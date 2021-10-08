Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65A442666C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhJHJQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237272AbhJHJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QINuD3vOMUoOmNOM6OKfs1CcbZJa/bSQ5hGKOOlIS9A=;
        b=JAaarcknOJcRV24Inw3z+TpDRUhqCrtEvWyoUTl4UkYXixsrKbA/8OhBlakFqju1X109P5
        xx6hvfsEY4l94cgh1j7n1qr8YA5QwdTAAhCGABeMv1LiRmmnVzoCZvALdpCjM/nw2f9+zP
        7SyzbjlA0jXDGpznOUfTsoCHaN26bIg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-uSvUKDPQOI2ehF5YrU38UA-1; Fri, 08 Oct 2021 05:14:14 -0400
X-MC-Unique: uSvUKDPQOI2ehF5YrU38UA-1
Received: by mail-wr1-f72.google.com with SMTP id c4-20020a5d6cc4000000b00160edc8bb28so1004505wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 02:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QINuD3vOMUoOmNOM6OKfs1CcbZJa/bSQ5hGKOOlIS9A=;
        b=O+u2JOblhH3ZPppYUOHClFe2h4YZ8gWbcoOSmkIBb/jzahKEFrb5OdTC6DOl6eZbZF
         p2VVkHEtu77ia932TWTsRzXQvyY07jGGi3GUtEfg8Atj7a4lclZWs8nzAfZNfMnl2cKr
         oVIImXqPPVQyHXceowXA60QPo4LWcH5w+dMRR9O550D0zqoJDxmPmowLDgtmYwjDluKR
         08ubpJxEWnBAZQHMA02rcs+jVliI2+wcy2Mh9nEzmxvnpdWMJ65tCG8rlIOu0GGnIFe9
         /RhU8QEt4NPkCnpquTwhuUOs0Pre5aYlu/lZt+wtR5tYGCRwnFYVuSXKACbzQeNYYN4C
         jjBQ==
X-Gm-Message-State: AOAM532noTCjVBEvEvDP4HmibrpFn7YC27yPsdi8eyqR+swS2lsoAnJY
        75RRtqkKtUsNpq9pGEDHSK6IwgCnbf69rbXef5BFTHbZk+P4DlmZ7c/CT9IA4BnAe3/9PBW9btq
        xNJUcj7O4IVsVtWn9uBf0eJqt
X-Received: by 2002:a05:600c:4e86:: with SMTP id f6mr2303233wmq.52.1633684453457;
        Fri, 08 Oct 2021 02:14:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyh4MhcoIXFiPd0LzRAmW9q86m6uZ3JWzopP6VBqE7452ZqdtaQYVVlAhFAeatz4Cura/cmQ==
X-Received: by 2002:a05:600c:4e86:: with SMTP id f6mr2303206wmq.52.1633684453263;
        Fri, 08 Oct 2021 02:14:13 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k9sm1815090wrz.22.2021.10.08.02.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:14:13 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 6/8] ftrace: Add multi direct register/unregister interface
Date:   Fri,  8 Oct 2021 11:13:34 +0200
Message-Id: <20211008091336.33616-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008091336.33616-1-jolsa@kernel.org>
References: <20211008091336.33616-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding interface to register multiple direct functions
within single call. Adding following functions:

  register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
  unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)

The register_ftrace_direct_multi registers direct function (addr)
with all functions in ops filter. The ops filter can be updated
before with ftrace_set_filter_ip calls.

All requested functions must not have direct function currently
registered, otherwise register_ftrace_direct_multi will fail.

The unregister_ftrace_direct_multi unregisters ops related direct
functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  11 ++++
 kernel/trace/ftrace.c  | 142 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1ca60ee70fb0..ba5d02ba8166 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -316,7 +316,10 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 				unsigned long old_addr,
 				unsigned long new_addr);
 unsigned long ftrace_find_rec_direct(unsigned long ip);
