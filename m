Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D5634D002
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhC2MYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:24:55 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:19458 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231135AbhC2MYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:24:21 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TCLogo010357;
        Mon, 29 Mar 2021 07:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=ueoQaWSoc9GRqkZkHC9v6g7BA1XPdjpEOcqjaga1/TM=;
 b=WqtQd7bXMe5IHbx4MXzbLzcyNUSgOtYNbZSt4cNFquGNeExFSIeoAhaY0IUHAjNZBfLH
 OzalGUl6D1U8KRWrBcsZNbZjvWFItWqSnqdkIv6JyGj2kfq5oTHjvP8yV72CC6Ap+M7d
 H7YOPqwKmhWC8ESoHrmJssu5aTlWi5YxMoAf4qa8/ytXHEjKth6QeJkGbiaH6o0qhEtT
 kv2UYrMOxlssOapk+bKzuQPWVigy6VhhA2j34oFREmfRfV++lt56jTpyLSUTboeoZZsk
 Kv51MW14YJoTDZ24NVlwgTjOwdOmSnbO2UITny5pHImV+We0fiojM1Oxz3Poxf6ST3MV VQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 37j14pjaq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 07:24:13 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 29 Mar
 2021 13:24:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 29 Mar 2021 13:24:12 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8C9FC11CF;
        Mon, 29 Mar 2021 12:24:11 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <akpm@linux-foundation.org>, <arend@broadcom.com>
CC:     <rdunlap@infradead.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH RESEND] lib: crc8: Pointer to data block should be const
Date:   Mon, 29 Mar 2021 13:24:09 +0100
Message-ID: <20210329122409.3291-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 900yaGNAnM4HWvUR0oNViMJ_bExBXh1k
X-Proofpoint-ORIG-GUID: 900yaGNAnM4HWvUR0oNViMJ_bExBXh1k
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crc8() does not change the data passed to it, so the pointer argument
should be declared const. This avoids callers that receive const data
having to cast it to a non-const pointer to call crc8().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
No maintainer listed for this file so including Andrew Morton on the
'to' list.
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

