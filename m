Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A86F3FBFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhHaA34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhHaA3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:29:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD917C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:28:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d5so4851291pjx.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=xeGGkS9DPy4WQB4GRPUqCeVpyyUdhUi17Vay894T7BM=;
        b=ucVRU6OZTRl3QptUqjroUzc+W4mV96E16GONQ6jxdg5NCIcd1skCJJrUv/ZX6Je6Te
         xDEj/04qo+jO2NEiasz9jT/TvfArCq3lXh+IEgp1ntpK+HGRn6e0zms1kRqEAwjxhBSi
         Nt+ved2DndfMied/bx1EPgupgHs5Q0ioeepNjqvvCIudwcrPZ7cg0jTd+KJ5DGnIShkE
         BmNW3gljkADJRB+sNPildr3lJEVz2wCgFe+d9OesVyslTxecnoHgR7sA5KZn0T0q0j9Q
         fd8t4+3fuTkq3HrTgqmwxnFisBlJ5jR83CgAW7enO22kyqz3vm+iJySr4AOT1y4D6BUY
         ISWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=xeGGkS9DPy4WQB4GRPUqCeVpyyUdhUi17Vay894T7BM=;
        b=gXZ3fpgVyTnrxaQy/bpkEvD93R7/b9Bi6Nv7xqFEBVXMS6gbPNfSmRWEYJNbBvkuSx
         7IR/sL3i04iKo0pSwZYrqBNLJlYI783CkfrrKq5moh/YGXtByxf3noGQTECKv05r8zrP
         sSyhSSx6MtLgVTgFiOMhvdV3wZyJ1/5XgwJi5bnpMiPDjy4xOb+oZyYJhbBEE00GJmge
         t8NqDXumEYU+jZMO+lzA6LVFV9WqgjuuMrY6KBNx+9++VDfsLs25gSqR0TNSTE7v2g4E
         3QWiU6NrCkfH13Qi3WRCOA8WOzWMMiTTOTE8cyubdXrhOZcjj9ZeT0O633KwOnVO3/Ni
         2bEg==
X-Gm-Message-State: AOAM531RtT9yPZjmZRl8o+1eLNt71awQEGjrCf4nWwzeZqfieN7dNYYe
        M2c48wQHWqhU5CpsAydS0R/YdA==
X-Google-Smtp-Source: ABdhPJz5lue5pFTptO9Gf+1FDD8gPlNqhCKTDpoYKvfyRms2kawjzgy2b8eYNKdVlYtLSYv/sLHqZw==
X-Received: by 2002:a17:90b:c04:: with SMTP id bp4mr1992072pjb.230.1630369738818;
        Mon, 30 Aug 2021 17:28:58 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d2dc:2a51:77c9:8407])
        by smtp.gmail.com with ESMTPSA id 10sm16731659pgd.12.2021.08.30.17.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 17:28:57 -0700 (PDT)
Date:   Mon, 30 Aug 2021 17:28:51 -0700
From:   Benson Leung <bleung@google.com>
To:     Gwendal Grignou <gwendal@chromium.org>, groeck@chromium.org,
        enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org
Subject: Re: [PATCH v3] platform/chrome: cros_ec_trace: Fix format warnings
Message-ID: <163036969532.810812.17853237113738831670.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yfgp5H1xYGyDT6tM"
Content-Disposition: inline
In-Reply-To: <20210830180050.2077261-1-gwendal@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yfgp5H1xYGyDT6tM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gwendal,

On Mon, 30 Aug 2021 11:00:50 -0700, Gwendal Grignou wrote:
> Fix printf format issues in new tracing events.
>=20
> Fixes: 814318242 ("platform/chrome: cros_ec_trace: Add fields to command =
traces")

Applied, thanks!

[1/1] platform/chrome: cros_ec_trace: Fix format warnings
      commit: cf7f3ebb41d809c143f22a2fc518d16f1d995c0b

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--Yfgp5H1xYGyDT6tM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYS13wwAKCRBzbaomhzOw
wouUAQCYoX2hzw3XD8EZuE9RjB0ZRiUuNhueifYrd3MK4nggGgEA5Q4JPEnROrn7
4exCgU0DMr9OLCoELTg6xCDRtR05dAk=
=GX/0
-----END PGP SIGNATURE-----

--Yfgp5H1xYGyDT6tM--
