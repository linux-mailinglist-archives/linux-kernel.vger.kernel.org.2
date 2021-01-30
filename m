Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9E530933A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhA3JWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhA3JVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:21:39 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56497C0617A9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 00:09:22 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y19so11931920iov.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 00:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pF2wojN9gGVpEFLc3F0it5xrHpu2kN/KdpA0MJ6RRs=;
        b=fnhBSwX5/funsUDXajW4rsV1DPuOtzdpPVFrrcZ7ZMfWXoAeoHwqG62GCWubZMAoO/
         WVsQkz/fgBe0lB+kjGwAn7NC3ZTrpr/1JqvAhuckNwCOVDVaOxgVteTivcXu/VfyV+HB
         xV2sdAnYnK6XNxLyHR+flGg3Rxu9hokL4Out5EHGPEVJIFxVmEe/J+BTEHO1UkcFHWpH
         5WmzqOWwKTych2E0F1xSAv3Gcg6r46sR1xGhprCCB5DUpXn9A5++f0m94sbx48b+Qn4i
         0tpIonQC0LaZFGZslUb9q59oqeRK6WHOoLDpSkLxGBXs97FqtbU1X5MbERrR4jq3WxS4
         obrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pF2wojN9gGVpEFLc3F0it5xrHpu2kN/KdpA0MJ6RRs=;
        b=Nh+VFXVElrfONV/ZBExTSjEYZXmbRJm2EC1O1lqzUtOZM+SZFple7UDRlErdk+K8fk
         0MeDeGvdYwBQvE5LNMpwc9sfO4m94wVgTHkcKQBqBDZypAcpoeQ1m2VeFzOMilFFuEyA
         lQb8r3CItktd1Z+MJ5z4AfWqudU4MOvtAu9sDMIIoeMZB22idhvoqz9qCQmLXLS2LkNK
         V9CHMTJPeGa/ZS6SNC8HXLUftI9BMB2pKR+ilEicXtF1/VGFtF/dpBQ5Jo6KysWZYn7e
         vo4KMrJcKl1saLBUNC64rzjBH+4IwPBDCS6idqLML0q3N9THaS/iHBBrC/MUYhMJ2n4k
         bgDA==
X-Gm-Message-State: AOAM531fcITnxHKsR3+JqVa8nEpwkX+51qB/RImKlzNmTgyeQ4Ewag9q
        RDwNaflKRBE3h4l9Kie3uodC2FGXMaXGz+y5Lwu1QVFjOnw=
X-Google-Smtp-Source: ABdhPJzcXsnhwrs8IODBKuA1fG8zEHE9zE9u9Tep93UhkLINan8bZibM1PZuW7Lqh3yLrlxyHgcrmC28NFD25q1CXUY=
X-Received: by 2002:a05:6602:2053:: with SMTP id z19mr178334iod.86.1611994161568;
 Sat, 30 Jan 2021 00:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20210115170907.24498-1-peterx@redhat.com> <20210115170907.24498-22-peterx@redhat.com>
 <CAJHvVcg4tjgRis=WF77phGC6Xm=DBo1W5pDa_d0ZP-Df1VXRxw@mail.gmail.com> <20210129223129.GB260413@xz-x1>
In-Reply-To: <20210129223129.GB260413@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Sat, 30 Jan 2021 00:08:44 -0800
Message-ID: <CAJHvVcjaLW23z9yJeSQR=R3PuRFEzWEHmOBkMiLEaYFnQ0OuuQ@mail.gmail.com>
Subject: Re: [PATCH RFC 21/30] hugetlb: Pass vma into huge_pte_alloc()
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 2:31 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 28, 2021 at 02:59:13PM -0800, Axel Rasmussen wrote:
> > > +pte_t *huge_pte_alloc(struct mm_struct *mm, structt vm_area_struct *vma,
> >
> > This was pointed out to me just after I sent v3 of my series today
> > (which includes this patch):
> >
> > Typo, s/structt/struct/.
>
> Thanks Axel - fixed here too.  It's strange why it didn't complain.
>
> Re the minor fault series, I thought it would be good to have some comment from
> Andrea/Mike or others, but in all cases I'll read your v3 next week.
>
> (A small heads-up: you'd better use v3.1 next time for that single patch, so
>  that just in case there will be a complete v4 series then that patch won't
>  collapse with it)

Thanks!

And, I'll keep that in mind for next time. I had seen it done that way
before, but it slipped my mind.

>
> --
> Peter Xu
>
