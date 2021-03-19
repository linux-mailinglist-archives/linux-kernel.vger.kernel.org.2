Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB72B34276D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhCSVJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhCSVJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:09:33 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA47C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 14:09:33 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c6so7906725qtc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 14:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=Zpz99ti9s3TrhMmoMNGsJo2F5GcF/oxCrc7dtqrT7gk=;
        b=jp8NhXi7vGRwxUX3qLSXSsW94zPi0vfYCTdPsBEvkFOrerJmKSyvNHvO0ZfULuRc5+
         4/uRVMZzhze92lTAO2taLdPhLfWrSqRWmIizWFuICMLSh2CyBQarruxCa6n4YpmyEfM7
         ECvsxrKAnXDaAe/m1sfyXlMyasxAiyCmev4ffyj/uHGUTzAiOkDftUdrHimxnvfFkXH1
         d/OdRFnOcKCkVeJ/MqgnFT1VfQdZk02rZbX2ao8aLdBN4PCvXCjovB4sXhjR6HMBme16
         zfKAZDOFiI2FQvG/NM2ZRaLbe1w2lbGpU9OaZYMJvJJaWwRLpBKmJCyKA/oGii0E0l1X
         enrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=Zpz99ti9s3TrhMmoMNGsJo2F5GcF/oxCrc7dtqrT7gk=;
        b=d/CSem2jZ28WFRbdya3AHo5KOo4KWvmwxTorXTgg1/VLWCs9Ja9poIQlyY6xZpTz8B
         HvxHTAyz1Ffi8+V3sEHu+XXSgHiivxzA9/x6p4Tq3NnzCxWxehHz2GVGk4lReZgQ+Mc/
         1f4Y6/p783TpoEmPDmxTWSvxN9FmGjZfSEIKW+javldRMLga8ceb4zD81lCy4U9u5f/8
         Pzd0WqQrEqvLbTWPzUrQ3HGgxHTT9e0cRRcvBi7CAlVUjosA6lPj9ZjuWC5VDqKhWMlh
         CfYqZnaQa7mhv5tu6jTE5hU15+PwD5whtyRJ3d7jp++67ONVHV95O2xulZKLDF6E61jI
         1ZeQ==
X-Gm-Message-State: AOAM533uXlFBtZDUFtzTKaMYRjnb+WUQezbPppnTfw5/WQifEONQxBb6
        kjsyBT23Bki6NlzT25dU554M78rGUxKFeJLd
X-Google-Smtp-Source: ABdhPJwvC9GV9xX5KBIYzo+sG4dmnJqGk+An0A4oXjDXsX3y4FEBOC9oZc9ICDX0iGE9sekW45V7Pg==
X-Received: by 2002:aed:34c7:: with SMTP id x65mr547284qtd.229.1616188172374;
        Fri, 19 Mar 2021 14:09:32 -0700 (PDT)
Received: from Gentoo ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id w9sm4776002qti.27.2021.03.19.14.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:09:31 -0700 (PDT)
Date:   Sat, 20 Mar 2021 02:39:21 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     david@fromorbit.com
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: [unixbhaskar@gmail.com: [PATCH] lib: Fix a typo]
Message-ID: <YFUTASslkS14RsXf@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        david@fromorbit.com, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6bq9FZlzaaIdgDcQ"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6bq9FZlzaaIdgDcQ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

----- Forwarded message from Bhaskar Chowdhury <unixbhaskar@gmail.com> -----

Hi Dave,

Can you please take it, as I haven't found anybody attached with this file,=
but
found you made some entry(I am trying to take advantage of you!! :)  ) ..

Thanks,
Bhaskar
Date: Sat, 20 Mar 2021 02:31:55 +0530
=46rom: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: unixbhaskar@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] lib: Fix a typo
X-Mailer: git-send-email 2.26.2


s/funtion/function/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  lib/list_sort.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/list_sort.c b/lib/list_sort.c
index 52f0c258c895..282fe269f16a 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -107,7 +107,7 @@ static void merge_final(void *priv, cmp_func cmp, struc=
t list_head *head,
   * @head: the list to sort
   * @cmp: the elements comparison function
   *
- * The comparison funtion @cmp must return > 0 if @a should sort after
+ * The comparison function @cmp must return > 0 if @a should sort after
   * @b ("@a > @b" if you want an ascending sort), and <=3D 0 if @a should
   * sort before @b *or* their original order should be preserved.  It is
   * always called with the element that came first in the input in @a,
--
2.26.2


----- End forwarded message -----

--6bq9FZlzaaIdgDcQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBVEvkACgkQsjqdtxFL
KRW5SAf/WhsCUV0YIE6q0yTihVsbhxIVj9yYf/TWC/xuf+aBcBRddjhQif1c4ZVd
VPNeCLJVPhKbyPrAJ/ed2J+tM1Wq12SN79+uiz7jUwz/GrxH/ill4ndzCACLVA29
/KrjhSrKSHryR1TOWKdTENAyTSPPicF1dLqSHwOKKqloW9ca+p6tdX7a0VIXgbaB
6jTyvRQA2Fx334K4uNgepe8oMVJvEU4r6WdBqS+NLm1C0lAoZksGE6VMYg3S9n5a
nbRz+Qh3z8BjoVUSJTC4kdxGdA90LkBVC8esbRv7C/rN9eLmPVz+M7dk2hy1H6lI
q1GiVwQy93vHWV03St5fgz/BPiJ++A==
=qKBD
-----END PGP SIGNATURE-----

--6bq9FZlzaaIdgDcQ--
