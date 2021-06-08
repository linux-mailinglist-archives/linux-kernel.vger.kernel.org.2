Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8053039EBD6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhFHCVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:21:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4502 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHCVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:21:53 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzYlq29tMzZfvT;
        Tue,  8 Jun 2021 10:17:11 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:20:00 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:19:59 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/1] lib: Fix spelling mistakes in header files
Date:   Tue, 8 Jun 2021 10:19:31 +0800
Message-ID: <20210608021932.12581-1-thunder.leizhen@huawei.com>
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

include/linux/nodemask.h		--> lib/nodemask.c
include/linux/bootconfig.h		--> lib/bootconfig.c
include/linux/percpu-refcount.h		--> lib/percpu-refcount.c
include/linux/scatterlist.h		--> lib/scatterlist.c
include/linux/debugobjects.h		--> lib/debugobjects.c
include/linux/lru_cache.h		--> lib/lru_cache.c
include/linux/cpumask.h			--> lib/cpumask.c


Zhen Lei (1):
  lib: Fix spelling mistakes in header files

 include/linux/bootconfig.h      | 2 +-
 include/linux/cpumask.h         | 2 +-
 include/linux/debugobjects.h    | 2 +-
 include/linux/lru_cache.h       | 8 ++++----
 include/linux/nodemask.h        | 6 +++---
 include/linux/percpu-refcount.h | 2 +-
 include/linux/scatterlist.h     | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.25.1


