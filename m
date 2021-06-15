Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAEC3A7AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhFOJhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:37:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4914 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhFOJhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:37:16 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G434K6VvQz6yhV;
        Tue, 15 Jun 2021 17:32:01 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 17:35:10 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 15 Jun 2021 17:35:10 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <alexander.shishkin@linux.intel.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <jonathan.zhouwen@huawei.com>,
        <f.fangjian@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>
Subject: [RFC PATCH 0/4] Add support for Ultrasoc Trace Module
Date:   Tue, 15 Jun 2021 17:34:40 +0800
Message-ID: <1623749684-65432-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for Ultrasoc Trace Module on Hip08 and Hip09
platform. It includes core layer framework, AXI Communicator(AXI-COM) and 
System Memory Buffer(SMB).

Qi Liu (4):
  Documentation: tracing: Documentation for ultrasoc framework and drivers
  ultrasoc: add ultrasoc core layer framework
  ultrasoc: Add ultrasoc AXI Communicator driver
  ultrasoc: Add System Memory Buffer driver

 Documentation/trace/ultrasoc-trace.rst        | 209 ++++++++
 MAINTAINERS                                   |   7 +
 drivers/Makefile                              |   1 +
 drivers/hwtracing/Kconfig                     |   2 +
 drivers/hwtracing/ultrasoc/Kconfig            |  34 ++
 drivers/hwtracing/ultrasoc/Makefile           |  13 +
 drivers/hwtracing/ultrasoc/ultrasoc-axi-com.c | 334 +++++++++++++
 drivers/hwtracing/ultrasoc/ultrasoc-axi-com.h |  66 +++
 drivers/hwtracing/ultrasoc/ultrasoc-smb.c     | 663 ++++++++++++++++++++++++++
 drivers/hwtracing/ultrasoc/ultrasoc-smb.h     | 182 +++++++
 drivers/hwtracing/ultrasoc/ultrasoc.c         | 518 ++++++++++++++++++++
 drivers/hwtracing/ultrasoc/ultrasoc.h         | 168 +++++++
 12 files changed, 2197 insertions(+)
 create mode 100644 Documentation/trace/ultrasoc-trace.rst
 create mode 100644 drivers/hwtracing/ultrasoc/Kconfig
 create mode 100644 drivers/hwtracing/ultrasoc/Makefile
 create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-axi-com.c
 create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-axi-com.h
 create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-smb.c
 create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-smb.h
 create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc.c
 create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc.h

-- 
2.7.4

