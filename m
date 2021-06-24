Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356B43B3273
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhFXPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:24:48 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:29629 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624548146; x=1656084146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y7tZRJfnG6aeqHYrMTfHvaHEvFUoji00D/rtrDYcPuY=;
  b=maFT4EtEmOIVtZeQv1dTR6wR8xXf+WNwOsO4JQYjt8K8h+UALIZr45eB
   mipU5vZ+JFixYYIXzjQ2q7RQUt8PFQFEDAHgD19Jg7hlo2oZLY5kuyQbL
   5T+wO15fzronN9+AVunjwmF2cWc+DwcRP0zOtGWHUjX7+deqYFaVouR4U
   hvWtPMB76mFFCXKPUdwim0z4QEXGSdzGhYLuMRcbPHdKPcQ412YBWHdtL
   IT1UYkkccooU510OyLzkeBXWOlEUk9byrtQfIT2WXoozeavmlRyu+pp+w
   4eKm6e8azIkGlgsh3j5+hBC9SnomLXOC2VqjF3Q1VnL7iGxkScjLxwqJm
   w==;
IronPort-SDR: pHtAaHk8Xpuy+gil8j0QsdK0Ie8SOBmSW7qkVp2lX69UreNa5TZhLAaIhWwWqcX4lvAS5dx+Zz
 f8Qwl0GpfXjnc2sT4FZX8Zmr5nb0hZq4N6RBgpNS4DCSNrvui0xOhIgT++JNP8gjYaTCQ3Jm/m
 6Un1m0V/M/f9aUw6sQRwgByvrDQYzQTsp+KeT3jp/RCaOekg7XgRI7LvUeF5dmodrFHBWTpA7v
 SdoBQ1gOB38IpshnUcROQ3cjuP9qGPYt+YcAX0i98Mrqkb8zQ/j9dbOAFsIdnnUWTw2dkKubzd
 1LM=
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="122433937"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jun 2021 08:22:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 08:22:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Thu, 24 Jun 2021 08:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXfRzdwYU4FF7nn6HNHRRqppsUa223DEdHMLzNu6Y9hKH/PZYs9dvVR8KWHv0t0+pQwPdS2hwkcGaJvIPMgZRVQ2ybCEIFBTTV93qfhzmiNtNCCSJcb8JNz5TgYGtlMqsWrQNeO9r/z45AmE7dV19id2CQXI1VHf+tZGFlQ+oe5xHbr5j3k0nhYdAlMUy6i1PoYnYf5Ipx77I+h0He0GkLJ46WE471hNN6huFgOLkQPtXhn/35j8dC7IZdKH0Y0CPU39hcuuMG9muWK6Q0YZbyRGkOe5Zd55cqj17z++OxhSNlbE4RpJDY0OBvTiUybdLH9WLXGy2rqLP28+7BJsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7tZRJfnG6aeqHYrMTfHvaHEvFUoji00D/rtrDYcPuY=;
 b=WrJ0j+gYLV9Wh/wuBzGHtwZIs1hhmWXrbt/1QfnaNmLTH3QXafm+ziV/HOugUonq81MJLRBIF9vJZrWvI1mjK/TIJTGsChOTI/M4hj2ucNdipaNnY5QvUSV5AaxTZxwMgRIKOwDgTHUNpm9+3/hZgzCRh3n7x7sMu/y9MRcbPf74vlpECcLMAg21bhNmmHqaJwWcuWFLOQRMdiBJ31lvClNSRJszLaTLqPkFOAnwtozZcyc3z+HQ0sKL3X+T5X9ee+7Np5s54e7u0lejGqnfYxHcSwjqLiN6MpveVx1rcLKv+AIHcEobhAKssnK9Uu+ZahLYgMuiVdZt4YA0yyZ//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7tZRJfnG6aeqHYrMTfHvaHEvFUoji00D/rtrDYcPuY=;
 b=Y8stVSoa5OBnevggDWQJLWgqBr+tG3XfMNOuxZll2LToc1iYldw3ktNXJOPPCQ5V8fSaXmp8uZHR8QS7csev+uJqz2ql0JwSMwG89+W+lKU6rFo8eXMCcKEEttHBag6tGsawkXgPC2fZB7783Sxz8bTJ+I8mKVVhxc8JtfnqVmg=
Received: from PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8)
 by PH0PR11MB5173.namprd11.prod.outlook.com (2603:10b6:510:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 15:22:24 +0000
Received: from PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4]) by PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4%9]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 15:22:24 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama5d4_xplained: Mark optional
 AT25DF321A as disabled
