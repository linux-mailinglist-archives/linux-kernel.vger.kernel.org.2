Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31165447207
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 08:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbhKGHos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 02:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbhKGHoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 02:44:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E37C061570;
        Sun,  7 Nov 2021 00:42:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w29so9496088wra.12;
        Sun, 07 Nov 2021 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKxtBwFHv3lQqGO1awh/6piDm162i5ruhwqDgxDNab8=;
        b=m3tcAWbqeH6KSPcvHCdw9uto9zrjzGQlSzrcVg6hvH7Vnux6S/42Mtu2WF0sLRsX9G
         pgJeaGWQ5mX95e7Bn+b4AdNnTwkRiW9X34oZbLPtUSpDtKYh91XU7TgSLtfFOC0EPbzd
         jABbj7Nid4qalwWfiOKv6sXMZZE1IuDas26GcihyukIJdEJa2scmJ8n1XKEHf4VB+TrL
         11j5qY3dLMfNhJFWj5kw63NF1xej0mqhX1EZlCC/8FKKxpCWaQies3XjdSrO16MjNhyO
         7JbTOu1P7jqg231zIWrp7fmiOoqOFmYsOR/SQAnknK2LhTzbyvpiQBfK6mQFeu84H2yq
         U5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKxtBwFHv3lQqGO1awh/6piDm162i5ruhwqDgxDNab8=;
        b=TF8gqVcYFAFhKDRQZQGWk54O5XEiSH50Vf8qIWcatBG9mFEfIUGtEFCHS3XVkBAXDr
         1cmbI6p1QXoP7XJhEAQ5jjAIpClv41StpYQbfAODfjvE+kaws6Wryi8EYqPZMe3iLhOO
         gwN2H4PgSAoOtHw2/RzgB73FnTT2pSG2XbXL7G8zSD1t/4GjK1NZgjhvkZL6XuIVUOh2
         SFpc1/tSjsIcqEg62Lz+8wB98WFxnlyIuZALTI4QrTpSQQATldieV69JJHwWoNV1841W
         rjJ9AIEwptePfvwXv9k1SAouK4dhkRjI2+iL3viHFOvlZ0aY6WUQKsSsk78fzkN2cwoQ
         B3aA==
X-Gm-Message-State: AOAM531huhNoDVW5b1Jzz/MH+UM5pdcWdV332jJko85CoLGTbjWX2WuT
        rL7h71hjqN4Ri1pFC/Pjf/94pjELuSTd1w==
X-Google-Smtp-Source: ABdhPJyRapTBKhS+yiD8/y/xjjmAjY+GhLlx70nk2dCH5X3dPgBcFvc2A4pp/gkGZ67hYcv/+qSibQ==
X-Received: by 2002:a05:6000:15c1:: with SMTP id y1mr29878574wry.63.1636270922587;
        Sun, 07 Nov 2021 00:42:02 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id e12sm15353352wrq.20.2021.11.07.00.42.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Nov 2021 00:42:01 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org, john@phrozen.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name
Subject: [PATCH v5 0/4] clk: ralink: make system controller a reset provider
Date:   Sun,  7 Nov 2021 08:41:56 +0100
Message-Id: <20211107074200.18911-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series add minimal change to provide mt7621 resets properly
defining them in the 'mediatek,mt7621-sysc' node which is the system
controller of the SoC and is already providing clocks to the rest of
the world.

There is shared architecture code for all ralink platforms in 'reset.c'
file located in 'arch/mips/ralink' but the correct thing to do to align
hardware with software seems to define and add related reset code to the
already mainlined clock driver.

After this changes, we can get rid of the useless reset controller node
in the device tree and use system controller node instead where the property
'#reset-cells' has been added. Binding documentation for this nodeq has
been updated with the new property accordly.

This series also provide a bindings include header where all related
reset bits for the MT7621 SoC are defined.

Also, please take a look to this review [0] to understand better motivation
for this series.

Regarding the way of merging this:
 - I'd like patches 1 and 4 which are related going through staging tree.
 - The other two (patches 2 and 3) can perfectly go through the clock tree.

Thanks in advance for your feedback.

Changes in v5:
 - Move platform driver init process into 'arch_initcall' to be sure the
   rest of the world can get the resets available when needed (since PCIe
   controller driver has been moved from staging into 'drivers/pci/controller'
   is probed earlier and reset was not available so it was returning 
   -EPROBE_DEFER on firt try. Moving into 'arch_initcall' avoids the 'a bit
   anoying' PCI first failed log trace.

Changes in v4:
 - I sent wrong patch 3 accidentaly so now include the good version, sorry.

Changes in v3:
 - Collect Rob's Acked-by for patches 1 and 2. 
 - Rebase on the top of staging-next since there were already many
   changes there and PATCH 4 of the series didn't apply cleanly.

Changes in v2:
 - Address review comments of Dan Carpenter [1]:
 + Avoid 'inline' in function definition.
 + Return proper error codes (-EINVAL) instead of '-1'.
 + Make use of 'devm_kzalloc' instead of 'kzalloc'.

Best regards,
   Sergio Paracuellos

Sergio Paracuellos (4):
  dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
  dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
  clk: ralink: make system controller node a reset provider
  staging: mt7621-dts: align resets with binding documentation

 .../bindings/clock/mediatek,mt7621-sysc.yaml  | 12 +++
 drivers/clk/ralink/clk-mt7621.c               | 86 ++++++++++++++++++-
 drivers/staging/mt7621-dts/mt7621.dtsi        | 25 +++---
 include/dt-bindings/reset/mt7621-reset.h      | 37 ++++++++
 4 files changed, 145 insertions(+), 15 deletions(-)
 create mode 100644 include/dt-bindings/reset/mt7621-reset.h

-- 
2.33.0

