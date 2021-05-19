Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C79389972
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhESWqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:46:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43562 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhESWqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:46:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JMd52g134195;
        Wed, 19 May 2021 22:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mGpcABSjMosIf0asX+2GdOPb/lx2UyoI0FqdfcbS4nM=;
 b=Mgo1DedUPoU9dyHlxsOPcAca1ISBFVmXz6irmgE3tMbXAEaxzmj3IoFI902PISzqx6B1
 hXNRpJZublQGW8ZHravlsh0W0lV0XfTC07SpksYFHJ+EVKZCtIr2QPLAadF30loBfHtM
 Y+AFxn4+44E092Y9iOEH0Fs9sUTPyj2VzU3N8vPwjx7eWWbAFKetQ1ENhe0LH+Faw15G
 t/QB7k7uj9y2zRrn7UPidyfs52S+B3R/jFHZP/OW5sngrmvT3pO8pFW39BTviDb8YLQ0
 tAWVSBklWITGGwiLtqWonusZ0GKYBUdAnafy3bkzklafbfJM4933aSGbopsCiq5G3dEf Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38j5qrb2v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 22:44:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JMeR68133430;
        Wed, 19 May 2021 22:44:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 38megkvf7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 22:44:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXa7Km+ekhkCPrFOVX2/qN1ZlgCvy3ljPId3jDq/SVZfCOn3Mo8RwlxkvEft96cQ2du7cEVNG5hS8lcMi3JonXtPwsNcA/OWKjC7LcrfKzEO3O8OwbSy1mSyvJfuUajogBylyDQyk6RCJQMBXFyyrjtDE/fXxMw7APQcPXCfhvnJbzlCX8yHERParX1mZyXckJYUb24mogmCRfEOUeR4uV44Y9LPUucxhkYSEk1vrHCFGGnu5nhjet5O4isMpSchZ3uC80ToFcYpmHPA1TdHrdrN1syFvEAsFJOG96sP0ZEMejv8XrYWRX49j/XblsRvuA9d9iXPVjkYMPzcVN4qHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGpcABSjMosIf0asX+2GdOPb/lx2UyoI0FqdfcbS4nM=;
 b=L2GZlML3Ye4BJDyqPUOSh+Nj4Df3X32u9lrtS+5cB3QJyNxtPEKawxF4UNaCQk6xGXLV0DaxyNxwJIGflH/7RKyW6dYxTiIgbOeXYR+NDunk0b0P4if5c37rn81aKoiwaa3DiyVK4N9yyGIUZ0nnC6Db5NxKjq+7YPIWPl/7ZR4rU+3DubK9JciYW2tPHnxLKCe7AKA8tu9aj+qZO0u8DU3I5EaGbJdlqF72r7GjnoNfN7K94pOis7bWPoKwJHYDGxNjXcV+7v5sCpexsitCXKiDF25lGORv813zPJ/bQUHsgYIAgI6xVMDKWJBodpXWx/l5IlzgRftnHPV7PjxQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGpcABSjMosIf0asX+2GdOPb/lx2UyoI0FqdfcbS4nM=;
 b=LM6E2HCprcwNGH7/PhCHofTR5wguhFHuvuJDJw0Dz3RQLB8uwmfInU+9Q2TFHXuUkt9DQRHCas0PKdL2DJvz5M+yR3RHEPVmgtNZodNpnnp4vBo7DGeDq8fzQY75Xwg0YikMLV6BCjgHN8uSx1+2x+CIoxJKEhg3pbrO/DByij0=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 22:44:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 22:44:52 +0000
Subject: Re: [External] Re: [PATCH] arm64: mm: hugetlb: add support for free
 vmemmap pages of HugeTLB
To:     Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com
References: <20210518091826.36937-1-songmuchun@bytedance.com>
 <5ae7a4be-dfd5-faf6-a75c-a2adf5a344b2@arm.com>
 <CAMZfGtVJrnQ6Nb25CON3WupOx-K3BFzQ2t546r0xsT45vZD+4w@mail.gmail.com>
 <CAMZfGtWpu=pDqn2WZ4QPTevvHmjMaXg8oN8rh1KCDXwievzNrw@mail.gmail.com>
 <CAMZfGtUOmFQCXYKq3V=bJs1Ve6kgnT_o_LhsY0gitOY+D7T10A@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7c39926f-3e8c-afda-7a68-81d2a65c580c@oracle.com>
