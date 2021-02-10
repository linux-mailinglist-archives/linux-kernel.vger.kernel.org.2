Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65C63160A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhBJILl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:11:41 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:41398 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhBJILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612944677; x=1644480677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q3xZ7Pi62ghugDx/YIn+3pI1NL8JLD9+q03EyO96yaI=;
  b=yEMQzmsMTuNsoJe+OU8fO7qTnUqQk0yAXtCMm6Pygv/LMMHzjquz+6S4
   n80W9RZVPigbMya9xV4IiiAXnphqh1uo6kal9WZEwFgNSGhUtNL/wqk0M
   TA8C5+c5WvUf9TyIIvehfcf4zmmFBu9cEm1Jmfn9DZkPszIuhn1cak9IR
   n0V370XdLB0y4chdhD6ntPWdoO17+lNzz4q/79V5K3iTbphDlP4NDJvRh
   SSy7zfwvHatg080yCftMfXHJEGlvoXQSNJVM3hQcowL+5KBvWvjjf6Fwa
   8e2OBxr9drsKSaqPpDCQ7N7jJn7JkErBr+3MtxboiAGdVqAIgZi/Coag3
   g==;
IronPort-SDR: PMeqyZHbaJ6LwURVr1wJI5mIBi3SGN7q5hpgyl/tw2P8h4B0kcYEYi4RvaZzik6tSS9I/CQUy6
 pW1b7G0DS71TwUsyxRWUl1qhqKiIiRu+3qNc6PIYgzik/5xqfhDyAnGMW01SlqDLObvrRQWdm/
 94tOZHPmBZXCHq3oqkhYe9fPxylHyuGuB/5fWYUUYpnFHWmTEhwuUoDv9vwOk9+s8kpJA8kgGK
 e8U9kakVVQDYAivM4w/Z5FP1yT+mLtSMrzjJg/yX1qI4uquY2AU4gjUbbMYGI+Ri4FNyUIW3Zv
 YXg=
X-IronPort-AV: E=Sophos;i="5.81,167,1610434800"; 
   d="scan'208";a="114523417"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 01:10:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 01:10:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 10 Feb 2021 01:10:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf7Ur3Ia2z9Np72YeyjXLQ4jAWxHyRbE77IcjdA2aoMLo6Lu1u6LIpLYkfaJury0cLe8W9+2MLXIvVzCyoisMQ/7AXTphZpJVvTorukAcQ5kunkUB8y2r9t0xeHIi61XFa1ARqKC/rafPZshQhQfYhh2Mysb2XXYIOHjzREyhxERlhRxy6EnVv3gscS55e02rMwC8EXuow/YALe6YQt562xEsqw/H+g1hGQ6STpRzaOq6jtw6m8Q7+O1iZJ1yTWat0RKmwEDF343doeZFj7jDyUUw9dvwQIMECa4d4PJj7/JZs1P3o6WDzH9TbzRevJOwrHRSvQAsc7pNNGDSuU3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3xZ7Pi62ghugDx/YIn+3pI1NL8JLD9+q03EyO96yaI=;
 b=XKlEN7yn5dPCde6UG5v5nhFDuWmJ1KwA4hSLaVKd9uoHyT+O/fBu7CXxhPRcT42EWm3+yveAV6T/gIeENnMpyifCrjVQhL4zG1UMYj/OP8oVKa7c92Mlm1Uau65O2LjywPAmM6QqETR6SYqoUdPJywN/8sIaqkf0ZI89BH6cX6ocnTGbmrpUt571dj7mrR84YypuYtEFFmXuV+niVBfTjeE0vcfmBZDYerRKzT1RBzlRHcbKgCIFeWkxe3REN+leY/sCCq8LA/7QlfXkTtSabHdP3Fa8X+xNqNStHD5N5vDgdd4CAYPkMGD9dlyU/07aZzdZHgEVdk+/wsMKHAgGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3xZ7Pi62ghugDx/YIn+3pI1NL8JLD9+q03EyO96yaI=;
 b=ZsFK2I+roq8iqqzAg3wM/GRPfh065Ke2lnpFlNDALDrBydLYAJYDOGKEqGMDMEBtBV40SztNBXIZYdnWCFPtG2+WoGb7KsnpmIUE5beTVBbmP5BBDr7xlqWN3f4KQrzCyTvcLo7rtKWHXl1Kpv+N3RF5UGUZrdEkc4uHwv1m1Wk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3424.namprd11.prod.outlook.com (2603:10b6:805:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 08:09:59 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%4]) with mapi id 15.20.3825.031; Wed, 10 Feb 2021
 08:09:59 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <saravanak@google.com>
