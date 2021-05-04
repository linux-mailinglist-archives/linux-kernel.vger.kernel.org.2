Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89700372DA3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 18:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhEDQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhEDQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 12:13:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372E6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 09:12:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n138so14139539lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7lkJK3ZMQxyrUYaqzq8/RCOAe7M9iq9dnCm7X+7Tk6w=;
        b=Tct+1MB0IFW/9oXqyLhJenJz+W3OxAZ87NhH7cnhGgVMgNaYUzAvGLFV5TamrGpII3
         RWUeihnmK/zl5oRlUjqrx8IWtoNhLBWtXnwMtkJBdYXEwPd0YmwBk2rFGPSEOKf5gj4z
         zM96lEiFyGoiqXzHwz8XD+goa17A3MQ0L1dek03mlWH1VFHsJp8CD7jMf1AheKzR859i
         bLXgyjsidOSLeqV38gHLR7r44tUixeTmGosF+CdqA8EL6b9XeVAGGfEW05KBUa4Ta60G
         tRCHjh8QlGZlA8xa3yzu+laXXqqcNdgh3BPpJSr45VFaW+wTVMnKsUpSvLTEowQm/Drq
         iIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7lkJK3ZMQxyrUYaqzq8/RCOAe7M9iq9dnCm7X+7Tk6w=;
        b=Oyu8fiHtuWH3SqEhTmon0Z9EX20vb2yZH0aAV6hH0PpAEyQ1EnGBKzQbs6WNI1SW9v
         0yuGfDgA+B/IbUpE4vRJ5qTqA37Omk41PlA17HGtfxF0vZ0aywd7Sr1LhROZL2/JUqVp
         b0IOC/j/wRq/MluiSc1jZ0dZ8a8yNOwdvsSf6Cm/pWHKCzF16z8FzXDp2cVC2lCqde6e
         v2FPsTqPirmLCEB0lJExaNqaig+QxQb4UXwmOExmpenf5pP8DRc1E37m6JY5jutvxAJG
         kVuzCVxg+vpYiywNNE04r97G4NfqriN/cjek0gVU4BvLJqM47Mw1Xyhi+r+SrrpyFThs
         Y0Qg==
X-Gm-Message-State: AOAM530OwfR9N4m4y5pG7ISmvrTCWkLiofLCGHzIM6scUIeBYTj9ux5z
        aKVBo/euFfnrloBLhjNdmsWeycwGnRHaRNjz
X-Google-Smtp-Source: ABdhPJysYt8OkmHwrobuZn1T35XlaRK5aGAipkn4MC0S4T0NJEqylzAwDppNwaSwpmVNWjJJByPTQw==
X-Received: by 2002:ac2:44da:: with SMTP id d26mr16518818lfm.522.1620144751714;
        Tue, 04 May 2021 09:12:31 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:30 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] Initital support for new power/perf features for SD cards
Date:   Tue,  4 May 2021 18:12:11 +0200
Message-Id: <20210504161222.101536-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the SD spec v4.x the SD function extension registers were introduced,
together with a new set of commands (CMD48/49 and CMD58/59) to read and write
to them.

Moreover, in v4.x a new standard function for power management features were
added, while in v6.x a new standard function for performance enhancements
features were added.

This series implement the basics to add support for these new features (and
includes some additional preparations in patch 1->7), by adding support for
reading and parsing these new SD registers. In the final patch we add support
for the SD poweroff notification feature, which also add a function to write to
these registers.

Note that, there are no HW updates need for the host to support reading/parsing
of the these new SD registers. This has been tested with a 64GB Sandisk Extreme
PRO UHS-I A2 card.

Tests and reviews are of course greatly appreciated!

Kind regards
Ulf Hansson

Ulf Hansson (11):
  mmc: core: Drop open coding when preparing commands with busy
    signaling
  mmc: core: Take into account MMC_CAP_NEED_RSP_BUSY for eMMC HPI
    commands
  mmc: core: Re-structure some code in __mmc_poll_for_busy()
  mmc: core: Extend re-use of __mmc_poll_for_busy()
  mmc: core: Enable eMMC sleep commands to use HW busy polling
  mmc: core: Prepare mmc_send_cxd_data() to be re-used for additional
    cmds
  mmc: core: Drop open coding in mmc_sd_switch()
  mmc: core: Parse the SD SCR register for support of CMD48/49 and
    CMD58/59
  mmc: core: Read the SD function extension registers for power
    management
  mmc: core: Read performance enhancements registers for SD cards
  mmc: core: Add support for Power Off Notification for SD cards

 drivers/mmc/core/core.c    |  22 +--
 drivers/mmc/core/mmc.c     |  43 ++---
 drivers/mmc/core/mmc_ops.c | 137 +++++++-------
 drivers/mmc/core/mmc_ops.h |  10 +-
 drivers/mmc/core/sd.c      | 371 ++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/sd_ops.c  |  38 +---
 include/linux/mmc/card.h   |  22 +++
 include/linux/mmc/sd.h     |   4 +
 8 files changed, 504 insertions(+), 143 deletions(-)

-- 
2.25.1

