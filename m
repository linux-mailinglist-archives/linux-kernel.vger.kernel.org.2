Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04919419858
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhI0QBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:01:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235231AbhI0QBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:01:35 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RFKkVJ019427;
        Mon, 27 Sep 2021 11:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9rjvTpuegI7nSldU/P2UqoAV18PNgkJMnAtwNiMbFW0=;
 b=j9Hd7JUgg3CqJHdxnCIxDva6gc8DsCgopuD3i3J3uVQC1LCodvqotCzMZmKApkX0/up6
 r/MQqknk9hqQuO4Uchl48CmJwSjG9YnQP0v6D/12pj4Cb25Lf/UJnztE5UQA0/kkkEK/
 K4ymecVT0QGPxO1pn62/y/ibNU/wWFRPSxpdVHC5Le+mI0hKn3/egO7WCf2BxclnShCr
 vP7yv5pS6ALsKqjnSYeZSC5NngxD0yVatI/2HoU+4A5ByRQvdcUK2kP5xNSqI0Om/60z
 qQN5EHEDBze3Qd8SnxD0WoZgLWQKKa6r8lADPfVPoAyTzeIVIRJ4Ll0KqDN9dJ/76/gb 9g== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bagsey5jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 11:59:33 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18RFvA5N023415;
        Mon, 27 Sep 2021 15:59:32 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 3b9udah922-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 15:59:32 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18RFxVLS31326708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 15:59:31 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E18828066;
        Mon, 27 Sep 2021 15:59:31 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0B0B2805E;
        Mon, 27 Sep 2021 15:59:29 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.70.165])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 27 Sep 2021 15:59:29 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        linux@roeck-us.net, jdelvare@suse.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 0/4] occ: fsi and hwmon: Extract and provide the SBEFIFO FFDC
Date:   Mon, 27 Sep 2021 10:59:21 -0500
Message-Id: <20210927155925.15485-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hq_U2-C-OvtzS1JO9UzamJ6rVWwuL0C5
X-Proofpoint-ORIG-GUID: hq_U2-C-OvtzS1JO9UzamJ6rVWwuL0C5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_06,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=814 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, users have no way to obtain the FFDC (First Failure Data
Capture) provided by the SBEFIFO when an operation fails. To remedy this,
add code in the FSI OCC driver to store this FFDC in the user's response
buffer and set the response length accordingly.
On the hwmon side, there is a need at the application level to perform
side-band operations in response to SBE errors. Therefore, add a new
binary sysfs file that provides the FFDC (or lack thereof) when there is
an SBEFIFO error. Now applications can take action when an SBE error is
detected.

Changes since v2:
 - Add documentation

Changes since v1:
 - Remove the magic value that indicated an SBE/SBEFIFO error with no
   FFDC.
 - Remove binary sysfs state management and intead just clear the error
   flag when the whole FFDC has been read.

Eddie James (4):
  fsi: occ: Use a large buffer for responses
  fsi: occ: Store the SBEFIFO FFDC in the user response buffer
  docs: ABI: testing: Document the OCC hwmon FFDC binary interface
  hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs

 .../sysfs-bus-platform-devices-occ-hwmon      |  13 ++
 drivers/fsi/fsi-occ.c                         | 163 +++++++++---------
 drivers/hwmon/occ/p9_sbe.c                    |  86 ++++++++-
 include/linux/fsi-occ.h                       |   2 +
 4 files changed, 184 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-occ-hwmon

-- 
2.27.0

