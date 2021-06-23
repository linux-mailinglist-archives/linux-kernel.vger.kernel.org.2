Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0FA3B1AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFWNK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230415AbhFWNKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624453714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=laMK981mv0ZnD0B9GFNK7CVhuuQIdDNlKXWiyssjTBI=;
        b=HB/G0BeqDnoj4GiBQcWQGMgAgJX4TSPL9+k4sR8ScJSjRIPGjPqwTWBti6sIlZUhfdeuKE
        Cvsq+f+SCW7Ss71kUrTltJxgmbB6tv78GWgOCPkjHXEhk6q3d0s7N1z5loIsBw/8RT97Cs
        hFshPcch5grV8NOU+SwSLNdhOS6NYyc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-KtXNY7ELOCORW3ua5F91rA-1; Wed, 23 Jun 2021 09:08:33 -0400
X-MC-Unique: KtXNY7ELOCORW3ua5F91rA-1
Received: by mail-ej1-f71.google.com with SMTP id k1-20020a17090666c1b029041c273a883dso972752ejp.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=laMK981mv0ZnD0B9GFNK7CVhuuQIdDNlKXWiyssjTBI=;
        b=ihhg202vdBYdmN1rCZUyuexU0CddKWJxGkoaLiMlPYt6YZaDN1om2Z9njUS8Et57BY
         b+T+gISBGWVGYBxQ/g0RCyVNNyoR6/bec7LSvo99BYlii3Zhdytp+wje04vlIo9GL/9h
         4Q/jxF+QK4LCMSI+JkAYMveYBIQJaA93s6BVAHaoIZ08JSwn7ukY/pwkaWi6BtVsD1Es
         ezKVkY+rHYh8Sy7IxA7TEYOu3OmWlpnRGQ98gBPdJkNTVH8Ok0YwDcSKFwOQZC/I/rnO
         BRpAPUb/Zs6V2K108NB/JroYWyhz70tJ6r7XcB3xcjMOVF0jgVqcEQJenkca/rruP9Do
         HIOQ==
X-Gm-Message-State: AOAM5320jZZSVj4gdjATDrrb9nMQBUv+RZTifMQUYgK+1yqlrP858MHv
        X621vxtHUDKYgJWshxdcFmznHMdWcSqa8NnBS8i+wLI8tNYCS+T3l5C88TiccUW6pt4J9SpZEQn
        v8evmW+ZnV/2xZwcRFnCWAG0nVvtoyxVZdnPkG2dIod83mcQCANLuylMO8VY40RSzZTRgvEAiOv
        dO
X-Received: by 2002:a05:6402:214:: with SMTP id t20mr12498362edv.20.1624453711673;
        Wed, 23 Jun 2021 06:08:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZyOJdESTaoaBILztmfKMoUyzU0klenAe/9rbnsswLUshPvy0GTs8FlOlUumkGgkSEzu3bfQ==
X-Received: by 2002:a05:6402:214:: with SMTP id t20mr12498337edv.20.1624453711490;
        Wed, 23 Jun 2021 06:08:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id cb14sm7954783edb.68.2021.06.23.06.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 06:08:30 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: convert function to static
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210623130103.7727-1-fabioaiuto83@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a5e755c3-48c9-40d4-fccb-1b9146fe762f@redhat.com>
Date:   Wed, 23 Jun 2021 15:08:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210623130103.7727-1-fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/23/21 3:01 PM, Fabio Aiuto wrote:
> function chk_sta_is_alive() is used only inside core/rtw_ap.c
> so remove the prototype and convert it to static.
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 23bbdf084631..3e2d8b735fc8 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -164,8 +164,7 @@ static void update_BCNTIM(struct adapter *padapter)
>  	pnetwork_mlmeext->IELength = offset + remainder_ielen;
>  }
>  
> -u8 chk_sta_is_alive(struct sta_info *psta);
> -u8 chk_sta_is_alive(struct sta_info *psta)
> +static u8 chk_sta_is_alive(struct sta_info *psta)
>  {
>  	sta_update_last_rx_pkts(psta);
>  
> 

