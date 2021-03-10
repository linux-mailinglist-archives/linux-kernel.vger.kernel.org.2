Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9BC334933
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhCJUzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:55:18 -0500
Received: from mail.archlinux.org ([95.216.189.61]:48836 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhCJUzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:55:17 -0500
Received: from [IPv6:2001:8a0:f24a:dd00:4cf5:7496:69c2:e329] (unknown [IPv6:2001:8a0:f24a:dd00:4cf5:7496:69c2:e329])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by mail.archlinux.org (Postfix) with ESMTPSA id A3C3C467C1A;
        Wed, 10 Mar 2021 20:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1615409715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CFWD62KwYYW5BIxmkvulCdUgCOyPBrIm36EOgkfRmI4=;
        b=5V8lFgFAHPUstRYS+PICAtVJICPZ7cEkTj+alZBsEMJgTph15inmx7aL3DUQt9fiz9WWz6
        g0haAcgcd/bkjcBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1615409715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CFWD62KwYYW5BIxmkvulCdUgCOyPBrIm36EOgkfRmI4=;
        b=fkYxzmvV5TQ83xcY/5rqeUJ3oMrrW48gK3nj7C/+j6CjceWkfBLyRmCcTR4OPK4IDysTLS
        hJw2dO+0ekgr/AHNcM5dJSbXLbcX05wEUnrmVJbtU5uvyeXhYQkSSFMd92BuDtsGNLPo7d
        7ezaCADUO5i9CIAEumLpfJGNoKeTu2t7uzj39Q8VgydN83GS/as2MuUHyyAgvomwase0Fq
        NwUHwISAoM1EPx2s8CXIsKLhpWa2k+Y77OgBqA2gVNsNyhlbpxFO1eu9D/A3zAk0+fH2Dh
        L6AdYyJuoLnwGkTCzPbra7NRfrIWNXJ2GJ/qHA0g5Y1FZV0WXonDK6FGZ6OQ+UyjuY9b0d
        MqpcSaVb3wWTYjYGooao9Pl9gUVtHrGAKtvFLC0ZpKnmPwt6AIzdqVuO0ApnCqMQ+kcj24
        X3WdXEl2dHlSUUtoYAAPXI+Fwr+OelXBXqW7O2IyyD2a2Tfk2L2qXx904XY20E9TVJfeGn
        wXibFc9NIAYB7PO24i1IdvmexOxUOfW4DDmocH2ImmK0JIfQqC/ijkssXC6aQNRNjDlA7r
        P28QNyorvxQ3Ye4ouP21J27bzaWrwyepvc6KBprDRRzm020Qj5SGReTfFXhUNErZxF8qCi
        wymSDxRpUEGFI3OylXD0tSIMstPSeWyxp6eVIa8gjYZg0t+m27dhg=
Message-ID: <91cda49d4fda10781dc2add8174536cf6b91a527.camel@archlinux.org>
Subject: Re: Logitech G602 wireless mouse kernel error messages in 5.10.11+
 kernels
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
To:     markh@compro.net, Jiri Kosina <jkosina@suse.cz>, sashal@kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <8276a207-abe7-06cc-0c25-f4eebf1a9525@compro.net>
References: <ac5dde9c-194f-ce40-5c13-2a6890fad6a9@compro.net>
         <bb840ecf8dc626a07b9f00af69b0d561fb60f75b.camel@archlinux.org>
         <8276a207-abe7-06cc-0c25-f4eebf1a9525@compro.net>
Organization: Archlinux
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BdjneROPG+yI9508ZaBV"
Date:   Wed, 10 Mar 2021 20:55:12 +0000
MIME-Version: 1.0
User-Agent: Evolution 3.38.4 
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=ffy00 smtp.mailfrom=lains@archlinux.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BdjneROPG+yI9508ZaBV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-03-10 at 15:24 -0500, Mark Hounschell wrote:
>=20
> That is correct, I don't have any buttons bound to keyboard events. With=
=20
> the original patch the G4(forward) and G5(Backward) buttons work in a=20
> browser. I guess G7, G8, and G9 buttons are programmable to keyboard even=
ts?
>=20
> However this patch does not seem to fix the messages I get.
>=20
> Regards
> Mark

Those events belong to the USB HID button usage page and are sent by the
receiver in the HID device with the unnumbered report descriptor, so they a=
re
not affected.

Looking at the report descriptor for the other HID device, I see a report I=
D of
128 (0x80) used for a vendor application, I am not really sure what it is u=
sed
for and can't seem to trigger my device to send it.

I am gonna guess this is the device reporting the pressed buttons via vendo=
r
reports or something like that. Speaking as the person who added support fo=
r
this device in libratbag, this report is very likely not something that we =
don't
need in our custom drivers and just likely something extra that Logitech bu=
ilt
to achieve something custom in the Windows driver. FWIW, this device is a v=
ery
weird one, it does not even follow Logitech's own spec :P

Seeing this report the driver chugs.

	if (report > REPORT_TYPE_RFREPORT_LAST) {
		hid_err(hdev, "Unexpected input report number %d\n", report);
		return;
	}

Causing your

[   36.471326] logitech-djreceiver 0003:046D:C537.0002: Unexpected input re=
port number 128
[   36.565317] logitech-djreceiver 0003:046D:C537.0002: Unexpected input re=
port number 128
[   42.390321] logitech-djreceiver 0003:046D:C537.0002: Unexpected input re=
port number 128

I feel like the correct fix for these cases is not to consume the report an=
d not
forward it to device node, but rather to forward it to the receiver node.

(looping in Hans)
Hans, you introduced this code, do you remember why? Where did
REPORT_TYPE_RFREPORT_LAST get its value from and what is the purpose of thi=
s
check?
Shouldn't we just keep forwarding unknown reports to the receiver node? Is =
there
any technical limitation to do that? I am not too familiar with this part o=
f the
code.

Cheers,
Filipe La=C3=ADns

--=-BdjneROPG+yI9508ZaBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAmBJMiYACgkQ+JPGdIFq
qV1nHQ/+O0N28W7t9mA6prszQLBd9rusR1tLz46U8UBIeJuKg+bP0JNntJBomF+B
t7vtqvl0feG3liKkmJ/PesoJa6U2xyfsC6Dc7G5TTMA+FPoJ/dj7vZHzD/B3DlDf
Idx4bkK5uSsdS4PkQe7ePoddcOruqyLum4hPhgH9DRdT8hwy7NlLVxx31mwdCLcD
kpfkYz00+wncoA9DhiR2Z5b3MEly0BkQXUq04iuKinbZQwZMBwsOXJlIMJJoIqRx
ycbzDPGRy6JZvz1gPk4FcnsSa1IC3P2OHz6V3W1yx+3LKv0uhdx5nyrk6bTwc1tP
m7ZOvAmFUhFvwwEQ9OOJjuAVqhoXcivYVMfjoxeIfjOmuI0EhHxP/BzHX5xMW5ln
xXAWeOsNii5HhBLRjRpri4rIAWFo+U8F+Gazjg7omPRlLbl59dCZKxXaSycj/nhT
Xoh7JxO7qlY9qtjBNQsMMPJAFwgLkz8OdWhW6A/ediMaBL78xg9PTlUbrfxStMVd
mekD+pxz0/s1e4KJdd4mVeeKDcIC5u6sZLUur/N5R6pizPNsEjTE3vVlNUsyLeGT
B4fPV2bNrXslxw86zeXnE11RvAZNwDI9b2zCYcbKUzP0Ic1agRyUaSEuiWIGn29Y
3ZurU1jabSIUKbHTBEZI2iuMpqGIA6blREdPmjMUGi7GVw9VHb4=
=A7iO
-----END PGP SIGNATURE-----

--=-BdjneROPG+yI9508ZaBV--

