Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8A39EFF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFHHyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:54:36 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:23043
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229518AbhFHHyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:54:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMqkZvjlRepUyKt3tFmBXcfV02iIQMGFMmuFcrH5yPk5ehJL/KD6X+3mIWLATyk9bT+2wc7A5cnBTGxAQhCQUm5QNzBXfNR6WMi1+D1RrfEN7I9ZVESPPz8t1k4Wi7OYQ0VwUzaZFt+AjU81iRGpcmYwhg+Mns4EE/Raxn7gdEkrCCfCNfl6/FbHJ4RSCl12DfEgLhSh5HVnW0k3dbvZCJOW1pTyvMc9ykHLKB+CnU9LOtB6ixI6HG+WicKtQvlKFvA0CzdIyF6AXPXWVSO/Qkw/qNsfZsZbrb8bPkqP9X9LH1JVdRtVWfEceCmyT5AOWsWIs4qeTr3GAsLh0HrTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT2q4xmP2Oi+7z/S3nCHCNlFZqkLiFVwpv+A/JuGrdg=;
 b=ocetxa+Y1o8ZIIxVCKSu2SWJxEKBgsB77KxFFbQ7fbSoE8MkHhg6/oxJI/s12vCclmirnnRsO5oTQJu24q/mjTTnsC62QRJb9i8k6Hld6nL3tiQ6m9VZq0UrvzQ6wrgy/4z6EznOr4smrveQLxOqYyzOVSSz6kB8M4Yg3H3nE7/LlsGjLjMB2dCinWquZ9ZN6B8K7kqOxXwpJq5iH1wi0GorObp7eB2UBiITR6JLZQWQAK+KhHTuMOULhZogtgZ/nhr+7z3vhQzDRl5SWe/no6JMNarl+PPX+agGyuehkOisozv+b/oJ4s0nzuza7p21j7jUArOYDMDS0B9ulxt1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT2q4xmP2Oi+7z/S3nCHCNlFZqkLiFVwpv+A/JuGrdg=;
 b=u2uKfkQY0pUH7lxtxwDV9seT1Nw3UnC/KHsIR8c7626KVR0oyiBmbkT5pXkj86UBk0BqkeGXg4KUzOer1sIh4I4d5kW5EVxDY191UlxVpqSEeZUw/YQF3AmRYOBrojLWcY8uAU3ryEQ8oIcQA2I515+PTfkWBDUQW5wg0MD2gVw=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2282.eurprd03.prod.outlook.com (2603:10a6:3:24::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Tue, 8 Jun 2021 07:52:38 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::ed91:9c0d:24af:c443]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::ed91:9c0d:24af:c443%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 07:52:38 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: bd71815: Get rid of struct bd71815_pmic
Thread-Topic: [PATCH] regulator: bd71815: Get rid of struct bd71815_pmic
Thread-Index: AQHXW6mhfdAkSdVbgU2CGPMkDmSD/KsJvxiA
Date:   Tue, 8 Jun 2021 07:52:38 +0000
Message-ID: <5ac9821151fc80e7cdcf0c524e73851e61eaafe2.camel@fi.rohmeurope.com>
References: <20210607143002.1600017-1-axel.lin@ingics.com>
In-Reply-To: <20210607143002.1600017-1-axel.lin@ingics.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: ingics.com; dkim=none (message not signed)
 header.d=none;ingics.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d8f4782-9ccb-493f-47c3-08d92a5262cf
