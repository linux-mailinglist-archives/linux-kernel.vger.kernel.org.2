Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8698A446599
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhKEPYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:24:21 -0400
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:63809
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233395AbhKEPYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:24:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+3TrLJy4hBCacuDXHJ2oyYr9bXsE1qRkSmoT1+5KDsEiREK/oUNqH0Q4zmk/9BBw2p8bSQLlZ9zv41fnp+nA5VlCvWygFlRdv2AT9uFFKmF4mHHYsPilCAKrAWyV/Qib2Tj4ATloCCS4lnjEW7KnlRbKz7a3lICsY4BxZEbaA6iscD1+hcj1vp4bKOl7qJSm5o5kCRCxkTMd74BuNoGZWI6mryyq5zx/d2dJ1Ti5jZE8j+qyRDRXcr937eG0+jWKDw0ducWphY632JaLazuYP3BSBQpWcEdoK3++/seWLj8RfxHtHxaBRCfen/eXSDibKB5OCodwDIrkiw8bZ+UOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvO1VJzGifgMUXoHBQSmCqN8TvCEMZYuDlE+UKA7glE=;
 b=ltYNOvZ+8WaAZ/ePvxdAJdWmneS3r//c7kDkeLn8uvnKqAyIdu5aykIVaMOeyEsHjem6y1zhteE6x0a9t9Ox7WecoQRZWjt4vGE2G0zS3QesalPkAjYVbMw/hBapePW8MJAhWtnQJbo+67Uikyd1v+CdqpnTO7Ti4NayMbX+4x/CzS6xfIKHaDZWOerZ1xUPbyF0TdvtABg6rY4YkqGKDHP/TRD5WsmkQMRxkIKAyrSCs7YyIHHAiLVxvq/QTMx4KSDTL7AqMgItNnaD7k9M8ldxGhwFnjI7fVZxaL2bRjb4tMu8lyttIMxQAbaofSFNFi+lXBVhvcFDYFIJdAhxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvO1VJzGifgMUXoHBQSmCqN8TvCEMZYuDlE+UKA7glE=;
 b=JDcGZRFbJ8UBqyCJPs6XTW167NRD+icyKiVh+r9Q7aVGDvf+sj7YqQCM9K51rmhetzn2jiXKlTKk3eV/PPIvvTWOFE2ct1QXkcbCoGMTcFpAwl6bkdFgh/RxUndni929H41Zu2V8AGzJA9QbcQpzTVdE1JkcaPFGhmbZBTo7824Os3UlRJeqNGktCsnGj+8WL83hR0U55rfvo0sNQnhM7XN+uk9lLmQCGtweWHr8DeS8dHqSnRYcOY+SERi/2nQMsLZl2ASPHfgTVGxChTbejGzxts4jG533aEVrHEBxeK5bg+6DUwX5NHuV/gOejZrCz/5rYfd4JB1oFbBcD5AXow==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB2403.namprd12.prod.outlook.com (2603:10b6:207:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 15:21:37 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e%7]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 15:21:36 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] mm: migrate: Fix the return value of migrate_pages()
Date:   Fri, 05 Nov 2021 11:21:29 -0400
X-Mailer: MailMate (1.14r5839)
Message-ID: <6730F418-6BAA-435E-B790-7C77C22E21A3@nvidia.com>
In-Reply-To: <1b05ce4f-059e-94bc-3753-f11d0c32693d@linux.alibaba.com>
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
 <c838c56f12cd3e6c693c0b124a167fdc07f59fb6.1635936218.git.baolin.wang@linux.alibaba.com>
 <81ED0EF7-779F-4977-AF09-665FF750319C@nvidia.com>
 <1b05ce4f-059e-94bc-3753-f11d0c32693d@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_82E9F5A3-A02B-4D55-8CAC-77EC4B8185CC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:208:234::18) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
