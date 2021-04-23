Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70BB368A49
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 03:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbhDWBP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 21:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhDWBP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 21:15:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC96C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 18:15:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w186so20580350wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 18:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2iyahBHzOh1s1/2DDrTt76XfDUplpwYz1B02Q5JMG8=;
        b=QrGJ0WbTFOBeAA0exsEZvLpywew49OqEUPMbWHqiq14wL85spVThPTXWeaYkYKMpts
         RfbDhHvxCNv4cYMQpl9b2zqU3uwWhlFbsLsW33fVvAgT1OGg8+NStrYdS4o6hqs0aJF2
         tp1ajTlsBTrgKM4I7KPzjseDw7I2SS4MNO0fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2iyahBHzOh1s1/2DDrTt76XfDUplpwYz1B02Q5JMG8=;
        b=Ial8iIRvIgHaReTmuC2OdNN/6XKoU2CgQTrqSH/h8NUTcQQ7nwyXQhKx5eP7mFaAiQ
         T/Lm3cxLt/09SynfRWmzq/kgFAalVUCPTjb5Y7gLk7CSWichRuFbv0HDzTXMJ7rmlGW+
         b3xPounymS67M9QrpeO7Nj3RXSiKCQ6TwsNiwI0PbE7EIqucq6tUiauK+4vzfgzf2qu8
         eAokJcCo/qlhSWL73UjsSeTfYdmQY+F2TNRZUr4vsKyNR+o3OVBUsh3FnBh3oFmTO7JY
         o3I0X5pkD26Y3UkmMLU/8PK/LEl5eRygK2/F0QJ50JTumZEsZQ7ct1O60pgF6q0DRmem
         tdtw==
X-Gm-Message-State: AOAM532K84RXpcKRL9FK3bnnkhd5Ua7ZOea4AIE5JNEwZPKQyu/pigcf
        wzjLf2xZ5Z7T/HY24Kv7kTBcxw==
X-Google-Smtp-Source: ABdhPJykgMyRqYka02II3MnpOSqLN9awuNage0XpfEWrRk2h6Gk1EU5+x87de9PYTdQM+a5iqIP8nQ==
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr1549439wmk.2.1619140521519;
        Thu, 22 Apr 2021 18:15:21 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:e4b7:67ca:7609:a533])
        by smtp.gmail.com with ESMTPSA id a13sm6709340wrs.78.2021.04.22.18.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:15:21 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 1/2] seq_file: Add a seq_bprintf function
Date:   Fri, 23 Apr 2021 03:15:16 +0200
Message-Id: <20210423011517.4069221-2-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423011517.4069221-1-revest@chromium.org>
References: <20210423011517.4069221-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to seq_buf_bprintf in lib/seq_buf.c, this function writes a
printf formatted string with arguments provided in a "binary
representation" built by functions such as vbin_printf.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 fs/seq_file.c            | 18 ++++++++++++++++++
 include/linux/seq_file.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index cb11a34fb871..5059248f2d64 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -412,6 +412,24 @@ void seq_printf(struct seq_file *m, const char *f, ...)
 }
 EXPORT_SYMBOL(seq_printf);
 
+#ifdef CONFIG_BINARY_PRINTF
+void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary)
+{
+	int len;
+
+	if (m->count < m->size) {
+		len = bstr_printf(m->buf + m->count, m->size - m->count, f,
+				  binary);
+		if (m->count + len < m->size) {
+			m->count += len;
+			return;
+		}
+	}
+	seq_set_overflow(m);
+}
+EXPORT_SYMBOL(seq_bprintf);
+#endif /* CONFIG_BINARY_PRINTF */
+
 /**
  *	mangle_path -	mangle and copy path to buffer beginning
  *	@s: buffer start
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index b83b3ae3c877..723b1fa1177e 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -146,6 +146,10 @@ void *__seq_open_private(struct file *, const struct seq_operations *, int);
 int seq_open_private(struct file *, const struct seq_operations *, int);
 int seq_release_private(struct inode *, struct file *);
 
+#ifdef CONFIG_BINARY_PRINTF
+void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary);
+#endif
+
 #define DEFINE_SEQ_ATTRIBUTE(__name)					\
 static int __name ## _open(struct inode *inode, struct file *file)	\
 {									\
-- 
2.31.1.498.g6c1eba8ee3d-goog

