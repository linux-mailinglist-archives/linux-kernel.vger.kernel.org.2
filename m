Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F193B101B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFVWeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:34:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229675AbhFVWea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:34:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MM3plg081412;
        Tue, 22 Jun 2021 18:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=PAiQ9DOwEvzOctZzFK/vKd2mPf1P98CwzdiESolvSZ0=;
 b=BYN8h9jG5HxZ5cHstqc6wRGItxNJs/R6TN9OdAodJk2ofSnoyFwC2QBZ3lGBLVuEXZ0b
 0RpgC1YqqzdARTM0zmfbz64ooYot5wbuQgaeep7FK7LZAJuy9hbPgzmSf1jdVKvccina
 cBUrlilSSlQvEuzIkyJ41oUF5cRQfFIim4ocptcTticxmqr+6C0NxM3Z9gCdveoxUiTV
 9w0VoaXomewCdbOBH8NySdaZnwD//KiOM+8ZCHeCMs+baMZebiSc3iTOCyNrsRd+q6B8
 7CHdqztQCO19zZGymwvN2lu0inTQ/EviGb0wRYKfNCb4OD1BlQnYyN/H+GqC1lt9Vh6M /w== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39bnpv4n0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 18:32:10 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15MMCbar001385;
        Tue, 22 Jun 2021 22:32:09 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 399879t883-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 22:32:09 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15MMW9l539518520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 22:32:09 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 056D8AE08A;
        Tue, 22 Jun 2021 22:32:09 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92092AE062;
        Tue, 22 Jun 2021 22:32:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 22 Jun 2021 22:32:08 +0000 (GMT)
From:   wenxiong@linux.vnet.ibm.com
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, brking1@linux.vnet.ibm.com,
        wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH 1/1] ipr: system crashes when seeing type 20 error
Date:   Tue, 22 Jun 2021 16:07:24 -0500
Message-Id: <1624396044-4916-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D0gK8iMx2VP_1cs2LsoTZBhQF_kGosdy
X-Proofpoint-ORIG-GUID: D0gK8iMx2VP_1cs2LsoTZBhQF_kGosdy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_13:2021-06-22,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

Test team saw "4041: Incomplete multipath connection between enclosure
and device" when IO drawers/drives have bad connections. System crashes
when handling this type 20 errors.

[    5.332452] ipr: 3/00-06-09: 4041: Incomplete multipath connection between enclosure and device
[    5.332460] ipr: 3/00-06-09: The IOA failed to detect an expected path to a device
[    5.332465] ipr: 3/00-06-09: Inactive path is failed: Resource Path=3/00-04-09
[    5.332471] ipr: 3/00-06-09: Functional IOA port: Resource Path=3/00-04, Link rate=unknown, WWN=5005076059C38E05
[    5.332478] ipr: 3/00-06-09: Incorrectly connected Device LUN: Resource Path=3/00-00-00-00-00-00-00-00-00-20-00-00-24-00-00-00-0, Link rate=unknown, WWN=0020000024000000
[    5.332487] ipr: 3/00-06-09: Path element=FF: Resource Path=3/50-05-07-60-45-56-5A-9C-00-00-00-00-00-00-00-00-0, Link rate=unknown WWN=0000000000000000
[    5.332492] ipr: 00000000: 54520EC8 00000000 00000000 4E532050
[    5.332495] ipr: 00000010: 45522054 49434B3D 00000050 278130E6
[    5.332498] ipr: 00000020: 033B5300 03282584 4C4D00E0 278039F3
[    5.332501] ipr: 00000030: 033B5180 03282404 4C4D00E0 276A0282
[    5.332504] ipr: 00000040: 033B5000 03281E04 447000E0 27697D19
[    5.332507] ipr: 00000050: 033B4E80 03281D84 447000E0 27690524
[    5.332509] ipr: 00000060: 033B4D00 03281C84 447000E0 27687FDA
[    5.332512] ipr: 00000070: 033B4B80 03281C04 447000E0 2767E787
[    5.332515] ipr: 00000080: 033B4A00 03281B04 447000E0 27674F0A

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>

---
 drivers/scsi/ipr.c | 4 ++--
 drivers/scsi/ipr.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 30c30a1db5b1..5d78f7e939a3 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -1300,7 +1300,7 @@ static char *__ipr_format_res_path(u8 *res_path, char *buffer, int len)
 
 	*p = '\0';
 	p += scnprintf(p, buffer + len - p, "%02X", res_path[0]);
-	for (i = 1; res_path[i] != 0xff && ((i * 3) < len); i++)
+	for (i = 1; res_path[i] != 0xff && i < IPR_RES_PATH_BYTES; i++)
 		p += scnprintf(p, buffer + len - p, "-%02X", res_path[i]);
 
 	return buffer;
@@ -1323,7 +1323,7 @@ static char *ipr_format_res_path(struct ipr_ioa_cfg *ioa_cfg,
 
 	*p = '\0';
 	p += scnprintf(p, buffer + len - p, "%d/", ioa_cfg->host->host_no);
-	__ipr_format_res_path(res_path, p, len - (buffer - p));
+	__ipr_format_res_path(res_path, p, len - (p - buffer));
 	return buffer;
 }
 
diff --git a/drivers/scsi/ipr.h b/drivers/scsi/ipr.h
index 783ee03ad9ea..69444d21fca1 100644
--- a/drivers/scsi/ipr.h
+++ b/drivers/scsi/ipr.h
@@ -428,6 +428,7 @@ struct ipr_config_table_entry64 {
 	__be64 lun;
 	__be64 lun_wwn[2];
 #define IPR_MAX_RES_PATH_LENGTH		48
+#define IPR_RES_PATH_BYTES		8
 	__be64 res_path;
 	struct ipr_std_inq_data std_inq_data;
 	u8 reserved2[4];
-- 
2.27.0