Received: from [10.2.56.203] (216.228.112.22) by MN2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:208:234::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 15:21:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96ac6d0d-de48-49aa-aa9f-08d9a06ff547
X-MS-TrafficTypeDiagnostic: BL0PR12MB2403:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2403F6FA6D3C5E2DDA052DA3C28E9@BL0PR12MB2403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxBjgVzxTIGmhNPJpCuKIYY8/bI7orSsP34OntEhgxe5IDgSKmPICEMHABK5o61pNIKTpzLvQRi5p9jBf3r/qgJ1w/wzbbj8XByIQ/dVF9HpxUodxG+uojq0Y3YJCTW51ceMOLDFNZkLIiI67cNLp4Y0pnfa1sBanA5WBcYu5HktLOiwjjR7b+IqhyVM3JDy/6XMdToCMYPt13fWesQMYnwrAM4kQyOTDjNllo2a+GRwCuvw/33Q8vnFT1PTW5S3PBqMuQdCSdRTdkxqCabJFySSDutI00bQv28d7i71XKzLhBR0XZO5MS7Hh7EF7URf9ZLPaboSVMpCy4NSJBLMpokqCtG5u96YNoGyk0ZDTa4m/lykGhQAOLrptAz06PRelozro093ERf/uD+R+rA5nZ4C6tRolnclhL804DUCYJqWlQJuSL9v+PKATOJO0HEnvczMMaRl83vWwtcaMxjpL/0JUqrvYwzLAtzVPtycWBGrlb7rsdT5IGgnZhTT9lJb+stq77qizqJOyDogRSgt/dqilrGR9jEgSSeuuYW0LInoWsbJ0sawXjouZYtehDBftMaM1DmA/WyvTmI752HA2qRyAYsqcadWs7hf6cQnXfIXNX5vEhOPVx5C7y233oUvH/BnbDazurN2W5TjQlq51Y8IQ4z24YsU/pDmjI5Fu6iRjveaJsXZXDIM07N/R4ccZmOPZ7eqys+w4ezlZkfsQDvp/BvnLblg5le3Kqivtjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(8936002)(36756003)(83380400001)(26005)(186003)(2616005)(6486002)(956004)(6916009)(4326008)(6666004)(38100700002)(2906002)(33656002)(66556008)(21480400003)(16576012)(316002)(66476007)(30864003)(5660300002)(8676002)(508600001)(86362001)(66946007)(235185007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L3bc3NaE0AB8bX5+gTUWxdkGlig+dMcJLZP74YRuDlFcoG9m2Z0BBjhP+Bw/?=
 =?us-ascii?Q?InS68giBIi5R3xd0M8atzV6/Qg2cFID0u4gvg13Fe3LmPUL4mdZdPoOVULG0?=
 =?us-ascii?Q?JJPZ3BhGa2zwI1qb/teVryYhVr/WTw4OVWIKFLHG3e19zM1VZsQNgrC7VIcW?=
 =?us-ascii?Q?u5ESz2CgMoodpBTxwvHhzVgbTBbAYSohNNkM93ELybrPyFaBBRGEqFMi4gk8?=
 =?us-ascii?Q?2BmMG1VbzSFEN1k5cQlredYIZRVHO5Hk0SI68ISmWSDrrIpGQnn5oZuE7/GS?=
 =?us-ascii?Q?F2skYnn6/MCynsKSp9lynr4gISWW7cTcjEHEJbT+QsPZYcbZr6h95h/pojm0?=
 =?us-ascii?Q?e/2+wQin0cs98oww5JPkfUlaJGjUNhZ+MXYqdH0cDIwm1bakWCx+VnSR7yQB?=
 =?us-ascii?Q?yLmyjXmQVyAvoRPhTbatFt1enmS+k4xSADfSIBW/LRNZJw+OyjJvU5KcEueS?=
 =?us-ascii?Q?SPYtONNdVuAf30t+1eJJvit1pxtPZQJx92wGGr6Oz8hoxBFYXjbk993+/ZN4?=
 =?us-ascii?Q?3E5X8OIt1Tgoa62fHv+sotSTvO37bgaIKnVmUEthxL3afjAbfu0QpR/o34VM?=
 =?us-ascii?Q?ipS0LgafeHQv9m1Ndo1vLAxFF/ObIodv0N+eY0Oe8GblTe2HCIERGOuXrXLv?=
 =?us-ascii?Q?luy2SAh2GMtBNxeK2frhy/Ui7UIbjZdejN9WQ1h3CdH8l/KmV5KT7oOVCnXL?=
 =?us-ascii?Q?MlUp4s9XzBA47yerim2HZCTDuQDEWG6Ae1MeCBrSBzwkzKzImk4mNXh+QjHO?=
 =?us-ascii?Q?ZttdrGJfLXYY1snkERfWT/6+OlJjfTfmTykm8famjEazLuh1yQA0S16LUvFS?=
 =?us-ascii?Q?I+LZ5JPAyKUZzGneLXGG+GlECZhFbDeBgck92zqCuCrm4M8rEmkv4KfFN+j6?=
 =?us-ascii?Q?mEHLYbUr2ZQ3aNqYuupmT6FFuTg4/mkuAt84wPjDcdNAbwoycSXEKGhckEhZ?=
 =?us-ascii?Q?w/cNoWb27NIFvBG/Hk0EmmUhUpAT/4KxER32ET6V0NEf2CPmZXDoPJJPFKgC?=
 =?us-ascii?Q?q/jboLgcRAB4ecJgv5srEQ9nfQbHPWFJNJs0e4JTlde0prj4eXggFCSZHl55?=
 =?us-ascii?Q?9qMMcUELH5UOMTkSNav5QcLdhHdu5BXqaI4U7h2VMrZ9/33UIIHnDFk/EXxM?=
 =?us-ascii?Q?SUu3bg9U/5LS0AiLDn3gVjAYGEgOepYyBxkG9VNuUOhc98j/nr3OcC6Hz3/C?=
 =?us-ascii?Q?nckexZ+0ise3N5mmjmx7IteoHwOOieKV8NjXhhFhprBsiU9PnhE+S4NisEb8?=
 =?us-ascii?Q?Z6XCFKMtn+hOsveC2KH+rI1H7PKUDY4HXgSdBdU4DQHdu1gv269fzfHfg4Rm?=
 =?us-ascii?Q?aHFXGDJ/XHsDlU8T3qbDxKEJO+B0jCKrZueat8ySo2sY6YjIjYK1kbsoX4l3?=
 =?us-ascii?Q?ZbxHCihW6A1CYwbB5JNsKtKhjbrWOM7yjW9DIKe0a8tcy5g6X2Nn3aXyw6g9?=
 =?us-ascii?Q?R+u9oYmRyEfxbUige7L4cIWSOszEDrwjwVdJ4qApOmhBBTr4cJbXz7YCph3l?=
 =?us-ascii?Q?607i9VfE8sdrmcv/b3rFYZJicpSca5Fc5+yxvzEZYB9YQ7QPlQ1SLIuP5IEk?=
 =?us-ascii?Q?unGvs61eyxi5Nqt+UMk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ac6d0d-de48-49aa-aa9f-08d9a06ff547
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 15:21:36.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2GWzhfOm0Cjyog+eH72LpbJgk48HiKU0E71SDMCTN8o1Nb1GxduNl8lH9+6UHom
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2403
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_82E9F5A3-A02B-4D55-8CAC-77EC4B8185CC_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 5 Nov 2021, at 6:17, Baolin Wang wrote:

> On 2021/11/4 23:33, Zi Yan wrote:
>> On 3 Nov 2021, at 6:51, Baolin Wang wrote:
>>
>>> As Zi Yan pointed out, the syscall move_pages() can return a non-migr=
ated
>>> number larger than the number of pages the users tried to migrate, wh=
en a
>>> THP page is failed to migrate. This is confusing for users.
>>>
>>> Since other migration scenarios do not care about the actual non-migr=
ated
>>> number of pages except the memory compaction migration which will fix=
 in
>>> following patch. Thus we can change the return value to return the nu=
mber
>>> of {normal page, THP, hugetlb} instead to avoid this issue, meanwhile=
 we
>>> should still keep the migration counters using the number of normal p=
ages.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>   mm/migrate.c | 18 ++++++++++--------
>>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index a11e948..00b8922 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1428,7 +1428,7 @@ static inline int try_split_thp(struct page *pa=
ge, struct page **page2,
>>>    * @mode:		The migration mode that specifies the constraints for
>>>    *			page migration, if any.
>>>    * @reason:		The reason for page migration.
>>> - * @ret_succeeded:	Set to the number of pages migrated successfully =
if
>>> + * @ret_succeeded:	Set to the number of normal pages migrated succes=
sfully if
>>>    *			the caller passes a non-NULL pointer.
>>>    *
>>>    * The function returns after 10 attempts or if no pages are movabl=
e any more
>>> @@ -1436,7 +1436,7 @@ static inline int try_split_thp(struct page *pa=
ge, struct page **page2,
>>>    * It is caller's responsibility to call putback_movable_pages() to=
 return pages
>>>    * to the LRU or free list only if ret !=3D 0.
>>>    *
>>> - * Returns the number of pages that were not migrated, or an error c=
ode.
>>> + * Returns the number of {normal page, THP} that were not migrated, =
or an error code.
>>>    */
>>>   int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>   		free_page_t put_new_page, unsigned long private,
>>> @@ -1445,6 +1445,7 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>>>   	int retry =3D 1;
>>>   	int thp_retry =3D 1;
>>>   	int nr_failed =3D 0;
>>> +	int nr_failed_pages =3D 0;
>>>   	int nr_succeeded =3D 0;
>>>   	int nr_thp_succeeded =3D 0;
>>>   	int nr_thp_failed =3D 0;
>>> @@ -1517,7 +1518,7 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>>>   					}
>>>
>>>   					nr_thp_failed++;
>>> -					nr_failed +=3D nr_subpages;
>>> +					nr_failed_pages +=3D nr_subpages;
>>>   					break;
>>>   				}
>>>
>>> @@ -1537,7 +1538,7 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>>>   					}
>>>
>>>   					nr_thp_failed++;
>>> -					nr_failed +=3D nr_subpages;
>>> +					nr_failed_pages +=3D nr_subpages;
>>>   					goto out;
>>>   				}
>>>   				nr_failed++;
>>> @@ -1566,7 +1567,7 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>>>   				 */
>>>   				if (is_thp) {
>>>   					nr_thp_failed++;
>>> -					nr_failed +=3D nr_subpages;
>>> +					nr_failed_pages +=3D nr_subpages;
>>>   					break;
>>>   				}
>>>   				nr_failed++;
>>> @@ -1575,8 +1576,9 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>>>   		}
>>>   	}
>>>   	nr_failed +=3D retry + thp_retry;
>>
>> This line can probably go away, since we do not want to count retried =
pages.
>
> OK.

