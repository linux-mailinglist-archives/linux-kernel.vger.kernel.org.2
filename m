Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF514416FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245546AbhIXKIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 06:08:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3868 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245423AbhIXKIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:08:37 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HG71613Mlz67b9b;
        Fri, 24 Sep 2021 18:04:26 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 12:07:02 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 11:06:58 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <mst@redhat.com>,
        <jasowang@redhat.com>, <robin.murphy@arm.com>
CC:     <xieyongji@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <virtualization@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <thunder.leizhen@huawei.com>, <baolu.lu@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/5] iommu: Some IOVA code reorganisation
Date:   Fri, 24 Sep 2021 18:01:52 +0800
Message-ID: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOVA domain structure is a bit overloaded, holding:
- IOVA tree management
- FQ control
- IOVA rcache memories

Indeed only a couple of IOVA users use the rcache, and only dma-iommu.c
uses the FQ feature.

This series separates out that structure. In addition, it moves the FQ
code into dma-iommu.c . This is not strictly necessary, but it does make
it easier for the FQ domain lookup the rcache domain.

The rcache code stays where it is, as it may be reworked in future, so
there is not much point in relocating and then discarding.

This topic was initially discussed and suggested (I think) by Robin here:
https://lore.kernel.org/linux-iommu/1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com/

I also added in another old patch to avoid double-negatives now that
the error handling is a bit better for IOVA init code:
https://lore.kernel.org/linux-iommu/YAVeDOiKBEKZ2Tdq@myrica/

Baseline is v5.15-rc2

John Garry (5):
  iova: Move fast alloc size roundup into alloc_iova_fast()
  iommu: Separate flush queue memories from IOVA domain structure
  iommu: Move IOVA flush queue code to dma-iommu
  iommu: Separate IOVA rcache memories from iova_domain structure
  iommu/iova: Avoid double-negatives in magazine helpers

 drivers/iommu/dma-iommu.c            | 341 +++++++++++++++++++++++---
 drivers/iommu/iova.c                 | 343 ++++++++-------------------
 drivers/vdpa/vdpa_user/iova_domain.c |  61 ++---
 drivers/vdpa/vdpa_user/iova_domain.h |   4 +-
 include/linux/iova.h                 |  82 +------
 5 files changed, 451 insertions(+), 380 deletions(-)

-- 
2.26.2

