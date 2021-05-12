Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC437B7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhELIaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhELIaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:30:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F0B1611CE;
        Wed, 12 May 2021 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620808147;
        bh=7gd5CmNGOJIefPoc1YnRuWUilvs0IIYYKBaqlByUW98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gbvQJ7jnRRwSgVE1A41/VzurZI31My1M6hhfO4gpSULBgb55OeNQFtWMzexQxO5QP
         oLKvgIQBDP1btdd6A4nGOGHLW3weDd7F8rJOHxSzLemzbysmhK8rXSb/5S7cVT1ujy
         BdIjClGIrr58d0dlkrd2Nht0Os3lfMIcegLJL8V+/fsT215TLKcW32f+K63J/eb2EM
         C6meyfNEkP/TnbLwKjFiPEeQbrwg89w4Xut+8n1UvvZlNFuFSB1G8rBMVVgHYrKpRb
         ngq2+hujs9UzlFzONleDU5psqVlJ0YNTUNbjWicZZze1IPFj0/6P83PNjUGSO/lV84
         mTwbIojPvahBQ==
Date:   Wed, 12 May 2021 10:29:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>,
        Marco Elver <elver@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 39/53] docs: dev-tools: testing-overview.rst: avoid
 using UTF-8 chars
Message-ID: <20210512102901.3de0fdb7@coco.lan>
In-Reply-To: <CABVgOSn67XkxasNeMvcs-ciL8F8zmMEVoZMNqf8xRdUg1heX_g@mail.gmail.com>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
        <1591224255d095d14ff3bc2bf4e7796dcc55c77d.1620641727.git.mchehab+huawei@kernel.org>
        <CABVgOSn67XkxasNeMvcs-ciL8F8zmMEVoZMNqf8xRdUg1heX_g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 11 May 2021 07:35:29 +0800
David Gow <davidgow@google.com> escreveu:

> On Mon, May 10, 2021 at 6:27 PM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > While UTF-8 characters can be used at the Linux documentation,
> > the best is to use them only when ASCII doesn't offer a good replacemen=
t.
> > So, replace the occurences of the following UTF-8 characters:
> >
> >         - U+2014 ('=E2=80=94'): EM DASH
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > --- =20
>=20
> Oh dear, I do have a habit of overusing em-dashes. I've no problem in
> theory with exchanging them for an ASCII approximation.
> I suppose there's a reason it's the one dash to rule them all: :-)
> https://twitter.com/FakeUnicode/status/727888721312260096/photo/1
>=20
> >  Documentation/dev-tools/testing-overview.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentati=
on/dev-tools/testing-overview.rst
> > index b5b46709969c..8adffc26a2ec 100644
> > --- a/Documentation/dev-tools/testing-overview.rst
> > +++ b/Documentation/dev-tools/testing-overview.rst
> > @@ -18,8 +18,8 @@ frameworks. These both provide infrastructure to help=
 make running tests and
> >  groups of tests easier, as well as providing helpers to aid in writing=
 new
> >  tests.
> >
> > -If you're looking to verify the behaviour of the Kernel =E2=80=94 part=
icularly specific
> > -parts of the kernel =E2=80=94 then you'll want to use KUnit or kselfte=
st.
> > +If you're looking to verify the behaviour of the Kernel - particularly=
 specific
> > +parts of the kernel - then you'll want to use KUnit or kselftest. =20
>=20
> As Marco pointed out, having multiple HYPHEN-MINUS symbols in a row is
> probably a better replacement, as it does distinguish the em-dash from
> smaller dashes better.
> However, I need three for sphinx to output an em-dash here (2 hyphens
> only gives me an en-dash).
>=20
> So, if we want to get rid of the UTF-8 em-dash, my preferences would
> be (in descending order):
> 1. Three hyphens: '---' (sphinx generates an em-dash)
> 2. Two hyphens: '--' (worst case, an en-dash surrounded by spaces --
> as sphinx generates for me -- is still readable, and it's still
> readable as an em-dash in plain text)
> 3. One hyphen as in this patch (which I don't like as much, but will
> no doubt learn to live with)
>=20
> But it looks like you've got several similar comments on other patches
> in this series, so I'm happy for you to use whatever ends up being
> agreed upon generally.

Yeah, from the comments I received so far, it seems that most developers
want to use '---' for EM DASH and '--' for EN DASH, typing it as ASCII
instead of using U+<number> as this is easier on most editors.

Yet, my understanding is that we don't have a consensus with that
regards, as some patches I sent using a single hyphen were=20
accepted/reviewed/acked.

So, I sent (and it was already applied) a small patch series (/5)
fixing the cases where UTF-8 chars (including DASH) were added
by mistake (probably due to some conversion tool).=20

For the remaining issues, my plan is to split this series in two
parts:

The first one with non-polemic UTF-8 changes, and a second one with
just EM/EN DASH, using '---' to replace EM DASH and '--' to replace
EN DASH, as this way, the produced HTML/LaTeX/PDF docs won't change.

This should make easier to discuss the EM/EN DASH changes on
each patch, and see if the above default is the better fit for a
particular usecase.

Thanks,
Mauro
