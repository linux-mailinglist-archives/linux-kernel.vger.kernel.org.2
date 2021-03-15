Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D4E33A912
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 01:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhCOA17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 20:27:59 -0400
Received: from mail-eopbgr690055.outbound.protection.outlook.com ([40.107.69.55]:59457
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229476AbhCOA1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 20:27:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSBo/bkoR8PF+6MvUOp13fCJP+loI3EjuCosLOtoLNo+/zCAfZiTYq/R9HmHxRkVxus24qawmkNPjNlfjnoQxMAgT6EiqrA5siQGlIrnefdL5ofXZLNxzBCRoZ8NgFD4iONGhsHelY4GMrcQLyvP5PMb0CsWXKKFN8JO2Om4XTiYQHOYe7zaV/kpktqKFJC6jec3g7uluz7K6QASwsNXfbo+tWsCiRzRzR+iuW3fsNLpVcSo6xU2r9d+8KI46qZ2UeEUw8BuMAVa8/vE96UGnloWe8OaLEAz+RCPN6iU/60Ymkfh6BtTPBTsAjyK0mmMSt81DcQIofeN50bchr7wUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qnyiXXzgAKLhfAqot+KgIT9S4UHmLPcfgaji6WEuwM=;
 b=nhRMmRgdNCgOa9GaVU46kBuhzRbcnYc017VCP0fEGtUrv5RMUi5TQwdjAk0ZIkxsGNgRsmGVdvZNmuqEeFxTpX9W+XqAFwaw4wmrr5IkeGRPNQbVZfFarOYBFdt+cShICq1/QQysa/Bd/fPZPAbIaYmMPaeMX4kSr+BXhtMJI0qqLv7PXlRcD1rZoZJpTHXEQagsVgC6GaX8iHVYhptYc7uBgoQdPbvevxnu0kiZrPTw+gVaB3VAip/W8FMGgMgKhP0WUxVaSjCzNRvvjYqtRz8VH4uV23Mk34YGSqcJMgZqBoz4RT/XUav9yX3ulO/46WqwuHFOXa/H/mVlkIQ45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qnyiXXzgAKLhfAqot+KgIT9S4UHmLPcfgaji6WEuwM=;
 b=CXuPypODlnohp15b2a+LdAgsT9luzu1xuiTRZyU/KEgWvCZUwBIUaycLjAsZ7GuO589sELUd/yom+rvi+fCZD/jvE/bu3H1twr041DeiSHE0RFT3u3rTW27Wcr/pypv7YTcxINDfEwKY0WJvER/ErDFR216u2DIs1nMNnBpi1EYS2HF6g3UMeoFlJUiIyyHUBUwB7xs1977zXvgX9iBhcANoP1JnDGgoe46BNkaN8BAzBZhtHBJtNg069sv9chddapZptF+GaNqt2dlQjcHz2s/StBefZiir/ENDalAPp5LjxoPFB/6fAFjNud7KKZBOwRohh+1GAwdBLfdtGg/4Og==
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 00:27:37 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 00:27:36 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Yu Zhao" <yuzhao@google.com>,
        "Matthew Wilcox" <willy@infradead.org>
Cc:     linux-mm@kvack.org, "Alex Shi" <alex.shi@linux.alibaba.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Hillf Danton" <hdanton@sina.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Mel Gorman" <mgorman@suse.de>, "Michal Hocko" <mhocko@suse.com>,
        "Roman Gushchin" <guro@fb.com>, "Vlastimil Babka" <vbabka@suse.cz>,
        "Wei Yang" <richard.weiyang@linux.alibaba.com>,
        "Yang Shi" <shy828301@gmail.com>,
        "Ying Huang" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        page-reclaim@google.com
Subject: Re: [PATCH v1 06/14] mm, x86: support the access bit on non-leaf PMD
 entries
Date:   Sun, 14 Mar 2021 20:27:29 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <3465DA3A-B735-4657-A1E0-89CF5DE0D4FF@nvidia.com>
In-Reply-To: <YE6kacDMLga/kfvf@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-7-yuzhao@google.com>
 <74C83FFE-DC78-40CD-B6BE-00614DC8F125@nvidia.com>
 <20210314225103.GQ2577561@casper.infradead.org> <YE6kacDMLga/kfvf@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_CBFB7DBC-C603-4F2A-AF6A-DDA4A1BE8835_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:208:23c::30) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.54.46] (216.228.112.21) by MN2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:208:23c::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 00:27:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be3dedb8-e83d-42fd-a9e7-08d8e749223f
