Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED90B441159
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 00:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhJaXEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 19:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhJaXEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 19:04:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE83C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 16:01:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s24so10436193plp.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 16:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=sXsy59nkm+x4I8q82QAi5Hn9Gi9Qo/W9vpXNqJNq07M=;
        b=oK0tXIllB8ObEtv1NKcDvw106h2ZMxTTsVvGAW3ZLJYG9JmE8X7EeKTN+82Riy9Akw
         a2pV1wEWCVBmdiqpllGjkB7KrImxKmgGQ6dKZO/yvWvPbh+FKsf2BPz02LbHrZtBzlgb
         lqMh4Gg/EYOhSu5bHoROq6kkhjoGDLvTKETaLE1mrxjWfe/VMUwlE6YK43avYCTMSmtT
         TeSUqdj/o8i9Qp3gCg4VLt86ShX8MQeNqrTgB0loikvLxgvMotg0cIBFN8QZ+jIBbwOa
         KQ9T3Oofu0FnYfODnJNqMdsgj8d0cXU+4dUqrcsu6h1vLZlfijIyTOypLOT2nmjtvqZr
         520g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=sXsy59nkm+x4I8q82QAi5Hn9Gi9Qo/W9vpXNqJNq07M=;
        b=2KiSCzSbnRL7M/xxO0XBpzDhdr1n7sE9Ned6GluEp1mllkC8ITGFYFukJEr+96s/XU
         2xL5gAY3orzWxVANeUQA3QUDHBr7/ThrUO1lsMr9KsVgQ6UH1A3TjmKtBYHk8al0/G6Z
         iilb55+u/zAl0LxYE0v4+z+jp8Olj4N1EfzAnpeml9tnswzm5CMIW7C7z1oOGjrHbaJA
         XRhnY/7RHBmM8rK51Aa5vivakds+DLmdkP57Cmf408j4Oig5u5kzHU9NtNOHWjyYxMa0
         7MDGJARheJPytiLYQrYxc2yNxJoHieW7mksuXqduO+oRaoyCO4fGRx33/SFlKHUi0F+D
         fLCg==
X-Gm-Message-State: AOAM532qB4Z1oEjSNIQ2pHrJj8RaRLiyoITrWV+/5jIb3v1DJNSKwE7o
        PfYmJqRDfA2NtjC6mUz/b3VLrH4ydHCLbQ==
X-Google-Smtp-Source: ABdhPJzCHjDKqSe+qvt0n5PrJPNqJsS6EyGJMsCLP/lMxMiemzSL9927FZ/uN4nKc6sojRB8jgz90Q==
X-Received: by 2002:a17:902:d4cf:b0:141:d36c:78f6 with SMTP id o15-20020a170902d4cf00b00141d36c78f6mr7342851plg.56.1635721307486;
        Sun, 31 Oct 2021 16:01:47 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:6f5c:6c4e:1798:d0cf])
        by smtp.gmail.com with ESMTPSA id s25sm12818279pfm.138.2021.10.31.16.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 16:01:46 -0700 (PDT)
Date:   Sun, 31 Oct 2021 16:01:41 -0700
From:   Benson Leung <bleung@google.com>
To:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_proto: Use EC struct for
 features
Message-ID: <163572120352.2079946.6960520137860452667.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twKEpGLg3YemdzOe"
Content-Disposition: inline
In-Reply-To: <20211004170716.86601-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--twKEpGLg3YemdzOe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Mon, 4 Oct 2021 10:07:09 -0700, Prashant Malani wrote:
> The Chrome EC's features are returned through an
> ec_response_get_features struct, but they are stored in an independent
> array. Although the two are effectively the same at present (2 unsigned
> 32 bit ints), there is the possibility that they could go out of sync.
> Avoid this by only using the EC struct to store the features.

Applied, thanks!

[1/2] platform/chrome: cros_ec_proto: Use EC struct for features
      commit: 7ff22787ba49c2e66dcec92f3e2b79ef6b6a0d71
[2/2] platform/chrome: cros_ec_proto: Use ec_command for check_features
      commit: 297d34e73d491a3edbd6e8c31d33ec90447a908b

Best regards,

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--twKEpGLg3YemdzOe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYX8gVQAKCRBzbaomhzOw
wliEAQCbb1oSHT+l35Dit0ZNiukuRBSXXnhtUrnBh3Fh8dY5OAD/cwuYeDrbDXIF
mRnfNRYQz9GLjp7HGIUd8XcR1f/X8wo=
=8WoH
-----END PGP SIGNATURE-----

--twKEpGLg3YemdzOe--
