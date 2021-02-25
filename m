Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1CF32509F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhBYNjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:39:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhBYNi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:38:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C71264EFA;
        Thu, 25 Feb 2021 13:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614260295;
        bh=lr8SL9gD1RWyjVOW25vxn/w4nEZ3HcF0RQApW0bE4+0=;
        h=From:To:Cc:Subject:Date:From;
        b=fh37CZa/Bs2ZEjyMs1wmFwPp0jkA0MMlfdDvyK+PmqWcEN3BM6/zqBbvWcNxi6F37
         bYZ+xK8yf0GkALDlHwbSnjlYgApDuc6US3VIXJxtoq8Yzea6M9SiJFZTnzK3qc45gZ
         liOhe4uX/RJfju5omkj5rKHECq9yjpSqZYbM0r55CEdn+6c7ESl05Yn/7opxRJpm9I
         u2gArH99Y47woV/TxubtTzXK639iQ66G/GJ8TEahg6EOE1CiBWibIZk22LDjrFJl8A
         bN06OcxTYEE90VA8pfBPD5BZU0veRnZvph+JG2+KZP85vQF+UcpH7BFy8nTuMeD61s
         8d1/vnCpLmknw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        David Hildenbrand <david@redhat.com>,
        Aslan Bakirov <aslan@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] memblock: fix section mismatch warning
Date:   Thu, 25 Feb 2021 14:38:00 +0100
Message-Id: <20210225133808.2188581-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The inlining logic in clang-13 is rewritten to often not inline
some functions that were inlined by all earlier compilers.

In case of the memblock interfaces, this exposed a harmless bug
of a missing __init annotation:

WARNING: modpost: vmlinux.o(.text+0x507c0a): Section mismatch in reference from the function memblock_bottom_up() to the variable .meminit.data:memblock
The function memblock_bottom_up() references
the variable __meminitdata memblock.
This is often because memblock_bottom_up lacks a __meminitdata
annotation or the annotation of memblock is wrong.

Interestingly, these annotations were present originally, but got removed
with the explanation that the __init annotation prevents the function
from getting inlined. I checked this again and found that while this
is the case with clang, gcc (version 7 through 10, did not test others)
does inline the functions regardless.

As the previous change was apparently intended to help the clang
builds, reverting it to help the newer clang versions seems appropriate
as well. gcc builds don't seem to care either way.

Fixes: 5bdba520c1b3 ("mm: memblock: drop __init from memblock functions to make it inline")
Reference: 2cfb3665e864 ("include/linux/memblock.h: add __init to memblock_set_bottom_up()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/memblock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index c88bc24e31aa..d13e3cd938b4 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -460,7 +460,7 @@ static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
 /*
  * Set the allocation direction to bottom-up or top-down.
  */
-static inline void memblock_set_bottom_up(bool enable)
+static inline __init void memblock_set_bottom_up(bool enable)
 {
 	memblock.bottom_up = enable;
 }
@@ -470,7 +470,7 @@ static inline void memblock_set_bottom_up(bool enable)
  * if this is true, that said, memblock will allocate memory
  * in bottom-up direction.
  */
-static inline bool memblock_bottom_up(void)
+static inline __init bool memblock_bottom_up(void)
 {
 	return memblock.bottom_up;
 }
-- 
2.29.2

