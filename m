Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65A743405F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhJSVUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:20:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229757AbhJSVUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:20:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JKb41d018601;
        Tue, 19 Oct 2021 17:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iRqgWxxg+iOFC3Bn/CSNvCl8ea31ahQ16yAUIoc9AiU=;
 b=b4w/7prdQnjmSLeGsHBcIn9f6+AEsgs6lpkKfT4n483K3Uarl0MOZqdInnSnrc9Pcf7c
 lK7Ty2zWHAv5rKSAVADEVTojiaxWxwmOmZA4UzjsIt62Q6/4WakCIKJx9+18+u30KYya
 nJilQJPp3HJISdP+YS7C1vBRAV0kiJLDZwuc6MOHp8tX3DYbSrOAmLbnAUYUzBqQ8qiq
 /O/NZSJp3XFjC2kPp0K0Mg/cIb4OAlerkhZCqFTd3leWHvGPBff4RUGa0K2pLr5xuuwY
 Oofmbv7m99OxczAJda5GQRBvP9weJVPqKXZBe9/B7iMHXSHEjzCYo7rB02ajPGCL/My5 Fg== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bt35w3w11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 17:17:52 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JLDx4w029657;
        Tue, 19 Oct 2021 21:17:52 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 3bqpcb829d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 21:17:52 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JLHptA39846206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 21:17:51 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12AEC6A05A;
        Tue, 19 Oct 2021 21:17:51 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B21F26A05D;
        Tue, 19 Oct 2021 21:17:50 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.36.93])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 21:17:50 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, eajames@linux.ibm.com
Subject: [PATCH v2 1/2] docs: ABI: testing: Document the SBEFIFO timeout interface
Date:   Tue, 19 Oct 2021 16:17:48 -0500
Message-Id: <20211019211749.38059-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211019211749.38059-1-eajames@linux.ibm.com>
References: <20211019211749.38059-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DRjGaXtFH0Id3MGi_UO8caL1y_8ajul3
X-Proofpoint-ORIG-GUID: DRjGaXtFH0Id3MGi_UO8caL1y_8ajul3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110190122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the new sysfs entry that indicates whether or not
the SBE has timed out.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../ABI/testing/sysfs-bus-fsi-devices-sbefifo          | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo

diff --git a/Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo b/Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo
new file mode 100644
index 000000000000..531fe9d6b40a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo
@@ -0,0 +1,10 @@
+What:		/sys/bus/fsi/devices/XX.XX.00:06/sbefifoX/timeout
+KernelVersion:	5.15
+Contact:	eajames@linux.ibm.com
+Description:
+		Indicates whether or not this SBE device has experienced a
+		timeout; i.e. the SBE did not respond within the time allotted
+		by the driver. A value of 1 indicates that a timeout has
+		ocurred and no transfers have completed since the timeout. A
+		value of 0 indicates that no timeout has ocurred, or if one
+		has, more recent transfers have completed successful.
-- 
2.27.0

