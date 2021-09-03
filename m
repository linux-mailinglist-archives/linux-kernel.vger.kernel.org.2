Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FEF400642
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350065AbhICUBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234588AbhICUBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630699236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x9PgDg0VuadlLxntBrqQGmujU+0XAeFQSKsJZr0kO/w=;
        b=KUuRLNkhFPMiIDgDl9Tpcr9sVhKUyzY6KxKp38Oy9ofj9xhVo65r60p1l2bW+K13rHonRk
        t/OIoxoxeFiN1hm1hgWL3WcbEnxFaYpqwshYbqiwIloJejVhJGmGKcenq2LKuXJodfzuRm
        6+yyx2M8+KS1G+1nAobhCw1SIUm2vyw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-vg1s6dktMq2clVCGcWyIiw-1; Fri, 03 Sep 2021 16:00:35 -0400
X-MC-Unique: vg1s6dktMq2clVCGcWyIiw-1
Received: by mail-qv1-f70.google.com with SMTP id et12-20020a056214176c00b0037279a2ce4cso683982qvb.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 13:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x9PgDg0VuadlLxntBrqQGmujU+0XAeFQSKsJZr0kO/w=;
        b=NVPniDaEBEnZKMp24pP3A731sZXuB5QS4qUmcXGnu4Kdr80Z5HOUIJ9v+pr301M9xL
         2nkvnh9ZpY2aaVMV0e0NS54CGTvpdoMPEQ4gGk1ta2GgUIGgV+79OeIOv1NbRexEf0P/
         TQK31icW1pc3s0ptFQm1ELHBIj4Nv0yuG24xVA+9Xt2T812JuR1bLOqoHQ/cCJNiMFpd
         waL2MZX9Sxub432UYfsEMjJVGumX2m83T2Rz68ItJpNADGF3g2sUFDwMMVorT1VgRJz2
         1s2pC/QLoYqWuGwiryHX9C0Ch27ZNDE0SM0fPywX8bfWC9uDAyS1bDQhDwR0P/gr2spN
         xP4Q==
X-Gm-Message-State: AOAM530car8EtNb0raSDVrrUSMcd7O0Y/qqzmtVtgC1auz9kUAlbG+jO
        WBtQfBhYResRw++h5VZZ/CyXvvNaM0SvPDuDjrcatYWWc+0+y0X3luKIHue19kRbkdaUS3Wfv3n
        klIuUIKMXg99or2nZMIxDNJiY
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr673239qtn.49.1630699235038;
        Fri, 03 Sep 2021 13:00:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye/lyjzu//z90V1ZPCWF2igim5y/x1oB909G3x2WTTet8of7sXkSA//xTu7Jgi3hdUtDTKGg==
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr673211qtn.49.1630699234768;
        Fri, 03 Sep 2021 13:00:34 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id a189sm133760qkf.114.2021.09.03.13.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 13:00:34 -0700 (PDT)
Date:   Fri, 3 Sep 2021 16:00:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v2 1/5] mm/shmem: Unconditionally set pte dirty in
 mfill_atomic_install_pte
Message-ID: <YTJ+4PAzKf9Cqydk@t490s>
References: <20210902201721.52796-1-peterx@redhat.com>
 <20210902201721.52796-2-peterx@redhat.com>
 <2f1bfe82-9bb7-957c-2b32-2ccf8a48e70a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f1bfe82-9bb7-957c-2b32-2ccf8a48e70a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 09:42:34AM +0200, David Hildenbrand wrote:
> On 02.09.21 22:17, Peter Xu wrote:
> > It was conditionally done previously, as there's one shmem special case that we
> > use SetPageDirty() instead.  However that's not necessary and it should be
> > easier and cleaner to do it unconditionally in mfill_atomic_install_pte().
> > 
> > The most recent discussion about this is here, where Hugh explained the history
> > of SetPageDirty() and why it's possible that it's not required at all:
> > 
> > https://lore.kernel.org/lkml/alpine.LSU.2.11.2104121657050.1097@eggly.anvils/
> > 
> > Currently mfill_atomic_install_pte() has three callers:
> > 
> >          1. shmem_mfill_atomic_pte
> >          2. mcopy_atomic_pte
> >          3. mcontinue_atomic_pte
> > 
> > After the change: case (1) should have its SetPageDirty replaced by the dirty
> > bit on pte (so we unify them together, finally), case (2) should have no
> > functional change at all as it has page_in_cache==false, case (3) may add a
> > dirty bit to the pte.  However since case (3) is UFFDIO_CONTINUE for shmem,
> > it's merely 100% sure the page is dirty after all, so should not make a real
> > difference either.
> 
> Would it be worth adding VM_BUG_ON() to make sure that "100%" is really the
> case?

I won't be able to make it 100% sure (and that's where I put it "merely").  The
example discussed between Axel and me in the other thread could be an outlier
(when two processes, uffd target, and uffd minor resolver, map the region as
RO), it's just that neither do I think that's a great matter, nor do I think it
would be worth a BUG_ON(), not to mention we use BUG_ON so carefully.

> 
> > 
> > This should make it much easier to follow on which case will set dirty for
> > uffd, as we'll simply set it all now for all uffd related ioctls.  Meanwhile,
> > no special handling of SetPageDirty() if there's no need.
> 
> To me this all sounds sane, but I'm certainly not an expert on that code, so
> ...

No problem.  I hope this patch didn't bring much headache to a lot of people.
It's just that I do think this is the right thing to do so I will insist until
someone says no to me.  Already appreciate a lot for all the comments and r-bs!

-- 
Peter Xu

