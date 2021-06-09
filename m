Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650163A0C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhFIGn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:43:59 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5341 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhFIGn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:43:56 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G0HVR6RtKz6vkV;
        Wed,  9 Jun 2021 14:38:07 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:41:59 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:41:58 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v4 0/7] drivers/perf: Use general macro to simplify event attributes
Date:   Wed, 9 Jun 2021 14:40:56 +0800
Message-ID: <1623220863-58233-1-git-send-email-liuqi115@huawei.com>
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

Changes since v3:
- Drop changes in arm_dsu_pmu.c and hisi_uncore_pmu.c.
- Link: https://lore.kernel.org/linux-arm-kernel/1623123201-45634-1-git-send-email-liuqi115@huawei.com/

Changes since v2:
- Add _func parameter in common marcro, so string can be determined by driver.
- Link: https://lore.kernel.org/linux-arm-kernel/1621417919-6632-1-git-send-email-liuqi115@huawei.com/

Changes since v1:
- +CC maintainers of each PMU driver.
- Link: https://lore.kernel.org/linux-arm-kernel/1621322628-9945-1-git-send-email-liuqi115@huawei.com/

Qi Liu (7):
  perf: Add EVENT_ATTR_ID to simplify event attributes
  drivers/perf: Simplify EVENT ATTR macro in SMMU PMU driver
  drivers/perf: Simplify EVENT ATTR macro in qcom_l2_pmu.c
  drivers/perf: Simplify EVENT ATTR macro in qcom_l3_pmu.c
  drivers/perf: Simplify EVENT ATTR macro in xgene_pmu.c
  drivers/perf: Simplify EVENT ATTR macro in fsl_imx8_ddr_perf.c
  arm64: perf: Simplify EVENT ATTR macro in perf_event.c

 arch/arm64/kernel/perf_event.c   |  5 +----
 drivers/perf/arm_smmuv3_pmu.c    |  7 ++-----
 drivers/perf/fsl_imx8_ddr_perf.c |  7 ++-----
 drivers/perf/qcom_l2_pmu.c       |  7 ++-----
 drivers/perf/qcom_l3_pmu.c       |  5 +----
 drivers/perf/xgene_pmu.c         | 11 ++++-------
 include/linux/perf_event.h       |  6 ++++++
 7 files changed, 18 insertions(+), 30 deletions(-)

-- 
2.7.4

