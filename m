Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9491530FFAB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBDVuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:50:54 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:34402 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhBDVu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:50:26 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BF8161C0B79; Thu,  4 Feb 2021 22:49:44 +0100 (CET)
Date:   Thu, 4 Feb 2021 22:49:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <20210204214944.GA13103@amd>
References: <20210202201846.716915-1-timur@kernel.org>
 <20210204204835.GA7529@amd>
 <20210204155423.2864bf4f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20210204155423.2864bf4f@gandalf.local.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > > +	pr_warn("** Kernel memory addresses are exposed, which may       **=
\n");
> > > +	pr_warn("** compromise security on your system.                  **=
\n"); =20
> >=20
> > This is lies, right? And way too verbose.
>=20
> Not really. More of an exaggeration than a lie. And the verbosity is
> to

Well... security is _not_ compromised but robustness against kernel
bugs is reduced. It should not exaggerate.

> make sure it's noticed by those that shouldn't have it set. This works we=
ll
> for keeping trace_printk() out of production kernels. Why do you
> care

So if we want people to see it, we up the severity, right? Like
pr_err()... Distro kernels have quiet, anyway...

Lets take a look for what we say for _real_ problems:

[    0.544757] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitiza
tion
[    0.544876] Spectre V2 : Mitigation: Full generic retpoline
[    0.544961] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switc
h
[    0.545064] L1TF: System has more than MAX_PA/2 memory. L1TF
mitigation not effective.
[    0.545163] L1TF: You may make it effective by booting the kernel
with mem=3D2147483648 par
ameter.
[    0.545281] L1TF: However, doing so will make a part of your RAM
unusable.
[    0.545374] L1TF: Reading
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html
might help you decide.

This machine is insecure. Yet I don't see ascii-art *** all around..

"Kernel memory addresses are exposed, which is bad for security."
would be quite enough, I'd say...

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAca/gACgkQMOfwapXb+vIbAgCgqdbBjD/oEzrrT4AAuxjRKbnb
YFcAniCKkMfU/JAkSWIF01S6cuPg0KRX
=0B3l
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
