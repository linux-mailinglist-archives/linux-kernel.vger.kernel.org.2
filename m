Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C643D76DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhG0NfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhG0NfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:35:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7DEC061757;
        Tue, 27 Jul 2021 06:35:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so4867243pjh.3;
        Tue, 27 Jul 2021 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SM1qeuF+L0BGO1YAmr+KZvllo2SOKG+lPJEnNUNNYAc=;
        b=TbKb8piGrIG5ydptI8v65Ya4i8SJZdvGdOqc1GQYcevkHkfS4N28VzMA8R9SM1A1a+
         ch/yxaogHN+fgO7uR2qfX2VwyHlZsQRTRQeET/08XJWYahbekAZR47n/JSkXAjtvIqOn
         ZDSL6gsT4HNHmWAqfO8DB45LMH0TxGjki0arPkkVQeLUSGBQVCHAclN4s5ACkPhdf02B
         je3ZcxA5tR1ld9t7GkWib1Zj0TDgycR5MjcCXH7bbjH6bMZ9Crdar8RTnodWJTQ8MnxV
         lN0pirmq7NcydqRfA92z9UOFUaBXH5h7kSgTGZH1OWc/4CmikCIRBA50YGbAfjxmJ8zb
         JaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SM1qeuF+L0BGO1YAmr+KZvllo2SOKG+lPJEnNUNNYAc=;
        b=XlTmW2z2Z7kSO2ZeufxZdKjwSqlwss6V9T94YfEOkcOfyeGtqjR3B2wfhKHTAncdeF
         WZqDV9443RlIm9iWhgqeOZMmSLqBpcuy8KRmEO+w0BzQXP+m6CQd4y0szeFPTlkGTlxU
         +I3otGPZJSceGQkQnQZ5SSf0R3dDwI6UX1rPIvL8nCnR0jOE7MILs/n8sO1SqLmQhHUR
         f9DZpHw8zFIiDCnfJzN3i5cUfjnw24Ww5CCzCxqRtXvsrF7GmFRQTc6VSwQEiA/Gt5Do
         6kk02boqaho8cTz7b7WVZvMN8S/NOIIseAXuWUganCDJohJL66Sh///1S/EItXmHX/6D
         AEgQ==
X-Gm-Message-State: AOAM533cHwXFV1In0uiiFzh8DK2PG811O5EWhNt9ueYIQL6lwx0TxSQO
        VDTdqIuxz4GaFolWpClZE5E=
X-Google-Smtp-Source: ABdhPJwPYckpcicHZU4lAuNI8dXd92Kf2vcK7oi1UwdQLB9+te1BS62AXOQhvjI6uskDWfm4Kw9gLA==
X-Received: by 2002:a17:90a:fa1:: with SMTP id 30mr4323244pjz.42.1627392900378;
        Tue, 27 Jul 2021 06:35:00 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id l8sm3066859pjc.17.2021.07.27.06.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:34:59 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org
Subject: [PATCH v2 2/5] kprobes: Use helper to parse boolean input from userspace
Date:   Tue, 27 Jul 2021 22:34:23 +0900
Message-Id: <20210727133426.2919710-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727133426.2919710-1-punitagrawal@gmail.com>
References: <20210727133426.2919710-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "enabled" file provides a debugfs interface to arm / disarm
kprobes in the kernel. In order to parse the buffer containing the
values written from userspace, the callback manually parses the user
input to convert it to a boolean value.

As taking a string value from userspace and converting it to boolean
is a common operation, a helper kstrtobool_from_user() is already
available in the kernel. Update the callback to use the common helper
to parse the write buffer from userspace.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1cf8bca1ea86..26fc9904c3b1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2770,30 +2770,14 @@ static ssize_t read_enabled_file_bool(struct file *file,
 static ssize_t write_enabled_file_bool(struct file *file,
 	       const char __user *user_buf, size_t count, loff_t *ppos)
 {
-	char buf[32];
-	size_t buf_size;
-	int ret = 0;
-
-	buf_size = min(count, (sizeof(buf)-1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
+	bool enable;
+	int ret;
 
-	buf[buf_size] = '\0';
-	switch (buf[0]) {
-	case 'y':
-	case 'Y':
-	case '1':
-		ret = arm_all_kprobes();
-		break;
-	case 'n':
-	case 'N':
-	case '0':
-		ret = disarm_all_kprobes();
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret = kstrtobool_from_user(user_buf, count, &enable);
+	if (ret)
+		return ret;
 
+	ret = enable ? arm_all_kprobes() : disarm_all_kprobes();
 	if (ret)
 		return ret;
 
-- 
2.30.2

