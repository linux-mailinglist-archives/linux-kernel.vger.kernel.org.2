Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7305F40335D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 06:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhIHE1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 00:27:11 -0400
Received: from mail-eopbgr1410080.outbound.protection.outlook.com ([40.107.141.80]:64000
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229590AbhIHE06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 00:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTgNFHb2c2s2tetvIzaaDqSRpNQ9mHq7fGtuiAvaFLSq67tN6ecDe+Kn6LS+bjuvAtjTHmAnpYeOCQ19uO70y8ekE6GuZxtQP8KVS3JOSwWcVTvEOduYFV1b9Nh+fNktxLoxKXYNs+NXKvy1zGRC1BKW/CbqILDwPAs8awTLr+banhyVKRmSedLHt7zakpP8yPa7owe2t8RPp3mEdjbVQpUgTJk0As+rMm6YPHJs9TQ9BtNzcOXjl3whMRF1ZY57Ruihv3wqlbBdw7G0Sb6peoq2TIQWikKxy5CqA2+9Mv18XgUcuyrRc5XoEIOxRfwWVaN/CBsjIAc5Fh0ec75f7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9cEflLbqnsfA1+fBcryaBpJEVsmbiY2XeAQxXcHkLIc=;
 b=VJrvCBb/OtWhCqkgKb4QGR3uGqg+sbcf5yyh0TRQOX80vZGKXCHEkGicH7RTuHukEwKqeNE/nPfKvOBqb4Kc1b8F7UR8a6FfFbImK/1TrHNjWA31k2PUfqpNWoNYF7IUoae/V7T7SaNtwtklQ5cuPOOuvbNunMOO/PjdJKD88YT2V87BgDASUrLDo0wb9TjUa6Z8tsf0zLLgGuf+WrzeKBNIdStENUE7/a96vznWT+dy/0Q4fuOPyD3SYbddNKpWVRWToR/h2HO2Aw3SDeO0aD5OQkXAvKfG+wLJMWLUCffuDXFtxej0mnEKscFZacbZDt+rC2Bg5jtI9hnGUJvKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cEflLbqnsfA1+fBcryaBpJEVsmbiY2XeAQxXcHkLIc=;
 b=UIShbhf3MTBto9mrf0TkVe5ZNsPFD6t187IVmwh3k3lkXWZ/PN4+1NLLxrZNBkfPH9nT7VoJixU8nIyyz6VpxV4bhqahfuKtyINErhs1YxwKMnHLoHTEJFIa2x4XPBB4B1GaJup0WeDsaj7P0+YKs2ckXkhaAKvzuPG7NvcW4tQ=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3070.jpnprd01.prod.outlook.com (2603:1096:404:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 04:25:47 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::5c68:d56a:79f7:56c1]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::5c68:d56a:79f7:56c1%7]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 04:25:47 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "osalvador@suse.de" <osalvador@suse.de>,
        "hughd@google.com" <hughd@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: hwpoison: deal with page cache THP
Thread-Topic: [PATCH] mm: hwpoison: deal with page cache THP
Thread-Index: AQHXpGmYAfzKRAxlWUeBf7/9yfCIYg==
Date:   Wed, 8 Sep 2021 04:25:47 +0000
Message-ID: <20210908042547.GA11650@hori.linux.bs1.fc.nec.co.jp>
References: <CAHbLzkr35uVHCJB_cr_fZdz3_FXXGam7dsrAn15j5BPfmfX-_A@mail.gmail.com>
 <CAHbLzko+XqFLx9=e2=E3rGRsLzcm32dZnpDf20gnUb2dAR0d_Q@mail.gmail.com>
 <20210902030728.GA1860112@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkoBz2DwPXC5Nj+Kd6-pRaHgtZ-MGNPzYW4azN6Xpz3oyw@mail.gmail.com>
 <20210903115311.GA2477773@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkoXaB_Hz_ZUw4BvR0PKV_ZV4F+hHekRS9RgUnxBYkMV_g@mail.gmail.com>
 <CAHbLzkpDK5qb1=VM8qeDdfjdqRyuL+ehwOK=8uZPYuR7J+xMEQ@mail.gmail.com>
 <CAHbLzko6yTTnBopzASaYeuD5bBsc_kdhQxQoVd-wqEhkzX1agg@mail.gmail.com>
 <20210908025024.GA4117799@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkptCkXdVdG9mr1BU8TEyEpW57go_Pj1uVopkxORqYi8aw@mail.gmail.com>
