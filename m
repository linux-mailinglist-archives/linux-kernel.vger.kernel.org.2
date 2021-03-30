Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6834EABE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhC3Ong (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:43:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231694AbhC3Onc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:43:32 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UEYwbm088116;
        Tue, 30 Mar 2021 10:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=3iqNoGVDnaPAnvYDi/Xp7QrkNPfusFwyKyE3eCYTBbo=;
 b=QcvSGFhqLLypYLzoJCYN3mhH0vD34+aZv9rcQiZ5tn9sJNZrgG51mz3QOj8c5KGthAOD
 Az3WPvR90TaR8yrqaFNFPpIJBaDD3/m3M4VZsp2wSXDkjXzkUZUvuC3KfKWjmTXTYpN4
 fZsZ2LwwrGLcbkyxp4UHIij+vUBadIhadrJKndV+negGl453Ravq4FcCrcU5M9RVmfgj
 JB7P+NdGmlhPOIkCjDoEEYSWCsF0youa2JPo1FfD3yhmQSjS4HE5jf1TdfI/8/a+bFBM
 9ukYc7d91MIcMMkELmS6szdUKfZg1yl94Lt0idISEmNB2EbW3azhCXd0hOM9C1nRZlYL Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhssv37d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 10:42:15 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12UEZH0M090959;
        Tue, 30 Mar 2021 10:42:14 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhssv362-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 10:42:14 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UEb1t8020052;
        Tue, 30 Mar 2021 14:42:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 37huyh9g7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 14:42:12 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UEg9LW43909432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 14:42:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FF2BA406B;
        Tue, 30 Mar 2021 14:42:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF9DEA4059;
        Tue, 30 Mar 2021 14:42:08 +0000 (GMT)
Received: from thinkpad (unknown [9.171.41.230])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 30 Mar 2021 14:42:08 +0000 (GMT)
Date:   Tue, 30 Mar 2021 16:42:07 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 5/6] mm: migrate: don't split THP for misplaced NUMA
 page
Message-ID: <20210330164207.3a2826f7@thinkpad>
In-Reply-To: <20210329183312.178266-6-shy828301@gmail.com>
References: <20210329183312.178266-1-shy828301@gmail.com>
        <20210329183312.178266-6-shy828301@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GTLsRE-t3jKQmmrgEXa1bXyawU1Xg_HM
X-Proofpoint-ORIG-GUID: QA4EJPs-o2GZJ_Ndz7oaZ4WGu5lBPCKq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_04:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 11:33:11 -0700
Yang Shi <shy828301@gmail.com> wrote:

> The old behavior didn't split THP if migration is failed due to lack of
> memory on the target node.  But the THP migration does split THP, so keep
> the old behavior for misplaced NUMA page migration.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/migrate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 86325c750c14..1c0c873375ab 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1444,6 +1444,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	int swapwrite = current->flags & PF_SWAPWRITE;
>  	int rc, nr_subpages;
>  	LIST_HEAD(ret_pages);
> +	bool nosplit = (reason == MR_NUMA_MISPLACED);
>  
>  	if (!swapwrite)
>  		current->flags |= PF_SWAPWRITE;
> @@ -1495,7 +1496,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  			 */
>  			case -ENOSYS:
>  				/* THP migration is unsupported */
> -				if (is_thp) {
> +				if (is_thp && !nosplit) {

This is the "THP migration is unsupported" case, but according to your
description you rather want to change the -ENOMEM case?

Could this be the correct place to trigger THP split for NUMA balancing,
for architectures not supporting THP migration, like s390?

Do I understand it correctly that this change (for -ENOSYS) would
result in always failed THP migrations during NUMA balancing, if THP
migration was not supported?