CC:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <mirq-linux@rere.qmqm.pl>, <gregkh@linuxfoundation.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
Thread-Topic: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
Thread-Index: AQHW/vc9M0xRwyNg8kaFXOuETguw+A==
Date:   Wed, 10 Feb 2021 08:09:58 +0000
Message-ID: <9b06192b-4978-e430-7d93-4985cc4813d7@microchip.com>
References: <20210128104446.164269-1-tudor.ambarus@microchip.com>
 <CAGETcx9CodHDeqSYM1zQXRi-p_rFUJQgwMtnuWeKvCt_B3dCOw@mail.gmail.com>
 <161285731192.418021.10555916396092570051@swboyd.mtv.corp.google.com>
 <CAGETcx9C+sH-GKz61GfCxd9qk=E-AMueHSwPgp5Z_5QcOzXJiQ@mail.gmail.com>
 <d15b1045-2dac-a1ba-a078-2f37786c1d9d@microchip.com>
 <CAGETcx8+RFPM51hixbpmroHB17iMpxeyUrFe6hOLaoQNNp-zKg@mail.gmail.com>
In-Reply-To: <CAGETcx8+RFPM51hixbpmroHB17iMpxeyUrFe6hOLaoQNNp-zKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7797cc6-6f78-46b0-c805-08d8cd9b4263
x-ms-traffictypediagnostic: SN6PR11MB3424:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB342460DA6B60A082818731E9F08D9@SN6PR11MB3424.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2YCZy+BHzsUWihSFW4FF6YQi1cy0QYDajsFV6nqgy7MjDyr/UbV0rx6N1VwgF7PHEEpACUhbO1IYDPnSVJAGfVUKqxKNGj4bbIuIutaf/ahyUdmfFrx48erQccpwKkUm639YtOTfNZemO6EnYeJB6KIc6xEiUZD9C3uZlkVONFDKvbL7tJlc5x76M271aA+vTyBCLKq9wEwG43y8WLRHz2tash5ise+cPnfEp9NRd2JDrVaUHIL6I8+Iygtch1GNbJwBKOsIqADRQeUDOmquO4KAt+zdIq7p310ws9TSgQ+dDqZHmxJnP5/K0MZf0ogPGOzhj6zpB79oagOHSF3n1TQS04PrKoGmti4mbmWx1QxdF4xNIzYdVweLGW9lRwo8UJpPcF6vOv3QA+Z9P5xjWXNa1pqDGBHC005p1xaxxLqC78favDyWqco5obfMrSpYJ7oCIfYyB86axKDbVFMM9+gcj3Mek+L//pR+x/3fannuFQjW+/kfdf7WM8E9hOoorCtaU8xUiKFB9FFaNi7506tdf6l/CD2X5D179xYsHBlR69exk39gDRTq912ayu77Hrg2X7fd9r+38aHvcDtxT/cLjzbqEnDL2059wTMoamPpV9qYvRxGbHBtBQQw8jg1oGZ44YrSbd5F+7sbtwc7NxraVlP4dPSA8XgeUsvnU07VnlOj/FxJa6/JYohcJCU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(346002)(366004)(66476007)(54906003)(6512007)(71200400001)(53546011)(76116006)(66946007)(6916009)(91956017)(5660300002)(64756008)(66446008)(31686004)(316002)(66556008)(478600001)(8676002)(8936002)(6506007)(2616005)(26005)(86362001)(6486002)(966005)(186003)(4326008)(31696002)(2906002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RFozSitseGRSR0R2eEpLOEttaHJCdnNTZVg4bTNCc3NLajVmc3JHcDNubjg1?=
 =?utf-8?B?U2E4dVh6b0F6VFVQWGFTWVlhQXJtMVhVZjJVbFVwdlo5cU8rS092WjAzekxn?=
 =?utf-8?B?cE1oRUFyK3BwWHlDb3VNbVlTa0d6dm9tYXQraWpvVS9VZ1F3SklEd2lWZVVa?=
 =?utf-8?B?YnNNRytLU1ZESDlPQnNOU0dld3NBUFVhR24rQit2SXFSNjliTHZIbjJZRGFP?=
 =?utf-8?B?SXh6Qjh2RkZDTi9xcTI1VUJkZjUyQXlxS2JYZmRtdGtPc2Y0SkEzVTROUWd3?=
 =?utf-8?B?amd5RzhaQjh1c3VyTU0rNWNtelU0YWgvbmxXYlZ0QytieXVmSkVSbnF0WlM0?=
 =?utf-8?B?Q1lFb3JVM3BLbmVuUStzc3dUT0dLU3M5SUNpYVNZcU9Fb1hNbTNRZ1JNZ1Jz?=
 =?utf-8?B?c3hVeWIxSTZvQjEzcG5VT0dscGkza2RFeXZUcW8wZXh3ZXk5SmFCcWNzQmw2?=
 =?utf-8?B?ZE1sSTNGVEYwcFpoNGM3bEtjTm1WZmxHalNMRW00NFI5ekpPWVQ1b3NpUnVh?=
 =?utf-8?B?Zlo4cE5jbjhRL3h1QVQvdVEwdzUwTlp2YTRvc0s1cFdxcSswRWdwbTVXYTJF?=
 =?utf-8?B?UFE5L1d3MU5jK0g0NTdSczg3Z0ZkcTJhM1FBalYrdmdSbXdjMmsvZk1aY1Rk?=
 =?utf-8?B?VlBFaUExU2dheXZwK1FSaTJPYnEzalN0bU1wUW0zWGNKcndNZ2dFSS8rNXJx?=
 =?utf-8?B?dW1RUFZSNWFGQUJERDB0cEVFZVM5Yk9CcHJFSVRxS2t2TlpKR0pjSFRlczJa?=
 =?utf-8?B?QWhvREdDb21YNW01dUJLbUpuQkJyTXVvdTdsMkJuUkJ2ei9leWovVmw5dUtU?=
 =?utf-8?B?WVdmS2UwaUt5R3dYM1lrNlNDaktEbzJGZDNmRFpDZkpvUmIrc2NlYjBMK3Jp?=
 =?utf-8?B?Wmd1VjFSM1VlRG1wWWNwZ0VJb1lOTlY2YURsKzhueXBocEI2SFBOVFV5NjFT?=
 =?utf-8?B?bWxWWVhXN3RhM1g4OGZGc2RTS3Y5NTJuajZpMmtrK1pISFAzbmc5c1R3QXBs?=
 =?utf-8?B?aXBmU0VJeHNFWEhRU2xtb0lqOExuVTZ4OEo2WkhTaE0xR01jMHIrNWZMdnNW?=
 =?utf-8?B?aEpZZmVJajZSSnozUk1uTndsQVhjZysxV1Z6NXFURTd0cFk4WGEzUk1aOHNs?=
 =?utf-8?B?eEZaMldJUUsvYUVURm1VY3lXMXpZSkZIaldBK2M3NnVIS0p2eDNsWm9ldXRs?=
 =?utf-8?B?N3pnaDFmcURUR1htWElQUVFOMlFCS1c4Z1pmbThsUzg0OTFzakhGM0w3WGd3?=
 =?utf-8?B?NUZpR3RQVG5rS2xUZnBhak5kYzV5TklrNFVPelJiV1poOXFxZnpxcnVxTFVy?=
 =?utf-8?B?cUwzVDl2cW8zd0Y5enFSWlRieklBTDV0alBza1Q1VEVHa1pUMFZTMEpmLzRq?=
 =?utf-8?B?M3M3K2Z2OFk2Tk1uK200RTVKdzU3UVU1SC84d1BYUjd3YXhoTE1pWkJZSUox?=
 =?utf-8?B?Smwyd05ZNmVaTS82dE9kRXBacFBFK3B5MzRPVmZzdFhneHhhQ2d2QkUrTjhB?=
 =?utf-8?B?YkVEenl2Q3B5STRvditqb3N2WmVNMGJkNXVxOE5Kbm04QWx6ZUszWHlKLzFx?=
 =?utf-8?B?RTQwdzJvMUFYTFVWUk50eWgyNGxOd1RENzJLZGJPd3BGUUpHUm1ya21LTTlr?=
 =?utf-8?B?U29BOHBiRlp0VWluUXlCaC9ocHFMUWNKSC9sbGtnaU5MWWhYaTVRV2FzdTdv?=
 =?utf-8?B?NUlOREpxU2EvbG9LcjIzSExOeWxEaURPc3dTdVNXcXdtRmJjcjJBUDlQNDNY?=
 =?utf-8?Q?onKt/MgeOnsjGl+rDw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86D616362403BD4BABC005C4473F90A9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7797cc6-6f78-46b0-c805-08d8cd9b4263
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 08:09:58.9180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3vUUdnExDP57Yk1GuM+tXDwT+r9n/0y40TOC0VUYj+7S/wXsBLgaGdqn9yUpveRI0wz1N39zqKK15EWu0KyPM8lLQkCp/nDXXu8nMiNTZX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3424
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNhcmF2YW5hLA0KDQpPbiAyLzkvMjEgOTowNiBQTSwgU2FyYXZhbmEgS2FubmFuIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgRmVi
IDksIDIwMjEgYXQgNzoyMSBBTSA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToN
Cj4+DQo+PiBIaSwgU2FyYXZhbmEsDQo+Pg0KPj4gT24gMi85LzIxIDExOjExIEFNLCBTYXJhdmFu
YSBLYW5uYW4gd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
Pj4NCj4+PiBPbiBNb24sIEZlYiA4LCAyMDIxIGF0IDExOjU1IFBNIFN0ZXBoZW4gQm95ZCA8c2Jv
eWRAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+DQo+Pj4+IFF1b3RpbmcgU2FyYXZhbmEgS2FubmFu
ICgyMDIxLTAxLTI4IDA5OjAxOjQxKQ0KPj4+Pj4gT24gVGh1LCBKYW4gMjgsIDIwMjEgYXQgMjo0
NSBBTSBUdWRvciBBbWJhcnVzDQo+Pj4+PiA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3
cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+IFRoZSBzYW1hNWQyIHJlcXVpcmVzIHRoZSBjbG9jayBwcm92
aWRlciBpbml0aWFsaXplZCBiZWZvcmUgdGltZXJzLg0KPj4+Pj4+IFdlIGNhbid0IHVzZSBhIHBs
YXRmb3JtIGRyaXZlciBmb3IgdGhlIHNhbWE1ZDItcG1jIGRyaXZlciwgYXMgdGhlDQo+Pj4+Pj4g
cGxhdGZvcm1fYnVzX2luaXQoKSBpcyBjYWxsZWQgbGF0ZXIgb24sIGFmdGVyIHRpbWVfaW5pdCgp
Lg0KPj4+Pj4+DQo+Pj4+Pj4gQXMgZndfZGV2bGluayBjb25zaWRlcnMgb25seSBkZXZpY2VzLCBp
dCBkb2VzIG5vdCBrbm93IHRoYXQgdGhlDQo+Pj4+Pj4gcG1jIGlzIHJlYWR5LiBIZW5jZSBwcm9i
aW5nIG9mIGRldmljZXMgdGhhdCBkZXBlbmQgb24gaXQgZmFpbDoNCj4+Pj4+PiBwcm9iZSBkZWZl
cnJhbCAtIHN1cHBsaWVyIGYwMDE0MDAwLnBtYyBub3QgcmVhZHkNCj4+Pj4+Pg0KPj4+Pj4+IEZp
eCB0aGlzIGJ5IHNldHRpbmcgdGhlIE9GX1BPUFVMQVRFRCBmbGFnIGZvciB0aGUgc2FtYTVkMl9w
bWMNCj4+Pj4+PiBkZXZpY2Ugbm9kZSBhZnRlciBzdWNjZXNzZnVsIHNldHVwLiBUaGlzIHdpbGwg
bWFrZQ0KPj4+Pj4+IG9mX2xpbmtfdG9fcGhhbmRsZSgpIGlnbm9yZSB0aGUgc2FtYTVkMl9wbWMg
ZGV2aWNlIG5vZGUgYXMgYQ0KPj4+Pj4+IGRlcGVuZGVuY3ksIGFuZCBjb25zdW1lciBkZXZpY2Vz
IHdpbGwgYmUgcHJvYmVkIGFnYWluLg0KPj4+Pj4+DQo+Pj4+Pj4gRml4ZXM6IGU1OTA0NzQ3Njhm
MWNjMDQgKCJkcml2ZXIgY29yZTogU2V0IGZ3X2Rldmxpbms9b24gYnkgZGVmYXVsdCIpDQo+Pj4+
Pj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAu
Y29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+IEknbGwgYmUgb3V0IG9mIG9mZmljZSwgd2lsbCBjaGVj
ayB0aGUgcmVzdCBvZiB0aGUgYXQ5MSBTb0NzDQo+Pj4+Pj4gYXQgdGhlIGJlZ2luaW5nIG9mIG5l
eHQgd2Vlay4NCj4+Pj4+Pg0KPj4+Pj4+ICBkcml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIuYyB8IDIg
KysNCj4+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4+DQo+Pj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jIGIvZHJpdmVycy9jbGsv
YXQ5MS9zYW1hNWQyLmMNCj4+Pj4+PiBpbmRleCA5YTVjYmM3Y2Q1NWEuLjVlZWEyYjRhNjNkZCAx
MDA2NDQNCj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIuYw0KPj4+Pj4+ICsr
KyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jDQo+Pj4+Pj4gQEAgLTM2Nyw2ICszNjcsOCBA
QCBzdGF0aWMgdm9pZCBfX2luaXQgc2FtYTVkMl9wbWNfc2V0dXAoc3RydWN0IGRldmljZV9ub2Rl
ICpucCkNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAgICAgb2ZfY2xrX2FkZF9od19wcm92aWRlcihucCwg
b2ZfY2xrX2h3X3BtY19nZXQsIHNhbWE1ZDJfcG1jKTsNCj4+Pj4+Pg0KPj4+Pj4+ICsgICAgICAg
b2Zfbm9kZV9zZXRfZmxhZyhucCwgT0ZfUE9QVUxBVEVEKTsNCj4+Pj4+PiArDQo+Pj4+Pj4gICAg
ICAgICByZXR1cm47DQo+Pj4+Pg0KPj4+Pj4gSGkgVHVkb3IsDQo+Pj4+Pg0KPj4+Pj4gVGhhbmtz
IGZvciBsb29raW5nIGludG8gdGhpcy4NCj4+Pj4+DQo+Pj4+PiBJIGFscmVhZHkgYWNjb3VudGVk
IGZvciBlYXJseSBjbG9ja3MgbGlrZSB0aGlzIHdoZW4gSSBkZXNpZ25lZA0KPj4+Pj4gZndfZGV2
bGluay4gRWFjaCBkcml2ZXIgc2hvdWxkbid0IG5lZWQgdG8gc2V0IE9GX1BPUFVMQVRFRC4NCj4+
Pj4+IGRyaXZlcnMvY2xrL2Nsay5jIGFscmVhZHkgZG9lcyB0aGlzIGZvciB5b3UuDQo+Pj4+Pg0K
Pj4+Pj4gSSB0aGluayB0aGUgcHJvYmxlbSBpcyB0aGF0IHlvdXIgZHJpdmVyIGlzIHVzaW5nDQo+
Pj4+PiBDTEtfT0ZfREVDTEFSRV9EUklWRVIoKSBpbnN0ZWFkIG9mIENMS19PRl9ERUNMQVJFKCku
IFRoZSBjb21tZW50cyBmb3INCj4+Pj4+IENMS19PRl9ERUNMQVJFX0RSSVZFUigpIHNheXM6DQo+
Pj4+PiAvKg0KPj4+Pj4gICogVXNlIHRoaXMgbWFjcm8gd2hlbiB5b3UgaGF2ZSBhIGRyaXZlciB0
aGF0IHJlcXVpcmVzIHR3byBpbml0aWFsaXphdGlvbg0KPj4+Pj4gICogcm91dGluZXMsIG9uZSBh
dCBvZl9jbGtfaW5pdCgpLCBhbmQgb25lIGF0IHBsYXRmb3JtIGRldmljZSBwcm9iZQ0KPj4+Pj4g
ICovDQo+Pj4+Pg0KPj4+Pj4gSW4geW91ciBjYXNlLCB5b3UgYXJlIGV4cGxpY2l0bHkgTk9UIGhh
dmluZyBhIGRyaXZlciBiaW5kIHRvIHRoaXMNCj4+Pj4+IGNsb2NrIGxhdGVyLiBTbyB5b3Ugc2hv
dWxkbid0IGJlIHVzaW5nIENMS19PRl9ERUNMQVJFKCkgaW5zdGVhZC4NCj4+Pj4+DQo+Pj4+DQo+
Pj4+IEkgc2VlDQo+Pj4+DQo+Pj4+IGRyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3No
ZHdjLmM6ICAgICAgIHsgLmNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMi1wbWMiIH0sDQo+Pj4+
DQo+Pj4+IHNvIGlzbid0IHRoYXQgdGhlIGRyaXZlciB0aGF0IHdhbnRzIHRvIGJpbmQgdG8gdGhl
IHNhbWUgZGV2aWNlIG5vZGUNCj4+Pj4gYWdhaW4/IEZpcnN0IGF0IG9mX2Nsa19pbml0KCkgdGlt
ZSBoZXJlIGFuZCB0aGVuIHNlY29uZCBmb3IgdGhlIHJlc2V0DQo+Pj4+IGRyaXZlcj8NCj4+Pg0K
Pj4+IFlvdSBhcmUgcmlnaHQuIEkgYXNzdW1lZCB0aGF0IHdoZW4gVHVkb3Igd2FzIHNldHRpbmcg
T0ZfUE9QVUxBVEVELA0KPj4NCj4+IE5vLCB0aGVyZSdzIGEgc2luZ2xlIGRyaXZlciB0aGF0IGJp
bmRzIHRvIHRoYXQgY29tcGF0aWJsZS4NCj4+DQo+Pj4gdGhleSBkaWRuJ3Qgd2FudCB0byBjcmVh
dGUgYSBzdHJ1Y3QgZGV2aWNlIGFuZCB0aGV5IGtuZXcgaXQgd2FzIHJpZ2h0DQo+Pj4gZm9yIHRo
ZWlyIHBsYXRmb3JtLg0KPj4+DQo+Pj4gSG93ZXZlci4uLg0KPj4+ICQgZ2l0IGdyZXAgImF0bWVs
LHNhbWE1ZDItcG1jIg0KPj4+IGFyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaTogICAgICAg
ICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9DQo+Pj4gImF0bWVsLHNhbWE1ZDItcG1jIiwg
InN5c2NvbiI7DQo+Pj4gYXJjaC9hcm0vbWFjaC1hdDkxL3BtLmM6ICAgICAgICB7IC5jb21wYXRp
YmxlID0gImF0bWVsLHNhbWE1ZDItcG1jIiwNCj4+PiAuZGF0YSA9ICZwbWNfaW5mb3NbMV0gfSwN
Cj4+PiBkcml2ZXJzL2Nsay9hdDkxL3BtYy5jOiB7IC5jb21wYXRpYmxlID0gImF0bWVsLHNhbWE1
ZDItcG1jIiB9LA0KPj4+IGRyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jOkNMS19PRl9ERUNMQVJF
X0RSSVZFUihzYW1hNWQyX3BtYywNCj4+PiAiYXRtZWwsc2FtYTVkMi1wbWMiLCBzYW1hNWQyX3Bt
Y19zZXR1cCk7DQo+Pj4gZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hkd2MuYzog
ICAgICAgeyAuY29tcGF0aWJsZSA9DQo+Pj4gImF0bWVsLHNhbWE1ZDItcG1jIiB9LA0KPj4+DQo+
Pj4gR2VleiEgSG93IG1hbnkgZHJpdmVycyBhcmUgdGhlcmUgZm9yIHRoaXMgb25lIGRldmljZS4g
Q2xlYXJseSBub3QgYWxsDQo+Pj4gb2YgdGhlbSBhcmUgZ29pbmcgdG8gYmluZC4gQnV0IEknbSBu
b3QgZ29pbmcgdG8gZGlnIGludG8gdGhpcy4gWW91IGNhbg0KPj4NCj4+IEZyb20gdGhpcyBlbnRp
cmUgbGlzdCBvbmx5IHRoZSBkcml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIuYyBkcml2ZXIgYmluZHMg
dG8gdGhlDQo+PiAiYXRtZWwsc2FtYTVkMi1wbWMiIGNvbXBhdGlibGUsIHRoZSByZXN0IGFyZSBq
dXN0IHVzaW5nIHRoZSBjb21wYXRpYmxlIHRvDQo+PiBtYXAgdGhlIFBNQyBtZW1vcnkuDQo+Pg0K
Pj4+IHJlamVjdCB0aGlzIHBhdGNoLiBJIGV4cGVjdCB0aGlzIHNlcmllcyBbMV0gdG8gdGFrZSBj
YXJlIG9mIHRoZSBpc3N1ZQ0KPj4+IFR1ZG9yIHdhcyB0cnlpbmcgdG8gZml4Lg0KPj4+DQo+Pj4g
VHVkb3IsDQo+Pj4NCj4+PiBXYW50IHRvIGdpdmUgdGhpcyBzZXJpZXMgWzFdIGEgc2hvdD8NCj4+
DQo+PiBUaGUgc2VyaWVzIGF0IFsxXSBkb2Vzbid0IGFwcGx5IGNsZWFuIG5laXRoZXIgb24gbmV4
dC0yMDIxMDIwOSwgbm9yIG9uDQo+PiBkcml2ZXItY29yZS1uZXh0LiBPbiB0b3Agb2Ygd2hpY2gg
c2hhMSBzaG91bGQgSSBhcHBseSB0aGVtPw0KPiANCj4gSXQncyBvbiB0b3Agb2YgZHJpdmVyLWNv
cmUtbmV4dDoNCj4gNDczMTIxMGMwOWY1IGdwaW9saWI6IEJpbmQgZ3Bpb19kZXZpY2UgdG8gYSBk
cml2ZXIgdG8gZW5hYmxlDQo+IGZ3X2Rldmxpbms9b24gYnkgZGVmYXVsdA0KDQpJIHNlZSBHcmVn
IHRvb2sgeW91ciBzZXJpZXMuIEkgdHJpZWQgdGhlIGRyaXZlci1jb3JlLW5leHQgKHdpdGggeW91
ciBzZXJpZXMNCmluY2x1ZGVkKSwgaXQgZG9lc24ndCBzb2x2ZSBteSBib290IHByb2JsZW0gb24g
c2FtYTVkMl94cGxhaW5lZC4NCg0KV2l0aCBbMl0gYXBwbGllZCwgc2FtYTVkMl94cGxhaW5lZCBj
YW4gYm9vdCBhZ2Fpbi4NCg0KQ2hlZXJzLA0KdGENCg0KPiANCj4+IEFueXdheSwgSSB0aGluayB0
aGUgcGF0Y2ggYXQgWzJdIGlzIHN0aWxsIG5lZWRlZCwgcmVnYXJkbGVzcyBvZiB0aGUgb3V0Y29t
ZQ0KPj4gb2YgWzFdLg0KPiANCj4gUmlnaHQsIFsyXSBpcyBzdGlsbCBhIGdvb2QgY2xlYW4gdXAg
YmFzZWQgb24geW91ciBjb21tZW50IGFib3ZlLg0KPiANCj4gLVNhcmF2YW5hDQo+IA0KPj4+DQo+
Pj4gWzFdIC0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDIwNTIyMjY0NC4yMzU3
MzAzLTEtc2FyYXZhbmFrQGdvb2dsZS5jb20vDQo+Pg0KPj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyMTAyMDMxNTQzMzIuNDcwNTg3LTEtdHVkb3IuYW1iYXJ1c0BtaWNyb2No
aXAuY29tLw0KPj4NCj4+IENoZWVycywNCj4+IHRhDQo+Pg0KDQo=
