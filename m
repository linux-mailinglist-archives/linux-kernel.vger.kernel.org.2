Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167C1314ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBIMRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:17:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhBIMRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:17:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28D5D64E28;
        Tue,  9 Feb 2021 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612872981;
        bh=tbfL8g0UWBEILy7472DR/DOMnrufN5HfdOYSoxqI7EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWFQubJFMGmdTmG4mzOZgVU8YhFhlVFrYi9UC64LKagKi2Q24AULqwVRENyU0KT3E
         42mPDA85UhsgIOp42b/EIDgm/tRrGst5Z8+w/lt3Qe8Es56d6OOTQFLp+PujzUd1KO
         HcLS3DowQVwS1QLSZyKCRuLCseyMChhIafuFzeeQ2NUJBt2MfC5vVRnyNP6Db0buZB
         YerUcfe4jByFaGEVRm8jPo0Xum78C/UEf5AR6t9oC/6qdiadvILGEerPEEBAmF9lC5
         K7csb0DvvNdfM3TX4fwv5NjujpVC6iYh4qBj9wjDga/1Hkb1LeqDYqeG/j1SbVgtJL
         THu7wc7qeh4JA==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l9RwY-0002Ge-HA; Tue, 09 Feb 2021 13:16:34 +0100
Date:   Tue, 9 Feb 2021 13:16:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: drop bogus to_usb_serial_port() checks
Message-ID: <YCJ9IgwSLyNmPq5B@hovoldconsulting.com>
References: <20210208154806.20853-1-johan@kernel.org>
 <9306d82c-d030-1243-1079-1ff5339f6cc5@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k6LeVVzb1Npc5CPz"
Content-Disposition: inline
In-Reply-To: <9306d82c-d030-1243-1079-1ff5339f6cc5@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k6LeVVzb1Npc5CPz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2021 at 06:06:38PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On 2/8/21 4:48 PM, Johan Hovold wrote:
> > The to_usb_serial_port() macro is implemented using container_of() so
> > there's no need to check for NULL.
> >=20
> > Note that neither bus match() or probe() is ever called with a NULL
> > struct device pointer so the checks weren't just misplaced.
> >=20
> > Signed-off-by: Johan Hovold <johan@kernel.org>
>=20
> Reviewed-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>

Thanks Uwe and Greg for reviewing. Now applied.

Johan

--k6LeVVzb1Npc5CPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCYCJ9GwAKCRALxc3C7H1l
CLvkAQDfo3I5Ca+zcyx/jKOy+aFv30HBYqCsfn4Sani21GgCMAD/YZZQv75/d6T2
9xLd5NB4u4snbqgW698u4Fo+33d59Ak=
=VW1p
-----END PGP SIGNATURE-----

--k6LeVVzb1Npc5CPz--
