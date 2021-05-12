Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FCC37BF72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhELOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:12:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44588 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230362AbhELOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:12:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CE4a1q146034;
        Wed, 12 May 2021 10:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=d0UUIad/gZlY4qKQ9o8OrUCGPp92lSUIJYiNaYE2ss4=;
 b=MmDCJwvrvOY79IivoYIqTyUDAySf7TuUv6mwjWfa6nnB00TrBgXf29qzs7Nx9jMX8c3F
 l2820M4puZ1JG6aDkVFXd2EhRy6ZxIbGsV9KMxY9ZarFC3iWIMEIOmbvFk+Q2OYFSvJ1
 Kwd3V2UXC3d3sdIF4PQ9UDesBi8JUggbFDp0vheP2wR4sLkjnow0CYOwgiz3P9RtUryu
 ZPj/YLGdYIiokogWusgbdxDkia4LNp8uSP/iUcFLk2kMR2Vt0NZ0oF5SxCA4tZKAlK30
 Sp37CJZcRnzDYr1d+KMTlKiOl6U4uuhdc8kV+jsak58E1rvnOwMSXFOB2nOx8Z5Wjml/ mg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gehtc8nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 10:11:06 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14CDq2RH032506;
        Wed, 12 May 2021 14:11:04 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 38dj98a87g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 14:11:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14CEAZV729426088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 14:10:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F4A511C054;
        Wed, 12 May 2021 14:11:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3825611C050;
        Wed, 12 May 2021 14:11:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 May 2021 14:11:02 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH] driver core: replace open-coded device_lock_assert()
Date:   Wed, 12 May 2021 16:10:54 +0200
Message-Id: <20210512141054.2180373-1-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gq5kCRb1hfewYtpVS9xpZ7q34TKRCQ-e
X-Proofpoint-GUID: gq5kCRb1hfewYtpVS9xpZ7q34TKRCQ-e
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_06:2021-05-12,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=929
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the right wrapper makes it easier to associate this assert
statement with the device_[un]lock() helpers.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4a8bf8cda52b..bfa3536d48df 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3437,7 +3437,7 @@ bool kill_device(struct device *dev)
 	 * to run while we are tearing out the bus/class/sysfs from
 	 * underneath the device.
 	 */
-	lockdep_assert_held(&dev->mutex);
+	device_lock_assert(dev);
 
 	if (dev->p->dead)
 		return false;
-- 
2.25.1

