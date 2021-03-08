Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10D33312F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCHQJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:09:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:55326 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhCHQIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:08:38 -0500
IronPort-SDR: 1dDPJVsbmsBnotllS0GsSKkgbWYCJer4fKPNgm2wuLkLbp8A/0YcFXYY5IFOIXzQ6maPO6E2K1
 5aYNHXlQGn0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175670108"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="175670108"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:08:37 -0800
IronPort-SDR: IMEqcAKyZuVXmkA9OvMZCbl2TvS/vdpGXEbx3aY+XFV/gJ2NX2tZKeONc1Y48Ma+RYaDHcqY1I
 UmmwjljYlFVg==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="430419043"
Received: from dbdavenp-mobl1.amr.corp.intel.com (HELO [10.212.234.206]) ([10.212.234.206])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:08:36 -0800
Subject: Re: [PATCH] soundwire: bus: Fix device found flag correctly
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210308113752.19661-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1e7cadc4-7da8-712a-7ebb-b977254d496f@linux.intel.com>
Date:   Mon, 8 Mar 2021 09:51:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308113752.19661-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/21 5:37 AM, Srinivas Kandagatla wrote:
> found flag that is used to indicate SoundWire device on the bus is
> not reset correctly after one iteration, this could miss adding devices
> that are enumerated on the bus but on in device list.

typo? did you mean "enumerated on the bus but not on device list"?

if yes, the first part is ambiguous in its wording, the enumeration 
completes by programming a device number. At this point the device is 
only 'attached'.

The fix is correct otherwise, please add my tag if you change the commit 
message in a v2.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> 
> Fixes: d52d7a1be02c ("soundwire: Add Slave status handling helpers")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/bus.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index a9ab4a6264e0..188e391c5a83 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -712,7 +712,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>   	struct sdw_slave *slave, *_s;
>   	struct sdw_slave_id id;
>   	struct sdw_msg msg;
> -	bool found = false;
> +	bool found;
>   	int count = 0, ret;
>   	u64 addr;
>   
> @@ -744,6 +744,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>   
>   		sdw_extract_slave_id(bus, addr, &id);
>   
> +		found = false;
>   		/* Now compare with entries */
>   		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
>   			if (sdw_compare_devid(slave, id) == 0) {
> 
