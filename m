Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8F53FC961
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhHaOIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234953AbhHaOIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:08:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 387766054E;
        Tue, 31 Aug 2021 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630418874;
        bh=K2JoNJVMX/LmaqqHbYdUQl55LSnI4B9otNeFYZtcjZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZbTE6ZnCPyzA4CRJB39yJBwkgB7zHRjF1wKKMdHh895sdY7YmocAxaYUCD0dPamRa
         GOLFKGSJbRIqpj36u1CLQoNlIwTH5hlq0jnB+5mHMsVGbxl7TrNNkobYFI30ls77W3
         44MLZ/Q8F+NAM6e4ivCvJINeW2Udas3N/8EUzyeJZtGRWUHmx06HLQF8VqDmBTW5jU
         xI3QotIiWXpdgx/o4E4oJUmwNPlo5uXWh7kavsVPIOsHs6pHVtzUBb+IKKn/rGws8R
         CWWGK/ptaEWq8R4u9smUFgpWGm9yKgsD7Ux9twDtH5dGPQdXx3UvloWC61KTCYRgMf
         JTt15ZPXKDHOw==
Date:   Tue, 31 Aug 2021 15:07:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        kernel test robot <oliver.sang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [mm] f9ce0be71d:
 BUG:KCSAN:data-race_in_next_uptodate_page/next_uptodate_page
Message-ID: <20210831140749.GA31886@willie-the-truck>
References: <20210826144157.GA26950@xsang-OptiPlex-9020>
 <20210827154232.rrpetqsh5xxklkej@box.shutemov.name>
 <20210831131313.GC31712@willie-the-truck>
 <CANpmjNOEstBLc9tbofcM=hfkYsmQFLBzq3i=L58fPpgg1vHgPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOEstBLc9tbofcM=hfkYsmQFLBzq3i=L58fPpgg1vHgPw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 03:38:17PM +0200, Marco Elver wrote:
> On Tue, 31 Aug 2021 at 15:13, Will Deacon <will@kernel.org> wrote:
> > > > [  184.717904][ T1873] ==================================================================
> > > > [  184.718938][ T1873] BUG: KCSAN: data-race in next_uptodate_page / unlock_page
> > > > [  184.719828][ T1873]
> > > > [  184.720103][ T1873] write (marked) to 0xffffea00050f37c0 of 8 bytes by task 1872 on cpu 1:
> > > > [  184.721024][ T1873]  unlock_page+0x102/0x1b0
> > > > [  184.721533][ T1873]  filemap_map_pages+0x6c6/0x890
> > > > [  184.722102][ T1873]  handle_mm_fault+0x179c/0x27f0
> > > > [  184.722672][ T1873]  do_user_addr_fault+0x3fb/0x830
> > > > [  184.723263][ T1873]  exc_page_fault+0xc3/0x1a0
> > > > [  184.723845][ T1873]  asm_exc_page_fault+0x1e/0x30
> > > > [  184.724427][ T1873]
> > > > [  184.724720][ T1873] read to 0xffffea00050f37c0 of 8 bytes by task 1873 on cpu 0:
> > > > [  184.725575][ T1873]  next_uptodate_page+0x456/0x830
> > > > [  184.726161][ T1873]  filemap_map_pages+0x728/0x890
> > > > [  184.726747][ T1873]  handle_mm_fault+0x179c/0x27f0
> > > > [  184.727332][ T1873]  do_user_addr_fault+0x3fb/0x830
> > > > [  184.727905][ T1873]  exc_page_fault+0xc3/0x1a0
> > > > [  184.728440][ T1873]  asm_exc_page_fault+0x1e/0x30
> > > > [  184.729027][ T1873]
> > > > [  184.729313][ T1873] Reported by Kernel Concurrency Sanitizer on:
> > > > [  184.730019][ T1873] CPU: 0 PID: 1873 Comm: systemd-udevd Not tainted 5.11.0-rc4-00001-gf9ce0be71d1f #1
> > > > [  184.731103][ T1873] ==================================================================
> > >
> > > Line annotation would be helpful.
> >
> > Agreed.
> >
> > > And I'm not very familiar with KCSAN. My guess it reports PageLock() vs.
> > > clearing PG_locked. In this context it looks safe, unless I miss
> > > something.
> >
> > The access in clear_bit_unlock() is annotated as a full sizeof(long) atomic
> > write, so we could be racing with a non-atomic read of another bit in the
> > page flags but I can't spot where that happens before the trylock_page() in
> > next_uptodate_page().
> >
> > > Do we need some annotation to help KCSAN?
> >
> > clear_bit_unlock() is already instrumented and _most_ of the helpers in
> > page-flags.h look they should be as well by virtue of using test_bit().
> 
> Even though they're data races, if this is a "1-bit value change" data
> race, then I'd leave it as-is for now (unless maintainer prefers
> marking everything that can concurrently be accessed).
> 
> Bots wanting to enable KCSAN and races like this was the reason for
> CONFIG_KCSAN_PERMISSIVE (ignoring those "1-bit value changes"):
> https://lkml.kernel.org/r/20210607125653.1388091-1-elver@google.com --
> This series is supposed to land in this merge-window.
> 
> For syzbot, we do active moderation -- when we get the time, we look
> at races, and try to analyze or fix (although I've not looked
> recently), or unconditionally forward to some maintainers who
> committed addressing all data races in their subsystems (RCU, some
> parts of networking).
> 
> Without active moderation before kernel 5.15, I do not recommend
> turning on KCSAN on bots unconditionally, simply because prioritizing
> the severity of data races is still difficult (and maintainers only
> have so much time). Ultimately, our goal is of course to eventually
> address all data races, but I think it requires time and patience.

(sounds like the 0day folks should disable KCSAN for now then)

> With 5.15, it may be possible to cautiously enable KCSAN on bots
> without moderation if they set CONFIG_KCSAN_PERMISSIVE=y. If no
> moderation is possible, an intermediate step may be:
> 
> -- sending everything to a separate mailing list by default, without
> Cc (those interested, can subscribe)
> -- maintainers who opt into KCSAN reports will get the reports as normal.
> 
> We could also make use of those opt-ins for syzbot. :-)
> 
> Thoughts?

I wasn't complaining about the report! It's more that without line numbers
we're struggling a bit to figure out where the race is. All the page-flag
tests on the reader side should be using test_bit(), but the report above
doesn't seem to think that the read is marked. Given your series adding
CONFIG_KCSAN_PERMISSIVE and the fact that you try to triage these things, I
thought maybe you've seen this before and might be able to point at the race
(which is hopefully benign, but it's annoying when you can't spot it!).

Will
