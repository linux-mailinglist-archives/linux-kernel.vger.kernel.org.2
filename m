Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7EA3AB9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFQQ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 12:56:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:64907 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhFQQ4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:56:09 -0400
IronPort-SDR: 2AXy54TXrhDRCQIBKHHIJSApUX9prQrmIsewEM6exlFOAGQdtVop3kLBE/rZxPuND19A0UaH8m
 BvMNSyG9rXBg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="292040058"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="292040058"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 09:54:01 -0700
IronPort-SDR: NOCxQ0VF4jinLQk0JADj6VWcCxnY3F/Fi34RqmSoq1N7o15xyYR04W3Qfa8uGilhRlZO1M3aul
 mSf+QDka0GkQ==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="421929542"
Received: from kumarkir-mobl2.amr.corp.intel.com (HELO [10.212.96.56]) ([10.212.96.56])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 09:54:00 -0700
Subject: Re: [PATCH] soundwire: stream: Use polling for DP Prepare completion
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20210617153410.27922-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1d340be7-2f21-73a5-bcc3-91372976dfb9@linux.intel.com>
Date:   Thu, 17 Jun 2021 11:53:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617153410.27922-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Richard for the patch, very interesting.
 
> sdw_prep_deprep_slave_ports() cannot use the port interrupt to signal
> CP_SM completion because it is called while holding the bus lock, which
> blocks the alert handler from running.
> 
> Change to polling the PREPARESTATUS register and remove the
> infrastructure that was implemented for the previous interrupt waiting.

I am afraid the entire PORT_READY support is completely untested at the moment: all the existing codecs use the simpler state machine, e.g. 		

dpn[i].simple_ch_prep_sm = true;

So my main question is: how did you test this change? Is this on a platform already supported upstream? yes/no answer is fine, no details necessary.

I am also not fully clear on the locking issue. 

Is the problem that sdw_handle_slave_status() uses a mutex_lock(&bus->bus_lock), which is already held in sdw_prepare_stream

int sdw_prepare_stream(struct sdw_stream_runtime *stream)
{
[...]
	sdw_acquire_bus_lock(stream);

[...]
	ret = _sdw_prepare_stream(stream, update_params);

	sdw_release_bus_lock(stream);
	return ret;
}

so dealing with an ALERT status while doing pre-deprep would cause a self-inflicted deadlock? 

If yes, that's a more general problem that would need to be fixed. this lock is taken in ALL stream operations, not just prepare/deprepare.

If e.g. a jack detection was signaled during any stream reconfiguration, we would also not be able to deal with the information, would we?

the purpose of the lock in sdw_handle_slave_status() was to check if devices attach or fall-off the bus before handling their status. The command/control protocol is always operational so nothing prevents the interrupt from being handled.

There's also something odd about directly polling on the status bits. The status bits will be used to signal the ALERT condition which is transmitted to the host during PING frames. This solution would result in the host noticing an interrupt: host controllers typically have a sticky status where all changes in PING frames are detected and used as a trigger for interrupt processing. In this case the interrupt would still be handled, but the sdw_handle_slave_status() would be deferred until the stream prepare is complete, and at that point the interrupt processing would not see any sources. It's not illegal but it's a bit odd to cause empty interrupts to be handled. 

It might be a better solution to fix conflicts between stream reconfiguration and interrupts. I don't have a turn-key proposal but the suggested patch feels like a work-around.
maybe using mutex_is_locked()?

If we can't figure something out, then at least the PORT_READY mask should not be set, i.e. this code would need to be removed:


int sdw_configure_dpn_intr(struct sdw_slave *slave,
			   int port, bool enable, int mask)
{
...
	/* Set/Clear port ready interrupt mask */
	if (enable) {
		val |= mask;
		val |= SDW_DPN_INT_PORT_READY;
	} else {
		val &= ~(mask);
		val &= ~SDW_DPN_INT_PORT_READY;
	}

	ret = sdw_update(slave, addr, (mask | SDW_DPN_INT_PORT_READY), val);
}

> A new configuration field 'ch_prep_poll_us' is added to struct
> sdw_dpn_prop so that the peripheral driver may select a polling interval.
> If this is left at zero a default interval of 500 usec is used.

we already have a 'ch_prep_timeout' that's defined, do you need to redefine a new field? why not just read once at the end of that timeout? It's a prepare operation, there's no requirement to be fast, is there?

Those properties were supposed to be populated in platform firmware btw, we should try and limit what properties need to be set in a codec driver.

> +		prep_timeout_us = dpn_prop->ch_prep_timeout * USEC_PER_MSEC;

I also just noticed that we don't have a default for ch_prep_timeout, that's a bug.

> +		if (dpn_prop->ch_prep_poll_us)
> +			prep_poll_us = dpn_prop->ch_prep_poll_us;
> +		else
> +			prep_poll_us = SDW_DEFAULT_DP_PREP_POLL_US;

Thanks
-Pierre
