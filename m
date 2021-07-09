Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BE43C2206
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhGIKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:02:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:28619 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhGIKCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625824801; x=1657360801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=op6PFifUMx3/xmCF1UMk2ivGAhKN6Fhy+E96vnhyWdE=;
  b=H4A4A1hWo5iD/BydixsFrc4m0hbI+cTnqJTgW3x0MTT6ijPlYqQmkk8Y
   bT7VZnTzhdeHnazpb4p6YN8ZVyhjMoQfUcUl1rgMtcRUSKPLOmMfvmj2L
   WlfU8tG5zaJyJCcCXA5ZCqE3/jlUw0MfCfSeeTDOfg0akWheGXgTqB3hK
   a6mKYX0KYYi6ATjXBHV7TLg3U235IbeNynSrqBkgKi1QbmRzdtuwQCTfm
   G13joEnnJDdSTHKEYowHonEi6RS2/GiQobp3SlDUOzSSLZx6Xi2q+o/NZ
   FJLE3npu978t+edpvCk7/QS3rSFW4t1LYikUIZ26Kr/cm4WLMk+pSG86E
   A==;
IronPort-SDR: 4mXnu0ScSaYvrh8YdQ4ld6hxG5+5MUEsBTPqWg9Fyx3CLW8gXFZe69wPzvzfxIQpdsQjT5o8dO
 oJagrhxvYWAlf1A8RPEr7gjCFlvr0jsUz/DRMiO2aDOhO1U/NgCHhc0FqjFXoimpzcCU5kdNFD
 YzxSUwPsQ6t9y3ZG9kMt2tmDTfBXAR0jG7n6KHsfBI8Pux3w5nbBvgp/2ICAqBsIO+JnzJ8wiS
 okxPtbIWRlMjV9tXQd3US0TlH9GjItVCq4ZnOeo6QiCB11jmYQFDFo6Sj6O6L4qX2yiEJJ4rEG
 FRI=
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="127657030"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2021 03:00:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 02:59:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 9 Jul 2021 02:59:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXS8Svu6gnTCdu+Spdd0XLITB9g/CnMWenJ0v+HzITv8+mepA2Wa1K3d3AVSgNp6ClAM9mtH4zNcuX8FU6wHge2drWOGWl7HsqURu1cNbnt6k+BwupOSRQGCCDkgZHyikJ+AGy263MaitnDkSt12w+15LSjM1UoyAk9ShS3Y6nOrj7iEiLTBYR9Krpg3HmPDlTYdhro0eYs62K4+cxKG90sErnqz+jZV4VIjFeNSx9LYbvnVvuDIPBZ1rOLFuyOGtJ9wNH1aBFv02HivPuSxQfvIHj3hHLn7FqcnUrzFXepAGbvKzfeMLb977oa8Kic61wZs28zaybrJG9Is3CevJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op6PFifUMx3/xmCF1UMk2ivGAhKN6Fhy+E96vnhyWdE=;
 b=FmiNGkkfdSCsbeZMaQCiD8REbzgEaZN1u9bjHJ8tuWuGL+A1BN1xdDuBglWR2LjMV3s97FYcd2hLRTAl9xLa1yPV7bcNE9GopEFJSkAcF8M3MdNM+fpuxLCRXIl4fe4VFN45lVjJmWFDRIyUzcOm9BQxtXiixaPbv2WNzbDETKxbrBU4Lc9n/W8zFT6tzCd2fuKXFTSGMu9r3GXV4q2oGw3+24tVSBxtkYjxpD5Mj3uyCb8yWcHNKN1dX3GCxqxxh4Uvenlef+uCp+evgm6GWZ65Mr0SjjvpCZdr41aCE2VxwbBZt99mrI+QZInNCoZ8ejTHIER+uSdfBWm6shS5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op6PFifUMx3/xmCF1UMk2ivGAhKN6Fhy+E96vnhyWdE=;
 b=Os5IXA5QOsD+huhStm97vTefolvnbLMS7xUb/Ta6Y5K+/4TopTpKkrorSQIWUAHEnENyDE0JLcSsho/nFvNpZbpQ1VXk9rGbZ0qtNQx/0KvmYfsUvdOazr1sMNl3ZGmf8biD8NJjGrOC+IgkosH0F3+Iqmb4kxJNhASxzY5WCO4=
Received: from DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) by
 DM8PR11MB5686.namprd11.prod.outlook.com (2603:10b6:8:21::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Fri, 9 Jul 2021 09:59:57 +0000
Received: from DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::44ef:d8cf:6e86:2cd5]) by DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::44ef:d8cf:6e86:2cd5%5]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 09:59:57 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] clk: at91: clk-generated: Limit the requested rate to our
 range
