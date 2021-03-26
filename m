Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0634A693
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhCZLrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:47:08 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:20928
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229604AbhCZLrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:47:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZviHwVr2+h3SANgHL5tnBkGxwplpyypJGZ0pppLOsY85W/DUyZAwxLxDJdoIqXcOqPDELPP5bOI+S4ooCGJNyf+vp0F/Epm+uM3Zmo28b3VrYJfM0uUW4Gv4nIavSsycTgJRtGLYbGvySJYXTSUcI2DMtEk0zZD9QmcgzSBg5mprNXhrSqElwWT+Yk5CwEBxx4Oquhp+PJmw13LPofn+bfHnxjWV8djHdA+2DoOuOPPlmw7RFowJytsMK04IRYuh2J6k9WgIDbYVDqc6KZMOFERKk26fYp7uvL+Mw83jvLnigUNI6Pp3vESIHiyMCR5AKMknKoL5P8LyEkR50u97Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIA9n5ndUr4ecicoNpOR1JXY9ze2KTAD5PLBGbY20Q4=;
 b=NhE4MPjL5CW70SvRjeCYCwA3v8dqFE1pviHbX2UucqrP8KZajYTs1UJRrC98J0kTH61r/SnyV6apig3O4+pWw75yQo9G70ryMDvBRSLCDCm7z54ltwpJErU6OwEe4dM8EYBHcu7IaHMxhm/RjNHoy8Kg+saOu76bxYZR6PcSaJhFU+Cf1zL4evjjv6t+fsqe6AkvGfR9+ggkYElmtdFCmelsGXUigWtYeO3jHMJ7biaO/1+c2JHMQV4rTljkqJPuzATaUV8gVa+l6Tzt0290HgjWQSmTbB5RZxxCXUpLKL+3aM+t+q0odtR056/c0gtAiDR6RcvkVRlYcni7uJYTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIA9n5ndUr4ecicoNpOR1JXY9ze2KTAD5PLBGbY20Q4=;
 b=Oj+Hr9sBOEEFTEWSrhUn67Vp9GaEYxCmu2BESrdX4rSmm316V9u3YwyW0Ufc5nK32BfKWlE5ojfwO5wRmjm00UnwvdP2+Dvnj8drAdWOL4fB0Z3hzITh4BM044kAQ/IHv+Du9sE+LIA5syh2fDI1UEG4jJ0YQFAkojz3NqJARkZ7TTwvvR39YoIkL3P7iHgE72+b5uuBEhLp686X8GuEwr/tpI2HFkJMjhlf3ucAg0JXPsLa3Xgo9uXuHPT3gbUD/vRUXVuA4630RGtnOeHCIidG5lnUtwQuEcEfx/Df8D54vAaeNdEVt0vv3BlWNUmZC9FfrUxsrnPVSW/VRGhBvA==
Authentication-Results: shipmail.org; dkim=none (message not signed)
 header.d=none;shipmail.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 11:46:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 11:46:56 +0000
