Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B064318FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhJRMZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:25:10 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25228 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhJRMZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:25:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HXwwR4NfMz8tkh;
        Mon, 18 Oct 2021 20:21:43 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 20:22:55 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 20:22:55 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <edumazet@google.com>, <wangkefeng.wang@huawei.com>,
        <guohanjun@huawei.com>, <shakeelb@google.com>, <urezki@gmail.com>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v2 0/2] fix numa spreading for large hash tables
Date:   Mon, 18 Oct 2021 20:37:08 +0800
Message-ID: <20211018123710.1540996-1-chenwandun@huawei.com>
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

[PATCH v2 1/2] fix numa spreading problem
[PATCH v2 2/2] optimization about performance

v1 ==> v2:
1. do a minimal fix in [PATCH v2 1/2]
2. add some comments

Chen Wandun (2):
  mm/vmalloc: fix numa spreading for large hash tables
  mm/vmalloc: introduce alloc_pages_bulk_array_mempolicy to accelerate
    memory allocation

 include/linux/gfp.h |  4 +++
 mm/mempolicy.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++
 mm/vmalloc.c        | 28 ++++++++++++----
 3 files changed, 108 insertions(+), 6 deletions(-)

-- 
2.25.1

