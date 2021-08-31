Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2657F3FC864
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbhHaNj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbhHaNj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:39:26 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B297C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:38:31 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 107-20020a9d0bf4000000b0051b8be1192fso12586223oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpdFht62uo2CCaSdrBMwUxa75j2wFEslp4y6a2jyOdg=;
        b=tVVKheBrg5j0/juS4Wq1fkSh3AA/f2e/Ie0jHN1ukJGtPV839OhYVHuzAw/xpqzyC8
         3HlgEeLya+Bqi1UvwCa6oNoCf6Z7I6IaFpVtJ//qz2FvYGJyAlTPDflMYNC96EnIVtDQ
         P2IFfpPxPuRKv1uoUeXIuJQhliRrTaxHooiPxmMq+xnVJ9SPqPAH30ViXYoDrayp6mbU
         0L1T1U7pceqXuGmb+3maLwHS38FAy9EVpm1j08EiJPcbEP+4FEGYkNpr1v04zyoOLxyI
         nHLLWJQkMPHjw4RGzMiCJ1eJlAtryqSW5JGjjBizd5x2cgWFTuYcOvhbDbxKlEbzRUX8
         /+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpdFht62uo2CCaSdrBMwUxa75j2wFEslp4y6a2jyOdg=;
        b=LMYPzG+CAoDjFN9hwUcCq7om7VMC4BvSTnYXAmhFzFaZWBz1gixII/7mso3ftFJHCA
         qYZfqjkZ04VCI6ssFibjWMvDyXGbDlV5KP+D0GXxZ6cOqqmJSksfYk+gWv90b/sEnOa8
         wR+5tFID58BHSxpJtI+Z3YxVSZSIb3RuiDXZQIIIKOEQjxl1ghWmQAFoqbYIN/IMsa46
         DSdAvZrCB9DV61c05j/4mU/9jlfmUzegSIYZxwfNqRYA/1iyn2vw7l0ZRAa772Op9o42
         zxoI67cG8W5OMecYl6kHIDt5L1oenFtTt8XR0y/ZuXVhg1bd7Kx9GhBTi2MPZat/N+qJ
         KQBQ==
X-Gm-Message-State: AOAM533LFYxFZgsmKJx8T6uXMdiBO8Y0KlwKMZZnyCFbNKOlv8m/yFAI
        jh2rzDUcNrw0qu8lZfhoW/6BN+9Z8OvAkVC7p89HGw==
X-Google-Smtp-Source: ABdhPJxxgzLM2LzRcnGtoqEz96FJujfIni00TmQjFNW7SfT+qJBz80HlHGbUjWf6JBrBuvSgAAw/fNA9THFKe6Jb8sE=
X-Received: by 2002:a05:6830:3114:: with SMTP id b20mr24466026ots.17.1630417110385;
 Tue, 31 Aug 2021 06:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210826144157.GA26950@xsang-OptiPlex-9020> <20210827154232.rrpetqsh5xxklkej@box.shutemov.name>
 <20210831131313.GC31712@willie-the-truck>
