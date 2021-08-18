Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB63EFCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbhHRGg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:36:59 -0400
Received: from mail-eopbgr1400040.outbound.protection.outlook.com ([40.107.140.40]:3840
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238345AbhHRGgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:36:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nniacDKcPyGt/4x51E+uKViCOTbEWdWxkM+ZkqtioKgCXXxQsIOPjLdF0pFNIOhpv5fsH2Mj9L16A3A0Amr9oRM+vVw/SLhQDA8KccEY7KFuWcvIhwG7Z7YMDZahzzoE02qs5ZFRFHfcXMTl+wkIWwVO6df7qU3LBGnTJlszOxVauyUp383uaiu/PkY5xzAib/YWYS+LvKvS2sG0M6xHeUpq6kKRqwbgZCvTX9Lkn0MyClXPgiNgBY6nwOmULg8dWKGMDRM5I722JPrBXJuRGp4WVK36ympzu45mUfnHfCWlBJR/5mI64zMZPRULimJflKfF7sRGVNL/7yTc+8Sjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVh/Wj4Sfn3twqiosmfpKtQgkP6Y5+0WOsFTooXosYg=;
 b=QtmNtVgRtTxxTNDl4CaekltGZuazC/MamftLlgtvBMOk85gXOHXUy3uyF6OR8/+231vGERa6I6/gimoGtrYA8rtgdM1WPZ0R72fgE3PNb9uOcr9iDNw786mXC+7Fh1mbvtOwnt0ra88SOI5FFWY6UsT+3kCqXk2JTix22CJsEm7TLt9z+LZSbFoYWlJ7U9iv9RXqiKuuuVZ/LjutQDR29uWLSA+vXOjLOobS/sWi9UTVORQq6RlmSxNzKX00R9TOhQsDxTgH5SOtYjyq8bgp8YLV4tjTgDis/32iBYJLikzEXQPU4kLjuxB8xKRot1UcDZM+Z/4ygpV16Oabrki6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVh/Wj4Sfn3twqiosmfpKtQgkP6Y5+0WOsFTooXosYg=;
 b=d6MNLqntCLg2aZRRNm2RpwHQBGBykjdcb7I3zRgg10c3DiWeTW+oW43smuaRyOfH0vqF18NZVgkBDMbSdmkvD1LGT9KzpXE4WEBiE1wYmFAel36GDCGH14zSGXVnh8H3SmAuoygFKgxVWsR1QFq7oJmMEwz6p10hLNWD/DrTlLk=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 18 Aug
 2021 06:36:07 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 06:36:07 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "osalvador@suse.de" <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] doc: hwpoison: correct the support for hugepage
Thread-Topic: [PATCH 2/2] doc: hwpoison: correct the support for hugepage
Thread-Index: AQHXksnWSucmiPZmmU+U59EF+iniwat40RKA
Date:   Wed, 18 Aug 2021 06:36:07 +0000
Message-ID: <20210818063607.GA501393@hori.linux.bs1.fc.nec.co.jp>
References: <20210816180909.3603-1-shy828301@gmail.com>
 <20210816180909.3603-2-shy828301@gmail.com>
