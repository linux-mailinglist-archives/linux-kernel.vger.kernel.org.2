Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764A834C210
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 04:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhC2CzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 22:55:10 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:26778 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230039AbhC2CzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:55:08 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12T2nFpF029307;
        Mon, 29 Mar 2021 02:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version; s=pps0720;
 bh=joIr4w8+33NkBbut5Watc2XaBlepQEi2iXux732VPJs=;
 b=eR8olXPLDp04xaPu3WJKuFX1J1PEZw/qRBfnCEzIXEwO3De5GZo0um0zlGT0LaOKhznj
 nwVCvXuxU5SLfScBvPbU8I0trNaV8X2jnlsgyNtbtbK4xHq/I9qWu367I29x9iNo7Qx6
 nRGiEAn+UBuZfuPkWESlQuGVFdugLye2h/UuVcrTOJyutiAeBDK7EtDdMBzf7t71wWMw
 xt/Nlfr+kQ6W0+VStvdT6F7MyK+HigNLnxrAOgzni2JuMSqV4R7MTi2ttht/s+lX9Ej3
 XzyIEhJF08Ij332XwliWnjXJUaR7M7EvL4KWNy6tYyTBDYicoeL3/ZfSSP/yiM2uj/CN iw== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 37jetyd7ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 02:55:04 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id F05EB4F;
        Mon, 29 Mar 2021 02:55:03 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 8CD054C;
        Mon, 29 Mar 2021 02:55:02 +0000 (UTC)
From:   matt.hsiao@hpe.com
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, jerry.hoemann@hpe.com,
        Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH] misc: hpilo: MAINTAINERS: add entry for hpilo
Date:   Mon, 29 Mar 2021 10:53:52 +0800
Message-Id: <20210329025352.21485-1-matt.hsiao@hpe.com>
X-Mailer: git-send-email 2.16.6
X-Proofpoint-GUID: UaSvJbtOIA5XzPD1yzQ_dhfXusqTDWIr
X-Proofpoint-ORIG-GUID: UaSvJbtOIA5XzPD1yzQ_dhfXusqTDWIr
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_14:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=861 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290021
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Hsiao <matt.hsiao@hpe.com>

The original maintainer left the company, add myself as the successor.

Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb2a3633b719..0546e7f84a4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7890,6 +7890,11 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/usb/hdpvr/
 
+HEWLETT PACKARD ENTERPRISE ILO CHIF DRIVER
+M:	Matt Hsiao <matt.hsiao@hpe.com>
+S:	Supported
+F:	drivers/misc/hpilo.[ch]
+
 HEWLETT PACKARD ENTERPRISE ILO NMI WATCHDOG DRIVER
 M:	Jerry Hoemann <jerry.hoemann@hpe.com>
 S:	Supported
-- 
2.16.6

