Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F41443921D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhJYJPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhJYJPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:15:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062F2C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:13:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id np13so7753984pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ATtusDzZDIylNdGI8yivyPmdhTP5mkz+4pQcoTIn5lo=;
        b=jGEUbIXRYvuB0DrV+TSzKVqHPQhjz4+WwI9i9s8d5F3r3jIyl7jzHRW6VzhP1pw5Ku
         mLaGVq6dBPHN7MmQDZGADNH11wTKfciU0kZto8qjs6gZ+fFtMNZ3FG3BIu20G3E/WUyV
         Lf7t8U1VfDgh/VkY401jniye7a9E7jbSaTmicUmcWwt8EM5vcp7zm4QYFx0Ag6qRTWLf
         Tk+aChdCxmBZeZ1EmVffeuTOZrxgVG9mwtOfzW1mPDKnOyRBaMgGRVLpTL/ZdDtxfMz5
         dlpVr++Angmfl8OZOpqWWkxf8f8/2O5j74/tzeZhj2CByW4M7qCHVr1REnTujeNzANGd
         bqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ATtusDzZDIylNdGI8yivyPmdhTP5mkz+4pQcoTIn5lo=;
        b=DFOu2oiySdp5L6eddFxQOPXmITJYZ4+V/8ml+/p+Tyn9Ext0fMwrfrv4p/8GPtH4IU
         WYD0Mn6RZbFvUBW3pF0oNya9FHuAIIrf+z0nurydQZjy6boNs/ic8cIV0UaKu//ZXFeC
         iSVnz09kTaqY6giduK8OvjYEAMG3DiNK0uUkGxzSvA1Z4EDU8EZM3QVH17ovga8ZSX1l
         rnrcUMHBdtIjKaZKFcCwaC1mDTBhTzD+zQlU51GRZp2LuCIKGeGVMwCaGZShcJVf+q5z
         3ahh1uP3Zkq5Q8w+2psa9QkfyWQILwAREypn+vM4bs0oURqQARQiNYdVOovlA7ftseN+
         k/rg==
X-Gm-Message-State: AOAM533H3cHRSWF1me7p77LE3KLqhjsCPz51CDEqlp/gvGR25AE12Gw4
        TzTUzL+wVPiHIpx9NR/KjKo=
X-Google-Smtp-Source: ABdhPJyBg8wfcK4S7RcGfdVCLnyh2cS/qF+h0hCpRxg+XgHPYelvmLgmot45earrLTa8rPCB9qjWdQ==
X-Received: by 2002:a17:90b:3e85:: with SMTP id rj5mr34001833pjb.104.1635153189553;
        Mon, 25 Oct 2021 02:13:09 -0700 (PDT)
Received: from [192.168.1.122] ([122.181.48.19])
        by smtp.gmail.com with ESMTPSA id y6sm14772373pfi.154.2021.10.25.02.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 02:13:09 -0700 (PDT)
Message-ID: <4715e602-bdc0-e0d9-ff99-8eb08c8c5063@gmail.com>
Date:   Mon, 25 Oct 2021 14:43:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: core: Refactor
 nested if-else
Content-Language: en-US
To:     Kushal Kothari <kushalkothari285@gmail.com>,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, hdegoede@redhat.com,
        marcocesati@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com
References: <20211025072528.152028-1-kushalkothari285@gmail.com>
From:   Praveen Kumar <kpraveen.lkml@gmail.com>
In-Reply-To: <20211025072528.152028-1-kushalkothari285@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-2021 12:55, Kushal Kothari wrote:
> Refactor nested if else by combining nested if into a single if condition and removing unnecessary else conditionals which leads to removing unnecessary tabs .There is no change in logic of new code.
> checkpatch warning : Too many leading tabs - consider code refactoring
> 
> Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 65 ++++++++-----------
>  1 file changed, 26 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 0f82f5031c43..eb10b6f85426 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -1192,46 +1192,33 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
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
> +			if (p && !memcmp(p+2, WMM_IE, 6)) {
> +				pstat->flags |= WLAN_STA_WME;
> +				pstat->qos_option = 1;
> +				pstat->qos_info = *(p+8);
> +				pstat->max_sp_len = (pstat->qos_info>>5)&0x3;
> +				pstat->has_legacy_ac = false;
> +				if ((pstat->qos_info&0xf) != 0xf)
> +					pstat->has_legacy_ac = true;
> +
> +				pstat->uapsd_vo = 0;
> +				if (pstat->qos_info&0xf) {
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

there is a bug here, if *p* is not null, and *memcmp* failed; then we fall in else part and break, and will miss the next entry in *p* using below statement

p = p + ie_len + 2;


> 

Regards,

~Praveen.

