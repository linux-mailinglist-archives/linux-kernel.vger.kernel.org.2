Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D417B3947D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhE1UOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhE1UN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:13:57 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46234C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:12:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 131so6794650ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=730RyWLlIkS/afgq41VA6uiOuJV1jg//1PGLIJFflks=;
        b=BQ50FtejrBVyVqQUY/NBLy9VUR41u+QA76G1LEStdWRUZebctaoGJgefENCsC7X3uH
         mwgWf7xp+6cFf1urBc6X1nv4zEHIqt+VkUoE9UGXVCiyBRj4+8oJqGy6RkSQaea3NBVn
         sdabQBUwfPQFqjJYzAjQN8EljA8VVRPttQBB0a5d2aoRPVNZ3+0tSLxGljTQ4eh60ra3
         hxygaZwSLfmGUvC9jVjchooqV/hKujjWUcXY6uvMlyDh6SBVH8EdXGmsgEgdOu6HDK27
         uREc2v2lkqfZs4jGf+ubCqr0fHadrZlpndswfMDvDUtWmJUGiLll7a1aBR5+86kwiUHG
         TjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=730RyWLlIkS/afgq41VA6uiOuJV1jg//1PGLIJFflks=;
        b=IQ5SUxmImDCzTQCjwowKiJkb+Qx/AcO39Q3UafpxfuSEJpiUoxt57frrkRBhrvfDb2
         Hqa0C2PfPH7VPuv/yACpysXRXFsSd2y7rkpnaeHGi5TZ5yeB05ZZzh4Hz7rkLJYnhTYN
         yV7YrKqqLXkKn+yanLHNQiL9TdtR/n31koJ/FeQ+Xv0QfKqY0LTywhRPtIT9WyIQ3Dyq
         y6UWNKvxicgGtRcbWeOvUM0MnwgSr40sh7CjhlGJ4RsUTDa7K3z6jEhadIZnQu+W7rOl
         d5ylkdvKHkfB6JI9TlR8JRvGNjugQatfYrLNLVUzBvnuhQtYqUlC42rzOIR1MyDdBDQf
         Ooqw==
X-Gm-Message-State: AOAM532AG+ycflimJVQUuvHXszWCPLyqWHkgzbMtrG0Rh4Hn7+GX+f6N
        iWnsQqalwDRufNFWsWtR37c=
X-Google-Smtp-Source: ABdhPJxv2uOke6XN8IS5T4v7yudXiebRpa/quKhMDWEqh5IwHgZCJ96mU+2mxHhPrtq04ix2crFY8Q==
X-Received: by 2002:a2e:b4f3:: with SMTP id s19mr7781563ljm.10.1622232739678;
        Fri, 28 May 2021 13:12:19 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yg81q1---xrfn1y-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:bcab:6bff:fe6e:22ea])
        by smtp.gmail.com with ESMTPSA id u16sm550980lfl.83.2021.05.28.13.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:12:19 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     samitolvanen@google.com
Cc:     wcw@google.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>
Subject: [PATCH 6/6] pgo: Fixup code style issues.
Date:   Fri, 28 May 2021 23:12:13 +0300
Message-Id: <20210528201213.459483-1-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
 kernel/pgo/instrument.c | 106 ++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
index a95c86d668b5..b30104411879 100644
--- a/kernel/pgo/instrument.c
+++ b/kernel/pgo/instrument.c
@@ -31,7 +31,7 @@
  * ensures that we don't try to serialize data that's only partially updated.
  */
 static DEFINE_SPINLOCK(pgo_lock);
-static int current_node = 0;
+static int current_node;
 
 unsigned long prf_lock(void)
 {
@@ -55,58 +55,58 @@ void prf_unlock(unsigned long flags)
 static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
 						 u32 index, u64 value)
 {
-    struct prf_mod_private_data *pmod;
-    struct llvm_prf_data *start = __llvm_prf_data_start;
-    struct llvm_prf_data *end = __llvm_prf_data_end;
-    struct module * mod;
-    struct llvm_prf_value_node * vnds = __llvm_prf_vnds_start;
-    struct llvm_prf_value_node * vnds_end = __llvm_prf_vnds_end;
-
-    if(start <= p && p < end) {
-        /* vmlinux core node */
-        if (&vnds[current_node + 1] >= vnds_end)
-            return NULL; /* Out of nodes */
-
-        current_node++;
-
-        /* Make sure the node is entirely within the section
-         */
-        if (&vnds[current_node] >= vnds_end ||
-            &vnds[current_node + 1] > vnds_end)
-            return NULL;
-
-        return &vnds[current_node];
-
-    } else {
-        /* maybe an module node
-         * find in what module section p points into and
-         * then allocate from that module
-         */
-        rcu_read_lock();
-        list_for_each_entry_rcu(pmod,&prf_mod_list,link) {
-            mod = READ_ONCE(pmod->mod);
-            if(mod) {
-                /* get section bounds */
-                start = mod->prf_data;
-                end = mod->prf_data + mod->prf_data_size;
-                if(start <= p && p < end)
-                {
-                    vnds = mod->prf_vnds;
-                    vnds_end = mod->prf_vnds + mod->prf_vnds_size;
-                    if (&vnds[pmod->current_node + 1] < vnds_end) {
-                        pmod->current_node++;
-
-                        vnds = &vnds[pmod->current_node];
-                        rcu_read_unlock();
-                        return vnds;
-                        break;
-                    }
-                }
-            }
-        }
-        rcu_read_unlock();
-        return NULL; /* Out of nodes */
-    }
+	struct prf_mod_private_data *pmod;
+	struct llvm_prf_data *start = __llvm_prf_data_start;
+	struct llvm_prf_data *end = __llvm_prf_data_end;
+	struct module *mod;
+	struct llvm_prf_value_node *vnds = __llvm_prf_vnds_start;
+	struct llvm_prf_value_node *vnds_end = __llvm_prf_vnds_end;
+
+	if (start <= p && p < end) {
+		/* vmlinux core node */
+		if (&vnds[current_node + 1] >= vnds_end)
+			return NULL; /* Out of nodes */
+
+		current_node++;
+
+		/* Make sure the node is entirely within the section
+		 */
+		if (&vnds[current_node] >= vnds_end ||
+			&vnds[current_node + 1] > vnds_end)
+			return NULL;
+
+		return &vnds[current_node];
+
+	} else {
+		/* maybe an module node
+		 * find in what module section p points into and
+		 * then allocate from that module
+		 */
+		rcu_read_lock();
+		list_for_each_entry_rcu(pmod, &prf_mod_list, link) {
+			mod = READ_ONCE(pmod->mod);
+			if (mod) {
+				/* get section bounds */
+				start = mod->prf_data;
+				end = mod->prf_data + mod->prf_data_size;
+
+				if (start <= p && p < end) {
+					vnds = mod->prf_vnds;
+					vnds_end = mod->prf_vnds + mod->prf_vnds_size;
+
+					if (&vnds[pmod->current_node + 1] < vnds_end) {
+						pmod->current_node++;
+
+						vnds = &vnds[pmod->current_node];
+						rcu_read_unlock();
+						return vnds;
+					}
+				}
+			}
+		}
+		rcu_read_unlock();
+		return NULL; /* Out of nodes */
+	}
 }
 
 /*
-- 
2.31.1

