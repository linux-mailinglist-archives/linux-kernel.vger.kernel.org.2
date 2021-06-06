Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3383439CF26
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFFMqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35064 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhFFMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:44 -0400
Date:   Sun, 06 Jun 2021 12:43:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XcbId6i3F5zM/Pv26vVo4GYbaZp7Ok9mwWFJ49xyalw=;
        b=G0CE/gUdEGnaes/M47UUTEacWwKch0fthRIT82NYiPoHGLeUGnfESsHunzQOKauP4OkVau
        mlC+l+QRNPC/NlKViKZz5h6D2S4fuDAtEKtXX4uuvwWVwLLiEZEQH94L0ba8nbG6K+TT55
        vdA4SQkml4Ip2k8J1a9R4GmfukNS+mJmGMeSaXkMgtcVWvj7Ck9boLCCp40JSILyC7Wfux
        ubRcTHYLvYHSUEpp40pLahEzpmIIUuHL6qqbmL5sBywbr3b0BPR5NSTm2B9UyLbl8ejX7n
        xiyhG8HbwDDshW0xLmE/AJzN6vTY8pBtHTBKWaPd8115FqLKOGgWiOHDRNhXsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XcbId6i3F5zM/Pv26vVo4GYbaZp7Ok9mwWFJ49xyalw=;
        b=J2x0n8OvtoauxDxzA5mUj6OjKxs0LYFSKOiJuGR+Cidj7wbvrm4rl3Nu1RCSbLNBmv+hzj
        roRHL2opVNH4UqCQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] MIPS: lantiq: Directly include linux/of.h
 in xway/dma.c
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343394.29796.12848794312736279026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1a7cc83d83be8e4a3c382937df07cf4ef4cd8d5b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1a7cc83d83be8e4a3c382937df07cf4ef4cd8d5b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 09:31:09 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:47 +01:00

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
