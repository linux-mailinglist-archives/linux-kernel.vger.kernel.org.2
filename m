Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B909354241
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 15:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbhDENLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 09:11:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:59977 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbhDENL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 09:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617628282; x=1649164282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K5CFAiTs4RVrOXw1u7PiwMZ/tjLo9CqprS5x5KEIX+Q=;
  b=ih2rH6Ell7KYWujlPH+rghVE+dutE2kQdQ3VReYj1zdGk6ohvgvbrvFx
   97reV2rn8sCQRdX3Czr0SzvTk8zJ2J1IeHldFblMko0pXK2k3nMrRBxbw
   V/Zspol6hlFzo7IbL2IsH6UEYoSYQMaWL6yJxxtAZ/hiO8KW+9aOikpPk
   oZu+WAIri5Eg7spyIVH8n1Yot4/sz/cl133oGetwa/QWSl9xUluMP7HTy
   Dos+uunukduCbewMTKwQ/ek/kMtsrDzzogdQIb3VeLJt2IYcgmHKYFICS
   dxHVjp31vHIkFp03b7lA6fPNg2+nc4XplXN7Iv1OGFw+OVBEsxJU3L7Wy
   g==;
IronPort-SDR: CSNKNaAaqbzhX8eFaaegOHMEtBh+yOJ4UUiU7aXVUOycIseRnHEU+e07qbYGMtzE3CgUk/byoB
 XzWktjZt5S43CHIU4du1k0UGktQ1VItABAzeJpLqdB51/Mg6OHj2KUXJHOS8JKjQuQNt8fBTkq
 WkUcW+vXDwafZX6YE6Bh2Auk0sXgPpmQX4Uaq5uQuuBAY+QLj6ec+pq7fbTw+aw7JQTPtJkpHT
 9/NtGBO35wJo+4To9mLWIyn20UgzoNnHGN3DBRC1cZwcBrPydpYqbMvV15fzCb+ZdjXc2gTptz
 Zuw=
X-IronPort-AV: E=Sophos;i="5.81,306,1610434800"; 
   d="scan'208";a="115320062"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2021 06:11:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Apr 2021 06:11:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Mon, 5 Apr 2021 06:11:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMTQ9t/2HOBHuWG6HNVnxf73V3riXimIzMXRBWjQ6h9Q/PD+Zl6RfZ59r/OD9dX6NSrbjbehU1s/2hUFrFSxArfTfirjHr3PsY5EYJs7YbY1ULpWv6Qax2T3FZJ0BjPmOfJBj1v5W5aN1BH+U0J+tgst3UZx6OWP8t4mexesVkTBbMOgEq7a1i716RY4imrx42bxNen/FCUHeoEuSHqsWpLwxOfUPs4OePagY1FIX7d6MWhbGja6vermHYYtWDmrE+rbqwMdX4HSHLMw0iv67b01qxWHFB/WMxAMQkXZtcZ/1qLPfPCG5C7CakSV1/k0iqi0wlNV6u1Seq5N2T02kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5CFAiTs4RVrOXw1u7PiwMZ/tjLo9CqprS5x5KEIX+Q=;
 b=G70qNSz4oexN6yTzKWykZ0vDA6Mlt0pN0JZ/Hplisb8ZDYacgE2JFlViyQd4/bKETNcyMV1GMSB72/Q4pvNOhukg93y28rr8EjylTUWeIN5nduyYVX9LBU5bBH11RmYc1C/U+H9XR1YdmmCPzwRC/R1zwdCymxNG3431BtBqM3TWIDLvM4WXYbjuKLB2K2P6GtQ/8M/HPllIm2tvddNKbXeDo44KMSlkqrAkVDK9bpSb6T16LEVddxel3ozOgmZbX38VuJ3+cYdLjEOb2CY7JEa3+Y0bQIcUBVRC+K8t8uIithyBSaVT4pyVw4F86T7U1jAXetf0iq4cABhZHo42/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5CFAiTs4RVrOXw1u7PiwMZ/tjLo9CqprS5x5KEIX+Q=;
 b=FXUIy6ECrQMOiko8CIOrze6AqLkZzpJlhpN2+4pSI9Yg4gd/a8b//rIH9dhSp5v1iCS65IUEOtW8DLhUrOLuPvWuzExQM8xuqGC9IkbHC6mt2Nh0L0jh6whvgFCBY0vHIlvJ9GbtV93LiXBmgkZBb3/mdGdPAbZalyrolyXowMk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4841.namprd11.prod.outlook.com (2603:10b6:806:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 13:11:19 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49e5:8be7:95d:b6a9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49e5:8be7:95d:b6a9%4]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 13:11:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
