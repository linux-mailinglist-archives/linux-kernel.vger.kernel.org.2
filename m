Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8393B7FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 11:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhF3JPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 05:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233541AbhF3JPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:15:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4797061D05
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625044392;
        bh=J2MOPPIp5YIk+RoNqiEpM/27M2PC8jB9VCYZvKMRjKE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lW99uWA911R48Z/wX80vMxUdNRoKC6SqFJmh8e4wVzaI+2qhYE/LRFP524heeh8DL
         zdyBrgCm4vFsnzvqykM2g5r5nXFq/grG/ka+t+NCaC5ILHuC8uvoBD/nVXH+knrrqx
         iymjrIyW43fe6ydeChoweDglWNQPnbLtNjkb/oBCwIvDOlmwSG6hzFio1fEOXj3n4T
         VDydykPEX1AA8vhc4buewgc7r55/I0KqtuU7tf3lIVicJr76nOH4AGFHDiaihSKikX
         mwW0KfkCihEjL7BgtYp1JNBN4z63AUg5cfJPsgTs5cuZjlj6sZ5G2lPhW0633+yWHE
         FfyqN/kngr/xA==
Received: by mail-oo1-f48.google.com with SMTP id s10-20020a4aeaca0000b029024c2acf6eecso453264ooh.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 02:13:12 -0700 (PDT)
X-Gm-Message-State: AOAM531IijvAsKVLSjNLR0JSQsuB/FQoP6vrg9Ne5wudNGpQtqmE0RzL
        ETnaAHqaugbFEyBOPuNtfkUiv8hGaqm9QnUkwDY=
X-Google-Smtp-Source: ABdhPJzpPkzmWODYndka1/8zl6LLSbgcOALtwM/frg7yBAWBajBfUpaHzX8lvMibCWK/HfyfzJRG9y9PTqnnFYIUmDU=
X-Received: by 2002:a4a:2f87:: with SMTP id p129mr7656173oop.41.1625044391555;
 Wed, 30 Jun 2021 02:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f3e94a05c5d8686f@google.com> <b7f0725f-2731-24af-f15d-1054d6398749@intel.com>
 <CAMj1kXGTV+U-oy=wyHf2KmuzjmaaPJaLBY4mx09tWjL6gCC=rQ@mail.gmail.com> <20210630080934.GA24186@gondor.apana.org.au>
In-Reply-To: <20210630080934.GA24186@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Jun 2021 11:13:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFyJ9C4aqq9+DxOMCPOxQUApQK+Oa3V8F0H39wwoK9wxA@mail.gmail.com>
Message-ID: <CAMj1kXFyJ9C4aqq9+DxOMCPOxQUApQK+Oa3V8F0H39wwoK9wxA@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __fdget_pos
To:     Herbert Xu <herbert@gondor.apana.org.au>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2021 at 10:10, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Hi Ard:
>
> On Wed, Jun 30, 2021 at 09:42:14AM +0200, Ard Biesheuvel wrote:
> >
> > > There's one suspect-looking site in xts_crypt():
> > >
> > > >       kernel_fpu_begin();
> > > >
> > > >       /* calculate first value of T */
> > > >       aesni_enc(aes_ctx(ctx->raw_tweak_ctx), walk.iv, walk.iv);
> > > >
> > > >       while (walk.nbytes > 0) {
> > > >               int nbytes = walk.nbytes;
> > > >
> > > >               ...
> > > >
> > > >               err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
> > > >
> > > >               kernel_fpu_end();
> > > >
> > > >               if (walk.nbytes > 0)
> > > >                       kernel_fpu_begin();
> > > >       }
> > >
> > > I wonder if a slab allocation failure could leave us with walk.nbytes==0.
> >
> > The code is actually the other way around: kernel_fpu_end() comes
> > before the call to skcipher_walk_done().
> >
> > So IIUC, this code forces an allocation failure, and checks whether
> > the code deals with this gracefully, right?
> >
> > The skcipher walk API guarantees that walk.nbytes == 0 if an error is
> > returned, so the pairing of FPU begin/end looks correct to me. And
> > skcipher_walk_next() should not invoke anything that might sleep from
> > this particular context.
> >
> > Herbert, any ideas?
>
> xts_crypt looks buggy to me.  In particular, if the second
> skcipher_walk_virt call (the one in the if clause) fails, then
> we will return without calling kernel_fpu_end.
>
> Another issue, we are not checking for errors on the first
> skcipher_walk_virt call, this may cause a double-free with
> the subsequent skcipher_walk_abort inside the if clause.
>
> With skcikpher_walk_virt, you must check for errors explicitly
> *unless* you use it in a loop construct which exits on !walk->nbytes.
>

So something like this, I suppose?

--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -849,6 +849,8 @@
                return -EINVAL;

        err = skcipher_walk_virt(&walk, req, false);
+       if (err)
+               return err;

        if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
                int blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
@@ -862,7 +864,10 @@
                skcipher_request_set_crypt(&subreq, req->src, req->dst,
                                           blocks * AES_BLOCK_SIZE, req->iv);
                req = &subreq;
+
                err = skcipher_walk_virt(&walk, req, false);
+               if (err)
+                       return err;
        } else {
                tail = 0;
        }