X-MS-TrafficTypeDiagnostic: BL0PR12MB5011:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5011BEFDB4194E23D974C676C26C9@BL0PR12MB5011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gf+cUGq8cMdI76fpXYW9iRmIC8t5Er1pPvxuz1ttSHvHsocx/QREByIcCMpI1YtZ374o/QjiHT00J3SAvOo3rU/cnForPgnoMXvDVGYBcSoY5Bfb18MXOAC+J7rd4CeIrXMo+3HtE/aUJMDYDGoTKIXdnA97eupFOaz5EQK4EUipj1Vl3iKjQK03kV1nS0CHawpBgfuCekejYwd3DhyIWEouF/0IAe0uPulFGRPdlNMqi1ef39+fqGaFHFfqzHfw0plusoOXLS9ZC/qhKj+dsc4RZHdg59+PfORWeN1utaZpVePrHfq0Ip97YH0BS9vGFL7EOnf77oCr55fkKSlUjmxbPjAZPn6r/376eNyfTjmsTzqrdwquz8g4GWQXPvUVYgQKATzbjvRWQWfb2xV1Mg+DKAonK7KHGgqZBspjJ4uHTuzJ3ba5b8AX1xwxoMS/RWQyk/QNREwXnT9e1TpH0nSrLlyZp+JJk8/aHTnhIAmgzBFfrHLdAoZWgeF2oaIjVZElpqUBac5peUTch53TDKQv0CrzZ2ODrsnKFHrZplsxxI7MzQejKJyxDlzbMFIzL+qjPCxD8zZq/sCEzyOiJiYE8GLX/8/ZidLZVRZq/KzkXDya/+blnUE0RM8GYyn7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(66476007)(66946007)(6666004)(186003)(36756003)(66556008)(478600001)(4326008)(86362001)(235185007)(7416002)(2906002)(5660300002)(83380400001)(33964004)(33656002)(316002)(54906003)(8676002)(8936002)(2616005)(110136005)(6486002)(16526019)(53546011)(956004)(16576012)(26005)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Zmc0amEveWJod2g3ZVl3WHM2Z1BDQWRQQktKZUowZ2lLZTZYS1FTamZkQzBv?=
 =?utf-8?B?cjlJeHpIRlR5akoreUpRL3BYeVZzYjJiZ2hOeDF2UE5zTVBYUFYxSzJDbW9F?=
 =?utf-8?B?Y3o1cXluL1NBazJIdEFiZS8xcnVqeWc5QzM2MVcvMjJCSXdPNHh6KzU3R2Zo?=
 =?utf-8?B?Nm5sSHNnNXZXWkd1a1RiL1Z2NHl5ZCtkWkJydmVrcTlzTlRmZU8vcXRYSFRx?=
 =?utf-8?B?VmJ5N1ZkdnpEbFovR3VQL3prUVZNdTMzRUgyNWkyY3VMTWhhTURyR0FnOVZu?=
 =?utf-8?B?Y3VxLzZ3S3RLQ3hmV2NNVGpqclFZbXFPUDZEMHc0MUJSNUtkYS9vNmVVSkZ2?=
 =?utf-8?B?NTRCMmNxaTBORnVwTVpUNkNWOWhnTDdXTWw2aGY4QzVmVnlONnFxYlplUzRh?=
 =?utf-8?B?bEN6WFB3K0J4MkR5RnQyT3AzeGJJVCtwOU9sOHRkRmpDeGdOUmx5QWVlZmhM?=
 =?utf-8?B?aXBDaG9GajJhMHlFQ3dtUTlWTUJKT01LK3JkdlFYM3VaR282RThVdXlvRzJw?=
 =?utf-8?B?ZENBWVVvYjFSUWZTZHdDS2FsZHFBOUdTSEo3Vy9KdHZKNVV6anhHT2NVa2xL?=
 =?utf-8?B?RTNMVmhyQnJsTUlMZVpHdjh4SDVHMWRkcVJsRVZUZVpBTVJNaWJRRzJrdXpV?=
 =?utf-8?B?clpBRk5zSVBuUDhvWVZ1V0plbWVrektjbWlCTEpndFBhM1Z3MXpiUnUyZWFh?=
 =?utf-8?B?ZE5aZWZWbEpVOVVMMXFYMW1MOVlWbTc1dHhxd28yRnVmUUtkMEg3ekdPWi8w?=
 =?utf-8?B?b1hzSWcxS3gxZGxGcGtQd0V0a2c1Q1R6K2JBMWdoaFVOcG56U3U4V3VpeG9Y?=
 =?utf-8?B?dFVWTXNwTzB1MHBQRkdhaG5obzFtU0ZUK2tJR3I4cUNXRFJBeis4Z2lJYzBX?=
 =?utf-8?B?NGIxczJkRmVBdEJpV0Nla21YWXpodksrTnNFWmZxK1llaXM0WUZXTzdaVzlx?=
 =?utf-8?B?WVpsay81U1Jlbm5aYStpUFJ3bFpwRWhTSVpRUVF2bkNKa2NDVXpQV204em1U?=
 =?utf-8?B?aUtMeENLeEhuelNDMnNJRktyUFJQdi9wck1aWDJWWk80ZGkzUEZxZ0NOcDRn?=
 =?utf-8?B?M1p0OXZBRHJISHlZZXIzb1ZPU0pSbnFLRFo1SVZiOGdPVEhEZGVvQlNlTWFi?=
 =?utf-8?B?ekEyeXEvS2h1TC8zYTNuK2VmeW85MG56eHhyUUxJVklMbFB2cnU4KzdtZWZL?=
 =?utf-8?B?NDNVL1FOczg4VzhjRjFsM2JLTWhDdy9FK0Z6MDRQSHFFS0FuYjFSV3lnTmRD?=
 =?utf-8?B?M0VzUmt3d1QvdVI0aHlDN1BVblhYVkJRVDN6Qm1vOFlmY0RRejAvVjRkUVBB?=
 =?utf-8?B?U3dhMVgzT09heVIzQVhONVlOZ1BYbTFyVCtRVVVoSW5iRUI1YWQ0U3VVdzVT?=
 =?utf-8?B?MVMrR3RnZW5FUTBxRDNpdVZHcXRmeFdVUnRGQkRlZlRYajAzNTRDU1YwL3JF?=
 =?utf-8?B?bzhQV0pjSHQweVVHSis1OUc0ZWZxZ2YzMm1JU3NqVFF4OXdIRU14ZXF5RXpL?=
 =?utf-8?B?TjcwdzZhdGp4VEcvdHNJd00vbG4vVWgvZkhtcVBmUG9qYmM5SWx0SHRaa2NG?=
 =?utf-8?B?K2N0UXlxbXRabDdGTE80MUhBYlQ2Wk5CSXQ4RzQ4KzVhQ3E0RS81RTVvWTJM?=
 =?utf-8?B?ZUpBWFp0eEVrVUIvU0Y5R2crNzVhN0w4ci9OeTRQVTE2Vk9PbEJoamZwaEpS?=
 =?utf-8?B?UE5rVEtnVHF6K1hiSVFmc0tobzdMd0d6Q1JiYlRpZVJpamFVZlR3U0pBUzFV?=
 =?utf-8?Q?ZeZTXStBF1sifUbxN2TbBMaGQGbM1DKD/+LfWxG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3dedb8-e83d-42fd-a9e7-08d8e749223f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 00:27:36.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDVC6+plJ4sf+U8npIwhBjIEd/Sgk6U0d9nBeUgY//yIJu8JmZJQgRZ9RTtig/zu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_CBFB7DBC-C603-4F2A-AF6A-DDA4A1BE8835_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 14 Mar 2021, at 20:03, Yu Zhao wrote:

