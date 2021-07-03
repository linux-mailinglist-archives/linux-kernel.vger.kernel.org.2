Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D46D3BA82F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 11:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhGCJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 05:58:59 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:57403 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhGCJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 05:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625306185; x=1656842185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jtNZJgMEoRPkx7QQMQ9f5XyVweo2LbjaVSVHrgQa0Mk=;
  b=wCWSaV3sS2ZZsJtX5x5dJuK73WUo/02dPvfWup1CsmRfNjiN0Xgsv+0H
   XWd1At0T5F4IoyvOWlTBfVmzU0RX8JzDJpwFkLW4kb8rd6ZrX6UaAG/zj
   aAsilYEBVXpp+rUjZBoqciSzTLS+HF37XqM1uLVv7T/J89MMF798QBZF0
   Km24aV4ER9HRXVqplXRiMp7qkOfxOq10q2K17cVxv5YF5ORJEf8xypxi5
   fHMONX12KRfb4yqck567SHpezzLami7UpZ8ZmMYSa3dmes3MlVM9UTccT
   C7/oAkMSb7qiMd6hzRkszkG+zZ5jwYPvaMMbM7XOyujdhQIMKiwO/VgFK
   g==;
IronPort-SDR: FxyaH8Bb/ugCbbEQOhqGD3PXcukdOYLutNXufefJTmfUemnEgwUte3jMHdWA9kH5nhgInKRYbY
 qskxSxYdnWbSMmSjcZ8okrm52bV6982iafsNm7CAstqUDIqgkeByDo0DtRz6+Ul+e+JngYh8Q/
 3OJZkyeuviBRoNXHg4fy9aunkVucrhz32ya0NQ2aQB8ySiStb8zE7N13b+Ta6VF9k1/fOuY5kA
 30PSPZZXiTALB0qyk2xkawcl4yNqtYv1hdGUBNO3gObZjsNP6o6+h/lGryhGLF+DXRjvBxZfvZ
 3nQ=
X-IronPort-AV: E=Sophos;i="5.83,321,1616482800"; 
   d="scan'208";a="61043365"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2021 02:56:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 3 Jul 2021 02:56:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Sat, 3 Jul 2021 02:56:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bwnv7Dn+s+YAw/9JA8vgPEIhBhmy5Z6J8UO37kIlKZKfArG//Wx7F2Ebym/0rd2DbRLOSaiU0+5UCDUMPl13EbampKT7ltz29hEuy80o7NdH8bqTFtlJD4uTSI2X6LStBu0OaIv8G7jEbeTkPI0976BV9M4+iBDrDfRap80ntMRCGwxOEktAhyKUF+OMxzSIHAJg7LsBIYefLuBBKYm9hBkL0fjhrZswFIKl2VLQvFQfdrcCg1mL4yBd4A+kHFv2ZqL7MAW4w2Z4RpvUoOIfBMvMP2a6DZxmZQMVaVco4Gg1SOEpK6wey88uTbQh0LApv7j8NVVCxhwPxSkRKnU9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtNZJgMEoRPkx7QQMQ9f5XyVweo2LbjaVSVHrgQa0Mk=;
 b=ezwxrNSUrbcYTRq2xDzh23D9cJbir9J6NiGPZi8m23IAv14EF+78jnTrz0Idkn+evm+E/bZBVbKivAwUKUo2GNhnc40yPiMOVZWAU/ambGulRuBl4xc2hBh6eyFAUhumWkSsZHSJDzruUJulWlKG5UYhhQt7jT+3HWQ6chYR8MCAgW6ZT/8vo5Qjs5KfKocDgvBpdnsXZUPB33BbxX6up3Pj2jtftohvAj4KjVX21uuLk4zCu5xoFViyaF1FF2nURyWgWxmnisexwUghXlJhPLpPgi2WI3E9EWGu4AGMX+8Mt4VoeEBXsaflRgBBJqlMnif4u2OdZuq6PFjVmAqtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtNZJgMEoRPkx7QQMQ9f5XyVweo2LbjaVSVHrgQa0Mk=;
 b=fcZhjg8vOhCiy2hXiA60SR9RjUsGP+Xh3XslQIV1ehAVBJYb3axoC75W3Onu5nU5OW1Ow7mkBS1fEQ//J1/fmCOqeMYmlfAik1CGOymB7v06TrqJIdgurYfCn+Ru0YMQsegwAiKRo4mzsschQXK7VOHBIcR6I/fpVL0Tayr3Z1c=
Received: from PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Sat, 3 Jul
 2021 09:56:15 +0000
Received: from PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4]) by PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4%8]) with mapi id 15.20.4287.024; Sat, 3 Jul 2021
 09:56:15 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux@roeck-us.net>
