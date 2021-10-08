Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43A74260E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 02:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbhJHAGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 20:06:40 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13705 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhJHAGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 20:06:37 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HQT0v5Qt3zWjPG;
        Fri,  8 Oct 2021 08:03:11 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 08:04:39 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 08:04:38 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
        <will@kernel.org>, <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH v3 0/2] iommu/vt-d: boost the mapping process
Date:   Fri, 8 Oct 2021 08:04:31 +0800
Message-ID: <20211008000433.1115-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

We found that the __domain_mapping() would take too long when
the memory region is too large, we try to make it faster in this
patchset. The performance number can be found in PATCH 2, please
review when you free, thanks.

Changes v2 -> v3:
 - make first_pte_in_page() neater  [Baolu]
 - remove meaningless BUG_ON() in __domain_mapping()  [Baolu]

Changes v1 -> v2:
 - Fix compile warning on i386  [Baolu]

Longpeng(Mike) (2):
  iommu/vt-d: convert the return type of first_pte_in_page to bool
  iommu/vt-d: avoid duplicated removing in __domain_mapping

 drivers/iommu/intel/iommu.c | 11 ++++++-----
 include/linux/intel-iommu.h | 10 ++++++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

-- 
1.8.3.1

