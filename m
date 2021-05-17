Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B04382300
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 05:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhEQDPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 23:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhEQDPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 23:15:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D60C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 20:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ntHCwS6vuOQS1pbrYRyU4GJgiqYXxM4C5/zbAtZ1vac=; b=e4fTWzOoq6Hg00RkJQvHtaclMk
        hyHps9zpV6nbGVRGr+S2AZ26F5kpPr85TsWhwsorONeTWYTDaaPtyPnSTa21YF/5V0+4cCMPhkEbD
        iLIo5cglJK6byTc3nJJm0RZHBBc1HXgntubsJyl+27SFqg1c5F9grCK6jW6XgB3MF+5rkhuzSG+OV
        I9UiUYcKjyAccgolMfpV2Gu/zlktBfsxMJkUcS+KEduFZYqUjZEXwqUWrqeu2wfGc2nsr6iS5vqT7
        TYGmkGzfLEWAV9gU4lLm9mS2nivr7yX79498A0JJqXJt5P6rQVhR45TSHsec/SFkpCJ4J9aweBv0X
        X8vpSERA==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1liThb-00DRcQ-N4; Mon, 17 May 2021 03:13:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] nds32: add a Kconfig symbol for LOCKDEP_SUPPORT
Date:   Sun, 16 May 2021 20:13:54 -0700
Message-Id: <20210517031354.9646-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each architecture (arch/) should define its own LOCKDEP_SUPPORT
Kconfig symbol (if it is needed). arch/nds32/ is the only one
that does "select LOCKDEP_SUPPORT", which is basically a no-op
since the symbol is not defined. (It might be nice for kconfig
to warn about that.)

Add a "config LOCKDEP_SUPPORT" to arch/nds32/Kconfig to correct
this issue.

Since the current Kconfig file selects LOCKDEP_SUPPORT unconditionally,
use "def_bool y" to set/enable it always.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/nds32/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-next-20210514.orig/arch/nds32/Kconfig
+++ linux-next-20210514/arch/nds32/Kconfig
@@ -36,7 +36,6 @@ config NDS32
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_PERF_EVENTS
 	select IRQ_DOMAIN
-	select LOCKDEP_SUPPORT
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
@@ -64,6 +63,9 @@ config GENERIC_LOCKBREAK
 	def_bool y
 	depends on PREEMPTION
 
+config LOCKDEP_SUPPORT
+	def_bool y
+
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
