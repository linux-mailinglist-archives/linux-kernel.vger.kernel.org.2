Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD100434002
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhJSUzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:55:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbhJSUzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:55:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JKqYta010227;
        Tue, 19 Oct 2021 16:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bWSLdJokj3Lbnm7HvXDpghITkmfYosOMdEXedxpqtzI=;
 b=nDW6OHne8hEetonI9eRDw9MJHXBWm9buXJS5KUYRBiscsPUlXF/1H5qjuDkmEa/M7s3S
 noaNMRoDIvhkkF0mw6M7q/oxuj0Ves91riYtdS9JFX1J1poJcciOQQYGHs7+v8nxiln4
 TsBCgmF7mnwSJOfAI8RCkYYLkEbI2Zew8XOtzjMlrLqvtK7adrAtY3LNHvQptIfVmlQo
 OtbiMrtruJOm5Gg5b+GS6ekpcPwRchAhxFIpTtGOIHuK5B5rCvHOIHZY/ADrpTeIK+Bc
 WC6BQBhv3XYfE6TwvmYbUZBYAnDMForYJ6WX39YypvnYr43M5EkNdPzqrzr/pCpn9mRE lw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bt5ek00da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 16:53:10 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JKq1FI031910;
        Tue, 19 Oct 2021 20:53:09 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03wdc.us.ibm.com with ESMTP id 3bt4srs1d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 20:53:09 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JKr8ST52560214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 20:53:08 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E8F0124055;
        Tue, 19 Oct 2021 20:53:08 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C6E3124058;
        Tue, 19 Oct 2021 20:53:07 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.36.93])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 20:53:07 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, linux@roeck-us.net,
        jdelvare@suse.com, eajames@linux.ibm.com
Subject: [PATCH v4 0/4] occ: fsi and hwmon: Extract and provide the SBEFIFO FFDC
Date:   Tue, 19 Oct 2021 15:53:03 -0500
Message-Id: <20211019205307.36946-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sQzvMspzv4QAgSPwezngz6BHdGZXZyA4
X-Proofpoint-ORIG-GUID: sQzvMspzv4QAgSPwezngz6BHdGZXZyA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=721 adultscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190118
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

Changes since v3:
 - Rebase
 - Add a check for valid FFDC length
 - Add comments about SBE words being four bytes

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
 drivers/fsi/fsi-occ.c                         | 164 +++++++++---------
 drivers/hwmon/occ/p9_sbe.c                    |  86 ++++++++-
 include/linux/fsi-occ.h                       |   2 +
 4 files changed, 186 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-occ-hwmon

-- 
2.27.0