Thread-Topic: [PATCH] ARM: dts: at91: sama5d4_xplained: Mark optional
 AT25DF321A as disabled
Thread-Index: AQHXaQy7ADHbvMwdrUWX0CVnQw3iqw==
Date:   Thu, 24 Jun 2021 15:22:24 +0000
Message-ID: <f8fcace3-fc18-ff3a-8d85-0fc10f672d5e@microchip.com>
References: <20210622134222.107806-1-tudor.ambarus@microchip.com>
 <4d631b4c-7d0c-3a04-5ab6-00d09c792438@microchip.com>
In-Reply-To: <4d631b4c-7d0c-3a04-5ab6-00d09c792438@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [79.115.63.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a67c6b1-fd1c-47a2-a3cd-08d93723de3e
x-ms-traffictypediagnostic: PH0PR11MB5173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5173E0549EA8F5FCD4919247F0079@PH0PR11MB5173.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tzkCtDby7PfgsNQcikWonwDVuQqKFti4zSm97YdmAExGebVx3AkAj16Liaiyo5+QAAcM8XgGWEITT1iRiJt0VXcuy9EGzxmOg/5BUy11BIBKeVVzOge1e+/Bvc0CK0C5jQyafU1mV0W6ViZG6isANF7gv1iEQ6nhmp3c1mo2CvzXBXaaVCunbogpfWj8ZGxqc4srFpBcCI4k5DeShxDCs4jw4mznbQ8b5k96U2qfGOLVR81NA6o5DCOmxmZYriBEGL97w/smSTPxMAgEl04ekft3xOH3tcHmVqOw6H8ayezoV+1rTevx9MggDM+nT0ef1AMjDmrrRxnCKoqHcG8eA6+4OMxiKuPdDD3qJutNbfAxdTj35flIoW7WO7nGSkYSGDswAzbi40fK+326kxNFucH/jYkqGcle0KpCmGeWvRlDQpepHgN9a3pUOsZPeY4PuuFyv68F0ketY2ItLXcKlaNReC0D8WfF6VuOpRc31ozXb7tZqgbuSEe/JbvRkbwBgAjHXxbzHlW/XBT3d4KSinovkAAZLsInd36eRNSgTdLIxYcdp42785W/0AiAXZN1CHZatajmba/V7nZAI5qONesXXcuEbo0OqEmXKTd9gqG1wqgWWVB6uLKxNHHvTFONp4VnJaJMx2qCpqMSsNdqZWJAffWHzDvFJUyJPSgw7hMlpNla9H+hI3ErSWQ7PZhLKHuFd2jjVXi+J3lKEnF07oHJo3fmQmZVM5l13OmF60A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(346002)(366004)(4326008)(6636002)(6506007)(66446008)(66556008)(66476007)(66946007)(76116006)(26005)(53546011)(64756008)(186003)(91956017)(31696002)(31686004)(83380400001)(38100700002)(122000001)(36756003)(71200400001)(6486002)(8676002)(8936002)(86362001)(2906002)(5660300002)(54906003)(110136005)(6512007)(478600001)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?4Kf7hocxOqAiStTDzWFQZs18jdETCZ5WGOWhdjvNl4HM/DK5OIl1dHTy?=
 =?Windows-1252?Q?82Xmt1oZdvYpP8fJFReNAMu14Qlq6FHsesYtOTmLa/ps+r6fFqBCIxeT?=
 =?Windows-1252?Q?J4l3FJ9FRFJ+4fuDEq27QN8phUZkh8I8L7+Z2t+qqh4EdASxILNxeBHb?=
 =?Windows-1252?Q?1YntEf86HlOI5emzDGA4Waa2eM8v2LtqD9HfQ+n+XX0f1pzPyvTw5Gf4?=
 =?Windows-1252?Q?tGdR4nGrAZ1ikRiJFIeJ/XlwQ0l4poHfxzGtbghMpdirLomDnZWTkEGR?=
 =?Windows-1252?Q?HFZbgwtR/XhdOmE8YNgQlH9NdQTzNflzUP3noLPy+v7YkF06txHwHYlP?=
 =?Windows-1252?Q?YySfzW80+q7WlgbBYsgG0Ts7sSqp/OoIPEqDeTpr8NiCWpifn1cx6Kn6?=
 =?Windows-1252?Q?Cvw2Y6iKacU0WFrpBaU0HH6ios+i+RP0XbkL7uHdsKOlnoyKJIQJsXds?=
 =?Windows-1252?Q?cRkKB3GxGG2fiw2rrTL6RtYEGbomzzgHd25lVEkRqoM962vzA6tjylpW?=
 =?Windows-1252?Q?7zyFpxJa+HqZTGgxBlWlRrKOaD+EH0skGt685QqKbryIhkjhb3/tWrhr?=
 =?Windows-1252?Q?nilM7jpvCpR0N9OEsmZw5HHubx5Hx5+gUlBHaU5QQFsHAM26tpYiEmn6?=
 =?Windows-1252?Q?eu1m72qIL2pawsGb/F2uSoAYJDKV/0c9O+AHNbwKuIDGpdcW9GZPyhif?=
 =?Windows-1252?Q?uGvy9++PvObNr7NDubh5Na0GtuM1dSENox1BWqGBzWGQJCz/vitbrEbN?=
 =?Windows-1252?Q?Q2ln5lsKPYpGdXWGkC65dRnFAq4UOPJ26IqjB56eUONFi0cE6vg8Vdkb?=
 =?Windows-1252?Q?A+MaPnjhZ1oWkfDEDhFW/HemmAQwk/0n9SA3HJOZixzydUrwM65B6/+2?=
 =?Windows-1252?Q?Ms5oIJdlHZ5celmCwsyIN1fwcMAK4GpyuaEA/Io2niZYgv/kEVEQ4FWM?=
 =?Windows-1252?Q?dQs3c4wZyLTeYD7+X/g7Ih9HIg3mQ2wgvvZjuB/yNnrwBjsOUwOAPdM3?=
 =?Windows-1252?Q?8m+W0QP0bfGWo57oP8gsEwa6VTbWNQHdzxTMdKNy0YB92rTdl+0MP4S0?=
 =?Windows-1252?Q?GfelRKjbDC1SgUmpTKX4qCc12s6cTOkFKfkqXS8yQJjxnqxc6MI+Qs45?=
 =?Windows-1252?Q?ej9FQQb2ZhzpFdGw8Fps0da5K0dusx9b1drlj+m0nhmkvsBnCGtNqbTE?=
 =?Windows-1252?Q?A6EedKmx7kCIo1P3R+Bk/9tKh6dScOYiT22/BkQZCOtJCsHiSVMfLCKD?=
 =?Windows-1252?Q?wbhey9rVnnx5JJpSLmOUFns4HVostCXsOSlr8xgA5HUmELMws17SNtj9?=
 =?Windows-1252?Q?6WrH1u4J49SDgtKdrYeC7VvRRbmsXl+8DvjiISB0daw0hMrfH6HxawoE?=
 =?Windows-1252?Q?+CaDHJbqfRpxO9Y10Fy7Xu1ETlc2+r+4COY=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <8FFBC14B6022214795523E11AF8F7E18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a67c6b1-fd1c-47a2-a3cd-08d93723de3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 15:22:24.0710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhrU946DzHw2hdt9lNANlPQIYEFMJp8HQsy2ua1Q2qkNfKm3MaBWFyosCnzJfvgd1Ni6XZF+hIRCTHHxVDSbQrN+QhWDGGG1jXm3oOY88k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/21 4:53 PM, Nicolas Ferre wrote:
> Hi Tudor,
>=20
> On 22/06/2021 at 15:42, Tudor Ambarus wrote:
>> sama5d4_xplained has an optional on-board serial DataFlash (AT25DF321A),
>> which does not come populated on board by default. Mark it as disabled
>> to avoid the following probe error:
>> spi-nor spi0.0: unrecognized JEDEC id bytes: 00 00 00 00 00 00
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> =A0 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 2 +-
>> =A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot=
/dts/at91-sama5d4_xplained.dts
>> index 0b3ad1b580b8..f397e2a68e5c 100644
>> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
>> @@ -40,7 +40,7 @@ uart0: serial@f8004000 {
>> =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spi0: spi@f8010000 {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cs-gpios =3D <&pioC =
3 0>, <0>, <0>, <0>;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D "disabled";
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m25p80@0 {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatib=
le =3D "atmel,at25df321a";
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spi-max-=
frequency =3D <50000000>;
>=20
> What about keeping SPI enabled and just having the status of m25p80 as di=
sabled: honestly, I don't know if it works and if it's desirable, but might=
 be closer to reality.
>=20
> Tell me what you think.

I think it will work, because child status is checked with __of_device_is_a=
vailable,
and the child will be skipped when marked as disabled.

But I feel that spi0 was enabled just because at25df321a was assumed to be =
populated.
Wouldn't it be strange to have spi0 marked as okay, but the only child as d=
isabled?
How about removing spi0 node entirely from sama5d4_xplained dts?

Cheers,
ta
