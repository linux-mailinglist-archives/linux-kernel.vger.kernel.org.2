Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFA845886B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 04:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbhKVDp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 22:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhKVDp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 22:45:26 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753B1C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 19:42:20 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bi37so74228526lfb.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 19:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxe8DPCg+uafJ/sYNOrpF2h4ZTaoXE7DFoYKfcxFVJc=;
        b=A4e5EgXtmamYxQv6yZ/ZCAvXmGDN5/1xd2SQ3B1ZtTWIrwYSMiY2dwTWHNU/yfrZ/r
         922YWO9NzPP4rSY/meZSa4DDcRJBlOCDt9XJQp8n70/kgqGct7EVRlR5oPPau0/bQbOQ
         c2Qzr9hqLtb56Ur9j5LYCjOwvxWhvWNYE2chk2fWg8BMLj263W6IV8/sei2FtshM0Pe1
         cU/EVahx+AJaTSvANGXQM5oLuJ1yWF6uYXSWX4OJwY8Jx3TbpfwRerzkgpfm/ncMeg0V
         avM8N9TXei4WQQhJm+7C3Gd7uRzr0nRj4QRU5FhAtTjN06iy2MEyiiRAiLLuud32fTSE
         NXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxe8DPCg+uafJ/sYNOrpF2h4ZTaoXE7DFoYKfcxFVJc=;
        b=PKwrJE5xaBFkPgI/30EsfHR0MyQY0l9KcGdXHVx5rtsuWcEQuliEjK8Mv9FE4oOrdP
         Ot/4AgRxV2dHwqrDUhRtPWTnABqv3jA3wHrwVbBbzRCehPJ6RiLW4IoIAHURi8PNL1tU
         AMwEYchZ5/FO9jDlJu+VPhDqzV9SMVMrcCCosGzsDZaQt5oglK4UpEHWCyM110yG9vTk
         6zmcXfHnM8N9aACFn8eus04i0NCiwseec6oPFJM59iV07gKyfTgiXSft3Fjru4LrXOmh
         iRNUXVieKlK9X/jPgEI45KrYxGbP2QvV/0DmfD42pqJvjIP8STU/hs4+JQS3z8sYa91r
         xVEw==
X-Gm-Message-State: AOAM532dxgc0S1DS1/2kxqnRo+g+Aj58z+h20XmLcviRSR8qs4MrKLxz
        UxnkB7UlF3itfl8hAJGizKFZtbApQgPtJ4DA3oQeFg==
X-Google-Smtp-Source: ABdhPJy23l4y/hncWYk2gEzg4in48kfvM6Ei5MOm26/qaQptkxsqdIo+HuZYIpk001pCAo0twWk8DAfjSTjTaLkGOIg=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr46351182ljp.202.1637552538461;
 Sun, 21 Nov 2021 19:42:18 -0800 (PST)
MIME-Version: 1.0
References: <20211120201230.920082-1-shakeelb@google.com> <20211122005047.ufnyvqlqu55c5trt@box>
In-Reply-To: <20211122005047.ufnyvqlqu55c5trt@box>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 21 Nov 2021 19:42:07 -0800
Message-ID: <CALvZod6WmFBj9NUWoNMMJywJ3VtoxMkMX8-T9E+m2tP2e7Gtqg@mail.gmail.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 4:50 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
[...]
>
> Have you considered impact on short-living tasks where paying splitting
> tax would hurt performace without any benefits? Maybe a sparete madvise
> opration needed? I donno.
>

Do you have a concrete example of such short-living applications doing
MADV_DONTNEED? I can try to get some numbers to measure the impact.

Regarding the new advice option, I did give some thought to it but
decided against it based on the reason that we should not be exposing
some low level kernel implementation detail to users through a stable
API.

[...]
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 9d27fd0ce5df..a984bb6509d9 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1412,6 +1412,10 @@ struct task_struct {
> >       struct mem_cgroup               *active_memcg;
> >  #endif
> >
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +     struct list_head                *deferred_split_list;
> > +#endif
> > +
> >  #ifdef CONFIG_BLK_CGROUP
> >       struct request_queue            *throttle_queue;
> >  #endif
>
> It looks dirty. We really don't have options to pass it down?
>
> Maybe passdown the list via zap_details and call a new rmap remove helper
> if the list is present?
>

We already have precedence on using this technique for other cases but
let me take a stab at passing the list through zap_details and see how
that looks.

> >
> > +void split_local_deferred_list(struct list_head *defer_list)
[...]
> Looks like a lot of copy-paste from deferred_split_scan(). Can we get them
> consolidated?

I will see what I can do.

Thanks for the review.
Shakeel
