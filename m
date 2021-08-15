Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B883EC6DA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 05:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhHODWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 23:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhHODWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 23:22:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2197DC061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 20:22:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so27087485pjr.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 20:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5mhzwT6IWWSlxmSfpfeE/XFQS/+/uVPYRanjo7kSzqM=;
        b=O6VehYN2jHm7YoGR7ufXgki7fWpXoe4UDufXDXvOqGF+lWVGOtYHVxVxktfNCuEpaZ
         q+LFxFWhBKizbhfRwUFWvrm9b2/WLH64ONB1psK4/qlZ2XvgdhVyDutyY6NERXqTHiHb
         T2jG1r7w9dPJIrUnKtp1VoinC5cpdvJNc+PFXtYKpxR8S5phZpU/l/TRHttwpfVETv2P
         QhbHqBVBgtP8wRT8ohWlZcpxLKpEZRzVwkmnMWdwlJah7qDjYIAEZ6z+dhmMmkgr7Jn8
         KDnFwDab02DuSX1SQ/q7goxhBys6oKK6BbUAMy1/sd3gwEwk2IwZKcQ4ZKTLH2OX/i/H
         nb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5mhzwT6IWWSlxmSfpfeE/XFQS/+/uVPYRanjo7kSzqM=;
        b=X2D+S1XXscJvAheycz+euckW825Q++s5EJHk3Bz+4CrubLq72XFkpZmNFYoHcnjnfN
         BlysPr0bcvcLwdJhXISExM4/FY2LSWer+8OQTwkZWHea7KUjjVDZE4uxAFdN4hnt75Sp
         DR4rQMwBWS8/FaMX7rslCy34SNly7tCw/vKPqKmdV0thfXtgi/hyR9hD9v8pR3uX9WZ8
         c1WwKMwl9pdubP5q0j39rVfh/ZXYuppKN4dtraRfRC4z+ebrl8M178Yk82fkNz8XBB3b
         HTrSgG2KB9OxWNeX7YydpGP9rKbzofaf2c1JEkDshELldyR18ssHsQP9awCiZ458Eimf
         3Bew==
X-Gm-Message-State: AOAM5328W58w0458J+J8+2L5tVpDLa/YhpNSIxJyL5OCGuldfFQKtdCv
        iXqJiLDGW5iieDln9KhQOmE=
X-Google-Smtp-Source: ABdhPJx72TuyGGIJg/K1DsHnfxHB5bzww3roMVw7mjr6b4ZABbm84UYUJGuFRojHhql8BKmLY9tWfQ==
X-Received: by 2002:aa7:8891:0:b0:3e1:6eb1:b4b4 with SMTP id z17-20020aa78891000000b003e16eb1b4b4mr3017492pfe.9.1628997730660;
        Sat, 14 Aug 2021 20:22:10 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:9e16:8225:d249:1ee3])
        by smtp.gmail.com with ESMTPSA id p30sm6747703pfh.116.2021.08.14.20.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 20:22:10 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     gregkh@linuxfoundation.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, Barry Song <song.bao.hua@hisilicon.com>,
        kernel test robot <lkp@intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Pinski <pinskia@gmail.com>
Subject: [PATCH] lib: bitmap: Mute some odd section mismatch warning in xtensa kernel build
Date:   Sun, 15 Aug 2021 15:21:32 +1200
Message-Id: <20210815032132.14530-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

Constanly there are some section mismatch issues reported in test_bitmap
for xtensa platform such as:

  Section mismatch in reference from the function bitmap_equal() to the
  variable .init.data:initcall_level_names
  The function bitmap_equal() references the variable __initconst
  __setup_str_initcall_blacklist. This is often because bitmap_equal
  lacks a __initconst annotation or the annotation of
  __setup_str_initcall_blacklist is wrong.

  Section mismatch in reference from the function bitmap_copy_clear_tail()
  to the variable .init.rodata:__setup_str_initcall_blacklist
  The function bitmap_copy_clear_tail() references the variable __initconst
  __setup_str_initcall_blacklist.
  This is often because bitmap_copy_clear_tail lacks a __initconst
  annotation or the annotation of __setup_str_initcall_blacklist is wrong.

To be honest, hardly to believe kernel code is wrong since bitmap_equal is
always called in __init function in test_bitmap.c just like __bitmap_equal.
But gcc doesn't report any issue for __bitmap_equal even when bitmap_equal
and __bitmap_equal show in the same function such as:

  static void noinline __init test_mem_optimisations(void)
  {
	...
          for (start = 0; start < 1024; start += 8) {
                  for (nbits = 0; nbits < 1024 - start; nbits += 8) {
                          if (!bitmap_equal(bmap1, bmap2, 1024)) {
                                  failed_tests++;
                          }
                          if (!__bitmap_equal(bmap1, bmap2, 1024)) {
                                  failed_tests++;
                          }
  			...
                  }
          }
  }

The different between __bitmap_equal() and bitmap_equal() is that the
former is extern and a EXPORT_SYMBOL. So noinline, and probably in fact
noclone. But the later is static and unfortunately not inlined at this
time though it has a "inline" flag.

bitmap_copy_clear_tail(), on the other hand, seems more innocent as it is
accessing stack only by its wrapper bitmap_from_arr32() in function
test_bitmap_arr32():
static void __init test_bitmap_arr32(void)
{
        unsigned int nbits, next_bit;
        u32 arr[EXP1_IN_BITS / 32];
        DECLARE_BITMAP(bmap2, EXP1_IN_BITS);

        memset(arr, 0xa5, sizeof(arr));

        for (nbits = 0; nbits < EXP1_IN_BITS; ++nbits) {
                bitmap_to_arr32(arr, exp1, nbits);
                bitmap_from_arr32(bmap2, arr, nbits);
                expect_eq_bitmap(bmap2, exp1, nbits);
		...
        }
}
Looks like gcc optimized arr, bmap2 things to .init.data but it seems
nothing is wrong in kernel since test_bitmap_arr32() is __init.

Max Filippov reported a bug to gcc but gcc people don't ack. So here
this patch removes the involved symbols by forcing inline. It might
not be that elegant but I don't see any harm as bitmap_equal() and
bitmap_copy_clear_tail() are both quite small. In addition, kernel
doc also backs this modification "We don't use the 'inline' keyword
because it's broken": www.kernel.org/doc/local/inline.html

Another possible way to "fix" the warning is moving the involved
symboms to lib/bitmap.c:

  +int bitmap_equal(const unsigned long *src1,
  +                       const unsigned long *src2, unsigned int nbits)
  +{
  +       if (small_const_nbits(nbits))
  +               return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
  +       if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
  +           IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
  +               return !memcmp(src1, src2, nbits / 8);
  +       return __bitmap_equal(src1, src2, nbits);
  +}
  +EXPORT_SYMBOL(bitmap_equal);

This is harmful to the performance.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Andrew Pinski <pinskia@gmail.com>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 include/linux/bitmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 37f36dad18bd..3eec9f68a0b6 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -258,7 +258,7 @@ static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 /*
  * Copy bitmap and clear tail bits in last word.
  */
-static inline void bitmap_copy_clear_tail(unsigned long *dst,
+static __always_inline void bitmap_copy_clear_tail(unsigned long *dst,
 		const unsigned long *src, unsigned int nbits)
 {
 	bitmap_copy(dst, src, nbits);
@@ -334,7 +334,7 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
 
-static inline int bitmap_equal(const unsigned long *src1,
+static __always_inline int bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-- 
2.25.1

