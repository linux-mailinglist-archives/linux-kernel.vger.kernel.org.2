Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353BB3EB66E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbhHMOA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbhHMOAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:00:53 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38FEC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:00:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c12so2707713ljr.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVM0vplmy/19oK/cXrcKqIhbxHNaKwUpDUiALp+Y6aE=;
        b=qCdruYefutWcjRrs3M/Y8Udlh9BzmfI2VBGmQAwmpPOdLXo/52OU1jEr0frSqAsfB0
         pr5SZqxxMxH3RL88RSRRY8v2rViEd5gUbtZXzxRPkgcgW93uMYQ+8Hngw6ZH7lSTF0XK
         E63VgjFuBAS+uJ8k6CaaVIJePYuSncm+wtyml15y9bEmJlswD6yhITjfhLL+UFhRx9m6
         9iTi8HHmLLoo/7i584xEqHSczw/5hapOBgYB2caJwq8eux6APBgaztvWyVYq87so8fn+
         sH4rOIidwbuHvvRypbps4CZsG9iy/9EaOM94w7cMSc2073AcnIRL/vzXDEHRgJLgsMJ8
         p0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVM0vplmy/19oK/cXrcKqIhbxHNaKwUpDUiALp+Y6aE=;
        b=YMPHUYgOhqtM9ewX0axYtaFgGZRKO0jFH+foYSAvprXL8adarHhMX6Hih0BhuoKcIn
         uMTLdwH5EPHZ0O/lrru/AT8Os0PNjeG9TlQb3CRBUBUfjP0bbtF8SqdX+QzOqiRpbQHA
         rak6mxTrFykZ5TKNKNjOn7yjGdMsSCtBOYf2yhZE6Gtt2GQn5k4EtzKdVOPBFDcG+f7q
         RSaQ0pMvxcuJnn6zKkxHL4sUapn2DbPmhwF4ez1wlJqa3cj/f/6Il1RPrlX+LrmpVCVu
         3g0aLiHui3s+MnZdEWdqR9YHtwzccsLH/2u4yp4BsAZY3c3FdpNKlM3ChoIm4hyw6iyw
         zOZg==
X-Gm-Message-State: AOAM532Feu3/yVF6ohoVwknp/wCxPQep1OXtfhzXNAnMq2/M0cARekLT
        409+l3IvTE4gWBUmEg1RNhXMI4SZBqyXsw==
X-Google-Smtp-Source: ABdhPJxtJmMaaBxGAbInWk8Sqlc4Ietf7STHLSTXHytqFjsXm17SZQxD6cM/rca40hCqGYZfE9H2Aw==
X-Received: by 2002:a2e:824e:: with SMTP id j14mr1926569ljh.77.1628863225011;
        Fri, 13 Aug 2021 07:00:25 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.232])
        by smtp.gmail.com with ESMTPSA id u10sm165002lft.252.2021.08.13.07.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 07:00:24 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     rostedt@goodmis.org, penguin-kernel@I-love.SAKURA.ne.jp,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH v2] profiling: fix shift-out-of-bounds bugs
Date:   Fri, 13 Aug 2021 17:00:22 +0300
Message-Id: <20210813140022.5011-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <99b9e091-9e95-5e45-5914-38a938840aa6@i-love.sakura.ne.jp>
References: <99b9e091-9e95-5e45-5914-38a938840aa6@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported shift-out-of-bounds bug in profile_init().
The problem was in incorrect prof_shift. Since prof_shift value comes from
userspace we need to clamp this value into [0, BITS_PER_LONG -1]
boundaries.

Second possible shiht-out-of-bounds was found by Tetsuo:
sample_step local variable in read_profile() had "unsigned int" type,
but prof_shift allows to make a BITS_PER_LONG shift. So, to prevent
possible shiht-out-of-bounds sample_step type was changed to
"unsigned long".

Also, "unsigned short int" will be sufficient for storing
[0, BITS_PER_LONG] value, that's why there is no need for
"unsigned long" prof_shift.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-and-tested-by: syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com
Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Changes in v2:
	1. Fixed possible shiht-out-of-bounds in read_profile()
	   (Reported by Tetsuo)

	2. Changed prof_shift type from "unsigned long" to
	   "unsigned short int"

---
 kernel/profile.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index c2ebddb5e974..eb9c7f0f5ac5 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -41,7 +41,8 @@ struct profile_hit {
 #define NR_PROFILE_GRP		(NR_PROFILE_HIT/PROFILE_GRPSZ)
 
 static atomic_t *prof_buffer;
-static unsigned long prof_len, prof_shift;
+static unsigned long prof_len;
+static unsigned short int prof_shift;
 
 int prof_on __read_mostly;
 EXPORT_SYMBOL_GPL(prof_on);
@@ -67,8 +68,8 @@ int profile_setup(char *str)
 		if (str[strlen(sleepstr)] == ',')
 			str += strlen(sleepstr) + 1;
 		if (get_option(&str, &par))
-			prof_shift = par;
-		pr_info("kernel sleep profiling enabled (shift: %ld)\n",
+			prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
+		pr_info("kernel sleep profiling enabled (shift: %u)\n",
 			prof_shift);
 #else
 		pr_warn("kernel sleep profiling requires CONFIG_SCHEDSTATS\n");
@@ -78,21 +79,21 @@ int profile_setup(char *str)
 		if (str[strlen(schedstr)] == ',')
 			str += strlen(schedstr) + 1;
 		if (get_option(&str, &par))
-			prof_shift = par;
-		pr_info("kernel schedule profiling enabled (shift: %ld)\n",
+			prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
+		pr_info("kernel schedule profiling enabled (shift: %u)\n",
 			prof_shift);
 	} else if (!strncmp(str, kvmstr, strlen(kvmstr))) {
 		prof_on = KVM_PROFILING;
 		if (str[strlen(kvmstr)] == ',')
 			str += strlen(kvmstr) + 1;
 		if (get_option(&str, &par))
-			prof_shift = par;
-		pr_info("kernel KVM profiling enabled (shift: %ld)\n",
+			prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
+		pr_info("kernel KVM profiling enabled (shift: %u)\n",
 			prof_shift);
 	} else if (get_option(&str, &par)) {
-		prof_shift = par;
+		prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
 		prof_on = CPU_PROFILING;
-		pr_info("kernel profiling enabled (shift: %ld)\n",
+		pr_info("kernel profiling enabled (shift: %u)\n",
 			prof_shift);
 	}
 	return 1;
@@ -468,7 +469,7 @@ read_profile(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	unsigned long p = *ppos;
 	ssize_t read;
 	char *pnt;
-	unsigned int sample_step = 1 << prof_shift;
+	unsigned long sample_step = 1UL << prof_shift;
 
 	profile_flip_buffers();
 	if (p >= (prof_len+1)*sizeof(unsigned int))
-- 
2.32.0

