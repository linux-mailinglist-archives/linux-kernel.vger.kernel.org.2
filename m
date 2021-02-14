Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B88F31B1E4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhBNSTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 13:19:16 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:37969 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhBNSTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 13:19:13 -0500
Received: by mail-io1-f50.google.com with SMTP id f6so4647644ioz.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 10:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uhe7FNxfl3eAYbBDyrWuMB4meish9hrXfBwq41jpn7c=;
        b=titWdTwZ9a0gcQBw26LzfWYNHfn3rnSUYPE25xoO1rIMW7jwYiLs6wQYqRH6y8tMpF
         ZHDfb0/fPgGDm/UphRw2M3NNXmBDycX3RhccgAG7hGJp4cBpFg40PN+RQmERXLOPjnf0
         VCeJsRatLhZvXUrIh4yKGaI4SSp53WmPy86FqRgGIh3r1+NYN2maqxX7sse76qOmE9uQ
         QHhcLJ5SeZDvxmHUJClghB1OikE4Ig0L2qfyBkoAXeawblOS430nWLVFfnP/+qorwaTl
         ATtNqydspt+lM8F1ZH3jdtUjXB/YmQYTbl4TXH4ISKO+dj0TttRJ8NdQUgxwY0jhv2Vk
         KAyA==
X-Gm-Message-State: AOAM5320KIpFIfFSR68+XN3MXZqHO1TFk+WFMT/IXJrThhM11j+Hd4ms
        NFp97sJJYiJ6bl0jt4q4fYg=
X-Google-Smtp-Source: ABdhPJyHercrGg7WtnXSrJyU2wld6jg06HYiCyVQMWpDOJXDcmd/dvKQR5YvHnMBL/uDyRLnl4+bUA==
X-Received: by 2002:a6b:c913:: with SMTP id z19mr10240609iof.60.1613326712269;
        Sun, 14 Feb 2021 10:18:32 -0800 (PST)
Received: from abasin.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id r9sm8309575ill.72.2021.02.14.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 10:18:31 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] percpu: fix clang modpost section mismatch
Date:   Sun, 14 Feb 2021 18:18:02 +0000
Message-Id: <20210214181802.896248-1-dennis@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcpu_build_alloc_info() is an __init function that makes a call to
cpumask_clear_cpu(). With CONFIG_GCOV_PROFILE_ALL enabled, the inline
heuristics are modified and such cpumask_clear_cpu() which is marked
inline doesn't get inlined. Because it works on mask in __initdata,
modpost throws a section mismatch error.

Arnd sent a patch with the flatten attribute as an alternative [2]. I've
added it to compiler_attributes.h.

modpost complaint:
  WARNING: modpost: vmlinux.o(.text+0x735425): Section mismatch in reference from the function cpumask_clear_cpu() to the variable .init.data:pcpu_build_alloc_info.mask
  The function cpumask_clear_cpu() references
  the variable __initdata pcpu_build_alloc_info.mask.
  This is often because cpumask_clear_cpu lacks a __initdata
  annotation or the annotation of pcpu_build_alloc_info.mask is wrong.

clang output:
  mm/percpu.c:2724:5: remark: cpumask_clear_cpu not inlined into pcpu_build_alloc_info because too costly to inline (cost=725, threshold=325) [-Rpass-missed=inline]

[1] https://lore.kernel.org/linux-mm/202012220454.9F6Bkz9q-lkp@intel.com/
[2] https://lore.kernel.org/lkml/CAK8P3a2ZWfNeXKSm8K_SUhhwkor17jFo3xApLXjzfPqX0eUDUA@mail.gmail.com/

Reported-by: kernel test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 include/linux/compiler_attributes.h | 6 ++++++
 mm/percpu.c                         | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index ea5e04e75845..c043b8d2b17b 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -210,6 +210,12 @@
 # define fallthrough                    do {} while (0)  /* fallthrough */
 #endif
 
+/*
+ * gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#flatten
+ */
+# define __flatten			__attribute__((flatten))
+
 /*
  * Note the missing underscores.
  *
diff --git a/mm/percpu.c b/mm/percpu.c
index 80f8f885a990..6596a0a4286e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2663,7 +2663,7 @@ early_param("percpu_alloc", percpu_alloc_setup);
  * On success, pointer to the new allocation_info is returned.  On
  * failure, ERR_PTR value is returned.
  */
-static struct pcpu_alloc_info * __init pcpu_build_alloc_info(
+static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
 				size_t reserved_size, size_t dyn_size,
 				size_t atom_size,
 				pcpu_fc_cpu_distance_fn_t cpu_distance_fn)
-- 
2.30.0.478.g8a0d178c01-goog