In-Reply-To: <20210816180909.3603-2-shy828301@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4ce9316-5338-419b-bc73-08d962127614
x-ms-traffictypediagnostic: TYCPR01MB5936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB593650738C7EA1DA99CD33B2E7FF9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G55FcdkggHsICC6KrnlNyfOcC2YiqjYjnelZQ4LpbFGpo9p/Nf0dFcJURLEQtl+og/XPZjaM8IpZJSofaluNMGnKYU/nUvzQSoNkb41qpMsI3YKtOMe9O//hQ32pNkoGLdHNYTBGia7F6ACqZoiqoB0tuIkPXEY/pmjvnBe2MsuIV4YYaUKQlQu7sAw1NcxKv6CQa7MnzoWZXsfLdoZcykyAocUIfvWHdNI9Q5gIowwodZ4ctoK2vs7w83qQLcjfZ7hBKeHwxjiS4I6r+2W/AOlx5Bsn8Z6ufA3Eb6gNeEs2RpRXupBm0tATB1uIOB2fBaRFn9a71t+QP+N46Vy5DsDtua1/P0O2ScmGn7FMNH6h53iUK4P+sKH6bQlPfa3gIPoSLsxmSk/bYHQMJNn4FoLB/OZe74r1EIV2rEw8cKIvIx6PnX+ayCrIfJrncaJzx0hFzfR0pqOmTvuSUL2LSUAasiLIvi+YOZIJS4G1EFXXxQwFBwdLnYgFdVsTFuI0AIRJz6O0iK5xnESh9f5H3p1jqVYoVFoYdUBtU/3xH8/dfLj5+23eNTbcvCVg/lZr8VId1G6m+B3q7E+G9DyqTpTTLPTv/nyLs/YtHhE3aojOhtTyX8aj39CdtsaNTWkMQ5SRCy4f1C4myjhfx3WR95LWmkxJAWhN8tg2m6q9HexMya95BfRUHvR/E3ah8swMu4nXV5vMntZw+zb/OafRZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39850400004)(376002)(38070700005)(66946007)(38100700002)(66446008)(4744005)(85182001)(64756008)(66556008)(122000001)(33656002)(186003)(5660300002)(66476007)(2906002)(76116006)(54906003)(6916009)(6506007)(71200400001)(55236004)(6512007)(1076003)(26005)(6486002)(86362001)(478600001)(4326008)(8676002)(9686003)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU5KL3pRdzMzSmZRSnN3OWlyMlRoWkR4MEplYnVwSlhGTGdVOUFIL3daY014?=
 =?utf-8?B?WFUrc1N2ZFdNQXZLaWQxNUc3UUxFTVhDM2pQRzg3eEE0VmNyUWMremZnblJ5?=
 =?utf-8?B?NWdUQlhjWFUvbmcxMmJUQkhvS3hsU09kZjY5OGRxUWRXRUtWdUdCaE00RDRm?=
 =?utf-8?B?TnM0SGxMTHNBMDNlVEdPejZWVFpNZVZkdk1IeWtQdkJEYTBaL3MrOENHTWVr?=
 =?utf-8?B?RUJoS1VNdHN6WlZCUlpIbzA1UU5Sb0duU1ZaQU5XeWwxc1ZtdW5Dd24rMEww?=
 =?utf-8?B?elBYbUVxYVJNQnJUUjFhaUNWM2svTjY5NDlSeEwyamhFTytVQ2o0YlgzZXhk?=
 =?utf-8?B?TStzcnlyYVl2clhBTk16d1VpcE5vdnRuOTEvWVZmYlN5WkpSV0NQeVdpZG1r?=
 =?utf-8?B?WXhxblNXY0VoSWRvT2NraS82NGJCVitRMkRveFBPblNvTTF6Vm5rc3A1aDUz?=
 =?utf-8?B?SGhWOEZBQWgxUk1zaDUvLzJBTWdEMUtqK1ZXVGxVTW9aZ3F2UGxzZmxBNEZi?=
 =?utf-8?B?WDUzVWdIakNMZG5SdnhTbjlUclh2L0ZJMVQxSjdaRjhqcTA4bzFFa2MrYysv?=
 =?utf-8?B?NTJKSlY0MEhVV2RHSlFZUDAzSGxEeTVvcUo0NXBBVFlaaUR2ZXVxelcvVHZi?=
 =?utf-8?B?SUhFakwralNGM29PdjVnenhoTjRCcFcrdjFXNTE0Mkl2UkttWWc1MU1VQ2c1?=
 =?utf-8?B?QVc4RTVwd2R1blM4WmJrbGZuTnRFcENtUmNKWXQyNUpzenY0Mm1iblhQSFRF?=
 =?utf-8?B?eEtldnU2ZUZkOFFHZXkrZllrNVFkVjRjaXNlOUUwZjBFcUQxbk80alVob2Yv?=
 =?utf-8?B?ZVh6TWVDYk9oNDJaR1gydG1ub3RJdFE4MHdhbWdFQUh2alFGM0JtQU9NdUdQ?=
 =?utf-8?B?UU9yUFhzUVFRRTkrVDZ1OFd6ODhtejNSZW4yV2wxQ3FSemQ0MXEva0RWRkF5?=
 =?utf-8?B?SHpBenFQU1hIN1FhZFhJYkFKTUhzM0tSYlpMSVpJVGNiSUxYM1JQUEpaUFEr?=
 =?utf-8?B?R0hOT2d5TFY2bUdqUWlQbjNaS053dHR0T2FGUkdpcmU0bUNVQVM2SEpSWUNQ?=
 =?utf-8?B?M2FHbk1kb3dqODNZQnlMbVF3Y05zcXEvRTdxNzhVWDZ5bERydFB6WnJxMldl?=
 =?utf-8?B?Q20wdnowckVCV3g1UGsyTzNsdUNscWhwTDExN2YzaHR5NkVvQXRZVWhHL1pC?=
 =?utf-8?B?cmMxRndEZVFIVHJKcnJQanYycU5lWjJoVVU2QmNZcTNlWFV4NmNLQXo2WlY0?=
 =?utf-8?B?V2dFazRjL25sSmg1SHFuMnNtdFZENHUvZkNXQ0JxcDZWbXNKOWZmOHhwTnV1?=
 =?utf-8?B?RlUxTnVoZ2lIVWk3WWRqcjF6Z0picG9USjBHRUdsaC9hZFFiRVhWZjZGcS9r?=
 =?utf-8?B?Q01lSzdsTDFKbEVKU0lpTDI3OTFWUmRFT3Ywak1mVm5wNFAvbnRjenBxbjhm?=
 =?utf-8?B?L0srVEE0QUF6U0hic2tYN3I3bTZ2dEg5eDhNYTBsemJoOE00ZEw0LzRtZngx?=
 =?utf-8?B?aFVXWXhjZXNFVXd1cXhhY3RtQTBlZkNXNE02ZXUySXNUb2t2allvTGwyenZ4?=
 =?utf-8?B?dHVJVzRSWC9LZkpqeVplY28xdEhVblEzSnUwODV4dW93d3g4STNESFE4bHhi?=
 =?utf-8?B?SE45bmhhK0JwcmNSbDYyTTRhMzFvMENuZE5CcGhaSUZYOW91T3hqTlo2aW44?=
 =?utf-8?B?R05ha2tFQkI1NUxUOU1ZR3N1bGFydE9DLzlYUzRhL1diQ0NjNWQ2bjNIWXNW?=
 =?utf-8?Q?Yhe6dZy6BmE3euG63k4Hbi6IKvFbkNuX9+uP16C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56A8D2A788D5744C91C1D2BD267F2309@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ce9316-5338-419b-bc73-08d962127614
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 06:36:07.9099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayogrV93MithiivhcIvbNIXQLjo/taqn7DbLf8aKGmD8YDS21WKYewTDutHKpJ5dbiIrML4OO3aNQltHNf4Ngg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5936
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMTE6MDk6MDlBTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IFRoZSBod3BvaXNvbiBzdXBwb3J0IGZvciBodWdlIHBhZ2UsIGJvdGggaHVnZXRsYiBhbmQg
VEhQLCBoYXMgYmVlbiBpbg0KPiBrZXJuZWwgZm9yIGEgd2hpbGUsIHRoZSBzdGF0ZW1lbnQgaW4g
ZG9jdW1lbnQgaXMgb2Jzb2xldGUsIGNvcnJlY3QgaXQuDQo+IA0KPiBDYzogTmFveWEgSG9yaWd1
Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gQ2M6IE9zY2FyIFNhbHZhZG9yIDxvc2Fs
dmFkb3JAc3VzZS5kZT4NCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBTaGkgPHNoeTgyODMwMUBnbWFp
bC5jb20+DQoNClRoYW5rIHlvdSENCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEu
aG9yaWd1Y2hpQG5lYy5jb20+
