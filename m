Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11F340C436
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbhIOLQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:16:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21066 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232540AbhIOLQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:16:49 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FAUbxR026751;
        Wed, 15 Sep 2021 07:15:27 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b2v0scb9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 07:15:27 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 18FBFQiM041096
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 07:15:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Wed, 15 Sep 2021
 07:15:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Wed, 15 Sep 2021 07:15:25 -0400
Received: from ramonaalexandra-Precision-5520.ad.analog.com ([10.48.65.154])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18FBFN3f006537;
        Wed, 15 Sep 2021 07:15:24 -0400
From:   Ramona Alexandra Nechita <ramona.nechita@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <zbr@ioremap.net>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>
Subject: [PATCH] w1: slaves: fixed typo in w1_ds28e04.c initial comment
Date:   Wed, 15 Sep 2021 14:15:16 +0300
Message-ID: <20210915111516.17943-1-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: YqZ0U0ABdcBobuSCuKi0c2xXipxUvs5q
X-Proofpoint-GUID: YqZ0U0ABdcBobuSCuKi0c2xXipxUvs5q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_02,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DS28E04 is supposed to be DS28E04-100. Fixed in the
initial comment from w1_ds28ee04.c.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 drivers/w1/slaves/w1_ds28e04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
index 8a640f159078..a2199495c873 100644
--- a/drivers/w1/slaves/w1_ds28e04.c
+++ b/drivers/w1/slaves/w1_ds28e04.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *	w1_ds28e04.c - w1 family 1C (DS28E04) driver
+ *	w1_ds28e04.c - w1 family 1C (DS28E04-100) driver
  *
  * Copyright (c) 2012 Markus Franke <franke.m@sebakmt.com>
  */
-- 
2.25.1

