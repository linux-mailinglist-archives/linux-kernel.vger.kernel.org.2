Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69AA3975F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhFAPB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbhFAPBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:01:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04778C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:00:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q5so14682292wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xTnUcZQ1M6+BYid99fnaF+ixo8qSQ1hhwUI4m/9pRPY=;
        b=AmaaliZj9qGfTYWmjTC1HLASdMEW+9GO2+wT87la4L5j5ellm7YGaKkFS/+Rh7uy0V
         NEkyV0usBtP+uCSFcgrChGBBeMfmIV/+a2tf1r2yGa/uygoNOhQXgJomuc9qHYKmcX6L
         ynVBBokekEcn5hfMgj3+ftZDPKjvFZJVEEBiVCVWVxAX43J5PQXHINZ1PQQpPY7isGyy
         7gtWsRPmPp9VCNVlq7aRSg7+QrBVbElnEdZWLCmoLIhQ/RQb/jbTYqB9pNIOgZAVo1Mr
         1U6fIcfHSu7cyINYtTrM5UmYmZx13PudPU2mWYB6AD/4jPuTavrkgWnJte6MUjb/PdMq
         2B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xTnUcZQ1M6+BYid99fnaF+ixo8qSQ1hhwUI4m/9pRPY=;
        b=UvJpZj7iHBJrl0hfHMQpTLCjcE8rBm9WdrvslujciJ+U5mxPYwX0FdZQpiRX3Fvf9u
         UlsM/gIyVA+WQ+awnqIeVs5LRkNTiupaFYeP8gfLDQacJY5gla21cWugbfbF50nblau3
         /kXxcn9g34qNNIuoUNuMmtRCY0B9QvJ0BoTc4v6mU81Mtp32whKqVpzkORfaDafY1eYK
         ggLuT6ao1QHCiMKnlFXsswl1A4CdO25CKw6HVB9Qb0b1fS+51ZhK2EC9HNu/ZDJF4BSV
         C6+fgyxzgVPmPGdwRcknXUuCo6KzDUwXKphotqUnR7r6kLTRAQeMEVDNshQQaTPt94oQ
         61Rw==
X-Gm-Message-State: AOAM533cuIAZBbzDoZmWYyNPcJiGrfPlSb9xD+nyy7EfGxIoTGql8/V9
        q6vdpssVI1TLZFoKbcWwdM+Gig==
X-Google-Smtp-Source: ABdhPJzhV/vKxfJ1BcZM4khG7Htu5IbTcd/J21L4vIo9pAV449SV0cNjm1DdHhfwCKkcnbGBuxMzAg==
X-Received: by 2002:a5d:68ca:: with SMTP id p10mr4252855wrw.65.1622559610666;
        Tue, 01 Jun 2021 08:00:10 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id l5sm2830452wmi.46.2021.06.01.08.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:00:10 -0700 (PDT)
Date:   Tue, 1 Jun 2021 16:00:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Mark Jonas <mark.jonas@de.bosch.com>,
        Hubert Streidl <hubert.streidl@de.bosch.com>,
        stwiss.opensource@diasemi.com
Subject: Re: [PATCH] mfd: da9063: propagate errno when I2C mode fails
Message-ID: <20210601150008.GP543307@dell>
References: <20210525134243.4003-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210525134243.4003-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Wolfram Sang wrote:

> Don't hardocde EIO but use the obtained value.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mfd/da9063-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
