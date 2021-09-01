Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478793FDEB7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbhIAPdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:33:49 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:62720
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244459AbhIAPds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:33:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3I1rJYd9eTNX5kVz6Lw81/LaY41kgoRU6J/kC7rYFqTDnkjqmDXV+XtS4PlqilXvwvRozoHz9gpB/e7ywsEKE4TrOUdO79an5ZHyLpmATyuXW4sZCSCkuO0yzs/hH4kbWYbB4ESJ09R75MT6srIWea7+DWDUfQkkLKyNAeVBD6jUM/VsMKLzGBBOT4NNcfWu32PFD97M+tDAHQ3kA8pHdBwnGlhbYJZvdKjAkMAeCSoXneeXzPpTuaeSYvjs2qrt3/a+s5pMOb6VgBXK5r8WQ/SP/DxXbMninKXnJ9Db9ZRe1TtikhwvZN0O8ixiAAHQhCBWqXwv3SfQVXvaQw2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xRypjF1lbdtLE4dBdmVipqOyjXxbKOJyW1XsgPJZxI=;
 b=jBJXD2Z2pMe3gkDnH59kVflepEWkla58XmqXP1ecY3QazsL797EnmvEMGlXqXqeJvYvN/PpsLZnfJy1COwp3RZRfIyUDd4tBtIGIE/Flo6hmRuX38K9Gqj0wDPSCJ2D2t6RbryD+5vtDZ16Y6vur7W+Vez7wow+Low+SEyNlY9HN5gpJrbiQSBsClmWA2olNmlnw0gJAYJQBd6wy7F4e8MojYC4dhs43a0HQXdkTp7l1bpUtiabl3R/ACQOPJIUhuc2NkTRkT+WQRUko3YGfX4NYACEbk7lKx7ZVZfTJxLb7DMJwHSbwuK/s8wzfNKcgumds2xJO7aIo4Nx/jXaP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xRypjF1lbdtLE4dBdmVipqOyjXxbKOJyW1XsgPJZxI=;
 b=cpDZpB/Z1tn+UdRiJFwM6wtA5us1J+B1feXHe+27chzB3hAaKdCDYB8UnezCMDIulRKY07Fh5OxLxsbQNXjV+KaluOfmBa9IJKWURKSP5WFocsnnV6IGpiEj4BSxegGc160cPWxY16ifckkGBvVfjBvZNV0C1U0PCmzpsyNJ//O2re+HE1Hsdn6CYJSzyMFWYeXWgIfpe+F9rHs4KWHJ1O/eVgUzR8gZ1lHv5UvcUDJRwNAj8aeK5XG32LNddkSG0mUd3F/23Azoc27n1vVaqc62cLhwD1vn1HzKdGpj1KcQxUzCFj6/ssRZvBb8ssMTc3dttW0DA4LH84K3yEmdTg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 15:32:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 15:32:49 +0000
Date:   Wed, 1 Sep 2021 12:32:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
Message-ID: <20210901153247.GJ1721383@nvidia.com>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-7-zhengqi.arch@bytedance.com>
 <20210901135314.GA1859446@nvidia.com>
 <0c9766c9-6e8b-5445-83dc-9f2b71a76b4f@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9766c9-6e8b-5445-83dc-9f2b71a76b4f@redhat.com>
