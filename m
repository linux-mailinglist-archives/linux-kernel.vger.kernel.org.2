Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933DC32BFBE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580112AbhCCSdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348491AbhCCRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yk5hew9EWxKSUOJsRRgQSnvH+BMlTy0ZCJsrZVtQ1Oc=;
        b=J+dHjUAwW1Xk/L88udyyN8IUhKs1lrbFeL/0XX9vfn6IpjT58cXueX3GwOMx0Psl/nstZU
        nhbufgXunsgYuu2T5J3Al0ncV9Nf1uGgH/YhPeJ5A3o4lswcWiLxk+oNn/xskeeF1JVPWG
        Q4WOjsHeYmZlqysp2z4HjgtCqcPaLRk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-WhkIGxLKMa6lXxY9iAJxsg-1; Wed, 03 Mar 2021 12:06:03 -0500
X-MC-Unique: WhkIGxLKMa6lXxY9iAJxsg-1
Received: by mail-wr1-f71.google.com with SMTP id y5so2557652wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yk5hew9EWxKSUOJsRRgQSnvH+BMlTy0ZCJsrZVtQ1Oc=;
        b=IavGZuoWE0XEIjT8YtwcEdjsx6/1n3VK2V7B83hu51rBGy5NBT9pEDDdKmJygg3FZo
         ZBpFmb5FeyzoI+i1anYD3DimXzFyYmpIWKBJepry3ypjqdU187neqfLr22kzkcC3Hr0n
         NYqSOsmhpmRocnSAwGr07ltrhbzEU2yYay8CWSM5jqBqhgFnOX3BUJMpUPr3vo3Hh/XI
         n8cszn25TvBuvqpuuNc6CnPVC+WfqNaIP8VD431x8kKkweEYLFdaFSMoGyHAFE3pHqbC
         IUut4E5b6tdn7r8I+LSqeTxh3oWW0XOXpcqLPoR7pyZQXFiwnphz7zaZmuc3N1EXwTrg
         o2QQ==
X-Gm-Message-State: AOAM533oG+y8C7MAkuVckcyxVQJlnBz4x6J4riSEDs+Y6QB9rN35u5t5
        zR5Kjj+YSq/tcum51wqH13DxE8XnbtYFOHxZWgGo+FiwnBmPTYWWQ00KUpeZkELRj+jflHDBTxv
        8SQTCxU0K4nXCKTegirmbDKVxi+aDWhs7oWBTWE4kwGuMAXd8Ixtai7IPe8vHRkwxUOlpjVur+E
        qi
X-Received: by 2002:adf:de92:: with SMTP id w18mr27975106wrl.217.1614791161468;
        Wed, 03 Mar 2021 09:06:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVb38s51jSJeLfyUquwBfMh6UgqoJPoyXtTvGV66gDQkofnbwtYWw0E77rPTtrMzUBW9GCjg==
X-Received: by 2002:adf:de92:: with SMTP id w18mr27975085wrl.217.1614791161210;
        Wed, 03 Mar 2021 09:06:01 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id d29sm32957827wra.51.2021.03.03.09.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:06:00 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 4/8] arm64: Move instruction encoder/decoder under lib/
Date:   Wed,  3 Mar 2021 18:05:32 +0100
Message-Id: <20210303170536.1838032-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170536.1838032-1-jthierry@redhat.com>
References: <20210303170536.1838032-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aarch64 instruction set encoding and decoding logic can prove useful
for some features/tools both part of the kernel and outside the kernel.

Isolate the function dealing only with encoding/decoding instructions,
with minimal dependency on kernel utilities in order to be able to reuse
that code.

Code was only moved, no code should have been added, removed nor
modifier.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/kernel/Makefile        | 2 +-
 arch/arm64/lib/Makefile           | 6 +++---
 arch/arm64/{kernel => lib}/insn.c | 0
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm64/{kernel => lib}/insn.c (100%)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 790af8c69338..027f06cb75ff 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -13,7 +13,7 @@ CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-common.o entry-fpsimd.o process.o ptrace.o	\
 			   setup.o signal.o sys.o stacktrace.o time.o traps.o	\
-			   io.o vdso.o hyp-stub.o psci.o cpu_ops.o insn.o	\
+			   io.o vdso.o hyp-stub.o psci.o cpu_ops.o		\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index d31e1169d9b8..9cd83908717d 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   copy_to_user.o copy_in_user.o copy_page.o		\
-		   clear_page.o csum.o memchr.o memcpy.o memmove.o	\
-		   memset.o memcmp.o strcmp.o strncmp.o strlen.o	\
-		   strnlen.o strchr.o strrchr.o tishift.o
+		   clear_page.o csum.o insn.o memchr.o memcpy.o		\
+		   memmove.o memset.o memcmp.o strcmp.o strncmp.o	\
+		   strlen.o strnlen.o strchr.o strrchr.o tishift.o
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
 obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/lib/insn.c
similarity index 100%
rename from arch/arm64/kernel/insn.c
rename to arch/arm64/lib/insn.c
-- 
2.25.4

