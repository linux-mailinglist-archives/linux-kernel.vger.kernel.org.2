Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B1145500C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbhKQWDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:03:21 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:44352 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240763AbhKQWDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637186412; x=1668722412;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j8EqZ2E3tsJJr2vVLoX7B0Dbv8BtMcVkEGw0WBUIKjI=;
  b=ifeylYRP8ZSo2UNQPn4uwktcOVcv5e6uU676HuU9jF1FThtS02rgDq+y
   VZp0VwHivcpsD1+XmiZLXoAhTetaaq31cdGoQyiA5UVfPumdPZ6ZoZZey
   AHmxBar4J9nvBVQEZEDEDDHYDMERXA+EpcMK6dpcfheaObxm5JHigg71K
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Nov 2021 14:00:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 14:00:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 17 Nov 2021 14:00:10 -0800
Received: from fixkernel.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 17 Nov
 2021 14:00:10 -0800
Date:   Wed, 17 Nov 2021 17:00:07 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
CC:     Yu Zhao <yuzhao@google.com>, <linux-kernel@vger.kernel.org>
Subject: BUG: KASAN: use-after-free in dec_rlimit_ucounts
Message-ID: <YZV7Z+yXbsx9p3JN@fixkernel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, I can still reproduce this quickly on today's linux-next and all
the way back to 5.15-rc6 by running a syscall fuzzer for a while. The trace
points out to this line,

        for (iter = ucounts; iter; iter = iter->ns->ucounts) {

It looks KASAN indicated that that "ns" had already been freed. Is that
possible or perhaps this is more of refcount issue? 

 BUG: KASAN: use-after-free in dec_rlimit_ucounts
 Read of size 8 at addr ffff0008c0739860 by task trinity-c27/10924

 CPU: 27 PID: 10924 Comm: trinity-c27 Not tainted 5.15.0-next-20211115-dirty #192
 Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  print_address_description.constprop.0
  kasan_report
  __asan_report_load8_noabort
  dec_rlimit_ucounts
  dec_rlimit_ucounts at kernel/ucount.c:284
  mqueue_evict_inode
  mqueue_evict_inode at ipc/mqueue.c:544
  evict
  iput.part.0
  iput
  __arm64_sys_mq_unlink
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Allocated by task 10615:
  kasan_save_stack
  __kasan_slab_alloc
  slab_post_alloc_hook
  kmem_cache_alloc
  create_user_ns
  unshare_userns
  ksys_unshare
  __arm64_sys_unshare
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Freed by task 8660:
  kasan_save_stack
  kasan_set_track
  kasan_set_free_info
  __kasan_slab_free
  slab_free_freelist_hook
  kmem_cache_free
  free_user_ns
  process_one_work
  worker_thread
  kthread
  ret_from_fork

 Last potentially related work creation:
  kasan_save_stack
  __kasan_record_aux_stack
  kasan_record_aux_stack_noalloc
  insert_work
  __queue_work
  queue_work_on
  __put_user_ns
  put_cred_rcu
  rcu_do_batch
  rcu_core
  rcu_core_si
  __do_softirq

 The buggy address belongs to the object at ffff0008c07395e8
  which belongs to the cache user_namespace of size 768
 The buggy address is located 632 bytes inside of
  768-byte region [ffff0008c07395e8, ffff0008c07398e8)
 The buggy address belongs to the page:
 page:fffffc002301ce00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff0008c073cec8 pfn:0x940738
 head:fffffc002301ce00 order:3 compound_mapcount:0 compound_pincount:0
 memcg:ffff0008b9b5f101
 flags: 0xbfffc0000010200(slab|head|node=0|zone=2|lastcpupid=0xffff)
 raw: 0bfffc0000010200 ffff000800f3e9c8 ffff000800f3e9c8 ffff000802e69b80
 raw: ffff0008c073cec8 00000000001d0012 00000001ffffffff ffff0008b9b5f101
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff0008c0739700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff0008c0739780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff0008c0739800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff0008c0739880: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
  ffff0008c0739900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
