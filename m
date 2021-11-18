Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000A34551CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 01:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhKRAnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:43:20 -0500
Received: from smtp.bonedaddy.net ([45.33.94.42]:40128 "EHLO
        smtp.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242026AbhKRAnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:43:14 -0500
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Nov 2021 19:43:14 EST
Received: from localhost (n49-190-249-147.per1.wa.optusnet.com.au [49.190.249.147])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pabs3@bonedaddy.net)
        by smtp.bonedaddy.net (Postfix) with ESMTPSA id E3476180043;
        Wed, 17 Nov 2021 19:32:45 -0500 (EST)
Authentication-Results: smtp.bonedaddy.net; dmarc=fail (p=none dis=none) header.from=bonedaddy.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonedaddy.net;
        s=mail; t=1637195567;
        bh=VS917qWGTSuuIA++0nFAHDygZRVz17R9nv4XhK4y60s=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date;
        b=aYJDabHkd0bol+RdUU5mqXmTe6XyOxIptbW7oxafXxErCA8dquJtQxQR6ymKO+xbw
         mecy45wnmgt2yGpBmfyx8kkfjr6jS4FOLXticveHlnIYfdodKpbow7cAVlSRLMSyyR
         IvEKCdZP/cgUGdp9lipqZHFlTDIpf2J3p0JV8yVyszzfRXTrdsKKrqgZtZBy5zMkxv
         Ik/CPyIP5xsQW2cEzkQPM9YEnFkpA3/L53ls5DPoRG0chBUMPxXPtfSnziQHFBqZ5P
         2gzkNOezyjm7Qk63NnrnQg36HLMzKaOEqpfqKJA+85tJ2EGi6/Zf5ZYx+rJJ++DX5D
         3EQwsA7a8bziQ==
Message-ID: <b82c6441832477653dfc4c2556b81b29bc1c75fa.camel@bonedaddy.net>
Subject: Re: [PATCH] tools/lib/lockdep: drop liblockdep
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Sasha Levin <sashal@kernel.org>, mingo@kernel.org
Cc:     peterz@infradead.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20211112151602.1378857-1-sashal@kernel.org>
References: <20211112151602.1378857-1-sashal@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-pwDPWNJtCAwnqfPeIZpF"
Date:   Thu, 18 Nov 2021 08:32:03 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.42.1-1 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pwDPWNJtCAwnqfPeIZpF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-11-12 at 10:16 -0500, Sasha Levin wrote:

> TL;DR: While a tool like liblockdep is useful, it probably doesn't
> belong within the kernel tree.
...
> liblockdep should continue living in an external tree, syncing with
> the kernel often, in a controllable way.

I read that liblockdep and the lockdep tool are moving out of the Linux
kernel tree, but couldn't find where they will be moving to. An LWN
commenter suggested I contact you to ask about this. Thoughts?

https://lwn.net/Articles/875135/
https://lwn.net/Articles/876262/
https://lwn.net/Articles/876291/

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-pwDPWNJtCAwnqfPeIZpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAmGVnv8ACgkQMRa6Xp/6
aaP8QxAAuzSYsCkQC87JrtClniJR1szSdWWQttJtc+ewNzs7W+tNNjIq7qkHZ09h
GY0dwaqpFmkScMEtq+fdi72GVVi+dole2vd3mUMs+yIVhHlwYSEDNLV8iswoZB8y
5vTwjrmX/9NcLkYlAKaGBfMfKnIAgC3m8NCf5ACrMRfcPv7wGjaHikgubZKwnbY9
j2orftsJI7dmgE7WqBcsi+LT1N8vet0g9Ykc/Dw7pSXG6qzRLdBNZsQMbuLecYl1
Bk0oB7xbpe6+l3o4WJ/QPSB54jFFtMyIu33OyOYlBKsqizWgT4fvsuBLrskhsg1f
ZOUlmnjxUKqedluqXiAcFVXadzAuKGJORZa5CcgGb9lco8SKPHApkuNDw9ZAAlUa
LsqCz4S8vz4+/y7S+b6ldXnfCS34XaOxvCr388cGngXe1lI+/DQPVPOA4JqsCFi/
0e0WaXJWI8PObskyyMJXcN612+a3AUj391/RBRh+m1YMvFZuSg6OlxLaSZiN33l/
j48Rx0XYq+SaMK+AniskSbccqIhe/c47MtUCAFL7XSpyfqfQNgp4y85RHZiAIwum
FlcCEKHFN/lCX6EMaQ5E+IeNIybR0OfK51FU8EE5i0KdqQ4+Wy6zHENsPKEfBTEt
Y9qSzdfxlfdsAcF3IKOChRjtyyhISF/dFAp+yRlTCcsqKRkOqz4=
=ZiBm
-----END PGP SIGNATURE-----

--=-pwDPWNJtCAwnqfPeIZpF--
