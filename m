Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8BD33EE45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCQK0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:26:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14361 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhCQKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:25:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F0mTp1w7lz9s00;
        Wed, 17 Mar 2021 18:23:58 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 18:25:40 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <jolsa@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <yangjihong1@huawei.com>,
        <xukuohai@huawei.com>, <zhangjinhao2@huawei.com>,
        <lihuafei1@huawei.com>
Subject: [PATCH 0/2] Fix the race on &event->ftrace_ops between perf and ftrace
Date:   Wed, 17 Mar 2021 18:25:27 +0800
Message-ID: <20210317102529.226734-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race on &event->ftrace_ops between perf_alloc_event() and
__ftrace_ops_list_func(). When adding a perf event, if the event needs
to use the ftrace framework, it needs to register ftrace_ops with
ftrace, which is a structural member of perf event. If perf_alloc_event()
fails, it will free the allocated event directly, but if ftrace_ops has
been successfully registered, and the probe point is triggered, then
__ftrace_ops_list_func() may still reference the ftrace_ops that perf
just registered, but it has been freed with the event is freed,
so use-after-free happens.

This race condition was triggered when we did the fuzz test, see the commit
message of PATCH 2 for detailed logs. This patch set fixes this race.

Li Huafei (2):
  ftrace: Update ftrace_ops->next pointer with rcu_assign_pointer()
  perf, ftrace: Fix use-after-free in __ftrace_ops_list_func()

 include/linux/ftrace.h          | 15 +++++++++++++++
 kernel/trace/ftrace.c           |  4 ++--
 kernel/trace/trace_event_perf.c |  7 +++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.17.1

