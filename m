Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B975545E454
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357531AbhKZCY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:24:26 -0500
Received: from mx24.baidu.com ([111.206.215.185]:52426 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357545AbhKZCWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:22:24 -0500
Received: from BC-Mail-Ex05.internal.baidu.com (unknown [172.31.51.45])
        by Forcepoint Email with ESMTPS id 10D62BAB587FCEAC3DD2;
        Fri, 26 Nov 2021 10:19:08 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex05.internal.baidu.com (172.31.51.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 26 Nov 2021 10:19:07 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 26 Nov 2021 10:19:07 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-staging@lists.linux.dev>
Subject: [PATCH v3 0/3] staging: zynpu: Add driver support for ARM(China) ZHOUYI AI accelerator
Date:   Fri, 26 Nov 2021 10:18:58 +0800
Message-ID: <20211126021904.32325-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex10.internal.baidu.com (172.31.51.50) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZHOUYI NPU is an AI accelerator chip which is integrated into ARM SOC,
such as Allwinner R329 SOC.
Add driver support for this AI accelerator here.

v1->v2:
        *Add TODO file.
        *Update changelog to explain why this code is added to staging.
v2->v3:
        *Fix unit_address_format in dt-binding, avoid leading 0s.
        *Fix typo in changelog, 'tandard'->'standard'.

Cai Huoqing (3):
  staging: zynpu: Add driver support for ARM(China) ZHOUYI AI
    accelerator
  dt-bindings: staging: Add the binding documentation for ZHOUYI AI
    accelerator
  MAINTAINERS: Add the driver info of the ZHOUYI AI accelerator

 .../bindings/staging/arm,zynpu.yaml           |  61 ++
 MAINTAINERS                                   |   6 +
 drivers/staging/Kconfig                       |   2 +
 drivers/staging/Makefile                      |   1 +
 drivers/staging/zynpu/Kconfig                 |  34 +
 drivers/staging/zynpu/Makefile                |   7 +
 drivers/staging/zynpu/TODO                    |  13 +
 drivers/staging/zynpu/z1.c                    | 233 +++++
 drivers/staging/zynpu/z2.c                    | 297 +++++++
 drivers/staging/zynpu/zhouyi.h                |  70 ++
 drivers/staging/zynpu/zhouyi_base.c           |  71 ++
 drivers/staging/zynpu/zynpu.h                 | 252 ++++++
 drivers/staging/zynpu/zynpu_core.c            | 254 ++++++
 drivers/staging/zynpu/zynpu_drv.c             | 349 ++++++++
 drivers/staging/zynpu/zynpu_fops.c            | 245 ++++++
 drivers/staging/zynpu/zynpu_io.c              | 133 +++
 drivers/staging/zynpu/zynpu_io.h              | 119 +++
 drivers/staging/zynpu/zynpu_irq.c             | 123 +++
 drivers/staging/zynpu/zynpu_irq.h             |  85 ++
 drivers/staging/zynpu/zynpu_job_manager.c     | 467 ++++++++++
 drivers/staging/zynpu/zynpu_job_manager.h     | 200 +++++
 drivers/staging/zynpu/zynpu_mm.c              | 704 +++++++++++++++
 drivers/staging/zynpu/zynpu_mm.h              | 142 +++
 drivers/staging/zynpu/zynpu_session.c         | 817 ++++++++++++++++++
 drivers/staging/zynpu/zynpu_session.h         | 283 ++++++
 drivers/staging/zynpu/zynpu_sysfs.c           | 205 +++++
 26 files changed, 5173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/staging/arm,zynpu.yaml
 create mode 100644 drivers/staging/zynpu/Kconfig
 create mode 100644 drivers/staging/zynpu/Makefile
 create mode 100644 drivers/staging/zynpu/TODO
 create mode 100644 drivers/staging/zynpu/z1.c
 create mode 100644 drivers/staging/zynpu/z2.c
 create mode 100644 drivers/staging/zynpu/zhouyi.h
 create mode 100644 drivers/staging/zynpu/zhouyi_base.c
 create mode 100644 drivers/staging/zynpu/zynpu.h
 create mode 100644 drivers/staging/zynpu/zynpu_core.c
 create mode 100644 drivers/staging/zynpu/zynpu_drv.c
 create mode 100644 drivers/staging/zynpu/zynpu_fops.c
 create mode 100644 drivers/staging/zynpu/zynpu_io.c
 create mode 100644 drivers/staging/zynpu/zynpu_io.h
 create mode 100644 drivers/staging/zynpu/zynpu_irq.c
 create mode 100644 drivers/staging/zynpu/zynpu_irq.h
 create mode 100644 drivers/staging/zynpu/zynpu_job_manager.c
 create mode 100644 drivers/staging/zynpu/zynpu_job_manager.h
 create mode 100644 drivers/staging/zynpu/zynpu_mm.c
 create mode 100644 drivers/staging/zynpu/zynpu_mm.h
 create mode 100644 drivers/staging/zynpu/zynpu_session.c
 create mode 100644 drivers/staging/zynpu/zynpu_session.h
 create mode 100644 drivers/staging/zynpu/zynpu_sysfs.c

-- 
2.25.1