In-Reply-To: <20210831131313.GC31712@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Tue, 31 Aug 2021 15:38:17 +0200
Message-ID: <CANpmjNOEstBLc9tbofcM=hfkYsmQFLBzq3i=L58fPpgg1vHgPw@mail.gmail.com>
Subject: Re: [mm] f9ce0be71d: BUG:KCSAN:data-race_in_next_uptodate_page/next_uptodate_page
To:     Will Deacon <will@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        kernel test robot <oliver.sang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 at 15:13, Will Deacon <will@kernel.org> wrote:
[...]
> > > +------------------------------------------------------------------------+-----------+------------+
> > > |                                                                        | v5.11-rc4 | f9ce0be71d |
> > > +------------------------------------------------------------------------+-----------+------------+
> > > | BUG:KCSAN:data-race_in_next_uptodate_page/next_uptodate_page           | 0         | 19         |
> > > | BUG:KCSAN:data-race_in_mark_page_accessed/next_uptodate_page           | 0         | 17         |
> > > | BUG:KCSAN:data-race_in_next_uptodate_page/page_memcg                   | 0         | 13         |
> > > | BUG:KCSAN:data-race_in_next_uptodate_page/unlock_page                  | 0         | 13         |
> > > +------------------------------------------------------------------------+-----------+------------+
> > >
> > > [  184.717904][ T1873] ==================================================================
> > > [  184.718938][ T1873] BUG: KCSAN: data-race in next_uptodate_page / unlock_page
> > > [  184.719828][ T1873]
> > > [  184.720103][ T1873] write (marked) to 0xffffea00050f37c0 of 8 bytes by task 1872 on cpu 1:
> > > [  184.721024][ T1873]  unlock_page+0x102/0x1b0
> > > [  184.721533][ T1873]  filemap_map_pages+0x6c6/0x890
> > > [  184.722102][ T1873]  handle_mm_fault+0x179c/0x27f0
> > > [  184.722672][ T1873]  do_user_addr_fault+0x3fb/0x830
> > > [  184.723263][ T1873]  exc_page_fault+0xc3/0x1a0
> > > [  184.723845][ T1873]  asm_exc_page_fault+0x1e/0x30
> > > [  184.724427][ T1873]
> > > [  184.724720][ T1873] read to 0xffffea00050f37c0 of 8 bytes by task 1873 on cpu 0:
> > > [  184.725575][ T1873]  next_uptodate_page+0x456/0x830
> > > [  184.726161][ T1873]  filemap_map_pages+0x728/0x890
> > > [  184.726747][ T1873]  handle_mm_fault+0x179c/0x27f0
> > > [  184.727332][ T1873]  do_user_addr_fault+0x3fb/0x830
> > > [  184.727905][ T1873]  exc_page_fault+0xc3/0x1a0
> > > [  184.728440][ T1873]  asm_exc_page_fault+0x1e/0x30
> > > [  184.729027][ T1873]
> > > [  184.729313][ T1873] Reported by Kernel Concurrency Sanitizer on:
> > > [  184.730019][ T1873] CPU: 0 PID: 1873 Comm: systemd-udevd Not tainted 5.11.0-rc4-00001-gf9ce0be71d1f #1
> > > [  184.731103][ T1873] ==================================================================
> >
> > Line annotation would be helpful.
>
> Agreed.
>
> > And I'm not very familiar with KCSAN. My guess it reports PageLock() vs.
> > clearing PG_locked. In this context it looks safe, unless I miss
> > something.
>
> The access in clear_bit_unlock() is annotated as a full sizeof(long) atomic
> write, so we could be racing with a non-atomic read of another bit in the
> page flags but I can't spot where that happens before the trylock_page() in
> next_uptodate_page().
>
> > Do we need some annotation to help KCSAN?
>
> clear_bit_unlock() is already instrumented and _most_ of the helpers in
> page-flags.h look they should be as well by virtue of using test_bit().

Even though they're data races, if this is a "1-bit value change" data
race, then I'd leave it as-is for now (unless maintainer prefers
marking everything that can concurrently be accessed).

Bots wanting to enable KCSAN and races like this was the reason for
CONFIG_KCSAN_PERMISSIVE (ignoring those "1-bit value changes"):
https://lkml.kernel.org/r/20210607125653.1388091-1-elver@google.com --
This series is supposed to land in this merge-window.

For syzbot, we do active moderation -- when we get the time, we look
at races, and try to analyze or fix (although I've not looked
recently), or unconditionally forward to some maintainers who
committed addressing all data races in their subsystems (RCU, some
parts of networking).

Without active moderation before kernel 5.15, I do not recommend
turning on KCSAN on bots unconditionally, simply because prioritizing
the severity of data races is still difficult (and maintainers only
have so much time). Ultimately, our goal is of course to eventually
address all data races, but I think it requires time and patience.

With 5.15, it may be possible to cautiously enable KCSAN on bots
without moderation if they set CONFIG_KCSAN_PERMISSIVE=y. If no
moderation is possible, an intermediate step may be:

-- sending everything to a separate mailing list by default, without
Cc (those interested, can subscribe)
-- maintainers who opt into KCSAN reports will get the reports as normal.

We could also make use of those opt-ins for syzbot. :-)

Thoughts?

(For completeness, longer discussion on developer/maintainer
strategies: https://lwn.net/Articles/816854/)

Thanks,
-- Marco
