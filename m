Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB3045C8D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbhKXPik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241544AbhKXPii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:38:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2282C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:35:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r8so4913833wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PE3oEbn7qgNgZ9JhYnMoJXVeqzLltbHz8wGgAK6JobM=;
        b=R+Bx74Dx+cw8IlheVux1WxLQJKDwl5S9HJCouNY9vJVJFSh0GmYq6eDXZ/IMiG3ToV
         kO5lvkUfzfxkdeCU+M1l+iHhjIgFGMJV+EK8ivWSF2bn57+BeJVqgJgEGAUtOOkPikJx
         33m7IIoshjXISWp7b8dlclORSxQQIqiedntPDIWfi7tyPAZ7ht9YaFqcTq5WykdKC9xn
         apOEMYhCCc0pQ9C1wRQL32VxhjPVgru0DiJQAJuQVuLMD4CLlkdaQulvFfc0jTlqeUjr
         fvDgZcUQFGuXm/MgpZ+tboHnPEfRaDGYuj/5j/ga+SLs08NEBQv9HW+IhaWROOYZ/f6L
         9BrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PE3oEbn7qgNgZ9JhYnMoJXVeqzLltbHz8wGgAK6JobM=;
        b=P4eth/BFy1gZYxDEsShUVsIjBlYMaooKwfrFwVJUYfwFKQs1RPaEcUl/MFHzEwG8gm
         DJi9GylI0F0iIh4JVWweU2PUyYx89/wWEMbCUjb74tPKlIzU0ZZ/5MxE5IPYmxCF9+7r
         q008iqwkYjSt1xXbKHHoRq6C26DNJ3XoQRVvFzh8PehIUhULWuJo/31RXS8pFFu/fa6b
         QGO4LdsxhDUkiu5jog3x8KIR7c/IN2BCRyYkNBVXrnvdVUshZ3morU8fs9Xcf5H0yEwS
         vTpoZG9wf6xewJWOm6zIRjQxaeZ9UERk0CJ4AeHosOmKy5+EHoFHZ2+H+LbFlSnrB2hf
         oT9A==
X-Gm-Message-State: AOAM531IDCOZdE/UGX4XLUxERs4x7cYYRSK/vJm2vBzil4jQSybN8zBW
        yrZ8EmjSTfBR8eybbFdbnw/waA==
X-Google-Smtp-Source: ABdhPJzbm8N1ndLOo+Uf7Fms3C0HtGXm665DKmZr7sGlFKuGGmR3Ng9QP50vP1rIsEkAGVmOmVV4hw==
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr20982207wrd.300.1637768127374;
        Wed, 24 Nov 2021 07:35:27 -0800 (PST)
Received: from google.com ([2.31.167.61])
        by smtp.gmail.com with ESMTPSA id e12sm248761wrq.20.2021.11.24.07.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:35:26 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:35:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, romain.izard.pro@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: atmel-flexcom: remove #ifdef CONFIG_PM_SLEEP
Message-ID: <YZ5buDQ35sRPALD6@google.com>
References: <20211028135138.3481166-1-claudiu.beznea@microchip.com>
 <20211028135138.3481166-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028135138.3481166-2-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021, Claudiu Beznea wrote:

> Remove compilation flag and use __maybe_unused and pm_ptr instead.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  drivers/mfd/atmel-flexcom.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
