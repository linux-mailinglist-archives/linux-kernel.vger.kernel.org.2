Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1F35E00A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbhDMN1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:27:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:41002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239438AbhDMN1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:27:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618320400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8lafVMVlqcvY7c180HwnbQQcnl+XANbCvOvXcaqEvjk=;
        b=N6gReKBQSdhU1VW+YK9rmRN4jLleRoXs4ljpABGoYdRcIM2f4OKid3cAr75hPq2sDgwTPu
        ejAEoVpn8ZjkdRhFJ3xlwbz9aTvCOGObVX1qXEWswIiyHl2WXeaFMXv0Ti3F/Vj83QrmAy
        YbNKHE08RV11LRp6wYTrfwd3+gevEaQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78EDFAE89;
        Tue, 13 Apr 2021 13:26:40 +0000 (UTC)
Date:   Tue, 13 Apr 2021 15:26:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] mm,hugetlb: Split prep_new_huge_page functionality
Message-ID: <YHWcD7AgspDma+kq@dhcp22.suse.cz>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-5-osalvador@suse.de>
 <YHWbkNqLsNht6who@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHWbkNqLsNht6who@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-04-21 15:24:32, Michal Hocko wrote:
> On Tue 13-04-21 12:47:44, Oscar Salvador wrote:
> [...]
> > +static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> > +{
> > +	__prep_new_huge_page(page);
> >  	spin_lock_irq(&hugetlb_lock);
> > -	h->nr_huge_pages++;
> > -	h->nr_huge_pages_node[nid]++;
> > +	__prep_account_new_huge_page(h, nid);
> >  	spin_unlock_irq(&hugetlb_lock);
> >  }
> 
> Any reason to decouple the locking from the accounting?

OK, I spoke too soon. The next patch already has the locking around when
calling this. Please add a lockdep assert into the helper to make the
locking expectations more obvious.

With that
Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
