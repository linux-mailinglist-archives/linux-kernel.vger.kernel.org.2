Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA87F3FC531
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbhHaJwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240769AbhHaJwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630403466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t6bvp9pXHWwYkD8tY68DycfX16y6E0FnbXtjvnYOkio=;
        b=N7ogKsx+lwoAxZu6PoT0ldLSKVe+6z91veGkgOEaijs7q2yggKJizFSYmjSnyx0wLpkQEl
        HlQAXU6uVjFz3mFxRtasAW+7UwiZ7n3taaYwMAZvFFtGw3hDKf0fQp33QVbci/W7hOln4E
        9KBhc4ouyWSx2bSskngHwpwMUkNlncI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-Oa7zgcozMQCVrz4kmlWiVQ-1; Tue, 31 Aug 2021 05:51:04 -0400
X-MC-Unique: Oa7zgcozMQCVrz4kmlWiVQ-1
Received: by mail-wr1-f69.google.com with SMTP id h6-20020a5d4fc6000000b00157503046afso3851874wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6bvp9pXHWwYkD8tY68DycfX16y6E0FnbXtjvnYOkio=;
        b=Q3adeZF+SdtZ4qwO6rw2uOGKc2XiosAer0KUpQpXwVVe61bujnc875BZe1JI35yJQJ
         B9rubQt5k5fuZTfXMugR7kffUmEX/rZ6gnqiNpWA5GZ1eZb10IInFhd3bFtqRORx5WGG
         nD4K/UvQn25Qa05iQijgjQHxProZeKTNAWeQDcswCX02ZHJWsOn7q1Re02DiGSOfms0C
         NpFBLd/3EzRzvQLBCOIqQNgqc+D28BZ6znjLt//DYX7Ait7HKI2jeOkMlmai8xox3oIr
         ygAzXytBT/7Wia52L0eJOtHij50wv0dLe/biG9PM3FYQllU31pUqDJzMugR2bDqX297b
         AxYA==
X-Gm-Message-State: AOAM5312EsheUcFi9R76LIla0JavJ7ryI285WxMbBWcTD1zKsJ+5to4t
        cR7BqXxXYyqhvmeiMfc9ZqLhK4m+LJALbRy8Kk/YUfFGL9gBHj9MQqgpAtcbB70rwBTevWOiysP
        rktblE3aj72jv8joSUGWtx++B
X-Received: by 2002:a1c:2547:: with SMTP id l68mr3401837wml.23.1630403462943;
        Tue, 31 Aug 2021 02:51:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPyCWrQg3mVkjhGw+uezNrWGR5cdnracfdsEemYrpJbkF1MzgGClBoUlUPi8OGKfJP6S3o6A==
X-Received: by 2002:a1c:2547:: with SMTP id l68mr3401829wml.23.1630403462787;
        Tue, 31 Aug 2021 02:51:02 -0700 (PDT)
Received: from krava.redhat.com ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id t11sm2118614wmi.23.2021.08.31.02.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:51:02 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 7/8] ftrace: Add multi direct modify interface
Date:   Tue, 31 Aug 2021 11:50:16 +0200
Message-Id: <20210831095017.412311-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831095017.412311-1-jolsa@kernel.org>
References: <20210831095017.412311-1-jolsa@kernel.org>
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
 include/linux/ftrace.h |  6 ++++++
 kernel/trace/ftrace.c  | 43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e40b5201c16e..f3ba6366f7af 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -318,6 +318,8 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 int unregister_ftrace_direct_multi(struct ftrace_ops *ops);
+int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+
 #else
 struct ftrace_ops;
 # define ftrace_direct_func_count 0
@@ -357,6 +359,10 @@ static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
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
index 7243769493c9..59940a6a907c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5518,6 +5518,49 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
+
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

