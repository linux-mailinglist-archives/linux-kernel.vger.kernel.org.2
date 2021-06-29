Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7933B7139
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhF2LTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhF2LTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:19:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B926AC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 04:17:26 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id f30so38899060lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=co2MnmhqTunRm8w19zQP35XSCvF/jJ76gA/W9GlIUz0=;
        b=JBet+L1/xGCXdWUkOprU0gLpjHcspyWMX41k11zgcAWXmzhI9gm3YIixLkNTJlqVB/
         XcWiFb1eTuuQ0kZPvEkUrb3UuAcYdsKHD/D12Eaov5Lzyd9QnJCwNNchJ8ukHTIasmKs
         SFGy7bdYdELyUi/4Cs4D+h5baTLqNvlmps9/xqsI+9OHQKc8Rq13MEKERP9VFoa5IgQG
         W+ULAaQCMLpup1hbsAmWwrAshrxJwNGepLcM9rge/JvfV2nG6weCZl5M0tIBdw+xf5i9
         7vS+4WIflZLG5RqKPfZoLlErqKzj99hms0mYKEi1B3mu0Gv99P1J6P91mtxFB1BPzUWQ
         zw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=co2MnmhqTunRm8w19zQP35XSCvF/jJ76gA/W9GlIUz0=;
        b=gUeMD1PBH4LIzbVIjhGMDLa+epunFOucVdmeoBZV+S7MBfAC5bAgiOaQQybhU95wAE
         R+T4zfdfKqlc2ga55L6EBMP/Ak1wGDwXWCBR+5s64P55BDvX8nQyVaCll3QU/qOgSRmw
         SJDMoTxJFLbWvxeQklNKlzo1gj/CcCskyyNI0OQxyLQN/DgUtDdJ44tmnnSZYkswZfxz
         H+ykjyS4MwemWeqOcPTyqgvvCJ5P9UJgyxpK1IN5AYTP3hM9K9KqAs4B5p1FeXLK+wEa
         tHBLnR6CFwPCUUcvWsRh+DcqYmfDdMKJ4fIoQzyt75m/e7J6zZhz2v33/NQFFJxYhFwi
         uQJw==
X-Gm-Message-State: AOAM532sTCqCJIAdbNy0bnwkFLAV79aM7fJn4RQNhGFJBlI0Wl69LmUK
        ELlBV14mU+riYxbTrl/ErkI=
X-Google-Smtp-Source: ABdhPJyGUNfsY7ynhRA9iabVuy2UenX5kT6gcct7E/4hF5q63/J3+g9SwmUC5LFXj4H6uuIg3SuXrQ==
X-Received: by 2002:a05:6512:3305:: with SMTP id k5mr22335683lfe.132.1624965444978;
        Tue, 29 Jun 2021 04:17:24 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id v19sm1848185ljh.118.2021.06.29.04.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 04:17:24 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:17:12 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        amd-gfx@lists.freedesktop.org, tzimmermann@suse.de,
        intel-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, rodrigo.vivi@intel.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
Subject: Re: [PATCH v4 12/17] drm/uAPI: Add "preferred color format" drm
 property as setting for userspace
Message-ID: <20210629141712.21f00c38@eldfell>
In-Reply-To: <jIDQ2rRRMWlhDDPf08Z8xZlEE8HTBx7fHsylFdK0joSSFVyES8D444Giyiji9zbIm7dU4QpbsXZLvIDTbGW0wEoUWKsMEI4evizn0UdGMvM=@emersion.fr>
References: <20210618091116.14428-1-wse@tuxedocomputers.com>
        <20210618091116.14428-13-wse@tuxedocomputers.com>
        <20210622101516.6a53831c@eldfell>
        <jIDQ2rRRMWlhDDPf08Z8xZlEE8HTBx7fHsylFdK0joSSFVyES8D444Giyiji9zbIm7dU4QpbsXZLvIDTbGW0wEoUWKsMEI4evizn0UdGMvM=@emersion.fr>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LAj=Yh72UIUuJMQi5B=dyga";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LAj=Yh72UIUuJMQi5B=dyga
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jun 2021 08:12:54 +0000
Simon Ser <contact@emersion.fr> wrote:

