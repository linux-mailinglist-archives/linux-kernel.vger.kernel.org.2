Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20032A081
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381176AbhCBEWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:22:08 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2477 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348007AbhCBAW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:22:29 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d85150000>; Mon, 01 Mar 2021 16:21:41 -0800
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 00:21:37 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <bskeggs@redhat.com>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <jglisse@redhat.com>, <hch@infradead.org>,
        <daniel@ffwll.ch>
Subject: Re: [PATCH v3 1/8] mm: Remove special swap entry functions
Date:   Tue, 2 Mar 2021 11:21:35 +1100
Message-ID: <3156280.dJpzq75PnV@nvdebian>
In-Reply-To: <20210301174642.GP4247@nvidia.com>
References: <20210226071832.31547-1-apopple@nvidia.com> <20210226071832.31547-2-apopple@nvidia.com> <20210301174642.GP4247@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614644501; bh=azDUrxm78xZYK+HMnHGyx9Cls7mv6No8+tEzyjhqkY4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:Content-Type:
         X-Originating-IP:X-ClientProxiedBy;
        b=OWpxffKeP4tRIYOnIzWmKU2ko4OneFNOwVj+FyTqa4wUuAyUq/G035xSN96rL3s4U
         CA2Le5hOQkxj09JDqjwtL+dcVozOjVJOqsAP/77YPxoAGDgKoCS+uC44nuPIHShHJu
         AQcoFQv2I5HrVxcpLUdaEYX96qs+Fbn+H4WH6IiNhxMuJse6m0q6LImPEePfGXcqS3
         y8rWRlSZ6kxZv7XVJ05BMWPXBFERIbAwCPh/cbO3qmpQiPSlkeCWEOdT2cGGNX3CKM
         xj85TG9o7jkYYmeYx1sJ/KOkEFDUPRj2HB/Euue8YPgbHDP8xnwpiiRC88gPjPdE07
         Dv/DTQIp44Jsg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2 March 2021 4:46:42 AM AEDT Jason Gunthorpe wrote:
> 
> I wish you could come up with a more descriptive word that special
> here
> 
> What I understand is this is true when the swap_offset is a pfn?

Correct, and that points to a better name. Maybe is_pfn_swap_entry()? In which 
case adding a helper as Christoph suggested makes some more sense. Eg: 
pfn_swap_entry_to_page()

> > -static inline struct page *migration_entry_to_page(swp_entry_t entry)
> > -{
> > -	struct page *p = pfn_to_page(swp_offset(entry));
> > -	/*
> > -	 * Any use of migration entries may only occur while the
> > -	 * corresponding page is locked
> > -	 */
> > -	BUG_ON(!PageLocked(compound_head(p)));
> > -	return p;
> 
> And this constraint has been completely lost?

Yes, sorry I should have called that out. I didn't think loosing the check was 
a big deal, but I can add some checks to some of the call sites which would 
catch a page being incorrectly unlocked.

> A comment in front of the is_special_entry explaining all the rule
> would help alot

Will add one.

> Transformation looks fine otherwise

Thanks.

 - Alistair
 
> Jason
> 




