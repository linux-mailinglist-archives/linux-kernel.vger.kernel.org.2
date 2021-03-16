Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B0833CDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhCPGXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCPGWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:22:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D00C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 23:22:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so845260pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 23:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xHVFZ6ek9UWH6gJaYSFsmDxhb9ekTRVKDZq6Jazc5rQ=;
        b=pnrONYLdoVlRUvqukdeM+bXd8Ij3mjhE5t0V3KUkfpk/yrSbJMiTCr/S7UD0odUa02
         dWaR7hogUC6ysiqCkMkPEk2Rm3IVlquKQdHRqaOjcwbaGU5bYrQgZbR/QG+VhgyITwf6
         e/ragJyDp+NpS773hJSNltE3XoRaFmfNc8Iq8U25yWlB4aNnetpoVFz4yl7ETuoMnP83
         2M+UYJc9wZw4k2VjBiPyaeFI/Y9/7t/nEJhE31nhE3tiAMGH/f/B+TGq6ZdxRnsfEJnc
         y46UwmnnQfOkJuGmkcKJv5m/gRbBj8RETOssa7aTxyXocQ25FcQhbN+O8uXfxhn888eb
         XcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHVFZ6ek9UWH6gJaYSFsmDxhb9ekTRVKDZq6Jazc5rQ=;
        b=pQ81eg/zXjUs8lcuMR+jqcsgZ8UL1ItE/f2EAjnPEFsyVhkEKn5gKWyJf/xv5eh+6G
         6QlsOtHZbwarbOWVk4xtf912hUnLYSYSX0A0RYVKO/W5d5oJf4sHLRTHwbsGX1I80fPz
         a3K1FICEFwTBepxI1ewnnXjXJXtOo2wtdRsLUa364/xL8PxL58rW3wE60PGriArtXSfs
         7lex4nZ4yEqtI5rJa8eem1uNnyJFQ4fDU+C4YalSoO+FvM/z+azy299o83QdxKAV0VQD
         R4+JTjU9SINqVV70lFaNBa9aObliVjHyAMlS6oe0I/Lj4k2ZeTfwkUOLImwKNpVOvUuK
         ovmA==
X-Gm-Message-State: AOAM532dRekG81YuJ/B0zjHf3s1CN72OleWVh17HKURStd2Ud0z8exnD
        drDV+3BAJv8ZpTXXT6kAppCWgV7dg+GPZQZkznmDag==
X-Google-Smtp-Source: ABdhPJzwigYVXz2vofcgYR8WF6McxMTqCfCE2w04XtmytRTQbUcrh1yt1B0vcVv1/ZkImkLny9NzW7QBJVGP8TQlx/s=
X-Received: by 2002:a17:90a:ce0d:: with SMTP id f13mr3153239pju.85.1615875758578;
 Mon, 15 Mar 2021 23:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210316041645.144249-1-arjunroy.kdev@gmail.com>
 <CAOFY-A1L8c626HZYSWm6ZKFO9mqBdBszv6obX4-1_LmDBQ6Z4A@mail.gmail.com> <CALvZod7hgtdrN_KXD_5JdB2vzJzTc8tVz_5YFN53-xZjpHLLRw@mail.gmail.com>
In-Reply-To: <CALvZod7hgtdrN_KXD_5JdB2vzJzTc8tVz_5YFN53-xZjpHLLRw@mail.gmail.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Mon, 15 Mar 2021 23:22:27 -0700
Message-ID: <CAOFY-A0v2BEwRinhPXspjL_3dvyw2kDSyzQgUiJxc+P-3OLP8g@mail.gmail.com>
Subject: Re: [mm, net-next v2] mm: net: memcg accounting for TCP rx zerocopy
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Arjun Roy <arjunroy.kdev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 9:29 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Mar 15, 2021 at 9:20 PM Arjun Roy <arjunroy@google.com> wrote:
> >
> [...]
> > >
> >
> > Apologies for the spam - looks like I forgot to rebase the first time
> > I sent this out.
> >
> > Actually, on a related note, it's not 100% clear to me whether this
> > patch (which in its current form, applies to net-next) should instead
> > be based on the mm branch - but the most recent (clean) checkout of mm
> > fails to build for me so net-next for now.
> >
>
> It is due to "mm: page-writeback: simplify memcg handling in
> test_clear_page_writeback()" patch in the mm tree. You would need to
> reintroduce the lock_page_memcg() which returns the memcg and make
> __unlock_page_memcg() non-static.

To clarify, Shakeel - the tag "tag: v5.12-rc2-mmots-2021-03-11-21-49"
fails to build on a clean checkout, without this patch, due to a
compilation failure in mm/shmem.c, for reference:
https://pastebin.com/raw/12eSGdGD
(and that's why I'm basing this patch off of net-next in this email).

-Arjun
