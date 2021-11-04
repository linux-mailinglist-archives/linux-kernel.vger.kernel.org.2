Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEA44516A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 11:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhKDKJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 06:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKDKJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 06:09:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F23C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 03:07:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HlK770t1Gz4xbw;
        Thu,  4 Nov 2021 21:06:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1636020421;
        bh=awT5bBlE5ynUwEEralGSrwt9ezjdXHOlQ81tJVY4khE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=isvl7dbJmKRaelsWXioQXmkjf4E7VBe87nOvKSM2A6rlPyoqNTtwQqcf287ZgGi8H
         TFhLjw3sPDYTJL6e2ZohJjVRbBVkZZLCZDQC8XcxIb0Okb/JkQlzHswyIzekKwttgE
         9XibYyZ9jvue+BTa2Ndb9qxKcmLlquDKBI+cLmS1IipOQpovJTRU5XSevFvvhE4C10
         S9RzEvj7SvIxomSXbDfalToOdErzRNwvpj2kawa8oBSRckss2kMCrHYIeavbWcBlZH
         6quyoZQzg4oGvcBQcyCb6+zw4ZrFjZi7lF0N6mRhX4qV5BqCusjTKyR3UtotIu32t1
         tzL5isucUalcw==
Date:   Thu, 4 Nov 2021 21:06:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     davidcomponentone@gmail.com
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathan@kernel.org, sfr@canb.auug.org.au, sxwjean@gmail.com,
        aneesh.kumar@linux.ibm.com, yang.guang5@zte.com.cn,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] powerpc: use swap() to make code cleaner
Message-ID: <20211104210637.3c424bcc@elm.ozlabs.ibm.com>
In-Reply-To: <20211104061709.1505592-1-yang.guang5@zte.com.cn>
References: <20211104061709.1505592-1-yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R16OcEvAD708zS6cRq.O30G";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R16OcEvAD708zS6cRq.O30G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu,  4 Nov 2021 14:17:09 +0800 davidcomponentone@gmail.com wrote:
>
> From: Yang Guang <yang.guang5@zte.com.cn>
>=20
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.

So if swap() is in the above include file, then you should include it.

--=20
Cheers,
Stephen Rothwell

--Sig_/R16OcEvAD708zS6cRq.O30G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGDsMAACgkQAVBC80lX
0GzJQQgAg/kH3K8D26DLC1G83icbaaUB7A770GEvFjsQW+93XumOEFQQ/PW9y9Qj
SAWzu/UnEGWzoNcxNtrc5zB0IgOHqpg32KkwjK2R46p2h/SogfaWVXD3POrLwMMg
w1l2V/36ORlDTbURwwBuPU/790L7ZY8q82Xhhu6AMWcB4Za7TerOrrOhi4+uVP4w
fpCAP+6KFhUyHwIvS/uK7AH7BwEugJSjk07b4A6hGwlx/AoloQFIkdmTXZ1jLHkS
AVEeq7x2dD18junmwjmXJe09HLEAuqNccA3uRLCS8gL+3tq4iPTc4+bg5lslznis
sjJ0cFMBlDbJSaG9hiEwa1IqoOHMvg==
=h+K3
-----END PGP SIGNATURE-----

--Sig_/R16OcEvAD708zS6cRq.O30G--
