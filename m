Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F73A743E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFOCqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhFOCqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:46:03 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C2BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:43:59 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q3so18567404iop.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3K1BTqaM5pKy65dpCEo3lZI1RCD2stLd5UR2x4SDMk=;
        b=X0nswPKSD51xx5SUUNgPTOxx9Nzx2H96D/YduRYRZHo+ejqCQzThCbpTVUia8QeV9R
         HdIR5kd9RP86hki3k4UkBoiYhfysqZ1n0rn+upB0o0TRnfoK96DT08O5/uKpVd6JcNjt
         W/u6S+e7PCOUhEJSpkXQzLSmHd4ODdHjB47m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3K1BTqaM5pKy65dpCEo3lZI1RCD2stLd5UR2x4SDMk=;
        b=jg4ikFP0Xo5349yBzR2kTZvT8Cl4Ai/MyhpLD5ePVY8DQbbhXYR4lc4+9jRHalNN4k
         3q54AIPTHRVmgmT/VmrZKgacXI1N4jcuX6bM7vtZ/ZQai5S4o2J4MHPs9JIAs6aRrc6C
         4wDjhdKhNcKpL9SbXPUUvkrhPNVMHLUzUe9cbabZtC8+jbGWRZHNSkaxzI40Wh5GoHCu
         pWe11OMLUJ7RUgZ39EXKOyQ0thMLon6dSRpYMeogaR2QLwlxpd529KNAgR31UZYsq9WL
         md/Kkm4OfRF+d0uBOFDUiLlx/qiYBjUllA/JTSopHzj+uegU+lBH17/wFvycEp/PDC3t
         DubQ==
X-Gm-Message-State: AOAM533UwrwZYnVk6cpImiJk1w+/O74XXeK4woZXZ+G13Pjw8r6E6rVE
        8F5v8GwIm5GjyqwPyPvJ4ygYgdXBllfd1Q==
X-Google-Smtp-Source: ABdhPJw7o9IChYHT/R02LwCZbPFFEfQ7b/20+CtiE7nlvaJ6m/AvsWXKO7fqTTME6tiaz6HvSr0q9g==
X-Received: by 2002:a63:5d52:: with SMTP id o18mr19853904pgm.440.1623721647575;
        Mon, 14 Jun 2021 18:47:27 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id n6sm14378524pgm.79.2021.06.14.18.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 18:47:27 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     elver@google.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v12 4/6] kasan: Document support on 32-bit powerpc
Date:   Tue, 15 Jun 2021 11:47:03 +1000
Message-Id: <20210615014705.2234866-5-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210615014705.2234866-1-dja@axtens.net>
References: <20210615014705.2234866-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN is supported on 32-bit powerpc and the docs should reflect this.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/dev-tools/kasan.rst |  8 ++++++--
 Documentation/powerpc/kasan.txt   | 12 ++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 83ec4a556c19..05d2d428a332 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -36,7 +36,8 @@ Both software KASAN modes work with SLUB and SLAB memory allocators,
 while the hardware tag-based KASAN currently only supports SLUB.
 
 Currently, generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390,
-and riscv architectures, and tag-based KASAN modes are supported only for arm64.
+and riscv architectures. It is also supported on 32-bit powerpc kernels.
+Tag-based KASAN modes are supported only for arm64.
 
 Usage
 -----
@@ -343,7 +344,10 @@ CONFIG_KASAN_VMALLOC
 
 With ``CONFIG_KASAN_VMALLOC``, KASAN can cover vmalloc space at the
 cost of greater memory usage. Currently, this is supported on x86,
-riscv, s390, and powerpc.
+riscv, s390, and 32-bit powerpc.
+
+It is optional, except on 32-bit powerpc kernels with module support,
+where it is required.
 
 This works by hooking into vmalloc and vmap and dynamically
 allocating real shadow memory to back the mappings.
diff --git a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
new file mode 100644
index 000000000000..26bb0e8bb18c
--- /dev/null
+++ b/Documentation/powerpc/kasan.txt
@@ -0,0 +1,12 @@
+KASAN is supported on powerpc on 32-bit only.
+
+32 bit support
+==============
+
+KASAN is supported on both hash and nohash MMUs on 32-bit.
+
+The shadow area sits at the top of the kernel virtual memory space above the
+fixmap area and occupies one eighth of the total kernel virtual memory space.
+
+Instrumentation of the vmalloc area is optional, unless built with modules,
+in which case it is required.
-- 
2.27.0

