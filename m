Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4223F3E29D9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245591AbhHFLjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245580AbhHFLjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:39:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51FDC061799
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 04:39:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b13so10689652wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 04:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sIk9FDJCPmcBhdDrRs7Ki2ReP7DyCdqBVdDWjMBZOiE=;
        b=wbWks6lEYjvAFd8wDtE3tfzuo6MII1IMN/bSuSZ2g4dsRiie1AcxA5fpGbq5cfRGL/
         0g0mIUNjDeE1TaM3OIPJTjcmtBme9PEeS1RNcqvPcRvSDZ5yIazrO944cFaAIY3Qj3uo
         b67JQBnNIYciH2oeHy8k2QcdMgpfiBuQNo6tL33strImBjybigF+hskrVToRtpc09aaG
         wHNoWfLXpQQXVwUtbzUdxpeylTvawmK6f5hUEkfzN9ceqZHFsBRtOg1QRHJsY7V/m3RM
         Rz1lpUfrDgTBUfYC42baoT6qsOxw1A7CAVPhPZtVckfOVqAA2Dj6504itzd/t8IJg8yV
         irWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sIk9FDJCPmcBhdDrRs7Ki2ReP7DyCdqBVdDWjMBZOiE=;
        b=s2mJ6FbQ9krUu10quQEgwicsQYgGq1sSBkpqgs0uOAnkI0M5UUK+536Es9ZOiIlCSG
         khT+dbU2sNWUVACInSxmUuJ0KWos/og7akfXHNDNwexfxM+BWzyufzJZG9E5lcM7aI35
         gdpaOk7mddGG5xvNy6UUU77pmHe/mIIy4lOokRUa8wHWwCwqvUW+t+JAsw55+qzDBN9k
         nIFOIlAgQgRDiGRQ6crmdbKT5927wyvPEMJzDcvrNYwhx7OqlKVkKNd1YpgeR+KLeIZc
         CuV2iANEsUTgVXIBh8ThcUYLNqweFXkwNGQj5XGfvvVcqkqFgZz62ofBDSDpHcDnoC5i
         NIsw==
X-Gm-Message-State: AOAM530E+7lNpO/OP5y3Gv/yfGzCELfUeszab2iONDJSSDU3qDm1Yl7U
        I/zwvEUbMDZAx4JN3hYlXpTxQA==
X-Google-Smtp-Source: ABdhPJwmb3vNrMXwP6JpkOcLC4w5PE8cPJplNLMnZxrqyOdhMaQAIHMxBx5o8cOkLzJz2yReUAbLfA==
X-Received: by 2002:a5d:4583:: with SMTP id p3mr2956946wrq.398.1628249956329;
        Fri, 06 Aug 2021 04:39:16 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id j4sm8328045wmi.4.2021.08.06.04.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:39:15 -0700 (PDT)
Date:   Fri, 6 Aug 2021 12:39:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v9 04/12] mfd: simple-mfd-i2c: Enable support for the
 silergy,sy7636a
Message-ID: <YQ0fYe531yCyP4pf@google.com>
References: <20210806091058.141-1-alistair@alistair23.me>
 <20210806091058.141-5-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210806091058.141-5-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2021, Alistair Francis wrote:

> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/mfd/simple-mfd-i2c.c | 12 +++++++++++
>  include/linux/mfd/sy7636a.h  | 41 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 include/linux/mfd/sy7636a.h

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
