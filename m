Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF65347DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbhCXQi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:38:27 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:56800
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235892AbhCXQiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:38:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnX/rgWkx7BAJmNkPxMeDisyRBDS4Fjm9uxOQ+IFHNk7L/9q77uBtSaLl3G5Mm5BD5FKN8oV+1Wu6nQaLdxnm8K5JaKufY5uqO26CJd4eqezIreBEqqA7GhSS9mikCWWGIOedHbaLrjj/g8NLN9oQXopNKOZcRXPCpYN/P+OuSP7wswoULse7ZFO3rBjc/fugENNv0t98phK/VkpqPOYRmHjYcuYkq0yAbqWNEAFlRRlAPOIezrzYw/pHeEIu6FCFxZW880lNmTMg6cWvHoyExrEemMVXr4iXE3Y/yxFIJmxkeEbmHgDlOEX9YUG79r0dGkTQxWRV2MvG0U0f/40Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv4Qh5ZQzJ3MCjLi9QUo3xoGEY4GJ1GeP29Z22lX6MU=;
 b=OUhEZ5mYTk066X8O5b/dSKyCKm9vGDgcfxEn4XsS1rAJay+ZavJcri0baHcdrsGzRAGAQ5w+IPPvlQZSikq2vUPpo+pEhXaktHc3tQrD1qg6+WRG+zIJyNw53lcGEJ4e28NLpGr7jR5JVpsnDU0PrnrW6Ql4DJ0psFzGChr6ejtZQmceu5vogerLY88DTyDqglxZguA5P/rz/yse/8QhWoq18zt5hfdFu6KGdMgD9DkDvUhvat2bJRfzPEu9CPmWE55S1xMsD5kDiXQYyaFD/dEkjztdNGi/NAIKf0j1ayExs+1DmRE08rWn9GdUbCnWXRaefTiUmbhqNLX+/d50IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv4Qh5ZQzJ3MCjLi9QUo3xoGEY4GJ1GeP29Z22lX6MU=;
 b=qYBhngqp7tM16xfdw97gXAsHsJnExwx2jWnFwUtdtYtsadkIjdv9U3BAYO0OMLprfUAQl5gCUiuQeotgRS6lf+Lr7ysf+/iW7etSEpbnVhgHODkiXxhRzfaLI5lF125jrQI4H05wDqenIGZy1GOrtorPoBYXxsEhu0P0EXp3K05b0HRhmYwOoS7/Ewdw3XQu1+Wdq/eGZN3n2Wo4KSbDXSJ3lwIJ9wGfJlVxWwv+2x+wBTWlqwHQazmFVT9F32nehaeB73W4s/ZX0zF0yU+zQGBvqNECNIAITBOXaXnMS9YACbp04ix73f4dRa6cM85LIRs+rFdEYeptjBdg2XdjyA==
Authentication-Results: shipmail.org; dkim=none (message not signed)
 header.d=none;shipmail.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 16:38:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 16:38:13 +0000
