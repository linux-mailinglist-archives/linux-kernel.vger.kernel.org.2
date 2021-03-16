Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822E833DA71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbhCPRO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239084AbhCPRN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:13:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90A0E65013;
        Tue, 16 Mar 2021 17:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615914835;
        bh=XieCZyeIda15jzEAAI/y4+VLPR3qlObfVN96dVZaJj0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZKdeS6p+E09TOd6dWytI/OA5eYJebcWEdHzd4F5OHYIU7oE4fU1/Fbj2qfzcXddLc
         bh0IW93QtFFAWthEDQf6AOeTNWZtj4lrILisBDhrRkm6TT0CcZZF5iD/aHw/GWiC6/
         oYZOnsYl5+NkKKdRmmiRwAO6ABuCd1xoGosIGNvVB2VVBK1okbwCn5C3+y0Ba+vLxD
         JVTPVfVxE1QQ2xgmVJMKMxbQBR0c9MFHC1YzDEWWeOpl/B5Jh4RSWLKN3gjLEUXjdF
         bA06lmb+8f/tnfoFPyCR0mReG4GUqh3dIxpSsk1rxXneBSvMQ+TPgiUaxMILegOxjw
         3/NCabqMUHNKA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] memblock: fix section mismatch warning again
Date:   Tue, 16 Mar 2021 19:13:47 +0200
Message-Id: <20210316171347.14084-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Commit 34dc2efb39a2 ("memblock: fix section mismatch warning") marked
memblock_bottom_up() and memblock_set_bottom_up() as __init, but they could
be referenced from non-init functions like memblock_find_in_range_node() on
architectures that enable CONFIG_ARCH_KEEP_MEMBLOCK.

For such builds kernel test robot reports:
All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x74fea4): Section mismatch in reference from the function memblock_find_in_range_node() to the function .init.text:memblock_bottom_up()
The function memblock_find_in_range_node() references
the function __init memblock_bottom_up().
This is often because memblock_find_in_range_node lacks a __init
annotation or the annotation of memblock_bottom_up is wrong.

Replace __init annotations with __init_memblock annotations so that the
appropriate section will be selected depending on
CONFIG_ARCH_KEEP_MEMBLOCK.

Link: https://lore.kernel.org/lkml/202103160133.UzhgY0wt-lkp@intel.com
Fixes: 34dc2efb39a2 ("memblock: fix section mismatch warning")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---

@Andrew, please let me know if you'd prefer this merged via memblock tree.

 include/linux/memblock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index d13e3cd938b4..5984fff3f175 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -460,7 +460,7 @@ static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
 /*
  * Set the allocation direction to bottom-up or top-down.
  */
-static inline __init void memblock_set_bottom_up(bool enable)
+static inline __init_memblock void memblock_set_bottom_up(bool enable)
 {
 	memblock.bottom_up = enable;
 }
@@ -470,7 +470,7 @@ static inline __init void memblock_set_bottom_up(bool enable)
  * if this is true, that said, memblock will allocate memory
  * in bottom-up direction.
  */
-static inline __init bool memblock_bottom_up(void)
+static inline __init_memblock bool memblock_bottom_up(void)
 {
 	return memblock.bottom_up;
 }
-- 
2.28.0

