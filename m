Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E954841B6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbhI1S7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:59:09 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:39844 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242324AbhI1S7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:59:08 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 87BB11C0B87; Tue, 28 Sep 2021 20:57:27 +0200 (CEST)
Date:   Tue, 28 Sep 2021 20:57:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
Subject: Re: [PATCH v2] HSI: cmt_speech: unmark comments as kernel-doc
Message-ID: <20210928185727.GA10433@duo.ucw.cz>
References: <20210928183536.30645-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20210928183536.30645-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Fix build warnings from the kernel test robot:
>=20
> drivers/hsi/clients/cmt_speech.c:831: warning: This comment starts with '=
/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-=
doc.rst
>     * Block until pending data transfers have completed.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Aditya Srivastava <yashsri421@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

If noone applies it, you may want to send it to akpm, he's  often
helpful in pushing similar patches.

Best regards,
							Pavel
						=09
--=20
http://www.livejournal.com/~pavelmachek

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYVNllwAKCRAw5/Bqldv6
8s0eAJ9qS7PYdwLpdbMLswIYnkLecrFPpQCgteSzpK8HQwDB0Rgz17Q0NlPE+Wk=
=XOow
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
