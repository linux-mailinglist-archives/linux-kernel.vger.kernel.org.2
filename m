Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCEA3D6A28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 01:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhGZWkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 18:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhGZWkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:40:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F811C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:21:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso2284402pjo.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=jwE8iPnou8eAaCB0WRZyacOP06sDJ9ZFrD6Y2YMgjvc=;
        b=vqHFebVP8e0qZUP9vkWk0Uc4r37bQDuazoYjqcgV5njW9KM0bYYLfR5kYGSlTff3Jo
         fr+P9uQmIV/BggIfggbiQuqqJJhtbl6xYPoNrWk0Pi1swfygbZDE8lm+m4EOMvBGOx6o
         B2n/z/8IiXYoFJzx9z7LS+XcLYac1BxYytLjMAamvyfIuMoRnn3KX0yALSb21MMSE0m6
         rBjHFPzmgD2HihbVwg2dWXB4f3wlXOudAT5xdNrDvEMJyQmxZ48tVlhOuPxdbofK2kFJ
         +r5v6+8rt/zj52uy6HdyvGMwO4LCfNCOQ2A2UNR1kpUnQcHj/hex+gyXyMMD6oDvFtSE
         e39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=jwE8iPnou8eAaCB0WRZyacOP06sDJ9ZFrD6Y2YMgjvc=;
        b=oK7hu1D+LnA0qMIeMtKn81zXUOZRKSnLYJo6WD1q6ywwvKYpGDNu5Mgf1YptHcPVh9
         xxUhpLmUSH+OS3ax6b3tJiwej1wqd4uwfSnFFkn2BreAwEoza3kfMAI/RxOYIyWBlkrn
         xYowqxtu4yHdg7iNw+FlvbWBzTvKTJVqBJ42EhgugJFGgspVCyhmZiB39yj964VF3YtU
         J0g8TEKs5Iy+piA3SrYtiPLpgeiHNX00Fw7lOko2m+yRD74n3qAkuzksHyyV8WE70EF1
         AulRHa0dAQoKR+oTSOdvjaG8JOUrzPjofa7QPOc5Z4lgSsKRKXpIL6qoSInnjj3kxx07
         nbQA==
X-Gm-Message-State: AOAM532fST+cvTynwnm/Jm+cn7jjNBGe88PgvStXQSbD5tFO+iOMua8/
        mXpL4zUdfP+GHdDDmxMfV2WntQ==
X-Google-Smtp-Source: ABdhPJz0Y7NQlIogU5gFrXJVNl7z/25YkRK2Wp85B7IJFsVkoMRKIc7/QNjzzEed2ZM30RoICYoZUQ==
X-Received: by 2002:a62:160a:0:b029:328:56b9:b1ee with SMTP id 10-20020a62160a0000b029032856b9b1eemr20254568pfw.52.1627341661469;
        Mon, 26 Jul 2021 16:21:01 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:e7ce:f790:a304:f54a])
        by smtp.gmail.com with ESMTPSA id l2sm1111556pfc.157.2021.07.26.16.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:21:00 -0700 (PDT)
Date:   Mon, 26 Jul 2021 16:20:54 -0700
From:   Benson Leung <bleung@google.com>
To:     Patryk Duda <pdk@semihalf.com>
Cc:     Guenter Roeck <groeck@chromium.org>, upstream@semihalf.com,
        linux-kernel@vger.kernel.org, bleung@google.com,
        bleung@chromium.org
Subject: Re: [PATCH v2] platform/chrome: cros_ec_proto: Send command again
 when timeout occurs
Message-ID: <162734150752.1757423.12568889339349684744.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d1KsMKyOJHLKsvVu"
Content-Disposition: inline
In-Reply-To: <20210518140758.29318-1-pdk@semihalf.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d1KsMKyOJHLKsvVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Patryk,

On Tue, 18 May 2021 16:07:58 +0200, Patryk Duda wrote:
> Sometimes kernel is trying to probe Fingerprint MCU (FPMCU) when it
> hasn't initialized SPI yet. This can happen because FPMCU is restarted
> during system boot and kernel can send message in short window
> eg. between sysjump to RW and SPI initialization.

Applied, thanks!

[1/1] platform/chrome: cros_ec_proto: Send command again when timeout occurs
      commit: 3abc16af57c9939724df92fcbda296b25cc95168

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--d1KsMKyOJHLKsvVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYP9DVgAKCRBzbaomhzOw
wgb5AP0R9D/kM6LOj6Fa0F/rP7OriYZTtEyuYoCUb72eBnXPuwEA/b9P3RYQgBKC
5544Yq5c2w4XUrCXmoCwPC+yQIOIOQ4=
=3w4x
-----END PGP SIGNATURE-----

--d1KsMKyOJHLKsvVu--
