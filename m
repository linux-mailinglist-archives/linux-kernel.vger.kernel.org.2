Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24646354388
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbhDEPnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:43:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23024 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbhDEPnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617637386; x=1649173386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jBaME4sEvjGTjabD6pFAi2LBzoB4vA9HqoKf0Ekc9e0=;
  b=Czg+lkdtH5CwGdGsQLXXZkmgf20RFbIW4diV2WzIFP24bgvF4cVXloeU
   sf0uM12cRfQRkTyXYomha0a3rm0gGRPYjwx/OLwNSwctgcpxt/piknomd
   26FL2mL48koqsidQ3qXo1vQFRs1PilIZFdiYq0wRsBtysePaQpUkBE64E
   0Z0uqNKa81L09YFlQ2mi58UAh95pmM6lPRZgL3vePNpZ2Ccbg80wXPcb5
   XlLo4rped1PZr/ZHvKsOgXGBVlYpT7WM2biel7TJHaotVpkzXxFhcUPu0
   Ha5uMT2/B8IlL/f1tEExmAm7YXVhlr3jhRbtc6CyO+aOAgPzQI401jvPI
   w==;
IronPort-SDR: dPaNmbXrEprqEqiqYGfuoTe21aaIFNpZaR7q0/XS0nXFVHWW0MxPcaBZN5hqDfBB7Z+KOLdBTs
 q+K45MHcmBML8DAgdNXK5UNpdLAftmb36DSZdwwfVaa9r8a1fNJVLnD6kPzj5qD/IvO+jU5iPj
 oOR9dewBSFYS00dDRTWF3R/U00LRfX5odPHU37eGIKP7NEARJ2TIGzYM3RfKnZN0R5HRWVMdwh
 p6rI8ltFpXIgbbplkX9QpnOXWiZSNazj25j/JHjagT2TdvImOqGzoIXMivWXYBz2UEqW9RJRrC
 Qao=
X-IronPort-AV: E=Sophos;i="5.81,306,1610434800"; 
   d="scan'208";a="112480635"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2021 08:43:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Apr 2021 08:43:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Mon, 5 Apr 2021 08:43:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQcmXNp95ToAzzRhda0DcwyCcUAQizRZ2p3TXUfsCUQkHIsZxEdqmXMb1CvfhQCFsOQ8zNRD9D2N3GwLZYmwBeMSYzoLcnv4v7oJry4vEaNMWE9UW1dQIr4M8sbBbgYjdnUHY+rCD8QwO7CVJPh6v+tzcaKfhBiXMIURZLYsKqGJGTe8+3XEkLnO5ROPc/dsFq8WSFIOkowx08VZxitbVM4D1BUA77rZXSJQzRY4k2QX7aEotr90cCgWw0Ue9hjfn2ZgH34DAp4cQCrV3Rzvr8DE1p65IYP9YtrmEOFclqvBAc4TEfALEHBHXlGI8hB9kc1O8eLrnGMEP4nat+KLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBaME4sEvjGTjabD6pFAi2LBzoB4vA9HqoKf0Ekc9e0=;
 b=BxD0+3gA3aGYouH8zIr0VUKlH0tKgf8VoOOACTGTdsmTDnPnQjN9x9u90xvgWKw4WiyntFHqZKNti9tMzYHkLz9PYSvW3zJIvqxJDYIdohUbrcBaN6ZV7WGFvUv4JVGgwEq8x+eReTwS6REYIc2431GabCg3DBcTk5t2bjB0Dsi1rIsYTPxdObWwQE4Dh+bzx7ymEeYyb21E6MSau9rSwkUIR+pkX6DbGqcy0riOH5oJ2RpSlFkoxxUZTaMauO67s/konunZTq5pRd2bEe8R1O03HRplfyPA8DjiT5Ox//U6GBK5rEgjZPeAEUWhVpyohTBGMjEuk322RR8YrTJzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBaME4sEvjGTjabD6pFAi2LBzoB4vA9HqoKf0Ekc9e0=;
 b=ozEBD948Eim7r4NMdFoVxlkZxs7eRgmSbbL/eYjFm5WWvZuYi+JSi8but+Fsqcm9ilrAJ/nE2Hn6+fEUSilrSWffeYEmwA2rw2HblHSnts61UjT4GjMhx/y9nghJz10qwkG3/GNjRImZwFeIvND1Eci8FNPY3X7PR93bIVa4udo=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4985.namprd11.prod.outlook.com (2603:10b6:806:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Mon, 5 Apr
 2021 15:42:58 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49e5:8be7:95d:b6a9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49e5:8be7:95d:b6a9%4]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 15:42:58 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
