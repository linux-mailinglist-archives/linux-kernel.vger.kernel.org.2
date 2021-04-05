Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F683354254
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 15:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbhDENU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 09:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhDENU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 09:20:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81D22613AE;
        Mon,  5 Apr 2021 13:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617628850;
        bh=C4x+vM6T4MdxX8ujtga+Wyn57/xXCsWxfixHKNLC6hU=;
        h=From:To:Cc:Subject:Date:From;
        b=ajQYNn1NdIdIa676MVc/3jwJpXm4uIRGBvYX8BQQGFdBNb+9Ri3X1TpZl9blWs6k/
         JgtXO8B3u6NYp8Q7opM8u3MFGpoBDDDCP0/iCge5XMlDQw9K+IiMZ6qlk7Iu67bjVx
         fY8E5/eYhuClF4yxiCemH31mMbHUaYxL6FV5Z2VdhDX0dtaNyY5WJea4fuUIXfmJjB
         8fNnhzGThIFAktZXriCX/W5MSf0T6LORLMjZQTMmN7J0uucQEn6DwbmVGh4qfTHX5O
         X5xj1fZ8X6drwQw6YbyY+0Xph6jfOlpa7HAxXhzeiTL3tcUme22biedKk+ePCHqPFb
         tW5Jmm2J/tHWg==
From:   alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>,
        Alexey Skidanov <alexey.skidanov@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] lib/genalloc: add parameter description to fix doc compile warning
Date:   Mon,  5 Apr 2021 21:20:21 +0800
Message-Id: <20210405132021.131231-1-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

commit 52fbf1134d47 ("lib/genalloc.c: fix allocation of aligned buffer
 from non-aligned chunk") add a new parameter 'start_addr' w/o
description for it. That cause some doc compile warning:

lib/genalloc.c:649: warning: Function parameter or member 'start_addr' not described in 'gen_pool_first_fit'
lib/genalloc.c:667: warning: Function parameter or member 'start_addr' not described in 'gen_pool_first_fit_align'
lib/genalloc.c:694: warning: Function parameter or member 'start_addr' not described in 'gen_pool_fixed_alloc'
lib/genalloc.c:729: warning: Function parameter or member 'start_addr' not described in 'gen_pool_first_fit_order_align'
lib/genalloc.c:752: warning: Function parameter or member 'start_addr' not described in 'gen_pool_best_fit'

This patch fix this by adding parameter descriptions.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Alexey Skidanov <alexey.skidanov@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Huang Shijie <sjhuang@iluvatar.ai> 
Cc: Alex Shi <alexs@kernel.org> 
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com> 
Cc: Stephen Rothwell <sfr@canb.auug.org.au> 
Cc: linux-kernel@vger.kernel.org 
---
 lib/genalloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 8273760884a7..9a57257988c7 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -642,6 +642,7 @@ EXPORT_SYMBOL(gen_pool_set_algo);
  * @nr: The number of zeroed bits we're looking for
  * @data: additional data - unused
  * @pool: pool to find the fit region memory from
+ * @start_addr: not used in this function
  */
 unsigned long gen_pool_first_fit(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data,
@@ -660,6 +661,7 @@ EXPORT_SYMBOL(gen_pool_first_fit);
  * @nr: The number of zeroed bits we're looking for
  * @data: data for alignment
  * @pool: pool to get order from
+ * @start_addr: start addr of alloction chunk
  */
 unsigned long gen_pool_first_fit_align(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data,
@@ -687,6 +689,7 @@ EXPORT_SYMBOL(gen_pool_first_fit_align);
  * @nr: The number of zeroed bits we're looking for
  * @data: data for alignment
  * @pool: pool to get order from
+ * @start_addr: not used in this function
  */
 unsigned long gen_pool_fixed_alloc(unsigned long *map, unsigned long size,
 		unsigned long start, unsigned int nr, void *data,
@@ -721,6 +724,7 @@ EXPORT_SYMBOL(gen_pool_fixed_alloc);
  * @nr: The number of zeroed bits we're looking for
  * @data: additional data - unused
  * @pool: pool to find the fit region memory from
+ * @start_addr: not used in this function
  */
 unsigned long gen_pool_first_fit_order_align(unsigned long *map,
 		unsigned long size, unsigned long start,
@@ -742,6 +746,7 @@ EXPORT_SYMBOL(gen_pool_first_fit_order_align);
  * @nr: The number of zeroed bits we're looking for
  * @data: additional data - unused
  * @pool: pool to find the fit region memory from
+ * @start_addr: not used in this function
  *
  * Iterate over the bitmap to find the smallest free region
  * which we can allocate the memory.
-- 
2.25.1