Date:   Wed, 19 May 2021 15:44:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtUOmFQCXYKq3V=bJs1Ve6kgnT_o_LhsY0gitOY+D7T10A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:303:85::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0172.namprd04.prod.outlook.com (2603:10b6:303:85::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 22:44:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c44e831-1130-4af3-0083-08d91b17b782
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44629847366228D3CEEB9630E22B9@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1OqJTmxrutICr/PR2r+2syBwkl7lJlpD4VVYwWt6gHlQqXMU05mvY4k4tIF9OG2G5rrWMs7LKPx+bdZZjPb1go+YM7sWVrvQ01FB4J0STJvAKn6ceanNhEzslm5+0AvWRr7k0ehu3E/7P0t+XzHchoJGCbkdsdZUyh2nRKsbXveYCLtrWOW3qtmsVYr0SylI988mkfl8dWSnWrpXq/wvdeVJLVJ7m1N6RV/NTJJD53R0cFMdnubrBHRblYuU8XZVFaDZHXxVDucCEDegU3O62bcC8x2I2P5ytH7i9klSXgG58ld373hfRpkENESGnvzzjTNctqeJx+rauGji2aRpSNzaxVbqdLSSHzeexTDeg2EzpYdlOEPqyIiPV43haJ7wLE3gt0b9ZBougTi0iDa2m6mMHs6W0UnEvfxklAUGNzVqXO1ehhVgf+BOkz+ZU3Tr1mWLmS+q2XTP9Bx1HW/+ti4R3DxXC0mHAlHnYJ9uz0xEXpy/Dy5ndWOQX6DxBbjn4ydJfdpdf7EsY9MZKdsCjbdT8C99otWaA6w5eoc2iKFpXnKjwmcOsLc/j25L4q8JU1ksKMUz1UR2yUXxRfVXDDwqh0R7OhI147DhzSA+0tRZNOc0NDGNZqyCNO7DF+whmyWHTc5XS4lvKyfNiJByZjmKMGBX9BYR3N4SS5leQy2nT/NBtg6bQBApSBvUSA+XpASERX8BVZmHQCrt5O0ajXxOCndx3Qpy8bzkW2sv1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(44832011)(478600001)(54906003)(38100700002)(956004)(2906002)(31686004)(5660300002)(16576012)(2616005)(316002)(38350700002)(66476007)(66946007)(66556008)(26005)(53546011)(52116002)(31696002)(83380400001)(8936002)(86362001)(16526019)(4326008)(110136005)(6486002)(7416002)(36756003)(186003)(8676002)(45980500001)(4533004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NVhleHpRR2lCKzc1SklIeFJ1YjhUTmhMTnFzRytENGEzWVVUQ0JWbU9qTE5w?=
 =?utf-8?B?U0dTdHc1RFZCR1pEM25KZEN1K0Yzb0hCUkkrbno3VERwZjJ4UDJoY2lVa0l2?=
 =?utf-8?B?aVM3NDlpSkhjcHJMVmNtc1l0WUloa1FUTmd0bGc1TzhPVHV3emF1OVRIR3pt?=
 =?utf-8?B?bTF2ajBjRi9IWHNWU2NzWGU2WWlzZUtBWTdHSVlvUVhudHdZaGp1QkUva2Zo?=
 =?utf-8?B?bGxwb0JaNWIwNkwrU1VMWkJXTHlyME95RFVrNXdsWGkxa2pzTmlHdGJyZW1O?=
 =?utf-8?B?OS9uNG9LMUZGWmI2M1hlM3Fla3ptMUMrMW1OaDc1SnRMTW91azV6RStzeklB?=
 =?utf-8?B?UlNYTTJWVGlXcUNqdVBxRTN5c0tpWnREODRld2tBZ09KbTBnNEd3dHlyNzRZ?=
 =?utf-8?B?eTRwL24xT3o2YmRUa2lEK2FzNEJkQVhGVFpaWEV1YVY4UnRFV1pXaE9XRUYx?=
 =?utf-8?B?aTlVUllaaERPYWVTM005VWRtemRIYTgyV2dVTm1FUjFJSWZKSFhIRlZGdVA1?=
 =?utf-8?B?dzBaa2lpL0dNU1hLQVNDYmFVNHI5OUVWSjZWMXFoeHlHemhPTjlsMjdzdUNM?=
 =?utf-8?B?bDJUSlhtUFhWT3NGR3BYR2p3cWtnNjBUZnR2NG1mK0JHQm5yeHlRUkE3UUVo?=
 =?utf-8?B?SVlZNkZDZThYYzNWTGFWaVY5VGxjbWZ6RTlSRWdBbnZnWHd6Y3lyUmZFYnAw?=
 =?utf-8?B?NWkrcHBQWjFNbnVLZmorUHBBbVhFZVUyRjhRNkZkZUEwdVJmUWs2eVVjOWN3?=
 =?utf-8?B?eWJKQXJ1MTRYM21HeUNlRXRQSytDQzZxRHhCYjhDRVc3WkVwODVUeHJwSFlS?=
 =?utf-8?B?MytXcktuVGduWjRQMjhIOTYrWnZqUlZCUE1XdUhTVUw4QTBWcEFoYU5BNSt5?=
 =?utf-8?B?NHZEUjFhOTROK09oK2xMc3YxUGQ4QzRXdUdVeXovamY3Vzl1NVhQUW1VQ25j?=
 =?utf-8?B?bkFvb0E5T3Y3SGlwc1NsQ3hYcW5pZlNaaXFEWUpPTE10OHF0ZU9NdDBxSFNJ?=
 =?utf-8?B?S0RrRFQrR0pUT2JoR0JzVExBdktWTmVIcVRmUXJLZmNXdGhLZElENlhucnF1?=
 =?utf-8?B?aDBpMlJLNEdnNmNoQ3JmenRIV3F4dnZBaFdTaFNHcG93VnE3bVBxU2lzWVhp?=
 =?utf-8?B?TDU5WktXa2pqRkYrQ2tXZWE3VXByVm5XU1VTVlc5MnRtWk55ekZTNVpxNGJR?=
 =?utf-8?B?dloyMEUvcGtBU0RxTy81L2RrbGFCNk5GbCtPTEdmeEg5Qkx4YzJQdVpRNUt2?=
 =?utf-8?B?UXlGSGZTR0UySGR2cjdmMlFYRlpWeFNTdk5pSUNoc0xaMXBqRStqWFBGRmx1?=
 =?utf-8?B?RjJxVWkyNlBmeFpjSDliU1czMWZaNWJXUFNnRVVnOWd2dUZVdTBHSm1GZHp3?=
 =?utf-8?B?NDVhSVVPK3pvZlYzL1N4ZmtFbWYzb2RCVTRqdXZlUmVXZXpHRlJwVHUwWi93?=
 =?utf-8?B?eWxtQUhLTFF1MXVSQzdBS3cvY0M5NGp4TDhnVVI1cnJ0ejIyZ25Ea1BwbWN3?=
 =?utf-8?B?M3RPQU51WFl6alMyYlI4dEZieHZzVS84Rnd6QTJoOWRPOUlheDR4SUw1QVdS?=
 =?utf-8?B?bGZCdElUK3lES25BQWhWTDhzMGEwcGNicGxiTGlrRzNRZ2twNGZtbFBsY3hL?=
 =?utf-8?B?bGxKQVVOR0RUV28wVEQ1cXlQVmI1WEJBYzJSN3BuQjBIdTFMTGwwaHIxUjBN?=
 =?utf-8?B?R01YUHpPNE1sQTBNd2FSTWdJQlJkYmhudFR0dlhkVFVFd2ZJeGQySXptZThs?=
 =?utf-8?Q?O67WeszUWfNSHBiKD2hejtSGRBZP8SPKm0VCDSu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c44e831-1130-4af3-0083-08d91b17b782
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 22:44:52.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdXpy3HVsa1lhDbj2g8rabA4v3yAe8FAub7d7hkG4Au/21YOzLKv+dPOdNafdtvKB9YIN8asAIznf3lObSRoQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9989 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190139
X-Proofpoint-GUID: uWsw68vPWIdCFL5BbxY6sQOcfKaQ0Qd4
X-Proofpoint-ORIG-GUID: uWsw68vPWIdCFL5BbxY6sQOcfKaQ0Qd4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9989 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 9:21 AM, Muchun Song wrote:
> On Wed, May 19, 2021 at 11:22 PM Muchun Song <songmuchun@bytedance.com> wrote:
>>
>> On Wed, May 19, 2021 at 10:43 PM Muchun Song <songmuchun@bytedance.com> wrote:
>>>
>>> On Wed, May 19, 2021 at 8:35 PM Anshuman Khandual
>>> <anshuman.khandual@arm.com> wrote:
>>>> How does this interact with HugeTLB migration as such which might iterate
>>>> over individual constituent struct pages (overriding the same struct page
>>>> for all tail pages when this feature is enabled). A simple test involving
>>>> madvise(ptr, size, MADV_SOFT_OFFLINE) fails on various HugeTLB page sizes,
>>>> with this patch applied. Although I have not debugged this any further.
>>>
>>> It is weird. Actually, I didn't change the behaviour of the page migration.
>>> This feature is default off. If you want to enable this feature, you can pass
>>> "hugetlb_free_vmemmap=on" to the boot cmdline. Do you mean that the
>>> success rate of page migration will decrease when you enable this feature?
>>> The rate will increase if disbale. Right?
>>
>> I have done the test and found the issue. Because unmap_and_move_huge_page
>> always returns -EBUSY. I will look into this issue in depth. Thanks for your
>> report.
>>
>> The return point is as below:
>>
>> if (page_private(hpage) && !page_mapping(hpage)) {
>>         rc = -EBUSY;
>>         goto out_unlock;
>> }
> 
> I know the issue. It was caused by commit d6995da31122 ("hugetlb:
> use page.private for hugetlb specific page flags"). The below patch
> can fix this issue.
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e7a173da74ec..43419c4bb097 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1290,7 +1290,7 @@ static int unmap_and_move_huge_page(new_page_t
> get_new_page,
>          * page_mapping() set, hugetlbfs specific move page routine will not
>          * be called and we could leak usage counts for subpools.
>          */
> -       if (page_private(hpage) && !page_mapping(hpage)) {
> +       if (hugetlb_page_subpool(hpage) && !page_mapping(hpage)) {
>                 rc = -EBUSY;
>                 goto out_unlock;
>         }
> 

Thank you Muchun!  That was my bad commit.
-- 
Mike Kravetz
