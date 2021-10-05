Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D38422012
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhJEIFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhJEIFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:05:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50461C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 01:03:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o4-20020a05600c510400b0030d55d6449fso2177402wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FMhGY7C4erACOrtNGWdyPG3fPCsKUPZ4ssc9loYl6pM=;
        b=ZoeMflsFYVySlgWgIEjG/K1qmzO3CDj7gLY+OpRpCjf6EZsMIIRlB9/vyDlAzkNm5k
         Wncvqw0RT8K4uC5ipSSyBuZNxVr+bG3/1WYl+Oed7iQarvJlcLJchWUqIdT0/Kl9euZs
         Zl4YuEeGG/zdA8SPk7Znn7BEUO9GGMwl5PGyoLYKU9RnCDqI3DuZqmQaL2iXPnCUNajO
         BILj3AX2PC5sOmRtjvFlUUhE0gLhzW5OUik6szQbAwZDZ4769VQKzn980Of1/ba6Jytl
         8AMeNQCAKUhJfnx8DdM2C+NLCBosxm1YkJDIT/F1NxqPnjQvQZF0fzP8eCR6PlIE9lr5
         vfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FMhGY7C4erACOrtNGWdyPG3fPCsKUPZ4ssc9loYl6pM=;
        b=nNJjRCLGG6iFmTtIbydUYlMqM8GgeWCx6epDU93AXAWxQrporY4J1BIJOH1ngqpKHF
         ZRSOtEV1Y0A9VBwslAAzlaqCjtdsTQa9uedxHTlmxskINPQqfWyGF8CuGkf2/E9viQel
         tSZ18alb/7tK3oZyb5nXQJfx6uwPhjrRIuYGcCOhIecmDehXzrEaekXaetT/t1uVExVT
         xo/5i+JYV6eeyusYMhKaN5X/5QDZFKt1/9xN2+TGwiPsSMzhyG4sVOvy5uWLwD5FieJI
         fGs2M7Mj7GQRANd4nopgP/k1C/+ZywJD+iVJ55U2+M0CvhxXNqazajyLJH1QGYaRx4aD
         Nm2g==
X-Gm-Message-State: AOAM533133292vEiV9K6wH5zYhEEjwvsjAf2gf0C3BgVZxgDJdUClt1K
        ZIV3qepw3iDVp1w+X0Osk7Bouw==
X-Google-Smtp-Source: ABdhPJwH+SL83NXNyv9pNPnnhhHVpHp2yakF3NjqgwRt6yZWZwnCko0+0kNYtrvEbNE6LVA0xb5fZg==
X-Received: by 2002:a1c:8054:: with SMTP id b81mr1907961wmd.87.1633421027875;
        Tue, 05 Oct 2021 01:03:47 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id l124sm1009147wml.8.2021.10.05.01.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 01:03:47 -0700 (PDT)
Date:   Tue, 5 Oct 2021 09:03:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <YVwG4RhXKCPuB1Wp@google.com>
References: <1828cb783b1ebca0b98bf0b3077d8701adb228f7.1630586862.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1828cb783b1ebca0b98bf0b3077d8701adb228f7.1630586862.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Sep 2021, Mauro Carvalho Chehab wrote:

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

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
