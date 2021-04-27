Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D2236C7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhD0O0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbhD0O0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:26:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0361C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:26:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n2so6521707wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RwMvEObyLlKjSGQB/9hmAtzJSE09xxj6MxSNgN4PmDg=;
        b=agw3pihNfoQx/rmG9lGzHPRnpPYrXsNJpXdMOjbVUrgEvLtwFuHTcLG/Sfu43S8NBu
         nvBbsuzaPjVoYOG+SJ+dVtTSdPN9fLNrfAULOBwFmVUvZCvMjPOfOByQJCzOldf+issf
         7/tOx35F9DuZZJ+Q3T/4qYAPalHVxeYaNJPEvtrrmgw+DoX9Hty1rBdNgDfV8nQekwdJ
         wgcO4IYJrXCH1m1X0u5vTuCHeQYufzi499D6xFPXFhQLVRk3sJh2ZnIaceBGm/zsqNLU
         joy+IaBjekSq5EIx9r90YBcHNel+cn0r1JgvRfRFHGX2y66eauywKyGOqlwqizVpt2cW
         TTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RwMvEObyLlKjSGQB/9hmAtzJSE09xxj6MxSNgN4PmDg=;
        b=S38eb4Efz26G/Fy7Mn4vr0fYE3BqEmT4u2HI/yv5mJHrzx31cYw0SR5N5U3jpqZRxo
         zs63iC36wD33qwuZfbUW5nvd5oRkm/4Nx9x6Xd5Co5aTUyd7Rkp7soOiceLVXuKj+yFi
         TGuV/oun3e7yBj+XhsTh6VtyQbZywQx7dgXyLlceqFZPAFN/N4bnQgniiCsBv7R4DT6g
         avtE2/jjDHmNatXB0a/uEVjnowdBBaj52BrkY09kIsw9+bFLvpg1LE7rShrBVvQ2VWL/
         0i8fKWwlLMBuwuAK+d+ahMUFyv29G9yZujkFmxqlWP+sKcEHP0YFBkoQnMTdvpKAW7PL
         fIBA==
X-Gm-Message-State: AOAM532jVcP4CAZ1FkRocv9zwaqGDLEStINCOlsfbC0m6Vf/Hhfiw8Et
        Gee8IMO7GXlFJO/rmojiR1M=
X-Google-Smtp-Source: ABdhPJwO1y9ZUdpol4SaeaOvTVLho4jSt7rEK8qX01Ic5QLYtfAmkg67iQrVra9g3IPmDXAJH/Jn6A==
X-Received: by 2002:adf:ea06:: with SMTP id q6mr5891373wrm.34.1619533563597;
        Tue, 27 Apr 2021 07:26:03 -0700 (PDT)
Received: from agape.jhs ([5.171.81.92])
        by smtp.gmail.com with ESMTPSA id d5sm4182448wrv.43.2021.04.27.07.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 07:26:03 -0700 (PDT)
Date:   Tue, 27 Apr 2021 16:26:00 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        rcy@google.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging:gasket:core: Fix a double free in
 gasket_enable_device
Message-ID: <20210427142559.GD1399@agape.jhs>
References: <20210427141129.6207-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427141129.6207-1-lyl2019@mail.ustc.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lv,

I fear gasket is no more on staging tree, I think it's no more on
kernel. Try fetch again from remote.

On Tue, Apr 27, 2021 at 07:11:29AM -0700, Lv Yunlong wrote:
> In gasket_enable_device, it calls gasket_interrupt_init().
> Inside gasket_interrupt_init, interrupt_data is allocated via
> kzalloc() and then is assigned to gasket_dev->interrupt_data.
> If the later two kzalloc() failed, interrupt_data will be freed
> and gasket_dev->interrupt_data will point to a freed memory.
> 
> After gasket_enable_device received the error, the freed
> gasket_dev->interrupt_data is freed again in
> gasket_interrupt_cleanup(gasket_dev).
> 
> My patch moves the "gasket_dev->interrupt_data = interrupt_data"
> assignment behind the later kzalloc() all successd, to avoid
> gasket_dev->interrupt_data pointing to a freed memory
> 
> Fixes: 80666096eb78f ("staging: gasket: core: remove static function forward declarations")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/staging/gasket/gasket_interrupt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
> index 864342acfd86..d4993d7abb87 100644
> --- a/drivers/staging/gasket/gasket_interrupt.c
> +++ b/drivers/staging/gasket/gasket_interrupt.c
> @@ -322,7 +322,6 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
>  	interrupt_data = kzalloc(sizeof(*interrupt_data), GFP_KERNEL);
>  	if (!interrupt_data)
>  		return -ENOMEM;
> -	gasket_dev->interrupt_data = interrupt_data;
>  	interrupt_data->name = driver_desc->name;
>  	interrupt_data->type = driver_desc->interrupt_type;
>  	interrupt_data->pci_dev = gasket_dev->pci_dev;
> @@ -349,6 +348,8 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
>  		return -ENOMEM;
>  	}
>  
> +	gasket_dev->interrupt_data = interrupt_data;
> +
>  	switch (interrupt_data->type) {
>  	case PCI_MSIX:
>  		ret = gasket_interrupt_msix_init(interrupt_data);
> -- 
> 2.25.1
> 
> 
> 

thank you,

fabio
