Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D03A438F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhFKN5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhFKN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3B6C0613A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:45 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=y7a/JZCc5409EJXGIR+ABiGeFyfKIt2c7ts7VNj2SpU=;
        b=L+oIysfMUN0j9wr4d6x61u7vVb1jN4Pb9aqRlgSc0/P1yGLjSIZUCmnbCtWidiJwFDzAqe
        AYMoSeY7lDuz1RoLwJdCg6G2TMynfos3Nt5j+CmEeo6dQS8vZhnisfIozaRxunSd5Tkl4X
        UgQ6thvLCEdI7zQtvY9xy0th0/KzXzybHO2wutWyOLdKBgHGAiKdPziighgu1PyGaSwoFL
        TeGAFcEY7uB8oB0DoBrqQSdZDdFAsmG7rfNh+BPCrhXvRInbj5ZJPaKaAbaR6oq8otGzUd
        I5+/MyQV461TcuS/OIZr6s2/dlyOe/YUPez0riofkzV6tCpmP2Y+GrdFUHg61g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=y7a/JZCc5409EJXGIR+ABiGeFyfKIt2c7ts7VNj2SpU=;
        b=7U4NS2HVw6JjO1rG0UVGSiZndryV69tRgJyRwa2/NrspUQi+5KFBB5rf/rsTTT4bYf08Tn
        k9orffQJ7bBmGbAg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] MIPS: lantiq: Directly include linux/of.h
 in xway/dma.c
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341968333.19906.10512024766711070295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     95af1df6f4e2b121ce33166d61c99250143073b5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/95af1df6f4e2b121ce33166d61c99250143073b5
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 09:31:09 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:16 +01:00

MIPS: lantiq: Directly include linux/of.h in xway/dma.c

This drivers currently obtains linux/of.h by luck and a chain of
bizarre inclusions, which we're about to fix.

Let's include the required file directly.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/mips/lantiq/xway/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index aeb1b98..63dccb2 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -12,6 +12,7 @@
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 #include <lantiq_soc.h>
 #include <xway_dma.h>
