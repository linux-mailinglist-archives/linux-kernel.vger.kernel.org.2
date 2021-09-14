Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7901040BA60
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhINVhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:37:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234905AbhINVhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:37:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18ELTJCa017399;
        Tue, 14 Sep 2021 17:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8YkWHHZWBMRmrxft3c4znvxzx63UXOJv+ONJc9YVRQQ=;
 b=lXbWXt13RjOsf2zyJHLQ+OSzHbSOwO8aU5UI3GIq6qY2cdChb4RsgsrgqvOm1i5XlwsA
 mIxQWaaoufyMdXaX32SGJ+UBSQKaWOIasdpcRbrnq2K8viVbb7nKYpMe4k1tWY3zp4yx
 ruRKLjqm5q5g6fCfpgbL3zrOEBYMK09o2MP5rTfxsWQKI1cbpUMWmm4vE76dp+6Lmbin
 /F41KyTtZl7pSVm1xGdAn40fLYPrwf1S8JXpuMGGoITLO1+ad7qT/Az0Y1V9D4lQjt/T
 QhItDV2orPKbzyVZJ7sUSv0vPBB84uR/Lw4Y77xbtMAfftd0A3DFI/DlnHwskGbVl9ar /Q== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b33psg40g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 17:35:47 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18ELRpIP016509;
        Tue, 14 Sep 2021 21:35:46 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 3b0m3d37v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 21:35:45 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18ELZiCY17236382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:35:44 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 851E1136055;
        Tue, 14 Sep 2021 21:35:44 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12212136066;
        Tue, 14 Sep 2021 21:35:43 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.154.14])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Sep 2021 21:35:43 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, linux@roeck-us.net, jdelvare@suse.com,
        alistair@popple.id.au, jk@ozlabs.org, eajames@linux.ibm.com
Subject: [PATCH 0/3] occ: fsi and hwmon: Extract and provide the SBEFIFO FFDC
Date:   Tue, 14 Sep 2021 16:35:40 -0500
Message-Id: <20210914213543.73351-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dXVbggaTbo18cX80ZZMiKriM-p5bRR-h
X-Proofpoint-GUID: dXVbggaTbo18cX80ZZMiKriM-p5bRR-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=716 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140123
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

Eddie James (3):
  fsi: occ: Use a large buffer for responses
  fsi: occ: Store the SBEFIFO FFDC in the user response buffer
  hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs

 drivers/fsi/fsi-occ.c      | 184 ++++++++++++++++++++-----------------
 drivers/hwmon/occ/p9_sbe.c |  98 +++++++++++++++++++-
 include/linux/fsi-occ.h    |   3 +
 3 files changed, 202 insertions(+), 83 deletions(-)

-- 
2.27.0

