Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39C3E311D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245219AbhHFV0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:26:35 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:52965
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240338AbhHFV0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:26:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da87/1RqdvYH8vq3OSVP3yXypF+LrUSpUNBnOhi9oemrYUXUWNdW/5HvRQWNkyBQJIOm+zQOjdaey+4CojnBW1rSpB8uyocKnt7qeW6njiC8SKT+NWo1disRT3P642StmycWhbY3VkbqoeVifFSgBez9PqI9QtlwpnLvfIzHml7Su4i3A57YbzD6QB+N+5VLbOvuJ744jJ5uGk8I4DSO0lE2Cx6Moa0ZCuTTRDo2dVcvsaAZhPWFDavZ1vntJZoi6R6V6Kjp9/6ssS3TTzQA/YR6lk+7pdnmSYg4Sfw2G+glLiC+47y4HO6JmYw8++A+dOrJm9FLoQ52s90ogPax6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bPPQGcp9xZfPIknp25xkrSOSMz0hiYT7Jk0PESQgNM=;
 b=e+fp3DwFGp3+wQl353h6Q7XOqKmMsHnSOse6Lc/PMaA8lUQ75qTR8qRFOMREgs+imXJ+dfF4pS5BBBCb/XMPO1rZu9kGFLGJDUqkNPbEEcGFdplg5Kb/bZDN3ODZJAZefqNt/eqISAPpLQm1V63YLHqEKsQKY3Zr2AOpTqqbZ1fGDNsU1TvwsXd505j8c+9y8MFW3IXf1p96rMI2YYHpEs5lpME/x7tzkN0+AWHZMK37E5ej11fxV+5XM/JMp7u4h79LmxA0ba0LJH5a/Nh/Vv0LheoAa+0fWYT8nuRqON6qFq1PvnoRwbbprohtUfOokVdK9c6doWNQzhGyrqiXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bPPQGcp9xZfPIknp25xkrSOSMz0hiYT7Jk0PESQgNM=;
 b=ahZB4j5TDa6yEOHEWd1zrJ28IElt5AdjYPi1uwMvrMS9QL2ct6he2IFWS3UJG19PPtNPsVqLWcFNU3Y8/P6JMhGROiP3bLY0Xz+nEPosJTcLSJH6buwVqAF58nAgxAhsCAV8k7sxE5qhmSc6Rf/LpfIEp94L9tMZSjmgtgV36rZMJWjCU/vN6DlQTO6TEbWKGhvkpaC3b4EHOKtRPSOkbk3IPq65Ld32MiI/Jqb1dRBtCL19IwWYKObaaLGXLA9RlPMgjvPwN7uifEOBFX5FOldrrLi7ET2AHUp96Un3lTiyqlGRY6vDl2HrVcfXjNu8cVwoN2LQxxKXt45UKZKLRQ==
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 21:26:15 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4394.017; Fri, 6 Aug 2021
 21:26:15 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot time parameter.
