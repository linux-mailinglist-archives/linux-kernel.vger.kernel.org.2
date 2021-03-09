Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F8F33258A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhCIMgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:36:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:59944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhCIMf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:35:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AEF72AB8C;
        Tue,  9 Mar 2021 12:35:55 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] arm64: make STACKPROTECTOR_PER_TASK configurable.
Date:   Tue,  9 Mar 2021 13:35:44 +0100
Message-Id: <20210309123544.14040-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using dummy-tools STACKPROTECTOR_PER_TASK is unconditionally
selected. This defeats the purpose of the all-enabled tool.

Description copied from arm

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/arm64/Kconfig | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a8ff7cd5f096..f59d391e31a4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1549,9 +1549,20 @@ config RANDOMIZE_MODULE_REGION_FULL
 config CC_HAVE_STACKPROTECTOR_SYSREG
 	def_bool $(cc-option,-mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0 -mstack-protector-guard-offset=0)
 
+
 config STACKPROTECTOR_PER_TASK
-	def_bool y
+	bool "Use a unique stack canary value for each task"
 	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
+	default y
+	help
+	  Due to the fact that GCC uses an ordinary symbol reference from
+	  which to load the value of the stack canary, this value can only
+	  change at reboot time on SMP systems, and all tasks running in the
+	  kernel's address space are forced to use the same canary value for
+	  the entire duration that the system is up.
+
+	  Enable this option to switch to a different method that uses a
+	  different canary value for each task.
 
 endmenu
 
-- 
2.26.2

