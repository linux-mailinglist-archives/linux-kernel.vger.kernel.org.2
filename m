Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AA535A230
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhDIPnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:43:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93222C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 08:43:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g17so6601139ejp.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOQBkcBExWdOzHh9ROtfbTcad8EXL0NpCgTPDC8YVU0=;
        b=jHvR2b2XusmZqh290V+djJWa1Nxfumd3xyxS5ELiMJ/K0garq58cL8wPCxGzOxQc+1
         f80QRSasdCvuaThHV6SywIF5ulzIzkl/PG83/Ev3BiezWm6AbIGBENwu3NKNJDAE55cb
         d+cl55dvnuuraoikehq4GnljwZ8YGdtAIJLOU451Nelo/mmp1xs4konHZZC8T9wybYly
         8W05xf7jteaDKqyX7+Xt3Bc9Wo2gm24tDPc1ZZjLc1sXhBP56RPcufLHhMY8THHGXvGl
         YQYTkHBD0V2RGkYy28dzGrAu81XpAH7uAVE9GE++JahdYYj+0gD6jfehXgT4cn4KMp4x
         HWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOQBkcBExWdOzHh9ROtfbTcad8EXL0NpCgTPDC8YVU0=;
        b=fBYQ52aL5P9gtd0uKzTesqrYrVsCDtwanW1FALDK++4ey8/qwE1dpzaPTtostfRBM2
         qdjOmkrUWSDKOQRz49gnz7m7vPNdB45xW4omksD9PGbgfHT6rfvrrwc1bclGM44TcBKb
         BnffndLAJEgrX1iYK3ziJ4PUQEM5W2OOGOJccq/N1uxu7l+B3EyDC9yh1fV2D4y2LjQX
         JAwfaXF2KRf3NowbZFyP4Ml7QD88MKHv4T9rHazf+SR68HOGJyOISlITKJ6odKbrx455
         j+nJ+bwo0Ji2B0T0DkjHlgc5Ad0QYTiMUBCuvh7CAr+8B9gUaSOamEnIXy9GP9FsDN9L
         edIQ==
X-Gm-Message-State: AOAM5323qZefSDNhHGREZdGGFb32YA7bj59VdZXMoUF7FTD0Ry+YtBEi
        zYudFudTTYkPK8N4p9jU8ZL5O0a34EZtnZ3vheM=
X-Google-Smtp-Source: ABdhPJxSRZFTfTZiEzUO2PcNytVm0YBqn2asyhjN/KVvOFgcYRdNlRK3rpo3nI4jFY4MyLWiNa/LP2FQSddharx7mAI=
X-Received: by 2002:a17:906:4bce:: with SMTP id x14mr16335453ejv.383.1617983009301;
 Fri, 09 Apr 2021 08:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183223.80F1E291@viggo.jf.intel.com>
 <YG7XjTG9tiK29y1j@localhost.localdomain> <CAHbLzkqoaSnuBJMAe_heQt01FuPWODYQHJ955gaJNNojwbUjrw@mail.gmail.com>
 <YG9IthpDC/lri4Qh@localhost.localdomain> <CAHbLzkqt0_xM=rAaNiSwKn=kY=wmWiFe3N+CEuqH_ryU-o1ysQ@mail.gmail.com>
 <YG/g49rCrId0ALra@localhost.localdomain>
In-Reply-To: <YG/g49rCrId0ALra@localhost.localdomain>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 9 Apr 2021 08:43:17 -0700
Message-ID: <CAHbLzkr0AWWNMJ6i1551m75YfsVwdYuhLbW8sZqW_M-iH8vpBw@mail.gmail.com>
Subject: Re: [PATCH 04/10] mm/migrate: make migrate_pages() return nr_succeeded
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, weixugc@google.com,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 10:06 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Apr 08, 2021 at 01:40:33PM -0700, Yang Shi wrote:
> > Thanks a lot for the example code. You didn't miss anything. At first
> > glance, I thought your suggestion seemed neater. Actually I
> > misunderstood what Dave said about "That could really have caused some
> > interesting problems." with multiple calls to migrate_pages(). I was
> > thinking about:
> >
> > unsigned long foo()
> > {
> >     unsigned long *ret_succeeded;
> >
> >     migrate_pages(..., ret_succeeded);
> >
> >     migrate_pages(..., ret_succeeded);
> >
> >     return *ret_succeeded;
> > }
>
> But that would not be a problem as well. I mean I am not sure what is
> foo() supposed to do.
> I assume is supposed to return the *total* number of pages that were
> migrated?
>
> Then could do something like:
>
>  unsigned long foo()
>  {
>      unsigned long ret_succeeded;
>      unsigned long total_succeeded = 0;
>
>      migrate_pages(..., &ret_succeeded);
>      total_succeeded += ret_succeeded;
>
>      migrate_pages(..., &ret_succeeded);
>      total_succeeded += ret_succeeded;
>
>      return *total_succeeded;
>  }
>
>  But AFAICS, you would have to do that with Wei Xu's version and with
>  mine, no difference there.

It is because nr_succeeded is reset for each migrate_pages() call.

You could do "*ret_succeeded += nr_succeeded" if we want an
accumulated counter, then you don't have to add total_succeeded. And
since nr_succeeded is reset for each migrate_pages() call, so both vm
counter and trace point are happy.

>
> IIUC, Dave's concern was that nr_succeeded was only set to 0 at the beginning
> of the function, and never reset back, which means, we would carry the
> sum of previous nr_succeeded instead of the nr_succeeded in that round.
> That would be misleading for e.g: reclaim in case we were to call
> migrate_pages() several times, as instead of a delta value, nr_succeeded
> would accumulate.

I think the most straightforward concern is the vm counter and trace
point in migrate_pages(), if migrate_pages() is called multiple times
we may see messed up counters if nr_succeeded is not reset properly.
Of course both your and Wei's suggestion solve this problem.

But if we have usecase which returns nr_succeeded and call
migrate_pages() multiple times, I think we do want to return
accumulated value IMHO.

>
> But that won't happen neither with Wei Xu's version nor with mine.
>
> --
> Oscar Salvador
> SUSE L3
