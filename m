Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2B23F091C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhHRQ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHRQ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:29:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD2EC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 09:28:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso2718420pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=zMI/sJPr9AxAdibfY1LmHyxKcQfoBxpZC9RvVsQxvXg=;
        b=XeQ/Xt5tb5oRPyA1jc97uV7ubp5xcfSZ00ZfUDiDrgHbHIqfOKxyQMfEhX31nJ9p8h
         3fdCZbCBLAImql/lSEpQFwUlTc4RtE8/K1EqU7mIUyE8J23rxTTbN32dC/GKjSB3/eFy
         UTEscc3wkKYEr6885zW8gvnwsuB7x2miScYosK16PplEYs0c8YoAEe/qG9IrNfo6QCRi
         hOaOkKfvqXLjQ3LmPMjnN1nLtk/waa7mg3FZuf87MnHxgBasTPy/CMcbqGtkerNRGw+N
         8kT3gsrOmEqGvD42veeHJK2PTSpQAgfDtkN9A8PAyLiCZOgp8Xee9cad+f28ryCllIa8
         lVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=zMI/sJPr9AxAdibfY1LmHyxKcQfoBxpZC9RvVsQxvXg=;
        b=mpaNzm1Fcurgvvt7RZcv9SWpMHumSeVawVoinMz4WsbrpVg/4HSd6zVPBjVoOeXxBc
         5KERrN/gxgyLXbJUawT81XpkuGA9uN9EAixeeRiy5artSawBCF33LKYL6KO0jZsi9SCm
         KBQoj1HKlS/Bi8EhEpI3goTEzRnuD2XugVTJ+QMCPe0HIMJIZ+VVH7vdU1og3mY/pmfW
         TAEgV/yWz4z8uTphkSwCuhcOxoslirmT6KrD+JJJX7X++8ZlzqzlpUcgXdRgMtTb6Qyp
         LGI0kYzuvTH2GvBRearK3oyyQhXF+KwDH/iiJfwgdHraplgw/toa/ykbj3tAeJUtI0pD
         OyUg==
X-Gm-Message-State: AOAM531jdOYdfv5IQa21WP2a920XmmKpI32lD5TnJLsOZPN7753RTYUd
        jYCOkoG7ZsZhJB/yLc1uiarylc0kILxoKw==
X-Google-Smtp-Source: ABdhPJzAd3tyecAB59abWIdGGzX4hGvN37mWuR6S0NvhFCnXpG9VAywyjKAGlUT2v9T7jSSVi0qOQA==
X-Received: by 2002:a17:90a:8d06:: with SMTP id c6mr10100980pjo.9.1629304136987;
        Wed, 18 Aug 2021 09:28:56 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:3d3f:436d:c957:b88b])
        by smtp.gmail.com with ESMTPSA id w145sm235157pfc.169.2021.08.18.09.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:28:56 -0700 (PDT)
Date:   Wed, 18 Aug 2021 09:28:49 -0700
From:   Benson Leung <bleung@google.com>
To:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, bleung@chromium.org
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_proto: Update feature
 check
Message-ID: <162930405787.1994945.17127194721609468006.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LqN424g2CWOByJnw"
Content-Disposition: inline
In-Reply-To: <20210803173619.91539-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LqN424g2CWOByJnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Aug 2021 10:36:19 -0700, Prashant Malani wrote:
> EC feature flags now require more than 32 bits to be represented. In
> order to make cros_ec_check_features() usable for more recent features,
> update it to account for the extra 32 bits of features.

Applied the whole series, thanks!

[1/2] platform/chrome: cros_ec_proto: Update feature check
      commit: 3c645a03579d15de3b6ffd6d75801011d80416fc
[2/2] platform/chrome: cros_ec_typec: Use existing feature check
      commit: 7ddbb62d7b43e3334a52427cd9666d90a833bd19

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--LqN424g2CWOByJnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYR01QQAKCRBzbaomhzOw
wlaIAP4jHtmegyWW4P9ZbvrFv4AHkhiF/jA9l4SyACNslnHlSwD+N6wFdOn40mQP
guxZ+PUDq3lwNYdt6uf3igaegLZAjA0=
=0LKn
-----END PGP SIGNATURE-----

--LqN424g2CWOByJnw--
