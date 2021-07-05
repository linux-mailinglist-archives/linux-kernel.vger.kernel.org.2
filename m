Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C803BBE35
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhGEO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhGEO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:29:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AB7C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 07:26:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a8so10633412wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=HH55LBpZyfX0xom0Xy0NfYjuUSiqOKT6v4NTwAPCdnk=;
        b=cf6Nkbg8/mksGpX43D+HpQX/Mxh9s1vlsI8hgkqOTCwm+Ouxinp22HhlWX1yH2Qhs/
         gUXckvLrU7klh6TWd04PlsifXwG/T1PYIIxAQVumxd4HbWxC1k0VitYkxGMVkB3jW8GO
         2a17//B86HvMoYioUOyPh6oSC4jq32qLqAmmwX8jPi3M07U4dR8D9q3Zh5fGUI+1bjvs
         MH6AFgJGt2aKqiGLPlRP7P+Ye8ZcRjNqskqZA1EYyVzYuNfkylcfzYZ7zpTk3/mYZS32
         WllKGvMS7JMp8siZN1m6laac1TrAUk3Mmwid429iNiVWDlQnFcnKqFYGXxNQ/ER7INv+
         xHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=HH55LBpZyfX0xom0Xy0NfYjuUSiqOKT6v4NTwAPCdnk=;
        b=GdalJRsw3RVooDhXG0U0yk5q9B9Q8CIEVtJd+0ay61RLDs6PGSehz18rJrHWzvROs9
         Z42gyOeCM6t7wbOp+Q3zi6o2BXKyL1NfnBMKrYspsSUgT0T+gPdvo5O7evcsTJt8sxSv
         wxrHvI10MVGqF4COrr93MtqvWCkmVvyb7cyKIqLmoUrhnrY8tAISqkBdtP9hAw64/Vw7
         etcNH80ZtvKZeX9mAYAQj+zakKjVC5xZiWrfeWeuHzcI93r/GJ0ibfyUxWi5b2kQoDSU
         c1CCkEovCm+rL0vMLzOmJxTSgT0I82uIKEyAeKRtSnvXfKl5ACzXGAacoFPmC/bLmF+j
         ww+g==
X-Gm-Message-State: AOAM530nzOvs9keTdOwKxaorgQ1sayIpRmYa+BOPp5U+jZ8Meb6YvWSO
        HqisvVAaH9FCi5AI5+YDM7uUPpE510CWUA==
X-Google-Smtp-Source: ABdhPJxJu7oeSE3Wb66alh/ZjB3W1i8f7+TxigBaXH9fjgEMtTdmYaPv672RvZ+ZiGtfQG1lrdV1cg==
X-Received: by 2002:adf:e588:: with SMTP id l8mr15834581wrm.208.1625495195032;
        Mon, 05 Jul 2021 07:26:35 -0700 (PDT)
Received: from dell ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id q19sm21954890wmc.44.2021.07.05.07.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:26:34 -0700 (PDT)
Date:   Mon, 5 Jul 2021 15:26:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v5.14
Message-ID: <YOMWmKay/ETTkvkz@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.14

for you to fetch changes up to 1181f2164135d770bdad297290b73d274787389b:

  backlight: lm3630a: Convert to atomic PWM API and check for errors (2021-06-22 14:11:37 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for Richtek RT4831 Backlight

 - New Device Support
   - Add support for Qualcomm PMI8994 WLED Backlight

 - Fix-ups
   - Device Tree adaptions; richtek,rt4831-backlight
   - Trivial; spelling, whitespace, etc; Kconfig
   - Use Atomic PWM API; lm3630a_bl

 - Bug Fixes
   - Fix Firmware Node Leak in error path; lm3630a_bl
   - Fix erroneous return codes; lm3630a_bl

----------------------------------------------------------------
Andy Shevchenko (1):
      backlight: lm3630a_bl: Put fwnode in error case during ->probe()

ChiYuan Huang (2):
      backlight: rt4831: Adds DT binding document for Richtek RT4831 backlight
      backlight: rt4831: Adds support for Richtek RT4831 backlight

Juerg Haefliger (1):
      backlight: Kconfig whitespace and indentation cleanups

Konrad Dybcio (1):
      video: backlight: qcom-wled: Add PMI8994 compatible

Uwe Kleine-König (2):
      backlight: lm3630a: Fix return code of .update_status() callback
      backlight: lm3630a: Convert to atomic PWM API and check for errors

 .../leds/backlight/richtek,rt4831-backlight.yaml   |  62 +++++++
 drivers/video/backlight/Kconfig                    |  30 +--
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/lm3630a_bl.c               |  54 +++---
 drivers/video/backlight/qcom-wled.c                |   1 +
 drivers/video/backlight/rt4831-backlight.c         | 203 +++++++++++++++++++++
 include/dt-bindings/leds/rt4831-backlight.h        |  23 +++
 7 files changed, 335 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
 create mode 100644 drivers/video/backlight/rt4831-backlight.c
 create mode 100644 include/dt-bindings/leds/rt4831-backlight.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
