Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0525F41C3C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbhI2LxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245211AbhI2Lw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:52:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBC1C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso3808727pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/VjNrwEZjpRMSoLri0tBeyC7nWBWmXaqPoJWcQsBRk=;
        b=Mc+0M/FXboBQONFYA3d1hJzH3d1+3tb62bSla4J6H8qgE6iJt31alEfsie1XH5Lf6N
         EQZfC/CyvDO7KtK4EgD5tM/JI7v34/0rJuyeRSCODDZJanNfcAfv/ACtswPYp0PDHYbZ
         zPFNlkzTOdaVCWFunasUNwTowiRx9AiN9UWumvOwv5Lp8EDmFvU/UTwtDm1gVo8QkKAY
         wpWIKV2oum4B0OgUsi3DgARpeVTFTwPiFy3Qa0FikR5Yv4vU+Nh1IgdUeoPp/ii74VNn
         laidlA+5XCGS9raRY+HtGiNTxXTreqj2AJpnCFsI8TopSwHrMq5R5EMf1kDUvYvizVIc
         mKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/VjNrwEZjpRMSoLri0tBeyC7nWBWmXaqPoJWcQsBRk=;
        b=xo835vICCD5j3ZttfRYT53nLCNjoFnnzBC6+wKE4OctODwJ5cX2dju406icc35BDUD
         8eSOb0GvP2F/cmeGHhWQOuU/SuSi5qEpIamDBN0cA+/CsuHSPw8ZFL6Ss1GrwBj2LUmz
         oapvUm41HIqJKqp30nLoUhkz4cb/jzfBf8+RD48WCwpIn7CANTMsPAuzQFnkT4h1K6EJ
         L4eareo6/AYey2Ww+M+LmfxAY98XxTtZlWE43DSRlIsFNhMB9eQY4D7rod/cuROiNoc6
         YcdbJeMJFDCmiA0E6oboKCU2srN9JUCDyhyGq1kOpckAslXHkoLK97uWjBNNF8IWlX+b
         r3LQ==
X-Gm-Message-State: AOAM533gc01ivHXPzZd94lN1g375vlWvNxNIjIMU8Ay+zKXizif0B3UU
        KRi9X1M4/HayZzoY/Cy2JVY=
X-Google-Smtp-Source: ABdhPJzbYQaSiA+3ZLRvYl8E7EYQm0FH59QeOCNG3ub/D8U93lauJSAkPhQRYGhMiPi7Vv6ftnfDLQ==
X-Received: by 2002:a17:90b:1b06:: with SMTP id nu6mr5910331pjb.15.1632916275599;
        Wed, 29 Sep 2021 04:51:15 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id u12sm2403204pgi.21.2021.09.29.04.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 04:51:15 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, viro@zeniv.linux.org.uk,
        christian@brauner.io, dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 2/5] kernel/fork: allocate task->comm dynamicly
Date:   Wed, 29 Sep 2021 11:50:33 +0000
Message-Id: <20210929115036.4851-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210929115036.4851-1-laoar.shao@gmail.com>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task->comm is defined as an array embedded in struct task_struct before.
This patch changes it to a char pointer. It will be allocated in the fork
and freed when the task is freed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/sched.h |  2 +-
 kernel/fork.c         | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e12b524426b0..b387b5943db4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1051,7 +1051,7 @@ struct task_struct {
 	 * - access it with [gs]et_task_comm()
 	 * - lock it with task_lock()
 	 */
-	char				comm[TASK_COMM_LEN];
+	char				*comm;
 
 	struct nameidata		*nameidata;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..227aec240501 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -721,6 +721,20 @@ static void mmdrop_async(struct mm_struct *mm)
 	}
 }
 
+static int task_comm_alloc(struct task_struct *p)
+{
+	p->comm = kzalloc(TASK_COMM_LEN, GFP_KERNEL);
+	if (!p->comm)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void task_comm_free(struct task_struct *p)
+{
+	kfree(p->comm);
+}
+
 static inline void free_signal_struct(struct signal_struct *sig)
 {
 	taskstats_tgid_free(sig);
@@ -753,6 +767,7 @@ void __put_task_struct(struct task_struct *tsk)
 	bpf_task_storage_free(tsk);
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
+	task_comm_free(tsk);
 	put_signal_struct(tsk->signal);
 	sched_core_free(tsk);
 
@@ -2076,6 +2091,10 @@ static __latent_entropy struct task_struct *copy_process(
 	if (data_race(nr_threads >= max_threads))
 		goto bad_fork_cleanup_count;
 
+	retval = task_comm_alloc(p);
+	if (retval)
+		goto bad_fork_cleanup_count;
+
 	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
 	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE | PF_NO_SETAFFINITY);
 	p->flags |= PF_FORKNOEXEC;
-- 
2.17.1

