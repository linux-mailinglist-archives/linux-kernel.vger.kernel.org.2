Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77BC3496E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhCYQeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCYQeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:34:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A51AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:34:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y6so3157143eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=IHZjGjcwG93Iiom25k9jNG9Fywlor+CHx0u3IjlOi3U=;
        b=vlvmJnQ46DIUjbAYm/ooeFWWmhIECTvZf05lFfizVU67lHn7Q/ZnPTCbcv+7zhOaR9
         r1tVgnvlLbsnIw/Ig1DZO+qcE/xHf70701wra9f13nR6VToGTTE41VlSqfubG3T0ultW
         qz0wFt8IRLHEKmCKo1n2T81vag4p8eftJ9FsNZSm+kAID+Hp/jPQK9JBAzjKHSc9QxUZ
         shOw0evwGGSpqWz99fcpoSmCFeHNLgBDSWPjpH9kHwHX7rufJ2BE47Ve6QG7WeKCqIcr
         lMnjTjFLS2081Q/6CH81AAWOA7hfX5NP8GWSqwoAd1UucmWTW4ZRTHsgWFepF7H+EPO+
         WS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=IHZjGjcwG93Iiom25k9jNG9Fywlor+CHx0u3IjlOi3U=;
        b=JlM6OKder6Fc9DClq8L9qf3OBlvauaNxIzzzqf9IYyE12/z5iNgCPPoMAbA34ryxyZ
         Rm4+JS7XTS1SzZdYf56EdQH4HTechBa1OC3X0SZYfp25cK69dv0qIwQbLK6HSsyO+wdt
         FuEyQxpMEXIbygyjlwFrXAFdGTj4c2RLtKxtYqLt5hW3XlXtgQv+RZlI2X4WdXT9X2rJ
         6S8qUYLA+J9p5eSX1dMYh3hTcGIwYez4FRiH4TLieVKrq/RXmgQ8QMoHgQkGLMYvbZMH
         aheR9FKywcCaN51NDE9EL3RtRZpv0wsQLEUsNEnEHi1hqIgAYDVVKWAhuaX7zt+v0zWa
         ZXTw==
X-Gm-Message-State: AOAM532O6QQK/H52cuLQLw9Ja2F+ufZAe2QH9Yx5m2SFBWwXcJlZIWLI
        dZEOyd251Zp8gKUNbrJHC5AJYy6LLPESvw==
X-Google-Smtp-Source: ABdhPJzTUhYBhwDaIrlGTm+42WMXaSrSrafPKglxDZuPz2tEzbDBRMWAEL+oyqTd1XABMmTFpt5pjA==
X-Received: by 2002:aa7:d445:: with SMTP id q5mr9836851edr.382.1616690040248;
        Thu, 25 Mar 2021 09:34:00 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id q20sm2615889ejs.41.2021.03.25.09.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:33:59 -0700 (PDT)
Date:   Thu, 25 Mar 2021 16:33:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD fixes for v5.12
Message-ID: <20210325163358.GU2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.12

for you to fetch changes up to a61f4661fba404418a7c77e86586dc52a58a93c6:

  mfd: intel_quark_i2c_gpio: Revert "Constify static struct resources" (2021-03-23 09:14:12 +0000)

----------------------------------------------------------------
 - Bug Fixes
   - Unconstify editable placeholder structures

----------------------------------------------------------------
Andy Shevchenko (1):
      mfd: intel_quark_i2c_gpio: Revert "Constify static struct resources"

 drivers/mfd/intel_quark_i2c_gpio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
