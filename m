Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C8B3E9653
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhHKQqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:46:35 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:38839 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhHKQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:46:34 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 17BGjLup009549;
        Thu, 12 Aug 2021 01:45:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 17BGjLup009549
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628700322;
        bh=X9DsnRLorrRzC4aklBYuipruGKuEaAwA49SVBCCAwS0=;
        h=From:To:Cc:Subject:Date:From;
        b=PmKf/HbdYeZ6rENzJ5PDj3H992+9evTUBqFnpd3/iiaqBUziJOAR50HMYJOWB3tvk
         Trg1EIvYD45sO95dntIj5zXUfrJYBSCcaXE0dipNBvqqW9PdxhEpk/9XPab5GfK7Of
         IdwK8tor8c0Aqbz3UAiggxl0ks8Ge8MSP8lT9QJZElOOmoney3COfYysyIn/dnd4U0
         iR5YYKa6aOgAsjEr+iLts/n6/0H7WabK6P3uaIY7B4o5oWwuZNyQuMGoFaXXMFPx0o
         4y+5kSM4QeoQtvpbcuSPVqtpqFg+9Zr1z/88uBw8TmMhBBo0trYBjjODtgGWaZJGnY
         /hvw9PkLHBqBg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: move core-y in arch/microblaze/Makefile to arch/microblaze/Kbuild
Date:   Thu, 12 Aug 2021 01:45:18 +0900
Message-Id: <20210811164518.187497-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use obj-y to clean up Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/microblaze/Kbuild   | 4 ++++
 arch/microblaze/Makefile | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/Kbuild b/arch/microblaze/Kbuild
index a4e40e534e6a..a1c597889319 100644
--- a/arch/microblaze/Kbuild
+++ b/arch/microblaze/Kbuild
@@ -1 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-y			+= kernel/
+obj-y			+= mm/
+obj-$(CONFIG_PCI)	+= pci/
+obj-y			+= boot/dts/
diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 6d4af39e3890..9adc6b6434df 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -50,17 +50,12 @@ KBUILD_CFLAGS += -ffixed-r31 $(CPUFLAGS-y) $(CPUFLAGS-1) $(CPUFLAGS-2)
 
 head-y := arch/microblaze/kernel/head.o
 libs-y += arch/microblaze/lib/
-core-y += arch/microblaze/kernel/
-core-y += arch/microblaze/mm/
-core-$(CONFIG_PCI) += arch/microblaze/pci/
 
 boot := arch/microblaze/boot
 
 # Are we making a simpleImage.<boardname> target? If so, crack out the boardname
 DTB:=$(subst simpleImage.,,$(filter simpleImage.%, $(MAKECMDGOALS)))
 
-core-y	+= $(boot)/dts/
-
 export DTB
 
 all: linux.bin
-- 
2.30.2

