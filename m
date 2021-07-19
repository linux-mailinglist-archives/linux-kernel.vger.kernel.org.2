Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A059E3CD3BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbhGSKk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:40:58 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11449 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbhGSKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:39:03 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GSzn00mpFzcg21;
        Mon, 19 Jul 2021 19:16:20 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 19:19:41 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 19 Jul 2021 19:19:38 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
Subject: [PATCH 0/2] coresight: ultrasoc: Add support for System Memory Buffer device
Date:   Mon, 19 Jul 2021 19:17:35 +0800
Message-ID: <20210719111737.47891-1-liuqi115@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support for SMB(System Memory Buffer) device, SMB
obtains CPU instructions from Coresight ETM device and stores these
messages in system memory.
SMB is developed by Ultrasoc technology, which is acquired by Siemens,
and we still use "Ultrasoc" to name document and driver.

Change since RFC:
- Move ultrasoc driver to drivers/hwtracing/coresight.
- Remove ultrasoc-axi-com.c, as AXI-COM doesn't need to be configured in
  basic tracing function.
- Remove ultrasoc.c as SMB does not need to register with the ultrasoc core.
- Address the comments from Mathieu and Suzuki.
- Link: https://lists.linaro.org/pipermail/coresight/2021-June/006535.html

Qi Liu (2):
  Documentation: tracing: Documentation for ultrasoc SMB drivers
  coresight: ultrasoc: Add System Memory Buffer driver

 .../trace/coresight/ultrasoc-trace.rst        | 193 +++++
 MAINTAINERS                                   |   7 +
 drivers/hwtracing/coresight/Kconfig           |   3 +
 drivers/hwtracing/coresight/Makefile          |   2 +
 drivers/hwtracing/coresight/ultrasoc/Kconfig  |  12 +
 drivers/hwtracing/coresight/ultrasoc/Makefile |   6 +
 .../coresight/ultrasoc/ultrasoc-smb.c         | 722 ++++++++++++++++++
 .../coresight/ultrasoc/ultrasoc-smb.h         | 142 ++++
 8 files changed, 1087 insertions(+)
 create mode 100644 Documentation/trace/coresight/ultrasoc-trace.rst
 create mode 100644 drivers/hwtracing/coresight/ultrasoc/Kconfig
 create mode 100644 drivers/hwtracing/coresight/ultrasoc/Makefile
 create mode 100644 drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.c
 create mode 100644 drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.h

-- 
2.17.1

