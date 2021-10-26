Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB243B3D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhJZOWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhJZOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:22:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDADC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:19:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y78so9020074wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ymxJaa2BlrWL2+RXM0aWcrPrkleRVCX/6OMjVLXnHtc=;
        b=XWAqQZZNvVVVwLs4pdIGM8QinWryHGx3OAOqEn2Ss7dz0S3K7xo+eslGhwWJBalIFM
         60OLe9buohW0yo0naWMeahIfop42HbrEE4AhZDeecb+nFxs+yVAckLTCRGqF98J2BUKs
         Tnsf6dOqRJSy7XVkC8u8uhdhsZWd3R2Bhab6PIiISlBUXNSo1llmLUzIFf69/h3Vv5Af
         wjDBOeqht4Zmfm6hqUEtdD4/HJvIMNOlSwe9jL2hLXHEsj7+meFYFsaGUT16GJQggAH4
         RpluBK7h3/aCGc0Ls3UWwih7ZeyukAe04lEsr1nYIQH64HT8enl6TRRII8uvOYmdN/1j
         iYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ymxJaa2BlrWL2+RXM0aWcrPrkleRVCX/6OMjVLXnHtc=;
        b=qS46T9D662oiVsJY/FWWLKxzxRDXeWa0eG0pK1sHR2N/x/l+qVnImPUfXateR7wiSJ
         7LSi+c+WpZ48byEcbkUX9MwSpopHOVVj/bVrafVMfdbgaoxDg5rvXbG4hfC/R3aMjWXj
         3c0axNJCjHOR3xjikxVJv4BO/D/NnUS3CpuAIiCQoN9y++wYzh1Yfr/KALji6Yk85mip
         EISh9QaJbGX/Yaj9IBgeoDzl7jwHMUiCHiaGjkD/6xpJcExEY1qINhlUyloV1GQIimbB
         1kgmIzJtr1Z771OTADaWRI2PMPThuQF6nR0a0/iR9SHWAoIypyFbXcixDK4HsVdYK45C
         8wOg==
X-Gm-Message-State: AOAM531OWL+RYaUn8I9N5EvTQ6BpdTzY/AOffLZWN/kzwwuotJPOQKX+
        7nKQ89gfaCyxXqJaxFLpMzo=
X-Google-Smtp-Source: ABdhPJyH9o9somPIHfeMc5isE6xascAU+4UrpUU9SY3Y8u3MODCrO1+DwFNsybtMTX8LgmGBhzdALA==
X-Received: by 2002:a05:600c:4ba1:: with SMTP id e33mr4147069wmp.9.1635257978977;
        Tue, 26 Oct 2021 07:19:38 -0700 (PDT)
Received: from kernel.org ([2a0d:6fc0:68c:c000:a2b6:e878:f1bf:3444])
        by smtp.gmail.com with ESMTPSA id q18sm764216wmc.7.2021.10.26.07.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:19:38 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:19:34 +0300
From:   Mike Rapoport <mike.rapoport@gmail.com>
To:     Kushal Kothari <kushalkothari285@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, hdegoede@redhat.com,
        marcocesati@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, kushalkothari2850@gmail.com
Subject: Re: [PATCH v2] staging: rtl8723bs: core: Refactor nested if-else
Message-ID: <YXgOdpebeA/dFWIz@kernel.org>
References: <20211026134253.7868-1-kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026134253.7868-1-kushalkothari285@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 07:12:53PM +0530, Kushal Kothari wrote:
> Refactor nested if-else to avoid deep indentations. There is no change
> in the logic of the new code, however, now it is simple because it gets
> rid of five unnecessary else conditionals and it combines nested if into
> single if-else-if. This refactor also leads to fix warning detected by
> checkpatch.pl:
> WARNING: Too many leading tabs - consider code refactoring
> 
> Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
> ---
> 
> Changes in v2: Fix the bug of not handling properly the else logic
> when p is not null in else-if. Also, reword the subject line and break 
> it up at 72 columns.
> 
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 69 ++++++++-----------
>  1 file changed, 29 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 0f82f5031c43..267d853b1514 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -1192,50 +1192,39 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
>  		p = pframe + WLAN_HDR_A3_LEN + ie_offset; ie_len = 0;
>  		for (;;) {
>  			p = rtw_get_ie(p, WLAN_EID_VENDOR_SPECIFIC, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
> -			if (p) {
> -				if (!memcmp(p+2, WMM_IE, 6)) {
> -
> -					pstat->flags |= WLAN_STA_WME;
> -
> -					pstat->qos_option = 1;
> -					pstat->qos_info = *(p+8);
> -
> -					pstat->max_sp_len = (pstat->qos_info>>5)&0x3;
> -
> -					if ((pstat->qos_info&0xf) != 0xf)
> -						pstat->has_legacy_ac = true;
> -					else
> -						pstat->has_legacy_ac = false;
> -
> -					if (pstat->qos_info&0xf) {
> -						if (pstat->qos_info&BIT(0))
> -							pstat->uapsd_vo = BIT(0)|BIT(1);
> -						else
> -							pstat->uapsd_vo = 0;
> -
> -						if (pstat->qos_info&BIT(1))
> -							pstat->uapsd_vi = BIT(0)|BIT(1);
> -						else
> -							pstat->uapsd_vi = 0;
> -
> -						if (pstat->qos_info&BIT(2))
> -							pstat->uapsd_bk = BIT(0)|BIT(1);
> -						else
> -							pstat->uapsd_bk = 0;
> -
> -						if (pstat->qos_info&BIT(3))
> -							pstat->uapsd_be = BIT(0)|BIT(1);
> -						else
> -							pstat->uapsd_be = 0;
> -
> -					}
> -
> -					break;
> +			if (p && memcmp(p+2, WMM_IE, 6)) {
> +				p = p + ie_len + 2;
> +			} else if (p && !memcmp(p+2, WMM_IE, 6)) {
> +				pstat->flags |= WLAN_STA_WME;
> +				pstat->qos_option = 1;
> +				pstat->qos_info = *(p+8);
> +				pstat->max_sp_len = (pstat->qos_info>>5)&0x3;
> +
> +				pstat->has_legacy_ac = false;
> +				if ((pstat->qos_info&0xf) != 0xf)
> +					pstat->has_legacy_ac = true;
> +
> +				if (pstat->qos_info&0xf) {
> +					pstat->uapsd_vo = 0;

This variable and other variables below are set to 0 just before the loop,
so the initialization here can be removed.

> +					if (pstat->qos_info&BIT(0))
> +						pstat->uapsd_vo = BIT(0)|BIT(1);
> +
> +					pstat->uapsd_vi = 0;
> +					if (pstat->qos_info&BIT(1))
> +						pstat->uapsd_vi = BIT(0)|BIT(1);
> +
> +					pstat->uapsd_bk = 0;
> +					if (pstat->qos_info&BIT(2))
> +						pstat->uapsd_bk = BIT(0)|BIT(1);
> +
> +					pstat->uapsd_be = 0;
> +					if (pstat->qos_info&BIT(3))
> +						pstat->uapsd_be = BIT(0)|BIT(1);
>  				}
> +				break;
>  			} else {
>  				break;
>  			}
> -			p = p + ie_len + 2;
>  		}
>  	}
>  
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
