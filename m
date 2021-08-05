Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6923E158E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbhHENUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhHENUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:20:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0877AC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 06:20:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so3684412wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 06:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aI+lAZ4QCh/zoprg6NdKM4JrIkfhAkDgyk/KB+BRPk4=;
        b=O7dMtFjMTQXToBMTlvPDO2ukYwjPS0Na+/WQob1GrAPnrMjtzSyhCXZjKr/0g667iO
         cGa93V/8QJShHYJMr+oA9FpZpksEGNqDo04E2KOWmxiZmrt9emKi0XZyaOMasx9IL0WK
         zw5H+LqQY/vBSk8iFZtsVCcJhvmrP19Tb5o464cY2Bd589chyWYV+raQ6TvMIBcl3hUW
         2RIR3+/IaFPI40PXFjfp9lFNDiFFrRH2zDMRyWj1gpzOZ8zyVBhzS2U8SmUBlADdMb7q
         cF4gXjyUuarjXm/VgdFWxvxti6dtLEYgxxpNqUvzojfYTEszcPjUmX7JlrfpkixEg+Fe
         Y6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aI+lAZ4QCh/zoprg6NdKM4JrIkfhAkDgyk/KB+BRPk4=;
        b=J7768YxbINe1AfFpYm/sKWtMPnS1Y2kyGPGy6ed8TOU6Xue+BCbhqjIeMDWKOsgd8+
         ivBRCpkcSwOXl84ZHUSCR4S3nlYRDtiBZEb8/oqdiBrsSvq7VwMu7sHFkCn3xeZJpew0
         kmWQYjQElemywNLJHJGxWgdSQ7B4P2wMS8pTZKvLBiqojDmiy8L4yyeWrX2l20jisdaA
         2Xb+o2oh9pHK8S/aU/c3Jioj3a0CxGAzTBno1YFQ+X8A27TQ9xNfrRlmNBXap2Uvpt2C
         64bLn3vMheerw7zTnPqv0SUPAIVGjFd27gqqvzA23OvzIoqHCwlam6lXtAq9qSEkcOQw
         g/0g==
X-Gm-Message-State: AOAM532wTCUbHo9lBEutCxtGlnr0m0KXpxANs4tK7yiz9haHFxckpvAY
        OgMF6dl9v7zPg82ZQUO3ukXKwQ==
X-Google-Smtp-Source: ABdhPJxFUwYBmvc4ArSc+sHfQRinfMCqxuWeu50PVxLOXBo54xgnaNVmCJ1b9zNOYNJaAY91KzqBLA==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr5194556wmj.48.1628169618666;
        Thu, 05 Aug 2021 06:20:18 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id k18sm8797077wms.1.2021.08.05.06.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 06:20:18 -0700 (PDT)
Date:   Thu, 5 Aug 2021 14:20:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: db8500-prcmu: Rename register header
Message-ID: <YQvlkOJKgXoUZHgs@google.com>
References: <20210802080332.3172856-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210802080332.3172856-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021, Linus Walleij wrote:

> Drop the ambition to support dbx500, the other SoCs in this series
> were never deleted and the support for them has been deleted.
> DB8500 is what we support.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/{dbx500-prcmu-regs.h => db8500-prcmu-regs.h} | 0
>  drivers/mfd/db8500-prcmu.c                               | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/mfd/{dbx500-prcmu-regs.h => db8500-prcmu-regs.h} (100%)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
