Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9E33B141E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 08:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFWGsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 02:48:31 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49955 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWGs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 02:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624430771; x=1655966771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xkaZfQakbR0VwKs8cbEz1dAs0cksJTVIy8rdpatUK/I=;
  b=S+fTuUX1eZLpzmxmHyqBmjSRqU6VA4nzxoFwDDebtAhbI0i/f2Nl7IYK
   C5wZwS7AciITbnNzzTsSenLR3hF1OPuNKveygXwghTzxJ5xfFNttBLKfu
   U3ztAGFurUVZ1CzanE3hxPWkSo+ombyynCOYkEt3FyjH2c+i9FoJFRJta
   rcmas4JEkczbUKLlCEMIgy9X9DeGUBn96s7XCI1BLtbc1oLb8e9mWZQih
   i8yZHH/nFoWvD+kopXf5UOCSmui6fpKkjDaz2pFFLxNMtOxIzqLqy3TJ1
   8twtF8OHCliSwD+NG70bEMolUVYEhIwF5EZidmI/0ds2ZWg0cVIfUBRba
   A==;
IronPort-SDR: W6bwCSeVRt+pbWhumKAW9IjFmY59PBeYyX6VCa9bQxvZ/rBbCIqEyBS51Ge1rlqgCZb36SckBo
 bjJ+uj+s/fUCcb8hkabc4OM/0FX2ISOa58BC1axVeJw3AoDwLtfa3rR46UKGpWzNf438G7SCGb
 5Ni54Be7hS9BJkZ64YqltQQ+uCZlg1l9r5dNo8tnC0fW1zefMe2I7uZ9b4ekT6c4dK8fWfgxsA
 z/JE2kFE7FqIa5IrjWvXFxs4Z2wk5jkZil9ByHnF7epqNGrVYLYI2XcM+ySCylfJ5nhc5veDUF
 1Rs=
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="122252878"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2021 23:46:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 23:46:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Tue, 22 Jun 2021 23:46:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaqWtg16LJOXnsxVZAdT0gg1RLi7eNzo8iRz8mnaqLfzl7GGQMJ5e/RzkjgCzuPa2+IuTreSXJd5qlZcfmJRvLE1nXuQb9KxkA7jlO+wfFau/559jV97O4wZhRHsCG+9jwXYAjoE/9rbMJbV1V2nyqNp2tht8i67TWKY6UO+7bu4eDd4LrDYZYizYDLqP7z4G1Rtiow07/3zJANiDkKygQzqTg1lRmgjNLn+cZHBZQSvCh8IuAtIE1mHbVvFjLX+0HhLbAyI7HaHDZnEy/UKNQQiHOQuYn299FeXaCNadE5CDbQyKobwD4YK34qKrok87p1G/uxBM8sO5B9szgmjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etMye7dtjiXlH7V+0CF++LL51xPWdRarEMf/Gc8fRnw=;
 b=aaYJb9DTJYA+5fB5hrGDncsHH/HxpAK4u93rNjFhFMuFPd00NVrAJWfegP35p19WUUF6KHRsBq6J84GDc0aITJTob4zaGy5HQSEnRejLnUOWGZPWbkmNSbCOU6edLeAlADV1SnFsTMnGfTWAtMkg8bAwAtGRTE+jDcxPjxAiDjGiGLX7NGgijSWJ8b9RVtWGBGg8DcoffI+WgZGzeIbA+PCSsO5AjVtz+FXE+463WNvfF55tUeHx7ZhqMrGRvbRTkdDsQkoi+Lf3+XvSaU+rWAJFblvNgOoX0CXFjkmR7HboQ/GYloHWSnuKAU1z2SRt4IaENraSjX/1tnq1edlEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etMye7dtjiXlH7V+0CF++LL51xPWdRarEMf/Gc8fRnw=;
 b=AbfGoyQy5p0LHeRCK5zhtx9EE3xk3zIOe36sUrS5dz2B7IKRb0xSNBiBShlPKrzJTQQ/6fIraDsAD0mB/a9JgrvwlIlne4+jkxApjH0N+8xHtTTM1SZTXkTgndIKSOWb6RsRb64Wx7S2oooqxXHtUlObFfyfn/ukj1vPx9DDUyM=
Received: from PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8)
 by PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 06:46:08 +0000
