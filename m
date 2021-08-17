Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4E3EF252
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhHQS5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229843AbhHQS5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629226591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yAhyO3KKXBKNO36+f4gsCKDB/3643Px/UhEi2O3/Wpg=;
        b=biCk0U5O/UhpOjPDWseOqy5WmGPvruQVqVbBufg0RJKhDQUim4SBFZ7FmdDzSC6YcsdEid
        yC6Yblxa2MX4+OcJoop+QIMNfZz1WAV+SB0S6WxPo/IZOK7T4c3Ca0HaY9Op9YTvK+NjVo
        SGrTMW6MsNdyTWNtA7En/xqsso5ITpQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-l_Hmgnc1PMuPC-qvCTi1Yg-1; Tue, 17 Aug 2021 14:56:30 -0400
X-MC-Unique: l_Hmgnc1PMuPC-qvCTi1Yg-1
Received: by mail-ej1-f69.google.com with SMTP id s11-20020a170906060b00b005be824f15daso1830614ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yAhyO3KKXBKNO36+f4gsCKDB/3643Px/UhEi2O3/Wpg=;
        b=B1gNwIloVAQ0eDV19ZIe1sKTXZ10X+FKJEBAPYSGDvmF4m/zk9HXkPRPi3E73mlZvQ
         KJnuPZxB3OwVER/tykwOZPOWVDEWEmMorF376+45B7jPsKkuBlxSdDBIypEYo/VdjMRY
         d4B4UWMospmzv65QduL24hlxuZ0YL9t84aka1wCWUt48Hq3jEDzrAWr1IADAdjKbw/+m
         6K3FkLmIzkHCcWXbR/7y1Ste/yOSdQPtIiFIVcxIv0OPDjgs4H0gkZuzrcbD31UEBygK
         E5PKpE//8NirawZ75PPr0NkoPrtMri48Rgo2+l0ZVXOuDA3UhQLMc5WjHBkEqLhFQ91M
         laxA==
X-Gm-Message-State: AOAM530VydBqRjyyG3mnqf257VGSdLu5WghDdM7ScSFv/L847GvG/Hus
        O4lvLgrVU3udw2e+9/KUp3HMshlnJp7VPRxgR3QBLb+7m8hVmQLI/BJ0EUMqaCSKOHLh+8EN4Mz
        CwRBMflYpVU/oFfx8kkINeMoEUs+xJ/4PWXWfFnXr+sznGPkkvC6vxhL/Fls855CkIpiO5lKkNL
        Nv
X-Received: by 2002:a05:6402:17d7:: with SMTP id s23mr5718609edy.344.1629226589014;
        Tue, 17 Aug 2021 11:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9SYE8cKVX4JvfftdJpEX6NAdu/ypoLgHzLsEsiQxGY2ZuvjShq0CIJ5GDv//Fjj28VYurEw==
X-Received: by 2002:a05:6402:17d7:: with SMTP id s23mr5718586edy.344.1629226588779;
        Tue, 17 Aug 2021 11:56:28 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id lb12sm1084318ejc.28.2021.08.17.11.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 11:56:28 -0700 (PDT)
Subject: Re: [PATCH v3] platform/x86: intel_pmc_core: Prevent possibile
 overflow
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, novikov@ispras.ru,
        gayatri.kammela@intel.com, mgross@linux.intel.com,
        andy.shevchenko@gmail.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210814014728.520856-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <41bb0f96-4429-9a6f-959f-fa5511a89911@redhat.com>
