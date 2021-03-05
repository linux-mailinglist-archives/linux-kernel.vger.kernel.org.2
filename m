Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AEA32E476
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCEJOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCEJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:13:53 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4EDC061574;
        Fri,  5 Mar 2021 01:13:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p21so2366050lfu.11;
        Fri, 05 Mar 2021 01:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PhTwnS6e+dOXGQrScOlJarhrtWGlmLJkLdp9O5h0GHo=;
        b=htvFEAqGTv25B8HwXBqP2E6mw7giIUxxPvkoiUz8Pbbvi4STBfDdPIAlTPYWb+KTgs
         HA6DpvsXUtdE4S14QU4RX7L7jz5BnWlGvjTcSFZgsXRRWTCYVH7xKkOkdZkWDpndyjoC
         8i8dZP1y0s814qk+REf/9JVuH/Cr6h1Qe0MfDefyHTgAjxbbvQnDn+oRkBAyuh/mzLnI
         G3fiNaLLAR4tLwjvcrlIMQbIYfrDDIH+5iwFpjs8Tx9I2llNFnOziqrs0+XEOcbA+X9C
         BC6oqyLtKk0IrsWhIHCxFJ8yh7UZ7I6pkofCLiRke7XCn1FL+gRh/g6zq9JEJyPmVZOd
         977Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PhTwnS6e+dOXGQrScOlJarhrtWGlmLJkLdp9O5h0GHo=;
        b=EUKTIiC/QIwArFYwsYfexgpL1ZeHBqb2f/hriCu4BoiBYc+3vALE0F24SwN+nqIH6G
         52h1gua0pzE4CUelbQl7UCoapDh3gr8PjDK8U8FPJiZTYcE/Ro0zzpZ3P0XUTbgOGkCD
         0BuYY+2UDhy/y+70TdFbJx/8D5dfmhfHcJ1ji79OW9/IgXI0X2Qv3sXea1xthTVW3rnn
         DJieJgZWA7OS9+MLiioUcX6DczAsU7bxy8WzKldYNNgk5ladp6uND8dPz/WhzN2sU9Tl
         jz0kcA5w33QfmuRJSiPtGRLuFFsnp5m51t5eE7ZgNLcybjbAl/5q+64VhCp6AnPThdo7
         hoQw==
X-Gm-Message-State: AOAM532C3jk13uvTHWbsUtiV/lZm/VonUAh9GK8Dgbz7X97cf5FmGonP
        ApQjrnXGZeY52XJ1xEmLKIA=
X-Google-Smtp-Source: ABdhPJxwB5rP6t2SaOLsLjt2imgfZdWI9yHY2brcos7S3qzCK9X6wTcwXLCa2C7+/xlVZHElmFYxbw==
X-Received: by 2002:a05:6512:11e3:: with SMTP id p3mr4937581lfs.137.1614935631505;
        Fri, 05 Mar 2021 01:13:51 -0800 (PST)
Received: from [192.168.1.100] ([31.173.85.142])
        by smtp.gmail.com with ESMTPSA id p10sm233695ljg.99.2021.03.05.01.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 01:13:51 -0800 (PST)
Subject: Re: [PATCH 03/17] usb: xhci-mtk: get the microframe boundary for ESIT
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
 <1614934975-15188-3-git-send-email-chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <cfa6dccb-d784-06fd-e5bc-0b53d105b7f6@gmail.com>
Date:   Fri, 5 Mar 2021 12:13:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614934975-15188-3-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 05.03.2021 12:02, Chunfeng Yun wrote:

> Tune the boundary for FS/LS ESIT due to CS:
> For ISOC out-ep, the controller starts transfer data after
> the first SS; for others, the data is already transfered

    Transferred.

> before the last CS.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   drivers/usb/host/xhci-mtk-sch.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
> index 8950d1f10a7f..e3b18dfca874 100644
> --- a/drivers/usb/host/xhci-mtk-sch.c
> +++ b/drivers/usb/host/xhci-mtk-sch.c
> @@ -513,22 +513,35 @@ static void update_sch_tt(struct usb_device *udev,
>   		list_del(&sch_ep->tt_endpoint);
>   }
>   
> +static u32 get_esit_boundary(struct mu3h_sch_ep_info *sch_ep)
> +{
> +	u32 boundary = sch_ep->esit;
> +
> +	if (sch_ep->sch_tt) { /* LS/FS with TT */
> +		/* tune for CS */
> +		if (sch_ep->ep_type != ISOC_OUT_EP)
> +			boundary += 1;

    Why not:

			boundary++;

> +		else if (boundary > 1) /* normally esit >= 8 for FS/LS */
> +			boundary -= 1;

			boundary--;

[...]

MBR, Sergei