Received: from PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4]) by PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4%9]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 06:46:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <linux@rasmusvillemoes.dk>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <frieder.schrempf@kontron.de>,
        <bbrezillon@kernel.org>, <p.yadav@ti.com>,
        <linux-kernel@vger.kernel.org>, <esben@geanix.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>,
        <masonccyang@mxic.com.tw>, <ycllin@mxic.com.tw>
Subject: Re: [RFC 2/3] mtd: spi-nor: core: compare JEDEC bytes to already
 found flash_info
Thread-Topic: [RFC 2/3] mtd: spi-nor: core: compare JEDEC bytes to already
 found flash_info
Thread-Index: AQHXZ/txAD1daNN5FEGbvnbgvaM45A==
Date:   Wed, 23 Jun 2021 06:46:08 +0000
Message-ID: <d1473b12-daea-e5e8-b8d5-64084bfbe11c@microchip.com>
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
 <20210621152320.3811194-3-linux@rasmusvillemoes.dk>
 <223232ecd0865e819477f17cd464ab08@walle.cc>
 <d43f021d-8f95-7857-b70b-91e22b0a8e2a@rasmusvillemoes.dk>
In-Reply-To: <d43f021d-8f95-7857-b70b-91e22b0a8e2a@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [79.115.63.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d5d46c7-840c-4b28-369d-08d9361294f0
x-ms-traffictypediagnostic: PH0PR11MB4997:
x-microsoft-antispam-prvs: <PH0PR11MB49972EF26DDD7A44CA254578F0089@PH0PR11MB4997.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSEY2yDL/mUBPz635HYQAkAaiUHIG3pinqOkjen8zcqy/ts20QIxWzhijPoVUwhogu9h0jugSoTLT2JSrc+JWACSiwt8uI4jFS7Bfud0Q0UfICFpG7Ayu9MmvCxqyJU6nLDt4OZY55OUP3oIm1Wfj5tfz658y+13VS4SWKxGnZSnDKK5bZOzYweK3wop+d1zzmn2pMax97SPFtYQHAv47EZBmwUtVxhbcAAAbUlLEOCvsh+vj0+08rzkMf1PodtZomyyVFuXsgHvYYSpVxRgSBdHZahvm0rhBVcGyYVRaK4D3y1tBU2yJkWrcuelYFaaYNNtC55NF2pnoVwlsZxiYid5dB6Q6UnI7YJ02H0g2a+Qn5PFYVNnkJbK7tX2pOS48hoafTAAS8CZ+aHmik21djmjTHiuLeCT5D3wIpZ5Mf1NsdFw9o/meolX7li014vJVazRodZyigEgNSogC4BJSZ9eg1YejPPyLB2z/iuxKSREgSo3vxlIjqC60rH7ziFqVaMTg5BMCdzz42UuDILVUstKB2ecssl69GvID+OuCqC/Yxvu41BFKpNRMbfCuwLsFORjzmY5YKJ/qWArrAbfTNC5NfZ+QVOdP9jjq2chhdgmejBeabdeDqIHebMwiOzPOOLnRsbs4MqsY8HicUq7ZC5JKTtuhcgLjxNrHw2pYQ6G6icp4w4r05yt/qSliJsS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(346002)(136003)(66946007)(110136005)(186003)(8676002)(71200400001)(31686004)(91956017)(53546011)(54906003)(36756003)(76116006)(26005)(6506007)(6512007)(66556008)(86362001)(316002)(66476007)(2616005)(478600001)(6486002)(31696002)(2906002)(122000001)(5660300002)(66446008)(8936002)(4326008)(83380400001)(64756008)(38100700002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?bO2griUo1cZOfCnIftUFJcu8j2/XxoqIde46gJ3dS+HTX/NI2vZoPRkm?=
 =?Windows-1252?Q?I36FW1wR+T6O1+25BjEURNI+5268jZRGMFqCtjT+wDRHEJ36aU6eOgrc?=
 =?Windows-1252?Q?z4HZymRqPQMphaOmN/fM1ptwAOstHd7049crPpSR+7g9LyHIIipeZMuW?=
 =?Windows-1252?Q?+BRkP+JeBdZigaVyESqLkuStFBDfzAYVceobuFgi8RHcdYeAe3Cwlhgk?=
 =?Windows-1252?Q?x2ZqKkq9qaoIZJn7Zo2aqubqwMC5Ae9XT2riCLBBFBSmn+G7NhEpq8vn?=
 =?Windows-1252?Q?y5u58R+Woa/q3MFEmP2vrk2wOXiAOe5cm20t/A8di3hPbiEyXD4R69BF?=
 =?Windows-1252?Q?8k6JUgpBj2AQeR/tfVrlQUjdS/m4VU06y+LDCEW2rBAmxNooq/W54PSY?=
 =?Windows-1252?Q?OPZAN089C0NW7AK/W4UglUIRVidLSRYT8Al7hHjkxyMO+GhQP2C1PNFt?=
 =?Windows-1252?Q?dDNtBx5rMyBpW2n4fu3YVR+ztLd36jXlGIXLFQ1xmIJL7qUU0fAsZ5Bz?=
 =?Windows-1252?Q?cA489ZwqnOzvO/Kp544NDWGJUdrUjjS0In95kziwCTFTnaqn75LXDwhE?=
 =?Windows-1252?Q?Ytknh+9Q+p55N6JxN39W+cS7m3kMD+5IG7k5rhMCyHuieJ8StLlnaDCr?=
 =?Windows-1252?Q?PcKpJyir3hs4co0C73w++t8rRy0Lajg9VYg84uQUjOF+aG9/nOub/cw+?=
 =?Windows-1252?Q?fHxVRa9TDLx2lyVTzkDf4DTdRjLCphgRopBHkqVhBvpNbQ/ZAFffZlNO?=
 =?Windows-1252?Q?SqrhxQX1PCrOGPMqmOSRgrNHsugtdFD2S/uPMx8Lo2aoEGIHxIB4SYMH?=
 =?Windows-1252?Q?uoGn0opJTvgAeQNGbTnC2V2CKRWmT3lC6XbCrA7r2BDS244MPy6bAZud?=
 =?Windows-1252?Q?JnTm/EJoNrlzq11f0Ad+0Mk5EuwKFABH9Ayok3O9J80Y3R/IYHLmvDnc?=
 =?Windows-1252?Q?2XRMOU2Ws88ZU35qgPpGd/9bjsyOWesYTM/SHQK4fxu5Q+gsio7oDLFj?=
 =?Windows-1252?Q?iIjUxDcHCJFDqPgaxiH1JtVKs5lur5Axsw2zIw08lzJG/EwHLyhNVyBz?=
 =?Windows-1252?Q?Vc0vt04QNaoA5o7JLmWiOlO9tgpsLwwbFHgjqdaY+BcqrkSa1C0qL8cu?=
 =?Windows-1252?Q?iNiWzysR1vsI/Nwyr8k2WNeE0kyKyvE0CZKLRRcCOrRk8v7rNKixO37Q?=
 =?Windows-1252?Q?XWha2V82bldFwg01Bkw07n1ThmTsRYCjgGC2Z0eKlBY3H1kx+Ef9SLiV?=
 =?Windows-1252?Q?y2FSKKD4F9SpD1RI8j5sXRO6j0VONszejNdFZxNEaUdphd7fagUP/EA1?=
 =?Windows-1252?Q?wQCHaQBFE0OQ44UzF0VUfMYjTbjrJHndcAYnA15UjcfEZcBFHwNLkK/4?=
 =?Windows-1252?Q?SOB+026PP6PW9W+xtomGazw4rQx/No1DL2M=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A42A73CAC17D0841B9405202F3E939F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5d46c7-840c-4b28-369d-08d9361294f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 06:46:08.4283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+ROkRDKeUXj1EXHM/Xcnx/mncctRGNeeJJhTxH0VLfcKnK5KTY5wqj7+id+J/fS6gCBKHByssFyKtzL7314hOo7XPbX6x0+ghqK5cz5VJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/22/21 11:58 PM, Rasmus Villemoes wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On 22/06/2021 13.57, Michael Walle wrote:
>> [+ some people from MXIC as they are ones who posted to the ML
>> lately. Feel free to forward this mail to the corresponding people.]
>>
>> Am 2021-06-21 17:23, schrieb Rasmus Villemoes:
>>> Macronix engineers, in their infinite wisdom, have a habit of reusing
>>> JEDEC ids for different chips. There's already one
>>> workaround (MX25L25635F v MX25L25635E), but the same problem exists
>>> for MX25L3205D v MX25L3233F, the latter of which is not currently
>>> supported by linux.
>>>
>>> AFAICT, that case cannot really be handled with any of the ->fixup
>>> machinery: The correct entry for the MX25L3233F would read
>>>
>>>         { "mx25l3233f",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K |
>>> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ ) },
>>>
>>> while the existing one is
>>>
>>>     { "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
>>>
>>> So in spi_nor_init_params(), we won't even try reading the sfdp
>>> info (i.e. call spi_nor_sfdp_init_params), and hence
>>> spi_nor_post_sfdp_fixups() has no way of distinguishing the
>>> chips.
>>>
>>> Replacing the existing entry with the mx25l3233f one to coerce the
>>> core into issuing the SPINOR_OP_RDSFDP is also not really an option,
>>> because the data sheet for the mx25l3205d explicitly says not to issue
>>> any commands not listed ("It is not recommended to adopt any other
>>> code not in the command definition table, which will potentially enter
>>> the hidden mode.", whatever that means).
>>
>> Maybe we should ask Macronix if it is safe to send the RDSFDP command.
>> Can anyone from MXIC comment this?
>=20
> Yeah, that would be useful to know, but I don't have any hopes
> whatsoever of Macronix engineers being able to help sort out the mess
> they've created by reusing IDs in the first place. They don't seem to
> understand how that can possibly be a problem.
>=20
> I, and my client, have contacted them on several occasions to ask how
> we're supposed to deal with that. At one point, the answer was
> "MX25L3233F support Serial Flash Discoverable Parameters (SFDP) mode,
> MX25L3205D does not support.", but when I asked the obvious follow-up
> ("but the MX25L3205D datasheet warns against doing RDSFDP or any other
> not explicitly allowed command"), I got no response.
>=20
> Another response was
>=20
> "I can only comment on Linux 4.4, as that is the only version that I
> have supporting material for. Basically we have a patch for MTD/SPI-NOR
> (see attached). This is to allow allow the MTD subsystem to cope with
> devices that have the same ID (see below first paragraph of application
> note attached). Please note that the MX25L3205D had an EOL notification
> on 14th May 2010."
>=20
> and that attached patch is a 173KB .patch file that made me taste my
> breakfast again.
>=20
> And they keep repeating the argument that when a chip is EOL, it's OK to
> reuse its ID (because obviously nobody have used that chip in a product
> that would receive OS updates, so any OS released later than that EOL
> date can just include support for the newer chip and drop the old one...)=
.
>=20
>>> In order to support such cases, extend the logic in spi_nor_read_id()
>>> a little so that if we already have a struct flash_info* from the name
>>> in device tree, check the JEDEC bytes against that, and if it is a
>>> match, accept that (device tree compatible + matching JEDEC bytes) is
>>> stronger than merely matching JEDEC bytes.
>>
>> This won't help much without a proper dt schema. No in-tree devicetree
>> could use is because the DT validation would complain.
>=20
> I can certainly extend the regexp in jedec,spi-nor.yaml to match this
> new one. DT is supposed to describe the hardware, so I can't see how
> that could possibly be controversial.

No, please don't go that path yet.

>=20
>  So if this will
>> go in (and the maintainers are rather hesitant to add it, I tried
>> it myself [1]), you'd also need to add it to jedec,spi-nor.yaml and
>> get an ack from Rob.

I'm not hesitant, I'm keeping my NACK until we're sure there isn't any othe=
r way
to differentiate at run-time. I've contacted a macronix representative, ask=
ing
if RDSFDP is harmful for MX25L3205D, let's wait for a few days. Maybe Zheng=
xun or
ycllin in cc can help too. Is there anyone here having a MX25L3205D?

Cheers,
ta

>=20
> Thanks for that link. So it seems this isn't the first time recycled IDs
> have come up, and not just for Macronix.
>=20
> Yes, vendors shouldn't recycle IDs. They do. They should be punished by
> people not using those chips in new designs. Doesn't work, hardware
> designers do use them. Auto-detection is preferred over using hard-coded
> values from DT. Sure, absolutely, and when the ID is known to be
> ambiguous, by all means throw in all the heuristics and chip-specific
> quirks one can think of to disambiguate. But at the end of the day,
> there are chips out there which cannot be distinguished without help
> from DT, and as DT is supposed to describe the hardware, why is that
> such a big problem?
>=20
> And I'm not suggesting any change whatsoever as to how a compatible
> string of merely "jedec,spi-nor" would be handled - it would just take
> the first chip with the read JEDEC id, then apply any appropriate quirks
> and fixups.
>=20
> Rasmus
>=20

