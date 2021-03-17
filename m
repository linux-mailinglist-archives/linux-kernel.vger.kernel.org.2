Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4847B33ED4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCQJpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:45:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13556 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCQJoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:44:21 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F0lYH3HzczNp6n;
        Wed, 17 Mar 2021 17:41:55 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 17:44:12 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <john.garry@huawei.com>, <zhangshaokun@hisilicon.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH 0/3] drivers/perf: convert sysfs sprintf/snprintf/scnprintf to sysfs_emit
Date:   Wed, 17 Mar 2021 17:41:48 +0800
Message-ID: <1615974111-45601-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic sysfs_emit() and sysfs_emit_at() function to take
place of sprintf/snprintf/scnprintf, to avoid buffer overrun.

Zihao Tang (1)
  drivers/perf: convert sysfs snprintf family to sysfs_emit

Qi Liu (2):
  drivers/perf: convert sysfs scnprintf family to sysfs_emit_at
  drivers/perf: convert sysfs sprintf family to sysfs_emit

 drivers/perf/arm-cci.c                   | 12 ++++++------
 drivers/perf/arm-ccn.c                   | 28 ++++++++++++----------------
 drivers/perf/arm-cmn.c                   | 22 +++++++++++-----------
 drivers/perf/arm_dmc620_pmu.c            |  2 +-
 drivers/perf/arm_dsu_pmu.c               |  5 ++---
 drivers/perf/arm_smmuv3_pmu.c            |  4 ++--
 drivers/perf/arm_spe_pmu.c               |  3 +--
 drivers/perf/fsl_imx8_ddr_perf.c         |  7 +++----
 drivers/perf/hisilicon/hisi_uncore_pmu.c |  8 ++++----
 drivers/perf/qcom_l2_pmu.c               |  2 +-
 drivers/perf/qcom_l3_pmu.c               |  4 ++--
 drivers/perf/thunderx2_pmu.c             |  4 ++--
 drivers/perf/xgene_pmu.c                 |  4 ++--
 13 files changed, 49 insertions(+), 56 deletions(-)

-- 
2.8.1

