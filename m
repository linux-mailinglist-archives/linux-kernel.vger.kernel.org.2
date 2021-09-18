Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FCD4105F6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 12:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhIRKuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 06:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhIRKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 06:50:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9A3C061574;
        Sat, 18 Sep 2021 03:48:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q11so19389953wrr.9;
        Sat, 18 Sep 2021 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=MU4kIxxMIxBExIJtSVF8R7Su9e74XUBdqKLR5SUf6Qw=;
        b=eaQ0lRr92UC4ry0qZshEmv0yDb1Rw+dWHQBRPKSR11nquRz9f+SATYrQL3DVBe9qij
         e6BLg/Ps9dUh4PZk+1wZIOjP7SWgxKJAYetcw0kOEkcPNTX8R3hocsre1mQosvmIUt7m
         hCYz4qR+BqFDhqhfiCZ+4kzNSfm64yxYw9gZ2Ei+FFEcWt9S+M1rKqdl9AlKdnr6aqfp
         6L8S9K4kk1Raxy5lAEBW6e/ZgYWxSQgb06DxMPssclxGsAudlJguwT100xVMASPzaV6k
         VJr8bx1ydFzNyNQg8bshrBHlfPwOFd0EK3agbIG09RhraHfxcU1LkCiFVIObqvBwV5RC
         /3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=MU4kIxxMIxBExIJtSVF8R7Su9e74XUBdqKLR5SUf6Qw=;
        b=WYo7A1hPvVsyji5ML2DZwCNcqux5AdrqOUeV3af/qjaiJQCAYbHAInjy7TcUXYxjiE
         dtgaJmFOT+hsRune0IQ6bqetdTQnsKS0lUvAEFJ/xjJYtc3qM6BbcjsO57pun2zkHbPU
         RtTybfayi0FF1fQzWIioevDoPNZePU0lnRMgRYoIvDomBNAFdWlKoZPwy/0wHy36bPlR
         MEFOM7D0Q4k3/i5ssOgjh8D5iXS0Vz2DjgasI11Xcz31dzCV1uHIWteN/tLp0VRN59Zw
         jwpsn9p3l31C4KpvdMEpPoekMPDxigg0UeMnXOetZfClD2MikJv45J+I4CNNpRAonQ67
         faFg==
X-Gm-Message-State: AOAM532ry5g/e/IcqsUIph+rnRJgkJ0fi39XvySehvtqpCQm/974z00S
        b7k8GOO2uTdOLa0myHEAbfo=
X-Google-Smtp-Source: ABdhPJykBid9mMlT5U7Xlu+UqlFELIhoRpofIn/8n+6tUXEdJXImN0YjID821v8FbU/YAuiOhHiesQ==
X-Received: by 2002:adf:e6c9:: with SMTP id y9mr17681333wrm.430.1631962124536;
        Sat, 18 Sep 2021 03:48:44 -0700 (PDT)
Received: from localhost ([2a01:e0a:3d3:9cc4:4624:564:2256:d6c3])
        by smtp.gmail.com with ESMTPSA id a72sm13744853wme.5.2021.09.18.03.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 03:48:43 -0700 (PDT)
From:   "Bastien =?ISO-8859-1?Q?Roucari=E8s?=" <roucaries.bastien@gmail.com>
X-Google-Original-From: Bastien =?ISO-8859-1?Q?Roucari=E8s?= <rouca@debian.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Chen-Yu Tsai <wens@csie.org>, Chen-Yu Tsai <wens@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Salvatore Bonaccorso <carnil@debian.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] [PATCH] ARM: dts: sun7i: A20-olinuxino-lime2: Fix ethernet phy-mode
Date:   Sat, 18 Sep 2021 10:48:42 +0000
Message-ID: <58294171.jumPIWX89V@portable-bastien>
In-Reply-To: <20210916110305.ehmaspxht4nnhksg@gilmour>
References: <20210916081721.237137-1-rouca@debian.org> <20210916110305.ehmaspxht4nnhksg@gilmour>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2254600.lUWymMvBDu"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2254600.lUWymMvBDu
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Bastien =?ISO-8859-1?Q?Roucari=E8s?= <rouca@debian.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wens@csie.org>, Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Salvatore Bonaccorso <carnil@debian.org>, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] [PATCH] ARM: dts: sun7i: A20-olinuxino-lime2: Fix ethernet phy-mode
Date: Sat, 18 Sep 2021 10:48:26 +0000
Message-ID: <58294171.jumPIWX89V@portable-bastien>
In-Reply-To: <20210916110305.ehmaspxht4nnhksg@gilmour>
References: <20210916081721.237137-1-rouca@debian.org> <20210916110305.ehmaspxht4nnhksg@gilmour>

Le jeudi 16 septembre 2021, 11:03:05 UTC Maxime Ripard a =C3=A9crit :
> Hi,
>=20
> On Thu, Sep 16, 2021 at 08:17:21AM +0000, roucaries.bastien@gmail.com wro=
te:
> > From: Bastien Roucari=C3=A8s <rouca@debian.org>
> >=20
> > Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> > config") sets the RX/TX delay according to the phy-mode property in the
> > device tree. For the A20-olinuxino-lime2 board this is "rgmii", which is
> > the wrong setting.
> >=20
> > Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
> > Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
> > the Ethernet working again on this board.
> >=20
> > Signed-off-by: Bastien Roucari=C3=A8s <rouca@debian.org>
>=20
> It's the third time you've sent it since yesterday, what are the
> differences and which one am I supposed to apply?

apply the first, my infra is falky sorry for the three messages send

Bastien
>=20
> Maxime


--nextPart2254600.lUWymMvBDu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXQGHuUCiRbrXsPVqADoaLapBCF8FAmFFw/oACgkQADoaLapB
CF9QWxAAguLfgRJtwGFHJiP1VFF7kzOq3ZDuBjsSV5h0SmJ/dgvc4PDmAbzZLEj3
ScHILpo1r3Pifcpqkv7WHpqhwryrW0dWqmUxHXgmKVaVJOZ0kVZnQYMkZ/fEA7Ei
rIZiRFVN7KHJOCKEXi9pOK3T3WJZJSxLbzEIdHKe5gT46i4HQ16FxaasVJlUqz5w
HFwOPqNpNDi/zu0yyXO4KzbhRbajKKvXLTGTmLNyQVANWEGr+iYnBMmk5Vr538xQ
Aua/tZkyPHtWV27hT3ombEkrt3wmGsALfvi4wo47/jJY8XfZjep80umhvi8M/zLY
h5cQ/bliw2kfAPzxo5cmz+atWk1ICygNNr2G449ZE+aQ9qnr9V41QgeR1ZLPwC1C
wxEd+lw/P651fSrhRxvStSO3HUhYxDTHbNRAbF7ZZ9uyWR1L8UKJzz5IhtDiLJ1X
eu2ddOfTMqAxFqiuMiflSc4/YKn0vZg9KtPk/cMRKFTv3QgsalO4di5JT5lykJM/
x+5RA5fe0sgoV6hlteY5j8mZkaoUwV/kaSWq604dBX/0y5asXO3NGmqtiSEwKaNO
ssRpDM/SZ5DKrNd9QPB4XeuecW+pAgw//wyt67AjrNz/4NTSVNzBgYCWUmmtMoUG
KOLUEUpociQD2R7F7UNkNPYWlOQgqI/zW+XjfUX9WOI51sT2PUo=
=nqzX
-----END PGP SIGNATURE-----

--nextPart2254600.lUWymMvBDu--

