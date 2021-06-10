Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F713A2B47
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFJMSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:18:55 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:33344 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhFJMSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:18:54 -0400
Received: by mail-qk1-f172.google.com with SMTP id c9so701115qkm.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X/mw4hUZ/e5f8XcWky8PtkE7VfZGoQ7c5l0ce8GaFjk=;
        b=pSqsk6p1i6tt3msly851ebT62Y/2WSMFTcvhfyyUMuhTUXHhw1/gPmNWygVky3pXhy
         lCvnjq7gr9f0ofN3XRP2fQkIhZ/Luzt0ZOyvH/MRBsGLQvJ8zsvkh2NFVlrP5SwNcf9z
         gNPzr6of/TmH2GLQr6m5W3NAOVX8lOmqWyBFoGq3kYPadO1ditmqEDWbNIiHgFL0NqUE
         X1ErKX7lL5VEkI3RBNQmfHyRBDpYCFAVhM8w6biv0xISvwLyTky/kg81jh/bepQDZsUf
         RKzQFj9V5dFIZ/GHAza4DFQTD6RXVJr3/jyllN7jM9tU7uOX/p0PUa7rFArfTpK9Jt2t
         qFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X/mw4hUZ/e5f8XcWky8PtkE7VfZGoQ7c5l0ce8GaFjk=;
        b=kDIAeJLuAXTlo+TuB2UMw4butFQwXTzYkzJ4Xw0epBIiLX+uTpXB8HCcR0BMAFu/zI
         cwMjXY6IJgwcfEe+VmFFAnXpyfHVo283guM9+GJk7Zbxr+6QTCxW2XbE0pY7HoHWcX73
         yayeG2XTIKxUVqf50vuUS1NPuDd6HZMAsQN01iZW5q56LjXRtjtstgyxiuxqp6kNfKYJ
         CVSMyPVoZoDunjix6hPEewfGig4fTPOiZh8rkaA1t9SuUo3W1KwcGJMqM9H/NkyX3cgE
         VEowbgERvLA5HQYy669GgQWWvgbGo/YLpclYwbPlM9AwXIERFn9iwpH3Y0CUFATCvDon
         7agA==
X-Gm-Message-State: AOAM533fIeY7ZiQKaSVBa4amZUlgpdubgMgQkPUG4N7UdZ2zQB8S7cER
        vIpWmOKruoHoWN8ZT6psVmUXTw==
X-Google-Smtp-Source: ABdhPJx8bkfi4t9XeSnNx/iqKc0BUHZGJ17n0wfLu9CTkrquetTaEWfeRydyF66UUbGMoF2UrtYlxg==
X-Received: by 2002:a37:63d6:: with SMTP id x205mr4208068qkb.501.1623327343383;
        Thu, 10 Jun 2021 05:15:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id a191sm2133358qkg.61.2021.06.10.05.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:15:42 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lrJb4-0053vI-3o; Thu, 10 Jun 2021 09:15:42 -0300
Date:   Thu, 10 Jun 2021 09:15:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] mm: page_vma_mapped_walk(): use pmd_read_atomic()
Message-ID: <20210610121542.GQ1096940@ziepe.ca>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <594c1f0-d396-5346-1f36-606872cddb18@google.com>
 <20210610090617.e6qutzzj3jxcseyi@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610090617.e6qutzzj3jxcseyi@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:06:17PM +0300, Kirill A. Shutemov wrote:
> On Wed, Jun 09, 2021 at 11:38:11PM -0700, Hugh Dickins wrote:
> > page_vma_mapped_walk() cleanup: use pmd_read_atomic() with barrier()
> > instead of READ_ONCE() for pmde: some architectures (e.g. i386 with PAE)
> > have a multi-word pmd entry, for which READ_ONCE() is not good enough.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: <stable@vger.kernel.org>
> >  mm/page_vma_mapped.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index 7c0504641fb8..973c3c4e72cc 100644
> > +++ b/mm/page_vma_mapped.c
> > @@ -182,13 +182,16 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >  	pud = pud_offset(p4d, pvmw->address);
> >  	if (!pud_present(*pud))
> >  		return false;
> > +
> >  	pvmw->pmd = pmd_offset(pud, pvmw->address);
> >  	/*
> >  	 * Make sure the pmd value isn't cached in a register by the
> >  	 * compiler and used as a stale value after we've observed a
> >  	 * subsequent update.
> >  	 */
> > -	pmde = READ_ONCE(*pvmw->pmd);
> > +	pmde = pmd_read_atomic(pvmw->pmd);
> > +	barrier();
> > +
> 
> Hm. It makes me wounder if barrier() has to be part of pmd_read_atomic().
> mm/hmm.c uses the same pattern as you are and I tend to think that the
> rest of pmd_read_atomic() users may be broken.
> 
> Am I wrong?

I agree with you, something called _atomic should not require the
caller to provide barriers.

I think the issue is simply that the two implementations of
pmd_read_atomic() should use READ_ONCE() internally, no?

Jason
