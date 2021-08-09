Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122033E41AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhHIIex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233974AbhHIIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628498072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPQarTSOi0X361Zw0RXaLnMWkmeZ4pZwVNx8G3+tPYs=;
        b=bsfWuREsXBVN33TiuImOalBjw92kuWLbOT/olLnlocluD7SgxzKU08wPAa+qtepI4mo2SM
        sKugwWsWpx1hQKOfkUm4qAEj79S0MVCSwjnOd4cAO68YOXZdXMitT053roUTSKPDUTi9l1
        BsqPsZAJKzbxc6cLGXALvMn/7hpZBog=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-oy5oFRyXOkKCqpYA9uGqjg-1; Mon, 09 Aug 2021 04:34:31 -0400
X-MC-Unique: oy5oFRyXOkKCqpYA9uGqjg-1
Received: by mail-ed1-f72.google.com with SMTP id v11-20020a056402348bb02903be68e116adso646086edc.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 01:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kPQarTSOi0X361Zw0RXaLnMWkmeZ4pZwVNx8G3+tPYs=;
        b=Brt1iLTeFgop5FfyPYUvGr2A4DQvBDIhxOo7IhFT+i3IglfbxSw2xJIsv5trJVI0ON
         GPTvWPqN9n4ieKe98uZZ8q5V5oBi4XoT6C4KPApSjSxknovSwvDh2RmoD+HXwT49qEe0
         GYclNoYYrhsE+c85buiwS37rMsi3JLn/robpsNLRx+Bdf0cDJmcY79LJdM2mI8JiN2lU
         9NqjqFE4TdZiDFLZQlcgiVE1KoPU7+p5M1b5olFpl9PLCd0lAP94jqsuxSClCjEVu2vC
         2JnFUM/Q8PDibcZT/7oUm4LXzizOSz1XW8ipJ9z1grfsMImbYBgk1hHFAroQrtYvzIBX
         EtQw==
X-Gm-Message-State: AOAM532OQ4+eRJaXOYF5OtLD4uBnzsrFg10UFaZP9DBallKwTDZn4Es1
        ZD5lS4TmHgXDNsrnozOrtkEAnlunkecKTBmAQwo28FljBog/cPXFAoqgi7F1X6jaMSf5FKKSwxe
        54H0qsZyztoH0g+79hsKgunuaypncP45iYIOL6a2i14KIAP4aNqC23J0yquCrvF3ZE4PBcv93/b
        F5
X-Received: by 2002:a17:906:1950:: with SMTP id b16mr4353804eje.153.1628498069842;
        Mon, 09 Aug 2021 01:34:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfAQN277/WqiV63b17hpYsEH8gdwXFBqz9HKsmS64tmoN+TNN0KMXw5HYyjWOLaludbfVTVg==
X-Received: by 2002:a17:906:1950:: with SMTP id b16mr4353788eje.153.1628498069688;
        Mon, 09 Aug 2021 01:34:29 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id ec38sm7712253edb.40.2021.08.09.01.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 01:34:29 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: intel_pmc_core: Prevent possibile
 overflow
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, novikov@ispras.ru,
        gayatri.kammela@intel.com, mgross@linux.intel.com,
        andy.shevchenko@gmail.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210804213843.498937-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8ff9f139-68bc-e5fa-5f37-231b635f986d@redhat.com>
Date:   Mon, 9 Aug 2021 10:34:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804213843.498937-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/4/21 11:38 PM, David E. Box wrote:
> Low Power Mode (LPM) priority is encoded in 4 bits. Yet, this value is used
> as an index to an array whose element size was less than 16, leading to the
> possibility of overflow should we read a larger than expected priority.  In
> addition to the overflow, bad values can lead to incorrect state reporting.
> So rework the priority code to prevent the overflow and perform some
> validation of the register. Use the priority register values if they give
> an ordering of unique numbers between 0 and the maximum number of states.
> Otherwise, use a default ordering instead.
> 
> Reported-by: Evgeny Novikov <novikov@ispras.ru>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> 
> v2:	Remove lpm_priority size increase. Instead, remove that array and
> 	create 2 new local arrays, one to save priority levels in mode order,
> 	and one to save modes in priority order. Use the mode_order list to
> 	validate that no priority level is above the maximum and to validate
> 	that they are all unique values. Then we can safely create a
> 	priority_order list that will be the basis of how we report substate
> 	information.

Thank you for the new version.

