Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9973D5633
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhGZIaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:30:23 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:3926 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231800AbhGZIaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:30:19 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q91K3w020076;
        Mon, 26 Jul 2021 02:10:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=j2RQb0gXX4hfh5csfhNRYibG6Z7de3T7B6QrAroXJR0=;
 b=ARlQIi2RtRo8hReJpJ1QlsS1klj5ix0FUZoMETLjcN28RDTKdK54qxxX9PoBMchl5nup
 z97ocCUP9H1BlIpxcd+BOuFXwbgNWxkz/wv7LHP7pTID55heHL4C8DWOyz3/qCLzSH53
 8rZCXVS+voMTHQLXWSo/pmSfaQmosxUAR9N9m3guSk6/Sw6bIYcrz9XCdrjR59vodKv2
 acEhGBdTaSMnvQf8uBgzznnxEGxVXKkuWBQykron60tJ8kVvaIu8gksvxX79tHGWhpp2
 wfQDUc3NO87eFF8xzk3o48ajEcUDGajK6Y1SMIvux+ngy/Ps3GPGO5TF9QQnBIpP05Rj Fw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3a1avpa2qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 02:10:42 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 26 Jul
 2021 02:10:41 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 26 Jul 2021 02:10:38 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/4] dt-bindings: perf: marvell: cn10k ddr performance monitor
Date:   Mon, 26 Jul 2021 14:40:24 +0530
Message-ID: <20210726091027.798-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726091027.798-1-bbhushan2@marvell.com>
References: <20210726091027.798-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: l1zryHv0pPqPNA3lveZIuCo7GFrbZkz0
X-Proofpoint-ORIG-GUID: l1zryHv0pPqPNA3lveZIuCo7GFrbZkz0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_05:2021-07-26,2021-07-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell CN10k DDR
performance monitor unit.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../bindings/perf/marvell-cn10k-ddr.txt           | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.txt

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.txt b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.txt
new file mode 100644
index 000000000000..a2a593e99963
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.txt
@@ -0,0 +1,15 @@
+* Marvell CN10k DDR performance monitor
+
+Required properties:
+
+- compatible: should be one of:
+	"marvell,cn10k-ddr-pmu"
+
+- reg: physical address and size
+
+Example:
+
+	ddrcpmu {
+		compatible = "marvell,cn10k-ddr-pmu";
+		reg = <0x87e1 0xc0000000 0x0 0x10000>;
+	};
-- 
2.17.1

