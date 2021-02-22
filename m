Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE153213C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 11:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhBVKHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 05:07:49 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56066 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhBVKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:04:29 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E25AC1C0B76; Mon, 22 Feb 2021 11:03:25 +0100 (CET)
Date:   Mon, 22 Feb 2021 11:03:25 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v4] reboot: allow to specify reboot mode via sysfs
Message-ID: <20210222100325.GA14587@amd>
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20201110202746.9690-1-mcroce@linux.microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-11-10 21:27:46, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
>=20
> The kernel cmdline reboot=3D option offers some sort of control
> on how the reboot is issued.
> Add handles in sysfs to allow setting these reboot options, so they
> can be changed when the system is booted, other than at boot time.

We already have a reboot syscall, do we need sysfs interface, too?


> +What:		/sys/kernel/reboot/mode
> +Date:		November 2020
> +KernelVersion:	5.11
> +Contact:	Matteo Croce <mcroce@microsoft.com>
> +Description:	Reboot mode. Valid values are: cold warm hard soft gpio


> +What:		/sys/kernel/reboot/type
> +Date:		November 2020
> +KernelVersion:	5.11
> +Contact:	Matteo Croce <mcroce@microsoft.com>
> +Description:	Reboot type. Valid values are: bios acpi kbd triple efi pci

what is difference between mode and type? What is difference between
cold and hard for example? WTF is gpio?

> +What:		/sys/kernel/reboot/cpu
> +Date:		November 2020
> +KernelVersion:	5.11
> +Contact:	Matteo Croce <mcroce@microsoft.com>
> +Description:	CPU number to use to reboot.

Why should user care about this?

--=20
http://www.livejournal.com/~pavelmachek

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAzgW0ACgkQMOfwapXb+vLtxACguGpb6W0A79OaDxEhEh+8cC39
HncAniijxQbLlu/Vi/12nYkf21xNAQ29
=D5yD
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
