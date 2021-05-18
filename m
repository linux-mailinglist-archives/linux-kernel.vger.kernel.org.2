Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C03D38766C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348473AbhERK1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242870AbhERK1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:27:49 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E521EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:26:30 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id x15so9272490oic.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mU/NNV0Kszseb1MnLIIdlRvIBPmRmPf+2nBb/wwtKw=;
        b=pRYuI5YFZrPoNB4YYh1aPgWGEG3Hkr1vYF3dJJby7Q4Up+iMseB4HRTUuZBwqOZDDr
         BuDtlcsPhVG3FjcDuy9wtQmOGnbzpfGQB+pX6T4LKBqSW1Scyk83wDdjnOD46w6Rms+x
         LBD/B6JexSvpi/lLQCFiMszD8BktObOxPIRun9QDYdgvYHHx8NXEbaHrcD0Nss9Bs7BB
         k6+3Uq+P5UI7kSUYNEviCrY3NPMnAQSGVzne4qSVoPTAUv3iu45yLqzTQnGoeLoRhdwN
         Q6QzJCdQXgfHoT3i6P3J7c4CLgg9Cc/jW1oDOIeNDsV59kzAlpU0Yezujy4r9n8GxdNV
         1UCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mU/NNV0Kszseb1MnLIIdlRvIBPmRmPf+2nBb/wwtKw=;
        b=HcfdMwe6PdoHZoRj3e3zYoFNyOGepA7U22XZMp3AvG1WNxYDBDjvtsKKBctMd3cVjN
         IFru3JAtPNLLu/KQw3Hzfi6U3B7WyFqg82aOKAcYoGPfOWWFVqH/x1vKjsHYijnsJbvv
         ROc/k1XsHC3yGr4EPIMLQfqjvuTnFrhtlIJlG3eh+w7gxjH6NJs3s+THqVwNJpfepHWG
         +3KjPkyMfwDD3HzknLuD7sTogDiW6zLRfr8voq8OMRWk6vMb6bjXq0mUZFW+cEWimndA
         Z7zyltK6jU2re5tl2jW7td4/0O9yLRUe8MzHRzLdWDlcdcAurSXX5Dgw80Bk6lD/2pP8
         UvYw==
X-Gm-Message-State: AOAM53361hNp0UVGoa0xcNycPLDPMRH85uwWF0U/rv8sSkW99hL1MyNU
        XSt+HjxgF++iH8IO07hvOyQSr3FFHvsyKt4Ewpg=
X-Google-Smtp-Source: ABdhPJxm141ZsUF6u39+57ylWb2ptiOY7eTW2B1ZaYFPJYhW1ZPlf2ltkyfZa84v4XTBJC+3cCn0YO+QXQlNjIVWOKE=
X-Received: by 2002:a05:6808:a96:: with SMTP id q22mr2913741oij.47.1621333590379;
 Tue, 18 May 2021 03:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210517112044.233138-1-aisheng.dong@nxp.com> <20210517112044.233138-3-aisheng.dong@nxp.com>
 <YKOSZELQWd6o7cva@kernel.org>
In-Reply-To: <YKOSZELQWd6o7cva@kernel.org>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 May 2021 18:25:28 +0800
Message-ID: <CAA+hA=QcNWo3brs4HvdBb+QHHOiBHgF3hdbfJ1ivaGHiBXM4EQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/sparse: free section usage memory in case
 populate_section_memmap failed
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 6:09 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, May 17, 2021 at 07:20:41PM +0800, Dong Aisheng wrote:
> > Free section usage memory in case populate_section_memmap failed.
> > We use map_count to track the remain unused memory to be freed.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  mm/sparse.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 7ac481353b6b..98bfacc763da 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -549,12 +549,14 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> >                              __func__, nid);
> >                       pnum_begin = pnum;
> >                       sparse_buffer_fini();
> > +                     memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
>
> I'd move both sparse_buffer_fini() and freeing of 'usage' memory after the
> failed label.
>

Doing that needs to introduce another 'failed' label.
Do you think if it's necessary?

e.g.
diff --git a/mm/sparse.c b/mm/sparse.c
index 7ac481353b6b..408b737e168e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -533,7 +533,7 @@ static void __init sparse_init_nid(int nid,
unsigned long pnum_begin,
                        mem_section_usage_size() * map_count);
        if (!usage) {
                pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
-               goto failed;
+               goto failed1;
        }
        sparse_buffer_init(map_count * section_map_size(), nid);
        for_each_present_section_nr(pnum_begin, pnum) {
@@ -548,17 +548,20 @@ static void __init sparse_init_nid(int nid,
unsigned long pnum_begin,
                        pr_err("%s: node[%d] memory map backing
failed. Some memory will not be available.",
                               __func__, nid);
                        pnum_begin = pnum;
-                       sparse_buffer_fini();
-                       goto failed;
+                       goto failed2;
                }
                check_usemap_section_nr(nid, usage);
                sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
                                SECTION_IS_EARLY);
                usage = (void *) usage + mem_section_usage_size();
+               map_count--;
        }
        sparse_buffer_fini();
        return;
-failed:
+failed2:
+       sparse_buffer_fini();
+       memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
+failed1:
        /* We failed to allocate, mark all the following pnums as not present */
        for_each_present_section_nr(pnum_begin, pnum) {
                struct mem_section *ms;

Regards
Aisheng
> >                       goto failed;
> >               }
> >               check_usemap_section_nr(nid, usage);
> >               sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
> >                               SECTION_IS_EARLY);
> >               usage = (void *) usage + mem_section_usage_size();
> > +             map_count--;
> >       }
> >       sparse_buffer_fini();
> >       return;
> > --
> > 2.25.1
> >
> >
>
> --
> Sincerely yours,
> Mike.
