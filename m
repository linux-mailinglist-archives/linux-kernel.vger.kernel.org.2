Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FAF435C78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhJUH4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:56:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13961 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhJUH4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:56:35 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HZfpN6q8xzZcQC;
        Thu, 21 Oct 2021 15:52:28 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 15:54:15 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 15:54:09 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <edumazet@google.com>, <wangkefeng.wang@huawei.com>,
        <guohanjun@huawei.com>, <shakeelb@google.com>, <urezki@gmail.com>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v3 0/2] fix numa spreading for large hash tables
Date:   Thu, 21 Oct 2021 16:07:42 +0800
Message-ID: <20211021080744.874701-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH v3 1/2] fix numa spreading problem
[PATCH v3 2/2] optimization about performance

v1 ==> v2:
1. do a minimal fix in [PATCH v2 1/2]
2. add some comments

v2 ==> v3:
remote redundant code

based on commit 14a60b114a8560de785df502fdc5687a969eae81

Chen Wandun (2):
  mm/vmalloc: fix numa spreading for large hash tables
  mm/vmalloc: introduce alloc_pages_bulk_array_mempolicy to accelerate
    memory allocation

 include/linux/gfp.h |  4 +++
 mm/mempolicy.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++
 mm/vmalloc.c        | 27 +++++++++++----
 3 files changed, 107 insertions(+), 6 deletions(-)

-- 
2.25.1

