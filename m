Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9D3441D2C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhKAPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAPNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:13:37 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E8EC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:11:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id j9so9303851pgh.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBZi83vZo90X4DWmybsCLymlTmBLf30mrVPyLTdyp98=;
        b=bhiVPa4HmoYB06HhL3gKuW6b3+gCHF3y9NkMc3itttd4nDlARQGqcp4olrHfIVxkFw
         j8Ej3sgGlCFDOlxuO6zvcGmKB0i3zrGEJKCrNxco6ZE105zbpa0sVZDQSJwQI8OjfDEq
         2fx9/+sg8QWuqUmP63p0e1mK5mKgnHRzfggW3S4mIDHGcOCY3zzAF0HjMc9cJ/uZPrQ8
         fJs9MatKzbyvWlveznUpN6uwfs4LObmbhj4IkMA6IZxGtYeJxLFRmQXu9/fPyIs4I1Nt
         9pLIxo4dqueujpk9H7Om1heZtdL9xzLI1UhDJM+easzdGMplldfGEHwAn/YSXBI4Vlia
         dQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBZi83vZo90X4DWmybsCLymlTmBLf30mrVPyLTdyp98=;
        b=4R8IB36sAEFkgmojjXpiEqZcwpxoFFSEN7k7+dohsG8KxNphdpAo2inImnsJkbx60H
         pfk9HtueltG7xjb+1M9PzVwOXQsM+Q9VoHUVocVZAOYaxuTMdka8KzkTL69U3ORil/4J
         ZdFoTPPaodMm4vh1i74uA2Bh1esmstHn071ods+Xf8mlhsqvwF7xYC56yC86AuePtfWt
         duGeEVo9cnvkIFq7UVNcKdgRHYvF06V1+hxZpUHHcGuoP1qlUkq+TyXP26DPw4GxaLuG
         j/Fj2Px+nqbIRxdKDRIq4QgVhEWOXNK7VAItgnodSEw+FJfXox9IIVQ50mJmyxGXWW6b
         jJJQ==
X-Gm-Message-State: AOAM532ECL2m2b1JMQuxWq4GYsGqOAcBLcoSdxfXi/uIjrkvfQCvZKv6
        YPhGVljMezFBlAQae6DLfMM=
X-Google-Smtp-Source: ABdhPJzBWMw0uXmaZMzYXhdUhhVw4vQDybBmKWUZqZqjCHysHSuTv9ab1YTCoJLdS8LRXT/8KzU72w==
X-Received: by 2002:a05:6a00:ac8:b029:320:a6bb:880d with SMTP id c8-20020a056a000ac8b0290320a6bb880dmr29334553pfl.41.1635779463612;
        Mon, 01 Nov 2021 08:11:03 -0700 (PDT)
Received: from localhost.localdomain (li1164-150.members.linode.com. [45.79.65.150])
        by smtp.gmail.com with ESMTPSA id z16sm2435967pfr.69.2021.11.01.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 08:11:03 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [RFC][PATCH v4 2/2] trace: add documentation for the object trace
Date:   Mon,  1 Nov 2021 23:10:41 +0800
Message-Id: <20211101151041.618057-1-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 Documentation/trace/events.rst | 110 +++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 8ddb9b09451c..d8477273ee3a 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -527,6 +527,116 @@ The following commands are supported:
 
   See Documentation/trace/histogram.rst for details and examples.
 
+- objtrace
+
+  This command provides a way to get the value of any object, The object
+  can from the dynamic event(kprobe_event/uprobe_event) or the static event
+  (tracepoint).
+
+  Usage:
+  When using the kprobe event, only need to set the objtrace(a new trigger),
+  we can get the value of the object. The object is from the setting of the
+  kprobe event.
+
+  For example:
+  For the function bio_add_page():
+
+  int bio_add_page(struct bio *bio, struct page *page,
+	unsigned int len, unsigned int offset)
+
+  Firstly, we can set the base of the object, thus the first string "arg1"
+  stands for the value of the first parameter of this function bio_add_gage(),
+
+  echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
+
+  Secondly, we can get the value dynamically base the above object.
+
+  find the offset of the bi_size in struct bio:
+  $ gdb vmlinux
+  (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
+  $1 = (unsigned int *) 0x28
+
+  echo 'objtrace:0x28(arg1):u32:1 if comm == "cat"' > ./events/kprobes/ \
+	p_bio_add_page_0/trigger
+
+  The best way to use this is that we can set the entrance event and exit
+  event, for example, the following example is to set the read_papes as
+  the entrance event, and set the blk_account_io_start as the exit event.
+
+  dd if=/dev/zero of=/test.txt bs=4k count=3
+  cd /sys/kernel/debug/tracing/
+  echo 0 > ./tracing_on
+  echo 'p read_pages' >> ./kprobe_events
+  echo 'p blk_account_io_start' >> ./kprobe_events
+  echo 'traceon if comm == "cat"' > ./events/kprobes/p_read_pages_0/trigger
+  echo 'traceoff if comm == "cat"' > ./events/kprobes/p_blk_account_io_start_0/trigger
+  echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
+  echo 'objtrace:0x28(arg1):u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
+  cat  /test.txt > /dev/null
+  cat ./trace
+  # tracer: nop
+  #
+  # entries-in-buffer/entries-written: 50/50   #P:1
+  #
+  #                                _-----=> irqs-off
+  #                               / _----=> need-resched
+  #                              | / _---=> hardirq/softirq
+  #                              || / _--=> preempt-depth
+  #                              ||| / _-=> migrate-disable
+  #                              |||| /     delay
+  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+  #              | |         |   |||||     |         |
+             cat-95      [000] .....     1.412065: _raw_spin_unlock_irqrestore <-event_triggers_call object:0xffff888108af6328 value:0x0
+             cat-95      [000] .....     1.412066: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x0
+             cat-95      [000] .....     1.412066: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x0
+             cat-95      [000] .....     1.412066: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412066: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412066: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412068: submit_bio <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: submit_bio_noacct <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: __submit_bio <-submit_bio_noacct object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: blk_try_enter_queue <-__submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: submit_bio_checks <-__submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: __cond_resched <-submit_bio_checks object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: rcu_all_qs <-__cond_resched object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: should_fail_bio <-submit_bio_checks object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: create_task_io_context <-submit_bio_checks object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: kmem_cache_alloc_node <-create_task_io_context object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: should_failslab <-kmem_cache_alloc_node object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: _raw_spin_lock <-create_task_io_context object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: blk_mq_submit_bio <-__submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: __blk_queue_split <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: bvec_split_segs <-__blk_queue_split object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: dd_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: _raw_spin_lock <-dd_bio_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: blk_mq_sched_try_merge <-dd_bio_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: elv_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: elv_rqhash_find <-elv_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: dd_request_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: elv_rb_find <-dd_request_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: dd_limit_depth <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: __blk_mq_get_tag <-blk_mq_get_tag object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: blk_mq_rq_ctx_init.isra.0 <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: ktime_get <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: dd_prepare_request <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: blk_account_io_start <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x3000
+
 7. In-kernel trace event API
 ============================
 
-- 
2.25.1

