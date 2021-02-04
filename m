Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E380C31006B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBDW6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:58:36 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:40676 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBDW6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:58:34 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5CC6E1C0B77; Thu,  4 Feb 2021 23:57:52 +0100 (CET)
Date:   Thu, 4 Feb 2021 23:57:51 +0100
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
Message-ID: <20210204225751.GD13103@amd>
References: <20210202201846.716915-1-timur@kernel.org>
 <20210204204835.GA7529@amd>
 <20210204155423.2864bf4f@gandalf.local.home>
 <20210204214944.GA13103@amd>
 <873d7e08-7a70-a1a3-f486-882d1d515965@kernel.org>
 <20210204221143.GB13103@amd>
 <202102041415.D9093ED6@keescook>
 <20210204225136.GC13103@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <20210204225136.GC13103@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2021-02-04 23:51:36, Pavel Machek wrote:
> On Thu 2021-02-04 14:17:13, Kees Cook wrote:
> > On Thu, Feb 04, 2021 at 11:11:43PM +0100, Pavel Machek wrote:
> > > On Thu 2021-02-04 15:59:21, Timur Tabi wrote:
> > > > On 2/4/21 3:49 PM, Pavel Machek wrote:
> > > > >This machine is insecure. Yet I don't see ascii-art *** all around=
=2E.
> > > > >
> > > > >"Kernel memory addresses are exposed, which is bad for security."
> > > >=20
> > > > I'll use whatever wording everyone can agree on, but I really don't=
 see much
> > > > difference between "which may compromise security on your system" a=
nd "which
> > > > is bad for security".  "may compromise" doesn't see any more alarmi=
st than
> > > > "bad".  Frankly, "bad" is a very generic term.
> > >=20
> > > Well, I agree that "bad" is vague.... but original wording is simply
> > > untrue, as printing addresses decreases robustness but can't introduce
> > > security problem on its own.
> > >=20
> > > Being alarmist is not my complaint; being untrue is.
> >=20
> > It's just semantics. Printing addresses DOES weaken the security of a
> > system, especially when we know attackers have and do use stuff from dm=
esg
> > to tune their attacks. How about "reduces the security of your system"?
>=20
> "reduces" sounds okay to me.
>=20
> You should not have attackers on your system. That reduces your security.
>=20
> You should not have users reading dmesg. Again that reduces your
> security.
>=20
> You should not have bugs in your kernel. That reduces your security.

Oh, and you really should not run modern, out-of-order CPU. That
significantly reduces your security.

Yet we have documentation stating that my machine is secure:

   The Linux kernel contains a mitigation for this attack vector, PTE
      inversion, which is permanently enabled and has no performance
      impact. The kernel ensures that the address bits of PTEs, which
      are not marked present, never point to cacheable physical memory
      space.

   A system with an up to date kernel is protected against attacks
   from malicious user space applications.

when it is not:

[    0.545064] L1TF: System has more than MAX_PA/2 memory. L1TF
mitigation not effective.
[    0.545163] L1TF: You may make it effective by booting the kernel
with mem=3D2147483648 parameter.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAce+8ACgkQMOfwapXb+vKLGQCgwvG6KKuDEJFTd5qxHq5/pzQu
cM0AmgPB1EkGxKVWU5vD4ONwiUfrYwWM
=HeDB
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
