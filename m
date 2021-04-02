Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174F4353035
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbhDBUWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhDBUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:22:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7340BC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 13:22:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 12so8911628lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMrRePfGs1rF/T8z45CYbyde8SGCiB/0IWN15dBKTJI=;
        b=K/dv6wv+PFj+4PI8hAV+9SsaiW/csXqkRnIg0Lhz25DtvvFyM5j4fzl5WAlAbqsO+N
         PAa2YIePQr+RXXRmAxCIVT0HcpHgkZpsN65u1on1d2/XZ1oHKHnDWMJjH9ZD4ms7dYXv
         r7JhzLv4NQN5Io/A0HWsKHulRwwGxcAHSn07B5GjiZbsmeTXz/heoPGD0Lku7RBtKpiM
         r253J8ed/4MfFl72mCLyjCEb+0GS/c/T6yH8o0Nqe7QNiir1s6NI1XE5TOlQc80gh9gq
         rnTPEFs7cwieMQKbyrqBKwyw1SNeh4hE8BKcfyAyUIZ9vanSlTL0nL4jCdAUyktHL8nA
         pUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMrRePfGs1rF/T8z45CYbyde8SGCiB/0IWN15dBKTJI=;
        b=A68mI2Gu0hAWM7boRzxf64FdsUZVG25L9SOF5en8TAq8EINpPePi3HE3UVFYpilVX7
         rd9QmLC4I1G0izI3K5gN8dHKsLzEROV8Ap/0JYPR6xQ1m1rC6njO1ndaLxsYxBKtYbhE
         M/Dgh/czn/DBAdGN4M/BxEJV/Z775JpKcbOTt7S7OaPW/uiHFJKd63TPn+lwEd87tW/o
         x1ROm2G3x6WH0S3cwQVxoHsuu1CbBx9RSL7zN9LdwfoWxwHF7SDOmZrR6xZHyTfSUv+S
         0ihFnxaO2Ba3D7qTzPCaO9s5P85WZrI4toaUSf1rx8K5gs76LqGHoC7dz/X4SN8nbLFY
         pK2g==
X-Gm-Message-State: AOAM533ogFa8HWfbEh44VzTCXL77ZCFxbfKkpPs4b1+XycqE7XSGoh7d
        /obPdk/DQomuvI3BZVsFYbc=
X-Google-Smtp-Source: ABdhPJxK5ZwN9Lka2IUo+p5XW2oAQOlP4IKexiSST1atXqp4cdaQFESzv6Asos86tQX1NOCn4tJybg==
X-Received: by 2002:a19:2216:: with SMTP id i22mr9727882lfi.57.1617394968170;
        Fri, 02 Apr 2021 13:22:48 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f11sm952514lfr.119.2021.04.02.13.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 13:22:47 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH-next 1/5] lib/test_vmalloc.c: remove two kvfree_rcu() tests
Date:   Fri,  2 Apr 2021 22:22:33 +0200
Message-Id: <20210402202237.20334-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two test cases related to kvfree_rcu() and SLAB. Those are
considered as redundant now, because similar test functionality
has recently been introduced in the "rcuscale" RCU test-suite.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 5cf2fe9aab9e..4eb6abdaa74e 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -47,8 +47,6 @@ __param(int, run_test_mask, INT_MAX,
 		"\t\tid: 128,  name: pcpu_alloc_test\n"
 		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
 		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
-		"\t\tid: 1024, name: kvfree_rcu_1_arg_slab_test\n"
-		"\t\tid: 2048, name: kvfree_rcu_2_arg_slab_test\n"
 		/* Add a new test case description here. */
 );
 
@@ -363,42 +361,6 @@ kvfree_rcu_2_arg_vmalloc_test(void)
 	return 0;
 }
 
-static int
-kvfree_rcu_1_arg_slab_test(void)
-{
-	struct test_kvfree_rcu *p;
-	int i;
-
-	for (i = 0; i < test_loop_count; i++) {
-		p = kmalloc(sizeof(*p), GFP_KERNEL);
-		if (!p)
-			return -1;
-
-		p->array[0] = 'a';
-		kvfree_rcu(p);
-	}
-
-	return 0;
-}
-
-static int
-kvfree_rcu_2_arg_slab_test(void)
-{
-	struct test_kvfree_rcu *p;
-	int i;
-
-	for (i = 0; i < test_loop_count; i++) {
-		p = kmalloc(sizeof(*p), GFP_KERNEL);
-		if (!p)
-			return -1;
-
-		p->array[0] = 'a';
-		kvfree_rcu(p, rcu);
-	}
-
-	return 0;
-}
-
 struct test_case_desc {
 	const char *test_name;
 	int (*test_func)(void);
@@ -415,8 +377,6 @@ static struct test_case_desc test_case_array[] = {
 	{ "pcpu_alloc_test", pcpu_alloc_test },
 	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test },
 	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test },
-	{ "kvfree_rcu_1_arg_slab_test", kvfree_rcu_1_arg_slab_test },
-	{ "kvfree_rcu_2_arg_slab_test", kvfree_rcu_2_arg_slab_test },
 	/* Add a new test case here. */
 };
 
-- 
2.20.1

