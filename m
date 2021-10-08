Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20ADC42666F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhJHJQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237470AbhJHJQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXKKrinDM77WFUunxS5Afbd05XO3wolRRteT5kMHCY4=;
        b=Ajw8oZXpyPKUYjVGXzPPs7IXyVn8FUQA18STNKYb905SMgRPsCDmwBmhqPejk9Ih7vqMfJ
        MLilOw5TuEtoA+fGGIBVunONW4AICAnUfRqjaO1MCsU8LHg+HqNYcDKOvdsdw1Fa+/KZsq
        sdIZieTNdU2SLBJf4DiOuUyG1s1zRa8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-MeJB7e3INE6_Nk9d7fdS3w-1; Fri, 08 Oct 2021 05:14:20 -0400
X-MC-Unique: MeJB7e3INE6_Nk9d7fdS3w-1
Received: by mail-wr1-f72.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so6797554wrb.14
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 02:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXKKrinDM77WFUunxS5Afbd05XO3wolRRteT5kMHCY4=;
        b=lac/Dh9aFqe0NTGb7o+pphKGYx4xWcJNJn0CCRLozMYDMozV3g9b8FX4KTPcwTBsj3
         QU4QZB/+iul2wvmNc5S5PugRQJlaFKKYz93wMPzTwsqVwgCBwWDxd7CrQT26p7Pr0Cnx
         uEswPT/HiShfgIkvkmEbi2GLS+QcFAiEYdY6Sgz+KmtGqL2d00qxi+PA6SCm+b0ctaXc
         9VtaVTMUdU0H3PiCnu0ACk/JV3CcixFlJdD6aM2vD9IYXk6TcMwSFFPsqWlQ1i+aqQkf
         CepBe6nZF6iHssrfwgk53FyQW6Opk3OlOUBz39JmdJcIcotJ5RNHzfN49oNaK9Q3hhMf
         ZuFQ==
X-Gm-Message-State: AOAM532GizfN9o8Q27eRlbLPpK1TfrwSJibOZisRGBj4LCtouXwGBrPx
        s+KYWk1zR49nSioPJJcrSpkJtlw9QR943qhWiu3+QbBmzr6gQKugZomzYzzQKjwg98M64oCbsIR
        DViHc8q4ZkbKbjvYmFPKJW7XX
X-Received: by 2002:a05:600c:1907:: with SMTP id j7mr2161819wmq.184.1633684459438;
        Fri, 08 Oct 2021 02:14:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz84j7K2uFms5WNUH+r7ll2dxXog50Ofy2QktxnUnkOsHyey2rYBor+XjZJ2p6C+bIHLWsaKg==
X-Received: by 2002:a05:600c:1907:: with SMTP id j7mr2161801wmq.184.1633684459246;
        Fri, 08 Oct 2021 02:14:19 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t3sm7861433wmj.33.2021.10.08.02.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:14:19 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 7/8] ftrace: Add multi direct modify interface
Date:   Fri,  8 Oct 2021 11:13:35 +0200
Message-Id: <20211008091336.33616-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008091336.33616-1-jolsa@kernel.org>
References: <20211008091336.33616-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding interface to modify registered direct function
for ftrace_ops. Adding following function:

   modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)

The function changes the currently registered direct
function for all attached functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  6 ++++
 kernel/trace/ftrace.c  | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ba5d02ba8166..c15b767f39cf 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -318,6 +318,8 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+
 #else
 struct ftrace_ops;
 # define ftrace_direct_func_count 0
@@ -357,6 +359,10 @@ static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigne
 {
 	return -ENODEV;
 }
+static inline int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9df7bffb770..d92f2591c3fc 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5547,6 +5547,68 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
+
+/**
+ * modify_ftrace_direct_multi - Modify an existing direct 'multi' call
+ * to call something else
+ * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the new trampoline to call at @ops functions
+ *
+ * This is used to unregister currently registered direct caller and
+ * register new one @addr on functions registered in @ops object.
+ *
+ * Note there's window between ftrace_shutdown and ftrace_startup calls
+ * where there will be no callbacks called.
+ *
+ * Returns: zero on success. Non zero on error, which includes:
+ *  -EINVAL - The @ops object was not properly registered.
+ */
+int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	struct ftrace_hash *hash = ops->func_hash->filter_hash;
+	struct ftrace_func_entry *entry, *iter;
+	int i, size;
+	int err;
+
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+	mutex_lock(&ftrace_lock);
+
+	/*
+	 * Shutdown the ops, change 'direct' pointer for each
+	 * ops entry in direct_functions hash and startup the
+	 * ops back again.
+	 *
+	 * Note there is no callback called for @ops object after
+	 * this ftrace_shutdown call until ftrace_startup is called
+	 * later on.
+	 */
+	err = ftrace_shutdown(ops, 0);
+	if (err)
+		goto out_unlock;
+
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
+			entry = __ftrace_lookup_ip(direct_functions, iter->ip);
+			if (!entry)
+				continue;
+			entry->direct = addr;
+		}
+	}
+
+	err = ftrace_startup(ops, 0);
+
+ out_unlock:
+	mutex_unlock(&ftrace_lock);
+	mutex_unlock(&direct_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi);
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.31.1

