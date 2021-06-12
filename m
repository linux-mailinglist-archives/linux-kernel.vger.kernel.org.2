Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5153A4C76
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFLDiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:38:07 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:42599 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhFLDiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:38:06 -0400
Received: by mail-lj1-f169.google.com with SMTP id r16so12160575ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78xQAjO1ty/zMhuJXBJQ0SNn9rzp8kj1m8rkURlW+20=;
        b=XX+1d3vO5nXOF7E7mJIy/ts0SFcoBNWHZIM3Vtudq1ORRs+icfyH7/FgEk8C7ELeuG
         73r3q5rOTEJzrLqMp2B6xKpOyXuv//GzSY9TpbfUd60T6KE7UVusq7HwFQln2QqXUaVR
         Ct8MYM+05Skc2OAaIutdK+SHSRLU9DlFDVrQ6YBSdEoiuoBvujkMb/GwT2IIAQonInxg
         72h9sBnEc9yYr1iZyZ9ZBqZTCbx5ZLK3Zea4KCJDZeSDpevkCtVK4z0Tdugc889G/kUC
         wTSMMa7hgHsoX4HdaeTGT+/DIxN6P4CpeRufgl1Ubu4i5+DJiwHsHiPtV/g535pKw6Nj
         igFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78xQAjO1ty/zMhuJXBJQ0SNn9rzp8kj1m8rkURlW+20=;
        b=R7oJPwNEK6tJGERuGVOgkiE2DfdI4X1Ha/7157icgWH0TmL4/Dup4zV8Fk+fqjHiM6
         GqUx4yMr+OJe8Jl7kBe9JtXVSDFI61f8M/sO8ESUJfUOkomZhpQykO98bSVV15gXRM27
         kzhMnE7QkABCGzgEjtPNiL0WXlgsbJ/u7Vfqaaiuuqj3WqNiZymQf4FIWK/cPUo37QJB
         RH71gEswhM4DaaU1lqo6YyS41fdSQZvNtA953mv7tdvX4Ft0DdoWHr8AMMkD2wsoA7Qa
         TMlPf0sSnsEdSk55F17CpurfXOv+u4AG4Yd2ni2kmhH/G6M5UgDzKZfpejKP07wwzUvR
         5STA==
X-Gm-Message-State: AOAM532YT/ZxssL+b2nk5kwX96xAdBkEPJvQ7/PjIhu/QUNZ++opob1E
        hMOaf15xH463WUUQQCOFmzM=
X-Google-Smtp-Source: ABdhPJxStUXRlkQWlgOOOawwwZqvERR9Mv9rs29engKK5nAtvUYwwqH65Yyn2bp391FhuxDbpL7e2A==
X-Received: by 2002:a2e:870d:: with SMTP id m13mr5395268lji.250.1623468906729;
        Fri, 11 Jun 2021 20:35:06 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4ydkw9h---3prwmt-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:6897:4dff:feec:7495])
        by smtp.gmail.com with ESMTPSA id f19sm943250ljn.88.2021.06.11.20.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:35:06 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Jessica Yu <jeyu@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     morbo@google.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [RFC PATCH 1/5] pgo: Expose module sections for clang PGO instumentation.
Date:   Sat, 12 Jun 2021 06:24:22 +0300
Message-Id: <20210612032425.11425-2-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose module sections for clang PGO:
In find_module_sections() add code to grab pointer and size
of __llvm_prf_{data,cnts,names,vnds} sections.

This data is used by pgo/instrument.c and pgo/fs.c
in following patches together with explicitly exposed
 vmlinux's core __llvm_prf_xxx sections.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
the reason of disabling profiling for module.c
is that instrumented kernel changes struct module layout,
and thus invalidates profile data collected from module.c
when optimized kernel it built.

More over the profile data from kernel/module.c
is probably not needed either way.
---
 include/linux/module.h | 15 +++++++++++++++
 kernel/Makefile        |  6 ++++++
 kernel/module.c        |  7 +++++++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 8100bb477d86..7f557016e879 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -492,6 +492,21 @@ struct module {
 	unsigned long *kprobe_blacklist;
 	unsigned int num_kprobe_blacklist;
 #endif
+#ifdef CONFIG_PGO_CLANG
+	/*
+	 * Keep in sync with the PGO_CLANG_DATA sections
+	 * in include/asm-generic/vmlinux.lds.h
+	 * The prf_xxx_size is the section size in bytes.
+	 */
+	void *prf_data; /* struct llvm_prf_data */
+	int prf_data_size;
+	void *prf_cnts;
+	int prf_cnts_size;
+	const void *prf_names;
+	int prf_names_size;
+	void *prf_vnds; /* struct llvm_prf_value_node */
+	int prf_vnds_size;
+#endif
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 	int num_static_call_sites;
 	struct static_call_site *static_call_sites;
diff --git a/kernel/Makefile b/kernel/Makefile
index 6deef4effbdb..8657d67b771c 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -44,6 +44,12 @@ CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
 # Don't instrument error handlers
 CFLAGS_REMOVE_cfi.o := $(CC_FLAGS_CFI)
 
+# Don't profile module.c:
+# CLANG_PGO changes the layout of struct module
+# for instrumented kernel so the profile data
+# will mismatch on final build.
+PGO_PROFILE_module.o := n
+
 obj-y += sched/
 obj-y += locking/
 obj-y += power/
diff --git a/kernel/module.c b/kernel/module.c
index b5dd92e35b02..a2f65c247c41 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3329,6 +3329,13 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					      sizeof(*mod->static_call_sites),
 					      &mod->num_static_call_sites);
 #endif
+#ifdef CONFIG_PGO_CLANG
+	mod->prf_data = section_objs(info, "__llvm_prf_data", 1, &mod->prf_data_size);
+	mod->prf_cnts = section_objs(info, "__llvm_prf_cnts", 1, &mod->prf_cnts_size);
+	mod->prf_names = section_objs(info, "__llvm_prf_names", 1, &mod->prf_names_size);
+	mod->prf_vnds = section_objs(info, "__llvm_prf_vnds", 1, &mod->prf_vnds_size);
+#endif
+
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
 

base-commit: 0039303120c0065f3952698597e0c9916b76ebd5
-- 
2.32.0

