Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B2531721E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhBJVOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhBJVKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:10:22 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94271C0613D6;
        Wed, 10 Feb 2021 13:09:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DbXSx6ckVz9sRf;
        Thu, 11 Feb 2021 08:09:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1612991378;
        bh=T37OReoOydFbq4unal8lMB7zx6wTkEScGSNlSPw6ilw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Au/K03MmTWDwkNwgXpRYwXzNdKD5CLmWC9iMkxqcsCtod8qCqUNeZ83ml6swojmRW
         rorY8TZinRrvQAMGvGGqJByedWFJdW2tfwYh8U/M5NH3F9i/abWsaJZZAN2RCGKrzS
         loPz7nQQPlsXJdu7MKck6V0445fwIM/EpHtG/+04N+bv2wK+FvkvC04HYA8mGzopbd
         2xqVAANOtZn31q610PlpEyAtCIVMzdTrSFGYmgY5Bq6kXQtDPM71q/bCZ20nWdSPTO
         0rRKjMV3biyw+dpGji5F9UnYndc+i4AbvkFRrhfKoZjUa5k5+G9CIMLaQxKcFMh+16
         GJemgs/eqze2A==
Date:   Thu, 11 Feb 2021 08:09:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: irq: Fix the return value for of_irq_parse_one()
 stub
Message-ID: <20210211080936.7c51b99c@canb.auug.org.au>
In-Reply-To: <20210210200050.4106032-1-saravanak@google.com>
References: <20210210200050.4106032-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9VHlBQTTpR8AbkOIrHYbqOp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9VHlBQTTpR8AbkOIrHYbqOp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Wed, 10 Feb 2021 12:00:49 -0800 Saravana Kannan <saravanak@google.com> w=
rote:
>
> When commit 1852ebd13542 ("of: irq: make a stub for of_irq_parse_one()")
> added a stub for of_irq_parse_one() it set the return value to 0. Return
> value of 0 in this instance means the call succeeded and the out_irq
> pointer was filled with valid data. So, fix it to return an error value.
>=20
> Fixes: 1852ebd13542 ("of: irq: make a stub for of_irq_parse_one()")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Oops, sorry about that.

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/9VHlBQTTpR8AbkOIrHYbqOp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmAkS5AACgkQAVBC80lX
0GwRCQf9EBXY8yx+s8dTbRHzyMaTzfcM8yWhayyA+gpPCBRi2K98HHe7Ru+ayJVP
u/YA78f3rJAG9IRa6EfZNGPRvZMeEJRuK1QuRdXX9CpMOXx3TIEbHTZI7cD6bpCk
n7VQpyWKB1tZV4SEC/UYofIZB+R3mgdn/6xGS16oMvLrwE4UEiMBRUeq9may8pia
hKe/K6/Tg0a3owfPw7JvLtIiAA9qQiCo9VAGV3y/35Jlu3+Ht5IA+YT1m99ljVxd
c5wFitjJNPdLSyYCIzv0cmbuBjwzWnlhrWz0G3oVq9OchSGyJnwciiOgZT2Mp6Wx
1ULk877lV3YLLd6Xj8RevOxm7lzibw==
=ddxf
-----END PGP SIGNATURE-----

--Sig_/9VHlBQTTpR8AbkOIrHYbqOp--
