Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654153EA6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbhHLOyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:54:33 -0400
Received: from out2.migadu.com ([188.165.223.204]:65070 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238178AbhHLOyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:54:19 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1628780033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFE484nExSDg5Ok/GAjUckuGCTsrDMPO22KkRkoS4wU=;
        b=pr6XeKYAMprwvuBBdX/lt+F3QwTj3fGUhv4IEAotjC/4BaZkHHf7XeolnzIweVIW6LCyyW
        EPOKOwqPtC2QGXfPPurU+h1aTQa1PmDAu7Tgj0c3dqunydSrIQDWGL7bYCjuzOVAWNhYsn
        YcmE+DR0rDAgOM8kUwC5Bk0rGoGw/lg=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] kasan: test: only do kmalloc_uaf_memset for generic mode
Date:   Thu, 12 Aug 2021 16:53:32 +0200
Message-Id: <2e1c87b607b1292556cde3cab2764f108542b60c.1628779805.git.andreyknvl@gmail.com>
In-Reply-To: <cover.1628779805.git.andreyknvl@gmail.com>
References: <cover.1628779805.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: andrey.konovalov@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@gmail.com>

kmalloc_uaf_memset() writes to freed memory, which is only safe with the
GENERIC mode (as it uses quarantine). For other modes, this test corrupts
kernel memory, which might result in a crash.

Only enable kmalloc_uaf_memset() for the GENERIC mode.

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 lib/test_kasan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 1f533a7346d9..1dcba6dbfc97 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -534,6 +534,12 @@ static void kmalloc_uaf_memset(struct kunit *test)
 	char *ptr;
 	size_t size = 33;
 
+	/*
+	 * Only generic KASAN uses quarantine, which is required to avoid a
+	 * kernel memory corruption this test causes.
+	 */
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
+
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
-- 
2.25.1

