Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2684322DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhJRPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:33:35 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42960 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230154AbhJRPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:33:34 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19ICZjli024862;
        Mon, 18 Oct 2021 08:31:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=dU2vCIi5WKPb7AFGaKXXQnjtepfMevDauHgbDEzDwrw=;
 b=Go2/eztflQ7vf1M3NDoKpy63E7BgUeHyJP46YFhUVgAzcQfbRrWbnKbxr7WzfqDic5jU
 7pxH306/yAMhLH/m7LJMAsQFBFQJ46GnrFx534ylWimO7qZGt/q6Yymo9fI/zJ1rR8IX
 FUnlmLD7Q9lnqSO1y4Y2eM3PpShk/+40Y0IPdkeWuXA/0BswFUKgF6a14/61GDD5vxKK
 4Y+cD9qA8q2AgyC5wHJGZhxX6MKR/kcUJPyFPOWzrg+ndTgLjhcJSJyu+En5forACnZ7
 1W8cY528zI+PPc0gh/54RVBM5GhwowTHevn5IN12wJBjyx2nib/4DRyfFVB/EgpL1K/r 0A== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bs1bujjke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 08:31:14 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 08:31:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 18 Oct 2021 08:31:13 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 7DEE15E6862;
        Mon, 18 Oct 2021 08:31:10 -0700 (PDT)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbhushan2@marvell.com>, <sgoutham@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH v6 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu driver
Date:   Mon, 18 Oct 2021 21:00:55 +0530
Message-ID: <20211018153057.23217-1-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: N-5QNF2_xhJzFgjxJK5kM1P8ezzqTWOk
X-Proofpoint-ORIG-GUID: N-5QNF2_xhJzFgjxJK5kM1P8ezzqTWOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_07,2021-10-18_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces performance monitor driver to Last-level-cache
tag-and-data (LLC-TAD) PMU which is an intergral part of Marvell CN10K SoCs.
The configuration and functionality of the TAD PMU is covered in patch 1.
The device tree bindings are dealt in patch 2.

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

