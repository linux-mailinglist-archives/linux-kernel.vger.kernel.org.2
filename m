Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B853F2743
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbhHTHE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:04:57 -0400
Received: from mail-eopbgr1400040.outbound.protection.outlook.com ([40.107.140.40]:59456
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238727AbhHTHEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:04:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpXQF1RWpC/165mAbwWpB9S7NZHZtbMimCnFkNLXXabusNgN9EQ8+O54gDVKVjgHlSIk28qx/LWanm4yR/jeX+8FigA/qYaFp/sMMGSui/mMguGEsen8YfSeVTcvLnnsg4kHv4u6yDsBOQlU97RyVtQWqtNqUHcgyGjUfKjl3dmLBVVpHsCMV5ppbzi2yzrjLxIkOGa0FB3uFfrGN7nLP1t8u1HSzKj0xSw4nRS7DAuGeR7Ehkcijzh0Q5tcjvEHhCrP7hPSYOedjX4bqn/1udssvNEmI8OtnNQ5nx74MNT+AuLuzR3atzgN81a6KG9kZzY3u5DN0TPAM21EvrnYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k+DduO/J0W0FFCyX4FQEL5LNKqiTgcmOri1UGGoN8k=;
 b=fdV+GJpVgJmD3JIa3DPY+JJsYDYTeCjugNDMpRN8BL+1bp3q5L89TOvFZgM2W+pqLA9vEZCvX9fYBsJ4E+HP4+ByZUVZteyo+xx+sckiYmZzRKuASynY7m3owKgsEUYHQsz0Qf2UlEFYaXHmtG9feiDkneSF9vYwMEzp9Lv9aC5oPVG/3WiYsaBmDNQzF4pn9SwjrV88Y8+jqqOUBEC5GrQfcdgqs2iXW41PeR8nvoZTNaYuYemM06sPlQ4nC8Ded2kZfFXK4a+xajyI92sn6PjsRde4f50W3r6B9CAEVrQsT95KykYrEmdCFTav5LR2XNjlqG/AQLgG5/3Pl6ft1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k+DduO/J0W0FFCyX4FQEL5LNKqiTgcmOri1UGGoN8k=;
 b=RFd2tehj2JyZsKSgKMn1y0lqxbeb9FFPujn5CR76byyQrfbM0mwLSZt02tW+2qObrvB22KZ+lXOSY5N2ffohNvAYqaLE/16hsnCuP2N8jemQC6/l570DZcSmNLWOLzpjvMsEvtvKaA+D7JXjpmPOpPcvkdm9rwHRDK2OnrrbkpQ=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB5930.jpnprd01.prod.outlook.com (2603:1096:404:8055::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 20 Aug
 2021 07:04:14 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.024; Fri, 20 Aug 2021
 07:04:14 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "osalvador@suse.de" <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        "david@redhat.com" <david@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH 1/3] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
Thread-Topic: [v2 PATCH 1/3] mm: hwpoison: don't drop slab caches for
 offlining non-LRU page
Thread-Index: AQHXlZGVQtUYpun+7EKEcBqESbB1yA==
Date:   Fri, 20 Aug 2021 07:04:14 +0000
Message-ID: <20210820070413.GB63355@hori.linux.bs1.fc.nec.co.jp>
References: <20210819054116.266126-1-shy828301@gmail.com>
In-Reply-To: <20210819054116.266126-1-shy828301@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f67ba84f-a151-4c8e-b81f-08d963a8b80f
x-ms-traffictypediagnostic: TYAPR01MB5930:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5930DA9EF6AF4048922E5A71E7C19@TYAPR01MB5930.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZjequNNIMR3pW4b/gsbDV6N54JAm3czRbEV6w2IDgd/1ncCaBnlwfJKhXNKo1wmUT6vZ53c/DhfGWfPOmumgJpd/G7BPAc8sTUFtcu//FHBylVQoUfT/jy2oBYA3qA4uQbpqcHMfayKcId0ERwqN3aKPjcwrsPK+6qVvJf0Qv3qrwT0se0EZJ48nfrBEHyPdPka5HDZKIscaORLPqno2Owwtphxa0ZqRd0szetYkDBVXiXEgIjTe5dM75CN3hIBztDeq3e7+ox8ofdIv4oPonC9GDbJS9O9JPWKlzNv621sSU3swNFzxUu9oW9gQMwimT8t+gskdc23OBSXCeqRxs2j4vln5gWPRmrxzLPcmm2Uj47miiqQNI1B9DVTjkN3D8WmGzUpJRB9ONaK+hxQy8j5+jNiDBQQ1e1sOtqND+WDq9RDAEwTUrkPPd33zinxIvCtwHwh0GnKM2o5sSIe5bE+k/QbHK0aWXTBS3umNcBoNDrtHvGgHSW8HAcAHsgC1BmwrjeFUtg/pY+w2amygpHa/0gYoQDQNMhwZxCdt7fCjrEA3A3jtynKQALdNzkebXJZyk8HXCiLzua7Hb5zKme1m86oz0u4gw80RetpnwuwGW3vBH/wRWljnrKCvh4dtdf+6gxCwQRX/a5pfvUBFDj2xF9GYoIfFub2lGDdptj/wojlWt4OnanKVhSfJhZPyQVsruFMU6ghg6t7a5CozQKQvoK/1pC5ZDLvJNWVey13exSOYpC1aN69v7LRoA6XQmVX7R3x4cSE8g7gyhOEcX6n0YjapAZ0R6L/ksj6EsCY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(6916009)(54906003)(2906002)(71200400001)(6512007)(8936002)(9686003)(85182001)(66556008)(38100700002)(66946007)(66446008)(186003)(64756008)(38070700005)(1076003)(76116006)(33656002)(83380400001)(26005)(66476007)(55236004)(966005)(4326008)(86362001)(8676002)(6486002)(478600001)(122000001)(316002)(45080400002)(6506007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGhiLzRaKzlUZjVFYytSQW9sNG9pYjZRM0cralNnanNFaXF4djR2cU90Y004?=
 =?utf-8?B?NGdMMW9KRFhQOGI2VllOdDJMcWhQWU9uVWxvU2tmRVFtQmtLUVpLWkR1Sk5q?=
 =?utf-8?B?SDNJUzNyc1lkWXpzSWNrS0pzejNObUErM0dmcTIvYjNvYjFNUDlOME9jUDVn?=
 =?utf-8?B?cmdHd29WUHBoYjZ2UndvN0pkejFNNm9iOFp6TEdzbEkvSndTby9KZWsyRVRP?=
 =?utf-8?B?ZTZEMkI1TWZBaTRReC9JOFY4ZUFWSjVTQjh3Znh4UHIzVmRRYUQrcmRyUWFD?=
 =?utf-8?B?WXBYbXQyTHA0bTR0VkM3SVd0WXFyMmxFSFJVZVAxR1YyZng2WnhqblhtYklw?=
 =?utf-8?B?RE5JOU9GZ2piSEI0Q2xJMFNpRTJhOTFPVk85cm5JVWNDWWtkTm9aNWxNZGtO?=
 =?utf-8?B?WHBnb1BSYVBHZm53TGVSQkRsVjBVRFFlWEpCUUVnSkM2R2x3RmFtZ0hFUzI0?=
 =?utf-8?B?VVBadk9KK1BHOE0yclRhR2xLalB6WlZmOWtkN0tnRmxMYmpvL295ZTdUOTZJ?=
 =?utf-8?B?MkxvWS9YUitrWjNkem14NUdoMXorT3U5UmVIY3JObjcxang0bkxlcUgxeTNM?=
 =?utf-8?B?YVd0bjhiQ2tITkVjTWxVWjBScGt0OFd6aXBNOTM1MzNuVDExbGdhK25yQWVu?=
 =?utf-8?B?dTQyeVhOVEpwc0FVYXI3QXZUU3RIQUJJanNoKzlJZmw2MjhRTzk2VjNraDRy?=
 =?utf-8?B?TWxpTEgrTmJ6QXhNQUJIT0dvbm81c3FERXFHUlh6OHJtV0hQMW5aM2VhNWdn?=
 =?utf-8?B?WVJ6NTZCZUZOY3JNSFZFZHRIYW1xSnRJUzRTS1VwQldUZVVMR3FrRVNGNGxy?=
 =?utf-8?B?aGVOWWYxajlqSTJBSUhZSms1VEZlbUd4Tno5S05RQnRPanRWRXBqL00zbTZo?=
 =?utf-8?B?QWk5T0ZBVzRMVXBZY0U3cTQwOXhhM2JvSFFmaGlZb3o5UTZCRVVtUGw3VFlH?=
 =?utf-8?B?eWcwdVNuY0RZRS82cGVFMjNNelpFVHNTNmpxZ2tpU3VKc1hyeks4bU5CUkd5?=
 =?utf-8?B?OWRXT1dMQk5Za0ZDam5yY1QvRS9TQktVd0NLeURNTGhFOXp1Ujk4Q0dSUlJk?=
 =?utf-8?B?ejFqV3MzSjFLMHN5RDN5WFRGWThscy9URjk0cWVEWVZZa1d0cCt1dHhjazlw?=
 =?utf-8?B?Y2I2M2NnL2l6cjRJWEVYM0p0TlpLY3hiR1p3c2orU0VOSzJqQ3hVMFpPVDZj?=
 =?utf-8?B?VS9QZ1F1Ri9pUlBETnJGaHBLaWF5dmpUUVpabjZZbkZpbmZ3V3dHWjlJZTJk?=
 =?utf-8?B?RFFUSklrSUYySWpmbUNrM2lwTyszczRFUTI2anludEJONGdJUDBmTVcvYkxZ?=
 =?utf-8?B?Rno5d1RCZllZa1NncHltSzYwS1V5UEdCTWZqWXUxRkpUUzBwbWxKcnRaVW12?=
 =?utf-8?B?akpOSS9nMFVyMEVkZHRJUTRzRVVTMUx6Zkg3aVNKaXpHYzloZXVlb0hSZk1i?=
 =?utf-8?B?V2RKVkVXWkI5NFFuUk5FTjFncmRiZVY3aGZ6S0xlcWhxSXV5L2V3MDJhUlRH?=
 =?utf-8?B?aGxxazZnSWdDRFF3NTZEUWxvQUFMY2dLaTc3MGQxQmt4N2dINktnUVpRYWNn?=
 =?utf-8?B?VFlpYkJCNWFMQWRtVXhtdGR0a0dxT3ZFUzdmM1hoKzZkOGJXc095UFZmUFRi?=
 =?utf-8?B?eHdoWFhqVis5amlYckFpVHp1Vy9HVlV2SjhpV05tS2NoaW1qR1pUYndkL0VM?=
 =?utf-8?B?UEo3YlAybVdsS2dpVmhIVjR3T05NRnVERjhWRDBIMUhTdUVrVWE0SDAwN0p6?=
 =?utf-8?B?aFVIblZteS9hN2IwRmE5cXhmSEpXdnlJbW9jdTgzSnBYY08wZ0J2eVF0b0p5?=
 =?utf-8?B?dDlIL2lZeTIyNk5ra2hLZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53683494C216C6469185B70353B780A2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67ba84f-a151-4c8e-b81f-08d963a8b80f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:04:14.2139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDXucvedvtkCOVF6d2K9UqlEy1t3EjzhVLqiEHPhA4tWmUMFF/wuRZw5Nsf7MZ/5azy2VsACBpCUt1Yke9lhTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5930
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMTgsIDIwMjEgYXQgMTA6NDE6MTRQTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IEluIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIHNvZnQgb2ZmbGluZSwgaWYgbm9u
LUxSVSBwYWdlIGlzIG1ldCwNCj4gYWxsIHRoZSBzbGFiIGNhY2hlcyB3aWxsIGJlIGRyb3BwZWQg
dG8gZnJlZSB0aGUgcGFnZSB0aGVuIG9mZmxpbmUuICBCdXQNCj4gaWYgdGhlIHBhZ2UgaXMgbm90
IHNsYWIgcGFnZSBhbGwgdGhlIGVmZm9ydCBpcyB3YXN0ZWQgaW4gdmFpbi4gIEV2ZW4NCj4gdGhv
dWdoIGl0IGlzIGEgc2xhYiBwYWdlLCBpdCBpcyBub3QgZ3VhcmFudGVlZCB0aGUgcGFnZSBjb3Vs
ZCBiZSBmcmVlZA0KPiBhdCBhbGwuDQo+IA0KPiBIb3dldmVyIHRoZSBzaWRlIGVmZmVjdCBhbmQg
Y29zdCBpcyBxdWl0ZSBoaWdoLiAgSXQgZG9lcyBub3Qgb25seSBkcm9wDQo+IHRoZSBzbGFiIGNh
Y2hlcywgYnV0IGFsc28gbWF5IGRyb3AgYSBzaWduaWZpY2FudCBhbW91bnQgb2YgcGFnZSBjYWNo
ZXMNCj4gd2hpY2ggYXJlIGFzc29jaWF0ZWQgd2l0aCBpbm9kZSBjYWNoZXMuICBJdCBjb3VsZCBt
YWtlIHRoZSBtb3N0DQo+IHdvcmtpbmdzZXQgZ29uZSBpbiBvcmRlciB0byBqdXN0IG9mZmxpbmUg
YSBwYWdlLiAgQW5kIHRoZSBvZmZsaW5lIGlzIG5vdA0KPiBndWFyYW50ZWVkIHRvIHN1Y2NlZWQg
YXQgYWxsLCBhY3R1YWxseSBJIHJlYWxseSBkb3VidCB0aGUgc3VjY2VzcyByYXRlDQo+IGZvciBy
ZWFsIGxpZmUgd29ya2xvYWQuDQo+IA0KPiBGdXJ0aGVybW9yZSB0aGUgd29yc2UgY29uc2VxdWVu
Y2UgaXMgdGhlIHN5c3RlbSBtYXkgYmUgbG9ja2VkIHVwIGFuZA0KPiB1bnVzYWJsZSBzaW5jZSB0
aGUgcGFnZSBjYWNoZSByZWxlYXNlIG1heSBpbmN1ciBodWdlIGFtb3VudCBvZiB3b3Jrcw0KPiBx
dWV1ZWQgZm9yIG1lbWNnIHJlbGVhc2UuDQo+IA0KPiBBY3R1YWxseSB3ZSByYW4gaW50byBzdWNo
IHVucGxlYXNhbnQgY2FzZSBpbiBvdXIgcHJvZHVjdGlvbiBlbnZpcm9ubWVudC4NCj4gRmlyc3Rs
eSwgdGhlIHdvcmtxdWV1ZSBvZiBtZW1vcnlfZmFpbHVyZV93b3JrX2Z1bmMgaXMgbG9ja2VkIHVw
IGFzDQo+IGJlbG93Og0KPiANCj4gQlVHOiB3b3JrcXVldWUgbG9ja3VwIC0gcG9vbCBjcHVzPTEg
bm9kZT0wIGZsYWdzPTB4MCBuaWNlPTAgc3R1Y2sgZm9yIDUzcyENCj4gU2hvd2luZyBidXN5IHdv
cmtxdWV1ZXMgYW5kIHdvcmtlciBwb29sczoNCj4gd29ya3F1ZXVlIGV2ZW50czogZmxhZ3M9MHgw
DQo+IMKgIHB3cSAyOiBjcHVzPTEgbm9kZT0wIGZsYWdzPTB4MCBuaWNlPTAgYWN0aXZlPTE0LzI1
NiByZWZjbnQ9MTUNCj4gwqAgwqAgaW4tZmxpZ2h0OiA0MDkyNzE6bWVtb3J5X2ZhaWx1cmVfd29y
a19mdW5jDQo+IMKgIMKgIHBlbmRpbmc6IGtmcmVlX3JjdV93b3JrLCBrZnJlZV9yY3VfbW9uaXRv
ciwga2ZyZWVfcmN1X3dvcmssIHJodF9kZWZlcnJlZF93b3JrZXIsIHJodF9kZWZlcnJlZF93b3Jr
ZXIsIHJodF9kZWZlcnJlZF93b3JrZXIsIHJodF9kZWZlcnJlZF93b3JrZXIsIGtmcmVlX3JjdV93
b3JrLCBrZnJlZV9yY3Vfd29yaywga2ZyZWVfcmN1X3dvcmssIGtmcmVlX3JjdV93b3JrLCBkcmFp
bl9sb2NhbF9zdG9jaywga2ZyZWVfcmN1X3dvcmsNCj4gd29ya3F1ZXVlIG1tX3BlcmNwdV93cTog
ZmxhZ3M9MHg4DQo+IMKgIHB3cSAyOiBjcHVzPTEgbm9kZT0wIGZsYWdzPTB4MCBuaWNlPTAgYWN0
aXZlPTEvMjU2IHJlZmNudD0yDQo+IMKgIMKgIHBlbmRpbmc6IHZtc3RhdF91cGRhdGUNCj4gd29y
a3F1ZXVlIGNncm91cF9kZXN0cm95OiBmbGFncz0weDANCj4gICBwd3EgMjogY3B1cz0xIG5vZGU9
MCBmbGFncz0weDAgbmljZT0wIGFjdGl2ZT0xLzEgcmVmY250PTEyMDcyDQo+ICAgICBwZW5kaW5n
OiBjc3NfcmVsZWFzZV93b3JrX2ZuDQo+IA0KPiBUaGVyZSB3ZXJlIG92ZXIgMTJLIGNzc19yZWxl
YXNlX3dvcmtfZm4gcXVldWVkLCBhbmQgdGhpcyBjYXVzZWQgYSBmZXcNCj4gbG9ja3VwcyBkdWUg
dG8gdGhlIGNvbnRlbnRpb24gb2Ygd29ya2VyIHBvb2wgbG9jayB3aXRoIElSUSBkaXNhYmxlZCwg
Zm9yDQo+IGV4YW1wbGU6DQo+IA0KPiBOTUkgd2F0Y2hkb2c6IFdhdGNoZG9nIGRldGVjdGVkIGhh
cmQgTE9DS1VQIG9uIGNwdSAxDQo+IE1vZHVsZXMgbGlua2VkIGluOiBhbWQ2NF9lZGFjX21vZCBl
ZGFjX21jZV9hbWQgY3JjdDEwZGlmX3BjbG11bCBjcmMzMl9wY2xtdWwgZ2hhc2hfY2xtdWxuaV9p
bnRlbCB4dF9EU0NQIGlwdGFibGVfbWFuZ2xlIGt2bV9hbWQgYnBmaWx0ZXIgdmZhdCBmYXQgYWNw
aV9pcG1pIGkyY19waWl4NCB1c2Jfc3RvcmFnZSBpcG1pX3NpIGsxMHRlbXAgaTJjX2NvcmUgaXBt
aV9kZXZpbnRmIGlwbWlfbXNnaGFuZGxlciBhY3BpX2NwdWZyZXEgc2NoX2ZxX2NvZGVsIHhmcyBs
aWJjcmMzMmMgY3JjMzJjX2ludGVsIG1seDVfY29yZSBtbHhmdyBudm1lIHhoY2lfcGNpIHB0cCBu
dm1lX2NvcmUgcHBzX2NvcmUgeGhjaV9oY2QNCj4gQ1BVOiAxIFBJRDogMjA1NTAwIENvbW06IGt3
b3JrZXIvMTowIFRhaW50ZWQ6IEcgICAgICAgICAgICAgTCAgICA1LjEwLjMyLXQxLmVsNy50d2l0
dGVyLng4Nl82NCAjMQ0KPiBIYXJkd2FyZSBuYW1lOiBUWUFOIEY1QU1UIC96ICAgICAgICAvUzgw
MjZHTTJOUkUtQ0dOLCBCSU9TIFY4LjAzMCAwMy8zMC8yMDIxDQo+IFdvcmtxdWV1ZTogZXZlbnRz
IG1lbW9yeV9mYWlsdXJlX3dvcmtfZnVuYw0KPiBSSVA6IDAwMTA6cXVldWVkX3NwaW5fbG9ja19z
bG93cGF0aCsweDQxLzB4MWEwDQo+IENvZGU6IDQxIGYwIDBmIGJhIDJmIDA4IDBmIDkyIGMwIDBm
IGI2IGMwIGMxIGUwIDA4IDg5IGMyIDhiIDA3IDMwIGU0IDA5IGQwIGE5IDAwIDAxIGZmIGZmIDc1
IDFiIDg1IGMwIDc0IDBlIDhiIDA3IDg0IGMwIDc0IDA4IGYzIDkwIDw4Yj4gMDcgODQgYzAgNzUg
ZjggYjggMDEgMDAgMDAgMDAgNjYgODkgMDcgYzMgZjYgYzQgMDEgNzUgMDQgYzYgNDcNCj4gUlNQ
OiAwMDE4OmZmZmY5YjJhYzI3OGY5MDAgRUZMQUdTOiAwMDAwMDAwMg0KPiBSQVg6IDAwMDAwMDAw
MDA0ODAxMDEgUkJYOiBmZmZmOGNlOThjZTcxODAwIFJDWDogMDAwMDAwMDAwMDAwMDA4NA0KPiBS
RFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwMDAwMDAwMDAwMDAwIFJESTogZmZmZjhjZTk4
Y2U2YTE0MA0KPiBSQlA6IDAwMDAwMDAwMDAwMjg0YzggUjA4OiBmZmZmZDcyNDhkY2I2ODA4IFIw
OTogMDAwMDAwMDAwMDAwMDAwMA0KPiBSMTA6IDAwMDAwMDAwMDAwMDAwMDMgUjExOiBmZmZmOWIy
YWMyNzhmOWIwIFIxMjogMDAwMDAwMDAwMDAwMDAwMQ0KPiBSMTM6IGZmZmY4Y2I0NGRhYjljMDAg
UjE0OiBmZmZmZmZmZmJkMWNlNmEwIFIxNTogZmZmZjhjYWNhYTM3ZjA2OA0KPiBGUzogIDAwMDAw
MDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjhjZTk4Y2U0MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAw
MDAwMDAwMDAwDQo+IENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAw
NTAwMzMNCj4gQ1IyOiAwMDAwN2ZjZjZlOGNiMDAwIENSMzogMDAwMDAwMGEwYzYwYTAwMCBDUjQ6
IDAwMDAwMDAwMDAzNTBlZTANCj4gQ2FsbCBUcmFjZToNCj4gIF9fcXVldWVfd29yaysweGQ2LzB4
M2MwDQo+ICBxdWV1ZV93b3JrX29uKzB4MWMvMHgzMA0KPiAgdW5jaGFyZ2VfYmF0Y2grMHgxMGUv
MHgxMTANCj4gIG1lbV9jZ3JvdXBfdW5jaGFyZ2VfbGlzdCsweDZkLzB4ODANCj4gIHJlbGVhc2Vf
cGFnZXMrMHgzN2YvMHgzZjANCj4gIF9fcGFnZXZlY19yZWxlYXNlKzB4MWMvMHg1MA0KPiAgX19p
bnZhbGlkYXRlX21hcHBpbmdfcGFnZXMrMHgzNDgvMHgzODANCj4gID8geGZzX2FsbG9jX2J1ZnRh
cmcrMHhhNC8weDEyMCBbeGZzXQ0KPiAgaW5vZGVfbHJ1X2lzb2xhdGUrMHgxMGEvMHgxNjANCj4g
ID8gaXB1dCsweDFkMC8weDFkMA0KPiAgX19saXN0X2xydV93YWxrX29uZSsweDdiLzB4MTcwDQo+
ICA/IGlwdXQrMHgxZDAvMHgxZDANCj4gIGxpc3RfbHJ1X3dhbGtfb25lKzB4NGEvMHg2MA0KPiAg
cHJ1bmVfaWNhY2hlX3NiKzB4MzcvMHg1MA0KPiAgc3VwZXJfY2FjaGVfc2NhbisweDEyMy8weDFh
MA0KPiAgZG9fc2hyaW5rX3NsYWIrMHgxMGMvMHgyYzANCj4gIHNocmlua19zbGFiKzB4MWYxLzB4
MjkwDQo+ICBkcm9wX3NsYWJfbm9kZSsweDRkLzB4NzANCj4gIHNvZnRfb2ZmbGluZV9wYWdlKzB4
MWFjLzB4NWIwDQo+ICA/IGRldl9tY2VfbG9nKzB4ZWUvMHgxMTANCj4gID8gbm90aWZpZXJfY2Fs
bF9jaGFpbisweDM5LzB4OTANCj4gIG1lbW9yeV9mYWlsdXJlX3dvcmtfZnVuYysweDZhLzB4OTAN
Cj4gIHByb2Nlc3Nfb25lX3dvcmsrMHgxOWUvMHgzNDANCj4gID8gcHJvY2Vzc19vbmVfd29yaysw
eDM0MC8weDM0MA0KPiAgd29ya2VyX3RocmVhZCsweDMwLzB4MzYwDQo+ICA/IHByb2Nlc3Nfb25l
X3dvcmsrMHgzNDAvMHgzNDANCj4gIGt0aHJlYWQrMHgxMTYvMHgxMzANCj4gDQo+IFRoZSBsb2Nr
dXAgbWFkZSB0aGUgbWFjaGluZSBpcyBxdWl0ZSB1bnVzYWJsZS4gIEFuZCBpdCBhbHNvIG1hZGUg
dGhlDQo+IG1vc3Qgd29ya2luZ3NldCBnb25lLCB0aGUgcmVjbGFpbWFibGVkIHNsYWIgY2FjaGVz
IHdlcmUgcmVkdWNlZCBmcm9tIDEyRw0KPiB0byAzMDBNQiwgdGhlIHBhZ2UgY2FjaGVzIHdlcmUg
ZGVjcmVhc2VkIGZyb20gMTdHIHRvIDRHLg0KPiANCj4gQnV0IHRoZSBtb3N0IGRpc2FwcG9pbnRp
bmcgdGhpbmcgaXMgYWxsIHRoZSBlZmZvcnQgZG9lc24ndCBtYWtlIHRoZSBwYWdlDQo+IG9mZmxp
bmUsIGl0IGp1c3QgcmV0dXJuczoNCj4gDQo+IHNvZnRfb2ZmbGluZTogMHgxNDY5ZjI6IHVua25v
d24gbm9uIExSVSBwYWdlIHR5cGUgNWZmZmYwMDAwMDAwMDAwICgpDQo+IA0KPiBJdCBzZWVtcyB0
aGUgYWdncmVzc2l2ZSBiZWhhdmlvciBmb3Igbm9uLUxSVSBwYWdlIGRpZG4ndCBwYXkgYmFjaywg
c28gaXQNCj4gZG9lc24ndCBtYWtlIHRvbyBtdWNoIHNlbnNlIHRvIGtlZXAgaXQgY29uc2lkZXJp
bmcgdGhlIHRlcnJpYmxlIHNpZGUNCj4gZWZmZWN0Lg0KPiANCj4gUmVwb3J0ZWQtYnk6IERhdmlk
IE1hY2tleSA8dGRtYWNrZXlAdHdpdHRlci5jb20+DQo+IENjOiBOYW95YSBIb3JpZ3VjaGkgPG5h
b3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiBDYzogT3NjYXIgU2FsdmFkb3IgPG9zYWx2YWRvckBz
dXNlLmRlPg0KPiBDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IFlhbmcgU2hpIDxzaHk4MjgzMDFAZ21haWwuY29tPg0KPiAtLS0NCj4gdjI6
ICogUmViYXNlZCBvbiB0b3Agb2YgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vQ0FI
Ykx6a3BBRVpSVG1uT25qVkhZSEdKN0FwamRDOGVEaDUzREFuVEhzRzE4NVFHT2ZRQG1haWwuZ21h
aWwuY29tL1QvI3QgKE5hb3lhIEhvcmlndWNoaSkNCj4gICAgICogQWRkZWQgY29tbWVudCBhYm91
dCBwb3NzaWJsZSBmdXR1cmUgb3B0aW1pemF0aW9uIHdoZW4gaGFuZGxpbmcNCj4gICAgICAgc2xh
YiBwYWdlIChEYXZpZCBIaWxkZW5icmFuZCkNCj4gICAgICogQWRkZWQgcGF0Y2ggIzMgdG8gY2Fs
bCBkdW1wX3BhZ2UgKE1hdHRoZXcgV2lsY294KQ0KDQpUaGFuayB5b3UgOikNCg0KQWNrZWQtYnk6
IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
