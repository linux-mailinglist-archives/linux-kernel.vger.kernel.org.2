Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2035126E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhDAJhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbhDAJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:36:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AB6C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:36:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k128so710000wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EPDBHbZ+mRKnrNaC/N5QN7AETckdIEnqwj/xW1Ps1Tg=;
        b=iIZwAC0xaoLSg43i0qM+Y5c6Z/QBj2LKVofvJakegSgsIciFNRoD0HzdGaNuqwE2Ds
         /lAI/K+FiXXA27ogs2Sfg08fs3ni5cohNZKjvP/gLf1GHtX1Pt5kYSekWI8v1tq7h42N
         VmCcI6EoARm9U19tt7VyjJc+UFbX8yNEs4W1DxUNLVxgig2MKS2MaqvyJAK7DAyS2Z5z
         /5l2DSOcBE4iq7WwWxpjBfATBIX2a687CoCCFvr/r1HHwo90hJsgwkTDHzptKYz0DVjJ
         TMVCg+AmdTmzd0PX8lJ2KOBAaAIBQh0qm8yGpHf33is3OaVeszGzINQsFhSSD4A3QRbT
         youw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EPDBHbZ+mRKnrNaC/N5QN7AETckdIEnqwj/xW1Ps1Tg=;
        b=p5qXOcBg/7lDK1/JzhEJoYOsgDTqXG1UuMwSacUwenO1waS96WvPjSfg4ac8Qq/Kmg
         FRIS/rwVJMPF87k9mEQjnYBGOPZ7vxY5No2fGvEuuf+dZOevPsUOEe9xd4Fy+ojY1mIK
         atA55ewtGlYasa36QoXRd2KYU8jYIkPFXaxkATGrzz7HhUobOk/553PaxnpK/VoO8mNa
         DMD4x7e1yn0ao/uUpv7i30jVUc2cUN5m6mIDCPwYzIYTrnE9WQSoJdGZGt1dyMATuAIH
         4hSEE5udKgjxgkspBtcxta0AjDDoDH7QrG4PiI27XWapo0P8wSvN0jMcGOUpSCswb3YY
         4bTQ==
X-Gm-Message-State: AOAM530lOUQ4YCB2OLfeyIvDe1hO17REC7pXbggdK04ZJ1wHqEAzYQKY
        5NUR5ttL20yK/AGMqxg8yYk=
X-Google-Smtp-Source: ABdhPJyw8+/O191pr0frxMG+TtW/fRlG9FZ9qoESROa0hMKBJP2vTiOfLlNIC/V+vgMJHI2qnQFpDQ==
X-Received: by 2002:a7b:c0c3:: with SMTP id s3mr7080484wmh.11.1617269817973;
        Thu, 01 Apr 2021 02:36:57 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id l4sm5927565wmh.8.2021.04.01.02.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:36:57 -0700 (PDT)
Subject: Re: [PATCH 1/4] soc: mediatek: pm-domains: Add a meaningful power
 domain name
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, drinkcat@chromium.org,
        hsinyi@chromium.org, weiyi.lu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210225175000.824661-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <f61e32cb-0dbe-2e12-2d77-3778953ee1d7@gmail.com>
Date:   Thu, 1 Apr 2021 11:36:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210225175000.824661-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/02/2021 18:49, Enric Balletbo i Serra wrote:
> Add the power domains names to the power domain struct so we
> have meaningful name for every power domain. This also removes the
> following debugfs error message.
> 
>   [    2.242068] debugfs: Directory 'power-domain' with parent 'pm_genpd' already present!
>   [    2.249949] debugfs: Directory 'power-domain' with parent 'pm_genpd' already present!
>   [    2.257784] debugfs: Directory 'power-domain' with parent 'pm_genpd' already present!
>   ...
> 
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Whole series applied to v5.12-next/soc

Thanks a lot!
Matthias

