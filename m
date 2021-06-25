Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55B93B3E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFYHxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhFYHxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:53:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63869613C0;
        Fri, 25 Jun 2021 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624607463;
        bh=fWOl8kOxGDI5CuY7kq4vwX6NEbElX6xB1jGZ6mixVWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZZCY5hCC8e5vBdtM1Ne0h1kgUEJBANRnVPnVJ16qyouvywbO8yjtWsck0Je/d7618
         gRHASzILhvU/FmisBYT9ZPctn6mQ45gqiJf8SR2hfc7ezMv5sZcIBzCHF3CRc5wBur
         IffL976PL8fdkxbyT3efimpMf7peKpPHnyOy38Jd0PNrN6PB/6pzBtHKKCl35lKFwX
         Y+lhS/Rzp6CV6yc2dfsqJuYUvdxBt/04vo+02b+SGD3TevudclEjjcbhBdgA7fpMj5
         NNmgMgUspy/tD5wvnQejdWWnNW3sXqEf0ehbFEqB3jkSJAxC56TBZTrUwXiS3+g3fd
         yDQT0Q5txZsbg==
Date:   Fri, 25 Jun 2021 09:50:59 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     "Wu X.C." <bobwxc@email.cn>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        SeongJae Park <sj38.park@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] docs: pdfdocs: Improve alignment of CJK
 ascii-art
Message-ID: <20210625095059.7f97fd62@coco.lan>
In-Reply-To: <20210625065524.GA11219@bobwxc.top>
References: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
        <20210625065524.GA11219@bobwxc.top>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 25 Jun 2021 14:55:24 +0800
"Wu X.C." <bobwxc@email.cn> escreveu:

> On Thu, Jun 24, 2021 at 09:06:59PM +0900, Akira Yokosawa wrote:
> > Subject: [RFC PATCH 0/3] docs: pdfdocs: Improve alignment of CJK ascii-=
art
> >=20
> > Hi all, =20
>=20
> Hi Akira,
>=20
> >=20
> > This is another attempt to improve translations' pdf output.
> > I see there is a mismatch in the font choice for CJK documents, which
> > causes poor-looking ascii-art where CJK characters and Latin letters
> > are mixed used.
> >=20
> > One of noticeable examples of such ascii-art can be found in
> > Korean translation of memory-barriers.txt.
> >=20
> > Hence the author of Korean translation of memory-barriers.txt is
> > in the CC list.
> >=20
> > At first, I thought the issue could be fixed by simply selecting
> > "Noto Sans Mono CJK SC" as both of monofont and CJKmonofont.
> > It fixed the mis-alignment in the Chinese translation, but failed
> > in the Korean translation.
> >=20
> > It turns out that Hangul characters in "Noto Sans Mono CJK SC"
> > are slightly narrower than Chinese and Japanese counterparts.
> > I have no idea why the so-called "mono" font has non-uniform
> > character widths.
> >=20
> > GNU Unifont is an alternative monospace font which covers
> > almost all Unicode codepoints.
> > However, due to its bitmap-font nature, the resulting document
> > might not be acceptable to Korean readers, I guess. =20
>=20
> OK, it works.
>=20
> But I still want to say that the display effect of Unifont is really
> not good. Unifont's lattice is too small, and only one size.
> http://fars.ee/QA1k.jpg	    http://fars.ee/GAAv.jpg
> Looks like computers 20 years ago, LOL :)
>=20
> It there any chance to use other fonts, like *Sarasa Mono* ?
>                                               =E7=AD=89=E8=B7=9D=E6=9B=B4=
=E7=B4=97=E9=BB=91=E9=AB=94
> Looks more beautifull http://fars.ee/DTT6.jpg
> But I guess not many people installed it.

Does Sarasa mono looks nice for Japanese, Chinese and Korean
(plus latin)?

If so, I guess it shouldn't be a problem to use it, as the
./scripts/sphinx-pre-install can be patched to recommend
its install.

Thanks,
Mauro
