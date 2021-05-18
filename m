Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F2D387842
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348954AbhERMCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:02:11 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:42779 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhERMCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:02:00 -0400
Received: by mail-lj1-f172.google.com with SMTP id w4so11206324ljw.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent;
        bh=uBxbKGfrk+AmQm28DywmEhOcHQjWh7Z3o+Ie5/RNxxQ=;
        b=bdMp19AZ4532yWSvVgAiWVlYlC+h2KZNP+N8Mo5h/C5wznVjzd+HsROQduSBW9hM/J
         R+/H2LCAy1aDRi16af5iqrtUFBTPTi9v4IkbBLag2Gila0WpTtBgrDocTh9jTLXpcgXB
         dwChXfwUAm1RFBYYPZVxqhtFJmKSDA+gc+s4BhqjWueGxlpJr2ACk5wynnB5mNhV8USk
         7KvHVSv5OmgABeCmWWaFUSQF2jHxelkhmrNFwVty01uQrF4fTZ6u5NkomoxtTf/bomrM
         xf3eKe3Z42qISgSeeMWvLcdhk2HKxo6keJq9+iOVHOv/OJModstA6eCrkH8BgRAVFCfs
         ghCQ==
X-Gm-Message-State: AOAM530b3RaK+qtgqAOwx3zoJYjZauvQg4kmJZbDaV5rdQB+K5tXccV9
        Ea3v2Eojw0395bugMf8JV7s=
X-Google-Smtp-Source: ABdhPJxb7TI1YPMjjf0KcKqyR/cg9cN0a0RjkhqgPqxvkWfJfAVEfJ/fJBZX+tW2+opg9FMY37BK7g==
X-Received: by 2002:a2e:a58f:: with SMTP id m15mr3832442ljp.212.1621339241854;
        Tue, 18 May 2021 05:00:41 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::1])
        by smtp.gmail.com with ESMTPSA id y13sm2263731lfl.252.2021.05.18.05.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:00:41 -0700 (PDT)
Message-ID: <b9a088966bd7306952e4288ff900067029762bc3.camel@fi.rohmeurope.com>
Subject: Re: [PATCH] regulator: bd71815: Fix missing include files
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20210518114843.1495152-1-axel.lin@ingics.com>
References: <20210518114843.1495152-1-axel.lin@ingics.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MtT8W99nMrpNivyPCaKd"
MIME-Version: 1.0
Date:   Tue, 18 May 2021 15:00:34 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MtT8W99nMrpNivyPCaKd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


On Tue, 2021-05-18 at 19:48 +0800, Axel Lin wrote:
> Include linux/of.h and linux/gpio/consumer.h to fix below errors:
> error: implicit declaration of function =E2=80=98of_match_ptr=E2=80=99
> error: implicit declaration of function =E2=80=98devm_gpiod_get_from_of_n=
ode=E2=80=99
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks Axel.

Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>



--=-MtT8W99nMrpNivyPCaKd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCjq+AACgkQeFA3/03a
ocWwvAf/cduUv+apxQdafm4F9S/mcJtqxLb+8t+fC1gIIV3HVYC5RtZ4cOSYJeCr
zqmByNeXCsPMny1SX5KztgBE8HpPctZD8xUHfHBJsMhdyavU26ndJFgrjeAffeS+
379mYuuUBlJ4iFPl6C2YfkIGMGp7URg9Ee03DfF+zZGq7Q6KUl9txcAVlqzcNCag
NQzFDZFSVpSL9p0ZACeaGGLFGaoS7RXz+whCy15hausE4jsM2rUyeD3ZK17aX+vd
TZwLWxzwnZ10vB10gnD5KnyYHiUkTnhPofdb97S46ru+hgQrs+6wdcr7Uh+D2NiN
vsjsFSQEIk35j86OqOyw/G9RpzH57w==
=wYG1
-----END PGP SIGNATURE-----

--=-MtT8W99nMrpNivyPCaKd--

