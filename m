Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8523C5C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 14:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhGLMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 08:42:12 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40661 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230361AbhGLMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 08:42:11 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CCWAMR004125;
        Mon, 12 Jul 2021 14:39:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=/eCSMC2RUgrd+lVsRJOiXmgkxD0dt0fqr8pKy1Y7rHs=;
 b=F1u2yO+vNfMD1XUNE+ehsDr53KID6V6gA7SVIlR3bb+Cw79vLbMgo7cnTYQlfDrcLPjF
 8yZWmm7G/rpdSPrccL4+B9Tyv9063Y/wbNWzH2mOMI6fQjHDqMogR8zp7ONwfm2h6V9/
 yzmr/yad0QC7F6fjze01jF/0sAhL5MbXDU+eZg7kP9epFQMS2nTjdb7FNQt/wwFVJwSj
 wpqRsfxgDzztuJLmk5dDbm1K5zJunFfNulKtqvUJvr+mtIdzjRkT8drW/Gb3o4qsRRU6
 ZnMFPOId8WAxyXQBKsuwtbr2P1mDKR1hkWzEhjyzt5+nd93BZ/gLCqFOQi8AT0IVZKij Sg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39rk1vgw1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 14:39:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6844F10002A;
        Mon, 12 Jul 2021 14:39:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 572E02248B4;
        Mon, 12 Jul 2021 14:39:19 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Jul 2021 14:39:18
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v2] rpmsg: Fix rpmsg_create_ept return when RPMSG config is not defined
Date:   Mon, 12 Jul 2021 14:39:12 +0200
Message-ID: <20210712123912.10672-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_07:2021-07-12,2021-07-12 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a minor fix.

According to the description of the rpmsg_create_ept in rpmsg_core.c
the function should return NULL on error.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---

update from V1:
- add Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
- rebased on kernel V.14-rc1. 

---
 include/linux/rpmsg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index d97dcd049f18..a8dcf8a9ae88 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -231,7 +231,7 @@ static inline struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev
 	/* This shouldn't be possible */
 	WARN_ON(1);
 
-	return ERR_PTR(-ENXIO);
+	return NULL;
 }
 
 static inline int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
-- 
2.17.1

