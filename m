Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75971334867
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhCJT5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:57:06 -0500
Received: from mail.archlinux.org ([95.216.189.61]:59408 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbhCJT5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:57:02 -0500
Received: from [IPv6:2001:8a0:f24a:dd00:4cf5:7496:69c2:e329] (unknown [IPv6:2001:8a0:f24a:dd00:4cf5:7496:69c2:e329])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by mail.archlinux.org (Postfix) with ESMTPSA id 58E54467230;
        Wed, 10 Mar 2021 19:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1615406218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+pmc6YEBXrtEJ4spHBCF6ZAX8QcQH+oyO+u4cLpEcA=;
        b=pKtPO3q7v2rvvrcdpgokRc5UzMQIJ0cuKI5hfqca9o3L/8oX64JswhRq0tKiHNaPHYecu0
        JiQzqAo3wGBxdUSwmqS1q29I+Yk/PBTLK1p//Nk68GV8N3EOnG1t2NQVLySfW1L/KYVcBY
        FijWWRS2utkkRmYHxlOOOsvVPpDxw1wcb1PytgIyIWaHR2I1DRAfuhvBlkUwqUeIHPB0/L
        RlTBBhqR6kdqGZVu/+8/WCs6EzHQDfdGvDxYg9Yk/NJ1ACDbde2P9/6vzBhyP6JHVwyXzT
        0co2TVhV0N9r1hWOfVyxyGfIvmSZW40bufYm922a54lilF3zuPXscx5Xyu2DrgtqTS81FZ
        sJmrap4RIJStyNxlLk07AEE5gS31ewgj48V1bwZ/regzCjHOTWor3Uolar1BFLotIpKA9q
        QNW+F0jLT/Pe+fhgsU2Cmq2TdpbyuKXu19u+cajdjzUDLY9CgLNXkV530Xc7SMN8G0OJN2
        Lz+mRZd8Oh9aRAJHqYRk/pIJ/XB+nos8vJ5z+JuaaoMxf77wbVYiLXMpJrK+Y2TeOdgchB
        GxbJANjRQ2jAFeSfzOUtHImizxMKylmcFDBIDsCN81Dr9qV5dyYKZhIjHLroM+BfDvlpgP
        6ba/y32UdlW4rjZHnmPzq8AuRqAU35jtueR3XheKbBaa6rc54/aNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1615406218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+pmc6YEBXrtEJ4spHBCF6ZAX8QcQH+oyO+u4cLpEcA=;
        b=GYSybscTEpNxCMkmgFmLOSwP14h83G6HqPczL3qYwr2rYs+ew60i8zGH2uAZi53NCdor4Y
        V3rIzLzaZoGh30CQ==
Message-ID: <bb840ecf8dc626a07b9f00af69b0d561fb60f75b.camel@archlinux.org>
Subject: Re: Logitech G602 wireless mouse kernel error messages in 5.10.11+
 kernels
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
To:     markh@compro.net, Jiri Kosina <jkosina@suse.cz>, sashal@kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <ac5dde9c-194f-ce40-5c13-2a6890fad6a9@compro.net>
References: <ac5dde9c-194f-ce40-5c13-2a6890fad6a9@compro.net>
Organization: Archlinux
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-SSbG85K8SwLR0DYnaBe+"
Date:   Wed, 10 Mar 2021 19:56:54 +0000
MIME-Version: 1.0
User-Agent: Evolution 3.38.4 
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=ffy00 smtp.mailfrom=lains@archlinux.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SSbG85K8SwLR0DYnaBe+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-03-10 at 13:55 -0500, Mark Hounschell wrote:
> I have been using a Logitech wireless G602 mouse since forever. As of=20
> kernel 5.10.11 I get the following kernel messages;
>=20
>=20
> $dmesg | grep -i logitech
(snip)
> .
> .
> .
> Every mouse event seems to produce another "Unexpected input report=20
> number 128" kernel message.
>=20
> The commit that started this is:
>=20
> commit 1e6fc9768ed2c3917e1fd7af26cb194dfe14f7da
> Author: Filipe La=C3=83=C2=ADns <lains@archlinux.org>
> Date:=C2=A0=C2=A0 Mon Jan 4 20:47:17 2021 +0000
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 HID: logitech-dj: add the G602 receiver
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 [ Upstream commit e400071a805d6229223a98899e9da8=
c6233704a1 ]
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Tested. The device gets correctly exported to us=
erspace and I can see
> =C2=A0=C2=A0=C2=A0=C2=A0 mouse and keyboard events.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Filipe La=C3=83=C2=ADns <lains@ar=
chlinux.org>
> =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> The actual patch:
>=20
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.=
c
> index 1ffcfc9a1e033..45e7e0bdd382b 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -1869,6 +1869,10 @@ static const struct hid_device_id=20
> logi_dj_receivers[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID_USB_DEVI=
CE(USB_VENDOR_ID_LOGITECH,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0xc531),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data =3D r=
ecvr_type_gaming_hidpp},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* Logitech G602 receiver (0xc537=
) */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID_USB_DEVICE(USB_VEND=
OR_ID_LOGITECH,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0xc537),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data =3D recvr_type_g=
aming_hidpp},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* Logitech lightspeed=
 receiver (0xc539) */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID_USB_DEVI=