Thread-Topic: [PATCH 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
Thread-Index: AQHXKh0qsepR3n5rmUO9Y03pG1rHig==
Date:   Mon, 5 Apr 2021 13:11:19 +0000
Message-ID: <e28e7cd3-9728-3428-1bae-9cda258174bc@microchip.com>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-2-michael@walle.cc>
In-Reply-To: <20210318092406.5340-2-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa0dc0da-1ee9-47a1-7530-08d8f8344d63
x-ms-traffictypediagnostic: SA2PR11MB4841:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB4841D1886B628742E6A277F6F0779@SA2PR11MB4841.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /aD4glTCbqcHezO5Yw7aFhB5Ag1qqznTsG8Chod53QodUo4Yb4XIY8XHnl/piMnNCa9qzeFGm0x2pOLtOpYVVDfAnf/Ez/YcfZQF6JuatjC7Ufns1g6KRWQs1Rp+VNiVWdLKnLyCmIXUOvm6ibDVL91j8/Xmr7UtHF/Mm3DtWy9cLkI3YBag4B1YM4ScMo7GrRBcBq4TeiR873ep9jhLZaeqsWm5LTPeD5zjex4D+zdpsi4KeejJJNM+VI1IgNilSbt3MbUbYNe0kkaCiD2s/fZvnmKUMtlF9xzpZDF23iwzoEyPCiFvi+ScvqAQRrIbFoplSksUBJcuPMDPvn43H4l0SgOUg9iEFd+1MRA4Ibo0zPC2yO60HywgrTcwF8GPhOJw+Hx565UluIQdvMrKxanVOcaTHrdX1QOJ+e6fV/w7AJ2qn5pfB7Pg6zkm4D5ZztltoCW8ylDlfAaipEz7iQ0zkqQgv91GJcwuSa99LNGcdxDY0YfsDTX7M6fsvwp2HkXVYIav54Ghd7Iz0MlbN6N/wcHNA+G/6voam3ONg18oycpxs8gHHJqzW0I6lKthkB6uSL6p68I4Mgqag3ZUwlJXEi0TQ9RPWkl0a4YBJjtJWHcCT1AAZHxPyk7LcS22jNKMJqeqVzd2GcTVDVxniX9Kn7GqbD6LHHREawIskCFqibXTndPZAUxroUPGH8xa8f+64Ba2fMIrApAl5l99DoqgdPfHHsh41ZYBggV9V4k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(366004)(39860400002)(38100700001)(2906002)(54906003)(110136005)(26005)(8936002)(8676002)(2616005)(4326008)(316002)(6486002)(31686004)(76116006)(36756003)(53546011)(91956017)(6506007)(83380400001)(66556008)(64756008)(66446008)(478600001)(31696002)(66946007)(66476007)(71200400001)(5660300002)(6512007)(86362001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NDh4bHBlWGU1VGdHbFNxK21UMm5MNlhYa2w4SFhQajBNaGEya1dLK0RkMlBN?=
 =?utf-8?B?bVRFOVRTWmdlTzVNUnZ5UWJrY1NmYmZDcW9XakZiWXlTNUJPc3JwaExsWk55?=
 =?utf-8?B?S2FvcWtwUEltejAzMHZHd3RBbWtqRk1XTFphSkdDWVVkdENOUEVkU3piRHMy?=
 =?utf-8?B?VlB4bmpPdW9Bc0Z0OUEyL1NpVStBZG5oS2laVW5BaW5KWGp5OVdPb1Y3V0pu?=
 =?utf-8?B?QUVITy9IeEpWY2FrUXY2MjhXRGhRb091S0xXWU43Y2N6dlFjZkJvbVRNQkh6?=
 =?utf-8?B?UTdrM2IyZlE4bGdwVXZzOUFWdEVmNlhNOHdoelp0VTAvV1ZMNHhvRm9MeGli?=
 =?utf-8?B?T01YdnltUUN0QmRKU1RFMmViMU5yVWU0UnJuRjNrTURzN050ejUxVVN0UG9V?=
 =?utf-8?B?R05kU2RjS1ZyNHNRRGp5WHRHOHNVUWVLeEdzU1J1WnFEUC9jellKUnlWeXBC?=
 =?utf-8?B?b1B3SlpwTGtUYVZCbkdNaVRYU1haTFRLYTNsTmhIZ3lKM2dKNTRISjA0TmRD?=
 =?utf-8?B?SFBJUG9vOGdhT1Uzc3pGeFpTYU16Q0RYeXFid3EwK0hsUnd5c3FTS0pUZDZu?=
 =?utf-8?B?ckxVa2ROUW44VnYwdGFjbnRVU0oxUGIwWE9jUDlMcndPRnhDT1Q3cUVTTCsz?=
 =?utf-8?B?REsxUDMzSGZ2UHcyRk1hQTRBNGY0ZFRjRkxZMEJFcFFiQU5FT2Nta1JWTzhM?=
 =?utf-8?B?Wm1KS3VRTk96Y0FUVWJwZGZRNUF2eURtdExUSVQ0Z3l6OHNxUVZkVW82N2N6?=
 =?utf-8?B?S0Z1YjIrRFVGbUlTUnFlNkl3cjIwV2J0Ulh3a3hQSm95R1BIcWRvQVhqT2FE?=
 =?utf-8?B?ekZRa0FFenRyOElOYktQbmtNQmRRcTRVa3laNEZsTVRvNisvckVsRUFyV0F0?=
 =?utf-8?B?TlhqcCt0bXZmbE02cFlhY1V6eVlGRVE3N0tBay9vOEk5QzQ1SGdOcVZaU1NB?=
 =?utf-8?B?Zmdhbm9nRkNFVUdWUWcwMzRTVGVDVnhkRzBpWll4NFJpQUlWOFpXSDJLY2VY?=
 =?utf-8?B?TUU4MUZzVW5MNlAwRXBPeWNjOEZBaFNQYnB5bVhQQ2VNZS9BaEM3V1FCa0Uy?=
 =?utf-8?B?VzY3L0F1R0JyRXVqcitDSFE3SGx6RUg1b2hjUjZDc3FzK0xsQ0dTeUxCR200?=
 =?utf-8?B?Vml6RXpTWDdXUENVS3RFTDQ0aGdUMXdoT3NTdVhBYlVZV1dkTzM0RGgzTUY0?=
 =?utf-8?B?cVFXaEh1MDBmSkxzR3RNNHNqdmRnc2pnWVl4S3RBWU9abVZ2OG1jdGM1UXEw?=
 =?utf-8?B?dU04Z2ZodFlabG1BODI3ZGp0cFl1VWcvTWUxZVpSck9JUXJHT2JrNmdBT2Ew?=
 =?utf-8?B?VHNxdG5iSkJQSjNvRXgveFFiRFhkNUtkajdUMlhvVmpYRkNlZWlKYjQwRTJk?=
 =?utf-8?B?NWNvVVFMZFJBbWZPc0IwUmE3bGxsdFNmcDVWWWxTbG9RemdKSEU0QUhQNVpw?=
 =?utf-8?B?alRVeGFiUmsyQkliZnlkUVJRaTVad2Q2MVRrVTFSS2p0TzJkdXg5azcwbkNo?=
 =?utf-8?B?Uk80NVpWSzBqVjVqVUVlTkFZOXUwVFVmdXJMN0E2YnFsaWJxMUZqTUp2YnhF?=
 =?utf-8?B?SFNTdlljV1U5MGZmcjNxSDYrWm1QRGFaSlFsWFkrR1AveHF4bWtBRXFnUHB0?=
 =?utf-8?B?Q29OMENSdFR3YXdNRXVPWVNsVnpsZXFuUTBOM2E1ZU1oZDdWUGZKTzBRUkUv?=
 =?utf-8?B?Tys3cGUrVUJKQUZMZ2h6T0kwa2RJcjYwU1p4N3E4ZlcvOHpPTUNxbS9MY1F6?=
 =?utf-8?Q?UynUJTHOCqGYJVA/Ko=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40E8581542BA8E43987077A24721F124@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0dc0da-1ee9-47a1-7530-08d8f8344d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 13:11:19.2619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AzvVonprwas43O0g5ENTE/iGL6rhQqEU9l6F2O+eEZCAmE6yG/+Lw7zp9nmZCizFm8eLhsImaSp3955mg4tMBb2kfAcv1hwpDbxPH2HnZ1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4841
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDMvMTgvMjEgMTE6MjQgQU0sIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRHVlIHRvIHBvc3NpYmxlIG1vZGUg
c3dpdGNoaW5nIHRvIDhELThELThELCBpdCBtaWdodCBub3QgYmUgcG9zc2libGUgdG8NCj4gcmVh
ZCB0aGUgU0ZEUCBhZnRlciB0aGUgaW5pdGlhbCBwcm9iZS4gVG8gYmUgYWJsZSB0byBkdW1wIHRo
ZSBTRkRQIHZpYQ0KPiBzeXNmcyBhZnRlcndhcmRzLCBtYWtlIGEgY29tcGxldGUgY29weSBvZiBp
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+
DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggIHwgMTAgKysrKysrKysNCj4g
IGRyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jICB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCB8ICAzICsrKw0K
PiAgMyBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0K
PiBpbmRleCA0YTNmN2YxNTBiNWQuLjY2OGYyMjAxMWIxZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgN
Cj4gQEAgLTQwNyw2ICs0MDcsMTYgQEAgc3RydWN0IHNwaV9ub3JfbWFudWZhY3R1cmVyIHsNCj4g
ICAgICAgICBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMgKmZpeHVwczsNCj4gIH07DQo+IA0K
PiArLyoqDQo+ICsgKiBzdHJ1Y3Qgc2ZkcCAtIFNGRFAgZGF0YQ0KPiArICogQG51bV9kd29yZHM6
IG51bWJlciBvZiBlbnRyaWVzIGluIHRoZSBkd29yZHMgYXJyYXkNCj4gKyAqIEBkd29yZHM6IGFy
cmF5IG9mIGRvdWJsZSB3b3JkcyBvZiB0aGUgU0ZEUCBkYXRhDQo+ICsgKi8NCj4gK3N0cnVjdCBz
ZmRwIHsNCj4gKyAgICAgICBzaXplX3QgIG51bV9kd29yZHM7DQo+ICsgICAgICAgdTMyICAgICAq
ZHdvcmRzOw0KPiArfTsNCj4gKw0KPiAgLyogTWFudWZhY3R1cmVyIGRyaXZlcnMuICovDQo+ICBl
eHRlcm4gY29uc3Qgc3RydWN0IHNwaV9ub3JfbWFudWZhY3R1cmVyIHNwaV9ub3JfYXRtZWw7DQo+
ICBleHRlcm4gY29uc3Qgc3RydWN0IHNwaV9ub3JfbWFudWZhY3R1cmVyIHNwaV9ub3JfY2F0YWx5
c3Q7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYyBiL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc2ZkcC5jDQo+IGluZGV4IDI1MTQyZWM0NzM3Yi4uMmI2Yzk2ZTAyNTMyIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYw0KPiArKysgYi9kcml2ZXJz
L210ZC9zcGktbm9yL3NmZHAuYw0KPiBAQCAtMTYsNiArMTYsNyBAQA0KPiAgICAgICAgICgoKHAp
LT5wYXJhbWV0ZXJfdGFibGVfcG9pbnRlclsyXSA8PCAxNikgfCBcDQo+ICAgICAgICAgICgocCkt
PnBhcmFtZXRlcl90YWJsZV9wb2ludGVyWzFdIDw8ICA4KSB8IFwNCj4gICAgICAgICAgKChwKS0+
cGFyYW1ldGVyX3RhYmxlX3BvaW50ZXJbMF0gPDwgIDApKQ0KPiArI2RlZmluZSBTRkRQX1BBUkFN
X0hFQURFUl9QQVJBTV9MRU4ocCkgKChwKS0+bGVuZ3RoICogNCkNCj4gDQo+ICAjZGVmaW5lIFNG
RFBfQkZQVF9JRCAgICAgICAgICAgMHhmZjAwICAvKiBCYXNpYyBGbGFzaCBQYXJhbWV0ZXIgVGFi
bGUgKi8NCj4gICNkZWZpbmUgU0ZEUF9TRUNUT1JfTUFQX0lEICAgICAweGZmODEgIC8qIFNlY3Rv
ciBNYXAgVGFibGUgKi8NCj4gQEAgLTEyNjMsNiArMTI2NCw4IEBAIGludCBzcGlfbm9yX3BhcnNl
X3NmZHAoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gICAgICAgICBzdHJ1Y3Qgc2ZkcF9wYXJhbWV0
ZXJfaGVhZGVyICpwYXJhbV9oZWFkZXJzID0gTlVMTDsNCj4gICAgICAgICBzdHJ1Y3Qgc2ZkcF9o
ZWFkZXIgaGVhZGVyOw0KPiAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IG5vci0+ZGV2Ow0K
PiArICAgICAgIHN0cnVjdCBzZmRwICpzZmRwOw0KPiArICAgICAgIHNpemVfdCBzZmRwX3NpemU7
DQo+ICAgICAgICAgc2l6ZV90IHBzaXplOw0KPiAgICAgICAgIGludCBpLCBlcnI7DQo+IA0KPiBA
QCAtMTI4NSw2ICsxMjg4LDkgQEAgaW50IHNwaV9ub3JfcGFyc2Vfc2ZkcChzdHJ1Y3Qgc3BpX25v
ciAqbm9yLA0KPiAgICAgICAgICAgICBiZnB0X2hlYWRlci0+bWFqb3IgIT0gU0ZEUF9KRVNEMjE2
X01BSk9SKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiArICAgICAg
IHNmZHBfc2l6ZSA9IFNGRFBfUEFSQU1fSEVBREVSX1BUUChiZnB0X2hlYWRlcikgKw0KPiArICAg
ICAgICAgICAgICAgICAgIFNGRFBfUEFSQU1fSEVBREVSX1BBUkFNX0xFTihiZnB0X2hlYWRlcik7
DQo+ICsNCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIEFsbG9jYXRlIG1lbW9yeSB0aGVuIHJl
YWQgYWxsIHBhcmFtZXRlciBoZWFkZXJzIHdpdGggYSBzaW5nbGUNCj4gICAgICAgICAgKiBSZWFk
IFNGRFAgY29tbWFuZC4gVGhlc2UgcGFyYW1ldGVyIGhlYWRlcnMgd2lsbCBhY3R1YWxseSBiZSBw
YXJzZWQNCj4gQEAgLTEzMTEsNiArMTMxNyw0OSBAQCBpbnQgc3BpX25vcl9wYXJzZV9zZmRwKHN0
cnVjdCBzcGlfbm9yICpub3IsDQo+ICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgfQ0KPiAN
Cj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIENhY2hlIHRoZSBjb21wbGV0ZSBTRkRQIGRhdGEu
IEl0IGlzIG5vdCAoZWFzaWx5KSBwb3NzaWJsZSB0byBmZXRjaA0KPiArICAgICAgICAqIFNGRFAg
YWZ0ZXIgcHJvYmUgdGltZSBhbmQgd2UgbmVlZCBpdCBmb3IgdGhlIHN5c2ZzIGFjY2Vzcy4NCj4g
KyAgICAgICAgKi8NCj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgaGVhZGVyLm5waDsgaSsrKSB7
DQo+ICsgICAgICAgICAgICAgICBwYXJhbV9oZWFkZXIgPSAmcGFyYW1faGVhZGVyc1tpXTsNCj4g
KyAgICAgICAgICAgICAgIHNmZHBfc2l6ZSA9IG1heF90KHNpemVfdCwgc2ZkcF9zaXplLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0ZEUF9QQVJBTV9IRUFERVJfUFRQKHBh
cmFtX2hlYWRlcikgKw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0ZEUF9Q
QVJBTV9IRUFERVJfUEFSQU1fTEVOKHBhcmFtX2hlYWRlcikpOw0KPiArICAgICAgIH0NCg0KTWlj
aGFlbCwgSSBsaWtlIHRoZSBpZGVhIG9mIHNhdmluZyB0aGUgU0ZEUCBkYXRhLCBidXQgSSB0aGlu
ayB0aGlzIGNhbiBiZQ0KaW1wcm92ZWQgYSBsaXR0bGUuIEZvciBleGFtcGxlLCBpdCBpcyBub3Qg
bWFuZGF0b3J5IGZvciB0aGUgdGFibGVzIHRvIGJlDQpjb250aW51b3VzIGluIG1lbW9yeSwgdGhl
cmUgY2FuIGJlIHNvbWUgZ2FwcyBiZXR3ZWVuIEJGUFQgYW5kIFNNUFQgZm9yIGV4YW1wbGUsDQp0
aHVzIHdlIGNhbiBpbXByb3ZlIHRoZSBtZW1vcnkgYWxsb2NhdGlvbiBsb2dpYy4gQWxzbywgd2Ug
Y2FuIG1ha2UgdGhlIHNhdmVkIHNmZHANCmRhdGEgdGFibGUtYWdub3N0aWMgc28gdGhhdCB3ZSBk
b24ndCBkdXBsaWNhdGUgdGhlIHJlYWRzIGluIHBhcnNlX2JmcHQvc21wdC80YmFpdC4NCkFyZSB5
b3Ugd2lsbGluZyB0byByZXNwaW4/DQoNCkNoZWVycywNCnRhDQo=
