Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681B3331694
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhCHSs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhCHSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:48:48 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD72C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 10:48:48 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id h10so16293863edl.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 10:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version;
        bh=KZOctmIZsl7lvXk2shny2Smy1YinZIVG1Ks/6xHN1hI=;
        b=olN5qTom8+8/xNiBqIDj4CAUipIrlzH9JKHxgG3l5yJ5Md1HYiG4wi1Vm9+UMhQjDZ
         6A8IcijoJroaje+A193WTUA+NLxBXFNrzsHOHmYCVNzk9l7jnlUTBvCnhBZsVbIGKeSq
         5KkcBv/bQwYuu8SMFmtCeWX20rfCk+HHdjGJR/ehMJQNX56cOqGUnNwgNhAzRKsDXld0
         lu1uFNylMhHQ7kV8f6LTvVOW+CdGkc+rKwGvPvMaR/6HdrmYDiVGUcTW07ZQPNiKMEy+
         9U+EISH43TYtjoV6YOxmtqvjzmFMzvnwBX+X8RFfYCcgvgUKPGoAiAzjMXx+pTKvOqUP
         Kl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version;
        bh=KZOctmIZsl7lvXk2shny2Smy1YinZIVG1Ks/6xHN1hI=;
        b=E+w1H7K9yQ0XvpIKQB/IGz+R4V3HUxmH+JBXXYuMlOrlZNK94+698QdTxMZV5IyGVQ
         LHkuBIk/k7qmshk2om0VUGg4HTPBtUJjqcK0/lnzB4Xsu+DYhYPfy/K7BHfQWy5lOjyW
         RGEWL+GaV2IiIPDWP/H6sTz2QaOGkvHZ1efU4Xn60wFKzL1tN1YCfXTZRRdhMPdJdrjl
         8mXrUNNVbp6QJRwdnwNtnvj1mjLqeqdr+JvtdWJ2SKhNICX94neb0obPtOhhE+E76vHV
         TnhzO/KvScn7l2DoLq/p4ly47miUJQGNPhx6KHM+Z/sIbjTVtI4erO17qhYAb3bLYopf
         u2Zg==
X-Gm-Message-State: AOAM531deo7WACB0gSq7uQhTIWo/jj/dlOpwvLRZ5OwGZF5ZRZ8uHGof
        qa0hDuhOH7dR+mIzTXasJDw=
X-Google-Smtp-Source: ABdhPJxG0r0+VERGDChlwVhbaPYrbrkDz3rYfhKYdwEa12oydZ/OoGymn/2RPjBWsgcxnc8UYw00cg==
X-Received: by 2002:a05:6402:31a7:: with SMTP id dj7mr23735249edb.33.1615229327146;
        Mon, 08 Mar 2021 10:48:47 -0800 (PST)
Received: from [192.168.1.140] ([87.121.147.51])
        by smtp.gmail.com with ESMTPSA id t12sm1889064edy.56.2021.03.08.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:48:46 -0800 (PST)
Message-ID: <998cafbe10b648f724ee33570553f2d780a38963.camel@gmail.com>
Subject: [PATCH] SOUND: pci: hda: Add Sound BlasterX AE-5 Plus support
From:   Simeon Simeonoff <sim.simeonoff@gmail.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, conmanx360@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Mar 2021 20:48:35 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-6B1Qh9fG6JNfosKRK9le"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6B1Qh9fG6JNfosKRK9le
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


The new AE-5 Plus model has a different Subsystem ID compared to the
non-plus model. Adding the new id to the list of quirks.

Signed-off-by: Simeon Simeonoff <sim.simeonoff@gmail.com>
---
=C2=A0sound/pci/hda/patch_ca0132.c | 1 +
=C2=A01 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index c966f49fa942..b2b620f6c832 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1309,6 +1309,7 @@ static const struct snd_pci_quirk ca0132_quirks[] =3D=
 {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SND_PCI_QUIRK(0x1102, 0x001=
3, "Recon3D", QUIRK_R3D),
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SND_PCI_QUIRK(0x1102, 0x001=
8, "Recon3D", QUIRK_R3D),
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SND_PCI_QUIRK(0x1102, 0x005=
1, "Sound Blaster AE-5", QUIRK_AE5),
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SND_PCI_QUIRK(0x1102, 0x0191, "S=
ound Blaster AE-5 Plus", QUIRK_AE5),
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SND_PCI_QUIRK(0x1102, 0x008=
1, "Sound Blaster AE-7", QUIRK_AE7),
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
=C2=A0};
--=20
2.27.0



--=-6B1Qh9fG6JNfosKRK9le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQFMBAABCgA2FiEEXD0JRrvVJxP9wPdu90R3V3oC/y8FAmBGcYMYHHNpbS5zaW1l
b25vZmZAZ21haWwuY29tAAoJEPdEd1d6Av8vjk0H/0x7MonpUW+lrbspfgwyNr4q
Ige3BGBjmzrPxGyePDrSaT3SpI/0E13Td6fssN3UYLRkw8mpHY3ukj87cmZ+G+gC
y+g/SQuHIgGstWnmX0wtuXYEvQQEHE5mF6gkYWynhD8FIX8lzyEBARVuRcfuY4jf
EZOrxx6PKMLdsFf+lDkq6tlFlk+GUxVxBeKNJL4RVH43kplxCYfsJnCZHTd7piH8
AxSJy8ilRbPqx2v9q8l7Tc2qNHH8jHwj9Tkm4XFV3EK/WQx8sum4CFih5S4oRgz7
XzZWvesIKvKFiRh4mZ2E5kPHg10KJsqTNVhYzlP02lEsnxbTqyPEuNswxtUbp6c=
=L7IC
-----END PGP SIGNATURE-----

--=-6B1Qh9fG6JNfosKRK9le--

