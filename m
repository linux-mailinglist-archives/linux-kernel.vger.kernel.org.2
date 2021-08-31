Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11ED3FBFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbhHaAO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhHaAO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:14:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:14:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id bg1so4256053plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=P8+JdCKC1AK1PfOvG8dnf+/CiPFEbFmDeMcaMvZw4Tw=;
        b=peX9y6iOT8HkjW1o3cf/KVegoB3fhVBAkIWEtaTiGbz5SZ6nNAkp/VeMqJvo/5hWF6
         d6XrUHcavlymHzqGYAP7ehbQlHxD91QJ9KnDCUaLO8fNQTX3pq+87gnvBJlq5jb1zQSQ
         tJC6yeXnVjtTIim0rPBsFxWXU5KZ76LjU5FaTkkRe0P+IE29Smxo1q5PBWjS3sbHjNGB
         dLtX0BcJ82FH/5Avt1NThDQN0XgEBaY2HiUeRvI7Bc/O52jSv8LSNltBwlodbo08+cBF
         cp9EbF0/eXaD1LS/+OwW3txAztccFVNAAmWBostSq2aP0pEP+uCXU3MNCH+qqk4OUC6y
         SZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=P8+JdCKC1AK1PfOvG8dnf+/CiPFEbFmDeMcaMvZw4Tw=;
        b=SuCEB1iOq/SjbLwAZNv1q9oxdM6W507jJJvQSI3sQdlxSFESCWnaCfMrXD8JfGsVf/
         9Z0+EdFYgbJHL6kj0uW7PYTM1Shdp11NegvAUGh/R/dPEqb9/x4YVyUPcmaJ5/jZLHs/
         jl/onkM4IiLIzuRp1cchF/qwVOPsVzzm81Q57/v7FNmwIm4aap2ikGkF4g9nV+YRA3t3
         8DMdt8LHfj9pLZTXNnVP7+d+sgLt1UrOC9v4vhsozZvZpH9ovUt2RvqCS1o0+69SBzdJ
         4zsWNQFqfNUMF6h7PQYZYw1dNC7XpniZboGu/qVdkKgDdBg1hlGb78iOFKxOBx+f4Xr7
         WXYw==
X-Gm-Message-State: AOAM532WisBIYQ6m2we7Cb/Yb8gSeGnSqhXS9SR1vedeMu7MnPAq0oKs
        s+C9yWgiPkLWGFoh+qUPLQtqtA==
X-Google-Smtp-Source: ABdhPJz6aZ/unH5uYmi4dSkk37oMKaVaJjkc/91HoVdmeA0GET66IQkTs2GbmZkoKXy1kR2zZ9CsaQ==
X-Received: by 2002:a17:902:a604:b029:12c:dda2:30c4 with SMTP id u4-20020a170902a604b029012cdda230c4mr1944345plq.73.1630368842329;
        Mon, 30 Aug 2021 17:14:02 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d2dc:2a51:77c9:8407])
        by smtp.gmail.com with ESMTPSA id 15sm583193pjw.39.2021.08.30.17.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 17:14:00 -0700 (PDT)
Date:   Mon, 30 Aug 2021 17:13:54 -0700
From:   Benson Leung <bleung@google.com>
To:     Gwendal Grignou <gwendal@chromium.org>,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        bleung@google.com
Subject: Re: [PATCH] platform/chrome: cros_ec_trace: Fix format warnings
Message-ID: <163036877941.809543.752509524579579884.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ju5jcConUq7qjl0X"
Content-Disposition: inline
In-Reply-To: <20210823200132.2006257-1-gwendal@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ju5jcConUq7qjl0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gwendal,

On Mon, 23 Aug 2021 13:01:32 -0700, Gwendal Grignou wrote:
> Fix printf format issues in new tracing events.
>=20
> Fixes: 814318242 ("platform/chrome: cros_ec_trace: Add fields to command =
traces")

Applied, thanks!

[1/1] platform/chrome: cros_ec_trace: Fix format warnings
      commit: 5a51bdb0ae26cac8764bfb59839a34ea13155a47

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--Ju5jcConUq7qjl0X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYS10QgAKCRBzbaomhzOw
wmsMAQC0akqwKK1RegZOuP4k72ThhSGIv0mcMXC0ZgXRnDWCawD7BYZqS7tDfJz6
R2R6ng4LcwvX52wMbrdX2oX9QWDnvQE=
=jbVf
-----END PGP SIGNATURE-----

--Ju5jcConUq7qjl0X--
