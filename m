Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F250F3B7EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhF3IMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 04:12:33 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51056 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232954AbhF3IMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:12:32 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lyVI6-0006Ui-RC; Wed, 30 Jun 2021 16:09:50 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lyVHq-0006L3-N8; Wed, 30 Jun 2021 16:09:34 +0800
Date:   Wed, 30 Jun 2021 16:09:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        syzbot <syzbot+5d1bad8042a8f0e8117a@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jpa@git.mail.kapsi.fi,
        kan.liang@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 __fdget_pos
Message-ID: <20210630080934.GA24186@gondor.apana.org.au>
References: <000000000000f3e94a05c5d8686f@google.com>
 <b7f0725f-2731-24af-f15d-1054d6398749@intel.com>
 <CAMj1kXGTV+U-oy=wyHf2KmuzjmaaPJaLBY4mx09tWjL6gCC=rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGTV+U-oy=wyHf2KmuzjmaaPJaLBY4mx09tWjL6gCC=rQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard:

On Wed, Jun 30, 2021 at 09:42:14AM +0200, Ard Biesheuvel wrote:
>
> > There's one suspect-looking site in xts_crypt():
> >
> > >       kernel_fpu_begin();
> > >
> > >       /* calculate first value of T */
> > >       aesni_enc(aes_ctx(ctx->raw_tweak_ctx), walk.iv, walk.iv);
> > >
> > >       while (walk.nbytes > 0) {
> > >               int nbytes = walk.nbytes;
> > >
> > >               ...
> > >
> > >               err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
> > >
> > >               kernel_fpu_end();
> > >
> > >               if (walk.nbytes > 0)
> > >                       kernel_fpu_begin();
> > >       }
> >
> > I wonder if a slab allocation failure could leave us with walk.nbytes==0.
> 
> The code is actually the other way around: kernel_fpu_end() comes
> before the call to skcipher_walk_done().
> 
> So IIUC, this code forces an allocation failure, and checks whether
> the code deals with this gracefully, right?
> 
> The skcipher walk API guarantees that walk.nbytes == 0 if an error is
> returned, so the pairing of FPU begin/end looks correct to me. And
> skcipher_walk_next() should not invoke anything that might sleep from
> this particular context.
> 
> Herbert, any ideas?

xts_crypt looks buggy to me.  In particular, if the second
skcipher_walk_virt call (the one in the if clause) fails, then
we will return without calling kernel_fpu_end.

Another issue, we are not checking for errors on the first
skcipher_walk_virt call, this may cause a double-free with
the subsequent skcipher_walk_abort inside the if clause.

With skcikpher_walk_virt, you must check for errors explicitly
*unless* you use it in a loop construct which exits on !walk->nbytes.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
