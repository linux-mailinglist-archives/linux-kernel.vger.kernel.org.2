Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543CC437FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhJVU77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbhJVU76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:59:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62651C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 13:57:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 193-20020a1c01ca000000b00327775075f7so4791829wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QSF0jA8ABTYUhTui/XcGHRBwB7x1TPcMqxthGL1f5LA=;
        b=B9NCjSFQskXlpgjNpL5r4SpGWDHfdAvWLsoAeugGcxlJ3oF1xON6ZxAWdR92Sf8Yiq
         23s+IaR1V0bHMpWp3A8hs2CPDytYC7gmsLYrPn8l8Nl5JNnUQK9exSj+TgjPje+VpG4K
         TNmrGgtXWGJajU2LLTxeWqEnsFDTwTP+pMPR2Ml+LSZ/ZFPt+fdNN3WIee5KjlCwu4XH
         rbQEYJhCfPJ7aCHDMpYH2QnoCT/4expSZclg7bhno3xlZNEwLJzVsTevIVhKGNcGjf0y
         dsMghtoWH+NO3qfy+nTnnSzNtU7XZsNhT6Ovl6X1MaNfKQjjKJX52AMijHhu4JQgoV/G
         XC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QSF0jA8ABTYUhTui/XcGHRBwB7x1TPcMqxthGL1f5LA=;
        b=wKYv0q01g4A2OUJQ74AV8IDp5Cm9jTXhCmTxR/gOZY+hmI1bdxYtCBhGxrcBN3uKKh
         SCqe4CX4s5e4MKz6ORygP6g91J+kkSewo4qHTIcht8AGuvPAjY3jG6HbAGvyomRMaUAA
         jLqErhah2a+P1BDWQDyaEnDolzo1O1rX5n5hC+6xkIVlu4tpYa8S5JhA8d1WiRwFuFI8
         Gi314VoZG4z5UWk3K18yVy0xUtjRMrOiKoNQUzsnW+YGXgUPp9v+mbhmFMULMKttYcv2
         4RNSZ2xohjTnHVZHY6QIvmgzawvWJGFQag1JxPY9vzQcKAW2BtD4no9yOPAemQeG3ixz
         efZw==
X-Gm-Message-State: AOAM530/D4u8JYSWMbSeM6Csl58Ct36UxQX8w1qE/36V4lX0LdHpvdlJ
        1WTGLZkbei+Z40dkupizXghaN7fL90zmzTj5
X-Google-Smtp-Source: ABdhPJxlJGY+bgzV4uvWtjGEITmD2Pn+wqlqdvYkzevWguNJQ2/20tFPdL8eMxUCB1EaHVk+OLcE5Q==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr32030825wma.129.1634936258669;
        Fri, 22 Oct 2021 13:57:38 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a691:2666:4ecf:26e9? ([2a01:e34:ed2f:f020:a691:2666:4ecf:26e9])
        by smtp.googlemail.com with ESMTPSA id n68sm11775539wmn.13.2021.10.22.13.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 13:57:38 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v5.16
Message-ID: <65693aaf-ab94-c9bb-a97b-a2bb77033a54@linaro.org>
Date:   Fri, 22 Oct 2021 22:57:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d25a025201ed98f4b93775e0999a3f2135702106:

  clocksource: Make clocksource watchdog test safe for slow-HZ systems
(2021-08-28 17:01:32 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
tags/timers-v5.16-rc1

for you to fetch changes up to eda9a4f7af6ee47e9e131f20e4f8a41a97379293:

  clocksource/drivers/timer-ti-dm: Select TIMER_OF (2021-10-21 14:18:53
+0200)

Please note there is a shared branch with the arm tree armv8.6_arch_timer

The reason of the sharing is described in the merge commit.

----------------------------------------------------------------
- Fix redefined macro in the arc timer ()

- Big cleanup for ARM arch timer clocksource in order to set the scene
  for ARMv8.6 and provide support for higher frequencies with longer
  roll up (Marc Zyngier)

- Make arch dependant the Exynos MCT and Samsung PWM timers (Krzysztof
  Kozlowski)

- Select the TIMER_OF option for the timer TI DM (Kees Cook)
peter
----------------------------------------------------------------
Daniel Lezcano (1):
      Merge branch 'timers/drivers/armv8.6_arch_timer' into
timers/drivers/next

Kees Cook (1):
      clocksource/drivers/timer-ti-dm: Select TIMER_OF

Krzysztof Kozlowski (1):
      clocksource/drivers/exynosy: Depend on sub-architecture for Exynos
MCT and Samsung PWM

Marc Zyngier (12):
      clocksource/arm_arch_timer: Add build-time guards for unhandled
register accesses
      clocksource/drivers/arm_arch_timer: Drop CNT*_TVAL read accessors
      clocksource/drivers/arm_arch_timer: Extend write side of timer
register accessors to u64
      clocksource/drivers/arm_arch_timer: Move system register timer
programming over to CVAL
      clocksource/drivers/arm_arch_timer: Move drop _tval from erratum
function names
      clocksource/drivers/arm_arch_timer: Fix MMIO base address vs
callback ordering issue
      clocksource/drivers/arm_arch_timer: Move MMIO timer programming
over to CVAL
      clocksource/drivers/arm_arch_timer: Advertise 56bit timer to the
core code
      clocksource/drivers/arm_arch_timer: Work around broken CVAL
implementations
      clocksource/drivers/arm_arch_timer: Remove any trace of the TVAL
programming interface
      clocksource/drivers/arm_arch_timer: Drop unnecessary ISB on CVAL
programming
      clocksource/drivers/arch_arm_timer: Move workaround
synchronisation around

Oliver Upton (1):
      clocksource/drivers/arm_arch_timer: Fix masking for high freq counters

Randy Dunlap (1):
      clocksource/drivers/arc_timer: Eliminate redefined macro error

 arch/arm/include/asm/arch_timer.h    |  37 +++---
 arch/arm64/include/asm/arch_timer.h  |  52 ++++----
 drivers/clocksource/Kconfig          |   3 +
 drivers/clocksource/arc_timer.c      |   6 +-
 drivers/clocksource/arm_arch_timer.c | 243
+++++++++++++++++++++--------------
 include/clocksource/arm_arch_timer.h |   2 +-
 include/soc/arc/timers.h             |   4 +-
 7 files changed, 201 insertions(+), 146 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
