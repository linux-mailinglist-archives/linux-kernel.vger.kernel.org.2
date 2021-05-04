Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63B372F93
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhEDSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:11:41 -0400
Received: from www.zeus03.de ([194.117.254.33]:38946 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232223AbhEDSLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Y34wyRaSh3zmhZ3SGxDBw5N6OS0q
        BKtxcch6tx4BtGs=; b=BjVd7TSZ58IFtBo+B4VnXqV8RD8loGwGDcqKHMm5S4P8
        /9P1MXFvasFfYwC0w6Mc5fqb1HeuSrgk0Pw+60P6+OiRJk8LieWwCisNSWSx73k3
        l6hJvmgEaRVdbS2UtzEKbyzizDAEyFopmFs5FEXP6si9qbhGKZPJlX0ayatAa2M=
Received: (qmail 1458253 invoked from network); 4 May 2021 20:10:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2021 20:10:40 +0200
X-UD-Smtp-Session: l3s3148p1@B1Pm/oTBwo8gAwDPXxOMAJUzfx/HAvHg
Date:   Tue, 4 May 2021 20:10:39 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] platform/x86: samsung-laptop: set debugfs blobs
 to read only
Message-ID: <20210504181039.GA58737@ninjato>
References: <20210504170030.58447-1-wsa+renesas@sang-engineering.com>
 <20210504170030.58447-2-wsa+renesas@sang-engineering.com>
 <CAHp75Vc8OGDB0=ta_GLg3Bjv5NK32dMuuaPTX-ETXRDHtRpxnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <CAHp75Vc8OGDB0=ta_GLg3Bjv5NK32dMuuaPTX-ETXRDHtRpxnA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Not sure if this should be the second patch in the series (sounds like
> a potential fix).

Not a fix. The write will be rejected anyhow. It just looks strange to
have writable permission when there is no proper callback for it.


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmCRjhoACgkQFA3kzBSg
KbbQjQ//cKah7zwcBF9H7KvEyZ/rLJyL/7HF6uGe3gKlVjogj4ND4Xi4ktqb979W
QTLVgi5y+zAt8Kl7iH98Vpx/hAb8FBrpOVj3xsHh2WxYAubTJLqe/v/1bfgU6/5g
ovXLKpkTa5IVOUm6u7fCFlXht42ZwSf6ZoJYUf60iTL4xlqD5qbtKi2UIiqs4HkE
9F2YlbBvrK6MYFx9q9eVBa9DT9WUtFzv4mWS433FAOvqdaYPyCIxHWPgEDlFCOby
vzx+NmOVevSbyrAWIiy0MjNuLP0YUQU4HXe+n6Ba/FHQ6COTzHrojR14xgQSJd6+
G/CwRTwskKgD5rCY2kfa101Ind8ZhzCcMbDjfL9pYhDwhRFL/vNBJRmL081np2L2
e1o5iqT/5ccYz9qEQiukw0iYq1402pAT3serRNW6amYnxZcNYBFLmr4Z+o7P/6qh
spmJpROhxQjShviQozeqMlFR9Or2kbjQH8mwPppccL2mn8IUXO1YvfDirG/xO7ua
uPK3FhNFk6IODQ5c6miFE07kK2y6mN35FWTgEayOSt6MsDg6ppYcVZCgtJ3OhdV0
v6ZLCECtdgvpEacReaDqVrYOVeoQ4Ok7zKb4OkrekEEF1nlpVu2cl3i8DptslBj4
v2qB543sYGCqi4lyFDVpvYoEuM08hsQpZZpCCSS7VIhWTenuFCk=
=uUfh
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
