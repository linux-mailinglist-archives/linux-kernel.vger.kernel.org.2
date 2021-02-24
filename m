Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EADF32357C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 02:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhBXBxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 20:53:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49742 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhBXBxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 20:53:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O09aZW165959;
        Wed, 24 Feb 2021 00:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1Nm4A+r1q9ED0EiWm2oomBwoPnodn1I8p67FDM/zLpg=;
 b=UQFS4cLeVtMXetfq/vtbPr2/0v4CAZczmdQcNMPXmtDL4GxmF3uqhLpw06QpIlJGrk18
 o5McATNDz9KI3odT97QczKQmLVU5+CClkQTsd76vUoCVf7lIFjw2xpC3j30NOHCflVlZ
 3ZXPLTEHc/TzLBdR+rftNl0MOBfZEPISLN7TE8JHgDGt9QdY0BgMM09tV6v2dnc04e12
 tWbJYuXowjsGf26cnriRNtpiJKM/6x02GLaTc6a78dMvVCIDlQ/IuZkd7uWi3Q1QD3ep
 8mFf2NtBdqy2iRuamDBc1Tcx79bm6k8E0ccWVzpZ5N/LFvIAZ1cUzIpjqr1FBeQYaOPE dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36tsur19qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 00:27:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O0QAld137156;
        Wed, 24 Feb 2021 00:27:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 36uc6sesd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 00:27:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11O0RSGd024704;
        Wed, 24 Feb 2021 00:27:28 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Feb 2021 16:27:28 -0800
Subject: Re: [PATCH] hugetlb: fix uninitialized subpool pointer
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210223215544.313871-1-mike.kravetz@oracle.com>
 <20210223224540.GB2740@localhost.localdomain>
 <53527e9d-d09b-7287-9f79-ebdbf4e9bc7a@oracle.com>
 <a7f063ea6b5eae4a4fcf038268e3a604@suse.de>
 <ef62ac45-9ec9-2582-3e58-7efc0609221f@oracle.com>
Message-ID: <3590f7a0-854d-04eb-6d73-7b3ef2ac49b5@oracle.com>
Date:   Tue, 23 Feb 2021 16:27:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ef62ac45-9ec9-2582-3e58-7efc0609221f@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240001
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/21 3:21 PM, Mike Kravetz wrote:
> On 2/23/21 2:58 PM, Oscar Salvador wrote:
>> On 2021-02-23 23:55, Mike Kravetz wrote:
>>> Yes, that is the more common case where the once active hugetlb page
>>> will be simply added to the free list via enqueue_huge_page().  This
>>> path does not go through prep_new_huge_page.
>>
>> Right, I see.
>>
>> Thanks
> 
> You got me thinking ...
> When we dynamically allocate gigantic pages via alloc_contig_pages, we
> will not use the buddy allocator.  Therefore, the usual 'page prepping'
> will not take place.  Specifically, I could not find anything in that
> path which clears page->private of the head page.
> Am I missing that somewhere?  If not, then we need to clear that as well
> in prep_compound_gigantic_page.  Or, just clear it in prep_new_huge_page
> to handle any change in assumptions about the buddy allocator.
> 
> This is not something introduced with the recent field shuffling, it
> looks like something that existed for some time.

nm, we do end up calling the same page prepping code (post_alloc_hook)
from alloc_contig_range->isolate_freepages_range.

Just to make sure, I purpously dirtied page->private of every page as it
was being freed.  Gigantic page allocation was just fine, and I even ran
ltp mm tests with this dirtying in place.
-- 
Mike Kravetz
