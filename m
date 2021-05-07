Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488EB37645E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhEGLPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 07:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhEGLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:15:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B1C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ucEoLpPTIeb0/RORnoVORFMYYdg8I3ltC+ygRFKdXyQ=; b=tlPFr5SISA4ftBpBbp1+b149IT
        TBRCgWW9CBZFMJRTwWxLjA6Q4gAd3q9VPsSb79ojiiCHKfB25kwzjl+NUQ+EYKZSS3SCbkyMaaiU0
        2DztknMYdA1mYNRRy7t80WMPFg/OhVPW2r17MT1tVSHjHE/t57GqQipCJRtzwVctAjjM3NSUdDGV6
        po/hvYlLfuu7JDS0y/2aSPHt+HES91tLPafBFdD+yfIjldPafhh2GJuTky9NBcffHivT6j8ZPibsu
        RiQuZ1EOMWkw/Cb+sM5tFEmVP44Ob3Q1+2p39beXYtTeB0vHCubG1QkKTo2TI6Gp6AqO42NX2hu7k
        NYMJyKkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leyQi-0037HK-4E; Fri, 07 May 2021 11:14:07 +0000
Date:   Fri, 7 May 2021 12:14:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 3/3] mm: gup: pack has_pinned in MMF_HAS_PINNED
Message-ID: <YJUg+I1P+umwsE8b@casper.infradead.org>
References: <20210506232537.165788-1-peterx@redhat.com>
 <20210506232537.165788-4-peterx@redhat.com>
 <69055843-185d-20ea-213b-10494a2f7246@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69055843-185d-20ea-213b-10494a2f7246@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 11:42:59PM -0700, John Hubbard wrote:
> +static void set_mm_has_pinned_flag(unsigned long *mm_flags)

mm_set_has_pinned_flag(struct mm_struct *mm), please.

