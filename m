Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111243FDE30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245545AbhIAPC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:02:29 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:5035 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232392AbhIAPC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:02:28 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181Edk96012502;
        Wed, 1 Sep 2021 08:01:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=E1nuS92ErdRk1AcDBFZarmoe/1ZKdqDGvNNb9C4z+4g=;
 b=Ug0+N1sHsTmL5IV+3if5R4MJ9Rak4nDY/Dnl9P3wbcXkNvfDhIlKipHGLXlWZ5sMIlvP
 ZQTpTe4zPZC//0lI/YJPo9gLPpzlKBHU0YVfee58+pHPY7RHlWKGjuOE3Qmp3+JX2wKT
 BjkglheypPV83FMieoGomy/jlVGskTWgbtXZgsSnrp/q9ompB0R4A01JViwli0ySmhEu
 gq5W1EYXLFLkbSey+e3TRHVDAfoNSrjtKmjVw+/UoX2TcmLP77iTaCkvVUAi0pxgzBY8
 tkzLt5c69UMPLCVxfMHNqILLKLu+S6WsXTiv6eyEwDFJZeVKGUlo+t2OpLdincpJtadN IQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3atbfh02mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 08:01:16 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 1 Sep
 2021 08:01:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 1 Sep 2021 08:01:14 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 2488A5B6923;
        Wed,  1 Sep 2021 08:01:09 -0700 (PDT)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <sgoutham@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH v4 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu driver
Date:   Wed, 1 Sep 2021 20:31:03 +0530
Message-ID: <20210901150105.18863-1-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qOgNyYT5YDIITrah07_hMi5sAo2E5bVf
X-Proofpoint-GUID: qOgNyYT5YDIITrah07_hMi5sAo2E5bVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-01_05,2021-09-01_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces performance monitor driver to Last-level-cache
tag-and-data (LLC-TAD) PMU which is an intergral part of Marvell CN10K SoCs.
The configuration and functionality of the TAD PMU is covered in patch 1.
The device tree bindings are dealt in patch 2.

v4:
 - rebased on kernel v5.14-rc7
 - eliminate yamllint errors (Rob Herring) 

v3:
 - rebased on kernel v5.14-rc5
 - disable sampling events via PERF_PMU_CAP_NO_INTERRUPT (Will Deacon)
 - convert tad pmu bindings to schema (Will Deacon)
 - replace tighter semantics with *_relaxed() accesses (Will Deacon)
 - use PMU_EVENT_ATTR_ID generic macro (Will Deacon)
 - allow cleanup of allocations through devm_kcalloc() (Will Deacon)

v2:
 - rebased on kernel v5.13-rc3

Bhaskara Budiredla (2):
  drivers: perf: Add LLC-TAD perf counter support
  dt-bindings: perf: Add YAML schemas for Marvell CN10K LLC-TAD pmu
    bindings

 .../bindings/perf/marvell-cn10k-tad.yaml      |  60 +++
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/marvell_cn10k_tad_pmu.c          | 429 ++++++++++++++++++
 4 files changed, 497 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
 create mode 100644 drivers/perf/marvell_cn10k_tad_pmu.c

-- 
2.17.1

