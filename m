Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53563D76DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhG0Net (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbhG0Ner (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:34:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001F8C061757;
        Tue, 27 Jul 2021 06:34:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b1-20020a17090a8001b029017700de3903so3037710pjn.1;
        Tue, 27 Jul 2021 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5l6yxtUqEjm6HUyKl5DpC9WS7AqBuWTzIemrut1dbQ8=;
        b=h2vI83TEFPxb2KxjJ01mNlZvApRw8xlPLshjWY9kMBty6UW/ZIylfPzTt+CRzobYSO
         602Tae3rud3fVSPYLfqCPfuiUL3r3+XL0zZwy47mKVP1XV9bh7faqmMWkkls1ORfMG25
         wpK04fAsCoBbX58l7e68+LzR2/pglteeXdorTzJxOkCHsaW0Zz5kzUMiP42illeYXm0D
         j8qt0I56k/WEOJXDrY4kS+Nh1YYVF5YsSbg0E2JfgKc2n8l5uNrl5xhIWCuyqgvpuSlm
         Ii8pY3w4mXDNtZWYjKfXtTqNVhPDLmo/ShCUvbLJvtIPXXi2d4lIFt+c5dTWujpjdaeQ
         7WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5l6yxtUqEjm6HUyKl5DpC9WS7AqBuWTzIemrut1dbQ8=;
        b=a115rF7lMAus5INhvCUIOdA4UDoHNFKETC9r3kM9KgCZexaZZufZssvyRp0TuNbx9M
         5nR/z3ES2CxstaKfmbz745UXsPJQkT7sV84AEz6VsLp1NPlBz/wJkYUPN/5PTGASsq2l
         Ap2FXgYb/btpHyiBYbnp1pLwPB4V61GT/Y+6SYEY7/wsR7iNZmTSd6EAPBTdkGdhsqTT
         XUX9fSkYD6nfB4rgy7v4IhBStpnTEGABouc5m2ZAHimKgsZfdA3XTqEeVICg40iyVdnh
         nxay+sJXjzY9I0ZSFRQLL96VcxzFcoqt0ObGzAlF12fMlUVGwi3Fewp5L5o2kCez3gXK
         Qx9A==
X-Gm-Message-State: AOAM530R4fIEqr2ZI3TCKQFGa+S3FBFOkkJqklwoT44dMEwnID/ONiS+
        9ydtSXhi8ey1eJPb8QSxsXY=
X-Google-Smtp-Source: ABdhPJxC90pK8EtkssVHaul17JGJVw0HvFlB/6V9yefuoKHHS7hpaLCAEMgt/hfPWOpqTFdrBP8Smw==
X-Received: by 2002:a63:df14:: with SMTP id u20mr23430466pgg.348.1627392885527;
        Tue, 27 Jul 2021 06:34:45 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id w145sm3932415pfc.39.2021.07.27.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:34:44 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org
Subject: [PATCH v2 1/5] kprobes: Do not use local variable when creating debugfs file
Date:   Tue, 27 Jul 2021 22:34:22 +0900
Message-Id: <20210727133426.2919710-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727133426.2919710-1-punitagrawal@gmail.com>
References: <20210727133426.2919710-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_file() takes a pointer argument that can be used during
file operation callbacks (accessible via i_private in the inode
structure). An obvious requirement is for the pointer to refer to
valid memory when used.

When creating the debugfs file to dynamically enable / disable
kprobes, a pointer to local variable is passed to
debugfs_create_file(); which will go out of scope when the init
function returns. The reason this hasn't triggered random memory
corruption is because the pointer is not accessed during the debugfs
file callbacks.

Since the enabled state is managed by the kprobes_all_disabled global
variable, the local variable is not needed. Fix the incorrect (and
unnecessary) usage of local variable during debugfs_file_create() by
passing NULL instead.

Fixes: bf8f6e5b3e51 ("Kprobes: The ON/OFF knob thru debugfs")
Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 790a573bbe00..1cf8bca1ea86 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2809,13 +2809,12 @@ static const struct file_operations fops_kp = {
 static int __init debugfs_kprobe_init(void)
 {
 	struct dentry *dir;
-	unsigned int value = 1;
 
 	dir = debugfs_create_dir("kprobes", NULL);
 
 	debugfs_create_file("list", 0400, dir, NULL, &kprobes_fops);
 
-	debugfs_create_file("enabled", 0600, dir, &value, &fops_kp);
+	debugfs_create_file("enabled", 0600, dir, NULL, &fops_kp);
 
 	debugfs_create_file("blacklist", 0400, dir, NULL,
 			    &kprobe_blacklist_fops);
-- 
2.30.2

