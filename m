Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BE830C4E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbhBBQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbhBBPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:11:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCEFC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 07:10:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id a20so2447590pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 07:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EqKW371o6rtP9En/4t0IaIqN6HCQJfdRkRnV8RVUO+s=;
        b=WTQJVesWc4+AX+b1JtfEMaesjgFd0Mf3Q2pOWOaY0axttKC97JGbEs5gocxJuX+n14
         2HM22Lu358PG9L4Y5jHBUc6rcZ8oBDUFnuwEVvi/ui2JYF2n1uiyPqNaQRU3/Ti01NGS
         O2KQj2aUBb1n+A0uPoTdWTbuKvKZ2LGqDl7+glhz8Kp1Jv6Duo7CC2poq/miaH+TGxTh
         p2n6IE1BTS4lXq0pGuKhx6eGg1Bj+4ijsUQgQMC8/SAYe7CS/SYCDH9ZDcVW48zL9sFm
         qR2EJj5oWTh+KK0BfrP04IeJfEjNFijigKRA7GiOXuTquFARZ1Tvbraq3+1OQg6YQXL/
         d5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EqKW371o6rtP9En/4t0IaIqN6HCQJfdRkRnV8RVUO+s=;
        b=gQ3Ajy8WrpVU2F0krLQgBU+YbnfCrxx6juoC3L9kDBEkOsBJc9LjIvv1x6qCim1bbn
         bj8tKgZqxbnUvZfkbPtZ2mwDXGXJokk4nXbR8cUPYua42B9oP75I6tGpcx0N96KGFNx+
         l2gYPTQfzEitDTK+gQBLXEZjYjvBw3YabFts9piKV6ScGUHGXV8XY0Rb0eRCCKEmsbf9
         y27At6LjMoDePekBzz0n/3TIaIq40Uyot7MtO8vv3RF4ACTcCK4JMywrhuF5dT8J5nkS
         dWYTLnLLUzbKf5j1/0R3JF9qOndQIZ6Pw502/QzZp49NDfD/dsA8gEZA2chlgQhOXf1c
         V/mA==
X-Gm-Message-State: AOAM530V0yyIgMaaTf0PLATsfWiCvSkyTs20BceS+MEiNPhunobAeq8J
        /iOzKur4O4gUOegFpikpfIZkrA==
X-Google-Smtp-Source: ABdhPJz+xz+MQ9+W6QlJakZCeehrN7bMsTdCkNbX/tQMEC4KGLBHLnsH47+SRNxhnoC6OBBWgnx/4Q==
X-Received: by 2002:a17:903:2305:b029:df:c991:8c49 with SMTP id d5-20020a1709032305b02900dfc9918c49mr23883745plh.8.1612278622095;
        Tue, 02 Feb 2021 07:10:22 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id k128sm21694983pfd.137.2021.02.02.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 07:10:20 -0800 (PST)
Date:   Tue, 2 Feb 2021 07:10:14 -0800
From:   Benson Leung <bleung@google.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        bleung@chromium.org, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Return void in typec_partner_set_pd_revision
Message-ID: <YBlrVgJJMXqiocv7@google.com>
References: <20210202095512.761214-1-kyletso@google.com>
 <YBlpnMKzGBcP5Ybi@google.com>
 <YBlrGTaJQp/pCeJK@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XEo4q5bdcjfPOAx4"
Content-Disposition: inline
In-Reply-To: <YBlrGTaJQp/pCeJK@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XEo4q5bdcjfPOAx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2021 at 04:09:13PM +0100, Greg KH wrote:
> On Tue, Feb 02, 2021 at 07:02:52AM -0800, Benson Leung wrote:
> > Hi Kyle,
> >=20
> > On Tue, Feb 02, 2021 at 05:55:12PM +0800, Kyle Tso wrote:
> > > typec_partner_set_pd_revision doesn't need any return value.
> > >=20
> > > Fixes: 29b01295a829 ("usb: typec: Add typec_partner_set_pd_revision")
> > > Signed-off-by: Kyle Tso <kyletso@google.com>
> >=20
> > Review tags for <bleung@chromium.org>
>=20
> What does that mean?
>=20
> Please respond with a line that I can use...
>=20

Reviewed-by: Benson Leung <bleung@chromium.org>

Sorry.=20

Benson

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

--XEo4q5bdcjfPOAx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYBlrVgAKCRBzbaomhzOw
wrlpAQC2RSA1yb6r7vnrVJ9NdP8Nf5SIvBJuPEdsD5C5omP7TAEAzVUprcBR5JdV
kbMlfO1g6FGMwdsl20KXe0ngnkb7xQ8=
=Y2N6
-----END PGP SIGNATURE-----

--XEo4q5bdcjfPOAx4--
