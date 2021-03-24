Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846E73478B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhCXMlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:41:40 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:34529
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232800AbhCXMla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:41:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htdhG4uATKHDDW/jtIeXMvlmEZAXAwJ2tKsaGyLmAJ5Xv+gBER0OipqUephIhHTE3YM4d5BZoZMhVJBc/aqh2qzFOmL290x3/8K1khFNBJxYqjjfEbd47pwPwHXWlfbrmfhvU9bbqKD3+fXM0jzEG+zvpIieaIZzXCieG88EIllYanT1TKs7ct50Ud9j2OAQBioxduShOzCM+wr94e9cY97GX58UhD4M+Q5wVegJdL7gdZfph4ePyA1K2m2I3y9Vl3h4rX5LV6kOgP1Bichhz8qsBeeJpKT57tVRLUVceJOTRUek2o7snItbGs7dSbe4tTicZSdTL1n4v57pduvRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5INHl2RJYxVIGDP3kvmCBFXXvWJQ2G6Z/KAhlVpFQ/c=;
 b=Gj/tWMq3/heYCeYLgbJRp+2cFdIN+5e4rnWYymaMEGaWsUU5HO5b1TCwQKAD/3v0dGmeAtaRHYbq6NGw6sqElRzKkt3yLokwj7Lp/A3gjFoRi/d9PpM1giXI+Ql4ueaizD52BZH4vg9VuSxrYA4r97SoWFxlgjABiYpEE8vH8LHyCavSfVAHJzCZSLjvzS/MWy+EPtnc0FJkbb7Gq/HLTZe34ZB3pF9Cra5BD8zjBXg2vRjZywJS1/Tx0ybsUWAt9NATu1hpTeLmOdiSiKKUXkuIruZABqJTfTvY8aS0xETbvyCTGnOoWzp2fubJex36c0yXwYVyOBc06R2YMT/vzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5INHl2RJYxVIGDP3kvmCBFXXvWJQ2G6Z/KAhlVpFQ/c=;
 b=oGLs4lzL2HDrOZ+7Hums+x2hp9xpSsmmoRKTHqs6TtXrEhZViO6apg9t9B7+vZcDpodt0LBMLi521s7qdUG8N34apMVJDAg6nAjilQ2CBmtZDpkHbqmgbQFdf8eQN/hNFfB8pgkHpZy56rpfExym+WwKyw7/hqoWPyRyqmyBQblqZldObXFBrn2yDs39/yBdnGeKry0AOJtYsECHFoCwVvWHkgP0TdnDn4vOOD58rUa+tB2xbx4aUx9Po3l00VNmwRx9cfQJxE/JLp9Fy1621hZ+32a/PYkO2NXF8i4iFFHtftroAxjs0fo/oZgFSKrBQ5bqCP0dmNvVpVxbcaVvPA==
Authentication-Results: shipmail.org; dkim=none (message not signed)
 header.d=none;shipmail.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 12:41:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 12:41:29 +0000
