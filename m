Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E343587A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhDHO5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:57:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12792 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231679AbhDHO5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:57:05 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138EtpHQ112362;
        Thu, 8 Apr 2021 10:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=/zh21pqJzqg68Qk5Jdx/atCUW7Qt9NnkRuCC5o2j3xs=;
 b=joteoyNCX5ogdYnNZV4j661oSPb2snooGjNcfIbRI3EOXAKHlZrlI+32QBTPg3wuhka3
 0mOWm7iI5mXRTQHCLse8zt1UD/pyFdyFGw8bOIvhlascQ4YuWTRMaaaCwwqCyoxqql3D
 xxtJMI6Pcr+4O/78Bv5Fdh/C1ZGcV1HDfjykdOpE0C9j0n3eXkXbcn/Du4Gn5wZhRv30
 Mc50CdRXBwAPtrqnoZBV31D9jlSDnY0ZBF2a2qBdvU7b2waY0SM0Ym+guy/3FbPj5Qne
 Jk0M/rZAL3CoLLAPScxn1E4nrRvznf0fLopJArBhTcLvZ+HPHDLSt4efu6n5IZUlMnur 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvmgmq47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 10:56:15 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 138Eu84o113636;
        Thu, 8 Apr 2021 10:56:08 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvmgmpkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 10:56:08 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138EgVpo010511;
        Thu, 8 Apr 2021 14:55:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 37rvc5gw93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 14:55:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138EtIhQ57606526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 14:55:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CD3542042;
        Thu,  8 Apr 2021 14:55:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E681442045;
        Thu,  8 Apr 2021 14:55:17 +0000 (GMT)
Received: from localhost (unknown [9.85.70.102])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Apr 2021 14:55:17 +0000 (GMT)
Date:   Thu, 8 Apr 2021 20:25:17 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        willy@infradead.org, minchan@kernel.org, richard.weiyang@gmail.com,
        ying.huang@intel.com, hughd@google.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/5] close various race windows for swap
Message-ID: <20210408145517.jqodfz6cmm4wwk7g@riteshh-domain>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408130820.48233-1-linmiaohe@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AUM94jp9j7OwTyd4YdJfeM5VnUtO03bb
X-Proofpoint-ORIG-GUID: DRV0DWS22U1rM_oJc_MQdIWorN1hloc-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_03:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104080102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/08 09:08AM, Miaohe Lin wrote:
> Hi all,
> When I was investigating the swap code, I found some possible race
> windows. This series aims to fix all these races. But using current
> get/put_swap_device() to guard against concurrent swapoff for
> swap_readpage() looks terrible because swap_readpage() may take really
> long time. And to reduce the performance overhead on the hot-path as
> much as possible, it appears we can use the percpu_ref to close this
> race window(as suggested by Huang, Ying). The patch 1 adds percpu_ref
> support for swap and the rest of the patches use this to close various
> race windows. More details can be found in the respective changelogs.
> Thanks!
>
> Miaohe Lin (5):
>   mm/swapfile: add percpu_ref support for swap
>   swap: fix do_swap_page() race with swapoff
>   mm/swap_state: fix get_shadow_from_swap_cache() race with swapoff
>   mm/swap_state: fix potential faulted in race in swap_ra_info()
>   mm/swap_state: fix swap_cluster_readahead() race with swapoff

Somehow I see Patch-1 and Patch-2 are missing on linux-mm[1].
Also I wanted to ask if you have a way to trigger this in a more controlled
environment (consistently)?

[1]: https://patchwork.kernel.org/project/linux-mm/cover/20210408130820.48233-1-linmiaohe@huawei.com/

-ritesh

>
>  include/linux/swap.h |  4 +++-
>  mm/memory.c          | 10 +++++++++
>  mm/swap_state.c      | 33 +++++++++++++++++++++--------
>  mm/swapfile.c        | 50 +++++++++++++++++++++++++++-----------------
>  4 files changed, 68 insertions(+), 29 deletions(-)
>
> --
> 2.19.1
>
>
