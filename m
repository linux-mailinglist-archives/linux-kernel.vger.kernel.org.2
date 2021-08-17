Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8013EE6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhHQGzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhHQGzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:55:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A6C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:55:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f10so9910347wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AR7pc4AE2X9QocS3y7IAlhRBIiIOCoGNDxzVV9D+6Os=;
        b=BkMOYWOtMCIN3yujvpbGZn88HUevvRZbMYfDp2t7z6fyIy6FWuj4W/6mESxXk2nLyk
         MyGWD5JJ7qmU6ltT/+LRuUenOfk85r8BSMzDvgB4jYh73wOaiIOb1N9rYYRMQZjIr2vq
         BSnxjesVLJfXonkIaTPilQAzAvE0+mtz0oOn5FC1AtxfsedpbSEaCrOX4SBFm5ZxqjNO
         ylvTfDtjLlfQc9JCMJNz/4bMAu6f5XvsQZembls5tzdPIDV/4+oUAxebBXihtgg0c0qM
         +ZVKHBdAPrT8KfX2/ELaQ7EYcPrGr6eOtprJLbF1MfdA4H26LqplKyN7nhjHywUWiYpc
         IzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AR7pc4AE2X9QocS3y7IAlhRBIiIOCoGNDxzVV9D+6Os=;
        b=F3iKou6mFWPDYvRtM5tOp1r9vZBcH46kxMuG6XZNW3D1ehO/zZyYFO/2F9+3LaLEgd
         CP8nmxBn1qois0l/lJYvZUmdkqTDmtUBrzY194RCh/TAbn9PnnJIfMgrwbbzbeM7YFCU
         /4rN/WL99sz00pCWDcKwPrxT9AssiJbuOUfcW72PVohiXSkDzD+wZHnR0ndk0zfuOpkS
         ILx4K2nMX7ij+JET+/yBYkHJB7FlafhhrABVcldYxLFRWRxW/y4sfEMwS1n/md8sylYW
         w0FblxWtK/YpyN/F//0M1m44mnnGLzXnqHVSuq1KZznLe0tz3Erku5VRcZk9Es+rzqsl
         h0dQ==
X-Gm-Message-State: AOAM531TICfxLbsnprh8XKpDtDobwG3Od5ROaetW9rU/Vzfq/zW2sYyB
        iULAPTetEXPpUDFhB9rSNPG1fNR4E1c=
X-Google-Smtp-Source: ABdhPJxxJx9dmMiiaVxEreQVfXCMJO1ePRFVrDb26mI+viVc2P8jEg0A97tcuhlpKsWBAvjjl4q+PQ==
X-Received: by 2002:a05:600c:3b9c:: with SMTP id n28mr1686470wms.15.1629183302115;
        Mon, 16 Aug 2021 23:55:02 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::4058? ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id u16sm1138248wmc.41.2021.08.16.23.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 23:55:01 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: Add spaces before and after logical '&'
To:     Abhishek Anand Kulkarni <kulkarniabhishekanand@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210817022628.GA6595@abhishek-Lenovo-ideapad-110-15AST>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <6957e465-7250-c5f4-759f-c802391268e0@gmail.com>
Date:   Tue, 17 Aug 2021 08:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210817022628.GA6595@abhishek-Lenovo-ideapad-110-15AST>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 4:26 AM, Abhishek Anand Kulkarni wrote:
> Fix Checkpatch.pl warning to add space before and after logical '&'
> operator
> 
> Signed-off-by: Abhishek Anand Kulkarni <kulkaraniabhishekanand@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_ioctl_set.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> index a7f966a..570f25f 100644
> --- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> +++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> @@ -630,7 +630,7 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
>   		struct ndis_802_11_wep *wep = &padapter->securitypriv.ndiswep;
>   
>   		wep->Length = len;
> -		keyindex = key->KeyIndex&0x7fffffff;
> +		keyindex = key->KeyIndex & 0x7fffffff;
>   		wep->KeyIndex = keyindex ;
>   		wep->KeyLength = key->KeyLength;
>   
> 

Hi Abhishek,

there is already a pending patch that addresses this.

https://lore.kernel.org/linux-staging/20210816155818.24005-9-straube.linux@gmail.com/T/#u

Regards,
Michael