Date:   Wed, 24 Mar 2021 13:38:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <20210324163812.GJ2356281@nvidia.com>
References: <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
 <20210323163715.GJ2356281@nvidia.com>
 <5824b731-ca6a-92fd-e314-d986b6a7b101@shipmail.org>
 <YFsM23t2niJwhpM/@phenom.ffwll.local>
 <20210324122430.GW2356281@nvidia.com>
 <e12e2c49-afaf-dbac-b18c-272c93c83e06@shipmail.org>
 <20210324124127.GY2356281@nvidia.com>
 <6c9acb90-8e91-d8af-7abd-e762d9a901aa@shipmail.org>
 <20210324134833.GE2356281@nvidia.com>
 <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:610:75::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:610:75::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 16:38:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP6WK-0024cG-6e; Wed, 24 Mar 2021 13:38:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb4422af-cfb5-423b-a4da-08d8eee337b9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3402771B43E65E0A279B18AFC2639@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLZtLYndhfUbFPikQzNJMH9JvbVO9lDDO6sU7fJ6QPQvOIlknDa4W4/wOeAvSAerkfdEMek+4TO3OYaDc6mNGlvbXnYKnpkwQsscPNSFnd0/SWLJF7fOul075UEz+S4AKvh98QdJBSOlVNb9sBpanu/VSOpGnEfZ2bD8/IiXOPccTyfxxOX1UGiwCYwOn/vdZiueBb84cv5uWkWcim0AH8WVUMdkLtLT+rHU+ZVFPtERPCAJ7EwRmKeThMFZpRpKirlsP3DUspRgLEq72rYn1mLJCiKWF1AQc7faQeDt/Ks8kpLeEWbhnP5129E0KnuxA5sPq/Qrzjo79rScbY7/NbcsQuvPtFXFUGpuO112N4T2firKj0XHTvHZ0V/mlLrvi15r/HB4gsCdJV7UziKH5O4pB6y5DVHR85lJXq/DehMYaeJXjb+Xc7z0E8wb0RWkEIftBjdk8kQ4Qs8SLmOG20f/Ma74qT+9QVnqD0POkl6eDasyAb+cP+DSi4x/seyIQEc9PE8qtNoam4wv6UEb89rzeVVkYnc9zxt8LDMQp1R4nwSVH3ceCvd0vYEuVIGHl+SiFIGRAo8vFizxrzaK3E9qsNGib0StW5be6qsLoTfGFZwzQskQCQAJyt79XVvHib/JqMht+wr6A1ay6pmwxEeNpwO5+mzjxH+1imIW8s6GOn9jSUk1rxAhQ2l30EfG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(54906003)(86362001)(5660300002)(186003)(26005)(2906002)(4326008)(36756003)(83380400001)(478600001)(316002)(38100700001)(1076003)(8676002)(2616005)(9746002)(426003)(9786002)(66476007)(8936002)(33656002)(66556008)(53546011)(66946007)(6916009)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z1NrNHVFRmxscnFpTGg5alMwZ01LSU8wRW5wV0daWEc2NC9ta3R5bXBVaUU3?=
 =?utf-8?B?RVM5UysyeTZxVTFDbEZCUFdqNnVsc0pSSWdxamtTMUtuVjFWV1N2S05MMkpL?=
 =?utf-8?B?NHVrV2VEb1JBVDhkdzhEUHBTekRwSEl3N3UwU2Q5SllSWU5JUnRWWlFpVmtS?=
 =?utf-8?B?elhHZGxKYzlsRG1DV3VRUG5JLy9xRlorOGpnellEeDR5TDdWelRpNVgzekda?=
 =?utf-8?B?ZVFSVVFoOGFab3BFUmUwOXlDSnJmV050M0UzczdoZVdpem9sUFRCazB0WDR1?=
 =?utf-8?B?M0tPNWp6WHo5dmxLVHdIZUhYTnJhaHZiQk5Ob2g4dUZLclVHODUwQkZLcXNW?=
 =?utf-8?B?NWVzNTk1RHJBaUVZZHRId1RhN3RRVVp1VENwclJBc1hsQjl4anN0SzlqaGhW?=
 =?utf-8?B?NlRIMUE0MXV5SXByZmVzNkRBV3ZhZTczeTEwUHJKVERyT2hPWVZtTFlIejV4?=
 =?utf-8?B?QVRxd3p0bzk4MFA1TFFpMmYxN2lNSVpkTGkvTnI4UkpGdGY4ZGxTenI4eTJG?=
 =?utf-8?B?YTNUWkhYS1lsSWxlQjFhemswNnZhOHNEcUNwbWY0Um9tMG0yV3N4S1VyMk8w?=
 =?utf-8?B?WEVXWG85TmYzenVKQjIwcG1FQTFLSCthTHJwSkxXWVAyeVdVd3NMZFdhcU9n?=
 =?utf-8?B?UVc5SzlvSkdSMHBHZWhXMEtKUnYxU1grUlZkME1DWHRHMXQ5N1BydzFoS1d1?=
 =?utf-8?B?Nmc3RGQrZWVjbnJTUEFaRUlob0R6b0JBeVZhUVNTaUovR1JlQUlrVjl2SFl3?=
 =?utf-8?B?U2czdUlHbWFEdDhTMWt3VDlmTmxjS3U0NkJHaFF5ZElGcFRSb3ZRSVVKQ2tl?=
 =?utf-8?B?NzJlcHlZdExqK0ZFWkJnc0F6RTdPOVltZ2F2VE9GdXdHSEVFdjkrQm9ZN2Vp?=
 =?utf-8?B?aHk2a2FYQlQ3eGx1ZEQyVnZIT2R5ZHA3d2dyYm1NeWpwQkhpdTk5YkhXSG9Y?=
 =?utf-8?B?dUQ1ZVRTa3NDLzhGRy9UMTYwMkV2Wnk2RWoxMlJjUDRiY1pZY055Wm5tU0xr?=
 =?utf-8?B?Mnc4WEliQjV1RVNINFBXd3IyUG9WMU40VWt4VC9aVEZrQkpsWjhycW9NWTF3?=
 =?utf-8?B?SWJKWFk1ajRiMnlmaWVTRE1OREowT3NrejdzUlJJdDkvdmJCaGtGVkk4NkQv?=
 =?utf-8?B?bTZVbEJMUXd4WHdLU2M2aDA5R2M1citiWFhmVGpFVVlZZGZVWlFLNDhCc0xL?=
 =?utf-8?B?U2sxM2Npc3RMcDhQbkVoNFhUWGFtazhkMHdKdVFuOHFwdnFackdwZ3VTYURo?=
 =?utf-8?B?SDlGdlJ3Y2lOWWRibXRkTkNuSE96WE11ZUZKQ2U3djEyTk9DQytNd0VaSEcr?=
 =?utf-8?B?ODlMaXRGd1lTUXJRRGh4aWxSVTZnVjRubEpXNUMvUmRMa0hTVVhHbForM2hr?=
 =?utf-8?B?WmtldDUxNHpJZGU5RzVTU0JuSnN3L2RMdzhtZDdsMFlMMTlMZmNFTDVEZlh6?=
 =?utf-8?B?blNkb1Z3blRhVmNrb28zM3BtMHlHYzJvL2FNcDFtQkxIQ0ptdG1qYSt1STQ2?=
 =?utf-8?B?QW1yM2hPaERlMCs5blpxVWhlVGwwY0JxRVE4dDBCL3hmREswQ21Ra0E4Z2lE?=
 =?utf-8?B?WjEzMEZBWUlEeUkxY2VDbllmeWV0aG1DTVNRUWdmUXVVTXR3RDlZdFFqV3Jl?=
 =?utf-8?B?ZGhqN0pqekdlSUFHdGd3cEFuWGFseUFFd2JYZTZLZFgxVDJYcU1QU2ltbExQ?=
 =?utf-8?B?SXhzZDN1dDVNRFZDL3hRWTUxcjZCM2pFSk5YRHlXWmJCaGFNbHNpWXYyMStQ?=
 =?utf-8?Q?+LVpujs5/TLNOFZfQCEAn7uN62miR5QiezC23CI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4422af-cfb5-423b-a4da-08d8eee337b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 16:38:13.4894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+bV9ZaeUjZBO4Jfw3hY6kQp5N8f6hUVfRt+JPRWjZGMy0zwG4j4qMSwPr55g97L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 04:50:14PM +0100, Thomas Hellström (Intel) wrote:
