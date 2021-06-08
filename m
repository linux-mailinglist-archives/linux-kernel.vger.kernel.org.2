Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F196639ED19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFHDfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:35:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3097 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFHDff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:35:35 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzbLW5TqWzWtRt;
        Tue,  8 Jun 2021 11:28:51 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:33:41 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:33:40 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v3 0/9] drivers/perf: Use general macro to simplify event attributes
Date:   Tue, 8 Jun 2021 11:33:12 +0800
Message-ID: <1623123201-45634-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset applies a general EVENT_ATTR_ID to simplify event
attributes in many PMU drivers.

Qi Liu (9):
  perf: Add EVENT_ATTR_ID to simplify event attributes
  drivers/perf: hisi: Simplify EVENT ATTR macro in HiSilicon PMU driver
  drivers/perf: Simplify EVENT ATTR macro in SMMU PMU driver
  drivers/perf: Simplify EVENT ATTR macro in qcom_l2_pmu.c
  drivers/perf: Simplify EVENT ATTR macro in qcom_l3_pmu.c
  drivers/perf: Simplify EVENT ATTR macro in xgene_pmu.c
  drivers/perf: Simplify EVENT ATTR macro in fsl_imx8_ddr_perf.c
  drivers/perf: Simpilfy EVENT ATTR macro in arm_dsu_pmu.c
  arm64: perf: Simplify EVENT ATTR macro in perf_event.c

 arch/arm64/kernel/perf_event.c           |  5 +----
 drivers/perf/arm_dsu_pmu.c               |  2 +-
 drivers/perf/arm_smmuv3_pmu.c            |  7 ++-----
 drivers/perf/fsl_imx8_ddr_perf.c         |  7 ++-----
 drivers/perf/hisilicon/hisi_uncore_pmu.c |  7 +++----
 drivers/perf/hisilicon/hisi_uncore_pmu.h |  2 +-
 drivers/perf/qcom_l2_pmu.c               |  7 ++-----
 drivers/perf/qcom_l3_pmu.c               |  5 +----
 drivers/perf/xgene_pmu.c                 | 11 ++++-------
 include/linux/perf_event.h               |  6 ++++++
 10 files changed, 23 insertions(+), 36 deletions(-)

-- 
2.7.4

