Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2267F4134DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhIUNym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:54:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10144 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233182AbhIUNyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:54:41 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LD9YrJ023358;
        Tue, 21 Sep 2021 09:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=EJG/CDR2q0qBio4xJw4+XDBGA3e1T+kZ2BhtujGohqU=;
 b=OX47MZyfEe9bVM9MFKxv1s8QvdvY9iRkSnhg7UaPio8SgRbfMlzowlLYIfqDDKg8GyiZ
 SJxBGXzpCHdfgDE0g1mnML4KOZy7vRSoobS4PRyjT1USwlNKQA6we01zkJAuvUhOln5M
 Ed0lIUS7YhyO1vVv+1uzUmjD68vnSq6wwUWIVa37HFiQ4MTcvBg1Sa6vvw8aGUEmEMJ8
 o+pywtQrWcFQOWoPJtYD8b683NjE3UOt6eFENw7Ru7h10AghCDFAPAvv1Uc8ZaZIzRGF
 3Z5+tEO4SK2B+Bngq6E09bHJK+/h+31H7rfxFOePmm/TNjkVP7dcmbGcesLTkTUQRCK4 Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b7f69ambd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 09:52:57 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18LDAOIt028826;
        Tue, 21 Sep 2021 09:52:56 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b7f69amax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 09:52:56 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18LDhBiV006104;
        Tue, 21 Sep 2021 13:52:55 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3b57rax7u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 13:52:55 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18LDqspB39911842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:52:54 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46EC8AE06A;
        Tue, 21 Sep 2021 13:52:54 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 321D7AE068;
        Tue, 21 Sep 2021 13:52:50 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.82.215])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 21 Sep 2021 13:52:49 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 5/8] hugetlb: document the demote sysfs interfaces
In-Reply-To: <20210816224953.157796-6-mike.kravetz@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816224953.157796-6-mike.kravetz@oracle.com>
Date:   Tue, 21 Sep 2021 19:22:47 +0530
Message-ID: <87bl4m9gsw.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0k0bnVnbB0LS0_TUvr9DncwHIw4HtLCL
X-Proofpoint-ORIG-GUID: LaEMchr76khInJAkdHFxfn6RVNsPRWY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_01,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> Describe demote and demote_size interfaces.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst | 29 ++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 8abaeb144e44..902059a0257b 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -234,8 +234,12 @@ will exist, of the form::
>  
>  	hugepages-${size}kB
>  
> -Inside each of these directories, the same set of files will exist::
> +Inside each of these directories, the set of files contained in ``/proc``
> +will exist.  In addition, two additional interfaces for demoting huge
> +pages will exist::
>  
> +        demote
> +        demote_size
>  	nr_hugepages
>  	nr_hugepages_mempolicy
>  	nr_overcommit_hugepages
> @@ -243,7 +247,28 @@ Inside each of these directories, the same set of files will exist::
>  	resv_hugepages
>  	surplus_hugepages
>  
> -which function as described above for the default huge page-sized case.
> +The demote interfaces provide the ability to split a huge page into
> +smaller huge pages.  For example, the x86 architecture supports both
> +1GB and 2MB huge pages sizes.  A 1GB huge page can be split into 512
> +2MB huge pages.  The demote interfaces are:
> +
> +demote_size
> +        is the size of demoted pages.  When a page is demoted a corresponding
> +        number of huge pages of demote_size will be created.  For huge pages
> +        of the smallest supported size (2MB on x86), demote_size will be the
> +        system page size (PAGE_SIZE).  If demote_size is the system page size
> +        then demoting a page will simply free the huge page.  demote_size is
> +        a read only interface.

That is an alternate interface for nr_hugepages. Will it be better to
return EINVAL on write to 'demote' file below
/sys/kernel/mm/hugepages/hugepages-2048kB ?

Or may be not expose demote possibility within 2M hugepage directory at all?


> +
> +demote
> +        is used to demote a number of huge pages.  A user with root privileges
> +        can write to this file.  It may not be possible to demote the
> +        requested number of huge pages.  To determine how many pages were
> +        actually demoted, compare the value of nr_hugepages before and after
> +        writing to the demote interface.  demote is a write only interface.
> +
> +The interfaces which are the same as in ``/proc`` function as described
> +above for the default huge page-sized case.
>  
>  .. _mem_policy_and_hp_alloc:
>  
> -- 
> 2.31.1
