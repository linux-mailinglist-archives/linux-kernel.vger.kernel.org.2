Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FD041C386
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245663AbhI2Lfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245602AbhI2Lfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632915240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0TDRiIXZN1zosmX7RqwZWk2E8c4y64StnkfwR3/9VP4=;
        b=ilNcFynUmyHLX2mOYOingzIlghkAGWlMx+WmtWRi8sSeeAa2N8XgQFLhPwMgSey6I2/wRH
        P8t409F9hqVI4+0Stf6TFb8JC+mRKqWgwsBqao7OdCw+wN/GPOhAbY2FklmRLMoobEyEDU
        We6QF0zddGpg2M2CsMpKT/bsptKBXCw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-DcbKLaVFOleNg4vbLfzkyw-1; Wed, 29 Sep 2021 07:33:59 -0400
X-MC-Unique: DcbKLaVFOleNg4vbLfzkyw-1
Received: by mail-ed1-f70.google.com with SMTP id j26-20020a508a9a000000b003da84aaa5c5so2068051edj.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0TDRiIXZN1zosmX7RqwZWk2E8c4y64StnkfwR3/9VP4=;
        b=1bNosNPKUHJgsqqpi0eTDNEC23CeA4hugcKgSREHuPiB7lz1NOxvdn4Af16UStRKnh
         SJSbxHXXurcN9QuOvvTwHwbXyZUd4yqA1fbgglLVbqbKhVh7C7guf0vt3bi1gyg4Zj8h
         MpxhsBr5TSixloG5snrxUfZP8wyvHd3CRDl4h1TXIzLflSnpuKc9CzzcLDM1x0HCLDpN
         OawGHpChd7gssNLWQbjDdo7Wk5jmfDr1f7hTdcJtpejZB6q6CXzZGfDxJ4oIyI/Lpej3
         mVIM2HKmqV3ncQkIYpdvWzxXeEGFI5bdNwraKSqJ4M5oitxNZJdBXhAbnmn/9bGTTRka
         WgVA==
X-Gm-Message-State: AOAM533dr6SNeKsSogtDhhOltmvYV6PeCHPWreVduubV98U5jfIes89T
        i5LCOnHWmkgpbw8gIx3EPrxlkf/tvQ2VDUAWuhdzM5Muqmr+78cHwYbNyuc/g3l06lBt/X4DE1x
        hQyn2of37fsd4Jnuc3vSBySQEgRUMp+5xeMItx2ltGqNtcfj5audHWTXBEw6vOKy1EH5SYIo1Na
        Zd
X-Received: by 2002:a17:907:3d9f:: with SMTP id he31mr10470215ejc.255.1632915238518;
        Wed, 29 Sep 2021 04:33:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGzoOekWUWSH10+foP6Atye3miQirqqP2m3uVeNkgVSEskW9nh2h4pxkwH9rxpVIG70C5Q/Q==
X-Received: by 2002:a17:907:3d9f:: with SMTP id he31mr10470183ejc.255.1632915238217;
        Wed, 29 Sep 2021 04:33:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h18sm29081ejt.29.2021.09.29.04.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 04:33:57 -0700 (PDT)
Subject: Re: [PATCH v2] staging: rtl8723bs: remove meaningless
 pstat->passoc_req check in OnAssocReq()
To:     Longji Guo <guolongji@uniontech.com>, gregkh@linuxfoundation.org,
        fabioaiuto83@gmail.com
Cc:     ross.schm.dev@gmail.com, marcocesati@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210929110613.29979-1-guolongji@uniontech.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bc804876-4ca7-453a-b54d-bf7e1b067738@redhat.com>
Date:   Wed, 29 Sep 2021 13:33:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210929110613.29979-1-guolongji@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/21 1:06 PM, Longji Guo wrote:
> kfree(NULL) is safe and the check 'if (pstat->passoc_req)' before kfree
> is not necessary.
> 
> Signed-off-by: Longji Guo <guolongji@uniontech.com>
> ---
> Changes in v2:
> - Drop unnecessary "pstat->passoc_req = NULL;"

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 375d2a742dd2..51390a30fa55 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -1344,12 +1344,8 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
>  			issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
>  
>  		spin_lock_bh(&pstat->lock);
> -		if (pstat->passoc_req) {
> -			kfree(pstat->passoc_req);
> -			pstat->passoc_req = NULL;
> -			pstat->assoc_req_len = 0;
> -		}
> -
> +		kfree(pstat->passoc_req);
> +		pstat->assoc_req_len = 0;
>  		pstat->passoc_req =  rtw_zmalloc(pkt_len);
>  		if (pstat->passoc_req) {
>  			memcpy(pstat->passoc_req, pframe, pkt_len);
> 

