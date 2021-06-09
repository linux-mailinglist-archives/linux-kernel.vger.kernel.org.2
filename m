Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1125C3A185E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbhFIPCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:02:35 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5314 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbhFIPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:02:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0VXW5RJ5z1BKfd;
        Wed,  9 Jun 2021 22:55:39 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 23:00:31 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 23:00:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Christoph Lameter <cl@gentwo.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 0/1] ib: Fix spelling mistakes in header files
Date:   Wed, 9 Jun 2021 23:00:26 +0800
Message-ID: <20210609150027.14805-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 --> v3:
Add two new fixes:
arch independent ==> an architecture independent, in include/linux/lru_cache.h
A example structure for ==> Example structure for, in include/linux/nodemask.h

v1 --> v2:
Add a new fix: stroed/stored, in include/linux/bootconfig.h

v1:
include/linux/nodemask.h		--> lib/nodemask.c
include/linux/bootconfig.h		--> lib/bootconfig.c
include/linux/percpu-refcount.h		--> lib/percpu-refcount.c
include/linux/scatterlist.h		--> lib/scatterlist.c
include/linux/debugobjects.h		--> lib/debugobjects.c
include/linux/lru_cache.h		--> lib/lru_cache.c
include/linux/cpumask.h			--> lib/cpumask.c

Zhen Lei (1):
  lib: Fix spelling mistakes in header files

 include/linux/bootconfig.h      | 4 ++--
 include/linux/cpumask.h         | 2 +-
 include/linux/debugobjects.h    | 2 +-
 include/linux/lru_cache.h       | 8 ++++----
 include/linux/nodemask.h        | 6 +++---
 include/linux/percpu-refcount.h | 2 +-
 include/linux/scatterlist.h     | 2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.25.1


