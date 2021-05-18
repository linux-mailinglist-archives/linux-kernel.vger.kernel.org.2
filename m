Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953BC38733A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbhERHZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:25:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3006 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbhERHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:25:13 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FknTN4yBrzQpjd;
        Tue, 18 May 2021 15:20:24 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 15:23:53 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 15:23:53 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <john.garry@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH 0/9] drivers/perf: Use general macro to simplify event attributes
Date:   Tue, 18 May 2021 15:23:39 +0800
Message-ID: <1621322628-9945-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset apply a general EVENT_ATTR_ID to simplify event
attributes in many PMU drivers.

Qi Liu (9):
  perf: Add EVENT_ATTR_ID to simplify event attributes
  drivers/perf: hisi: Remove redundant macro and functions
  drivers/perf: Remove redundant macro and functions in arm_smmuv3_pmu.c
  drivers/perf: Remove redundant macro and functions in qcom_l2_pmu.c
  drivers/perf: Remove redundant macro and functions in qcom_l3_pmu.c
  drivers/perf: Remove redundant macro and functions in xgene_pmu.c
  drivers/perf: Remove redundant macro and functions in fsl_imx8_ddr_perf.c
  drivers/perf: Remove redundant macro and functions in arm_dsu_pmu.c
  arm64: perf: Remove redundant macro and functions in perf_event.c

 arch/arm64/kernel/perf_event.c                | 175 +++++-----
 drivers/perf/arm_dsu_pmu.c                    |  28 +-
 drivers/perf/arm_smmuv3_pmu.c                 |  33 +-
 drivers/perf/fsl_imx8_ddr_perf.c              |  80 ++---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |  22 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |  62 ++--
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  |  34 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   |   6 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |  14 -
 drivers/perf/hisilicon/hisi_uncore_pmu.h      |   2 -
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c |  10 +-
 drivers/perf/qcom_l2_pmu.c                    |  37 +-
 drivers/perf/qcom_l3_pmu.c                    |  30 +-
 drivers/perf/xgene_pmu.c                      | 475 +++++++++++++-------------
 include/linux/perf_event.h                    |   6 +
 kernel/events/core.c                          |   2 +
 16 files changed, 450 insertions(+), 566 deletions(-)

-- 
2.7.4

