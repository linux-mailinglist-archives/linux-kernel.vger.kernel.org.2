Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834F8440993
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhJ3Omt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 10:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhJ3Oms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 10:42:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A437C061570;
        Sat, 30 Oct 2021 07:40:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 71so7967872wma.4;
        Sat, 30 Oct 2021 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cAZsvYnkWZ2JmgGulEiIGKJLocwLHeQtPmIzuYHgKfs=;
        b=khXBGXNy+e/HlFq2JN0sgil6Vc2x5AlylRLeviiuxhssnMlLewtlBaNAOgyv8FZzcK
         4EzMkOUdNry/8vugvg/ad+WhHsUmPNn97zNo29LkhkgG7oUwoeZ/fRDQ7wAalLOUnrIm
         7/tHSifY6UL/xy0etYH1++CikQPRUcyc8V53TP7kE6mDs2rVNjFgA7uaB1nQWsL8WzsB
         Vi5XlHB6iwTxDUEoYdC/65i7K6xMsyjlQmodI8YPjPCs1FLFlRZXU/agOmuFol4bpd3q
         Y9A5tg0kIFqxk5Qr6jZ8ulAxSMGi8vPxHeAdquXHqxYEq5wCbgHNrEnCtuxVBNZqoFaf
         8SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cAZsvYnkWZ2JmgGulEiIGKJLocwLHeQtPmIzuYHgKfs=;
        b=8N135SIENGHk/EU51Q2dzG4YTMrc87TixyRgK4IuxrzH1zOzdCWLFOk2hoAiTdiaLF
         aRSVFw8xfN01qJnsKDmr2qQNvyIMgYM+fqZVi9ZjeVUi3MTN5B6ctOF4fDFUUjeZFFeC
         5zQHpaesSuLhTbewhT7ai4HJOUC8a+iF2Swh9RzbbwKmFqLQqHRzuXUzeNyEGqKicwat
         YFYQIcGnbkydK1pUFTMNpERxNHy2hiWSSqEMyv7BwQ6yYt8FSJUkUj5doCo8K7NDBWlH
         obiLlIxXGGsw69Mcsgvg/mWYMVYDKlJxoHjHb5lmbhvHjR9PSbjvgGAImu+v+RrzvmYc
         Tb+g==
X-Gm-Message-State: AOAM533Ra9OEqDFekBcKUMfmye537ovViAHXY9E13eFueM+rCmemnoBG
        W2yaMchzpYI1AQyxfEJ1txI=
X-Google-Smtp-Source: ABdhPJyx2fanuV1S9F+wmc5Y7BQAG6ILSt6BqaL9ztLHGolW4H1qza2M+gGEDUaZjVHH5pWKAam+SQ==
X-Received: by 2002:a05:600c:2e46:: with SMTP id q6mr8683745wmf.6.1635604816619;
        Sat, 30 Oct 2021 07:40:16 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id u19sm483602wmm.5.2021.10.30.07.40.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Oct 2021 07:40:15 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org, john@phrozen.org
Subject: [PATCH v4 0/4] clk: ralink: make system controller a reset provider
Date:   Sat, 30 Oct 2021 16:40:10 +0200
Message-Id: <20211030144014.26315-1-sergio.paracuellos@gmail.com>
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
 drivers/clk/ralink/clk-mt7621.c               | 79 +++++++++++++++++++
 drivers/staging/mt7621-dts/mt7621.dtsi        | 25 +++---
 include/dt-bindings/reset/mt7621-reset.h      | 37 +++++++++
 4 files changed, 139 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/reset/mt7621-reset.h

-- 
2.33.0

