Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196EE3F948C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 08:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbhH0Gur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 02:50:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58654 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229611AbhH0Gup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 02:50:45 -0400
X-UUID: 4ee35da79d684fd0ab2c16a9b0e705b5-20210827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UD81GlPUaoDKdwsKH4lkwO96oYOhl/GykrQ+frjhVZM=;
        b=ktMe+oD/TltRvhKnEOn1vNMbAO82BGY1uyi864D003JrCEMPg7BuR7Sn7X/hoEX2mJB4NjnbPtBF2vh6wJNkcZHFriB4v1c0LiCgOQcmTwCEdhBW/7NoAa3DKLhC07s/Bs2xWRakUbyeR/lrk2QtM8cR+XJ00o67CoTp9PnNswc=;
X-UUID: 4ee35da79d684fd0ab2c16a9b0e705b5-20210827
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 376932425; Fri, 27 Aug 2021 14:49:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Aug 2021 14:49:42 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 27 Aug 2021 14:49:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZdQv+EOJM/o0rUL3E6ORorH4/CHj+Wke6uR/g8uqMITQppBZQ9szmkXJkpqerbmAmAzL/ATmFVJWy1yCiisJvqwZGZU91H4oudYZO3ciL5ZoEFo+zyUEMovNGtwvEE3cXm418uMULwUV7QX4FhYo0nwioN1gYVOQpoHWLIQPlKO083nCGoWIM4866FXK6jBfWtSiFhYCC5Z19x2m2+vIBr40DkzG9oA6A9rYCXe9KFh1aaGkFUj2uhCc0c3htxiWQT8Pm3383IrXSTCFeUBWDDe3vqwuEAKV6pBK4g+8J0w8t2xouFtnhdqsxGGnRqb4OKB9c7qCznn6N3m5qkvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UD81GlPUaoDKdwsKH4lkwO96oYOhl/GykrQ+frjhVZM=;
 b=Y+dvfsBfF4S4ZoMjOQm4yO1nwDuqhtfEqVal580bLeVwIc9kIYOZW+YSpjmzIvH9rcHIO0Ulnltz8UlfcyLKyb09xpSjOW2YbD5N3DKmW++4ehAVV0layVDHXQbzhOkegTkQen7v0EUSxyNTauxDooY7L2Yh24/Yv5pgcwrsF2f/LhQFQifj5Yqtem31CGS5x4LYv/0ptVXr8zI4dskRzYOkaP2x0wuJb74KLcAVNKO94FkJpR4zocP4EvgYSHxb/J5wA5IW18DJ5I2f30oOhiQ6VzDYzOLm56rGXWSWi0uwDjSI9RJSBAxbTLOTO8nmQhmwp9WhRNz6+AoOKRc15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD81GlPUaoDKdwsKH4lkwO96oYOhl/GykrQ+frjhVZM=;
 b=Khh6QiaYORT8OyF3hE5q9HbcG38qEhuBDR+hCJfIssZ4iXS/VrhYYin9wqCfSfZIgn0RzBaT2gY92lwqNNevGvue7HdtuGpdbO05WFSl9QpHrKFhO1f+FXGxvLH3H2nlyK18z8qyajq0u7hpqM6MCC5YZRzCqiUFXnJG1BKQEG8=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR03MB6228.apcprd03.prod.outlook.com (2603:1096:820:8e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.9; Fri, 27 Aug
 2021 06:49:28 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c%7]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 06:49:27 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "ikjn@chromium.org" <ikjn@chromium.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        =?utf-8?B?WWFxaWkgV3UgKOatpuS6muWlhyk=?= <Yaqii.Wu@mediatek.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH next v2 3/6] usb: xhci-mtk: update fs bus bandwidth by
 bw_budget_table
Thread-Topic: [PATCH next v2 3/6] usb: xhci-mtk: update fs bus bandwidth by
 bw_budget_table
Thread-Index: AQHXmiVZCYpp+DFuZEGdWMiTnTLyNKuFrdcAgAE9OgA=
Date:   Fri, 27 Aug 2021 06:49:27 +0000
Message-ID: <72ee7a203d8a49e6e43a954b45133470ee6d5c16.camel@mediatek.com>
References: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
         <20210826025144.51992-3-chunfeng.yun@mediatek.com>
         <CAATdQgBD+dTtBie-cNKRJbfxEpc3haqjfUu1k26mTk8pCSOEww@mail.gmail.com>