Date:   Tue, 17 Aug 2021 20:56:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210814014728.520856-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/14/21 3:47 AM, David E. Box wrote:
> Substate priority levels are encoded in 4 bits in the LPM_PRI register.
> This value was used as an index to an array whose element size was less
> than 16, leading to the possibility of overflow should we read a larger
> than expected priority.  In addition to the overflow, bad values could lead
> to incorrect state reporting.  So rework the priority code to prevent the
> overflow and perform some validation of the register. Use the priority
> register values if they give an ordering of unique numbers between 0 and
> the maximum number of states.  Otherwise, use a default ordering instead.
> 
> Reported-by: Evgeny Novikov <novikov@ispras.ru>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> v3:	Modifying Andy's suggestion, just place the entire verification
> 	in a separate function. If it fails, then keep the default
> 	ordering. If it passes, overwrite with the verified ordering.
> 
> 	Fix error in default order array.
> 
> 	Also fix spelling noted by Andy drop the size comment since
> 	the array size is set when declared.
> 
> v2:	Remove lpm_priority size increase. Instead, remove that array and
> 	create 2 new local arrays, one to save priority levels in mode order,
> 	and one to save modes in priority order. Use the mode_order list to
> 	validate that no priority level is above the maximum and to validate
> 	that they are all unique values. Then we can safely create a
> 	priority_order list that will be the basis of how we report substate
> 	information.
> 
>  drivers/platform/x86/intel_pmc_core.c | 65 +++++++++++++++++++++------
>  drivers/platform/x86/intel_pmc_core.h |  2 +
>  2 files changed, 53 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index b0e486a6bdfb..ae410a358ffe 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1449,9 +1449,42 @@ static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc);
>  
> -static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
> +static bool pmc_core_pri_verify(u32 lpm_pri, u8 *mode_order)
>  {
> -	u8 lpm_priority[LPM_MAX_NUM_MODES];
> +	int i, j;
> +
> +	if (!lpm_pri)
> +		return false;
> +	/*
> +	 * Each byte contains the priority level for 2 modes (7:4 and 3:0).
> +	 * In a 32 bit register this allows for describing 8 modes. Store the
> +	 * levels and look for values out of range.
> +	 */
> +	for (i = 0; i < 8; i++) {
> +		int level = lpm_pri & GENMASK(3, 0);
> +
> +		if (level >= LPM_MAX_NUM_MODES)
> +			return false;
> +
> +		mode_order[i] = level;
> +		lpm_pri >>= 4;
> +	}
> +
> +	/* Check that we have unique values */
> +	for (i = 0; i < LPM_MAX_NUM_MODES - 1; i++)
> +		for (j = i + 1; j < LPM_MAX_NUM_MODES; j++)
> +			if (mode_order[i] == mode_order[j])
> +				return false;
> +
> +	return true;
> +}
> +
> +static void pmc_core_get_low_power_modes(struct platform_device *pdev)
> +{
> +	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> +	u8 pri_order[LPM_MAX_NUM_MODES] = LPM_DEFAULT_PRI;
> +	u8 mode_order[LPM_MAX_NUM_MODES];
> +	u32 lpm_pri;
>  	u32 lpm_en;
>  	int mode, i, p;
>  
> @@ -1462,24 +1495,28 @@ static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
>  	lpm_en = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_en_offset);
>  	pmcdev->num_lpm_modes = hweight32(lpm_en);
>  
> -	/* Each byte contains information for 2 modes (7:4 and 3:0) */
> -	for (mode = 0; mode < LPM_MAX_NUM_MODES; mode += 2) {
> -		u8 priority = pmc_core_reg_read_byte(pmcdev,
> -				pmcdev->map->lpm_priority_offset + (mode / 2));
> -		int pri0 = GENMASK(3, 0) & priority;
> -		int pri1 = (GENMASK(7, 4) & priority) >> 4;
> +	/* Read 32 bit LPM_PRI register */
> +	lpm_pri = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_priority_offset);
>  
> -		lpm_priority[pri0] = mode;
> -		lpm_priority[pri1] = mode + 1;
> -	}
>  
>  	/*
> -	 * Loop though all modes from lowest to highest priority,
> +	 * If lpm_pri value passes verification, then override the default
> +	 * modes here. Otherwise stick with the default.
> +	 */
> +	if (pmc_core_pri_verify(lpm_pri, mode_order))
> +		/* Get list of modes in priority order */
> +		for (mode = 0; mode < LPM_MAX_NUM_MODES; mode++)
> +			pri_order[mode_order[mode]] = mode;
> +	else
> +		dev_warn(&pdev->dev, "Assuming a default substate order for this platform\n");
> +
> +	/*
> +	 * Loop through all modes from lowest to highest priority,
>  	 * and capture all enabled modes in order
>  	 */
>  	i = 0;
>  	for (p = LPM_MAX_NUM_MODES - 1; p >= 0; p--) {
> -		int mode = lpm_priority[p];
> +		int mode = pri_order[p];
>  
>  		if (!(BIT(mode) & lpm_en))
>  			continue;
> @@ -1675,7 +1712,7 @@ static int pmc_core_probe(struct platform_device *pdev)
>  	mutex_init(&pmcdev->lock);
>  
>  	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
> -	pmc_core_get_low_power_modes(pmcdev);
> +	pmc_core_get_low_power_modes(pdev);
>  	pmc_core_do_dmi_quirks(pmcdev);
>  
>  	if (pmcdev->map == &tgl_reg_map)
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index e8dae9c6c45f..b9bf3d3d6f7a 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -188,6 +188,8 @@ enum ppfear_regs {
>  #define ICL_PMC_SLP_S0_RES_COUNTER_STEP		0x64
>  
>  #define LPM_MAX_NUM_MODES			8
> +#define LPM_DEFAULT_PRI				{ 7, 6, 2, 5, 4, 1, 3, 0 }
> +
>  #define GET_X2_COUNTER(v)			((v) >> 1)
>  #define LPM_STS_LATCH_MODE			BIT(31)
>  
> 
> base-commit: e4ec7a49ef8bb4edc85a0eee005d59fa65c94a0e
> 

