Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D366334851F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbhCXXOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:14:43 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:52138
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233517AbhCXXOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGFpsPORLOzKkmj6tzAmWict9UWBO9KN3f54qc60y4CONCf8czCogo7yp/VIZYY2+YW3XwI0knM6S9u+gZM5O3b9UZoQBwDiUssZvw7ftztr/PX3N2Lsyi3KojZCe/u62ahDvPBPG1kLQeKllx7oGKWOAovg44e0WYnuE9hI2VDV/JARFz4vMvxsO7/chJPywlFPw0k1WcR37VP5BYlpaQ6i5JtqR2dCY1J2dIlUsXs9qBlc6aWRVnO4Tr420oCgfl/GDCN5jfa3JVQVrTGExHJsNcZOcjwnP3FTo2U9WrKPFvGfl18JfWycUe/ZTExDODBEoLYp/Y5Woo2AHRTw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuUZxKmUjkg5oZIacpV6ViNaH7jmvSqlHYmtO41si+Q=;
 b=nOXXEHihf37MvQ8qA1+B/19D+tbsHLr4X9w46/sWTZRtPrtEIXHTOdzLMp9YhaQVHoeZcFckjmO7CtG69t7wlyyvqOawiwHBtAr4w2c/RlwONWZv8kiOeJDWjj4broVuVdhpGtK3mVBsoHRq9FAzvbT2W3jg8+un5EMnEZNRGuD9fL42NxHjopgFlM8BO2L5w4DLY5d5W1c6AB6XFCWRJ9UY6o6TZF7TNlkXjGAH0xo8ZCR1dpSt+UGgASZaYIz8KoavozMEMNjbFFWzRf3ZotNnHpGQ5ce9k8p5m3VhActGwXGoLNKMdM9l+ZeYwOecp3wjfLCgKemaaa1A946nBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuUZxKmUjkg5oZIacpV6ViNaH7jmvSqlHYmtO41si+Q=;
 b=V6nFI3OYWFWGZZ20YjA55lYI2mP4C+car1CzfpAq03c6+mNmN0Aee1VMBf2kBRqsHc7s1X7HhfJc39AJ7wwruVPSztJAK2BFbKRzgXaNB5uI6xMmDJkbRtBeR/0Ojy9gNYOcCJCcp3vwe/V6GIAvbqLBiOfu0agnRt6pVyCCl87pwkiKYXuFGzDi9ss2EYD9h7aFpg1tneuGP+1TMnwewjTgOAPrEMo5VjHg1l7QxzVOBiNKhhfTl1dHjz4iWtLR3EdoGejn3oCP2ggNGEWSm8tVSUbb2ugWSFDur56ANOjC8Mw1ZnQr2HntzoFWgZxKPITrU7EYtIdmiiFFd8bExQ==
Authentication-Results: shipmail.org; dkim=none (message not signed)
 header.d=none;shipmail.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Wed, 24 Mar
 2021 23:14:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 23:14:20 +0000
