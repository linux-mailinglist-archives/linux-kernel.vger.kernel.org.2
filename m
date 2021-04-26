Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7170136B4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhDZO1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:27:39 -0400
Received: from gimli.rothwell.id.au ([103.230.158.156]:53055 "EHLO
        gimli.rothwell.id.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDZO1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:27:39 -0400
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4FTRzY6r3wzymk;
        Tue, 27 Apr 2021 00:26:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rothwell.id.au;
        s=201702; t=1619447216;
        bh=M7hahHb9ZVwRs1gsNFLeF9qcPe2Uxmrhxr11CvVxURM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YYMNZxTKWf3mGo7kZl2wPMlKKQmoso7z0n0aDHoxjFybRBwYdcVd7My4Q9m7TOcEt
         11V9ZZXlnS9siZy9ZEblHBCne2XvpgHifgHpvLuWdkv4p0Ojlo7MDEhAmQIudSpirF
         vGymv+zPH/13rTs4bahKRBlEi6iBawq0EJBuxZ0UAfhrVwW+5OaJghGTmVFqt6CguW
         IuWP+OtZZA2TU1BW5miw/ZJXD505o+I60jvcf1xUd8f3qWCl16boFlpWmAiXWnedWf
         BafxNcY/grUUJRXTYFSohRZ0l1Yc41kmHWhx+TJik3gCTjPWpYpkA4o9isityHAmjC
         eXi2l0nWQpblA==
Date:   Tue, 27 Apr 2021 00:26:48 +1000
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] Staging/IIO driver updates for 5.13-rc1
Message-ID: <20210427002648.22459fa7@elm.ozlabs.ibm.com>
In-Reply-To: <YIa2ErYuJyCfSkS+@kroah.com>
References: <YIa2ErYuJyCfSkS+@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LIWecum9MUpAsQRxcfBxnbs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LIWecum9MUpAsQRxcfBxnbs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, 26 Apr 2021 14:46:10 +0200 Greg KH <gregkh@linuxfoundation.org> wro=
te:
>
> All of these have been in linux-next for a while with no reported
> issues.

There was just these:

https://lore.kernel.org/linux-next/20210329165525.32d51a3a@canb.auug.org.au/

https://lore.kernel.org/linux-next/20210331175151.67fcfe4d@canb.auug.org.au/

(the scmi tree commit mentioned in the latter is now in the arm-soc tree)

Not issues as such, but worth mentioning the conflicts and resolutions.
--=20
Cheers,
Stephen Rothwell

--Sig_/LIWecum9MUpAsQRxcfBxnbs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmCGzakACgkQAVBC80lX
0GyzKAgAobiMi+YHh7vVuIiLauo/vRee40i+Lm+a+SJSKfhdPXDBuvPnOxrtIHqr
6LUTkJ1yNu9Ne28RAeucxkkoQXnK9j2euF/NlUA/Yxg8ISgMbLkvy0k7lNBayZdj
TIR+0b//4ZhMR37vn2EpO+INCK1OUx42L4hGboUgxrTo0Io/8r4Cn3ZLfTC2UQO5
IYXjpZBNRsVqs63+BliOa8gZvZ3d4bVGVeITlR2nQZUlP6cGJHSkxp0pZcYAvSi9
Iu7rCpxkR1PrTH4U6PR5xsMVREzUNUk5YcKLfj/hgjKmLJHAOTw0IKaz3L9rY+u2
5Lm1vdd76PsfuVNRPT0iSxFxxhbcSA==
=LO1A
-----END PGP SIGNATURE-----

--Sig_/LIWecum9MUpAsQRxcfBxnbs--
