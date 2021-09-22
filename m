Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4BF41507A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhIVTbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhIVTbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:31:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:29:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v24so14164138eda.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrgYKtLBFmADfbZ+EYXAyd1R7pHk70zMq4I3HKrL4XQ=;
        b=NI4B6c5Qs9pLgZIr+E/Nu2rx85ukfw5hFmSAOYbROuToPf5XUHw+j+mdm180lecoHZ
         0w1NAfQ4uRdFv2cfVtln927lh0MS/bHTqBb1vA6rRQoWCphWgeyH0qW6OsPPWv7lxl20
         QsKNinptBhinFvMMKCYarJSXkOfpOTEZE1gOKjwT1fG2JazP4CJQPNHsOZp+vjAihrqj
         7KnSxupg4hbcf+7LIGXg9JktXt1ntRYwVvfZsXq0MDsJUmtNdOb/msOhyZNQNuj5OPxF
         EwncwYtWQnDcBaMwEBFnpO/E8/+vqN8AgueNVkNlkkmiVIg3O/qO7kaFACONVTLJPBjF
         sf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrgYKtLBFmADfbZ+EYXAyd1R7pHk70zMq4I3HKrL4XQ=;
        b=ufoMQlkucbPGgfe53edI5lPeuD1k4VVQNJq3/m5fTppc0lUJOIhLmqy7syrhx+RwdE
         TNKaTy9RI+tuAFvldeig1oLBLQdzG4Svz33+QQni6a79nD6M0r6BuUb3g2vDlZjTdgJ2
         P2BsAXxJ979eK5dNqJif38ERAPcyXMFCpWH18FofK6HcHCrB2ahciySEPnkwrLSDTVgq
         KwrNMRkz+GOeAZH8M7yk2iCnn4UNXOfc3XfCwCZHE7K8dPTOSxndax7euhH3SmXtLrPV
         CMRrrbR9PUVrKT9I5qto4XN1z4EAQciFIlSajrZWIr8vTWHGFwgK+yaCZZzrGaCAiGbY
         mQ/A==
X-Gm-Message-State: AOAM53380OchN48oHGD3AMwIMUd9rZr0Sxh8Vne1sZ5cDEAMGO3eHMUI
        W2ZHWZbasGxZI9KBn/4BTq7Hz8v1O3gRN+TEqjU=
X-Google-Smtp-Source: ABdhPJyaWkH37JcxWEo4IHedaosrFO3Vwov7XSXXX6HnCS4Jvx1o0l4NCFPI4WmlGETJeGrfu6RWjdOh8l66fvgjEC4=
X-Received: by 2002:a50:e0c8:: with SMTP id j8mr1132137edl.283.1632338987090;
 Wed, 22 Sep 2021 12:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210922175156.130228-1-peterx@redhat.com> <6bbb8e29-9e21-dfbe-d23d-61de7e3cc6db@redhat.com>
 <YUt833H6eaYFyHXD@t490s>
In-Reply-To: <YUt833H6eaYFyHXD@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 22 Sep 2021 12:29:35 -0700
Message-ID: <CAHbLzkq7kTdEC6ADJRAxXBEOYhsjR8E9uiEFCYFmtA5cD5fMhA@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 11:58 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Sep 22, 2021 at 08:21:40PM +0200, David Hildenbrand wrote:
> > On 22.09.21 19:51, Peter Xu wrote:
> > > We forbid merging thps for uffd-wp enabled regions, by breaking the khugepaged
> > > scanning right after we detected a uffd-wp armed pte (either present, or swap).
> > >
> > > It works, but it's less efficient, because those ptes only exist for VM_UFFD_WP
> > > enabled VMAs.  Checking against the vma flag would be more efficient, and good
> > > enough.  To be explicit, we could still be able to merge some thps for
> > > VM_UFFD_WP regions before this patch as long as they have zero uffd-wp armed
> > > ptes, however that's not a major target for thp collapse anyways.
> > >
> >
> > Hm, are we sure there are no users that could benefit from the current
> > handling?
> >
> > I'm thinking about long-term uffd-wp users that effectively end up wp-ing on
> > only a small fraction of a gigantic vma, or always wp complete blocks in a
> > certain granularity in the range of THP.
>
> Yes, that's a good question.
>
> >
> > Databases come to mind ...
>
> One thing to mention is that this patch didn't forbid thp being used within a
> uffd-wp-ed range.  E.g., we still allow thp exist, we can uffd-wp a thp and
> it'll split only until when the thp is written.
>
> While what this patch does is it stops khugepaged from proactively merging
> those small pages into thps as long as VM_UFFD_WP|VM_UFFD_MINOR is set.  It may
> still affect some user, but it's not a complete disable on thp.
>
> >
> > In the past, I played with the idea of using uffd-wp to protect access to
> > logically unplugged memory regions part of virtio-mem devices in QEMU --
> > which would exactly do something as described above. But I'll most probably
> > be using ordinary uffd once any users that might read such logically
> > unplugged memory have been "fixed".
>
> Yes, even if you'd like to keep using uffd-wp that sounds like a very
> reasonable scenario.
>
> >
> > The change itself looks sane to me AFAIKT.
>
> So one major motivation of this patch of mine is to prepare for shmem, because
> the old commit obviously only covered anonymous.
>
> But after a 2nd thought, I just noticed shmem shouldn't have a problem with
> khugepaged merging at all!
>
> The thing is, when khugepaged is merging a shmem thp, unlike anonymous, it'll
> not merge the ptes into a pmd, but it'll simply zap the ptes.  It means all
> uffd-wp tracking information won't be lost even if merging happened, those info
> will still be kept inside pgtables using (the upcoming) pte markers.

khugepqged does remove the pgtables. Please check out
retract_page_tables(). The pmd will be cleared and the ptes will be
freed otherwise the collapsed THP won't get PMD mapped by later
access.

>
> When faulted, we'll just do small page mappings while it won't stop the shmem
> thp from being mapped hugely in other mm, afaict.
>
> With that in mind, indeed I see this patch less necessary to be merged; so for
> sparsely wr-protected vmas like virtio-mem we can still keep some of the ranges
> mergeable, that sounds a good thing to keep it as-is.
>
> NACK myself for now: let's not lose that good property of both thp+uffd-wp so
> easily, and I'll think more of it.
>
> (To Axel: my question to minor mode handling thp still stands, I think..)
>
> Thanks,
>
> --
> Peter Xu
>
>
