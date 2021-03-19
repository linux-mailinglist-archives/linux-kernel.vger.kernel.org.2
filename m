Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2F3411F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhCSBKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhCSBKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:10:24 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE10C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:10:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c6so5636246qtc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=+P04+V61scgP8i83/qjVfGSPpOkjgZMNQbrILXLzmDc=;
        b=fzuBZ0NMrGwbez3hnGslYX+KD8HEdPvdHXSj5wxTAlPgHl4/RP7ra7ej4KgMj74bFM
         OZxQsGtEb2xDy6UZBv7fDM3LXamOZd4yFHpxohEuiEn4pm3ipIYao/xMX2q9joqfFrh4
         hIiQ1QWUtg7MSir4+naDksl5py3EnQ1cCHzJwMgRxVxlTwfr8m+sHZg4fle4s0PYhBTI
         tKp++9kFg5ArorNnX596R2tLep9QbJG/iqN1evqPHQH94nTgzBwaddI0r0SbPyV7on/G
         yVQSGbQ+UtwTl4s+AgwzyO/4UZLIc2eR6e6eBUplqyYotcYvk80rVVu7JFcaH3JxtUVV
         pK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=+P04+V61scgP8i83/qjVfGSPpOkjgZMNQbrILXLzmDc=;
        b=s3ODjsZmP+Y5vkRHVfHSAUSjLIFpm7kDtrb5Gb/hXRRGgHM+X0kBp9qC5izQe/CdkY
         wH08Pn+va7hNaqnv9zgY3cCmEZYx+jlxfP/Nt3crYlGcHsRYc5gV3Yw4lFZr/brGyU5/
         2XSTD80B6heEIjazELSBPSQswR7QuRMGwFgOltbw1YriyRDiF9PiFOHT4YRBX+e5Vvs1
         F4Ae12NUK4I5zTjr1OG6rXvboEDdy2vI5sj7/d8cDt07T1p00g259c/KekT4aBiNpN2V
         QZWW2Q3sGdyFsnch4KrovvvpEcWEbJ8wf0i2FV5Ntg0XUrHp1lUuGwInq4wanhpLh7JI
         Y3bw==
X-Gm-Message-State: AOAM531s/hgcAm2wFUPy/xKs8PXSAvej96vPZYD/TSOF4h67EoDmErWn
        dUltIFtZtGHzR708t/JLf+Y=
X-Google-Smtp-Source: ABdhPJzucyJZNxPLjkAv2a/Bn1/RDEjQZ3aGvrK9ueL5VjhZUMhaQjMOz/dwdCpLEh9nTXsZQWrYaA==
X-Received: by 2002:ac8:5510:: with SMTP id j16mr6264754qtq.339.1616116223491;
        Thu, 18 Mar 2021 18:10:23 -0700 (PDT)
Received: from Gentoo ([37.19.198.87])
        by smtp.gmail.com with ESMTPSA id t188sm3227815qke.91.2021.03.18.18.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 18:10:22 -0700 (PDT)
Date:   Fri, 19 Mar 2021 06:40:14 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     johannes.berg@intel.com
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: [unixbhaskar@gmail.com: [PATCH] average: Mundane typo fix]
Message-ID: <YFP59mdXHixdSPaU@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        johannes.berg@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uj/Io+VKCrOlLRCv"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uj/Io+VKCrOlLRCv
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

----- Forwarded message from Bhaskar Chowdhury <unixbhaskar@gmail.com> -----


Well, as this file is orphan, means, I can't see any specific maintainer
attached with it,so it prompted me to ran git blame and found
johannes.berg@intel.com

Hey Johannes, can you please take it and merge it , if it is okay with
you.Once Randy acked it.

Date: Fri, 19 Mar 2021 06:31:26 +0530
=46rom: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: unixbhaskar@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] average: Mundane typo fix
X-Mailer: git-send-email 2.26.2

s/funtions/functions/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  include/linux/average.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/average.h b/include/linux/average.h
index a1a8f09631ce..0cb77b3e483c 100644
--- a/include/linux/average.h
+++ b/include/linux/average.h
@@ -11,7 +11,7 @@
   *
   * This implements a fixed-precision EWMA algorithm, with both the
   * precision and fall-off coefficient determined at compile-time
- * and built into the generated helper funtions.
+ * and built into the generated helper functions.
   *
   * The first argument to the macro is the name that will be used
   * for the struct and helper functions.
--
2.26.2


----- End forwarded message -----

--uj/Io+VKCrOlLRCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBT+e8ACgkQsjqdtxFL
KRV42Af9Hl0K0ZosozBzsKCs+hentB8OI+XJfQkHjlN0OdkdGlV3Cniei6uw7n1c
3f1WhLnwCwxbO6qMlGXHR0o14dGkQR3oxOg8YXOdIIXo4Tz+is+T9mfCP1TnNhVk
q3TvRhc0FFpI5rCd1bYD5zx2pWWzNXSSAjeX6dJNCa65Qpurk9+uI3+5eVyQRWe6
hwv+TbHahsssLijAj8a6VPc/6UhgaDDXU96MuMFVEscB45HL3LGWW+kQa1D6/Mzz
YFqvFtSZF3k37h6hSel3JXCZ8uVwLLUh0btf1uM7xEvl9+ktwbSCacCu6CuzdDUO
ltEOz3aFcDLCnHrQOZEZSKUXYzFpQg==
=0qIf
-----END PGP SIGNATURE-----

--uj/Io+VKCrOlLRCv--
