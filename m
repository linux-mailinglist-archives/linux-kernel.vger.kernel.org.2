Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C4C41B96F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242949AbhI1VjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232003AbhI1VjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632865056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0oTxkz7NtuCdfXi6wiYu/Dbe5jAm1i2ab7g2h0GdR0=;
        b=WSqnY5DhKpelN3QaoW2TdFp5FKOJKklmi9WkpPP/ukeqj8kYBAb/1vCLSFCiGt15mNzKf6
        rXoG1+UtmDTHkRVcZdy1EJUydiVHWxOH3EYyUGTWeIRg2VdRINu0r+wA6A8LYc4vUyIaEz
        6cjtCAVdY0TZkx0322IDlf6wMfb+jUU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-17dCbdFmNEqo5Emc2jxFzA-1; Tue, 28 Sep 2021 17:37:35 -0400
X-MC-Unique: 17dCbdFmNEqo5Emc2jxFzA-1
Received: by mail-il1-f199.google.com with SMTP id c11-20020a928e0b000000b0024eb114af51so362142ild.22
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k0oTxkz7NtuCdfXi6wiYu/Dbe5jAm1i2ab7g2h0GdR0=;
        b=GU1puPuMYPAPCfurkQxJrhoURGrBpFsNB9ndju8xsatT3GT34yq/tXusdDbZt+3V1v
         /ln2PWGh3MRmrXgcANEi5zuVJ+alvKPSSXM9y2EeIfePLShv+35qtB2zf/MDzCPsQ21C
         6+jy3MfdlhmvMgv0PG189gR2gO3Yo9IfH1tD+sRD00tcW3nELR7MO/q+lB5FAo1IfeVB
         bv9UQldX020K2uyHlLTNQKtgvC+B1UFwx9WFSHOCsxPLJnJHSC0aatvMOvPABzcec9qa
         DNr7SXjcrjoz1jCvZHqgGz26ZauLiwAH6QbG4gnDMg2JS/gSW0iCKN2Rd86YkWp1Dp0Y
         /VgA==
X-Gm-Message-State: AOAM531q/E+jacsXa+EODG6To8ibmWkYdd0gflvM4+KHj4W/PZTNeGdg
        Y1+wiw1RdmgEtzwSHv8U3YoB9OLgWwAYu2/sqNjDwcAnsupS5WBUgzo7Ei02NVqk7hBLuBOABDY
        q5J81ONS/ENruxVtvrqEJDOgQ
X-Received: by 2002:a92:cda8:: with SMTP id g8mr5799288ild.1.1632865054514;
        Tue, 28 Sep 2021 14:37:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzncef8egk2flstm1KV0toHZLOw1cqmPWcIxsJLhlr4ajexL7LvOez53i+1SFiWl4ZQ5ku7nw==
X-Received: by 2002:a92:cda8:: with SMTP id g8mr5799277ild.1.1632865054226;
        Tue, 28 Sep 2021 14:37:34 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id e9sm167781iob.52.2021.09.28.14.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:37:33 -0700 (PDT)
Date:   Tue, 28 Sep 2021 17:37:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v4 1/4] mm/shmem: Unconditionally set pte dirty in
 mfill_atomic_install_pte
Message-ID: <YVOLG3NIlj+16IUh@t490s>
References: <20210915181456.10739-1-peterx@redhat.com>
 <20210915181456.10739-2-peterx@redhat.com>
 <49fddb9a-4a52-1df-8b7c-dde2a89330bf@google.com>
 <YVI195OZ7t3i3n6t@t490s>
 <256c72c4-ac99-94fb-d76-fab08e5cf5f4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <256c72c4-ac99-94fb-d76-fab08e5cf5f4@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 12:28:40PM -0700, Hugh Dickins wrote:
> > That's why I really like this patch to happen, I want to save time for myself,
> > and for anyone who will be fighting for another dirty lost issues.
> 
> I've lost time on missed dirties too, so I ought to be more sympathetic
> to your argument than I am: I'm afraid I read it as saying that you don't
> really understand "dirty", so want to do it more often to be "safe".
> Not a persuasive argument.

I'd hope I didn't mis-understood dirty bit, please let me know otherwise, then
I must have been making a very serious mistake, and also then I'll be more than
glad to learn to make things right, as long as you could help me to achieve it.