Thread-Topic: [PATCH 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
Thread-Index: AQHXKh0qsepR3n5rmUO9Y03pG1rHig==
Date:   Mon, 5 Apr 2021 15:42:58 +0000
Message-ID: <d14cbc96-43ab-8f1e-82e6-e1999a1972c5@microchip.com>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-2-michael@walle.cc>
 <e28e7cd3-9728-3428-1bae-9cda258174bc@microchip.com>
 <5359aa6ade80ff6d39e969c3be2957dd@walle.cc>
In-Reply-To: <5359aa6ade80ff6d39e969c3be2957dd@walle.cc>
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
x-ms-office365-filtering-correlation-id: 931bf8b3-e01c-4a86-59aa-08d8f8497d1d
x-ms-traffictypediagnostic: SA2PR11MB4985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB498541F591D9920D8DB72ABDF0779@SA2PR11MB4985.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kGYKAXPPj3B3oqy+Ie0coCY1Ug6kU+3AkVESMz/Yvm4HsKDsjSTb3eQ0mGhkNtzaRdE7kcYQYRFyQ5nIjFFNLW9qvlVah6XuNs/a7FiI1qWQsFh5DmlRmk2MDfFBR2IQJysNdI5hqNIwlCy9pFK3hS2/W+8xEYgSLkeh6V4pv/AJxs4ar4Zf37mbbIfhdsXOuDfu5bkvP3kR6NHBvcRBZ+0oJuUGE/Rk7ep4TZ3pZLzV3ZQagSC7O1v7qX8oHm4NU8OOGo7qi9VP26kwgoMUeGADjup+kYbNZEkmJUKSpcR/nxHmK/+jvu168YEFvV6QORfNDrEpgyLu0XQvAOoiyUdkLv1K2rc91UnSTb12fWI6bXfpzMzQCKUPBEvePXHM/JmHMd0Xm7OpQGiP3ylYvmYenAs7/EaqWUTwP/Ds4Pxmcgm+tiTY3hb4rya2x1ViaS/h1+kaNI8Li/3uc8A8HryM39yJWq9rzfRRbR+LGF206cFATSO+sP32rdaJ1KA4ZDNZdxueiwth7jV2g8OgW1MeE4St97bUa9p+/fyH4j7uKeb1GYp3W/NEsgBnoGjf4YnGrPllyW00D4qFzu4Zz8f7l2ehnaT73GlPm5aQlIgAyMrNDv5qv1s1uHSD2qQBQdF34lqUKSOUEx/pInErTBz4APBmPHiDC6GOFMt+sjLbfXzWq+H0Y2zKEPdaiZSB8S/eswDtp1Z678y6wHQOnxQuUcseBngI4IKtePzI7j4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39860400002)(376002)(136003)(91956017)(76116006)(31696002)(478600001)(31686004)(36756003)(186003)(6916009)(66556008)(6486002)(64756008)(83380400001)(26005)(2906002)(86362001)(66946007)(8676002)(6506007)(316002)(4326008)(71200400001)(66476007)(6512007)(5660300002)(66446008)(54906003)(38100700001)(2616005)(53546011)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aHk0bDREdGR6MzdKY29TZHNkK3EvelQzZTFRd0xINzFaSnlKT1pQN3ZrNWhp?=
 =?utf-8?B?VGx5UXFaem9TaUVuZXc3b2ZxcCtrT0FINk8yNEFtY1FrVWVSRG9MUE1jK2xM?=
 =?utf-8?B?dDIzTVVUdDlud2R4UUxwdWhJZlBJdDJtd1BXMUhuNEZlS2EyKzFFUzEzWTBN?=
 =?utf-8?B?MFRIblJKS3Bnak9jVVN3YkdhTU8zQmZJa1luaU5LVStSak1aaHBES2pqelVm?=
 =?utf-8?B?d0ttRzV2VERBQTZYSFMraElkOVFQQXFxY2F2aWVuY0F0Ym1kTlFyT2Q1UmFY?=
 =?utf-8?B?cC81bFhaM1JJeU5MM3dJc2JYUHhoL0tmVjVndkdOTEhBWUJDTlhOd0tRZWJq?=
 =?utf-8?B?elArQUpOY0VwL1dKQnNZdXZsNUREZ0IrVjVMT0VKUTF6SmFkNDJhcmJkQk5S?=
 =?utf-8?B?NzRGR3MzdkZtS3QvMm1Sa2dSUDF1dE9qT2VSVEdwNUNBT1JZejdVMXdLT3BS?=
 =?utf-8?B?ZFVNOWZBWUVsNGUwZFdEck15b3dZOHl1Mk1PQmZNWmtlMkIyQm81QlZ1b1JP?=
 =?utf-8?B?aUROeElZS0x3SEJyeFFBR0lld0lBeitEUUFveVNGOFN5cVRvdDdVN1dHOHF4?=
 =?utf-8?B?WFphcDdoS1BpQ0RJU2lPdlRNbVZSVWtodGdwcjg1YTljeks3ZkVobmxIR3Y5?=
 =?utf-8?B?bklXWndwSzMzNkJnRzlXVDRIUHlwaXBRS1dkRTNZSDB5Rkp6dkRncElTZldH?=
 =?utf-8?B?dVBpUE4zMkRNdWZadFZJQ0hmQ25YR0diWVYzYUtPcjd6SmNMMTlZOCtHMGM1?=
 =?utf-8?B?VCs1alVpVFNxME5tVS9DRll5T2NiQzdzNjhuMWRGSmdIZDhzOE83MXUyQU5T?=
 =?utf-8?B?TzZBRmdWRlhnc2ZrY09QY2pVMVlyVjhWVXEwUmlTbGozY0xicmlSeXhFc3dF?=
 =?utf-8?B?blFYNG1FSlFQUkl5d2VzWG1LQmIrV3RTNXRnMTZhZVJlT1Vtck9ud2hPc3Vm?=
 =?utf-8?B?OFNHdWlWemQ3aDNHNHFlcCtXdUhFMjJCalhQQ2IxMWRqaWhzWDlwVFFKNzJW?=
 =?utf-8?B?NmpwTCtBaVFtbmNyQ2EyeGY1WmlLZWl0ODQ5OWtDSzBIZ2FVcTNSOXdRemw4?=
 =?utf-8?B?WnZDb0ZUWU5QUkFaeWRLZmZmSnJGNVJHbmtGZFNCaUhmaVZUa0YxMFMzS3pP?=
 =?utf-8?B?TGpSYzlVcHlZTnIycXZLazdTSk15a1FmSlczYkgyT1ZvVHVJTlg4TXRtRnBI?=
 =?utf-8?B?eS9md0dUbjVXQUM1QkxSKzhjaXpNb1Y5ZnVHRkNINFFxMHFnRjhPUWxUQ0pI?=
 =?utf-8?B?cyszOE03VmJ6YTV5TThYTzdjcDBWbmRoSzBRMGE2Ui9TZDdOaUhNS3JzcFFq?=
 =?utf-8?B?anAvandCcXhFbE9oZ1BNMk00anZwZkxMb0kyNWhLaytyZWk0bDl5UUVxQ3pP?=
 =?utf-8?B?K1E0dEIwODFNbDdiUG81dXRidTJGWnJ4bG1tZXAwYk1KTGpmT0M0cTRqZnh4?=
 =?utf-8?B?VW56R1BBbkF6NjRKU1lwRFhnSDFGdktqMWUwcVZpeG5WL29EWk44WGhGZkdI?=
 =?utf-8?B?VVU3a1pjVFIydlA4TGhleWRGL2FFaXNlZVppOEhzNnd1bmloMHI4ejRTL09v?=
 =?utf-8?B?UWRyWW9xNW9RWFI3SC9sU1hzNzVIUE5YdGpQenBobHphZzU2b0R3cUY4QkpX?=
 =?utf-8?B?b1ZZUng2Qm5hbzgwbFdpTlBGUE9zL0dEbXczWG16bDVmUS9LcEUra3VCcm9R?=
 =?utf-8?B?TmMzYVBLQ29EekRoVXE0VndXajJFOC9WTEFvbHNqMHM1L2NDOG1UOGkvcnRq?=
 =?utf-8?Q?+p8Z++Gjjp4xalGYBs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF1C1F409705324D95A330DD52F0FD73@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931bf8b3-e01c-4a86-59aa-08d8f8497d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 15:42:58.7236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2p3/VuBlz9a7GOfeYt4EFOiEDmmTXAGZeU9p38j0H4g9jWxTmaPpN1lzgxjFmSw9vEGt8dljQP+bezctxODNRMZhDvt48KXl9q8m2TQ0mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4985
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC81LzIxIDY6MDcgUE0sIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksDQo+IA0KPiBBbSAyMDIxLTA0LTA1IDE1OjEx
LCBzY2hyaWViIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDMvMTgvMjEgMTE6
MjQgQU0sIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IER1ZSB0byBwb3NzaWJsZSBtb2RlIHN3aXRjaGluZyB0
byA4RC04RC04RCwgaXQgbWlnaHQgbm90IGJlIHBvc3NpYmxlDQo+Pj4gdG8NCj4+PiByZWFkIHRo
ZSBTRkRQIGFmdGVyIHRoZSBpbml0aWFsIHByb2JlLiBUbyBiZSBhYmxlIHRvIGR1bXAgdGhlIFNG
RFAgdmlhDQo+Pj4gc3lzZnMgYWZ0ZXJ3YXJkcywgbWFrZSBhIGNvbXBsZXRlIGNvcHkgb2YgaXQu
DQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNj
Pg0KPj4+IC0tLQ0KPj4+IMKgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmjCoCB8IDEwICsrKysr
KysrDQo+Pj4gwqBkcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuY8KgIHwgNDkNCj4+PiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gwqBpbmNsdWRlL2xpbnV4L210ZC9z
cGktbm9yLmggfMKgIDMgKysrDQo+Pj4gwqAzIGZpbGVzIGNoYW5nZWQsIDYyIGluc2VydGlvbnMo
KykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCBiL2Ry
aXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+Pj4gaW5kZXggNGEzZjdmMTUwYjVkLi42NjhmMjIw
MTFiMWQgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4+PiAr
KysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPj4+IEBAIC00MDcsNiArNDA3LDE2IEBA
IHN0cnVjdCBzcGlfbm9yX21hbnVmYWN0dXJlciB7DQo+Pj4gwqDCoMKgwqDCoMKgwqAgY29uc3Qg
c3RydWN0IHNwaV9ub3JfZml4dXBzICpmaXh1cHM7DQo+Pj4gwqB9Ow0KPj4+DQo+Pj4gKy8qKg0K
Pj4+ICsgKiBzdHJ1Y3Qgc2ZkcCAtIFNGRFAgZGF0YQ0KPj4+ICsgKiBAbnVtX2R3b3JkczogbnVt
YmVyIG9mIGVudHJpZXMgaW4gdGhlIGR3b3JkcyBhcnJheQ0KPj4+ICsgKiBAZHdvcmRzOiBhcnJh
eSBvZiBkb3VibGUgd29yZHMgb2YgdGhlIFNGRFAgZGF0YQ0KPj4+ICsgKi8NCj4+PiArc3RydWN0
IHNmZHAgew0KPj4+ICvCoMKgwqDCoMKgwqAgc2l6ZV90wqAgbnVtX2R3b3JkczsNCj4+PiArwqDC
oMKgwqDCoMKgIHUzMsKgwqDCoMKgICpkd29yZHM7DQo+Pj4gK307DQo+Pj4gKw0KPj4+IMKgLyog
TWFudWZhY3R1cmVyIGRyaXZlcnMuICovDQo+Pj4gwqBleHRlcm4gY29uc3Qgc3RydWN0IHNwaV9u
b3JfbWFudWZhY3R1cmVyIHNwaV9ub3JfYXRtZWw7DQo+Pj4gwqBleHRlcm4gY29uc3Qgc3RydWN0
IHNwaV9ub3JfbWFudWZhY3R1cmVyIHNwaV9ub3JfY2F0YWx5c3Q7DQo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMN
Cj4+PiBpbmRleCAyNTE0MmVjNDczN2IuLjJiNmM5NmUwMjUzMiAxMDA2NDQNCj4+PiAtLS0gYS9k
cml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYw0KPj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
c2ZkcC5jDQo+Pj4gQEAgLTE2LDYgKzE2LDcgQEANCj4+PiDCoMKgwqDCoMKgwqDCoCAoKChwKS0+
cGFyYW1ldGVyX3RhYmxlX3BvaW50ZXJbMl0gPDwgMTYpIHwgXA0KPj4+IMKgwqDCoMKgwqDCoMKg
wqAgKChwKS0+cGFyYW1ldGVyX3RhYmxlX3BvaW50ZXJbMV0gPDzCoCA4KSB8IFwNCj4+PiDCoMKg
wqDCoMKgwqDCoMKgICgocCktPnBhcmFtZXRlcl90YWJsZV9wb2ludGVyWzBdIDw8wqAgMCkpDQo+
Pj4gKyNkZWZpbmUgU0ZEUF9QQVJBTV9IRUFERVJfUEFSQU1fTEVOKHApICgocCktPmxlbmd0aCAq
IDQpDQo+Pj4NCj4+PiDCoCNkZWZpbmUgU0ZEUF9CRlBUX0lEwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MHhmZjAwwqAgLyogQmFzaWMgRmxhc2ggUGFyYW1ldGVyIFRhYmxlDQo+Pj4gKi8NCj4+PiDCoCNk
ZWZpbmUgU0ZEUF9TRUNUT1JfTUFQX0lEwqDCoMKgwqAgMHhmZjgxwqAgLyogU2VjdG9yIE1hcCBU
YWJsZSAqLw0KPj4+IEBAIC0xMjYzLDYgKzEyNjQsOCBAQCBpbnQgc3BpX25vcl9wYXJzZV9zZmRw
KHN0cnVjdCBzcGlfbm9yICpub3IsDQo+Pj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNmZHBfcGFy
YW1ldGVyX2hlYWRlciAqcGFyYW1faGVhZGVycyA9IE5VTEw7DQo+Pj4gwqDCoMKgwqDCoMKgwqAg
c3RydWN0IHNmZHBfaGVhZGVyIGhlYWRlcjsNCj4+PiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2
aWNlICpkZXYgPSBub3ItPmRldjsNCj4+PiArwqDCoMKgwqDCoMKgIHN0cnVjdCBzZmRwICpzZmRw
Ow0KPj4+ICvCoMKgwqDCoMKgwqAgc2l6ZV90IHNmZHBfc2l6ZTsNCj4+PiDCoMKgwqDCoMKgwqDC
oCBzaXplX3QgcHNpemU7DQo+Pj4gwqDCoMKgwqDCoMKgwqAgaW50IGksIGVycjsNCj4+Pg0KPj4+
IEBAIC0xMjg1LDYgKzEyODgsOSBAQCBpbnQgc3BpX25vcl9wYXJzZV9zZmRwKHN0cnVjdCBzcGlf
bm9yICpub3IsDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiZnB0X2hlYWRlci0+bWFqb3Ig
IT0gU0ZEUF9KRVNEMjE2X01BSk9SKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVJTlZBTDsNCj4+Pg0KPj4+ICvCoMKgwqDCoMKgwqAgc2ZkcF9zaXplID0gU0ZE
UF9QQVJBTV9IRUFERVJfUFRQKGJmcHRfaGVhZGVyKSArDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBTRkRQX1BBUkFNX0hFQURFUl9QQVJBTV9MRU4oYmZwdF9oZWFk
ZXIpOw0KPj4+ICsNCj4+PiDCoMKgwqDCoMKgwqDCoCAvKg0KPj4+IMKgwqDCoMKgwqDCoMKgwqAg
KiBBbGxvY2F0ZSBtZW1vcnkgdGhlbiByZWFkIGFsbCBwYXJhbWV0ZXIgaGVhZGVycyB3aXRoIGEN
Cj4+PiBzaW5nbGUNCj4+PiDCoMKgwqDCoMKgwqDCoMKgICogUmVhZCBTRkRQIGNvbW1hbmQuIFRo
ZXNlIHBhcmFtZXRlciBoZWFkZXJzIHdpbGwgYWN0dWFsbHkgYmUNCj4+PiBwYXJzZWQNCj4+PiBA
QCAtMTMxMSw2ICsxMzE3LDQ5IEBAIGludCBzcGlfbm9yX3BhcnNlX3NmZHAoc3RydWN0IHNwaV9u
b3IgKm5vciwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+IMKgwqDC
oMKgwqDCoMKgIH0NCj4+Pg0KPj4+ICvCoMKgwqDCoMKgwqAgLyoNCj4+PiArwqDCoMKgwqDCoMKg
wqAgKiBDYWNoZSB0aGUgY29tcGxldGUgU0ZEUCBkYXRhLiBJdCBpcyBub3QgKGVhc2lseSkgcG9z
c2libGUNCj4+PiB0byBmZXRjaA0KPj4+ICvCoMKgwqDCoMKgwqDCoCAqIFNGRFAgYWZ0ZXIgcHJv
YmUgdGltZSBhbmQgd2UgbmVlZCBpdCBmb3IgdGhlIHN5c2ZzIGFjY2Vzcy4NCj4+PiArwqDCoMKg
wqDCoMKgwqAgKi8NCj4+PiArwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBoZWFkZXIubnBo
OyBpKyspIHsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXJhbV9oZWFkZXIg
PSAmcGFyYW1faGVhZGVyc1tpXTsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
ZmRwX3NpemUgPSBtYXhfdChzaXplX3QsIHNmZHBfc2l6ZSwNCj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTRkRQX1BB
UkFNX0hFQURFUl9QVFAocGFyYW1faGVhZGVyKQ0KPj4+ICsNCj4+PiArDQo+Pj4gU0ZEUF9QQVJB
TV9IRUFERVJfUEFSQU1fTEVOKHBhcmFtX2hlYWRlcikpOw0KPj4+ICvCoMKgwqDCoMKgwqAgfQ0K
Pj4NCj4+IE1pY2hhZWwsIEkgbGlrZSB0aGUgaWRlYSBvZiBzYXZpbmcgdGhlIFNGRFAgZGF0YSwg
YnV0IEkgdGhpbmsgdGhpcyBjYW4NCj4+IGJlDQo+PiBpbXByb3ZlZCBhIGxpdHRsZS4gRm9yIGV4
YW1wbGUsIGl0IGlzIG5vdCBtYW5kYXRvcnkgZm9yIHRoZSB0YWJsZXMgdG8NCj4+IGJlDQo+PiBj
b250aW51b3VzIGluIG1lbW9yeSwgdGhlcmUgY2FuIGJlIHNvbWUgZ2FwcyBiZXR3ZWVuIEJGUFQg
YW5kIFNNUFQgZm9yDQo+PiBleGFtcGxlLA0KPj4gdGh1cyB3ZSBjYW4gaW1wcm92ZSB0aGUgbWVt
b3J5IGFsbG9jYXRpb24gbG9naWMuDQo+IA0KPiBJIHdhbnQgdG8gcGFyc2UgdGhlIFNGRFAgYXMg
bGl0dGxlIGFzIHBvc3NpYmxlLiBLZWVwIGluIG1pbmQsIHRoYXQgdGhpcw0KPiBzaG91bGQNCj4g
aGVscCB0byBkZWJ1ZyBTRkRQIChlcnJvcnMpLiBUaGVyZWZvcmUsIEkgZG9uJ3Qgd2FudCB0byBy
ZWx5IG9uIHRoZSBTRkRQDQo+IHNheWluZw0KPiAiaGV5IHRoZXJlIGlzIGEgaG9sZSwgcGxlYXNl
IHNraXAgaXQiLiBXaG8ga25vd3MgaWYgdGhlcmUgaXMgc29tZSB1c2VmdWwNCj4gZGF0YT8NCg0K
V2hhdCBraW5kIG9mIHVzZWZ1bCBkYXRhPyBEbyB3ZSBjYXJlIGFib3V0IGRhdGEgdGhhdCBkb2Vz
bid0IGZvbGxvdyB0aGUgamVzZDIxNg0Kc3RhbmRhcmQ/DQoNCj4gDQo+PiBBbHNvLCB3ZSBjYW4g
bWFrZSB0aGUgc2F2ZWQgc2ZkcA0KPj4gZGF0YSB0YWJsZS1hZ25vc3RpYyBzbyB0aGF0IHdlIGRv
bid0IGR1cGxpY2F0ZSB0aGUgcmVhZHMgaW4NCj4+IHBhcnNlX2JmcHQvc21wdC80YmFpdC4NCj4g
DQo+IFRoaXMgZmFsbHMgaW50byB0aGUgc2FtZSBjYXRlZ29yeSBhcyBhYm92ZS4gV2hpbGUgaXQg
bWlnaHQgYmUgcmV1c2VkLA0KPiB0aGUNCj4gcHJpbWFyeSB1c2UgY2FzZSBpcyB0byBoYXZlIHRo
ZSBTRkRQIGRhdGEgYXZhaWxhYmxlIHRvIGEgZGV2ZWxvcGVyL3VzZXIuDQo+IEVnLg0KPiB3aGF0
IHdpbGwgeW91IGRvIHdpdGggc29tZSBob2xlcyBpbiB0aGUgc3lzZnMgcmVhZCgpPyBSZXR1cm4g
emVyb3M/DQoNCldlIGRvbid0IGhhdmUgdG8gaGF2ZSBnYXBzIGluIG91ciBpbnRlcm5hbCBidWZm
ZXIsIHdlIGp1c3QgYWxsb2NhdGUgYXMgbXVjaA0KYXMgd2UgbmVlZCBhbmQgd2Ugd3JpdGUgaW50
byBvdXIgaW50ZXJuYWwgYnVmZmVyIGp1c3QgdGhlIHNmZHAgdGFibGVzLCB3aXRob3V0DQp0aGUg
Z2Fwcy4NCg0KPiANCj4gRldJVyBJJ20gcGxhbm5pbmcgdG8gcmVmYWN0b3IgdGhlIHJlYWQgY29k
ZSBzbyB0aGUgY2FjaGVkIHZhbHVlcyBhcmUNCj4gdXNlZC4NCj4gDQo+IC1taWNoYWVsDQoNCg==
