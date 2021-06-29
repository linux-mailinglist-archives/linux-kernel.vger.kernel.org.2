Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5183B74C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhF2PDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:03:48 -0400
Received: from mail-eopbgr660137.outbound.protection.outlook.com ([40.107.66.137]:53412
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233791AbhF2PDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:03:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRf46zmdT+AnhqKyXktoXq3WiS5CXycUCGZZHjMkbixHIFJ5PVJ7F7QTJRrd6eJUr1qwuQLgWumLFH/0Zm3oH80K6qpPO4wU0jaLAPPtR0z1F3BRpaUHsNm586eGk74SbgncCMGzPGcaa0wg5QWuPdvoNgIZfpNoUSdy+2HPW+aOahFgdl6fFaXWn8lKqZePGnlK/5B2/e/In/AePpONwUpFaexkCXa2yxWoP1Z0XvZEIRDb32MOc42/2kr0d51VIfMD+LmKMC31sf94QLZ0U4vUIbzTgehEsfIsnLlfbf3k/WyWTPfpUbF5bQHw47Esg62GxeUlB2twf7EEE6p1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2Q78n5JJXg7AMiQe7rdG466aUqM1ipadO69+a2s1iM=;
 b=ae1yFLv9XPEyCEgsmYC1zAwejb9YkYSvVFY/9B4KC0pS6daiSZgsRBRQBmbVs9wSkCphN7+1CfUnp3dw5zuke1ee6MCedJ/EQg2WyF2yhAb0rInvkBp9mrW8Vbp3LSZGDcCixwi6gdSx8XSK0/bk3OaYn0B5PuM3M6iNQmCfsQot1C/M2u9Ta36awbmJrdfoHhIBJF+52UiSn2rDdvDP2GmMnPMWYvRxIZrNEndZXFf5GT9DgDsOrdDf8rOxxylTSnC4FzY+7w/KkOOHmTQKjM89tXLrMZrZeSRn9vWV6qb4fXfiqVaSrVsKVTLPv5p7iaOtXZdp2Fvv1PIX6HeKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiphos.com; dmarc=pass action=none header.from=xiphos.com;
 dkim=pass header.d=xiphos.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiphos.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2Q78n5JJXg7AMiQe7rdG466aUqM1ipadO69+a2s1iM=;
 b=nJOlJO7CEMtqKfV2xKd2tqcJ6Gx5Valjr14aAEX2ByrwEkdhDUkrJ4mnTdCicONp44nVEPhorTuWMpHsH4nJY17cTPwMz1H3yuwzMObD0in0fd7zh+9OBm2Wv3WmBLIPzH/jIMqH1LtNuBBGaEkkNynOoHObVaBK909DctrU6E0=
Received: from YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:d::20)
 by YQXPR01MB4873.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:25::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 15:01:18 +0000
