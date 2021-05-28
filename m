Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8346B3947CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhE1UMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhE1UL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:11:57 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA2C061760
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:10:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s25so6732921ljo.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zRtz6gK/225LmKBawe8JmKSmjRSkTz4Gg05ZHMiOgL8=;
        b=CTDR1zgIjoDBn6W567XmSLFxVZQmvzLiGTETQYS1CVz+1WS4HZdqGxEm3zuVXkdQmW
         MXyQbzum4X+nmYJEe3pbNYB7HI0mR2jI74bOq1csS92TPF9rJQyF4k8bW5zTNbtXXqc9
         +nix430sVDkr5jCx1SMEDWSbqcqFaGnTOBHqdZqFHgIYGBY+DoOwhAsjRirOhv1bnMUj
         ljruXTlF/JwMuMWOEzwIqP4EYcPuwsPKJRQJWIGa0hmVznTQVl7JWmSqwOL1pwBuIA22
         UXikLMyfJzGJJwE7l/LHYXV320f/Wi42g6mN9TDLJ+bX+ksMsKn4ExSxn0w4fZTkOuiM
         paZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zRtz6gK/225LmKBawe8JmKSmjRSkTz4Gg05ZHMiOgL8=;
        b=bSj44aoOnVOhVEolFyMxLUrf5hepA0FPzIWncPTf/mk8BR23BroY1fwukT43rQh8Jf
         2LV3QIzgTQ74RGYkAvsKzkDBwi0+nX/A/P7twYAzqkCxg8VFEbti9eBk2xwcfsWqs4TV
         B7kVXX1PLvwJlE8WbA3/2755yxlp7EiW9ED/84EWt87txMybs9oY/Sm8P+4e1aku2QeF
         erqwNZ5Y0ILwHc6/yMZtMM37fqeAbD/TGFbXdclxysMpgDpXaLUMAw/vtKGM0Us3UCJ0
         RkpzDRnlTMxoctuQVqOzwKMC3AKOvZF6WXXornnyp4JJbX579KMo2voFXi7mK0uNGTUY
         fN9w==
X-Gm-Message-State: AOAM533e48ZZgc2k1Bv3rXeZ6DsZxMoHIn7eJkfsaO4gTVRF2XNko6L7
        pWDCkd2BoxRo6PMwMvqhyRE=
X-Google-Smtp-Source: ABdhPJwcQGaZ0OwQ9qDCFAEj9evnQAdtpbtM5GJ7TMt4F6tbNOwEKwqx/zk0ZrMl4mpgE70iIxd0Fg==
X-Received: by 2002:a05:651c:3c9:: with SMTP id f9mr7842438ljp.403.1622232619293;
        Fri, 28 May 2021 13:10:19 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yg81q1---xrfn1y-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:bcab:6bff:fe6e:22ea])
        by smtp.gmail.com with ESMTPSA id o14sm549724lfr.94.2021.05.28.13.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:19 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     samitolvanen@google.com
Cc:     wcw@google.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>
Subject: [PATCH 4/6] pgo: modules Enable __llvm_profile_instrument_target() for modules
Date:   Fri, 28 May 2021 23:10:06 +0300
Message-Id: <20210528201006.459292-1-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable allocate_node() for modules.

Before this patch __llvm_profile_instrument_target() profiled all
code which was instrumented, including modules.
Any module profiling was however effectively disabled by allocate_node()
if llvm_prf_data instance didn't point into core section.

Handle profiling data that orginates from modules by iterating
prf_mod_list and checking in what module the llvm_prf_data instance
points into.
If matching module is found the node is allocated from that module.
Each module has then its own current_node index.
The list iteration is protected by rcu here to avoid extra mutex.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
 kernel/pgo/instrument.c | 65 +++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
index 98cfa11a7b76..a95c86d668b5 100644
--- a/kernel/pgo/instrument.c
+++ b/kernel/pgo/instrument.c
@@ -31,7 +31,7 @@
  * ensures that we don't try to serialize data that's only partially updated.
  */
 static DEFINE_SPINLOCK(pgo_lock);
-static int current_node;
+static int current_node = 0;
 
 unsigned long prf_lock(void)
 {
@@ -55,17 +55,58 @@ void prf_unlock(unsigned long flags)
 static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
 						 u32 index, u64 value)
 {
-	if (&__llvm_prf_vnds_start[current_node + 1] >= __llvm_prf_vnds_end)
-		return NULL; /* Out of nodes */
-
-	current_node++;
-
-	/* Make sure the node is entirely within the section */
-	if (&__llvm_prf_vnds_start[current_node] >= __llvm_prf_vnds_end ||
-	    &__llvm_prf_vnds_start[current_node + 1] > __llvm_prf_vnds_end)
-		return NULL;
-
-	return &__llvm_prf_vnds_start[current_node];
+    struct prf_mod_private_data *pmod;
+    struct llvm_prf_data *start = __llvm_prf_data_start;
+    struct llvm_prf_data *end = __llvm_prf_data_end;
+    struct module * mod;
+    struct llvm_prf_value_node * vnds = __llvm_prf_vnds_start;
+    struct llvm_prf_value_node * vnds_end = __llvm_prf_vnds_end;
+
+    if(start <= p && p < end) {
+        /* vmlinux core node */
+        if (&vnds[current_node + 1] >= vnds_end)
+            return NULL; /* Out of nodes */
+
+        current_node++;
+
+        /* Make sure the node is entirely within the section
+         */
+        if (&vnds[current_node] >= vnds_end ||
+            &vnds[current_node + 1] > vnds_end)
+            return NULL;
+
+        return &vnds[current_node];
+
+    } else {
+        /* maybe an module node
+         * find in what module section p points into and
+         * then allocate from that module
+         */
+        rcu_read_lock();
+        list_for_each_entry_rcu(pmod,&prf_mod_list,link) {
+            mod = READ_ONCE(pmod->mod);
+            if(mod) {
+                /* get section bounds */
+                start = mod->prf_data;
+                end = mod->prf_data + mod->prf_data_size;
+                if(start <= p && p < end)
+                {
+                    vnds = mod->prf_vnds;
+                    vnds_end = mod->prf_vnds + mod->prf_vnds_size;
+                    if (&vnds[pmod->current_node + 1] < vnds_end) {
+                        pmod->current_node++;
+
+                        vnds = &vnds[pmod->current_node];
+                        rcu_read_unlock();
+                        return vnds;
+                        break;
+                    }
+                }
+            }
+        }
+        rcu_read_unlock();
+        return NULL; /* Out of nodes */
+    }
 }
 
 /*
-- 
2.31.1