My bad, I misread the code. This should stay, since each -EAGIN does not
increase nr_failed or nr_thp_failed and after the for loop, retry and thp=
_retry
give the number of pages that fail to migrate after 10 retries.

>
>>
>>> +	nr_failed_pages +=3D nr_failed;
>>>   	nr_thp_failed +=3D thp_retry;
>>> -	rc =3D nr_failed;
>>> +	rc =3D nr_failed + nr_thp_failed;
>>>   out:
>>>   	/*
>>>   	 * Put the permanent failure page back to migration list, they
>>> @@ -1585,11 +1587,11 @@ int migrate_pages(struct list_head *from, new=
_page_t get_new_page,
>>>   	list_splice(&ret_pages, from);
>>>
>>>   	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>>> -	count_vm_events(PGMIGRATE_FAIL, nr_failed);
>>> +	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
>>>   	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>>>   	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>>>   	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>>> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
>>> +	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succee=
ded,
>>>   			       nr_thp_failed, nr_thp_split, mode, reason);
>>>
>>>   	if (!swapwrite)
>>> -- =

>>> 1.8.3.1
>>
>> Thank you for the patch!
>>
>> In general, this looks good to me. But like you said in other email, w=
hen a THP fails to
>> migrate and gets split, the number of nr_failed will still be inflated=
 by the number of
>> failed subpage migrations. What I can think of is to split THPs to a s=
eparate list and
>> stop increasing nr_failed when the pages from the new list is under mi=
gration. Let me
>> know how it sounds to you.
>
> Thanks for your patch, but I think it does not cover all the cases.
>
> Firstly, what confuses me is that if we return 1 to users when failed t=
o migrate 1 THP page, but actually we may have migrated some normal pages=
 successfaully if the THP page is split. Anyway we can add some comments =
for migrate_pages() to explain it if this is acceptable.

Sure.

>
> Another concern about your patch is that, if the first round migration =
all pages are migrated successfaully (nr_failed =3D 0), but if failed to =
migrate the subpages of the THP in the second round, we will still return=
 0 to users, which is incorrect. Further more, if the

Ah, I missed this. We should increase nr_thp_failed when THP is split.

> subpages of the THP are migrated partially in the second round, what th=
e number of non-migrated should be returned?  Suppose multiple THP pages =
have been split?

Assuming users do not know/care what kinds of pages are in their migratio=
n list, we can
just return 1 if a THP is split, no matter how many subpages are migrated=
 successfully.
If they do want to know the details, they probably can check the tracepoi=
nts.

>
> Last concern is that, we will try to migrate subpages of the THP in the=
 second round, but if some non-migrated pages are still remained in the '=
from' list, we will do another redundant migration for these failed-migra=
tion pages and no failed counting for them. We can fix this issue by movi=
ng the remained non-migrated pages to 'ret_pages' list, which will put ba=
ck to 'from' list when returning from this function.
>
> if (!list_empty(&thp_split_pages)) {
> +	list_splice(from, &ret_pages);
> 	list_splice(&thp_split_pages, from);
> 	no_failed_counting =3D true;
> 	goto thp_subpage_migration;
> }

You are right. At this point, pages in the from list have been retried 10=
 times,
no need to migrate them again.

>
> The concern 2 is more complicated, or we can just use 'nr_thp_split' to=
 return if some subpages are failed to be migrated to simplify the case, =
no matter how many subpages are failed?
>
> rc =3D nr_failed + nr_thp_failed + nr_thp_split;

Like I said above, I would just increase nr_thp_failed when a THP is spli=
t. Here is the patch
I come up with based on your feedback above. This time I incorporated you=
r patch above. Please
let me know how it looks. Thanks.

diff --git a/mm/migrate.c b/mm/migrate.c
index 1852d787e6ab..a5fad22259a3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1429,7 +1429,7 @@ static inline int try_split_thp(struct page *page, =
struct page **page2,
  * @mode:              The migration mode that specifies the constraints=
 for
  *                     page migration, if any.
  * @reason:            The reason for page migration.
- * @ret_succeeded:     Set to the number of pages migrated successfully =
if
+ * @ret_succeeded:     Set to the number of normal pages migrated succes=
sfully if
  *                     the caller passes a non-NULL pointer.
  *
  * The function returns after 10 attempts or if no pages are movable any=
 more
@@ -1437,7 +1437,7 @@ static inline int try_split_thp(struct page *page, =
struct page **page2,
  * It is caller's responsibility to call putback_movable_pages() to retu=
rn pages
  * to the LRU or free list only if ret !=3D 0.
  *
- * Returns the number of pages that were not migrated, or an error code.=

+ * Returns the number of {normal page, THP} that were not migrated, or a=
n error code.
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
                free_page_t put_new_page, unsigned long private,
@@ -1446,6 +1446,7 @@ int migrate_pages(struct list_head *from, new_page_=
t get_new_page,
        int retry =3D 1;
        int thp_retry =3D 1;
        int nr_failed =3D 0;
+       int nr_failed_pages =3D 0;
        int nr_succeeded =3D 0;
        int nr_thp_succeeded =3D 0;
        int nr_thp_failed =3D 0;
@@ -1457,13 +1458,16 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
        int swapwrite =3D current->flags & PF_SWAPWRITE;
        int rc, nr_subpages;
        LIST_HEAD(ret_pages);
+       LIST_HEAD(thp_split_pages);
        bool nosplit =3D (reason =3D=3D MR_NUMA_MISPLACED);
+       bool dont_count_failed_subpage =3D false;

        trace_mm_migrate_pages_start(mode, reason);

        if (!swapwrite)
                current->flags |=3D PF_SWAPWRITE;

+thp_subpage_migration:
        for (pass =3D 0; pass < 10 && (retry || thp_retry); pass++) {
                retry =3D 0;
                thp_retry =3D 0;
@@ -1512,18 +1516,21 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
                        case -ENOSYS:
                                /* THP migration is unsupported */
                                if (is_thp) {
-                                       if (!try_split_thp(page, &page2, =
from)) {
+                                       nr_thp_failed++;
+                                       if (!try_split_thp(page, &page2, =
&thp_split_pages)) {
                                                nr_thp_split++;
                                                goto retry;
                                        }

-                                       nr_thp_failed++;
-                                       nr_failed +=3D nr_subpages;
+                                       nr_failed_pages +=3D nr_subpages;=

                                        break;
                                }

                                /* Hugetlb migration is unsupported */
-                               nr_failed++;
+                               if (!dont_count_failed_subpage) {
+                                       nr_failed++;
+                                       nr_failed_pages++;
+                               }
                                break;
                        case -ENOMEM:
                                /*
@@ -1532,16 +1539,19 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
                                 * THP NUMA faulting doesn't split THP to=
 retry.
                                 */
                                if (is_thp && !nosplit) {
-                                       if (!try_split_thp(page, &page2, =
from)) {
+                                       nr_thp_failed++;
+                                       if (!try_split_thp(page, &page2, =
&thp_split_pages)) {
                                                nr_thp_split++;
                                                goto retry;
                                        }

-                                       nr_thp_failed++;
-                                       nr_failed +=3D nr_subpages;
+                                       nr_failed_pages +=3D nr_subpages;=

                                        goto out;
                                }
-                               nr_failed++;
+                               if (!dont_count_failed_subpage) {
+                                       nr_failed++;
+                                       nr_failed_pages++;
+                               }
                                goto out;
                        case -EAGAIN:
                                if (is_thp) {
@@ -1567,17 +1577,34 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
                                 */
                                if (is_thp) {
                                        nr_thp_failed++;
-                                       nr_failed +=3D nr_subpages;
+                                       nr_failed_pages +=3D nr_subpages;=

                                        break;
                                }
-                               nr_failed++;
+                               if (!dont_count_failed_subpage) {
+                                       nr_failed++;
+                                       nr_failed_pages++;
+                               }
                                break;
                        }
                }
        }
        nr_failed +=3D retry + thp_retry;
        nr_thp_failed +=3D thp_retry;