Subject: Re: [PATCH] mtd: core: handle flashes without OTP gracefully
Thread-Topic: [PATCH] mtd: core: handle flashes without OTP gracefully
Thread-Index: AQHXb/GoAw4bbVO2W0KjeZydMqxv/w==
Date:   Sat, 3 Jul 2021 09:56:14 +0000
Message-ID: <9bb2acac-aeb8-d2b2-8df0-9acfd972ec5d@microchip.com>
References: <20210702093841.32307-1-michael@walle.cc>
In-Reply-To: <20210702093841.32307-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2324bf7d-c81c-46dd-4a72-08d93e08cbde
x-ms-traffictypediagnostic: PH0PR11MB5112:
x-microsoft-antispam-prvs: <PH0PR11MB51125A8092C36E7469E6E6B9F01E9@PH0PR11MB5112.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GIzXRbLFKMVKqrCV1LCFxo+IYDL+Qi000/To2G36IY0NRAI9bglmCj4wwEHi5rVImjR3lkb9net/yfR0EV4dEhGGjMUycsSMaN2+6K8o03ptI5XT2RFDhnsg8G2sUaZz64xftUMU/mfES+XQdOTyqpHIia6IzfEv2AvLsydu8uQusuS83nMXpGL+24LVZCWqse5huX8p/cktvfRip+D8GyAId1PffJjYzpBSqGqotdCUccKGr+1zvz+AY2oWzlSB8LLKuMF4ZjOFvdxV/FArkulUgvcgc3KFzzid8CrTSu75PZt1FTSAwlNSaGSOSOKWA+cELjNBzTPRW0UXD1lD6hbdGBN83HUt22f/ZqCi0XYCPB1x0ea5QStB02FMrhgFx8YdAzN7Yso1rubo9Ua1CB3L8dhkBXwVMkmaSivEwqQ42329SDN24VALbQi9IRK3l6fqzWbCOwLYGeF7D5Sb50TcNVihOXWhi8BVAhZ6C6ZEzIILKtCvg2pAHb8KuE90rTk6xP0nIHuSYXEosZ5tkZGbVANmITEsym7zOZwPDb8cDHb/z66CdXDWniMOnA3iV1BinqcjrGLZvPl7SD87C9b5FY+2iSbh3yCj3k8bpt/PgfU8smdjSdN5kTYNIWjMcaXTatQIy0DWa5sGBV8w36kG+nPePn3Px9nnSyqzUT4AxfthajcU93sxXJL67ysoYhNdfxhdqMCPyAg0LCkc1pP30HGXagnvY87X07lN2noL95mndzSkxKSA2rfPuzzr05exoD5h1FRURdwPIRHX4q+JW/ouV5T2RCGnxrtnctwSQGJL4fUHqzRkRAtk1Xzf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(83380400001)(2906002)(8676002)(31686004)(76116006)(4326008)(66556008)(64756008)(66476007)(66946007)(66446008)(91956017)(8936002)(6512007)(5660300002)(53546011)(6486002)(31696002)(86362001)(186003)(478600001)(26005)(966005)(38100700002)(122000001)(71200400001)(54906003)(110136005)(36756003)(6506007)(2616005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3NPdzFVNWNDZ1Vkd29ib2x2UDVtOEQvMDkvaWNSdS9ldjNJaHA4aUhtM0F2?=
 =?utf-8?B?SkJnSVpGamxiL0dIMGM4SUdla2dBTVJPM0p6NFFTcnlDbDU5bUxkdDRRQlUy?=
 =?utf-8?B?eFk0RmVZOEJsU29HcXJKVnNSTU4xcDE5ejhHTkRUQlNTTUxKanU3TWpuWTZD?=
 =?utf-8?B?THBwcXB1TUZkT3lIWkZKTVdadVdYUGY0VzZKUU9xbVhoZldiQjd0MG9DNmsy?=
 =?utf-8?B?dlcyN0pMQzRpak83b1cvUDBwMXFoM3pFSFdPRzJvOTgraWxJTDQzYzFEUDlL?=
 =?utf-8?B?MUlyeFNXWGt1SkxYaWxobmhuc1kyci94eStBR0pWeURzWkJTZ2RXRWVLVGRa?=
 =?utf-8?B?SjBvd0x5NFkwaFU2QjMxUzVmSnRzd21iL3JJQzg5cmJZZWsvQnpxN0RNV2Fo?=
 =?utf-8?B?bzNRNEMrd2R1eS9iVnBOd0g4T2FGMUpRYlVDTVgvSlZzeDNoeGhZU3gwN1VH?=
 =?utf-8?B?R1F6R2xXVG1LV003cXlSYTl1T01tNzNnQ1ArbDNXamRCSElyU0F1UFNrWFoz?=
 =?utf-8?B?aXF2Ym9YcnNSbFdMK1ZFa3g0bERiV2paYU5NV2Jmb2kyaGJJQ1p2ZThVQllJ?=
 =?utf-8?B?V2R1VklKSUNXQXRNR1Q4cnAwd1lYMkZ1WktTV0o2ekgyN2pCbWRUM1dIMld2?=
 =?utf-8?B?UlIrbzNucUVsTklqa25KTkxkUVQ2NEg2Qit4QnRPRGx1ek9HTkFYYWpubHBy?=
 =?utf-8?B?YjdsWW12NHBoZTZ3bDRvZkpQU0dYRmozeC9FRkRTck93NFBiekpkQTBiWFFh?=
 =?utf-8?B?cUF6amdxdCtjUGxkTGZEa3ZQQS9qR2VYdHB5dlZ2U3htZGxOOWlBTDRKN2Fz?=
 =?utf-8?B?b1VmdXZyUmlqanU5KzB1N1Y1TEN2NDRjWENlcklXTXRjckppdDFTdUtjU0Y2?=
 =?utf-8?B?TVh1N0MvQWkwQldQZWgzTWo3OERZUnVSV2xXYi9TRzIyU2hFWlphNzhSRnMw?=
 =?utf-8?B?NTVhTHc4T0p1c21XQmI4QUdpU01hcTZJMmlQMjFLMmdjbFQvbVR1V3E4UmVi?=
 =?utf-8?B?WC9YNytPN0l2eFNRTUVDeDJ6ZTRpWHZTMmJaZFFLWVhPbktFTCtTVFlSSFBZ?=
 =?utf-8?B?S05JYlJXRnhWVWpvNTQ1TVJzOXFlbllQMTJqbXRYUndLaW55M3p5RFZqWGJx?=
 =?utf-8?B?dTBkRzBvbzJnR3F0aTUzcjFYV1orTG9xVHlnL3RRcHdoYndndEN6aWtaRk9x?=
 =?utf-8?B?Q1BHL1J6S3hWQ0YwdG5LUjJveElFVHIvNFJEeUNZeW9aUnpuUzBpZ2g0bnRG?=
 =?utf-8?B?TEwvWDBpY1RuclNXaW9KN1MxNThxUThZRGJKdFVEalN3cDN2Y1JZbWJVKzlG?=
 =?utf-8?B?Vjd1dU9Ic0ZOM1U1QVNXcVdQSXdBTUhrVjJTTlZ5aUpQVUxzeXIvOGpCckls?=
 =?utf-8?B?dW1MM2xQR21tREdZQVRLaGZoMG8wWkl2b0U3Znp4VXlMTVF2RVl2cU5tY25W?=
 =?utf-8?B?K0ZMdVExVGdUNmUwcTQxRndwc3dVYk1HNThaUENoY2xHYmhVVGxudmxYL0dV?=
 =?utf-8?B?UU10Z0RXUXJNUTFVNmhtbTRTSVE2dXhtU01SV2k4U01TM0dQVTF4b0FKZmpa?=
 =?utf-8?B?K3FmdE4va2xhTlp0VHZpYXF5KzRLWENRVnB6VmVnOTk3cVJndGUzYXllR2pM?=
 =?utf-8?B?R2d6YjE1NG5iS2RYaE9iTDFidXE1RXJrak9iaUorOU5MUXNwRldKTTlpWVU5?=
 =?utf-8?B?NEVnVWF5ZGREVW5NcitPQWRoMkRGYkNtWDNheUlHWnhaWjRwajVhcmc5R2xh?=
 =?utf-8?Q?pdwecgkHGXmixzfjUA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <072B5F4F85DD9B43B7AB2F35D3C2F9F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2324bf7d-c81c-46dd-4a72-08d93e08cbde
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2021 09:56:14.9155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QioPVbZf9ryeKD3JoiBze3dgU+hG1z0uxJusC2m0/KfXsHejVx35UYILK/umi82h0xIQ/ebxu8JKv1wKq0Hc7sKTetuXhQgytnDxvjwXGu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yLzIxIDEyOjM4IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZXJlIGFyZSBmbGFzaCBkcml2ZXJzIHdoaWNo
IHJlZ2lzdGVycyB0aGUgT1RQIGNhbGxiYWNrcyBhbHRob3VnaCB0aGUNCj4gZmxhc2ggZG9lc24n
dCBzdXBwb3J0IE9UUCByZWdpb25zIGFuZCByZXR1cm4gLUVOT0RBVEEgZm9yIHRoZXNlDQo+IGNh
bGxiYWNrcyBpZiB0aGVyZSBpcyBubyBPVFAuIElmIHRoaXMgaGFwcGVucywgdGhlIHByb2JlIG9m
IHRoZSB3aG9sZQ0KDQp3aHkgZG8gdGhleSByZWdpc3RlciB0aGUgT1RQIGNhbGxiYWNrIGlmIHRo
ZXkgZG9uJ3Qgc3VwcG9ydCBPVFA/DQoNCj4gZmxhc2ggd2lsbCBmYWlsLiBGaXggaXQgYnkgaGFu
ZGxpbmcgdGhlIEVOT0RBVEEgcmV0dXJuIGNvZGUgYW5kIHNraXANCj4gdGhlIE9UUCByZWdpb24g
bnZtZW0gc2V0dXAuDQo+IA0KPiBGaXhlczogNGIzNjFjZmE4NjI0ICgibXRkOiBjb3JlOiBhZGQg
T1RQIG52bWVtIHByb3ZpZGVyIHN1cHBvcnQiKQ0KPiBSZXBvcnRlZC1ieTogR3VlbnRlciBSb2Vj
ayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxt
aWNoYWVsQHdhbGxlLmNjPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL210ZGNvcmUuYyB8IDEwICsr
KysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbXRkY29yZS5jIGIvZHJpdmVycy9t
dGQvbXRkY29yZS5jDQo+IGluZGV4IGI1Y2NkMzAzNzc4OC4uNjg4MWQxNDIzZGQ2IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL210ZC9tdGRjb3JlLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvbXRkY29y
ZS5jDQo+IEBAIC04ODAsNyArODgwLDEwIEBAIHN0YXRpYyBpbnQgbXRkX290cF9udm1lbV9hZGQo
c3RydWN0IG10ZF9pbmZvICptdGQpDQo+IA0KPiAgICAgICAgIGlmIChtdGQtPl9nZXRfdXNlcl9w
cm90X2luZm8gJiYgbXRkLT5fcmVhZF91c2VyX3Byb3RfcmVnKSB7DQo+ICAgICAgICAgICAgICAg
ICBzaXplID0gbXRkX290cF9zaXplKG10ZCwgdHJ1ZSk7DQo+IC0gICAgICAgICAgICAgICBpZiAo
c2l6ZSA8IDApDQo+ICsgICAgICAgICAgICAgICAvKiBFTk9EQVRBIG1lYW5zIHRoZXJlIGlzIG5v
IE9UUCByZWdpb24gKi8NCj4gKyAgICAgICAgICAgICAgIGlmIChzaXplID09IC1FTk9EQVRBKQ0K
DQpJZiBubyBPVFAgZGF0YSwgbWF5YmUgaXQncyBtb3JlIGFwcHJvcHJpYXRlIGZvciB0aGUgY2xp
ZW50cyB0byBqdXN0DQpyZXR1cm4gYSByZXRsZW4gb2YgMC4NCg0KDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHNpemUgPSAwOw0KPiArICAgICAgICAgICAgICAgZWxzZSBpZiAoc2l6ZSA8IDAp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBzaXplOw0KPiANCj4gICAgICAgICAg
ICAgICAgIGlmIChzaXplID4gMCkgew0KPiBAQCAtODk2LDcgKzg5OSwxMCBAQCBzdGF0aWMgaW50
IG10ZF9vdHBfbnZtZW1fYWRkKHN0cnVjdCBtdGRfaW5mbyAqbXRkKQ0KPiANCj4gICAgICAgICBp
ZiAobXRkLT5fZ2V0X2ZhY3RfcHJvdF9pbmZvICYmIG10ZC0+X3JlYWRfZmFjdF9wcm90X3JlZykg
ew0KPiAgICAgICAgICAgICAgICAgc2l6ZSA9IG10ZF9vdHBfc2l6ZShtdGQsIGZhbHNlKTsNCj4g
LSAgICAgICAgICAgICAgIGlmIChzaXplIDwgMCkgew0KPiArICAgICAgICAgICAgICAgLyogRU5P
REFUQSBtZWFucyB0aGVyZSBpcyBubyBPVFAgcmVnaW9uICovDQo+ICsgICAgICAgICAgICAgICBp
ZiAoc2l6ZSA9PSAtRU5PREFUQSkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBzaXplID0g
MDsNCj4gKyAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoc2l6ZSA8IDApIHsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgZXJyID0gc2l6ZTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290
byBlcnI7DQo+ICAgICAgICAgICAgICAgICB9DQo+IC0tDQo+IDIuMjAuMQ0KPiANCj4gDQo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBM
aW51eCBNVEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tdGQvDQo+IA0KDQo=
