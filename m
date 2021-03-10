Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4C933383B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhCJJGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhCJJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:06:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:06:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f12so22363219wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=N4vbXKs7ZJbURzN9BaHYH0I2x/dDDM0xoa3qDCuTQqo=;
        b=E0tggtbIxTWhE0nsjKYhrt9luo08Fu7dmvgy6pT5VOfL4YwxRwArp7itkVIypzv7zM
         wPlLSy2A2W1XKdI5fnwXtABzJFnd8lyDSABUZcG3UgB5O3d7WWhURQ/ckKFkV/6VW8w6
         HTSomeWphrGlKOp/VYxIPe2a+U/ni2iGYdxF9Gh7Q8tjT5pSUrpT0UgXEMEqm4dLabqD
         NUoaESbv1Xg7qyWcxmFUFEdqMg/MVv6EzZ9K4N1wkIjs9Kt8bHAoX9R86Zs42U/fI72b
         rEtQT9dW8HZCCOhHAG6Lkd4wR4J1s0o4eXfFVHix1rSU3hGRO4OeUr67wuudjq6QCHpj
         srOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N4vbXKs7ZJbURzN9BaHYH0I2x/dDDM0xoa3qDCuTQqo=;
        b=jdveBBqJ54xXcUTiBUCKCwD77qav+iI/oA/FZV3Pty97TD+/sZ4uk+RHt1B2sBhm1k
         TXTUXw7N/MV6PIwjMn3M70uDMlDIjD2mHisDZa10Q9pEnnxF+0xuJB/Q1h7m+HN3l34J
         3Dh6OY5Ew57xNzM+xaGdwyVRjP5/seDWCQCJxS3jVSLS+BlOd+wGBDwrlwrWq36r46Pk
         ADhi3yPKh7TrEtawmXEPAWrYvwEhJFzb8Bh1bxkd5YbRb/nVIU3DohqwebupUNDZFAuw
         +PFDO6+j9bEKCW1qnf1Q0usJv67BYVxK0QF7NQI4xpJ5PPwmHM4H5hYSoYoj9I/zktyg
         sBtg==
X-Gm-Message-State: AOAM532zbLsYGLHJBFcNJ8shM271BB5ibmpoabpgSIsR1fNdJn1/ZM+T
        EWMahneg9EPqrrRc8Xh9svEey+h8ALIPug==
X-Google-Smtp-Source: ABdhPJyfbU3j4FXTIzXwazFxh47rBt96RubkMP+WEmnJEr/EeESzflGVfZu8RZd3rGoxoUNH30vJhg==
X-Received: by 2002:adf:b313:: with SMTP id j19mr2348335wrd.188.1615367162112;
        Wed, 10 Mar 2021 01:06:02 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id s3sm1950721wmd.21.2021.03.10.01.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:06:01 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:05:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next RESEND] mfd: ene-kb3930: Make symbol
 'kb3930_power_off' static
Message-ID: <20210310090559.GI4931@dell>
References: <20210308123147.2340998-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308123147.2340998-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2021, 'Wei Yongjun wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The sparse tool complains as follows:
> 
> drivers/mfd/ene-kb3930.c:36:15: warning:
>  symbol 'kb3930_power_off' was not declared. Should it be static?
> 
> This symbol is not used outside of ene-kb3930.c, so this
> commit marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Acked-by: Lubomir Rintel <lkundrak@v3.sk>

This should have been a Reviewed-by.

> ---
>  drivers/mfd/ene-kb3930.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
