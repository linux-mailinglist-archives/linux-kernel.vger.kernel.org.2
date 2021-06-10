Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625753A2841
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFJJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhFJJay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:30:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A01FC61182;
        Thu, 10 Jun 2021 09:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623317339;
        bh=YKbH7RY9wgcda2Wl0gjS0fCDjC49wsG2m1zMvoWhqwk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FRDb2/ZD82DQsWzqFHq/6Gk0rFccbgZQb7AL9shwRQaM4SDBhbg5BKTxI6JqJlTpX
         IjC+ZcGo2ZUlMyHkxqX7mMi64IscT6nM1zyr90eWpQ6scGiirSEGgtJ9RNUcDxfkHs
         vCLd9XNVcNnf49Ani5wDP3EbQhxr8//taX6nlifBGxiit/dt6h0bXUBEPjVowWi/XM
         /ahI5nirEVpZGHC8MEwDazHKc4TCr0QUe+ZfT4Ugm/HWGSHK5nKVkvhGBYzibs8YM5
         TWT0gCrxm6mxlfATHfxG73cZWI9QR6Wv523lXFR1oull1FXZTJb+UFWDHOPH14p8jI
         zNKaJs9S22NyQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>,
        Peter Chen <peter.chen@kernel.org>
Subject: Re: [PATCH] USB: dwc3: remove debugfs root dentry storage
In-Reply-To: <20210609093924.3293230-1-gregkh@linuxfoundation.org>
References: <20210609093924.3293230-1-gregkh@linuxfoundation.org>
Date:   Thu, 10 Jun 2021 12:28:50 +0300
Message-ID: <87y2bi131p.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> There is no need to keep around the debugfs "root" directory for the
> dwc3 device.  Instead, look it up anytime we need to find it.  This will
> help when callers get out-of-order and we had the potential to have a
> "stale" pointer around for the root dentry, as has happened in the past.
>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Jack Pham <jackp@codeaurora.org>
> Cc: Peter Chen <peter.chen@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmDB21IRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUgwCgf/atPiB7V/9a8tB6tAjn7vw/LNH7WpnNKc
byRQHvI3U0QB2w48cQu+TWbQtqD9+38dALTqyvbXW3vAoU/73+nTdPnUwM4I2cZY
XEccdsyihd2CDM6CD7fh4dQbtyfqPqQzx1pu+m3c+kJamR4L4V+mV3wA7yPmqKqc
cXVclp4cXOvwKwLkQDyUGf0dE3PmS1LFAKOR6fMMiVp3rIUKZDiYXe0/gwZL99eX
00SL2C81LCcXIYVBjKgZbyXLQYnjCsXlrD4aCPC9XxVXxvSH64tAtEkHeRtC6kw7
Lleg2aZv8xuHNbbw7Fu7Z2yqyaG4eYmcDef7YgJI1BQeTI1E4LKoLQ==
=4Axh
-----END PGP SIGNATURE-----
--=-=-=--
