Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319DA3EEB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbhHQLSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhHQLSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:18:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528D4C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:17:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c4so8312637plh.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYnBlspxuhmknpZcNmSYoK8ZHtQKC47YyVKDkOVKsD4=;
        b=h4bcGsPgTmH7dao7enbARdwWwCLQwEfFB7EcMcJFCT1Kx4znYfygSvYklmKm57wEUp
         mZOmcbDH1miatWqZD9/EKfSX6Ragalg9LZ4qMB41KX4NqJ08wYhDOQT3MCpXXJD3DNz6
         Ex2Wen3wBnOGtbMTz5ar2a3TvSw/L7sOAiYZslaM1Sw145CS+UZC16lnNzNEVjEAF8cJ
         nnGMuBmb2lU8w65wA9KQ+pBmmZzSF8ckhMTPx7nn8LdP954rRdtULjLFFZ2YyqFMYsMT
         a0x2Sn5p7ppOlsBx553ypU3lgt2qmrHypJnkQ2SMt29spI63GQr5mQ2ehWt32ZnVhPeG
         uJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYnBlspxuhmknpZcNmSYoK8ZHtQKC47YyVKDkOVKsD4=;
        b=aA1dO/TBfji7ctFmo1DT90FNI7Fz3h1Hh59QDhp72VtH2d5tkQ7954Nso6KbYqE3v0
         JrblriJhqa1Hf0YN3MYm4c6bAUwGozfKN7c4fXYMdwZKkIuPdOn2AzQF9Cia6ka2SYPh
         JYDxXxooqOORN62sfJ7whxtxISS9/rxHaotl4MyWDa4KOcDL2sCI2eGXxpaR/e7KrV6u
         0A4H67L2QDiqwO+Wav5fanF/hM7Ybr7DYw2HEV3IPR4pSoa+wxiumv0d/2h/oQSMR/nC
         gSZtGX92+U6CsS9/37i5NfDSC7uSiG49VR34sd3QypRR1tnNlIL5VmCMctuqnOAh8pJa
         3rwA==
X-Gm-Message-State: AOAM532jJfqJkS64CT0B3G2ssOXCQ+CxJznGtPAkz+iSr8h4F45MZ3y8
        0Fa/YSUaEhX3d2bWwwNLCwtElZxM2No=
X-Google-Smtp-Source: ABdhPJzZ1eTyH6XejS0cJw2IRmQ36fKLmQodNGTJhSvTvx6zl0NETDei0rmNLfpTuEgSp9hLQXWA6g==
X-Received: by 2002:a17:90a:5285:: with SMTP id w5mr3072044pjh.78.1629199067653;
        Tue, 17 Aug 2021 04:17:47 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id fh19sm2100967pjb.27.2021.08.17.04.17.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 04:17:47 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 0/6] workqueue: Make flush_workqueue() also watch flush_work()
Date:   Tue, 17 Aug 2021 09:32:33 +0800
Message-Id: <20210817013239.3921-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <CAJhGHyBsn+rqVQzNqRw2RxtpHyrpQpa0kMtU1RcZP7TCbC6dqg@mail.gmail.com>
References: <CAJhGHyBsn+rqVQzNqRw2RxtpHyrpQpa0kMtU1RcZP7TCbC6dqg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Li reported a problem[1] that the sanity check in destroy_workqueue() catches
a WARNING due to drain_workqueue() doesn't wait for flush_work() to finish.

The warning logs are listed below:

WARNING: CPU: 0 PID: 19336 at kernel/workqueue.c:4430 destroy_workqueue+0x11a/0x2f0
*****
destroy_workqueue: test_workqueue9 has the following busy pwq
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/1 refcnt=2
      in-flight: 5658:wq_barrier_func
Showing busy workqueues and worker pools:
*****

It shows that even after drain_workqueue() returns, the barrier work item
is still in flight and the pwq (and a worker) is still busy on it.

The problem is caused by drain_workqueue() not watching flush_work():

Thread A				Worker
					/* normal work item with linked */
					process_scheduled_works()
destroy_workqueue()			  process_one_work()
  drain_workqueue()			    /* run normal work item */
				 /--	    pwq_dec_nr_in_flight()
    flush_workqueue()	    <---/
		/* the last normal work item is done */
  sanity_check				  process_one_work()
				       /--  raw_spin_unlock_irq(&pool->lock)
    raw_spin_lock_irq(&pool->lock)  <-/     /* maybe preempt */
    *WARNING*				    wq_barrier_func()
					    /* maybe preempt by cond_resched() */

So the solution is to make drain_workqueue() watch for flush_work() which
means making flush_workqueue() watch for flush_work().

Due to historical convenience, we used WORK_NO_COLOR for barrier work items
queued by flush_work().  The color has two purposes:
	Not participate in flushing
	Not participate in nr_active

Only the second purpose is obligatory.  So the plan is to mark barrier
work items inactive without using WORK_NO_COLOR in patch4 so that we can
assign a flushing color to them in patch5.

Patch1-3 are preparation, and patch6 is a cleanup.

[1]: https://lore.kernel.org/lkml/20210812083814.32453-1-lizhe.67@bytedance.com/

Lai Jiangshan (6):
  workqueue: Rename "delayed" (delayed by active management) to
    "inactive"
  workqueue: Change arguement of pwq_dec_nr_in_flight()
  workqueue: Change the code of calculating work_flags in
    insert_wq_barrier()
  workqueue: Mark barrier work with WORK_STRUCT_INACTIVE
  workqueue: Assign a color to barrier work items
  workqueue: Remove unused WORK_NO_COLOR

 include/linux/workqueue.h   |  13 ++--
 kernel/workqueue.c          | 133 ++++++++++++++++++++++--------------
 kernel/workqueue_internal.h |   3 +-
 3 files changed, 88 insertions(+), 61 deletions(-)

-- 
2.19.1.6.gb485710b

