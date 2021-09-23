Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C627416398
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhIWQt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242378AbhIWQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:49:51 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C803EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:48:19 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id m4so7292363ilj.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxbhH0FBrH9RlY3GCWj3vHyXUDd29e30TtZJPUe9Ibk=;
        b=Jtq5H3GPyNn1265DoS44A3ihlFLvNyoVn26DSAjKcXA5NWsF0vQTPeiBtAZfRATOs5
         jMymN/ac1DO84W/iNoDVqKiAMC/zRn2Q9pXKhqvnc6+gJKIOYF8Eba//Ff9BEsc5sRek
         AajE1ciWtVU6f2qfm7WHD6gOnMM140hHMC0MsK+iP/WudBEaWtXSlOKAWoye30bO0gWv
         SjQ6NjfKPtmCwF5Fpxrc3zQH5nYHbEI84ttOgBSmOAcYEcvxofxXTBjuUxpchm6a3JGp
         +wOIm3osaUk1Gb1wrt9BQpOZH6/aMFtYBqQUydlXMPJM1nhm1IVN9b6khmq5+GOkqCdw
         bC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxbhH0FBrH9RlY3GCWj3vHyXUDd29e30TtZJPUe9Ibk=;
        b=PRea8JjJC1JcxqSJYFpWDgIf1k6ghITf+f2m7IBb2s0KsEfeT73tWNEblK8O8kue8t
         3vYsI1utiG3IJE0Lvg+6f4SYC/XXZgwez+kE4L3Jb8sGgN05KyqoceNNBFfD7nGnwZJ/
         agkf02M/66zgKqxz1A+NJXUPqLtjYZsPT7JnBB1a7P1L9NIKyFmJmQT7kBfTz2aCUjG9
         YIcqtJIZYD4Fd7IyyKjkvrEH6M8nG+UV5Y2G22q0ckDmBmpweHJT9WkTaPbAnEt2wTKc
         8eRaxw7FnFY2Y8se7ivX/QFp+Ez4oU35uCJvnP2YFb6TldMhGQulHB2RKK+/usyPvSBr
         8vHw==
X-Gm-Message-State: AOAM532L8ZaipU5v9BxK/qsu2ZrXK5lnJtlLSVVRX32Vu81Jx5wYSrwI
        wBBpTbvnHVsjX3IWfEnF3y1PXoeSMVoyfhGfDUaeJA==
X-Google-Smtp-Source: ABdhPJyNLcJWJ4cf4hRRACEbrYhFMbPyl9v2GI1tCWXExlcI87+rVJkMusdSUtoWRAIYRhGKEpZ/eZeyzBVkt5ln8IQ=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr4397642iln.275.1632415699032;
 Thu, 23 Sep 2021 09:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210922175156.130228-1-peterx@redhat.com> <CAJHvVch3g_UY-akMdu0O9413iCb1H83DLhR1Am8WnfUyV=s1=g@mail.gmail.com>
 <YUueOUfoamxOvEyO@t490s> <24224366-293a-879-95db-f69abcb0cb70@google.com>
 <YUu/6lWX92WLUzpt@t490s> <472a3497-ba70-ac6b-5828-bc5c4c93e9ab@google.com> <YUvj9r3Y954pYPnf@xz-m1.local>
In-Reply-To: <YUvj9r3Y954pYPnf@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 23 Sep 2021 09:47:42 -0700
Message-ID: <CAJHvVcg=oQBcuFjT_RO-_0VMtmyTzkzmUaUv0-zX42CnRWbBAg@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 7:18 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Sep 22, 2021 at 06:22:45PM -0700, Hugh Dickins wrote:
> > No, I think I misunderstood you before: thanks for re-explaining.
> > (And Axel's !userfaultfd_minor() check before calling do_fault_around()
> > plays an important part in making sure that it does reach shmem_fault().)
>
> Still thanks for confirming this, Hugh.
>
> Said that, Axel, I didn't mean I'm against doing something similar like
> uffd-wp; it's just a heads-up that maybe you won't find a reproducer with real
> issues with minor mode.
>
> Even if I think minor mode should be fine with current code, we could still
> choose to disable khugepaged from removing the pmd for VM_UFFD_MINOR vmas, just
> like what we'll do with VM_UFFD_WP.  At least it can still reduce false
> positives.
>
> So far in my local branch I queued the patch which I attached, that's required
> for uffd-wp shmem afaict.  If you think minor mode would like that too, I can
> post it separately with minor mode added in.

No worries, you can leave the minor fault case to me.

My thinking there was a THP collapse bug was really just based on
speculation, not a real reproducer, so it's very possible my
speculation was wrong. It will take some more thinking and reading to
convince myself one way or the other. :) Thanks to you and Hugh for
all the details.

I'd prefer not to add this fix "just in case", if it isn't a real
problem, as it seems like it may confuse future readers of the code.

I'll send out a patch for it if / when I manage to build a real
reproducer. Or, in the meantime, some of my Google colleagues are
testing this code via their live migration implementation, so if there
is a bug here there's a good chance we'll find it that way too.

>
> Note that it's slightly different from what I pasted in reply to Yang Shi - I
> made it slightly more complicated just to make sure there's no race.  I
> mentioned the possible race (I think) in the commit log.
>
> Let me know your preference.
>
> Thanks,
>
> --
> Peter Xu
