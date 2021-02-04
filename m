Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5183E30FFF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhBDWMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:12:41 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:36280 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhBDWMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:12:40 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6764D1C0B79; Thu,  4 Feb 2021 23:11:44 +0100 (CET)
Date:   Thu, 4 Feb 2021 23:11:43 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Timur Tabi <timur@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <20210204221143.GB13103@amd>
References: <20210202201846.716915-1-timur@kernel.org>
 <20210204204835.GA7529@amd>
 <20210204155423.2864bf4f@gandalf.local.home>
 <20210204214944.GA13103@amd>
 <873d7e08-7a70-a1a3-f486-882d1d515965@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <873d7e08-7a70-a1a3-f486-882d1d515965@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2021-02-04 15:59:21, Timur Tabi wrote:
> On 2/4/21 3:49 PM, Pavel Machek wrote:
> >This machine is insecure. Yet I don't see ascii-art *** all around..
> >
> >"Kernel memory addresses are exposed, which is bad for security."
>=20
> I'll use whatever wording everyone can agree on, but I really don't see m=
uch
> difference between "which may compromise security on your system" and "wh=
ich
> is bad for security".  "may compromise" doesn't see any more alarmist than
> "bad".  Frankly, "bad" is a very generic term.

Well, I agree that "bad" is vague.... but original wording is simply
untrue, as printing addresses decreases robustness but can't introduce
security problem on its own.

Being alarmist is not my complaint; being untrue is.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAccR8ACgkQMOfwapXb+vIf6QCdFo9gfAZzJ83XTjLr8/1dbIGv
K+EAn1o1rnSVuT+Es2aMfbXenkksRbT/
=E+WM
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
