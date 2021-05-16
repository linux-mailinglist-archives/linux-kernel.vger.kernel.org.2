Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B53381E72
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 13:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhEPLPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 07:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhEPLPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 07:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E649161164;
        Sun, 16 May 2021 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621163640;
        bh=bxIW72OBGlUVbKXIO28RbGD+VrGPRvwYLITR6ZFMjjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kvkSsjUwYa1V714tMzdnqN6zgVoaNNC3jZaMjlQG4uoFAbITDWPw75pi5xgdRVG5p
         EKGaPZN4o3OFFkM4VeLebdU562quM996k1R5RbJldOVSmVLDORld5n18OrZh5G+xeo
         yquBoE7haM25TjstGcjy4b8Lj5JYW6jv6TAMENd4C3Vs/k2Do4V1xFhB+PrLVpwd+z
         sqpTahBXZs2VAOK/x9j6YKkGaMk8TrwOPZ2sucI3BsFmSaA2OXU7x/0f6FMy3triBY
         cwv8At9hogUYBCk/UuJAzkat5N6P3UXWGBNJeruA5WhLWZ3Wq+hXLK3FDFfbLJEpxT
         FvNvTNbVrW1Lw==
Date:   Sun, 16 May 2021 13:13:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/16] docs: admin-guide: reporting-issues.rst:
 replace some characters
Message-ID: <20210516131355.30c73b7d@coco.lan>
In-Reply-To: <a138a130-6208-be63-b6ea-b08f3d66012a@leemhuis.info>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
        <5625907ed95964321c39a8688b70c54bac6d8e95.1621159997.git.mchehab+huawei@kernel.org>
        <a138a130-6208-be63-b6ea-b08f3d66012a@leemhuis.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 16 May 2021 12:28:06 +0200
Thorsten Leemhuis <linux@leemhuis.info> escreveu:

> Lo! On one hand I think it would be good to fix the tools to make them
> understand non-breakable spaces in places where the author chose to use
> them,

Fixing it is not trivial ;-)

See, while DocBook, LaTeX and other similar tools allow the author
to specify exactly how the output will be produced, Markup languages=20
are not meant to give full control to the author, but, instead, to make
their work easier by letting the toolset to take decisions about line
breaks, font type and size, etc.

In the specific case of Sphinx, the main tool parses the ReST files,
and an output module is responsible to generate the actual output.

So, there's one module for LaTeX, another one for HTML and a
third party one for PDF (we currently don't use the last one).

It is the output module that will actually decide to do line
breaks and to honor the document margins and to add non-breakable
spaces when needed.

When the output is a web page, it shouldn't be a problem to use
unbreakable spaces, provided that the output module is smart enough
to detect it, adding an horizontal scroll bar if needed to avoid
long lines to be simply truncated if the window is smaller than
the lines.

For e-pub, LaTeX and PDF, though, unbreakable spaces should be
replaced by normal ones if the string is too long, or the lines
will simply be truncated, with text loses.

So, while it could be possible to use such characters, extra
care should be taken, as all output formats need to be tested.

Also, as Kernel patches and toolset improvements could change,
for instance, the used font, or a change somewhere could lead
into a different column width, such the tests need to be
repeated from time to time and with different Sphinx versions.

So, this ends by being a maintenance nightmare. Better to live
without those ;-)

> but whatever, their use in that sentence is definitely not
> important, so feel free to add:
>=20
> Acked-by: Thorsten Leemhuis <linux@leemhuis.info>
>=20
> Thanks for working on this. Ciao, Thorsten

Thanks!
Mauro
>=20
> On 16.05.21 12:18, Mauro Carvalho Chehab wrote:
> > The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
> > conversion and some cut-and-pasted text contain some characters that
> > aren't easily reachable on standard keyboards and/or could cause
> > troubles when parsed by the documentation build system.
> >=20
> > Replace the occurences of the following characters:
> >=20
> > 	- U+00a0 ('=C2=A0'): NO-BREAK SPACE
> > 	  as it can cause lines being truncated on PDF output
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/admin-guide/reporting-issues.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documenta=
tion/admin-guide/reporting-issues.rst
> > index 18d8e25ba9df..d7ac13f789cc 100644
> > --- a/Documentation/admin-guide/reporting-issues.rst
> > +++ b/Documentation/admin-guide/reporting-issues.rst
> > @@ -1248,7 +1248,7 @@ paragraph makes the severeness obvious.
> > =20
> >  In case you performed a successful bisection, use the title of the cha=
nge that
> >  introduced the regression as the second part of your subject. Make the=
 report
> > -also mention the commit=C2=A0id of the culprit. In case of an unsucces=
sful bisection,
> > +also mention the commit id of the culprit. In case of an unsuccessful =
bisection,
> >  make your report mention the latest tested version that's working fine=
 (say 5.7)
> >  and the oldest where the issue occurs (say 5.8-rc1).
> > =20
> >  =20



Thanks,
Mauro
