Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3F930681B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhA0Xj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:39:58 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:39972 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbhA0Xhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:37:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RNFMTI120191;
        Wed, 27 Jan 2021 23:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NxsoP6LZIIriYwWOadOhSSOFWa60pgRlgKoPwSaLfNs=;
 b=nNfzr9pezrVr20yNT18m214enf+U+QzIXfUm60rDvLWyQbVp2cwru2TIFVVP0n160Qlc
 qC7hXHuV+06lxC86Z6AfkOzWm3Rlds7KVfOGT/m+hC5OvU5AhDbzhwpcayloKpvRs0fu
 jauu/MtTM4bDUSijmyP6OTou/hDTGcWg2QDPf+fRXRH4h9AV2tXh/aLu/4H6HGiHqn03
 XkA1XvlnWRz8Na6JTzLLneSGODnhZGhJG8vWpB/2zdz/MgRJIS69VKeQ1gZzTaXQiNcX
 KAw5PYFfc8Lx4vnYeDc7glIrGCnk/UKf/q1NIr0iaPqTMkM+GWHY1Z2D/+VO+fkA79Yh Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3689aasve2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 23:36:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RNGBbW194940;
        Wed, 27 Jan 2021 23:36:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3030.oracle.com with ESMTP id 368wqyfm1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 23:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF7gUStS5A3jpTeHpxeDM5uCOhdzucKrNa9Eokjcd3uYSRpZ0Jjb7i+Yas/bQMc6dLdczvTTZRT/bRDh4xos5Xgiw37ecISDn5XHQ8IPQYzv54QQvG96luV8M171Uxw+kAOaFWweqZu+giPB3zZLTjgJy1HcZlnnUN4GaFwB5LxC1j0fYf1nZu08zP+T8t15LLE8O5CjNWNOgu6bLC4XbMCNl7B20hze1sxLSFyuWLMMurd695DaqgR2VN63QfB6SaZT3v8EhKqhxmKbHseylT7drlbTerlbycYDmg51NlCyVAQFV7ISloAnDfek0iZSpF30WmJxEnXat8FJIC5+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxsoP6LZIIriYwWOadOhSSOFWa60pgRlgKoPwSaLfNs=;
 b=RUVr6cHsM7xr4UXd3j32iOXziwNmA/MhAISouVF/+5eBgEtxgqsV++dLwkVkBww7GqLx4uAX1rMNw/cjMzEFjW8gIXQCIXhBrmq87NoIISWA3XaNe2GRIHjOhsOfyzuC2ZgAbRsevbSdi/D1Gzr19d9HzR/JBOp/xDGLzwzrnVT+7MZH8mX8xhl6DxhJeWjPNIbK6LdBs1Z+nxuLKG3DWjQ5om5iqBxZHQJ+gR5Spl6MpyERDMMvsADQPpdggPIs5bpMr69C096hwr/j1ZO6EkTLHmt44NV/flG7MmDPlvFkRYwcwTxV7h61bDhH+LL8RWvVMwq1STvUBqeF/cGEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxsoP6LZIIriYwWOadOhSSOFWa60pgRlgKoPwSaLfNs=;
 b=qu79aCPQyPr1d86AgJ2XlZFDbiAjMnU6pDocbldFxry0cRdO4blbr4N89DkJy/RAxEGsNSR15WrgKa+JwC15c/1m0ZJbBwy5Qttt2rIXSTcnMxPHEa30xm7d3KBa3s0hu1tL+kLpZg0eqVEdf4wPeYGCeYobwsN/6zj4XtBKr5s=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 23:36:42 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 23:36:42 +0000
Subject: Re: [PATCH v3 3/5] hugetlb: only set HPageMigratable for migratable
 hstates
To:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-4-mike.kravetz@oracle.com>
 <20210127103523.GI827@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2196d93e-f573-7163-183e-0ad2cec7555e@oracle.com>
