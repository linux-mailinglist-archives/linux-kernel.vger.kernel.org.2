Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C93630C674
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbhBBQtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbhBBQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:47:16 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8DDC061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:46:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id f63so14689999pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HlX9WjLA2fX7KzMv4kzPA/gTRvAYQzupJhgpnjS3bao=;
        b=QwGoSvhfHpronz4VD6aLhYwnDEVaZwoLVN+6NxpIVeL6XZoU1IY40jt8AZLFitS1j8
         E+ZHoWdYZ0oImcdxxzVFIdKh5pIqsFBy0WYMKmJJujmhIz2+tbweAUkSh0WucUMk1Yxf
         dWFJJbws2RmLQbx5M/WSkd9jdfhl/xGAqq8xzy1nmUlCDlxYTfgyeuLJS9UneNMPbSqI
         b+ZkGZsA0c8AUB5tycE82+8oE95wxR/3v7llsfn6o4DqdedIJEl21UOV7Yqf9qK9u67V
         dATYtl4jdvbrTrBcSkmQFmwCUfZ8lYs5hlqzHVnw20FE477h9REBmgIUoI4oqDY5jPAj
         1ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HlX9WjLA2fX7KzMv4kzPA/gTRvAYQzupJhgpnjS3bao=;
        b=XjRLaS5zN6yhr7NpTrlIPs6IcuCOdjBhxYTAOWEEZ7i7Sn2iBHHnhaouYqeJ1Z/I8H
         ZpZ5maPmYd6ibOQKsTmwsK97Ju84l4yOvgzBfsIENlq2DxDgARP3/iwlJm0UBrX0FpQk
         FJ0QIJpdnZYaEI25N0HLAgCT5Vcalq/L7Q5MomDm+oEt/U14zDe6Nv/4KGMkf+w7B2DC
         segFteEnNdf40+Ys34pMXKndtfDmHlPF0UY9EU36dArTHvFwzGGoIPwVJ+jEHdjNZl28
         xV0n1u5Nh+0nLYF+oHSW+T29t0GjFr1uc/hgVJHSvGtbj6iIHdF9ngvCDsnmNo6JZh6r
         tN/Q==
X-Gm-Message-State: AOAM530BFnlTKXgYLRMSWPj1AaSV2gRnRUY+UVAQ9wFSkLIcjrcdaDY6
        ST7/rtVysat2SjtZDkHxh5TdHg==
X-Google-Smtp-Source: ABdhPJwj5JfiHzAo5Q0/hHFe8/EvnRDnc1U9Tq7uvxv5OvYDfLHPnVwj7GITHb4aPUhXAZ8WTFnEBQ==
X-Received: by 2002:a63:f218:: with SMTP id v24mr22842506pgh.244.1612284395284;
        Tue, 02 Feb 2021 08:46:35 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id k31sm23820221pgi.5.2021.02.02.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:46:33 -0800 (PST)
Date:   Tue, 2 Feb 2021 08:46:29 -0800
From:   Benson Leung <bleung@google.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@chromium.org>,
        heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        pmalani@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kyletso@google.com
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Fix call to
 typec_partner_set_pd_revision
Message-ID: <YBmB5QBciYoNRudT@google.com>
References: <20210202163248.3981555-1-bleung@chromium.org>
 <YBl/0C4yc3ST9zLy@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EcoCSIARD0xJJIhb"
Content-Disposition: inline
In-Reply-To: <YBl/0C4yc3ST9zLy@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EcoCSIARD0xJJIhb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2021 at 05:37:36PM +0100, Greg KH wrote:
> On Tue, Feb 02, 2021 at 08:32:48AM -0800, Benson Leung wrote:
> > typec_partner_set_pd_revision returns void now.
> >=20
> > Fixes: cefc011f8daf platform/chrome: cros_ec_typec: Set Partner PD revi=
sion from status
>=20
> Can you please use the documented format for the Fixes: tag (and for the
> use of any git id in the kernel changelog)?


D'oh. Thanks. I set up my pretty=3Dfuller now.

Benson
>=20
> If anyone were to commit this change, you would get a nasty-gram email
> from linux-next :)
>=20
> thanks,
>=20
> greg k-h

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--EcoCSIARD0xJJIhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYBmB5AAKCRBzbaomhzOw
wnNvAQCmAmkTTaVjN89qczWo4cSjKH3z4NYggo+Gq+nvCdvcWQD9Hp/fFtjtVZtI
Elx6J5/4HMgux8AhdhdjF1eZYD68kgM=
=wmoi
-----END PGP SIGNATURE-----

--EcoCSIARD0xJJIhb--
