Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16D839130F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhEZIy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:54:29 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14334 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232808AbhEZIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:54:29 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14Q8pd9g026635;
        Wed, 26 May 2021 04:52:57 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 38shmq891h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 04:52:56 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 14Q8qst2014253
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 04:52:55 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 26 May 2021 01:52:52 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 26 May 2021 01:52:52 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Wed, 26 May 2021 01:52:52 -0700
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.143])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 14Q8qmas013903;
        Wed, 26 May 2021 04:52:49 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrei Drimbarean <andrei.drimbarean@analog.com>
Subject: [PATCH] regmap: add support for 7/17 register formating
Date:   Wed, 26 May 2021 11:52:24 +0300
Message-ID: <20210526085223.14896-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: FBdXPTlKNaVdv4QtcsQsy-oB01NtfIE4
X-Proofpoint-ORIG-GUID: FBdXPTlKNaVdv4QtcsQsy-oB01NtfIE4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_06:2021-05-25,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=919 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105260056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for 7 bits register, 17 bits value type register
formating. This is used, for example, by the Analog Devices
ADMV1013/ADMV1014.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Andrei Drimbarean <andrei.drimbarean@analog.com>
---
 drivers/base/regmap/regmap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 19f57ccfbe1d..bc1c36b93c15 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -230,6 +230,16 @@ static void regmap_format_7_9_write(struct regmap *map,
 	*out = cpu_to_be16((reg << 9) | val);
 }
 
+static void regmap_format_7_17_write(struct regmap *map,
+				    unsigned int reg, unsigned int val)
+{
+	u8 *out = map->work_buf;
+
+	out[2] = val;
+	out[1] = val >> 8;
+	out[0] = (val >> 16) | (reg << 1);
+}
+
 static void regmap_format_10_14_write(struct regmap *map,
 				    unsigned int reg, unsigned int val)
 {
@@ -864,6 +874,9 @@ struct regmap *__regmap_init(struct device *dev,
 		case 9:
 			map->format.format_write = regmap_format_7_9_write;
 			break;
+		case 17:
+			map->format.format_write = regmap_format_7_17_write;
+			break;
 		default:
 			goto err_hwlock;
 		}
-- 
2.25.1

