Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1A4118D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242309AbhITQFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:05:30 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:37485 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242287AbhITQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:05:29 -0400
Received: by mail-vs1-f41.google.com with SMTP id q66so11707054vsa.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dMifcbnkfSRVe/bi5rOjd4ROjtJjArQaEcU6dV9IRM=;
        b=aptUPUcr400c/8oUAfyBwb+N74h6PJN9sKyXwxGiz1HSpSXts9FIhA7DGVivsYUsdj
         eKzxCAhSZo5e3ypd0P1SpHnZqL5HJE9gqMcqpVcwmfA9dFQLM7tfeQzXeE8PQux21Aw3
         t9t1GZko5S6k9c1+m+0M3McOjaYZB+BHF/aFovWwMasLmF2ddEC7j0Br/5lB5UaIYhp2
         E5TqQ5HrQmeqbCX6POZMBiW2qYV2m+daWqzcauHreoW/KjV7N4DGqDR3MKvMFk9Q6xab
         rmHZeMmvWejnKDUqlO/3zmIBrVXvK9EOotwkMzvI8AkVx9tPIn46mWN1PGLeez1hh4yv
         v6fw==
X-Gm-Message-State: AOAM533FE/uxO4OhErIdFoi3YF5bn3mJ3/U/3BQlz9DQCkLqjIDWgBpr
        gPRUNnb9PvfKN+oL/W6MqQACg+Vp5+4Op7bmGKE=
X-Google-Smtp-Source: ABdhPJx2uraiUOErFyJzXCe29wH/9CtnJzCdNfo89F3RZy1TJcNLDQmozi8h7VqjlVlyhgUEQ3q1hFky3vmS0tcBgY0=
X-Received: by 2002:a67:cc1c:: with SMTP id q28mr15980655vsl.37.1632153842016;
 Mon, 20 Sep 2021 09:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com>
 <dfa20866-0d00-9bd3-6078-5544cfa5b633@sr71.net> <CAMuHMdUUfm6u_Pz3qzA0V7tLZd7jhcwdyxU7L0SyC_EdyzwQxw@mail.gmail.com>
In-Reply-To: <CAMuHMdUUfm6u_Pz3qzA0V7tLZd7jhcwdyxU7L0SyC_EdyzwQxw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Sep 2021 18:03:50 +0200
Message-ID: <CAMuHMdVtHDQ2f0VKAdQFQV9dZJ5uFGD9yHvNviQ_k7AEfhN77w@mail.gmail.com>
Subject: Re: IMPORTANT: CIVS opt-in for Technical Advisory Board voting
To:     Dave Hansen <dave@sr71.net>
Cc:     Laura Abbott <laura@oxidecomputer.com>, ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 5:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Sep 20, 2021 at 5:37 PM Dave Hansen <dave@sr71.net> wrote:
> > My @linux.intel.com account is the most common one from the git logs.  I
> > have only received one TAB-related email there:
> >
> >         Subject: Upcoming Technical Advisory Board election -- look for
> >                  your ballot
> >
> > However, I never actually received a ballot at that email, presumably
> > because of this CIVS opt-in issue.
> >
> > Was this just me?  Or would it be appropriate to send these opt-in
> > instructions to all of those that should have received a ballot instead
> > of just sending to the mailing lists?
>
> I did the CIVS opt-in, and entered the confirmation number.
> Still, unlike Vlastimil, I saw no way to vote?
> Just retried the opt-in, "already opted-in".

If you use multiple email addresses, make sure to opt-in using the exact
same one on which you received the original email from Laura.
Then there will be a link to the actual poll after entering the confirmation
code.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
