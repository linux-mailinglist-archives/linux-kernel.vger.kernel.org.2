Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D6A4125B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354536AbhITSrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:47:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24292 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381830AbhITSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:43:39 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHTFui012846;
        Mon, 20 Sep 2021 14:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=meQS/RP9xoT9soPKhLQcaeOZwMSklLYSbprnpe+jLG0=;
 b=rqXWWlZuQ1g1KwNpDZ6oNkUV1k3ZU3b/WID/DNPna7QiHIXb9xaFHt6UVQDR901XDr9Z
 Q6iVVEjwlhfbAiRWEiMqGVxfnjBNePaousi2TDc27ys3uux2dANvkdiGqrUlKZQgUrcN
 fWknaluvwczGEeFF1fVH+OgHQR4vByhfn2QwI++HkiqUah3E+Jjg4Af7vrEQx7D0NCil
 51wdBdkn1Ub9PedsxIJgQTt3RVZYRlc2Hh5cIjaCb2VwGaWxacezD0wGbzvM/2HLm8sJ
 pHm1j8O7AiEjw0NUrvOn1y28c0dt4I6SHadveUy/rLz6+gLtPaHUOFGFJ4Bv2fPePA83 Bg== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b5wjy9v65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Sep 2021 14:41:45 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18KIb8Io012321;
        Mon, 20 Sep 2021 18:41:44 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 3b57ra6hqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Sep 2021 18:41:44 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18KIfhLk52036030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 18:41:43 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D796124053;
        Mon, 20 Sep 2021 18:41:43 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24B1412405C;
        Mon, 20 Sep 2021 18:41:42 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.87.144])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 20 Sep 2021 18:41:41 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        linux@roeck-us.net, jdelvare@suse.com, eajames@linux.ibm.com
Subject: [PATCH v2 0/3] occ: fsi and hwmon: Extract and provide the SBEFIFO FFDC
Date:   Mon, 20 Sep 2021 13:41:38 -0500
Message-Id: <20210920184141.21358-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: erWkY5jj-MtnCEJZLy9-uUNAKakpNgnp
X-Proofpoint-ORIG-GUID: erWkY5jj-MtnCEJZLy9-uUNAKakpNgnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=681
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200109
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

Changes since v1:
 - Remove the magic value that indicated an SBE/SBEFIFO error with no
   FFDC.
 - Remove binary sysfs state management and intead just clear the error
   flag when the whole FFDC has been read.

Eddie James (3):
  fsi: occ: Use a large buffer for responses
  fsi: occ: Store the SBEFIFO FFDC in the user response buffer
  hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs

 drivers/fsi/fsi-occ.c      | 163 +++++++++++++++++++------------------
 drivers/hwmon/occ/p9_sbe.c |  86 ++++++++++++++++++-
 include/linux/fsi-occ.h    |   2 +
 3 files changed, 171 insertions(+), 80 deletions(-)

-- 
2.27.0

