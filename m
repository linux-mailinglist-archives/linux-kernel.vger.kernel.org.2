Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9055B408DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbhIMN25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241855AbhIMN0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631539487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GXsTS2qgj0DJKAnZpWeQ2GgDU/t21LtMn8iMahLaDWw=;
        b=SDwiwHFiCU/piGQxUnn/varq5ECJhVdIE9UWZnGiGpLR+4p8/7sF/QpQzu7Nghb8chiJNP
        zVs6iUlbsiW++jrDxHdjpdKIu9VFt38Hw/zVASJ7cLUMU/gRZCBcOCR8z9gTHH4Ny7Dus2
        1sdjCTbKTndGgosQ6Zs+CWOLrFtEXbc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-fk7ovpuDNDCTdcEVp7s7HQ-1; Mon, 13 Sep 2021 09:24:46 -0400
X-MC-Unique: fk7ovpuDNDCTdcEVp7s7HQ-1
Received: by mail-ej1-f70.google.com with SMTP id o7-20020a170906288700b005bb05cb6e25so3644738ejd.23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GXsTS2qgj0DJKAnZpWeQ2GgDU/t21LtMn8iMahLaDWw=;
        b=2tzkvjXsNt88TR1FwkP77ewycTwb4lEzAcyOINmgTF0G8DuQZ6FGk5sG8P+kXTO2Jm
         96FhF/PfaHIpH2qakdODldFRHsCym7VLp3lI2IBc5lKASFbS7xTpdGSyx7i3wQUehMOU
         TDU7Mv+6/615BuzxMKNakyRc3EfPYNmbsI0VoXYJrgt0tlhNKIIL1mlORTuIuoMDxjUK
         uEki8gF9cKLC80fF8hXTIhoGytgtSqBZq/Oe4gMvkoM5m9qbkbEbUJ94nkrdJQxOj9cA
         23AYeBAlxEJbvybXkvRbdRC3WOn6ZcF7xG+fb3lTQ25I6+sv8WguLOP/fcJujzO49oBg
         d7UQ==
X-Gm-Message-State: AOAM532z4LceLQxQVqFD15x+QKXMCkjYAYIs5AGHv2Npd0JLh3SC4qzH
        5DMx5taH0ROi6m0A5iFZBnb2anK9HRYnCAbAAl1MDs2wh+Hs8exZHDE0Y9pgthPl6r1/gcA23yv
        fOSbqmuYj9LVWxbQdnu9uHlszFfWkMCdD6aRCf+b52S1NCTdyNfsWQqrefNkEL7LoxwY2opwTp/
        y2
X-Received: by 2002:aa7:c617:: with SMTP id h23mr11717115edq.357.1631539485288;
        Mon, 13 Sep 2021 06:24:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgso/58go/bCIPD3ANBIA2Lxa5lcq90iKyqr6/f66HqZVHaaHJih6Pcb+vTLHe8eF6VN93+A==
X-Received: by 2002:aa7:c617:: with SMTP id h23mr11717099edq.357.1631539485094;
        Mon, 13 Sep 2021 06:24:45 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id y5sm2773354edt.21.2021.09.13.06.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 06:24:44 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: protect sleepq_len access by
 sleep_q.lock
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210913130346.2390-1-fabioaiuto83@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d6d6c6bf-b787-aac9-4767-4bf54c5437ac@redhat.com>
Date:   Mon, 13 Sep 2021 15:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210913130346.2390-1-fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 9/13/21 3:03 PM, Fabio Aiuto wrote:
> protect sleepq_len access by sleep_q.lock and move
> pxmitpriv->lock after sleep_q.lock release.
> 
> This fixes and completes a lockdep warning silencing
> done in a prevoius commit where accesses to sleep_q
> related fields were protected by sleep_q.lock instead
> of pxmitpriv->lock.
> 
> Note that sleep_q.lock is already taken inside
> rtw_free_xmitframe_queue so we just wrap sleepq_len
> access.
> 
> Moved pxmitpriv->lock after sleep_q.lock release to
> avoid locks nesting.
> 
> Fixes: 78a1614a81f0 ("staging: rtl8723bs: remove possible deadlock when disconnect")
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> index bf090f3b1db6..c98918e02afe 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> @@ -294,10 +294,12 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
>  
>  	/* list_del_init(&psta->wakeup_list); */
>  
> -	spin_lock_bh(&pxmitpriv->lock);
> -
>  	rtw_free_xmitframe_queue(pxmitpriv, &psta->sleep_q);
> +	spin_lock_bh(&psta->sleep_q.lock);

AFAICT this needs to be above the rtw_free_xmitframe_queue() ?

Regards,

Hans


>  	psta->sleepq_len = 0;
> +	spin_unlock_bh(&psta->sleep_q.lock);
> +
> +	spin_lock_bh(&pxmitpriv->lock);
>  
>  	/* vo */
>  	/* spin_lock_bh(&(pxmitpriv->vo_pending.lock)); */
> 

