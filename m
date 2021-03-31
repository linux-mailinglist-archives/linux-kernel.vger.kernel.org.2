Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5BB34FBDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhCaIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:47:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23574 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCaIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617180453; x=1648716453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PoxtYxjAh6lAyoOvtogAl3rtUb7qGoOpkEDJe9LJlos=;
  b=GW5S1akS5ae2298g4OL3HhzqCqNH84DK3n+tGesL/s76PNVU+xWxNzy7
   TpAqk/p/S0ytWq5nTLeAaEgoiyr6iMo7Zcd0yBPJ/N4WpuU/xboXDAU0j
   RPCrEAMSclVdr8DGkZ53NzZAqtERFQAzSKlJAAZYOeBB3S3E5+8V47U9y
   3WNo4FqFX4UM9XWRVkdyY7XlzBEm06fjfID/P4xAbUjBKKX+cBCUfk/hU
   h0B2UZyV4Q+vkA4xslOM4WEAm6Wk84Jahg0cEx9SaO1wUs+so8d+A6zax
   bIbt8jKtFr3UFqK6kLywU+bes85QkUsWxFpKEXfBmUzU36olAq5or9bup
   w==;
IronPort-SDR: VPRCDPWsboAP856b1/V4/Guib3JeBeu+ru7mzUiEUUAcdtE8AT4BBT40sGYXkgkEgq647p8JYP
 i6KPjCGNYOgnOz3Vkef1JXoyWQ+ixDv2FbjaNSDeO+ii3bsLPOiOxYbY6zdG1WfRiyQMessO8Y
 cOw38oIiFV4NnR0Mvh4lNb5zYfsWGZgiReJbsCjZwTQ7pL9pYTZdxTyfpLKUOCiaBqlgyKiKPl
 UK38Ujd1q1sWM4kpw331NTjxaKa8WiJt1GdoPiAE839kP+vADcfgvF+mC3e5jgsbJ1KZAw4vSU
 DNE=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="109187135"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 01:47:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 01:47:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Wed, 31 Mar 2021 01:47:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VThI89f5UFGSkrmFcoJhOmBFExU9IbPfZ1WnRyROGgOurc09TFkhyXxEZPcZK9zDtFjWiioPoSavRxvzFgdBIxkhVKoctcfehZFBbW91sT8cZoQ/PFNE3YyexEXT6cT3jP1jToHM4xdTslP4WyTy6fwrYTFcag5KTzev59mOVP0HIg2gK6OWj0Wbh1/RdAu4VvDMhWNuTLo7kvKSEBqjTeMID3oggvf0aebFdaehG2h3QCwsQ+rGUTs+OZFwUUH2e1V/WCqMjqPHHD+bLszawP0FdqI5RXtYECMTaBHFhGHsmF0gmiOOZxDWa6IMkE1B6NzkC2D87jt3LCT7Vdc7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQF9DK2RHqO5ZnuRp97Rps+5T90rAh7VToiEdvKxGBE=;
 b=ZmaMxRQwX8HrAmD/3St8j0jWz4bkV/kjYPke/HMEZ8URcPnKr5TXfNGs5d33ptu+euG89qDTdgM1v5lz+VxuEFYByN1MCMdz6nuWUR+WrHneYCiNNIhoMiAV614FEf8GrpDgHT1QsVA70kvhlpuk47o7BVQC5fMTU9ysMcOuPD4aez9QSQqzFMkc9OvOxmv/hIaiMiJ11Y0xjuDSkZDODXXwbNg8pTuiJ4yEbParffTB4zSvD1SfUJk/cWHlmuImd7gGVNkD3+V0obv/JT6SHSoWhdWRY/3ttBZq2SUTO5KYcs2+myo21HBnvBWi/c2c9PGk3lCW646Mij7sQclUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQF9DK2RHqO5ZnuRp97Rps+5T90rAh7VToiEdvKxGBE=;
 b=fDwkV3Xs1Y+WGOyGc112Wc0oMp6KcmCftF1l7ZFdCwelYp9MpVjD8oQZFbJU18H7xt+OTVbJ5JmDDRid4EjOfYPdqY+X0u/GKWTA9dBQlh5nSKBMy37phFMDFgvR0jbX5MpLPxOQzdVARwYPNQwvsoQQjng0xQUSQL0JmYwPohU=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1434.namprd11.prod.outlook.com (2603:10b6:4:9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.31; Wed, 31 Mar 2021 08:47:30 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7%2]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 08:47:30 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/5] clk: at91: re-factor clocks suspend/resume
Thread-Topic: [RESEND PATCH 1/5] clk: at91: re-factor clocks suspend/resume
Thread-Index: AQHXJgp7ERVcbtEhzUqus85al+/a/A==
Date:   Wed, 31 Mar 2021 08:47:30 +0000
Message-ID: <4a2f6e6b-020d-2d01-2510-3f2c897c08f1@microchip.com>
References: <20210324094353.1710114-1-claudiu.beznea@microchip.com>
 <20210324094353.1710114-2-claudiu.beznea@microchip.com>
 <b89186ea-07da-c3a7-7e88-0bc1ca585769@microchip.com>
