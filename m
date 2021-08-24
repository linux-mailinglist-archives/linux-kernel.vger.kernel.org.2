Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A123F5C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbhHXKcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:32:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236319AbhHXKco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:32:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17OATa9T120550;
        Tue, 24 Aug 2021 06:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=55jPYrm2CeOCXNTRbI3j9+G9udguvuCT/EodvQBcFn0=;
 b=gsp97i6DcRC4eGjuz7wKhFK74F44PB5ujUAOvlz+wxZ2m/aP7Z4rNweds9LMP2PPBQdD
 2GKGa2FsPBY/3dEsW03kf+EkKz7mwnyDWUWHctzQJW6s1k9MHLpFzp2F/24FggqGzat7
 vnx5+d+htCEmHErBL5NiQKb6nIBsc3zvvWrvGYooCnq1qcGRk0x38lO5/PpvWVBzmuAV
 XEQskRM8B6zygtCIeS2EJ75++ZVyiqLgq1QvMP99vNyyNL3ZIDKYCHxC7WU+k9NU6EQn
 9gqQi38VurgdkM4GJsH5PWKJ4C7BqJMNzkMYPM5oaw8HtlGXXcR60WoqHGHbVwOV9rls yw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amy2kr1gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 06:31:09 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17OARioa030215;
        Tue, 24 Aug 2021 10:31:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ajs48cxx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 10:31:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17OARKQE23724438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 10:27:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DB9C11C05C;
        Tue, 24 Aug 2021 10:31:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4ECC11C054;
        Tue, 24 Aug 2021 10:31:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Aug 2021 10:31:02 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: clean up open-coded NUMA_NO_NODE in device_initialize()
Date:   Tue, 24 Aug 2021 12:30:55 +0200
Message-Id: <20210824103056.1571475-1-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CubTcxcH7l3hNKE8JRnicOQXxI13E6mx
X-Proofpoint-GUID: CubTcxcH7l3hNKE8JRnicOQXxI13E6mx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_02:2021-08-24,2021-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the right macro to get rid of a magic number.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f6360490a4a3..fa1043d74e36 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2835,7 +2835,7 @@ void device_initialize(struct device *dev)
 	spin_lock_init(&dev->devres_lock);
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
-	set_dev_node(dev, -1);
+	set_dev_node(dev, NUMA_NO_NODE);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	INIT_LIST_HEAD(&dev->msi_list);
 #endif
-- 
2.25.1

