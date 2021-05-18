Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE86938713B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbhERF0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 01:26:19 -0400
Received: from mail-eopbgr1400043.outbound.protection.outlook.com ([40.107.140.43]:17472
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239894AbhERF0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 01:26:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNAy/Cl3rF5GKqZ5XVF62VWGswasOSp3KzB/7tOpLav/QG9dIWH6ks1S/j75M1VVziaQX+GNaqYqWfSCC0z14VyzIkpbWk+bOeJs85d+NaXdzdy71MCMXeitonjwtwGAfe4NrZLbFKug3RDL062lvtLfA82KEJSorwh3jrfzXxmbPHP0BXJ2xn/OG4h2oXTe28f2hVNLBpb4/Tvb8HgppRPMc5wRBSZa3CdQPUqgz4QtBwJ5tAQubVxP0iFkNHkzokGCNCntstBOO3kOyiZKn5ubuT93X+5WEn4BdB8SU6VCpuqvxLWzjjJN9b9gJIttIqolQ3thv2wGfLGhjMJcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caakUM4mX0FB/JKFRr3yQ1P43TROYggOOb/7r0ynzAE=;
 b=e6knhTcL0WJWwH5VpzlXuxAs9fs1erjn2o6V0HLSXsirKhYnT5AXmyjdLBfIs8SxjCffPsq7QvJKHZ2Rf8IR7CbxFSrfLOjY9yqNSU9UuiYlIqi6wGTtvzTUc4ghXsJGzU9wKVtzmJtCF3u46doQiuGexvgIpPR6kQuypv2rtZnZ7aC6SrAylJcPyQY5FNlwret0Cv6O3Aq7cveWO5PzgqD5KVPtBP15kn2BtykqDH5DvoNz3BhYvQk03HLBxw/XEq875OIy6Ht3G0V3che/ewKEhXpxBYPRFcBzH0m4uc6L39gkmPBpZNdELCR9S1h2CcwvMrnN0bGNOE9l3rFzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caakUM4mX0FB/JKFRr3yQ1P43TROYggOOb/7r0ynzAE=;
 b=N0aZYzwJPx8f48eoJy0hhBic4HpZTqDS1jy7ZpcWRteVQDKYSE4eeRyHeDnUQ0IIyMDFCk+/kHfCuvOY5ZN5+ZZpdvmF++/ZPxkDERKmyOByyDHvGqnihRHkCosQ7KfwgVmNVEwAywyQrM7jXEfdkWvGlCyMCPdfQfk8VXdCYvI=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYYPR01MB6960.jpnprd01.prod.outlook.com (2603:1096:400:d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 05:24:16 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%6]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 05:24:16 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] mm,hwpoison: fix race with compound page
 allocation
Thread-Topic: [PATCH v4 1/2] mm,hwpoison: fix race with compound page
 allocation
Thread-Index: AQHXStiw8zyFqifSk0OEHCtVYuHbOKroG+6AgACadoA=
Date:   Tue, 18 May 2021 05:24:16 +0000
Message-ID: <20210518052415.GA2394770@hori.linux.bs1.fc.nec.co.jp>
References: <20210517045401.2506032-1-nao.horiguchi@gmail.com>
 <20210517045401.2506032-2-nao.horiguchi@gmail.com>
 <126534de-9679-0e22-bb2c-807f40edca38@oracle.com>
