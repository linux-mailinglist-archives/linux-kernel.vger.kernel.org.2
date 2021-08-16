Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B83ED123
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhHPJkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 05:40:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62489 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhHPJkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 05:40:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629106787; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oKikVBz7YtjF50RcnbcWEBy/0mgCOYKAeqMfAVhOyHw=; b=YZwZ/RGW0x2sLUNS7lK78RKINFQYEehAJLmVxtXVDbpSLVC7zAyg59UHleWhIjXMcyRQSHt+
 D+AWv44rywZlyFPyNht0YAM1Fufq41OwqexUcA+JXx61h2STFPZMMoZn/l0Fh7QYe5dWC87q
 vSfUVHRNb0pHeRsqrfc5XZVVvXs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 611a325f454b7a558f99ca83 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Aug 2021 09:39:43
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C518C43460; Mon, 16 Aug 2021 09:39:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-charante-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34952C4338F;
        Mon, 16 Aug 2021 09:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 34952C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, rientjes@google.com,
        shakeelb@google.com, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org
Cc:     vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] mm: oom_kill: add trace logs in process_mrelease() system call
Date:   Mon, 16 Aug 2021 15:09:16 +0530
Message-Id: <1629106756-20874-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The process_mrelease() system call[1] is used to release the memory of
a dying process from the context of the caller, which is similar to and
uses the functions of the oom reaper logic. There exists trace logs for
a process when reaped by the oom reaper. Just extend the same to when
done by the process_mrelease() system call.

[1] https://lore.kernel.org/linux-mm/20210809185259.405936-1-surenb@google.com/

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 mm/oom_kill.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 431d38c..8f4020a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -941,7 +941,6 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	mmdrop(mm);
 	put_task_struct(victim);
 }
-#undef K
 
 /*
  * Kill provided task unless it's secured by setting
@@ -1199,8 +1198,18 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 		ret = -EINTR;
 		goto drop_mm;
 	}
+	trace_start_task_reaping(task->pid);
 	if (!__oom_reap_task_mm(mm))
 		ret = -EAGAIN;
+	if (!ret) {
+		pr_info("process_mrelease: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB oom_score_adj:%d\n",
+			task_pid_nr(task), task->comm,
+			K(get_mm_counter(mm, MM_ANONPAGES)),
+			K(get_mm_counter(mm, MM_FILEPAGES)),
+			K(get_mm_counter(mm, MM_SHMEMPAGES)),
+			task->signal->oom_score_adj);
+	}
+	trace_finish_task_reaping(task->pid);
 	mmap_read_unlock(mm);
 
 drop_mm:
@@ -1208,9 +1217,12 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 put_task:
 	put_task_struct(task);
 put_pid:
+	if (ret && ret != -EAGAIN)
+		trace_skip_task_reaping(pid_vnr(pid));
 	put_pid(pid);
 	return ret;
 #else
 	return -ENOSYS;
 #endif /* CONFIG_MMU */
 }
+#undef K
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

