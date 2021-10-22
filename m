Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D4D437537
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 12:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhJVKFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhJVKFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:05:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54522C061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:02:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so1356712wrc.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nGjT1AOVEd9u+o/+gwUtiVquACHYTgqPaEm19BZqzks=;
        b=nuygEqAjt4hZHvYg383a/4J/0cZ4ltTZw7vuniBg8ryX9BvfLDJfRQ2gdm54CpS/fp
         WI0IWxc5HsFcXCwYOEs3PfD6OlU8t5/90igIK13eQb8xxdKh9ba272h/XHLEunW2QqON
         8k5FG+stAoVMaAVF1zkci0xyA/kS6fH46OlTIUfW3ZgQfrivX6Z5J7Vm+i0LJmdhWQxp
         Z6SJgrsy/4JChXJvK1zLu+rhZ2+VztL/i030CAm9pb0AsG6Dak/22PxRWqSnu+qBAhjV
         dbhY20a8lITwVb6pxD9Vz1QDMLG6YBOJGC/+ljTFH2e1OnZKzr5kq968FqHSPzp4e6J5
         T8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nGjT1AOVEd9u+o/+gwUtiVquACHYTgqPaEm19BZqzks=;
        b=PfHFyW+1Hajd2FX7PVJqnaap5OlZgtO6WNnT/drl4iYsaB2o/Q2F9EhaR7PTJ48gU5
         0M4F09TR/cqNGlxUpxbsD67qwQJnXX/v/JQXCuYlzhJx7Skix7v5GyYR2w2RIWl7p9ff
         NJ2ELDBT/D1PAieufcAyw4yY04M429mYfqGpWq0fuLtu5g8w4OWc63mXexECdJ7kt5sG
         8Ucc6qlGAhQIdGHa+nipHTIZoELhbi+++PyUwy/dl0mZjz5JGy8k4mIWFVeehUZeDytf
         BsdAi9myWHwpnUYQDdvV0jxzdx93m/t6k2GyslanD7oXEZ+hwpv4ikzB1C1ynZwVJYTZ
         hgxQ==
X-Gm-Message-State: AOAM533kUX324/bKvOs+96Js1/WJ3g+qbI3DoUBoReUPHM7xIuACgCrG
        7BDqA2bHGPgRgedqpGqYjkiG9w==
X-Google-Smtp-Source: ABdhPJyU8SPbKWh/ZJVVNpIOCfeScFOeqeql/+ttz0VcR88SMJHnMe2kapfTFYdC+twQcMhJ5DSrVQ==
X-Received: by 2002:a05:6000:1689:: with SMTP id y9mr14340579wrd.52.1634896966959;
        Fri, 22 Oct 2021 03:02:46 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id u1sm782155wrt.97.2021.10.22.03.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 03:02:46 -0700 (PDT)
Date:   Fri, 22 Oct 2021 11:02:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 3/3] mfd: tps80031: Remove driver
Message-ID: <YXKMRFLW/jYbhOiO@google.com>
References: <20211021192258.21968-1-digetx@gmail.com>
 <20211021192258.21968-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211021192258.21968-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021, Dmitry Osipenko wrote:

> Driver was upstreamed in 2013 and never got a user, remove it.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/Kconfig          |  14 -
>  drivers/mfd/Makefile         |   1 -
>  drivers/mfd/tps80031.c       | 526 -----------------------------
>  include/linux/mfd/tps80031.h | 637 -----------------------------------
>  4 files changed, 1178 deletions(-)
>  delete mode 100644 drivers/mfd/tps80031.c
>  delete mode 100644 include/linux/mfd/tps80031.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
