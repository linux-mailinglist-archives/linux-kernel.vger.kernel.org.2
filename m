Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2126B3D76E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbhG0NfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbhG0NfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:35:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CAFC061760;
        Tue, 27 Jul 2021 06:35:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i10so12689304pla.3;
        Tue, 27 Jul 2021 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TP6CxDY7H/n3wctXVLoN8fg4wjE6OdPNG/Gq2ojCMo=;
        b=W8H82ET2uXZcrxq9/n3Eqe4eJzDzFOXU9cSfpVlrZMXp8EzxaooiEEP6JfXx0fO8F7
         QkW1y2pkYHCSWMYvxTKTMTafCNCVIHMyvpIIy818bGQS9E1rbr98vmN4KnlxhpUHD3dA
         dUpAVBptm36DquWQXzkh15wfYcLhy7glkvfDifuTYPzQ0jy0tKc2ApRNpC380QtcyQn/
         PjNvS7qBMIztQO8L5BvYE61fCmSxGOLVaIMHfL9fe0J2d3G383NF26Hr1MU9DGdj6MPm
         fZpxY053OQg6BCvKL0fiYssXtB3aI+/fu1k26tKOr463CZs/j5NV4nijDZeeNY3WmuKJ
         dBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TP6CxDY7H/n3wctXVLoN8fg4wjE6OdPNG/Gq2ojCMo=;
        b=mlM/znAMHpmIu0CPPFRRc4vITATxrnfnjZ3B4iLm/evvqZGr/SX8i3/YK4d+WDL6yh
         hslQxs4B4FHtvPUsfM8GyiSmZz2pfammXFvoylsyYdGbrVUUiviEcDCo6JYFCIdNG2Yz
         SsWBHN8H4IG7psxrMweo6vaCxzO1EP46sSQe7fhaNt/M01pUvOLdDErzXTL+r3ODFfAE
         CazXaNWOnQ18+Oz2vpsrvPK8F19wozxgOPvyNYPzTUmtg+dOie27cWM9R0ULw8S9qLYD
         CjMF7Uv3+Yc5DXmqwbN72LHOtZZlNgs5x76A8xJ1sCk2yPrgLefDcngiDKeugxRObl5O
         d+bA==
X-Gm-Message-State: AOAM532bRlit+VmxMPUoYE7zfdwsnfsWtPSKN/pi96Rkm+hCIrsOl3Xe
        yF9SzjL67TQjwdVrcUIuIdk=
X-Google-Smtp-Source: ABdhPJyKeAMoFZRNNiTINae6lBywxqlT0Pg93U1AU98I9H4QbRIFANiE0tH7dEiGvuRssOqPyQ4eWg==
X-Received: by 2002:a65:5603:: with SMTP id l3mr23828057pgs.190.1627392916325;
        Tue, 27 Jul 2021 06:35:16 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id c23sm3856991pfo.174.2021.07.27.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:35:15 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org
Subject: [PATCH v2 5/5] kprobes: Make arch_check_ftrace_location static
Date:   Tue, 27 Jul 2021 22:34:26 +0900
Message-Id: <20210727133426.2919710-6-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727133426.2919710-1-punitagrawal@gmail.com>
References: <20210727133426.2919710-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_check_ftrace_location() was introduced as a weak function in
commit f7f242ff004499 ("kprobes: introduce weak
arch_check_ftrace_location() helper function") to allow architectures
to handle kprobes call site on their own.

Recently, the only architecture (csky) to implement
arch_check_ftrace_location() was migrated to using the common
version.

As a result, further cleanup the code to drop the weak attribute and
rename the function to remove the architecture specific
implementation.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h | 2 --
 kernel/kprobes.c        | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0b75549b2815..8a9412bb0d5e 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -361,8 +361,6 @@ static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
 }
 #endif
 
-int arch_check_ftrace_location(struct kprobe *p);
-
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cfa9d3c263eb..30199bfcc74a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1524,7 +1524,7 @@ static inline int warn_kprobe_rereg(struct kprobe *p)
 	return ret;
 }
 
-int __weak arch_check_ftrace_location(struct kprobe *p)
+static int check_ftrace_location(struct kprobe *p)
 {
 	unsigned long ftrace_addr;
 
@@ -1547,7 +1547,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 {
 	int ret;
 
-	ret = arch_check_ftrace_location(p);
+	ret = check_ftrace_location(p);
 	if (ret)
 		return ret;
 	jump_label_lock();
-- 
2.30.2