FWICT, I was trying to argue it's not worth it to worry the corner case, but
obviously I failed. :) But that's fine and understandable, because it happens.

> 
> > 
> > > 
> > > I haven't looked again (I have a pile of mails to respond to!),
> > > but when I looked before I think I found that the vmf flags are
> > > not available to the userfaultfd ioctler.  If so, then it would
> > > be more appropriate to just leave the mkdirty to the hardware on
> > > return from fault (except - and again I cannot spend time researching
> > > this - perhaps I'm too x86-centric, and there are other architectures
> > > on which the software *must* do the mkdirty fixup to avoid refaulting
> > > forever - though probably userfaultfd state would itself prevent that).
> > 
> > If it's based on the fact that we'll set PageDirty for file-backed, then it
> > looks okay, but not usre.
> > 
> > One thing to mention is pte_mkdirty() also counts in soft dirty by nature.  I'm
> > imagining a program that was soft-dirty tracked and somehow using UFFDIO_COPY
> > as the major data filler (so the task itself may not write to the page directly
> > hence HW won't set dirty bit there).  If with pte_mkdirty the other userspace
> > tracker with soft-dirty can still detect this, while with PageDirty I believe
> > it can't.  From that POV I'm not sure whether I can say that as proactively
> > doing pte_mkdirty is a safer approach just in case such an use case exist, as
> > myself can't say they're illegal, so pte_dirty is a superset of PageDirty not
> > vice versa.
> 
> And this is not persuasive either: without much deeper analysis
> (which I'll decline to do!), it's impossible to tell whether an excess of
> pte_mkdirty()s is good or bad for the hypothetical uffd+softdirty tracker:
> you're guessing good, I'm guessing bad.
> 
> How about a compromise (if you really want to continue with this patch):
> you leave the SetPageDirty(page) in shmem_mfill_atomic_pte(), where I
> feel a responsibility for it; but you do whatever works for you with
> pte_mkdirty() at the mm/userfaultfd.c end?

Sure.  Duplicating dirty bit is definitely fine to me as it achieves the same
goal as I hoped - we're still 100% clear we won't free a uffd page without
being noticed, then that's enough to me for the goal of this patch.  I won't
initiate that NACK myself since I still think duplicating is unnecessary no
matter it resides in shmem or uffd code, but please go ahead doing that and
I'll be fine with it, just in case Andrew didn't follow the details.

Actually, I can feel how strong opinion you're at this point on keeping the old
way on this patch, and yes I definitely touched the shmem code (your preference
has its reasoning; I have mine too and I had a preference on the other side,
but I failed to persuade you..).  So also feel free to NACK the whole patch
with both the SetPageDirty and condition checks on pte_mkdirty(), I'm fine with
it too.  I can keep the conditions in my future series too.  Not like the other
zap_details patch where I believe I must need at some point, this patch is
something I hoped a lot to have, but it's not a must.

I know this "hole" already so I won't fall into it so hard the 3rd time
(actually on the 2nd time I debugged faster and quickly noticed I just fell
into this same hole I've used to fall).  Let's wish the same to the others.

> 
> (In the course of writing this, it has occurred to me that a much nicer
> solution might be to delete mfill_atomic_install_pte() altogether, and
> change the userfaultfd protocol so that handle_userfault() returns the
> page supplied by ioctler, for process to map into its own userspace
> in its usual way. But that's a big change, that neither of would be
> keen to make; and it would not be surprising if it turned out actually
> to be a very bad change - perhaps tried and abandoned before the "atomic"
> functions were decided on. I wouldn't even dare mention it, unless that
> direction might happen to fit in with something else you're plannng.)

Dangling pages will be hard to make right, imho.  E.g., please considering one
thread faulted in with uffd-missing, we'll request UFFDIO_COPY and deliver the
page to the faulted thread, then a 2nd thread faulted on the same address
before the 1st faulted thread resolved the page fault in the pgtables.  It'll
start to be challenging from that point, imho.

From that POV I think current uffdio-copy is doing great on using pgtable and
the pgtable lock to keep all these things very well serialized.  We may have
false positives as the 2nd faulted thread will generate a dup message, but
that can be easily resolved by the user app.

Thanks,

-- 
Peter Xu

