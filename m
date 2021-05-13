Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958C437FBFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhEMRBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhEMRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:00:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEAAC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:59:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c22so12720223ejd.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlfKotu9sca7LHhOUQlejV4TMBT38h8R33rjxE+jdW8=;
        b=Zqr3iG+q0GJOewBqwZhZyyP9OMzSabGqlImo0bNoJVzWNtvVPzvEP4Eq5tNFu3YVCy
         GhfQsgXXr2hD2WSkbDSAM6y1eOseCYhVMPBgMO6rs9OZST5ITs6bRMSE2ooZzbHO6hcg
         yTWC/G33pE9f1kH7cxRgHRs0MeGiTmsciBFOhYqqSWjafMzr93SpShiV7tgEBi6bL43d
         aAbnvQ1uzcaqBNMOwwBveKW+jJn++qrSPPEhNd5fnyk+xjQDEzsQjFtXsazEimGRydJ9
         FvAkDicbe8lru1funJlzYAkUsOtq7+jAUIwGBaspsNp6/Zmjr3J21Sv4wxQVxD+rD3To
         qhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlfKotu9sca7LHhOUQlejV4TMBT38h8R33rjxE+jdW8=;
        b=B6Sqo3P3KIL6BcRXe2uqg/ck+EGKuX+EeJo0aNiD+rAU/5kBY0vgxW4AzEt0XCzahg
         dwvfsvuGSj8KKl/giIxU7zYWhbjecbWH7sBNtPXe3XXQEAlZdTG2VPQQARD32bvR58YA
         zFjTWTOPpQTqOgukT73f+datJZtG9Q3DaAJZMzwaZ3qLl2EVbJKOhXf8qjrCBMFdZsTZ
         q7zu/mINpHW9VQohxnvl3IXNGPUJqGcV8QnmKPDDaEinw5AgMJEL/a7PLOTeX/VKqm7P
         7nbZbYWhvDJDq34nC9/cLYiJ7AHsIXffuxEyKyEaBeDaTsUdefzSF2fggbOQtQ9ZREVh
         +q1A==
X-Gm-Message-State: AOAM531Ra89AcHbdJ9OaV4olDPSuEsWXiqG389591NmNN/r61+nCE03E
        lzzCCxX5HEhBCUAeN3vMyOc5kFc6WZgX9iSVnOM=
X-Google-Smtp-Source: ABdhPJwTw/EhzpOLvZKoM7wzshi7JIeiZlRD0pSH09UR1VbFoI380Mgzy6S0IYW9rB5Yrs2Pq87gtWFtP0E92gIExkE=
X-Received: by 2002:a17:906:b7d6:: with SMTP id fy22mr1236673ejb.383.1620925186436;
 Thu, 13 May 2021 09:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <1620890438-9127-1-git-send-email-anshuman.khandual@arm.com> <CAHbLzkpMF9b148ois7vMPrB9TVQNAfObWD=b02RFFvYBGhX3mg@mail.gmail.com>
In-Reply-To: <CAHbLzkpMF9b148ois7vMPrB9TVQNAfObWD=b02RFFvYBGhX3mg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 13 May 2021 09:59:34 -0700
Message-ID: <CAHbLzkqcyjL6L5UUvf1+=_8T3FuJxHXi8qHnevcFub+8rjc27A@mail.gmail.com>
Subject: Re: [RFC] mm/thp: Update mm's MM_ANONPAGES stat in set_huge_zero_page()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 9:50 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, May 13, 2021 at 12:20 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> >
> > Although the zero huge page is being shared across various processes, each
> > mapping needs to update its mm's MM_ANONPAGES stat by HPAGE_PMD_NR in order
> > to be consistent. This just updates the stats in set_huge_zero_page() after
> > the mapping gets created.
>
> I don't get why MM_ANONPAGES needs to be inc'ed when huge zero page is
> installed. This may cause inconsistency between some counters, for
> example, MM_ANONPAGES may be much bigger than anon LRU.
>
> MM_ANONPAGES should not be inc'ed unless a new page is allocated and
> installed, right?

I just realized I mixed MM_ANONPAGES up with the global anon pages
counter. Take back my comment. Sorry for the confusion.

>
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > Should it update MM_SHMEM_PAGES instead ? Applies on latest mainline.
> >
> >  mm/huge_memory.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 63ed6b25deaa..262703304807 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -706,6 +706,7 @@ static void set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
> >         if (pgtable)
> >                 pgtable_trans_huge_deposit(mm, pmd, pgtable);
> >         set_pmd_at(mm, haddr, pmd, entry);
> > +       add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
> >         mm_inc_nr_ptes(mm);
> >  }
> >
> > --
> > 2.20.1
> >
> >