Date:   Wed, 24 Mar 2021 20:14:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <20210324231419.GR2356281@nvidia.com>
References: <YFsM23t2niJwhpM/@phenom.ffwll.local>
 <20210324122430.GW2356281@nvidia.com>
 <e12e2c49-afaf-dbac-b18c-272c93c83e06@shipmail.org>
 <20210324124127.GY2356281@nvidia.com>
 <6c9acb90-8e91-d8af-7abd-e762d9a901aa@shipmail.org>
 <20210324134833.GE2356281@nvidia.com>
 <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
 <20210324163812.GJ2356281@nvidia.com>
 <08f19e80-d6cb-8858-0c5d-67d2e2723f72@amd.com>
 <730eb2ff-ba98-2393-6d42-61735e3c6b83@shipmail.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <730eb2ff-ba98-2393-6d42-61735e3c6b83@shipmail.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 23:14:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPChf-002DMW-7Y; Wed, 24 Mar 2021 20:14:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81ae8e3d-19b7-42c3-debe-08d8ef1a8e1c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28092491BCC180A65CB180ADC2639@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8T+V+cxAslVfNzr7B1vhYqCczW9W6F3nizWp97BWlwtLV0RJxq6fuUtWkkFD3KaJSdkeX8EaVkCxZH1mqeEwaidLmZRAeodDEi2ctTGALxLk0AEoPKXHBhW0biQQfFyiC9ZnIadq4WLwmZ2KgSgIRldYHFUNni/4YuOJX4XmJaWVb6p9TH2adSdZj7OkUoU76jK3y/3NOM3wpgelqqGfIieT76+nd86JfoqQYly5h0cUv9bjLf0gs4mxIY/h1oa+1rHTl5O9oKDRoCA3oBwG40RzTFEr3m4MaF94Jg19t+AeiuFgot/lmg2RH+GsfbBcerOxBzdAQwDGQ1AFP/GEd9sxbRdbGLgUEFKxROEqRCjS8dT6t9Kfpgpt4CCzwfKg7EBmuHES7cAr7k6h0zTEm8k4VK5VuyA6IGGFZWQDGEDTMJ0qZ6PDb3Spx8ta/+Tw6GE6OLQcv1xuvFx9ffFjvrCjM16vDymFS6AHHYNq4njelPrBUYHucj2jlhJBS8GRlroqdhXvG54gkdWfITNV+D2rnyGzWdkDC8CY0/dIpQKNwm4axFIf5POibVRVhdjcD87/RxoZB1z1bROLvhrUje9/XHnkrL165S+DtfL4jSM74Yu/1njOsEkuq7dqFSvZS7SsfDUs4Dnzr+NfIdFEowmkABlOWCTJoj/VK9eRpm1ND4DcKVonpTeznDpjvRE1s5GemrQ6BbrcDyW6hsX0zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(2906002)(2616005)(426003)(6916009)(1076003)(26005)(36756003)(8676002)(186003)(4326008)(86362001)(8936002)(9786002)(66476007)(478600001)(54906003)(66556008)(66946007)(9746002)(316002)(5660300002)(53546011)(66574015)(38100700001)(33656002)(83380400001)(21314003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aU83cjFZVDdtWHVaVlZSSTFOcW5pWDNFQWdOYmNudFA0SnIzVGRJUWx3T2FF?=
 =?utf-8?B?aGF2dzZON1kwUjN2VmpOd1V5bFJkUERrQzZnZS9TOXJKS3ZRYzlRdk94UU14?=
 =?utf-8?B?NU9jbUovb2NLU2o1LzgxU0U0UGxBZjdzamlYajFzZ2dHa2JEUEcyT3M2d1Ar?=
 =?utf-8?B?THRoQ2krU0dQT2hHMWZFRU1YVk56dHJPUlBTUm93V1ZtalA0NzJLamVlK1FP?=
 =?utf-8?B?L0UrUGo1U0RFcE5Lamgva0lzZVJPYnhuQU52NGV2ZnVHUWJKVWJTUDN6b3Z5?=
 =?utf-8?B?VjZXeldBajdpMFhxNzNuSGxhV3JvbVQ3d2dWR012SktTQnUrSTRrU0JZVlFI?=
 =?utf-8?B?OTdmQUIwSEh0WDJCK1BzYW9rakhxTllQUjVxWWlDYS9Xb3lNYytVSlMxam8w?=
 =?utf-8?B?bko3SUVJN0UxVjBTdXdWWmY4dTArb0RrYm11VkhBRlNzbXk4bFJJcGxpU1k5?=
 =?utf-8?B?U1JpeCtOTWdmeDNyM2NwampVSmsveURwckhwdlNPbkR0bnNxSXp2cEU5Vlp3?=
 =?utf-8?B?ZVptNjdqQk9xaWU4Sjd4eTlQUnRJYVJUNVRyUHNlcjQyNVB6NGxUQUpBNFJp?=
 =?utf-8?B?Rm5XbDlQU213RDcwNVdTZm9uN2diTUFvSTNjd3dnL3lRZ1VoWDluc0RzTU1h?=
 =?utf-8?B?WTlVWU9QWTU3TmE3UUFxUkQ2WWZXUm1UT2JKRlhKRExIUStkU0Nwa21mMW55?=
 =?utf-8?B?bnhBZDZ5dmJWUW12ZzVJdkZOcUc5SjEyZmxLdG9UZ2RSNHYrWGxsOW1CMTA2?=
 =?utf-8?B?YUdCS3VhVS9jNDVUYkdlbEp2VldHQ2djdVArbE41UVpVWWI2RHZVMWNaNU9B?=
 =?utf-8?B?SUxOVVhtUklQVzhvYW9pVW16U2hvZFRERkF1UVk3Qjh4SkFrcFpJNWJvVTVk?=
 =?utf-8?B?bWJEa3Jaam1zQ0VwUWF1VTdBWm1nY25mbTRoWGJpZHViSjExWmZXREV1R2xE?=
 =?utf-8?B?eGVWelFJbmFFUk5BUU9BTEM5S2ZLbXdRY0lncEN1WE90U0cxMHQ0bTlDOUo4?=
 =?utf-8?B?dTRKaWRiSkt4QlUzZk1xcnQyOG9KYzU5d1V0YlFUbE9OcUVlcDdHVklod1R5?=
 =?utf-8?B?Y3ltakMzTDlWaVdNOENIZFIrT2JzM3FpTlBWSGpvSXVaYVloaW9ObHQyRjFL?=
 =?utf-8?B?allMT3djM0d3QTY1QkhnWUpiUDU0OHZ5UkQ3cUlZaFdKNm4yVjJwTlJxMmo2?=
 =?utf-8?B?SzFHckpVZEZUMjZnNkNlcG5XM09rUHZMM2pvRzQzb292ck1wY1JXS3JlNmlJ?=
 =?utf-8?B?U3ZxOXNPNUwyZGxlVXJuNk1IZUNjSjdJd0F2NEU5K1Rqc2ZRY2sxSG4xTXJt?=
 =?utf-8?B?MzFkUVBhZ2lZdUZkMzl1ekVTaGovN05ENTZxdkxmeHVRWjdkcWt0YmhoMDB4?=
 =?utf-8?B?L0ZrWStqd1F4UU9RZjVYQm9nWTRUWmExREFaOVZ1cXdQWmlFa3NQMkpvR09v?=
 =?utf-8?B?RGF3VnVVa01Gb1l0S2t6QldEUlFZN3BjN3BoN3FHMnFoQjdtNjZEbVRhQlZX?=
 =?utf-8?B?ZEQzKzZhQXZESWNFYkZVNEx5S3ZkMTQwL0FQWHNpSXhuSE9RYm9YdWtlRmtD?=
 =?utf-8?B?Tm5vREplTFdZT1dkMUFZUTU1d3B6NTJ3M0FiMTFIazNQa09kSHBNVmV0anVV?=
 =?utf-8?B?eGNUNEFpZlBVbiszbGdYemNkWkVPOWtvMmhxN3J2Sm0vQjgzK0F5cGFCMkpI?=
 =?utf-8?B?Y0diM1A1bXBUYytZaFZra0YxY2dkQzhSTktWa0xsWWFsTTZBWERrNDNDMGwy?=
 =?utf-8?Q?lPa3FsJxqc/NLGvZxntNbaa0Gtg/byaNAeYCHa7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ae8e3d-19b7-42c3-debe-08d8ef1a8e1c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 23:14:20.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP8laqMWfMr5ONTR0ULxDBvK7tEd+ErlHcqheHqhsGY0WaYgZrThrW28RN0+LRr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 09:07:53PM +0100, Thomas Hellström (Intel) wrote:
> 
> On 3/24/21 7:31 PM, Christian König wrote:
> > 
> > 
> > Am 24.03.21 um 17:38 schrieb Jason Gunthorpe:
> > > On Wed, Mar 24, 2021 at 04:50:14PM +0100, Thomas Hellström (Intel)
> > > wrote:
> > > > On 3/24/21 2:48 PM, Jason Gunthorpe wrote:
> > > > > On Wed, Mar 24, 2021 at 02:35:38PM +0100, Thomas Hellström
> > > > > (Intel) wrote:
> > > > > 
> > > > > > > In an ideal world the creation/destruction of page
> > > > > > > table levels would
> > > > > > > by dynamic at this point, like THP.
> > > > > > Hmm, but I'm not sure what problem we're trying to solve
> > > > > > by changing the
> > > > > > interface in this way?
> > > > > We are trying to make a sensible driver API to deal with huge pages.
> > > > > > Currently if the core vm requests a huge pud, we give it
> > > > > > one, and if we
> > > > > > can't or don't want to (because of dirty-tracking, for
> > > > > > example, which is
> > > > > > always done on 4K page-level) we just return
> > > > > > VM_FAULT_FALLBACK, and the
> > > > > > fault is retried at a lower level.
> > > > > Well, my thought would be to move the pte related stuff into
> > > > > vmf_insert_range instead of recursing back via VM_FAULT_FALLBACK.
> > > > > 
> > > > > I don't know if the locking works out, but it feels cleaner that the
> > > > > driver tells the vmf how big a page it can stuff in, not the vm
> > > > > telling the driver to stuff in a certain size page which it might not
> > > > > want to do.
> > > > > 
> > > > > Some devices want to work on a in-between page size like 64k so they
> > > > > can't form 2M pages but they can stuff 64k of 4K pages in a batch on
> > > > > every fault.
> > > > Hmm, yes, but we would in that case be limited anyway to insert ranges
> > > > smaller than and equal to the fault size to avoid extensive and
> > > > possibly
> > > > unnecessary checks for contigous memory.
> > > Why? The insert function is walking the page tables, it just updates
> > > things as they are. It learns the arragement for free while doing the
> > > walk.
> > > 
> > > The device has to always provide consistent data, if it overlaps into
> > > pages that are already populated that is fine so long as it isn't
> > > changing their addresses.
> > > 
> > > > And then if we can't support the full fault size, we'd need to
> > > > either presume a size and alignment of the next level or search for
> > > > contigous memory in both directions around the fault address,
> > > > perhaps unnecessarily as well.
> > > You don't really need to care about levels, the device should be
> > > faulting in the largest memory regions it can within its efficiency.
> > > 
> > > If it works on 4M pages then it should be faulting 4M pages. The page
> > > size of the underlying CPU doesn't really matter much other than some
> > > tuning to impact how the device's allocator works.
> 
> Yes, but then we'd be adding a lot of complexity into this function that is
> already provided by the current interface for DAX, for little or no gain, at
> least in the drm/ttm setting. Please think of the following situation: You
> get a fault, you do an extensive time-consuming scan of your VRAM buffer
> object into which the fault goes and determine you can fault 1GB. Now you
> hand it to vmf_insert_range() and because the user-space address is
> misaligned, or already partly populated because of a previous eviction, you
> can only fault single pages, and you end up faulting a full GB of single
> pages perhaps for a one-time small update.

Why would "you can only fault single pages" ever be true? If you have
1GB of pages then the vmf_insert_range should allocate enough page
table entries to consume it, regardless of alignment.

And why shouldn't DAX switch to this kind of interface anyhow? It is
basically exactly the same problem. The underlying filesystem block
size is *not* necessarily aligned to the CPU page table sizes and DAX
would benefit from better handling of this mismatch.

> On top of this, unless we want to do the walk trying increasingly smaller
> sizes of vmf_insert_xxx(), we'd have to use apply_to_page_range() and teach
> it about transhuge page table entries, because pagewalk.c can't be used (It
> can't populate page tables). That also means apply_to_page_range() needs to
> be complicated with page table locks since transhuge pages aren't stable and
> can be zapped and refaulted under us while we do the walk.

I didn't say it would be simple :) But we also need to stop hacking
around the sides of all this huge page stuff and come up with sensible
APIs that drivers can actually implement correctly. Exposing drivers
to specific kinds of page levels really feels like the wrong level of
abstraction.

Once we start doing this we should do it everywhere, the io_remap_pfn
stuff should be able to create huge special IO pages as well, for
instance.
 
> On top of this, the user-space address allocator needs to know how large gpu
> pages are aligned in buffer objects to have a reasonable chance of aligning
> with CPU huge page boundaries which is a requirement to be able to insert a
> huge CPU page table entry, so the driver would basically need the drm helper
> that can do this alignment anyway.

Don't you have this problem anyhow?

Jason
