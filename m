Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582D0403975
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351643AbhIHMF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:05:56 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35784 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234758AbhIHMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:05:52 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1889TZZk030893;
        Wed, 8 Sep 2021 05:04:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=rNwDQ/qSjWPQ+WqtJv2ivYT9fUH60zkO9sLdsZ7fPpM=;
 b=g2QJU43HYRdClYCD9uvO9NxtAkMpyK2g7aFAjHN1wxKuGEYFia3Hf+eqzYxOgw33xkC7
 54ERiAqdG3cF5wbV17e5wETGqfK7wrez74ohIXFeSQQZq4oJprguShlGUHPQ5qS7/d76
 OVMDr9YMau75AN9IWNqEvbtug7kVmrQ7lV12ve5iydtFVkel3Hwgo3WW3N+3Qtd1Em78
 C3/ps3TB3NaDoAN1rEZBq3Yhw1/RgKrYXKLYsXSUs9LVkUFb3au2SH3Uy46f0em5p2AI
 DGoUIbZvdKSnrcAP2eOFlqcNAASFkgeGCQVkrt6wqq36+LLSIxiRyWLkN5RcVcKq9ekn YQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3axtka8fw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:04:36 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 05:04:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 05:04:30 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 43A233F708C;
        Wed,  8 Sep 2021 05:04:27 -0700 (PDT)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <sgoutham@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH v5 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu driver
Date:   Wed, 8 Sep 2021 17:34:23 +0530
Message-ID: <20210908120425.10084-1-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Wxt_lwnp6VLDJCmBOz-qMQz3tG3_X1Xp
X-Proofpoint-ORIG-GUID: Wxt_lwnp6VLDJCmBOz-qMQz3tG3_X1Xp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_05,2021-09-07_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces performance monitor driver to Last-level-cache
tag-and-data (LLC-TAD) PMU which is an intergral part of Marvell CN10K SoCs.
The configuration and functionality of the TAD PMU is covered in patch 1.
The device tree bindings are dealt in patch 2.

v5:
 - add prefix, type, description for vendor specific properties
   in DT bindings (Rob Herring)

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

 .../bindings/perf/marvell-cn10k-tad.yaml      |  63 +++
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/marvell_cn10k_tad_pmu.c          | 430 ++++++++++++++++++
 4 files changed, 501 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
 create mode 100644 drivers/perf/marvell_cn10k_tad_pmu.c

-- 
2.17.1