Received: from YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::74e7:26e3:2b35:6c2d]) by YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::74e7:26e3:2b35:6c2d%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 15:01:18 +0000
From:   Liam Beguin <lvb@xiphos.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "liambeguin@gmail.com" <liambeguin@gmail.com>
Subject: RE: [PATCH 1/2] clk: lmk04832: Depend on SPI
Thread-Topic: [PATCH 1/2] clk: lmk04832: Depend on SPI
Thread-Index: AQHXbK0Z5VBEWEekVkSaq8zJ0a0yiKsrFTJQ
Date:   Tue, 29 Jun 2021 15:01:17 +0000
Message-ID: <YQBPR0101MB1811EF89914E845264FA4DE8D8029@YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM>
References: <20210629060751.3119453-1-sboyd@kernel.org>
In-Reply-To: <20210629060751.3119453-1-sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xiphos.com;
x-originating-ip: [198.48.202.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 231ab118-3c98-4b9a-ae19-08d93b0ebfad
x-ms-traffictypediagnostic: YQXPR01MB4873:
x-microsoft-antispam-prvs: <YQXPR01MB48731D3FFBA95022C3381694D8029@YQXPR01MB4873.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aTqB2tCQO+lZppiB+DYKj3JwKGVIWcJkZV7p0Piwdd5yQVrf71Co8voaHOnmlr/3sR7Uu41FenMNQergYYqGH7cytkx9lRVZdfq1C5eAomjd7+daynQ8R6rA6pGPXSTyq9y5bOubhmuFEH1k6t9tXTFIu84cs8nyjKl1nPeGi/4QwZNt82I4vKhZkFCybYVHxG2m25kznuJBnsCc85woDZDOf1570bshyU1nevxym3mPEvLl3kwpZrdgWDg0GzExO7HSDYpA8FWwxspWzTi7oN8W8P4Exynud4XzSjAuSA32Ps1bwNh4YmIMhE5wELqgqECI/ckq5j7mMXjWEEHTS15aG+RUYAvaHlWJyd62D8qtk4W+w0GF2Yx7Ckc34k4l05v/pbX6lgduGIViCM0ps0lndwkDInc6YUFMC60xdCaQg7tJa1A7whEKwvN+GaP428ZV4rG0MKlfXon0394145jy6zNs9DK7y6sJgMh600P5FxheOFGmuIElVLofFYZZuR3HxNuJa4SEewk9rnm1tKATIH/dytLdAK7ADAQoUbvFpL6kdeltBGmIr1rcLP+wUAJHbnJMbLj6wKtFMR/Xz/LQVRA7JHDIdlhCtCnmaOgiSORKhBUiJ9PcMb4CrBWFNbKMqaeU9gDWp7r5vn8VWBGVYICiBGbwLywpdpZSA82KZ7jfN2LHqqzWKmu8YDyabF5kGhytfuw/c18NdJ4MAF1OK9KnCQV5pPVrychpQsG9uK8kQ32vPbfk+ASlEnKZUcuHdhLhWPQJpmP5nNPbKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(346002)(39830400003)(122000001)(66946007)(64756008)(66446008)(38100700002)(71200400001)(2906002)(86362001)(83380400001)(66476007)(52536014)(66556008)(5660300002)(76116006)(6506007)(53546011)(54906003)(4326008)(33656002)(7696005)(316002)(8676002)(966005)(8936002)(478600001)(26005)(9686003)(55016002)(186003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cuqr74rVtIWj6pM7piWwEuzCCGiJHSzlYFjbHIrwSTNNEn2XOan8QOpg2uHs?=
 =?us-ascii?Q?qWDy7p+SaphtR4zNxFJweSWOvZqBX02F8AvUraaY4dlMdqIMBsU/UpCiLgEr?=
 =?us-ascii?Q?vjxt128k7Cj236aBSxsECrAGQE9uPXxnLuo8Khm025GR9cXbghWasdRx8lRo?=
 =?us-ascii?Q?WfnWy2VX4mCVVVuDMUTaIXOMyCtBOyAa2kG/C8lV9YWrqwLwQUKZHF/qcNgn?=
 =?us-ascii?Q?KlLtiKkh5UEXKAZBRX9wKrSs0fWQvaAgosbJgK/cqZjdN0rm45ugTnqJemHs?=
 =?us-ascii?Q?kd6XTGOH7XqreCSdgHBmd52uWdQ4YqO1o6QJwMB7VuGs5jaWKw6Px0c2mn7T?=
 =?us-ascii?Q?wXKjfgBa5X/EAzZEO6vffED8YtNayjFhPl1+kMCbvZG04Q0GqF1+GSYCV8+j?=
 =?us-ascii?Q?s2uTiBceH1d+3OXtnzm4svYI+9ChHPvB2ngLL90K2ILn3KJeUvW6rPAb4jK3?=
 =?us-ascii?Q?d9fZOf8pWq7Df0ndOnz1MXq2eIZHvlV/hOwQd13MkQVyhNiH9Povw0b3s8Dg?=
 =?us-ascii?Q?E8RXG/pUxCkCbMNRw2TqcISTKpN71EQ1DWwRNjGwEhepUj6IrTyOjK7AYxXV?=
 =?us-ascii?Q?WjGyh5HwkSZ+A1UKdat4lMU/6kQI+uiHbh9/IxyoypNvpeXDpKsG/7sah1CZ?=
 =?us-ascii?Q?AoB1QYQ+8toMLm54SPVG05nPpkDF8D2hTWFq0P48JO4H3xUKqxH8JBgCnZb+?=
 =?us-ascii?Q?Y4fbTfhMVFmEVBUfQi4/pqNKEysIfSfyV/9Gr0ANAAoLri9sVVdebhSKgTIM?=
 =?us-ascii?Q?PU77zdmnO1EwHS9KVkRcM8fyIlEHFwXoqb1SIAHZYdDkXAzbIk3vE8+w79nl?=
 =?us-ascii?Q?Nhj1Qi+x0E2ywr9HamzJaiSPhHtQ0eYbAmXDaTT+zHl9B/4xBUzcRNMQ3XFZ?=
 =?us-ascii?Q?G2+5MykCQb/EjC2tSXLofub1gjfLJvBEwl/oy7oJa4nC45owbX+LmY1YmEsS?=
 =?us-ascii?Q?400wdEDBSSd3iRrVEzFzCXD6Ou4VCxTYezjfAW64GzKhEtRfNPLVhqAWU4bb?=
 =?us-ascii?Q?xFIuaYYCbBtDH812ESQ4vX8AMsqTNq0r16rXlfoc15TqGjqTykQDsiPDJneS?=
 =?us-ascii?Q?iiGuDSR94AXIdJa5nOzSGPn73ABia6f4bbJUxZ3z5JI5ed9a98eDC/Y5zjyK?=
 =?us-ascii?Q?XmJ3S0d23D/8MDH0Vgv94KsHVjABWg7c7dclEXMFzjCQNB3XF4ecit/uZh9d?=
 =?us-ascii?Q?IGhYMHWJoMvs0Nkz8nAjvu01YGS7rUKFWgTcy5q805AcuqJaM3ZVhDR35IjQ?=
 =?us-ascii?Q?XJPPZhH0bN5RcTH06xWZ+QiKT/hD6/OsOTJz+gfYOR4m9LxMiMJYI8LnXEHu?=
 =?us-ascii?Q?/ewFWMkUSakeW0h+tYmK0v6B?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xiphos.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB1811.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 231ab118-3c98-4b9a-ae19-08d93b0ebfad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 15:01:17.9874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 11c32550-fdb1-48d9-8a3d-133e5b75b54f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtU73g7xPv+g55OBaHsf2kuvbCJj9vXgyvsY57QneghRiqsE6eWk6e8zkG+enwNx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB4873
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Boyd <sboyd@kernel.org>
> Sent: June 29, 2021 2:08 AM
> To: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>
> Cc: linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org; kernel test
> robot <lkp@intel.com>; Liam Beguin <lvb@xiphos.com>
> Subject: [PATCH 1/2] clk: lmk04832: Depend on SPI
>=20
> This driver depends on SPI. Otherwise compilation fails
>=20
>   clk-lmk04832.c:(.text+0x1668): undefined reference to `spi_get_device_i=
d'
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Liam Beguin <lvb@xiphos.com>
> Fixes: 3bc61cfd6f4a ("clk: add support for the lmk04832")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Liam Beguin <lvb@xiphos.com>

> ---
>  drivers/clk/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index ccf77849bdbd..d49cf3ae52aa 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -57,6 +57,7 @@ config CLK_HSDK
>=20
>  config LMK04832
>  	tristate "Ti LMK04832 JESD204B Compliant Clock Jitter Cleaner"
> +	depends on SPI
>  	select REGMAP_SPI
>  	help
>  	  Say yes here to build support for Texas Instruments' LMK04832
> Ultra
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

