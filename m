Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D323FD661
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbhIAJTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:19:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:22160 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243485AbhIAJTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:19:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="282408953"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="282408953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 02:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="476059938"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2021 02:18:33 -0700
To:     Phil Elwell <phil@raspberrypi.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Bell <jonathan@raspberrypi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210831160259.2392459-1-phil@raspberrypi.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: guard accesses to ep_state in xhci_endpoint_reset()
Message-ID: <3830571c-566c-ef13-bc08-60206a634253@linux.intel.com>
Date:   Wed, 1 Sep 2021 12:21:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210831160259.2392459-1-phil@raspberrypi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.8.2021 19.02, Phil Elwell wrote:
> From: Jonathan Bell <jonathan@raspberrypi.com>
> 
> See https://github.com/raspberrypi/linux/issues/3981

Thanks, so in a nutshell the issue looks something like:

[827586.220071] xhci_hcd 0000:01:00.0: WARN Cannot submit Set TR Deq Ptr
[827586.220087] xhci_hcd 0000:01:00.0: A Set TR Deq Ptr command is pending.
[827723.160680] INFO: task usb-storage:93 blocked for more than 122 seconds.

The blocked task is probably because xhci driver failed to give back the
URB after failing to submit a "Set TR Deq Ptr" command. This part should
be fixed in:
https://lore.kernel.org/r/20210820123503.2605901-4-mathias.nyman@linux.intel.com
which is currently in usb-next, and should be in 5.15-rc1 and future 5.12+ stable.

> 
> Two read-modify-write cycles on ep->ep_state are not guarded by
> xhci->lock. Fix these.
> 

This is probably one cause for the "Warn Cannot submit Set TR Deq Ptr A Set TR
Deq Ptr command is pending" message.
Another possibility is that with UAS and streams we have several transfer rings
per endpoint, meaning that if two TDs on separate stream rings on the same 
endpoint both stall, or are cancelled we could see this message.

The SET_DEQ_PENDING flag in ep->ep_state should probably be per ring, not per
endpoint. Then we also need a "rings_with_pending_set_deq" counter per endpoint
to keep track when all set_tr_deq commands complete, and we can restart the endpoint  

Anyway, my patch linked above together with this patch should make these errors
a lot more harmless.

Let me know if you can trigger the issue with both these patches applied.

I'll add your patch to the queue as well.

Thanks
-Mathias
