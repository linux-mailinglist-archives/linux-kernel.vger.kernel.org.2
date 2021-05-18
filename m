Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAF7388175
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352095AbhERUgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhERUg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:36:28 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE4DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:35:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l4so16596888ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+yPM+CpyV8Wh11cTJC3LS6+dkbEEXWG+p9UZNDPsAk=;
        b=l/azbJk3fat9D0FL0O6XKEvUeyA5tZs2XQoikedFbtKvJ8jTeX1DB8hZP8rzqRtKq4
         X1wvvHxlgWhyR5BbfY0/dFH984efcfRxwEVHjXoIxkKUzKjckD2B0s+OZU1nKhm9Dthl
         DAnsZ8ife3AiZAOVgmAlRk0KTTLP87UnIPlYwUTY07JyJvdld7LFNZjkllBIzVeL3QJd
         0phyC2eaA0eHNZTqQZZd5C1GmhWu1Snul/+EM9i0oZe2ICkZSZa3GbbG0K8agQIhkR35
         3o9400/8DStKDotpco5ne8237WNQhhxvZoe+8fm2y0qqjIL0kAEVClGECmfwPCjyPxcl
         6PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+yPM+CpyV8Wh11cTJC3LS6+dkbEEXWG+p9UZNDPsAk=;
        b=JJKjmnzZZceV4E4HLBg7q6BeC/TmjV1JjADWVe+Pe4NBgKGKU+4tzweXUuzo+cMfvE
         CadUOH8EJw7zgyOh/5AxxzqSkViIzjBnNTSXcaFCjIjLKgbTwprLYIMsvmwBUP8HI0ui
         20NUmTM/XOObl4j+HBXtIA75FCRf+LHXH4C3c/DptpTftpod9Pf+yEHYF0Y8CvSSS0Qe
         B266WfMZ/licMtfVv7i6O9VR8ivz6GKV5MHWothsNXa5L+hah8rTQnz1pIEF9PgOIvCc
         n1vToOgdp8pknvpvmQOUHKEurTEhTj2zn1xUWJUVEcErCkCgxIA6g34/qe+DjHjBqB+6
         f8aw==
X-Gm-Message-State: AOAM533tEgW3U4AKrYwHHvoLTsgmaN4MmY/Ovws0eATkx9gsrZyAlBlQ
        OHZUXcZFbJtg+quXxK0u6ePGhuHK/fhjBoV/5Ic=
X-Google-Smtp-Source: ABdhPJxtiC1TrMgg8FP975op27pt7l46d2euPAFUX3EXSZ3uUypUhsdti8PJxgghaGeWZmJjjsOvel9nRXUzFmxM+4o=
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr7997640ejf.25.1621370107556;
 Tue, 18 May 2021 13:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210518200927.69011-1-jrdr.linux@gmail.com> <CAHbLzkpZnqAwDDFYHwd7K7CA-8i1yZEwOVVZsb4GqA9_7XCz_Q@mail.gmail.com>
In-Reply-To: <CAHbLzkpZnqAwDDFYHwd7K7CA-8i1yZEwOVVZsb4GqA9_7XCz_Q@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 18 May 2021 13:34:55 -0700
Message-ID: <CAHbLzkqZZpQ+JUA10QaLDZUqiGr6XkSc+Dhpatd6JPhzhdE7Bg@mail.gmail.com>
Subject: Re: [PATCH] mm/huge_memory.c: Remove unused variable unmap_success
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:19 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, May 18, 2021 at 1:09 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > Kernel test robot throws below warning ->
> >
> >    mm/huge_memory.c: In function 'unmap_page':
> > >> mm/huge_memory.c:2345:7: warning: variable 'unmap_success' set but not used [-Wunused-but-set-variable]
> >     2345 |  bool unmap_success;
> >          |       ^~~~~~~~~~~~~
> >
> > Remove the unused variable unmap_success.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Thanks for catching this. Reviewed-by: Yang Shi <shy828301@gmail.com>
>
> Just like https://lore.kernel.org/linux-mm/CAHbLzkonsd9f=48+cxKOJamNb9e8qpvWJCYDGFB_wNTdET2zmQ@mail.gmail.com/T/#t,
> not sure why my compiler didn't catch such warning.

I just found out my build has "-Wno-unused-but-set-variable". This
explains why I didn't catch it.

> > ---
> >  mm/huge_memory.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 52ca04b905cf..ff79a12993c9 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2342,14 +2342,13 @@ static void unmap_page(struct page *page)
> >  {
> >         enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
> >                 TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> > -       bool unmap_success;
> >
> >         VM_BUG_ON_PAGE(!PageHead(page), page);
> >
> >         if (PageAnon(page))
> >                 ttu_flags |= TTU_SPLIT_FREEZE;
> >
> > -       unmap_success = try_to_unmap(page, ttu_flags);
> > +       try_to_unmap(page, ttu_flags);
> >  }
> >
> >  static void remap_page(struct page *page, unsigned int nr)
> > --
> > 2.25.1
> >
> >