Date:   Fri, 26 Mar 2021 08:46:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <20210326114654.GL2356281@nvidia.com>
References: <YFsNRIUYrwVQanVF@phenom.ffwll.local>
 <a1fa7fa2-914b-366d-9902-e5b784e8428c@shipmail.org>
 <75423f64-adef-a2c4-8e7d-2cb814127b18@intel.com>
 <e5199438-9a0d-2801-f9f6-ceb13d7a9c61@shipmail.org>
 <6b0de827-738d-b3c5-fc79-8ca9047bad35@intel.com>
 <9f789d64-940f-c728-8d5e-aab74d562fb6@shipmail.org>
 <20210325175504.GH2356281@nvidia.com>
 <1ed48d99-1cd9-d87b-41dd-4169afc77f70@shipmail.org>
 <20210325182442.GI2356281@nvidia.com>
 <1eda588b-ae51-9b69-4bd4-da37b2aa1e4b@shipmail.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1eda588b-ae51-9b69-4bd4-da37b2aa1e4b@shipmail.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Fri, 26 Mar 2021 11:46:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPkvW-003Iyk-CP; Fri, 26 Mar 2021 08:46:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34355dca-f3fa-4b74-5c62-08d8f04cdb34
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4617F7C43BCDF9C0C1A1CCD0C2619@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLPwPNFF38NeYMV7HwGYtXmJuY97S77o9BngZymEJuX/zASMO/n9FW4noxGQV+cVhzj94X+p9yRNhr78z/5DidKAXzCaL1JO+g6c7EdaSeb1FMkKDclcKYO5riKUCdm2akp7OYjOMCTSMNFuaq2wkFGgr7DSTu6WufGFzQ/Rn7hGQQ8qcULkKryuxB/0aEpLCmP4E7j0D3PWRAmiaxyzc15aPmWJgj6fy2SY6RlCsZpCd9CnO+e9WyFaAoEzQ3bnQT4Vl2heBrOazPorDU9KFNlgCTKJHEsLHk+in8uaFJIMw+xWSmwBT32XmjopaqiJPTSG8sM40zvDp8W9PEDA5KcuQfmedlU4fpe9U9htqtg42F9XufydyxJYzs48yoD0oPJrZUOXepLLks2UMERyqohplwAZ9ym0ka3uqzIGybJ2RwK11xyr9BbHWETdMSzWNWpjen3Gkbuy/Tm+quk9grlifmn+RUylmBdA/cqctJzID/fv5Fxo/vO5eX4ENHPcMypMTmoJU5nY3iMSvUzqNuAtXcUoJnjDDUTMHSLoczwdrGsisf7l0f/cFgJOK3oBeKpYdkaskbk4K7Uj8Yv3qgbTFTrDUNf6QdEr2E5DWNgZuRWl+2m92s6m8kVQtzuOPPQnJUrO1ogjwtaR18xstLq3dFdCr1eXN0qnIuJdc6KJd2ryPwnWCOoFF9g5ctZd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(9746002)(83380400001)(33656002)(53546011)(186003)(66946007)(4326008)(426003)(6916009)(66556008)(2906002)(26005)(9786002)(5660300002)(8936002)(36756003)(66476007)(316002)(2616005)(54906003)(38100700001)(1076003)(86362001)(8676002)(478600001)(66574015)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q25qaVZTYVZ3VnFTeExaeUpYU0R2b0RoUmpxS3FacHRZZStPR1gzN2U5VWNE?=
 =?utf-8?B?YS9sQi96VG9lMHpFTGdrUGlBSWdNY01HNHczTW4xSElKSXJWNGNoWENMcUhV?=
 =?utf-8?B?Z0I5U25uWVJnRVViWXFuN0xoL0ltZHZXRTdzZUxmZTFvdTZOQlZubHMxWUpo?=
 =?utf-8?B?OUNkd21RNmplME5DNVBnWS93bUV5NG9Db3NLc284VkxHR3FtYXhUU29RNW9n?=
 =?utf-8?B?MkdNR2tGMkFxZ1lHb0ZaNWEyVjI2M0hERHgxWDlsS0FCd2pmSmdWcUdDZmlK?=
 =?utf-8?B?RG5JQzI3TG8zSVp1MUh6c3Y2WG5wM2c1UDFvMEVjdmxlL1phUmprQnJKSDlr?=
 =?utf-8?B?UjlObDJpeEN6MG80V3VxTGlRc21QY0dvN1JLYkZkZjErK2NrdHdDQnY5S3R2?=
 =?utf-8?B?OTZ3SmVORjZHVVdCeVFxQ1dMYkhuRzJCaE5GZEdoKzUyMTZ6SFd3N1JFU3Vq?=
 =?utf-8?B?Q0lZZUMrRHdWU2FSZzZ3RDNNOExHUXdxMDZ1NGdlYmlBZlJ4M3pLcVdsU3BT?=
 =?utf-8?B?RVN4TTkwRld2b3loTWlBbzNrTEQ5bXhZYVdhcFZuNXROZUxkRmNFRFV6b2Zx?=
 =?utf-8?B?SUdMNE1RSTE2YUlHdlJzTi83RGtNQlhzN0lQQ09zbzllN2EzV2k3aG1acHFF?=
 =?utf-8?B?dmdsMGpOTTkyQU1oM2tzUFluRktwcHkrUjV4ejV0dkgxVWtzSjgyT05waWVm?=
 =?utf-8?B?NVU3WDNnaFRQTDZsQnl2UFJ5dEZpeDd0VFA1M0xIczJZd1Jpem5uZVl0Rk1K?=
 =?utf-8?B?c3J0OWFYRGQvZ2lNNFpYdHVydkJMK1JBT0hIeCtBY3dsRjZjS2xkNjVxeFJ3?=
 =?utf-8?B?TFBSMklqcnNhZStIVUE3cWpYR1p1ZDRwZlV6L0JDTzlOeVJBeWRqN3lQM0hN?=
 =?utf-8?B?Z3lqRXQyTGhBN1VxVUhjUGVYYVZMRTRGNXVvZ0ZkbFA4L2tjSC8yWExHZW1B?=
 =?utf-8?B?SWtQeFhvTkkwcUMrMjFJWUVxSXFRM09SQ3VSN2Y0OVpLdGE3OTRFUDIyenFu?=
 =?utf-8?B?RFhRcDRqTUlqMU9aREtoSUxTNHFtRGp1T2R1VHAzN2pnZHpJYmpGVjd3K0xY?=
 =?utf-8?B?UENFTnVCbkl5UVhwRDZNZ2ZPeGdISGlpSDNMTW55ckI5cVZTa25rWng4UVBE?=
 =?utf-8?B?MjFwT1dTL0FxanhnUFFmMm5FSkF4Z2NlZGE5TDRHRlN1Uy9uZzJQNnN4WExr?=
 =?utf-8?B?dzBOaEJUY2lRTDVxYzRzSWZxYUsvbFZlQkM2S05mUjF3SmloTWhFZVdzZnh5?=
 =?utf-8?B?cHdqMFkzK3VjQng5YnFuanZMM0pYelBZUXJ5WGlkWDdRa2RFZUFUSktXWGJF?=
 =?utf-8?B?WlNoN3Y3eFh3YjRUbElxMmZWZUR3djQwNVFhZ1hnVy9aR3F6Q2pqd1JweUR1?=
 =?utf-8?B?YkViNFBpVEhXMngyS3F2cmFJMHovUHF4RkFXRGhMRFppMmV4YWs4bGtSa3E0?=
 =?utf-8?B?cVA1YUJtYnZXbHZUcG8ydWV3VWR5OXZZaG9MYmpCdFpyNmpTM0RrUjhTQUNy?=
 =?utf-8?B?cnd6NGZMaVVXaFFuQkwyQ2UrRk43ekt6SXJYaHQrbW5lYXBBY0JJS0gzZWNl?=
 =?utf-8?B?cWovdzNaV3BzaUZxQ2phNXdWTXNXeEJCc0tnemxNdFdUSHQzbXJJV0dUY25i?=
 =?utf-8?B?U04zZW4weGZNR3FrcHYza1FzVUJ2cGZRNVcyeitRQkE1dDdUVlY1bDRzWlQ4?=
 =?utf-8?B?cmF4ZU0vMDFEa04wR1NKSE8ycjhkekxYaXVpWW5yVzBpNmpYM0ZVTVhmNzZr?=
 =?utf-8?Q?5LylTFKt49I7gfuepu8mJrbB/47JQ9ChPwoasgq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34355dca-f3fa-4b74-5c62-08d8f04cdb34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 11:46:56.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNCfHu3Hulal1mi9BHWXpnmk2JoM/tW6HoCkQby9gAAE8m1RpON0pey+tDv6UJ7U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:08:09AM +0100, Thomas Hellström (Intel) wrote:
