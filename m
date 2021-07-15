Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B60F3C9938
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbhGOG6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhGOG6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:58:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED608C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:55:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso5468673pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+UkBm5t+E6hjsyMIIxKcjrTMIbJU8ZfaF4S1aVJ3q4=;
        b=fy7MDi3XGdK0wBXT9skLcFuKLIEwNF60I+3xMVR6Xd9F8fg5MRufHjpEBlItqfVOxI
         MCmgoatTTdp5t5WJi9E5JuHppO6GXxrUXWhmcXixGBgh6vben0Fc/1+xEZerWTbc9Ju2
         3+FRoJimcwa3/52tQGBl+0PEP84F2y4gI6vfZTw2y9C5foBPkXU/MbPkILf80GLsdRwk
         wfaKZQwyksoVI373RB+LA3FL77HjmsqY5YAuBEYA1v/LJz2/78Y4siXl6ECw6elCVBgi
         BMtzMST+ppquGNhf/YypD3PfqtcaW5+kPB9fonfP8u5xB8SCVq9pUoYqRURstOzQG5Ma
         1/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+UkBm5t+E6hjsyMIIxKcjrTMIbJU8ZfaF4S1aVJ3q4=;
        b=qDjPco1cnxz/MzH0Yqz4r1tcBXi7gUbeDL2zcIE5Kp3ZIqrosIQKeY8mT+mAKoeIcU
         VOLqXAYarSauBMdA2LOmv58pheQLYNm0pdqveJ2OSa7aFZimaU5syIZcJKbpXpg0J2IR
         sjZ5zvwg9eA90t7rKj0RxyY24LtIFHR9Sab66Nzl43lQNbv7Jdrey0OGR75XL0VvxjW3
         KQNo6El2sWH1eFQLpesG9/fFvta0y2uFmSZYIP/p/DWbdqNZChp3YtvQkOmraO+rso32
         szXHYpPtASh/tVwt0y84JwHStThHnTyaMAMf4HuDFolgQuEozaNk5+R6nyzqWnKJIpyN
         RxbQ==
X-Gm-Message-State: AOAM533PF1OXsz+WMbAFX9CzC6ITFexoUhCN85xF0AHEmE7kHcp/i5nD
        7VK/7SS5L9Xq+lqbDTSD6bA=
X-Google-Smtp-Source: ABdhPJz3PdLl3OUBJaxWndqMWLwwlmnt03OCmX+b9UUx17rxBsNoTPSTDF+QroaGEh3TC9irqY52uQ==
X-Received: by 2002:a17:90a:7892:: with SMTP id x18mr8305004pjk.115.1626332110460;
        Wed, 14 Jul 2021 23:55:10 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j20sm5032689pfc.203.2021.07.14.23.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 23:55:09 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] Add module build support for timer driver
Date:   Thu, 15 Jul 2021 14:54:52 +0800
Message-Id: <20210715065455.392923-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patchset was based on the previous one [1], and add a few
boilerplate macros for module build purpose according to comments
from Thomas Gleixner on the patch [2].

Also switch sprd timer driver to use the help macros for support
module build.

* Changes from v1:
- Removed TIMER_OF_DECLARE() from timer-sprd.c, and removed ifdef;
- Rebased on v5.14-rc1.

[1] https://lkml.org/lkml/2020/3/24/72
[2] https://www.spinics.net/lists/arm-kernel/msg826631.html

Chunyan Zhang (2):
  clocksource/drivers/timer-of: Add boilerplate macros for timer module
    driver
  clocksource/drivers/sprd: Add module support to Unisoc timer

Saravana Kannan (1):
  drivers/clocksource/timer-of: Remove __init markings

 drivers/clocksource/Kconfig      |  2 +-
 drivers/clocksource/timer-of.c   | 30 ++++++++++++++++++++++--------
 drivers/clocksource/timer-of.h   | 24 ++++++++++++++++++++++--
 drivers/clocksource/timer-sprd.c | 15 ++++++++++-----
 4 files changed, 55 insertions(+), 16 deletions(-)

-- 
2.25.1

