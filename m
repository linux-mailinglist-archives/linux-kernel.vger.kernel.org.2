Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468B9443D9C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhKCHU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:20:29 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:56834 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCHU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:20:27 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 50D2120130D;
        Wed,  3 Nov 2021 07:17:49 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id C1533204AD; Wed,  3 Nov 2021 08:14:02 +0100 (CET)
Date:   Wed, 3 Nov 2021 08:14:02 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: fix crash on multiple early calls to
 add_bootloader_randomness()
Message-ID: <YYI2unrpOm/ap/y6@light.dominikbrodowski.net>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YX44DCaIg/qGOrtE@light.dominikbrodowski.net>
 <CAMj1kXEeCwhADMEwfE8SaG=1+J8Lzrck72DixSdxOP3cAK_Uzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEeCwhADMEwfE8SaG=1+J8Lzrck72DixSdxOP3cAK_Uzg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Oct 31, 2021 at 01:33:34PM +0100 schrieb Ard Biesheuvel:
> On Sun, 31 Oct 2021 at 07:31, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > If add_bootloader_randomness() or add_hwgenerator_randomness() is
> > called for the first time during early boot, crng_init equals 0. Then,
> > crng_fast_load() gets called -- which is safe to do even if the input
> > pool is not yet properly set up.
> >
> > If the added entropy suffices to increase crng_init to 1, future calls
> > to add_bootloader_randomness() or add_hwgenerator_randomness() used to
> > progress to credit_entropy_bits(). However, if the input pool is not yet
> > properly set up, the cmpxchg call within that function can lead to an
> > infinite recursion. This is not only a hypothetical problem, as qemu
> > on x86 may provide bootloader entropy via EFI and via devicetree.
> >
> 
> arm64 not x86

Thanks, fixed in v2

> > As crng_global_init_time is set to != 0 once the input pool is properly
> > set up, check (also) for this condition to determine which branch to take.
> >
> > Calls to crng_fast_load() do not modify the input pool; therefore, the
> > entropy_count for the input pool must not be modified at that early
> > stage.
> >
> > Reported-and-tested-by: Ivan T. Ivanov <iivanov@suse.de>
> 
> Nit: fancy tags like this are more difficult to grep for
> 
> Better to use separate Reported-by and Tested-by tags

Well, it's used not all that rarely, but I don't care that much, so updated for v2.

> Please don't drop the diffstat. Are you using git format-patch?

For singular patches no; but fixed for v2.

> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 605969ed0f96..4211ff3092f9 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -1763,8 +1763,8 @@ static void __init init_std_data(struct entropy_store *r)
> >  }
> >
> >  /*
> > - * Note that setup_arch() may call add_device_randomness()
> > - * long before we get here. This allows seeding of the pools
> > + * add_device_randomness() or add_bootloader_randomness() may be
> > + * called long before we get here. This allows seeding of the pools
> >   * with some platform dependent data very early in the boot
> >   * process. But it limits our options here. We must use
> >   * statically allocated structures that already have all
> > @@ -2274,7 +2274,12 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
> >  {
> >         struct entropy_store *poolp = &input_pool;
> >
> > -       if (unlikely(crng_init == 0)) {
> > +       /* We cannot do much with the input pool until it is set up in
> > +        * rand_initalize(); therefore just mix into the crng state.
> > +        * As this does not affect the input pool, we cannot credit
> > +        * entropy for this.
> > +        */
> > +       if (unlikely(crng_init == 0) || unlikely(crng_global_init_time == 0)) {
> 
> Can we just drop the unlikely()s here?

As that would be a different change to the one necessary to resolve the bug,
I'd like to defer that decision to the maintainer of random.c.

Thanks,
	Dominik
