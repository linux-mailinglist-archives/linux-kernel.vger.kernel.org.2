Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDB6445FF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhKEHFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:05:11 -0400
Received: from mail-dm6nam11on2043.outbound.protection.outlook.com ([40.107.223.43]:33121
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229494AbhKEHFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:05:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7iN2EwcklXGEReJgryw565l2ii+c5Oc8dGMkgipBOmRGrztMmUUH+hKDs/4Li2JY+j/3BMUAxLhQkdRbyoVP0ZbaYF817A/gWAO4WGZHNlDypumc46BOourEvRgiNCzjf9YijFaWpczEt7G6OWvEuQdkNmjFim9ZfO0QKCZGXOMogCfukVmvc0YpyGejIICfq7Mg8aPjKEent9U1g2xZaV6I98yzVQVk13Ok931jgO8J+zVlX9AzcUoawyTNy611F5cLUNsstUmvc6hQdl6vHloKRWE4+vM7/s1B/Tk8q5xaJ9qjGbrz6IX/t7dxOXq1IECh33GmdmQkhDcPC3b/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+uW9umJHY7HSDEGoDh1c+SQgO88EtReH8vBfvMuwek=;
 b=GiMt4Ou4YOSYktk/xUHLlnOvs47+C4CrbyLkTPbs0GtioOpCpTXiogTAxA36hTFjikrM/d+V0z5F2uh6hTzWGqnjsqOKUSUeh2obCiuG8JPu1uucsNe6dkNsx8TytjabpC9cfjvS11IQpkraKJEzMhWXGkuUEtQgvYEj0X3QXhpd+xuRM0AJnZRNpJ05MrBxkBw4miHPU/h89pRJeBafj5sJKUrdaz0HAUU6YYG5dH2rJ8/xSGAfpKW2fOcm6CedcAUqOwnMrmcsurMnmAYzC0ph9QNQYU0YVdhNa2FNUF4pCV7riGenrQLuyvRNfamcS0SGZctt0Bcai8mvPVqqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+uW9umJHY7HSDEGoDh1c+SQgO88EtReH8vBfvMuwek=;
 b=t9vn68LIG5YxOH6cqjSKpRpIoN9XrFGXHtvQOnJ7SIFzv1L4fxmlW1OsH6jDs3YnFieBJ9DZRRTJkmWzGCoSwU+hlEsYtOLyySx8QVNnlNZ+3gaZYpAPsVa1+dGuq71tRz0tDpaz2zIxjoE4zxKEd/qQXHE6jGrbD04ZvG/pJ+jCu7bB3nIzSn/LqTt2Wm+TXjmKtwOGbuH4pfadIKcl+kwLe/ug6iuQQjaB1jAjqmf8CSGbS//egP5KDfE4NiVoxYqBEpPOqBRVvbn1QCpqz2moWIZ4DUpCHQlJVKl3O1EIbLDEksi9kNdMGQVyLZHSHEr1EjOZXy4bWyMEFoODFA==
Received: from MWHPR15CA0066.namprd15.prod.outlook.com (2603:10b6:301:4c::28)
 by BL0PR12MB4851.namprd12.prod.outlook.com (2603:10b6:208:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 5 Nov
 2021 07:02:21 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::56) by MWHPR15CA0066.outlook.office365.com
 (2603:10b6:301:4c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 5 Nov 2021 07:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 07:02:21 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 5 Nov
 2021 07:02:18 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <dhowells@redhat.com>,
        <hughd@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <jglisse@redhat.com>, <jgg@nvidia.com>,
        <rcampbell@nvidia.com>, <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/migrate.c: Rework migration_entry_wait() to not take a pageref
Date:   Fri, 5 Nov 2021 18:02:14 +1100
Message-ID: <7899398.tcx7jHFkIm@nvdebian>
In-Reply-To: <YYPQX2Y5u+ujrAOv@casper.infradead.org>
References: <20211104103338.891258-1-apopple@nvidia.com> <YYPQX2Y5u+ujrAOv@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2468f104-8729-49ad-041c-08d9a02a3692
X-MS-TrafficTypeDiagnostic: BL0PR12MB4851:
X-Microsoft-Antispam-PRVS: <BL0PR12MB485197DAD68E17CAAF8EE379DF8E9@BL0PR12MB4851.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3d9SRHWJWPuK3yNfbzO9ZAd8QFMJA9WyPq8blAeQE7nzKzf1zX8PdRBIAwRp6QqN6z8OxQKtG0DSPEtAQSIl9kCqbInIQknPxJRp/zYpjUoQMUVLTsM756aBCp8E8jx5Dzh6t23pmVMeI07cvyBx0hoUtfU3CF+ImoGsFp0lfqsSSpZSI5KVVS96u1TlY+OkuJLu2TRAdHIoxHmPXIeKqfjOhIVK54cSiyVJlh8pmgcqyhd06WUeC5qJ4DZWKnegHM2D3aGPf3R0WQthOIxWLNtKg3caUGInv+Arg+8KKPsSBlhmc6f9jqM3sbnVUANmQeD0zuNgOItEWGcLle7i7AJTEVMw/LJL0Q1TclYKnDFOZfaKJ1sPHIb08VcCelYdVksH1267oM38DG14NZ14/Dz1oB4NU0MpXlmtrl+4E5JvArAuV57i0tfQGM+dAhb7m1o8w+RdgYmMisvaFI4PjgCr0sn4JfSq8ZcOQLD9g1Vo8noyPqaFVIrmZHBffOrilv4ZVWxtzcCVVK2Ct2G+v4J2oNUDhEbOFpKyvl9C1aSBYUmB5WvVqifWShdrnQdk+fhtfDP2vH85JD2QQ4zgaNkq1AENMrxBS652G5Orddr4JhFcY27/oSE8balE3uhvBIG+1QhNFbsct6A5JAbRVGqoWZo7giuy063wiMics56WV3yT59kuMkNbzm4BJzJ4SwWFUwp/4W8YF8P8dxOCiqmQqPY9KSKRzb+ef6nWzcw=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(426003)(316002)(70586007)(186003)(6666004)(36906005)(2906002)(9686003)(6916009)(70206006)(8676002)(82310400003)(336012)(8936002)(26005)(83380400001)(356005)(33716001)(54906003)(86362001)(5660300002)(36860700001)(107886003)(47076005)(508600001)(4326008)(7636003)(16526019)(9576002)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 07:02:21.2686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2468f104-8729-49ad-041c-08d9a02a3692
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4851
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 4 November 2021 11:21:51 PM AEDT Matthew Wilcox wrote:
> On Thu, Nov 04, 2021 at 09:33:38PM +1100, Alistair Popple wrote:
> > +++ b/mm/filemap.c
> > @@ -1356,6 +1356,88 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
> >  	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
> >  }
> >  
> > +/**
> > + * migration_entry_wait_on_locked - Wait for a migration entry to be removed
> > + * @page: page referenced by the migration entry.
> > + * @ptep: mapped pte pointer. This function will return with the ptep unmapped.
> > + * @ptl: already locked ptl. This function will drop the lock.
> > + *
> > + * Wait for a migration entry referencing the given page to be removed. This is
> > + * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
> > + * this can be called without taking a reference on the page. Instead this
> > + * should be called while holding the ptl for the migration entry referencing
> > + * the page.
> > + *
> > + * Returns after unmapping and unlocking the pte/ptl with pte_unmap_unlock().
> > + *
> > + * This follows the same logic as wait_on_page_bit_common() so see the comments
> > + * there.
> > + */
> > +void migration_entry_wait_on_locked(struct page *page, pte_t *ptep,
> > +				spinlock_t *ptl)
> > +{
> > +	struct wait_page_queue wait_page;
> > +	wait_queue_entry_t *wait = &wait_page.wait;
> > +	bool thrashing = false;
> > +	bool delayacct = false;
> > +	unsigned long pflags;
> > +	wait_queue_head_t *q;
> > +
> > +	q = page_waitqueue(page);
> 
> You're going to need to update this patch to apply to Linus' current
> tree; page_waitqueue() went away in favour of folio_waitqueue().

Argh, thanks I had meant to rebase before sending.

> It seems like it would look simpler if this were a patch which modified
> folio_wait_bit_common() instead of doing a manual inline of it into
> this function.

Yes, happy for some opinions here. I was debating a manual inline vs. modifying
folio_wait_bit_common() but felt an additional two special case arguments would
make things a bit messy and there was no obvious way to refactor or split up
folio_wait_bit_common().

However I just noticed wait and wait_page are related so I might be able to
refactor some of the initialisation to reduce code duplication. Will resend a
rebased version doing that.



