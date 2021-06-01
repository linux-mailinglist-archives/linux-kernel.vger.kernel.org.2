Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B693975DA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhFAO6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:58:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892B8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 07:56:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h5-20020a05600c3505b029019f0654f6f1so1262618wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vdk5QDwow3LZhVP+K/QJtZB00WubWTVwR8JW8Qsj2lE=;
        b=eFouv1splfzerNFOpEOxYp8Z2L3YkhrfNBYTCvCvpK0O/2jLcXFO8cl7b232U0kLMw
         slYUCtay5K+KSJu3GSEe9WKgIqElbnTkDGsoQBVzoShRJkxFkV/G2Ui62/ZwSLFafGsM
         p4nPvIqniFVaq0Y/A6PUA1I4KzNwxM8J7H/r898KOq94xAhNHFxW2tMRatWpjtt0XV5w
         tyeOwwIRJQDmswOH3r/uTLbQ6EeXQuRTUh03qekfeua9r/qS5LLCZl8tefK48WfqUvjI
         duIYfxFtrtruRZdNyLfJx06xUsr0VWwC3witlPWaf3Nx12lRo9gmEhxxymz0tK1aYB9H
         3wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vdk5QDwow3LZhVP+K/QJtZB00WubWTVwR8JW8Qsj2lE=;
        b=VvIx4BwW9XSNXRKvPb7cY+M2p0F/jHkuNmgeaSuD0uoJarflUpzy6n0SgblSmzNUBU
         H51FVe6bwtXFGMYArgarh4mbU+pZZbAA1qgYlceu3MigmsOm+OX635LvpsKeOMxXqwl1
         FxaCuY4Ulc0srGvZowdlKQ64LnsWcO6uCWJaCDALsx5jhqfQuM59f5isXiJZflHM+Kmn
         35toQ/cN+JjxSB4dXoldPZhPKTO2zwvxR0S4JPySMot0RKsRyzg9hU89hxnCdylVtxhc
         h4IcTmiecFWbvB13kl459I6cptqOYqt9HMdzpBxj3892u0pAHRIpvt8TvWTQwqA918zv
         9M6g==
X-Gm-Message-State: AOAM533GyjOUKo8ROIfm6/taVc6BjrzcIgaKMTI/S4lROHRlu0CuWt6G
        IGM1bczbUOwhtHHY2Gr9T6Z4kA==
X-Google-Smtp-Source: ABdhPJw+5IoKwXwL/tiqw+k+8nnAycZ6MqVZFw3/wN1FrLh1UlnL0uKXNCqC+LnKnX5y9QI/PmrcTQ==
X-Received: by 2002:a1c:9a84:: with SMTP id c126mr26985979wme.160.1622559408222;
        Tue, 01 Jun 2021 07:56:48 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id s8sm4282310wrr.36.2021.06.01.07.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:56:47 -0700 (PDT)
Date:   Tue, 1 Jun 2021 15:56:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hao Fang <fanghao11@huawei.com>
Cc:     puck.chen@hisilicon.com, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH] mfd: hisilicon: use the correct HiSilicon copyright
Message-ID: <20210601145646.GN543307@dell>
References: <1621679115-15479-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1621679115-15479-1-git-send-email-fanghao11@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021, Hao Fang wrote:

> s/Hisilicon/HiSilicon/.
> It should use capital S, according to the official website
> https://www.hisilicon.com/en.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---
>  drivers/mfd/hi655x-pmic.c       | 2 +-
>  include/linux/mfd/hi655x-pmic.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
