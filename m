Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636F83E98A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhHKTWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhHKTWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:22:07 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91306C0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:21:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1628709700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lNfCPiEqsvC4j0wratT12NabqkYWU1ro94i4c/TmnC4=;
        b=XglRGggb+pI2XH3q6+ggFWTuR0jX4ckwAYAUmIfagJThGhgC/7QZX1hfKuOAGhq6xNszaO
        Z67Nz1sJ248zvpOiPIOsu0g5JNGjEClO3VneWk3KubQNT25rewG5JB2/7EFTDyzniZnNLi
        huZJrCjAYG/pFvA/50a16+4PbqfGX/o=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] kasan: test: avoid crashing the kernel with HW_TAGS
Date:   Wed, 11 Aug 2021 21:21:16 +0200
Message-Id: <cover.1628709663.git.andreyknvl@gmail.com>
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

Andrey Konovalov (8):
  kasan: test: rework kmalloc_oob_right
  kasan: test: avoid writing invalid memory
  kasan: test: avoid corrupting memory via memset
  kasan: test: disable kmalloc_memmove_invalid_size for HW_TAGS
  kasan: test: only do kmalloc_uaf_memset for generic mode
  kasan: test: clean up ksize_uaf
  kasan: test: avoid corrupting memory in copy_user_test
  kasan: test: avoid corrupting memory in kasan_rcu_uaf

 lib/test_kasan.c        | 74 ++++++++++++++++++++++++++++-------------
 lib/test_kasan_module.c | 20 +++++------
 2 files changed, 60 insertions(+), 34 deletions(-)

-- 
2.25.1

