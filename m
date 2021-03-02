Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965F832A55B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383766AbhCBM1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:27:05 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19345 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350233AbhCBMDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:03:41 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603e293f0000>; Tue, 02 Mar 2021 04:02:07 -0800
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 12:02:03 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <bskeggs@redhat.com>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <jglisse@redhat.com>, <jgg@nvidia.com>,
        <daniel@ffwll.ch>
Subject: Re: [PATCH v3 1/8] mm: Remove special swap entry functions
Date:   Tue, 2 Mar 2021 23:02:01 +1100
Message-ID: <3345714.hC2lq6CL0I@nvdebian>
In-Reply-To: <2110609.1zlQqR5hOE@nvdebian>
References: <20210226071832.31547-1-apopple@nvidia.com> <20210226155909.GA2907711@infradead.org> <2110609.1zlQqR5hOE@nvdebian>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614686527; bh=b4u8wlHSQs9FvZtrdld+N7bU6bKVR4VIsqvExBaD4Rs=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:Content-Type:
         X-Originating-IP:X-ClientProxiedBy;
        b=dCvuFv2nHakCS7lmDYO2pxF6pGlzQ4j5wasHy/HwPnpQbwFTJ4SkzTAsw+V480/yo
         GU6GDIY5sCyead7VMxIwQxY9J+SH+Dd1Yc+whx/HTBCLcXBAYtUmQ7vRQ1ZLts7uGI
         ORtUa8tOqSxCxJfrpOM1lbvVDuEBaKlc5aeB+qOT8QzxQA7XZwcVrgkSOQ5J55/qsT
         5omouGzUjYOojRdozUTNKFqLaHURFqh5FOyeJSzvikrM97UDKkytICAKlRXXTB3Jg7
         AnhYQA/D2u2YQeGtcqeGkNKxCsDG7H/6I77qB8qOrbv0JzI4ERftAYolHKQ9e2ejGX
         zGJjSgT2MgSyg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2 March 2021 7:52:53 PM AEDT Alistair Popple wrote:
> On Saturday, 27 February 2021 2:59:09 AM AEDT Christoph Hellwig wrote:
> > > -		struct page *page = migration_entry_to_page(entry);
> > > +		struct page *page = pfn_to_page(swp_offset(entry));
> > 
> > I wonder if keeping a single special_entry_to_page() helper would still
> > me a useful.  But I'm not entirely sure.  There are also two more open
> > coded copies of this in the THP migration code.
> 
> I think it might be if only to clearly document where these entries are 
used. 
> Will add it for the next version to see what it looks like.

Actually the main advantage ends up being that it becomes easy to retain the 
page locked check for migration entries.

 - Alistair 



