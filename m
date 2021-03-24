Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D3634786F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhCXMYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:24:48 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:50529
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231566AbhCXMYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:24:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDgxdvXrd4i729NktA7TLfhfZLbk+gvWvcMrYwNEFpMPX2wE2wYKU+iu9++a8cwvWNhSRs5x71PQNr8g+fik01Gn/gM5uCO8JKaXzW5iRhmN8bJIz5I/FSauL6xN3XBBaktT+KL+WnWK4+H4DOybm/eq1CJAGzYYE9JDL1niCGW42ZNGTcbQlTeLy2dw7jSGlXiwZPYGi5KP0kSAITchKPeoepPYOIoFC1r6bAtGEv9rPQvwdcoL22I0WkUO9luchslOSGwCBQBHYyWlkEKoWPJzCB+cGPnAvMzU0/iExrwH5Ssp9OcsWFzuRK7pKlsoCHPbwwULy3JxNMFgpRgT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FBWiIXAhofQbkYblUPIbb5ol27zUlwYxHQMNJEB7HU=;
 b=gLlBkTuYMz6kMviFxH4dqwcOhQ+WrTH1Ujwr6b0Wz4AKaP2aebX0BIF3vB3nXsiii046RdTr7ngntaZbYfdsx0KDfm39HtIL9AlrcWoUnKgn6tz+1yh8eU9WTEGjY1+fjZRqoZHJ+liaR3C2lTp4//0aq2XGgoSx7VoFGp6ajUczWYXc9/07q1HMwY7BkDRgAuaiYzwReafliqjkECDbgF2vBAPxKCTl0B/3lxhWbRMU5NYlvP1k+RSHjGizMgTJUEJR+5kMjAiWY/2Zjf6QwHNobBhH1dxQfEVZ12eL3HDc1T6oGb2wnIC2XJy1zC6GW2ivz4SAiOTuS6XajwJwMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FBWiIXAhofQbkYblUPIbb5ol27zUlwYxHQMNJEB7HU=;
 b=fjpGwJiNXO6YloZaU/yU58DhJXfUtorzNIsWDkjFfP9Tave5iUHNDrWewjhSF4mHkyPNPeSlq23GUhkCUGkfS3Cgb3VtmEvIvFgit86dkcBsvQeAt9hlgwj0lknP2Or+S5z17FcNQBf2/I/MJbCezvJx7kuqG9Cl57LvccbS2S5FtoTGE3t0oZuoiDLyS8M9YNvRUEKgMw+6UTnKnIht/oGxn9tjQhddQ98tu3f6viBnJhSJ5lHXS6a4iis3SEoEgPAhTQiYEvPscZNTV1D3yeHmoYEz1RwFKbra7/XLRdTfpPE2NlYhrLTwOjyUs0FpkzYYG71uv/4rm838yGnfmw==
Authentication-Results: shipmail.org; dkim=none (message not signed)
 header.d=none;shipmail.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 12:24:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 12:24:32 +0000
Date:   Wed, 24 Mar 2021 09:24:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <20210324122430.GW2356281@nvidia.com>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <YFnST5VLcEgv9q+s@phenom.ffwll.local>
 <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
 <20210323163715.GJ2356281@nvidia.com>
 <5824b731-ca6a-92fd-e314-d986b6a7b101@shipmail.org>
 <YFsM23t2niJwhpM/@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFsM23t2niJwhpM/@phenom.ffwll.local>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 12:24:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP2Yo-001yu8-BY; Wed, 24 Mar 2021 09:24:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 471eed84-f9dc-4738-78b7-08d8eebfc748
