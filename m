Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DED408321
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 05:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhIMDaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 23:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbhIMDaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 23:30:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5394AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:28:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w6so4899112pll.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaLP9/Z6E8hGCsnN+XYIzHXxBH+JFCDzB2O8P56kFfE=;
        b=BQZcl6bNx8LPE+OAJCLA4QskR1C2LECgDxwxyBN04BdZphnw+W63sqtmMoNTllDH8R
         CIV8g5NqHmsZjD2SCgOx9TDXiOw3OX0VHItrNUfzJimWctTNggMNA0JqJqVFuMVs0HE+
         IIUQmCdVK1BtRWEr150k4iSKj/wN5cIuN99L37niKkFk/vjBl8eEs9ZnidlfQSpuxNJi
         YqmFOFjruy1oS2LldgEF3+0406zydnlwsrsmOTz1q0INLZzNz8+CzraD3j0YgaO5zS9c
         O4v5rMZjvsFRs3ZUQj9Qi20vcEw4RB9Zu0ANKaLfqgkEn6SbcS+uud09d6H4QQ9C2StY
         Y2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaLP9/Z6E8hGCsnN+XYIzHXxBH+JFCDzB2O8P56kFfE=;
        b=fGckuf1wVoOYy3vhv6uWh+2q9EUyGKa8YqzBEl6575CFTUD5RB2ffsTgLdJcKnu4AJ
         +jpxI8f2TwQ1BzUr3iY8su4/BikOh6grFcAfYS15rjd3OYs3fRk4fxJlHKdWoFFjCsEZ
         Ux45cSXrstP5oUk1me1g6iWqqyBzM97s9qZ2Bx+CIYJpOdffY86fhXpsqjMHh+58tiXT
         Cu48vUK+hKLkTVKxUmKdi3t3Npd4Or28A1so2274/H/q9c0BlD+0pdnl8D5V6946cWYm
         wM9eNKS3IaztmPtDqc/IaADLsYlqoJolfBfQANGbwD1bRrkDy0lT3A0IogCpXz2hzU/e
         GvQQ==
X-Gm-Message-State: AOAM533z0OC2mu14JSNs1RmLXzHc/ZiA+nLgcNGZsiLeBW2/dRnxR/y3
        qZDzmbcYj2YMSDNi+Pohn98=
X-Google-Smtp-Source: ABdhPJySEVGIRCkDttLukctbkE1aDdlLMoKUfMSgVLYhOag7G3RrdaCehiT9n1kXzsg0msLfdBeoGA==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr10528214pjb.71.1631503732761;
        Sun, 12 Sep 2021 20:28:52 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m12sm665109pjv.29.2021.09.12.20.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 20:28:52 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v3 0/3] Add module build support for timer driver
Date:   Mon, 13 Sep 2021 11:28:31 +0800
Message-Id: <20210913032834.147237-1-zhang.lyra@gmail.com>
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
 drivers/clocksource/timer-sprd.c | 18 +++++++++++++-----
 4 files changed, 53 insertions(+), 16 deletions(-)

-- 
2.25.1

