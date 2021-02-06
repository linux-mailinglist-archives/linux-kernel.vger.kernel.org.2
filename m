Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB93119F1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhBFDY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhBFCmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:42:49 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36354C03326B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 17:00:01 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o21so4324522pgn.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 17:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=oZZn+JIFzp4LWSCg8/YO74j3ESlzJbwnYOeM6yksh8s=;
        b=RM1t6lsPR3igckIl3lWBdHup4gr3aPhGgfaGPnh8h0uEfj3/qJk5FBSTQpdLllXPiJ
         83BWi6oVDd2Kc8Ng0izzH5fownZ/hmjEQrwWuL2GL5JqtWzuIE3n25MdUvpdp6FZuWUt
         C4BMqqWULQq1lGICsXtIsj3/o9nrG/G+qnb+4bHl/qK8jwhu5zGei9zewr4bqUlcSSGv
         rIrju3WHZZvdmx+sHjpGpW8L2Tn9MHGs+BE11XAZTmahBepoXBcbf08LRudZ60WqCQYO
         3OmxXKmYzfxbGdR9xpl3r/ZtadKj1JOYZeA0a/H9Cm7BHJun+WkAKpPu25DAKfQh4cu5
         5euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=oZZn+JIFzp4LWSCg8/YO74j3ESlzJbwnYOeM6yksh8s=;
        b=oSTDPzgIVoGsAEsxSO8T2hK5hnYSbs8TC3QLpg8VbuzbZY1rVjd1LdnKQPZPqIDtqs
         k7g+8WRb3rMCF1Q9dwe9gHUQImuzQs7P3zTHmeNxWbo3qyXjdni5S40PfFJbcm7hI8WD
         TaUWQA4bvgrSHvdsIjz12mI7z8e4CMdO+RH+enac1eMInBLCfNq7/GNZgaWVO5AUxi/A
         bXGo3Hk8T8MA+wnIWt83EmCKmr55Yj35t9NJ2lsNYjWwd+RSg/uKwCLwGB9rR3nGajP9
         3c0v7XbbRRGMJJ620G/F5n+ipCqRauGa8CJzIsVYPkd092QmYTcDgByB0yl4WMuG+kdI
         PQQg==
X-Gm-Message-State: AOAM531DkSr6NHl/8S26wrmqh87F52lWfAujqym2uB65rxkIUxO/ZR72
        hsIiKHZrbcMJj1P5JTAoFlimNlRcfwjQdg==
X-Google-Smtp-Source: ABdhPJwgIaqre/KLGqNDMISVhMpJeI5UQSoPXI4W5DdAtx08tRixd45QUFW8/KGK7bEOQxuzBDqmBg==
X-Received: by 2002:aa7:8f13:0:b029:1bd:f965:66d8 with SMTP id x19-20020aa78f130000b02901bdf96566d8mr6745369pfr.80.1612573200364;
        Fri, 05 Feb 2021 17:00:00 -0800 (PST)
Received: from google.com ([2620:15c:202:201:ece3:2313:611:d02d])
        by smtp.gmail.com with ESMTPSA id 123sm10965160pfd.91.2021.02.05.16.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:59:59 -0800 (PST)
Date:   Fri, 5 Feb 2021 16:59:54 -0800
From:   Benson Leung <bleung@google.com>
To:     Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Rajmohan Mani <rajmohan.mani@intel.com>
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org
Subject: Re: [PATCH 0/2] Add support for Type-C mux events without port
 partners
Message-ID: <161257294393.387556.6550563862754358247.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r+tXoRC1u64xSd3I"
Content-Disposition: inline
In-Reply-To: <20210205195113.20277-1-rajmohan.mani@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r+tXoRC1u64xSd3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rajmohan,

On Fri, 5 Feb 2021 11:51:11 -0800, Rajmohan Mani wrote:
> There are cases, where support for Type-C mux events is needed, that
> does not have port partners.
> Enabling communication to a retimer connected to an USB4 port, when
> no devices are attached, is a case that requires support for handling
> Type-C mux events without port partners.
>=20
> The following patches[1] are needed on top of the mainline kernel to be
> able to verify these patches.
>=20
> [...]

Applied, thanks!

[1/2] platform/chrome: cros_ec_typec: Skip port partner check in configure_=
mux()
      commit: 38f56061c892c237ad4ee733cf3981a84f6b6aea
[2/2] platform/chrome: cros_ec_types: Support disconnect events without par=
tners
      commit: b4b06c97729547d03a8f49c6774c8bd69150ea4d

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--r+tXoRC1u64xSd3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYB3qCgAKCRBzbaomhzOw
wu60APsGQC0TGnVr1yEAsUxcFWihYcnhOHoxJ3zD9b7+BhTTAAEAxb3P0uPBj5fH
VL9UsUpGguy/w4XZsILHbgS/WkZmAgU=
=bFDO
-----END PGP SIGNATURE-----

--r+tXoRC1u64xSd3I--
