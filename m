Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6773876DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348643AbhERKrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348650AbhERKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:47:30 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C90C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:46:11 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so8219862oth.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLn0qmv+qeKnpI5hPApwAC1v8Q18RNOwfCBH1vF3cnI=;
        b=hE+Os49HBcsVKkzno2MpD5l9huV9cOpZZVO6fSr8j2C2n+ty9XE5CcrM5HzKzk47s+
         l/WV3cqoKXfKCccTq7O/SS38K8ikxrJrJF0abeUNLZOrOiQLc66Zy5rkqO18R7OTShSd
         Mo3b87/vBM0iAW9/DXk1gQPPbKhC2HddEtjNd3JJy+ki15W/rEuGhZ31k/xYOc40FNlq
         136hISg8mak8RG0AQ0cro9uTJTCzKZpk93FdOSdP6gwY0Dy5+IkcF9+a/NXsKjpGHQR5
         tWoLJtnB3omKizBHU6D8ZWyNoMcqcdHnwyI1MQEzpjnUs8JkKlZL5eno8fDinstr+Mqb
         oqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLn0qmv+qeKnpI5hPApwAC1v8Q18RNOwfCBH1vF3cnI=;
        b=qP/UqZttMJARUtqEDnA0PRx4yYROFCCpcZOA1CCBtQRO60HAy+b0dFW3MT0AiLwFKO
         csAt5WmyqCK9v3XXieJhjDdQR2dyj4M1+B7DVbnA+2mzPoO/DgoTj3vWxJPShkMXhVc/
         AzOmV2h87/ueF/NOLZyjR98WhppNiKNv3iJGOgWqvoxShprvpJuKJwhCnxsLWpZz23HR
         TmV+TR8BdG9Dp3YKD4sl4JLAoYucqmCKNz9TWzwdxgnv9ul7CKwHiNUONAcuu0b+fMSr
         7xHuaC3p12SLk3tdL5OzKaB8ldPOKxuCuuV59xotkG99vA04sLQv8O2AwviiMm6bIJ3Q
         NRbw==
X-Gm-Message-State: AOAM530IjtpWF9BvMYR94eUqcUs6mKaVtdbeg67M/iViOqHZFIJY8vVE
        ryHQoVJDB+HOwsGOVBN768GAmKXpXFlj5t81uQA=
X-Google-Smtp-Source: ABdhPJy618grM6clriKmwdc2E1GMWXwbHncO5uOQG90ApB0CP6RlS0ZfGJ6bpAloJD0tFyM5WMl7c5TNNbZoEyQneAE=
X-Received: by 2002:a9d:4115:: with SMTP id o21mr3740851ote.52.1621334771169;
 Tue, 18 May 2021 03:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210517112044.233138-1-aisheng.dong@nxp.com> <20210517112044.233138-4-aisheng.dong@nxp.com>
 <YKOTDumqMIFfqc+f@kernel.org>
In-Reply-To: <YKOTDumqMIFfqc+f@kernel.org>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 May 2021 18:45:08 +0800
Message-ID: <CAA+hA=TZyVcSfbBzJvzwULhbvfC00JP=_xam3JoirdnTiDd_KQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/sparse: move mem_sections allocation out of memory_present()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 6:12 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, May 17, 2021 at 07:20:42PM +0800, Dong Aisheng wrote:
> > The only path to call memory_present() is from memblocks_present().
> > The struct mem_section **mem_section only needs to be initialized once,
> > so no need put the initialization/allocation code in memory_present()
> > which will be called multiple times for each section.
> >
> > After moving, the 'unlikely' condition statement becomes to be
> > meaningless as it's only initialized one time, so dropped as well.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  mm/sparse.c | 23 ++++++++++-------------
> >  1 file changed, 10 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 98bfacc763da..df4418c12f04 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -254,19 +254,6 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
> >  {
> >       unsigned long pfn;
> >
> > -#ifdef CONFIG_SPARSEMEM_EXTREME
> > -     if (unlikely(!mem_section)) {
> > -             unsigned long size, align;
> > -
> > -             size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> > -             align = 1 << (INTERNODE_CACHE_SHIFT);
> > -             mem_section = memblock_alloc(size, align);
> > -             if (!mem_section)
> > -                     panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> > -                           __func__, size, align);
> > -     }
> > -#endif
>
> Maybe split this into a helper function and call it directly from
> sparse_init()?
>

Sounds good to me
e.g. sparse_alloc_section_root() called directly from sparse_init().
Thanks for the suggestion

Regards
Aisheng

> > -
> >       start &= PAGE_SECTION_MASK;
> >       mminit_validate_memmodel_limits(&start, &end);
> >       for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
> > @@ -292,9 +279,19 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
> >   */
> >  static void __init memblocks_present(void)
> >  {
> > +     unsigned long __maybe_unused size, align;
> >       unsigned long start, end;
> >       int i, nid;
> >
> > +#ifdef CONFIG_SPARSEMEM_EXTREME
> > +     size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> > +     align = 1 << (INTERNODE_CACHE_SHIFT);
> > +     mem_section = memblock_alloc(size, align);
> > +     if (!mem_section)
> > +             panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> > +                   __func__, size, align);
> > +#endif
> > +
> >       for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
> >               memory_present(nid, start, end);
> >  }
> > --
> > 2.25.1
> >
> >
>
> --
> Sincerely yours,
> Mike.
