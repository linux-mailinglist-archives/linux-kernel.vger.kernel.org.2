Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C7E365469
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhDTIor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:44:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60852 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhDTIoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:44:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13K8JJqv175990;
        Tue, 20 Apr 2021 08:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=vUXFWl3fpUuqSWOHe9zDl0mexS+RTbrEVv1eNGSk3i4=;
 b=co5rixwnTNEul1efoP0KvaSOtc/dlB1psUa4EtTsNyLI6VYGCMBXbg7sV/p6tze0yyJ9
 P11jKLfYWZut4+cK4ISQ76WslgHBHePql5xfY3G2qZ7lEiY09DVlMkDzoifSnqhoIsJA
 3f1gW84Aodlvh2yQLMAfrL9m+LJ0NK2msaUkOAvg2+DOtm+goVIJNWubpIsmRAajB5qB
 yOWo94v3I31ds93gvqybTkreXBpvecSsZbnRi9vmKfF9JRRbzex/aTbPP55BQ3WCKGWI
 IjnLByFpmvYPiVSxD4fWE4HDOy5exQp52E8fZrbJYT6Ofwue1pdIouwivXRmwGvJ9dOj Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37yqmnebkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 08:44:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13K8bR1f138467;
        Tue, 20 Apr 2021 08:44:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38098pv4w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 08:44:11 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13K8iA7d163141;
        Tue, 20 Apr 2021 08:44:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 38098pv4vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 08:44:10 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13K8i99f015537;
        Tue, 20 Apr 2021 08:44:09 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Apr 2021 01:44:09 -0700
Date:   Tue, 20 Apr 2021 11:44:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator: fix a bit test
Message-ID: <YH6UUhJhGk3mk13b@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: 4iCASsShEcj4h5YPyacErW9Ry97_fC_x
X-Proofpoint-GUID: 4iCASsShEcj4h5YPyacErW9Ry97_fC_x
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "funcs" variable is a u64.  If "func" is more than 31 then the
BIT() shift will wrap instead of testing the high bits.

Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/platform/surface/aggregator/controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 00e38284885a..69e86cd599d3 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -1040,7 +1040,7 @@ static int ssam_dsm_load_u32(acpi_handle handle, u64 funcs, u64 func, u32 *ret)
 	union acpi_object *obj;
 	u64 val;
 
-	if (!(funcs & BIT(func)))
+	if (!(funcs & BIT_ULL(func)))
 		return 0; /* Not supported, leave *ret at its default value */
 
 	obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
-- 
2.30.2