In-Reply-To: <b89186ea-07da-c3a7-7e88-0bc1ca585769@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.76.227.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0786b2d4-5409-4567-2230-08d8f4219e74
x-ms-traffictypediagnostic: DM5PR11MB1434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1434441C3DB1C75831203458877C9@DM5PR11MB1434.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r7ADAqnxtcfsyhxJJvh4yyN/r+FUFGuchT46dfF32ZuZgGmRyZISbBTMhXAqtmzC+wOep0DirxhBAmhvbNcaGLbNc2hvpM55BgrREN+xduAXlP8jTMDvPKKnhsz1mEDFrpJSx58gr4hr3tUSTfqxIdY4NtfW3rAj+dCGOsHQjzoSz7h4+AbbyJVM/ljeeKMex/k4eFGXXQwKpBBtlJgRBoSkv/+Nkhp3eKo9eVIFxwwj2VNwS4rZ3F1asQrVFfN1/56wPtLiXG1aHSKdpoaB6marseaXik5eKolfTbhKuST052+KM9M6GKoCJeiYjVl233042sjENIJKsmycJh+uJ6kwHqHk8S1iiU8/oqkKzWa/xv4UGlggX3Ro5PDTMugJyGDRG8qMWYxj6R4OQqG3JnqikjTxQ+Q9pZTnt+YPyc+8+cofc7iaH9/Io728lvx9ADcQPZpkP17yUQ4542gGzuXI1A0wOyXQYtir+oF+jGiJKTbD03thEQpTZsZP8hPGF9o52urI+A2kSbxl9QQoYFm7OKn5PK29zBrEk8KnpNBCO5LyAfNEhzMsJyEYYCIEg9xNmHdl0VM2OWyBKocbQU7+H1CSdfxSthIYr4HFLJD7fcJbQIQCDIlzKmr1SoaABNvep3cBVCbj5P8tOZtrKQOloVXKQERUcs0GfcVNLPxc/mOuwuGnRKdMrKSYylQoUaR0CWuBJ/nflgcVfvzgx+A01YV23lsBJ5YIuxrJvMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(6486002)(26005)(110136005)(83380400001)(15650500001)(31686004)(66476007)(66556008)(8676002)(66946007)(64756008)(8936002)(71200400001)(91956017)(498600001)(30864003)(6506007)(53546011)(76116006)(2616005)(6636002)(186003)(2906002)(66446008)(86362001)(4326008)(38100700001)(6512007)(5660300002)(31696002)(36756003)(45980500001)(43740500002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?/iO+eysLBqkofSrl7mm1N83kxM5cqPyFZtAtvimiHfzCvqkiTlmA9sBX?=
 =?Windows-1252?Q?bxV+R1xZWdoDJ+wg+6XcZZkz8wselYUdMBSWEIXhOUX7OauTm6964ATX?=
 =?Windows-1252?Q?n+2LlGg3C1ecBn1tKWrXDBUyXzC8JvlgLYCtacaLtCKM/YvsTCTL8Y3R?=
 =?Windows-1252?Q?c3jF4KrkvnciWSeQzXHggkptDWrLmJYNGYEJvSSVpvvaH6P8hgA+/kl0?=
 =?Windows-1252?Q?MqFLk4xDQEvjgg8QvLHJUJrJu0aZWEmnKXS9eCZEBfEI+gaXfRub6zKr?=
 =?Windows-1252?Q?BCx9XOivTmSy1awgv2spTGbP+faj6Kc/6jYZvpdv85/C719JXjHRjBom?=
 =?Windows-1252?Q?H+OMrGKNmcs0Z8t15d6YrmdOkaXV4QHHaBfQy0rVJ9wZYv0PKJN8TL37?=
 =?Windows-1252?Q?IbIUGbjzJtLB1+tybvzkQnci3yO6gLqrIzhZf28+yMFtyhnN4e+Hkl1q?=
 =?Windows-1252?Q?AaO9Y+D7h5Dtor2gu/LPZlGFCKJ1ZzVPd/thvg6mSenRQl3REREnmRR+?=
 =?Windows-1252?Q?19BVxupA1SEA/HgkpBL8M0urG1KGZ6rS68pBiWL4/aK+CP+4suF/haQU?=
 =?Windows-1252?Q?9YKnJS+iLUNua2t+VyrTF+zpTwiNw3dA4hyzCwJXRnu+N0ngKGvaMQjA?=
 =?Windows-1252?Q?LsO5L8RpYGW5FIsF1Yn6ro1iPe71TufRdJ9SeXkDQv/GoHjT0OidW5u1?=
 =?Windows-1252?Q?Pj5QkicivBLGgXTvlK8jjwfIOc0OWkvUnZBbmmTRKhnmuYS2fP2O4SsE?=
 =?Windows-1252?Q?CPP73QkWb3DFCy8We5s1K564TinXC8wkjwaDizsrJz7dF0l5IGdYCSh8?=
 =?Windows-1252?Q?n+1+SU/yoDDW5WF8S4zcwbxcAdbHYvlohyvq/fYC7AEQr3Rkz21hjBvw?=
 =?Windows-1252?Q?l9kMBCF+rHtVegKqOICcWdtX5tvixk25i88TLrHVEISb7F6If4Ni5teX?=
 =?Windows-1252?Q?JL9iSl5g5CsuHfS9cfEA9WZamysfQGzxm6r1ox/YApOJ7nPdAsQiD9/a?=
 =?Windows-1252?Q?rmws3hgdFzmHxyVbRAfeVDLqiLCQo5X+lWQmPIVyXdzEsB1w4hUPLyvM?=
 =?Windows-1252?Q?twHjRQyhCkZ80nd9nWwt4bjamUwOBy3Wv1Eeu2oRtGkj/7s2tHWWAbU2?=
 =?Windows-1252?Q?VjULmic86AEN7QAzN7+Uh5JKcakD91XtZZuVncgv7PfyCdBnFv/ifqUs?=
 =?Windows-1252?Q?P9Bc9UVLFdpNTQAmQ6rjXxKcUh32DhSx4xEKjypOizLkjcPE7nVlB2n6?=
 =?Windows-1252?Q?EKtkV7acr5eqor37YPX3HOiEnRyCImxhUbPQEEmOmmeiNb63cA7wScTk?=
 =?Windows-1252?Q?5xLiUNbkLxIY59dCxXCBjoeNWOOABp0NCK8MVm7NzlHsfyGvt8UFHeHh?=
 =?Windows-1252?Q?R3SQ39ccokPyl4//Sq0nHHpSYCT9txy9pNk=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4399CB444ABF654EAC50F1335027F67C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0786b2d4-5409-4567-2230-08d8f4219e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 08:47:30.1414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abHqfkrTKwdg7zXmDAdQQOOZIBBIQae/tkmT9R3BQzhDVV7kb0o/kCcIQbuGGiXjPS14fCjUJFqMO9zqu4zG6wA0HagbiSGHaLZq1p7oy80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1434
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.2021 20:14, Nicolas Ferre wrote:
> On 24/03/2021 at 10:43, Claudiu Beznea wrote:
>> SAMA5D2 and SAMA7G5 have a special power saving mode (backup mode) where
>> most of the SoC's components are powered off (including PMC). Resuming
>> from this mode is done with the help of bootloader. Peripherals are not
>> aware of the power saving mode thus most of them are disabling clocks in
>> proper suspend API and re-enable them in resume API without taking into
>> account the previously setup rate. Moreover some of the peripherals are
>> acting as wakeup sources and are not disabling the clocks in this
>> scenario, when suspending. Since backup mode cuts the power for
>> peripherals, in resume part these clocks needs to be re-configured.
>>
>> The initial PMC suspend/resume code was designed with SAMA5D2's PMC
>> in mind. SAMA7G's PMC is different (few new functionalities, different
>> registers offsets, different offsets in registers for each
>> functionalities). To address both SAMA5D2 and SAMA7G5 PMC add
>> .save_context()/.resume_context() support to each clocks driver and call
>> this from PMC driver.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>> =A0 drivers/clk/at91/clk-generated.c=A0=A0=A0 |=A0 45 +++++--
>> =A0 drivers/clk/at91/clk-main.c=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 66 ++++++++=
++
>> =A0 drivers/clk/at91/clk-master.c=A0=A0=A0=A0=A0=A0 | 183 ++++++++++++++=
++++++++++++--
>> =A0 drivers/clk/at91/clk-peripheral.c=A0=A0 |=A0 38 +++++-
>> =A0 drivers/clk/at91/clk-pll.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 37 ++++++
>> =A0 drivers/clk/at91/clk-programmable.c |=A0 29 ++++-
>> =A0 drivers/clk/at91/clk-sam9x60-pll.c=A0 |=A0 68 ++++++++++-
>> =A0 drivers/clk/at91/clk-system.c=A0=A0=A0=A0=A0=A0 |=A0 20 +++
>> =A0 drivers/clk/at91/clk-usb.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 27 ++++
>> =A0 drivers/clk/at91/clk-utmi.c=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 47 ++++++-
>> =A0 drivers/clk/at91/pmc.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 149 =
++--------------------
>> =A0 drivers/clk/at91/pmc.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2=
4 ++--
>> =A0 12 files changed, 554 insertions(+), 179 deletions(-)
>>
>> diff --git a/drivers/clk/at91/clk-generated.c
>> b/drivers/clk/at91/clk-generated.c
>> index b4fc8d71daf2..0e436f9e7508 100644
>> --- a/drivers/clk/at91/clk-generated.c
>> +++ b/drivers/clk/at91/clk-generated.c
>> @@ -27,6 +27,7 @@ struct clk_generated {
>> =A0=A0=A0=A0=A0 u32 id;
>> =A0=A0=A0=A0=A0 u32 gckdiv;
>> =A0=A0=A0=A0=A0 const struct clk_pcr_layout *layout;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0=A0=A0=A0=A0 u8 parent_id;
>> =A0=A0=A0=A0=A0 int chg_pid;
>> =A0 };
>> @@ -34,25 +35,34 @@ struct clk_generated {
>> =A0 #define to_clk_generated(hw) \
>> =A0=A0=A0=A0=A0 container_of(hw, struct clk_generated, hw)
>> =A0 -static int clk_generated_enable(struct clk_hw *hw)
>> +static int clk_generated_set(struct clk_generated *gck, int status)
>> =A0 {
>> -=A0=A0=A0 struct clk_generated *gck =3D to_clk_generated(hw);
>> =A0=A0=A0=A0=A0 unsigned long flags;
>> =A0 -=A0=A0=A0 pr_debug("GCLK: %s, gckdiv =3D %d, parent id =3D %d\n",
>> -=A0=A0=A0=A0=A0=A0=A0=A0 __func__, gck->gckdiv, gck->parent_id);
>> -
>> =A0=A0=A0=A0=A0 spin_lock_irqsave(gck->lock, flags);
>> =A0=A0=A0=A0=A0 regmap_write(gck->regmap, gck->layout->offset,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (gck->id & gck->layout->pid_m=
ask));
>> =A0=A0=A0=A0=A0 regmap_update_bits(gck->regmap, gck->layout->offset,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AT91_PMC_PCR_GCKDIV_MAS=
K | gck->layout->gckcss_mask |
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gck->layout->cmd | AT91_PMC_=
PCR_GCKEN,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gck->layout->cmd | (status ?=
 AT91_PMC_PCR_GCKEN : 0),
>=20
>=20
> update_bits is already a compact version of read/modify/write, I think it
> doesn't need another lever of density.
> I wouldn't include this test operator here.

Having the check of status here allows to have a single function, namely
clk_generated_set() for enable, disable that could be used in in clock
enable/disable APIs but also on suspend/resume function. To avoid the
checking as, a first solution I see using another local variable that does
what the test operator is doing here:

unsigned int x =3D status ? AT91_PMC_PCR_GCKEN : 0;

and then:

     regmap_update_bits(gck->regmap, gck->layout->offset,
                AT91_PMC_PCR_GCKDIV_MASK | gck->layout->gckcss_mask |
-               gck->layout->cmd | AT91_PMC_PCR_GCKEN,
+               gck->layout->cmd | x,

Would you prefer having another local variable and doing like this?


>=20
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 field_prep(gck->layout-=
>gckcss_mask, gck->parent_id) |
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gck->layout->cmd |
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(AT91_PMC_PCR=
_GCKDIV_MASK, gck->gckdiv) |
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AT91_PMC_PCR_GCKEN);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (status ? AT91_PMC_PCR_GCKEN=
 : 0));
>=20
> Ditto
>=20
>> =A0=A0=A0=A0=A0 spin_unlock_irqrestore(gck->lock, flags);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static int clk_generated_enable(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_generated *gck =3D to_clk_generated(hw);
>> +
>> +=A0=A0=A0 pr_debug("GCLK: %s, gckdiv =3D %d, parent id =3D %d\n",
>> +=A0=A0=A0=A0=A0=A0=A0=A0 __func__, gck->gckdiv, gck->parent_id);
>> +
>> +=A0=A0=A0 clk_generated_set(gck, 1);
>> +
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 @@ -239,6 +249,23 @@ static int clk_generated_set_rate(struct clk_hw=
 *hw,
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 +static int clk_generated_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_generated *gck =3D to_clk_generated(hw);
>> +
>> +=A0=A0=A0 gck->pms.status =3D clk_generated_is_enabled(&gck->hw);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_generated_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_generated *gck =3D to_clk_generated(hw);
>> +
>> +=A0=A0=A0 if (gck->pms.status)
>> +=A0=A0=A0=A0=A0=A0=A0 clk_generated_set(gck, gck->pms.status);
>> +}
>> +
>> =A0 static const struct clk_ops generated_ops =3D {
>> =A0=A0=A0=A0=A0 .enable =3D clk_generated_enable,
>> =A0=A0=A0=A0=A0 .disable =3D clk_generated_disable,
>> @@ -248,6 +275,8 @@ static const struct clk_ops generated_ops =3D {
>> =A0=A0=A0=A0=A0 .get_parent =3D clk_generated_get_parent,
>> =A0=A0=A0=A0=A0 .set_parent =3D clk_generated_set_parent,
>> =A0=A0=A0=A0=A0 .set_rate =3D clk_generated_set_rate,
>> +=A0=A0=A0 .save_context =3D clk_generated_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_generated_restore_context,
>> =A0 };
>> =A0 =A0 /**
>> @@ -314,8 +343,6 @@ at91_clk_register_generated(struct regmap *regmap,
>> spinlock_t *lock,
>> =A0=A0=A0=A0=A0 if (ret) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(gck);
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 hw =3D ERR_PTR(ret);
>> -=A0=A0=A0 } else {
>> -=A0=A0=A0=A0=A0=A0=A0 pmc_register_id(id);
>> =A0=A0=A0=A0=A0 }
>> =A0 =A0=A0=A0=A0=A0 return hw;
>> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
>> index cfae2f59df66..8601b27c1ae0 100644
>> --- a/drivers/clk/at91/clk-main.c
>> +++ b/drivers/clk/at91/clk-main.c
>> @@ -28,6 +28,7 @@
>> =A0 struct clk_main_osc {
>> =A0=A0=A0=A0=A0 struct clk_hw hw;
>> =A0=A0=A0=A0=A0 struct regmap *regmap;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0 };
>> =A0 =A0 #define to_clk_main_osc(hw) container_of(hw, struct clk_main_osc=
, hw)
>> @@ -37,6 +38,7 @@ struct clk_main_rc_osc {
>> =A0=A0=A0=A0=A0 struct regmap *regmap;
>> =A0=A0=A0=A0=A0 unsigned long frequency;
>> =A0=A0=A0=A0=A0 unsigned long accuracy;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0 };
>> =A0 =A0 #define to_clk_main_rc_osc(hw) container_of(hw, struct
>> clk_main_rc_osc, hw)
>> @@ -51,6 +53,7 @@ struct clk_rm9200_main {
>> =A0 struct clk_sam9x5_main {
>> =A0=A0=A0=A0=A0 struct clk_hw hw;
>> =A0=A0=A0=A0=A0 struct regmap *regmap;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0=A0=A0=A0=A0 u8 parent;
>> =A0 };
>> =A0 @@ -120,10 +123,29 @@ static int clk_main_osc_is_prepared(struct clk=
_hw
>> *hw)
>> =A0=A0=A0=A0=A0 return (status & AT91_PMC_MOSCS) && clk_main_parent_sele=
ct(tmp);
>> =A0 }
>> =A0 +static int clk_main_osc_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_main_osc *osc =3D to_clk_main_osc(hw);
>> +
>> +=A0=A0=A0 osc->pms.status =3D clk_main_osc_is_prepared(hw);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_main_osc_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_main_osc *osc =3D to_clk_main_osc(hw);
>> +
>> +=A0=A0=A0 if (osc->pms.status)
>> +=A0=A0=A0=A0=A0=A0=A0 clk_main_osc_prepare(hw);
>> +}
>> +
>> =A0 static const struct clk_ops main_osc_ops =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D clk_main_osc_prepare,
>> =A0=A0=A0=A0=A0 .unprepare =3D clk_main_osc_unprepare,
>> =A0=A0=A0=A0=A0 .is_prepared =3D clk_main_osc_is_prepared,
>> +=A0=A0=A0 .save_context =3D clk_main_osc_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_main_osc_restore_context,
>> =A0 };
>> =A0 =A0 struct clk_hw * __init
>> @@ -240,12 +262,31 @@ static unsigned long
>> clk_main_rc_osc_recalc_accuracy(struct clk_hw *hw,
>> =A0=A0=A0=A0=A0 return osc->accuracy;
>> =A0 }
>> =A0 +static int clk_main_rc_osc_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_main_rc_osc *osc =3D to_clk_main_rc_osc(hw);
>> +
>> +=A0=A0=A0 osc->pms.status =3D clk_main_rc_osc_is_prepared(hw);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_main_rc_osc_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_main_rc_osc *osc =3D to_clk_main_rc_osc(hw);
>> +
>> +=A0=A0=A0 if (osc->pms.status)
>> +=A0=A0=A0=A0=A0=A0=A0 clk_main_rc_osc_prepare(hw);
>> +}
>> +
>> =A0 static const struct clk_ops main_rc_osc_ops =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D clk_main_rc_osc_prepare,
>> =A0=A0=A0=A0=A0 .unprepare =3D clk_main_rc_osc_unprepare,
>> =A0=A0=A0=A0=A0 .is_prepared =3D clk_main_rc_osc_is_prepared,
>> =A0=A0=A0=A0=A0 .recalc_rate =3D clk_main_rc_osc_recalc_rate,
>> =A0=A0=A0=A0=A0 .recalc_accuracy =3D clk_main_rc_osc_recalc_accuracy,
>> +=A0=A0=A0 .save_context =3D clk_main_rc_osc_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_main_rc_osc_restore_context,
>> =A0 };
>> =A0 =A0 struct clk_hw * __init
>> @@ -465,12 +506,37 @@ static u8 clk_sam9x5_main_get_parent(struct clk_hw
>> *hw)
>> =A0=A0=A0=A0=A0 return clk_main_parent_select(status);
>> =A0 }
>> =A0 +static int clk_sam9x5_main_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_sam9x5_main *clkmain =3D to_clk_sam9x5_main(hw);
>> +
>> +=A0=A0=A0 clkmain->pms.status =3D clk_main_rc_osc_is_prepared(&clkmain-=
>hw);
>> +=A0=A0=A0 clkmain->pms.parent =3D clk_sam9x5_main_get_parent(&clkmain->=
hw);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_sam9x5_main_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_sam9x5_main *clkmain =3D to_clk_sam9x5_main(hw);
>> +=A0=A0=A0 int ret;
>> +
>> +=A0=A0=A0 ret =3D clk_sam9x5_main_set_parent(hw, clkmain->pms.parent);
>> +=A0=A0=A0 if (ret)
>> +=A0=A0=A0=A0=A0=A0=A0 return;
>> +
>> +=A0=A0=A0 if (clkmain->pms.status)
>> +=A0=A0=A0=A0=A0=A0=A0 clk_sam9x5_main_prepare(hw);
>> +}
>> +
>> =A0 static const struct clk_ops sam9x5_main_ops =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D clk_sam9x5_main_prepare,
>> =A0=A0=A0=A0=A0 .is_prepared =3D clk_sam9x5_main_is_prepared,
>> =A0=A0=A0=A0=A0 .recalc_rate =3D clk_sam9x5_main_recalc_rate,
>> =A0=A0=A0=A0=A0 .set_parent =3D clk_sam9x5_main_set_parent,
>> =A0=A0=A0=A0=A0 .get_parent =3D clk_sam9x5_main_get_parent,
>> +=A0=A0=A0 .save_context =3D clk_sam9x5_main_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_sam9x5_main_restore_context,
>> =A0 };
>> =A0 =A0 struct clk_hw * __init
>> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master=
.c
>> index a80427980bf7..6f1fb2eb2a8d 100644
>> --- a/drivers/clk/at91/clk-master.c
>> +++ b/drivers/clk/at91/clk-master.c
>> @@ -37,6 +37,7 @@ struct clk_master {
>> =A0=A0=A0=A0=A0 spinlock_t *lock;
>> =A0=A0=A0=A0=A0 const struct clk_master_layout *layout;
>> =A0=A0=A0=A0=A0 const struct clk_master_characteristics *characteristics=
;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0=A0=A0=A0=A0 u32 *mux_table;
>> =A0=A0=A0=A0=A0 u32 mckr;
>> =A0=A0=A0=A0=A0 int chg_pid;
>> @@ -112,10 +113,52 @@ static unsigned long
>> clk_master_div_recalc_rate(struct clk_hw *hw,
>> =A0=A0=A0=A0=A0 return rate;
>> =A0 }
>> =A0 +static int clk_master_div_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_master *master =3D to_clk_master(hw);
>> +=A0=A0=A0 struct clk_hw *parent_hw =3D clk_hw_get_parent(hw);
>> +=A0=A0=A0 unsigned long flags;
>> +=A0=A0=A0 unsigned int mckr, div;
>> +
>> +=A0=A0=A0 spin_lock_irqsave(master->lock, flags);
>> +=A0=A0=A0 regmap_read(master->regmap, master->layout->offset, &mckr);
>> +=A0=A0=A0 spin_unlock_irqrestore(master->lock, flags);
>> +
>> +=A0=A0=A0 mckr &=3D master->layout->mask;
>> +=A0=A0=A0 div =3D (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
>> +=A0=A0=A0 div =3D master->characteristics->divisors[div];
>> +
>> +=A0=A0=A0 master->pms.parent_rate =3D clk_hw_get_rate(parent_hw);
>> +=A0=A0=A0 master->pms.rate =3D DIV_ROUND_CLOSEST(master->pms.parent_rat=
e, div);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_master_div_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_master *master =3D to_clk_master(hw);
>> +=A0=A0=A0 unsigned long flags;
>> +=A0=A0=A0 unsigned int mckr;
>> +=A0=A0=A0 u8 div;
>> +
>> +=A0=A0=A0 spin_lock_irqsave(master->lock, flags);
>> +=A0=A0=A0 regmap_read(master->regmap, master->layout->offset, &mckr);
>> +=A0=A0=A0 spin_unlock_irqrestore(master->lock, flags);
>> +
>> +=A0=A0=A0 mckr &=3D master->layout->mask;
>> +=A0=A0=A0 div =3D (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
>> +=A0=A0=A0 div =3D master->characteristics->divisors[div];
>> +
>> +=A0=A0=A0 if (div !=3D DIV_ROUND_CLOSEST(master->pms.parent_rate,
>> master->pms.rate))
>> +=A0=A0=A0=A0=A0=A0=A0 pr_warn("MCKR DIV not configured properly by firm=
ware!\n");
>=20
> Just to be sure: I see no write to register in this function and only
> warning print. I assume it's intended.

Yes, its intended. It is the code that was active before this patch (see
old code in drivers/clk/at91/pmc.c). This register should be restored by
bootloader.

>=20
>> +}
>> +
>> =A0 static const struct clk_ops master_div_ops =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D clk_master_prepare,
>> =A0=A0=A0=A0=A0 .is_prepared =3D clk_master_is_prepared,
>> =A0=A0=A0=A0=A0 .recalc_rate =3D clk_master_div_recalc_rate,
>> +=A0=A0=A0 .save_context =3D clk_master_div_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_master_div_restore_context,
>> =A0 };
>> =A0 =A0 static int clk_master_div_set_rate(struct clk_hw *hw, unsigned l=
ong
>> rate,
>> @@ -125,7 +168,9 @@ static int clk_master_div_set_rate(struct clk_hw *hw=
,
>> unsigned long rate,
>> =A0=A0=A0=A0=A0 const struct clk_master_characteristics *characteristics=
 =3D
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 master->characteristics;
>> =A0=A0=A0=A0=A0 unsigned long flags;
>> +=A0=A0=A0 unsigned int mckr, tmp;
>> =A0=A0=A0=A0=A0 int div, i;
>> +=A0=A0=A0 int ret;
>> =A0 =A0=A0=A0=A0=A0 div =3D DIV_ROUND_CLOSEST(parent_rate, rate);
>> =A0=A0=A0=A0=A0 if (div > ARRAY_SIZE(characteristics->divisors))
>> @@ -145,11 +190,24 @@ static int clk_master_div_set_rate(struct clk_hw
>> *hw, unsigned long rate,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> =A0 =A0=A0=A0=A0=A0 spin_lock_irqsave(master->lock, flags);
>> -=A0=A0=A0 regmap_update_bits(master->regmap, master->layout->offset,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (MASTER_DIV_MASK << MASTER_D=
IV_SHIFT),
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (div << MASTER_DIV_SHIFT));
>> +=A0=A0=A0 ret =3D regmap_read(master->regmap, master->layout->offset, &=
mckr);
>> +=A0=A0=A0 if (ret)
>> +=A0=A0=A0=A0=A0=A0=A0 goto unlock;
>> +
>> +=A0=A0=A0 tmp =3D mckr & master->layout->mask;
>> +=A0=A0=A0 tmp =3D (tmp >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
>> +=A0=A0=A0 if (tmp =3D=3D div)
>> +=A0=A0=A0=A0=A0=A0=A0 goto unlock;
>> +
>> +=A0=A0=A0 mckr &=3D ~(MASTER_DIV_MASK << MASTER_DIV_SHIFT);
>> +=A0=A0=A0 mckr |=3D (div << MASTER_DIV_SHIFT);
>> +=A0=A0=A0 ret =3D regmap_write(master->regmap, master->layout->offset, =
mckr);
>> +=A0=A0=A0 if (ret)
>> +=A0=A0=A0=A0=A0=A0=A0 goto unlock;
>> +
>> =A0=A0=A0=A0=A0 while (!clk_master_ready(master))
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_relax();
>> +unlock:
>> =A0=A0=A0=A0=A0 spin_unlock_irqrestore(master->lock, flags);
>> =A0 =A0=A0=A0=A0=A0 return 0;
>> @@ -197,12 +255,25 @@ static int clk_master_div_determine_rate(struct
>> clk_hw *hw,
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 +static void clk_master_div_restore_context_chg(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_master *master =3D to_clk_master(hw);
>> +=A0=A0=A0 int ret;
>> +
>> +=A0=A0=A0 ret =3D clk_master_div_set_rate(hw, master->pms.rate,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 master-=
>pms.parent_rate);
>> +=A0=A0=A0 if (ret)
>> +=A0=A0=A0=A0=A0=A0=A0 pr_warn("Failed to restore MCK DIV clock\n");
>> +}
>> +
>> =A0 static const struct clk_ops master_div_ops_chg =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D clk_master_prepare,
>> =A0=A0=A0=A0=A0 .is_prepared =3D clk_master_is_prepared,
>> =A0=A0=A0=A0=A0 .recalc_rate =3D clk_master_div_recalc_rate,
>> =A0=A0=A0=A0=A0 .determine_rate =3D clk_master_div_determine_rate,
>> =A0=A0=A0=A0=A0 .set_rate =3D clk_master_div_set_rate,
>> +=A0=A0=A0 .save_context =3D clk_master_div_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_master_div_restore_context_chg,
>> =A0 };
>> =A0 =A0 static void clk_sama7g5_master_best_diff(struct clk_rate_request=
 *req,
>> @@ -272,7 +343,8 @@ static int clk_master_pres_set_rate(struct clk_hw
>> *hw, unsigned long rate,
>> =A0 {
>> =A0=A0=A0=A0=A0 struct clk_master *master =3D to_clk_master(hw);
>> =A0=A0=A0=A0=A0 unsigned long flags;
>> -=A0=A0=A0 unsigned int pres;
>> +=A0=A0=A0 unsigned int pres, val;
>> +=A0=A0=A0 int ret;
>> =A0 =A0=A0=A0=A0=A0 pres =3D DIV_ROUND_CLOSEST(parent_rate, rate);
>> =A0=A0=A0=A0=A0 if (pres > MASTER_PRES_MAX)
>> @@ -284,15 +356,24 @@ static int clk_master_pres_set_rate(struct clk_hw
>> *hw, unsigned long rate,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 pres =3D ffs(pres) - 1;
>> =A0 =A0=A0=A0=A0=A0 spin_lock_irqsave(master->lock, flags);
>> +=A0=A0=A0 ret =3D regmap_read(master->regmap, master->layout->offset, &=
val);
>> +=A0=A0=A0 if (ret)
>> +=A0=A0=A0=A0=A0=A0=A0 goto unlock;
>> +
>> +=A0=A0=A0 val =3D (val >> master->layout->pres_shift) & MASTER_PRES_MAS=
K;
>> +=A0=A0=A0 if (pres =3D=3D val)
>> +=A0=A0=A0=A0=A0=A0=A0 goto unlock;
>> +
>> =A0=A0=A0=A0=A0 regmap_update_bits(master->regmap, master->layout->offse=
t,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (MASTER_PRES_MASK << ma=
ster->layout->pres_shift),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (pres << master->layout=
->pres_shift));
>> =A0 =A0=A0=A0=A0=A0 while (!clk_master_ready(master))
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_relax();
>> +unlock:
>> =A0=A0=A0=A0=A0 spin_unlock_irqrestore(master->lock, flags);
>> =A0 -=A0=A0=A0 return 0;
>> +=A0=A0=A0 return ret;
>> =A0 }
>> =A0 =A0 static unsigned long clk_master_pres_recalc_rate(struct clk_hw *=
hw,
>> @@ -330,11 +411,66 @@ static u8 clk_master_pres_get_parent(struct clk_hw
>> *hw)
>> =A0=A0=A0=A0=A0 return mckr & AT91_PMC_CSS;
>> =A0 }
>> =A0 +static int clk_master_pres_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_master *master =3D to_clk_master(hw);
>> +=A0=A0=A0 struct clk_hw *parent_hw =3D clk_hw_get_parent(hw);
>> +=A0=A0=A0 unsigned long flags;
>> +=A0=A0=A0 unsigned int val, pres;
>> +
>> +=A0=A0=A0 spin_lock_irqsave(master->lock, flags);
>> +=A0=A0=A0 regmap_read(master->regmap, master->layout->offset, &val);
>> +=A0=A0=A0 spin_unlock_irqrestore(master->lock, flags);
>> +
>> +=A0=A0=A0 pres =3D (val >> master->layout->pres_shift) & MASTER_PRES_MA=
SK;
>> +=A0=A0=A0 if (pres =3D=3D 3 && master->characteristics->have_div3_pres)
>> +=A0=A0=A0=A0=A0=A0=A0 pres =3D 3;
>> +=A0=A0=A0 else
>> +=A0=A0=A0=A0=A0=A0=A0 pres =3D (1 << pres);
>> +
>> +=A0=A0=A0 master->pms.parent =3D val & AT91_PMC_CSS;
>> +=A0=A0=A0 master->pms.parent_rate =3D clk_hw_get_rate(parent_hw);
>> +=A0=A0=A0 master->pms.rate =3D DIV_ROUND_CLOSEST_ULL(master->pms.parent=
_rate,
>> pres);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_master_pres_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_master *master =3D to_clk_master(hw);
>> +=A0=A0=A0 unsigned long flags;
>> +=A0=A0=A0 unsigned int val, pres;
>> +
>> +=A0=A0=A0 spin_lock_irqsave(master->lock, flags);
>> +=A0=A0=A0 regmap_read(master->regmap, master->layout->offset, &val);
>> +=A0=A0=A0 spin_unlock_irqrestore(master->lock, flags);
>> +
>> +=A0=A0=A0 pres =3D (val >> master->layout->pres_shift) & MASTER_PRES_MA=
SK;
>> +=A0=A0=A0 if (pres =3D=3D 3 && master->characteristics->have_div3_pres)
>> +=A0=A0=A0=A0=A0=A0=A0 pres =3D 3;
>> +=A0=A0=A0 else
>> +=A0=A0=A0=A0=A0=A0=A0 pres =3D (1 << pres);
>> +
>> +=A0=A0=A0 if ((master->pms.rate !=3D
>> +=A0=A0=A0=A0=A0=A0=A0=A0 DIV_ROUND_CLOSEST_ULL(master->pms.parent_rate,=
 pres)) ||
>> +=A0=A0=A0=A0=A0=A0=A0 (master->pms.parent !=3D (val & AT91_PMC_CSS)))
>> +=A0=A0=A0=A0=A0=A0=A0 pr_warn("MCKR PRES was not configured properly by=
 firmware!\n");
>=20
> Same here: it's restored by bootloader, right?

Yes!

>=20
>> +}
>> +
>> +static void clk_master_pres_restore_context_chg(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_master *master =3D to_clk_master(hw);
>> +
>> +=A0=A0=A0 clk_master_pres_set_rate(hw, master->pms.rate,
>> master->pms.parent_rate);
>> +}
>> +
>> =A0 static const struct clk_ops master_pres_ops =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D clk_master_prepare,
>> =A0=A0=A0=A0=A0 .is_prepared =3D clk_master_is_prepared,
>> =A0=A0=A0=A0=A0 .recalc_rate =3D clk_master_pres_recalc_rate,
>> =A0=A0=A0=A0=A0 .get_parent =3D clk_master_pres_get_parent,
>> +=A0=A0=A0 .save_context =3D clk_master_pres_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_master_pres_restore_context,
>> =A0 };
>> =A0 =A0 static const struct clk_ops master_pres_ops_chg =3D {
>> @@ -344,6 +480,8 @@ static const struct clk_ops master_pres_ops_chg =3D =
{
>> =A0=A0=A0=A0=A0 .recalc_rate =3D clk_master_pres_recalc_rate,
>> =A0=A0=A0=A0=A0 .get_parent =3D clk_master_pres_get_parent,
>> =A0=A0=A0=A0=A0 .set_rate =3D clk_master_pres_set_rate,
>> +=A0=A0=A0 .save_context =3D clk_master_pres_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_master_pres_restore_context_chg,
>> =A0 };
>> =A0 =A0 static struct clk_hw * __init
>> @@ -539,9 +677,9 @@ static int clk_sama7g5_master_set_parent(struct
>> clk_hw *hw, u8 index)
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 -static int clk_sama7g5_master_enable(struct clk_hw *hw)
>> +static void clk_sama7g5_master_set(struct clk_master *master,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int sta=
tus)
>> =A0 {
>> -=A0=A0=A0 struct clk_master *master =3D to_clk_master(hw);
>> =A0=A0=A0=A0=A0 unsigned long flags;
>> =A0=A0=A0=A0=A0 unsigned int val, cparent;
>> =A0 @@ -550,9 +688,10 @@ static int clk_sama7g5_master_enable(struct clk=
_hw
>> *hw)
>> =A0=A0=A0=A0=A0 regmap_write(master->regmap, PMC_MCR, PMC_MCR_ID(master-=
>id));
>> =A0=A0=A0=A0=A0 regmap_read(master->regmap, PMC_MCR, &val);
>> =A0=A0=A0=A0=A0 regmap_update_bits(master->regmap, PMC_MCR,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PMC_MCR_EN | PMC_MCR_CSS | P=
MC_MCR_DIV |
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (status ? PMC_MCR_EN : 0) | =
PMC_MCR_CSS | PMC_MCR_DIV |
>=20
> Ditto
>=20
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PMC_MCR_CMD | PMC_MCR_I=
D_MSK,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PMC_MCR_EN | (master->parent=
 << PMC_MCR_CSS_SHIFT) |
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (status ? PMC_MCR_EN : 0) |
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (master->parent << PMC_MCR_C=
SS_SHIFT) |
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (master->div << MASTER_=
DIV_SHIFT) |
>=20
> Ditto
>=20
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PMC_MCR_CMD | PMC_MCR_I=
D(master->id));
>=20
> This whole line becomes hardly readable.

It is what previously has been used except the adition of status variable.
All the values passed to regmap_update_bits() needs to be there for proper
functionality. The clk_sama7g5_master_set() has been added to use the same
function, namely clk_sama7g5_master_set(), in .enable, .disable,
.save_context, .restore_context APIs.

Would you prefer using another local variable to store the conditional
checking of status variable:

unsigned int x =3D status ? PMC_MCR_EN : 0;

?

Thank you for your review,
Claudiu

>=20
>> =A0 @@ -563,6 +702,13 @@ static int clk_sama7g5_master_enable(struct clk=
_hw
>> *hw)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_relax();
>> =A0 =A0=A0=A0=A0=A0 spin_unlock_irqrestore(master->lock, flags);
>> +}
>> +
>> +static int clk_sama7g5_master_enable(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_master *master =3D to_clk_master(hw);
>> +
>> +=A0=A0=A0 clk_sama7g5_master_set(master, 1);
>> =A0 =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> @@ -620,6 +766,23 @@ static int clk_sama7g5_master_set_rate(struct clk_h=
w
>> *hw, unsigned long rate,
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 +static int clk_sama7g5_master_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_master *master =3D to_clk_master(hw);
>> +
>> +=A0=A0=A0 master->pms.status =3D clk_sama7g5_master_is_enabled(hw);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_sama7g5_master_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_master *master =3D to_clk_master(hw);
>> +
>> +=A0=A0=A0 if (master->pms.status)
>> +=A0=A0=A0=A0=A0=A0=A0 clk_sama7g5_master_set(master, master->pms.status=
);
>> +}
>> +
>> =A0 static const struct clk_ops sama7g5_master_ops =3D {
>> =A0=A0=A0=A0=A0 .enable =3D clk_sama7g5_master_enable,
>> =A0=A0=A0=A0=A0 .disable =3D clk_sama7g5_master_disable,
>> @@ -629,6 +792,8 @@ static const struct clk_ops sama7g5_master_ops =3D {
>> =A0=A0=A0=A0=A0 .set_rate =3D clk_sama7g5_master_set_rate,
>> =A0=A0=A0=A0=A0 .get_parent =3D clk_sama7g5_master_get_parent,
>> =A0=A0=A0=A0=A0 .set_parent =3D clk_sama7g5_master_set_parent,
>> +=A0=A0=A0 .save_context =3D clk_sama7g5_master_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_sama7g5_master_restore_context,
>> =A0 };
>> =A0 =A0 struct clk_hw * __init
>> diff --git a/drivers/clk/at91/clk-peripheral.c
>> b/drivers/clk/at91/clk-peripheral.c
>> index 7a27ba8e0577..bf088cd06225 100644
>> --- a/drivers/clk/at91/clk-peripheral.c
>> +++ b/drivers/clk/at91/clk-peripheral.c
>> @@ -37,6 +37,7 @@ struct clk_sam9x5_peripheral {
>> =A0=A0=A0=A0=A0 u32 id;
>> =A0=A0=A0=A0=A0 u32 div;
>> =A0=A0=A0=A0=A0 const struct clk_pcr_layout *layout;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0=A0=A0=A0=A0 bool auto_div;
>> =A0=A0=A0=A0=A0 int chg_pid;
>> =A0 };
>> @@ -155,9 +156,9 @@ static void clk_sam9x5_peripheral_autodiv(struct
>> clk_sam9x5_peripheral *periph)
>> =A0=A0=A0=A0=A0 periph->div =3D shift;
>> =A0 }
>> =A0 -static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
>> +static int clk_sam9x5_peripheral_set(struct clk_sam9x5_peripheral *peri=
ph,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned i=
nt status)
>> =A0 {
>> -=A0=A0=A0 struct clk_sam9x5_peripheral *periph =3D to_clk_sam9x5_periph=
eral(hw);
>> =A0=A0=A0=A0=A0 unsigned long flags;
>> =A0 =A0=A0=A0=A0=A0 if (periph->id < PERIPHERAL_ID_MIN)
>> @@ -168,15 +169,22 @@ static int clk_sam9x5_peripheral_enable(struct
>> clk_hw *hw)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (periph->id & periph->layout-=
>pid_mask));
>> =A0=A0=A0=A0=A0 regmap_update_bits(periph->regmap, periph->layout->offse=
t,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 periph->layout->div_mas=
k | periph->layout->cmd |
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AT91_PMC_PCR_EN,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (status ? AT91_PMC_PCR_EN : =
0),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 field_prep(periph->layo=
ut->div_mask, periph->div) |
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 periph->layout->cmd |
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AT91_PMC_PCR_EN);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (status ? AT91_PMC_PCR_EN : =
0));
>=20
> Ditto
>=20
>> =A0=A0=A0=A0=A0 spin_unlock_irqrestore(periph->lock, flags);
>> =A0 =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 +static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_sam9x5_peripheral *periph =3D to_clk_sam9x5_periph=
eral(hw);
>> +
>> +=A0=A0=A0 return clk_sam9x5_peripheral_set(periph, 1);
>> +}
>> +
>> =A0 static void clk_sam9x5_peripheral_disable(struct clk_hw *hw)
>> =A0 {
>> =A0=A0=A0=A0=A0 struct clk_sam9x5_peripheral *periph =3D to_clk_sam9x5_p=
eripheral(hw);
>> @@ -393,6 +401,23 @@ static int clk_sam9x5_peripheral_set_rate(struct
>> clk_hw *hw,
>> =A0=A0=A0=A0=A0 return -EINVAL;
>> =A0 }
>> =A0 +static int clk_sam9x5_peripheral_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_sam9x5_peripheral *periph =3D to_clk_sam9x5_periph=
eral(hw);
>> +
>> +=A0=A0=A0 periph->pms.status =3D clk_sam9x5_peripheral_is_enabled(hw);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_sam9x5_peripheral_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_sam9x5_peripheral *periph =3D to_clk_sam9x5_periph=
eral(hw);
>> +
>> +=A0=A0=A0 if (periph->pms.status)
>> +=A0=A0=A0=A0=A0=A0=A0 clk_sam9x5_peripheral_set(periph, periph->pms.sta=
tus);
>> +}
>> +
>> =A0 static const struct clk_ops sam9x5_peripheral_ops =3D {
>> =A0=A0=A0=A0=A0 .enable =3D clk_sam9x5_peripheral_enable,
>> =A0=A0=A0=A0=A0 .disable =3D clk_sam9x5_peripheral_disable,
>> @@ -400,6 +425,8 @@ static const struct clk_ops sam9x5_peripheral_ops =
=3D {
>> =A0=A0=A0=A0=A0 .recalc_rate =3D clk_sam9x5_peripheral_recalc_rate,
>> =A0=A0=A0=A0=A0 .round_rate =3D clk_sam9x5_peripheral_round_rate,
>> =A0=A0=A0=A0=A0 .set_rate =3D clk_sam9x5_peripheral_set_rate,
>> +=A0=A0=A0 .save_context =3D clk_sam9x5_peripheral_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_sam9x5_peripheral_restore_context,
>> =A0 };
>> =A0 =A0 static const struct clk_ops sam9x5_peripheral_chg_ops =3D {
>> @@ -409,6 +436,8 @@ static const struct clk_ops sam9x5_peripheral_chg_op=
s
>> =3D {
>> =A0=A0=A0=A0=A0 .recalc_rate =3D clk_sam9x5_peripheral_recalc_rate,
>> =A0=A0=A0=A0=A0 .determine_rate =3D clk_sam9x5_peripheral_determine_rate=
,
>> =A0=A0=A0=A0=A0 .set_rate =3D clk_sam9x5_peripheral_set_rate,
>> +=A0=A0=A0 .save_context =3D clk_sam9x5_peripheral_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_sam9x5_peripheral_restore_context,
>> =A0 };
>> =A0 =A0 struct clk_hw * __init
>> @@ -460,7 +489,6 @@ at91_clk_register_sam9x5_peripheral(struct regmap
>> *regmap, spinlock_t *lock,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 hw =3D ERR_PTR(ret);
>> =A0=A0=A0=A0=A0 } else {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 clk_sam9x5_peripheral_autodiv(periph);
>> -=A0=A0=A0=A0=A0=A0=A0 pmc_register_id(id);
>> =A0=A0=A0=A0=A0 }
>> =A0 =A0=A0=A0=A0=A0 return hw;
>> diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
>> index 6ed986d3eee0..31964622c658 100644
>> --- a/drivers/clk/at91/clk-pll.c
>> +++ b/drivers/clk/at91/clk-pll.c
>> @@ -40,6 +40,7 @@ struct clk_pll {
>> =A0=A0=A0=A0=A0 u16 mul;
>> =A0=A0=A0=A0=A0 const struct clk_pll_layout *layout;
>> =A0=A0=A0=A0=A0 const struct clk_pll_characteristics *characteristics;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0 };
>> =A0 =A0 static inline bool clk_pll_ready(struct regmap *regmap, int id)
>> @@ -260,6 +261,40 @@ static int clk_pll_set_rate(struct clk_hw *hw,
>> unsigned long rate,
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 +static int clk_pll_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_pll *pll =3D to_clk_pll(hw);
>> +=A0=A0=A0 struct clk_hw *parent_hw =3D clk_hw_get_parent(hw);
>> +
>> +=A0=A0=A0 pll->pms.parent_rate =3D clk_hw_get_rate(parent_hw);
>> +=A0=A0=A0 pll->pms.rate =3D clk_pll_recalc_rate(&pll->hw, pll->pms.pare=
nt_rate);
>> +=A0=A0=A0 pll->pms.status =3D clk_pll_ready(pll->regmap, PLL_REG(pll->i=
d));
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_pll_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_pll *pll =3D to_clk_pll(hw);
>> +=A0=A0=A0 unsigned long calc_rate;
>> +=A0=A0=A0 unsigned int pllr;
>> +=A0=A0=A0 u8 out =3D 0;
>> +
>> +=A0=A0=A0 if (pll->characteristics->out)
>> +=A0=A0=A0=A0=A0=A0=A0 out =3D pll->characteristics->out[pll->range];
>> +
>> +=A0=A0=A0 regmap_read(pll->regmap, PLL_REG(pll->id), &pllr);
>> +
>> +=A0=A0=A0 calc_rate =3D (pll->pms.parent_rate / PLL_DIV(pllr)) *
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (PLL_MUL(pllr, pll->layout) + 1);
>> +
>> +=A0=A0=A0 if (pll->pms.rate !=3D calc_rate ||
>> +=A0=A0=A0=A0=A0=A0=A0 pll->pms.status !=3D clk_pll_ready(pll->regmap, P=
LL_REG(pll->id)) ||
>> +=A0=A0=A0=A0=A0=A0=A0 (((pllr >> PLL_COUNT_SHIFT) & PLL_MAX_COUNT) !=3D=
 PLL_MAX_COUNT) ||
>> +=A0=A0=A0=A0=A0=A0=A0 (out && ((pllr >> PLL_OUT_SHIFT) & out) !=3D out)=
)
>> +=A0=A0=A0=A0=A0=A0=A0 pr_warn("PLLAR was not configured properly by fir=
mware\n");
>> +}
>> +
>> =A0 static const struct clk_ops pll_ops =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D clk_pll_prepare,
>> =A0=A0=A0=A0=A0 .unprepare =3D clk_pll_unprepare,
>> @@ -267,6 +302,8 @@ static const struct clk_ops pll_ops =3D {
>> =A0=A0=A0=A0=A0 .recalc_rate =3D clk_pll_recalc_rate,
>> =A0=A0=A0=A0=A0 .round_rate =3D clk_pll_round_rate,
>> =A0=A0=A0=A0=A0 .set_rate =3D clk_pll_set_rate,
>> +=A0=A0=A0 .save_context =3D clk_pll_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_pll_restore_context,
>> =A0 };
>> =A0 =A0 struct clk_hw * __init
>> diff --git a/drivers/clk/at91/clk-programmable.c
>> b/drivers/clk/at91/clk-programmable.c
>> index fcf8f6a1c2c6..6c4b259d31d3 100644
>> --- a/drivers/clk/at91/clk-programmable.c
>> +++ b/drivers/clk/at91/clk-programmable.c
>> @@ -24,6 +24,7 @@ struct clk_programmable {
>> =A0=A0=A0=A0=A0 u32 *mux_table;
>> =A0=A0=A0=A0=A0 u8 id;
>> =A0=A0=A0=A0=A0 const struct clk_programmable_layout *layout;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0 };
>> =A0 =A0 #define to_clk_programmable(hw) container_of(hw, struct
>> clk_programmable, hw)
>> @@ -177,12 +178,38 @@ static int clk_programmable_set_rate(struct clk_hw
>> *hw, unsigned long rate,
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 +static int clk_programmable_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_programmable *prog =3D to_clk_programmable(hw);
>> +=A0=A0=A0 struct clk_hw *parent_hw =3D clk_hw_get_parent(hw);
>> +
>> +=A0=A0=A0 prog->pms.parent =3D clk_programmable_get_parent(hw);
>> +=A0=A0=A0 prog->pms.parent_rate =3D clk_hw_get_rate(parent_hw);
>> +=A0=A0=A0 prog->pms.rate =3D clk_programmable_recalc_rate(hw,
>> prog->pms.parent_rate);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_programmable_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_programmable *prog =3D to_clk_programmable(hw);
>> +=A0=A0=A0 int ret;
>> +
>> +=A0=A0=A0 ret =3D clk_programmable_set_parent(hw, prog->pms.parent);
>> +=A0=A0=A0 if (ret)
>> +=A0=A0=A0=A0=A0=A0=A0 return;
>> +
>> +=A0=A0=A0 clk_programmable_set_rate(hw, prog->pms.rate, prog->pms.paren=
t_rate);
>> +}
>> +
>> =A0 static const struct clk_ops programmable_ops =3D {
>> =A0=A0=A0=A0=A0 .recalc_rate =3D clk_programmable_recalc_rate,
>> =A0=A0=A0=A0=A0 .determine_rate =3D clk_programmable_determine_rate,
>> =A0=A0=A0=A0=A0 .get_parent =3D clk_programmable_get_parent,
>> =A0=A0=A0=A0=A0 .set_parent =3D clk_programmable_set_parent,
>> =A0=A0=A0=A0=A0 .set_rate =3D clk_programmable_set_rate,
>> +=A0=A0=A0 .save_context =3D clk_programmable_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_programmable_restore_context,
>> =A0 };
>> =A0 =A0 struct clk_hw * __init
>> @@ -221,8 +248,6 @@ at91_clk_register_programmable(struct regmap *regmap=
,
>> =A0=A0=A0=A0=A0 if (ret) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(prog);
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 hw =3D ERR_PTR(ret);
>> -=A0=A0=A0 } else {
>> -=A0=A0=A0=A0=A0=A0=A0 pmc_register_pck(id);
>> =A0=A0=A0=A0=A0 }
>> =A0 =A0=A0=A0=A0=A0 return hw;
>> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c
>> b/drivers/clk/at91/clk-sam9x60-pll.c
>> index 34e3ab13741a..7020d3bf6e13 100644
>> --- a/drivers/clk/at91/clk-sam9x60-pll.c
>> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
>> @@ -38,12 +38,14 @@ struct sam9x60_pll_core {
>> =A0 =A0 struct sam9x60_frac {
>> =A0=A0=A0=A0=A0 struct sam9x60_pll_core core;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0=A0=A0=A0=A0 u32 frac;
>> =A0=A0=A0=A0=A0 u16 mul;
>> =A0 };
>> =A0 =A0 struct sam9x60_div {
>> =A0=A0=A0=A0=A0 struct sam9x60_pll_core core;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0=A0=A0=A0=A0 u8 div;
>> =A0 };
>> =A0 @@ -75,9 +77,8 @@ static unsigned long
>> sam9x60_frac_pll_recalc_rate(struct clk_hw *hw,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 ((u64)parent_rate * frac->frac >> 22));
>> =A0 }
>> =A0 -static int sam9x60_frac_pll_prepare(struct clk_hw *hw)
>> +static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
>> =A0 {
>> -=A0=A0=A0 struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw);
>> =A0=A0=A0=A0=A0 struct sam9x60_frac *frac =3D to_sam9x60_frac(core);
>> =A0=A0=A0=A0=A0 struct regmap *regmap =3D core->regmap;
>> =A0=A0=A0=A0=A0 unsigned int val, cfrac, cmul;
>> @@ -141,6 +142,13 @@ static int sam9x60_frac_pll_prepare(struct clk_hw *=
hw)
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 +static int sam9x60_frac_pll_prepare(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw);
>> +
>> +=A0=A0=A0 return sam9x60_frac_pll_set(core);
>> +}
>> +
>> =A0 static void sam9x60_frac_pll_unprepare(struct clk_hw *hw)
>> =A0 {
>> =A0=A0=A0=A0=A0 struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw=
);
>> @@ -280,6 +288,25 @@ static int sam9x60_frac_pll_set_rate_chg(struct
>> clk_hw *hw, unsigned long rate,
>> =A0=A0=A0=A0=A0 return ret;
>> =A0 }
>> =A0 +static int sam9x60_frac_pll_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw);
>> +=A0=A0=A0 struct sam9x60_frac *frac =3D to_sam9x60_frac(core);
>> +
>> +=A0=A0=A0 frac->pms.status =3D sam9x60_pll_ready(core->regmap, core->id=
);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void sam9x60_frac_pll_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw);
>> +=A0=A0=A0 struct sam9x60_frac *frac =3D to_sam9x60_frac(core);
>> +
>> +=A0=A0=A0 if (frac->pms.status)
>> +=A0=A0=A0=A0=A0=A0=A0 sam9x60_frac_pll_set(core);
>> +}
>> +
>> =A0 static const struct clk_ops sam9x60_frac_pll_ops =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D sam9x60_frac_pll_prepare,
>> =A0=A0=A0=A0=A0 .unprepare =3D sam9x60_frac_pll_unprepare,
>> @@ -287,6 +314,8 @@ static const struct clk_ops sam9x60_frac_pll_ops =3D=
 {
>> =A0=A0=A0=A0=A0 .recalc_rate =3D sam9x60_frac_pll_recalc_rate,
>> =A0=A0=A0=A0=A0 .round_rate =3D sam9x60_frac_pll_round_rate,
>> =A0=A0=A0=A0=A0 .set_rate =3D sam9x60_frac_pll_set_rate,
>> +=A0=A0=A0 .save_context =3D sam9x60_frac_pll_save_context,
>> +=A0=A0=A0 .restore_context =3D sam9x60_frac_pll_restore_context,
>> =A0 };
>> =A0 =A0 static const struct clk_ops sam9x60_frac_pll_ops_chg =3D {
>> @@ -296,11 +325,12 @@ static const struct clk_ops
>> sam9x60_frac_pll_ops_chg =3D {
>> =A0=A0=A0=A0=A0 .recalc_rate =3D sam9x60_frac_pll_recalc_rate,
>> =A0=A0=A0=A0=A0 .round_rate =3D sam9x60_frac_pll_round_rate,
>> =A0=A0=A0=A0=A0 .set_rate =3D sam9x60_frac_pll_set_rate_chg,
>> +=A0=A0=A0 .save_context =3D sam9x60_frac_pll_save_context,
>> +=A0=A0=A0 .restore_context =3D sam9x60_frac_pll_restore_context,
>> =A0 };
>> =A0 -static int sam9x60_div_pll_prepare(struct clk_hw *hw)
>> +static int sam9x60_div_pll_set(struct sam9x60_pll_core *core)
>> =A0 {
>> -=A0=A0=A0 struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw);
>> =A0=A0=A0=A0=A0 struct sam9x60_div *div =3D to_sam9x60_div(core);
>> =A0=A0=A0=A0=A0 struct regmap *regmap =3D core->regmap;
>> =A0=A0=A0=A0=A0 unsigned long flags;
>> @@ -334,6 +364,13 @@ static int sam9x60_div_pll_prepare(struct clk_hw *h=
w)
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 +static int sam9x60_div_pll_prepare(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw);
>> +
>> +=A0=A0=A0 return sam9x60_div_pll_set(core);
>> +}
>> +
>> =A0 static void sam9x60_div_pll_unprepare(struct clk_hw *hw)
>> =A0 {
>> =A0=A0=A0=A0=A0 struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw=
);
>> @@ -482,6 +519,25 @@ static int sam9x60_div_pll_set_rate_chg(struct
>> clk_hw *hw, unsigned long rate,
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 +static int sam9x60_div_pll_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw);
>> +=A0=A0=A0 struct sam9x60_div *div =3D to_sam9x60_div(core);
>> +
>> +=A0=A0=A0 div->pms.status =3D sam9x60_div_pll_is_prepared(hw);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void sam9x60_div_pll_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw);
>> +=A0=A0=A0 struct sam9x60_div *div =3D to_sam9x60_div(core);
>> +
>> +=A0=A0=A0 if (div->pms.status)
>> +=A0=A0=A0=A0=A0=A0=A0 sam9x60_div_pll_set(core);
>> +}
>> +
>> =A0 static const struct clk_ops sam9x60_div_pll_ops =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D sam9x60_div_pll_prepare,
>> =A0=A0=A0=A0=A0 .unprepare =3D sam9x60_div_pll_unprepare,
>> @@ -489,6 +545,8 @@ static const struct clk_ops sam9x60_div_pll_ops =3D =
{
>> =A0=A0=A0=A0=A0 .recalc_rate =3D sam9x60_div_pll_recalc_rate,
>> =A0=A0=A0=A0=A0 .round_rate =3D sam9x60_div_pll_round_rate,
>> =A0=A0=A0=A0=A0 .set_rate =3D sam9x60_div_pll_set_rate,
>> +=A0=A0=A0 .save_context =3D sam9x60_div_pll_save_context,
>> +=A0=A0=A0 .restore_context =3D sam9x60_div_pll_restore_context,
>> =A0 };
>> =A0 =A0 static const struct clk_ops sam9x60_div_pll_ops_chg =3D {
>> @@ -498,6 +556,8 @@ static const struct clk_ops sam9x60_div_pll_ops_chg =
=3D {
>> =A0=A0=A0=A0=A0 .recalc_rate =3D sam9x60_div_pll_recalc_rate,
>> =A0=A0=A0=A0=A0 .round_rate =3D sam9x60_div_pll_round_rate,
>> =A0=A0=A0=A0=A0 .set_rate =3D sam9x60_div_pll_set_rate_chg,
>> +=A0=A0=A0 .save_context =3D sam9x60_div_pll_save_context,
>> +=A0=A0=A0 .restore_context =3D sam9x60_div_pll_restore_context,
>> =A0 };
>> =A0 =A0 struct clk_hw * __init
>> diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system=
.c
>> index f83ec0de86c3..80720fd1a9cf 100644
>> --- a/drivers/clk/at91/clk-system.c
>> +++ b/drivers/clk/at91/clk-system.c
>> @@ -20,6 +20,7 @@
>> =A0 struct clk_system {
>> =A0=A0=A0=A0=A0 struct clk_hw hw;
>> =A0=A0=A0=A0=A0 struct regmap *regmap;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0=A0=A0=A0=A0 u8 id;
>> =A0 };
>> =A0 @@ -77,10 +78,29 @@ static int clk_system_is_prepared(struct clk_hw =
*hw)
>> =A0=A0=A0=A0=A0 return !!(status & (1 << sys->id));
>> =A0 }
>> =A0 +static int clk_system_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_system *sys =3D to_clk_system(hw);
>> +
>> +=A0=A0=A0 sys->pms.status =3D clk_system_is_prepared(hw);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_system_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_system *sys =3D to_clk_system(hw);
>> +
>> +=A0=A0=A0 if (sys->pms.status)
>> +=A0=A0=A0=A0=A0=A0=A0 clk_system_prepare(&sys->hw);
>> +}
>> +
>> =A0 static const struct clk_ops system_ops =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D clk_system_prepare,
>> =A0=A0=A0=A0=A0 .unprepare =3D clk_system_unprepare,
>> =A0=A0=A0=A0=A0 .is_prepared =3D clk_system_is_prepared,
>> +=A0=A0=A0 .save_context =3D clk_system_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_system_restore_context,
>> =A0 };
>> =A0 =A0 struct clk_hw * __init
>> diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
>> index 31d5c45e30d7..b0696a928aa9 100644
>> --- a/drivers/clk/at91/clk-usb.c
>> +++ b/drivers/clk/at91/clk-usb.c
>> @@ -24,6 +24,7 @@
>> =A0 struct at91sam9x5_clk_usb {
>> =A0=A0=A0=A0=A0 struct clk_hw hw;
>> =A0=A0=A0=A0=A0 struct regmap *regmap;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0=A0=A0=A0=A0 u32 usbs_mask;
>> =A0=A0=A0=A0=A0 u8 num_parents;
>> =A0 };
>> @@ -148,12 +149,38 @@ static int at91sam9x5_clk_usb_set_rate(struct
>> clk_hw *hw, unsigned long rate,
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 +static int at91sam9x5_usb_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct at91sam9x5_clk_usb *usb =3D to_at91sam9x5_clk_usb(hw);
>> +=A0=A0=A0 struct clk_hw *parent_hw =3D clk_hw_get_parent(hw);
>> +
>> +=A0=A0=A0 usb->pms.parent =3D at91sam9x5_clk_usb_get_parent(hw);
>> +=A0=A0=A0 usb->pms.parent_rate =3D clk_hw_get_rate(parent_hw);
>> +=A0=A0=A0 usb->pms.rate =3D at91sam9x5_clk_usb_recalc_rate(hw,
>> usb->pms.parent_rate);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void at91sam9x5_usb_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct at91sam9x5_clk_usb *usb =3D to_at91sam9x5_clk_usb(hw);
>> +=A0=A0=A0 int ret;
>> +
>> +=A0=A0=A0 ret =3D at91sam9x5_clk_usb_set_parent(hw, usb->pms.parent);
>> +=A0=A0=A0 if (ret)
>> +=A0=A0=A0=A0=A0=A0=A0 return;
>> +
>> +=A0=A0=A0 at91sam9x5_clk_usb_set_rate(hw, usb->pms.rate, usb->pms.paren=
t_rate);
>> +}
>> +
>> =A0 static const struct clk_ops at91sam9x5_usb_ops =3D {
>> =A0=A0=A0=A0=A0 .recalc_rate =3D at91sam9x5_clk_usb_recalc_rate,
>> =A0=A0=A0=A0=A0 .determine_rate =3D at91sam9x5_clk_usb_determine_rate,
>> =A0=A0=A0=A0=A0 .get_parent =3D at91sam9x5_clk_usb_get_parent,
>> =A0=A0=A0=A0=A0 .set_parent =3D at91sam9x5_clk_usb_set_parent,
>> =A0=A0=A0=A0=A0 .set_rate =3D at91sam9x5_clk_usb_set_rate,
>> +=A0=A0=A0 .save_context =3D at91sam9x5_usb_save_context,
>> +=A0=A0=A0 .restore_context =3D at91sam9x5_usb_restore_context,
>> =A0 };
>> =A0 =A0 static int at91sam9n12_clk_usb_enable(struct clk_hw *hw)
>> diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
>> index df9f3fc3b6a6..2b102ee2a7d3 100644
>> --- a/drivers/clk/at91/clk-utmi.c
>> +++ b/drivers/clk/at91/clk-utmi.c
>> @@ -23,6 +23,7 @@ struct clk_utmi {
>> =A0=A0=A0=A0=A0 struct clk_hw hw;
>> =A0=A0=A0=A0=A0 struct regmap *regmap_pmc;
>> =A0=A0=A0=A0=A0 struct regmap *regmap_sfr;
>> +=A0=A0=A0 struct at91_clk_pms pms;
>> =A0 };
>> =A0 =A0 #define to_clk_utmi(hw) container_of(hw, struct clk_utmi, hw)
>> @@ -113,11 +114,30 @@ static unsigned long clk_utmi_recalc_rate(struct
>> clk_hw *hw,
>> =A0=A0=A0=A0=A0 return UTMI_RATE;
>> =A0 }
>> =A0 +static int clk_utmi_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_utmi *utmi =3D to_clk_utmi(hw);
>> +
>> +=A0=A0=A0 utmi->pms.status =3D clk_utmi_is_prepared(hw);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_utmi_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_utmi *utmi =3D to_clk_utmi(hw);
>> +
>> +=A0=A0=A0 if (utmi->pms.status)
>> +=A0=A0=A0=A0=A0=A0=A0 clk_utmi_prepare(hw);
>> +}
>> +
>> =A0 static const struct clk_ops utmi_ops =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D clk_utmi_prepare,
>> =A0=A0=A0=A0=A0 .unprepare =3D clk_utmi_unprepare,
>> =A0=A0=A0=A0=A0 .is_prepared =3D clk_utmi_is_prepared,
>> =A0=A0=A0=A0=A0 .recalc_rate =3D clk_utmi_recalc_rate,
>> +=A0=A0=A0 .save_context =3D clk_utmi_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_utmi_restore_context,
>> =A0 };
>> =A0 =A0 static struct clk_hw * __init
>> @@ -232,10 +252,35 @@ static int clk_utmi_sama7g5_is_prepared(struct
>> clk_hw *hw)
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0 +static unsigned long clk_utmi_sama7g5_recalc_rate(struct clk_hw *hw=
,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 unsigned long parent_rate)
>> +{
>> +=A0=A0=A0 return 480000000;
>> +}
>> +
>> +static int clk_utmi_sama7g5_save_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_utmi *utmi =3D to_clk_utmi(hw);
>> +
>> +=A0=A0=A0 utmi->pms.status =3D clk_utmi_sama7g5_is_prepared(hw);
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static void clk_utmi_sama7g5_restore_context(struct clk_hw *hw)
>> +{
>> +=A0=A0=A0 struct clk_utmi *utmi =3D to_clk_utmi(hw);
>> +
>> +=A0=A0=A0 if (utmi->pms.status)
>> +=A0=A0=A0=A0=A0=A0=A0 clk_utmi_sama7g5_prepare(hw);
>> +}
>> +
>> =A0 static const struct clk_ops sama7g5_utmi_ops =3D {
>> =A0=A0=A0=A0=A0 .prepare =3D clk_utmi_sama7g5_prepare,
>> =A0=A0=A0=A0=A0 .is_prepared =3D clk_utmi_sama7g5_is_prepared,
>> -=A0=A0=A0 .recalc_rate =3D clk_utmi_recalc_rate,
>> +=A0=A0=A0 .recalc_rate =3D clk_utmi_sama7g5_recalc_rate,
>> +=A0=A0=A0 .save_context =3D clk_utmi_sama7g5_save_context,
>> +=A0=A0=A0 .restore_context =3D clk_utmi_sama7g5_restore_context,
>> =A0 };
>> =A0 =A0 struct clk_hw * __init
>> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
>> index 20ee9dccee78..77b57c9f5dcb 100644
>> --- a/drivers/clk/at91/pmc.c
>> +++ b/drivers/clk/at91/pmc.c
>> @@ -3,6 +3,7 @@
>> =A0=A0 *=A0 Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
>> =A0=A0 */
>> =A0 +#include <linux/clk.h>
>> =A0 #include <linux/clk-provider.h>
>> =A0 #include <linux/clkdev.h>
>> =A0 #include <linux/clk/at91_pmc.h>
>> @@ -14,8 +15,6 @@
>> =A0 =A0 #include <asm/proc-fns.h>
>> =A0 -#include <dt-bindings/clock/at91.h>
>> -
>> =A0 #include "pmc.h"
>> =A0 =A0 #define PMC_MAX_IDS 128
>> @@ -111,147 +110,19 @@ struct pmc_data *pmc_data_allocate(unsigned int
>> ncore, unsigned int nsystem,
>> =A0 }
>> =A0 =A0 #ifdef CONFIG_PM
>> -static struct regmap *pmcreg;
>> -
>> -static u8 registered_ids[PMC_MAX_IDS];
>> -static u8 registered_pcks[PMC_MAX_PCKS];
>> -
>> -static struct
>> -{
>> -=A0=A0=A0 u32 scsr;
>> -=A0=A0=A0 u32 pcsr0;
>> -=A0=A0=A0 u32 uckr;
>> -=A0=A0=A0 u32 mor;
>> -=A0=A0=A0 u32 mcfr;
>> -=A0=A0=A0 u32 pllar;
>> -=A0=A0=A0 u32 mckr;
>> -=A0=A0=A0 u32 usb;
>> -=A0=A0=A0 u32 imr;
>> -=A0=A0=A0 u32 pcsr1;
>> -=A0=A0=A0 u32 pcr[PMC_MAX_IDS];
>> -=A0=A0=A0 u32 audio_pll0;
>> -=A0=A0=A0 u32 audio_pll1;
>> -=A0=A0=A0 u32 pckr[PMC_MAX_PCKS];
>> -} pmc_cache;
>> -
>> -/*
>> - * As Peripheral ID 0 is invalid on AT91 chips, the identifier is store=
d
>> - * without alteration in the table, and 0 is for unused clocks.
>> - */
>> -void pmc_register_id(u8 id)
>> -{
>> -=A0=A0=A0 int i;
>> -
>> -=A0=A0=A0 for (i =3D 0; i < PMC_MAX_IDS; i++) {
>> -=A0=A0=A0=A0=A0=A0=A0 if (registered_ids[i] =3D=3D 0) {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 registered_ids[i] =3D id;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> -=A0=A0=A0=A0=A0=A0=A0 }
>> -=A0=A0=A0=A0=A0=A0=A0 if (registered_ids[i] =3D=3D id)
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> -=A0=A0=A0 }
>> -}
>> -
>> -/*
>> - * As Programmable Clock 0 is valid on AT91 chips, there is an offset
>> - * of 1 between the stored value and the real clock ID.
>> - */
>> -void pmc_register_pck(u8 pck)
>> -{
>> -=A0=A0=A0 int i;
>> -
>> -=A0=A0=A0 for (i =3D 0; i < PMC_MAX_PCKS; i++) {
>> -=A0=A0=A0=A0=A0=A0=A0 if (registered_pcks[i] =3D=3D 0) {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 registered_pcks[i] =3D pck + 1;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> -=A0=A0=A0=A0=A0=A0=A0 }
>> -=A0=A0=A0=A0=A0=A0=A0 if (registered_pcks[i] =3D=3D (pck + 1))
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> -=A0=A0=A0 }
>> -}
>> -
>> -static int pmc_suspend(void)
>> +static int at91_pmc_suspend(void)
>> =A0 {
>> -=A0=A0=A0 int i;
>> -=A0=A0=A0 u8 num;
>> -
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_PMC_SCSR, &pmc_cache.scsr);
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_PMC_PCSR, &pmc_cache.pcsr0);
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_CKGR_UCKR, &pmc_cache.uckr);
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_CKGR_MOR, &pmc_cache.mor);
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_CKGR_MCFR, &pmc_cache.mcfr);
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_CKGR_PLLAR, &pmc_cache.pllar);
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_PMC_MCKR, &pmc_cache.mckr);
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_PMC_USB, &pmc_cache.usb);
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_PMC_IMR, &pmc_cache.imr);
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_PMC_PCSR1, &pmc_cache.pcsr1);
>> -
>> -=A0=A0=A0 for (i =3D 0; registered_ids[i]; i++) {
>> -=A0=A0=A0=A0=A0=A0=A0 regmap_write(pmcreg, AT91_PMC_PCR,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (registered_ids[i] & A=
T91_PMC_PCR_PID_MASK));
>> -=A0=A0=A0=A0=A0=A0=A0 regmap_read(pmcreg, AT91_PMC_PCR,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &pmc_cache.pcr[registered=
_ids[i]]);
>> -=A0=A0=A0 }
>> -=A0=A0=A0 for (i =3D 0; registered_pcks[i]; i++) {
>> -=A0=A0=A0=A0=A0=A0=A0 num =3D registered_pcks[i] - 1;
>> -=A0=A0=A0=A0=A0=A0=A0 regmap_read(pmcreg, AT91_PMC_PCKR(num), &pmc_cach=
e.pckr[num]);
>> -=A0=A0=A0 }
>> -
>> -=A0=A0=A0 return 0;
>> +=A0=A0=A0 return clk_save_context();
>> =A0 }
>> =A0 -static bool pmc_ready(unsigned int mask)
>> +static void at91_pmc_resume(void)
>> =A0 {
>> -=A0=A0=A0 unsigned int status;
>> -
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_PMC_SR, &status);
>> -
>> -=A0=A0=A0 return ((status & mask) =3D=3D mask) ? 1 : 0;
>> -}
>> -
>> -static void pmc_resume(void)
>> -{
>> -=A0=A0=A0 int i;
>> -=A0=A0=A0 u8 num;
>> -=A0=A0=A0 u32 tmp;
>> -=A0=A0=A0 u32 mask =3D AT91_PMC_MCKRDY | AT91_PMC_LOCKA;
>> -
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_PMC_MCKR, &tmp);
>> -=A0=A0=A0 if (pmc_cache.mckr !=3D tmp)
>> -=A0=A0=A0=A0=A0=A0=A0 pr_warn("MCKR was not configured properly by the =
firmware\n");
>> -=A0=A0=A0 regmap_read(pmcreg, AT91_CKGR_PLLAR, &tmp);
>> -=A0=A0=A0 if (pmc_cache.pllar !=3D tmp)
>> -=A0=A0=A0=A0=A0=A0=A0 pr_warn("PLLAR was not configured properly by the=
 firmware\n");
>> -
>> -=A0=A0=A0 regmap_write(pmcreg, AT91_PMC_SCER, pmc_cache.scsr);
>> -=A0=A0=A0 regmap_write(pmcreg, AT91_PMC_PCER, pmc_cache.pcsr0);
>> -=A0=A0=A0 regmap_write(pmcreg, AT91_CKGR_UCKR, pmc_cache.uckr);
>> -=A0=A0=A0 regmap_write(pmcreg, AT91_CKGR_MOR, pmc_cache.mor);
>> -=A0=A0=A0 regmap_write(pmcreg, AT91_CKGR_MCFR, pmc_cache.mcfr);
>> -=A0=A0=A0 regmap_write(pmcreg, AT91_PMC_USB, pmc_cache.usb);
>> -=A0=A0=A0 regmap_write(pmcreg, AT91_PMC_IMR, pmc_cache.imr);
>> -=A0=A0=A0 regmap_write(pmcreg, AT91_PMC_PCER1, pmc_cache.pcsr1);
>> -
>> -=A0=A0=A0 for (i =3D 0; registered_ids[i]; i++) {
>> -=A0=A0=A0=A0=A0=A0=A0 regmap_write(pmcreg, AT91_PMC_PCR,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pmc_cache.pcr[register=
ed_ids[i]] |
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AT91_PMC_PCR_CMD);
>> -=A0=A0=A0 }
>> -=A0=A0=A0 for (i =3D 0; registered_pcks[i]; i++) {
>> -=A0=A0=A0=A0=A0=A0=A0 num =3D registered_pcks[i] - 1;
>> -=A0=A0=A0=A0=A0=A0=A0 regmap_write(pmcreg, AT91_PMC_PCKR(num), pmc_cach=
e.pckr[num]);
>> -=A0=A0=A0 }
>> -
>> -=A0=A0=A0 if (pmc_cache.uckr & AT91_PMC_UPLLEN)
>> -=A0=A0=A0=A0=A0=A0=A0 mask |=3D AT91_PMC_LOCKU;
>> -
>> -=A0=A0=A0 while (!pmc_ready(mask))
>> -=A0=A0=A0=A0=A0=A0=A0 cpu_relax();
>> +=A0=A0=A0 clk_restore_context();
>> =A0 }
>=20
> I like how it simplify this part! Good.
>=20
>> =A0 =A0 static struct syscore_ops pmc_syscore_ops =3D {
>> -=A0=A0=A0 .suspend =3D pmc_suspend,
>> -=A0=A0=A0 .resume =3D pmc_resume,
>> +=A0=A0=A0 .suspend =3D at91_pmc_suspend,
>> +=A0=A0=A0 .resume =3D at91_pmc_resume,
>> =A0 };
>> =A0 =A0 static const struct of_device_id sama5d2_pmc_dt_ids[] =3D {
>> @@ -265,12 +136,8 @@ static int __init pmc_register_ops(void)
>> =A0 =A0=A0=A0=A0=A0 np =3D of_find_matching_node(NULL, sama5d2_pmc_dt_id=
s);
>> =A0=A0=A0=A0=A0 if (!np)
>> -=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
>> -
>> -=A0=A0=A0 pmcreg =3D device_node_to_regmap(np);
>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>> =A0=A0=A0=A0=A0 of_node_put(np);
>> -=A0=A0=A0 if (IS_ERR(pmcreg))
>> -=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(pmcreg);
>> =A0 =A0=A0=A0=A0=A0 register_syscore_ops(&pmc_syscore_ops);
>> =A0 diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
>> index a49076c804a9..86580ebd9ad9 100644
>> --- a/drivers/clk/at91/pmc.h
>> +++ b/drivers/clk/at91/pmc.h
>> @@ -13,6 +13,8 @@
>> =A0 #include <linux/regmap.h>
>> =A0 #include <linux/spinlock.h>
>> =A0 +#include <dt-bindings/clock/at91.h>
>> +
>> =A0 extern spinlock_t pmc_pcr_lock;
>> =A0 =A0 struct pmc_data {
>> @@ -98,6 +100,20 @@ struct clk_pcr_layout {
>> =A0=A0=A0=A0=A0 u32 pid_mask;
>> =A0 };
>> =A0 +/**
>> + * struct at91_clk_pms - Power management state for AT91 clock
>> + * @status: clock status (enabled or disabled)
>> + * @parent: clock parent index
>> + * @parent_rate: clock parent rate
>> + * @rate: clock rate
>> + */
>> +struct at91_clk_pms {
>> +=A0=A0=A0 unsigned int status;
>> +=A0=A0=A0 unsigned int parent;
>> +=A0=A0=A0 unsigned long parent_rate;
>> +=A0=A0=A0 unsigned long rate;
>> +};
>> +
>> =A0 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - =
1))
>> =A0 #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_ma=
sk))
>> =A0 @@ -248,12 +264,4 @@ struct clk_hw * __init
>> =A0 at91_clk_sama7g5_register_utmi(struct regmap *regmap, const char *na=
me,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const char =
*parent_name);
>> =A0 -#ifdef CONFIG_PM
>> -void pmc_register_id(u8 id);
>> -void pmc_register_pck(u8 pck);
>> -#else
>> -static inline void pmc_register_id(u8 id) {}
>> -static inline void pmc_register_pck(u8 pck) {}
>> -#endif
>> -
>> =A0 #endif /* __PMC_H_ */
>>
>=20
>=20

