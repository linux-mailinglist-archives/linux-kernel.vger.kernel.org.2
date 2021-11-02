Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A00A44382B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhKBWE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhKBWEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:04:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478FBC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 15:02:19 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id D52EE9B4;
        Tue,  2 Nov 2021 22:02:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D52EE9B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635890539; bh=O1Oizdi3GsjZEryfYChbmXQeObgHv1rXkYHFf6Oq9eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOTwfwZOhLOb8J+hwbPlIBUG58F1RSYCHwkD7JSeKDOPvYW8mJwa9lO7zGCtxHfbi
         E7y21QGEglqBX8fQ7xbSC69mTB3GLKOqsToOI6sS10r4rpd7aBSVDGUxmHJe9gO8uG
         JmkN6mDqiiGVzb+3es+tTt/ccPeFqlcU0pFMi8UWe7tCDyP8ZI5fO/pmS9KdKorD8T
         M7j5s3qzmlkTkdkyQhOTf6mACiSs/EmBR5vi6n/Dg1jG1yLWXgW/SawO9sxS+j71Fj
         GJEqgqeZG9zgOI/TihyxFD3cX1xOrKVPze8MP9YLT3eDHuhElHwFiVm05QNArrhRpp
         K1duzKwtGBq2A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Nicolas Pitre <npitre@baylibre.com>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/9] Remove unused header <linux/cnt32_to_63.h>
Date:   Tue,  2 Nov 2021 16:01:57 -0600
Message-Id: <20211102220203.940290-4-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102220203.940290-1-corbet@lwn.net>
References: <20211102220203.940290-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fb37409a01b0 ("arch: remove unicore32 port) deleted the last file
that included <linux/cnt32_to_63.h>, but left that header file behind.
Nothing uses it, delete it now.

Cc: Nicolas Pitre <npitre@baylibre.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/cnt32_to_63.h | 104 ------------------------------------
 1 file changed, 104 deletions(-)
 delete mode 100644 include/linux/cnt32_to_63.h

diff --git a/include/linux/cnt32_to_63.h b/include/linux/cnt32_to_63.h
deleted file mode 100644
index 064428479f2d..000000000000
--- a/include/linux/cnt32_to_63.h
+++ /dev/null
@@ -1,104 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  Extend a 32-bit counter to 63 bits
- *
- *  Author:	Nicolas Pitre
- *  Created:	December 3, 2006
- *  Copyright:	MontaVista Software, Inc.
- */
-
-#ifndef __LINUX_CNT32_TO_63_H__
-#define __LINUX_CNT32_TO_63_H__
-
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <asm/byteorder.h>
-
-/* this is used only to give gcc a clue about good code generation */
-union cnt32_to_63 {
-	struct {
-#if defined(__LITTLE_ENDIAN)
-		u32 lo, hi;
-#elif defined(__BIG_ENDIAN)
-		u32 hi, lo;
-#endif
-	};
-	u64 val;
-};
-
-
-/**
- * cnt32_to_63 - Expand a 32-bit counter to a 63-bit counter
- * @cnt_lo: The low part of the counter
- *
- * Many hardware clock counters are only 32 bits wide and therefore have
- * a relatively short period making wrap-arounds rather frequent.  This
- * is a problem when implementing sched_clock() for example, where a 64-bit
- * non-wrapping monotonic value is expected to be returned.
- *
- * To overcome that limitation, let's extend a 32-bit counter to 63 bits
- * in a completely lock free fashion. Bits 0 to 31 of the clock are provided
- * by the hardware while bits 32 to 62 are stored in memory.  The top bit in
- * memory is used to synchronize with the hardware clock half-period.  When
- * the top bit of both counters (hardware and in memory) differ then the
- * memory is updated with a new value, incrementing it when the hardware
- * counter wraps around.
- *
- * Because a word store in memory is atomic then the incremented value will
- * always be in synch with the top bit indicating to any potential concurrent
- * reader if the value in memory is up to date or not with regards to the
- * needed increment.  And any race in updating the value in memory is harmless
- * as the same value would simply be stored more than once.
- *
- * The restrictions for the algorithm to work properly are:
- *
- * 1) this code must be called at least once per each half period of the
- *    32-bit counter;
- *
- * 2) this code must not be preempted for a duration longer than the
- *    32-bit counter half period minus the longest period between two
- *    calls to this code;
- *
- * Those requirements ensure proper update to the state bit in memory.
- * This is usually not a problem in practice, but if it is then a kernel
- * timer should be scheduled to manage for this code to be executed often
- * enough.
- *
- * And finally:
- *
- * 3) the cnt_lo argument must be seen as a globally incrementing value,
- *    meaning that it should be a direct reference to the counter data which
- *    can be evaluated according to a specific ordering within the macro,
- *    and not the result of a previous evaluation stored in a variable.
- *
- * For example, this is wrong:
- *
- *	u32 partial = get_hw_count();
- *	u64 full = cnt32_to_63(partial);
- *	return full;
- *
- * This is fine:
- *
- *	u64 full = cnt32_to_63(get_hw_count());
- *	return full;
- *
- * Note that the top bit (bit 63) in the returned value should be considered
- * as garbage.  It is not cleared here because callers are likely to use a
- * multiplier on the returned value which can get rid of the top bit
- * implicitly by making the multiplier even, therefore saving on a runtime
- * clear-bit instruction. Otherwise caller must remember to clear the top
- * bit explicitly.
- */
-#define cnt32_to_63(cnt_lo) \
-({ \
-	static u32 __m_cnt_hi; \
-	union cnt32_to_63 __x; \
-	__x.hi = __m_cnt_hi; \
- 	smp_rmb(); \
-	__x.lo = (cnt_lo); \
-	if (unlikely((s32)(__x.hi ^ __x.lo) < 0)) \
-		__m_cnt_hi = __x.hi = (__x.hi ^ 0x80000000) + (__x.hi >> 31); \
-	__x.val; \
-})
-
-#endif
-- 
2.31.1

