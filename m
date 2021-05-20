Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26193389EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhETHUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:20:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3440 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETHUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:20:34 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fm1Hs0kpTzCs8h;
        Thu, 20 May 2021 15:16:25 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 15:19:12 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 20 May
 2021 15:19:11 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <cuibixuan@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 0/3] iommu/arm-smmu-v3: clean up some code style issues
Date:   Thu, 20 May 2021 16:42:17 +0800
Message-ID: <20210520084220.51684-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some code style issues.

Bixuan Cui (3):
  iommu/arm-smmu-v3: fix missing a blank line after declarations
  iommu/arm-smmu-v3: Change *array into *const array
  iommu/arm-smmu-v3: Prefer unsigned int to bare use of unsigned

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.17.1

