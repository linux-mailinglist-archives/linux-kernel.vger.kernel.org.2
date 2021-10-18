Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39816430EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhJREXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:23:13 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51268 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhJREXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:23:10 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19HNPWNk001206;
        Sun, 17 Oct 2021 21:20:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=dQ5QZtjVCPnpGNLDoV34tkpmdk4MFBxO7ml4x9+6FUw=;
 b=EjCkiQzlAkvtciIuVIg1sXfP7ZU3Q7yx3yYqdfow+qY3HTj561CAJshUtw8IHp6kyVM0
 3PR5xJWxCi3pifQ8B47qOru+hYhJUdWKPDBBC/UfmtmljWZPerVgjqrFtQ5qyq1OlRxB
 OAuWCMD4XehE0QaQ77Ye/VsG1BnEb1xiLpMMWFar0yTIAHEz9QaxAzaszmRa88/ov10h
 /eK3AqxANxau2mDGuMWa2+KMLeIlrea/+mc2sz4hE5fT9jq5FPFsy0s0yNoewItiVVeQ
 HzhLGeylqW5OtE6Vz0R8iivczUouQsqSWCiFeIRInd4ZX3HFX2RZjqjMQkUI97luCy1L KA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3brt1s10ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 21:20:24 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 17 Oct
 2021 21:20:22 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 17 Oct 2021 21:20:19 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v5 0/4] cn10k DDR Performance monitor support
Date:   Mon, 18 Oct 2021 09:50:11 +0530
Message-ID: <20211018042015.25151-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HdD3NMif2em5bLt5Lq6hZLLR_YKsv2S6
X-Proofpoint-GUID: HdD3NMif2em5bLt5Lq6hZLLR_YKsv2S6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_01,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds DDR performance monitor support
on Marvell cn10k series of processor.

First patch adds device tree binding changes.
Second patch add basic support (without overflow and event
ownership). Third and fourth patch adds overflow and event
ownership respectively.

Seems like 4th patch can be merged in second patch,
For easy review it is currently separate

v4->v5:
 - Added missing COMPILE_TEST dependency

v3->v4:
 - Added Rob Herring reviewed-by for dt-binding patch

v2->v3:
 - dt-binding, ddrcpmu@1 -> pmu@87e1c0000000
 - Add COMPILE_TEST as a dependency
 - Switch to sysfs_emit()
 - Error propagation when invalif event requested
 - Switch to devm_platform_get_and_ioremap_resource()
 - Other review comments on v2.

v1->v2:
 - DT binding changed to new DT Schema
 - writeq/readq changed to respective relaxed
 - Using PMU_EVENT_ATTR_ID

Bharat Bhushan (4):
  dt-bindings: perf: marvell: cn10k ddr performance monitor
  perf/marvell: CN10k DDR performance monitor support
  perf/marvell: cn10k DDR perfmon event overflow handling
  perf/marvell: cn10k DDR perf event core ownership

 .../bindings/perf/marvell-cn10k-ddr.yaml      |  37 +
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 756 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 5 files changed, 802 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
 create mode 100644 drivers/perf/marvell_cn10k_ddr_pmu.c

-- 
2.17.1

