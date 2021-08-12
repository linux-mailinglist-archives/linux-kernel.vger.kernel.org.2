Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BDB3EA6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbhHLOyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbhHLOyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:54:18 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F877C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 07:53:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1628780031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y4INfxuNvGKmJ7fA8mFpegB4/XD7G/W0BELDU6wu598=;
        b=olo/lvSAvBkGdMgJajSr08q+Aq3l7q9njOKWjWFce2KNAfP7eaZ31El3QqgK3k8fvjPGh1
        IKEl7ot+Re6s9j8P9hPd34yzy0QNWjkpm0Nl5lc7Y0CUDvi947qU3b5nIOtTJW86Zc6ezu
        f+stVRrmpOwC7pm6T3tDAY3HU9RDyg0=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] kasan: test: avoid crashing the kernel with HW_TAGS
Date:   Thu, 12 Aug 2021 16:53:27 +0200
Message-Id: <cover.1628779805.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: andrey.konovalov@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@gmail.com>

KASAN tests do out-of-bounds and use-after-free accesses. Running the
tests works fine for the GENERIC mode, as it uses qurantine and redzones.
But the HW_TAGS mode uses neither, and running the tests might crash
the kernel.

Rework the tests to avoid corrupting kernel memory.

Changes v1->v2:
- Touch both good and bad memory in memset tests as suggested by Marco.

Andrey Konovalov (8):
  kasan: test: rework kmalloc_oob_right
  kasan: test: avoid writing invalid memory
  kasan: test: avoid corrupting memory via memset
  kasan: test: disable kmalloc_memmove_invalid_size for HW_TAGS
  kasan: test: only do kmalloc_uaf_memset for generic mode
  kasan: test: clean up ksize_uaf
  kasan: test: avoid corrupting memory in copy_user_test
  kasan: test: avoid corrupting memory in kasan_rcu_uaf

 lib/test_kasan.c        | 80 +++++++++++++++++++++++++++++------------
 lib/test_kasan_module.c | 20 +++++------
 2 files changed, 66 insertions(+), 34 deletions(-)

-- 
2.25.1

