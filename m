Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792BA34F300
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhC3VZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:25:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34720 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232503AbhC3VZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:25:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UL4537075355;
        Tue, 30 Mar 2021 17:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=WGevOUYeABgQK1oYMwEC64xDN3lnfAnxL1yOftiflwk=;
 b=dEj3I4gzgDKIccVgIPxbbRTWik5bdTPS1SwnipFIJTrRpDcTZESZUyCuoAzq8fdnnB8l
 LnLeU6QU3RpkrgPwPQ85g/BcKuEb5hQAxqg6/dgA3o2z/o+W9BWItrYKEQ/tuO3pxUh3
 Hgn5SEx8LVRQw3KAxJ3bOXqTvIv3A93HJxzhoeh2Ue9CAui1fawd6LSC6XvFVcFEB7U7
 RkcrluYWYLBsdti5BM6IwtVS8UTOm/GD6cF2u7TjtE68ZEYePsrkvfDw+KKE6fPLhM90
 Lfll9AfFiDWLfPedwfDI2p+IJ8eLufhtBm9BtHZI80KXKBERvvUqf0JVdOa0apBDnlnW 1w== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mb3gse6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 17:25:19 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12ULNCLC014104;
        Tue, 30 Mar 2021 21:25:18 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 37mav9gbwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 21:25:18 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12ULPH6W18678056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:17 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4915C7805C;
        Tue, 30 Mar 2021 21:25:17 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10DFA7805F;
        Tue, 30 Mar 2021 21:25:15 +0000 (GMT)
Received: from LAPTOP-E35P3CCB.rch.stglabs.ibm.com (unknown [9.65.217.212])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Mar 2021 21:25:15 +0000 (GMT)
From:   Brad Warrum <bwarrum@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Steven Royer <seroyer@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] MAINTAINERS: Update entry for ibmvmc driver
Date:   Tue, 30 Mar 2021 16:22:38 -0500
Message-Id: <20210330212238.2747-1-bwarrum@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vago9kDTWCfZYX3cwXsx_cUXQ375olaw
X-Proofpoint-GUID: vago9kDTWCfZYX3cwXsx_cUXQ375olaw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_12:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300154
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Royer has moved on to a different project and has asked
that Ritu and I take over maintainership of the IBM Power
Virtual Management Channel Driver.

Signed-off-by: Brad Warrum <bwarrum@linux.ibm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e91994b8d3b..d9fb56b544c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8544,7 +8544,8 @@ S:	Supported
 F:	drivers/scsi/ibmvscsi/ibmvfc*
 
 IBM Power Virtual Management Channel Driver
-M:	Steven Royer <seroyer@linux.ibm.com>
+M:	Brad Warrum <bwarrum@linux.ibm.com>
+M:	Ritu Agarwal <rituagar@linux.ibm.com>
 S:	Supported
 F:	drivers/misc/ibmvmc.*
 
-- 
2.17.1

