Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38BE3E98D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhHKTea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhHKTe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:34:28 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59755C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:34:04 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1628710442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikZnRm2MVtJHm0Ia+fXtL9BHvKn2N23olNLH7huqioo=;
        b=gLxXIwemBjQyLG6H9gnaaiLf4noXa4CpUotGNEpTCNeDc+YIsb3ZUKCDdyrbZIwh+d17/k
        di/+fVQOTW/CUtH/7mP5M2cl879hHF9yRUx9absN4HBAz8+DQm5BPcIALMg4YU8IJEeUtD
        Q29ZB92XMCPsehZlG2fCGFYEv4PZ7FE=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] kasan: test: avoid corrupting memory in kasan_rcu_uaf
Date:   Wed, 11 Aug 2021 21:34:00 +0200
Message-Id: <da8d30df9206b54be2768b27bb026ec06e4da7a4.1628709663.git.andreyknvl@gmail.com>
In-Reply-To: <cover.1628709663.git.andreyknvl@gmail.com>
References: <cover.1628709663.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: andrey.konovalov@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@gmail.com>

kasan_rcu_uaf() writes to freed memory via kasan_rcu_reclaim(), which is
only safe with the GENERIC mode (as it uses quarantine). For other modes,
this test corrupts kernel memory, which might result in a crash.

Turn the write into a read.

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 lib/test_kasan_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
index fa73b9df0be4..7ebf433edef3 100644
--- a/lib/test_kasan_module.c
+++ b/lib/test_kasan_module.c
@@ -71,7 +71,7 @@ static noinline void __init kasan_rcu_reclaim(struct rcu_head *rp)
 						struct kasan_rcu_info, rcu);
 
 	kfree(fp);
-	fp->i = 1;
+	((volatile struct kasan_rcu_info *)fp)->i;
 }
 
 static noinline void __init kasan_rcu_uaf(void)
-- 
2.25.1