X-ClientProxiedBy: MN2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:208:e8::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR20CA0009.namprd20.prod.outlook.com (2603:10b6:208:e8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Wed, 1 Sep 2021 15:32:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLSEJ-007rRM-4t; Wed, 01 Sep 2021 12:32:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c01a8d9-eaa0-49df-3538-08d96d5dc095
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111D1EC7149F61F0758AF80C2CD9@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmIp5ip+CcIsztpYt+AM+JoPuW48P1GcVHy1MNF0wh8m3wPgLlbKCefuXoMYGQH/cyi59GS0qSo+6oHK+5P9E7PDCxFrd6LWYvgixOU671Rmlaq8BE58hNBf7azpvrLL4cFg6zdCSGAM75XTbiOUf9hyteeRQvfpdbjqArS9uXr4ZRRV05A0iqIe2v5ucQQB1Xsz2sc8VB0HngdY/Mrn+bNAk2cDUNgf4Z9NmimU2Yhf2WorhCZgAYaFAivVjAi/1WcpBV6NOwIdbvq+Gf6NGsukXzd9jcVWTY1Wk9jWLdb3c765p9F8IBsYqLxvu4HE+70k7ZnHJngXp8kgnK+BAtMmZFfc1iNSf1HN1XHVHrivuFSgQ4+qfHjHXnViuNO18fYP5Z6rLpMJbZskid5DEbR1IGpwECQRbjrkgbghkD0zAE9rAuKhJSRGHSZxtZO8ASQfWXs1ZLjFqVsE2P0opBaQknjZItf0AfhrbgP4iIGaJGy1TCULAuHk2E7qqARiOXVBLL0/XVoYrM8/BkruqN8cDWM8jzOdga4+z84IJ3jRXLifmaaHlRmbB9oq71xngcOJGEYHhotFwKij+fuu+qKBU0TOiePzzfQYzVe4HFqrO0lKzOhvGSw67l+w/TKTVLqmqHhmDxmoAz4m8lD0gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66556008)(426003)(5660300002)(9746002)(7416002)(316002)(9786002)(8676002)(2906002)(38100700002)(36756003)(2616005)(4326008)(86362001)(53546011)(1076003)(83380400001)(6916009)(66946007)(66476007)(508600001)(33656002)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6s+gCerC1/OlG7erO4sz4HmBNr8whviIJ9txtjgSt8s9mtpKXjSXa1Oc9beB?=
 =?us-ascii?Q?EyB4yuVDdd2/7oAkQQ2BmJFJuCc/kHYoBeBbeXYsSpdsF1DeTlWJIUTGPbjy?=
 =?us-ascii?Q?ypLSwJeZEyD/3XEZWMeSkI7aYp0XAfF6qzjpwfwNZjqapJjs6cpkl4svcb1i?=
 =?us-ascii?Q?3Ux3gS7OSrogySs2uqbiLrmmsSeTU2/yTTALO8OxEKQpnSOaB1D3Hb7bRQIu?=
 =?us-ascii?Q?pgwdfrj2LCsKCeCTYd9G9Fb64i/A99erOn+P3ecSZ3TIMTt3qXOzaCg2qyQO?=
 =?us-ascii?Q?+16HLWb8RbcxSIBJcH+wvECgeOgOclkeE/Xo0Tn27xfgobK5r6zv/c8fLKEe?=
 =?us-ascii?Q?3y6A6+hKamdWEQth6e80pIW5QHVJbgAMEf8+oehJ5ZfdiQzsWVETIdP36orI?=
 =?us-ascii?Q?HVVIh8/lHl6ReBaPk6hQT0jzIhJL8LB1ptzXZtmA2d+RLtOFrozWVWfOTxbw?=
 =?us-ascii?Q?MNkgktBJt/Vvy1buW0K9DPWZKUM4ve7WK+ZuiJzodHBqVRONKl/q5Bw0T2uZ?=
 =?us-ascii?Q?SnvT6sKY0Z0kKbfKoLg3dH/vAGe6/Bre2KC3Gy48KJ3ZXi/xgczfYZJjbuET?=
 =?us-ascii?Q?OnjPKxgq1vEQk8nbj/OO8jytPAhDY2x0yA93k5JPXmHETUFz8DNdsaOupxm0?=
 =?us-ascii?Q?YAa33BDfgGPkekmS1CDE+dkOUlMSRk5SCVhGLcdLphyYqEFzA1t5IbaVlRMQ?=
 =?us-ascii?Q?ZDIaqEsivR+sbK5ZThpcX0h/PQ+KEQiwGwXQNkfp8xwrRunZRXaWQ8aIOdWn?=
 =?us-ascii?Q?p+mMz6h5GFGUL7hJ7eFc9doSxNkP+Enp2ivwfG+/ENj/+y4quPBt8YfEvNUP?=
 =?us-ascii?Q?bFM+Lf2VPj8PNIVVMATrZxXfvls3/Z4r3XjyPQmPcgrd1q3ievAZ4kA8PsnW?=
 =?us-ascii?Q?iUg7x2gpnR/likr4+WtrVdbpqggHppLJ0sAqEdiPOt5izbyn5OkPGAwpVzGn?=
 =?us-ascii?Q?5IAZEOCrJyjuPNHT72H45HgJaf8yt+vCcqz+Alh9XKMgKP1IVZKPXJuRvXkh?=
 =?us-ascii?Q?8TCnji1R+DSpYMi5FrD5GrHeGtJnfeRmeGnjTbhfklZaclCQM0Vmrbb4lNgB?=
 =?us-ascii?Q?6oa4nCzRgdR7KDV29AWsFx8VztZTGgQaRAJFfLKC5n/hS+K8pZDDc5QDjs4d?=
 =?us-ascii?Q?cpR6NjbiTTC+zum+/x+45RjEosZxy3vz/oB3kWtnz0WrZSZCDFFUURJFzwdl?=
 =?us-ascii?Q?u3NiddMKt6i/rBn3fud4+toCGhNSqeDozC5MhyNtrstlPgm6GLuXrFa0VbgG?=
 =?us-ascii?Q?LMkxmw4j0syk3KWPaDPo2NMl9yKEtMmLA7qxQjJ8TVEjv+I49tK+2Cpx1TRC?=
 =?us-ascii?Q?wUWtiOze3qAzHYvBnHi+4ICD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c01a8d9-eaa0-49df-3538-08d96d5dc095
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 15:32:48.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RU8MqWsHIuGqTQIK67LmGcxqyweyN1N6hDJ8GlEsXPI1Vy9f1gDWmt3bBkc/UEcM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 03:57:09PM +0200, David Hildenbrand wrote:
> On 01.09.21 15:53, Jason Gunthorpe wrote:
> > On Thu, Aug 19, 2021 at 11:18:55AM +0800, Qi Zheng wrote:
> > 
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index 2630ed1bb4f4..30757f3b176c 100644
> > > +++ b/mm/gup.c
> > > @@ -500,6 +500,9 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
> > >   	if (unlikely(pmd_bad(*pmd)))
> > >   		return no_page_table(vma, flags);
> > > +	if (!pte_try_get(mm, pmd))
> > > +		return no_page_table(vma, flags);
> > > +
> > >   	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
> > 
> > This is not good on a performance path, the pte_try_get() is
> > locking/locking the same lock that pte_offset_map_lock() is getting.
> 
> Yes, and we really need patch #8, anything else is just confusing reviewers.

It is a bit better with patch 8, but it is still not optimal, we don't
need to do the atomic work at all if the entire ptep is accessed while
locked. So the above is stil not what I would expect here, even with
RCU.

eg I would expect that this kind of change would work first with the
existing paired acessors, ie

	pte = pte_offset_map(pmd, address);
	pte_unmap(pte);

Should handle the refcount under the covers, and same kind of idea for
the _locked/_unlocked varient.

Only places that don't already use that pairing should get modified.

To do this we have to extend the API so that pte_offset_map() can
fail, or very cleverly return some kind of global non-present pte page
(I wonder if the zero page would work?)

> > Also, I don't really understand how this scheme works with
> > get_user_pages_fast.
> 
> With the RCU change it in #8 it should work just fine, because RCU
> synchronize has to wait either until all other CPUs have left the RCU read
> section, or re-enabled interrupts.

So at this point in the series fast gup is broken, that does mean the
series presentation really needs to be reworked. The better
presentation is to add the API changes, with a
no-functional-difference implementation, push the new API in well
split patches to all the consumption sites, then change the API to
have the new semantics.

RCU and refcount to free the page levels seems like a reasonable
approach, but I have to say I haven't thought it through fully - are
all the contexts that have the pte deref safe to do call_rcu?

Jason


