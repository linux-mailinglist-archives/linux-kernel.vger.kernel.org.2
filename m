Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8AA3E289C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbhHFKbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244908AbhHFKbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:31:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4136C061799
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:31:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y7so12397874eda.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SdOA0uji50FSR13/XDPx4weRv/KxkeY+zmfiRSKHVU=;
        b=YLQ0ExyEqhh+Ndr0E2FoKznXutZgcW6fp6swLkYTyCT+jp+/dNxi8HGdEgO1LdgkgS
         AeUDS3Ivq9l1+Ux57KggrGJzBgelk4g9GudQLZ+mv7lF8AwhPyQQMWeLK+9ucH+uEkxp
         zqWAcZDCbO7sC9X5qRbBe7I1isNpXJRI2LVuTvbz46tAYGJ6ho3WXTY5x3N8/1RdWcWo
         yM0ly0MAxiSNN+X2ji4gW2O0wKwA35LCNnBhkFrjGmh2fz+O3/4NOQP6YLkqG1rz4lUp
         P+kHok44xVzRkO3/lBmeMVeiNTggc7v0HgoUN76eI+hlSiMHVND5Cj0CJdxfzAUJcuV7
         qBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/SdOA0uji50FSR13/XDPx4weRv/KxkeY+zmfiRSKHVU=;
        b=mmlTIhnYoD20D/6bUBFYQ9ITYe3jmevxBFAqzA4VKebUQSEuCABHEnG+9UTT/UcPdg
         J2D9jhrei4Vj7mBNpt9gUKDulsip3gCl8cgCC8IkqqQbYvDpCUZW5XLvt5vy5ornj4he
         fFigTvavFC47Sm8hDhMaJy9DLp0MgGKC9WgHM3/IGEmlo33al/yn/mUO0R5WRN/v8jqM
         NW8+3A90ENltrA6hnR4UbG3/xeH+pCOzHVS8t6zyVO0mwEk9DyDBrMoqwH0caB5k6Nfq
         40WJlorGlYTOlnj2Aijj+ck3S83NlhnZabd0gU9ocSPiLlOg+UTqORDFThx4QKkbcNx6
         L6pw==
X-Gm-Message-State: AOAM531+UkEzMpMajJuDW01Uz/Uc9QVMLj0SBOghvRSxu9QDoha4b1UK
        NH0auDYu9S+ZSF/uKHGw5BfRHMXj6asKtlip
X-Google-Smtp-Source: ABdhPJwHmikLlTk+xILgOuQnia/v0mNRSDmWhPkeIRoviyGlpipqMGrdAl3VymOjhcMHhL5XIL+oMQ==
X-Received: by 2002:a05:6402:1289:: with SMTP id w9mr12075996edv.127.1628245883311;
        Fri, 06 Aug 2021 03:31:23 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id ec38sm3615755edb.40.2021.08.06.03.31.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Aug 2021 03:31:23 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: Remove binding for energymicro,efm32-timer.txt
Date:   Fri,  6 Aug 2021 12:31:22 +0200
Message-Id: <571fc4b2e6d41c61b7f4445601a79bb50aace2e7.1628245879.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has been removed by commit 523d83ef0979
("clocksource/drivers/efm32: Drop unused timer code") that's why binding
doc shouldn't be also valid anymore.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../timer/energymicro,efm32-timer.txt         | 23 -------------------
 1 file changed, 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/energymicro,efm32-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/energymicro,efm32-timer.txt b/Documentation/devicetree/bindings/timer/energymicro,efm32-timer.txt
deleted file mode 100644
index e502c11b2211..000000000000
--- a/Documentation/devicetree/bindings/timer/energymicro,efm32-timer.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* EFM32 timer hardware
-
-The efm32 Giant Gecko SoCs come with four 16 bit timers. Two counters can be
-connected to form a 32 bit counter. Each timer has three Compare/Capture
-channels and can be used as PWM or Quadrature Decoder. Available clock sources
-are the cpu's HFPERCLK (with a 10-bit prescaler) or an external pin.
-
-Required properties:
-- compatible : Should be "energymicro,efm32-timer"
-- reg : Address and length of the register set
-- clocks : Should contain a reference to the HFPERCLK
-
-Optional properties:
-- interrupts : Reference to the timer interrupt
-
-Example:
-
-timer@40010c00 {
-	compatible = "energymicro,efm32-timer";
-	reg = <0x40010c00 0x400>;
-	interrupts = <14>;
-	clocks = <&cmu clk_HFPERCLKTIMER3>;
-};
-- 
2.32.0

