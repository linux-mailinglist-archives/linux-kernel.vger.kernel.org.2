Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B1C3FC030
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhHaAtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhHaAtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:49:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396DEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:48:44 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s11so15089191pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yFaWzb+TLH4WHLdwXSHNeJ4rSVU4dAPnjRX35vG6J3o=;
        b=Q/zSRh/rS17rNG5gLUB6XH8qFy3N93vhHD8DJcoDWWfwtM6YJMDv7NVg+auPdojVzn
         E2QXd/b8mgd3VbPxjn0DYt2fh5QKpg3JXdjgWcZclXEnXu7mNyQuhx4liM2XT8GlqpI5
         UE9CUcGCHSQOREo/ILO8auhT0TObUOiYVneW74gVen4TQSf2eWQUwSahGyiVgG2+MQl9
         KSFVlCia87RDu5t89kAEkG4NqRpvvJQQqEW3aRI/XnK+flwudjeerkSEDdaYnikFZrQv
         +4wTVMIw2uUpqoZQZj/WJGc7avhGs5mudFqcg5WSnTGENCqvPROt8p3DymFqKI9amfkG
         VloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yFaWzb+TLH4WHLdwXSHNeJ4rSVU4dAPnjRX35vG6J3o=;
        b=GYGXcImRDjiPVo/UBvLdGWi5OjOB1q3kH97aPpYLphTUwZY77u2ZSNi4EyWkotEoSa
         a3FzHbanzH5E/X+zFH9rwhNohOPvBuOHtRIwx2XTfV/pdk9EESLJhXqYgO5obutXWd0l
         oRt89KGxXj/mfG2QRKR7rDY1R70HNl7X692cJAW/4C5zpAtU7JBH5A1CCUuwkAFyOBQF
         RBM2zIH79O3cbFC0ZAKNJOsraekJGsYRVL7/wdbkqgEexXRLp0XcnqYKMUCjpVGBftgB
         D3ny4qmwm90TO8rOTNof4cs8tcHWa4EZGXesv56KWFDouWJas2RlcopiOo1D1Yn3Q0uH
         whHg==
X-Gm-Message-State: AOAM530a/4tlrmoa5PKmBVBvAaB0Vu1tLOxBaT4yJMoiWe9xkXNC9Ydq
        b/bddSHVRvTne2RpxqIJh3+IGA==
X-Google-Smtp-Source: ABdhPJzlUDwU/F6Inn7zoPYFB091hLOckUyDZJjmcu+Dsy0HjXMCf3Qr26QuUUXnhcUbEixSTolCHA==
X-Received: by 2002:a63:db4b:: with SMTP id x11mr24810099pgi.396.1630370923215;
        Mon, 30 Aug 2021 17:48:43 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d2dc:2a51:77c9:8407])
        by smtp.gmail.com with ESMTPSA id c11sm608804pji.24.2021.08.30.17.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 17:48:42 -0700 (PDT)
Date:   Mon, 30 Aug 2021 17:48:36 -0700
From:   Benson Leung <bleung@google.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the chrome-platform tree
Message-ID: <YS18ZIR7+DctTlCH@google.com>
References: <20210831103906.5c590f67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sz57E3mArmgEJ+Af"
Content-Disposition: inline
In-Reply-To: <20210831103906.5c590f67@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sz57E3mArmgEJ+Af
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Tue, Aug 31, 2021 at 10:39:06AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> In commit
>=20
>   cf7f3ebb41d8 ("platform/chrome: cros_ec_trace: Fix format warnings")
>=20
> Fixes tag
>=20
>   Fixes: 814318242 ("platform/chrome: cros_ec_trace: Add fields to comman=
d traces")
>=20
> has these problem(s):
>=20
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
>=20
> --=20
> Cheers,
> Stephen Rothwell

Sorry about all the churn. One last time, my for-next has been updated:
  4665584888ad ("platform/chrome: cros_ec_trace: Fix format warnings")

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--Sz57E3mArmgEJ+Af
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYS18ZAAKCRBzbaomhzOw
wvyiAP4+vVrVa/MpotuHcn1IcLM4SrJrw2fgefeQh1xu3ypwlQEAo2h6BRVujjKN
jyvtobrqUXEsDEQ8wNQytkg4U6P1SQo=
=RDfB
-----END PGP SIGNATURE-----

--Sz57E3mArmgEJ+Af--
