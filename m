Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E943FBE7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhJ2L7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 07:59:30 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50196 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhJ2L73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:59:29 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19T9lGgE020112;
        Fri, 29 Oct 2021 04:56:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=r+8HQGiVGsjaulFL18oDjpaLJ1niU8R1G65tS/pCS/Y=;
 b=Zvz5aJbtTxs4if37lW9Uv+n28c4YxuyUUr/udPa5VhFaq6vRDiS47NfI53EKgu+fc8K+
 faere1PYALqIyi8R+87NC/r/QlmdJEbw7TYpwlnN1wQcLSZzHpkzN1iOSPjgIEQ7EH+F
 FcZl+7ZsbmW1D/LwGZioWLjbjBlcJE3jpvHPO7bK46nYPvkGpm3lw2RKJQkKNXkt4m/W
 M7m6GI2GHYcfQLF7+wyqUyX1t6qgOc/l5h3FegGC9Ni/WXwlW+LGnZ0/HZzo/WzetmMQ
 R82rPYWb/8dQqTS/nt+2hI3+06kBLBGuAwQ6IK+W5jlE1vQwUZnjBSBe5W57y5waOJMP 5g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3c06hujb5k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 04:56:51 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 29 Oct
 2021 04:56:49 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 29 Oct 2021 04:56:46 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v6 0/4] cn10k DDR Performance monitor support
Date:   Fri, 29 Oct 2021 17:26:39 +0530
Message-ID: <20211029115643.32351-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 5CeUoUF_2pFsxFsiJ_qCT6IdPoFExC0b
X-Proofpoint-ORIG-GUID: 5CeUoUF_2pFsxFsiJ_qCT6IdPoFExC0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_02,2021-10-29_01,2020-04-07_01
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

v5->v6:
 - Changed COMPILE_TEST to (COMPILE_TEST && 64BIT)

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