I expect that you will send a new version addressing Andy's remarks,
so I'm going to drop this version from my queue.

Regards,

Hans


> 
>  drivers/platform/x86/intel_pmc_core.c | 65 +++++++++++++++++++++------
>  drivers/platform/x86/intel_pmc_core.h |  4 ++
>  2 files changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index b0e486a6bdfb..0f623c422d4e 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1449,11 +1449,15 @@ static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc);
>  
> -static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
> +static void pmc_core_get_low_power_modes(struct platform_device *pdev)
>  {
> -	u8 lpm_priority[LPM_MAX_NUM_MODES];
> +	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> +	u8 pri_order[LPM_MAX_NUM_MODES] = LPM_DEFAULT_PRI;
> +	u8 mode_order[LPM_MAX_NUM_MODES];
> +	u32 lpm_pri;
>  	u32 lpm_en;
> -	int mode, i, p;
> +	int mode, i, j, p;
> +	bool bad_pri_reg = false;
>  
>  	/* Use LPM Maps to indicate support for substates */
>  	if (!pmcdev->map->lpm_num_maps)
> @@ -1462,24 +1466,59 @@ static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
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
> +	if (!lpm_pri)
> +		bad_pri_reg = true;
> +
> +	if (!bad_pri_reg) {
> +		/*
> +		 * Each byte contains gives the priority level for 2 modes (7:4 and 3:0).
> +		 * In a 32 bit register this allows for describing 8 modes. Store the
> +		 * levels and look for values out of range.
> +		 */
> +		for (mode = 0; mode < 8; mode++) {
> +			int level = GENMASK(3, 0) & lpm_pri;
>  
> -		lpm_priority[pri0] = mode;
> -		lpm_priority[pri1] = mode + 1;
> +			if (level >= LPM_MAX_NUM_MODES) {
> +				bad_pri_reg = true;
> +				break;
> +			}
> +
> +			mode_order[mode] = level;
> +			lpm_pri >>= 4;
> +		}
>  	}
>  
> +	if (!bad_pri_reg) {
> +		/* Check that we have unique values */
> +		for (i = 0; i < LPM_MAX_NUM_MODES - 1; i++)
> +			for (j = i + 1; j < LPM_MAX_NUM_MODES; j++)
> +				if (mode_order[i] == mode_order[j]) {
> +					bad_pri_reg = true;
> +					break;
> +				}
> +	}
> +
> +	/*
> +	 * If bad_pri_reg is false, then mode_order must contain unique values for
> +	 * all priority levels from 0 to LPM_MAX_NUM_MODES and this loop with properly
> +	 * overwrite our default ordering. Otherwise just use the default.
> +	 */
> +	if (!bad_pri_reg)
> +		/* Get list of modes in priority order */
> +		for (mode = 0; mode < LPM_MAX_NUM_MODES; mode++)
> +			pri_order[mode_order[mode]] = mode;
> +	else
> +		dev_warn(&pdev->dev, "Assuming a default substate order for this platform\n");
> +
>  	/*
>  	 * Loop though all modes from lowest to highest priority,
>  	 * and capture all enabled modes in order
>  	 */
>  	i = 0;
>  	for (p = LPM_MAX_NUM_MODES - 1; p >= 0; p--) {
> -		int mode = lpm_priority[p];
> +		int mode = pri_order[p];
>  
>  		if (!(BIT(mode) & lpm_en))
>  			continue;
> @@ -1675,7 +1714,7 @@ static int pmc_core_probe(struct platform_device *pdev)
>  	mutex_init(&pmcdev->lock);
>  
>  	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
> -	pmc_core_get_low_power_modes(pmcdev);
> +	pmc_core_get_low_power_modes(pdev);
>  	pmc_core_do_dmi_quirks(pmcdev);
>  
>  	if (pmcdev->map == &tgl_reg_map)
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index e8dae9c6c45f..9aaadb0f87df 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -188,6 +188,10 @@ enum ppfear_regs {
>  #define ICL_PMC_SLP_S0_RES_COUNTER_STEP		0x64
>  
>  #define LPM_MAX_NUM_MODES			8
> +
> +/* Must contain LPM_MAX_NUM_MODES elements */
> +#define LPM_DEFAULT_PRI				{ 7, 5, 2, 6, 4, 3, 1, 0 }
> +
>  #define GET_X2_COUNTER(v)			((v) >> 1)
>  #define LPM_STS_LATCH_MODE			BIT(31)
>  
> 

