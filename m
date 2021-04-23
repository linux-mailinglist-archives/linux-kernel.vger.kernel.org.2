Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1EE369B57
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbhDWUeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:34:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43022 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232947AbhDWUeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:34:04 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NKW7pB026382;
        Fri, 23 Apr 2021 20:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=B51HfpieUr/uKWMC6FEGX15kgv6IIUjgFjCP5YV8s0E=;
 b=PtkfYZB25TpjIKekvlRZbpnHkxashaLMf2yn2+eIxwhkeNr3f6YzDqYAR4Vh+MbeIacH
 Jhx431SixwFD5MaoGxJYVGFen+7u8IlZ3TnBoxYwbSIQ1oPjdDuLH0+ZmyUt7Ndd9V7a
 dHnwShLG7y4nJJ31zGPoL8vyMBL/3dxD4lxpuNFzYJ8luj+cfjevIqR/FAkSLARPL5IA
 ANrrUDdiHL1X6uxWbqlbnV+aQMh5OT467OJJ/H6gnzc4AsCdYE/hcCoriOEC6OdR4K3v
 hpwhlUu93wfi6G4yqCUHS4xR8xgdnBlMGdoUoQgFDHSLTWtBRm7di126FNFn5eIWYh0E jA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 383duh8ey6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 20:33:14 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13NKWL5X053590;
        Fri, 23 Apr 2021 20:33:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 383cbfxu8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 20:33:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OywJWHghXS/wrSUqYZ+I9J/4rW2PjoNNm8gsg1S50Jakpq7TuLXq+8kzHMgZi8NaHIZpJvU1CfwNuAuUazDiibyxltCRnV+m3VuHbnDYV9PIZ4ibR4CLmNq53iJpt1YARJRRixkh0BeYVtey/8brhR9YtCZ1MvALFCOFxiMiX82f0zgdsWfIdbvQYYmP3W03Jfr+W6zwxoj8kAf6PBeUEAMtA4IQq8ZkcSVgPz7WTaGBLYF87ksGNl5sdNW4SfBM2ISZn/FOx+gS3QVJVGZkQg1SfGQvrpTWiOvsgOcZ/qFMPHMB8UV+lcDbiH/SnxVyHtpxQ4urXOjPVoGnE2taiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B51HfpieUr/uKWMC6FEGX15kgv6IIUjgFjCP5YV8s0E=;
 b=NORk0VoIZkKum/Rc78pm1NAZpKrs6RpXLBoXqJ3flBM52+nnbuquWDQhaRP2bc5M46Rl3TCy4vKpAG94FmTV9znDYpVfsuJKUoEXG/gTEuzLFzBoYj7Ecqx67YX/k++a3/P2Rz7VlW7cBwa2BNRS8zajzNRmKRb/85BzlnpcCK8Y2Jnwt6r13nFg/wfM+w859Nk8j2bAaKMEmEn0+bt9toOLcyBeqqlafmRDoKknA25wsMipFHh0yK0hbWxpG3v++IUBOosk3/ieY0OwYrSB0f95+Py7DDmptb/onp+cH6eAQeygXfwerd7SiObs/kjr6kQP9Dcn2/v8+ZtAxT3/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B51HfpieUr/uKWMC6FEGX15kgv6IIUjgFjCP5YV8s0E=;
 b=bGb4mZfgLx88Inop5ArCHrLxPgemMTROG3nCJqhpsCNnHJNUkB/w8/ai/v+FbSSx9g34q+7bcfSX44E4oUu3ZDZRimUo/HNYkmU4N9OqZYinEFL8PjfwSdRX4zCzkOVDj/b9E8xOy8ZYKAsmRdpxuCeT4bMIQWm63UjwWS+UJBs=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2615.namprd10.prod.outlook.com (2603:10b6:a02:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Fri, 23 Apr
 2021 20:33:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 20:33:10 +0000
Subject: Re: [PATCH 21/23] hugetlb/userfaultfd: Only drop uffd-wp special pte
 if required
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323005054.35973-1-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <02712955-0552-f82a-0ab8-460d63af3519@oracle.com>
Date:   Fri, 23 Apr 2021 13:33:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210323005054.35973-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0004.namprd10.prod.outlook.com (2603:10b6:301::14)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR10CA0004.namprd10.prod.outlook.com (2603:10b6:301::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Fri, 23 Apr 2021 20:33:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051a1a2f-ac4f-4fe2-f6f8-08d9069702a0
X-MS-TrafficTypeDiagnostic: BYAPR10MB2615:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2615FDF36CA1F15FACB58A74E2459@BYAPR10MB2615.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXPTqGy7KCOFcDkZxFHKfyTmKpfes/hdFQYyOrN6SNhvreUaV3ZCcTFxI3OXOL+fJnfggk3p6NLun692wPlwK29RZnu6Z/tFnIyHMuHjZJB9xT0JEOFUlPFbqHH/pQvckpujw25BC0x/BDgxeMPq9BXHq1D38Pem3PQKI8TSn5vLVeFI0DyzGiB60tQjFmRjRTHo5Rmj2+aR/sbdz1o2ION2TjgcABzpr2E+He5a9lrK5fEpY856QfNwZCKhTUObC5+uQ8Wk60rOOiSWtMzZVqPU/9e2ScdDJugFtV1bax/1xvMO7lPhxbZNiXd+l1PCfOv9p0DRczKd6rUdH683JQY1Xf/AYgPZWYAzNk0lHWDgoY9oJk5Glx6uwNnEXs+APs2SHDZKyjiQN7DBlcD9qeOoTWC6jxv2MZD5WYuDYU3nGp4fzGri7nrojV4mN/qVj8ihQ0Is4ieJd7DOO0N1sgG6Ga2kkw5PtrsgljsrliSgy2WI7hLr35ofT1gp4reU7q8zsWZjoXOZnPDxDkwp4kIIXut4JbjA5teztlyIRlL3g5LNCVBbKtpCWXdakZ2ihqBw8qA2iOS6m3m7MQe5UpoN8bYrLN538ZtLy7zNk7WzSHgG9Bmi9ss4SeiDDykAmnIgb8mCe/d+NK6uEjPuPSikHIfFR4g3jQ2/KoE0HyDU9YK8D+HyI4B6ep0TLU2UR+1NUK8Z0rbDNgfGNwaA/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(16576012)(54906003)(66946007)(2906002)(6486002)(66476007)(66556008)(8936002)(8676002)(316002)(52116002)(5660300002)(4326008)(44832011)(31686004)(36756003)(956004)(31696002)(478600001)(26005)(16526019)(83380400001)(38100700002)(86362001)(186003)(2616005)(7416002)(38350700002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFZlM00yN3R6eVZXYjdTTkp5QmlEeDNmejhsTG55d3ZXWHpFMmJlajE4eVhL?=
 =?utf-8?B?TEloWXpUdTdwWVZDZEJjM1hxREVFK3hIWCtySnBJYnBlZUZZVk9KOFN1N0d5?=
 =?utf-8?B?eE9yNEZ3OXB6NnYrSWtXd2hMeUNSQTlZdG1ZUlh1WklVcjlTRGNJeUgvMDYz?=
 =?utf-8?B?dndMOFlzcTJCVk5IZzdnOTFiZ0RJMS8yeGc3bkxONWlpd3BualdkczZmeFg2?=
 =?utf-8?B?b3hKbTEvaEQvS0Mxbk51RytsZ0pwbGRPYzM1MzVmbkJLcXZOcm9mcGttME4z?=
 =?utf-8?B?ODdSd3RMYUJHc3NHSHhlR09PY3VVSWxXdGVzNVByU1lOeTJ1eWJCOEpnN0Uy?=
 =?utf-8?B?Y21mbGtoQklNNXNMdVFYTWp2USs0WEtpRkNMenJmOTgydSswRHgzTVM3Nk5i?=
 =?utf-8?B?dHJuZkVUcklPY2dESTJTRXdmYTd6WTRNVUxyRE13STd5Vi93VUlBbUpZUUJp?=
 =?utf-8?B?R2pGcnBBU1N5RE1WdXE3SmZRa2xHRUF0dnEvMjQ1VVkrc0VtcEpWN1pFU2xO?=
 =?utf-8?B?WURBT0Y5ajJ3YXpCMTF4RDFydENleG5ucG9FZjE1cTFyOXowdlB3RCtJNmtY?=
 =?utf-8?B?ZDZhMFhvOWc4Ny8wbndEczIvUk9rREtDTnFSQlplaVdya0dFaW9YUFUwbVFE?=
 =?utf-8?B?R28rd2xFLzU5MWhHYlZjTUJBa3BkYTRMM2p6SUt0MVR2ckpxNEs1RVRHWHJK?=
 =?utf-8?B?NVQ4L0I2eTZuaDVUaFBBMEFPOXA3SU1uQVJ5bVdMc1FWNnVjNXUyeVpKTk9o?=
 =?utf-8?B?aXNxdU1CK21rUG5ZNXErdEpmVVVrcEhBV1JuaHNKZ045YVlUMFFHb2dWR3Qw?=
 =?utf-8?B?QmpHVGFmeW1nNnNsSVB3MVpnODdoaktNaHdJaEIzUjVLSVR0Wit1QnJXdytG?=
 =?utf-8?B?VlJ2TDh4TU1hbVF2NWJaK29uOTV6R005WWpaSTNCSTBKa2NuNUtGNkVUZUpy?=
 =?utf-8?B?OWxzbG9jU2JSUGROd2FCKzdXRUgzZ1NtaU5qWmI0THB5Y21RYnpuQXJTZjN4?=
 =?utf-8?B?VWY5dnI3MXIyUWxrdDJ5Y0VBdXBsckhJYkgrQW5sVDFaKzdObisrandHdEIv?=
 =?utf-8?B?cU5qcUU1QWtjQ0Nubi9qOHhZNFRVcUhUZG1VRTFjMExpM2gvVGxEL0FRMkRV?=
 =?utf-8?B?a3h1OHZFYmlRTlVITGcyOXRCMTF2ZnVLbzZTc1FnVkV3b0J3YTFNeUZqdExa?=
 =?utf-8?B?Yy8ybEV6eDBxdHVXQlhuTk1YdlB5Ri9NRTBxVTZYQWlHQjlaZk8yb0d4aExP?=
 =?utf-8?B?N2Y2L0piaGprL0cwbENnWlBHaHNzMzcxL2lFZ0Vzb2MxOWxKQU1QR2ptOEpv?=
 =?utf-8?B?NXJYZ01oNGFNNUtFRmlNc3R0dTUwMFdveUJBTzlmV2J2Y05NTGxkYTB3VGUv?=
 =?utf-8?B?QmltYlMwVWtFR2EvVEFUUFI3NWo2ZERLdm84K3NBaTBGQjErTDQrS3l2eGM0?=
 =?utf-8?B?YjE4ZHpuMjN0NHU2UFlFNExJakZld1VtZkU5eCtFSzhJVXVEK3VPMWtwOHZQ?=
 =?utf-8?B?UkQ2QUNWN2hPNFpXM3l2eEowMFJKR2pYNDdldVZ1dENrSFAxQnE0eTRzS01k?=
 =?utf-8?B?WldadStpbkNLQ050NmhzcU9UaE1OUkFncjF4WUVJRjhraUtVNW5hTkFlY1pz?=
 =?utf-8?B?c2JUNjByOXQ3Z3NEV3NiNlhieFFQdW81ZVo0YWhFUnMzeGdmeTFYOFVQdGx2?=
 =?utf-8?B?VVFqMGVDaHdxbXlIMGNRNDNWeklxOWhmWVlmZ0JEUEVXaUNJNVZBcytZT1lT?=
 =?utf-8?Q?hWycipwftbo2hyc+nT/61vdJRRXKhWuLYmK8moC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051a1a2f-ac4f-4fe2-f6f8-08d9069702a0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 20:33:10.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxfWUHU+xkiLT1LKPkqPBen2cRCTaHHXs0vCn2Xa6qQEz+GvJHw2gSKcJoJwJ08xVuRff8JAzfzPXH3lkK2rPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2615
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9963 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230136
X-Proofpoint-ORIG-GUID: pIr0RXqtGdHLCjjICosj5BAd_-rTfABX
X-Proofpoint-GUID: pIr0RXqtGdHLCjjICosj5BAd_-rTfABX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:50 PM, Peter Xu wrote:
> Just like what we've done with shmem uffd-wp special ptes, we shouldn't drop
> uffd-wp special swap pte for hugetlb too, only if we're going to unmap the
> whole vma, or we're punching a hole with safe locks held.
> 
> For example, remove_inode_hugepages() is safe to drop uffd-wp ptes, because it
> has taken hugetlb fault mutex so that no concurrent page fault would trigger.
> While the call to hugetlb_vmdelete_list() in hugetlbfs_punch_hole() is not
> safe.  That's why the previous call will be with ZAP_FLAG_DROP_FILE_UFFD_WP,
> while the latter one won't be able to.

This commit message is a bit confusing, but the hugetlb hole punch code
path is a bit confusing. :)   How about something like this?

As with  shmem uffd-wp special ptes, only drop the uffd-wp special swap
pte if unmapping an entire vma or synchronized such that faults can not
race with the unmap operation.  This requires passing zap_flags all the
way to the lowest level hugetlb unmap routine: __unmap_hugepage_range.

In general, unmap calls originated in hugetlbfs code will pass the
ZAP_FLAG_DROP_FILE_UFFD_WP flag as synchronization is in place to prevent
faults.  The exception is hole punch which will first unmap without any
synchronization.  Later when hole punch actually removes the page from
the file, it will check to see if there was a subsequent fault and if
so take the hugetlb fault mutex while unmapping again.  This second
unmap will pass in ZAP_FLAG_DROP_FILE_UFFD_WP.

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/hugetlbfs/inode.c    | 15 +++++++++------
>  include/linux/hugetlb.h | 13 ++++++++-----
>  mm/hugetlb.c            | 27 +++++++++++++++++++++------
>  mm/memory.c             |  5 ++++-
>  4 files changed, 42 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index d81f52b87bd7..5fe19e801a2b 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -399,7 +399,8 @@ static void remove_huge_page(struct page *page)
>  }
>  
>  static void
> -hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
> +hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
> +		      unsigned long zap_flags)
>  {
>  	struct vm_area_struct *vma;
>  
> @@ -432,7 +433,7 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
>  		}
>  
>  		unmap_hugepage_range(vma, vma->vm_start + v_offset, v_end,
> -									NULL);
> +				     NULL, zap_flags);
>  	}
>  }
>  
> @@ -513,7 +514,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  				mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  				hugetlb_vmdelete_list(&mapping->i_mmap,
>  					index * pages_per_huge_page(h),
> -					(index + 1) * pages_per_huge_page(h));
> +					(index + 1) * pages_per_huge_page(h),
> +					ZAP_FLAG_DROP_FILE_UFFD_WP);
>  				i_mmap_unlock_write(mapping);
>  			}
>  
> @@ -579,7 +581,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
>  	i_mmap_lock_write(mapping);
>  	i_size_write(inode, offset);
>  	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
> -		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
> +		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
> +				      ZAP_FLAG_DROP_FILE_UFFD_WP);
>  	i_mmap_unlock_write(mapping);
>  	remove_inode_hugepages(inode, offset, LLONG_MAX);
>  }
> @@ -612,8 +615,8 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  		i_mmap_lock_write(mapping);
>  		if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
>  			hugetlb_vmdelete_list(&mapping->i_mmap,
> -						hole_start >> PAGE_SHIFT,
> -						hole_end  >> PAGE_SHIFT);
> +					      hole_start >> PAGE_SHIFT,
> +					      hole_end >> PAGE_SHIFT, 0);
>  		i_mmap_unlock_write(mapping);
>  		remove_inode_hugepages(inode, hole_start, hole_end);
>  		inode_unlock(inode);
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 92710600596e..4047fa042782 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -121,14 +121,15 @@ long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>  			 unsigned long *, unsigned long *, long, unsigned int,
>  			 int *);
>  void unmap_hugepage_range(struct vm_area_struct *,
> -			  unsigned long, unsigned long, struct page *);
> +			  unsigned long, unsigned long, struct page *,
> +			  unsigned long);
>  void __unmap_hugepage_range_final(struct mmu_gather *tlb,
>  			  struct vm_area_struct *vma,
>  			  unsigned long start, unsigned long end,
> -			  struct page *ref_page);
> +			  struct page *ref_page, unsigned long zap_flags);
>  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  				unsigned long start, unsigned long end,
> -				struct page *ref_page);
> +				struct page *ref_page, unsigned long zap_flags);

Nothing introduced with your patch, but it seems __unmap_hugepage_range_final
does not need to be in the header and can be static in hugetlb.c.

Everything else looks good,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
