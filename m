Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCFE38995E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhESWd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:33:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36006 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhESWd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:33:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JMUr30006197;
        Wed, 19 May 2021 22:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lxVHWrJp+EOOkXcqzPE4WmJyKvsqUemoTKoAUiZrg/g=;
 b=a+PT/B4QqqH3Ia719POmsW4Z4rh258/8zbscrqNURazqe5b98+99Gmn8SNp85MO8DVi8
 Lk3PUkMias34OV4s1r1fdxfK4GU/9N29jyyDebfi3TmAgZbldETiKJZMNW63o80LFYLG
 U+A9Bxv7lFFCKqyJhvF79lxR6bu+g60PxtHWygOVJLzCeb0OaTvKl/ZzK2LVrJIURw8u
 v/CdB0l6Hcbe8X2FdghqOr18LqAbIDQATAw3vBxRS0xK5MX9PoKCq11nWPS3/GX9DZtY
 cjACUFGXzdtd+qE2oDXiVxT6Ol3aOYn5MpzM3W5b86dFKfN99FQAj4nY2qIK9kK82xqI +w== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38ktd2h5x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 22:32:25 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14JMWNqK121411;
        Wed, 19 May 2021 22:32:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 38megkv9h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 22:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhfoPMCGwiDkY5DbGForiIBSZo2WHqx1PYK6phvccc1xfNu0LbgNmL2mcXKGwVNlt4C/UAjaDaVn04U+TTGnk/KJ2KJoDfevVmGv/gLomnKlyGCqzJSXjv14PY/A4wo71Qj5uGpkVeulPGpFGi9pKQ41a549d/yJacFL38o3rXGKZi+a514ia0aoSdikaFmIAsdHUblAyOB7F6/Js1Uo7KSMDsDo+4o+jynqtCuh2EzngdK9oTSDrOARHTMYsWpTl3iBEddMhq9YbbIkKUNwPfK/r1936Pi2t/Aa+V2eiYbIvoCR0cMXRhc8tB64k03RCIsKiG76PNUxQn5tZekcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxVHWrJp+EOOkXcqzPE4WmJyKvsqUemoTKoAUiZrg/g=;
 b=HJGx4HkOlP0jujIdapJ7XAdwEnPD6HgTH1PKoCx0pcLlEGis+oyQPg/0JAC3uFtxb5o0LcwJMVVKcEVJGsLl5Z08f0DuA3uvVfirTISsCeNXRysFixh4ELXTO3sUVqbg4rEcUQkbmh9O4JxPbx1INlFrhzzgxRHxUuERnGB1+sn4Kj3W2EMEyhgD9wHRUlCN1HzwvIaKkjCeyQsCAEg6z3lRB2Ie+9s8Bs7v1/36R8FQIP/KNnFv2hnAlbbMPpE3Rt0aJQyOIYw+lEBUK8frHfS7oVjybHvnyZM/ovWNh9eQQ3Iz7FY8qMi5MY0QJnj8cJoMAYCCuJm/LOe7TLzzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxVHWrJp+EOOkXcqzPE4WmJyKvsqUemoTKoAUiZrg/g=;
 b=oq/V6uLRSqIeLxppGM0Rvh/ZSEJmv96CF/lHZVufuqJS28xWuX4Du0v1QAZVBv78OumWQtUMWrhSDOeopiK15ritFlkx0JwI1mTRpwfSKRuXqL8p5ONzuCPyCD8aX1OF1csp/GhbdZG8sxusPS00quWjMafxjW+3gNjciGIWMoU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2614.namprd10.prod.outlook.com (2603:10b6:a02:b0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 19 May
 2021 22:32:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 22:32:21 +0000
Subject: Re: [PATCH v5 1/2] mm,hwpoison: fix race with hugetlb page allocation
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210518231259.2553203-1-nao.horiguchi@gmail.com>
 <20210518231259.2553203-2-nao.horiguchi@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d78f430c-2390-2a5f-564a-e20e0ba6b26a@oracle.com>
Date:   Wed, 19 May 2021 15:32:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210518231259.2553203-2-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:303:8f::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0026.namprd03.prod.outlook.com (2603:10b6:303:8f::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 22:32:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf630e7-4780-46bb-daee-08d91b15f75e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2614:
X-Microsoft-Antispam-PRVS: <BYAPR10MB26146430692CFBFBF7032B6BE22B9@BYAPR10MB2614.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70X6ryB2No/7CqfO74VwAbhI2P2Du5ZFTzvyrA2+a14NtE+0BXCI0Z9VLe21S5vRBMxuYmykzsLVVYciOTG0aDLI1RyChixC1zb9awflOqR/TU29/9T2BQojoiZapeYKitk4j4XheCoVJdZAakpkQ4L8DLAXkXX7oHPfBdVTQUd6T/xPhjTFzo2cZHBnEuQDzNg8fDLCVQk7/UAvma2V5+ov/UJ/OTJqOsSbVHb2tKLGte6TRgpKuJ+DOarixx/C0o5im4+aOxxKufqEFJ9X/3SQKUOHQQgHGa4pWgIdqRWcF1UwzlGa3bQTcTCySVFLur86NqmSdTXQ9mgnEQOTp2Xo1Hy69TMOtuWiKv7WbGr+Oo38ZW59UYq1cnJ/w1cFT20QD1DREdxjd1lDswxgogmFtmvkhKzqpEj0uhji6TwOblaE2YIQpVllid0N6RJDr7DqVFc9fWYXqO9lFnu+R1uiCFMFBb/guZTfDw/MY6izF+I9/Db9n0o/BxockIe7Mv2+w7cb6Q3Rn+Zyn+YJBx69Z9lqq/T58Y8FBsPONq9/JYvcL3yNmMtSFwUo4bgo2Nsw4kyOObIPz8n8tSVO667nvqArsRHT2av8VJ1pxIB41Rwb3Nd4gavOPPUiBHU2Pd94ZAKulofP6svj9ggOJ+VUQJOwHiuQJuYo+LrdEp3meDiO7ZZZY8QZolKaZ1zd4XQ0O8phkM3Ce/2QstVv9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(136003)(346002)(66946007)(66556008)(66476007)(316002)(36756003)(2616005)(956004)(44832011)(8676002)(31686004)(8936002)(26005)(2906002)(16526019)(478600001)(186003)(31696002)(6666004)(86362001)(53546011)(38100700002)(4326008)(110136005)(38350700002)(5660300002)(52116002)(54906003)(83380400001)(16576012)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y245TnVZWThMM2lrUlRCREk3S2tYbVM1dDhiSTFXZnlzNXhyYlQ3OFJ3TmY5?=
 =?utf-8?B?Ym9YYnpOMW43amF4OXFQZkltVitIek9CUVFYTURJamZuSkdvNUl1YWFVNGxM?=
 =?utf-8?B?OTM5SVR1dG9tc0txNFdoN3l6eEhjNWxyaXE5YlB4bU8xaUxpWjJwbks0MVQx?=
 =?utf-8?B?bjg4WlZJb2NaeGhyK3AwYWxUUG5OekNCZ29hMExDTTkvTnVUOHk0bzJrS0kw?=
 =?utf-8?B?Y0ZPSlN5bVhWalN5bkJNdy82bm5xMURKWVlCZmQzZCtwSmhJZkV5TWVkL1Nl?=
 =?utf-8?B?WFBGS0MwY2dPNFN0eHd4VDhYanBKNDBZOU1jdjBtNm1aeDVxVkhFT3dlQlRw?=
 =?utf-8?B?QnZmczBkMlA2cGRMdDdOeTlZMHNqbmpVT3J5Y3JBc05WMk5EdFFnQjdReHR3?=
 =?utf-8?B?Z3BCQ01acHRPaXVaeURkYTFUUjEyMjRBN1JTcXFEcUV6VXFMMzhlMnpLRlBk?=
 =?utf-8?B?ejZuejNKR0JNbEpVcnVWaW1USWZhbHJYbVNsQThuaGxtcW5TT3JHSmRiaE1G?=
 =?utf-8?B?QWJOTGZiQXdaQmJBdE5yU0VhS2VZK2pwbkcyYUNCbWV5SXpSMWlZWnEraHhm?=
 =?utf-8?B?N05HbkRlc3VUTDdBbk8xZVZzKytuajFORWp5L05zYWlwdnl1eUNPSEpZSkdq?=
 =?utf-8?B?azBoQ3g5M01sT2NlV3RTbWswM1o1RVZJYWZlMFQ5NS9Rb054dkhkVmkyUVI3?=
 =?utf-8?B?QS9TT05QdDdDejcxWEpBYzdIeGpudEtqTXpqaFlTVXBhb2tUMmk3K0JxeVl3?=
 =?utf-8?B?clpqbzZESjlVaE5YN0JFS1NkTnhWekxNcFRhWW83bnQwc3BoLzZsM3BqU3Vm?=
 =?utf-8?B?WFNlTTl6bkY1QlcwOHpwOXlFenkxZ1ZpRWZSMjJIa0JZRnZJdW5yOWtWTHJG?=
 =?utf-8?B?WWJzRnJ1VlJBZWIwQyt3Q3U4VERCQ0hOZFl2cDQxL2w4WXd5ckJuVUh2eW4v?=
 =?utf-8?B?UVJ4RHJrNC9aYmFGVzRPYS96TENObVZVUGJCc1RpWmdFVktjU2s2bDlMYXFj?=
 =?utf-8?B?RmdOTjdoL0JXZmR0YUNLRXE3L0NxUGlkUzJJY3ZQWlNSVE9mSThMNm5WRHVZ?=
 =?utf-8?B?OVZrN0ZTc2c2VGdYUTNxRlUyR2hxd2pYOGdTeW02Tk50Nm5Nc3NEdUQ0aHRS?=
 =?utf-8?B?a05GUUlsMncwZmhzVERQWFViUjczZUpLb0JhVXJJVkxBaVcrQkpwQ2sxZFY2?=
 =?utf-8?B?eklwWHhUaXJHOUtGTjUxTXcrMTJyT1JLUXJiVUNaS1RmLzRoK1VWVzh6Nkxm?=
 =?utf-8?B?YlphY3c0YnVEdDdZcUFMaEFJeDE4aFNieUxQd1FxTzdoR0NLMFp2YjhoQ0lY?=
 =?utf-8?B?TldvWDI5WmRCcC9DRDRvNkNheVN4N1hyQmZ2Z1FJRTdic21uSVVLZmNrM3Ux?=
 =?utf-8?B?bVpPeUs2TnlXcVlrZWlGdjFUUkdvOFJwNjQzRms5ZzF1MnJqVkliK0xPOTVu?=
 =?utf-8?B?WDc2V0lXMEpST2pBZEVhVlYxdndlNm9LdkdIRkkyRTUzME44RjlXM3Q2MW5K?=
 =?utf-8?B?U1Uzb3lPWWVpUjdnRDl5YUs5ZndXZWR6R0pXVUVoQ09qRnRxKzdKdWQraXg1?=
 =?utf-8?B?ZERVV3RyRXJORTFFU05hY2IzbDNqQWlPbUpHVUcwbGZsbUhQcWgrWWZkQTRC?=
 =?utf-8?B?N1M5NHVCdkZ2NHNRTThFc0M1ZjlRMFBkN3BxOUc2N1k5WXZPUjQ1eWx2Rm9B?=
 =?utf-8?B?UldoM1phNStLMkdId0t3YURxdG1OVVBhSHY3clUzSHVtakV2MWZGd2krSXZm?=
 =?utf-8?Q?k2rD6/mwQkuvhHoELjTXmsALqYmxS27+SVRZ8c3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf630e7-4780-46bb-daee-08d91b15f75e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 22:32:21.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtfvdeLpEfNLy+NpReEkrWa7zV3c7oZ40hshimWNgO2kFmV1b1TD7UyMnJPuawcQY7T8Zy1u+vQM0+n4EnOeOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2614
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9989 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190137
X-Proofpoint-GUID: nQRzL5QkRwgTrfiM6lbjzQ-WB1UJfrKo
X-Proofpoint-ORIG-GUID: nQRzL5QkRwgTrfiM6lbjzQ-WB1UJfrKo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 4:12 PM, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When hugetlb page fault (under overcommitting situation) and
> memory_failure() race, VM_BUG_ON_PAGE() is triggered by the following race:
> 
>     CPU0:                           CPU1:
> 
>                                     gather_surplus_pages()
>                                       page = alloc_surplus_huge_page()
>     memory_failure_hugetlb()
>       get_hwpoison_page(page)
>         __get_hwpoison_page(page)
>           get_page_unless_zero(page)
>                                       zero = put_page_testzero(page)
>                                       VM_BUG_ON_PAGE(!zero, page)
>                                       enqueue_huge_page(h, page)
>       put_page(page)
> 
> __get_hwpoison_page() only checks the page refcount before taking an
> additional one for memory error handling, which is wrong because there's
> a time window where compound pages have non-zero refcount during
> initialization.  So make __get_hwpoison_page() check page status a bit
> more for hugetlb pages.
> 
> Fixes: ead07f6a867b ("mm/memory-failure: introduce get_hwpoison_page() for consistent refcount handling")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Cc: stable@vger.kernel.org # 5.12+
> ---
>  include/linux/hugetlb.h |  6 ++++++
>  mm/hugetlb.c            | 15 +++++++++++++++
>  mm/memory-failure.c     |  8 +++++++-
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git v5.13-rc2/include/linux/hugetlb.h v5.13-rc2_patched/include/linux/hugetlb.h
> index b92f25ccef58..790ae618548d 100644
> --- v5.13-rc2/include/linux/hugetlb.h
> +++ v5.13-rc2_patched/include/linux/hugetlb.h
> @@ -149,6 +149,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
>  long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  						long freed);
>  bool isolate_huge_page(struct page *page, struct list_head *list);
> +int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
>  void putback_active_hugepage(struct page *page);
>  void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
>  void free_huge_page(struct page *page);
> @@ -339,6 +340,11 @@ static inline bool isolate_huge_page(struct page *page, struct list_head *list)
>  	return false;
>  }
>  
> +static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
> +{
> +	return 0;
> +}
> +
>  static inline void putback_active_hugepage(struct page *page)
>  {
>  }
> diff --git v5.13-rc2/mm/hugetlb.c v5.13-rc2_patched/mm/hugetlb.c
> index 95918f410c0f..f138bae3e302 100644
> --- v5.13-rc2/mm/hugetlb.c
> +++ v5.13-rc2_patched/mm/hugetlb.c
> @@ -5847,6 +5847,21 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
>  	return ret;
>  }
>  
> +int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
> +{
> +	int ret = 0;
> +
> +	*hugetlb = false;
> +	spin_lock_irq(&hugetlb_lock);
> +	if (PageHeadHuge(page)) {
> +		*hugetlb = true;
> +		if (HPageFreed(page) || HPageMigratable(page))
> +			ret = get_page_unless_zero(page);
> +	}
> +	spin_unlock_irq(&hugetlb_lock);
> +	return ret;
> +}
> +
>  void putback_active_hugepage(struct page *page)
>  {
>  	spin_lock_irq(&hugetlb_lock);
> diff --git v5.13-rc2/mm/memory-failure.c v5.13-rc2_patched/mm/memory-failure.c
> index 85ad98c00fd9..353c6177e489 100644
> --- v5.13-rc2/mm/memory-failure.c
> +++ v5.13-rc2_patched/mm/memory-failure.c
> @@ -959,8 +959,14 @@ static int page_action(struct page_state *ps, struct page *p,
>  static int __get_hwpoison_page(struct page *page)
>  {
>  	struct page *head = compound_head(page);
> +	int ret = 0;
> +	bool hugetlb = false;
> +
> +	ret = get_hwpoison_huge_page(head, &hugetlb);
> +	if (hugetlb)
> +		return ret;
>  

Hello Naoya,

Thanks for your continued efforts.  However, I believe the race still
exists.  Unless I am mistaken, it is possible that page is in the hugetlb
allocation patch and racing with __get_hwpoison_page() as follows:

    CPU0:                           CPU1:

                                    gather_surplus_pages()
                                      page = alloc_surplus_huge_page()
				      	page = alloc_fresh_huge_page()
				      	  page = alloc_buddy_huge_page()
    memory_failure_hugetlb()
      get_hwpoison_page(page)
        __get_hwpoison_page(page)
	  get_hwpoison_huge_page()
	    /* Note that PageHuge()
	       is false, so hugetlb
	       not set */
	  PageTransHuge(head) false
					  prep_new_huge_page(page)
					  /* Now PageHuge() becomes true */
          get_page_unless_zero(page)

I am not sure if it is possible to handle this race in the memory error
code.  I can not think of a way to avoid potentially incrementing the
ref count on a hugetlb page as it is being created.  There is nothing
synchronizing this in the hugetlb code.

When Muchun first proposed a fix to the race, the idea was to catch the
race in the hugetlb code.  Michal suggested that the memory error code
be more careful in modifying ref counts.  I would wait a bit to see if
someone has a good idea how this can be done.  We 'may' need to revisit
the approach suggested by Muchun.
-- 
Mike Kravetz
