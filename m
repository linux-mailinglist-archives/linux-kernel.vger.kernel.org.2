Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744C3318BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhBKNQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:16:27 -0500
Received: from foss.arm.com ([217.140.110.172]:51588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231592AbhBKM5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:57:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 399B5113E;
        Thu, 11 Feb 2021 04:56:11 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D4743F73B;
        Thu, 11 Feb 2021 04:56:10 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] arm64: Fix warning in mte_get_random_tag()
Date:   Thu, 11 Feb 2021 12:56:02 +0000
Message-Id: <20210211125602.44248-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simplification of mte_get_random_tag() caused the introduction of the
warning below:

In file included from arch/arm64/include/asm/kasan.h:9,
                 from include/linux/kasan.h:16,
                 from mm/kasan/common.c:14:
mm/kasan/common.c: In function ‘mte_get_random_tag’:
arch/arm64/include/asm/mte-kasan.h:45:9: warning: ‘addr’ is used
                                         uninitialized [-Wuninitialized]
   45 |         asm(__MTE_PREAMBLE "irg %0, %0"
      |

Fix the warning initializing the address to NULL.

Note: mte_get_random_tag() returns a tag and it never dereferences the address,
hence 'addr' can be safely initialized to NULL.

Fixes: c8f8de4c0887 ("arm64: kasan: simplify and inline MTE functions")
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---

This patch is based on linux-next/akpm

 arch/arm64/include/asm/mte-kasan.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 3d58489228c0..b2850b750726 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -40,7 +40,12 @@ static inline u8 mte_get_mem_tag(void *addr)
 /* Generate a random tag. */
 static inline u8 mte_get_random_tag(void)
 {
-	void *addr;
+	/*
+	 * mte_get_random_tag() returns a tag and it
+	 * never dereferences the address, hence addr
+	 * can be safely initialized to NULL.
+	 */
+	void *addr = NULL;
 
 	asm(__MTE_PREAMBLE "irg %0, %0"
 		: "+r" (addr));
-- 
2.30.0

