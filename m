Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6D356867
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350306AbhDGJv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:51:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16375 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhDGJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:51:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFfks2KBNzlVk8;
        Wed,  7 Apr 2021 17:49:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 17:51:36 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] drivers/perf: hisi: Add support for PCIe PMU
Date:   Wed, 7 Apr 2021 17:49:01 +0800
Message-ID: <1617788943-52722-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for HiSilicon PCIe Performance Monitoring
Unit(PMU). It is a PCIe Root Complex integrated End Point(RCiEP) device
added on Hip09. Each PCIe Core has a PMU RCiEP to monitor multi root
ports and all Endpoints downstream these root ports.

HiSilicon PCIe PMU is supported to collect performance data of PCIe bus,
such as: bandwidth, latency etc.

Qi Liu (2):
  drivers/perf: hisi: Add driver for HiSilicon PCIe PMU
  docs: perf: Add description for HiSilicon PCIe PMU driver

 Documentation/admin-guide/perf/hisi-pcie-pmu.rst |  103 +++
 MAINTAINERS                                      |    6 +
 drivers/perf/Kconfig                             |    2 +
 drivers/perf/Makefile                            |    1 +
 drivers/perf/pci/Kconfig                         |   16 +
 drivers/perf/pci/Makefile                        |    2 +
 drivers/perf/pci/hisilicon/Makefile              |    5 +
 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c       | 1012 ++++++++++++++++++++++
 include/linux/cpuhotplug.h                       |    1 +
 9 files changed, 1148 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hisi-pcie-pmu.rst
 create mode 100644 drivers/perf/pci/Kconfig
 create mode 100644 drivers/perf/pci/Makefile
 create mode 100644 drivers/perf/pci/hisilicon/Makefile
 create mode 100644 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c

-- 
2.8.1