CE(USB_VENDOR_ID_LOGITECH,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1)=
,
>=20
>=20
>=20
> markh@harley:~> lsusb
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 003: ID 046d:c537 Logitech, Inc.
> Bus 003 Device 002: ID 0424:2504 Standard Microsystems Corp. USB 2.0 Hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>=20
>=20
>=20
> With the patch reverted:
>=20
> $dmesg | grep -i logitech
(snip)
>=20
> $lsusb
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 003: ID 046d:c537 Logitech, Inc.
> Bus 003 Device 002: ID 0424:2504 Standard Microsystems Corp. USB 2.0 Hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>=20
> With or without the patch and error messages the mouse has always worked.
>=20
> Regards
> Mark

Yes, sorry about that. The following patch should fix it, can you confirm?
You probably didn't notice any breakage because you do not have any of your
buttons bound to keyboard events.


commit ef07c116d98772952807492bd32a61f5af172a94 (hid/for-5.11/upstream-fixe=
s)
Author: Filipe La=C3=ADns <lains@riseup.net>
Date:   Fri Feb 5 14:34:44 2021 +0000

    HID: logitech-dj: add support for keyboard events in eQUAD step 4 Gamin=
g

    In e400071a805d6229223a98899e9da8c6233704a1 I added support for the
    receiver that comes with the G602 device, but unfortunately I screwed u=
p
    during testing and it seems the keyboard events were actually not being
    sent to userspace.
    This resulted in keyboard events being broken in userspace, please
    backport the fix.

    The receiver uses the normal 0x01 Logitech keyboard report descriptor,
    as expected, so it is just a matter of flagging it as supported.

    Reported in
    https://github.com/libratbag/libratbag/issues/1124

    Fixes: e400071a805d6 ("HID: logitech-dj: add the G602 receiver")
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Filipe La=C3=ADns <lains@riseup.net>
    Signed-off-by: Jiri Kosina <jkosina@suse.cz>

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 45e7e0bdd382..fcdc922bc973 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -980,6 +980,7 @@ static void logi_hidpp_recv_queue_notif(struct hid_devi=
ce
*hdev,
        case 0x07:
                device_type =3D "eQUAD step 4 Gaming";
                logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workit=
em);
+               workitem.reports_supported |=3D STD_KEYBOARD;
                break;
        case 0x08:
                device_type =3D "eQUAD step 4 for gamepads";


Cheers,
Filipe La=C3=ADns

--=-SSbG85K8SwLR0DYnaBe+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAmBJJHkACgkQ+JPGdIFq
qV1xoQ/7BezhfGMQqJKTWrMmjoIXoV6Dw/IxoiJCAUq5dv56LrdFenw1HYYYWHyw
ya6ndXiR9XzaHqbZXzjl8fUNV0nbGCWs39r03o8h7VXR/ELTNIRlaulByY40Ejou
IDKBtbnJNYzGo13JNKHrI8Eu0LT+tuZ0S8G6JMTFAEcWEgAU0OiFapbBts/xWUJ5
zm0v8l0C8y0OpinF3ebBX4t2QbHaNKcQ8VvrHrv44rnTa4RDWDIK5FMdcJA/uHal
NR3vhQe8h26Nr5GeL8jqp/+w6UaKwZ3nmnr0hN5yMqD7CcDmHr9Jm+L3DWOIP6YK
RqaxiCZ0KGyfkZmnWqgQvK8entWIGX+qRxHsSZkdCYjMkDlv6mYGjD7ddonBLLRh
NhawAkTQpuX9rGcF/+e794wIHyAkc94DtIPKRIIgNqupAau9uaKaA8EL1vUjWoLN
jYz+UZmjzUzl6HrLNPL0RTKT5yoZYlZA5dCnOSRygpnktmMOqACysCaTxfO8BdL5
V0aB+Ui98JpBcYtG4jKMuY22h6ULuWkx4Jpvn/4hIE3J7PVxR/UFEMPo8xsWDgxs
cs86XE5pvRIB+4A1yKw/nl91K4kjmJhyzZWlvGfyfkHLt2GEPGlJij6cLeJ59wnf
3+wvGp9Bzk+rH74jJ4fHlz8ZqdfZIEL2dvfCZx4h57x1v8YHNJc=
=CjRQ
-----END PGP SIGNATURE-----

--=-SSbG85K8SwLR0DYnaBe+--