In-Reply-To: <126534de-9679-0e22-bb2c-807f40edca38@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8f6c5b7-ce22-4ef0-8443-08d919bd2e6a
x-ms-traffictypediagnostic: TYYPR01MB6960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYYPR01MB6960E43B02E836C50EA254D7E72C9@TYYPR01MB6960.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lcZD4cnNUuhK+af9gEeaXzLsVl+kCqgxKO13TxL0K89lhEC81ObtIYPPzXTvpJmSLtfYdxmQbOgVc4mS0lPUtu7Aru+DddAjC/zyYVfAUdVm8rTSg1HX7MwnathboyGY7pJBOxG/CVrN+joXZXghrZ8vM+W2csOdk6yRFcxUr4D11yWgxCwGpr+GIL/15FGnh0VraVduh1e8NSFQ/mo/0913wfUDpOzhwXN645tUMcUyo/QG8mYnxq+tR+36K5SBVbySYluwLA7nYisxmtnfIE0YE+xj/CLwVjP5MPS4sb7xr7LoYgD6s6iXv97veSJaAle+loV8Xm9x4vamp4k9A1OTfn5hBHDd+0Yd1jlewDQ9JRWpJiZxLdzcXvwHOr/LoLjlTkqquRbVxsoefaw/Ura7RUmpozSlP/GHIjkFILyRfImBjkKyO0m9jkA3OgCbJS+gX9yl+wWMhFisOAm1stzWCXe9cysDvIp6NXT2G1SCvAYYuUb6b1amBoyXbfnGSFlsw5BcE7wQbAVRKUIp5Ghx9vx8Epc3Bjc1Km/3K49koQ4F4cbuipSic8/YPDbXrmhGyk5TA64hPWPupGkcTZm824HcyVaP1vLtRXDUF+k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(54906003)(55236004)(316002)(6506007)(478600001)(4326008)(33656002)(186003)(64756008)(38100700002)(5660300002)(66446008)(6486002)(83380400001)(85182001)(9686003)(71200400001)(26005)(8676002)(2906002)(122000001)(76116006)(6916009)(8936002)(66946007)(1076003)(66556008)(53546011)(66476007)(6512007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bmtQVlFXUDQ5a0FTcHQvNTRVenZZT3lKYUlZMXpSWTVnQTdNVzdvVjgrUVlh?=
 =?utf-8?B?UTU5eSs0eUJFUUlXYzIxdEoxUzVEV3ZtN01RcG9pZWl5Q0N5NWdMOHQ5SmFZ?=
 =?utf-8?B?L3JmRllyYlgwcFY5R1kyWTFVeUUwT1FIbHBxcnlBeFNGcGlaV2Q4NU5VMlNu?=
 =?utf-8?B?WlNEbFhBek1ZK1JUcEJ4ZlgwSnNGeFJhb3JDNFA1dUdLL1JubnRuNXhwVkxz?=
 =?utf-8?B?K2JlRTdLOGh5TjFkZkdiWDlxRmRHUVd1d2JXMHJ2K0lnc0o5QlNtcUpIN0VQ?=
 =?utf-8?B?UFh3NUVrZ0hkK2tBaVNFSUxPV3NNZEhIMWFaRmRUMmpNdTk3ZlZlRWplODhW?=
 =?utf-8?B?azl6bWt3bUZ0RHI5bUp2MUpIdkhIV1J5RldmWVMyMGJWSlNBZjJWT2VBb1pL?=
 =?utf-8?B?THJGWHpUZlVQdHRkSjBsZ0FXczlwUU5haG8xOWtnYlF5WVRLaTlCdEJHRkg4?=
 =?utf-8?B?RVdlNWR6U2JuQUdLaS9HUGRBNk5SSzN4VVZpdTdiWTE3ajVrZTFRMmNUT1ZN?=
 =?utf-8?B?RDVmNzhrWlNjV21hbkxWS3VtQUFZdmUwSnNVK3dPNi9vVWFFdnl1aVRscmM2?=
 =?utf-8?B?cG5URys2OTNhUkhuaTlTL1JtWm9yR2crNjMycVUrTE1PNW5CV1JvN2xOY20z?=
 =?utf-8?B?SCtZL3YyK0pxUnY3Wkd4TnZzL2hKVmI1Wm9wdDRibml5TU95WHVyT0UrMUI1?=
 =?utf-8?B?QldpdG44cWZLbTJzb1pKWHExMXJ1N01mb1Q2cHZhcTRGSXJXcGhDTFAvbXlE?=
 =?utf-8?B?Y0tMWHR0d0xPWnp4dk00WUF0WkE4Mk01dDVZVjJwSG1jcnZpTDBPNW51N2R6?=
 =?utf-8?B?MnpnaUxtVkdRbEVZRUpRTE5INzdlcGk1cm02b3VjRG13amgxa2VDTVRQNlNG?=
 =?utf-8?B?ZDhaWGFXK0FkN2pabUVTOGR2UFk0VHh6Y09uNTdaOXdpWk1WY0Rlejl6R2hK?=
 =?utf-8?B?ZEdHSERjMWlNMHJZOEovU25WS1YyZEo5clpsTE1vYlo4MW9nWTN4Y1l0TVRj?=
 =?utf-8?B?amw4VnVYRVpzcFNXcE5LSG5yZUMrK1N6MzhMYzdPcXdDa2xFUGpwL0tFSFhk?=
 =?utf-8?B?WmtwMXdWczYvUGdZV3FUZ212eUFXTis0ck1BeHJKZjBDTmNoUXliQWN0Nmpi?=
 =?utf-8?B?VnRINnowQTRGa05VV2dLaFJvVkJKa0ZtNWJFckN2R25EYklrY2RabmpLRkpR?=
 =?utf-8?B?ZUU5UG4rWGhrZ1VkYlYybExLMnBGakY4Yk14TFN4L2xLYTY0eTU4bDVDaDlR?=
 =?utf-8?B?WjFUSWpPU0d3UnBXOEhDbjFWUHordlcxbytrdW9QMkJwdkVTUzVqOFR1eU5Y?=
 =?utf-8?B?U0RBd095c1lKMWVycEIyaERRUzdwN3daT3hSSU96aTBMSTVueUFYeGUwRFU5?=
 =?utf-8?B?Mk9DV3hKODJQQk9xZVllcUlCeVV0R3FKVDhMMDd4M3VaUURwSG9kTmNMUk9Z?=
 =?utf-8?B?eTFmdVRPbmV0US9RVTNjeDI1bGNsTzRKM0s0Z3ZwZWlmN2V4a3JDeGJpTnp4?=
 =?utf-8?B?QUNlRDVMSVdmV2Q4WDFyVDRSenAxTkZVcGttRklZaUt0a2lZamczQTQxY2lP?=
 =?utf-8?B?azZXRTNSZlpQYmNwNVI4OGNJSmpRVXh4bWxLL1oyQVpYQzYraW5LNU5Pc3JW?=
 =?utf-8?B?TUNwcURpUythZ3ZCcVF1RGc0eFNTVDM3b3JaRW1vZ3NMa0lkSXJ4WTZyTHdF?=
 =?utf-8?B?QzIrTFZWRGt5ajJQalBjcEZteDN5UmszdWdRQzJNMmlzZnZ3OFlGbHNUZnR4?=
 =?utf-8?Q?bjQR++fJ8jGQtMSKDsyyEaZKdt4JzLpdfkpZcgn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46827D44691CE8468DE180A1A7B9415D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f6c5b7-ce22-4ef0-8443-08d919bd2e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 05:24:16.7332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9T/Q4rok1+ZkdPHleGEJos8wtG6vVZJ7gVYP4MPGTjjECx8K7Qf/klZQ4HaJx+AajY7QP7u8z/Fn4t/2SDR8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6960
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXkgMTcsIDIwMjEgYXQgMDE6MTE6MjVQTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiA1LzE2LzIxIDk6NTQgUE0sIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPiBG
cm9tOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IA0KPiA+
IFdoZW4gaHVnZXRsYiBwYWdlIGZhdWx0ICh1bmRlciBvdmVyY29tbWl0dGluZyBzaXR1YXRpb24p
IGFuZA0KPiA+IG1lbW9yeV9mYWlsdXJlKCkgcmFjZSwgVk1fQlVHX09OX1BBR0UoKSBpcyB0cmln
Z2VyZWQgYnkgdGhlIGZvbGxvd2luZyByYWNlOg0KPiA+IA0KPiA+ICAgICBDUFUwOiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIENQVTE6DQo+ID4gDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZ2F0aGVyX3N1cnBsdXNfcGFnZXMoKQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcGFnZSA9IGFsbG9jX3N1cnBsdXNfaHVnZV9wYWdlKCkN
Cj4gPiAgICAgbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYigpDQo+ID4gICAgICAgZ2V0X2h3cG9pc29u
X3BhZ2UocGFnZSkNCj4gPiAgICAgICAgIF9fZ2V0X2h3cG9pc29uX3BhZ2UocGFnZSkNCj4gPiAg
ICAgICAgICAgZ2V0X3BhZ2VfdW5sZXNzX3plcm8ocGFnZSkNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHplcm8gPSBwdXRfcGFnZV90ZXN0emVybyhwYWdlKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVk1fQlVHX09OX1BBR0UoIXpl
cm8sIHBhZ2UpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnF1
ZXVlX2h1Z2VfcGFnZShoLCBwYWdlKQ0KPiA+ICAgICAgIHB1dF9wYWdlKHBhZ2UpDQo+ID4gDQo+
ID4gX19nZXRfaHdwb2lzb25fcGFnZSgpIG9ubHkgY2hlY2tzIHBhZ2UgcmVmY291bnQgYmVmb3Jl
IHRha2luZyBhZGRpdGlvbmFsDQo+ID4gb25lIGZvciBtZW1vcnkgZXJyb3IgaGFuZGxpbmcsIHdo
aWNoIGlzIHdyb25nIGJlY2F1c2UgdGhlcmUncyBhIHRpbWUNCj4gPiB3aW5kb3cgd2hlcmUgY29t
cG91bmQgcGFnZXMgaGF2ZSBub24temVybyByZWZjb3VudCBkdXJpbmcgaW5pdGlhbGl6YXRpb24u
DQo+ID4gDQo+ID4gU28gbWFrZXMgX19nZXRfaHdwb2lzb25fcGFnZSgpIGNoZWNrIHBhZ2Ugc3Rh
dHVzIGEgYml0IG1vcmUgZm9yIGEgZmV3DQo+ID4gdHlwZXMgb2YgY29tcG91bmQgcGFnZXMuIFBh
Z2VTbGFiKCkgY2hlY2sgaXMgYWRkZWQgYmVjYXVzZSBvdGhlcndpc2UNCj4gPiAibm9uIGFub255
bW91cyB0aHAiIHBhdGggaXMgd3JvbmdseSBjaG9zZW4uDQo+ID4gDQo+ID4gRml4ZXM6IGVhZDA3
ZjZhODY3YiAoIm1tL21lbW9yeS1mYWlsdXJlOiBpbnRyb2R1Y2UgZ2V0X2h3cG9pc29uX3BhZ2Uo
KSBmb3IgY29uc2lzdGVudCByZWZjb3VudCBoYW5kbGluZyIpDQo+ID4gU2lnbmVkLW9mZi1ieTog
TmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiBSZXBvcnRlZC1i
eTogTXVjaHVuIFNvbmcgPHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbT4NCj4gPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZyAjIDUuMTIrDQo+ID4gLS0tDQo+ID4gQ2hhbmdlTG9nIHY0Og0KPiA+
IC0gYWxsIGh1Z2V0bGIgcmVsYXRlZCBjaGVjayBpbiBodWdldGxiX2xvY2ssDQo+ID4gLSBmaXgg
YnVpbGQgZXJyb3Igd2l0aCAjaWZkZWYgQ09ORklHX0hVR0VUTEJfUEFHRQ0KPiA+IC0tLQ0KPiA+
ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgMTAgKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgdjUuMTIvbW0vbWVtb3J5
LWZhaWx1cmUuYyB2NS4xMl9wYXRjaGVkL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gPiBpbmRleCBh
MzY1OTYxOWQyOTMuLjc2MWY5ODJiNmQ3YiAxMDA2NDQNCj4gPiAtLS0gdjUuMTIvbW0vbWVtb3J5
LWZhaWx1cmUuYw0KPiA+ICsrKyB2NS4xMl9wYXRjaGVkL21tL21lbW9yeS1mYWlsdXJlLmMNCj4g
PiBAQCAtMTA5NCw2ICsxMDk0LDE2IEBAIHN0YXRpYyBpbnQgcGFnZV9hY3Rpb24oc3RydWN0IHBh
Z2Vfc3RhdGUgKnBzLCBzdHJ1Y3QgcGFnZSAqcCwNCj4gPiAgc3RhdGljIGludCBfX2dldF9od3Bv
aXNvbl9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcGFnZSAq
aGVhZCA9IGNvbXBvdW5kX2hlYWQocGFnZSk7DQo+ID4gKwlpbnQgcmV0ID0gMDsNCj4gPiArDQo+
ID4gKyNpZmRlZiBDT05GSUdfSFVHRVRMQl9QQUdFDQo+ID4gKwlzcGluX2xvY2soJmh1Z2V0bGJf
bG9jayk7DQo+ID4gKwlpZiAoUGFnZUh1Z2UoaGVhZCkgJiYgKEhQYWdlRnJlZWQoaGVhZCkgfHwg
SFBhZ2VNaWdyYXRhYmxlKGhlYWQpKSkNCj4gPiArCQlyZXQgPSBnZXRfcGFnZV91bmxlc3NfemVy
byhoZWFkKTsNCj4gPiArCXNwaW5fdW5sb2NrKCZodWdldGxiX2xvY2spOw0KPiA+ICsJaWYgKHJl
dCA+IDApDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArI2VuZGlmDQo+IA0KPiBJIG11c3QgYmUg
bWlzc2luZyBzb21ldGhpbmcuDQo+IA0KPiBUaGUgYWJvdmUgY29kZSBtYWtlcyBzdXJlIHRoZSBw
YWdlIGlzIG5vdCBpbiBvbmUgb2YgdGhlc2UgdHJhbnNpdGl2ZQ0KPiBodWdldGxiIHN0YXRlcyBh
cyBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLiAgSXQgb25seSBhdHRlbXB0cw0KPiB0
byB0YWtlIGEgcmVmZXJlbmNlIG9uIHRoZSBwYWdlIGlmIGl0IGlzIG5vdCBpbiBvbmUgb2YgdGhl
c2Ugc3RhdGVzLg0KPiANCj4gSG93ZXZlciwgaWYgaXQgaXMgaW4gc3VjaCBhIHRyYW5zaXRpdmUg
c3RhdGUgKCFIUGFnZUZyZWVkKGhlYWQpICYmDQo+ICFIUGFnZU1pZ3JhdGFibGUoaGVhZCkpIHdl
IHdpbGwgZmFsbCB0aHJvdWdoIGFuZCBleGVjdXRlIHRoZSBjb2RlOg0KPiANCj4gCWlmIChnZXRf
cGFnZV91bmxlc3NfemVybyhoZWFkKSkgew0KPiAJCWlmIChoZWFkID09IGNvbXBvdW5kX2hlYWQo
cGFnZSkpDQo+IAkJCXJldHVybiAxOw0KPiANCj4gU28sIGl0IHNlZW1zIGxpa2Ugd2Ugd2lsbCBh
bHdheXMgZG8gYSBnZXRfcGFnZV91bmxlc3NfemVybygpIGZvcg0KPiBQYWdlSHVnZSgpIHBhZ2Vz
Pw0KDQpSaWdodCwgbm8gbmVlZCB0byBmYWxsIHRocm91Z2ggaW4gc3VjaCBhIGNhc2UuDQoNCj4g
DQo+IEFsc28sIGR1ZSB0byBjb21taXQgZGI3MWVmNzliNTliICgiaHVnZXRsYjogbWFrZSBmcmVl
X2h1Z2VfcGFnZSBpcnENCj4gc2FmZSIpIHlvdSBuZWVkIHRvIG1ha2Ugc3VyZSBpbnRlcnJ1cHRz
IGFyZSBkaXNhYmxlZCB3aGVuIHRha2luZw0KPiBodWdldGxiX2xvY2suDQoNClRoYW5rcywgSSds
bCByZWJhc2UgdG8gbGF0ZXN0IG1haW5saW5lIGFuZCBjb21wbHkgd2l0aCBuZXcgc2VtYW50aWNz
Lg0KDQotIE5hb3lh
