Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2763F297A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbhHTJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbhHTJuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:50:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DFFC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 02:49:42 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e7so8598961pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBo2auMf6j+mtaOtkAHIvSZjkC64wCOzPc0CNYPDet8=;
        b=HO0QZlwZVXjarhtIjOG3pFV82nAwbnA+JDssg1OnVgASe6bXZFmkIf+ZwoiSvilUdD
         rSis6OluMFftfdVAyt3KKBPvSKHBoIpOgl4SDtFjfl+WDfHupRjsgjX1LmHd0hzA0v6X
         +aL68qZHSRzNtFV6z+NTqLDz3NGK5moBXEyVHJK4QgCdrAT5swjTTBvmgD1V548nU53P
         kSyAOstNMpATw5kLcdNx8VOin2fdykb9VEQ5wrfy1qEmeyn5eXpG45Zx+wz2IlmsxpIG
         oQ8hE3cqY3TzGpuilhp2qk6yEtrUb+ZPbTVlULF0+JpCP93mMo355BqhoVaWRqAByq4I
         JPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBo2auMf6j+mtaOtkAHIvSZjkC64wCOzPc0CNYPDet8=;
        b=DhxrMU5i2jlopcun53KZiOMOy9Jwtu7FLI3xWV8QeluigY7fgrMuj8+vDcVHPBOGun
         VM3PfrQE47sfVUGLZ6YcB+gMq4LUkUrBFLH2gFJ2wWi18kSBcfwjCR2N0HbU1M4veEqd
         mHMYVtFasXMZq612yqSfo1+6QLOOPUOy0TMlLuHEYRw/Ia79FkOt5UEFQcxwWGleqCbW
         BY58byMmDoq1JjzhXHctH/PPRLyu7zE4+bAHreNV9oOdG2CPCoAtczQaVEJeWamJEKHt
         kGZEcuXGFjnhYACqigoBykefuXIAnD7hVqKSCHkFSIv6yMTywKSBn/4a3s8ri4SnsJYo
         7dYQ==
X-Gm-Message-State: AOAM533NPbvsdjFusc9qmiGUpgTV4K6AGC10OcEJHfjjB0U4iIAl7Rv0
        JUc64+Z2Aht5Qj72PziaWhU=
X-Google-Smtp-Source: ABdhPJzfmyh8zVg/dE0szgMj2njjECYs5HYmu5hssWiD0bDKz6fpxtoZLN3/Y9kwRwc9rz46o74xFg==
X-Received: by 2002:a63:4b5a:: with SMTP id k26mr17745995pgl.241.1629452982038;
        Fri, 20 Aug 2021 02:49:42 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a4sm4955172pfa.203.2021.08.20.02.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 02:49:41 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] Add module build support for timer driver
Date:   Fri, 20 Aug 2021 17:47:28 +0800
Message-Id: <20210820094731.1890536-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patchset was based on the previous one [1], and add a
boilerplate macro for module build purpose according to comments
from Thomas Gleixner on the patch [2].

Also switch sprd timer driver to use the help macro to support
module build.

* Changes from v2:
- Define one macro TIMER_PLATFORM_DECLEAR() to replace the three ones in the v2;
- Use builtin_platform_driver() to replace module_platform_driver() to make sure
  unloading timer modules not supported;
- Add more description to explain that unloading is not supported.

* Changes from v1:
- Removed TIMER_OF_DECLARE() from timer-sprd.c, and removed ifdef;
- Rebased on v5.14-rc1.

[1] https://lkml.org/lkml/2020/3/24/72
[2] https://www.spinics.net/lists/arm-kernel/msg826631.html

Chunyan Zhang (2):
  clocksource/drivers/timer-of: Add a boilerplate macro for timer module
    driver
  clocksource/drivers/sprd: Add module support to Unisoc timer

Saravana Kannan (1):
  drivers/clocksource/timer-of: Remove __init markings

 drivers/clocksource/Kconfig      |  2 +-
 drivers/clocksource/timer-of.c   | 30 ++++++++++++++++++++++--------
 drivers/clocksource/timer-of.h   | 19 +++++++++++++++++--
 drivers/clocksource/timer-sprd.c | 17 ++++++++++++-----
 4 files changed, 52 insertions(+), 16 deletions(-)

-- 
2.25.1