> On Sun, Mar 14, 2021 at 10:51:03PM +0000, Matthew Wilcox wrote:
>> On Sun, Mar 14, 2021 at 06:12:42PM -0400, Zi Yan wrote:
>>> On 13 Mar 2021, at 2:57, Yu Zhao wrote:
>>>
>>>> Some architectures support the accessed bit on non-leaf PMD entries
>>>> (parents) in addition to leaf PTE entries (children) where pages are=

>>>> mapped, e.g., x86_64 sets the accessed bit on a parent when using it=

>>>> as part of linear-address translation [1]. Page table walkers who ar=
e
>>>> interested in the accessed bit on children can take advantage of thi=
s:
>>>> they do not need to search the children when the accessed bit is not=

>>>> set on a parent, given that they have previously cleared the accesse=
d
>>>> bit on this parent in addition to its children.
>>>>
>>>> [1]: Intel 64 and IA-32 Architectures Software Developer's Manual
>>>>      Volume 3 (October 2019), section 4.8
>>>
>>> Just curious. Does this also apply to non-leaf PUD entries? Do you
>>> mind sharing which sentence from the manual gives the information?
>>
>> The first few sentences from 4.8:
>>
>> : For any paging-structure entry that is used during linear-address
>> : translation, bit 5 is the accessed flag. For paging-structure
>> : entries that map a page (as opposed to referencing another paging
>> : structure), bit 6 is the dirty flag. These flags are provided for
>> : use by memory-management software to manage the transfer of pages an=
d
>> : paging structures into and out of physical memory.
>>
>> : Whenever the processor uses a paging-structure entry as part of
>> : linear-address translation, it sets the accessed flag in that entry
>> : (if it is not already set).

