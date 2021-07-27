Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA743D76E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhG0NfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhG0NfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:35:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A827CC061757;
        Tue, 27 Jul 2021 06:35:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso4856052pjf.4;
        Tue, 27 Jul 2021 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0R2BGk4LuAr7Y5IYCIfbtJOd6IDApUbFvKOOvdTW5a0=;
        b=k4NE1gNy0AX0JFNlvxzzETC4ubAnlL/Phy1hg7q3T/Qm74DO+8ngdZHgkEbCslhYSp
         fj6Ok+pwqWVv6vIoisLiZWpFAIDVVlAAplknaVDoTWXSYJOfie+8qUq1HMfEfQqaN1QT
         FBq/dpHKCSjrYDBD+aNjOA5ZzvylRjyzI9GbcxjxBUL9tW8yRtO7rI2VRzxEjLEUg+ef
         6F4+fehj/v0eSlVUIxbGz+633nlYJnlyGISoI7k2463ZF0BoCXxBOTXCo4C2XtzzDlur
         +NIDWl4TTkCvfBzoc8R/U2YaRCWWgzwhjMFD5oGq0YcmK88axnRDd9Rfd6OcRpntpgzG
         CbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0R2BGk4LuAr7Y5IYCIfbtJOd6IDApUbFvKOOvdTW5a0=;
        b=QuLCeQ5g8ckz2TEZ2O+6KFTc5ZQ8CL6/R1i+OEoR+zzamY+rhrrZ7CPj2SeCrvynRg
         euPT+sXn8DCRSET1m4p/RGImCXzq+8I5SSrt+PSwONHM8wrqDnSLs7bK5M9PllWPa/1L
         1GqnyUH4rbbWA+mudTio552EqH+I9REvxovBpGdVUuLppUvEE/snChEZkJloglwoMvrC
         4ijTcGzbyW1zUq9MteVADePK8DD6DOLgmPRvvFVC1KG70dLpalUDaPkjFvdqLgx4/hgp
         yQjiGlIR/g10fsXJQXC9W1xd6/GeYDLn5pJffKbcl3+xSFDXB494i/BzvsDLC8APveHv
         9LWw==
X-Gm-Message-State: AOAM532n/tUwxj1cMJ0rm3RBKYC917MtCLsNyCUvu6uHf6Bg6Y8KIIOn
        oFeHIgrtYCT0zGj70gBBOiQ=
X-Google-Smtp-Source: ABdhPJwlPMWV2peaxkN7yvxiBmC7mG5yivjwLT61AfrGjV3YaxQ7mVoaZq4yWC35Vahb5EBA3q+l6g==
X-Received: by 2002:a17:90b:2513:: with SMTP id ns19mr4214024pjb.63.1627392907194;
        Tue, 27 Jul 2021 06:35:07 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id 20sm4012933pfi.170.2021.07.27.06.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:35:06 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org
Subject: [PATCH v2 3/5] kprobe: Simplify prepare_kprobe() by dropping redundant version
Date:   Tue, 27 Jul 2021 22:34:24 +0900
Message-Id: <20210727133426.2919710-4-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727133426.2919710-1-punitagrawal@gmail.com>
References: <20210727133426.2919710-1-punitagrawal@gmail.com>
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
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |  5 +++++
 kernel/kprobes.c        | 23 +++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e4f3bfe08757..0b75549b2815 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -354,6 +354,11 @@ static inline void wait_for_kprobe_optimizer(void) { }
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
index 26fc9904c3b1..cfa9d3c263eb 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1033,15 +1033,6 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
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
@@ -1113,11 +1104,6 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
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
@@ -1129,6 +1115,15 @@ static inline int disarm_kprobe_ftrace(struct kprobe *p)
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

