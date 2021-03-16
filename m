Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC8533D13E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhCPJ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbhCPJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:56:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC7C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:56:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d139-20020a1c1d910000b029010b895cb6f2so1061741wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8RGvMB0vE58IY6FLA7y4aPwQYgLDG3orhH0vIHasF8k=;
        b=PTQ1R7AXaieU3pD3JfMFjNtFz8rmzGOeVsCYfH4F9MW+Chn8RGr8RmpXHhysx1sDIr
         pw6Nom9IxucJ8sAX19OP/YLgKiAMofymWJu3UNPZO5cNONSHnnFVu5CJ/QZ+pRJvrqt8
         DHPr7QH+SK6jB7m47nZPCsmktzooxzEvzXB2pOio+i+HeK+Ud4NJv+7YuxJUUAYBPTEW
         j54r/GnxP5btJWX99y+r3p33HLwR8xIhjJg+xhNP1MrHdm4MtVj3wAR9rBwyqnddXKDO
         zd9Aqgx+eP1zu+xQgyyvHHazup2aOO7ZoRUAn9Dbw21+eLMkc9LPk0lsQIJgX5EJ/R9i
         q+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8RGvMB0vE58IY6FLA7y4aPwQYgLDG3orhH0vIHasF8k=;
        b=DJoRfTmvuXmtNrCmWVbQ5piqwOOgQzxaeTfmByFUVO8JwgHFcyZk2/QpZXBH1f2yYS
         Y7DvToaqsIkmcHH6xXPrX9ncGd8sEjjdWWhyk2HtIVhFH+nQI1Qu/BaSFyGmzhGjXNNT
         9/7wQcMCz1AgaCHPsRplnEuWJR3fmn2vAzTYjTtAkYv1frSorfSyxSOwzgw9YJBa2kHt
         PQnN78D2NPhel2Gi0S6fEP7VFxTDBWBpd1ycYf50e35TLAZb4VwGpL+PliFp6uFYJ8B/
         7Yg7Z3/RDyko1Ce8t66gZZgjopIZFuW+2n1ZXC7U0EynfmtbUjq3V6TWKa7WNQkafpYQ
         ZwMg==
X-Gm-Message-State: AOAM5322auoHIwT1UKYfZvphSkoVaTvX9gbHYQjDMJd6avDAJuzB87ZY
        qwFFPgkU4PF+I/nCC8KB5L1VZQJ1WlO1wQ==
X-Google-Smtp-Source: ABdhPJzUXnZC1sxTX9lpFfLiccKmdbMykVgQ2iLk7D/x6tyP+qkuEnLM2hpWOyGgPau5+XAMCX8o1A==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr3855858wma.188.1615888564145;
        Tue, 16 Mar 2021 02:56:04 -0700 (PDT)
Received: from dell ([91.110.221.243])
        by smtp.gmail.com with ESMTPSA id s83sm2632058wmf.26.2021.03.16.02.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 02:56:03 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:56:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH RESEND v4] MAINTAINERS: move Milo Kim to credits
Message-ID: <20210316095601.GD701493@dell>
References: <20210316081000.12596-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316081000.12596-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, Krzysztof Kozlowski wrote:

> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Milo Kim's email in TI bounces with permanent error (550: Invalid
> recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> credits and remove the separate driver entries for:
>  - TI LP855x backlight driver,
>  - TI LP8727 charger driver,
>  - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> 
> ---
> 
> Dear Lee,
> 
> Could you take care about this patch?
> 
> Best regards,
> Krzysztof
> 
> Changes since v3:
> 1. Remove the entries as Dan Murphy won't be mainaining them.
> 
> Changes since v2:
> 1. Fix subject (TP -> TI).
> 
> Changes since v1:
> 1. Add Dan Murphy, do not remove the entries.
> ---
>  CREDITS     |  3 +++
>  MAINTAINERS | 23 -----------------------
>  2 files changed, 3 insertions(+), 23 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
