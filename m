Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51764419860
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhI0QBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:01:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235326AbhI0QBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:01:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RFp3ZW027286;
        Mon, 27 Sep 2021 11:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DDR7amV9b4jtrTajEyb2TPW4T7H2hgWGOt0jFZPj8N8=;
 b=jzlGHBDa3HdDncX2q769zZMisUx2cqztQWptmDYSpP4e3CRPtN+Bj1kJTXWWHvcduweM
 eKCG06SNHk3WOZFBMVjNmDLswsDgDl/y6LvllFSU2+xRMeZNQEP8NLzEB6keDrdyRMu0
 6Do/y08xA5WAVSS3iuiqU9IlV8dBrggLH+MdhG7wfr85WXr9fomav05539Ibqyfc1zYD
 +yaTJ7GyMQ0iFATfuokHsdyMXMsVkiO7zNnJkHe0Sdoyy/9PoG5BeR1Rb3s3/x6/0gmF
 o/K8OnmvAz3Cb5U+w3DJCvg7AYrv99ubKNKGqdBUn8L5Tsg1SFZx6JsV1cpW0PooUW53 /g== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bagn80guk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 11:59:38 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18RFv9wM023410;
        Mon, 27 Sep 2021 15:59:38 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 3b9udah94a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 15:59:38 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18RFxbYs38076742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 15:59:37 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1C862805C;
        Mon, 27 Sep 2021 15:59:36 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1CDE28064;
        Mon, 27 Sep 2021 15:59:35 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.70.165])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 27 Sep 2021 15:59:35 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        linux@roeck-us.net, jdelvare@suse.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 3/4] docs: ABI: testing: Document the OCC hwmon FFDC binary interface
Date:   Mon, 27 Sep 2021 10:59:24 -0500
Message-Id: <20210927155925.15485-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210927155925.15485-1-eajames@linux.ibm.com>
References: <20210927155925.15485-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZbA8UBDt6cVQL7MpmzaHB9e-Jt8ETDYH
X-Proofpoint-ORIG-GUID: ZbA8UBDt6cVQL7MpmzaHB9e-Jt8ETDYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_06,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270106
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

