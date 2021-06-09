Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253963A1190
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbhFIKxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbhFIKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:52:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E87DC061789;
        Wed,  9 Jun 2021 03:51:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso1181284pjb.0;
        Wed, 09 Jun 2021 03:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMnjRIUH7U+LMaqu23CyFxSMSpd6wBrIg0N0L1+h9xI=;
        b=CQWJzh2vMfM8dqsbuL8saaK/h/oFNR54r77/rpiHjM849egwn9aXMHW12ubfLKGbMl
         pmoFuUtPIr8X+UsstCY0qS4PmIDbhR7CTp8nw/749Iuwl+ZB9kAj7PaY0bC9KeLeG3qu
         V/XK2HUZUHGRHVzPtz+pdaJQIqxZzACgJ8pWpelVMq/4dIH3jxbXuTblM5X3P4M67Y6i
         ukpevPlAQu5OUOpqFZMYCSPPoPyL/whzW11fGPjEF5B4bD7Iw3yiRN14LlPLDhHWPLlv
         WhE9zXvaLk9LlGF/K14jPq4nvw05yp37ZbmvCpm3c/kYcdlJNm1GR7RNKsognK/xw7Wt
         BtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMnjRIUH7U+LMaqu23CyFxSMSpd6wBrIg0N0L1+h9xI=;
        b=OAcokV/RaKqueM5oSCLgdrMoLVKUCHHsnrqSPyT7Ivjr2v+lB6wFOTBjeKDH4ssXgS
         25iQ+um/ZItqLPWy4PeOepuE6RCqGl7bRETrBZ+vPIqfyZzyGS3W9x6SB5kE/RoO07oJ
         QX7lJUE8mIhLS929TjSg5KYrf00cDVhZJWG5TsBCvmiwV0Ev4CSqfwn2ujLC5VMnj51w
         iCxcGItys71XfAMBPG0uFY2L5pNXiIWqIBoaPFBnnC5E6NxIJgiasXQpdv6+lqvZtRtv
         4tJkwVDAPGyE0i0uqx3re0tf4b5SJbtkHVckbl/5aiaOZXwSWxSGl5pFDjJ/7ixnUvoQ
         GyNg==
X-Gm-Message-State: AOAM533Dz7qskHLOkIAy1n8WXjlmP7aF2CF8Dl10v0OrLGC8aQOe8bkd
        +tlJRxwpd9vSuaIDeBatI/I=
X-Google-Smtp-Source: ABdhPJyb2QKYuRHCjf6sjspPY3Ti9AWx0Hk4FRdUqZw/P5UMIrmj14p3Ofqf4kooWHhJ8ifdHV5TlA==
X-Received: by 2002:a17:90a:4404:: with SMTP id s4mr10011078pjg.218.1623235863633;
        Wed, 09 Jun 2021 03:51:03 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id g6sm13603667pfq.110.2021.06.09.03.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:51:03 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org
Subject: [RFC PATCH 3/5] kprobe: Simplify prepare_kprobe() by dropping redundant version
Date:   Wed,  9 Jun 2021 19:50:17 +0900
Message-Id: <20210609105019.3626677-4-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609105019.3626677-1-punitagrawal@gmail.com>
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function prepare_kprobe() is called during kprobe registration and
is responsible for ensuring any architecture related preparation for
the kprobe is done before returning.

One of two versions of prepare_kprobe() is chosen depending on the
availability of KPROBE_ON_FTRACE in the kernel configuration.

Simplify the code by dropping the version when KPROBE_ON_FTRACE is not
selected - instead relying on kprobe_ftrace() to return false when
KPROBE_ON_FTRACE is not set.

No functional change.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
---
 include/linux/kprobes.h |  5 +++++
 kernel/kprobes.c        | 23 +++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 1883a4a9f16a..771013bab18a 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -362,6 +362,11 @@ static inline void wait_for_kprobe_optimizer(void) { }
 extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs);
 extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
+#else
+static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	return -EINVAL;
+}
 #endif
 
 int arch_check_ftrace_location(struct kprobe *p);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1a11d3c411bf..54d37d4ab897 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1022,15 +1022,6 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 static int kprobe_ipmodify_enabled;
 static int kprobe_ftrace_enabled;
 
-/* Must ensure p->addr is really on ftrace */
-static int prepare_kprobe(struct kprobe *p)
-{
-	if (!kprobe_ftrace(p))
-		return arch_prepare_kprobe(p);
-
-	return arch_prepare_kprobe_ftrace(p);
-}
-
 /* Caller must lock kprobe_mutex */
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
@@ -1102,11 +1093,6 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
-static inline int prepare_kprobe(struct kprobe *p)
-{
-	return arch_prepare_kprobe(p);
-}
-
 static inline int arm_kprobe_ftrace(struct kprobe *p)
 {
 	return -ENODEV;
@@ -1118,6 +1104,15 @@ static inline int disarm_kprobe_ftrace(struct kprobe *p)
 }
 #endif
 
+static int prepare_kprobe(struct kprobe *p)
+{
+	/* Must ensure p->addr is really on ftrace */
+	if (kprobe_ftrace(p))
+		return arch_prepare_kprobe_ftrace(p);
+
+	return arch_prepare_kprobe(p);
+}
+
 /* Arm a kprobe with text_mutex */
 static int arm_kprobe(struct kprobe *kp)
 {
-- 
2.30.2