In-Reply-To: <CAHbLzkptCkXdVdG9mr1BU8TEyEpW57go_Pj1uVopkxORqYi8aw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d890ebe-4ba8-4556-6cdd-08d97280bb6e
x-ms-traffictypediagnostic: TYAPR01MB3070:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3070C4A2CB500F7D00EEA71BE7D49@TYAPR01MB3070.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OE/welCT/M6tmOHKOm7OoR14f7UZ1udWDikFLxDIzs1EwW/NYHF+DMHdbMeqWlH+toVNPzHI8kYRGwnjqUiD/dDAAiRMCH43Qxe+VFzzppIXJfbLkCdCSSCSk7qvGqoDqMTswQrqFf/ZdcPW7VJDNshRalXCRWyalco4NF3yO8TMIYSMAxOW8L9dL47BqRJpI5hAAWLcM7fx4KKslvZw2/Qx9Yo8iF3LjQe7P19ofruEQitg4EYosOnPnL+DdchgqbA2msa2XYLJiI4lxfAQquYUawAf6Dl5Enx4psE/flu2dn3rms7nLLIfwNzulNo5jspdimOFPtPMczTa2PXI7reUvbaJnf/OnvH+5qXZJPbTsBKo0bJFp1XSbG5/O9P3sjgjf5ooSnMW6qRYsX9TNvulpnszp4UC2ubS5XiaCi5EJNiOPRfmjtukPbze/8ZDM4QAJC4TppyMl1cZ1xThA8KDql/ymc1lq9nt+NqdVT/7ZKtO/c56ILB2r0A0dJ46mAlRnpVFr6vyjZN0uTf8UJtTZ3SDFuMizU3i8ApIbMuSGdnZDs5JqiJZrSUjttbZzukXwwMtLUY8Dx5O1/UuVvZDlsAXeT1uOVmZRLNwhOlMfKb26GMC5Jmrenb+4gccQfpFMO0ubqUt0kOsnLz8MnFduYnuc/DJ0o4bILkF1KZ5gQ946UZ7ybf60RLMWpR1I57uRMrMM/UnFiyYmxcd+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(55236004)(26005)(8936002)(8676002)(86362001)(6486002)(316002)(4326008)(122000001)(54906003)(76116006)(66446008)(186003)(5660300002)(38100700002)(71200400001)(6512007)(9686003)(478600001)(38070700005)(83380400001)(85182001)(66946007)(6506007)(6916009)(66476007)(2906002)(66556008)(1076003)(33656002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1RtbmM0ZkFlK285NU5ta0s4VEk1bXhpYWxDM1gyYWMzT25FWlVGVVk3dzRv?=
 =?utf-8?B?SlhJVWVlKzJHODNpVDNLdUwrb2ZrTHZmTzhxRVdtTlEyWW0yZi9BN1VJWHZm?=
 =?utf-8?B?M1NYS0czMmtiNnNwK25nOERBRWFvcjJGWDFoeXk1MnF3UU94bk1EUW9rdkY0?=
 =?utf-8?B?TURkVVBBZFlBMkRlSDdycGxuNzMvVExXSnp4NitPNmtlbCtGaE1ZQkRIMkxh?=
 =?utf-8?B?MDVLSVg3ZXY2VFgycnpETUtONDA1dEJ0eGhlWlpxYU5FSnBMWkRJREdIcURh?=
 =?utf-8?B?Rk0yZ2VFcy96Nno2cThjT1FXNFVpVk9BbVpXWURWMHJpNW1IeUFnQWZMV2Z5?=
 =?utf-8?B?eHozcGJyM1F2WHN1NlE5Q3Vnby9PVEc0L2ZaZkxPdEt5bVFGNFc5aWNDbHRx?=
 =?utf-8?B?b0RHTkFrbkpveE9CSDM2RUVrNzdwU3EvYUFEb2VhZjRhbFVwRUo2UGpremxS?=
 =?utf-8?B?SXJpZGF2enZBZForK0Nva2xyNnhnYmY2d3BkVFErZHJLRkd2WGdUdWtYbDhw?=
 =?utf-8?B?K2FWWWlJUFlYcjRjVFdDYVdkNFZncWtGZE40clNROHJJdFNJRmJRVVppMVBn?=
 =?utf-8?B?bDNSTmVaZFV2VlVXeHIwWHZ4K2owVXREdGh5ZXFkZ2NtaGNyMXZqVytoRXpV?=
 =?utf-8?B?VlhFVU1ldTlGMG5vQ2NqVTBuQkEreHJHTXVkYXdHTHFlQXl2Z256L0oraFpF?=
 =?utf-8?B?b0VBMXJuVU5mamZiWS9wbmpkalJpMzdsWS9lQmlrdGZ4eWtDQjhXajlQNTVL?=
 =?utf-8?B?Qmx4SUswSjFmRUkxZDdnMHhkeHR6eG9Dc2UvOVdKcEdac1plV21XK1drT1Ju?=
 =?utf-8?B?Nm5pVGlLd09sOElDdURxbGZTb0g4MUQ1a01PQWxUNFoyZk5aY1FYcUhLY0xt?=
 =?utf-8?B?dDk3eTl0N2NZNmx3L29TM1l5R3YwOFlJQmVGczI1Zld1TklXRW0vanN4cno3?=
 =?utf-8?B?eUlneHlBbGF0WlFxWTJ6VFczdnlJdTl3dFBmZ21nU24vMGtSQnVGZXJ0T29H?=
 =?utf-8?B?Rmc2ODBOd2t2RDNjUGt5OVNTYTB6NWNaMng3OGtnZDNQOWc0UmU3TTlkejg1?=
 =?utf-8?B?ZlZOem85azhmUGpFN0JPTlc3OUFpYmdaR0VyckJid2pNS1NVR1VMWGtwYjZy?=
 =?utf-8?B?ZHlHdFp5ZzhFb0Rnb3NGd2tWQ2haYzlFVFlZaWt5T1hxQmVYUzhzNVBqRmFW?=
 =?utf-8?B?QW9FNjRrMmdQVEtCV2NBdi8rM29lM0E2Zk1oeGNsZ2R5UUx1TzErMW5ocjJo?=
 =?utf-8?B?cXQ0cWhGT2JCT2ZiNnhXUDR1ZHhxSWlLaUNlcXZpaVlzNnFpemxWVVh3U0px?=
 =?utf-8?B?bk9HM1luVi93dVYrd3BudzYzTXNJRVlZS2I4U3A1Q1BYTFJtN3ZXaWZ4R04r?=
 =?utf-8?B?QzlEQTZnQk9KZ09aSXRzeHh0a1hnQ2psWWpLdnhySDUyUk5ERTQyQlQzb3FP?=
 =?utf-8?B?cHlpN3AyNWtKR2VhdmRZdU1Ca3VpQTdxRDdqeVVleDVFS2puaEFMWWc3clNr?=
 =?utf-8?B?eFpGdzlDL2FkaXFUMzgvZVJieFFWMTAzMm5YcU9BeVBjZVlOZWh1cll2SGlW?=
 =?utf-8?B?eFkwSkF0TjJ1VzNremFrRTZrcFRNeStFcUJic0NGYlFGZDQrWXlvQVBrWWlJ?=
 =?utf-8?B?NGwyNzRNRXFNSmVVeEFTRjRjOFljTUVxY3Awc0dtUE5scUs0SDZiMjVoN0JG?=
 =?utf-8?B?TW01MThibW1RK2JKNDlCMlI2elQxSUp2VW54d2ZYb0tQbTlycWlQLzd4UjlX?=
 =?utf-8?Q?vtT0P/BB3t5agBDLioBxQu9CX6eARRHm4OcsRYV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B17ADE6ABE23F14E81FDFC46D063328E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d890ebe-4ba8-4556-6cdd-08d97280bb6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 04:25:47.4642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGLIfzCyJPok8RmPJBTwosg/AaoVHegr8LWEgzh+pcPBG3ws21UfHRvcb8ResqVHW/OtaFPdUbucI8Hb4HdjXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMDcsIDIwMjEgYXQgMDg6MTQ6MjZQTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQouLi4NCj4gPiA+ID4gPiA+ID4gNS4gV2UgYWxzbyBjb3VsZCBkZWZpbmUgYSBuZXcgRkdQIGZs
YWcgdG8gcmV0dXJuIHBvaXNvbmVkIHBhZ2UsIE5VTEwNCj4gPiA+ID4gPiA+ID4gb3IgZXJyb3Ig
cG9pbnRlci4gVGhpcyBhbHNvIHNob3VsZCBuZWVkIHNpZ25pZmljYW50IGNvZGUgY2hhbmdlIHNp
bmNlDQo+ID4gPiA+ID4gPiA+IGEgbHQgY2FsbHNpdGVzIG5lZWQgdG8gYmUgY29udGVtcGxhdGVk
Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IENvdWxkIHlvdSBleHBsYWluIGEgbGl0dGxlIG1v
cmUgYWJvdXQgd2hpY2ggY2FsbGVycyBzaG91bGQgdXNlIHRoZSBmbGFnPw0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gSnVzdCB0byBzb2x2ZSB0aGUgYWJvdmUgaW52YWxpZGF0ZS90cnVuY2F0ZSBwcm9i
bGVtIGFuZCBwYWdlIGZhdWx0DQo+ID4gPiA+ID4gZG9lc24ndCBleHBlY3QgYW4gZXJyb3IgcG9p
bnRlci4gQnV0IGl0IHNlZW1zIHRoZSBhYm92ZQ0KPiA+ID4gPiA+IGludmFsaWRhdGUvdHJ1bmNh
dGUgcGF0aHMgZG9uJ3QgbWF0dGVyLiBQYWdlIGZhdWx0IHNob3VsZCBiZSB0aGUgb25seQ0KPiA+
ID4gPiA+IHVzZXIgc2luY2UgcGFnZSBmYXVsdCBtYXkgbmVlZCB1bmxvY2sgdGhlIHBhZ2UgaWYg
cG9pc29uZWQgcGFnZSBpcw0KPiA+ID4gPiA+IHJldHVybmVkLg0KPiA+DQo+ID4gT3JpZ25hbGx5
IFBHX2h3cG9pc29uIGlzIGRldGVjdGVkIGluIHBhZ2UgZmF1bHQgaGFuZGxlciBmb3IgZmlsZS1i
YWNrZWQgcGFnZXMNCj4gPiBsaWtlIGJlbG93LA0KPiA+DQo+ID4gICBzdGF0aWMgdm1fZmF1bHRf
dCBfX2RvX2ZhdWx0KHN0cnVjdCB2bV9mYXVsdCAqdm1mKQ0KPiA+ICAgLi4uDQo+ID4gICAgICAg
ICAgIHJldCA9IHZtYS0+dm1fb3BzLT5mYXVsdCh2bWYpOw0KPiA+ICAgICAgICAgICBpZiAodW5s
aWtlbHkocmV0ICYgKFZNX0ZBVUxUX0VSUk9SIHwgVk1fRkFVTFRfTk9QQUdFIHwgVk1fRkFVTFRf
UkVUUlkgfA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZNX0ZBVUxUX0RPTkVf
Q09XKSkpDQo+ID4gICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPg0KPiA+ICAgICAg
ICAgICBpZiAodW5saWtlbHkoUGFnZUhXUG9pc29uKHZtZi0+cGFnZSkpKSB7DQo+ID4gICAgICAg
ICAgICAgICAgICAgaWYgKHJldCAmIFZNX0ZBVUxUX0xPQ0tFRCkNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVubG9ja19wYWdlKHZtZi0+cGFnZSk7DQo+ID4gICAgICAgICAgICAgICAg
ICAgcHV0X3BhZ2Uodm1mLT5wYWdlKTsNCj4gPiAgICAgICAgICAgICAgICAgICB2bWYtPnBhZ2Ug
PSBOVUxMOw0KPiA+ICAgICAgICAgICAgICAgICAgIHJldHVybiBWTV9GQVVMVF9IV1BPSVNPTjsN
Cj4gPiAgICAgICAgICAgfQ0KPiA+DQo+ID4gc28gaXQgc2VlbXMgdG8gbWUgdGhhdCBpZiBhIGZp
bGVzeXN0ZW0gc3dpdGNoZXMgdG8gdGhlIG5ldyBzY2hlbWUgb2Yga2VlcGluZw0KPiA+IGVycm9y
IHBhZ2VzIGluIHBhZ2UgY2FjaGUsIC0+ZmF1bHQoKSBjYWxsYmFjayBmb3IgdGhlIGZpbGVzeXN0
ZW0gbmVlZHMgdG8gYmUNCj4gPiBhd2FyZSBvZiBod3BvaXNvbmVkIHBhZ2VzIGluc2lkZSBpdCBh
bmQgcmV0dXJucyBWTV9GQVVMVF9IV1BPSVNPTiB3aGVuIGl0DQo+ID4gZGV0ZWN0cyBhbiBlcnJv
ciBwYWdlIChtYXliZSBieSBkZXRlY3RpbmcgcGFnZWNhY2hlX2dldF9wYWdlKCkgdG8gcmV0dXJu
DQo+ID4gUFRSX0VSUigtRUlPIG9yIC1FSFdQT0lTT04pIG9yIHNvbWUgb3RoZXIgd2F5cykuICBJ
biB0aGUgb3RoZXIgZmlsZXN5c3RlbXMNCj4gPiB3aXRoIHRoZSBvbGQgc2NoZW1lLCBmYXVsdCgp
IGNhbGxiYWNrIGRvZXMgbm90IHJldHVybiBWTV9GQVVMVF9IV1BPSVNPTiBzbw0KPiA+IHRoYXQg
cGFnZSBmYXVsdCBoYW5kbGVyIGZhbGxzIGJhY2sgdG8gdGhlIGdlbmVyaWMgUGFnZUhXUG9pc29u
IGNoZWNrIGFib3ZlLg0KPiANCj4gWWVzLCBleGFjdGx5LiBJZiB3ZSByZXR1cm4gRVJSX1BUUiB3
ZSBuZWVkIG1vZGlmeSB0aGUgYWJvdmUgY29kZQ0KPiBhY2NvcmRpbmdseS4gQnV0IHJldHVybmlu
ZyB0aGUgcGFnZSwgbm8gY2hhbmdlIGlzIHJlcXVpcmVkLg0KPiANCj4gPg0KPiA+ID4gPg0KPiA+
ID4gPiBJdCBzZWVtcyBwYWdlIGZhdWx0IGNoZWNrIElTX0VSUihwYWdlKSB0aGVuIGp1c3QgcmV0
dXJuDQo+ID4gPiA+IFZNX0ZBVUxUX0hXUE9JU09OLiBCdXQgSSBmb3VuZCBhIGNvdXBsZSBvZiBw
bGFjZXMgaW4gc2htZW0gd2hpY2ggd2FudA0KPiA+ID4gPiB0byByZXR1cm4gaGVhZCBwYWdlIHRo
ZW4gaGFuZGxlIHN1YnBhZ2Ugb3IganVzdCByZXR1cm4gdGhlIHBhZ2UgYnV0DQo+ID4gPiA+IGRv
bid0IGNhcmUgdGhlIGNvbnRlbnQgb2YgdGhlIHBhZ2UuIFRoZXkgc2hvdWxkIGlnbm9yZSBod3Bv
aXNvbi4gU28gSQ0KPiA+ID4gPiBndWVzcyB3ZSdkIGJldHRlciB0byBoYXZlIGEgRkdQIGZsYWcg
Zm9yIHN1Y2ggY2FzZXMuDQo+ID4NCj4gPiBBdCBsZWFzdCBjdXJyZW50bHkgdGhwIGFyZSBzdXBw
b3NlZCB0byBiZSBzcGxpdCBiZWZvcmUgZXJyb3IgaGFuZGxpbmcuDQo+IA0KPiBOb3QgZm9yIGZp
bGUgVEhQLg0KPiANCj4gPiBXZSBjb3VsZCBsb29zZW4gdGhpcyBhc3N1bXB0aW9uIHRvIHN1cHBv
cnQgaHdwb2lzb24gb24gYSBzdWJwYWdlIG9mIHRocCwNCj4gPiBidXQgSSdtIG5vdCBzdXJlIHdo
ZXRoZXIgdGhhdCBoYXMgc29tZSBiZW5lZml0Lg0KPiANCj4gSSBkb24ndCBxdWl0ZSBnZXQgeW91
ciBwb2ludC4gQ3VycmVudGx5IHRoZSBod3BvaXNvbiBmbGFnIGlzIHNldCBvbg0KPiBzcGVjaWZp
YyBzdWJwYWdlIGluc3RlYWQgb2YgaGVhZCBwYWdlLg0KDQpTb3JyeSwgSSBtaXNzIHRoZSBjYXNl
IHdoZW4gdGhwIHNwbGl0IGZhaWxzLCB0aGVuIHRoZSB0aHAgaGFzIGh3cG9pc29uDQpmbGFnIHNl
dCBvbiBhbnkgc3VicGFnZS4gIEkgb25seSB0aG91Z2h0IG9mIHRoZSBzdWNjZXNzZnVsIGNhc2Us
IHdoZXJlIHRoZQ0KcmVzdWx0aW5nIGVycm9yIHBhZ2UgaXMgbm8gbG9uZ2VyIGEgc3VicGFnZS4N
Cg0KPiANCj4gPiBBbmQgYWxzbyB0aGlzIGRpc2N1c3Npb24gbWFrZXMgbWUgYXdhcmUgdGhhdCB3
ZSBuZWVkIHRvIGhhdmUgYSB3YXkgdG8NCj4gPiBwcmV2ZW50IGh3cG9pc29uZWQgcGFnZXMgZnJv
bSBiZWluZyB1c2VkIHRvIHRocCBjb2xsYXBzZSBvcGVyYXRpb24uDQo+IA0KPiBBY3R1YWxseSBu
b3QuIFRoZSByZWZjb3VudCBmcm9tIGh3cG9pc29uIGNvdWxkIHByZXZlbnQgaXQgZnJvbQ0KPiBj
b2xsYXBzaW5nLiBCdXQgaWYgd2UgcmV0dXJuIEVSUl9QVFIgKCMzKSB3ZSBuZWVkIGV4dHJhIGNv
ZGUgaW4NCj4ga2h1Z2VwYWdlZCB0byBoYW5kbGUgaXQuDQoNCk9LLCBzbyB3ZSBhbHJlYWR5IHBy
ZXZlbnQgaXQuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+IA0KPiBTbyBJIHJlYWxp
emVkICMxIHdvdWxkIHJlcXVpcmUgZmV3ZXIgY2hhbmdlcy4gQW5kIGxlYXZpbmcgdGhlIHBhZ2UN
Cj4gc3RhdGUgY2hlY2sgdG8gY2FsbGVycyBzZWVtIHJlYXNvbmFibGUgc2luY2UgdGhlIGNhbGxl
cnMgdXN1YWxseSBjaGVjaw0KPiBvdGhlciBzdGF0ZXMsIGUuZy4gdXB0b2RhdGUu
