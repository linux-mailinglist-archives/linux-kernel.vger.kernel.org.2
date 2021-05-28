Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7D33947BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhE1UEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhE1UEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:04:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD13C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:02:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v5so6704444ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8CjTgaGzpx1tYGvhyBdGCwHJ4sxt2qfBMHTKvcLBoYI=;
        b=guVGVqm5w4Gp5nI7wKkyRYFCD9Lg0ZOgq/cUtfOp2H4QhlW35tXSAzsOj5EZIRWbOG
         nnMcXcFUWE3Too9xx42l0SmsRo5hOUkH8gbP27+ooNGJcv0nzRsViNgZkaaII/xBCzwX
         Q1wMhkTUseZPtOBWqvKGKmFFDZTlTI6DeTcZvhiAns77XwdKe5+6V7pLgWQWUJGx9hpN
         1LqHVaV7gNXs0Xeyuf8vul2C8lD93CIB4VS9ofqgAY2WXSTapuTYXLGz/jyrxMOAFMRI
         DKq4FrBu8qnGUCp58TmUUohzp8gQeVTMA8Na5PhWQ1run7itfzx8qYb0Kt4PWbV+0Q1N
         RORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8CjTgaGzpx1tYGvhyBdGCwHJ4sxt2qfBMHTKvcLBoYI=;
        b=CK4Xh+DdbDKCgKvZPBx3omlbDykSnDncLiX5pPYW9SMOL57oqpHwws9XNxbYprIIgl
         DbEQ6DSi5ynY0gLmvSd8naZS1RH/mnsNBOS6ch1F0CsL6WRDBjP+N6M4msWO2AIz7sBr
         pP6eRj/4dmkv3qwLM3KfmBsGvTThGk7pMizIOxR6WyUaUQUXWfNkiRay8Wfj2e+hfCgr
         s/TaT5JH88n8S6sdFsgUmHB+qHZdKvByHGbc2JxC0UjPh2adOaOQksQ2zHzY6SN7E24o
         SRJRExf9osPKJ9a4rgH6FT3mdsjmCf9v/knvL6jkkjh9ukn7V95vbulztymoceVe2fXN
         0jGg==
X-Gm-Message-State: AOAM531nnbWff7koQhlrX0Wfl3Yx+DSWbPKv7vlOCsYy2ekwHy01mzdr
        Tf6etuLcCUNLUtVr4W2DIcE=
X-Google-Smtp-Source: ABdhPJwGIEWVmiDMVUkMC7T1pcLqU5qlF/Npl4OwNq6xxgsb/nRP6oBvDiV0yw2jGcnL4RmZwzp88w==
X-Received: by 2002:a05:651c:4c6:: with SMTP id e6mr7853378lji.326.1622232164523;
        Fri, 28 May 2021 13:02:44 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yg81q1---xrfn1y-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:bcab:6bff:fe6e:22ea])
        by smtp.gmail.com with ESMTPSA id h29sm600263lfv.230.2021.05.28.13.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:02:44 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     samitolvanen@google.com
Cc:     jeyu@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>
Subject: [PATCH 1/6] pgo: modules Expose module sections for clang PGO instumentation.
Date:   Fri, 28 May 2021 23:01:33 +0300
Message-Id: <20210528200133.459022-1-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables reading PGO profile data for
modules. It also contains some changes to instrumentation
code to fixup flaws when profile data is serialized from loaded modules.

To be able to export clang PGO profile data from modules into user space
we need to expose __llvm_prf_xxx sections from loaded modules.
This data is used by pgo/instrument.c and pgo/fs_mod.c in following patches.

====
The patch is based on Sami Tolvanen's earlier code: [1]
Patch https://lore.kernel.org/linux-doc/20210407211704.367039-1-morbo@google.com/
and kernel v5.13-rc3 was used as starting point for my changes.

Be kind, I'm an kernel newbie and this is my first git send-mail. :-)

[1] https://patchwork.kernel.org/project/linux-kbuild/patch/20210407211704.367039-1-morbo@google.com/
====
Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
 include/linux/module.h | 12 +++++++++++-
 kernel/module.c        |  8 +++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 8100bb477d86..2aa1e1fe4afa 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -504,7 +504,6 @@ struct module {
 	/* Elf information */
 	struct klp_modinfo *klp_info;
 #endif
-
 #ifdef CONFIG_MODULE_UNLOAD
 	/* What modules depend on me? */
 	struct list_head source_list;
@@ -527,6 +526,17 @@ struct module {
 	struct error_injection_entry *ei_funcs;
 	unsigned int num_ei_funcs;
 #endif
+#ifdef CONFIG_PGO_CLANG
+	/* Clang PGO llvm_prf_xxx sections */
+	void *prf_data; /* struct llvm_prf_data */
+	int prf_data_size;
+	u64 *prf_cnts;
+	int prf_cnts_num;
+	const char *prf_names;
+	int prf_names_num;
+	void *prf_vnds; /* struct llvm_prf_value_node */
+	int prf_vnds_size;
+#endif
 } ____cacheline_aligned __randomize_layout;
 #ifndef MODULE_ARCH_INIT
 #define MODULE_ARCH_INIT {}
diff --git a/kernel/module.c b/kernel/module.c
index 7e78dfabca97..e49de3b95d87 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3342,7 +3342,13 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 
 	info->debug = section_objs(info, "__dyndbg",
 				   sizeof(*info->debug), &info->num_debug);
-
+#ifdef CONFIG_PGO_CLANG
+    /* Grab module sections for Clang PGO profiler to hook into */
+	mod->prf_data = section_objs(info, "__llvm_prf_data", 1, &mod->prf_data_size);
+	mod->prf_cnts = section_objs(info, "__llvm_prf_cnts", sizeof(u64), &mod->prf_cnts_num);
+	mod->prf_names = section_objs(info, "__llvm_prf_names", sizeof(char), &mod->prf_names_num);
+	mod->prf_vnds = section_objs(info, "__llvm_prf_vnds", 1, &mod->prf_vnds_size);
+#endif
 	return 0;
 }
 
-- 
2.31.1