Matthew, thanks for the pointer.

>
> As far as I know x86 is the one that supports this.
>
>> The way they differentiate between the A and D bits makes it clear to
>> me that the A bit is set at each level of the tree, but the D bit is
>> only set on leaf entries.
>
> And the difference makes perfect sense (to me). Kudos to Intel.

Hi Yu,

You only introduced HAVE_ARCH_PARENT_PMD_YOUNG but no HAVE_ARCH_PARENT_PU=
D_YOUNG.
Is it PUD granularity too large to be useful for multigenerational LRU al=
gorithm?

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_CBFB7DBC-C603-4F2A-AF6A-DDA4A1BE8835_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBOqfEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK7ioP/iXqhqf8coxd9BziPjMq8dDbSltEG7lgcfrS
uJ/Qu4Q+nu6iY4H36HgkGcjcnf6QbWtzu9CJBi2zUuWYoT4mgR9mFA6E1sHE7EBk
hTufjKU4ondt5J1EMXjdh1az0Hn4OSgU0xMzW1dNzFutOhNi+AZpr5uB7IgwPcTa
UOq3c624FcJvCOtQTX92kh1xrYQfzqIdZmAw4q/IjFH93C6OPJxVK2f6fwS9g+Cd
DK9sPSZHbchFhBMZM6JDdDveAwCpCHHGzP1bRQlQSe5zGO+kvBO57lj968LnJeEQ
kWrqdXvl/wUcXZyc95D3Kob+TCoYkbIyps9t41E7GIWN4DZzv3J1e+yEgvpu/rOr
gvcVlqgxUmG5ONlrqMDcX+FyAFYuRCLXStM8OVVaLtiyi/qpR3cjxud1lEPvEtgw
3ivGxUTIIVuOohf60wRsXbFYMzZQYAgYs/dJYxSBXnpkDaccpmvuKwmGjkJz1lzH
Ig8P7Wew0Bpr+Xz1Hr7Bd3KYoLsKRE475tF5Kbk8gvN0esGc8JpvWQ450Aox24kK
w8Gq0ESCjHUJrR3LzbKUTr+5for2gz6lPxeWciaiVFCVwxG1wNbaOhSu4GEDxgos
yBD6YqVwMWcVmmH+ir8Mc3ocx8Z6HIw76RPFw4oxw0ULH21P327si7cuyk0wP8sL
H3zpnVI7
=dIvm
-----END PGP SIGNATURE-----

--=_MailMate_CBFB7DBC-C603-4F2A-AF6A-DDA4A1BE8835_=--
