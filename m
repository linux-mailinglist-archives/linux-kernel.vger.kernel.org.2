Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178A130ED1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhBDHRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbhBDHRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:17:13 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0348C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 23:16:33 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id my11so4624788pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 23:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=cYVhrYp+A5wMOttg3oEyP/BIlLuA0pdfVGJLCd/pDd8=;
        b=EUp83HgeF9+rlhHz+jW7vL091x8VTpq6Mnh/pV1FTfHLRs/yVpl+S5wGtsqXg/jCoK
         JShHXbi2ziXsootc+5Gx4PCZzZxdwKXu96GamTPLoGyE6P9cOFsR5+uHmQrb1UzXJdd8
         sIABwGi/0Jsw68pguINhut1N67foxmZc414mJ6sjkefn7icHLuTJYrpYKq6PldkGI4g6
         Fs7aljRkwplMizGFHDmH8n8aR8ZQrMtodb4Wi8FCERy5LD+B8ddXh/fvRDWn/EPYqgOS
         6GCm3V6aH+TUwBgVtvLfa3ytDZoKBmbb2DEPhcfsid2iLDM17G3Tx8/shAQZ+h8T7p2B
         O3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=cYVhrYp+A5wMOttg3oEyP/BIlLuA0pdfVGJLCd/pDd8=;
        b=skNH1X/mhZkLZ9poFF+SNbWSrEeO+1CyxCX+e3q2CLLfWJUZYFX+SajKYJYcs3MZxf
         4+9WUXOUudTwa+0805kzJfl+o+XzgJCfu1nGMIbDG9bBBxJCknpOvRbgG7UYHzQt+CAW
         /bGvzGMUKFGaEqLDKNHlSbHCkMK+GhQtnP3N99xims7EpbCGgKO3evwPOQ2PCjf9GOjK
         ZAubX6SeqRbFXEaEOIdPQmCqMujqrrRjCFv4G3oNcDHGzTosiznQAtbzjlvAcjD9pnKJ
         VM8qtbXB3gQlVdOgGrwxLmC8yqriXOOsf/kuZX68Ff9Apt7wmGN9/PGsZyv2GTwLxwgQ
         HPjw==
X-Gm-Message-State: AOAM5336XdKcINXc/3AvArE3u8MK0X8sLbhif9sC7++7vP7LMm4HEXVO
        u6NcCafnveY5DV+5eHdlUTq/TuKh/wYxPw==
X-Google-Smtp-Source: ABdhPJw/buOtxTEi7IvWLcHc+HV+sAvshKmgqeVECZb/OTF2xyOBFDVB1BKws0LarZMHQMpB/qX2ZA==
X-Received: by 2002:a17:90a:fe11:: with SMTP id ck17mr7047170pjb.152.1612422992568;
        Wed, 03 Feb 2021 23:16:32 -0800 (PST)
Received: from google.com ([2620:15c:202:201:5cde:5545:a9de:114f])
        by smtp.gmail.com with ESMTPSA id q12sm4987214pgj.24.2021.02.03.23.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 23:16:30 -0800 (PST)
Date:   Wed, 3 Feb 2021 23:16:25 -0800
From:   Benson Leung <bleung@google.com>
To:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        heikki.krogerus@linux.intel.com
Cc:     Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        bleung@chromium.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Decouple partner removal
Message-ID: <161230696071.2129937.11319499145894560712.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WmFn4R3DiriAedGH"
Content-Disposition: inline
In-Reply-To: <20210202224001.3810274-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WmFn4R3DiriAedGH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Tue, 2 Feb 2021 14:40:01 -0800, Prashant Malani wrote:
> Currently, we return if there is no partner present when
> !PD_CTRL_RESP_ENABLED_CONNECTED, without proceeding further. This ties
> partner removal to cable removal, whereas the two should be independent.
>=20
> Update the check to remove a partner if one was registered, but continue
> after that instead of returning.

Applied to for-kernelci, thanks!

[1/1] platform/chrome: cros_ec_typec: Decouple partner removal
      commit: d9f12f9e6c3695c32e681e9d266c4dc1c9016f66

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--WmFn4R3DiriAedGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYBufSAAKCRBzbaomhzOw
wrfuAP0dXIxw3BVKEWrrnm0wurqn0+9pAnfSuuPe0eI6R6DgiwD+PwrxcLTqegBg
7dL9pk4TKkuQr+YDh7jD8OZAE7HkOQE=
=tNYe
-----END PGP SIGNATURE-----

--WmFn4R3DiriAedGH--
