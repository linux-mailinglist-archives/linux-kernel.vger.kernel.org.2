Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0936B3A5D53
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 08:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhFNG77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 02:59:59 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48924 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232434AbhFNG7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:59:55 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E6ucF6007613;
        Mon, 14 Jun 2021 02:57:51 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 394su5e9nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 02:57:51 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 15E6vnW2060166
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jun 2021 02:57:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Mon, 14 Jun 2021 02:57:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Mon, 14 Jun 2021 02:57:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Mon, 14 Jun 2021 02:57:49 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 15E6vlpi028812;
        Mon, 14 Jun 2021 02:57:47 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <petre.minciunescu@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v2 0/2] clk: ad9545: Add support
Date:   Mon, 14 Jun 2021 10:07:16 +0300
Message-ID: <20210614070718.78041-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: GAzMq89hqKJRHd9KXjYeONVTX0IhzZ_R
X-Proofpoint-GUID: GAzMq89hqKJRHd9KXjYeONVTX0IhzZ_R
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_01:2021-06-11,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add support for AD9545 Quad Input, 10-Output, Dual DPLL/IEEE 1588,
1 pps Synchronizer and Jitter Cleaner.

At the core of the device there are PLL blocks. Each block consists
of one DPLL and one APLL. The DPLL can be fed timestamps from one of
the 4 reference input dividers or one of the two auxiliary NCOs.

The APLL takes the output of the DPLL and up-converts this
frequency to 1.2-2.0 GHZ. First 6 output dividers are receiving
clock from APLL0 and last 4 outputs are receiving clock from APLL1.

Current approach is to register under common clock framework,
depending whether they are mentioned in the device-tree,
any of the used references input dividers, the two auxiliary
NCOs, PLL blocks, output dividers.

A clock tree example:
Ref-B
  Ref-B-Div
    PLL0
      Q0C-div
    PLL1
      Q1A-div
      Q1B-div

Alexandru Tachici (2):
  clk: ad9545: Add support
  dt-bindings: clock: ad9545: Add documentation

Changelog v1 -> v2:
- allow uHz DPLL loop bandwidth in DT
- allow user to set different tub fill/drain rates per DPLL from DT
for improved locking detection
- added reference priorities, DPLLs now can have multiple parents selected based on
the validity of the reference in question and priority
- added fast ACQ process that can be configured in the DT
- fixed DT bindings errors
- added support for system clock compensation

 .../devicetree/bindings/clock/clk-ad9545.yaml |  556 ++++
 drivers/clk/Kconfig                           |    6 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/adi/Kconfig                       |   29 +
 drivers/clk/adi/Makefile                      |    9 +
 drivers/clk/adi/clk-ad9545-i2c.c              |   62 +
 drivers/clk/adi/clk-ad9545-spi.c              |   76 +
 drivers/clk/adi/clk-ad9545.c                  | 2428 +++++++++++++++++
 drivers/clk/adi/clk-ad9545.h                  |   16 +
 include/dt-bindings/clock/ad9545.h            |   69 +
 10 files changed, 3252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/clk-ad9545.yaml
 create mode 100644 drivers/clk/adi/Kconfig
 create mode 100644 drivers/clk/adi/Makefile
 create mode 100644 drivers/clk/adi/clk-ad9545-i2c.c
 create mode 100644 drivers/clk/adi/clk-ad9545-spi.c
 create mode 100644 drivers/clk/adi/clk-ad9545.c
 create mode 100644 drivers/clk/adi/clk-ad9545.h
 create mode 100644 include/dt-bindings/clock/ad9545.h

--
2.25.1
