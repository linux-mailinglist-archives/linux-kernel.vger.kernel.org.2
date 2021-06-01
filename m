Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D677397044
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhFAJ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:26:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53478 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233096AbhFAJ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:26:10 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1519DlsP002560;
        Tue, 1 Jun 2021 09:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=jN7+gUrA4PoLPxt0TxmBGmGW1ZJ+sWOMQa5ojP8FOLI=;
 b=YJz5eTlNAe93Y94xSW5Ggx6Hh3SGqyCLfHQwcmzOeGNRWCbz2RLtTCPV0snHxX3bM9yH
 MBp9U2cm7kNRD26BZQuU05C88ZXXU7KTQeC/inXuvT5CaLPP2BAzUR3EWChn+BLgGZr9
 owz5zuNGtVCXRenFGuhFBPB2h5XurqhTTPuiHRHd8MXbK/U/4Z9iC/7eXqOngko6rHX0
 QegeB8NGAVsbpnagN8fDUwdmdX5oqCtE7CZyRWzAzOo9XoKROjcGdbtoHpxBByvs5p1b
 cex1L8r4yWmaKpkh5xXRY6h+kzh3MWM+QQHC05i45nfUydj60AsASzaN/3iZhSEOQY/T /g== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38vpk2gg3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:24:22 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 1519HTHJ029745;
        Tue, 1 Jun 2021 09:24:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38uaqw62nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:24:21 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1519OKuB041457;
        Tue, 1 Jun 2021 09:24:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 38uaqw62nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:24:20 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1519OJRp012577;
        Tue, 1 Jun 2021 09:24:19 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Jun 2021 02:24:18 -0700
Date:   Tue, 1 Jun 2021 12:24:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>
Cc:     Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mm: thp: fix a double unlock bug
Message-ID: <YLX8uYN01JmfLnlK@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: 5FwNM0G1IyYbJRtmC7W_AiVNZk2TJwOt
X-Proofpoint-ORIG-GUID: 5FwNM0G1IyYbJRtmC7W_AiVNZk2TJwOt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're supposed to be holding the "vmf->ptl" spin_lock when we goto
out_map.  The lock is dropped after if finishes cleaning up.

Fixes: 9aff7b33c74a ("mm: thp: refactor NUMA fault handling")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 mm/huge_memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e353bbc6cee3..caa0148f15bb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1465,10 +1465,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
 	page = vm_normal_page_pmd(vma, haddr, pmd);
-	if (!page) {
-		spin_unlock(vmf->ptl);
+	if (!page)
 		goto out_map;
-	}
 
 	/* See similar comment in do_numa_page for explanation */
 	if (!was_writable)
-- 
2.30.2

