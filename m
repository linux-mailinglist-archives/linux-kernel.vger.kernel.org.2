Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A774082D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 04:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhIMC1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 22:27:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19031 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbhIMC1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 22:27:45 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H79H42j3RzbmK1;
        Mon, 13 Sep 2021 10:22:24 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 10:26:28 +0800
Received: from huawei.com (10.175.100.227) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 10:26:27 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <david@redhat.com>
CC:     <osalvador@suse.de>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <tangyizhou@huawei.com>
Subject: [PATCH] mm/memory_hotplug: Add static qualifier for online_policy_to_str
Date:   Mon, 13 Sep 2021 10:45:34 +0800
Message-ID: <20210913024534.26161-1-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

online_policy_to_str is only used in memory_hotplug.c and should be
defined as static.

Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0488eed3327c..4ea91c3ff768 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -57,7 +57,7 @@ enum {
 	ONLINE_POLICY_AUTO_MOVABLE,
 };
 
-const char *online_policy_to_str[] = {
+static const char * const online_policy_to_str[] = {
 	[ONLINE_POLICY_CONTIG_ZONES] = "contig-zones",
 	[ONLINE_POLICY_AUTO_MOVABLE] = "auto-movable",
 };
-- 
2.17.1

