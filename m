Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F67B375128
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhEFI4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233955AbhEFI4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:56:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E85A610FB;
        Thu,  6 May 2021 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620291302;
        bh=HypYNEUvZPshB25whGPVVHjWmP0jpG/9EsnncaZJijA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Kkc7eHgTImYp2GhthiuRiJToRBzR0KsZ+SDRDhY+N6Qf1ORgR0SVbCKt+RPxTBzM9
         4Nbz7/jmgQuM5HwKLBoBRZtQUd3gU5NQde3Xe3UUR4t2EV2HXFreErfkhlJdym9WpO
         q2MHpWWGj/z3a0LHb2JUsPN1P8a3qAKPVF5JrTIB8Yz4dse0ukto92N1fu/aV7p8EG
         N++0qe0TdoLtmb4qkn1XmXrD9Rt7ZZzgh0seLbamJKUZsR/QMlYdqtwJWQSxxSzB6Z
         ywWeGccOx+ZJzihoZnZ4W6HpIMnWxh3zXH6BqtsP5iXwor/cEJG4Z1GBpZaBw15DD6
         4SaE8Qm9P/pqg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [PATCH] usb: dwc3: remove repeated setting of current_dr_role
In-Reply-To: <20210506072608.32320-1-chunfeng.yun@mediatek.com>
References: <20210506072608.32320-1-chunfeng.yun@mediatek.com>
Date:   Thu, 06 May 2021 11:54:53 +0300
Message-ID: <87tunggs2q.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> dwc3_set_prtcap() already sets current_dr_role as
> DWC3_GCTL_PRTCAP_OTG, so remove the repeated one.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

looks correct to me:

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCTrt0RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUjZcggAq/dFh2Oz0a3/lRmAeiVVGmmB3VKWx8Vu
Rs4FlbcKpggPJ3VUtEC7Geg6efKgoYfkyOU7OPXvLz7Z+yrIWw1olfKlDyLRFdBM
rF55QU3vpARX6eiewyZCZBHVr3Gr+6htciyu3GKJF0ZjLhmSIwZeeY3taCWYAQHr
R+L7yxjoqZ6Hfy6gvqWXO8Wfwf/gqnd4G7AwoS0u/ByJfG0UiuKEgUwyqmv8NzUf
wjCU3K0cAi2neaXifVllZN5U4lg2BrnJ9TFyWDAlzCPBXpV0qUOsj2m7TwrpxURt
OGJ+usZ+adB6bjASXjYNFxKraovltbzA+bYY903A3vsVpRBQKzR23g==
=IFro
-----END PGP SIGNATURE-----
--=-=-=--