x-ms-traffictypediagnostic: HE1PR0301MB2282:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0301MB2282DE0736DA0771C8CD5230AD379@HE1PR0301MB2282.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Jc4KGTlpmVG8IvQlnw16lnMVg0Wm1aqYF838HHZhbLitK3xTKkfizTQfs6xBgu5k+bK2CcJfOFvQnnZIk8k+JeniptzQhjClH4E6ah77OqEZqqazWczls7UQOROqznnO8UOOfks8dkBcyUNJg+MuM39cTfMVkqaFHwGN0TRaQZ0JVsWhT0ZA7uX4iM2FNoqDBQgHknQWx5d4gVqspn3lTy3Obed2+MhlNSIfj4xzVOoBCZqU25rMngxSU0Pzim0N8TuEZW88b86ZwTLlui5KMfEJFxYESw2a/Me+yT4YYwwnJqbX8rZlVUpHlZAUUYIqMDedS/a1nooLj8/5qtxD8WJmzIO/CfUeC0z5j1YYOCc8UHMpwEBzjcRd3iO0S+9RwjYnCEzO8tvMtTmvv8MV3zY/xVgNqzO/TFetSPAkfqSNlKzKKI7G4pkhU3+1nUep28xC8ND7B72iNBSCvzxRsEuZErnBj9evJgGxoF0dZdk06D/eHlqOGQ4ZP6vdHFQ+9i2y9NBSe36+AaO/WbpZ8Ddou6B7VYwzZkTgzP1aDr3RDvC1WsMfmbmIM+ZbxJMMP6R+QFMYx9cGY8Q657uRmOQW8LTnHPz141Ivs6jg494Qb7J+/Fherh18qBDMkRSM2vztGTbEbPTqpwDX/53GA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39850400004)(99936003)(4744005)(186003)(66616009)(76116006)(54906003)(4326008)(6486002)(8676002)(110136005)(8936002)(3450700001)(316002)(6512007)(66476007)(66446008)(86362001)(66946007)(64756008)(66556008)(5660300002)(71200400001)(83380400001)(478600001)(38100700002)(2616005)(122000001)(2906002)(6506007)(26583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZWhkdkVhazVqdE85NFBFT2JIY21KNHpnQjZPN0pldHo5Sm84U1FMQnZzSlVR?=
 =?utf-8?B?b2IwS2R4a2crWldWcDF1aDhjV3lwQld2eDRkZVcxNVhUVHk4MHhYNG5MRjRn?=
 =?utf-8?B?TWh0dUZoRVpNQ1lLdWVlaVErQklMTHpxdTFpWFI4eHE0eFB5UFFWa1VneVNn?=
 =?utf-8?B?YlcwSTQxS3RTdk5nclBrK3ZNYmdJSkJFcjZjNndRc1JPbFE2M1VuNGFHeHFj?=
 =?utf-8?B?WVRGOER4N2xLcmU0UnFldVZBM0R5d3U3WjhnRi9ZcHZaU0NMYjMzSk5FcERP?=
 =?utf-8?B?cmlyazZLYzNWanp2K1EzMXgrM0VxTURmcFlIWjVaWUVGK05qNzJtVDBIN3Vp?=
 =?utf-8?B?TzhpOUJBTzRvSDZoZHc2UmRzY3ZaNTZmcitjd2dKZXhXS2VNbWNLNmlMUVdk?=
 =?utf-8?B?aUhoOHNGaHd1MWlrZ09jM2F5WUI2UHR4ejlCS0c0OUQxeTZsZFJWZlB4c1BG?=
 =?utf-8?B?ZmJwOVdkbXM4U3RZT2J2cFRHWkFIaytra1VzbllJeHZkZnhnMGVrMXZncmZ5?=
 =?utf-8?B?Z0FwcUxlNGhxNlUzVWFjUm9yV0hTdFZZUzBDUVNJMmhQcjRXV3orOG93Kzhx?=
 =?utf-8?B?VnFudy9NeTJmU1MwemplN2hzQ3ZzRklucDZlZFNBdW00MnNYTGZtQnJqMk81?=
 =?utf-8?B?NmxLaGVjMjNJZ0EwbzFFYzRxVktVR09SK0g1V3pHRm9tR05pQVRBVU5VR0ZP?=
 =?utf-8?B?TkVIb3dpazl5RWt2eXdwdXY5amkrQlZFNjZoTzdsaGgvNCt6T21rcFdDcUps?=
 =?utf-8?B?RFVPd0JETkdza0F2dXNnQ2tHa1FhWmQyTEE2WmUvcWF1OS9OVUw3MTFjejlE?=
 =?utf-8?B?OG03bVFyQ2Vick1lTzlmajh5M1VrVmZLa05xek02M2dhZ3FJNUdUekZsZitJ?=
 =?utf-8?B?UVdoTmlJdTZ5Nks4cjVLRGpuU2lWRVVzalpRa3UrSXJFSHVYbFMxUU9EWjc1?=
 =?utf-8?B?TTRmcXQwNVcxZ3lXQ1AxWVVuQWJsdm1SY05yNjg5QnhydDlueFl2eEI2NDU2?=
 =?utf-8?B?Y2xabzhkRDdvY1dDd3crazhvVU5NYkl0dmw2dEFta0pHYWZ5aVkweWZ1bDBz?=
 =?utf-8?B?MlkyeUozak9GUWcxZVJsWGJKZ3R4MlUzM2NxQUdKWU1xbnVNenFNaCtpMjVH?=
 =?utf-8?B?Y21BNmZsZ3RZeFh6QWt5RkRyUysydUxuRFNLOXhnWTREL2RwQWJrTjRCMHJH?=
 =?utf-8?B?elpnT0k3V3dBU2J5WUZLYXhFT1M0Q2IvLytaUkNLWVF2TFZ0WUM1bURlVXVI?=
 =?utf-8?B?bUIzaHpudksyNWc5SzJHZU1kQkdQUkNCODg4ZXVkOEcwa1RSMG5HNERsNGl2?=
 =?utf-8?B?NHVUUk04TTJ3UkVKMDhzM2ppWk9YUnNEVVg4Q1J5S203WGE5aDFDVHB0SjYz?=
 =?utf-8?B?VmxuVmRDUVRxR3FaalE1SnZVdVFHTENhNVB1U2dKR2R4M3ZXTzZ2SGJmSksx?=
 =?utf-8?B?MkI0UmEydWFjWDV6OXkyWTNPZVVvNEpKdGNGd1Y2cUJXOHEyTkZGRGVLczJw?=
 =?utf-8?B?YkplV2NSVC9WalJwK21UZ2xITlE3Nnpmc1RtNXdMcnJ3dEFBS2t6aFh5dm52?=
 =?utf-8?B?ZndTclYyZEdraFlQV0pmM3A0Tkowd0hnY0JkK0JtNFdzYUcxc05WQk9wNSs5?=
 =?utf-8?B?RTVyTE1HYkRPODNNbHZvM1FuenZ4dUZNQnl3NkN0TkpIUE9BOXJvN2FZQ1U1?=
 =?utf-8?B?dm0xWWgwUFdRSjVTUVEyTEtJWTlVMm5pbU1SMmttT0UwSWVpRVBrQmtDanBQ?=
 =?utf-8?B?U2hUbUpPMzZSczlNeUg2R3cyeHJ0dGZJK09OMmJmbExGN2txMFdjb0hrcXQ5?=
 =?utf-8?B?UklZNmM4VUNyclJ5TXFyZz09?=
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Q3zJhFgF3blQIFpwq4RE"
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8f4782-9ccb-493f-47c3-08d92a5262cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 07:52:38.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZzQuZZw4Ak0vpuXMS3T0mw6Bfebbc/lYswxPYs+T0PzKKs1tChlQrg4FEV7Qxkud07xfcOOgM8mSE6DNsa3mW3OlSV8vIuaDC3cGZHvhfOyle8Xui9WpcnJQAEYtVyAt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-Q3zJhFgF3blQIFpwq4RE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


On Mon, 2021-06-07 at 22:30 +0800, Axel Lin wrote:
> The content of bd71815_regulators is never changed, no need to
> duplicate
> it, thus remove descs[BD71815_REGULATOR_CNT].
> The *regmap, *dev and *rdev[BD71815_REGULATOR_CNT] are not really
> needed.
> The *gps is unused.
>=20
> Thus the struct bd71815_pmic can be removed.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/bd71815-regulator.c | 57 +++++++++--------------
> ----
>  1 file changed, 19 insertions(+), 38 deletions(-)

Thanks a lot Axel. This is nice!

We might need to decide the ops for LDO3 based on a DT configuration
because the LDO3 state can be tied to DCIN connection. Currently the
driver does not support that though - and this patch is a nice
simplification!

Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Best Regards
	--Matti



--=-Q3zJhFgF3blQIFpwq4RE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmC/IbUACgkQeFA3/03a
ocVuxggAhHe4s038FEz5w4fqtE+G2kvl/eqYwVtH8hUHwDr5p16SktPCTUIObpDN
FIPDEkerelHMqqammpZq0agrANTR3b4Gmg4qYbYXNJHwUIV8Xg4b9uFUiX+gQZce
Vgpz5OenvQr0b0GwFYt+QaSKATM8X1N2LEn73WzWCn8j6tyVkNidL7kOrF2/q5oY
aLxaW712OzdutM4mIbuy9zasE09SJUGhtr+LX1wGsTRPuT+UJobQubfBnAVb9z7E
4XNXdFiKN3o/Q1+K8fN8bfIltTBnRgThchn7eic6sEtCRthsabfSdYEgRYYTQPpB
4i+LetUUXWy1LEMEEV66loa9xy67Vg==
=S4vq
-----END PGP SIGNATURE-----

--=-Q3zJhFgF3blQIFpwq4RE--
