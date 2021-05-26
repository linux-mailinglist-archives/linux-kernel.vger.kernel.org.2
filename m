Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48716391125
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhEZHEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhEZHEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:04:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B15C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 00:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Hzm2mpOSaw22W6H0oIugHn8eMxTHgG1H+cJgvsJeeLU=; b=F+VshIB7zZHXD5VKKd6JQRmhoB
        f4wsu6c3Q+XVZCFbX4avMyTsZjoXAmWq4b78PQoiJ9Ld5UpH1Ywwayn++w9vkOG0H1M6z3SBSdldw
        miggwLe1oxJ5QZ5FVIIC7YeqwOsUDe+7TbYJFesfKo3YQ/efeQj3txZ8+lhLHyQAuP47j5EUDUH6D
        Rv619CL5zzAAVfbiu3t5jiyFjLj5+3OYfmO5aTexSbSqSUxLTyzlrT5I9mcf+IfZ9PtGHm5Gbul47
        SqMWdhQtZ+RzfpG9g8CCQZrKqglDpPUR8PWtBhxUkIG93scJqAtnywSfajaA3YbMT5SMb002V96+O
        irbsrWlA==;
Received: from [2601:1c0:6280:3f0::1c1d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llnZa-00BrlF-BB; Wed, 26 May 2021 07:03:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH] NIOS2: fix kconfig unmet dependency warning for SERIAL_CORE_CONSOLE
Date:   Wed, 26 May 2021 00:03:21 -0700
Message-Id: <20210526070321.22227-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
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
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
---
 arch/nios2/Kconfig.debug |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20210525.orig/arch/nios2/Kconfig.debug
+++ linux-next-20210525/arch/nios2/Kconfig.debug
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
