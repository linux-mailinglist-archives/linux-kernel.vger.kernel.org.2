Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE222346570
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhCWQhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:37:43 -0400
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com ([40.107.244.54]:23091
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233414AbhCWQhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:37:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqYL8SzR0L2YE4paxEK9jTHaa0dye3MNEcoLYY4HG9UDZjFOzV43x63ukw1LlKM3Be0IHohFGBcNaIThoouNeoRG1VMqz8Zp3u3M92TZyiJSPrbqUGQ+5hJB70/nh8Mm3J8hJCKLfvLVtdhWRpaKSk9s6jUfPXAum4k+aF9q19BARNNegoxtBy+E3lqpKS9bNxwBWbpvKnYhNXvyxlJ2ipsRP0Vn41QS3yhe/sQhEXDmg/O+jE/L1KxTRWMO8wYtgyQSIVFI+HP85ON9FeaU1GbijOTaxdWx2tpG2DmU/P6OVXJ+4gL72UmFlAYeGzoI/L66krYswEpeAVbdA+gRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yEPbVHVGSHnyu8v9GeH6CyGZ756P6R/fnr1NjRnKFY=;
 b=k1i2qvadfq4cgWZTgVjPPu9gXQpZhmTE99IrWiDDxg3974OWDmSi01mwLUVykaaQER1GJhMsujtrVjJWpZ81tyX1lUXRVchqWCttXTFwl17vQguQMKU6mxF3VTJI/t2prpVYOZ6JcTFRMQYpzfDyhDTHV+I+H4YUl5oGRW4u39fiYfSjmNEW5UhLBa3jRTho3LoKOPhGLDeS54DMZHl4pWHyFritu9PI1oFsbXuH55fz+boN6xCTmxoI00g522q5IYql0zMWWzxnIM7nbSQU4hFjNpwF7VJOwEGoy6EW1rjyp/fUdv5HAL5cS3Lv+2M/Ww/3MGtgO5keCYSnUxm9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yEPbVHVGSHnyu8v9GeH6CyGZ756P6R/fnr1NjRnKFY=;
 b=NpW7td7aCciipjrwwvJJ0SGxX0tYeVdKHZwzZwdii7aWyFzLt4KyG0lFA4cSjvc8Tevag3Ta4ZClrfktC0Ahi644gmII6I5CfWV5B2bnK56pK07O1kvkKfcHgUVksMHRtK0EJKlzzIwc6nOiqBEVvL+ofiV8iu48dTuE6bWIXtc9t59Gw7vlF9j2nLY3Xu4YHh/c+7/ueIAetNMa9/NIJg0S7XAfbdX4BI02me525zXzRBebIaQ1GgHs2Im6a6UGtpwdOnAAO5AptWGwRzSYI8ENWYQugCe8VKJ0SnN48bedOkls7G9vUKVuVEaqwnUmYJ5YF73Jf6sJM4+NFk+nQw==
Authentication-Results: shipmail.org; dkim=none (message not signed)
 header.d=none;shipmail.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 16:37:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 16:37:18 +0000
Date:   Tue, 23 Mar 2021 13:37:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <20210323163715.GJ2356281@nvidia.com>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <YFnST5VLcEgv9q+s@phenom.ffwll.local>
 <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: BY5PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:180::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BY5PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:180::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Tue, 23 Mar 2021 16:37:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOk1r-001ard-Vn; Tue, 23 Mar 2021 13:37:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55e80cac-5f53-4bf0-3bb9-08d8ee19ecb5
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24886B09EB4C18EAB722C859C2649@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1q+9ExTdSLKvI71NMbAAQ7EByU4PbToZQz9LEqiRUBp938bU9x0DIlD2Db8Fh/3Hk/sQXDOgpoYZ1/8nsj5SjloDclqhPklGCX/2b534Z7kxMzGvEuu+HVRjCjiAQdenT7i8ZNKGd5OidvWJIUjnhaLntDlylGh8nDNYA7RolA6911OEcT2MYrX3mJp2bz24C2jmnRT5XtPqXzXoJffqwif4zcQxYsI/zpXo6+MHLm7ZLCZPxMw384kkEnLvzNcP+5nedE0ECgtexgX79wjUHhA/uY8Ba8h0mNIvTfIvAu/obieRB/02Q+Lq2oq0ELIiyhXyEqnlSlMcBndXYBR2j/1ooOVBrZqoLZ0XmnLffaifk5ZfSuWi89Ft8nIM9Uvtp2AXhOCxv0FCviiKxZKeYv2EWc5D2PfwCC3nl1gx16z79/8z+wIqXVNrzjmedcmRrMB+45VrSFek5ZbZR+Z5PDRaeluxQeTS6SWdNivOdTj7huqG8RERHZmEClDS1dNSeMEfc48T9SNoKfVPgIaIFx1Fo4qPnVqLBEJ/Y22EFNEGyuIDn8SrGBXc+fANG8NEr0RjOtHQ7UlKQ6R58L2MufFNVPjUDyURyVFfO83wp2lDxPDWixLZXy882BETDniR2DPOZ74vDODfhCNgnQvKO8vhKFzcCJsFxXOhoP5ZF/cL57oIniTdEKG6Db7cIs6D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(38100700001)(54906003)(316002)(9786002)(9746002)(2616005)(66574015)(83380400001)(426003)(8676002)(66476007)(66946007)(4326008)(478600001)(6916009)(1076003)(8936002)(36756003)(33656002)(186003)(2906002)(5660300002)(66556008)(26005)(86362001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OXhGaHIzR3UwdUZpSDNpK2JZT05pQllyeXdBeWRmMHA5a3owTjVZWjdZNDJV?=
 =?utf-8?B?NzNqRkRBSHFUOEZCQ3JGV0ZmV3hyK2Y5c1NRZTFSNHl3SGJEZjU4SmdzRFFF?=
 =?utf-8?B?Qk55ay9hQzlDMVJnbmNRTWtqRERFaWZDdWZlbTVvNWc2MVY4c0Nsc041MU02?=
 =?utf-8?B?RkNIWW1iREN6Q2ZFbi9hYmd6STJuMkVHcTBCMk8wYlYzakZQUno2R1Nhc0ZJ?=
 =?utf-8?B?RWdyZG96N3FXaEU0cnV5Sk5MZTFtRG5BWTc1WUNCd2dMQnJ4Umc3T0ZLTXd3?=
 =?utf-8?B?YnJqUnlqd3BuNlE2Yk53cDAxTnJHUmxBN0thdUV1aFVoZ3NVZVpBZlVEYkN6?=
 =?utf-8?B?bWhzVkdUMDBXYVYxUENReXVNSk95UHNMdm9JUVUwcU1xT0tqRHdicVVpTGNo?=
 =?utf-8?B?WlIwRUFkREtkbGxhNldhNzdiT0gzWWpITDVDWldZY0NFRVlsN1EzYzQybnBL?=
 =?utf-8?B?OXliVGxFei81YjhpZi8yelNvaTNVdDNBMm1YeFVNeVNaajh0VzhsbjY3dVRN?=
 =?utf-8?B?bWU4Z3hhaDR1Wnl4TzFIejhOa1ZJZTZURnBOaHgrVmVmcDdobThGU2dxN1JN?=
 =?utf-8?B?ckRleGxQK1drWWJ2QWZEZTNzVnRLNzlVQlkxQUIra3E4UlhiQUpOYmpJSWVw?=
 =?utf-8?B?Z1NlNHZiQzdmN1dQMHR0dTNPRFA5b3E4TVBjV2ErbkphUDdIMkFudnRqUzRK?=
 =?utf-8?B?cEZKaTJwWlpkVGZPbVhxMjlvVzVjZnRNd0k0Nk5sVVByWk1tSENRVDB2V3BK?=
 =?utf-8?B?OHNPdnFjMS9NOS9jQlYzOTl2Si9oVC8rV2JBK0lNaHNHdEwrQm5weCswMk5F?=
 =?utf-8?B?RE1iTmxkUmNyakQxNUJ2RVUrc3BkbDVXVVlhYjZmOWhZSGVHaTc1d3pqUDJv?=
 =?utf-8?B?S1RzcGJCemlpKzJxaU1mWUVkdHh5Syt0MmNmc0RsZmNSQXdpbGxESkovL0Ru?=
 =?utf-8?B?N2JWVGFHbWpsTXJkeWlFMnpUbEw5YUxpdURpWWhhMXdoUTlPZTJPeTdwVW83?=
 =?utf-8?B?VWNGRkV6WjFVcS84bkZPTUxyQ0g2R0lTbS9selNIR3FOZVNtamIyWklnZzk0?=
 =?utf-8?B?U01qaGlzdE5zc005eWc0WlJtWERzOW5aMTZwdVMwajlydlBTZmFGZ001dy9V?=
 =?utf-8?B?RFB6WTJ6OHVQblUvVzJUOFBEbC9LL1JMdUtQUnM5SHB4OTljN04rUFFmQ21m?=
 =?utf-8?B?NHZuREFVT0twQk0yeUdqQjBTQUZyWHE2aW5wMkpIOVdEcUp2MVliRnBBeU5X?=
 =?utf-8?B?c1k3cXY2dURmaEFUVXBYd3ZXSWJtQXVEQkNjV2l0eU9ScDR2Z0ZLZU9vMTEz?=
 =?utf-8?B?bGR0ZGEraVBRUDI1RVMyblNjUVdabCtTYVBBcnFDTmhUemRLR29vbm1nRkgw?=
 =?utf-8?B?UjBRTVRzSkVXZEc2SWEyRzVKTUJrcXNBcU5yWjM0QjY1aWRWa1NVU2NUSTdM?=
 =?utf-8?B?ZUJCOGRFVENSbzh4N21rbWxTVzVPWHVkekJ5V0FaeFVMN016Rk5HQjJNMkd2?=
 =?utf-8?B?eG1oZnNPclh0cVVoSjFxLzFmNzZvMkZKMSs2aitCaldZOE4vUDJuOW5kQUFu?=
 =?utf-8?B?TkUvNmpoUkRsNUx5RDdFTmdsRlZiZVZHWVE3bnNlZWE2UzJESWxVUnhvTkxN?=
 =?utf-8?B?THByZXc3eS9wRnhML0dZQVl1VWg3QVBOOWN3WFYvOEFOdlZpQU1udkswVVhx?=
 =?utf-8?B?Z1hsYmtDeGhjb29MQVVRdjFZZkhWZ21oOXRwQXFuYkdZUWx2QUtkQ01lQlhr?=
 =?utf-8?Q?QDY/oLpn3OVhulD+IncQt7NC19Y0zVdwRiAm2VM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e80cac-5f53-4bf0-3bb9-08d8ee19ecb5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 16:37:18.8137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhMVhLldrklnO3bp3QJcLl8x5F7pEL4ta4QG9H4VYFjaCyEa5s8QZsrRYNDECmOH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 05:34:51PM +0100, Thomas Hellström (Intel) wrote:

> > > @@ -210,6 +211,20 @@ static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
> > >   	if ((pfn & (fault_page_size - 1)) != 0)
> > >   		goto out_fallback;
> > > +	/*
> > > +	 * Huge entries must be special, that is marking them as devmap
> > > +	 * with no backing device map range. If there is a backing
> > > +	 * range, Don't insert a huge entry.
> > > +	 * If this check turns out to be too much of a performance hit,
> > > +	 * we can instead have drivers indicate whether they may have
> > > +	 * backing device map ranges and if not, skip this lookup.
> > > +	 */
> > I think we can do this statically:
> > - if it's system memory we know there's no devmap for it, and we do the
> >    trick to block gup_fast
> Yes, that should work.
> > - if it's iomem, we know gup_fast wont work anyway if don't set PFN_DEV,
> >    so might as well not do that
> 
> I think gup_fast will unfortunately mistake a huge iomem page for an
> ordinary page and try to access a non-existant struct page for it, unless we
> do the devmap trick.
> 
> And the lookup would then be for the rare case where a driver would have
> already registered a dev_pagemap for an iomem area which may also be mapped
> through TTM (like the patch from Felix a couple of weeks ago). If a driver
> can promise not to do that, then we can safely remove the lookup.

Isn't the devmap PTE flag arch optional? Does this fall back to not
using huge pages on arches that don't support it?

Also, I feel like this code to install "pte_special" huge pages does
not belong in the drm subsystem..

Jason
