Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ADC323418
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhBWXFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:05:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45698 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhBWW4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:56:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NMsh66089506;
        Tue, 23 Feb 2021 22:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eH+QROudVGxvuw7OOj+pMSBS7rp1xCRGjbcwvhgbHd0=;
 b=aKVQfG7rLHl52IlJw7xcTTkxHW1sPeurag73Shv8L7a1lXp2bnoGV3THRHCrgLv8J0Mh
 8XthrYHHtBvpWI74AESL3sUoi20N9qtHUywQZbJpEu+vCw2nrKthy7AgVkvjrjNb9Ilp
 dFQ7Le7wH8nzz6y1g40aIzAQ/utRlzhH4+KBClKivTWvDzsCjZQrUNPARKHfiqSfztUT
 jru0Q84Bj9GK5cprvv+UlK0oja+fvs/0vjZRp2OLX/bVFmLL6VgPsiwnpwN3ioAh6xJj
 Q1X0K6AoRRNqKzmFLFn+9kEfPH6X4Bprvp/tMtuwrgssgrhpT4Bso1PSqIybHRc4o3Ru uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36ugq3fykd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 22:55:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NMe8Zj142519;
        Tue, 23 Feb 2021 22:55:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3020.oracle.com with ESMTP id 36uc6scet1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 22:55:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVEqzbuz30DmJ6NRZtJ/3++PY1eO8DU6drI1BaQTyvYZPJMcya5S/42PCO6zB3HohOxbxJSogNHbFc612Z4mRtgwtyCFG3yEyqL/W9Zp5MqHd5EmA+NrXmyHbfUr44zRDfr67f3b+Goy/vfREqw9j7giCAYcAdCRdZz9abY2DlrLtLIThiVgqMII23t/LR3G/WL+But+Bp6FAIBTn0H6vlY7/g9j8frjzMkcrfqtu0S6IGueo+bKAjuTKO0YiytoUPr93aydTbFzKRjVwSLpYlXTYgP5QExz6eegAO1+ctFCcJpXXrcMPSWkfQRLg2PduVJjyfyxCiExXoMAs+doDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH+QROudVGxvuw7OOj+pMSBS7rp1xCRGjbcwvhgbHd0=;
 b=BSZFlCpLkH+56fPizTEBe+EmX+bp/Zlo3QpzFsamSn8IzKv+jOTAUC8pKV+VFIZfxqyHc+v3vHO+5Gh0ihlcWF4UP+P8VSKtHqytuF5RU5AjoSPRZC/nj7u5WwddZXQd6ik8VX2N851Qk3JD5WB6zVzg0KbEn21BfEwS6cp43kYdYxL0QcEytlpjZ7pK5Xzx+jWA4YQGW1gJfJFfovF4dVhGUjizcb6bLS3PPl4Of2HpWzih8amwcyyq8oAyHHm3ex2d3VEYLBx8CdYHGhAe69SWHK5LaKWYE5Hgai1VBmwXqS+kz2uvNIz5S/3EfFMApCZ4ya+f8+X4ewSZh0R5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH+QROudVGxvuw7OOj+pMSBS7rp1xCRGjbcwvhgbHd0=;
 b=wzF9TB3Bjp2/bLzPkplQD4xe4QjWBb+vubcOjs/bXgipzoLt6s3ur3y5VhvpnYguZMtzqaEibg7PtXt74pjI8wHWZTrcktJzKXHDsDP0CLnQhncmphr62s9HnxNX7IFLi5Wze2lLkZPZtWCnILXVn636hpxDFB4ODltBP2nBXGc=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Tue, 23 Feb
 2021 22:55:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%5]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 22:55:11 +0000
