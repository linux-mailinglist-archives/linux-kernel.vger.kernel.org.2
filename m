Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900E83FEE5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbhIBNJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234054AbhIBNJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:09:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 118B060C3E;
        Thu,  2 Sep 2021 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630588093;
        bh=F1qtrOBY4LN3J6iz02W647VE8/3nrTJT54AKxL7E9zo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NNxOfzQrF7tPK5FFn2HQlMPLOaqaJExWydozIe3JMFEwYLILhzEduJIEFe5Brk/zP
         sPRUR2/24n0H5cjwjNKfY/tCXvMqa3oFF2r1b8F3PZHYEYuqfs+IlXFfKsxFxPnN3m
         uBkidjNAHp4YdXnE2Lk0TQ9WgvVxvGVfU6qSWcy9BzPP68og5IyZkItD+dOjZkNKiN
         8a11AVs7AyGUNzNNFCwSvVUBoXKkxiBDX38DF44jgiPYbD1T7DhSPgyPpq6ok2PyDP
         be6YzzzqQ0UyVDH5AEB6IXRuvw+GKArWlpFkTQDoGmM7rxTnh+AJ4xrPxu7TYpAcd+
         aZFB1Gf7yNUAQ==
Message-ID: <84fd35193e293894c4e64704e18dc063995b62c0.camel@kernel.org>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 02 Sep 2021 16:08:11 +0300
In-Reply-To: <YS+upEmTfpZub3s9@google.com>
References: <20210830154702.247681585@linutronix.de>
         <20210830162545.374070793@linutronix.de> <YS0ylo9nTHD9NiAp@zn.tnic>
         <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
         <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
         <87r1e8cxp5.ffs@tglx> <87o89ccmyu.ffs@tglx> <YS+upEmTfpZub3s9@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-01 at 16:47 +0000, Sean Christopherson wrote:
> On Wed, Sep 01, 2021, Thomas Gleixner wrote:
> > On Wed, Sep 01 2021 at 14:00, Thomas Gleixner wrote:
> > > commit b2f9d678e28c ("x86/mce: Check for faults tagged in
> > > EXTABLE_CLASS_FAULT exception table entries") made use of this in MCE=
 to
> > > allow in kernel recovery. The only thing it uses is checking the
> > > exception handler type.
> > >=20
> > > Bah. I'll fix that up to make that less obscure.
> > >=20
> > > The remaining two use cases (SGX and FPU) make use of the stored trap
> > > number.
> >=20
> > Though while for the FPU use case we really want to handle the #MC case=
,
> > it's not clear to me whether this is actually correct for SGX.
> >=20
> > Jarkko, Sean, Dave?
>=20
> Are you asking about #MC specifically, or about SGX consuming the trap nu=
mber in
> general?
>=20
> For #MC, it's probably a moot point because #MC on ENCLS is not recoverab=
le for
> current hardware.  If #MC somehow occurs on ENCLS and doesn't kill the pl=
atform,
> "handling" the #MC in SGX is probably wrong.  Note, Tony is working on a =
series to
> support recoverable #MC on SGX stuff on future hardware[*], but I'm not s=
ure that's
> relevant to this discussion.
>=20
> As for SGX consuming the trap number in general, it's correct.  For non-K=
VM usage,
> it's nice to have but not strictly necessary.  Any fault except #PF on EN=
CLS is
> guaranteed to be a kernel or hardware bug; SGX uses the trap number to WA=
RN on a
> !#PF exception, e.g. on #GP or #UD.  Not having the trap number would mea=
n losing
> those sanity checks, which have been useful in the past.

AFAIK, we do not consider #UD as a bug. Agree with the conclusion that SGX
should never #MC, I just did not get this part. #UD is something that is
useful for SGX run-time.

/Jarkko

