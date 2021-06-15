Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A705F3A7E14
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFOMVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhFOMVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:21:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C5AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:19:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so1884169wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S/Bt5fGVEpXuB26SoHsoKcqJXSL5+g1GerWz8a2JiSE=;
        b=kfW80NmvGGPwfOv5C1fLNuPZKI4F4jU51+SH6vxP2Vnp+URCx6IjB6+g7n8k25SUvE
         fd/dNetlrWrvq/7e6Da/0VbrFrq0TK3elLMqIp6ucY2yb2K7/Z6LGqcdbRqeCeWMIyLa
         fqIMfN/j3WAiOlp9U5yyX/diESCXeWQXoMaOtcgLW4T1rvj2o31YWyyLLBgjpczhmh4/
         vZenGltrRrbELV2hfmyPtO5rywzqUreLZLvdZGDmBppVTyf+566uQVb2fiMVzEGu2x38
         EWtk6TJssZ3vDbJcv3uANwDIHnCYKmbH2GqOSvrFqPKmZLqGW9yVZJu7eup1K5kGVowg
         SGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S/Bt5fGVEpXuB26SoHsoKcqJXSL5+g1GerWz8a2JiSE=;
        b=jFNkAxRAq5aNVqT6Pqv+5jTAjE/SzPzV+rNB0farsrz+Z27u2x+3MlHB3YQ3EPbKtD
         RjZ9LxtGRvPH3s33JD8Jk5wbp3dg+GDrVVV7yeaswygAggXfaXmd5SJ2GYygt2IaekJf
         KhI1cdnq+yEYXQmlz2yqNaLasgBdYY1hdgIHR/P9bE12a+/3VYUyubFgtv7BPOHMrVdi
         XIIhg+ZoX2jlGa8xfeYCEEjc77ihTaj9YX51IZgmj7cZfzRVP4wir959Z4AD3DiFyfPy
         a14DEUomg7yL9BZxRvXDDs1AMvZMqBy1sPzVgF1EdLpWB05Vo8HZb/iJ/OsFUU18s+pH
         M6Pg==
X-Gm-Message-State: AOAM533HPX5kXQ3Ip399oXtAI1/zBb7uTcFZp7vnVJJdBHKYMK2vXJkE
        ritODpp1f+Hnm3krp+wtXa+krg==
X-Google-Smtp-Source: ABdhPJwK2ofKWppTNAI4QadJJjnw7wlsCTLKHiz0doOO1YFrzZWD0pwn0GNNTSmP/0MWhcJ+lW2cNg==
X-Received: by 2002:a05:600c:4a23:: with SMTP id c35mr22650448wmp.26.1623759556488;
        Tue, 15 Jun 2021 05:19:16 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id g17sm18943412wrp.61.2021.06.15.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 05:19:15 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:19:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sergey Larin <cerg2010cerg2010@mail.ru>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max8907: Remove IRQF_NO_AUTOEN flag
Message-ID: <YMiawr+12Uq4Q2n+@dell>
References: <20210614222420.89865-1-cerg2010cerg2010@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614222420.89865-1-cerg2010cerg2010@mail.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021, Sergey Larin wrote:

> IRQF_NO_AUTOEN flag doesn't go well with IRQF_SHARED flag - the
> check in request_threaded_irq fails and exits with EINVAL.
> 
> So we ignore the flag and enable it on the first IRQ request. No
> interrupt should arrive from the chip as all interrupts are masked
> by default.
> 
> Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
> ---
>  drivers/mfd/max8907.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
