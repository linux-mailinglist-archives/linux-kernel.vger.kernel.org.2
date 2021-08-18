Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E333F0C30
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhHRT6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhHRT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:57:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC222C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:57:03 -0700 (PDT)
Date:   Wed, 18 Aug 2021 19:57:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629316622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VRtJZlNe+KC108tT6STJCYrYZzqOMTcFqP6N3wNjMIc=;
        b=vnK5GUFirtXlN9zpjg7M6pi5LxsjqfJXsafLkBktgvF/CUPv7kfqR5zyijBw48R/OnmmHt
        sD0DOYsxX3pBvD1pLzymGE8wCFNwIloaWP4kFNewp/i3VDvEtabTlwh8mqkpjdSRalEF4h
        nwaKev2XHYmQb4Ei3TYFnLmQW3M7v8Y0noAVeTmi5N9MSSfWG314iNtcam/SPwdjQO1fSv
        VbSifqLTkt56OkJvQkPQmAGNP/CBBQAsyAnp/20Mc2Es9NOB5RNhK5SbSg/NI2Xha9Va2q
        VMYeCE4sS+ypVOpYQCA6KbsvLsk6y3Y+fzpOglGwF8IPDHYpb2QrVHHhCfW1qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629316622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VRtJZlNe+KC108tT6STJCYrYZzqOMTcFqP6N3wNjMIc=;
        b=FLx+Q0c65jnMN8XVa7hEnDt4b/e/SFYMmOdHF0mP2cPWJ/O/44IlZuN2UvMWtucnXSnfu7
        0JwGtJZfWAec5qAg==
From:   "irqchip-bot for Jianqun Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: gpio: change items
 restriction of clock for rockchip,gpio-bank
Cc:     Jianqun Xu <jay.xu@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>, maz@kernel.org,
        tglx@linutronix.de
In-Reply-To: <20210816011948.1118959-5-jay.xu@rock-chips.com>
References: <20210816011948.1118959-5-jay.xu@rock-chips.com>
MIME-Version: 1.0
Message-ID: <162931662167.25758.2512620383508501425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     75d1415ea57c1b0e87f786e85e5f478fab5c91be
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/75d1415ea57c1b0e87f786e85e5f478fab5c91be
Author:        Jianqun Xu <jay.xu@rock-chips.com>
AuthorDate:    Mon, 16 Aug 2021 09:19:43 +08:00
Committer:     Linus Walleij <linus.walleij@linaro.org>
CommitterDate: Tue, 17 Aug 2021 01:01:49 +02:00

dt-bindings: gpio: change items restriction of clock for rockchip,gpio-bank

In the past we only need on clock which name "pclk" for a gpio controller.
In the new version gpio controller, there add some register to change
debounce clock dynamic, so the dt node needs to add the second clock, we
call it "dbclk".

The clock property need 2 items on some rockchip chips such as RK3568
SoCs.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Link: https://lore.kernel.org/r/20210816011948.1118959-5-jay.xu@rock-chips.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index d993e00..0d62c28 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -22,7 +22,10 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: APB interface clock source
+      - description: GPIO debounce reference clock source
 
   gpio-controller: true
 
