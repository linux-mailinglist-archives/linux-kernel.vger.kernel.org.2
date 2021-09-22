Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9001414AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhIVNmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbhIVNl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:41:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EECC061762
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:40:29 -0700 (PDT)
Date:   Wed, 22 Sep 2021 13:40:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632318027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TILP92Xh/mxt3SuQeQVfHgWl39wcBjit4kMi0LiHZE=;
        b=PFMGvPwFOV2gpIk0i0LMdVnpLrvbiq+FNlW/KSJGYmXyzRhKSvJtTRbiaj/h/9x7eV3lXg
        g6/qGxheLB05LTeaoIEYhDlapn7tKMllVFLodcKHEd44d1PNEsHwTALc1reqNQAmSXbr75
        FMMNDz+XvCVPKl/dwG+XraSVRvTOkmRRnstFh9ioDBLY4hFWxiV2tZBB0YwQ0AETtp5g/l
        IunkBeKHSXRx52Wt9A8AXpEejSBCMT3X52DpcIg2J92f8Oegbe5WCT8IeUg/Q9S5+6CUcf
        2v00x8fN/h210PT9pYdsKBNHvNDllBGFIJs3l+UfTepUt9chujYkH3c8CJEdsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632318027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TILP92Xh/mxt3SuQeQVfHgWl39wcBjit4kMi0LiHZE=;
        b=6YPFPRX+fQFGdrWhEVj3tcPBgzGfaNE22F7Scup1dPBqeIy8jclAgHh+DwhXS/P0Crd3DE
        WMXtYBuTZpJMmoDw==
From:   "irqchip-bot for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/mbigen: Repair non-kernel-doc notation
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Jun Ma <majun258@huawei.com>, Yun Wu <wuyun.wu@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
In-Reply-To: <20210905033644.15988-1-rdunlap@infradead.org>
References: <20210905033644.15988-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <163231802692.25758.10199103034129986705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     b99948836162b0cfb03007d9b2c2da9babc057b5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b99948836162b0cfb03007d9b2c2da9babc057b5
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sat, 04 Sep 2021 20:36:44 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 22 Sep 2021 14:32:26 +01:00

irqchip/mbigen: Repair non-kernel-doc notation

Fix kernel-doc warnings in irq-mbigen.c:

irq-mbigen.c:29: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * In mbigen vector register
irq-mbigen.c:43: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * offset of clear register in mbigen node
irq-mbigen.c:50: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * offset of interrupt type register

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Jun Ma <majun258@huawei.com>
Cc: Yun Wu <wuyun.wu@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Aditya Srivastava <yashsri421@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210905033644.15988-1-rdunlap@infradead.org
---
 drivers/irqchip/irq-mbigen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index f565317..12df216 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -25,7 +25,7 @@
 /* The maximum IRQ pin number of mbigen chip(start from 0) */
 #define MAXIMUM_IRQ_PIN_NUM		1407
 
-/**
+/*
  * In mbigen vector register
  * bit[21:12]:	event id value
  * bit[11:0]:	device id
@@ -39,14 +39,14 @@
 /* offset of vector register in mbigen node */
 #define REG_MBIGEN_VEC_OFFSET		0x200
 
-/**
+/*
  * offset of clear register in mbigen node
  * This register is used to clear the status
  * of interrupt
  */
 #define REG_MBIGEN_CLEAR_OFFSET		0xa000
 
-/**
+/*
  * offset of interrupt type register
  * This register is used to configure interrupt
  * trigger type
