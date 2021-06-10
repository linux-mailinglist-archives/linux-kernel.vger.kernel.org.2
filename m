Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CA13A2A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFJLmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:42:53 -0400
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:41984
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229895AbhFJLmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:42:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPkZT+wRX/HO6t9oVMD44nBc/c3GNcUP5X/lIV8Sua5EswOrr7tUT3Jafau0CZgNVseX/8R+RFVxP7kHM8oC8IPiVIEgKeaDCeowPRJ7kFrIi8WUfhL0K3S2+kbP6rpdnLzH0tJ4rAWMNotYQxNeMO+mJZap4Yu97PfZ5HheKQ70WeEeXUz8gdGYGKAt63tPTKII7kQT0Ncf2NjWm/TPKmgW4Hn7w0omSwwm+VLbXdTLeOzApGucVQo4gFOMcrEUEaiNQZZrZCuMtUPUvao6NO0PXq+OBQYJj2AytrToOV4g8Pb4H9eq7v+6MH0/nVavIKmEknjvDdyTxxEGSpVPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaQBxCcVK/oPN0GXgY0zUmW82eCVlxU1aYCNM7JnkzU=;
 b=LTIChBLyc9BF0na3l6FpmbWJ8G0gNSD2cnBQvIvmH28Qi7himIuzWc5Stt56c4YbkkBACOOVS5WLK/D9qCPPe3OAcsQxOr2ObegbNNyuP19vWTNspMFnJAbs86imZUa3VAbCs5igEk2Tj+7tUMZGOSSEuvCVtvQpTPJBjOve7rvccBleGIJft7D+gfB5N8XTDAERzqYpmvGW/Q4eeMlQiYhjtIpFmYOfBxO1H7jsMf1zs3y1fp4LK3m3PaXzitnpvpHo7q8KPTqA3QI/oTmiOJ2l27SM7NuvIQ9q3belz5Wd0TVRhht3vNE2DV7s4OXfbGL1Aw9Kf1ONkPTaNB1kvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaQBxCcVK/oPN0GXgY0zUmW82eCVlxU1aYCNM7JnkzU=;
 b=RqUtaia6ghO++gVRXdNL+CSPe+3vYobeYxTlHCS+BNR7SD1/UJIOzgnd2TXqAlpSJA8oMUcezzmC2i9W+OdLgcJbbCTwfPzN6qALKuMeYAUr6er2JxA6CAxyyaTMc4Ulv6wtQmeQ6kaJqaTofZlXGTP9hyrfJlusttRE4H2WFrJG5tbNWjXwWLFaBVrWxemMuhXD9h1tEaGptITa3S4X47dc7uQMySp7mTj3Pn6+0e83p+CO7LCY6uaX+xkNNVQNBWdlQd/oyfnXGXcHz5I5TSOIoMUsJ6eARhOBAGC4G8+Ft6D+iIrHDkBMFYM8DlLw3Qd+vPpF0XceC4qdqAhFmA==
Authentication-Results: techsingularity.net; dkim=none (message not signed)
 header.d=none;techsingularity.net; dmarc=none action=none
 header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 11:40:53 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4219.023; Thu, 10 Jun 2021
 11:40:53 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm/page_alloc: Allow high-order pages to be stored on the per-cpu lists
Date:   Thu, 10 Jun 2021 07:40:47 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <3B44DF44-5669-40B6-A122-011F1A749FAA@nvidia.com>
In-Reply-To: <20210610111821.GY30378@techsingularity.net>
References: <20210603142220.10851-1-mgorman@techsingularity.net>
 <20210603142220.10851-3-mgorman@techsingularity.net>
 <88FCC7AA-FAAA-4B87-B382-50BD54B2886B@nvidia.com>
 <20210610111821.GY30378@techsingularity.net>
