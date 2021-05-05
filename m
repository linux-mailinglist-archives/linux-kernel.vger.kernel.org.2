Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7448C373BDB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhEENBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232096AbhEENBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:01:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9186E61132;
        Wed,  5 May 2021 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620219612;
        bh=dZ1xJGngjZeBKc16aKYMAdaywhBSfsmokE/IuI15i4Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iMSeO7KQ1Bt7zl2Pv6i++IToqiANiQs65/VdtKCxuan4TC36c/ak657wOgYdJGSTY
         LJPJx5+IkC9Zk+i8atXHnEXIr/f+Xuzap7Pt8y7O+TS9pi8J/wZLNbjAuJGVxx8fLZ
         rb2IGmFoM2Xhat/rVhNLGfWhoirFZr/fSTakL3N4myYkcx3VmoHkSrkB7xGQHnQhTQ
         BNa45UOV3dL71y1sJlBTZ43TlnPA6HSWb+ehNa1Gq/hGvnVuIXdw0OFVbbTLTcuR+p
         gu0Pb796mnADlA/s1wevpEKQg22+kcfhad16SCUZnmBmEPy+IMeDjOzcsDVaXtszA1
         MSud66m9XTwLQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wei Ming Chen <jj251510319013@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, Wei Ming Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH] usb: gadget: function: Fix inconsistent indent
In-Reply-To: <20210503160927.6482-1-jj251510319013@gmail.com>
References: <20210503160927.6482-1-jj251510319013@gmail.com>
Date:   Wed, 05 May 2021 16:00:04 +0300
Message-ID: <87wnsdgwtn.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Wei Ming Chen <jj251510319013@gmail.com> writes:

> Remove whitespace before variable
>
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCSltQRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUhHEAf/ZwNHOFgPfLtD1kfMZ4zlxwZB7v+d+Yct
hlHwjbV2f1SvYtHcU995y0LF/cewkCXEWQub5Raeci0lpwp9WIavoRrug+REeUCq
XcPIOO1vnMiBRK0f/QhMzFb+cDv0fT82/phJMI1X562ZcDlUUO18U9dTiKZlFzyz
hx0K3SO45HqbhZUetYcZUQ90d60PBNVw7cbQqPKeg1DmL2wj+VHMwxnmR9kaaNiG
rdG4g+76rH1vY1l2+000xOnGa5ppJlrzflSpnc1baD7mmQh39UCqHxhHVw/nU5pJ
TTY5C6FJREGA1ZL3AARaQTtG1+NGYkexX6icULiPdcg8MHAP3v4hiw==
=9+4O
-----END PGP SIGNATURE-----
--=-=-=--
