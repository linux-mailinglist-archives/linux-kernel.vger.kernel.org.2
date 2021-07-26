Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFB53D5632
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhGZIaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:30:21 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:62734 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232614AbhGZIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:30:18 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q91MQJ020098;
        Mon, 26 Jul 2021 02:10:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=etw8mgMrhCLwprM5QMZwUjgd7AkZNHLFQCfXqafVLqw=;
 b=fVM0mb+8FkmON2kMe95wsgsiFvcgH/5uqtfMOz7Rwy7MRnP9khl51oWCxTaRqTKFF2IC
 7U+ZB7l02WF8fEPcrrxN2uC03PNKMnpwIAZSZ2rfHmDTzPrIDGdmuMsm3cqe3KXSsVpW
 xfVYGQiyzqHNXxKVGH/lynAMWK9VE/u0zJJE4i1czNPNmW9s8vXoxTZFXKW/O7vA2wEk
 ov8nC1opIiGYT3xJWpVN+vjaCMNXzRtrdNmg6KrSyjlOl3PG34CuEj4CcAcc+YLqSPlz
 qm3Dj6vUYJEFKiJY78b2xJ6sX13IDGz89z16fYozq44kT2qi6yc94gs+v21rCXpIGvOI Cg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3a1avpa2qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 02:10:39 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 26 Jul
 2021 02:10:37 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 26 Jul 2021 02:10:34 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 0/4] cn10k DDR Performance monitor support
Date:   Mon, 26 Jul 2021 14:40:23 +0530
Message-ID: <20210726091027.798-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: n_0xMYJggoK5iv0A6Mhiz2lO_W3imNgJ
X-Proofpoint-ORIG-GUID: n_0xMYJggoK5iv0A6Mhiz2lO_W3imNgJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_05:2021-07-26,2021-07-26 signatures=0
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

Bharat Bhushan (4):
  dt-bindings: perf: marvell: cn10k ddr performance monitor
  perf/marvell: ADD cn10k DDR PMU basic support
  perf/marvell: cn10k DDR perfmon event overflow handling
  perf/marvell: cn10k DDR perf event core ownership

 .../bindings/perf/marvell-cn10k-ddr.txt       |  15 +
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 766 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 5 files changed, 790 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.txt
 create mode 100644 drivers/perf/marvell_cn10k_ddr_pmu.c

-- 
2.17.1

