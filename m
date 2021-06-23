Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB1B3B199D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhFWMN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230170AbhFWMN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624450270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkYp3LLWN5Q5TY6AlEvPE9OLWA8THWduAdr4xKTfq9M=;
        b=dsg4gIjmcM7fCBYgi5mWcFcHPwZunVeLIOyWME5FCbGt1cV5XjqfDOoQjQbWyO+BaobiNh
        lTG7On/IWUtpsU50l+PNG+w8Xnf477Fzip+TVidtZfyJrUc+zX0Ny0hutzXTJZSHFvwB3j
        lngtmZ5Nb6immRZEa5HsvxXzQSxPv9Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-ERFfe0uVN06ezbFLCkE1_Q-1; Wed, 23 Jun 2021 08:11:05 -0400
X-MC-Unique: ERFfe0uVN06ezbFLCkE1_Q-1
Received: by mail-wr1-f69.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso995552wrh.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rkYp3LLWN5Q5TY6AlEvPE9OLWA8THWduAdr4xKTfq9M=;
        b=YSKWYVopAZ7jv+HtfDHvVromhHXVo6OBJrGXhXLyCvj+HUM8zGq9rkV7/0OCblD3Et
         7Iv/zl/eaxC20FXCXMSvyXcUdgLAcTJAzLYa56ULgWhXG7jzYj/BDzWqzpdanK2Q2i8T
         e7PVnZXTMuv4PkwxYxAZ8qp6d3JKVoVPwalI1I6thzoTlE3bHv4NBHNiB2VWsKWHfC2z
         d3kMkZ/ASupJHrhyqL4a1yW7tY4Xb0g+8yhi4ZkHW7pG9Uu4RyQGTKuZpAUIm3YwCK0w
         Zh1sGnfAry/DrdBGYB5nXalnbj72jc8zX+9RIym9sziGmi+dZuYCg3CXTe+dX9uUHCv8
         AHwQ==
X-Gm-Message-State: AOAM5323OOLdv6FnZPQvPJYMzejb8c9ISyl4vCo8a+MW3ly2P/kQ+86s
        UPFURrmYJEf4loMCTVPd6RYCk62BAIvUF36REylKYZoiAa4n9Ikn8YuYSBUOgDLCVSrayZQg7rP
        ofbu548Q9lsVkMZ05NHOym/A=
X-Received: by 2002:a1c:5985:: with SMTP id n127mr10220008wmb.75.1624450264882;
        Wed, 23 Jun 2021 05:11:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyTUiAuyq6x1LsXIDbUkLanDbniN3nvIi066ic/Yjpf5+S8hl4T4Fw6JI/eT0m8lNHcnACcA==
X-Received: by 2002:a1c:5985:: with SMTP id n127mr10219975wmb.75.1624450264656;
        Wed, 23 Jun 2021 05:11:04 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id y20sm5356222wmi.25.2021.06.23.05.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 05:11:04 -0700 (PDT)
Date:   Wed, 23 Jun 2021 13:11:03 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: add cond_resched() in __vunmap()
Message-ID: <20210623121103.i2xpvhxqyf7wopl4@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210622225030.478384-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3bx5yvu2w757xdna"
Content-Disposition: inline
In-Reply-To: <20210622225030.478384-1-aquini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3bx5yvu2w757xdna
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2021-06-22 18:50 -0400, Rafael Aquini wrote:
> Like in other range zapping routines that iterate over
> a large list, lets just add cond_resched() within __vunmap()'s
> page-releasing loop in order to avoid the watchdog splats.
>=20
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
>  mm/vmalloc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a13ac524f6ff..cd4b23d65748 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2564,6 +2564,7 @@ static void __vunmap(const void *addr, int dealloca=
te_pages)
> =20
>  			BUG_ON(!page);
>  			__free_pages(page, page_order);
> +			cond_resched();
>  		}
>  		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
> =20
> --=20
> 2.26.3
>=20

Good catch.

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

--=20
Aaron Tomlin

--3bx5yvu2w757xdna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmDTJMoACgkQ4t6WWBnM
d9adUA//RZS30uRgLfgY43El1uG1oRgqrxUpEmqJrljrdAetNuuhOQZ+D2kX8Lir
vohwyAIvp8rhXVZCnmqNpwSnsfcNOg65jU3MaQteHjSrW6JmJ/+G+JBrbjcKYKcf
2BIhqf6VRRPBVJ3fnjXtg5FkZTQR/BfukLcXrQFDomeXlDVCU4IzB+9OMFrQlDag
OAHlwtgFI9nlAmhV+gEWl9kPWjaG7idj5U1/jgjQTeqcj1Wqk68msztbJCZs4hP/
BDCZcRyfWC0fpOzC/W01qzsmYtFacSQmS7rLOD7osKNgtN0aard7Po+qAI+Jvlnp
bbx/xGZaEQe/WcDacp28UXfAgKUTgHaE/pS/bLSWR9XktkUPQOZt6YhjygwZzIAE
r7SjAvUQwtqEn1RMsNP4Cp7a329ETn2rOUlu9+rYeQaO+8DrHmDvKcmIRkz+kpFK
OfjTiT6dxcUmuzd0dkPJ0F/jfWTYt82NN+HvsYc1Ql69fLUqIvM1wYIzJeeNesg6
Io1igNu6/QceVwXoGbsjSXLaPTuXxyiPxfGC8am7Ssre4j2/7hNEfYmAdf6MR6NR
t79lIOo47yXvI4591aXjigXtT288CCZafc0wXUlbVkWosQ1ircBWxGqzsGlGXCOO
5hTzUGoXHewhTsgrHw0ushszF7WJ/lzuujZGt43x4fXpkqWTe/M=
=UDj0
-----END PGP SIGNATURE-----

--3bx5yvu2w757xdna--

