Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9742E35A461
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhDIRGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhDIRGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:06:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9F0C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 10:06:24 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z136so6599469iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ckuQKqYSNgY7eF5IEy/O9xqtXaRMqkkILp0uvz39yLw=;
        b=DEFRRBW7mUM0LwIC914tb1EnBOQjQOWcSoOpU0+RNeVf1rMBJ6apYAbKymvAtXEWOK
         pky1YZirx1+TImTY8pDc8zgciCwiRk76ZgOy81myto3FOf1NwLWAMpDzi3xAhk72VLg2
         TJBNtnN5ubOP44umFdm52CT7GInzWukLU4WsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckuQKqYSNgY7eF5IEy/O9xqtXaRMqkkILp0uvz39yLw=;
        b=gk6W5+0J+WUm/71WOiCdPifVLgrWGtXbYetTnOdL4Da3lRxTSvQ8rJItZKW1xBiu84
         aLRZDNzDinWZ9WAJECE7AaEh++7gz+fioi+U6LxBBSmPGWtQ23B2UPsj0uJUmwf68LaS
         0lOfODYoot1t4t7s5MMaGDrE3q3aXXWSj7h6DUSjol/NmbVNSWo/+20OwLZXamSJwIaO
         bQIICbV713C/814TguQ/xgHd45tembOhVyBNVcR1b19wjCbt+d/YSfTRMTfM3R1Ol+Eg
         6DA1Rxq5VXoAd7y4MaNVgy2v7ItM4h57QHWDcT15q4+pPWbsmuTthZGCQv9qpbwUesia
         YPNA==
X-Gm-Message-State: AOAM533sm3CwZMpaf1Ndez/p2ja70iMm5BKgxGfdfHBbydKdIS1tzPLz
        NVp1AldIVbRaySpCVPXoNQXNMA==
X-Google-Smtp-Source: ABdhPJyijYXlk1P49PEEb/iVM02dNCqi2XwX7HAn08GrYbt0mqY0L69S3e7RupJ8rCwxzY4jxxNmtQ==
X-Received: by 2002:a05:6638:381c:: with SMTP id i28mr15333884jav.60.1617987983281;
        Fri, 09 Apr 2021 10:06:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s15sm1391221ilv.13.2021.04.09.10.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 10:06:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] Revert "iommu/amd: Fix performance counter
 initialization"
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de, Jon.Grimm@amd.com,
        Tj <ml.linux@elloe.vision>,
        Alexander Monakov <amonakov@ispras.ru>,
        David Coe <david.coe@live.co.uk>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-2-suravee.suthikulpanit@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f156768c-37fd-a4e8-3959-a5bc5dae918c@linuxfoundation.org>
Date:   Fri, 9 Apr 2021 11:06:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210409085848.3908-2-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/21 2:58 AM, Suravee Suthikulpanit wrote:
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> This reverts commit 6778ff5b21bd8e78c8bd547fd66437cf2657fd9b.
> 
> The original commit tries to address an issue, where PMC power-gating
> causing the IOMMU PMC pre-init test to fail on certain desktop/mobile
> platforms where the power-gating is normally enabled.
> 
> There have been several reports that the workaround still does not
> guarantee to work, and can add up to 100 ms (on the worst case)
> to the boot process on certain platforms such as the MSI B350M MORTAR
> with AMD Ryzen 3 2200G.
> 
> Therefore, revert this commit as a prelude to removing the pre-init
> test.
> 
> Link: https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
> Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Alexander Monakov <amonakov@ispras.ru>
> Cc: David Coe <david.coe@live.co.uk>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
> Note: I have revised the commit message to add more detail
>        and remove uncessary information.
> 
>   drivers/iommu/amd/init.c | 45 ++++++++++------------------------------
>   1 file changed, 11 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 321f5906e6ed..648cdfd03074 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -12,7 +12,6 @@
>   #include <linux/acpi.h>
>   #include <linux/list.h>
>   #include <linux/bitmap.h>
> -#include <linux/delay.h>
>   #include <linux/slab.h>
>   #include <linux/syscore_ops.h>
>   #include <linux/interrupt.h>
> @@ -257,8 +256,6 @@ static enum iommu_init_state init_state = IOMMU_START_STATE;
>   static int amd_iommu_enable_interrupts(void);
>   static int __init iommu_go_to_state(enum iommu_init_state state);
>   static void init_device_table_dma(void);
> -static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> -				u8 fxn, u64 *value, bool is_write);
>   
>   static bool amd_iommu_pre_enabled = true;
>   
> @@ -1717,11 +1714,13 @@ static int __init init_iommu_all(struct acpi_table_header *table)
>   	return 0;
>   }
>   
> -static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
> +static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> +				u8 fxn, u64 *value, bool is_write);
> +
> +static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>   {
> -	int retry;
>   	struct pci_dev *pdev = iommu->dev;
> -	u64 val = 0xabcd, val2 = 0, save_reg, save_src;
> +	u64 val = 0xabcd, val2 = 0, save_reg = 0;
>   
>   	if (!iommu_feature(iommu, FEATURE_PC))
>   		return;
> @@ -1729,39 +1728,17 @@ static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
>   	amd_iommu_pc_present = true;
>   
>   	/* save the value to restore, if writable */
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false) ||
> -	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, false))
> -		goto pc_false;
> -
> -	/*
> -	 * Disable power gating by programing the performance counter
> -	 * source to 20 (i.e. counts the reads and writes from/to IOMMU
> -	 * Reserved Register [MMIO Offset 1FF8h] that are ignored.),
> -	 * which never get incremented during this init phase.
> -	 * (Note: The event is also deprecated.)
> -	 */
> -	val = 20;
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 8, &val, true))
> +	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
>   		goto pc_false;
>   
>   	/* Check if the performance counters can be written to */
> -	val = 0xabcd;
> -	for (retry = 5; retry; retry--) {
> -		if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true) ||
> -		    iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false) ||
> -		    val2)
> -			break;
> -
> -		/* Wait about 20 msec for power gating to disable and retry. */
> -		msleep(20);
> -	}
> -
> -	/* restore */
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true) ||
> -	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, true))
> +	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
> +	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
> +	    (val != val2))

Probably don't need parentheses around 'val != val2'

>   		goto pc_false;
>   
> -	if (val != val2)
> +	/* restore */
> +	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
>   		goto pc_false;
>   
>   	pci_info(pdev, "IOMMU performance counters supported\n");
> 

thanks,
-- Shuah
