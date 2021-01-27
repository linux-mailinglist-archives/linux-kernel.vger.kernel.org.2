Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2483067E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhA0X3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:29:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54030 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhA0X2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:28:33 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RNEEt9189926;
        Wed, 27 Jan 2021 23:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IZMGfAF3/CPhOnR5jlGq5owHSO5L8nt6IP03GTAkq0E=;
 b=ffjsmZslkBopFJln4ePSU6pCEkP58BaCNtDZ6xKM33XKgydRL5XgTkCejGYYyFZwntnZ
 X7GdIT2rENJ5W1T2+uv1k8rZor8WFJkcgh28/oKaNqev/HxLau4ezGqoJhSWZ5vr+oJA
 LZldWlLRLQ/QFj1w8nTwtu387QhPJ25UTCvGLzuxBhGsI8umE8jlS4J/BcFE2cB50AWI
 FGkMXtCm3u8egvirjmklCHEZyXpHSRyqa25fPhfGmlcBT3E552XEjW7GZoIDA7V+welT
 m/MJIZIG/ctwyHQLITpArbbFmKC91lwOmWsrrOCzilaU4BYorPMzB5XTlE0BufOj3eGO 7Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 368b7r1phc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 23:27:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RNGAKx194885;
        Wed, 27 Jan 2021 23:27:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 368wqyfbym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 23:27:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwGv1KwaJR2sRoxo1Nw8gZHdQZf+VVAI/SeFk4lPR+F04AgQMdgP3SvpNiah2HNWKgkUXZVk0QfV6revf7dNwYjBx7QtiyqofPpw7Ql9g0MZsHiQeIcD1/F8vhlYe57ATn8hHOgFN8qUngJJxyzBNW9HzDWiugoBZq8v+WPR0G1U2I+DDI2PSVU961Maymrn/RK8QEpykOIpdKWLY4wPLQ2vkE0wR0dekLK7EkkMmAxluMfCGqrfAl/gYpl8WnwRZGTBdUIYrS8LsGLIq+/u0IL8r2CyzL0g+gpaTF6wysGtkbo7RZoM9bTih9b48jf8r0/KVjF1YeagQJ6GdvrqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZMGfAF3/CPhOnR5jlGq5owHSO5L8nt6IP03GTAkq0E=;
 b=bUtSeEfTTNOSHzsJ9ED3vaJiqQ+Afw560KPOF9ODi5XwYocT315neGyqqJMIvaheTsQAJImEZGH7RRWOdVaP0q/rBJRyuzFgfwe4gVVKdI83WZA/r+DDJ67CrvDV1ucHRiSuZag++19LydY39/w0ckrd96Z/MCToBmYwIvAiLzVxoQiVwfhoygy0rs3u0LoKIMnGlNOUOOGSAo16FoKuSwiQWlI1ayD8eXhu/fGdIRQJt4AhSv8qsoP+yX56YODjMnB8kyDnQBbxPM7S+b/XqS2MF3Yc5VRxBcTN3qCAzVWGTmaO8AUK+By/5CYNK2PuErqMPwzLyI0KBVGn64XP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZMGfAF3/CPhOnR5jlGq5owHSO5L8nt6IP03GTAkq0E=;
 b=ICIb57Br75o4N9LBQlhKCq8qEJ1N/BM+sImeBkrHuVj1w5m9JJWErZvJ8kcUEoIxZhabwUm79jWg3uRDEymNMQfuCdk9N1LGWcQ3g43pshsAe9Jn9+APRV2uyjY8KY9BYj2qlhlAgAj2u16JVMm3JjiWKavooMyqlzpVJ2bayZI=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 23:27:22 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 23:27:22 +0000
Subject: Re: [PATCH v3 2/5] hugetlb: convert page_huge_active()
 HPageMigratable flag
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-3-mike.kravetz@oracle.com>
 <20210127102517.GG827@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1d05b4ae-e14d-794e-f2bb-0906cbfc2ba1@oracle.com>
