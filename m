Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2708E39A350
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhFCOfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:35:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230446AbhFCOfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:35:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EF69613D6;
        Thu,  3 Jun 2021 14:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622730842;
        bh=ePguWSm6IUi7J34haJRKbL48baqv/od3GKakWa5lKjo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Pg6QMJVd+uqWPoQ5YTL67bi/qfHAdh47SYlgExCc7uwCMxNx9BxkcVbJNW4lFTAkh
         hKZU11Frz4QU2/94opn3MUTlz/5iTNcgjHSgqo6JKWHJTnlp9CijdvOLj+NzlFv+QB
         DgbS656upfoLPxf46E7n9v7NXphrCrfJ4pUd4+WJ9JNtyo28uJZJ/VKlHcFUFoonMC
         6xzhKTRtVN2bbTvKLIqrKysQKUU1ZbheQISm3u6RN5K0wXoGhCt2xGYxfsMjsySceO
         GZ1yfS3/9DQV1Upqn64Bg88SrwL7p1u0FfH3JMFaY0bM+GAbGcWmD7mWGBRCjfFUB5
         8ZSCFEVgk/P6Q==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] usb: phy: isp1301: Deduplicate
 of_find_i2c_device_by_node()
In-Reply-To: <20210521145243.87911-1-andriy.shevchenko@linux.intel.com>
References: <20210521145243.87911-1-andriy.shevchenko@linux.intel.com>
Date:   Thu, 03 Jun 2021 17:33:54 +0300
Message-ID: <87a6o7c90t.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> The driver is using open-coded variant of of_find_i2c_device_by_node().
> Replace it by the actual call to the above mentioned API.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmC46FIRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUjI6Af/dcHPqnojZ4vC7RuGGLl4Y12R5LYRqnO4
71jGMI14lASrV3cp4DK2D4QkiKVxXj7VlIX2XHqoHDel5EXH4gvEG0m9k/Gjh/9K
hvYf0H4+VhvgQFpBQPHIOklQwMsow9stfH2GDwknZ+sfVMJcm/f3xqcRTZ0ZVeWO
2rVFcTJsezQsrN3z95mWp00YTaNHgebpiFLcyavF0JNEqtsq3gBehMCamXgTl7wk
qnD2W1v85dM3WF+8LbLOnPowGmtEQ+ZNh34z2Wa4i/+55bCZQWB3wsnMB/9vWrU4
s2ZL9hv4JVCIQdi9nRclc0KaAlGm/xoUbb2WU5Huz9Rk5Chxt10QIA==
=LFRq
-----END PGP SIGNATURE-----
--=-=-=--
