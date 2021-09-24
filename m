Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC704168EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 02:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243599AbhIXAbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 20:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbhIXAbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:31:13 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFD1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/fng2MakaD1v+Qm85lpyvTfC20CkyF/ZiyYHEdz66uM=; b=QMKsRsARBLWmJMVJEb+PiYGZ6Q
        7YpRjc9r4kUmgRqRzRyVVEqOk+UFQwCkPBITuddTzTm57drySMxxtygcM4T4wKj2Ay1BrwX8dws3S
        EHZrtP5CKDhPdDBw+r8PLL2ZnHR2vfTtppFyRT9J0sOBfjhNDZGoIW0h398bpGpGWHjGFVeW9A8Ak
        pPmRvvlZ+pcYMCnX0bq5bmZe9fBUMWRLGQYhwByBWH2BzuP8lbDOUPa0FBoNtV5vDD54bFSVlZenC
        5DXz1Msq5nK6XYlIsxm2+rHdiVvw/OygpA8iRJ9IBblyshZFuou1MovByVyFaFxbu1huKl57KoXfA
        ajODOBJA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTZ5v-00Cm6j-UF; Fri, 24 Sep 2021 00:29:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v2] NIOS2: fix kconfig unmet dependency warning for SERIAL_CORE_CONSOLE
Date:   Thu, 23 Sep 2021 17:29:39 -0700
Message-Id: <20210924002939.16562-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SERIAL_CORE_CONSOLE depends on TTY so EARLY_PRINTK should also
depend on TTY so that it does not select SERIAL_CORE_CONSOLE
inadvertently.

WARNING: unmet direct dependencies detected for SERIAL_CORE_CONSOLE
  Depends on [n]: TTY [=n] && HAS_IOMEM [=y]
  Selected by [y]:
  - EARLY_PRINTK [=y]

Fixes: e8bf5bc776ed ("nios2: add early printk support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
---
v2: resend to new maintainer

 arch/nios2/Kconfig.debug |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20210923.orig/arch/nios2/Kconfig.debug
+++ linux-next-20210923/arch/nios2/Kconfig.debug
@@ -3,9 +3,10 @@
 config EARLY_PRINTK
 	bool "Activate early kernel debugging"
 	default y
+	depends on TTY
 	select SERIAL_CORE_CONSOLE
 	help
-	  Enable early printk on console
+	  Enable early printk on console.
 	  This is useful for kernel debugging when your machine crashes very
 	  early before the console code is initialized.
 	  You should normally say N here, unless you want to debug such a crash.
