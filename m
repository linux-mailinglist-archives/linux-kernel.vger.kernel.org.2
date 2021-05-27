Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C19392970
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhE0IYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:24:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235400AbhE0IX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:23:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622103744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+EfkVrIQZXBeZTPSxjNuEm8wUQKfD3cTZZ/zTTMSBzw=;
        b=iIdOJB9ZclOzK1R83f55YqiC+wO2fih/GoA1P6TTFS7h/zJZv+/vjHUezFzt6uULVaRUNQ
        eLiBhU2Vt0rRbhtKjqCzvjWLKXmuXfKoUvniad9b6jcJksXd04jGHck9f8MPt9I054mw0y
        VQ+IuJWWlJzLeN4HCvmS7MSB1NRuQbw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F646AB71;
        Thu, 27 May 2021 08:22:24 +0000 (UTC)
Date:   Thu, 27 May 2021 10:22:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hugetlb: pass head page to remove_hugetlb_page()
Message-ID: <YK9Wv+EexkCi2+U5@dhcp22.suse.cz>
References: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
 <YK9OoPzkBB1jTpC1@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK9OoPzkBB1jTpC1@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-05-21 09:47:44, Oscar Salvador wrote:
> On Thu, May 27, 2021 at 08:52:57AM +0900, Naoya Horiguchi wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > When memory_failure() or soft_offline_page() is called on a tail page of
> > some hugetlb page, "BUG: unable to handle page fault" error can be
> > triggered.
> > 
> > remove_hugetlb_page() dereferences page->lru, so it's assumed that the
> > page points to a head page, but one of the caller,
> > dissolve_free_huge_page(), provides remove_hugetlb_page() with 'page'
> > which could be a tail page.  So pass 'head' to it, instead.
> > 
> > Fixes: 6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
> > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> It is probably worth adding a comment in remove_hugetlb_page() noting
> that we need a head page, so future users do not repeat the same
> mistake.

Ideally this will turn into page folio concept and no comments are
really needed.
-- 
Michal Hocko
SUSE Labs
