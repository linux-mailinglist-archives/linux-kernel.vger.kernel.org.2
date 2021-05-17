Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84B1382951
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhEQKHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:07:07 -0400
Received: from www.zeus03.de ([194.117.254.33]:38108 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236042AbhEQKDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=/FxvbSuKC1tmr9/+95uisDIUwuZu
        1r+6F20Yx4PySKw=; b=AgHOb03L0EvWeU3YMajBBb1smLBdbUYpODjjrJ36Z7x6
        nqAQRYctI4C/CUUTj8IT+1gDRmnYnS8hGJtgBHSG2JqwSEU2PHZjUb+VgLu+RfQq
        xPQLJMBME0JAaC/M8qxBlUGBSS+AfKQMTeoIPFXQJ9MYs0sZJdlfODnH0EBJU2Y=
Received: (qmail 2469005 invoked from network); 17 May 2021 12:02:12 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 May 2021 12:02:12 +0200
X-UD-Smtp-Session: l3s3148p1@r7iAr4PC7rggARa4RYY7ATBvQ5FTVwg4
Date:   Mon, 17 May 2021 12:02:04 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] platform/x86: samsung-laptop: use octal numbers
 for rwx file permissions
Message-ID: <YKI/HD7qZB6Seh/+@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20210504170030.58447-1-wsa+renesas@sang-engineering.com>
 <CAHp75VepeO6-A9-xJqjpEDZa0XDyNbat0PBrtrgFEgJ4yxh4kA@mail.gmail.com>
 <CAHp75VdSv4Ja7+bjPDvOawuv1ukhKZ==bjQ_MQbNPUds_7mVZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AuwULfkSGg+bPGLa"
Content-Disposition: inline
In-Reply-To: <CAHp75VdSv4Ja7+bjPDvOawuv1ukhKZ==bjQ_MQbNPUds_7mVZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AuwULfkSGg+bPGLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > -       debugfs_create_file("call", S_IFREG | S_IRUGO, root, samsung,
> > > +       debugfs_create_file("call", S_IFREG | 0444, root, samsung,
>=20
> Actually you may drop IFREG as well as debugfs will add it if there is
> no conflicting file type defined.

Oh, I missed this back then. Quoting only relevant parts of a message
helps me to avoid that ;)

I will add this, to patch 2, though. This is only a plain conversion. v3
coming in a minute.


--AuwULfkSGg+bPGLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmCiPxgACgkQFA3kzBSg
KbZfAxAAn+fNp1VOJnan7vF9NWywThmWildOGGMg40sGFK7hS1TCQS9sEgzXpXAo
wMm0HKPlLRCSS0K+7KJNnMIOP88tJz6gedVJE6lCeookcUVtyR84tsg6w7JsPONN
z+U0CyXszO7PXj17huNUb0J1+sstu0q/ZcmiCIFEjcHAfmKTFffCYxU6GjCkdNek
QLRq9v9qfgb6B+YfVSkF4Md0knusaOjxQSqxxT7Pzv0RM/9ptymd2MFSDYBrKi8/
xcuLM0wk/d88AE7ijOYGCD2Zt0Eaa8ZopgEB93QtAQOS5qf4GpLOew7HHfVZ5twp
vacvF2s920DK3ZSkHluqY1yQ1Lwwcciv3FcnlULi3ZnqFP83HY06j5PTUnjgMzQh
Sn7ueRnnNKExi60dP/PpcOtC4yJKdbFVk+lcS7OGPMf4VQMFbow91Wv+IsgtGc9W
V5CErITA2WBRuAO98o0uHC2JAjVKu990CopWAE4N48D80WLK5Dbd8go8RzE7CSss
EE59l4tkhCA7cwPPffWldor9aoLlJV9eKD08+RpIBQtSvBfPbHG1ED/m77xtTZKK
YKGso2jKiw1MFzMX0BlEDwC+wfj6Zd0ln73mu++dOydcvkM7asre1j6vJi5A/584
GUV36prkavJpi1qfcxQHBNevHUfLeKSOeFNUhpJ/YtqLQfPXkyw=
=AH4s
-----END PGP SIGNATURE-----

--AuwULfkSGg+bPGLa--