+int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 #else
+struct ftrace_ops;
 # define ftrace_direct_func_count 0
 static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
 {
@@ -346,6 +349,14 @@ static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	return 0;
 }
+static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	return -ENODEV;
+}
+static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6032a5441770..f9df7bffb770 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5405,6 +5405,148 @@ int modify_ftrace_direct(unsigned long ip,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
+
+#define MULTI_FLAGS (FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_DIRECT | \
+		     FTRACE_OPS_FL_SAVE_REGS)
+
+static int check_direct_multi(struct ftrace_ops *ops)
+{
+	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
+		return -EINVAL;
+	if ((ops->flags & MULTI_FLAGS) != MULTI_FLAGS)
+		return -EINVAL;
+	return 0;
+}
+
+static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long addr)
+{
+	struct ftrace_func_entry *entry, *del;
+	int size, i;
+
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			del = __ftrace_lookup_ip(direct_functions, entry->ip);
+			if (del && del->direct == addr) {
+				remove_hash_entry(direct_functions, del);
+				kfree(del);
+			}
+		}
+	}
+}
+
+/**
+ * register_ftrace_direct_multi - Call a custom trampoline directly
+ * for multiple functions registered in @ops
+ * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the trampoline to call at @ops functions
+ *
+ * This is used to connect a direct calls to @addr from the nop locations
+ * of the functions registered in @ops (with by ftrace_set_filter_ip
+ * function).
+ *
+ * The location that it calls (@addr) must be able to handle a direct call,
+ * and save the parameters of the function being traced, and restore them
+ * (or inject new ones if needed), before returning.
+ *
+ * Returns:
+ *  0 on success
+ *  -EINVAL  - The @ops object was already registered with this call or
+ *             when there are no functions in @ops object.
+ *  -EBUSY   - Another direct function is already attached (there can be only one)
+ *  -ENODEV  - @ip does not point to a ftrace nop location (or not supported)
+ *  -ENOMEM  - There was an allocation failure.
+ */
+int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	struct ftrace_hash *hash, *free_hash = NULL;
+	struct ftrace_func_entry *entry, *new;
+	int err = -EBUSY, size, i;
+
+	if (ops->func || ops->trampoline)
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
+		return -EINVAL;
+	if (ops->flags & FTRACE_OPS_FL_ENABLED)
+		return -EINVAL;
+
+	hash = ops->func_hash->filter_hash;
+	if (ftrace_hash_empty(hash))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+
+	/* Make sure requested entries are not already registered.. */
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			if (ftrace_find_rec_direct(entry->ip))
+				goto out_unlock;
+		}
+	}
+
+	/* ... and insert them to direct_functions hash. */
+	err = -ENOMEM;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
+			if (!new)
+				goto out_remove;
+			entry->direct = addr;
+		}
+	}
+
+	ops->func = call_direct_funcs;
+	ops->flags = MULTI_FLAGS;
+	ops->trampoline = FTRACE_REGS_ADDR;
+
+	err = register_ftrace_function(ops);
+
+ out_remove:
+	if (err)
+		remove_direct_functions_hash(hash, addr);
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	if (free_hash) {
+		synchronize_rcu_tasks();
+		free_ftrace_hash(free_hash);
+	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
+
+/**
+ * unregister_ftrace_direct_multi - Remove calls to custom trampoline
+ * previously registered by register_ftrace_direct_multi for @ops object.
+ * @ops: The address of the struct ftrace_ops object
+ *
+ * This is used to remove a direct calls to @addr from the nop locations
+ * of the functions registered in @ops (with by ftrace_set_filter_ip
+ * function).
+ *
+ * Returns:
+ *  0 on success
+ *  -EINVAL - The @ops object was not properly registered.
+ */
+int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	struct ftrace_hash *hash = ops->func_hash->filter_hash;
+	int err;
+
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+	err = unregister_ftrace_function(ops);
+	remove_direct_functions_hash(hash, addr);
+	mutex_unlock(&direct_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.31.1