-       rc =3D nr_failed;
+       /*
+        * try to migrate subpages of fail-to-migrate THPs, no nr_failed
+        * counting in this round, since all subpages of a THP is counted=
 as
+        * 1 failure in the first round.
+        */
+       if (!list_empty(&thp_split_pages)) {
+               /*
+                * move non-migrated pages (after 10 retries) to ret_page=
s to
+                * avoid migrating them again.
+                */
+               list_splice(from, &ret_pages);
+               list_splice(&thp_split_pages, from);
+               dont_count_failed_subpage =3D true;
+               goto thp_subpage_migration;
+       }
+
+       rc =3D nr_failed + nr_thp_failed;
 out:
        /*
         * Put the permanent failure page back to migration list, they
@@ -1586,11 +1613,11 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
        list_splice(&ret_pages, from);

        count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
-       count_vm_events(PGMIGRATE_FAIL, nr_failed);
+       count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
        count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
        count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
        count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
-       trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,=

+       trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succ=
eeded,
                               nr_thp_failed, nr_thp_split, mode, reason)=
;

        if (!swapwrite)

--
Best Regards,
Yan, Zi

--=_MailMate_82E9F5A3-A02B-4D55-8CAC-77EC4B8185CC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmGFS/oPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKttMQAK0QPqHW7YNFJ16Ga0EC+OQ9dxQnV1St2+hJ
Z2gQMMxxi1nw3jrht3Ly3UrLxtRBrtJG1UphkNwuszxhna5EYK0Pk9zKASkowP+i
jZJjSmc1Z2s+jc3P1Z9N6OhAiGeOJHbmvR6xhbgmY+tEOlGzRC8Iq2Btt5IFut1P
3Z2/0NNmASdi/4o7VI2+Bfv57g6LFT5FGEcSC2vrGaYn20KOAIkBMJb/USzY33oL
d9sMrM08nDw2hRbLdmYdzONz1CXy5a/K/AI6Iz6803kq35v+Vl+rmyXBtVts3m+T
ISOnbbIpo1j1dzRPp0QbE9vOISnchmajZTSwmdD80Su+iAgyJESeTC5buJIcchId
YLSyDru5O1x3KdyAUZNftqd4yjdQEYENXi5jdMj+s6KTSHQojyTsYAb9TN0L1ZUS
GlxCkTqv0ZPgzhZsxBxzDowsxlbrImi9XhdvMl+twqmhvyJv5UTW2XG1ZRy/gD31
C4xK1BQcA/aC9FfQIDZjWdxI7cnqFOkM9/8wxoYwak4ZHEJNZTUuhiCnvUJwnVTc
9kKv/e+QMareZF6jhvmmMaWkvEJvOVw0N9AJ/He59A+DWvpSQOCfCPNhuoUw+VDL
U/RWRhjxMe34bKY1XslDqyluKnjL2scsSMzrGFn6qybwyR43k3BDOz+bqyt+4KV7
KrcG0l2H
=2SMS
-----END PGP SIGNATURE-----

--=_MailMate_82E9F5A3-A02B-4D55-8CAC-77EC4B8185CC_=--
