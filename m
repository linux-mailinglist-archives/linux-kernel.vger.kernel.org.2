Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06303258F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhBYVpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:45:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56638 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhBYVo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:44:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PLTacB022585;
        Thu, 25 Feb 2021 21:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KhfZtiJsUCq9NleuxQLQAP4MCIdxj1iF+lpOWj0oVDk=;
 b=I8pvLvXSbjZJaENSs5nT5o6eG2tq9kucwmAjalm4WtOsNxvOmVu7X48m/VOfIVRm1Ypi
 aEHYNeJP8pGn34yr6w9zdKRqkZd/71q5DbYsiZrdd8OAq8wXL8r1iJhb8pHetSwAuNPd
 ZUJWHx6P3OouP2/Y/b0PwY6KldGs6UPCXg74v1MrpWGz1W7hwdUn3BWb7k/3hpXY2OoG
 b8jFkwImymEl0oUIHNUdmezepwEARs9vQkcnIBuiIWlTIITreYo8bK9xu2vJKpqeZRpS
 HhMKqMUItrh/IABGoW7zM+a9cMZ/mFUIFza1dfilIDgsGM1lUN47vaOcyXK1tUSND/S/ Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36ugq3pwu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 21:43:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PLUiVk109928;
        Thu, 25 Feb 2021 21:43:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3020.oracle.com with ESMTP id 36ucb2kstg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 21:43:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBkIGdNkMPkZxsVXrKa6t85LiADmlb4DTHUhJKgNPk6dPi9s0EX5NDsJkiT9JhTfP7318UnkfMTe7TT2sFMClJkzTgIXXV65iX/Z3AEA5+ofRnfdNOgcY2NnrcWoP/+PTL+qK3XSdacBEofy82kbSSQgOpGYG25xbcsO7WW8WizDtxN12b9QYQ2CeLgvI5Iomge7Xs9Tpy7kZfnCHUXi5ZPwGLAzZWHMJhz2klxTBOq49oKYYoG3HiFXhZ0CHQtfRTdPLt4XdlJzaAgxogILZy5JzxVwpMD4tbFhce0PQP4BfpdF+ksaC0Xen5QonowobkQvithsex1TqFkhBvk4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhfZtiJsUCq9NleuxQLQAP4MCIdxj1iF+lpOWj0oVDk=;
 b=NT29Wrr//elOsC0tl0O+Mqr/OCsYjRAKbwCz4xtyIGTb2TTzgd4pd7qZNxg8Gwpm93AkGYU/Wi54c//VMXxG6crJsRgLcmsIj9lPCYeKnt1FKIay2NejgWbgNFXLeLjTB5/3w7g3YpBEeHD5IKHj7S017sunnDx2EkECVPyePFuLxNQFu2kPnV9TXKiqRWwXCMrq9p3ojM8bdbC9r+NtpGoq9Fk/+JdOkspc/LGzNKhy1YAGDPw+UfVh+orZI+7cgf1gRwnbOUhvkdauC076T7M0/TuEApMPISFw7RVlZZNZwVj4qLekDt6buXYBaDw8/6uOKkaWgbn9jIJ6QNU5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhfZtiJsUCq9NleuxQLQAP4MCIdxj1iF+lpOWj0oVDk=;
 b=al8uZagU5MJQzwOqz6JLeUP8LmRqNqrgbdzq+mUDBMYaxzAzZ1t+9Labce1Fn4iEabdQBTVKxiAJaPUW70fMuesYP21N4MCdn7NGnJdSf/L59Ok4m5lhzgt43z63n2y2qFD7D+kzyEK4+84ha2V/wvpdVa0cna2UVU2mnF6hKl4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2823.namprd10.prod.outlook.com (2603:10b6:a03:87::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 21:43:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 21:43:30 +0000
Subject: Re: [RFC PATCH 2/2] mm,page_alloc: Make alloc_contig_range handle
 free hugetlb pages
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210208103812.32056-1-osalvador@suse.de>
 <20210208103812.32056-3-osalvador@suse.de>
 <9ed946df-9c6c-9a4d-4be9-2f32809974f7@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b4bf7fcf-449d-daed-e490-994b1072652a@oracle.com>
Date:   Thu, 25 Feb 2021 13:43:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <9ed946df-9c6c-9a4d-4be9-2f32809974f7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0031.namprd18.prod.outlook.com
 (2603:10b6:320:31::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 21:43:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11ccb53c-e521-4a2a-cf69-08d8d9d6644a
X-MS-TrafficTypeDiagnostic: BYAPR10MB2823:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2823F8F31226F3B4E892D8E5E29E9@BYAPR10MB2823.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYL1U7K2Oca8bUYhZ/PGv6OAgcUi/YvGbeNtVoeJUOkV7ietkbNG9v31ve2smvMIahy81V8iDmmhlnopzEC1DYkBxIeMi8yiCKmt+xjhuFOknJUXd2xmgZEM2awn+9b2PN4IwAaK75Q7R6fvnFAYbs9Ye9oMZMgsHC6AfiDl+acpcAX0LsPZ/WOR6lg24srLEt5hN+6pp+takYzdEidN1UBM6kQDaFOrgM8g/dTbAeFbYItzeMNBxL6DbMAZ9JlApIs1hLNk3SNdAcwttZ/DOQQe6iZFvoGr0x/iAPtDDvZYB3ljKdwjFZ/IxTOph93mRNPwXu7b95qsVWm0PlS+OlweUG9n1z+AHFDO+GH+8F5HzUSKlPxyyZNkc00IBy8AQNVgF924cCZBkuXNgBv4nQED+/XYzluAjpM986xanaZZlnhfnxl/Jq3Nz/e9CYBCzoadX/xPpORQHIeHfMpLkskKFyttsydQr0ax9vKRsuLxvqdbESHywZ//7u0d0sCzhYGF0xKob6QEYriS/lvmBZYPKhtGt4r1TOoSSLetmrno3uIw4inEcbMIZ/xQldscwXLSlGs3W22Jb/5L308G1vdp2Pk7ZxG5uS429h9biqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(39860400002)(366004)(186003)(66946007)(53546011)(86362001)(478600001)(4326008)(316002)(16526019)(31686004)(26005)(2906002)(52116002)(66556008)(5660300002)(110136005)(2616005)(956004)(8676002)(31696002)(66476007)(83380400001)(8936002)(36756003)(16576012)(54906003)(6486002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YXk1S1NLb0JXVU1teFlxRjJWeVNRRE9zMjBNa3d3SWZQVitKK2Evc1J3NHRO?=
 =?utf-8?B?UTN5VTFxYVdTR1hPVjFpTnNTYWx1eS9QWFA3RFhvUytsSHFNOWprK0RIN1B0?=
 =?utf-8?B?enhQSVRTVGtVT0RWNXU2dzRnNkN1WGJMZnR4ejljdVdiK2lleEEyWTVDN1hJ?=
 =?utf-8?B?blp3ZzF5SGF0VHUyVUtJTk5Qb0tsMzl1UEcvS29RSm5mWGtTTUNCczdHb3Y3?=
 =?utf-8?B?VzZ3K000WFdzNWo1ZE9ESS9VTFZSTmtTWlM5MDhzQVlIZEpkZ083MmJnYmFy?=
 =?utf-8?B?aGNJajdYbDhmdTBXd3pudkluM2NHUThVU0czQjQ5U000TXhocTJsdm5GdGRq?=
 =?utf-8?B?azA5L3FLelFMUW0xQkxWWlhwQUc2N3Y5V0UxMkhBS3crdjVjWk5hVS9KRXZB?=
 =?utf-8?B?ZmdyM0tBbTNEUEVBVVNjNDVNb0lxSWhyb2U0cDlsOXpibjJlT0oyVHNZekZo?=
 =?utf-8?B?aFdzZUhTK0N4bGVrYndHeE5mWGZCUCtMSU9lN2Q5SGFGdXBQYXFLbWFFYkl1?=
 =?utf-8?B?S0VIZjM5Yk1wdDNQcU9LREVmTUZpVytqTytZMFRHK1VudU0wbVJscU8yS3NG?=
 =?utf-8?B?cnpNdVVYdm5oQ2dxVGU4dklkRElGRW9LY3hndndGTlNPN2RGRkpxNitNUk9L?=
 =?utf-8?B?cEEzU1E0cnptWS84bDZkeGpWbFhvdXJmUERWWDFmODlpUXp4aTdFa1lRV0x5?=
 =?utf-8?B?aTNUdUZzczBXUGVsMGtqR0s5Z1pCME1pem8yc2NjZXVzNnFIenVrL0RDN254?=
 =?utf-8?B?VkVNeElud0FIMG5LU1NrSVdRTFl1RXZtaVhRc0VMS3N0N2pDdE5qS29VTm5Z?=
 =?utf-8?B?UnhUTjQ1Q2lKblNXR1dXelJ6WjRXc2Uzdi82cHp5andic25jR2ZxNWdVcmlv?=
 =?utf-8?B?STRuR2t6VU5uY0hOb2czUzBVNm1LbEErTmdsbjFsU1pHZ2RzdDlyUkRvak1H?=
 =?utf-8?B?RGJjdmNmdUd3ckZud3FxUUhmK3hqM21pNy9jVEQrWW90YkFFSDVmdlZkYjBE?=
 =?utf-8?B?V1BiRWg4YlpCZ1ZPNzM3NXlHa0dYdlhIRWYzTkZ5NzI1eDZ1QXZqWXpNeGo3?=
 =?utf-8?B?cUdYRjJkeWM4bUliYjFqN0FWVVUvL1ZaLzRHcE0wSEZCcks2MnJVS2dIVkpZ?=
 =?utf-8?B?cGo4anhFOEdFa1RLWU9jUXdLU3NVWEg1c0ttWVRzdmdXODZvd2YrdGluMkdE?=
 =?utf-8?B?MWE0L2FYcHNpV2ZrUkRMMzladnV2OTAzbC9mVjBvcFBVYmtQT3o2Y2oxaWdO?=
 =?utf-8?B?WG1QTGl0NnBPOHJJUWpoZ3VvaG1najE1T3QwZE1wWk9MRVBtMjUxVzl5b1RQ?=
 =?utf-8?B?aW1QdGU1alVRMjQyVXBuaGZkc0NBdklGM1lUc25QbjhGeVFvd1UzMUdnSlRO?=
 =?utf-8?B?VXhXaTY5YTAxT0xUSEg0MnZ4ZTkrLzB6S0toM3dqRlIwc0NMUi9MTGdIVnBh?=
 =?utf-8?B?WmNwajFhQUE4ZlFxV1lXUmRtaGdNRGIyaGxqVGJyVXc3L3pibmNlRlR6ZnU2?=
 =?utf-8?B?Wm82Q3VpRzNseUczM3U0bGhIZGZrbUNuSVZieWdiVXZlSlJDRXRsVXFWYjg0?=
 =?utf-8?B?cmYxQzNHNE4yK2dXUkNtUmE4VDR3S3NhZlAyY3pQeSt6RTg5RThTbFJTVS81?=
 =?utf-8?B?dmQvbTFFRUJzbUJEcG45WjZTL0ZzZmVnVXpYWkJIQVVWZHNxWnV5KzZ5YVM1?=
 =?utf-8?B?KzBGa0gwSmhYbWZQVnROQndwU2d5WmNUckp4bTJ5KzNmRnlCeFNXTDNaMkhN?=
 =?utf-8?Q?SLxtb/WWhC4cWkM/vYOUY/VKT1DZ0yEOvJgUMRf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ccb53c-e521-4a2a-cf69-08d8d9d6644a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 21:43:30.8210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgXbi3Cbs7yx/TB9LJHmpKH010QYi+g4Xf05n42Rv91hCp66DhsWiEtNHhN5W4ZNRBRQ+/Rm3tktR5ih+AhZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2823
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=991 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250163
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250163
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/21 12:23 AM, David Hildenbrand wrote:
> On 08.02.21 11:38, Oscar Salvador wrote:
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -952,6 +952,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>                       low_pfn += compound_nr(page) - 1;
>>                       goto isolate_success_no_list;
>>                   }
>> +            } else {
> 
> } else if (alloc_and_dissolve_huge_page(page))) {
> 
> ...
> 
>> +                /*
>> +                 * Free hugetlb page. Allocate a new one and
>> +                 * dissolve this is if succeed.
>> +                 */
>> +                if (alloc_and_dissolve_huge_page(page)) {
>> +                    unsigned long order = buddy_order_unsafe(page);
>> +
>> +                    low_pfn += (1UL << order) - 1;
>> +                    continue;
>> +                }
> 
> 
> 
> Note that there is a very ugly corner case we will have to handle gracefully (I think also in patch #1):
> 
> Assume you allocated a gigantic page (and assume that we are not using CMA for gigantic pages for simplicity). Assume you want to allocate another one. alloc_pool_huge_page()->...->alloc_contig_pages() will stumble over the first allocated page. It will try to alloc_and_dissolve_huge_page() the existing gigantic page. To do that, it will alloc_pool_huge_page()->...->alloc_contig_pages() ... and so on. Bad.
> 

Sorry for resurrecting an old thread.
While looking at V3 of these patches, I was exploring all the calling
sequences looking for races and other issues.  It 'may' be that the
issue about infinitely allocating and freeing gigantic pages may not be
an issue.  Of course, I could be mistaken.  Here is my reasoning:

alloc_and_dissolve_huge_page (now isolate_or_dissolve_huge_page) will be
called from __alloc_contig_migrate_range() within alloc_contig_range().
Before calling __alloc_contig_migrate_range, we call start_isolate_page_range
to isolate all page blocks in the range.  Because all the page blocks in
the range are isolated, another invocation of alloc_contig_range will
not operate on any part of that range.  See the comments for
start_isolate_page_range or commit 2c7452a075d4.  So, when
start_isolate_page_range goes to allocate another gigantic page it will
never notice/operate on the existing gigantic page.

Again, this is confusing and I might be missing something.

In any case, I agree that gigantic pages are tricky and we should leave
them out of the discussion for now.  We can rethink this later if
necessary.
-- 
Mike Kravetz
