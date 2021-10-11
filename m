Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF9428DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhJKNby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235280AbhJKNbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633958990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0bIphsa+eA0VMTvp2Swkoe07sxGwlhnRqxsOzukS0c=;
        b=Is1mQjVBno00CGn/ZRxcG6XetrXOqlxEFKt6jM947ryc3mcUdG/Z5/9s7+vNYhmMZEFIpl
        ftnlFLB13yIui7xgosnWIal4Tzd57vw8ed2xUE6cJk4eWEGGGKN99uxXpY5utBuFtG/fOm
        Nqq4HyaDbQlm7DQvouwOID7d7P4YlXI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-YYc7e4Z7PKqmMTbTRrPJOg-1; Mon, 11 Oct 2021 09:29:49 -0400
X-MC-Unique: YYc7e4Z7PKqmMTbTRrPJOg-1
Received: by mail-ed1-f69.google.com with SMTP id u24-20020aa7db98000000b003db57b1688aso10511390edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e0bIphsa+eA0VMTvp2Swkoe07sxGwlhnRqxsOzukS0c=;
        b=hOwuCOs5Zs3fxhQLrAfefPQOKhTpxSy2UV+Fp5p9K8+1nvB1IJqr5UY1IR7rnUs2zg
         4lzB7n2HLzZXqwOBkkeWQ+g0luT1SP7/THqrNxKp4hGoeiBOIIs4ZrLNs/i6VL/vcFTM
         P8R5ll80Mgc7RYH7eaxdI6LQv38J7QLl3zC5KDsQUsRNFj/I0vKN3kL0gTdU0NY0SLec
         GzoXq8eBjErMnLBYVkm6CDkEuMkZg35UASTPT83YRs4S43IIgSAS3C2VtIF9NPZf9Ox8
         OWHU2/8nue5BH96gauznyN/xuD3Ky9BykdGkPNFN4yxLq/3lwqDGWvXgioYzkKWtTSvZ
         KOTg==
X-Gm-Message-State: AOAM532fGf3rU8nG0UmXk0bywY4yuGnbBTxFQ8V/quwtHAun7oQhzGbR
        B3Q2mMORdMag3TPGDBaMA8nkq2JT8+crKik8LuMenKkCoS6XpozcC2slSbTFLT04BOkFKdE39oK
        upSXqCKKSkNyA9swXmnq6E3yU
X-Received: by 2002:a17:906:3484:: with SMTP id g4mr26418444ejb.273.1633958988621;
        Mon, 11 Oct 2021 06:29:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWCkz5bMDpDVnrf8hFaFBzUAwRhO8oFeErXoZgK0Cc7tIVv05ViAl3s1G7kC3Kt8OHGfchhQ==
X-Received: by 2002:a17:906:3484:: with SMTP id g4mr26418415ejb.273.1633958988414;
        Mon, 11 Oct 2021 06:29:48 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id z19sm3527950ejp.97.2021.10.11.06.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 06:29:48 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: amd-pmc: Fix the build error when
 CONFIG_DEBUG_FS is disable
To:     Sanket Goswami <Sanket.Goswami@amd.com>, Shyam-sundar.S-k@amd.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
References: <20211008083408.8497-1-Sanket.Goswami@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <73166ed7-dee5-e7b6-abd5-37dcdf2b8fba@redhat.com>
Date:   Mon, 11 Oct 2021 15:29:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211008083408.8497-1-Sanket.Goswami@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sanket,

On 10/8/21 10:34 AM, Sanket Goswami wrote:
> It was reported that when CONFIG_DEBUG_FS is disabled, amd-pmc driver
> ended up in build failure.
> 
> Re-order the routine to solve the problem.
> 
> Fixes: b4a53d6f61eb ("platform/x86: amd-pmc: Export Idlemask values
> based on the APU")
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>

Thank you for your pathc, but this is already fixed by the following (identical)
commit in my for-next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=40635cd32f0d83573a558dc30e9ba3469e769249

Regards,

Hans



> ---
>  drivers/platform/x86/amd-pmc.c | 86 +++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 91c1f1c6c929..88cded2fe680 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -155,6 +155,31 @@ struct smu_metrics {
>  	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
>  } __packed;
>  
> +static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
> +				 struct seq_file *s)
> +{
> +	u32 val;
> +
> +	switch (pdev->cpu_id) {
> +	case AMD_CPU_ID_CZN:
> +		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_CZN);
> +		break;
> +	case AMD_CPU_ID_YC:
> +		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_YC);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (dev)
> +		dev_dbg(pdev->dev, "SMU idlemask s0i3: 0x%x\n", val);
> +
> +	if (s)
> +		seq_printf(s, "SMU idlemask : 0x%x\n", val);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  static int smu_fw_info_show(struct seq_file *s, void *unused)
>  {
> @@ -210,49 +235,6 @@ static int s0ix_stats_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(s0ix_stats);
>  
> -static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
> -{
> -	int rc;
> -	u32 val;
> -
> -	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
> -	if (rc)
> -		return rc;
> -
> -	dev->major = (val >> 16) & GENMASK(15, 0);
> -	dev->minor = (val >> 8) & GENMASK(7, 0);
> -	dev->rev = (val >> 0) & GENMASK(7, 0);
> -
> -	dev_dbg(dev->dev, "SMU version is %u.%u.%u\n", dev->major, dev->minor, dev->rev);
> -
> -	return 0;
> -}
> -
> -static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
> -				 struct seq_file *s)
> -{
> -	u32 val;
> -
> -	switch (pdev->cpu_id) {
> -	case AMD_CPU_ID_CZN:
> -		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_CZN);
> -		break;
> -	case AMD_CPU_ID_YC:
> -		val = amd_pmc_reg_read(pdev, AMD_PMC_SCRATCH_REG_YC);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	if (dev)
> -		dev_dbg(pdev->dev, "SMU idlemask s0i3: 0x%x\n", val);
> -
> -	if (s)
> -		seq_printf(s, "SMU idlemask : 0x%x\n", val);
> -
> -	return 0;
> -}
> -
>  static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
>  {
>  	struct amd_pmc_dev *dev = s->private;
> @@ -295,6 +277,24 @@ static inline void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
>  }
>  #endif /* CONFIG_DEBUG_FS */
>  
> +static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
> +{
> +	int rc;
> +	u32 val;
> +
> +	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
> +	if (rc)
> +		return rc;
> +
> +	dev->major = (val >> 16) & GENMASK(15, 0);
> +	dev->minor = (val >> 8) & GENMASK(7, 0);
> +	dev->rev = (val >> 0) & GENMASK(7, 0);
> +
> +	dev_dbg(dev->dev, "SMU version is %u.%u.%u\n", dev->major, dev->minor, dev->rev);
> +
> +	return 0;
> +}
> +
>  static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev)
>  {
>  	u32 phys_addr_low, phys_addr_hi;
> 

