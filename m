Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404BC3FFA1C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 08:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhICGGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 02:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234109AbhICGGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:06:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 792D360FA0;
        Fri,  3 Sep 2021 06:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630649154;
        bh=9Nlcn8z4gbe0o0BNJJpnNKEG96e02lbT0cbwJClm3Y0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ScB2AWq1Ijl2pfVyYSdyF8bIMU9Jk82AJPSCdVh/dH2ft2HUzQqPa39UlkKmzKfhH
         uEob13evNkGXjwfYjV8C1EigsIOFdvYINaiPHgM4+G6CcIj/ZJ/7FU/v1gBGOWoaxD
         8E4+WlPghahXSzZJU9qc0hXfGT9WdvOXXwpNEs0rZUW5ZfBGxo4xz9y9k/KCU0mrXj
         m122lE3cYYadxdt7JM87EDTXoentiFZ7DcWdUD5pt/WwfbEEtfHJX/df8zAhqGUd6a
         7hVbf1ubdXE4MPpsA8arpXpUkNxedLfXNtpsShKhBbOhDYzj9T+pLHYOBBWZqr2Y1c
         HSeXIb5LvHBdg==
Message-ID: <6781e62221ecd5a61ef4982c191cbf9ea97f59ac.camel@kernel.org>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 03 Sep 2021 09:05:51 +0300
In-Reply-To: <23bd92e159dba35f74fc3d3a8186dfbb3ff84f66.camel@kernel.org>
References: <20210830154702.247681585@linutronix.de>
         <20210830162545.374070793@linutronix.de> <YS0ylo9nTHD9NiAp@zn.tnic>
         <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
         <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
         <87r1e8cxp5.ffs@tglx> <87o89ccmyu.ffs@tglx> <YS+upEmTfpZub3s9@google.com>
         <84fd35193e293894c4e64704e18dc063995b62c0.camel@kernel.org>
         <871r67cbp6.ffs@tglx>
         <23bd92e159dba35f74fc3d3a8186dfbb3ff84f66.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-03 at 09:00 +0300, Jarkko Sakkinen wrote:
> On Thu, 2021-09-02 at 16:08 +0200, Thomas Gleixner wrote:
> > On Thu, Sep 02 2021 at 16:08, Jarkko Sakkinen wrote:
> > > On Wed, 2021-09-01 at 16:47 +0000, Sean Christopherson wrote:
> > > > As for SGX consuming the trap number in general, it's correct.  For=
 non-KVM usage,
> > > > it's nice to have but not strictly necessary.  Any fault except #PF=
 on ENCLS is
> > > > guaranteed to be a kernel or hardware bug; SGX uses the trap number=
 to WARN on a
> > > > !#PF exception, e.g. on #GP or #UD.  Not having the trap number wou=
ld mean losing
> > > > those sanity checks, which have been useful in the past.
> > >=20
> > > AFAIK, we do not consider #UD as a bug. Agree with the conclusion tha=
t SGX
> > > should never #MC, I just did not get this part. #UD is something that=
 is
> > > useful for SGX run-time.
> >=20
> > I understood that storing the trap number is useful. I was just
> > questioning the #MC angle. I.e. pretending that the #MC caused by ENCLS
> > is recoverable.
>=20
> Absolutely not.=20
>=20
> I mixed up #UD caused by CPU executing inside enclave and ENCLS causing
> #UD. Sorry about that.
>=20
> Because of KVM we have to catch #PF's, given that a new power cycle
> in the host resets the state of SGX protected memory in the guest.

.. catching #PF's makes also quite a lot of sense for the bare
metal case because otherwise we would have to have hook for
power state change that would have invalidate all enclaves
running in the system.

/Jarkko