In-Reply-To: <CAATdQgBD+dTtBie-cNKRJbfxEpc3haqjfUu1k26mTk8pCSOEww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77a49dd3-0d12-43f4-4767-08d96926d087
x-ms-traffictypediagnostic: KL1PR03MB6228:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1PR03MB6228F75DC4FFD6861D42A35AFDC89@KL1PR03MB6228.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7A/FcV8mwwiw2qlK/foabJS970DMN2C7aWpyWXSWdPLFLUeRH1QoCX+VtC6FRZo2ebZM+LYiEVtRuF2CyoWMkqzbs7e1mfqPt+BWG1lw6pV8CsCkUaXOnyyhKtkZV6JpPa0ZcD/xVEHb03+ueyBjRitqrJiFcmSFIgw5MamqwPt8BEkdYgKGZ99uz4Dq3wRgyY1onuZrRFyyXZ/DfymvcnRm9Jfz0DMdVIklzXc4xcxJ6PO6HhEpMO/GOG9eXtRCFNafuY+e2d92x6t4dinGJuYzSwq+SoD+vOb/00kWANJKuWso/FoVSmmmzYsDUXO1Vrgx4T7PHVLuB3aJxX5W4AQnSy3PzsZUL8liWFLV2+qJfMQLY1bUM4Ghb66yBOYIuEdBFUSQrtmWmkPITIb1jkU4meAbIcKfPkdeJK7PfZn8IMLrkx3YZ0bFMM114Nz8mQUqMWZIB8meHCGvJfZkDUAf7X/PTIl8pbAGH2JGUWGSZzFqH7qh+ZIjDSQv+0h4XhubPwtqozeOAfNA/Wnqb9r21gVUKadQ7xsXuoCQh1pP4c0t/4qE2QgkuPpTmCtPFMB6t27vw16xpyve3pdYCzbzIVMW20wvNtkdiqgUGpyQZ0+qs5ojT2EuqveQWRFVwz8jIUbNUJnF5ntnthnRTIrdrZo76aJg8NGe54/r9aVoyiJLBbgJqsZ8GC5LNFo9vwvqb78V5R2dEZthIfBOYHU9ArcXK3SOBRYvGTxi53Cina0lk8FVMI5uNSe/qAJvBCkNW9+9LMh3FzhFfcOO7ZeR9H5c7ZgUJ0yQgugO91s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(508600001)(15650500001)(6916009)(85182001)(66556008)(6512007)(6486002)(53546011)(36756003)(86362001)(38070700005)(8676002)(6506007)(2906002)(64756008)(66446008)(83380400001)(66946007)(5660300002)(76116006)(26005)(4326008)(2616005)(91956017)(316002)(66476007)(186003)(54906003)(38100700002)(71200400001)(122000001)(99106002)(414714003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWNQZThsV21nUGJaeVlBNjdJendnRnI4QUlUOHFXZ2RDN0ZmblI0eEN1NW5w?=
 =?utf-8?B?WnVNTkFTU2NlL0NKR1VEZ2N0SCttTS9kb1pqZGF4cEdXT1puWGRmcDJpbEdV?=
 =?utf-8?B?WCtmZmtRd0FNRzZ0UU1pM25FLzJXSGxiQyt5WEpva0JMbXZDbFdZUERqQWZh?=
 =?utf-8?B?WXA5WnMxQjg2OWptTmZrN1lMQkpaOEdQY3JCczFaU0xLL2dNSExhNVN1bHo1?=
 =?utf-8?B?TTNIbmVrK0tKNC83VVdET0dvV1ZNUkg3RzVZU3FLaWVTSktscWhaYkZUT2VG?=
 =?utf-8?B?bkNwU2RxZ2FSMlAyaTVqOVdnMUNJeUh3QTV6TWc1djZRSjdzNERBUFFzUEVN?=
 =?utf-8?B?SEJTV0NTb0V6ZnlXV244RVVCaWZ2YkFvTjV5RDg3NFZzMENrZ3NUNWl0REpB?=
 =?utf-8?B?TXpXQlQ3RjB5My9BcmpUdzJiaGNGM1phQjYwMDNGUWZMRGxab1hJMVhUYml6?=
 =?utf-8?B?NldRMHB0ck9aNE1nNFZza3g4bDZ4c3laY3lnTWIzZ3UydlZ3V3hSVUVpK2t4?=
 =?utf-8?B?Mm9zSnBIVXRNVzVQRUI2MFkyWUpPaEZJKzREQkNCQTBZWjhFL2g2OWlGclBa?=
 =?utf-8?B?VmtFQXFkbm1adlQxS1RnNlFBbUZGWDk4bkJJUjUyT2tWMmFwaWt0T2VwOEtS?=
 =?utf-8?B?NllyalIvUDhvQWRlVjUxVU9JaXVWdldveE44Vmt4R2xnemJ6dzRDZGY4SWtx?=
 =?utf-8?B?S0d4MitGQlZnaTRBM2dwYlNNdWVmQ25iT2JkT3ZhcGZsakp3K2VFcjZuVFVn?=
 =?utf-8?B?U1RRSVRjazZMK2tBb0N1UTdPVldTNEhFWjEwblhxaEY4TENlbGVRK1gyWVZH?=
 =?utf-8?B?eHQrL0xmUHBTTXhtZ05tQnFuczE4RGVmb3RsRURRYWJqQ2FQRGVLdjRpSzd6?=
 =?utf-8?B?YUlmRXRtMk0xUFZKSktLaG5meFNNdXJObDBrZDlvTEdySldwMFdyYXA0RTNi?=
 =?utf-8?B?eXduTlpkUzFLN0V6Z1NldEF2cHVXVWV3ell3VzBOcDRDeVVXeHBNZ290Umcr?=
 =?utf-8?B?a09Gb3NnN0VTQVpRanpEMDZNa1UvNnIwSnJGeHNEMlA1eUNEeUtwKzBXZHBs?=
 =?utf-8?B?Qkt1SHFoTUJBM3o5WDFWM05VZGFtRWJlbjZmWUt4OVQxekZ6UGg3dnc1c2ht?=
 =?utf-8?B?ZnJvUUxkVWdMYW1PYzFsRWlrSEdWWnN0WEVsTFFJSVo4dDNCNkpuK0hlU0wx?=
 =?utf-8?B?L2k3eGM2djdKeHJ3QmxyZVRZa0F6c0wxOUYySllsZkZxL0dYQWllL2VFcEpz?=
 =?utf-8?B?YnN1aU5aNWFjK1VXM3cyUWNaMUJhZHJwM3ZJRTNobEVKa05oS3dPN3I2ZnpH?=
 =?utf-8?B?Mld5UG5NR0tuaFNEL2xIb09vVGhBNUpOa3FTVnY1TFpNbUlMUzRFcVhFUStt?=
 =?utf-8?B?Q2t3dUU4U2pIKzhPdWFWV0NmS3BURXFNQXAvVlo5NitwQUdzaG1ZU1JPdnJr?=
 =?utf-8?B?WWJIYXJ3NStwTjB0ZjVveEJoZmpONVhQanB4VnVBeGIwMU9ZRWpocGxuQ21q?=
 =?utf-8?B?N3NoOGhVOVRBT0F4ZDlVQkNNK3djRW51RUVMcm9Zbnc4dzFRQVJrZWlDNndu?=
 =?utf-8?B?NFBHZkovRGdEbElaSkV2Mll3bFZ1ZmZLUk5vVUpXRXBUczQxT2M5M0UvbW1k?=
 =?utf-8?B?M3pZUkJOR3VycFhxZ3R6MGcyYnlEZFNrT1BWSnZ6YlZtNXh0blhwTWJsOWZI?=
 =?utf-8?B?WHUvNWt5VThHYkI4bFNLTVRsRnZDWm9zUnozWExsQnR4amc4U2NzVFlIRFRV?=
 =?utf-8?Q?NlmDodGtBzFr59QJHrysbiV39QB/JFKcHUr7cBY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4914202AB55BC348B3508C353F5ECC4F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a49dd3-0d12-43f4-4767-08d96926d087
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 06:49:27.6786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: feWuG61BQnqB37ZmmsVDBnv4oiJ/iqvFKwLfKH/FsfkAhJ2NkR7mHoKwP4lBCM/zYp9T170/G2DN0YZ9ZOFOvS9jgMB02C4XK5c8i0Z1X7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6228
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA4LTI2IGF0IDE5OjU0ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
SGkgQ2h1bmZlbmcsDQo+IA0KPiBPbiBUaHUsIEF1ZyAyNiwgMjAyMSBhdCAxMDo1MiBBTSBDaHVu
ZmVuZyBZdW4gPA0KPiBjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4g
PiBVc2UgQGJ3X2J1ZGdldF90YWJsZVtdIHRvIHVwZGF0ZSBmcyBidXMgYmFuZHdpZHRoIGR1ZSB0
bw0KPiA+IG5vdCBhbGwgbWljcm9mcmFtZXMgY29uc3VtZSBAYndfY29zdF9wZXJfbWljcm9mcmFt
ZSwgc2VlDQo+ID4gc2V0dXBfc2NoX2luZm8oKS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBD
aHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjI6
IG5ldyBwYXRjaCwgbW92ZSBmcm9tIGFub3RoZXIgc2VyaWVzDQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMgfCAxNyArKysrKysrLS0tLS0tLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYw0KPiA+IGIvZHJp
dmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYw0KPiA+IGluZGV4IGNmZmNhZjRkZmE5Zi4uODNh
YmQyODI2OWNhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2No
LmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5jDQo+ID4gQEAgLTQ1
OCw4ICs0NTgsOCBAQCBzdGF0aWMgaW50IGNoZWNrX2ZzX2J1c19idyhzdHJ1Y3QNCj4gPiBtdTNo
X3NjaF9lcF9pbmZvICpzY2hfZXAsIGludCBvZmZzZXQpDQo+ID4gICAgICAgICAgICAgICAgICAq
IENvbXBhcmVkIHdpdGggaHMgYnVzLCBubyBtYXR0ZXIgd2hhdCBlcCB0eXBlLA0KPiA+ICAgICAg
ICAgICAgICAgICAgKiB0aGUgaHViIHdpbGwgYWx3YXlzIGRlbGF5IG9uZSB1ZnJhbWUgdG8gc2Vu
ZA0KPiA+IGRhdGENCj4gPiAgICAgICAgICAgICAgICAgICovDQo+ID4gLSAgICAgICAgICAgICAg
IGZvciAoaiA9IDA7IGogPCBzY2hfZXAtPmNzX2NvdW50OyBqKyspIHsNCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICB0bXAgPSB0dC0+ZnNfYnVzX2J3W2Jhc2UgKyBqXSArIHNjaF9lcC0NCj4g
PiA+YndfY29zdF9wZXJfbWljcm9mcmFtZTsNCj4gPiArICAgICAgICAgICAgICAgZm9yIChqID0g
MDsgaiA8IHNjaF9lcC0+bnVtX2J1ZGdldF9taWNyb2ZyYW1lczsNCj4gPiBqKyspIHsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICB0bXAgPSB0dC0+ZnNfYnVzX2J3W2Jhc2UgKyBqXSArIHNj
aF9lcC0NCj4gPiA+YndfYnVkZ2V0X3RhYmxlW2pdOw0KPiANCj4gSSdtIHdvcnJ5aW5nIGFib3V0
IHRoaXMgY2FzZSB3aXRoIHR3byBlbmRwb2ludHMsDQo+ICogRVAxT1VUOiBpc29jaHJvbm91cywg
bWF4cGFja2V0PTE5MjogYndfYnVkZ2V0X3RhYmxlW10gPSB7IDE4OCwgMTg4LA0KPiAwLCAuLi4g
fQ0KPiAqIEVQMklOOiBpbnRlcnJ1cHQsIG1heHBhY2tldD02NDogYndfYnVkZ2V0X3RhYmxlW10g
PSB7IDAsIDAsIDY0LCA2NCwNCj4gLi4uIH0NCj4gKElzIHRoaXMgY29ycmVjdCBid19idWRnZXRf
dGFibGUgY29udGVudHMgZm9yIHRob3NlIGVwcz8pDQpZZXMsIGVwMW91dCBpc29jIHVzZSB0d28g
dWZyYW1lLCBlcDJpbiBpbnRyIHVzZSBhIGV4dHJhIGNzOw0KPiANCj4gSSdtIG5vdCBzdXJlIGlm
IGl0J3Mgb2theSBmb3IgdGhvc2UgdHdvIGVuZHBvaW50cyB0byBiZSBhbGxvY2F0ZWQNCj4gb24g
dGhlIHNhbWUgdS1mcmFtZSBzbG90Lg0KPiBDYW4geW91IHBsZWFzZSBjaGVjayBpZiB0aGlzIGlz
IG9rYXkgZm9yIHhoY2ktbXRrPw0KQWxyZWFkeSB0ZXN0IGl0IHRoaXMgYWZ0ZXJub29uLCBjYW4g
dHJhbnNmZXIgZGF0YSByaWdodGx5IG9uIG91ciBkdnQNCmVudi4NCg0KPiAoSSBmZWVsIGxpa2Ug
SSBhbHJlYWR5IGFza2VkIHRoZSBzYW1lIHF1ZXN0aW9ucyBtYW55IHRpbWVzLikNClllcywgYXMg
c2FpZCBiZWZvcmUsIHByZWZlciB0byB1c2UgYndfYnVkZ2V0X3RhYmxlW10sIGlmIHRoZXJlIGlz
DQppc3N1ZSwgd2UgY2FuIGZpeCBpdCBieSBidWlsZGluZyB0aGlzIHRhYmxlLg0KDQpUaGFua3MN
Cj4gDQo+IA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh0bXAgPiBGU19QQVlMT0FE
X01BWCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRVNDSF9C
V19PVkVSRkxPVzsNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+IEBAIC01MzQsMjEgKzUzNCwx
OCBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfc2NoX3R0KHN0cnVjdA0KPiA+IG11M2hfc2NoX2VwX2lu
Zm8gKnNjaF9lcCwgYm9vbCB1c2VkKQ0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgbXUzaF9z
Y2hfdHQgKnR0ID0gc2NoX2VwLT5zY2hfdHQ7DQo+ID4gICAgICAgICB1MzIgYmFzZSwgbnVtX2Vz
aXQ7DQo+ID4gLSAgICAgICBpbnQgYndfdXBkYXRlZDsNCj4gPiAgICAgICAgIGludCBpLCBqOw0K
PiA+IA0KPiA+ICAgICAgICAgbnVtX2VzaXQgPSBYSENJX01US19NQVhfRVNJVCAvIHNjaF9lcC0+
ZXNpdDsNCj4gPiANCj4gPiAtICAgICAgIGlmICh1c2VkKQ0KPiA+IC0gICAgICAgICAgICAgICBi
d191cGRhdGVkID0gc2NoX2VwLT5id19jb3N0X3Blcl9taWNyb2ZyYW1lOw0KPiA+IC0gICAgICAg
ZWxzZQ0KPiA+IC0gICAgICAgICAgICAgICBid191cGRhdGVkID0gLXNjaF9lcC0+YndfY29zdF9w
ZXJfbWljcm9mcmFtZTsNCj4gPiAtDQo+ID4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbnVtX2Vz
aXQ7IGkrKykgew0KPiA+ICAgICAgICAgICAgICAgICBiYXNlID0gc2NoX2VwLT5vZmZzZXQgKyBp
ICogc2NoX2VwLT5lc2l0Ow0KPiA+IA0KPiA+IC0gICAgICAgICAgICAgICBmb3IgKGogPSAwOyBq
IDwgc2NoX2VwLT5jc19jb3VudDsgaisrKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHR0
LT5mc19idXNfYndbYmFzZSArIGpdICs9IGJ3X3VwZGF0ZWQ7DQo+ID4gKyAgICAgICAgICAgICAg
IGZvciAoaiA9IDA7IGogPCBzY2hfZXAtPm51bV9idWRnZXRfbWljcm9mcmFtZXM7DQo+ID4gaisr
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICh1c2VkKQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdHQtPmZzX2J1c19id1tiYXNlICsgal0gKz0gc2NoX2VwLQ0K
PiA+ID5id19idWRnZXRfdGFibGVbal07DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZWxz
ZQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHQtPmZzX2J1c19id1tiYXNl
ICsgal0gLT0gc2NoX2VwLQ0KPiA+ID5id19idWRnZXRfdGFibGVbal07DQo+ID4gICAgICAgICB9
DQo+ID4gDQo+ID4gICAgICAgICBpZiAodXNlZCkNCj4gPiAtLQ0KPiA+IDIuMTguMA0KPiA+IA0K
