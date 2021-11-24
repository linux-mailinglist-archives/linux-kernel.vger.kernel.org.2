Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D845C929
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbhKXPxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbhKXPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:53:04 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B50C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:49:54 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso4392704wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LOAzwgeaBxO6I85fZqEHMuxRjJsXSDSbNgLC7hgDJMk=;
        b=ZK6mVZtnF5dUw4/mZ3AMlAFR9wyeS1c8K7j6sUVHTxWYLfqKN5jnKxAqJDZxH2MB2U
         EZd57ZJJlklOTxfRByuMq56CF5EGXsDKuc2Hu6THpbb02DCcubc1fhg3K5KHkeLH2Y9j
         4hx3eiT1thLm+Sm2WczikAksElDVep7uiOSaPBqdDwKPt2/yjanQDJG4okkivrOlMNfh
         4U32H3gQv3gayw3kF7GOhAccCIYZI4V0EkXO67ruDika1vJu5nPU2OsOgcz5icu775AA
         pPW9Qv/rP9X78C3m3a4UuIBpXGcj8ZEjxY59F7LAkud2e9/ZfAYiYMcsAfmux3j798tX
         BDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LOAzwgeaBxO6I85fZqEHMuxRjJsXSDSbNgLC7hgDJMk=;
        b=qRioJuPtsH5esF+a/Ipg1H//RBMGn3hx94gM+AVVHMQiGX/rDfVquRtH84EpGyO46A
         1YiMvjqc7fxIlqfTJINDmOcCMyEU4sNwLOV6EwgE0PJvXxZqkISwUBzHGB0P9Hmz35Bc
         3DGQ5AoMS9zyb2oI2tjk2WRI/A/fNvOzT70+z6djj/zKMh6DtA40Lp/5xrVQ5piBT0bL
         Db2ohcLghU8ZZWMEPOog4bfa2BJWo2ONPU0AcVNpijhSU0g7W9TfFR3oB/jFOENSvNlp
         EnNAxggOI337DWIeDhRClZA1UIU9WJS5/uJUpPSX9IuB3SQm7hnfyvCbkA5zVRnUsiwa
         qdwA==
X-Gm-Message-State: AOAM532cU4wzfUZ0raLaKxcSqexE+0L5N0iC7twGGDAznpJjNQojhTqL
        zoEWkfWTwGLHZdaP5o9b0Q+XfA==
X-Google-Smtp-Source: ABdhPJxsoYpx10GoqhLm7/pLA9ESZB+94k0wYbt9DHYNyHnuNHjLa3HDoYgcq+VWCthjT7TcTGMdow==
X-Received: by 2002:a1c:80c5:: with SMTP id b188mr16791379wmd.57.1637768992772;
        Wed, 24 Nov 2021 07:49:52 -0800 (PST)
Received: from google.com ([2.31.167.61])
        by smtp.gmail.com with ESMTPSA id d2sm77738wmb.31.2021.11.24.07.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:49:52 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:49:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     michael@walle.cc, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Select MFD_CORE to fix build error
Message-ID: <YZ5fFG5CKv2vyWJI@google.com>
References: <20211102100420.112215-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102100420.112215-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, Robert Marko wrote:

> MFD_SIMPLE_MFD_I2C should select the MFD_CORE to a prevent build error:
> 
> aarch64-linux-ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
> drivers/mfd/simple-mfd-i2c.c:55: undefined reference to `devm_mfd_add_devices'
> 
> Fixes: 3abee4579484 ("mfd: Add simple regmap based I2C driver")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

In case you missed it, this patch was merged in v5.16-rc1.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
