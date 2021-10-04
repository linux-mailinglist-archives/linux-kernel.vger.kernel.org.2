Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902A94206FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhJDIGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhJDIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633334673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2znbHeTUtMfJ6z4tVBa0MoQXXesDQGCaycD18oxgNs=;
        b=IU3SQmGzCG5b4xwYvLRLa6TcD9ZMvN1MunqclG9JzdneB9+Z0yRtLnSMKIyRL2XZF1y16G
        4YGHRahW0KC+G5M8+1ZVtUmPvAJZNGgBBYy68ZhS+9wLpeP3110CqHya1qQ3oXVgnhXyMF
        0PQ9EHDGEm/FkiAjx8l4xJo7XtSWgVo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-w5vr9xXnMOGD6mDtfZO1WA-1; Mon, 04 Oct 2021 04:04:32 -0400
X-MC-Unique: w5vr9xXnMOGD6mDtfZO1WA-1
Received: by mail-ed1-f72.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so16332508edy.14
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 01:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b2znbHeTUtMfJ6z4tVBa0MoQXXesDQGCaycD18oxgNs=;
        b=W6zd8+qy0iFCeaH01N8Uy0TlhEQ6OxF2aSfG36N4Z3iUN7Quz+9Rv0dt8Dv6dpBSuc
         L/3eWGsqWVgFtitCDNYKHc6//uRqsKYkr9JPYuz/CVCyMLEWCJp4zfAm0rtPiqp5kSyg
         ISjXCEXmyzldMR8zWBC/+ZF1iFqm0DB6HOSTRH23kH/WN2Lwv8WiFwfaB3t9WT8IPsTv
         RXDx4jYlwCvKrldiclEpY4hKhX2JUt4i+162vwngjSZpOe9Xfrzjuog7vGlOQla5JnME
         AycYKtZ9FCalEdT1m4P/6w+ud4sUim54hePaM4y4AjyJFgX/a42LbQxx0q06JzJ7OD1t
         7L9Q==
X-Gm-Message-State: AOAM5307t9lS0OFewkwJPhyyY8GfiSk5rrpz3KsaVMz6+9RgnsXMmEre
        wucnrj0Ua188RoB46K3/vVjZ9iqOwFoxISKQayumu3aFBXKgQAwkTsAu1RHi5rO2BWPZFJTpZju
        tEp7zyzLgQT2IHxeMDWy3uyEu
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr17111299edw.379.1633334670831;
        Mon, 04 Oct 2021 01:04:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHDDAKdXSAn82KOTUnDct9UjyTAsKHFkUha0zXYEjle2CuvhBgiNLZygCtsXzjOKucrZp2bQ==
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr17111274edw.379.1633334670642;
        Mon, 04 Oct 2021 01:04:30 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id j14sm6935098edl.21.2021.10.04.01.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 01:04:30 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: core: remove reassignment of same
 value to variable
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YVnX1HIYoisW621x@user>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a110ec8f-0b80-1f44-b60f-e0ac62313832@redhat.com>
Date:   Mon, 4 Oct 2021 10:04:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVnX1HIYoisW621x@user>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/3/21 6:18 PM, Saurav Girepunje wrote:
> Remove reassignment of same value to variable pstat->auth_seq.
> On if (seq == 1) assigning the value 2. At the end of if statement
> also assigning the value pstat->auth_seq = seq + 1 that is again
> assigning the value 2.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 3ee4d35ca8d7..059cd85f4b03 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -808,7 +808,6 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
>  			pstat->state &= ~WIFI_FW_AUTH_NULL;
>  			pstat->state |= WIFI_FW_AUTH_STATE;
>  			pstat->authalg = algorithm;
> -			pstat->auth_seq = 2;

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


>  		} else if (seq == 3) {
> 
>  			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&ie_len,
> --
> 2.32.0
> 

