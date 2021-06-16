Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C953A9E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhFPPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:01:35 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:37562 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233984AbhFPPBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:01:33 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GEk5Ai006762;
        Wed, 16 Jun 2021 09:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=Mw3GHvBga3fgTLPCAmKN+ThJzmhqCFnsBBbNphenue4=;
 b=dgDss5SM0rRoNioML2SmQX4kgsgz7P9xIgrvo9siY7WS/n8GyuiT8n/haizLYIZ5m9Pm
 3u0MuKLdzLsSZCvPcnNNJ0V8ufvdDzG6M+Kz3UvldgeS3QXK9u5+drWaFt2ge+ELF+B+
 KIwUpGohLsHCChmBNIRQrR2mgi2iOiyxzq4L2e7hrbsetTRblBaSnZpljEU/k9Jsyhfu
 riDxX5cQJygZy+xhGRiey3h5+LaLqfrUsSX0jz/MXTnaW2DOUsiTrgU67otIcnHCrN2g
 VolVwn8Fqj7HDvToia2CbqdAhEBSXrZAzTSJgXuo36M4Sonu8S/tPQIB0KJTtzABEuFr mg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 397ab2grbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 09:59:13 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 15:59:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 16 Jun 2021 15:59:12 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B751C2BA;
        Wed, 16 Jun 2021 14:59:05 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2] soundwire: bus: Make sdw_nwrite() data pointer argument const
Date:   Wed, 16 Jun 2021 15:59:01 +0100
Message-ID: <20210616145901.29402-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: okaVGtRl9-7hOM9nXq_pfifi2xM656L-
X-Proofpoint-GUID: okaVGtRl9-7hOM9nXq_pfifi2xM656L-
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 spamscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106160085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Idiomatically, write functions should take const pointers to the
data buffer, as they don't change the data. They are also likely
to be called from functions that receive a const data pointer.

Internally the pointer is passed to function/structs shared with
the read functions, requiring a cast, but this is an implementation
detail that should be hidden by the public API.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/bus.c       | 8 ++++----
 include/linux/soundwire/sdw.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index a9e0aa72654d..49c66deba106 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -394,13 +394,13 @@ sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 }
 
 static int
-sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
 {
 	struct sdw_msg msg;
 	int ret;
 
 	ret = sdw_fill_msg(&msg, slave, addr, count,
-			   slave->dev_num, SDW_MSG_FLAG_WRITE, val);
+			   slave->dev_num, SDW_MSG_FLAG_WRITE, (u8 *)val);
 	if (ret < 0)
 		return ret;
 
@@ -535,9 +535,9 @@ EXPORT_SYMBOL(sdw_nread);
  * @slave: SDW Slave
  * @addr: Register address
  * @count: length
- * @val: Buffer for values to be read
+ * @val: Buffer for values to be written
  */
-int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
 {
 	int ret;
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ced07f8fde87..ee45d2984334 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1040,7 +1040,7 @@ int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
 int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
 int sdw_read_no_pm(struct sdw_slave *slave, u32 addr);
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
-int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
+int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val);
 int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
 void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
 
-- 
2.20.1

