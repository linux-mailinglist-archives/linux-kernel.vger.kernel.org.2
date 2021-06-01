Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED923975DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhFAO7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAO70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:59:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A412C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 07:57:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1423648wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x67didzJtzPvmOqgoOtarXvLTU2X2jkGh5nw7JkZVzU=;
        b=l+7hzMmPtjN45ePn9RNs41K0zG4xu7SfGq6Ex66ocZ7kMM5kADn84QdgR8hpFz4yM/
         EQcn0um0ME4ntF8kEZsNMFxMsjp1PtlXjQhzcY7/1GDoFrdeQC9IbBQc121gpgH3ZjXA
         ra2GSpf1mMcZ15xBJ7ol+qRugNLpfqmoY9Bpa61OGLITY73meyUD/3j/yllNyjOMkWGC
         xlwUVyXkbl/DZAIRyQ9d+x7GfdgUuoiw9um7LkQ2Byfn7rriXzxhLiAjtspplC3Y3tHs
         tCab2APbTgOsVuhc/XV6TIznhXDQX5m9kQPoEM0nBp15MewJXO6cj1iZUSORe5LpoMKg
         x6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x67didzJtzPvmOqgoOtarXvLTU2X2jkGh5nw7JkZVzU=;
        b=qa9YUmfZEZGa0J42Fo/ZLiYPx3zCPMRZH1HNpIGbGB9gZboU534kFS/XHV9Zaj+j7M
         moiZEDPvhcylMeK3KKbzjR/R0bHxpKSai2q65Ja7gcuUDBAJqFCirIIx/4njvhpiujV4
         7b+Sq4VOtkk6H6Nyx9i4khbTP495Xc0QAUOZwpxHNFJjYXrs3GJ31RGZ7cId+D/ahQGA
         qmuzbc4XIdyCluHt9DiwnoMoVrAKGFFYrwxMzf9a0OQdhDVRtiSLfqRfv/BIfN/jjZau
         ipVTVrRdirWdMHZG/zfhU9iUYNnU2jFGnNO1afhBWe1DB7U+1PY+1+4PbcUUGAduUB13
         e2bA==
X-Gm-Message-State: AOAM531Nk1vD1iD/lTh10jrNf7N0I8MSwDpN9uP7f7b+x5oI75ka6oT5
        HBnijp3mDy88uYeBh9BLpNPaUw==
X-Google-Smtp-Source: ABdhPJwAw8VQngr7L9YOTXshioLjs5VT7iu8jf0HW8o4ZIyUeYNTNLmv9SyWUs7wHtbITDfR5RQu/A==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr318833wmk.3.1622559462684;
        Tue, 01 Jun 2021 07:57:42 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id a11sm3475669wrr.48.2021.06.01.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:57:42 -0700 (PDT)
Date:   Tue, 1 Jun 2021 15:57:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: Re: [PATCH 2/2] regulator: bd71828: Fix .n_voltages settings
Message-ID: <20210601145740.GO543307@dell>
References: <20210523071045.2168904-1-axel.lin@ingics.com>
 <20210523071045.2168904-2-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210523071045.2168904-2-axel.lin@ingics.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2021, Axel Lin wrote:

> Current .n_voltages settings do not cover the latest 2 valid selectors,
> so it fails to set voltage for the hightest voltage support.
> The latest linear range has step_uV = 0, so it does not matter if we
> count the .n_voltages to maximum selector + 1 or the first selector of
> latest linear range + 1.
> To simplify calculating the n_voltages, let's just set the
> .n_voltages to maximum selector + 1.
> 
> Fixes: 522498f8cb8c ("regulator: bd71828: Basic support for ROHM bd71828 PMIC regulators")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  include/linux/mfd/rohm-bd71828.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
