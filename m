Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767F33A0973
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 03:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhFIBhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 21:37:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8097 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbhFIBhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 21:37:08 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G08jh2H0szYsVg;
        Wed,  9 Jun 2021 09:32:24 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 09:35:06 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 09:35:06 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/1] lib: Fix spelling mistakes in header files
Date:   Wed, 9 Jun 2021 09:34:50 +0800
Message-ID: <20210609013451.13706-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


