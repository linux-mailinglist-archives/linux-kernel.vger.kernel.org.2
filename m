Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED748308A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhA2QnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 11:43:02 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:32876 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231774AbhA2QmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 11:42:13 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10TGYf06030312;
        Fri, 29 Jan 2021 10:41:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=asEApGlJPp9aAVE0lyAUCcts8ePMP7FAIzfsrbb6X1g=;
 b=Qw9uA0hapTNWItC1FHMqRLxHRGOazL33ByDe9frUrxgHqPbwnhTnCNBVdTJP7gYUm6CR
 r+VlUEBEJZHqz/pfB2TjzIAGvOgYwe3xB3AR0qjvRzHuxSQ77raNrcxa7U8WxeJ2mfaK
 wcpcTx58YqQ2QN3HraMBMQdxAxbP158s/BoTmUj/3XQ62lyoiKsIi+kzODpNuFg9Zlux
 1BE/ML3n0M3Q8J5XYHlyn3vA2WAv5zcf+DmB3Hxv8PGZQFd1tmecDNLrMA3hMNBf6FFu
 9zkYqK9flI7VJQ/89h3djdog5KV9o5aK9ycQaGvQSaUKhG7wkAr8PzQV3mO6euIsb/NT 3Q== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 368h3u7my8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Jan 2021 10:41:24 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 29 Jan
 2021 16:41:23 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 29 Jan 2021 16:41:23 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.253])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D49E245;
        Fri, 29 Jan 2021 16:41:22 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <rdunlap@infradead.org>, <arend@broadcom.com>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] lib: crc8: Pointer to data block should be const
Date:   Fri, 29 Jan 2021 16:41:20 +0000
Message-ID: <20210129164120.27604-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 clxscore=1011 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crc8() does not change the data passed to it, so the pointer argument
should be declared const. This avoids callers that receive const data
having to cast it to a non-const pointer to call crc8().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/linux/crc8.h | 2 +-
 lib/crc8.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/crc8.h b/include/linux/crc8.h
index 13c8dabb0441..674045c59a04 100644
--- a/include/linux/crc8.h
+++ b/include/linux/crc8.h
@@ -96,6 +96,6 @@ void crc8_populate_msb(u8 table[CRC8_TABLE_SIZE], u8 polynomial);
  * Williams, Ross N., ross<at>ross.net
  * (see URL http://www.ross.net/crc/download/crc_v3.txt).
  */
-u8 crc8(const u8 table[CRC8_TABLE_SIZE], u8 *pdata, size_t nbytes, u8 crc);
+u8 crc8(const u8 table[CRC8_TABLE_SIZE], const u8 *pdata, size_t nbytes, u8 crc);
 
 #endif /* __CRC8_H_ */
diff --git a/lib/crc8.c b/lib/crc8.c
index 595a5a75e3cd..1ad8e501d9b6 100644
--- a/lib/crc8.c
+++ b/lib/crc8.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL(crc8_populate_lsb);
  * @nbytes: number of bytes in data buffer.
  * @crc: previous returned crc8 value.
  */
-u8 crc8(const u8 table[CRC8_TABLE_SIZE], u8 *pdata, size_t nbytes, u8 crc)
+u8 crc8(const u8 table[CRC8_TABLE_SIZE], const u8 *pdata, size_t nbytes, u8 crc)
 {
 	/* loop over the buffer data */
 	while (nbytes-- > 0)
-- 
2.20.1