X-MS-TrafficTypeDiagnostic: DM5PR12MB1434:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1434BC102C211EA874A68E7AC2639@DM5PR12MB1434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPLZtBABdo5QzJNJUk7YXugEOmGVOvsnyT652lKBf7KdqNPZbwMikaNfRLj64Xh76vydt2npGpJnSrDr3luuEKON9CvAOJ028O3DYbk0ztb+o7rtkfO6cEXP8r/gZvPJjrBNE1oF2iR4wrb845ktZliHz/OJXeKeJgZH4UMiAxsyny7SoL2KRHyfCIIGSihArdDgBhihJPYfKOs8tRoucsgWwDkJMQ/b7NAFl/yPwbCGo29kgHtu0s3jzRMiqLRKI+xb2xwT1slLTjnpQvbhxA9LdDzwvoiTOO1eCtKscyejj8Ra9LYCIaBAKY2D/yF/Hxw1i8McnqzKmH7WRN6msJuhjG86bCspVCsA2+n9SOaaiZ5R2FTRgpAWQzg+XS4/VNfDRAjDX+aCKKcNtRejM2nIB2jdUuFT8YnaYI90M1kFMfh8mokCQmeVSX8Y+uKfatPH6OV+RSCGOK8mqe49b2MUCks8PB1WuMGKBgiUSUvJXr61E+qNhBwcNz7GXrW+Dap5YKoM0E3w8cn4nxsnhgkzgaO1wCnkX2ODEfd9IDmtSUA2X8J9i8aVNpmw1LvG9s15qVGop4KwUQIe1f43CMJBKv4cRiJ6dvjOIqd70hzzyMrMHAT6uzWU8OsAg6sPmr3SpI4VZD8ad5BxMx1U5wdxVPGTffQ+7XWwc137mhOpZNzseUmmgI+1oZ23fBjTZKINOZMdh/9DAJFV/W6r0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(66556008)(83380400001)(1076003)(5660300002)(9786002)(9746002)(478600001)(26005)(186003)(66574015)(86362001)(316002)(426003)(2616005)(110136005)(66476007)(36756003)(38100700001)(8676002)(8936002)(66946007)(53546011)(33656002)(2906002)(21314003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dFVsZXNEZG5BWmxSZUJXZzdRNzlvc2Voc0JMSThoREhIby9XRGt6YkpFSm53?=
 =?utf-8?B?RkZBZnV1N1VYV2t2NXhmUU9HTU1Sa043ZWhBT0VKRHhweFJReThzdnErTjNs?=
 =?utf-8?B?anFONkpkNmtFbDFxNnpRaUFhV29QV29VcnMxZ2xBWTRWb0kxTVdUaEFxcWpt?=
 =?utf-8?B?TkY0RnZ1eFRzRU00bHVJbGRaUk1GMG83aGNtUUNBdjRZSlpOeTV0b09sZTlw?=
 =?utf-8?B?RWlrbFZkeEkvT0MxTk5CaUdiQTlFeXd6cVlxWVY2QXd3VG1ucVA4ZitVZUx5?=
 =?utf-8?B?bzdoSDlHaVo3VXJZSmY5Z0prVDZWajVVMmp0UmxVZlJzWVZvNGVyeUpaMXE5?=
 =?utf-8?B?VUQ3Nkx0MElPanBMbys1SHBucU8vTzQ3c25CNDJKSnc5cjVENzYrd1c4a0hv?=
 =?utf-8?B?ZHVOT0s5VndDY3dibnQ1RlN3RnlkM25rTDRYRmdNUGNmOFZCTnBRTGlzMnNB?=
 =?utf-8?B?SnpxWDczbmwxck9ZTS9EZUFEci9hVnJOeEk4dW91amlxL3Vlcy9Tc3lKU3BG?=
 =?utf-8?B?cmMyZGVKSkx4VGkvYUQ5RVA4OXB2Mjg3K1Bwenh2MFlzSWJ0OTk0aUtPb1cz?=
 =?utf-8?B?N1Y5UXJSV01LcmJkZDIvaDd4NWtodWc5V2xwRjQ1MXVBQTFkYWN2RGJab25t?=
 =?utf-8?B?Q3ZXOExiTjQwNERnQTRQUFdWdytkbnBjUG9PaTR3V3lDZjFYdDk1b3k0RC9p?=
 =?utf-8?B?cFV4RXVSc1YwSGljeC9QbDlNcllpN1ZzU2Q3bVRJanpwWGppZnh2djZsN1pH?=
 =?utf-8?B?ZEZHd1RLWWdHdkZrZWI3UkxHWFRjZXVPNnFJZUI1QUR5bkdTdjQ0TTJkR1ZT?=
 =?utf-8?B?K0Nuc0xtOTQ1TktPZnQxOUdrQ3ZWMFYzdzdHZzVvRURpcHo1aTJ1REg0TFpu?=
 =?utf-8?B?SlhKZks5V1p4eU1nbWUzZWdrTnlJcVE5Q1c0TnFjT0FEeGdWSjZqdWZhK1pl?=
 =?utf-8?B?R2tsMFAwMjBtaVh5WTVuRWx3RmZqSVRGMzV0b1FteUc4NDd6eDRxNi91dHBw?=
 =?utf-8?B?Tml3OEdPNUNuVHNDWm9jU0tXVFRGcGpGZ0o0cXdpUFBGaUFXdFl4SE9sS1hY?=
 =?utf-8?B?L1dzeE5CV00xU3BKeTNYUzBpZFlwbnRvcjd5c2NDdUlDbGRPanB4UVdXVytK?=
 =?utf-8?B?S3BLMzkzdjd2ZmJnNjVNUHg3MW9iSDNCd3R3U1dkalNHZVFHSHJvTHkweGFx?=
 =?utf-8?B?d0JTdnRTaXVJQzVIZHZEbDQyRmhuaUtWa2h0UDJVNHBreFhKWElQK0QzYjFm?=
 =?utf-8?B?ditqc05aZnZ5dEtpQ1NCWEo4c0NRUlY5OU81Sm9uSzlCZklML3RPdHJtSE8r?=
 =?utf-8?B?Z2d4U0grdlZqdi9kWG5wb2l3cXBseWNiM05jWkMxMUpaS1drUlZxcnFXU0ZJ?=
 =?utf-8?B?V1d4amxoRTFrUTA5WXd5UXZLbkFmTU5Mc1NJV2YwdVNHSVJoc0VYSjJ3NGN5?=
 =?utf-8?B?WmtKczloNUFGa3RUVVJrYkcxaE54b3ZXMk04SlZ4WFpmaUhzNjFCTVVTZ1RB?=
 =?utf-8?B?UVM4SnB0ZE82QlJlaGRESmdBRjI0dnJrcnRhZWliZHlGUW9rMklOTTU2WnZO?=
 =?utf-8?B?ZmVkdkVQWnUrYkVkMWxXRDVuRlZzZm5abk1BNk54RVhTK3Z0SkU1NkRhc0k0?=
 =?utf-8?B?dVRxSFE2ZEIwR2lQYW1HR09PRmJsTm5pZnB5eVluQmE3VG1YQXF0QlYvMGRP?=
 =?utf-8?B?TDBUWDltM0Q3c3dENzdPK2IrSXlYTkoxZkV0a3g5Ly83RytZOTJWL0sxK1l2?=
 =?utf-8?Q?5vpv+hP6EwfF1Y54BmhAl/I4ePCNP6Hpphkhzgj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471eed84-f9dc-4738-78b7-08d8eebfc748
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 12:24:32.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/mQ9uFNpgYN4xpXoiphKDjI83MyFxwSWFl8Uz548ioD6d3UWsvH2hzov5XQQmay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:56:43AM +0100, Daniel Vetter wrote:
> On Tue, Mar 23, 2021 at 06:06:53PM +0100, Thomas Hellström (Intel) wrote:
> > 
> > On 3/23/21 5:37 PM, Jason Gunthorpe wrote:
> > > On Tue, Mar 23, 2021 at 05:34:51PM +0100, Thomas Hellström (Intel) wrote:
> > > 
> > > > > > @@ -210,6 +211,20 @@ static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
> > > > > >    	if ((pfn & (fault_page_size - 1)) != 0)
> > > > > >    		goto out_fallback;
> > > > > > +	/*
> > > > > > +	 * Huge entries must be special, that is marking them as devmap
> > > > > > +	 * with no backing device map range. If there is a backing
> > > > > > +	 * range, Don't insert a huge entry.
> > > > > > +	 * If this check turns out to be too much of a performance hit,
> > > > > > +	 * we can instead have drivers indicate whether they may have
> > > > > > +	 * backing device map ranges and if not, skip this lookup.
> > > > > > +	 */
> > > > > I think we can do this statically:
> > > > > - if it's system memory we know there's no devmap for it, and we do the
> > > > >     trick to block gup_fast
> > > > Yes, that should work.
> > > > > - if it's iomem, we know gup_fast wont work anyway if don't set PFN_DEV,
> > > > >     so might as well not do that
> > > > I think gup_fast will unfortunately mistake a huge iomem page for an
> > > > ordinary page and try to access a non-existant struct page for it, unless we
> > > > do the devmap trick.
> > > > 
> > > > And the lookup would then be for the rare case where a driver would have
> > > > already registered a dev_pagemap for an iomem area which may also be mapped
> > > > through TTM (like the patch from Felix a couple of weeks ago). If a driver
> > > > can promise not to do that, then we can safely remove the lookup.
> > > Isn't the devmap PTE flag arch optional? Does this fall back to not
> > > using huge pages on arches that don't support it?
> > 
> > Good point. No, currently it's only conditioned on transhuge page support.
> > Need to condition it on also devmap support.
> > 
> > > 
> > > Also, I feel like this code to install "pte_special" huge pages does
> > > not belong in the drm subsystem..
> > 
> > I could add helpers in huge_memory.c:
> > 
> > vmf_insert_pfn_pmd_prot_special() and
> > vmf_insert_pfn_pud_prot_special()
> 
> The somewhat annoying thing is that we'd need an error code so we fall
> back to pte fault handling. That's at least my understanding of how
> pud/pmd fault handling works. Not sure how awkward that is going to be
> with the overall fault handling flow.
> 
> But aside from that I think this makes tons of sense.

Why should the driver be so specific?

vmf_insert_pfn_range_XXX()

And it will figure out the optimal way to build the page tables.

Driver should provide the largest physically contiguous range it can

Jason
