Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83953FF8B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 03:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbhICBvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 21:51:36 -0400
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com ([40.107.92.63]:24345
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229562AbhICBvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 21:51:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSqkAAO91MAYo6+wRWjcgUijAjTkgq1x566gNwhaqRHIFZX+TR4Gg4IzgTQQ98Y9o4QEN0npfZVNynGBgcqjZzRUAHay2gpzUZwRth7xDJTy1Rt00+DQ0zqdCSgGiuVocIg3O5hi8wSMxLTI439h9xqtV+fP9aYbPQSwez0zsse08YrZWBQIx7rNbowsUqWWJtxESKlQWlT0UCO22h/McKLZuaVaQl1BV5gzcxfs76xfRLiOHggF07W36ixaT1k7lRg8wQKrgLLZASKn9wScZKyyrH3ON/bLQA4vUHKmnOZDXvVYlzgyPp8Kor0yYfc8eBTl1crKlJ0Gbt5XjWuKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=huVVZ4datGA9S6fBqToI1Mh93Fv/twY/6rvzxXTMQg4=;
 b=XsU8YmiLrxPYw/QSP5hZYwSazI6TaYyidZFLWCsB0LNDF1MMx+Fjb8yXOz8UZS7di5lUHQz7VwoCT/ShRaJSBdT/Vacunrf4YCWHQw5wlKLdil30oh93zVbwo/sjmSKafAEQhkjJuC7V8Lib8iuXBcRBgZnRlIfG+yqk65qOpurcYSX5z8ommgirxVRrXYARu73Pe6PSwmNtopmm2P3vQd/mVHOGicleFeUeKYFheBL7lecp64LVGLCQ19h5Ww7USoIgsqYkdxWepQwPe3ILpHOsh/V5VDEW8k4Cvq38QuGPJqPiYyl3VtuHOuq/68wgW/6BGrTJzBd9UBkD4jRgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huVVZ4datGA9S6fBqToI1Mh93Fv/twY/6rvzxXTMQg4=;
 b=NndGrVTRUGb/JXXCNXmhCOINkSkWNbHuZKcpFMApiM0JOSTstYR8ky+rbdfmmFqIVpFBqyQzDJzQZm6qoUr4TVqHxA5EH5iGgMAzFoyBo+1yvAV193NliqbmmFTmnSJT2v0k6qpzoAO9TFfyimju13bYWcRaTxTI39SN5/tBN03z21hZoetUtwfbaME+bqnVXBNkG2rIwXGOuCW/wHdhZphb8Hms94XdOikRirtTsnJizfZJjFYKstjCPzxVyPICOwhbf8zw9sR60KO0RksiZpHW/4Wa+EbjBs+P3BTT3X+Dlvfc4U8NkZA15btbsutFiaEsIMuxWinJ5u/SGBqD9g==
Received: from DM6PR04CA0020.namprd04.prod.outlook.com (2603:10b6:5:334::25)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Fri, 3 Sep
 2021 01:50:34 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::f5) by DM6PR04CA0020.outlook.office365.com
 (2603:10b6:5:334::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Fri, 3 Sep 2021 01:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 01:50:34 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 3 Sep
 2021 01:50:33 +0000
Received: from nvdebian.localnet (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 3 Sep 2021
 01:50:31 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Jerome Glisse" <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Miaohe Lin" <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "David Hildenbrand" <david@redhat.com>
Subject: Re: [PATCH v2 4/5] mm: Add zap_skip_check_mapping() helper
Date:   Fri, 3 Sep 2021 11:50:28 +1000
Message-ID: <2306207.EELmk4mpEQ@nvdebian>
In-Reply-To: <YTF81ItjDYpHUe1J@t490s>
References: <20210902201721.52796-1-peterx@redhat.com> <1771631.QAr93JHi05@nvdebian> <YTF81ItjDYpHUe1J@t490s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f78313a5-3ead-44d3-3e02-08d96e7d3866
X-MS-TrafficTypeDiagnostic: BY5PR12MB4888:
X-Microsoft-Antispam-PRVS: <BY5PR12MB48885A6E7495C70DDE682AE8DFCF9@BY5PR12MB4888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8z/DAKkRgE1fIb0ubzXv9DhgvesX063dpmvA84FxcPh1eM2t0R3jTs3SPp8L/sNatdOcNjgpVzxiXvG9vaPywKD2L4AS/kBjWDm7GDuZDX/kpE3Zb/8HwsxATTuMQnlRc/J6mPJU5QdjtCvuSwPqt6G8+J2HiaYmrrTo4x0wsyjjaf5793OK2VWG/9pTbSAgSr3WnZ6OBKF6hRDOw1wpcYSSaMGqtFeCLgnbHDqPczq6DwIo92fFqp0HrQL8Pn0wbJhYaiV28EUdBLnhhoZ9/RAbQQnrWBIVOjqH9LH+vUm92fW+eYNMz9T7J5XGNU+tfwGyov4GBSqF/JsVVkgCjNbbzBfuojHnC9gNAMJGNoHiDD2htpzKv1zzHpCqrO6vWwM4W945Es91x2Z2r4J8JWmE4t+UdgfTR6IKE70O5BcVi8nw3RZzNik+4K3dYFvATcrOWezdWBH/dpCcNAElT3OmxqZK2DFujbPBeqJKjewB9KXs9u/RRocdQ8JpCNIh1BpBbwOhkorckD5VMAXuBMoYTWbCQAQDr1iiL4d3EuAvlNGQ1RakjdXheNChz9liNRfzU9N9yU5u2n60gK9Ks4pTs7ZA+fgHFWU8z5pH3Nq0I897AukmR+5t8ttRl/WEGuduIR64kJghLs61Qe28xtVTxmNmoGsPZAxH3U7XGv0ULcaGIE9EhAcxkdZfz6M+2LU4op/NgzU3QWsKd6CVNfRWDzeFxNlML9SJ73mDWQ=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(82310400003)(4326008)(9686003)(6666004)(47076005)(33716001)(7416002)(5660300002)(508600001)(8936002)(426003)(2906002)(7636003)(70206006)(186003)(26005)(6916009)(70586007)(83380400001)(356005)(16526019)(8676002)(336012)(36906005)(54906003)(9576002)(316002)(86362001)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 01:50:34.4658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78313a5-3ead-44d3-3e02-08d96e7d3866
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 3 September 2021 11:39:32 AM AEST Peter Xu wrote:
> On Fri, Sep 03, 2021 at 10:58:53AM +1000, Alistair Popple wrote:
> > On Friday, 3 September 2021 6:18:19 AM AEST Peter Xu wrote:
> > > Use the helper for the checks.  Rename "check_mapping" into "zap_mapping"
> > > because "check_mapping" looks like a bool but in fact it stores the mapping
> > > itself.  When it's set, we check the mapping (it must be non-NULL).  When it's
> > > cleared we skip the check, which works like the old way.
> > >
> > > Move the duplicated comments to the helper too.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  include/linux/mm.h | 15 ++++++++++++++-
> > >  mm/memory.c        | 29 ++++++-----------------------
> > >  2 files changed, 20 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 69259229f090..81e402a5fbc9 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -1720,10 +1720,23 @@ extern void user_shm_unlock(size_t, struct ucounts *);
> > >   * Parameter block passed down to zap_pte_range in exceptional cases.
> > >   */
> > >  struct zap_details {
> > > -	struct address_space *check_mapping;	/* Check page->mapping if set */
> > > +	struct address_space *zap_mapping;	/* Check page->mapping if set */
> > >  	struct page *single_page;		/* Locked page to be unmapped */
> > >  };
> > >  
> > > +/*
> > > + * We set details->zap_mappings when we want to unmap shared but keep private
> > > + * pages. Return true if skip zapping this page, false otherwise.
> > > + */
> > > +static inline bool
> > > +zap_skip_check_mapping(struct zap_details *details, struct page *page)
> > > +{
> > > +	if (!details || !page)
> > > +		return false;
> > > +
> > > +	return details->zap_mapping != page_rmapping(page);
> > 
> > Shouldn't this check still be
> > details->zap_mapping && details->zap_mapping != page_rmapping(page)?
> > 
> > Previously we wouldn't skip zapping pages if even_cows == true (ie.
> > details->check_mapping == NULL). With this change the check when
> > even_cows == true becomes NULL != page_rmapping(page). Doesn't this mean we
> > will now skip zapping any pages with a mapping when even_cows == true?
> 
> Yes I think so.  Thanks for pointing that out, Alistair, I'll fix in v3.
> 
> But frankly I really think we should simply have that flag I used to introduce.
> It'll make everything much clearer.

Yeah, I think a flag would also be fine.

 - Alistair