> On Tuesday, June 22nd, 2021 at 09:15, Pekka Paalanen <ppaalanen@gmail.com=
> wrote:
>=20
> > yes, I think this makes sense, even if it is a property that one can't
> > tell for sure what it does before hand.
> >
> > Using a pair of properties, preference and active, to ask for something
> > and then check what actually worked is good for reducing the
> > combinatorial explosion caused by needing to "atomic TEST_ONLY commit"
> > test different KMS configurations. Userspace has a better chance of
> > finding a configuration that is possible.
> >
> > OTOH, this has the problem than in UI one cannot tell the user in
> > advance which options are truly possible. Given that KMS properties are
> > rarely completely independent, and in this case known to depend on
> > several other KMS properties, I think it is good enough to know after
> > the fact.
> >
> > If a driver does not use what userspace prefers, there is no way to
> > understand why, or what else to change to make it happen. That problem
> > exists anyway, because TEST_ONLY commits do not give useful feedback
> > but only a yes/no. =20
>=20
> By submitting incremental atomic reqs with TEST_ONLY (i.e. only changing =
one
> property at a time), user-space can discover which property makes the ato=
mic
> commit fail.

That works if the properties are independent of each other. Color
range, color format, bpc and more may all be interconnected,
allowing only certain combinations to work.

If all these properties have "auto" setting too, then it would be
possible to probe each property individually, but that still does not
tell which combinations are valid.

If you probe towards a certain configuration by setting the properties
one by one, then depending on the order you pick the properties, you
may come to a different conclusion on which property breaks the
configuration.

> I'm not a fan of this "preference" property approach. The only way to fin=
d out
> whether it's possible to change the color format is to perform a user-vis=
ible
> change (with a regular atomic commit) and check whether it worked
> after-the-fact. This is unlike all other existing KMS properties.

I agree. FWIW, "max bpc" exists already.

> I'd much rather see a more general approach to fix this combinatorial exp=
losion
> than to add special-cases like this.

What would you suggest?

Maybe all properties should have an "auto" value in addition to the
explicit no-negotiation values where at all possible?

That might help probing each property individually with TEST_ONLY
commits, but it says nothing about combinations.

A feedback list perhaps? TEST_ONLY commit somehow returning a list of
property/value tuples indicating what value the "auto" valued
properties actually get?

What should a kernel driver optimize for when determining "auto" values?


Thanks,
pq

--Sig_/LAj=Yh72UIUuJMQi5B=dyga
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmDbATgACgkQI1/ltBGq
qqcYExAAkwmMC2LyEGzVad5N3ja6Gax0qc3Wpe2Cw40DuxFKcr1j6wJ7AHT4Rmli
R334a3TJ+3OPRzjeDnw28S4Ycx3ZEDVgPQ7g0pVBCGfSGze1gCaJRGd3sUFQDQxn
OVdgRoP/sSHbOKylhXb74+UPYcw3MJfUed0EiPAZC9XE2gnxiv8tprcGkm6N0Xm3
WYzu6Ssr7VGzKGmVDGg0cyjHHVZ6aOwmk9vxgI2KAoqeIr4rxycR07qxGARik5XP
6GlZZ0s+zysJSPCwLu6gfDK//BhCGIdEXZ7wFp1k7Di5mPbygR/KJIa9rWmLLW7k
RUi+QFcdfnJj7JNOq3Zx99ksh3RTjBzl0PQVa7YyTl0uZbBCR0JKb7BXntqhCKRL
PY5ELnIRjezTDJ/9+gYQcnwASN7iyshKTXQAcg9aAmUz5u0pD8QcW/xC7+gq1MNQ
v06S4Is633ONw5MAti7FsdqT42FxwoNdaDXgZKnnJV9UW2s81yUUkKftw2d1krXR
EeWumEOlIIFqo95FCs9PW5PiAYMODq3tukBkaJyZnTf1rX7bqfuf4Z9rxI+dFIsc
CKiql+ZpWTaJmp9sAGeaUcVtW52kiq4spGHRKct36Ahc1QeKsNzhmrmebHhAPMcB
Klt909YOQ1LqqP0SiDmTZQVvQ8qYeS2wViXZE0e8ezLgLUe97pA=
=9IoA
-----END PGP SIGNATURE-----

--Sig_/LAj=Yh72UIUuJMQi5B=dyga--
