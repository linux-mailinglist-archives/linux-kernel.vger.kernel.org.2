Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC07310054
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBDWwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:52:21 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:40230 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBDWwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:52:19 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6B3AC1C0B77; Thu,  4 Feb 2021 23:51:37 +0100 (CET)
Date:   Thu, 4 Feb 2021 23:51:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        john.ogness@linutronix.de, akinobu.mita@gmail.com
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <20210204225136.GC13103@amd>
References: <20210202201846.716915-1-timur@kernel.org>
 <20210204204835.GA7529@amd>
 <20210204155423.2864bf4f@gandalf.local.home>
 <20210204214944.GA13103@amd>
 <873d7e08-7a70-a1a3-f486-882d1d515965@kernel.org>
 <20210204221143.GB13103@amd>
 <202102041415.D9093ED6@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <202102041415.D9093ED6@keescook>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2021-02-04 14:17:13, Kees Cook wrote:
> On Thu, Feb 04, 2021 at 11:11:43PM +0100, Pavel Machek wrote:
> > On Thu 2021-02-04 15:59:21, Timur Tabi wrote:
> > > On 2/4/21 3:49 PM, Pavel Machek wrote:
> > > >This machine is insecure. Yet I don't see ascii-art *** all around..
> > > >
> > > >"Kernel memory addresses are exposed, which is bad for security."
> > >=20
> > > I'll use whatever wording everyone can agree on, but I really don't s=
ee much
> > > difference between "which may compromise security on your system" and=
 "which
> > > is bad for security".  "may compromise" doesn't see any more alarmist=
 than
> > > "bad".  Frankly, "bad" is a very generic term.
> >=20
> > Well, I agree that "bad" is vague.... but original wording is simply
> > untrue, as printing addresses decreases robustness but can't introduce
> > security problem on its own.
> >=20
> > Being alarmist is not my complaint; being untrue is.
>=20
> It's just semantics. Printing addresses DOES weaken the security of a
> system, especially when we know attackers have and do use stuff from dmesg
> to tune their attacks. How about "reduces the security of your system"?

"reduces" sounds okay to me.

You should not have attackers on your system. That reduces your security.

You should not have users reading dmesg. Again that reduces your
security.

You should not have bugs in your kernel. That reduces your security.

But you really can't have attackers patching your kernel. That
compromises your security completely.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAcengACgkQMOfwapXb+vLwIQCggID0EEu00qFUtoLk+ZKgVWU4
lFEAnilwNvaSM1ZHIQg883HlE7F3ptDc
=FGY9
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
