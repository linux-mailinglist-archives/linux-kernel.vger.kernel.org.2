Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5A2334A69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhCJWBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbhCJWBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:01:09 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD62C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:01:09 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mm21so41797881ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5b+lsixy3d7D3BIr++muUtKp8Fmjm6SWsiwbl+RXXPw=;
        b=Vq9es4vGcXJRtQHcmyvIJzK8d5nwG9k2/kE0pDNUa2CEeM34TDYhXaOo4Aj518rW+z
         2k6YfPQqQAAMhFQTR1wdj6OWVoeYZaW7aSThgQrV1dVroOdEla1RISzSz7w+RF/SkY0k
         eJJX8oTGBnK3gM1Avc4uTDxOPaxYxSMz6xfCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5b+lsixy3d7D3BIr++muUtKp8Fmjm6SWsiwbl+RXXPw=;
        b=n5YqhtLKf/Q4GuIasw5bOedo+9zSQGdxpygb4Ukdh7PVODYJkMpOsNWn7MRFvB0JWV
         TbFr+Wwzv5vGZm8tXguaYRJNK00udanxm0nn3cGEMOdT3HUOqVM45oESe/APXIor15Hj
         qdkL9frS3u7p/k87g5y80bl2puFLAs1RFF/t78UKZ3b3ENuf82go0P0k4iLZbap0A1ja
         +t6qufsJOKgyaQYq/ldO5yM8esBvW0ID3lEWmu2AzWxBmRBmzwaiIf1FUWCskGpMJlsn
         vY+ZkbGiIUQkdtVy33Ce4qUo1ITHZ3IO+8L6vjF/VIYnRVfz/68A/08CgGoQ/VLD1/kv
         0lOQ==
X-Gm-Message-State: AOAM530+6C/F8X8gvEJXALVqwUbVk5aSDSn5hFt+l3bCruzcVq3lPQ8Q
        hTm6RyjhKL3HrpNI5wRoGA5weA==
X-Google-Smtp-Source: ABdhPJxXpTNVKEgdl1uJ9O8I60+OTCZexcFAdp/WTMaXdSlSfIejd1pmnhHf9Fsm1ugh5Fpw4k5vdQ==
X-Received: by 2002:a17:906:b14d:: with SMTP id bt13mr15804ejb.407.1615413668056;
        Wed, 10 Mar 2021 14:01:08 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id x21sm268122eds.53.2021.03.10.14.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:01:07 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hubert Jasudowicz <hubert.jasudowicz@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH resend] kernel/cred.c: make init_groups static
Date:   Wed, 10 Mar 2021 23:01:01 +0100
Message-Id: <20210310220102.2484201-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_groups is declared in both cred.h and init_task.h, but it is not
actually referenced anywhere outside of cred.c where it is defined. So
make it static and remove the declarations.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/cred.h      | 1 -
 include/linux/init_task.h | 1 -
 kernel/cred.c             | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 4c6350503697..2695ad118806 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -53,7 +53,6 @@ do {							\
 		groups_free(group_info);		\
 } while (0)
 
-extern struct group_info init_groups;
 #ifdef CONFIG_MULTIUSER
 extern struct group_info *groups_alloc(int);
 extern void groups_free(struct group_info *);
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index b2412b4d4c20..40fc5813cf93 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -25,7 +25,6 @@
 extern struct files_struct init_files;
 extern struct fs_struct init_fs;
 extern struct nsproxy init_nsproxy;
-extern struct group_info init_groups;
 extern struct cred init_cred;
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
diff --git a/kernel/cred.c b/kernel/cred.c
index 421b1149c651..e1d274cd741b 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -33,7 +33,7 @@ do {									\
 static struct kmem_cache *cred_jar;
 
 /* init to 2 - one for init_task, one to ensure it is never freed */
-struct group_info init_groups = { .usage = ATOMIC_INIT(2) };
+static struct group_info init_groups = { .usage = ATOMIC_INIT(2) };
 
 /*
  * The initial credentials for the initial task
-- 
2.29.2

