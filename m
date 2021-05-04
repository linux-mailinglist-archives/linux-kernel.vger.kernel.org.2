Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA6372ACA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhEDNSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:18:15 -0400
Received: from www.zeus03.de ([194.117.254.33]:57766 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhEDNSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=QoW21j72oKNdkevzN53Z3SSjcRs5
        L5FcS9q3QcCSIjQ=; b=0yU4phmuc1eAcLKZpAbXxf79ecqurTqkHBBxBTkHGao6
        3BHdHng2EaMEr/Nvi/vYNnr3gCVkQR014SyOVj9QZMt7j2IcG2rFpRmrWb93qGlC
        egK8InrkDBNwFd7wHP9KSLceuDPQX9ysd/7SoSdO+WlCraOji3s9Cm4RErS31wE=
Received: (qmail 1373174 invoked from network); 4 May 2021 15:17:14 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2021 15:17:14 +0200
X-UD-Smtp-Session: l3s3148p1@PlWK5YDBUo0gAwDPXxOMAJUzfx/HAvHg
Date:   Tue, 4 May 2021 15:17:14 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: samsung-laptop: set debugfs blobs to read
 only
Message-ID: <20210504131714.GB43834@ninjato>
References: <20210504123139.45101-1-wsa+renesas@sang-engineering.com>
 <CAHp75VdqEa+mRDzwUVix7bY=2R=O0WOwXuLjv=mE4MGGOobYBw@mail.gmail.com>
 <20210504125130.GA43834@ninjato>
 <CAHp75VfHsMg78vTxEw910ez+28OeNEhzwUQehOHkZxAqePkadQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <CAHp75VfHsMg78vTxEw910ez+28OeNEhzwUQehOHkZxAqePkadQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Linus has (had?) a strong opinion about it. My point is to reduce the

OK, I see. Thanks for the pointer!

> churn since two patches fixing the very same parameter in a row seems
> too much to me.

I'd still prefer that and having a seperate patch fixing the whole
driver. IMO better than having a mixture of octals and defines.


--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmCRSVoACgkQFA3kzBSg
Kbb8ew/+LTJ2JUtey67y0nONa9iGb1qerwMH7OJbVmzzUov0n5p103YktKSdfOAz
HUE8nqbQV0UdqeIaQIwLjNHds+DLurdcvmOBwt253ajOCBpl5gtnjohmNfN72DQJ
bQJUN2gSrkKGC5Yh3wQoyZSmOJZ7uISzNlfAwda87R2hn8XqBs+pZh6+j7BEoChc
drJagjPd69uSxLpbfUflKy96T8SUAiCrzD0fHHwu8tiGwMCqv8Yl4Ld2pwB2SlPJ
6fqr8oq/bu5EymIEJV2dbnzC/xP9dE/96JCdu5NN4NFgC30p+xIb1hyvxyqi6ckg
ulXAyTkN285j0NkkNYsn9mvKr6EA/XsEw9unKC3eXiTv3jThCPs+ojU2wHdBtqU1
g40vOrlt0X6u08V5Y+joOOJuWcnFDbbb0NRzBpJoApciGroEJM4bCstzUNlGfAGg
+zRcPSutvvQnIUt0j7aqAzDEknnJ9TWRm1y9n8uTABShKUanW+Pa4Nc9UwnbD8o+
pMfuACe5MA+iE2sMTo0pB6wp7yNNt+EAi9v6pdYNU4LFmzXR4QfDoeh6zVBelL/X
0DyTnaQ1umB6c7FgT6chlfEdwS9zUwBsTcdJ4DaugPAg42LxvHTPvenLsbPGlaYY
5Aq4atpSeD5dVw9gpkMZNaoZcRSrCfmrPMrd70nxApa+k4CR7Ts=
=7Lqw
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
