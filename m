Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AC2458CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhKVLGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:06:42 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:35519 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhKVLGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:06:41 -0500
Received: by mail-lf1-f43.google.com with SMTP id u3so78742568lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 03:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f9b2AIh4aWDVxTO/xZTtTi+Eg78t+JABtBnA2rlMkoI=;
        b=Z8oZ1fkyTbu7rIFdrj4OgllyJ+15vS3DtkrjsrN7UNFlxzeITM+g75zdjsSo1XVe0e
         ifYUeCocIOapr+3ugyfXty1JQl5Xe9PpyrhQzYB2rTwaFSfYSwhPeBbfYl279TNWqD+6
         /Qqxb8pqesV0EFyMh5QQFawd0J9NJ7rSTUxM+zSA4NQ9PC8En1aThi9yJOSzxe8HTRHQ
         qIBAMQHnfUIkXgRdRWijUrKLWuXHlc6QrvIhFs8J31uto7C4jC70PKF/wN4m9TZdkGdJ
         KxlyXxanDZNht+9tzo/ZoDp/oGPJ+yZjGoWgT/Hy2qzEKZ2ajKVIi4q4q1cJo+FZtAsG
         yfeQ==
X-Gm-Message-State: AOAM530GdbIViuiX9S09V2aSpMTL8mSkZ/r6b1ebcKOk1lzcrO9En4Xj
        +ZWZBhf9QYm28DpV0oDYRbk=
X-Google-Smtp-Source: ABdhPJyzJANOVmX/7mQyvxJB1FSe2CVIRVaMR13gMqOZ7wkJvnRpYgpWHYQ93XcVk1QJzYm/ZETXRg==
X-Received: by 2002:a05:651c:2c1:: with SMTP id f1mr52514043ljo.345.1637579013756;
        Mon, 22 Nov 2021 03:03:33 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id a7sm921728lfk.216.2021.11.22.03.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 03:03:33 -0800 (PST)
Date:   Mon, 22 Nov 2021 13:03:25 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] bitops: Add single_bit_set()
Message-ID: <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KNWtCy4YsgGfrHT8"
Content-Disposition: inline
In-Reply-To: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KNWtCy4YsgGfrHT8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are cases when it is useful to check a bit-mask has only one bit
set. Add a generic helper for it instead of baking own one for each
user.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
I am not at all sure what would be the best place for this. Please let
me know if you think some other file would be more appropriate.
---
 include/linux/bitops.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 5e62e2383b7f..dd6c7baed3d3 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -66,6 +66,26 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (start) < (size); \
 	     (start) =3D find_next_clump8(&(clump), (bits), (size), (start) + 8))
=20
+/**
+ * single_bit_set - check if only one bit is set in value
+ * @bits:		value to check
+ * @bits_to_check:	how many bits we should scan
+ *
+ * Return: true if only one of the checked bits is set, othervice return f=
alse.
+ */
+static inline bool single_bit_set(const unsigned long bits, int bits_to_ch=
eck)
+{
+	int bit;
+
+	bit =3D find_first_bit(&bits, bits_to_check);
+	if (bit =3D=3D bits_to_check)
+		return false;
+
+	bit =3D find_next_bit(&bits, bits_to_check, bit + 1);
+
+	return (bit =3D=3D bits_to_check);
+}
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
--=20
2.31.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--KNWtCy4YsgGfrHT8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGbeP0ACgkQeFA3/03a
ocU/pgf/VlPNVumRBFTtr7sHtjCLM+qNj+Mpt0kEmSEQ9jgtE5qMLrS43kqykxid
/bVZbqb8Dl0wizaDDI9GG9EC6/VfwdND9Qb72TxmqafcULagsOi7b1BrZqs9wdYG
R6y+uUtUhWnRW2+GAqazPjDst58KEiVYpRDvWXx/L1TF8C06Zi1kxV0MmTJ1ZlX7
WNe0ijddQmCrnI6UbG7y5AHb3+e3/l9c7bpKxKpQUMkyxX/P3afhsPOeidsUJJoX
zD/pncejkAF0tuohPlapKIQH370ljdJZQ4vvWv3aS9ihZ9dTStk5jw7X6/oEiWiQ
SDAOgVmR+1QtnKluhxtARkR0f0tg+A==
=jlDs
-----END PGP SIGNATURE-----

--KNWtCy4YsgGfrHT8--
