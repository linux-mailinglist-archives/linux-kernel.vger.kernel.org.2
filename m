Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D0039BC36
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhFDPuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:50:18 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:46971 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:50:17 -0400
Received: by mail-lj1-f179.google.com with SMTP id e11so12115532ljn.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=csBRe6GCVEfaRNmTYDJTX2l/VpfE7TNuHayFgxQM24o=;
        b=QZRcmT5KadNWFjVQjJiemyr5SdfPveEFwW6PgIgkrNW0XBjGd9OvK0iQOuLwr71XMR
         stL/FJX5RLtW812HBNpRSycdp4S9aNlAPcBTVKmcp5N629lqvEDLXHFvmSO9sqxv6bOD
         TtL4hE6CV4TAxs8+ZISrfDHKyGOTNR++1q2+1cmvfkOcY/UHCsxKDlDVJFh9v4eFxyMB
         S7hMnTxn/z9/P82qloYQz2JtX4zDwjRcLKRYUMh5V0uttf2BpkpfSPzaZYXMdeVqPewr
         UfGDLn/tlVWYm9fW2Jl1ggJKYNSJtIjysyLkX5HGv6xUVMVe7cVS/CNxw5FJkC7ou0Ch
         xV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=csBRe6GCVEfaRNmTYDJTX2l/VpfE7TNuHayFgxQM24o=;
        b=kSkspIy5Kzvg6RxOjxbDnUoki0j66Kf76kQwkL6QqnYwJg5NayKjyyjGoF5iNYFG78
         GalYKtIfR+qpBKxoncYCbCMowqQmCGxXFvWv2jZdUB6gLWo+5d2R1t8gn9gruriwZzjS
         tgx4myPLzZA7h35xBKnOBknUPLv/9zrdP6kO5aA2o7zrIoCzU9HdmYUL024Iy6brz3cg
         wWjSEakPdekEPqj5HZhejatLqm64H3qtdTPTdek5fKUFBBxYwZaIF01nh2JkFMPEGvqg
         NcrX5iRkiz087asMSti8r7MOEXjQFiomoDyXbC1HCUDGnoMr3Rt+/BlUIoymg3M73CT0
         WmAA==
X-Gm-Message-State: AOAM5327qX3KIBxTqAi4w6ojXe6U5lUpbmbi4jJepP4Y8dH+fXebx3EC
        qGZNpYk90rQ1Y5N3/3NnUQKk8Q==
X-Google-Smtp-Source: ABdhPJz5y8pTqpmmdrBUS4ezybF5vsGudceRYwvvOvGEcx55Qqdyvt+K7SqvaM6smIu8T2YaTnvFpw==
X-Received: by 2002:a2e:2d11:: with SMTP id t17mr3902830ljt.56.1622821636863;
        Fri, 04 Jun 2021 08:47:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r27sm647044lfp.95.2021.06.04.08.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:47:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6ADE91027A9; Fri,  4 Jun 2021 18:47:28 +0300 (+03)
Date:   Fri, 4 Jun 2021 18:47:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/thp: try_to_unmap() use TTU_SYNC for safe
 DEBUG_VM splitting
Message-ID: <20210604154728.itpbqhwub5squt2u@box.shutemov.name>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011405510.2148@eggly.anvils>
 <YLlOPoP/rIRMm2U5@t490s>
 <alpine.LSU.2.11.2106031945280.12760@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106031945280.12760@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 07:54:11PM -0700, Hugh Dickins wrote:
> On Thu, 3 Jun 2021, Peter Xu wrote:
> > On Tue, Jun 01, 2021 at 02:07:53PM -0700, Hugh Dickins wrote:
> > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > index 2cf01d933f13..b45d22738b45 100644
> > > --- a/mm/page_vma_mapped.c
> > > +++ b/mm/page_vma_mapped.c
> > > @@ -212,6 +212,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > >  			pvmw->ptl = NULL;
> > >  		}
> > >  	} else if (!pmd_present(pmde)) {
> > > +		/*
> > > +		 * If PVMW_SYNC, take and drop THP pmd lock so that we
> > > +		 * cannot return prematurely, while zap_huge_pmd() has
> > > +		 * cleared *pmd but not decremented compound_mapcount().
> > > +		 */
> > > +		if ((pvmw->flags & PVMW_SYNC) &&
> > > +		    PageTransCompound(pvmw->page))
> > > +			spin_unlock(pmd_lock(mm, pvmw->pmd));
> > >  		return false;
> > >  	}
> > >  	if (!map_pte(pvmw))
> > 
> > Sorry if I missed something important, but I'm totally confused on how this
> > unlock is pairing with another lock()..
> 
> I imagine you're reading that as spin_unlock(pmd_lockptr(blah));
> no, the lock is right there, inside spin_unlock(pmd_lock(blah)).

Oh.. It made me scratch head too. Could you rewrite it in a more readable
way?

-- 
 Kirill A. Shutemov
