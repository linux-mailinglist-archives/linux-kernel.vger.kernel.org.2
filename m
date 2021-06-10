Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADA03A3735
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFJWhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhFJWhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:37:46 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17512C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 15:35:36 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t140so3870079oih.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8hMl0wiRRmqM61bQjykYoRZiv0fN0EuwY/cCyjTM+xs=;
        b=tsZzr52aDZt7EMZ9iAWTl+2VnQQbd1/lX9+t/v3t24fg9RKkV3cdkBhHVguv1JYS0K
         7gHCIcKetKJ/n2u/iVovx9p/gxYWQlzmk4Yp6yrnlimH64Bp8n7hZWD6n8diWDFxIlxF
         DRstO3+fSwAKHqhVcHD4N35iQhpxpQdJtrfZh4RbhJulePf4s8qL/bl/QHWh2VJ/cj7c
         vbz9B0RBaYTZO3YFcL8e4Zcjw4oeaVfVe8KaCNXeEZERhgVuRz/anBXPRWx7xehSSX3c
         KY4IzlxdxyLdR3GOhFqXuMPfF3Fmhhg0R/cry0NrjrX0bwNX0LG6fOmZEzYOeLiPtCSl
         ATvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=8hMl0wiRRmqM61bQjykYoRZiv0fN0EuwY/cCyjTM+xs=;
        b=Flrv6XYxvXygLtsQc2B9eQR1mgFPUpt8xjsrOHoOm2wusbrAFLrd/7a8C09Hnb745L
         0tBMwmCFQZDHnF1JQmykiuGm5voDlWX5IPw/LqFc7vK5qfLYXCfEANhXtRYkvNrKGZEa
         gJR2r32pPvUGMRam0lx6foK5wmdkHF+mysuAiaIWb0O93vqU5IQER7Gks6tU2J4kRs5k
         tTpyHnA1OynCBu4TM8wzXWanhnNH422WP0o3hijBeb2EW04WnKxdpcCdvE0ML6/yRXPg
         r3xJ+nnlQkYbv+bMsm+JXH9n4DVRzt1WBjG2iq43kgKMqUVMHlPGeYhrz3gYXUiSQ7r4
         nlhw==
X-Gm-Message-State: AOAM5332lEUdaIXdJ1/TcM8EcV2FdwTOZUojsFNmHPbGcc/eHxshgRWR
        rFdYeJUBeJn+vQwBKpW0BVDb4A==
X-Google-Smtp-Source: ABdhPJzkJR3+hkPtCoFRLeiC1N5kr4AOXTv1lh6DRLsVFsUU+zlbpzLOvbpU7+yT9B7UMDMIS94nSg==
X-Received: by 2002:a05:6808:985:: with SMTP id a5mr2414446oic.77.1623364534395;
        Thu, 10 Jun 2021 15:35:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e10sm685389otr.5.2021.06.10.15.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 15:35:33 -0700 (PDT)
Date:   Thu, 10 Jun 2021 15:35:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Will Deacon <will@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] mm: page_vma_mapped_walk(): use page for
 pvmw->page
In-Reply-To: <YMIeTEYwzmKdrMqG@t490s>
Message-ID: <82f6838b-ea38-2030-a8c6-8d2defc2e6@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com> <88e67645-f467-c279-bf5e-af4b5c6b13eb@google.com> <20210610085522.f5ffyejzn3xtqark@box.shutemov.name> <YMIeTEYwzmKdrMqG@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021, Peter Xu wrote:
> On Thu, Jun 10, 2021 at 11:55:22AM +0300, Kirill A. Shutemov wrote:
> > > @@ -234,9 +233,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > >  			return true;
> > >  next_pte:
> > >  		/* Seek to next pte only makes sense for THP */
> > > -		if (!PageTransHuge(pvmw->page) || PageHuge(pvmw->page))
> > > +		if (!PageTransHuge(page) || PageHuge(page))
> > >  			return not_found(pvmw);
> > > -		end = vma_address_end(pvmw->page, pvmw->vma);
> > > +		end = vma_address_end(page, pvmw->vma);
> > >  		do {
> > >  			pvmw->address += PAGE_SIZE;
> > >  			if (pvmw->address >= end)
> > 
> > I see two more pvmw->page in this loop. Do you leave them here as the code
> > will be rewritten later in the patchset?

That would be tacky; but I cannot see them (apart from in check_pte()).

> 
> I think they've got removed in previous series ("[PATCH v2 04/10] mm/thp: fix
> vma_address() if virtual address below file offset").

Yes, I think you've found the right explanation.

> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,
Hugh