Thread-Topic: [PATCH] clk: at91: clk-generated: Limit the requested rate to
 our range
Thread-Index: AQHXczHsvGtk8/nEqEWi55LFKfDMd6s6YTWAgAAKvgA=
Date:   Fri, 9 Jul 2021 09:59:57 +0000
Message-ID: <25631072-d9a3-0d84-fd47-4d2414f079f6@microchip.com>
References: <20210707131213.3283509-1-codrin.ciubotariu@microchip.com>
 <7586cf33-078a-cb85-98c8-9969baa0f19d@microchip.com>
In-Reply-To: <7586cf33-078a-cb85-98c8-9969baa0f19d@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 613b1b96-3034-4e88-d1d0-08d942c04f02
x-ms-traffictypediagnostic: DM8PR11MB5686:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5686B4C8D3828C93A3E63BBDE7189@DM8PR11MB5686.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SGGaG7mG5io5eO0QEpcSwCjOaskBoKq8yfH3QFbnLbNS4y0xu8JpP98nJhKLjm2w52dn1L2u4h3Dk5HjJCpmRMxz0JDDLV7DyzOwhprAMgiSkhfB2sN/yR3ZMd/lac+NOZSYC3xRY3TIlvCheWk7jqZ2+4uNrkgQJHkzQP80PUz4bK/nrG5/FSg6L9PCeFs6XsEzDVnSc71X493FMFVzEjJ13UJTkkaed89Q6gPpKsAeEyu5dOPrlpsstTbwQkpyXBNY1Gm7Hn+f3XMAt+kU4gnLImHzApED8d8R30ZrWeErmf2PdD0i/nQ3TdrNW6/x8RbyZBZDUN9eC33HscP1ttlTbkOl5Rt2k24nL3dx23N0wwcb66bXf8jpLHpaHLj8j8L23KpQl4NwH5eJilMGOgKvpqQmG0Dika7ghqzZciyaLX1mnBed4pER+W4ivty9JMHtePCSRQ1FLgau3TiVZn02aoaSELe5RLbiZXitI4PtiB82F7ypNVQYktVqbFF261iSzPEmd9ftW88hk+ObZE7axjPzG1+aO/N/G93M6ykFgmzRuxrPUmtES9mlhh20yrNjTLPD6vyeQzNZMjuDT4ZKkXQdQfSzsYsX2eA3QTGrmqJKKoSpcGeXwFn6W6MNcUnM2T+MGNSPsTlSEfxNsKUJTQlVYqPJL537Q/iUvehFE7ts11uJfmDOF7hmb+0ouf5ZV/12OCTN9RuTwfUf+fCIsIw9GEJpzR7xy+/TUgYbAt7ee7eMpr2mbT40wk/Vt1OcHAuhcjSZT/llIdteLKKeGXPXM96ET9gqO04DRbnstbSGwTr9USpp8DF/cAQu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(39860400002)(396003)(110136005)(36756003)(107886003)(6512007)(76116006)(54906003)(66446008)(478600001)(83380400001)(66556008)(64756008)(86362001)(4326008)(66476007)(966005)(316002)(26005)(6486002)(66946007)(5660300002)(186003)(2616005)(8936002)(122000001)(8676002)(31696002)(6506007)(2906002)(53546011)(31686004)(38100700002)(71200400001)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?i/FDAsLtcVilautojiojtGfNjuRqJDRuOG2MrsFRFA6gWXCkoZZQRo2i?=
 =?Windows-1252?Q?X8adLI+PTmMqbtuJ1d8Qo4yi3rWozmDN3U5QBqDtV4Wm/Q4er1V0OJ/L?=
 =?Windows-1252?Q?MVuTqYBoG4mxi5XWJwwKhsfBtUS6kodaUZoVSIiV55VJey2G6hWxRpRg?=
 =?Windows-1252?Q?Gl5kivgQUzhNCx9Xdzv0EhWvr5fSFr0M/96oncqSYb5E+fm6pSKsP0pz?=
 =?Windows-1252?Q?zVoOGZaZlGcGmG1RcK1G5K06FpmKMXSxqmGrf79xa+ON09203uZ0VYL3?=
 =?Windows-1252?Q?Q+tK2WVVg4IMYHtmQpL0/00oZNlxFzF1M10Efv4I1Sw6FYEwpk5ucMh9?=
 =?Windows-1252?Q?G9UtJ2G4ODPk7781UAzD7gLFQJaeSwe9PEffTtuGvnUE00RndHngAY/C?=
 =?Windows-1252?Q?BPNbG3aX2QEjRVnV03XJ/o7iR9OkK0++3afuMobdu27xXUJo7eXLVSf5?=
 =?Windows-1252?Q?1rLFNEzezXlHZBaKo/IRJCw5lfGma8vJPWXDLwA9xlnuvSljEoH1YlBK?=
 =?Windows-1252?Q?JdAxN4dztPaDZN3ZEBBwfSW1Dwj7felt7JC5gmWuEb5Yvy5XS/sUnX8t?=
 =?Windows-1252?Q?bwUNWQGHJjuNt6rS/Eel7NgIWLCOpb4JoOobRSAOvB8x2M9APYe7utGq?=
 =?Windows-1252?Q?k6GF3znPDEQgYrvDiqJAG6DTwoqx9JUFpU93bhBhouqrzkwB+94+R7G/?=
 =?Windows-1252?Q?YUvrKhQKUu9IuCcImGqvAh0Pg9qMWQRSRhcvvGCPdi1Dz+32bFlXFMfy?=
 =?Windows-1252?Q?eC5RigeNkxKwT8wSbjqtDrNzvOpxTo51NHJmKXx564yrokhKw1cBIJdH?=
 =?Windows-1252?Q?Xs5qJxyOkSK8pt/CYZuUNJjuONucLo/+3JRoJosw79Ehmz8z82y1z8Fd?=
 =?Windows-1252?Q?tPw0zt7msYEuH9PaGCQEcbHD/9uMp+kt6Go12xgwnbirNbXN7Qo7Tktu?=
 =?Windows-1252?Q?jWkmMSvuSEHr13N2YLocFVgvFyo1HqoK1xGKx/Jp1GQXJXJZ7qGg1E20?=
 =?Windows-1252?Q?elJlj7Yge0VD9KkVpsrG4EQV/Xh9i4WzjKFx4+zZ/WR50mvNiY0oqeoT?=
 =?Windows-1252?Q?qr7oSPRl0AuOap3vEv/0XApHdYYTSB33nvw9EARwJ/+ZgGzeGLvU1Kuc?=
 =?Windows-1252?Q?DnrgZLh1gIicTeZoWj16TDIPjPjGqCVi2BrlyVKUHtKzVL8/1dFJePYr?=
 =?Windows-1252?Q?v6M7kRLk/p3yOLzJcDcGoF2JuOHSwav33yiecpGg/BJq+yQd/R2EeGb2?=
 =?Windows-1252?Q?S5cRRYT8+sVFTUX+3YbKKj+/BKBH5O0ADLKOzK1KP34HbW2pfzSaTk4F?=
 =?Windows-1252?Q?/JCcg22WsLnMiWyV4XWMt6GOHnSzBYxLhHOTaWKGCuTkSTAuN0piWi4E?=
 =?Windows-1252?Q?YreNwI3yQU9eLL7RaYtZE8E6kdf/Ru/4hts=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <99E66F5B8BE2DA4286674328B9814AAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613b1b96-3034-4e88-d1d0-08d942c04f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 09:59:57.5359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fh9/b2++vzrf2CkE8aA6Xj24pXnUQrosvCAKyPTAoLmDch9gfNupLCq1Cg53Gkdazy1pGc6fDl034apM+mGcoWvGdfTc+WSBuCc9stX1cJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5686
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.07.2021 12:21, Nicolas Ferre wrote:
> On 07/07/2021 at 15:12, Codrin Ciubotariu wrote:
>> On clk_generated_determine_rate(), the requested rate could be outside
>> of clk's range. Limit the rate to the clock's range to not return an
>> error.
>=20
> Isn't it saner for the user to return an error code instead of=20
> automatically restrain the dynamics requested without notice?
>=20
> Can you elaborate the use case where returning an error is not convenient=
?

The way I see it, if the user requests a rate that is out of clock's=20
range, the driver's determine_rate() should return min/max, not an=20
error. That is actually the closest rate supported by the clock, which=20
is what determine_rate() should accomplish. The user has no clk API to=20
get clock's range, so there is no way to call clk_round_rate() only for=20
values within our range.

The use cause is with sam9x60's I2S driver, which has to try different=20
rates to get the closest one to what it needs. There is no 'perfect'=20
rate, because there is no AUDIO PLL and we have to try different values=20
for our internal dividers to find the closest one.

https://elixir.bootlin.com/linux/latest/source/sound/soc/atmel/mchp-i2s-mcc=
.c#L416

Best regards,
Codrin