> 
> On 3/24/21 2:48 PM, Jason Gunthorpe wrote:
> > On Wed, Mar 24, 2021 at 02:35:38PM +0100, Thomas Hellström (Intel) wrote:
> > 
> > > > In an ideal world the creation/destruction of page table levels would
> > > > by dynamic at this point, like THP.
> > > Hmm, but I'm not sure what problem we're trying to solve by changing the
> > > interface in this way?
> > We are trying to make a sensible driver API to deal with huge pages.
> > > Currently if the core vm requests a huge pud, we give it one, and if we
> > > can't or don't want to (because of dirty-tracking, for example, which is
> > > always done on 4K page-level) we just return VM_FAULT_FALLBACK, and the
> > > fault is retried at a lower level.
> > Well, my thought would be to move the pte related stuff into
> > vmf_insert_range instead of recursing back via VM_FAULT_FALLBACK.
> > 
> > I don't know if the locking works out, but it feels cleaner that the
> > driver tells the vmf how big a page it can stuff in, not the vm
> > telling the driver to stuff in a certain size page which it might not
> > want to do.
> > 
> > Some devices want to work on a in-between page size like 64k so they
> > can't form 2M pages but they can stuff 64k of 4K pages in a batch on
> > every fault.
> 
> Hmm, yes, but we would in that case be limited anyway to insert ranges
> smaller than and equal to the fault size to avoid extensive and possibly
> unnecessary checks for contigous memory. 

Why? The insert function is walking the page tables, it just updates
things as they are. It learns the arragement for free while doing the
walk.

The device has to always provide consistent data, if it overlaps into
pages that are already populated that is fine so long as it isn't
changing their addresses.

> And then if we can't support the full fault size, we'd need to
> either presume a size and alignment of the next level or search for
> contigous memory in both directions around the fault address,
> perhaps unnecessarily as well.

You don't really need to care about levels, the device should be
faulting in the largest memory regions it can within its efficiency.

If it works on 4M pages then it should be faulting 4M pages. The page
size of the underlying CPU doesn't really matter much other than some
tuning to impact how the device's allocator works.

Jason
