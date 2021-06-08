Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91373A01A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbhFHSzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:55:19 -0400
Received: from shelob.surriel.com ([96.67.55.147]:56130 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbhFHSsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:48:08 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lqgjk-00076z-8l; Tue, 08 Jun 2021 14:46:04 -0400
Message-ID: <d7906ed940b1d4f7fa31b5c41fd7b7a0649e06eb.camel@surriel.com>
Subject: Re: [patch V3 0/6] x86/fpu: Mop up XSAVES and related damage
From:   Rik van Riel <riel@surriel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Date:   Tue, 08 Jun 2021 14:46:03 -0400
In-Reply-To: <20210608143617.565868844@linutronix.de>
References: <20210608143617.565868844@linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BLaqvrxE0ll5JsgTSji/"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BLaqvrxE0ll5JsgTSji/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-06-08 at 16:36 +0200, Thomas Gleixner wrote:

> The following series addresses the problem and fixes related issues
> which were found while inspecting the related changes and testing
> signal restore and PKRU.

Woah, you sure found some subtle stuff there.

Acked-by: Rik van Riel <riel@surriel.com>


--=20
All Rights Reversed.

--=-BLaqvrxE0ll5JsgTSji/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmC/uusACgkQznnekoTE
3oNf7QgAg4xWi2JNoZaR/lLswHQrX0LVAvzv5u6/5/Adz+VBYKiXB9P9taoehPkI
ph0rA9UY4u8NdQx2qp8xJuh2iA80XTmi/3IeMcV/ZJJKUmPdtW13ikPXLGE43BZ9
pyCn22iZWAAMEI5Bo9T0wa/2xhE/9EisfHSpbIqLZSz7A7dUhFPpf0eYmPfmpXPl
6LWKUgKWglAQ8HMn+cvq/D4yS2Yaw3+ZOeJ0Sb6DlL+/tegrLPcLY+g9OA84Xk31
yBBgwLsyg11d5F8xGb7c9c5rAifQEE3vMbZIARFMcO7mvHiwwCUBBamuFoKVeQWK
KUum7fPD0J4StPSN2w/7eWWQ5J/3KQ==
=0VoB
-----END PGP SIGNATURE-----

--=-BLaqvrxE0ll5JsgTSji/--

