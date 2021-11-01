Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278B7441D32
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhKAPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:14:57 -0400
Received: from mail-co1nam11on2043.outbound.protection.outlook.com ([40.107.220.43]:26337
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231847AbhKAPOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:14:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFzma3XaicoIpJFOyT9G2rR8FyC5Boeu5F9ufhy27ptefoJuSdqWizumH3nuyifPZNExgWR9XFZZPhnFAXbHRp6GAPShmYVMZQVSXWJnedJoSxvkJdnJOqiWLvsoTCprNvT2DZ0858i0kf8249LVVPP8E2fW/P8cZIjKIRuw0EtokGZHYx48kYsMIEr2chVzsFm+6opm2SjWsH4tiQeNXQ1/joCHXjr9AwhbnuAaXGD89WBpNMIa5dQr2ySxufv4tncIn1FvmmSf7GMlTn4aKXFzbfl8us3ahw6i97g97MpbHhIWE+4em3AJwkTJkEAcb0N23NT9S1KYNhAzNSKFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mURpzbcfS44dOGJa7kJc+j0FuS5lybNgAqu4jEwIfHQ=;
 b=WVgk3vbX784GbttRz+IyBgT5hCWKpEKwuuH5mMDx6uRkcUuAjGbVgrTLmduhjT7Upvuzj+nIQOEVmS4MKyqY+ypI86qim46sGICvongQj1vDviuCQi+BO5LWP6AutGqgSoJjWDStE8BDOqysMeF/cA/pqimk7pkaHU0UUd8sxw6+FZCpo0/MPsWZ4bGFIYA7z4heYRzZwgPYM0a1wM5/LZ7xU9kk9+ZXCADhlXKN7+gcpgZHMUuSJ9XSICTf8wKX1V7aDuuSdxt3CHyREIdCNAl16VyEjs/aYvHsNwEbLYWdOcOBRePeEWTkvbIJ+o10rz3ebD64u/5v22ycL424kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mURpzbcfS44dOGJa7kJc+j0FuS5lybNgAqu4jEwIfHQ=;
 b=K3pQghiuGkq9yNwkOxXNh+ZywUjRVncasSIy8szDfsfz4igFnrjLmu+2umWrWEpBPHGK+6ebMvbNcOcf/I/USDJP6YkUjauOLTDyd+HPxhl/0RWjWC8FkeXpoz2Fa5WUwXi9cvzX3uiU/2+iPRBgOGIFuQARqfyxZohDtEX6LvzDU3lcoLDOqqi0D+38Cfx3segqs0gp3f13pZL7fHDzVu79bziKpz22aIc0zc/JwIgZy57/m2NE6Vodr2iTuTbg58fJA1ySGjWgMyxy9SoNjvTBXX66raGXvGU5PmPVKJwd1hi8gXyJ2sauUn9swJgbkKTKO0KRXGlR4wuOSGG+CA==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB2562.namprd12.prod.outlook.com (2603:10b6:207:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Mon, 1 Nov
 2021 15:12:18 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e%7]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 15:12:18 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: Correct the hugetlb migration stats
Date:   Mon, 01 Nov 2021 11:12:12 -0400
X-Mailer: MailMate (1.14r5839)
Message-ID: <D32BF8D1-E6E0-4535-B8C6-1F05842DB672@nvidia.com>
In-Reply-To: <29aa9c6e-7191-71bb-d8a3-e2695b18fa3e@linux.alibaba.com>
References: <b35e54802a9a82d03d24845b463e9d9a68f7fd6b.1635491660.git.baolin.wang@linux.alibaba.com>
 <677EF981-F33E-4002-AA38-DD669C319284@nvidia.com>
 <29aa9c6e-7191-71bb-d8a3-e2695b18fa3e@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2F515A58-743A-44D4-832F-C8DEE740E29E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0039.namprd15.prod.outlook.com
 (2603:10b6:208:237::8) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
Received: from [10.2.57.172] (216.228.112.21) by MN2PR15CA0039.namprd15.prod.outlook.com (2603:10b6:208:237::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 15:12:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aeaf9cf-21ab-4f58-028f-08d99d49feb1
X-MS-TrafficTypeDiagnostic: BL0PR12MB2562:
X-Microsoft-Antispam-PRVS: <BL0PR12MB25624927716829412E3662ECC28A9@BL0PR12MB2562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwE5cZM5QtiC1peBESG8oMgpxXHrelqN/TW7Nos0dDFEQ4Rsb8sQeeRtxlfWB4LGjNhlSn7h33kT4c5FWMobat7va91IJwAGYYCzJW/vCAJd3/I0K3YBo+IrvG40L86be8lfeAu91QjP8fOfUfInD11hVYi5Xt8hzHYFfZcgtVpODRwmQUGtqjb3coFxiwLoWLqq00X+Ts/uinOmCzl1xGsiqhJzukYON4wLg7nNhlSZPKd66XMGTNlw07469RTGiZpJnzJ3dbL5WaJK4A121e87c4nVhEh3I5LyMgZmeBNgO0eXttoSJedqdKyyfl4lYyGPLhME/n4T7ke+czW+oRFlPug7l67SOFSFrF6zfLcwN8Vj1lDJbH38r9GmB5aadYI1a7lKJcL6j/Nx9h31ZBhXbwn234MQ5Bbg0mwVjCIJsy05pvfuNQWe0pBxtmWZoA3jjvUvsbzm7jZmyqhyh3lfTncS7vhhKQz34GxqQI208PdBaC0RxsBB64zAX98xphpV9LTQFlGi/Z9OnfXPkhkswBqwJZXHOE2FCrDB/U6NgQrJ9XBpgOuICKqOpHlH/+TfxoKHWvFxAmlAIJ5F6cEcI6ui8F49S29+H7oz6Q/5MVevMAUXzn8TgBNHH/m69BFgq70fcSGEJvJL4ELzYe+ETgtaeyBsL3RSpqbuVqOuCXuJzXM5QeTwrY0nqObONwDsNWhdzldIRgvU+Z8dkWub6XljqXNOoXsSV/8h+0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(6916009)(508600001)(86362001)(66556008)(66476007)(186003)(33964004)(2616005)(16576012)(956004)(83380400001)(8936002)(6486002)(38100700002)(2906002)(33656002)(36756003)(53546011)(4326008)(235185007)(8676002)(5660300002)(316002)(6666004)(21480400003)(26005)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck1RNzlMMW9jc3IwdnU4V2lFcUpyb01tN2lIelhKS1ZSMTNVRWx3VFM2RTdy?=
 =?utf-8?B?QUI5WTFIclg0d2t4d1VjYVgxQnpwdmhVam4zck5FenRXTzNIT3B4YVA0ZGZs?=
 =?utf-8?B?QkFMUVlnYWQ2aGUxM2E1bWJFaFY4UVl2dFliVVo0NjJiRDZLdEV1ZUtCT0pZ?=
 =?utf-8?B?WFNTVGpFN2gzYWViMnVFZ1VkYTU5d29SVUhKR3drZHg2YnAra1RPaEE2VEMz?=
 =?utf-8?B?MkdNWnJmWXVBYkFrYW5OUUZqcjVTRWlJS01qQnYzcm5lNXd3U1BtVkZPMTl5?=
 =?utf-8?B?UnZybWNReW8ySXUrc1lIZHpmWXlzZzBMbGp2SlA5R2tYbk9nbUhrNlpZenZ4?=
 =?utf-8?B?YXlHejdJYkMrcWJ0S1lrNEY3L3NFaVlLZXowL2VuYTJBWXpibzNodkZQaWtD?=
 =?utf-8?B?UGJLYXhybytpSUxrYllXc0pMaXhZUXlFQzBGWm5xY2p6TE9SYnYwZlA5ZnEv?=
 =?utf-8?B?Y01JV2JPNjc1U2hkajFOaTJabFdrZlZiMytWSGZ6WHNlT2c5Yk50ZEVkY2Jo?=
 =?utf-8?B?S21jMXVaUUcxK3VwTkxhMVFZQnp0UTg0LzgvYU9DWVBiT0t5NDBERkoyNWR5?=
 =?utf-8?B?TFBlVFlrTU5oTGN6Y0IwbklTZzFnQnhEajFOdzgrd2U1Smp6Sm5MR2ptenFn?=
 =?utf-8?B?VGZ0NGEzSGdxR3JJU1lLMzRnRVUraU1ZbkQ4NXJTRU9adDRvOVA2Qlo1OU9h?=
 =?utf-8?B?OE01MUhZSTcwblU3THZ3dkN5bEUwKzVhQjZKZHkySFBUaFhZNFZqd3ZlV1FC?=
 =?utf-8?B?eVN6azYzZ2tncFVOQVpCNDBYMXhFV1BibnQ0VWliS1dPQzE0b2tlRU1VZytK?=
 =?utf-8?B?d3l1aG9QNjhvV0k1TVdYNUpHcWNHM3h1K1JMcm80cFQ0cjA1NEhpRU14WnFE?=
 =?utf-8?B?Tld4eG9BTDVmUjVqaHdoREJISkJUUG5HUndRNFY4N01ueVM5USswOGtab28z?=
 =?utf-8?B?VE9UYll3cEFvaWl5RjVyMm03UlU0V2pzSDFpZEd1TTc5cHJHMkdub3hqTHJW?=
 =?utf-8?B?WlhxbkpzTjFpTUxta0NOMWpQN3Uybjg3MWs2NEFKTlFiUTZMT2FzQ1NEd1I4?=
 =?utf-8?B?SVNWNE5IL25Yc3dabTczaU1COW56OUZpTVdiQm5qQXVWSEd5SlFjYW53b1Fy?=
 =?utf-8?B?NVRTYkJ4aWxsSndDZTdUTFh0TGRpWWNZNjdReUdkTmVicDd1NWNYOWFvOTZp?=
 =?utf-8?B?S1F2ek1LNU1yRkRTYU00RXZYOHl2WGF4dlpsSGdXZHI2LytBTUNrK0k4RnNM?=
 =?utf-8?B?Qmdsa2h6b0VmNjh1VFg4L2FQNTE3aW85dzNiUlF4VjZoQlJoR2VXc2ZXdDlH?=
 =?utf-8?B?cmtOemJpdStUZXpITkIxZENHQ05pSi9jTCtCMEU4dmplV3FRVmMrSG9IRFRi?=
 =?utf-8?B?QkVMdks1MGpvbWJ2VWlhWFh6VlpTeiswcldGcTd5Y0FPNWxGY1YvWDJVblpW?=
 =?utf-8?B?dkJ1NjBXd1lSVzBxbzNqd0ZQOWNqQjBtUzc4VjNUaFU4ZFBNUFErWXUzRHJy?=
 =?utf-8?B?bTRTOElocUtKc1NjbHZma1NKOVQycDRNOGI1aHphYTFXQjNWMWZZNFN0aDY2?=
 =?utf-8?B?Qlg0R29uL1ZhRjdscWd5NkRJYVV1MmdkdS9yVHFQTGM5VHJ4V3dLVTR3NzRY?=
 =?utf-8?B?Mm9tV1VxUllZTWd3S1ZzYVYrZ3EzVnFUQkNoRjNiemE0Nk5ycC9PNFcrSjA1?=
 =?utf-8?B?blhwUGFEcXB5Q0ZRZjg1cXNwNjFFakhEWC9sMVBYMW1VUFdBVkpEWXlFUXJp?=
 =?utf-8?B?NC81bXgzanRIck5LREFoZ1BMcTAyejBqMm1TQ2EwYnExdEhzLzJPTGFuekFV?=
 =?utf-8?B?czNVSHdkRisrbnRhRGdSSnFMWWVtVGwrWUUrWDlpTU9pblZOQVgxeHVobnJw?=
 =?utf-8?B?aUpYZVlVbnBvUUJyYkkzS2FiMjJGb1l0dnZRMy9pcWMrSFc0NWtJOGZEbEVY?=
 =?utf-8?B?TFdSL08zeUcycTJJWWFicDVYem5JZ2RlUnB4bnV0Qk1iV1lldFAxNHdWcE8w?=
 =?utf-8?B?V0U5MnliRXFQNE0yUUVUdE5QV2g5aEhOQlVxU28vTmZMSTdtL3YvVG1kOTht?=
 =?utf-8?B?TEpvSk5rTUpnQVBMZ1VWTDNTd0IvSGRTSWkwc0ZCcXJOT29WeU05Q2JWRmVC?=
 =?utf-8?Q?Cn3g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeaf9cf-21ab-4f58-028f-08d99d49feb1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 15:12:18.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFpORZfyorj7zawfh7j+8lV1qCEsqx+BFlDD0wC1f3QRhPQkZzT62cRNEbootvA5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2562
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2F515A58-743A-44D4-832F-C8DEE740E29E_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 1 Nov 2021, at 2:54, Baolin Wang wrote:

> On 2021/10/29 23:43, Zi Yan wrote:
>> On 29 Oct 2021, at 3:42, Baolin Wang wrote:
>>
>>> Now hugetlb migration is also available for some scenarios, such as
>>> soft offling or memory compaction. So we should correct the migration=

>>
>> hugetlb migration is available at the time if (PageHuge(page)) branch
>> is added. I am not sure what is new here.
>
> No new things actually, sorry for confusing and will update the commit =
message in next version.
>
>>
>>> stats for hugetlb with using compound_nr() instead of thp_nr_pages()
>>> to get the number of pages.
>>
>> nr_failed records the number of pages, not subpages. It is returned to=

>
> I also think nr_failed should record the number of pages, not the numbe=
r of hugetlb, if I understand you correctly.
>
>> user space when move_pages() syscall is used. After your change,
>> if users try to migrate a list of pages including THPs and/or hugetlb
>> pages and some of THPs and/or hugetlb fail to migrate, move_pages()
>> will return a number larger than the number of pages the users tried
>
> OK, thanks for pointing out the issue.
>
> But before my patch, we've already returned the number of pages success=
ed or failed for THP migration, instead of the number of THP. That means =
if we just move only 1 page by

Ah, you are right.

> move_pages() and if this page is 2M THP, so move_pages() will return 51=
2 if failed to migrate, which is larger than the page count specified fro=
m user.
>
> if (err > 0)
> 	err +=3D nr_pages - i - 1;

I am not sure this is right for user-space.

>
> On the other hand, the stats of PGMIGRATE_SUCCESS/PGMIGRATE_FAIL should=
 stand for the number of pages, instead of the number of hugetlb. Also fo=
r hugetlb migration when memory compaction, we've already counted the num=
ber of pages for a hugetlb into cc->nr_migratepages, if the hugetlb migra=
tion failed, the trace stat of compaction will be confusing if we return =
the number of hugetlb.
>
> trace_mm_compaction_migratepages(cc->nr_migratepages, err,             =
                      &cc->migratepages);
>
> So I think the stats of hugetlb migration should be consistent with THP=
=2E

It makes sense to me.

>
>> to migrate. I am not sure this is the change we want. Or at least,
>> the comment of migrate_pages() and the manpage of move_pages() need
>> to be changed and linux-api mailing list should be cc=E2=80=99d.
>
> I don't think we should update the comments of migrate_pages(), "Return=
s the number of pages that were not migrated" makes sense to me if I unde=
rstand correctly.
>
> For the manpage of move_pages(), as you said, the the returned non-migr=
ate page numbers can be larger than the numbers specified from user if fa=
iled to migrate a THP or a hugetlb. I am not sure if we should change the=
 manpage, since the THP already did, but I can send a patch to update the=
 manpage if you think this is still necessary. Thanks.

I am not sure changing manpage would help the users of move_pages() after=

think about it again, since users might not know all the THP and/or huget=
lb
information	when they call move_pages() and they just pass a list of N pa=
ges.

I just wonder if we could fix the rc value of migrate_pages to return
the number of {base page, THP, hugetlb} instead, so that move_pages()
can get its return value right.

Thanks.

>
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>   mm/migrate.c | 10 ++++------
>>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index a11e948..2b45a29 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1475,7 +1475,7 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>>>   			 * during migration.
>>>   			 */
>>>   			is_thp =3D PageTransHuge(page) && !PageHuge(page);
>>> -			nr_subpages =3D thp_nr_pages(page);
>>> +			nr_subpages =3D compound_nr(page);
>>>   			cond_resched();
>>>
>>>   			if (PageHuge(page))
>>> @@ -1540,7 +1540,7 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>>>   					nr_failed +=3D nr_subpages;
>>>   					goto out;
>>>   				}
>>> -				nr_failed++;
>>> +				nr_failed +=3D nr_subpages;
>>>   				goto out;
>>>   			case -EAGAIN:
>>>   				if (is_thp) {
>>> @@ -1550,14 +1550,14 @@ int migrate_pages(struct list_head *from, new=
_page_t get_new_page,
>>>   				retry++;
>>>   				break;
>>>   			case MIGRATEPAGE_SUCCESS:
>>> +				nr_succeeded +=3D nr_subpages;
>>>   				if (is_thp) {
>>>   					nr_thp_succeeded++;
>>> -					nr_succeeded +=3D nr_subpages;
>>>   					break;
>>>   				}
>>> -				nr_succeeded++;
>>>   				break;
>>>   			default:
>>> +				nr_failed +=3D nr_subpages;
>>>   				/*
>>>   				 * Permanent failure (-EBUSY, etc.):
>>>   				 * unlike -EAGAIN case, the failed page is
>>> @@ -1566,10 +1566,8 @@ int migrate_pages(struct list_head *from, new_=
page_t get_new_page,
>>>   				 */
>>>   				if (is_thp) {
>>>   					nr_thp_failed++;
>>> -					nr_failed +=3D nr_subpages;
>>>   					break;
>>>   				}
>>> -				nr_failed++;
>>>   				break;
>>>   			}
>>>   		}
>>> -- =

>>> 1.8.3.1
>>
>> --
>> Best Regards,
>> Yan, Zi
>>


--
Best Regards,
Yan, Zi

--=_MailMate_2F515A58-743A-44D4-832F-C8DEE740E29E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmGAA8wPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKMIcP/2EVUYz4+bVcSl4uDtkSrGix86BzA3ubI9TN
rJiN2L4Qudn7yW/cJ+D71qDg5c1S1Y71Tzz1i8qFFvbaMkyOCRVtu1eAeMDnH8Iw
QIcW92h2dmnp+Fsznkqi8U/RrnpsM26e0zDXkfG2z31gEJcB98xRmzr1Ukr0WScj
Bsrw5DLjtedeNsszIk1UEnvNRHT1V9xNnZ2kMR7yoR9bTwALWJfWgqMaTGnNlWf2
iGfPBl3EpMHVFpsFgEqGzkJRm3jAy94wWgzZtiyYMbAyJHsiVrDsff3mhEv6xw73
4wWSxmZTvo3YRvCvyI85PPDlEBUUiYFHnZUQ30VHK+C1wZ3LPEWqDX2UoDKLmRMz
0LVJl69RmJo4fD/EEfOTeNorJLB8SlswLFfMcyl6iQNxPEoTbL3clzBcyUOZA4MA
7D6p7kKHMWi9Z8dKy9P4bYlQ3HoXJ/PNKVNdNyvZekyfbFBgKGjMfp7UVzTyn5Zm
aZg8RwOEO+WNeuA8qut5bdtqqwJ5mYJGIiglNmRAhlpFk9Vvres3bI84APDsZqWI
EzTYXmW6XAs8jqtHh4Y3a10DuxDagovGkoSz3X8BY7UZx0pFvIZHUxXjgWt3PBxA
I4ol7IfSSGG1izaDE5OqmDTyXMpRIpdiTdvSr3vA4mQGGELhCHObtqP+15fWUVlo
3HMY94H2
=1A6b
-----END PGP SIGNATURE-----

--=_MailMate_2F515A58-743A-44D4-832F-C8DEE740E29E_=--
