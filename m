Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1972436D460
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbhD1JAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbhD1JA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:00:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F97DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:59:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d11so4326323wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=3tr7oJ/I4GBW3dQsd9N6MocOLkdlrYL11Zt6PMnERCo=;
        b=VEUlQiDTTG6nLe6QdW9EYHrStZYbV/3FZqTSe5WKIvbVjdLqR3wzhai+reTK8MxEm7
         UmDwSCkjPn47YOUdXZ6Iflq9f0L5TezRWkeSxu7sJO7iApvSq49DkEioZjO5jv+7D6pU
         2SOehfPp7FWbFaYSpfJHR4PSdF+vmAtXQgZbm/EQXJQdpeUAw3bKzcNm8T9Fd7U9xd4w
         08tr7StoN8pgF3N3Joejzwl2tB0uOf9uFDNLYosTit1MMcNtC7w2CqswXR4CL+50/uPd
         IDlQrcHWsDznh4HjwU7cdI56FsqKeLrtkxivtxPC70BzJsP8J8jIieAHmzQGRFtItnxr
         BXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=3tr7oJ/I4GBW3dQsd9N6MocOLkdlrYL11Zt6PMnERCo=;
        b=HL4bcOClpSob8soBb+KCi/v3/aHnqj++W4UNIgQLGx8oDSj1axMCZDW5k0aeaLhD1E
         c72Edt5aFykkapknDEvtYXVxuMSyG+ZKcxhMu5Qbsy+W/uvMKWanpqutukhJa2AGc9LD
         rb5Ep9Om12eKLd69I+qTC7aZMirNDOUiBxdwcJHW9AaiPj4UAX7WyEiq1H8ZhVwDwWdJ
         215McQnFC7TsilLhmz3G2rf+4zc/q8wRy7MSyekRXjZXYE5FlvBMTm4hAubglMXTPq+Y
         IuFX30paK0n4GR29YWJagBKhEr25MEG0IuitKVjSOmcRwEJYa+K+Ri1ZnHGzZRSQwSk5
         wKjA==
X-Gm-Message-State: AOAM530tehgK+YtUgKgAW9O9f3kBzAnnDYRj6/BzZdSId6U15CM2UzIV
        oK2Xu0kto3mGKG/i9yUehGYb4Q==
X-Google-Smtp-Source: ABdhPJzlAJWoO384jZbV0wKRxQJtPAwOYggdPy44FOm+l8ZHZGWOQ5gF0t0WoSAmm1v3crSTQgFJbA==
X-Received: by 2002:adf:f308:: with SMTP id i8mr34801890wro.209.1619600382062;
        Wed, 28 Apr 2021 01:59:42 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id n3sm2974405wmi.7.2021.04.28.01.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 01:59:41 -0700 (PDT)
Date:   Wed, 28 Apr 2021 09:59:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v5.13
Message-ID: <20210428085940.GI6446@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.13

for you to fetch changes up to 04758386757c1ef339b18d996976911be61d5efb:

  backlight: journada720: Fix Wmisleading-indentation warning (2021-03-23 09:42:55 +0000)

----------------------------------------------------------------
 - New Device Support
   - Add support for PMI8994 to Qualcom WLED
   - Add support for KTD259 to Kinetic KTD253

 - Fix-ups
   - Device Tree related fix-ups; kinetic,ktd253
   - Use proper sequence during sync_toggle; qcom-wled
   - Fix Wmisleading-indentation warnings; jornada720_bl

 - Bug Fixes
   - Fix sync toggle on WLED4; qcom-wled
   - Fix FSC update on WLED5; qcom-wled

----------------------------------------------------------------
Arnd Bergmann (1):
      backlight: journada720: Fix Wmisleading-indentation warning

Kiran Gunda (2):
      backlight: qcom-wled: Fix FSC update issue for WLED5
      backlight: qcom-wled: Correct the sync_toggle sequence

Konrad Dybcio (1):
      dt-bindings: backlight: qcom-wled: Add PMI8994 compatible

Linus Walleij (2):
      backlight: ktd253: Support KTD259
      dt-bindings: backlight: Add Kinetic KTD259 bindings

Obeida Shamoun (1):
      backlight: qcom-wled: Use sink_addr for sync toggle

 .../bindings/leds/backlight/kinetic,ktd253.yaml    |  9 +++--
 .../bindings/leds/backlight/qcom-wled.yaml         |  1 +
 drivers/video/backlight/jornada720_bl.c            | 44 +++++++++++-----------
 drivers/video/backlight/ktd253-backlight.c         |  1 +
 drivers/video/backlight/qcom-wled.c                | 41 +++++++++++++-------
 5 files changed, 57 insertions(+), 39 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
