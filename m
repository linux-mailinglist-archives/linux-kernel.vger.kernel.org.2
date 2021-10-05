Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA8B421FB2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhJEHwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhJEHwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:52:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7F4C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 00:50:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t8so35800448wri.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Bs9eBxHEnrps6X8s9shbbXuQ9tVCujgCc/WLBhtAzOc=;
        b=msLaNoizD3FyAm4YK1jl5AFyjcPRgLwLfWZCwkfhlsMUSOh1LctzNHzxTYpsjmNc8g
         G8DwjX5vbGMSfk3JMUDHL85oy6y+uAEdlGerh4zEhVKiJVQg/2HQlXE8Y76Wdtk3K2KV
         ymofaW7LvT8kd9xGocT1ZFGEZ3//s9z5M78Q8GAcwQfSS/QG/mZpeS/yXFiJGwwyPJeR
         +l0+gqVjjHF6ysafFP5WNOysQ0mucLHCSguTfCLxfGV+TQL1XzWqlhh4aTZgF9Pukh92
         HefACn8Rso41ylKwjNUBm+KSkcBJeBR9rLSx2wQ0m8HkkfhOP+A2jYmUEy3jl2zXNTjl
         i3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Bs9eBxHEnrps6X8s9shbbXuQ9tVCujgCc/WLBhtAzOc=;
        b=cLs63Z/22JUaLiidGJNZsSd5uJEAZgUqk6+Pgz135aWmeQ0ELHY/+PkoIwiw+oQqKd
         rMlmW/+NrLqfgVIiYOpeqnMmuhV3Wjh3ZwHMDSmqGEFLIpe/jjNKucNIWAiWK6MWDOWv
         ecFtFlPkZ3A8jKBnQLCjTSxMGa+WMnP3eMibX3sRxWZOZ/Z0089TAfSxnL7IcYu0BSJ0
         0+3wpvO7HrBvZk7d/O201WXnQmCBPptc9sP5HYwjv9p67a1u9lunRlC4e3QSviMvR68v
         EwZyKuTFaZ8xuOu/TJhiNSkqIyu/JbgP3qaBGZCtRDhcFSwV+r0XNgVOibQbTed50KWx
         ZAlQ==
X-Gm-Message-State: AOAM530N0WTSaK+Pp3V1+BmFYnSJKWy/i4Sw1L8fH0YzJnXgdq4c24N4
        NKXXFp7tCNq/wDvuxKx3GFuBYUBV7RclNA==
X-Google-Smtp-Source: ABdhPJyvwJNebP35f21WqQpV8sB/wnOeIROhBJJ5ob7RtpFjxUns4QRjyTcVUaiymlMk98QONlSD0Q==
X-Received: by 2002:adf:906a:: with SMTP id h97mr19135236wrh.220.1633420252688;
        Tue, 05 Oct 2021 00:50:52 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id e5sm16707940wrd.1.2021.10.05.00.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:50:52 -0700 (PDT)
Date:   Tue, 5 Oct 2021 08:50:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] mfd: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <YVwD2sPZMCtwP9yf@google.com>
References: <b6102d6db357ebb5c937f460a564c6f26281e403.1631709890.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6102d6db357ebb5c937f460a564c6f26281e403.1631709890.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021, Mauro Carvalho Chehab wrote:

> There are lots of fields at struct hi6421_spmi_pmic that aren't
> used. In a matter of fact, only regmap is needed.
> 
> So, drop the struct as a hole, and set just the regmap as
> the drvdata.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/mfd/hi6421-spmi-pmic.c           | 16 +++++----------
>  drivers/misc/hi6421v600-irq.c            |  9 ++++-----
>  drivers/regulator/hi6421v600-regulator.c | 10 +++++-----
>  include/linux/mfd/hi6421-spmi-pmic.h     | 25 ------------------------
>  4 files changed, 14 insertions(+), 46 deletions(-)
>  delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

I intend to take this with a Misc Ack.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
