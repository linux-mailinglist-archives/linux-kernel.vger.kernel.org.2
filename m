Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2024422C4F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhJEPZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:25:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23349 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbhJEPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:25:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HP1Ss45H7zRfk4;
        Tue,  5 Oct 2021 23:18:53 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 5 Oct 2021 23:23:15 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 5 Oct 2021 23:23:15 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
        <will@kernel.org>, <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH v2 0/2] iommu/vt-d: boost the mapping process
Date:   Tue, 5 Oct 2021 23:23:06 +0800
Message-ID: <20211005152308.1061-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Changes v1 -> v2:
 - Fix compile warning on i386  [Baolu]

Longpeng(Mike) (2):
  iommu/vt-d: convert the return type of first_pte_in_page to bool
  iommu/vt-d: avoid duplicated removing in __domain_mapping

 drivers/iommu/intel/iommu.c | 12 +++++++-----
 include/linux/intel-iommu.h |  8 +++++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
1.8.3.1

