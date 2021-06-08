Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCCF39FE29
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhFHRvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:51:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39420 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhFHRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:51:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EAEE6219BB;
        Tue,  8 Jun 2021 17:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623174582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQ0exyzvqmDVh1jljb/vutVtcq9WcTozqWGSBLWacEI=;
        b=kFFb+FbwC60F6qZnPlFdh9NRZGvnBm8ACc2LvCxznN4VzDquiF6R4x/WGbnBSxRMEY/xBB
        mWiw3Uh0daGhTdenBStjZlVLkxh7SeOWXq96qJstjjNDfPGNaJl98fePGbDuIJYU+SBy5Z
        EASgZMnknC0g6TiyOXLa3M0e4OONWto=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 94C83A3B97;
        Tue,  8 Jun 2021 17:49:42 +0000 (UTC)
Date:   Tue, 8 Jun 2021 19:49:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Zi Yan <ziy@nvidia.com>, nao.horiguchi@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mempolicy: don't have to split pmd for huge zero page
Message-ID: <YL+ttjqJ9lEMndiA@dhcp22.suse.cz>
References: <20210604203513.240709-1-shy828301@gmail.com>
 <YL265A86DQe5Rgon@dhcp22.suse.cz>
 <CAHbLzkowcskM=p==-q48Ca12D=h9SgqUuUB4NknRNR=64TyXCw@mail.gmail.com>
 <YL5rvdzh9dou+uAz@dhcp22.suse.cz>
 <CAHbLzkooYAi=Hb0=oJ+2b6G=h5Sx4jnyo5L0nPYjDcBqBHnfug@mail.gmail.com>
 <YL8RFneAmSSi2Z0I@dhcp22.suse.cz>
 <CAHbLzkquqKOL7pH8yBdfpafeHJCUZvccNKjQBucsP7C4k83f7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkquqKOL7pH8yBdfpafeHJCUZvccNKjQBucsP7C4k83f7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-06-21 10:15:36, Yang Shi wrote:
[...]
> I did some archeology, the findings are:
> 
> The zero page has PageReserved flag set, it was skipped by the
> explicit PageReserved check in mempolicy.c since commit f4598c8b3678
> ("[PATCH] migration: make sure there is no attempt to migrate reserved
> pages."). The zero page was not used anymore by do_anonymous_page()
> since 2.6.24 by commit 557ed1fa2620 ("remove ZERO_PAGE"), then
> reinstated by commit a13ea5b759645 ("mm: reinstate ZERO_PAGE") and
> this commit added zero page check in vm_normal_page(), so mempolicy
> doesn't depend on PageReserved check to skip zero page anymore since
> then.
> 
> So the zero page is skipped by mempolicy.c since 2.6.16.

Thanks a lot! This is really useful. Can you just add it to the
changelog so others do not have to go through the painful archeology.

With that, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Thanls!
-- 
Michal Hocko
SUSE Labs
