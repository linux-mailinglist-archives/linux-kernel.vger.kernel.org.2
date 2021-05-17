Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA1E382B21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhEQLf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbhEQLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:35:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51143C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:34:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k15so4423526pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SemXkCbow4yBXflzyDjNxahJ+Elgl4A0uyCJv5Cq9YU=;
        b=DGAyxqLgz3OO1MWLx8qiw1QtWW+DLDx7vUUkjOIhutGsiOt+YlE5BHfM5e21woX6cG
         h4BaS5ayqZ7xjC7FGxpccTNVf2+Gplw1SUXZGd1h3g+E5zezVy68TW05Hf44BDzfoYFv
         3jKBAGy69n78QmAxPzyHMt027++pHWHbuoIxhwI7IFSfMRoBUx7whlOpMb63xsq+bqDV
         HkpE2lrrYiwnXeAqmNnQtSqaOa3XJLFcraZ6lJ8/p+zZ8bOsHPNEY8/ZTkjh4s1Wg75K
         gEVP49iODFG12j5B5KoBARKByHZLg5mwxrTci1dS1Ppq4AhZ2RgAl+i8eehY/OAHLO98
         liHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SemXkCbow4yBXflzyDjNxahJ+Elgl4A0uyCJv5Cq9YU=;
        b=BUfMLJtt7YiVaYlK4/i6fKvU7k+YfIEjl41TOmxLADhPz6vlVtSghCUCJo9d7Mz9V5
         4Mi5gvu24JDtmtcqbuv62XSZfKomF6+Ns3aRyIL1y4yCzQUo6MfQxrE8d4bTeKnW9tsD
         nmrihyw7vHYt4ih2MXrw46vetIJ4hIOFaFuRmV1NDMqLCYj1aBqZFt6smrXr13B0UGo2
         d0o0I7zN/Hsi4KQOo4gBZO50rGHWCdbq1mPjqDmpuksEcR4I6qLfFy3nVYvhCzX2hmsa
         Fqqa97JgP/JKjzN7UZBm1xozbh2KqNjBZiqWERW4bMFsOMEthAlL6PoowWGLeFFgwErN
         8HNg==
X-Gm-Message-State: AOAM533YUtT5vuBALdt0ZwqIvNrgDUYIFCXUZvyDPyjWRGLXEGGjD7UC
        L+jY+j0tBA1E4Y6ctuKTUw==
X-Google-Smtp-Source: ABdhPJxGpZMBXtHpJPSmLqncN7Qur27kVlCHiJBfWTl77Rr67A+c0ruFAftsy1htis9tdyGwjvM9JA==
X-Received: by 2002:a63:6c9:: with SMTP id 192mr4922117pgg.39.1621251248820;
        Mon, 17 May 2021 04:34:08 -0700 (PDT)
Received: from u2004 (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id i7sm1351944pgv.93.2021.05.17.04.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 04:34:08 -0700 (PDT)
Date:   Mon, 17 May 2021 20:34:05 +0900
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm,hwpoison: fix race with compound page
 allocation
Message-ID: <20210517113405.GA2512538@u2004>
References: <20210517045401.2506032-1-nao.horiguchi@gmail.com>
 <20210517045401.2506032-2-nao.horiguchi@gmail.com>
 <20210517101239.GA21612@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210517101239.GA21612@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 12:12:50PM +0200, Oscar Salvador wrote:
> On Mon, May 17, 2021 at 01:54:00PM +0900, Naoya Horiguchi wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > When hugetlb page fault (under overcommitting situation) and
> > memory_failure() race, VM_BUG_ON_PAGE() is triggered by the following race:
> > 
> >     CPU0:                           CPU1:
> > 
> >                                     gather_surplus_pages()
> >                                       page = alloc_surplus_huge_page()
> >     memory_failure_hugetlb()
> >       get_hwpoison_page(page)
> >         __get_hwpoison_page(page)
> >           get_page_unless_zero(page)
> >                                       zero = put_page_testzero(page)
> >                                       VM_BUG_ON_PAGE(!zero, page)
> >                                       enqueue_huge_page(h, page)
> >       put_page(page)
> > 
> > __get_hwpoison_page() only checks page refcount before taking additional
>                                   ^^ the?                      ^^ an
> > one for memory error handling, which is wrong because there's a time
> > window where compound pages have non-zero refcount during initialization.
> > 
> > So makes __get_hwpoison_page() check page status a bit more for a few
>      ^^ make
> > types of compound pages. PageSlab() check is added because otherwise
> > "non anonymous thp" path is wrongly chosen.
> 
> This is no longer true with this patch, is it? What happened here?

Sorry, we need remove this. I dropped the changes for PageSlab
because I'm still not sure about what to do (I'd like to do it
in a separate work).

> 
> >  static int __get_hwpoison_page(struct page *page)
> >  {
> >  	struct page *head = compound_head(page);
> > +	int ret = 0;
> > +
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +	spin_lock(&hugetlb_lock);
> > +	if (PageHuge(head) && (HPageFreed(head) || HPageMigratable(head)))
> > +		ret = get_page_unless_zero(head);
> > +	spin_unlock(&hugetlb_lock);
> > +	if (ret > 0)
> > +		return ret;
> > +#endif
> 
> I am kind of fine with this, but I wonder whether it makes sense to hide this
> details into helper (with an empty stub for non-hugetlb pages)?

OK, I will do this.

> 
> >  	if (!PageHuge(head) && PageTransHuge(head)) {
> This !PageHuge could go?

I'll update this, too.

Thanks,
Naoya Horiguchi
