Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A610D3E5745
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbhHJJnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:43:51 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:61138 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234705AbhHJJnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:43:50 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A9eEui019608;
        Tue, 10 Aug 2021 02:43:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=iH2NyTAq7HOJvUV8gQMuft+GVh5DfrukXL9OaZL+UAw=;
 b=h5uQ/P9TQyzlO2aSz9mzzeTE8c7PEx6p1gf6btsCdk9P9bqRFiEFC/ADs7eUCJYrcwu7
 SPcT5qmm6P7EEN6OO4DO9/jX6V5Qg0CpbZ3k5ZRJT5qviyulkW1Zyaqb0egIlTYRp0iR
 elqn/EyJL0UCrWwEzMUSJlXBad1HepwoEZhR1vvSvTjI7R6haMlW7nEQyJC8YRezUyya
 l6TtbWRnFcr2U4L6DHdHZymP1/KZdVZdPuNnJesc/Gh7zRT9xtlkBfoicq1wss1BoqzO
 36leE2UoAH/lHCRFDhQ/fI9TAkgC+fPTSzpmmtlnulj7DrsexxNond0yelvvVgBycd9l Dg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3aaxfkmbx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 02:43:16 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 10 Aug
 2021 02:43:14 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 10 Aug 2021 02:43:11 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v2 0/4] cn10k DDR Performance monitor support
Date:   Tue, 10 Aug 2021 15:13:03 +0530
Message-ID: <20210810094307.29595-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hOBLCaOczG7ivGBQPe8WF2qV-edeFrKJ
X-Proofpoint-GUID: hOBLCaOczG7ivGBQPe8WF2qV-edeFrKJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_03:2021-08-06,2021-08-10 signatures=0
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
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 763 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 5 files changed, 809 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
 create mode 100644 drivers/perf/marvell_cn10k_ddr_pmu.c

-- 
2.17.1

