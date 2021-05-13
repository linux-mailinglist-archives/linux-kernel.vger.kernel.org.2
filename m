Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC2537F171
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 04:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhEMCxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 22:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhEMCxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 22:53:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E13061417;
        Thu, 13 May 2021 02:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620874348;
        bh=SLbN/DBHHqmewlE8uQW14WObooHOO9whfbtyrGVG5b4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HHlAXi1swYbztV+Xl0lXmdlm3Z62D/XY9oFpu3fdX9TfOekyShsSj+vQncgpZW7KI
         V5ZGTTo5f+r8od0SCbHo+X9celx0dnl2PvXHYQlmLXs57CaHKYzEeJQnGtu53dn8us
         HSJMlHfMNx0AkWyONanHd9JPnE3WKYCBojTArl0Y=
Date:   Wed, 12 May 2021 19:52:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com, rientjes@google.com,
        penberg@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in
 kmalloc_index() to compile-time
Message-Id: <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
In-Reply-To: <20210511173448.GA54466@hyeyoo>
References: <20210511173448.GA54466@hyeyoo>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 02:34:48 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> currently when size is not supported by kmalloc_index, compiler will
> generate a run-time BUG() while compile-time error is also possible,
> and better. so changed BUG to BUILD_BUG_ON_MSG to make compile-time
> check possible.
> 
> also removed code that allocates more than 32MB because current
> implementation supports only up to 32MB.
> 

This explodes in mysterious ways.  The patch as I have it is appended,
for reference.

gcc-10.3.0 allmodconfig.


mm/kfence/kfence_test.c: In function 'test_free_bulk':
mm/kfence/kfence_test.c:519:16: warning: unused variable 'size' [-Wunused-variable]
  519 |   const size_t size = setup_test_cache(test, 8 + prandom_u32_max(300), 0,
      |                ^~~~
In file included from <command-line>:
In function 'kmalloc_index',
    inlined from 'test_alloc' at mm/kfence/kfence_test.c:270:82:
././include/linux/compiler_types.h:328:38: error: call to '__compiletime_assert_922' declared with attribute error: unexpected size in kmalloc_index()
  328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
././include/linux/compiler_types.h:309:4: note: in definition of macro '__compiletime_assert'
  309 |    prefix ## suffix();    \
      |    ^~~~~~
././include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
  328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/slab.h:389:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
  389 |  BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
      |  ^~~~~~~~~~~~~~~~
make[2]: *** [mm/kfence/kfence_test.o] Error 1
make[1]: *** [mm/kfence] Error 2
make: *** [mm] Error 2

This patch suppresses the error:

--- a/mm/kfence/kfence_test.c~a
+++ a/mm/kfence/kfence_test.c
@@ -318,13 +318,13 @@ static void test_out_of_bounds_read(stru
 
 	/* Test both sides. */
 
-	buf = test_alloc(test, size, GFP_KERNEL, ALLOCATE_LEFT);
+	buf = test_alloc(test, 32, GFP_KERNEL, ALLOCATE_LEFT);
 	expect.addr = buf - 1;
 	READ_ONCE(*expect.addr);
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 	test_free(buf);
 
-	buf = test_alloc(test, size, GFP_KERNEL, ALLOCATE_RIGHT);
+	buf = test_alloc(test, 32, GFP_KERNEL, ALLOCATE_RIGHT);
 	expect.addr = buf + size;
 	READ_ONCE(*expect.addr);
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
@@ -519,11 +519,11 @@ static void test_free_bulk(struct kunit
 		const size_t size = setup_test_cache(test, 8 + prandom_u32_max(300), 0,
 						     (iter & 1) ? ctor_set_x : NULL);
 		void *objects[] = {
-			test_alloc(test, size, GFP_KERNEL, ALLOCATE_RIGHT),
-			test_alloc(test, size, GFP_KERNEL, ALLOCATE_NONE),
-			test_alloc(test, size, GFP_KERNEL, ALLOCATE_LEFT),
-			test_alloc(test, size, GFP_KERNEL, ALLOCATE_NONE),
-			test_alloc(test, size, GFP_KERNEL, ALLOCATE_NONE),
+			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_RIGHT),
+			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_NONE),
+			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_LEFT),
+			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_NONE),
+			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_NONE),
 		};
 
 		kmem_cache_free_bulk(test_cache, ARRAY_SIZE(objects), objects);


Is gcc-10.3.0 simply confused?  test_out_of_bounds_read() is clearly
calling kmalloc_index(32) which is OK.

Anyway, I'll drop this patch for now so I can compile a kernel!






From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: mm, slub: change run-time assertion in kmalloc_index() to compile-time

Currently when size is not supported by kmalloc_index, compiler will
generate a run-time BUG() while compile-time error is also possible, and
better.  So change BUG to BUILD_BUG_ON_MSG to make compile-time check
possible.

Also remove code that allocates more than 32MB because current
implementation supports only up to 32MB.

Link: https://lkml.kernel.org/r/20210511173448.GA54466@hyeyoo
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/slab.h |    7 +++++--
 mm/slab_common.c     |    7 +++----
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/include/linux/slab.h~mm-slub-change-run-time-assertion-in-kmalloc_index-to-compile-time
+++ a/include/linux/slab.h
@@ -346,6 +346,9 @@ static __always_inline enum kmalloc_cach
  * 1 =  65 .. 96 bytes
  * 2 = 129 .. 192 bytes
  * n = 2^(n-1)+1 .. 2^n
+ *
+ * Note: there's no need to optimize kmalloc_index because it's evaluated
+ * in compile-time.
  */
 static __always_inline unsigned int kmalloc_index(size_t size)
 {
@@ -382,8 +385,8 @@ static __always_inline unsigned int kmal
 	if (size <=  8 * 1024 * 1024) return 23;
 	if (size <=  16 * 1024 * 1024) return 24;
 	if (size <=  32 * 1024 * 1024) return 25;
-	if (size <=  64 * 1024 * 1024) return 26;
-	BUG();
+
+	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
 
 	/* Will never be reached. Needed because the compiler may complain */
 	return -1;
--- a/mm/slab_common.c~mm-slub-change-run-time-assertion-in-kmalloc_index-to-compile-time
+++ a/mm/slab_common.c
@@ -755,8 +755,8 @@ struct kmem_cache *kmalloc_slab(size_t s
 
 /*
  * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
- * kmalloc_index() supports up to 2^26=64MB, so the final entry of the table is
- * kmalloc-67108864.
+ * kmalloc_index() supports up to 2^25=32MB, so the final entry of the table is
+ * kmalloc-32M.
  */
 const struct kmalloc_info_struct kmalloc_info[] __initconst = {
 	INIT_KMALLOC_INFO(0, 0),
@@ -784,8 +784,7 @@ const struct kmalloc_info_struct kmalloc
 	INIT_KMALLOC_INFO(4194304, 4M),
 	INIT_KMALLOC_INFO(8388608, 8M),
 	INIT_KMALLOC_INFO(16777216, 16M),
-	INIT_KMALLOC_INFO(33554432, 32M),
-	INIT_KMALLOC_INFO(67108864, 64M)
+	INIT_KMALLOC_INFO(33554432, 32M)
 };
 
 /*
_

