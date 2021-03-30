Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF75D34DDF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhC3CHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:07:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:49634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhC3CGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:06:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58218B211;
        Tue, 30 Mar 2021 02:06:46 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     longman@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -tip] locking: Move CONFIG_LOCK_EVENT_COUNTS into Kernel hacking section
Date:   Mon, 29 Mar 2021 19:06:36 -0700
Message-Id: <20210330020636.112594-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a lot more intuitive to have it in the locking section of the kernel
hacking part rather than under "General architecture-dependent options".

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/Kconfig      | 9 ---------
 lib/Kconfig.debug | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index ecfd3520b676..d6f9aeaaf9f2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1113,15 +1113,6 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 config ARCH_USE_MEMREMAP_PROT
 	bool
 
-config LOCK_EVENT_COUNTS
-	bool "Locking event counts collection"
-	depends on DEBUG_FS
-	help
-	  Enable light-weight counting of various locking related events
-	  in the system with minimal performance impact. This reduces
-	  the chance of application behavior change because of timing
-	  differences. The counts are reported via debugfs.
-
 # Select if the architecture has support for applying RELR relocations.
 config ARCH_HAS_RELR
 	bool
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2779c29d9981..76639ff5998c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1401,6 +1401,15 @@ config DEBUG_LOCKING_API_SELFTESTS
 	  The following locking APIs are covered: spinlocks, rwlocks,
 	  mutexes and rwsems.
 
+config LOCK_EVENT_COUNTS
+	bool "Locking event counts collection"
+	depends on DEBUG_FS
+	help
+	  Enable light-weight counting of various locking related events
+	  in the system with minimal performance impact. This reduces
+	  the chance of application behavior change because of timing
+	  differences. The counts are reported via debugfs.
+
 config LOCK_TORTURE_TEST
 	tristate "torture tests for locking"
 	depends on DEBUG_KERNEL
-- 
2.26.2

