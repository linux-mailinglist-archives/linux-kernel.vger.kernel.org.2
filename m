Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01403C1566
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 16:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhGHOrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 10:47:06 -0400
Received: from foss.arm.com ([217.140.110.172]:60630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhGHOrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:47:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32791D6E;
        Thu,  8 Jul 2021 07:44:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D57693F66F;
        Thu,  8 Jul 2021 07:44:21 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     andreyknvl@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, mark.rutland@arm.com, ryabinin.a.a@gmail.com,
        will@kernel.org
Subject: [PATCH] kasan: fix build for CONFIG_KASAN_HW_TAGS
Date:   Thu,  8 Jul 2021 15:44:11 +0100
Message-Id: <20210708144411.25467-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_KASAN_HW_TAGS is selected, <linux/kasan.h> uses _RET_IP_,
but doesn't explicitly include <linux/kernel.h> where this is defined.

We used to get this via a transitive include, but since commit:

  f39650de687e3576 ("kernel.h: split out panic and oops helpers")

... this is no longer the case, and so we get a build failure:

|   CC      arch/arm64/mm/kasan_init.o
| In file included from arch/arm64/mm/kasan_init.c:10:
| ./include/linux/kasan.h: In function 'kasan_slab_free':
| ./include/linux/kasan.h:211:39: error: '_RET_IP_' undeclared (first use in this function)
|   211 |   return __kasan_slab_free(s, object, _RET_IP_, init);
|       |                                       ^~~~~~~~
| ./include/linux/kasan.h:211:39: note: each undeclared identifier is reported only once for each function it appears in
| ./include/linux/kasan.h: In function 'kasan_kfree_large':
| ./include/linux/kasan.h:219:28: error: '_RET_IP_' undeclared (first use in this function)
|   219 |   __kasan_kfree_large(ptr, _RET_IP_);
|       |                            ^~~~~~~~
| ./include/linux/kasan.h: In function 'kasan_slab_free_mempool':
| ./include/linux/kasan.h:226:34: error: '_RET_IP_' undeclared (first use in this function)
|   226 |   __kasan_slab_free_mempool(ptr, _RET_IP_);
|       |                                  ^~~~~~~~
| ./include/linux/kasan.h: In function 'kasan_check_byte':
| ./include/linux/kasan.h:277:35: error: '_RET_IP_' undeclared (first use in this function)
|   277 |   return __kasan_check_byte(addr, _RET_IP_);
|       |                                   ^~~~~~~~

Fix this by including <linux/kernel.h> explicitly.

Fixes: 6028bf777417 ("kernel.h: split out panic and oops helpers")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/kasan.h | 1 +
 1 file changed, 1 insertion(+)

As a heads-up, there are some unrelated runtime issues with
CONFIG_KASAN_HW_TAGS and the recent arm64 string routines rework, which
I'm looking into now. If you boot-test with this applied, you should
expect to see those.

Andrew, I assume you'd be the one to pick this up?

Thanks,
Mark.

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 5310e217bd74..dd874a1ee862 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -3,6 +3,7 @@
 #define _LINUX_KASAN_H
 
 #include <linux/bug.h>
+#include <linux/kernel.h>
 #include <linux/static_key.h>
 #include <linux/types.h>
 
-- 
2.11.0

