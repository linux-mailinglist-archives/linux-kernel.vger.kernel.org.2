Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97A3947D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhE1UMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhE1UMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:12:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:11:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r5so7010157lfr.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFwW7XSfRNsT3aVWbSn7LULfilPfTjG62qQhaigJR5c=;
        b=ZNdLRror0pn19p7uk00GzZaNSenk8XqlWfTCrVR+jaDZejhhZrWZyJlTXxBS2Cx+xD
         K+25E150fWJDiLyUVJXXdrYv0oMwFOAjWtiCqu6WqP36l43eouWbfrHRQklMwl+UYqUp
         lQXKvJ7KfSZda5bIxXoHHhO0QrfmhzfNAuRK1eaJ50SeeM0I83c+1X0TBDGgoQ7hxGuH
         las9tONL1mPRZ6Bqgdx5GIJSZNrmaRz4qYPbMcOoYE4wugCE2oMKV+lgWcbEMESDEk7C
         c3m58l5E/F/Y2vuHqPWmxFVTwTubfn1pmt1vingxEN38sTElMn8VBxMZDSPuysNDwYbH
         JEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFwW7XSfRNsT3aVWbSn7LULfilPfTjG62qQhaigJR5c=;
        b=Pz0z0edG+SMT6qED2E9lXJYdLeLFQkfWK2VGK7UyzsdDH3OhBatqfegBW536kgH2eK
         qariCVg0WgX8Q4DCY1kAq4H+zkLyN9SngZHn7ivVMmOT2+PnqkNQEWUYay46sRJl0jxo
         V03fWcWkFMfYYv1cQnHTGYA2b6RnIBoWfTx4mOA1L87E2/2J4F41Qrvq1EBS0jk8Eo4U
         kM0oF760hWpWPmF9tLZCG5AbCE0rric3bnH7JblGwK2oJreerA3Lp8576VxPObq7Fo22
         a/qFqQlIvQdZtMQQoNNNWuWJg1n31unhV2yUiVpUru1adom/PkQsWq5S0k+6Vj6/Nx+0
         JTdA==
X-Gm-Message-State: AOAM531tSszkXbyhLNUYoWTmUMDcKxbmd8ap6dQD04k87py0A5YXb+iZ
        /NsGOkrtrokBDRVnd3sUqzZBMBPRJJfi5Q==
X-Google-Smtp-Source: ABdhPJzuWuGng2Odnxye6vSefkZru5iSHBNHGPdxd2Q9eNH0fNvw4loXJnRz7vd7uJ7yGD9CuLuqfQ==
X-Received: by 2002:a05:6512:3487:: with SMTP id v7mr7055648lfr.467.1622232675866;
        Fri, 28 May 2021 13:11:15 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yg81q1---xrfn1y-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:bcab:6bff:fe6e:22ea])
        by smtp.gmail.com with ESMTPSA id v26sm548511lfd.291.2021.05.28.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:11:15 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     samitolvanen@google.com
Cc:     wcw@google.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>
Subject: [PATCH 5/6] pgo: modules Fixup memory leak.
Date:   Fri, 28 May 2021 23:11:07 +0300
Message-Id: <20210528201107.459362-1-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
 kernel/pgo/fs_mod.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/pgo/fs_mod.c b/kernel/pgo/fs_mod.c
index 0808d44227f1..2d1ff99e7982 100644
--- a/kernel/pgo/fs_mod.c
+++ b/kernel/pgo/fs_mod.c
@@ -261,6 +261,8 @@ static int prf_module_open(struct inode *inode, struct file *file)
 
 				if (!pinfo->buffer) {
 					err = -ENOMEM;
+					kfree(pinfo);
+					module_put(mod);
 					goto out;
 				}
 			}
@@ -373,7 +375,7 @@ static int pgo_module_notifier(struct notifier_block *nb, unsigned long event,
 			if (strcmp(data->mod->name, mod->name) == 0) {
 
 				mutex_lock(&prf_mod_lock);
-				/* remofe from profiled modules */
+				/* remove from profiled modules */
 				list_del_rcu(&data->link);
 				/* mark it stale */
 				WRITE_ONCE(data->mod, NULL);
-- 
2.31.1

