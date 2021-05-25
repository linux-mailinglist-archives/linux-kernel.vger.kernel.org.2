Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0766C38FACC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhEYGWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:22:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6698 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhEYGWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:22:35 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fq3lX4ZJXzlYDR;
        Tue, 25 May 2021 14:17:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 14:21:04 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 14:21:03 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/1] tracing: fix spelling mistakes
Date:   Tue, 25 May 2021 14:20:46 +0800
Message-ID: <20210525062047.8951-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files being checked:
kernel/trace/
include/linux/trace*.h


Zhen Lei (1):
  tracing: fix spelling mistakes

 include/linux/tracepoint.h           | 2 +-
 kernel/trace/Kconfig                 | 2 +-
 kernel/trace/ring_buffer.c           | 2 +-
 kernel/trace/ring_buffer_benchmark.c | 2 +-
 kernel/trace/trace.c                 | 6 +++---
 kernel/trace/trace_branch.c          | 2 +-
 kernel/trace/trace_events.c          | 2 +-
 kernel/trace/trace_events_filter.c   | 2 +-
 kernel/trace/trace_seq.c             | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.25.1