> ---
> 
>  drivers/soc/mediatek/mt8173-pm-domains.h | 10 ++++++++++
>  drivers/soc/mediatek/mtk-pm-domains.c    |  6 +++++-
>  drivers/soc/mediatek/mtk-pm-domains.h    |  2 ++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
> index 3e8ee5dabb43..654c717e5467 100644
> --- a/drivers/soc/mediatek/mt8173-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8173-pm-domains.h
> @@ -12,24 +12,28 @@
>  
>  static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>  	[MT8173_POWER_DOMAIN_VDEC] = {
> +		.name = "vdec",
>  		.sta_mask = PWR_STATUS_VDEC,
>  		.ctl_offs = SPM_VDE_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(12, 12),
>  	},
>  	[MT8173_POWER_DOMAIN_VENC] = {
> +		.name = "venc",
>  		.sta_mask = PWR_STATUS_VENC,
>  		.ctl_offs = SPM_VEN_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  	},
>  	[MT8173_POWER_DOMAIN_ISP] = {
> +		.name = "isp",
>  		.sta_mask = PWR_STATUS_ISP,
>  		.ctl_offs = SPM_ISP_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(13, 12),
>  	},
>  	[MT8173_POWER_DOMAIN_MM] = {
> +		.name = "mm",
>  		.sta_mask = PWR_STATUS_DISP,
>  		.ctl_offs = SPM_DIS_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
> @@ -40,18 +44,21 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>  		},
>  	},
>  	[MT8173_POWER_DOMAIN_VENC_LT] = {
> +		.name = "venc_lt",
>  		.sta_mask = PWR_STATUS_VENC_LT,
>  		.ctl_offs = SPM_VEN2_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  	},
>  	[MT8173_POWER_DOMAIN_AUDIO] = {
> +		.name = "audio",
>  		.sta_mask = PWR_STATUS_AUDIO,
>  		.ctl_offs = SPM_AUDIO_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(15, 12),
>  	},
>  	[MT8173_POWER_DOMAIN_USB] = {
> +		.name = "usb",
>  		.sta_mask = PWR_STATUS_USB,
>  		.ctl_offs = SPM_USB_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
> @@ -59,18 +66,21 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>  		.caps = MTK_SCPD_ACTIVE_WAKEUP,
>  	},
>  	[MT8173_POWER_DOMAIN_MFG_ASYNC] = {
> +		.name = "mfg_async",
>  		.sta_mask = PWR_STATUS_MFG_ASYNC,
>  		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = 0,
>  	},
>  	[MT8173_POWER_DOMAIN_MFG_2D] = {
> +		.name = "mfg_2d",
>  		.sta_mask = PWR_STATUS_MFG_2D,
>  		.ctl_offs = SPM_MFG_2D_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = GENMASK(13, 12),
>  	},
>  	[MT8173_POWER_DOMAIN_MFG] = {
> +		.name = "mfg",
>  		.sta_mask = PWR_STATUS_MFG,
>  		.ctl_offs = SPM_MFG_PWR_CON,
>  		.sram_pdn_bits = GENMASK(13, 8),
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index b7f697666bdd..694d6ea6de1d 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -438,7 +438,11 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>  		goto err_unprepare_subsys_clocks;
>  	}
>  
> -	pd->genpd.name = node->name;
> +	if (!pd->data->name)
> +		pd->genpd.name = node->name;
> +	else
> +		pd->genpd.name = pd->data->name;
> +
>  	pd->genpd.power_off = scpsys_power_off;
>  	pd->genpd.power_on = scpsys_power_on;
>  
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 141dc76054e6..21a4e113bbec 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -76,6 +76,7 @@ struct scpsys_bus_prot_data {
>  
>  /**
>   * struct scpsys_domain_data - scp domain data for power on/off flow
> + * @name: The name of the power domain.
>   * @sta_mask: The mask for power on/off status bit.
>   * @ctl_offs: The offset for main power control register.
>   * @sram_pdn_bits: The mask for sram power control bits.
> @@ -85,6 +86,7 @@ struct scpsys_bus_prot_data {
>   * @bp_smi: bus protection for smi subsystem
>   */
>  struct scpsys_domain_data {
> +	const char *name;
>  	u32 sta_mask;
>  	int ctl_offs;
>  	u32 sram_pdn_bits;
> 
