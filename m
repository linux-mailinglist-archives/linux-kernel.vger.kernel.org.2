Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30B7397050
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhFAJ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:27:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52576 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhFAJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:27:49 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15199CmN126927;
        Tue, 1 Jun 2021 09:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=wwB4VSUvKdGzhu1xJP6jPOcXCgeh115bhoXsbDIkYts=;
 b=kUAZg7E56EW/JNy5ngfcQUNwrba4Vh/MJPSxBA2rKyLD1seXq+aBtZ3X44pLbndf+AeT
 7CWbzXlRbwv0XjXL49uOnuS81piQBplQadsUEqwt7+eMJn8bI6YFAy0l9JO3P85niLYj
 PHUzuFDyscIZ6JNyQlItv9QpYKpPL5Z6BBULAmVkcKqzomrOmaxEj/xZx7KY7EUWPYX7
 U5CIroogBen9b3zIWvulPKGjIdNZBCC3yQO4WRhVji57MOJc3tlFRlLEEfytBhFr4wvv
 4161kAVZS2VRUEDMhLmAlHOm24ipXFQwrUc4Uo+49gfFw2kIN1pRHsdJOLK4HH1tsQTO Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38ub4cmygw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:25:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1519AbLR057280;
        Tue, 1 Jun 2021 09:25:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38uycr45yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:25:52 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1519NOV9084577;
        Tue, 1 Jun 2021 09:25:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 38uycr45xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:25:52 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1519Pp8o020050;
        Tue, 1 Jun 2021 09:25:51 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Jun 2021 09:25:50 +0000
Date:   Tue, 1 Jun 2021 12:25:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mm: hugetlb: checking for IS_ERR() instead of NULL
Message-ID: <YLX9FCOU0Il8Ejoy@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: xyYXQHqPAUI61IN86pE8ylRfcFXBAwHi
X-Proofpoint-ORIG-GUID: xyYXQHqPAUI61IN86pE8ylRfcFXBAwHi
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10001 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alloc_migrate_huge_page() doesn't return error pointers, it returns
NULL.

Fixes: ab45bc8b5910 ("mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 69a4b551c157..3221c94b4749 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5103,7 +5103,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			 */
 			page = alloc_migrate_huge_page(h, gfp_mask, node,
 						       nodemask);
-			if (IS_ERR(page)) {
+			if (!page) {
 				ret = -ENOMEM;
 				goto out;
 			}
-- 
2.30.2