Date:   Fri, 06 Aug 2021 17:26:09 -0400
X-Mailer: MailMate (1.14r5820)
Message-ID: <13DF8783-289F-4ED7-AC13-E60DF7CD0710@nvidia.com>
In-Reply-To: <6ae6cd92-3ff4-7ed3-b337-a4dfe33da1c@google.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <0d374eed-cc52-a656-b338-1156782bdf7e@suse.cz>
 <F34DBD0A-22DE-4CF2-B784-BBDD80A8E85A@nvidia.com>
 <6ae6cd92-3ff4-7ed3-b337-a4dfe33da1c@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F343033B-6EF6-4D7A-B403-0EF88D8B0BEB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.50.235] (216.228.112.22) by MN2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:208:1a0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 21:26:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b51d31d1-a490-42b0-f053-08d95920d22e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40630E6D273BCA4ACC52F7D4C2F39@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXy2vznSau/5bauAFHzzVJM26TPYvoz71Wgwzy7nVy5XNBZ5/hmrk5evqBEqo3SowpAz9qd3jgVV7Y/d0YnN34vbN/+p0QBkT5WUf1fYONS+dHgu45H+cGeNyEky3KIhEgMPWC9JLQGqezS3XrEjbRK74EFdVDpl5jXJhDY7DuFqT4xv4C0obasQz3FKrp4Ee+P+H9wzD/KF2sit8kvkB4ieVeot3zN5AltCPeyPAqDbWytW2jb/+U6zxpflrfVwFYRYwKaGfmD2aom+wCErVAqADyHIRS/RpGnFYlGZxinwX8gx8v/nDWoOUA7AuJtgO+aDM9ZurzaJeGy3oWPdFXL3Hb+ViiJuU9vXjkSZhAWHd/o+r9SpAhIF6JaRc+JZSrqMgcwSr39eHzPk5D2+cWrosyX2kX5FfmZoNgXiEmRp63XqXoR9mmS99xM6apS5dbJ1nNVbQ/YQVH4Y12v5+ahBvAfmCnrsDOnPpOFAcLJAfyAq8wa/C7uR7zaZx1D0zI3jcD8J6ljOKd0pT8KXB4uW+6q6h1KDr2oGmOWIPtTRicFik1t+2Sk/PC+G11aklqZfYwkPx/PHr7YfZ+Jp0xRH5lYBe/nhoxAD5fpa4OCHboKCxqc46nR0oAXYy04eTZzcrLnolh5fhpgzyFQ32gxrvPqA/iUj5KSCdieHLL6o0RiCwg9z0z1pyvCkKttb/5IKxVe9r6O5+K6tcot+tqCSjP2muLPrPtE0j5H3VqD9A7e3rc6vG2GJ/TrrL6PYKwZAOQZv7D0g6Mah1CpzLKC1Te4XUJ6Z0CvE7D1+HWHy5oQH4zfVcZq8Bss6nhndr/WjMrgT7HYRedPMSf4wwkU7/4Gwhtajby9QmD+fZZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(966005)(8676002)(33964004)(38100700002)(36756003)(6666004)(21480400003)(186003)(33656002)(5660300002)(478600001)(2906002)(956004)(53546011)(235185007)(316002)(8936002)(2616005)(7416002)(4326008)(26005)(6486002)(86362001)(54906003)(66556008)(83380400001)(66476007)(66946007)(16576012)(6916009)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3pjTXdxanFBZkdKRFhqalpVdXpSRWNtQzhiRDFxWW93U0s3ZmFDbFZOVkg0?=
 =?utf-8?B?K2F5cHIwT3JXZ3pmTUxBblNySzR6YUMvcjFUTDJRT1d4YWpFK1k0R1RrRko5?=
 =?utf-8?B?djlueTg1ZkcvWDE4K0phOXhrcXlsNzdTWDFmeXJ2S3BaLzJpZGE5M2ZabFBH?=
 =?utf-8?B?aGZPS2ZBZS90YTZJTGs2SW1IV2wxWlVVeHNsQUt1azh3K1RLSGRmQUFKdWlO?=
 =?utf-8?B?cVVYVm5oSE9ld0Z6Yy8wVzZTc3FCblhiZWp5Ry81YTVrRnd2OHFLSy8wbTRX?=
 =?utf-8?B?M3RNMFJVQ3BzVWVpS2dBTys4Z2MvTDBvZHRNRk9EUzNhMlB0THpGbkpoblpI?=
 =?utf-8?B?bzFnUE9OZmNCdmNQRFY1S21XeEIrUG5KZ0tQS1RJNmJzUHBQY2NDaE03ZHQ2?=
 =?utf-8?B?NkdXNlNobmpxUURNczVQUCtuUkJCQXRRTWNoRll1WG5MWU12eVllR1JXR2Jm?=
 =?utf-8?B?WGpqQzd3RVY1ZExIcnNybEJDMndhRnBZZldFRlh3T1h2ZDkxUEhNVlE2WTIr?=
 =?utf-8?B?aDhINm1jejUyQ1NoQ1hPMVhxTUN0VTJxcEYzVzNRVE5pN2pKOHMxTE9tY3V1?=
 =?utf-8?B?dHIrVTdaSVNNWDVZaWNVcTE2bWhyNUtmM2F1bGd2dm5uM3pJOGNvZ0hTNDhX?=
 =?utf-8?B?YWJVSFlTbFZhWkM0amxKNitQTDJwd0N6OWQ1bW5ObVNQemJKcytZOFZ5OUdL?=
 =?utf-8?B?RkFKWTFkeUQvbzQzREh4ejlza0xFbjlxN3BkVS8wVEFYekRkTGxsZWI3YTRY?=
 =?utf-8?B?LzFxS2dOYjFyZ2tRYzY0V05IcnNqMjdpY2VxK1hReWpRSXVaM0lTdktqUEFE?=
 =?utf-8?B?U1dmc2VNNXFYbkZHays1blc0Ly93VFpkdmhiREdNaHpnRkJCZ21zQTZQbSta?=
 =?utf-8?B?ZW1weEpQcjBXaEJkK3kyRWxWZTk5L0t2UitteE1HQnlqZUhxWU1FUUdrMTdW?=
 =?utf-8?B?Q2NaTExEZ3hFcGdIekpJdkdnVTU0WlcyTWkxQ1BJd2NRZmgxSk1TUGgwbVE1?=
 =?utf-8?B?N01XejZaeHZZei9XWTV2cmZiWCtYZm5OT29GR0FlZktzS2RDT2E4dTc4blVO?=
 =?utf-8?B?TEl5UUpVd2dWazJySWo1bGZIeGZGczdEekpPb3pwTHd2ZlBTdVc2UHhhK3dM?=
 =?utf-8?B?YjdQM3BQSTBqTHZBRTdZRUx1ZStiYjJmNmRPaXRYZXNFQjNGWVE3bDFVUEhJ?=
 =?utf-8?B?T2VDZ3BxYnBPaWNpRkw3aVJpNmwwZ1dLeWZGbVlDY20zZUw0U3l1dXpyOTIr?=
 =?utf-8?B?R05MV2R3ZjNZakVtTWFtWjNxNE45ekQ5cjlMbjd3OGFId1JBZ3l4aGd5QWYx?=
 =?utf-8?B?bG5TeTdUNzdXcEdCQXY3THI4ZXZqd29KVDRjdWU4VXc0czlzcld1UnVZb1BV?=
 =?utf-8?B?Q2c0MHZDMXZiVGs4anJId01aSU5qTWlmTmtSNzRBYUVMRGJhVVMyUWJINzdZ?=
 =?utf-8?B?ZzN2WHJpZlg1TjJlRmY5ZW9QRGh1UUs4V2g3ZmxGYVdrOUxKeEtFYWRtVnNN?=
 =?utf-8?B?a0tPOWw3ODdGSXdBYmF4Sk13UjkvRnh3OVF4WUZKYlFNOExOY3JhOGVjbVJS?=
 =?utf-8?B?TE1WaVQwOU9CUktUUVl5d2pXeW1Bbm92Ukpwb3ZVMDNtQ1FvbThVMGpkUkRS?=
 =?utf-8?B?WlpicGcxTitFNW52RGMxNXQ4Ujd3dHlxN05oM1QwZTVZNFpmTHNBekdEeW0x?=
 =?utf-8?B?dWdLVWw2Z1BEYXRWV2xZazd3VnJLYndDcURoNHZWWEFzSUh0N2NRc1dxb2pi?=
 =?utf-8?Q?jdfusZfeFUeUdfEWtWGhhNvjNj6HYRkqz2/1jRu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51d31d1-a490-42b0-f053-08d95920d22e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 21:26:15.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: me9nGk9/Hu8ddukEsBXr/83hO824dOVMvkMJ90PHa67dsEdsdSEm4kuHHVkIJAWb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_F343033B-6EF6-4D7A-B403-0EF88D8B0BEB_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6 Aug 2021, at 16:27, Hugh Dickins wrote:

