Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509F9372A63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhEDMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 08:52:27 -0400
Received: from www.zeus03.de ([194.117.254.33]:47824 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhEDMw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 08:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=qIw9rJ1kXaXeFLfj0Vi7CaukOKfs
        NrIjXgBJOt72A0E=; b=jK+WC3uW8Mp4ujLGyRLMciyFM+AjDaM5hYkGhkx875x0
        Oo2ALZ7S8dLcIHmI3luuJnShQsiBCnXQnPtbsd2HLEUBWq/gYzQvUFaU3h30aoWF
        Qptx7joAmE62IAB3nEBaUWmDmH0yD/c27k/HhYMV3U9bjUA7zWlt7bg3mHhSo8Y=
Received: (qmail 1365405 invoked from network); 4 May 2021 14:51:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2021 14:51:31 +0200
X-UD-Smtp-Session: l3s3148p1@xNOFiYDBhIwgAwDPXxOMAJUzfx/HAvHg
Date:   Tue, 4 May 2021 14:51:30 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: samsung-laptop: set debugfs blobs to read
 only
Message-ID: <20210504125130.GA43834@ninjato>
References: <20210504123139.45101-1-wsa+renesas@sang-engineering.com>
 <CAHp75VdqEa+mRDzwUVix7bY=2R=O0WOwXuLjv=mE4MGGOobYBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <CAHp75VdqEa+mRDzwUVix7bY=2R=O0WOwXuLjv=mE4MGGOobYBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Those blobs can only be read. So, don't confuse users with 'writable'
> > flags.
>=20
> Wouldn't it make sense at the same time to convert ugly namings to
> octal permissions?

I think this is out-of-scpoe for this patch. While I also use octals
personally, I don't feel strongly about it and let others use what they
prefer.


--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmCRQ00ACgkQFA3kzBSg
KbahCg//d2M3OWdq1SGS2wYk1cAJK0k9DJ5JT9KSJHdSc1GSYFd6vXzEEgNJu0Yd
UT+4Q1W6I9+cMNpskEbKxInuOfP7+ohlg253463eMK8wI9p5Z74tm+o2aY1eicZs
zzmHjhXq0H/f5i+JfaGaNfQiHfTObm/YCuHTImQQN2F8cl864L/Ng15w+rQuzf5F
k35wSeY9bxU8hfPp913dl91xC1EZ6um+9uaUQScoR8Ynm2MdnX1Sr8QSHiZ0TP/v
mPySH1wTxO6lS54ywgy1xDL+c+NlPkYFET8uj+iYUCeeasleT2kVCGpy7sSFLpo/
IvK+XqnPakBtLsNu0CAZq5sW6J35TXzOy7OvaPyraSMoLOADMFKTKpBCXJ0MOwoL
ahFR9AZaqTpoPQeHX/Bt6JgkXx03mCRjXzBGVc15ZfA3iuDI44ThamDydCJa3f2X
ax1W8a7uDAHd5SPJltBC/1xlBsU1vbDB+bzpuX+RHRDQR4iL+BciEvMovAGZw47N
h2MtjKsBPCbFaSpK07bA7VgBj0kGMRqaa3FRkjkFoV37ACbNPL7qcM5jmzihekHq
w7dYeMbeN/2cN1pIRzm8VI/CM9OAgWRvB/YeYfzKKohtUlubC+vZw5sEMEnUmjt1
Ypf/E5oWQ3sbixuqeUcALO/Bv/FCHJfrtUzhOI4r6coqrS4j7uI=
=e0Ke
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
