Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937F93922EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhEZWua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhEZWua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:50:30 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:48:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so2607692otg.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gyEju9+TLZeZG3bChNms/qB8ZByEtpBtdp/UD5bEjms=;
        b=shqvBt5Sb2Ed6AByKZFJbS/YbN1VytHSP2SUnnk6+LSKCi9dmvX7FPbiNmM+g0tWjm
         APBVu9ZANOLb81FOOxUxxC+uyCRO0bvnQEp3Qmkg1nLinEz5YKypgiy5eLtwtI7FbQrm
         ZW4ZALCWmzvHI7qeogV4u93jCk+a8VpIpE25ejPVAFo1gUERnsPFweUtHfg8k4ggktTR
         0JHkXvqReQS10W/AcISkgmaZ0oky8376Uil/p5Bg/QJIaqdLrihKNQcCSz65FuVu/R9z
         KjGnCk3BdJ5hWCDdeIplfwhrtr8C9C0Fe6vs2TgY/LyT6dFO5iJF4P3V8ODNL3Z5g07N
         MRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gyEju9+TLZeZG3bChNms/qB8ZByEtpBtdp/UD5bEjms=;
        b=Se8oJLrAPjTGuY+VnmYv6Xt7LfUbQrbMkzRDqKB5oF6M+WArJ1T1ZftY+GmjFR6axu
         CkM9ACY7BrfAyYA8QX2JQ47r0s6SIcjTJM5eR+8+v34HtflpEpY4St9As7RJgUelt2pa
         28EFPo2mN8jnfzMef/w5qPIwq6NV48jnX2bgYsDKYrDbwWRrUzWfaupMeUj8YMr0S7Pp
         TF35QKqTptXO6mi6MPVP3yYw7412zJlyKORAROeBpxgkkZgvyNzqlxvPg/MMP5ElAndc
         iqs+T6ruXGPLOyzkv+wngWss8ancxVjtUclNFP90ZjQoz8E6MVCFUKAD6K+PVT80Fm49
         IiAw==
X-Gm-Message-State: AOAM531gia1MvbeeAlvPkD2rU3LRTaepZgJQwOQweOYgY9AHbf2JgX0x
        A21cWLBgNgORClXFqcMaDtuI7A==
X-Google-Smtp-Source: ABdhPJzEvs6hgK43/zXNsYfnGCoiH/2u9UfsIZWcd3jP1iMMOEp4GSTuKSKVcn5Q8ExAJqOeJBp0mw==
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr450099oti.23.1622069336275;
        Wed, 26 May 2021 15:48:56 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m66sm133009oia.28.2021.05.26.15.48.55
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 26 May 2021 15:48:55 -0700 (PDT)
Date:   Wed, 26 May 2021 15:48:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?Q?HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3_=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>, Wang Yugui <wangyugui@e16-tech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/2] mm: thp: check page_mapped instead of page_mapcount
 for split
In-Reply-To: <CAHbLzkrmtw-GFEW2zmik6y0R8JjpB4T1hnfYf9O8kz5Zqrr4RQ@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2105261523250.16407@eggly.anvils>
References: <20210525162145.3510-1-shy828301@gmail.com> <20210525162145.3510-2-shy828301@gmail.com> <alpine.LSU.2.11.2105251412140.2003@eggly.anvils> <CAHbLzkqs32HkRiAoQeSv2ik9fBYmdhwUFq5vWkcs7PY0rUu2fA@mail.gmail.com> <alpine.LSU.2.11.2105251643320.2804@eggly.anvils>
 <CAHbLzkrmtw-GFEW2zmik6y0R8JjpB4T1hnfYf9O8kz5Zqrr4RQ@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021, Yang Shi wrote:
> On Tue, May 25, 2021 at 4:58 PM Hugh Dickins <hughd@google.com> wrote:
> > On Tue, 25 May 2021, Yang Shi wrote:
> > >
> > > We should be able to make dump_page() print total mapcount, right? The
> > > dump_page() should be just called in some error paths so taking some
> > > extra overhead to dump more information seems harmless, or am I
> > > missing something? Of course, this can be done in a separate patch.
> >
> > I didn't want to ask that of you, but yes, if you're willing to add
> > total_mapcount() into dump_page(), I think that would be ideal; and
> > could be helpful for other cases too.
> >
> > Looking through total_mapcount(), I think it's safe to call from
> > dump_page() - I always worry about extending crash info with
> > something that depends on a maybe-corrupted pointer which would
> > generate a further crash and either recurse or truncate the output -
> > but please check that carefully.
> 
> Yes, it is possible. If the THP is being split, some VM_BUG_* might be
> triggered if total_mapcount() is called. But it is still feasible to
> print total mapcount as long as we implement a more robust version for
> dump_page().

Oh dear. I think the very last thing the kernel needs is yet another
subtly different variant of *mapcount*().

Do you have a specific VM_BUG_* in mind there?  Of course there's
the VM_BUG_ON_PAGE(PageTail) at the start of it, and you'd want to
print total_mapcount(head) to avoid that one.

Looks like __dump_page() is already careful about "head", checking
whether "page" is within the expected bounds.  Of course, once we're
in serious VM_WARN territory, there might be races which could flip
fields midway: PageTail set by the time it reaches total_mapcount()?
Narrow the race (rather like it does with PageSlab) by testing
PageTail immediately before calling total_mapcount(head)?

Hugh
