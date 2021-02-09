Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742373154D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhBIROq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:14:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233001AbhBIROO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:14:14 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 119HAXDs051192;
        Tue, 9 Feb 2021 12:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=562yemiyOVTuwyRZThhtFedlR0E4yBk+jaDR1AUavJY=;
 b=iHC3xefCu8r0C5tk9UT8d+jk1EAI3fEffeQ8UwwcJxnxPtxrGgPdD4VZqGBlaNVu5cJd
 2/US67ARQGB5W37zDEtVRGXABdCijZVxRyCozFyVD4tOjoHrkABKSJrcDx3WtUUwSPST
 X2cZEhzPZv8ge2/fFDRXUYXVL4C2bOc6ddud5mtxWBsDNk8S6LZ6Yk08evmpyGPLf3NC
 OrA9VDJbtRN265ov3iGKIl3z6dyN0Qhz+4OSeW4uS8ziWA1g5rAVCM0c9rq/bQHmwgB5
 409FeEurOE8UuLjLYK5BX8Y06SxmlZoV99VFyW22Fu7apywPizLKx8R+oXZpMed8bggq cg== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kw4tbu0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 12:13:06 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 119GvaiU026201;
        Tue, 9 Feb 2021 17:13:05 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 36hjr981wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 17:13:05 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 119HD4js17367384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 17:13:04 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C10EAE063;
        Tue,  9 Feb 2021 17:13:04 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67760AE05C;
        Tue,  9 Feb 2021 17:13:03 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.58.95])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Feb 2021 17:13:03 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        jdelvare@suse.com, linux@roeck-us.net,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 4/4] hwmon: (occ) Print response status in first poll error message
Date:   Tue,  9 Feb 2021 11:12:35 -0600
Message-Id: <20210209171235.20624-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210209171235.20624-1-eajames@linux.ibm.com>
References: <20210209171235.20624-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_05:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to better debug problems starting up the driver, print
the response status from the OCC in the error logged when the first
poll command fails.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index ee0c5d12dfdf..f71d62b57468 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -1161,8 +1161,9 @@ int occ_setup(struct occ *occ, const char *name)
 		dev_info(occ->bus_dev, "host is not ready\n");
 		return rc;
 	} else if (rc < 0) {
-		dev_err(occ->bus_dev, "failed to get OCC poll response: %d\n",
-			rc);
+		dev_err(occ->bus_dev,
+			"failed to get OCC poll response=%02x: %d\n",
+			occ->resp.return_status, rc);
 		return rc;
 	}
 
-- 
2.27.0

