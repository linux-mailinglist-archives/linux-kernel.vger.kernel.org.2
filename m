Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3723A11A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbhFIKyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:54:32 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:46802 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbhFIKyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:54:11 -0400
Received: by mail-pf1-f180.google.com with SMTP id u126so14113791pfu.13;
        Wed, 09 Jun 2021 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pEYcVeyNoKzSNbvy4jy8pfVSwm3ir1DHFnmbQ76O6EA=;
        b=JTMsnpWbvjyyRYmDW2QAV8Ma0WytpzVLoOGSCojZcAgKvPzDoCmh2QKxB8fgHxXr7n
         zYVqOyN5B/XFl7wJ+y8dLgASoB1NrQFP4+P7DPi/i5W8Z+YoinGYIQUezBSQxaZzQIm1
         +SIP3j/8nKS0Fmb3wl2etlShppRrw7kSoy+W8vCnaUaXWFC3lKYb6ZiK+akS4avmxOeT
         8Oz2vJYAtYG9iwikhxhrSCSWQ7vUwfjhKv9UC8mzEKLblT/NgK7p2yuICXfzqRHSSuhv
         pyRwm/Ow7wxU/ivgzE8xsq1aBH0qj0CcrKod72suJVwTCyQ9oF7xNSXS2+DQCnIeVF1E
         ox/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pEYcVeyNoKzSNbvy4jy8pfVSwm3ir1DHFnmbQ76O6EA=;
        b=C7RZwJN5szpRbtTijMseI8k4nUHHtSFVyOe6ZVNWxEdjxsmvbvW5CgvZQRXuU+MoWY
         LWT+cCFwNW+00LUyxYkUEuSds4jid82GmW5n/pQo1PcneOcuAvwkMzhxQYhj3b2KkMmt
         mCnqRZ75Hch78Y50qXjHtvqlPiV2Lf4DTZ6UESNuNV5MwilXDsPbU+YEI/relnbnTe8W
         +1j0P0J4R/TjVsjRHhkfOcv02VPbDKAG93bK70iWgw7Hhxs9alSYQJHVrOq6EJgMSB/o
         JeJO/YhU9opiaWzq568riyEPJVjhSI7B+ZzrdbMqUHUejpmqQYMF+Foi5uZgqxR4M/a5
         k+Jw==
X-Gm-Message-State: AOAM532To1xKtObVvVvBXyZ+1u4qvl06Cfd8M5iDeF+j75HZQELExHJD
        fe84F+eThQ5fdwbshCOreJc=
X-Google-Smtp-Source: ABdhPJwsbJURFP/3M62IIsoytRCT7vn+qjb7Q0UcfrfXo8zLn1A5Wd4eUmp8SyJSQ0Hw33Lx6eoW4Q==
X-Received: by 2002:a63:5915:: with SMTP id n21mr3218842pgb.58.1623235876980;
        Wed, 09 Jun 2021 03:51:16 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id k8sm12556837pfg.185.2021.06.09.03.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:51:16 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org
Subject: [RFC PATCH 5/5] kprobes: Make arch_check_ftrace_location static
Date:   Wed,  9 Jun 2021 19:50:19 +0900
Message-Id: <20210609105019.3626677-6-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609105019.3626677-1-punitagrawal@gmail.com>
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_check_ftrace_location() was introduced as a weak function in
f7f242ff0044 ("kprobes: introduce weak arch_check_ftrace_location()
helper function") to allow architectures to handle kprobes call site
on their own.

Recently, the only architecture (csky) to implement
arch_check_ftrace_location() was migrated to using the common
version.

As a result, further cleanup the code to drop the weak attribute and
rename the function to remove the architecture specific
implementation.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
---
 include/linux/kprobes.h | 2 --
 kernel/kprobes.c        | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 771013bab18a..beea9ecee187 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -369,8 +369,6 @@ static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
 }
 #endif
 
-int arch_check_ftrace_location(struct kprobe *p);
-
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 54d37d4ab897..b12ae6cc8dc3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1531,7 +1531,7 @@ static inline int warn_kprobe_rereg(struct kprobe *p)
 	return ret;
 }
 
-int __weak arch_check_ftrace_location(struct kprobe *p)
+static int check_ftrace_location(struct kprobe *p)
 {
 	unsigned long ftrace_addr;
 
@@ -1554,7 +1554,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 {
 	int ret;
 
-	ret = arch_check_ftrace_location(p);
+	ret = check_ftrace_location(p);
 	if (ret)
 		return ret;
 	jump_label_lock();
-- 
2.30.2

