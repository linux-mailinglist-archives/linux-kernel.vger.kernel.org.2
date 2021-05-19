Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5F8388E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353412AbhESMhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbhESMg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:36:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:35:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so3230338wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y06vGdT7AQw6M4ZhpKji87og+cjxY+tkZexuVa+ZoG4=;
        b=jedgLjhU+jYdGWkBJjREpVz8Epa64b2E0r26n3C9IkindLezudF1M2vGf+qJkHPwUw
         oLpRqo5vgEKHjR61wueSA4IdZtD7f1E9MA14Sw5HUywUYxmdbakLtdpcsT7sLx7e5vKS
         e/wQBMGUd0HhPRKf0attdUvLB4ioA/KxMA6cF5JSnn40KoUsZghis4atbZ+WdEbpa95R
         BSChsQSUL63XHK1rOuNzrTg1+H7dOJ5uUytu7CDrF8m+LdsmezVDoAP+P+TSBycawRmZ
         p1A0tu5VAMEMH8vlAS0xrelLDsWznfkvXWyEHOKDqgshm5uFt9OihQe17sy/npvzpT2z
         5bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y06vGdT7AQw6M4ZhpKji87og+cjxY+tkZexuVa+ZoG4=;
        b=sGwM+O1MUq9R/yl7f9psjecA0cmt7+ZW4c1TitWTetc4pSYeCoyQ803uCvS03M592u
         l/oo1DoFSnJT29dUZ6aJWryJDElmC4hBF+xn8jlm7LCMMMYDCUVaRd8RwhLOgxb2Ry9V
         gsAkVt7ES5x7NYeUj3n14lhU+mA75399N5ncyw12XdEMKrrr7IOJTjaNFcLCkblHwKIG
         yLeFAKjMK+cJP9XmNRGtU+8F7oUUZaWgKjJVcvntfYqoyLyTjWuyjrMXHAZg4i9u1uNN
         5WH1P+ka4q3AC9jArG4rstyNiOD48C1+c9UoguacCRFVv+pOwfEHhXpqPDA5205AMt3P
         OEvw==
X-Gm-Message-State: AOAM532Uo+nwWfubG7GbyH1YpXzwoYC+i1ImfN9xSaqEiu/COGd0KHOv
        F9ytYHLlGo2scXHb/Bb1wQryGQ==
X-Google-Smtp-Source: ABdhPJyZrzJbg1BoZs327JjPOVbrj6yyB6CtRKk7wrTf0N0Rjv4goRayAA5SnYYzC8KCLsIDaC7zdQ==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr10929801wmc.105.1621427736921;
        Wed, 19 May 2021 05:35:36 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id b10sm29997220wrr.27.2021.05.19.05.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:35:36 -0700 (PDT)
Date:   Wed, 19 May 2021 13:35:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, GPIO and Regulator due for
 the v5.14 merge window
Message-ID: <20210519123534.GD2415519@dell>
References: <20210219223910.1831-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210219223910.1831-1-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tb-mfd-gpio-regulator-v5.14

for you to fetch changes up to 5258f7eed42f4565d065726fd82d3430dd618a68:

  mfd: lp87565: Move LP87565_regulator_id to .c file (2021-05-19 13:34:00 +0100)

----------------------------------------------------------------
Immutable branch between MFD, GPIO and Regulator due for the v5.14 merge window

----------------------------------------------------------------
Luca Ceresoli (2):
      mfd: lp87565: Fix typo in define names
      mfd: lp87565: Move LP87565_regulator_id to .c file

 drivers/gpio/gpio-lp87565.c           |  6 +++---
 drivers/regulator/lp87565-regulator.c | 11 ++++++++++
 include/linux/mfd/lp87565.h           | 39 +++++++++++++----------------------
 3 files changed, 28 insertions(+), 28 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
