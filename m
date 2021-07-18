Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A478F3CC906
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 14:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhGRMVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 08:21:22 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60190 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhGRMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 08:21:22 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 01F901C0B76; Sun, 18 Jul 2021 14:18:23 +0200 (CEST)
Date:   Sun, 18 Jul 2021 14:18:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, jpoimboe@redhat.com,
        peterz@infradead.org, mingo@kernel.org
Subject: Re: 5.14-rc0: regression when compiling tools/objtool
Message-ID: <20210718121822.GA14683@amd>
References: <20210711091729.GA22833@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20210711091729.GA22833@duo.ucw.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm getting build errors trying to build 5.14-rc0. Earlier -rc0
> releases built okay. This is 64-bit x86 build, 32-bit x86 and arm
> build okay for me, too. Attaching config, as it may be related?

This is quite annoying, as I'd like to try 5.14. Problem is not fixed
in -next, either...

Best regards,
								Pavel

>   CC      /fast/l/k/o/64/tools/objtool/check.o
>   CC      /fast/l/k/o/64/tools/objtool/weak.o
>   CC      /fast/l/k/o/64/tools/objtool/arch/x86/special.o
>   CC      /fast/l/k/o/64/tools/objtool/arch/x86/decode.o
> In file included from /fast/l/k/tools/objtool/include/objtool/objtool.h:1=
3,
>                  from /fast/l/k/tools/objtool/include/objtool/arch.h:11,
>                  from /fast/l/k/tools/objtool/include/objtool/check.h:11,
>                  from /fast/l/k/tools/objtool/include/objtool/special.h:1=
0,
>                  from arch/x86/special.c:4:
> /fast/l/k/tools/objtool/include/objtool/elf.h:10:10: fatal error: gelf.h:=
 No such file or directory
>  #include <gelf.h>
>           ^~~~~~~~
> compilation terminated.
> make[5]: *** [/fast/l/k/tools/build/Makefile.build:97: /fast/l/k/o/64/too=
ls/objtool/arch/x86/special.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
> In file included from /fast/l/k/tools/objtool/include/objtool/objtool.h:1=
3,
>                  from weak.c:10:
> /fast/l/k/tools/objtool/include/objtool/elf.h:10:10: fatal error: gelf.h:=
 No such file or directory
>  #include <gelf.h>
>           ^~~~~~~~
> compilation terminated.
>=20





--=20
http://www.livejournal.com/~pavelmachek

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmD0HA4ACgkQMOfwapXb+vKDkACgwqvl5ShEG/+sRy1/KTWJF+TR
nKQAnjD90Va2U4IaTYfrPcRvKII4kwWq
=91d9
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
