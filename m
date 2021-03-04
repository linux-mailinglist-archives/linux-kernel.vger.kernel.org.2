Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5114D32CDDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhCDHn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:43:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12686 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhCDHnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:43:32 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DrjTN3MHWzlSXp;
        Thu,  4 Mar 2021 15:40:40 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Mar 2021
 15:42:42 +0800
From:   Zhou Guanghui <zhouguanghui1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <hannes@cmpxchg.org>, <hughd@google.com>,
        <kirill.shutemov@linux.intel.com>, <npiggin@gmail.com>,
        <ziy@nvidia.com>, <wangkefeng.wang@huawei.com>,
        <guohanjun@huawei.com>, <dingtianhong@huawei.com>,
        <chenweilong@huawei.com>, <rui.xiang@huawei.com>
Subject: [PATCH v2 0/2] set memcg when split page
Date:   Thu, 4 Mar 2021 07:40:51 +0000
Message-ID: <20210304074053.65527-1-zhouguanghui1@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
1. rename mem_cgroup_split_huge_fixup
2. use split_page_memcg when split page

*** BLURB HERE ***

Zhou Guanghui (2):
  mm/memcg: rename mem_cgroup_split_huge_fixup to split_page_memcg
  mm/memcg: set memcg when split pages

 include/linux/memcontrol.h |  6 ++----
 mm/huge_memory.c           |  2 +-
 mm/memcontrol.c            | 15 ++++++---------
 mm/page_alloc.c            |  1 +
 4 files changed, 10 insertions(+), 14 deletions(-)

-- 
2.25.0