Date:   Wed, 27 Jan 2021 15:27:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210127102517.GG827@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:300:115::18) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR11CA0032.namprd11.prod.outlook.com (2603:10b6:300:115::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 23:27:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03701dd5-0a66-4f93-7dee-08d8c31b191f
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4531547D35F901A5CBBCDE0CE2BB9@CO1PR10MB4531.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qV/LkyW/O8ErvQNLLz5hxdYFx/On9iBuey6iILojihCmAQreVFQPerMdDq6Ue3oA6AyyrTAlfD+pDADi3r3rZYLLJwdJUjZrPu4ODmOFopJiuTrVRhTpV17QatvBiA5IlF75PqIBl+nxZ4xE9lSeYGJRidlq/TP82HV5x8I+M0sLLlO05nJGbDHBxXtiXNcGV7fOw9oI30tC8oooQ0k7z+cTBZPu9F+lkWjo28S6oHfT1dYh8ae3O73Q7SFmhjn2HwfDkFsQUJU7Vf03Z+IW4iLY/yt5nkRblJL2ASlEXm96/6ByIC+vl55kbKW6QgoRXWpgj648aEP/7UOV6xCCDAo2RUvlPLSBnp1hX7g6SHAzTb9wROZL9ybKjYUMKmGpxzuuZ7E7VjQmVExVtT3qBRvGtVbGnOe9ZwY+JSyf6UCgXzfl4tikSv7rEE2xKC3U+Si87chJuGU7hILzDVmSRGd13KFrfn/qTHPWfE/Do7laRYkE0zmOdSJw7gageEXb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39860400002)(366004)(136003)(53546011)(16526019)(6486002)(31686004)(4326008)(316002)(956004)(6916009)(16576012)(36756003)(52116002)(5660300002)(83380400001)(86362001)(66946007)(54906003)(66476007)(44832011)(66556008)(8936002)(2616005)(478600001)(8676002)(186003)(31696002)(7416002)(26005)(2906002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aWZQZUNUV1Z3OFExeDlJL0ZXWWhhNlZpN05lY3NrOEF5bHFNakpGN2VmNGIv?=
 =?utf-8?B?Z205T05SZytaendpbWlJU3M2Zm1LQmFJdkdyd2U3L25pbXZuWWpIQ2FOL1NN?=
 =?utf-8?B?aG11UytHNVBEQzdrdFdnVUxmSzhmYVBqR2hvMzJFZllXOXpqR2dJc0F2cURk?=
 =?utf-8?B?eW1qTkRLcU1maHdBTjhwbHZUVElkNG14ckMxUkNDS0syaGRpM1drcmM3ZGd0?=
 =?utf-8?B?V002RWpxMFd1OVowbjJSbnArbkRIdU1tVFBlMUFTZ2pacTMzY3hkc2ZuTVVq?=
 =?utf-8?B?Qlo1R2hOL0l0aURyU0dNWVYrdS9OWEtQUFNyNWpPMXN0VUxmN3JjRGJPY3pr?=
 =?utf-8?B?eVFkeWYvejVEYlhTN1lFY2FWd1ZDVEpBM0U0UkVoOUREUHJYRHVUelB0cllK?=
 =?utf-8?B?SUJhbVpoY3dScWVwM0FCNDlDa1Y3RUVGZjBXNmc5NVFsL0xjTjJleURtMGxS?=
 =?utf-8?B?aWJKemtDU2FlM1dpSS9qTnhZWlR5OEpMbGl5UE9EWnpIaysxVVVGbEVwZ0h4?=
 =?utf-8?B?MjRBVzJldGNXR2FkRGNqaEV6bEZpekhQM0pUamxXYnZYeDVmaHY5RkR2Q29Y?=
 =?utf-8?B?ek8veERGdktvOENRZENwUkEyTFFsdStHWTJzWU42VnFKYjh2a3BEMVNQeEkv?=
 =?utf-8?B?UlJnQUxNVUNTc2dWQjg4enVDQlNsSWIvdko1S0VMczc3K3hlTkJWR1Zjb0di?=
 =?utf-8?B?Zy81bXdVQVg2TDBrRithS2RhYU94Q20vYnd1cm1FaUFJV01sY25MTU5FRFJ6?=
 =?utf-8?B?TlNWaFdta0c1eGI0K1ZleXh2WDh2NkpSY2xxR3BOOVpqZlFTOThGZkVGVGhG?=
 =?utf-8?B?MXA4ekg5RXBrNmx5amlBRXNPNkdtSnVtUC8vd1VWYUloYXgwaG1qQjJVbnpS?=
 =?utf-8?B?K1FJMmwxZTZPWjh1ZVQxcG50dm56dStLL0tNTmhkK255USsxYTNJaDA1RU1I?=
 =?utf-8?B?dGRyQ2J1K2JxMi9pakw2OU8rL29nTDJzaVhOY0tsRGdQUFI5a2l3Uk9uemNO?=
 =?utf-8?B?bGtHcVFnZTVTWUpJMGN2N1lLL2Y3bmVURlB4WlJBalBBd3N3ZzF5Q1I0MEIx?=
 =?utf-8?B?c0EwRVFxMEZLVThoTkRDTEZFM3FXOWlXYlB6cHh5Y2oyanZTcGZJczFXZUxx?=
 =?utf-8?B?NXZJMVZ6eEx4eTloekR5U25TZGk4Sm44MkNTdU00SWxIVjBCYVhXdGFia0lr?=
 =?utf-8?B?VkpYNnlNN2Y3WSs0WnlybWNhVVB2N1RlazRRU3hpd2hsdkNMOTRWcjlaMjND?=
 =?utf-8?B?SUNCL3VJRlk3ZWtaVmd5N0NWZDZ3NndFQWlOUG9xemQ2V1NIcVZRY2pGTjFF?=
 =?utf-8?B?U1BScUlIbnA1dEppL0RUZzN4bzRYcG9VajErdUVJam5EVk1pMGJzdDlPRXQ4?=
 =?utf-8?B?bTM0eFc4T1E0RWN1NjJ3cFA0YzdONUd0SmEvVXl4Z0s5OTRhb1FzYW5pOXV0?=
 =?utf-8?Q?AVZusFzu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03701dd5-0a66-4f93-7dee-08d8c31b191f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 23:27:22.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAN6RG06xVtsk9r0HlFJ4k2CTRuM1j0N/TnV0Sg9CwhCEKPVMxfp+dpXYz3EJbdM3OoFt80QlaAdiR+NQOHePQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 2:25 AM, Michal Hocko wrote:
> On Fri 22-01-21 11:52:28, Mike Kravetz wrote:
>> Use the new hugetlb page specific flag HPageMigratable to replace the
>> page_huge_active interfaces.  By it's name, page_huge_active implied
>> that a huge page was on the active list.  However, that is not really
>> what code checking the flag wanted to know.  It really wanted to determine
>> if the huge page could be migrated.  This happens when the page is actually
>> added to the page cache and/or task page table.  This is the reasoning
>> behind the name change.
> 
> yeah, definitely less confusing!
> 
>> The VM_BUG_ON_PAGE() calls in the *_huge_active() interfaces are not
>> really necessary as we KNOW the page is a hugetlb page.  Therefore, they
>> are removed.
>>
>> The routine page_huge_active checked for PageHeadHuge before testing the
>> active bit.  This is unnecessary in the case where we hold a reference or
>> lock and know it is a hugetlb head page.  page_huge_active is also called
>> without holding a reference or lock (scan_movable_pages), and can race with
>> code freeing the page.  The extra check in page_huge_active shortened the
>> race window, but did not prevent the race.  Offline code calling
>> scan_movable_pages already deals with these races, so removing the check
>> is acceptable.  Add comment to racy code.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> One nit below
> [...]
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index a7eb05315c6e..58be44a915d1 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -480,9 +480,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>>   * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
>>   *	allocation time.  Cleared when page is fully instantiated.  Free
>>   *	routine checks flag to restore a reservation on error paths.
>> + * HPG_migratable  - Set after a newly allocated page is added to the page
>> + *	cache and/or page tables.  Indicates the page is a candidate for
>> + *	migration.
> 
> The state change is synchronized by hugetlb_lock.
> 
> Pls.

I will update/explain this.  But ... hugetlb_lock does not synchronize all
changes of this flag.  The flag is set without holding the lock for newly
allocated pages after being added to page cache and/or page tables.  This
'signals' the page is a candidate for migration.  When the migration code
(isolation, putback, move state) deals with the flag, it does hold the
hugetlb_lock.

This patch did not change any of the synchronization.
-- 
Mike Kravetz
