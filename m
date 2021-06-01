Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202433975D2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhFAOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:55:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E6C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 07:53:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so2094351wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W2kyomq6HBL5TPAwM9hsMfHIspmq5b2l1+yMyreGJzo=;
        b=TEg21JhDUFVCafPPe9rtcG74SEu6TXV4OvdopaJQb+OjnboON7V+hy3twxJEL6EC+Z
         guj2+clNdkKivngAf/yeFgN554G9qcTO5VkztWsgQ/jJLrqTFvTl2UHZzBqrjM2EvVQQ
         QI/QyjvLkTsvaIVEWfLQcE6VVxHQ2jBq0J/ZuWmEg4w0kYKHsRZ+/ienMfT+etUon2tY
         6/h7i1V+YyLqXL16T9wBklzf502S2w9eoB04VN8uUUwu+Rj/eOTqRmMo1bEPPIoPtu+k
         xwOIOWyWxR8YUqFtjjE0yx/Lh0Heb49GqDNfUc8ahMJBqzwMHlasq00y5B9mlutSVzJb
         uHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W2kyomq6HBL5TPAwM9hsMfHIspmq5b2l1+yMyreGJzo=;
        b=I3/mezy9Obo3RO5NoC0g2WrKFe4wjTNst1/P3TMV6JJnVWiyfyf3ExAoXFkz17vfOZ
         BY9T3OF0+/8eyk1zBtpdpSJfI8TyzJ0+mC0qfBhcykcLL/l9QoSt1TdkuLZVKM/3mkuk
         kkNh3MsCwmT9aFEMwkd2DU/qNVFuTh9jy6oOa1wsxxGISOXgiG73Qf1OCNJfROnuUaU/
         v4hEXyTaf/ps9jbI2S3gPXuSgXhb1garp4ZjxMVBfXd4a0dOY9kt3lTMQPlv6OTwRiEK
         F/iSLtcdssNG5WNgRutvKVM3KOLZhDqwRZjmYv3cWuLfzoK/VPHdukgQV3/4kxgR1OL/
         JP3A==
X-Gm-Message-State: AOAM530X7yA6vm9yfCJjWhnJLR3WdhYXWiW0iOu+GQtTvtAFExkNWvL7
        KRD14p8PAQs8eMR6IX4t7O4t1w==
X-Google-Smtp-Source: ABdhPJxnBgbZtAB1MlRP6uBEbzjBrOwMOwCbmGXHa+pkO19wrKIRJ28Pumactjmp/3FqEjyHVYLdBg==
X-Received: by 2002:a05:600c:2284:: with SMTP id 4mr12558069wmf.146.1622559201249;
        Tue, 01 Jun 2021 07:53:21 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id h15sm18681785wmq.1.2021.06.01.07.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:53:20 -0700 (PDT)
Date:   Tue, 1 Jun 2021 15:53:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] mfd: arizona: Allow building arizona MFD-core as module
Message-ID: <20210601145319.GL543307@dell>
References: <20210521135023.192688-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521135023.192688-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021, Hans de Goede wrote:

> There is no reason why the arizona core,irq and codec model specific
> regmap bits cannot be build as a module. All they do is export symbols
> which are used by the arizona-spi/i2c and arizona-codec modules, which
> themselves can be built as module.
> 
> Change the Kconfig and Makefile arizona bits so that the arizona MFD-core
> can be built as a module.
> 
> This is especially useful on x86 platforms with a WM5102 codec, this
> allows the arizona MFD driver necessary for the WM5102 codec to be
> enabled in generic distro-kernels without growing the base kernel-image
> size.
> 
> Note this also adds an explicit "depends on MFD_ARIZONA" to all the
> arizona codec Kconfig options. The codec drivers use functions from mfd
> arizona-core. These new depends are necessary to disallow the codec
> drivers being builtin when the arizona-core is build as a module,
> otherwise we end up with missing symbol errors when building vmlinuz.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Add explicit "depends on MFD_ARIZONA" to all the arizona codec Kconfigs
> ---
>  drivers/mfd/Kconfig        |  2 +-
>  drivers/mfd/Makefile       | 14 +++++++-------
>  drivers/mfd/arizona-core.c |  2 ++
>  sound/soc/codecs/Kconfig   | 10 +++++-----
>  4 files changed, 15 insertions(+), 13 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
