Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4B3CB997
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbhGPPWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:22:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240662AbhGPPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:22:25 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GFJ7lv044354;
        Fri, 16 Jul 2021 11:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0QVlcMY1gAfIISVAPvHh34Y1TfGpWj4HRFD2XYrOwRA=;
 b=XiGclKh/s2TG9RrL+Ho2GcVydfo/EQwFye7efm3AGxDTP20BJV52i1XNI4aUrtmaLZVj
 UqRXDCxB2/VkjViGUGHZ/S80fddbv7AXT+GAdJEJWJre+Q7Ug9ayx0mw8LHwFqz949pA
 AZ2itmpRExDf8Z3e9rjA2uEwvEtvFY2AQSKtFmOxzJqLJuY/PMW1je55M+SbJ40UWbJJ
 v4kFBrTWtDY2c42T/+y7K1F0pqvJI00VymjO3LMqBjriXRhn9tSQyEW47yjR7Q2wq841
 JCGskb9MMorvxD6lNI6NSxdHj9waLTM6q2gDUCIK+rBWChKnPdNa9NbqYMUeqR6R/vcS XA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39tw6bgduv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 11:19:07 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GFHgtY017641;
        Fri, 16 Jul 2021 15:18:58 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 39q36f71pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 15:18:58 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GFIvo831523160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 15:18:57 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16CE2C605D;
        Fri, 16 Jul 2021 15:18:57 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 943FFC6057;
        Fri, 16 Jul 2021 15:18:56 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.92.96])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 16 Jul 2021 15:18:56 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        linux@roeck-us.net, jdelvare@suse.com, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/3] OCC: fsi and hwmon: Set sequence number in submit interface
Date:   Fri, 16 Jul 2021 10:18:47 -0500
Message-Id: <20210716151850.28973-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uzbyxn0zbHVSz9zdEq9wLFhQ-OlU1hCK
X-Proofpoint-ORIG-GUID: uzbyxn0zbHVSz9zdEq9wLFhQ-OlU1hCK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_05:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=921 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conflicting sequence numbers have resulted in users of the OCC interface
getting the wrong response. For example, both the hwmon driver and an
application might send a transfer near the same time with the same sequence
number, and then one or both will get an incorrect respnse, but cannot tell
because the sequence number looks correct.
Perform the sequence numbering in the submit interface to make sure each
transfer has a unique sequence number. This also requires that the submit
interface perform the checksum calculation for the command. Adjust the hwmon
driver accordingly too.

Eddie James (3):
  fsi: occ: Force sequence numbering per OCC
  hwmon: (occ) Remove sequence numbering and checksum calculation
  fsi: occ: Add dynamic debug to dump command and response

 drivers/fsi/fsi-occ.c      | 98 +++++++++++++++++++++++++++++++-------
 drivers/hwmon/occ/common.c | 30 +++++-------
 drivers/hwmon/occ/common.h |  3 +-
 drivers/hwmon/occ/p8_i2c.c | 15 +++---
 drivers/hwmon/occ/p9_sbe.c |  4 +-
 5 files changed, 105 insertions(+), 45 deletions(-)

-- 
2.27.0

