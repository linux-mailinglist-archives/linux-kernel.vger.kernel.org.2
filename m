Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AFA380422
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhENH05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhENH0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:26:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8186610A7;
        Fri, 14 May 2021 07:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620977140;
        bh=TrAShEj1ptSA4c+OLQ9qKi11wcim5O2IeOtGTZ7UqA4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=uJ25GfOjBNcagF/Wg/X/WQDfpOe5fr3IJGN+gpIQk0NXhNdvHnmJ8lQscsGLrq/4N
         r82JE8ojB3XyOq1rnAbC+SPEBoOtWCdlSN16TZEOvZnlf+blDY0VoTuT7uAC5O4d8O
         MEKHCyZPDMDxxJZp4gJgXUAgNFWE6G15OJ24yqubwYG1pBu259HsbASEjZKWaMyzqU
         GewZkQsfLBcK5534CuppAHDzwBKCtm8kTe/yvCwJvpCvdeSX60orLxn7vbnlkb17uP
         jd6A0z6laOBs8+YF+Z7dNCJqV0p2XL5b8ug0bXFzQKBLEkDtsJbc1TX1AnQ2MmZBmF
         kySLx+puGMZ2w==
From:   Felipe Balbi <balbi@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: Re: [PATCH -next] USB: gadget: udc: s3c2410_udc:
 s3c2410_udc_set_ep0_ss() can be static
In-Reply-To: <20210513050544.625824-1-yangyingliang@huawei.com>
References: <20210513050544.625824-1-yangyingliang@huawei.com>
Date:   Fri, 14 May 2021 10:25:32 +0300
Message-ID: <87h7j57p5f.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Yang Yingliang <yangyingliang@huawei.com> writes:

> s3c2410_udc_set_ep0_ss() only used within this file. It should be static.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCeJewRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUia/AgAtbkAL59Za5Y6RLpK83G1aoMlXhb6M4Oy
Ewd+DcA2L5M6XsLNDJdpvuGEolidez96eZHZaj+ri2KT4N9CaVguyNkBHDqtNm9R
hmhbI714PWIUhVoYhJ/lw/nJ1QbZsdKxh/OAdLy5qy12MhX1GX2lmR/JMcCHodTl
EFCSMcnWOLRgXlcyLy5yUGT6zsGWsyLVytqRFsYG3qIfCOk1IGMdCNXd3AO++t4A
KGaJfydulNH5cUnCnsR/RW8I7VITwXF6sRNg2jzHBlUeSKXp5kKyfByy6prrCdKZ
iRSB+cUWjVGpVk5/zslEji+6pCXAlepMmuC1cwPYDD+CNbyAe6BCoQ==
=jNop
-----END PGP SIGNATURE-----
--=-=-=--