> On Fri, 6 Aug 2021, Zi Yan wrote:
>>
>> In addition, I would like to share more detail on my plan on supportin=
g 1GB PUD THP.
>> This patchset is the first step, enabling kernel to allocate 1GB pages=
, so that
>> user can get 1GB THPs from ZONE_NORMAL and ZONE_MOVABLE without using
>> alloc_contig_pages() or CMA allocator. The next step is to improve ker=
nel memory
>> fragmentation handling for pages up to MAX_ORDER, since currently page=
block size
>> is still limited by memory section size. As a result, I will explore s=
olutions
>> like having additional larger pageblocks (up to MAX_ORDER) to counter =
memory
>> fragmentation. I will discover what else needs to be solved as I gradu=
ally improve
>> 1GB PUD THP support.
>
> Sorry to be blunt, but let me state my opinion: 2MB THPs have given and=

> continue to give us more than enough trouble.  Complicating the kernel'=
s
> mm further, just to allow 1GB THPs, seems a very bad tradeoff to me.  I=

> understand that it's an appealing personal project; but for the sake of=

> of all the rest of us, please leave 1GB huge pages to hugetlbfs (until
> the day when we are all using 2MB base pages).

I do not agree with you. 2MB THP provides good performance, while letting=
 us
keep using 4KB base pages. The 2MB THP implementation is the price we pay=

