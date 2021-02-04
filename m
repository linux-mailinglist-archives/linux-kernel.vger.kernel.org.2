Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E8430FEC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBDUte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:49:34 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:57822 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBDUtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:49:33 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 782BA1C0B77; Thu,  4 Feb 2021 21:48:36 +0100 (CET)
Date:   Thu, 4 Feb 2021 21:48:35 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Timur Tabi <timur@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <20210204204835.GA7529@amd>
References: <20210202201846.716915-1-timur@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20210202201846.716915-1-timur@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2021-02-02 14:18:46, Timur Tabi wrote:
> If the make-printk-non-secret command-line parameter is set, then
> printk("%p") will print addresses as unhashed.  This is useful for
> debugging purposes.
>=20
> A large warning message is displayed if this option is enabled,
> because unhashed addresses, while useful for debugging, exposes
> kernel addresses which can be a security risk.

Yes please. I needed to see pointers for debugging, and seeing hashed
pointers is nasty. Having to patch C code to be able to develop... is
bad.

> +	pr_warn("** Kernel memory addresses are exposed, which may       **\n");
> +	pr_warn("** compromise security on your system.                  **\n");

This is lies, right? And way too verbose.

									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAcXaMACgkQMOfwapXb+vKvOQCeNeIzhzv70yiBaBw63hsqyL7n
Bm0An3ALaR2Z9WS8hhX/DU42VPs9cxmx
=lE4c
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