Date:   Wed, 24 Mar 2021 09:41:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <20210324124127.GY2356281@nvidia.com>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <YFnST5VLcEgv9q+s@phenom.ffwll.local>
 <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
 <20210323163715.GJ2356281@nvidia.com>
 <5824b731-ca6a-92fd-e314-d986b6a7b101@shipmail.org>
 <YFsM23t2niJwhpM/@phenom.ffwll.local>
 <20210324122430.GW2356281@nvidia.com>
 <e12e2c49-afaf-dbac-b18c-272c93c83e06@shipmail.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e12e2c49-afaf-dbac-b18c-272c93c83e06@shipmail.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTOPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 12:41:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP2pD-001zGl-9p; Wed, 24 Mar 2021 09:41:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e55da04-7835-4537-1711-08d8eec2253c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4267A03B54DA313A7BBCF89BC2639@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XogPg7Lu2VSrsZt0HMgpcqv189oMgpOW0BPXTSG9nZYnJiae0MS6cE7aLvNm1gxU5S4+1+IrZnjDvg1UUBlNXkwGFJtdHZ8cdOS4+EZVMzKkdpd8sWxbvun0T/0TTN3mcZjA+UFW/dBp3wnVC7WKNm2lD2jep+S99rC4o2MhZHvm7uBLjc/yf4qIRj/3+WH72eAYPpAgUQGhY1ifIQOmIA0Tm2xK1ByTkQmMdddN8ksBNqX4P8Wu8sfBVvb1vD7cd2avg7RZKOxsxYBTV9PXK5dTjD8t45IYknewJsHz/dURS2Xa3Xhig/4vGY1xagWYlgUldX4R3k4U31QNSqffvVb14k7UmvPzAcoX83AzbmVTdZCpj1ODL+5M/fMaNXia49+cfFA/Dew9vTd7lamN+YYxO/flo3jvbe8/+jznCix+PHRvtDCcbGyq5vMcy6+WxWRC3T/JhEmJfMUxQwaG03jYvhHbop6ysulf65Hkf0Gv35CibF1/Q8z9m1yGHv78KdlNw5taCesf6OGhl2XZdghLExV6zN8cdqt7b+pXmyOp93in0YRTHg0wYbjzslXw61dZadNYeBNSCc31aQ2DpzQ8eLMst+lRAkxuQVDyzkM88BTQ9YBD/kxTuvJxTh9biKkWlBMqjrWvmnMSQLvB9U3ropL4J47j3KCHdW8YL+dfAYInYjEeFas24ggWCs8f2FVEjVLGflJgK/6INm5+iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(66946007)(1076003)(6916009)(5660300002)(186003)(66476007)(66556008)(2906002)(2616005)(83380400001)(86362001)(426003)(316002)(53546011)(9786002)(8936002)(8676002)(478600001)(33656002)(4326008)(26005)(9746002)(66574015)(54906003)(36756003)(38100700001)(14583001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SVFSdHVIc0tHWFJqZ3FSbjdIQyt0QWtiQTkwRkFYdTlWRE5IM2JLdUlUSlg2?=
 =?utf-8?B?V3NpTzhtQXE1cTBhNUJIdUxaUU5RSTZVY1lTZ3U1YUN4eU94M2RETVJZME1O?=
 =?utf-8?B?eksvQmVUTWNHZWx2bldOQzVtbHFKVWJQb1k1UUhJdTFMYkYyM1k4SlJrVGJ2?=
 =?utf-8?B?WlU5QlJkNlpzTE9WNzB2Wlk2bjBUdzRiWEt2RktiZkxLWlNrb3hxa1NKWVU1?=
 =?utf-8?B?Y0xhNHFTOXYrM0JSV3FJbHRDQkk5RDB6amEzQ0N4a1Y2ZkZhNlhGV2JXYjda?=
 =?utf-8?B?YTRkUjl6R2ZYSW1TbDhyMFAvSTFOZXRicU5iWmRwQ0Vvc2VGWFFZNm1nQTRK?=
 =?utf-8?B?VEFLZzNBZW9RZ2hXMmZ5aHYzZkZHMlRBT2dFOXhmc1NjQXB6UUFCdzZlSU5t?=
 =?utf-8?B?aFRveS8va3I3U2h0SnAweEo1Zmx3NitadXo2YUV1aVkwTlBuZGg3eUc2ZjRo?=
 =?utf-8?B?UGRvdzEySDI2c0FrcmhlZGtLMzlNMFR3dWgzazh6QnhaS1h6c3phR0daOHpM?=
 =?utf-8?B?WjJjM1g3cTIxTVFaaHhZbitwL253VllvUkQyV0dVQlhvRnRFaDJiZU9zVlJx?=
 =?utf-8?B?MGk4bTlvUDRxWFZxTzBCSmNhZWdDUFkxY2dPWFpCVDdiMEY3MFBJYVFTNEl4?=
 =?utf-8?B?MHdHMU4wNEprdDBBMXMybTl3WlFONjdTS0RmK05yRHNkZ1U2NklyQm8wbDB3?=
 =?utf-8?B?Ni9oaDZlNzRvN0F4UGRNaDRUNHNxU29KSmlieFhaZmtzWE1VZ0VQeFRVZ3JO?=
 =?utf-8?B?b1VEeWRJY1dDdG5zUlBiYnUvb3lDUWpvaFI0UWVoZ0ppMncyei9pYTI2eC8z?=
 =?utf-8?B?dUw3cGtROUpLNzhieTNiQktycDBMNDdGb2FtTTBlMVRtVHFpNDlTekpKUVYv?=
 =?utf-8?B?dVJXcUN3RXlqTnNYZDlDQUZ0RitZSDlaRElXaFh6R3k0SmZmaXdJR2dadmxx?=
 =?utf-8?B?T1pJWktwVUZERXV5cWF4eWlldzJwL0NrQmxSd2xhYVJZQm94TVNIU2FzL1dr?=
 =?utf-8?B?a1NkTWk5ZEtJQ1RLTm9OS1pOTmh2T3ZUUlhmZTRkRWdGTDVpSjQzOFluOS9u?=
 =?utf-8?B?a3ZDVFlxZHNrMHZBclNZUDFFWk5QenhDZlBVbEVFaGo1a2lpL0VVdEk5UWsy?=
 =?utf-8?B?dGVtL2dDbzliVkdvSDZ2cjBId3lmMU5na2Qyc0RMMnlxRUpMVXMzWXhTR2N6?=
 =?utf-8?B?VHdySVRPWTlTZHo3WlBjZm9ZQ3lsalBnL015b045cVpmWlBLRE5VUXVSbXFV?=
 =?utf-8?B?c2VrSVhOVklXUlA1L1ptNmcvR0xFMlpCOUczZTNqSGJFa2REYzNiZVdhQzR5?=
 =?utf-8?B?TTJ5azVxRFpoQ2gxN2EwS045b0lqZDNWQWlueThOWXlpMzdLSWNDZTZPSy9j?=
 =?utf-8?B?ckltWndWNG40U0ViWnk4UjNncGUvN2NyZDEyalRkRFlUai85cFVpUmNsYU8w?=
 =?utf-8?B?cDRjcEl5cjJWSisvY3A4b1VBQktvVHoxaHYzWGdhR1RFMy82QWFOWlpIL3Iv?=
 =?utf-8?B?bCt5Mk5WQnNtSnIyUU1HRis4NVZ5VEsxd1hNbnRMT2RSRVNsQXFMT3JDUkc0?=
 =?utf-8?B?TDVCclpSZDZ4ZnVaVWpyWUtxdGhWMFpnZEJXOUd6SWRDWUc5ZVVFQitGYjdt?=
 =?utf-8?B?YWI3dnF5QlV0clAvTEh6T3NNM21xVEpySk1vbG5ENjE0TU5RamM1cGdhVldy?=
 =?utf-8?B?Q3pLV2d4UzVlKzBzSitpcm5qc3pUbllRdnkwaVJsamZLd2lxTmFjelhzQ2dq?=
 =?utf-8?Q?bS0YEGgKpxLZ0zqUuAFhGTJAvgugnPe8z5nOw1z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e55da04-7835-4537-1711-08d8eec2253c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 12:41:28.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4Ar3aV7kUsLC25Af5jw2GdJoi5HYzjnShwzQ/jNNHms5+UgWKYSrhZNP5+R/agg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 01:35:17PM +0100, Thomas Hellström (Intel) wrote:
> 
> On 3/24/21 1:24 PM, Jason Gunthorpe wrote:
> > On Wed, Mar 24, 2021 at 10:56:43AM +0100, Daniel Vetter wrote:
> > > On Tue, Mar 23, 2021 at 06:06:53PM +0100, Thomas Hellström (Intel) wrote:
> > > > On 3/23/21 5:37 PM, Jason Gunthorpe wrote:
> > > > > On Tue, Mar 23, 2021 at 05:34:51PM +0100, Thomas Hellström (Intel) wrote:
> > > > > 
> > > > > > > > @@ -210,6 +211,20 @@ static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
> > > > > > > >     	if ((pfn & (fault_page_size - 1)) != 0)
> > > > > > > >     		goto out_fallback;
> > > > > > > > +	/*
> > > > > > > > +	 * Huge entries must be special, that is marking them as devmap
> > > > > > > > +	 * with no backing device map range. If there is a backing
> > > > > > > > +	 * range, Don't insert a huge entry.
> > > > > > > > +	 * If this check turns out to be too much of a performance hit,
> > > > > > > > +	 * we can instead have drivers indicate whether they may have
> > > > > > > > +	 * backing device map ranges and if not, skip this lookup.
> > > > > > > > +	 */
> > > > > > > I think we can do this statically:
> > > > > > > - if it's system memory we know there's no devmap for it, and we do the
> > > > > > >      trick to block gup_fast
> > > > > > Yes, that should work.
> > > > > > > - if it's iomem, we know gup_fast wont work anyway if don't set PFN_DEV,
> > > > > > >      so might as well not do that
> > > > > > I think gup_fast will unfortunately mistake a huge iomem page for an
> > > > > > ordinary page and try to access a non-existant struct page for it, unless we
> > > > > > do the devmap trick.
> > > > > > 
> > > > > > And the lookup would then be for the rare case where a driver would have
> > > > > > already registered a dev_pagemap for an iomem area which may also be mapped
> > > > > > through TTM (like the patch from Felix a couple of weeks ago). If a driver
> > > > > > can promise not to do that, then we can safely remove the lookup.
> > > > > Isn't the devmap PTE flag arch optional? Does this fall back to not
> > > > > using huge pages on arches that don't support it?
> > > > Good point. No, currently it's only conditioned on transhuge page support.
> > > > Need to condition it on also devmap support.
> > > > 
> > > > > Also, I feel like this code to install "pte_special" huge pages does
> > > > > not belong in the drm subsystem..
> > > > I could add helpers in huge_memory.c:
> > > > 
> > > > vmf_insert_pfn_pmd_prot_special() and
> > > > vmf_insert_pfn_pud_prot_special()
> > > The somewhat annoying thing is that we'd need an error code so we fall
> > > back to pte fault handling. That's at least my understanding of how
> > > pud/pmd fault handling works. Not sure how awkward that is going to be
> > > with the overall fault handling flow.
> > > 
> > > But aside from that I think this makes tons of sense.
> > Why should the driver be so specific?
> > 
> > vmf_insert_pfn_range_XXX()
> > 
> > And it will figure out the optimal way to build the page tables.
> > 
> > Driver should provide the largest physically contiguous range it can
> 
> I figure that would probably work, but since the huge_fault() interface is
> already providing the size of the fault based on how the pagetable is
> currently populated I figure that would have to move a lot of that logic
> into that helper...

But we don't really care about the size of the fault when we stuff the
pfns.

The device might use it when handling the fault, but once the fault is
handled the device knows what the contiguous pfn range is that it has
available to stuff into the page tables, it just tells the vmf_insert
what it was able to create, and it creates the necessary page table
structure.

The size of the hole in the page table is really only advisory, the
device may not want to make a 2M or 1G page entry and may prefer to
only create 4k.

In an ideal world the creation/destruction of page table levels would
by dynamic at this point, like THP.

Jason
