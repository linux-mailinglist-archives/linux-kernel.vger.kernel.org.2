Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF044423962
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbhJFIIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbhJFIIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:08:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9340BC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:06:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o20so6105192wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4tbzzakAGljFCQTESp0PMOiWWBBe/H/4FlnYGwFPQxA=;
        b=nTX85TNeLD6eFcz91J5qRVCWeU877YNnZ0KaegFPg5y4geIgylTxhKs1tExl+6ORb9
         8zfa/Un8OthwXSiQqWxSA4KXxfxQUhQSPGwWnr7nUabvnbKtgpnVm56H+oYvXJrRrPw7
         QThNDA3Lr+sy+UD2kRztsLLO3VXTdsbdxu3hJ3Hq9T5ErumbLP4Ru2sb1u8wrK7tVN5U
         QpYuFCBN1fb/HusUaesTZ5cSWIlV8F+VfL1/A6V+D2cGvvr0yNYs+88cAV7xPNjGb0eB
         z8XoIYtJEPkX26V/q3If2PMiC7v/ViTN4ca5iP0cHRg8SYlGoATqPNHt66TFj9uEWt83
         XH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4tbzzakAGljFCQTESp0PMOiWWBBe/H/4FlnYGwFPQxA=;
        b=olQw4fze+ueibaw5aWW8eBHvtPL3YMU9N97YbEnZZYKcDyiRStCEEd4XjpAoUG0sH5
         bHMtmBBbgmU6vUy8SO0Oyr//019jGcmcwAJkXP2l7vLpaD5jU1lwfumYGQ471LDM+Q2l
         wvDEfV/muhSm6LPhIwJoz6YYVi5//eK37lEnERtkD/Imjj1UjMQhvm2Q+mXEZpSrLc3g
         5iqkTmm5Bxqh8KZ6mL4G1USGO9uSU3yS5jaht+J5ms5pYO7NnEsSGNJrp7dpf0Nj5W+9
         iiqEjlYRc8RYiY5Zoh4nQn4MuitPqSttaX+aToBg2rglqNklIO8d+piRxjFuF2Mha6a+
         ZznQ==
X-Gm-Message-State: AOAM531Ed3FyRh8W1W+4x8zE2zbEsLtYu83LviU7XckrebSr8nKcShPY
        w3poAwabsmazeqWl/r+20SoP+tpbDprSJw==
X-Google-Smtp-Source: ABdhPJwO77K72J5q+A9iuSL6drkccsKBk57zAbcpmb6mk9cM0nIqhZ9PFBU+hzEU8eW5dPn1gjss+w==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr8189104wmi.112.1633507579175;
        Wed, 06 Oct 2021 01:06:19 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id r2sm4639179wmq.28.2021.10.06.01.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 01:06:18 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:06:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCH v2 1/3] mfd: altr_a10sr: Add SPI device ID table
Message-ID: <YV1Y+RgygeJfi7UE@google.com>
References: <20210924143347.14721-1-broonie@kernel.org>
 <20210924143347.14721-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210924143347.14721-2-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021, Mark Brown wrote:

> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding a SPI device ID table.
> 
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  drivers/mfd/altera-a10sr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