Subject: Re: [PATCH] hugetlb: fix uninitialized subpool pointer
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <53527e9d-d09b-7287-9f79-ebdbf4e9bc7a@oracle.com>
Date:   Tue, 23 Feb 2021 14:55:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210223224540.GB2740@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:100::24)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:100::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 22:55:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4da56e90-cf52-43b8-301a-08d8d84e1313
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4686DACE1DFE512109276F9DE2809@SJ0PR10MB4686.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPLb/adLVHFVP0Hpmt9Bw05pioS46eamca3cEYiULWnKmAbuCYRE/ILNaGOQkqqymLatDs5EytoK9lmAVtVAO194lleH06o3EVFBvX0eUR9NpmBF4tjl63rZzIhcDstjhxMXLPhdQfxFiwXc0LBfnCKOoQpdMVq7ToYMbF2axCOKKa4HGNcyj2q5DpyO9H0pdP4R+ayl2AMTtP/0Sm2kjrDUuy9MRiq572ZJsjzRAUPXiJxCOisaTKC83Wd2dEeu0q21hqNphrXhI8RiuEdmIeNXgtqrMiAgHLTwLqiesVJVlUGl0OZsCb1q39+f3k/DP74lgIyEFKiMtJMPcaFw0llwxYLQ/cHx0vf3ar3Z31JCaynw26S399qL5Hnmrn6OMvvE97+tT1yycOQuprNevtOtn4RyoRL3vi9lXpOSnQeq515PX5vcuMO7k6MLer25m9AvMl4Wq2tgd8Xb8FZh0HjzXJ6Tl89PI9tQcPBTRbx18Uo1Ef7I3TPfOoPGjVESE+jSgyg1zjaLjHKUW809w3BE7tSJijAE2UB6CXhbVFCfTz8o1hMH30Dzs8d1o1k7Tzv7POjoEhjvCHGmpSPwymaw6DyctB6lSabk/Ky5M6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(39860400002)(136003)(31696002)(316002)(36756003)(16576012)(6916009)(8676002)(478600001)(8936002)(6486002)(52116002)(2906002)(54906003)(5660300002)(31686004)(66556008)(66946007)(53546011)(16526019)(66476007)(26005)(86362001)(2616005)(956004)(44832011)(186003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SXJ3MjJpd0o2ZFZaZ0FWeCtzNnRPTUMvUk1TbWdzMW5xcEJUdlN5WG1aRFlp?=
 =?utf-8?B?dlZQbkFjVlk3T3RqdGZxMXIvd202Ly9pZ2Yya0xIWXR2ajBJMjhDT3h2RTFC?=
 =?utf-8?B?NUJVQ1lROVhkbHlGZ3BnZGU2UkwrMEtuWk9uRFNud0MrbVBKcTFYdytNcFZE?=
 =?utf-8?B?ekNtMkl6WEYwbGtOVXRYQTVkanBWMUZGUlF3VTRqUmMycktvbG44RG5XSXFz?=
 =?utf-8?B?Rk1OTm85RWdUbFMxUFpqRnJaRlVUK1Y4QlkxRFA1U2tMMlFManVQbGhSc1lj?=
 =?utf-8?B?UDN1NGlZL2RKalJvSEZxdUdJL1VxRUhRdndGNElIVjVzalBZbVlQUU1sRDdO?=
 =?utf-8?B?OG5IdEd4UXBZaTVWOXF1RVlGeGloNCtKWjZnblFadUUzZCt3VTBoZXdwbDNY?=
 =?utf-8?B?eSt5WHdvOHZnL09pakd6Z2tha0JLM1p1cnZRRVZpcU9LdDNtSzdoVll0MVZJ?=
 =?utf-8?B?YWhkbjFxL3pRZm8vQUt3MW1nU2JCL0NadGhBcHE3UUFRTW9za05objFKdmR6?=
 =?utf-8?B?bWxlVTNOUEN6TWEzMmZXaGZROGhoa1owVnBGdnFQSHI3cGpUYStKMFNINURC?=
 =?utf-8?B?UWE4YmJjV1NSNENxQzExZjgwVFFWZURMMEtWNkM1SU0wQUhlaTZkQW5Ec0Ny?=
 =?utf-8?B?U3djbHZ3S3R1VXMxTVU3TE0xVllvZm0vR0tJMjVzeDhyYU5jSXozbmxOT2Rz?=
 =?utf-8?B?NlZpZC9pcVY3NkZMSDVxbHdGMUdNQm5NaWFUV2ZMWnd3a3c2aFIybVc3WUc3?=
 =?utf-8?B?TjBiR0JiTnpHNi9PR01HRk9nelNIdTFWTFBhTjg4eXJpMEZJcisrb29QR2V6?=
 =?utf-8?B?VkhVcjU4UVc2SHd1bVU3WDRwNks0NFF3ME5IcnlxNnhyekNTQmowQW51ZzM3?=
 =?utf-8?B?UGJkVmQ5cXQ4RHpSYmhwZHNnZGJmdkJ4VDFaM1BFQzBSQWVHQlBlQU9HdlBu?=
 =?utf-8?B?TDZMcUFNcEhwZHRqczYxeGdIS0hGSTViTVIwa1F3bXFQaHp0QTdiSkVaWlZT?=
 =?utf-8?B?MWRDNFB5RkR5SUJVZmtDYitqQWxIWUhlNy9mVy9Sem4vejNpRzNyaEJZOXhw?=
 =?utf-8?B?b2RrN09wNFoxcE8yNnRzS095VnFyRjlWVWxYWG1BK2xTN005ZStyNm9xWnhT?=
 =?utf-8?B?ejlrcHVJbVlOYTJ0aXN0ajNmRkNpOHcxbHY0VGJKdkJiWStYOXZkMVhyQnZp?=
 =?utf-8?B?czJZNmdoemxESHFLOFkyUUpCQ2lZbXJWZGdYRlIrR2VMWTE5QTk1dkhnWHBR?=
 =?utf-8?B?SFE1R1ZmV0Y1L3hrKzdHYnRVZm1ka014RENiM2tJMDFUVXZkQjl5ekVzUERa?=
 =?utf-8?B?dVNUaTFGQnA1TVM2dlpBVUJHY3lIeTJsd242NVNaSkFJb2dmeUVLYlBlaGxE?=
 =?utf-8?B?aGtlQmJyK0lYb2xkNGZyejNFZ2xDUmZ6dGFKam1TRzE2WkxYSnFGbjhBM2FT?=
 =?utf-8?B?K2lSNU9ldy9LUFRJY3Q5MWNlN2xUSlVuV0tMcGtoUkk0ZEp0dHYwZVlhdkRu?=
 =?utf-8?B?WDZkYnNrRzRhTVd3cWRLRFdqWXNDMHhrUzUwV1Fra3VjNU40azVZSkZGc0xp?=
 =?utf-8?B?ajNvb2NaZU5YQjAwd2wvN2FWcklkTkp6YVpnMEpCUzVaY0ZQSndPcVBzbUMz?=
 =?utf-8?B?NXNRYTFRV1lPdTlxUE95aXhraEFERnJVZHZZa2tjbjNrd1NCTEx5ZUp3UC9T?=
 =?utf-8?B?ZTlDZXhhWkh3OUtZRFhzZkRNeVRRN2xhekpoSGp1N1FyZDExVmhtM0Mwd0w1?=
 =?utf-8?Q?A8NE1B26yFF3YgTByBMZHfPvv96WytrTfDe6T5s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da56e90-cf52-43b8-301a-08d8d84e1313
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 22:55:11.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTipZ+3JVN7JjhWJ12vyWHHZ0gAI7vDxFznUtyyXaJiUN1xQQzSXOzJBl/hP2WvxM8HytV6JmvVJJHioE2dwVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4686
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102230191
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/21 2:45 PM, Oscar Salvador wrote:
> On Tue, Feb 23, 2021 at 01:55:44PM -0800, Mike Kravetz wrote:
>> Gerald Schaefer reported a panic on s390 in hugepage_subpool_put_pages()
>> with linux-next 5.12.0-20210222.
>> Call trace:
>>   hugepage_subpool_put_pages.part.0+0x2c/0x138
>>   __free_huge_page+0xce/0x310
>>   alloc_pool_huge_page+0x102/0x120
>>   set_max_huge_pages+0x13e/0x350
>>   hugetlb_sysctl_handler_common+0xd8/0x110
>>   hugetlb_sysctl_handler+0x48/0x58
>>   proc_sys_call_handler+0x138/0x238
>>   new_sync_write+0x10e/0x198
>>   vfs_write.part.0+0x12c/0x238
>>   ksys_write+0x68/0xf8
>>   do_syscall+0x82/0xd0
>>   __do_syscall+0xb4/0xc8
>>   system_call+0x72/0x98
>>
>> This is a result of the change which moved the hugetlb page subpool
>> pointer from page->private to page[1]->private.  When new pages are
>> allocated from the buddy allocator, the private field of the head
>> page will be cleared, but the private field of subpages is not modified.
>> Therefore, old values may remain.
>>
>> Fix by initializing hugetlb page subpool pointer in prep_new_huge_page().
>>
>> Fixes: f1280272ae4d ("hugetlb: use page.private for hugetlb specific page flags")
>> Reported-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Do we need the hugetlb_set_page_subpool() in __free_huge_page?

Yes, that is the more common case where the once active hugetlb page
will be simply added to the free list via enqueue_huge_page().  This
path does not go through prep_new_huge_page.

-- 
Mike Kravetz
