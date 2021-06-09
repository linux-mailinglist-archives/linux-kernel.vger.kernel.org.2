Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6049C3A119D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbhFIKyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:54:09 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:39918 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbhFIKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:53:52 -0400
Received: by mail-pj1-f52.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so1148378pjp.4;
        Wed, 09 Jun 2021 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rEuxJKsCrgKYAMD0f1XbwF4Fy6H4vsWs0ouH8e/xgA=;
        b=HkY1kXquqImBORfXGpjC0WNRTiCM2scB9nvKCdzIr8BQOiwvpUdfuVhYVMQBCghN1q
         SAaNnhhE3U0ukmjR98uS4Gp+Y6ow6SGGqS0MLiGKP+HM0eG437Kf3esm8AeqB2Edybif
         m7dI2ijBnphAQoHPt1xFK5jxMalJN4SGe9rdD46nUoqLo1eu40gLoDSDkDMS0Br9I9bn
         buvW7QT2OaLYgFmy9vR2XqgAqVQGBh1pF2MV1DFJDHPrXt5JuGnCXLLV+WsWipUEn3FO
         84JXAzNy3VNzTGRXF84JJR0ngBXNsQz6i5A5c35AqFORQNPfyXQdo1tTR+XXsmI2GR5m
         9vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rEuxJKsCrgKYAMD0f1XbwF4Fy6H4vsWs0ouH8e/xgA=;
        b=Z2XypeJVVbZbsZt0nAjZCCDaxSiFGmaYUuzEiip8XBwIFJDSDv866pIRJBNOzmx5xm
         ID8DQNR5HYazGgnvEcszqgSG8kh5/b9Yc6U7SPf/4qE/EuT9hP5KCyXd/P6m4bqJqGZn
         wvkFDrfOaP4LLwYpV70cI6xd5Wq/7HJvtxNphj31FzceaqwxaFvDSyMY9tkcfCbMco8E
         e+j14EnYblkVKAuBjW42tcpDcWhh//OzYiyCGn/nVtXxGtLCg1YwsSOGi0rkbaSXvRRm
         K6Ghl2S09VKQzPXZffqWRZVmDU7oaC3q81BdUYRVS+YqUIrbauJw67p93fjq67fKrZ26
         NhyA==
X-Gm-Message-State: AOAM53315DqRc1ipkcPUxrO699WyhoYG4eIjo8Obi/SI5HKqJxsnB6or
        /3uUaM19XJWQkBf9StWLq6DmocZecLpSgw==
X-Google-Smtp-Source: ABdhPJzOhWgEEN4vAtjWsvVxheMmFNVwRKyKkkHpAgdRhgWMo/rV7m7/0R5j28t8ardWC7h/Ttj7ZQ==
X-Received: by 2002:a17:90b:1d89:: with SMTP id pf9mr9835001pjb.26.1623235858107;
        Wed, 09 Jun 2021 03:50:58 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id z185sm14125372pgb.4.2021.06.09.03.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:50:57 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org
Subject: [RFC PATCH 2/5] kprobes: Use helper to parse boolean input from userspace
Date:   Wed,  9 Jun 2021 19:50:16 +0900
Message-Id: <20210609105019.3626677-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609105019.3626677-1-punitagrawal@gmail.com>
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
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
---
 kernel/kprobes.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index fdb1ea2e963b..1a11d3c411bf 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2777,30 +2777,14 @@ static ssize_t read_enabled_file_bool(struct file *file,
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

