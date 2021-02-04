Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A30830ED28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhBDHTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhBDHT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:19:27 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA88C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 23:18:46 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id j2so1518291pgl.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 23:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=2eRuV+MXnwPgq49jF42geq/0UwpntOjcJgm9XMP9CAg=;
        b=SLMDsE4y0FhDbfD2z7XAMkH8WPSB/nV94IxlWnVjQn726xDeAQXW2Hsadl8591l66S
         RSDITY6xHDiPuO2zpDHQq36N5MK4G+YHDQcx2+astVGW/GRZKLFuyMveXkAB6zu1IbZv
         OR7I2t8hqik4CUPYX9fOzvadOod0HDyxalU+rH0ZcbBJ7gS3npq+RW4PlUUoJx8/UUem
         su6IDcfNwrznXjwq6v5ddUzh5Q4VndIHMj9h1cf0TIqUFMsgoC2yn35BKW9SNHF6PfLI
         2ZZYzJIr/yKsnPqqAaPKKWDZHlPrzUBUaS95mohvSMrMhYwMdbHzsRRbNHuVpI9UGSAF
         a0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=2eRuV+MXnwPgq49jF42geq/0UwpntOjcJgm9XMP9CAg=;
        b=CcRSQz12sPgG4QIjqmT1gJxDANxuG4rLK/JMXA4s6lL+IuQK+DhRSjcP6Lop61emLF
         /sPV2IKCTTMnp1pNDGInuURNcW2gojsGbDNfncy3N+w+/g/PSDiLwgNNGNPrlihSYF/o
         e6eei6SsPTwwadV7zTAt4vQ0fkvis5qgcaALytdFuWg8GPXUE64MK/2aRkVzs2346MDc
         7f19RpC6y+bUenlDKx4F/TlM6IojvK4GR+pcrpWGE0bviLqRlatsTb4/1+eqZ3k03K7r
         EEBMrgDxV++LnnFgV37a8KrMsTWjwm79jHBBvIXkyr4kZfDDbwRFvQVZCyu/mv6tGkMg
         2d6A==
X-Gm-Message-State: AOAM532an2dM94/2r3EAx4dP4cSpLD8IazA1Ei49tSVree0R0BKO0Jhe
        Pl3fNRWGh+sd9jOoYxWSSCTRBoy2CtYayw==
X-Google-Smtp-Source: ABdhPJzvlmRt84/scknRPGOoIfunryBXyEpNMmzROMAU9TTEX5OhtIM2izr8j3fiavxrxXgOdEUybQ==
X-Received: by 2002:a62:7b90:0:b029:1be:9e89:1db5 with SMTP id w138-20020a627b900000b02901be9e891db5mr6677190pfc.35.1612423125170;
        Wed, 03 Feb 2021 23:18:45 -0800 (PST)
Received: from google.com ([2620:15c:202:201:5cde:5545:a9de:114f])
        by smtp.gmail.com with ESMTPSA id 30sm5238128pgl.77.2021.02.03.23.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 23:18:43 -0800 (PST)
Date:   Wed, 3 Feb 2021 23:18:38 -0800
From:   Benson Leung <bleung@google.com>
To:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>, bleung@chromium.org
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec: Import Type C control
 command
Message-ID: <161242303435.1051580.1469403981857153644.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s8Wck68FOGenQAW8"
Content-Disposition: inline
In-Reply-To: <20210203021539.745239-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s8Wck68FOGenQAW8
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
      commit: 3ec28d3673362076444e290bdb0d94ec6432dc09
[2/2] platform/chrome: cros_ec_typec: Clear Type C disc events
      commit: d521119c8b0d70b91971d632430ec1143e5d2e26

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--s8Wck68FOGenQAW8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYBufzgAKCRBzbaomhzOw
wj2uAP49ietv5xNfS66ocvls3D80NF2Tn5tE2b+8lv8nqLwsBQD/aUezNyrvbt3B
u1W2dP6hbipw3/VxwdG9O6iAQOX9VAw=
=YdQv
-----END PGP SIGNATURE-----

--s8Wck68FOGenQAW8--
