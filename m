Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9423E1409
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbhHELls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbhHELlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:41:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0124C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 04:41:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so3469186wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Iuum44OzvR9ycCAX4BpM1UbEqcs3DCbieLX3GdwCJ7A=;
        b=fmUu+n9ca6VA1AD3nnwh9IZvf73jglPzQzAAPiRA3w32TNb7j6mzgVCxS6itWg8Tpk
         HNBF5RzW0wW7APRwIyE5ywHV5JsB/ZuUochSK+qUYWwm8mki45HZVHgCedVXmNRViakE
         8mRRbVWbw4hiOJ1Ky3901ySZoDBQP0TqNWmERSMLVic5pc4F7rrYKCPDaIe6CAlmfwUh
         ujhIN3TyE+5OEy98H2O9+YnbR6UBndrhUUTS2ri5CsYfZx54ugGMOUT579LnXB40Trn3
         UMK/JKhT5npTjbe17lJ11SQh1PVKvFhhj8yiRTar5GKohyHsDPN0dPGhJXgjBiiuhXSB
         G/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Iuum44OzvR9ycCAX4BpM1UbEqcs3DCbieLX3GdwCJ7A=;
        b=ubpyuwpo3CeLSSKcE339SSaVr9nH1T4qNF225cf/sln6kvqXAmv7yaFqcD5TB9Mo9f
         869TMp7dFOMyh81DT6+YtruaZJocRS3n3oJRtjtt9diXMjVibfACq7ZtgGlklc7pgPOK
         e0/WNsZo7nj4zgc4yGgYgxFKSoOuubJk0Px2Hp02VmW+agOo6GlPS2zh0uywlZK4RucD
         9VjKz2Zclp9qHDamNKsbt/dhrKB6OuSoV2GWdIR3f+0yv8++ZnkcFEF0zVwhqFXIBtXn
         8QIqAo7t5iPRSbalucwX3uM3i4EAlgR/4u2FqKASRNFbpx8VMVpp/rF4SRw7+4pwkoS9
         2o1Q==
X-Gm-Message-State: AOAM532EoJoxSUhd8a+cS/LtE/AAvV1nogCQS5w3jRRBmDF3wT2d+G8C
        5zHB7XHybYN80hrqGgIDuA+Xaw==
X-Google-Smtp-Source: ABdhPJxDpe81xkZHcO88t/nNAWNlYt5FvkoiD5WNJe/wa5mC/XokgWoYCO52De2h0BU5xEMZDJtuRQ==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr4693888wme.31.1628163690246;
        Thu, 05 Aug 2021 04:41:30 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id f17sm7094599wrt.18.2021.08.05.04.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 04:41:29 -0700 (PDT)
Date:   Thu, 5 Aug 2021 12:41:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH] mfd: Don't use irq_create_mapping() to resolve a mapping
Message-ID: <YQvOZy48/DBzA5ao@google.com>
References: <20210725180754.250163-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210725180754.250163-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2021, Marc Zyngier wrote:

> Although irq_create_mapping() is able to deal with duplicate
> mappings, it really isn't supposed to be a substitute for
> irq_find_mapping(), and can result in allocations that take place
> in atomic context if the mapping didn't exist.
> 
> Fix the handful of MFD drivers that use irq_create_mapping() in
> interrupt context by using irq_find_mapping() instead.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/mfd/ab8500-core.c | 2 +-
>  drivers/mfd/stmpe.c       | 4 ++--
>  drivers/mfd/tc3589x.c     | 2 +-
>  drivers/mfd/wm8994-irq.c  | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
