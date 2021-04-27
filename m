Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E783336C75B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhD0NzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:55:07 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46548 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbhD0Nym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:54:42 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9C3D71C0B79; Tue, 27 Apr 2021 15:53:56 +0200 (CEST)
Date:   Tue, 27 Apr 2021 15:53:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     =?utf-8?B?eXVlY2hhby56aGFvKOi1tei2iui2hSk=?= 
        <yuechao.zhao@advantech.com.cn>
Cc:     "345351830@qq.com" <345351830@qq.com>,
        =?utf-8?B?UmFpbmJvdy5aaGFuZyjlvLXnjokp?= 
        <Rainbow.Zhang@advantech.com.cn>,
        =?utf-8?B?eXVueGlhLmxpKOadjuS6kemcnik=?= 
        <yunxia.li@advantech.com.cn>,
        =?utf-8?B?SmlhLlN1aSjotL7nnaIp?= <Jia.Sui@advantech.com.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [v2,1/1] adv_mix955x is a scheme that multiplexes
 PCA9554/PCA9555 into LED and GPIO
Message-ID: <20210427135356.GA2426@duo.ucw.cz>
References: <tencent_17A7BBC4D15D331C1A25B4075294E5D67706@qq.com>
 <cb03b75a018e4bec83eac6898eb1d2af@ACNMB2.ACN.ADVANTECH.CORP>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <cb03b75a018e4bec83eac6898eb1d2af@ACNMB2.ACN.ADVANTECH.CORP>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2021-04-27 08:32:05, yuechao.zhao(=E8=B5=B5=E8=B6=8A=E8=B6=85) wrote:
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
>=20
> With this driver, we can multiplex PCA9554/PCA9555 into LED and GPIO base=
d on the ACPI data of BIOS.
>=20
> Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> Signed-off-by: Sui Jia <jia.sui@advantech.com.cn>

Please Cc LED drivers to the LED maintainers...

> +
> +static inline u8 amix955x_set_bit(u8 val, int led_id, enum AMIX955X_LED=
=20
> +state) {
> +	led_id %=3D BANK_SIZE;
> +
> +	switch (state) {
> +	case AMIX955X_LED_ON:
> +		val &=3D ~(1 << led_id); //Clear bit
> +		break;
> +	case AMIX955X_LED_OFF:
> +		val |=3D 1 << led_id; //Set bit
> +		break;
> +	}
> +
> +	return val;

Please check CodingStyle, avoid useless comments and check word
wrapping in your email settings.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYIgXdAAKCRAw5/Bqldv6
8n36AKCAyk/FV6UAhuTMTRVivRmq2huMAACfa69qtKio3k+F86vekm0Ukg2KABc=
=asyZ
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
