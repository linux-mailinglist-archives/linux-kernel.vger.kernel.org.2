Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A083EA9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhHLRm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:42:58 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:27758 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229648AbhHLRmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:42:54 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CHfLhm017825;
        Thu, 12 Aug 2021 10:42:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=rPUu9ssA5+2l91vNWLBHC4332MScCyjZQDSplZiarf0=;
 b=dI4lSJcJLP/QYSUdI3kSocSE4CFhen68qyM4CfDIFMNlBHR2i+8KS8rij9BZNQ7ATzue
 4a9Xuy7bDqyS9a83TLY4yFCbU2d3VirG7oGBZL97XYk86AtjmqoeGLOq8+1Ks6dH7+5U
 RMOXNUAtppMdM7yov7U+uLiDI5hT/2LOTgqSzYrfbC5nUL52yERBgFV3Q8ENMAEmacvk
 bq1FxKLa+tLX3kEa29PcLCsZr8WwpZ54Qcgt9A0mVqjPG9jH1QgqazI0Deu+s2EvwoTi
 chELkxBzQisuWvltYg3AwXJiXHCgF1dLeCCxlfm1+ZIL9TV2Q083Xx7QqSXK6bejcrgN Xw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3acrnp35a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 10:42:17 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 12 Aug
 2021 10:42:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 12 Aug 2021 10:42:15 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 23A423F7051;
        Thu, 12 Aug 2021 10:42:12 -0700 (PDT)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <sgoutham@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH v3 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu driver
Date:   Thu, 12 Aug 2021 23:12:07 +0530
Message-ID: <20210812174209.1970-1-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: RUrL8g_jIupzGjxBmMdmfLNHf9RqUNR_
X-Proofpoint-ORIG-GUID: RUrL8g_jIupzGjxBmMdmfLNHf9RqUNR_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_05:2021-08-12,2021-08-12 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces performance monitor driver to Last-level-cache
tag-and-data (LLC-TAD) PMU which is an intergral part of Marvell CN10K SoCs.
The configuration and functionality of the TAD PMU is covered in patch 1.
The device tree bindings are dealt in patch 2.

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
  dt-bindings: perf: Add YAML schemas for Marvell CN10K LLC-TAD PMU
    bindings

 .../bindings/perf/marvell-cn10k-tad.yaml      |  45 ++
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/marvell_cn10k_tad_pmu.c          | 429 ++++++++++++++++++
 4 files changed, 482 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
 create mode 100644 drivers/perf/marvell_cn10k_tad_pmu.c

-- 
2.17.1

