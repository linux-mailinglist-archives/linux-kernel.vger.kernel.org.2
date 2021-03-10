Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8028334624
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhCJR7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhCJR6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:53 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA53C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:53 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id o7so13499516qtw.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qkIv/Dj8eNtVWTw/hqhsYIXxQswk0/NCtZ2mXt61vt4=;
        b=Yd6qXdpHhKJCGS2nS6b73itvEp4TXHoB4WqOXle6O5tLkJBJPw/XtiPR/uKeu43swS
         2hvS/aF6Anvw1YMOPyb5/0LqiiPvfB0aL64RNhlAz42c75kMdBUkplEzK+yFBXNQ6fyQ
         J/nbBIcWvsjxT1kGPNG/ru1ol04BtoCNsl4j5yN3RA+BegfK37UCg92KsBMRdyqOwIKd
         jYHjj6ABnTFkH96MW2j3xNeVLtIeiTKy+FdXKciOBIb7A4k5eusNa3eNL2V3Pe6/NjVY
         Cfa4vxJHinlwjdhhlyquWiYMJZUzIssWJwFW9dFCLf208MYkzWGv7Z4GyP9hNnulY8Hr
         GKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qkIv/Dj8eNtVWTw/hqhsYIXxQswk0/NCtZ2mXt61vt4=;
        b=b5PzDThktHteO21okI9KBGe0IR4qWwVGpQdytiNffneXsL7aEYZZMovsiB3paCLoAq
         u00aeG0YukRFSeRMQXkbPGK9BEWvsxQLHu6Lf1RDSwtMcXAB4eitbSJKc9jQvQOQzlBZ
         K2a5YzhZ53ET7ozABywKbZ4UYP+JmkbVODgenOxrpuR3tWqA844jeKanVDXJcZpm3kao
         NFEPQsapLbTFdGJYUIvw4i5mGuA3i/mcZ3qLEifyFIb64+VAIDX0L1IP8bWD/1DBtRzU
         oW/eQzkAtgm36RGJ0fBpzJ7kf6p42nrq5BZvv7hHLQL07CCZfAhsMmuYr5kMzWx0n2FO
         hJiA==
X-Gm-Message-State: AOAM5325rGdvFmpCd09BBRF2aHkBjBfU4QvwYWhC7jC6VQSai5V6y3Cb
        sxofNOJOUouodG3iqywEJR0RdU4BRinO
X-Google-Smtp-Source: ABdhPJxlCTx9p7rzRSKY5hPCMXHH9PbCR3/vxNwiQaM6JpLBZ/W3y1yrQSuLj+BwkUwpvNqFCqkE++nkXuKm
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:1909:: with SMTP id
 er9mr4159347qvb.5.1615399132338; Wed, 10 Mar 2021 09:58:52 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:43 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-27-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 26/34] KVM: arm64: Sort the hypervisor memblocks
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon need to check if a Physical Address belongs to a memblock
at EL2, so make sure to sort them so this can be done efficiently.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/reserved_mem.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/kvm/hyp/reserved_mem.c b/arch/arm64/kvm/hyp/reserved_mem.c
index fd42705a3c26..83ca23ac259b 100644
--- a/arch/arm64/kvm/hyp/reserved_mem.c
+++ b/arch/arm64/kvm/hyp/reserved_mem.c
@@ -6,6 +6,7 @@
 
 #include <linux/kvm_host.h>
 #include <linux/memblock.h>
+#include <linux/sort.h>
 
 #include <asm/kvm_host.h>
 
@@ -18,6 +19,23 @@ static unsigned int *hyp_memblock_nr_ptr = &kvm_nvhe_sym(hyp_memblock_nr);
 phys_addr_t hyp_mem_base;
 phys_addr_t hyp_mem_size;
 
+static int cmp_hyp_memblock(const void *p1, const void *p2)
+{
+	const struct memblock_region *r1 = p1;
+	const struct memblock_region *r2 = p2;
+
+	return r1->base < r2->base ? -1 : (r1->base > r2->base);
+}
+
+static void __init sort_memblock_regions(void)
+{
+	sort(hyp_memory,
+	     *hyp_memblock_nr_ptr,
+	     sizeof(struct memblock_region),
+	     cmp_hyp_memblock,
+	     NULL);
+}
+
 static int __init register_memblock_regions(void)
 {
 	struct memblock_region *reg;
@@ -29,6 +47,7 @@ static int __init register_memblock_regions(void)
 		hyp_memory[*hyp_memblock_nr_ptr] = *reg;
 		(*hyp_memblock_nr_ptr)++;
 	}
+	sort_memblock_regions();
 
 	return 0;
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

