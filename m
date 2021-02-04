Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB730FC53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbhBDTN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbhBDSiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:38:15 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB04C061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:37:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q72so2202960pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=kcFncfVY0snUb0dfc1fBrW7VzcII2qXEX9RXLbcBHdY=;
        b=DlsraEMBbI7RbC0sZkkoZsYw9XM7HgTXcX3fJjQ/r/iNGAZ+TgESRheWzJ9O0NFJb6
         D+FF0ck3ZtgZO6vCNY8qoLPId1i4JJdoUPNAxjINFSfBNVLm2YM2dLFkDq45bkAQb24k
         ajlkBmtVgp+zLNIuHCj3GYoOmDGfJ7orazCjRcuvcubTw4Stl68Ez6xivyR5auInsGUW
         Q2f+A2s5a6Tx0wEisKfKFhZ3zhQFNJHanKMFDVt7ufq9HK4OuMgi+D+W/4+ojHICe3NO
         3n6muHHQTIUvrYvR7WLEAKyUIoAIzR3U7e6a19HpNqTB1WWJoyl+P5hIErDfbyrFfey+
         OKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=kcFncfVY0snUb0dfc1fBrW7VzcII2qXEX9RXLbcBHdY=;
        b=a4z379WFp57t4+txyLgn88/dlZ2/DdoVudVmDx5NquezmjdA6TdePwaNvbTLZbLKlF
         hRdDtn/lS0QHZyIp8f4ZwWA+magwNr6Vgtct4JfZ5W9LWg/5+wyBNLHUEfNhV/okEoBz
         FbNvhPunp5yOfX1Otnlu5Cywl+AjmL3nl6SaJ7z2UW8CI43SnzYbmHoWNwdUnTQaiTl4
         93uXdrm/EXDCoj1AHyZEhICgsuINkjonyaxjsdHjpzD3n5pXdkCRphWdBUJdCDpI/ML/
         vU9rAYwvIzNZF2F5wj/S4o8LlUhFQpqbb42MFJeLAmmxAFHb5US3kNyc8gtag0SPPmbC
         HPnw==
X-Gm-Message-State: AOAM5310Oyj+P02ScLkSCxl0R2PPVDPkvitBVi39erZgl2E2vK1Qk/k7
        s3mHMpF9bLFQT95mv7/qgeSeDA==
X-Google-Smtp-Source: ABdhPJxIiOHKcvuNoQ1fmd6xO+itPD6BwLBPr7IZlNaYrAT0MTWpRD+RgVnxGlAKkKikqS2/BtrWOQ==
X-Received: by 2002:a17:902:bd4a:b029:e1:1ccd:35b7 with SMTP id b10-20020a170902bd4ab02900e11ccd35b7mr684505plx.30.1612463854107;
        Thu, 04 Feb 2021 10:37:34 -0800 (PST)
Received: from google.com ([2620:15c:202:201:5cde:5545:a9de:114f])
        by smtp.gmail.com with ESMTPSA id y11sm7287538pff.93.2021.02.04.10.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:37:32 -0800 (PST)
Date:   Thu, 4 Feb 2021 10:37:27 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec: Import Type C control
 command
Message-ID: <161246366607.1204111.1425833076265657929.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9IwtcMYSoU8QToid"
Content-Disposition: inline
In-Reply-To: <20210203021539.745239-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9IwtcMYSoU8QToid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Tue, 2 Feb 2021 18:15:37 -0800, Prashant Malani wrote:
> This command is used to communicate with the Chrome Embedded Controller
> (EC) regarding USB Type C events and state.
>=20
> These header updates are included in the latest Chrome OS EC headers [1]
>=20
> [1]
> https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/mai=
n/include/ec_commands.h

Applied, thanks!

[1/2] platform/chrome: cros_ec: Import Type C control command
      commit: b64afd949ee3a61e180813859b50aced26023c55
[2/2] platform/chrome: cros_ec_typec: Clear Type C disc events
      commit: c8ec21c6d25c2a8895614ea38575dadb8570c2f9

I rebased these changes so that it clears a merge conflict with changes in
greg's usb-next branch.

These two are in the chrome-platform repo as:
https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/l=
og/?h=3Dcros_ec_typec-clear-pd-discovery-events-after-handled

I will send a PR to Greg for these too.=20

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--9IwtcMYSoU8QToid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYBw+5wAKCRBzbaomhzOw
wtweAQC1Ean6KqIEG5J1esNWWaCDzx23dCfP/9Zw80RKf5yWuQEAvUE5HWvev1LV
yvo9M/7wAUV8vizx42fP4nxO5q1+3w4=
=cr1X
-----END PGP SIGNATURE-----

--9IwtcMYSoU8QToid--