Content-Type: multipart/signed;
 boundary="=_MailMate_6AC32CB9-4740-459A-9AFE-261CFFE0B7F4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR19CA0061.namprd19.prod.outlook.com
 (2603:10b6:208:19b::38) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.82.166] (216.228.112.21) by MN2PR19CA0061.namprd19.prod.outlook.com (2603:10b6:208:19b::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Thu, 10 Jun 2021 11:40:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb538dcd-8cde-4ef1-f383-08d92c049a2d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4077B06C921A2A66A97E1FC5C2359@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2aIGqXKOSmunJTefjMmBMP5FmqMO4o0kkuPNUwsYxdW+iSW6SQRTD2u1j0Aj3t1zWgFZQAqdySMip6Y3VFVz6OuuG03q8RnhJRVlsXR9YTOYMri5a/mlSr/JZcpkUSkD7LVJxujY1jgvFaIaQAN1VXhbnFKLLUsqnSwgXCNW3YAJomDfEJpBx6AbRpP6alMqnZYaUon6xhFxI3PlT3cJm5mOZOLnPCJrlkbHPBNLRMzoDYNixnBmTrWJvUjMKmKN2IP899e4GKz6JQ0sPuxsZUmuAf6GxhW8+17tJf/IiqrLrPT9+dTtN/Fj9FFcrVu98dwTh+BCnoNJo4H3NnS8zwQvy0mIu0f9pplqJ1uu7mqEleg6bqJ05lsiLg/nxdiQX3VWkT0e2QgwXY7vSc0sBJmuQObHmW+rWjxBGRippIzxF7SWM0XC9QePffRWJRet053TK3DPOJAV7L5GilAJoU+ku9kL0TZ2YeSQJIhv1lRNbMcgI/q2ccCKW8YFrSVjMaHpgX4ghGtATPv7+EFArmSEXPAyTxLD5/RwpCdK7iVrdA6pFzO8ScjAOncFdlSwD2lYGqwbk4uCcX+szrakgDgKDC1i06ZbHHuxOzgJdaeuBm8Bfpd3Ghy7IaeceGptncIbd43AsCPNDmTFk73wrjxrmted5DCGuEHY8ZSxog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(86362001)(8936002)(8676002)(54906003)(16576012)(53546011)(316002)(4326008)(956004)(2616005)(6486002)(38100700002)(16526019)(186003)(6916009)(66946007)(66476007)(66556008)(36756003)(21480400003)(33656002)(2906002)(26005)(6666004)(478600001)(5660300002)(45080400002)(235185007)(33964004)(83380400001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2syMHhGNm56eHcwMFRrNlhVVEkwSlM0UENjelRIa29mRWtpWlczQ1grcGwz?=
 =?utf-8?B?LzMvWDgySzRSZEpSRWx2REIrOXdiNXdOcjQ1Y1pUcWpHRTk0QkM5a0hVU3dQ?=
 =?utf-8?B?bTU2RjNmTjNpRkwxRGhMckZDRVl1MVNSdTZuczFaUWYzVDZEMnJNWHBqQklT?=
 =?utf-8?B?OExqZVZDOC9IZjJzVm84ck4rVm1RaXl0WkFOa3JoUkVFbU8zZDFkaUJERWwz?=
 =?utf-8?B?OGMvWmJqdUF5ck5kWHVGZDBsbk5vQWJqRlNRVmwxTVAwQjgzT0VQTEt0Um1Y?=
 =?utf-8?B?TVJHZHJlTUNvRUp0NFF5aXBLNFRZNU01NElUcUtXMU13d0JDSlhoalRKN0xU?=
 =?utf-8?B?bFFhb09TRjlZQ0dTMGxPeFJHNGFjSjNLR2hkUGpQZGpYRmRHZm5ka1ZSdkc0?=
 =?utf-8?B?U01vcy9SMm8zTENsd3Y4NUdLVHlwUkw2eVVxUDJ3R0FXUzhld2tRQWlWUWlT?=
 =?utf-8?B?eVJRMW9PbiszOEpGdzdtaDc5VEovSkl0Z2FzZElWSlFRNzV5RUFya3ladExR?=
 =?utf-8?B?MkZpUkszVGFpdUF2NEswMXJHY3paQU1Dd2t2OVY0QU81d0R6VlloVlB6UUUr?=
 =?utf-8?B?MFJuUk1xS1B4eTVSYUx0dFp4SWtmM3dVeHNmL0N4ejVQaEJya1JwT21wdUlW?=
 =?utf-8?B?SmNhZ1lyZEIwT1ZvNDNXeTlhTjJkKythYjBERU5vZzJOeG1zSVc1VDZUN21M?=
 =?utf-8?B?LzJIQ1pUTUFFMTNGVThPUE9lOGVGcFhHbDcwcGhWeTBWNnc0RTlvK2hHaFpp?=
 =?utf-8?B?MVEvMlRacTBMVDBXQUxWWWNYd2FxMjZMTlJER2RBYWFyWWROejF1TXdQNXdS?=
 =?utf-8?B?bnVXSUxWYmtEdHpiN1VRMDNDTzB6VDl5L1M2cnBpQ2ZpT0duMnVvUXhzZU9R?=
 =?utf-8?B?QU9XQmk2N040TmZ1TllFbVJLS0xxSkRVM1N2U0pUQW5WN3JqcHk1YUhkOGIw?=
 =?utf-8?B?WEJjVjJ6c3U0eVZUWms4VTA2aDFSUHU0M2NWdTR1TVMxb0dKajJoUXNuWnFj?=
 =?utf-8?B?RTlCVHRvR0VjYkF3Z0REckV4eHd4K2JSUUYzRWlvZlEzWlA5bVBwY05ITlJQ?=
 =?utf-8?B?MEFQTER2RFBFUkVpendxTVpxTFQyU1JWWkpiTGNLMHVFVWpyc3RzQko4bHQy?=
 =?utf-8?B?aUpXTFQ4OUlIOUx3VzA0TkpRcm9UYldkcTg5Z1pJY3JVUldVL25xanVRRk9s?=
 =?utf-8?B?c2NHNG51OEpSOFJzZys4YjhnMzNlVllia0ZzOVZVRFJlZU9OR1NYRjBXamk2?=
 =?utf-8?B?b1luRVZSb0dQd2NXWksrdkVUdG43MjdPQXl6K21NL2JRdXVnbGoxckdmaWZY?=
 =?utf-8?B?SHY4SXJNa20yaktmK3IwS21mQWlVM2crMXh4WXFpUUhRMVBrVlcvNmlMeDRX?=
 =?utf-8?B?K2xtUzhrbWwwRkllUGo5MjZ4Q3hYcEVmWURNUDY2SFUvcmJLLzNaSUtPZHM2?=
 =?utf-8?B?TFBpN2dGRXZPK0g1ZXJBdXQvM2RudWI2MW1HTlo2OHJzVlZyU0RwYzk2bHE3?=
 =?utf-8?B?amdkdFVIeXkwa2Zkam5IMDVXNWVTcUdZd3dSZ1lFWmRscU55ZjBzaW8zMzJ0?=
 =?utf-8?B?YUJwWjl1R21ZNkJhbHNlbEZZVnNpeUVNTit0NTlneFdGcU1BZnlnc1BnSG9V?=
 =?utf-8?B?TWlXRVV4c2lUeGhLcGRGTUxhWnhrV283a0VsZXZpbnJKS01LUWdRaWExNVZQ?=
 =?utf-8?B?THpHN2J6NnFESENxZ3ZreXMvMHFNVFkvaENYYkh2L2RBaXhHazJSTUIxa0FB?=
 =?utf-8?Q?jFpDilAJzwL6nm+WDdTIxbgIpDByIFJdrvQH3UK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb538dcd-8cde-4ef1-f383-08d92c049a2d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 11:40:52.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gh6+BFShu9re8GRGCq0HdnFcbN6mxpMr6UyDxI+xA5VKJL2yGXUXoz1cE6d1siV/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6AC32CB9-4740-459A-9AFE-261CFFE0B7F4_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10 Jun 2021, at 7:18, Mel Gorman wrote:

> On Wed, Jun 09, 2021 at 02:30:18PM -0400, Zi Yan wrote:
>> On 3 Jun 2021, at 10:22, Mel Gorman wrote:
>>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>> ---
>>>  include/linux/mmzone.h |  20 +++++-
>>>  mm/internal.h          |   2 +-
>>>  mm/page_alloc.c        | 159 +++++++++++++++++++++++++++++----------=
--
>>>  mm/swap.c              |   2 +-
>>>  4 files changed, 135 insertions(+), 48 deletions(-)
>>>
>>
>> Hi Mel,
>>
>> I am not able to boot my QEMU VM with v5.13-rc5-mmotm-2021-06-07-18-33=
=2E
>> git bisect points to this patch. The VM got stuck at ???Booting from R=
OM??????.
>>
>> My kernel config is attached and my qemu command is:
>>
>> qemu-system-x86_64 -kernel ~/repos/linux-1gb-thp/arch/x86/boot/bzImage=
 \
>>     -drive file=3D~/qemu-image/vm.qcow2,if=3Dvirtio \
>>     -append "nokaslr root=3D/dev/vda1 rw console=3DttyS0 " \
>>     -pidfile vm.pid \
>>     -netdev user,id=3Dmynet0,hostfwd=3Dtcp::11022-:22 \
>>     -device virtio-net-pci,netdev=3Dmynet0 \
>>     -m 16g -smp 6 -cpu host -enable-kvm -nographic \
>>     -machine hmat=3Don -object memory-backend-ram,size=3D8g,id=3Dm0 \
>>     -object memory-backend-ram,size=3D8g,id=3Dm1 \
>>     -numa node,memdev=3Dm0,nodeid=3D0 -numa node,memdev=3Dm1,nodeid=3D=
1
>>
>> The attached config has THP disabled. The VM cannot boot with THP enab=
led,
>> either.
>>
>
> There is not a lot of information to go on here. Can you confirm that a=

> revert of that specific patch from mmotm-2021-06-07-18-33 also boots? I=
t
> sounds like your console log is empty, does anything useful appear if
> you add "earlyprintk=3Dserial,ttyS0,115200" to the kernel command line?=


Sure. I can confirm that reverting the patch makes the VM boot.
The important information I forgot to mention is that after I remove
the NUMA setting in the QEMU, the VM can boot too.

earlyprintk gave the error message (page out of zone boundary) when the V=
M could not boot:

[    0.120569] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.161237] Memory: 16396772K/16776684K available (18452K kernel code,=
 3336K rwdata, 8000K rodata, 1852K init, 1444K bss, 379656K reserved, 0K =
cma-reserve)
[    0.162451] page 0x100041 outside node 1 zone Normal [ 0x240000 - 0x44=
0000 ]
[    0.163057] page:(____ptrval____) refcount:0 mapcount:0 mapping:000000=
0000000000 index:0x0 pfn:0x100041
[    0.163863] flags: 0x200000000000000(node=3D0|zone=3D2)
[    0.164283] raw: 0200000000000000 dead000000000100 dead000000000122 00=
00000000000000
[    0.164950] raw: 0000000000000000 0000000000000000 00000000ffffffff 00=
00000000000000
[    0.165621] page dumped because: VM_BUG_ON_PAGE(page && bad_range(zone=
, page))
[    0.166617] ------------[ cut here ]------------
[    0.167355] kernel BUG at mm/page_alloc.c:3764!
[    0.168079] invalid opcode: 0000 [#1] SMP NOPTI
[    0.168801] CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.0-rc5-mm1+ #3=
81
[    0.169870] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.14.0-2 04/01/2014
[    0.171057] RIP: 0010:get_page_from_freelist+0x10e5/0x1410
[    0.171763] Code: 4c 24 18 4c 89 ee 8b 14 24 e8 67 d8 fc ff e9 af f6 f=
f ff 45 31 ff e9 41 fe ff ff 48 c7 c6 60 51 a3 82 4c 89 ff e8 db 82 fd ff=
 <0f> 0b 658
[    0.174173] RSP: 0000:ffffffff82c03d08 EFLAGS: 00010046
[    0.174767] RAX: 0000000000000042 RBX: ffff88843fffad00 RCX: 00000000f=
fffdfff
[    0.175381] RDX: 0000000000000000 RSI: 00000000ffffffea RDI: 000000000=
0000000
[    0.175998] RBP: ffff888237c28300 R08: ffffffff82d509c8 R09: 000000000=
0009ffb
[    0.176613] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: ffff88823=
7c28408
[    0.177229] R13: 0000000000000000 R14: 0000000000000001 R15: ffffea000=
4001040
[    0.177852] FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlG=
S:0000000000000000
[    0.178550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.179045] CR2: ffff88843ffff000 CR3: 0000000002c0c000 CR4: 000000000=
00406b0
[    0.179664] Call Trace:
[    0.179876]  ? should_fail_alloc_page+0x5/0x10
[    0.180260]  ? prepare_alloc_pages+0xb4/0x190
[    0.180637]  __alloc_pages+0xe6/0x210
[    0.180952]  allocate_slab+0x9a/0x470
[    0.181275]  __kmem_cache_create+0x259/0x510
[    0.181645]  create_boot_cache+0x72/0x96
[    0.181998]  kmem_cache_init+0xb4/0x17b
[    0.182332]  start_kernel+0x3d5/0x695
[    0.182649]  ? x86_family+0x5/0x20
[    0.182945]  secondary_startup_64_no_verify+0xb0/0xbb
[    0.183383] Modules linked in:
[    0.183649] random: get_random_bytes called from oops_exit+0x35/0x60 w=
ith crng_init=3D0
[    0.183655] ---[ end trace 5a27ab5b99c01a0e ]---
[    0.184731] RIP: 0010:get_page_from_freelist+0x10e5/0x1410
[    0.185203] Code: 4c 24 18 4c 89 ee 8b 14 24 e8 67 d8 fc ff e9 af f6 f=
f ff 45 31 ff e9 41 fe ff ff 48 c7 c6 60 51 a3 82 4c 89 ff e8 db 82 fd ff=
 <0f> 0b 658
[    0.186828] RSP: 0000:ffffffff82c03d08 EFLAGS: 00010046
[    0.187283] RAX: 0000000000000042 RBX: ffff88843fffad00 RCX: 00000000f=
fffdfff
[    0.187900] RDX: 0000000000000000 RSI: 00000000ffffffea RDI: 000000000=
0000000
[    0.188522] RBP: ffff888237c28300 R08: ffffffff82d509c8 R09: 000000000=
0009ffb
[    0.189134] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: ffff88823=
7c28408
[    0.189752] R13: 0000000000000000 R14: 0000000000000001 R15: ffffea000=
4001040
[    0.190374] FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlG=
S:0000000000000000
[    0.191074] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.191572] CR2: ffff88843ffff000 CR3: 0000000002c0c000 CR4: 000000000=
00406b0
[    0.192188] Kernel panic - not syncing: Attempted to kill the idle tas=
k!
[    0.192791] ---[ end Kernel panic - not syncing: Attempted to kill the=
 idle task! ]---

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_6AC32CB9-4740-459A-9AFE-261CFFE0B7F4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDB+j8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKP9gP/jvX/SeiJKuG3x0XD7gzKxmdoLsBerujBw1T
nHGN+akCP+GWTfpjIo4nWqrFnIKk38NN9y44ZsCiKZ9ngV67Z5rjBTeKu8ir/Rw+
+WpwtCuOh1EHr4MzpoDKcs+BOssRTwCtKIl4I9ln7c9jIwWAyE+YYl17LxQFfbRj
4PQNR4jpg6v99GAPo2EqKuEYOG2iRjtn6NH8oyNkLWx8mhhZiqb1rtZZl30TaEYX
qyKS+UlOPRHpGOykRTdc/YFZ/6z0HsKTNBEDc41b8B+8Cj3udiVg/B+cYB/oDmlY
VHABt0W7FyMdt7TN6ffy2yr1R0u7ixwQ+3MoQss+8oLLINceOg+ivqLnWiTNS3WH
ZqhbVNUJsznoMbPKXubLiZgpfhyFQTnhHfksiWXhGgWZkbN2C8rxPW+bI4Mzf9SV
ukOg0JhmZFNaQe6+2HLBkdQD08GsrySJpLGfXua1r8HMjOjITvkZ9brctzo4zGEP
yzZTEJqtDOw8AzmJyO8f8xRp+6rz2F7TSU8a1hbF+VrlB7/VAoBZbP/LZa/Xq+7t
dqIqMM2Vb5LwqwvwNiEhYiBJqDJAXiLGAU/IqxNDUEYUMZ5CPn8YRVQYFqbRjeuo
6HOzpVRHQpX5ARGIW2qpYbJoCxVyBJG0n4rS/6jmXermyVtzgN/j5X62zQZd38aO
28X2oL9V
=KnIX
-----END PGP SIGNATURE-----

--=_MailMate_6AC32CB9-4740-459A-9AFE-261CFFE0B7F4_=--