to get the performance. This patchset removes the tie between MAX_ORDER
and section size to allow >2MB page allocation, which is useful in many
places. 1GB THP is one of the users. Gigantic pages also improve
device performance, like GPUs (e.g., AMD GPUs can use any power of two up=
 to
1GB pages[1], which I just learnt). Also could you point out which part
of my patchset complicates kernel=E2=80=99s mm? I could try to simplify i=
t if
possible.

In addition, I am not sure hugetlbfs is the way to go. THP is managed by
core mm, whereas hugetlbfs has its own code for memory management.
As hugetlbfs gets popular, more core mm functionalities have been
replicated and added to hugetlbfs codebase. It is not a good tradeoff
either. One of the reasons I work on 1GB THP is that Roman from Facebook
explicitly mentioned they want to use THP in place of hugetlbfs[2].

I think it might be more constructive to point out the existing issues
in THP so that we can improve the code together. BTW, I am also working
on simplifying THP code like generalizing THP split[3] and planning to
simplify page table manipulation code by reviving Kirill=E2=80=99s idea[4=
].

[1] https://lore.kernel.org/linux-mm/bdec12bd-9188-9f3e-c442-aa33e25303a6=
@amd.com/
[2] https://lore.kernel.org/linux-mm/20200903162527.GF60440@carbon.dhcp.t=
hefacebook.com/
[3] https://lwn.net/Articles/837928/
[4] https://lore.kernel.org/linux-mm/20180424154355.mfjgkf47kdp2by4e@blac=
k.fi.intel.com/

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_F343033B-6EF6-4D7A-B403-0EF88D8B0BEB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmENqPEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKCyEP/ix8J88iwOdiEDae3kAkk/1mr8r/W6LWMfe0
VLAaYj7VuBBKUnAj4H6Mm2eQewPeO1SF1gYfqLp7AtKIFJcCuo6hZbQAW2VZ8cTX
SMk4wimtoHItOFJKU1vVLbJSHfL15CQZT1G67nRHkANBMSmPkvp0ie/KhBMF3rU2
t6BQ6Tzt+utzzKIF+G3hJGYy5GM/v032DUMKrKhmaaJcs5NAVlObf5qEfl879khU
5+o041SvDqi7IyIkDqZM6SBVfmrHP5oIdZ2qx3vQ36OeWCJ0MvV0KvTXVwfBi7Bv
wMHt11QQvdNJBn2ziDeHjBSELSaOvFC3ggiRuNf7EcbWMs1wsi2uiyI21G9kK3R+
lJiB8aZLksnEL3BeTrFslgZ2hFU9IDiaI2lgxbRf7ZQ9GkntHUYtC7VnBMfpyGKz
gdHswp1VHrXTRNjzJgJ2A54eOhwztvEemQcMgR8NvGaOcO5760MHm6lSXGP4BMet
xkSBSnLk0pIWg20NdJt+62aKfaWDr3JVGPqJTliq6Fht60Jo94nB+QyaBVXVwmXN
MOkLSM0qnhi4VQXBzop8nD+JbDAG71df/KMuiwPz0eVSumntJg3+a5WtkkoEmKf7
CkBDfwjUcR8AFcUJpBGAm5S/zMxtCaVm6XAXu/cmvJeUYB3qeXJTd02bnFF181cA
Sy73gMjV
=ECSy
-----END PGP SIGNATURE-----

--=_MailMate_F343033B-6EF6-4D7A-B403-0EF88D8B0BEB_=--
