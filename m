Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E45372443
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 03:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhEDBc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 21:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhEDBc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 21:32:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADF6A6101B
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 01:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620091893;
        bh=K8vSP43hXBPaf8WuOBWx0dY70MfoRQlMOLSA9/M19w8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YyFRW08W1KqlNYAH6sqVmJAIqAoh+BJkY8VNjd7EpbikOoLJuP/vsOduyJeFPOzq5
         f3xVZsTQnfU3b26Ra9mzOXeTQ8rgy+m38YvJZ00bVl7Ptk166+Lg+9Mkpvj0LP9Qmt
         gzluIwDVn8lKnYM8GqoT5N4VSGBSJ9qtQhFcRvvwJCC86PpFNXXmpFGAKIPk8NLzAy
         k69sjFUqvXlIHsnc6OZg/fcW7jH/5Jv9/3gbrM+LUDgcSZFWAe4E30K+5I/GZyth6C
         O9dgIhg0eDgorRDmqLcwiacDH3egYfC21Vf0w9aTX6jWkg+EGMjnySzw3aNXjXt1Bj
         E6MCE4idgf9dg==
Received: by mail-ej1-f47.google.com with SMTP id m12so10695591eja.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 18:31:33 -0700 (PDT)
X-Gm-Message-State: AOAM533Ib/N3YDgNeD+VC7pVXbuHZW5/D4aEOXai28zb2i07xIrb9XmE
        vM86PiOXQbZpqFm3RTbx4V09Uu+a4L8aeHEO2iG7DA==
X-Google-Smtp-Source: ABdhPJyC0rDJkhOsqx6P1zeIhkietoOvs/0pyrT9F38SUm49ZWAL9NsuXK3iTuZdiEPs+LgmcRdVWj0S0LILvYfEGM0=
X-Received: by 2002:a17:906:4f91:: with SMTP id o17mr19184065eju.503.1620091892166;
 Mon, 03 May 2021 18:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrXRvhqw0fibE6qom3sDJ+nOa_aEJQeuAjPofh=8h1Cujg@mail.gmail.com>
 <20210503233010.x5lzpw4dq3gueg47@treble>
In-Reply-To: <20210503233010.x5lzpw4dq3gueg47@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 3 May 2021 18:31:21 -0700
X-Gmail-Original-Message-ID: <CALCETrVwFrpZU-6C=AVurVPk4ahV2yjqyhFeYbL_0OtBNJnZ=w@mail.gmail.com>
Message-ID: <CALCETrVwFrpZU-6C=AVurVPk4ahV2yjqyhFeYbL_0OtBNJnZ=w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Do_we_need_to_do_anything_about_=22dead_=C2=B5ops=3F=22?=
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 4:30 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Sat, May 01, 2021 at 09:26:33AM -0700, Andy Lutomirski wrote:
> > Hi all-
> >
> > The "I See Dead =C2=B5ops" paper that is all over the Internet right no=
w is
> > interesting, and I think we should discuss the extent to which we
> > should do anything about it.  I think there are two separate issues:
> >
> > First, should we (try to) flush the =C2=B5op cache across privilege
> > boundaries?  I suspect we could find ways to do this, but I don't
> > really see the point.  A sufficiently capable attacker (i.e. one who
> > can execute their own code in the dangerous speculative window or one
> > who can find a capable enough string of gadgets) can put secrets into
> > the TLB, various cache levels, etc.  The =C2=B5op cache is a nice piece=
 of
> > analysis, but I don't think it's qualitatively different from anything
> > else that we don't flush.  Am I wrong?
>
> Wouldn't this type of gadget (half-v1 gadget + value-dependent-branch)
> would be much more likely to occur than a traditional Spectre v1
> (half-v1 gadget + value-addressed-load)?

I don't fully believe this.  It's certainly the case that:

if (mispredicted as false)
  return;
secret =3D some_secret();
if (secret =3D=3D 42)
  do_something();

will leak the fact that the secret is 42 into the =C2=B5op cache, but it
will also leak it into the icache and lots of other things.  I see
nothing new here.  That being said, it's probably still worth
investigating the gadgets.

>
> Also, in section V.A., they identified 37 gadgets.  Has anybody looked
> at those yet?

Not I.
