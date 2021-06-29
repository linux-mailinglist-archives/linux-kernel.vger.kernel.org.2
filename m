Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178053B74B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhF2OwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:52:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:63149 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhF2OwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:52:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="205152367"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="205152367"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 07:49:24 -0700
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="447065340"
Received: from sneftin-mobl.ger.corp.intel.com (HELO [10.185.169.66]) ([10.185.169.66])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 07:49:22 -0700
Subject: Re: [Intel-wired-lan] [PATCH] driver core: fix e1000e ltr bug
To:     YeeLi <seven.yi.lee@gmail.com>, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org
Cc:     intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
References: <20210629082128.255988-1-seven.yi.lee@gmail.com>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <02ff77ef-e802-8e13-d169-1ab2c250405a@intel.com>
Date:   Tue, 29 Jun 2021 17:49:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629082128.255988-1-seven.yi.lee@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/2021 11:21, YeeLi wrote:
Yeeli,
> In e1000e driver, a PCIe-like device, the max snoop/no-snoop latency
> is the upper limit.So, directly compare the size of lat_enc and
> max_ltr_enc is incorrect.
> 
why?
>      In 1000Mbps, 0x8b9 < 0x1003, 189440 ns < 3145728 ns, correct.
> 
>      In 100Mbps, 0xc3a < 0x1003, 1900544 ns < 3145728 ns, correct.
> 
>      In 10Mbps, 0xe40 < 0x1003, 18874368 > 3145728, incorrect.
> 
Platform LTR encoded is 0x1003 - right. It is meant 1048576ns x 3 = 
3145738ns.
Now,
for 1000M: 0x08b9 => 185ns x 1024 = 189440ns (you are correct)
for 100M: 0x0c3a => 58ns x 32768 = 1900544ns (correct)
for 10M: 0x0e41 => 577ns x 32768 = 18907136ns (ok?)
18907136ns > 3145738ns, (latency encoded is great than maximum LTR 
encoded by platform) - so, there is no point to wait more than platform 
required, and lat_enc=max_ltr_enc. It is expected and we sent right 
value to the power management controller.
What is the problem you try solve?

> Decoded the lat_enc and max_ltr_enc before compare them is necessary.
> 
> Signed-off-by: YeeLi <seven.yi.lee@gmail.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 23 ++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 590ad110d383..3bff1b570b76 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -986,6 +986,27 @@ static s32 e1000_k1_workaround_lpt_lp(struct e1000_hw *hw, bool link)
>   	return ret_val;
>   }
>   
> +static u32 convert_e1000e_ltr_scale(u32 val)
> +{
> +	if (val > 5)
> +		return 0;
> +
> +	return 1U << (5 * val);
> +}
> +
> +static u64 decoded_ltr(u32 val)
> +{
> +	u64 decoded_latency;
> +	u32 value;
> +	u32 scale;
> +
> +	value = val & 0x03FF;
> +	scale = (val & 0x1C00) >> 10;
> +	decoded_latency = value * convert_e1000e_ltr_scale(scale);
> +
> +	return decoded_latency;
> +}
> +
>   /**
>    *  e1000_platform_pm_pch_lpt - Set platform power management values
>    *  @hw: pointer to the HW structure
> @@ -1059,7 +1080,7 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
>   				     E1000_PCI_LTR_CAP_LPT + 2, &max_nosnoop);
>   		max_ltr_enc = max_t(u16, max_snoop, max_nosnoop);
>   
> -		if (lat_enc > max_ltr_enc)
> +		if (decoded_ltr(lat_enc) > decoded_ltr(max_ltr_enc))
>   			lat_enc = max_ltr_enc;
>   	}
>   
> 
sasha
