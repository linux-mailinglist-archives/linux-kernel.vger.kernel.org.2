Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AA7342F01
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCTS30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCTS3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:29:23 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4DEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 11:29:23 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x27so6732114qvd.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=s5OJi0946gw3w9k11Tpr0BgpxuF7ZHF8zXDSVvR4TZ4=;
        b=FHjtAvfW+C326eLcX0ZTIcd3yXhw4YzrRWL4b+4+v/zge9saR6FljfFxMaHxn18jGA
         IqKGGiOF1lItGtSUhkishcG7VEg0nYE6IBlo+6pbaoXbXDLo7kxAVvbkUdPusIKgLY5L
         r9UvTTjU0lQ1X7QU41mdZp3j++mcUwIuQL+o8Mo6fAGT85U3xbL4v62oOCkJpd1R+lsK
         ydqsb+3VPczKCoFcdgh2h7YFER/pMtvofrboQFtSBT0UaHbDsr9aR5oTAhsd+KnlXrQP
         Pvn4zZo22iZ4PbzqeWm3ruhAfyImKrFQREy558sKhY4Wq7im3rc00kKw3SVzMwMAW9DX
         Z69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=s5OJi0946gw3w9k11Tpr0BgpxuF7ZHF8zXDSVvR4TZ4=;
        b=c3pUwQdxbhscu1S7t0lzmd3dX4kj2VZmfrEjYi3K+QCBjbD6WPW0Da5CTiMynsqrkH
         TPR58AEEcL8g+4wzLGru2hGZEPXvvGSvHC8S9oStOtf5hMiBiBHhhgVwe3snrMqOtN2a
         URfDmGgiTzzLRgxPdpNJvTDGYFgEhn6CKQGga+5vbU1NivJuHZPNANCTGYGyH+jb1B0K
         g+B60eM2jMCvjdftgkRU1Es1c9738N5Yxk43Pz0oeIImk43dn9Ll/c6BcaNysVRTa3dL
         R8lG3vYiaBP+/59iZH5RrvA+fdohfg3tFOUa8M363C0MWv3tLBXUxh6E1t0DNUNI60o7
         DRmw==
X-Gm-Message-State: AOAM533GmsWj4Dvl+KlBTu22MeB0JsQCjHZXMrw6M0YLABABtwNan4Lk
        Y1pCjBZSiPhT8uv3pfoos8I=
X-Google-Smtp-Source: ABdhPJzmKmW4n5hTYOnvH369i3DnnqrljMnGDzgGljESEhxoARUa6m3Y29h7fgv45q8gMuk8+ZtJpg==
X-Received: by 2002:ad4:5851:: with SMTP id de17mr14644803qvb.6.1616264962724;
        Sat, 20 Mar 2021 11:29:22 -0700 (PDT)
Received: from Gentoo ([138.199.13.205])
        by smtp.gmail.com with ESMTPSA id f8sm7223611qkk.23.2021.03.20.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 11:29:21 -0700 (PDT)
Date:   Sat, 20 Mar 2021 23:59:10 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>
Subject: [unixbhaskar@gmail.com: [PATCH] IA64: Trivial spelling fixes]
Message-ID: <YFY+9uwvNLeb/3Ab@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IuNE25+hj34chh7H"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IuNE25+hj34chh7H
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

----- Forwarded message from Bhaskar Chowdhury <unixbhaskar@gmail.com> -----

Date: Sat, 20 Mar 2021 23:53:47 +0530
=46rom: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: unixbhaskar@gmail.com, linux-ia64@vger.kernel.org, linux-kernel@vger.ke=
rnel.org
Subject: [PATCH] IA64: Trivial spelling fixes
X-Mailer: git-send-email 2.26.2


s/seralize/serialize/ .....three different places

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  arch/ia64/kernel/pal.S | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/pal.S b/arch/ia64/kernel/pal.S
index d3e22c018b68..06d01a070aae 100644
--- a/arch/ia64/kernel/pal.S
+++ b/arch/ia64/kernel/pal.S
@@ -86,7 +86,7 @@ GLOBAL_ENTRY(ia64_pal_call_static)
  	mov ar.pfs =3D loc1
  	mov rp =3D loc0
  	;;
-	srlz.d				// seralize restoration of psr.l
+	srlz.d				// serialize restoration of psr.l
  	br.ret.sptk.many b0
  END(ia64_pal_call_static)
  EXPORT_SYMBOL(ia64_pal_call_static)
@@ -194,7 +194,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_static)
  	mov rp =3D loc0
  	;;
  	mov ar.rsc=3Dloc4			// restore RSE configuration
-	srlz.d				// seralize restoration of psr.l
+	srlz.d				// serialize restoration of psr.l
  	br.ret.sptk.many b0
  END(ia64_pal_call_phys_static)
  EXPORT_SYMBOL(ia64_pal_call_phys_static)
@@ -252,7 +252,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_stacked)
  	mov rp =3D loc0
  	;;
  	mov ar.rsc=3Dloc4			// restore RSE configuration
-	srlz.d				// seralize restoration of psr.l
+	srlz.d				// serialize restoration of psr.l
  	br.ret.sptk.many b0
  END(ia64_pal_call_phys_stacked)
  EXPORT_SYMBOL(ia64_pal_call_phys_stacked)
--
2.26.2


----- End forwarded message -----

--IuNE25+hj34chh7H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBWPvEACgkQsjqdtxFL
KRWDJgf/QC5DQHemN8t3SWThnIpXvFfszaf/3RnJpjplnUx3U4xiP5Wc2+BEL9C8
bUthqNdTtK9gf21nof53nqArTZ4HywJbBxT23V14NPJ1G0R+yhaqGaVm+vAKxVmS
sCh8vSF5FDpVjhScmNwseSAJfoLBCqZoKJ5JMDskIWOk45kGg8S7EG7Qsau2Orth
i22HINzGDJX8m8pa/JkyQpwKzyxQGf7hFieauMsiYLBLP5Nzcvuujy1TdgCuMY8N
XOlSbgJ0Te8pJ85tTPVcjVpMGGrZ7fIx8mwXowJyD17QIN60Li051s3kV/0rh3WP
9rhlUSkqnAQqry+cVFWAH7/UQwq+SQ==
=JKib
-----END PGP SIGNATURE-----

--IuNE25+hj34chh7H--
