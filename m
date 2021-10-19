Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1B8434004
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhJSUzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:55:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32842 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231314AbhJSUzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:55:45 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JJkqFs029889;
        Tue, 19 Oct 2021 16:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DDR7amV9b4jtrTajEyb2TPW4T7H2hgWGOt0jFZPj8N8=;
 b=d4+ymPHj5PRTEdc8Yxz4KoErmdhCczBegSJQfB40/9PRNFbi7DbFmcnwrNGdpE7DIiWe
 Fx3z7ntFsLuXxvCu0Ll0/K30Oj9E3hm0KwAQzuEJvCd2jtwWEtX0a+cBcryRQuPfZoV4
 OifMXDtVlqvNzwakIbRGDrw3PR5pWnbWzJt4KykkqgCsfzT0DAPIZr9+dvAU2k8AAMSn
 DGlDaJa3MylEsANnZe0rZdgTRcDcQDW2zAHqXjK8e+zMmHhOz7dKq59ugjZH+IKdrmlQ
 FA2n8PxRNrnpa+2sTNiRm58cOsgsZzUJ3EnGXeC016P2STnkwOZw9Cggl5x2PzxXtaWG Cw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bt4ftsev1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 16:53:12 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JKq0F2031895;
        Tue, 19 Oct 2021 20:53:12 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 3bt4srs1e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 20:53:12 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JKrBsP33751418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 20:53:11 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57BE1124058;
        Tue, 19 Oct 2021 20:53:11 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81A9312406E;
        Tue, 19 Oct 2021 20:53:10 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.36.93])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 20:53:10 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, linux@roeck-us.net,
        jdelvare@suse.com, eajames@linux.ibm.com
Subject: [PATCH v4 3/4] docs: ABI: testing: Document the OCC hwmon FFDC binary interface
Date:   Tue, 19 Oct 2021 15:53:06 -0500
Message-Id: <20211019205307.36946-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211019205307.36946-1-eajames@linux.ibm.com>
References: <20211019205307.36946-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8guSpQYANPOlT_NZk8a9Q4e9sXxVWL4g
X-Proofpoint-ORIG-GUID: 8guSpQYANPOlT_NZk8a9Q4e9sXxVWL4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=906 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the new binary sysfs that will dump the SBEFIFO
FFDC.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../testing/sysfs-bus-platform-devices-occ-hwmon    | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-occ-hwmon

diff --git a/Documentation/ABI/testing/sysfs-bus-platform-devices-occ-hwmon b/Documentation/ABI/testing/sysfs-bus-platform-devices-occ-hwmon
new file mode 100644
index 000000000000..b24d7ab0278f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-platform-devices-occ-hwmon
@@ -0,0 +1,13 @@
+What:		/sys/bus/platform/devices/occ-hwmon.X/ffdc
+KernelVersion:	5.15
+Contact:	eajames@linux.ibm.com
+Description:
+		Contains the First Failure Data Capture from the SBEFIFO
+		hardware, if there is any from a previous transfer. Otherwise,
+		the file is empty. The data is cleared when it's been
+		completely read by a user. As the name suggests, only the data
+		from the first error is saved, until it's cleared upon read. The OCC hwmon driver, running on
+		a Baseboard Management Controller (BMC), communicates with
+		POWER9 and up processors over the Self-Boot Engine (SBE) FIFO.
+		In many error conditions, the SBEFIFO will return error data
+		indicating the type of error and system state, etc.
-- 
2.27.0