Date:   Wed, 27 Jan 2021 15:36:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210127103523.GI827@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:303:b7::25) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0110.namprd03.prod.outlook.com (2603:10b6:303:b7::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 23:36:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d1155b-341e-46c9-e2da-08d8c31c66a1
X-MS-TrafficTypeDiagnostic: CO1PR10MB4609:
X-Microsoft-Antispam-PRVS: <CO1PR10MB46098FB7554E3100B8B684C6E2BB9@CO1PR10MB4609.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHeG7/YkpmCFemH1kC94lzdTVVECy75HeC5qm0xtnvtT75+3lRl6GS9Fagw1O1v6fBbyFEx5JpkRphnRLRMwAaQ/0LKjCpDDyd98p8LIQDseOSaAGSBcqCr7HsniEKGkjTzeRzznGP4LzGDyTPBUyk/wVRS0usn6zMkzxUgoGXj80liBLK4rsthNQ7gXebB3kR7AV4ndU1zjkfYFkEKJ8tak0ZRJ5zxW6/z5W/isfqfyqlte3scD+rsnEyaDW2xLhHmjEZVnaYBcQu2w5C/tg4aSQNwTclR3aYxYu1uSpGT7vzW/maObSBEmbJfPzSeSpryC7pi25bWeEUnKIUOhK3i/JZJx+vs7MdvGUC7AF+YtMtc/YQKckoi++56xxUd5RjskycDfkPt2oo0dj3ZMIl7r4Teg34zIzNqw9rtogOgiUs1c0i1ZUzNhamjwVndkGM7+XVKa8KdkNQVJYKqN89mhX+mivuVvOk+E+VokvF0LegYOb35RlHWlg49O49ICvg8u+zes88a6R/W04xvU9OacUOLwxza89VLjg/xZ1movxeX0D6s97gDYfBJ+C8N9+TQ49QQu/iRNsej49kSXJ32bcd4IEGMov9IoiSRu4VI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(346002)(39860400002)(7416002)(4326008)(186003)(2616005)(8676002)(44832011)(478600001)(16576012)(31686004)(956004)(16526019)(31696002)(6486002)(83380400001)(110136005)(26005)(316002)(53546011)(86362001)(54906003)(52116002)(5660300002)(66556008)(66476007)(8936002)(36756003)(66946007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?czhCSFZmS3lkTE0yQjdld3lSaHAwV3lzQlQ4YkNyMktqMzMrNlFmOVo0a0FJ?=
 =?utf-8?B?M3Q5WmJacHJTZGIwN1Rha1kvR2JMYVNmQkZzMHIrMWNpQmhnckdLSjhQWE9D?=
 =?utf-8?B?czRLdEZIYmUvY0laOEJwMlkyNEdZVEh4cXBoZ2I3T1RvcVNvMlpwWEVrNnpE?=
 =?utf-8?B?TlUzazhQY2hPZ0FYTjlGai9XNHZrNGhnV1lSWGJBUkxOYVYvYmRHRFVIZTM4?=
 =?utf-8?B?TDE1ME02V3hwVllyMGhLV1pneGdONGhWdkpPMUdNZ1JlQndPakp3b2t6NU05?=
 =?utf-8?B?aUpKNkNnSlg3TldjS3RDdEFSOGk3WHZpZS9uSmcydHlkeVlkaVIyOWNwb0dD?=
 =?utf-8?B?SXkydCtsUStSTXlML2xhMWlFN3BpQUNzV2xTM1pWLzZleFp0bVludkx0YTFp?=
 =?utf-8?B?OUdRNjN3RVZiSUJsc2kxOEJFVG50SkpvQkZnN2VaMmdDVm1lVHlUcVZxcGF6?=
 =?utf-8?B?TjR6Y0xDdThoaHZ5WkNUSXZTSm9Wemd6ai9QVFZrTVJpblAxdGhiM2NvRzlW?=
 =?utf-8?B?YVo2RDlaV2xlZ2J3QStncFNFK21QNUp3WG9FNUJtZkc0NGkzcGxRdm1MRWF5?=
 =?utf-8?B?bHBZTElQUUQ2ZUpoZDN2VS8rWUhCWWMzR1F5ZVZaWE9yTWhHL3R0b3JPU1Np?=
 =?utf-8?B?a1VRNHVkQkxXSytERXBNZ1FUWnM0Szcrdk9VczJTZVBoSFJTa0I3Q2xNQ0Zm?=
 =?utf-8?B?U3BoWHJWZXpyQ3BaY0FMOVBvaVFLWXBoM2Rzbm92aUw4MjhrOUlkNkRxMnZO?=
 =?utf-8?B?ckh3U1NNaG01RmpyRlRnY1VTQityczJPTGNTWTc2bFA5MUtkVFJYRUdsZ2tS?=
 =?utf-8?B?ZTBmQjlrWWZlRklyVSt1ZCtJdVIzdlNhUktJMVVGY09aWk5uWmdzY0hVbmNp?=
 =?utf-8?B?MWR3ZW5yejQ1T2tTWVQwUW5PSTkxdlRLdXd1b3E3M24xZHVBQitHaFY2L2VZ?=
 =?utf-8?B?c1ZOS1FldDl1MVREUWtqVUFUTmFmdElKOTA5TXB3KzBBUW9Uc0x4WmpobG1Q?=
 =?utf-8?B?UWFFUnk5aDB4ZTArQWgrU2Yvamg0RVpHWmk4Skg4Z0w1UVZYQ0J2RXBvRTZ0?=
 =?utf-8?B?ei93eWIySW5sTDJjUTE5N01mUWg1VzJaRW95OWJwVnIzK1JJSk1Cb29HVnFo?=
 =?utf-8?B?WGlKbnZtbDdRQ01YUG05MkhiWnAraVdVRnBCYTdpeGc0V1E0ckVWQWpBT21J?=
 =?utf-8?B?TWJPTXRqVEhqalhEajk1akM1R2ppQUdkSlJPY2ljWjBwaktnNzk5aEFJbEVz?=
 =?utf-8?B?bndEN2ZnY21SMW1VWWFEU1RVaEF5SkdNUFB5ZDZFSTUzMkEwNHByUlhDUU1O?=
 =?utf-8?B?MlR4YWJXWllabjIrYXZXaDJrRmRQYVlpajh1L2lzeWg0Mk9jWkdoell2WWZv?=
 =?utf-8?B?MENEd1NURzJaNnJNZGhjZlF4Y3lKNWtsRUtFUzRMbWQ2bmdsMnhzejJhWitn?=
 =?utf-8?Q?BAUk6Out?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d1155b-341e-46c9-e2da-08d8c31c66a1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 23:36:42.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqNToq65E2f6/7SW0P4PYhEzHsVins/YcXBUNrRcHGY2t0/oG+48YWahBcfK1NdeCKlxZ46MJoy0d6K0n0s2cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 2:35 AM, Michal Hocko wrote:
> On Fri 22-01-21 11:52:29, Mike Kravetz wrote:
>> The HP_Migratable flag indicates a page is a candidate for migration.
>> Only set the flag if the page's hstate supports migration.  This allows
>> the migration paths to detect non-migratable pages earlier.  If migration
>> is not supported for the hstate, HP_Migratable will not be set, the page
>> will not be isolated and no attempt will be made to migrate.  We should
>> never get to unmap_and_move_huge_page for a page where migration is not
>> supported, so throw a warning if we do.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  fs/hugetlbfs/inode.c    | 2 +-
>>  include/linux/hugetlb.h | 9 +++++++++
>>  mm/hugetlb.c            | 8 ++++----
>>  mm/migrate.c            | 9 ++++-----
>>  4 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index e1d7ed2a53a9..93f7b8d3c5fd 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -735,7 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>>  
>>  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>>  
>> -		SetHPageMigratable(page);
>> +		SetHPageMigratableIfSupported(page);
>>  		/*
>>  		 * unlock_page because locked by add_to_page_cache()
>>  		 * put_page() due to reference from alloc_huge_page()
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 58be44a915d1..cd1960541f2a 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -740,6 +740,15 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>>  	return arch_hugetlb_migration_supported(h);
>>  }
>>  
>> +/*
>> + * Only set HPageMigratable if migration supported for page
>> + */
>> +static inline void SetHPageMigratableIfSupported(struct page *page)
> 
> This is really mouthful...
> 
>> +{
>> +	if (hugepage_migration_supported(page_hstate(page)))
>> +		SetHPageMigratable(page);
> 
> and it is really a trivial wrapper. I do understand why you want to
> prevent from the code duplication and potentially a missing check but
> this all is just an internal hugetlb code. Even if the flag is set on
> non-migrateable hugetlb page then this will not be fatal. The migration
> can fail even on those pages for which migration is supported right?
> 
> So I am not really sure this is an improvement in the end. But up to you
> I do not really have a strong opinion here.

Yes, this patch is somewhat optional.  It should be a minor improvement
in cases where we are dealing with hpages in a non-migratable hstate.
Although, I do not believe this is the common case.

The real reason for even looking into this was a comment by Oscar.  With
the name change to HPageMigratable, it implies that the page is migratable.
However, this is not the case if the page's hstate does not support migration.
So, if we check the hstate when setting the flag we can eliminate those
cases where the page is certainly not migratable.

I don't really love this patch.  It has minimal functional value.

Oscar, what do you think about dropping this?
-- 
Mike Kravetz
