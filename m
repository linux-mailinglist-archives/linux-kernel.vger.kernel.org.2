Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA88534345F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCUThZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:37:25 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47688 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCUThI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:37:08 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9ECED1C0B78; Sun, 21 Mar 2021 20:37:05 +0100 (CET)
Date:   Sun, 21 Mar 2021 20:37:05 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     ojeda@kernel.org, alex.gaynor@gmail.com,
        rust-for-linux@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Getting Rust to work
Message-ID: <20210321193705.GA13699@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

First try was on x86-32. It took me a whlie to figure out the problem,
hence the diff below.

Next I was not sure what to do with rustup. I'm not sure if advice
below is good.

Then I got failure because libclang (?) was not installed. I installed
it. But I guess that should be mentioned in docs as dependency.

With CONFIG_RUST unset, kernel builds for me. With CONFIG_RUST=3Dy +
RUST_EXAMPLE=3Dy... I get errors:

  RUSTC L rust/core.o
  BINDGEN rust/bindings_generated.rs
error: unknown argument: '-fmacro-prefix-map=3D./=3D'
error: unknown warning option '-Wno-frame-address'; did you mean '-Wno-addr=
ess'? [-Wunknown-warning-option]
=2E/arch/x86/include/asm/bitops.h:138:9: error: 'asm goto' constructs are n=
ot supported yet
=2E/arch/x86/include/asm/bitops.h:162:9: error: 'asm goto' constructs are n=
ot supported yet
=2E/arch/x86/include/asm/bitops.h:201:9: error: 'asm goto' constructs are n=
ot supported yet
=2E/include/linux/list.h:282:9: warning: duplicate 'const' declaration spec=
ifier [-Wduplicate-decl-specifier]
=2E/include/linux/list.h:318:27: warning: duplicate 'const' declaration spe=
cifier [-Wduplicate-decl-specifier]
=2E/include/linux/list.h:821:10: warning: duplicate 'const' declaration spe=
cifier [-Wduplicate-decl-specifier]
=2E/include/linux/list.h:830:10: warning: duplicate 'const' declaration spe=
cifier [-Wduplicate-decl-specifier]
=2E/arch/x86/include/asm/atomic.h:83:9: error: 'asm goto' constructs are no=
t supported yet
=2E/arch/x86/include/asm/atomic.h:123:9: error: 'asm goto' constructs are n=
ot supported yet
=2E/arch/x86/include/asm/atomic.h:137:9: error: 'asm goto' constructs are n=
ot supported yet
=2E/arch/x86/include/asm/atomic.h:152:9: error: 'asm goto' constructs are n=
ot supported yet

$ gcc --version
gcc (Debian 8.3.0-6) 8.3.0
$ rustc --version
rustc 1.52.0-nightly (61edfd591 2021-03-20)

Ideas?

Best regards,
								Pavel



diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-=
start.rst
index 33b5cd33ecc5..d034369b3d43 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -16,6 +16,8 @@ Some of these requirements might be available from your L=
inux distribution
 under names like ``rustc``, ``rust-src``, ``rust-bindgen``, etc. However,
 at the time of writing, they are likely to not be recent enough.
=20
+You need to have x86-64 or arm64 system.
+
=20
 rustc
 *****
@@ -32,6 +34,8 @@ Otherwise, fetch a standalone installer or install ``rust=
up`` from:
=20
     https://www.rust-lang.org
=20
+    (if you have multiple toolchains, do rustup default nightly-i686-unkno=
wn-linux-gnu )
+
=20
 Rust standard library source
 ****************************

--=20
http://www.livejournal.com/~pavelmachek

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYFegYQAKCRAw5/Bqldv6
8reiAJ0QrTqPs9WE45hndO1G+kQozPVRWQCfR9YiDCj1Zgghil4XdC11WaMxpck=
=SIwf
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
