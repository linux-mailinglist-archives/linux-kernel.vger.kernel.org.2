Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAAA43B363
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 15:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhJZN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 09:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbhJZN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 09:56:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FF4C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 06:54:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id l203so9688482pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=oChekstjDnKzwBhdDuGFpefvR6xyGjCzFXwyqCTn1FE=;
        b=XeW0KWC1g2HthKjpNT6Yaa7UdsE2wcfbZJGAm3iHM8imLVv7mRRyyO+fjHbp6/WH4l
         9rDRx0ijihXYsd8v0me+dtnaXDZuxKT69tBgcO7R6XbECV28jK2FyG/r3wzepmkuz2Ux
         RWDa+s9CkJvxtCtH3v3TCbmb+1GU7CLQq7vK5Vay+pQxor+axFECWC9kFO20XVVKG+xO
         /H8fT47GvCuQEk/y1xuMaW4E2n+axYATV4GLzkaO61BEE9PrMoo/Jl0+NZrB2G5bM1eK
         zfJ6By/TxpSCaxfj+DOIodffhmFskTVBcifhFaKl27UYCFMFs60X8zru/3bVmSU8EXQ7
         qeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oChekstjDnKzwBhdDuGFpefvR6xyGjCzFXwyqCTn1FE=;
        b=chrIr8DnFEPKzS5asEpNPHcIxURM7XYwq4H/1Phb8KJECzh9kWJKLrX9IusqmVngU8
         MwQYSL1Smgw51U5/HJur7idegu+SJKiBnT/lm2xItvlenp6CUy8hvdtonO9TMgtmDV0u
         KDtMIF1RA4I2NvZXg9fdaNeLQE9hPqPXCTOsqmViJqQIwWV73z/B7g1AiVeZftU5I4SN
         1kliskTIiTQioEeKVqBzMdHeQKsCF+nbbwIqrpFRgrlsYLhZqvy42kR84VN5KBxWhOfU
         zUl4/nw7lQyOifBlvf8NstZZswEEayAWwKxhNJWRX5R0w0E+FjAq1IsFwGWLVdgcY/2S
         ECmA==
X-Gm-Message-State: AOAM530t9Ny5hdbQarDSnihxMgsoJc097lowKGSiKdfjle6yQmfkyjN3
        q6FZxcQKkANi8xz9M0vvAHE=
X-Google-Smtp-Source: ABdhPJyhgTllBI7U5qR46CHoSwZnv3/cMgyHOAU/WUk4kVqfiooh1NbqVsORYmPmu81CMg0f3yUZkQ==
X-Received: by 2002:a63:e24b:: with SMTP id y11mr18769979pgj.452.1635256473057;
        Tue, 26 Oct 2021 06:54:33 -0700 (PDT)
Received: from [192.168.1.122] ([122.181.48.19])
        by smtp.gmail.com with ESMTPSA id lb5sm1066507pjb.11.2021.10.26.06.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 06:54:32 -0700 (PDT)
Message-ID: <84add494-6e39-cdd9-96c6-04a0245ae11c@gmail.com>
Date:   Tue, 26 Oct 2021 19:24:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: core: Refactor
 nested if-else
Content-Language: en-US
To:     Kushal Kothari <kushalkothari285@gmail.com>,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, hdegoede@redhat.com,
        marcocesati@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com
References: <20211026134253.7868-1-kushalkothari285@gmail.com>
From:   Praveen Kumar <kpraveen.lkml@gmail.com>
In-Reply-To: <20211026134253.7868-1-kushalkothari285@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-10-2021 19:12, Kushal Kothari wrote:
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

I would think of something,

for(;;) {
	p = rtw_get_ie(p, WLAN_EID_VENDOR_SPECIFIC, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
	if (p) {
		if (memcmp(p+2, WMM_IE, 6)) {
			p = p + ie_len + 2;
			continue;
		}
		pstat->flags |= WLAN_STA_WME;
		...
	}
	/* Here we will reach only if p is NULL or its required entry */
	break;
}

Can you please check if this works well. Thanks.
Also, wanted to check how are you testing these changes ?

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
> 

Regards,

~Praveen.

