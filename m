Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E3C44FDF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 05:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhKOEik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 23:38:40 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:4542 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230293AbhKOEiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 23:38:19 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AF1t4Yf015037;
        Sun, 14 Nov 2021 20:35:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=fqb86LaitD1/PaWc3suJpMiq8Opiayc80EIqho7Gurw=;
 b=WiWOv3G9rOo5sp+FHAqmdT2ecr+P7ome4OWXpZAQ3FcNv3uJq5yRl/UGBGG4IpnrEDFS
 KNbKIpPRZmm6/fis8GSmSofY7NufGI1bc/YvlJkP+C4NgBFRFKOKAaL63AtP43B5GalC
 toy9W9BwdLSBRwXm9edEAOuxc1A+8U78NlmGNCawDAnaHNBbttnrhm7FjZScQS4kESFX
 DxDSwULFZBYSmGh4840LOq52Md+m51QHqRG0T8w7ACvZVqU+W5mHaUZrH0r3L1HqFezw
 4arEbs9mhTpjtJQ7huaES2/mQ2z4vYYpJ4dc7sywm2Co2QHgZQeQhpnqoHAiyljyaChk sA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3cbea8gf22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 14 Nov 2021 20:35:15 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 14 Nov
 2021 20:35:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 14 Nov 2021 20:35:13 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 741173F7067;
        Sun, 14 Nov 2021 20:35:10 -0800 (PST)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbhushan2@marvell.com>, <sgoutham@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH v7 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu driver
Date:   Mon, 15 Nov 2021 10:05:04 +0530
Message-ID: <20211115043506.6679-1-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: NjXcDK35yA_QfLe98IYmAjhnwZw5_p4q
X-Proofpoint-ORIG-GUID: NjXcDK35yA_QfLe98IYmAjhnwZw5_p4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_03,2021-11-12_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces performance monitor driver to Last-level-cache
tag-and-data (LLC-TAD) PMU which is an integral part of Marvell CN10K SoCs.
The configuration and functionality of the TAD PMU is covered in patch 1.
The device tree bindings are dealt in patch 2.

v7:
 - use braces around a multi-line conditional statement (Will Deacon)
 - remove mask doesn't do anything (Will Deacon)
 - restrict compile test dependency to aarch64

v6:
 - add COMPILE_TEST dependency (Bharat Bhushan)
 - replace sprintf with sysfs_emit (Bharat Bhushan)

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
 drivers/perf/marvell_cn10k_tad_pmu.c          | 429 ++++++++++++++++++
 4 files changed, 500 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
 create mode 100644 drivers/perf/marvell_cn10k_tad_pmu.c

-- 
2.17.1

