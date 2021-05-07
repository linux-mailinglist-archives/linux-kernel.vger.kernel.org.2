Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C627837614C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhEGHky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhEGHkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:40:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D42C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 00:39:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z13so11509906lft.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smY86Lmu3R2wzXg9lSwn24IGK7EQT0GTkAK1YtXOofw=;
        b=HdZaIFSzvUfviaklz1QMJMOLRkfx+w7WAl6Cr+YdO+UzFif+9z6/XVqc8zSbOkDmv4
         9anyW7cvVMEZU6TIwdAtuUAlsQQYyZMiTZMuEZna5wDCJUHFeMriZdccreUB0dlU0Czx
         1SXMnhllfilxm0UtC29YOkpHy9FeRdjn1z9wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smY86Lmu3R2wzXg9lSwn24IGK7EQT0GTkAK1YtXOofw=;
        b=hCAbpqLsaRhV62iswuHicbnFxj7G0NSUMVfCQJ6jPubM3i71fEgOykDR9iKaQawHsh
         zoGQnXgh3mHohQ9hR6SIKEIv/A+mF+xPybdbUe2dy5zA3B0trNHiLPFXubJ4okVgz/MT
         ce6JgD6Rrtpv+0hTTtfgaUS6iTgirftv+QOqjMtf+7+nyNnZItQIXbnutYhio8wmTuYP
         ksWHztDKpdPIG8oZHrx+t2DwnMDl/U8RJKuTIrwpV0VFgANsh+DVEs2K4qCKuvI/qC8k
         9qudpCzwE2IKlIBvw6PBsMpd0wRUkqU2yyE+FIwxCg8NJ83pp0HQ0zMz9tgRZ+i1W5ew
         JM9w==
X-Gm-Message-State: AOAM532Qgb2+HF/2c00nNDM28yTP16bSQMHZE3QYr7pkXd6KGJ++NsYv
        YKYBVnMBUMs0IAZuXYE0FwiQHK9BqrVjPaSoNgo=
X-Google-Smtp-Source: ABdhPJxH45VN9Ycep4TihwC+C0U/Hgyznp5Gh/88HpxAT1M9GHaHmmwzhB842d+lWvxMqwYWXRfoJQ==
X-Received: by 2002:ac2:5471:: with SMTP id e17mr5428587lfn.630.1620373192589;
        Fri, 07 May 2021 00:39:52 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id h7sm1296912lfu.199.2021.05.07.00.39.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 00:39:51 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id u25so10361469ljg.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:39:51 -0700 (PDT)
X-Received: by 2002:a05:651c:1311:: with SMTP id u17mr6448216lja.48.1620373191134;
 Fri, 07 May 2021 00:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210506232537.165788-1-peterx@redhat.com> <20210506232537.165788-4-peterx@redhat.com>
 <69055843-185d-20ea-213b-10494a2f7246@nvidia.com>
In-Reply-To: <69055843-185d-20ea-213b-10494a2f7246@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 May 2021 00:39:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDXxQyzcJ6Xy1t8-4R0uqcanfSYetLoMNeKUTPdCNL0w@mail.gmail.com>
Message-ID: <CAHk-=wiDXxQyzcJ6Xy1t8-4R0uqcanfSYetLoMNeKUTPdCNL0w@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: gup: pack has_pinned in MMF_HAS_PINNED
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 11:43 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> +static void set_mm_has_pinned_flag(unsigned long *mm_flags)
> +{
> +       /*
> +        * Avoid setting the bit unless necessary. This matters a lot with
> +        * large SMP machines.
> +        */
> +       if (!test_bit(MMF_HAS_PINNED, mm_flags))
> +               set_bit(MMF_HAS_PINNED, mm_flags);
> +}

Yes, please do split it up like this.

But please make it explicitly inline, and move the comment to above
the function.

And add the important key part to it: that the bit is never cleared.

That idempotent behavior of the "set_bit()" is what makes it safe to
do this non-atomic test-and-set (yes, the "set_bit()" itself is
atomic, but the sequence above is not).

Side note: we do have a few other places where this kind of thing
happens, so it *might* make sense to even make this a generic pattern
in case somebody can come up with a good descriptive name for that
("set_bit_if_not_set()" sounds descriptive, but the subtle
non-atomicity should probably be part of it).

> +       if (flags & FOLL_PIN)
> +               set_mm_has_pinned_flag(&mm->flags);
>
> ...which is now very readable, once again.

Yes, that does look much better.

Thanks,

              Linus
