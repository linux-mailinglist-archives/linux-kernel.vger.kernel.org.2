Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136CF3E8694
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhHJXds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:33:48 -0400
Received: from mailout.comhem.se ([82.99.18.63]:44506 "EHLO mailout.comhem.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233570AbhHJXdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:33:46 -0400
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2021 19:33:46 EDT
Received: from mail.jni.nu (c188-150-64-249.bredband.tele2.se [188.150.64.249])
        by mailout.comhem.se (Postfix) with ESMTPS id 51C2644030C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 23:24:32 +0000 (UTC)
Received: by mail.jni.nu (Postfix, from userid 1000)
        id 1181C2D608CC; Wed, 11 Aug 2021 00:46:11 +0200 (CEST)
Date:   Wed, 11 Aug 2021 00:46:11 +0200
From:   Jesper Nilsson <jesper@jni.nu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mete Polat <metepolat2000@gmail.com>,
        Jesper Nilsson <jesper@jni.nu>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] rbtree: remove unneeded explicit alignment in struct
 rb_node
Message-ID: <YRMBs0FhqFZPDuNP@jni.nu>
References: <20210805133213.700-1-lukas.bulwahn@gmail.com>
 <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 04:02:22PM +0200, Arnd Bergmann wrote:
> On Thu, Aug 5, 2021 at 3:32 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Commit e977145aeaad ("[RBTREE] Add explicit alignment to sizeof(long) for
> > struct rb_node.") adds an explicit alignment to the struct rb_node due to
> > some speciality of the CRIS architecture.
> >
> > The support for the CRIS architecture was removed with commit c690eddc2f3b
> > ("CRIS: Drop support for the CRIS port")
> >
> > So, remove this now unneeded explicit alignment in struct rb_node as well.
> >
> > This basically reverts commit e977145aeaad ("[RBTREE] Add explicit
> > alignment to sizeof(long) for struct rb_node.").
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: Mete Polat <metepolat2000@gmail.com>
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > applies cleanly on next-20210804, but only x86 compile-checked.
> >
> > Michel, Davidlohr, Jesper, David, please ack.
> >
> > Mete, you might want to re-run your RBT test suite for this change.
> >
> > Andrew, once acked, please pick this minor cleanup into your tree.
> 
> Do you know why it needed the extra alignment on cris at the time?

The problem for CRIS was that the architecture always had packed
structs (there was no way to avoid it in GCC) and CRIS could all data
on any byte boundary.

That was ok for normal pointers in structs, all pointers would be allocated
inside the same page and it didn't matter that they were aligned on odd byte
addresses for the CPU (except for being a little slower)

However, when the lowest bits were used as flags, that would clash on CRIS since
all bits were valid and possible address bits, so any sub-struct in a struct might be
aligned on an odd address, and using the pointer to the sub-struct would inadvertently
set the flag bits.

That's why just adding a forced alignment on the sub-struct fixed the problem,
since the compiler would respect such alignments, and thus leave the lower bits
free for trickery.

> The revert would appear to change the alignment to 16 bits instead
> of 32 bits on m68k as well (not 8 bits as on cris), but I don't know if that
> can cause problems there.
> 
>         Arnd

/^JN - Jesper Nilsson
--
                  Jesper Nilsson -- jesper_at_jni.nu
