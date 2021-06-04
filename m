Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275F239B0A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 04:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhFDC5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 22:57:02 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]:37415 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDC47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:56:59 -0400
Received: by mail-qv1-f44.google.com with SMTP id z1so4293345qvo.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 19:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tzIVv+lKCCHH2FflktthX9wxyuJutky8QPa/YVxWuE8=;
        b=Ti9OjQCNoW3/TjQWP9o9zmOfFPCPJeIKzDZ0oWm4SfHRiekMW0qWopTYgy5cvt5CRb
         I2he0vPPCj/OssW9bMaLKi6txZuMaGO3JgH0unSpauH7iCNI62j+UsBAdWvxAnxcaA9Z
         mZycVBh110e+zgGQ8KbpoYpdp1/XUpLT7+mO6zc7F6Z0nIU30OlrdhzDEyI+WgejoOIM
         BO4DNd8qxMjBkU3x+tJfAir4gBxhvouo1BEmddnjzz5qW84fYypyRLhGQXdD7B4jXgL/
         VkWvTqxW2hlq1T9BH850dmsW7SRszqaOJLwnqZjb29oUxkSCNeHwaXH08HBxV4Xhvh19
         d9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tzIVv+lKCCHH2FflktthX9wxyuJutky8QPa/YVxWuE8=;
        b=sFB22//lENjdnq5dCC31IL5WbK8PXAllXmL8ix+UuHPMfl4EOMAGSrC95g5+ftYOdf
         7LN4sxBJgfK+C0/3FM2ejVoRYxdUfNdRDtphW9yikFtJNKFeUefaX/L+xsCKqsXcZOGT
         1O9Akw9pdxKnda1zH1KQ/0K9U4paTgXVRFwrYobwXxQACsYk8B/vJdgxJwnMlRiHSFAa
         fURL/z4K7Qpy2B4JFGHxFzx0dJvPX/Rfzi2eCoj9Ld5nBQyHY50cBNKOcPN4xC9eiTuB
         5gFjrQ4KOac3BHQjyEQ1fPO/K/c1rbYy7PM6uPfwfcE8Ta1iJs3Wxt62JnkaRlqFUU0m
         1q7A==
X-Gm-Message-State: AOAM53324GYYk9PoZJDCGUhqtiXcNCkn6tE+gMbjWMR+47QTf/EHX++6
        l0ieLZDZSJdxphOOaIR8CVWjRg==
X-Google-Smtp-Source: ABdhPJzF6d8NhQAvBLeQNS13us0aYVeeZuG4N5vWNDnNrhSxzZ+/vFl9aKx7az720abBxGTw484eUg==
X-Received: by 2002:a05:6214:485:: with SMTP id ay5mr2811633qvb.6.1622775253981;
        Thu, 03 Jun 2021 19:54:13 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x18sm3110686qkx.118.2021.06.03.19.54.12
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Jun 2021 19:54:13 -0700 (PDT)
Date:   Thu, 3 Jun 2021 19:54:11 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
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
Subject: Re: [PATCH 2/7] mm/thp: try_to_unmap() use TTU_SYNC for safe DEBUG_VM
 splitting
In-Reply-To: <YLlOPoP/rIRMm2U5@t490s>
Message-ID: <alpine.LSU.2.11.2106031945280.12760@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011405510.2148@eggly.anvils> <YLlOPoP/rIRMm2U5@t490s>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021, Peter Xu wrote:
> On Tue, Jun 01, 2021 at 02:07:53PM -0700, Hugh Dickins wrote:
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index 2cf01d933f13..b45d22738b45 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -212,6 +212,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >  			pvmw->ptl = NULL;
> >  		}
> >  	} else if (!pmd_present(pmde)) {
> > +		/*
> > +		 * If PVMW_SYNC, take and drop THP pmd lock so that we
> > +		 * cannot return prematurely, while zap_huge_pmd() has
> > +		 * cleared *pmd but not decremented compound_mapcount().
> > +		 */
> > +		if ((pvmw->flags & PVMW_SYNC) &&
> > +		    PageTransCompound(pvmw->page))
> > +			spin_unlock(pmd_lock(mm, pvmw->pmd));
> >  		return false;
> >  	}
> >  	if (!map_pte(pvmw))
> 
> Sorry if I missed something important, but I'm totally confused on how this
> unlock is pairing with another lock()..

I imagine you're reading that as spin_unlock(pmd_lockptr(blah));
no, the lock is right there, inside spin_unlock(pmd_lock(blah)).

> 
> And.. isn't PVMW_SYNC only meaningful for pte-level only (as I didn't see a
> reference of it outside map_pte)?

But you are pointing directly to its reference outside map_pte()!

Hugh