> 
> On 3/25/21 7:24 PM, Jason Gunthorpe wrote:
> > On Thu, Mar 25, 2021 at 07:13:33PM +0100, Thomas Hellström (Intel) wrote:
> > > On 3/25/21 6:55 PM, Jason Gunthorpe wrote:
> > > > On Thu, Mar 25, 2021 at 06:51:26PM +0100, Thomas Hellström (Intel) wrote:
> > > > > On 3/24/21 9:25 PM, Dave Hansen wrote:
> > > > > > On 3/24/21 1:22 PM, Thomas Hellström (Intel) wrote:
> > > > > > > > We also have not been careful at *all* about how _PAGE_BIT_SOFTW* are
> > > > > > > > used.  It's quite possible we can encode another use even in the
> > > > > > > > existing bits.
> > > > > > > > 
> > > > > > > > Personally, I'd just try:
> > > > > > > > 
> > > > > > > > #define _PAGE_BIT_SOFTW5        57      /* available for programmer */
> > > > > > > > 
> > > > > > > OK, I'll follow your advise here. FWIW I grepped for SW1 and it seems
> > > > > > > used in a selftest, but only for PTEs AFAICT.
> > > > > > > 
> > > > > > > Oh, and we don't care about 32-bit much anymore?
> > > > > > On x86, we have 64-bit PTEs when running 32-bit kernels if PAE is
> > > > > > enabled.  IOW, we can handle the majority of 32-bit CPUs out there.
> > > > > > 
> > > > > > But, yeah, we don't care about 32-bit. :)
> > > > > Hmm,
> > > > > 
> > > > > Actually it makes some sense to use SW1, to make it end up in the same dword
> > > > > as the PSE bit, as from what I can tell, reading of a 64-bit pmd_t on 32-bit
> > > > > PAE is not atomic, so in theory a huge pmd could be modified while reading
> > > > > the pmd_t making the dwords inconsistent.... How does that work with fast
> > > > > gup anyway?
> > > > It loops to get an atomic 64 bit value if the arch can't provide an
> > > > atomic 64 bit load
> > > Hmm, ok, I see a READ_ONCE() in gup_pmd_range(), and then the resulting pmd
> > > is dereferenced either in try_grab_compound_head() or __gup_device_huge(),
> > > before the pmd is compared to the value the pointer is currently pointing
> > > to. Couldn't those dereferences be on invalid pointers?
> > Uhhhhh.. That does look questionable, yes. Unless there is some tricky
> > reason why a 64 bit pmd entry on a 32 bit arch either can't exist or
> > has a stable upper 32 bits..
> > 
> > The pte does it with ptep_get_lockless(), we probably need the same
> > for the other levels too instead of open coding a READ_ONCE?
> > 
> > Jason
> 
> TBH, ptep_get_lockless() also looks a bit fishy. it says
> "it will not switch to a completely different present page without a TLB
> flush in between".
> 
> What if the following happens:
> 
> processor 1: Reads lower dword of PTE.
> processor 2: Zaps PTE. Gets stuck waiting to do TLB flush
> processor 1: Reads upper dword of PTE, which is now zero.
> processor 3: Hits a TLB miss, reads an unpopulated PTE and faults in a new
> PTE value which happens to be the same as the original one before the zap.
> processor 1: Reads the newly faulted in lower dword, compares to the old
> one, gives an OK and returns a bogus PTE.

So you are saying that while the zap will wait for the TLB flush to
globally finish once it gets started any other processor can still
write to the pte?

I can't think of any serialization that would cause fault to wait for
the zap/TLB flush, especially if the zap comes from the address_space
and doesn't hold the mmap lock.

Seems worth bringing up in a bigger thread, maybe someone else knows?

Jason
