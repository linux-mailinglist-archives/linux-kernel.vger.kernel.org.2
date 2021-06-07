Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235F639E815
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhFGUL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230502AbhFGUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623096604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQ5xpMy9H3ySDeawEK3lsKg3g0iHKCavSdZYio+WCq0=;
        b=e4CG3u15mIqqsbK3PxTzj0YJcj4zDFR1Ee5K1KeLzyP8NsONufFnnDejUHDsuCHZhHFhVF
        QQdZPPMzMoamciX4lAJTB82Wt7vKe/2SA3A4+R84FOCxG2wZfg3PuRO4PFeud3BtW8k1rM
        KgeWZ1UvsfgTht4pZCMP9T/XRMuLLEU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-xpdB3_d3MAathVpqMygi8w-1; Mon, 07 Jun 2021 16:10:03 -0400
X-MC-Unique: xpdB3_d3MAathVpqMygi8w-1
Received: by mail-ej1-f71.google.com with SMTP id p18-20020a1709067852b02903dab2a3e1easo5748638ejm.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 13:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=UQ5xpMy9H3ySDeawEK3lsKg3g0iHKCavSdZYio+WCq0=;
        b=qx2lhLsh5Aaov+FS6TMgSXoKYuWfJYvngTDaOlnu/jc0gawmc3SNKNvQVuUbmNM5Aa
         8XdcubaNpnYoFhf8mTs1iXR3cRScmnna2ieDOn3TZxZJAB82K/J2d1Xvigws7TyHbZOL
         RcypS1WPdj9LytB18lIx1/kpgZ3+mZZE5LSvsEnr0fDhQ5M2ZZCUfCrAA+e+ncsMSHhl
         igsn6XF7W7cEX8R5EJqMb5+/k6qlzWC/1DWIh2ZGm6bYtCX1n4TUyo0LuuE8tvltKlBB
         8/i4C63CpTG9ktk7kVev6G1Wss0tiy+/2BKgSewAhaj7aaJuKIRoLqEaHxU1JfkcOcqd
         eGZQ==
X-Gm-Message-State: AOAM531f9R5M1pfdD44WA6k1tR+k2xKQQ1H68izK085LA//iV+fqmlr/
        Y2Rna2DWgm/RfdjiMT7TFV4ea5j9GZm1XbIMWh4hJq77SAdX9TNPontAChOqgymIxY/xhHwGmhO
        u0ukA28dXYMd1zVDAkLc4/GU2
X-Received: by 2002:a17:906:c1c5:: with SMTP id bw5mr19551909ejb.552.1623096601846;
        Mon, 07 Jun 2021 13:10:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNyRGdzaq1Bntlewz/0qhpVhYXvvvnlZFiggbB41dNcsyIgSwhAu4EO7OprHiUzo0lP0lQ6w==
X-Received: by 2002:a17:906:c1c5:: with SMTP id bw5mr19551897ejb.552.1623096601691;
        Mon, 07 Jun 2021 13:10:01 -0700 (PDT)
Received: from [10.0.4.217] (i59F776DE.versanet.de. [89.247.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm6810338eje.81.2021.06.07.13.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 13:10:00 -0700 (PDT)
Message-ID: <4a76d2152f016b58298bec16aa2003a6ec55f8a8.camel@redhat.com>
Subject: Re: [RFC PATCH 0/7] usb: typec: ucsi: Polling the alt modes and PDOs
From:   Benjamin Berg <bberg@redhat.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Jun 2021 22:09:58 +0200
In-Reply-To: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MwjrE0nA8w0YwPPjLjiH"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MwjrE0nA8w0YwPPjLjiH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heikki,

On Mon, 2021-06-07 at 16:14 +0300, Heikki Krogerus wrote:
> This is the RFC series I promised [1].

Cool.

> I'm sorry it took this long to prepare these. I had to concentrate on
> other task for a while.
>=20
> Let me know if you still see any problems.

Hmm, I am not sure this got better. I applied the patchset on top of of
the 5.12.9 Fedora 34 kernel. On the machine in question (X1 Carbon 8),
I see the online state getting stuck at 1 occasionally. This can happen
for example when quickly plugging and unplugging a USB-C charger.

Benjamin

> [1]  =20
> https://lore.kernel.org/linux-usb/YKT3oEt%2F9fX8k8mw@kuha.fi.intel.com/
>=20
> thanks,
>=20
> Heikki Krogerus (7):
> =C2=A0 usb: typec: ucsi: Always cancel the command if PPM reports BUSY
> =C2=A0=C2=A0=C2=A0 condition
> =C2=A0 usb: typec: ucsi: Don't stop alt mode registration on busy
> condition
> =C2=A0 usb: typec: ucsi: Add poll worker for alternate modes
> =C2=A0 usb: typec: ucsi: acpi: Reduce the command completion timeout
> =C2=A0 usb: typec: ucsi: Process every connector change as unique
> connector
> =C2=A0=C2=A0=C2=A0 state
> =C2=A0 usb: typec: ucsi: Filter out spurious events
> =C2=A0 usb: typec: ucsi: Read the PDOs in separate work
>=20
> =C2=A0drivers/usb/typec/ucsi/ucsi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 317 +=
+++++++++++++++-----------
> --
> =C2=A0drivers/usb/typec/ucsi/ucsi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 3 +-
> =C2=A0drivers/usb/typec/ucsi/ucsi_acpi.c |=C2=A0=C2=A0 2 +-
> =C2=A03 files changed, 183 insertions(+), 139 deletions(-)
>=20


--=-MwjrE0nA8w0YwPPjLjiH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmC+fRYACgkQq6ZWhpmF
Y3A0dQ//fF8Sa9KqO64UQxKOGPoxvIYm2XOKF+kHnJw/x6cMOXoJC7l0iHUAhVaK
QeyMmpH886ivLVwsFj2wW9nUL9jT8M4iGOqlW5PNku4li0yanl291M6lBAwL7VMm
iQAqsDaP66ARdcoHK/Fj6lauVmPzDQEsRcWkRx96hHLjbYX5H2EsOGLOpuTIKKaz
dWPV4NTY9TWjD8t4yBkwc5mVQULalYlB/qnofbFsHqujCdN/pyGQ4gSGeBSQKSnE
xV6ko35MyGwpeN0bxu3V2ga4+KLyKwdWx0GBo+qdELmSfJQGe4Lk5b10AePd2MA2
ZSH2jiFdySHz6kkxOZgYSlAonNFBq3zYSgMze9MrK5GWUAgknnH264Y0dE0HQ+cS
89AsOq2iOFP1D8eC+AZpI7Zofbh9RkmeHoDXQk2tXCRKte86G9Eb1G/zrAMxJIme
l/SzVDOuUy4SbHgppkhS9xCTX8S4vUczRx2GeHtX1HGl7seKzYLUtx/TlJG1Cz2h
klK+oZN/TXMmPkrDlIQK4UpF61+UkgqayfpD0wGEMYX7U1CIOVYS3pnXSvI/7w4V
PPeqCsKDj5+VmX1IU9X77/+tTavjAAI6jAw/fczgiaJebiM6YGdHODmU1ke7i72t
cdHPxELHcBP9aoJCmP2Cf32/SdKkaLEO9HuHJA++PhqqxqDJkyM=
=BuYK
-----END PGP SIGNATURE-----

--=-MwjrE0nA8w0YwPPjLjiH--

