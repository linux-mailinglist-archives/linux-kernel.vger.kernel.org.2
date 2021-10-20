Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4551E4352ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhJTSte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhJTSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:49:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20D7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 11:47:13 -0700 (PDT)
Date:   Wed, 20 Oct 2021 18:47:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634755631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVoRLfPkwEAvJ45oJff+1wYH3evfCFuAjxc+7NLbSng=;
        b=OpvXSGbIbWPLKjK8pITlbWlVr9jx9j1TxwEYKqGtR/BqhkSRcUw69+yZIRukTFG5nSvV4v
        iqeGry3YM5/se3dt+wQzn8dq/3r6Q40Sc3PVuBhNivbVxLq1CrHTkZPlLBGLB3jd0/25y5
        C7BrR/idWz+UheHbDlmzpa9BxFvesFOgzeox5Qkj2YOQinaHUibTe9Koq3dksvYmAMW2uM
        gCogxtyqfgW4hm9DcWG3t0qhtMpeiBFGPXzEAoO/QdMKYmrYmOiRsEm+A7lsI7SSGyi22r
        h/QWpKxDaTiALgpBdbFk60zsAYRgofgPKj6OVj1/5jNG0gMruqqZd/AaZb6CWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634755631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVoRLfPkwEAvJ45oJff+1wYH3evfCFuAjxc+7NLbSng=;
        b=WWZoy5euVoBdUt0Mw4xhAVK/2+PXIKOzZXGQvYX5TfWbpz2JLnijFyF4+sERw2UFhYSh77
        74g+rOmHi5yRfoBg==
From:   "irqchip-bot for Neil Armstrong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64: meson: remove MESON_IRQ_GPIO selection
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210902134914.176986-3-narmstrong@baylibre.com>
References: <20210902134914.176986-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Message-ID: <163475563071.25758.7058300931913353895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     dfd8c90eb28b8f7c77ce7173c4bae591b26ea51a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/dfd8c90eb28b8f7c77ce7173c4bae591b26ea51a
Author:        Neil Armstrong <narmstrong@baylibre.com>
AuthorDate:    Thu, 02 Sep 2021 15:49:14 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 19:38:21 +01:00

arm64: meson: remove MESON_IRQ_GPIO selection

Selecting MESON_IRQ_GPIO forces it as built-in, but we may need to build it
as a module, thus remove it here and let the "default ARCH_MESON" build as
built-in by default with the option to switch it to module.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210902134914.176986-3-narmstrong@baylibre.com
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b0ce18d..ff2d83f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -167,7 +167,6 @@ config ARCH_MEDIATEK
 config ARCH_MESON
 	bool "Amlogic Platforms"
 	select COMMON_CLK
-	select MESON_IRQ_GPIO
 	help
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
