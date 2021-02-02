Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55F330C809
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhBBRjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:39:06 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:57384 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237667AbhBBRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:37:00 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 112HaDJu020123;
        Tue, 2 Feb 2021 11:36:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=ueoQaWSoc9GRqkZkHC9v6g7BA1XPdjpEOcqjaga1/TM=;
 b=XVQBYRf87dWPwIwRVKNaDp9fyxdCDmrPfY2J3tYx2h6E+qsRBlPh4KbmBIyfGzjWG+8V
 RBTUz1E29e92Rvnd8ayvOBsUyuD7D2jCw/lJdas7HwgR+uxlRscYpj8GeXNNd4i6BOpH
 mEXdu9ro3ViEPPu0OcOyUIWYsp5C9wd9GW+dVqRUblOy/LK1/K0nyt6zp7U+MvuFrz7k
 sQ/oLYfMaRt5+H0UNpJnhQTtGMxIsBFgkjNiMCMRakshlPIx7k8vmtmy/jEABcx8evZi
 Wj4vHhNerHv0O5suz6BW5+fciALJD7BK5B+2HQFn64+98aqYT7l6ROz7MqIMyH5AYPxq Lg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36d5r6c5a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Feb 2021 11:36:13 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 2 Feb 2021
 17:36:06 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 2 Feb 2021 17:36:06 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.44])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E777411CA;
        Tue,  2 Feb 2021 17:36:05 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <akpm@linux-foundation.org>, <arend@broadcom.com>
CC:     <rdunlap@infradead.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH RESEND] lib: crc8: Pointer to data block should be const
Date:   Tue, 2 Feb 2021 17:36:03 +0000
Message-ID: <20210202173603.7159-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020115
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

