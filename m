Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA44206E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 09:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhJDIBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhJDIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633334391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c37BzLidBYzb5X13SgY9I9yJ9KC600FPw/jSiIVYAh0=;
        b=FocwmMIt0k8MP8aYaLA/VYXyrBEyL0oeiyKJoQ+mcRQlMeF/Bu7mCQONnR6Cu2Bzvu/Pts
        rox7d7XeC2YsVSuOOoR0TxrB+HkGAx9vDPez/avjxRsXpSpi2oq++bT5WG0WFZTcS1TiFi
        /7Lcxj3Duo+plg0gtp4CvaN6wIGByqw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-YAZH9hyAPj21N8NdfthOrg-1; Mon, 04 Oct 2021 03:59:50 -0400
X-MC-Unique: YAZH9hyAPj21N8NdfthOrg-1
Received: by mail-ed1-f70.google.com with SMTP id k10-20020a508aca000000b003dad77857f7so440979edk.22
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 00:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c37BzLidBYzb5X13SgY9I9yJ9KC600FPw/jSiIVYAh0=;
        b=gmURyQY30viN2BuLHTF5XHu2YqduxNGVuNvL03u55SUfkO4x64rOqltcVNI8kqJptU
         KsRH9AHv49S9zbA4EC/BGofbe+znotCSvhSIOGWIqP3eArR4Jd/qEUOOjRu0+bMbwCfg
         YFMTnRlA20JTBuxLP81Cap71c7YYx3UXJHGBcIHcu5BvTq27sxaISLthaFNQ8pGIMW1i
         qSPCagi+LPthHEIaQIUUNO4BV1+hogtxSoz46GAxwwC3WRaxXSax9G+3wQVurDzbmBQq
         vdz8VtZIBN5I0if6SGvLA383uLyHziNU+rDpgT6UPIyhQdpgB2tHmhN27o48wuQD9JNe
         u7EQ==
X-Gm-Message-State: AOAM531KzP6RjOj8LKkUz6ep8JWA81bjlsfgfXT/9352Mr4tornJ/4Xe
        TKJKwoOhvlK9EBHFKNqJQdtNxf9emxgkatCD7kBuPissjLX3Tu93j/vV/9XaJVw+esRRkH02899
        f/i8Ccq7pRuyeCR+e+8GGV+kc
X-Received: by 2002:a50:bb09:: with SMTP id y9mr16259956ede.89.1633334389020;
        Mon, 04 Oct 2021 00:59:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzQhV94k4lBT9IBc6lsco946c+YRKUoPG15ShQUP6UiQTbWwVPybN55Udnsy6qXsJkSNGcQA==
X-Received: by 2002:a50:bb09:: with SMTP id y9mr16259942ede.89.1633334388849;
        Mon, 04 Oct 2021 00:59:48 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id n6sm6893877eds.10.2021.10.04.00.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 00:59:48 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: core: remove condition never execute
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YVnTJCoz2qsXDXGc@user>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fb939e4a-2e1e-18c2-f65c-9e2103ff8bcc@redhat.com>
Date:   Mon, 4 Oct 2021 09:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVnTJCoz2qsXDXGc@user>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 10/3/21 5:58 PM, Saurav Girepunje wrote:
> Remove condition which never get execute.
> as pattrib->mdata is always zero before if condition check.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index b2c042c36777..3ee4d35ca8d7 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -3222,9 +3222,6 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
>  	else if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE)
>  		SetToDs(fctrl);
> 
> -	if (pattrib->mdata)
> -		SetMData(fctrl);
> -
>  	qc = (unsigned short *)(pframe + pattrib->hdrlen - 2);
> 
>  	SetPriority(qc, tid);
> --
> 2.32.0
> 

