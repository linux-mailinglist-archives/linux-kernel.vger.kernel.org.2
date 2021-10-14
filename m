Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1C142E015
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhJNRdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:33:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19828 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231206AbhJNRdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:33:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EHSweS029454;
        Thu, 14 Oct 2021 13:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Rq0jcxFhNxsWKfix/Lz8kGT1bKN6ibN+5nMFu8RS/7A=;
 b=Y9zqZE5qg/RgZXEJaVLdbYi/r87yt1Ju43CYS85J3A+5B7LG4Tq8jMBjhHMydFu9FEWJ
 RLeDZskAxdpu7zOhaLi5AgW20fbPQ2x3D7m9iaIIhOFZoC9RHXqfHCly3ALT37FuFawo
 35qJSl4ihWt1QHYwNLTUzpULXYD6hUH2vpF+kJjTX7QXVq8+J6pE2cdG2Tpu23hRdMK1
 /OIqoAQlrQQHqhMCba8zzNYwYEQ6RerbPYWKhlVltv3yMPlOLmUDRPwr0+LsRcQEVfi5
 L5VbhJlBCYCtu8ndfuI1kz059YYHGcTlY2Nolf1MLIv4WenyXNMjG7HyAZJw2yUgdg+r GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bns3gch7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 13:30:58 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19EHO1C5001071;
        Thu, 14 Oct 2021 13:30:58 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bns3gch75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 13:30:58 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19EHBoVD000361;
        Thu, 14 Oct 2021 17:30:57 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 3bk2qcnb99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 17:30:57 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19EHUuiC17432838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 17:30:56 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CE2978068;
        Thu, 14 Oct 2021 17:30:56 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2207978066;
        Thu, 14 Oct 2021 17:30:56 +0000 (GMT)
Received: from localhost (unknown [9.211.53.229])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 14 Oct 2021 17:30:55 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: make of_node_check_flag() device_node parameter const
Date:   Thu, 14 Oct 2021 12:30:55 -0500
Message-Id: <20211014173055.2117872-1-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JY9EWnF96utcXMsIAX7Syizn4mRGmz5d
X-Proofpoint-ORIG-GUID: 1SY0t52Oa5vD4uq0yHKtp_7ZvbkZmhos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_09,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=868 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110140099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node argument isn't modified by of_node_check_flag(), so mark it
const.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 include/linux/of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 6f1c41f109bb..ac3a5dcbf9e1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -185,7 +185,7 @@ static inline bool of_node_is_root(const struct device_node *node)
 	return node && (node->parent == NULL);
 }
 
-static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
+static inline int of_node_check_flag(const struct device_node *n, unsigned long flag)
 {
 	return test_bit(flag, &n->_flags);
 }
-- 
2.31.1

