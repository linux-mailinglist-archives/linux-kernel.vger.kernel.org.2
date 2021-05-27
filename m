Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D83923D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 02:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhE0AgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 20:36:12 -0400
Received: from mail-eopbgr1410057.outbound.protection.outlook.com ([40.107.141.57]:25696
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231911AbhE0AgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 20:36:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP+pFcym4KUJSET9ecwcvyWRMvE19i+jwwenmWETayrwXYVXQAR16CuCyZoYUNg2woUhITE3LPWoj8fXCYu/qQJh3DxoDubtFhfbRo+WKHtQ0RAueUMRjbP4lTE3NFwivuAwllI2szdpEQAHJ/mb+dIv1+y6QLK1J0Sd0NnBq/sdj9Mdpextbghz2N6GhDwIxxSdjP43dkCzhV0Llr8vB9nUiAMfjU156DCZiCmIOdo5nvGWI+d3PeKZarwN9sqD2nB/QkBcwaCwZwsTq/NwWvdQGP4YMpSxAtaXE8Hcc05DMc9Vr8+5iWZHMvfCU1KcPSJINdvg2Lbv/g+RLr4ayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxZ7UZReyOVsbbhYIusKfh0WBWZUNgWu6cK0sD8p1Z4=;
 b=Mmkg3mqnRslpiv08CJ0xRCWnqddrLs+ee1Uv7irqhvRZLTyQVG8jzeS43GHtVFGrgO3jjdPOiASeej+puOGUfo+2ZtVpQD5jFuRckrmvbnmrqS1tZk66JNOhHfZunmIxaT/MORgMxpK1pYyi0SFE9JLnbnkxbMiJLHlqdNaYYVLkxPUf9kGQ4oaqUW+E4/SyVHbRnuraIzTu089rd0hpy8M+w9X2ZoNh/nbR6aHA9BgN63yAPnolFuCIY/83gmoCYmXkmei8DP43QTVLcx7nlehC51LbH1W7pH3WesLa3rxHdj4274SkqnkTWMDABs/HTVo55J5ipTKS8u59SrMXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxZ7UZReyOVsbbhYIusKfh0WBWZUNgWu6cK0sD8p1Z4=;
 b=L7qD8ZbFN7aGTAGqf0A7W6+Curipsx21AoQ+ZpNw3tCyuhzLaA+eNMeMd7uGdk02awmweWxr+0JMAeYENBjYH7kknnqXPGw3W0gkxtiRpxROxhL6KBCWlbLdyb5NVfdK80vKCO05wxY7Kcp7802nV37zxDPBVLpbPJtRALgnHc8=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5677.jpnprd01.prod.outlook.com (2603:1096:400:45::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 00:34:37 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 00:34:37 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Ding Hui <dinghui@sangfor.com.cn>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3] mm/page_alloc: fix counting of free pages after take
 off from buddy
Thread-Topic: [PATCH v3] mm/page_alloc: fix counting of free pages after take
 off from buddy
Thread-Index: AQHXUgQ0i86d00ztqkiYl0r2wtGCuar2fBsA
Date:   Thu, 27 May 2021 00:34:36 +0000
Message-ID: <20210527003436.GA3543069@hori.linux.bs1.fc.nec.co.jp>
References: <20210526075247.11130-1-dinghui@sangfor.com.cn>
In-Reply-To: <20210526075247.11130-1-dinghui@sangfor.com.cn>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sangfor.com.cn; dkim=none (message not signed)
 header.d=none;sangfor.com.cn; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e94ecdf4-8325-4e9c-ace1-08d920a7350e
x-ms-traffictypediagnostic: TYCPR01MB5677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB56776BDEBF204AABAE96CA7DE7239@TYCPR01MB5677.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0jQT3vqaCCiBX8OQr6wFJu+Moe2K6jWspDdKw6nIwlPuFajgtBCCs8PVb/4z/B6VjrlNFfWDoISFb8YUDiPD1QH/1iEIIVbXXHjhXMA8OieZgQhFS3zObVKDRSwwjzdVTUYePFG3I9qCFEnBoK0mLqPuu4XkwOQISDdmMzEbBex/boQeq8IrVFfkSLNm7vxg1O2k2qkkaqOWv1r9Yb8bBAGAK6Mn17ByNUYdVcPpYTdzqZMYHo902TGQKDbkRoKUDnkZMvmUeBUuYMIHk3kzvAyAQ5FQhV/08e0RxGAX+6YqP8TVbwn0SISjnK+i8hnvcmtt0lp3Swn/10nIli9jOEb6ctwTZ8P3Yp+NFTYKVMKmcA25FHQf/pWf+jWAIc27/u7e0EeWKjayLxnM6IOUeGfZvASW5SzHq7A/AkAu6GPvQeMMrVWLIkoLpON5+P8/4Tf1k9om6KMOzQ5hE+J6CPr3/eAzlJNsWXa+SgPUcL6WyDVodGS/aUpF8f2k29ZfgtkhVMPFu6bYLYevRIQjQN8spIag9Jz9vZZMRvwkcGJacl378kH9vZU7Pbjjj2dBIgm6SiVHb9AedirWtf/UjxyWVS3H2RJZZmStIgenC3Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(6916009)(122000001)(1076003)(55236004)(64756008)(66446008)(38100700002)(316002)(6506007)(6486002)(186003)(71200400001)(66556008)(86362001)(66476007)(478600001)(8936002)(4326008)(8676002)(54906003)(5660300002)(2906002)(66946007)(83380400001)(26005)(76116006)(33656002)(85182001)(9686003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UGxQQ1ROSVMvZEZweWdadkRFSVNvREUvYWszeEFNangvV3Y5SWo5S1dkbW5k?=
 =?utf-8?B?NjRMeEtWemdKMVQ1WlhERm1jN3llc3V5anlpTDd3ZlpQbzhQbnliZGRlSFJj?=
 =?utf-8?B?VHlOU2VGMS9xek5vUHhzdXgrMnFGWFBhM01TRldzUEpoOUVXa1hNV2tCcVlV?=
 =?utf-8?B?dlVGQXRJbC9WUDdaa3JBbmhLS3VVcVRPeG5GUkhvdG1lYTY3bDNKZFpDNjFO?=
 =?utf-8?B?azdZcHd5Sk9laWU1Ymx0TThOcDQvNVlSVGhFTysweiticEZoWFNMS1BuTStK?=
 =?utf-8?B?cHBRV1dIazY2Z3NPYjE2V0N5elVtWTIyWnF2VjNNTTlsKzZlTVU3d25xdlIx?=
 =?utf-8?B?S1VzZGg2WTd0NWQ4eXdJYkJ6eGZEN25SN1pPSE9aamhlenM5RldpUlJuRm1W?=
 =?utf-8?B?ZDRaYlVhYlVpYlJ6NmZkRERCcWJiT0g2MUJwK1hobEg1dStuVXkwWm1LNU5Y?=
 =?utf-8?B?QUhoaE4zYXNvZis0SWVDaWtFUlpmWi9PRlEvTE92c09GVmRiblBsVGdpb3FV?=
 =?utf-8?B?WjdDdGRDN0hMWmcxRjErUTV1cHd0Z2hmbG9qc21TeVhOVnBQMEhzR0NmUmtP?=
 =?utf-8?B?c1BKY0JjbjI5d0twamZLMDMraFcyRVlrdW51M3F5d3BLanpEc0xudUFYMXBP?=
 =?utf-8?B?UXhSZTNQeXdERGVGYkdYS1VhY1dwNTlrTldlY2VNZk5uMnd3M0ZpWlIxWVM3?=
 =?utf-8?B?SFJPT2d3VGRmWjhISlRkOFJtTWtacEprZHY2R201TVYrRWgyRDM4QjU1d1A5?=
 =?utf-8?B?QjFoZDN1RWFjUFJXd0NVVVdJaC9ha09BVWhQUDQrN3EwaXl4Sk1NV1NwNUdV?=
 =?utf-8?B?a2labkRwdlAzZnM3eFBrTVdFZEozL01LdFZQY210NXdtVS9ad1V1aXZpWEVr?=
 =?utf-8?B?SDJ0bzFoVWhGOVJXSHgvU0w0Z2psWlk3Znc0SVRESnRaNUxJcVFCbWRoUG9q?=
 =?utf-8?B?NU1VMXMwZ1MvMmRyS0gwQ1VFR2J0WTg5ZEJ4Nkd4RjJlM0J4VDlITk1nWi9o?=
 =?utf-8?B?RmVwUWJjc1NFK2FTY2lpMHlmdTZnTFEzT1BTZnJIVEVwaVRzbkdEcUFYQTNU?=
 =?utf-8?B?d3drUjlXR0pRVzA4Rks2V2x2ekt1WElaSW5HVXd1VGtsd3Z6dnNaeCs0R1p1?=
 =?utf-8?B?VVNwQWNXWEt6RWJFRStYNi9qL202aUZNR21sbmFhYWJLaG1qZE5YVExkYU9T?=
 =?utf-8?B?a0FNUzg2cTliampwY2R6VmFvOSsxQ0ZKRHA2T2hRMlpsRUkrWWFMMWo0WWZ6?=
 =?utf-8?B?d3M3RHovWTl6VVovNTJZRkxCMzdVVDJhS1dweDdYbVdGcnBjQkNkV010c3pm?=
 =?utf-8?B?a0RiejI1ZHlHbm1iODhlNC92Z29IdFBZK0E5MkhYUjdYNzMva1pXbFBoR09m?=
 =?utf-8?B?V0VFTFlCeDUwSVd6emlQM0RBVkhxQjh2TTBiZWJMTmlrZzZrUDFsVVY3NXdG?=
 =?utf-8?B?c2szTHVQK0RrblJmVFQ0eEx6c3l3NU1CVjlaRTYvclN2ZlFiWmxDVDU0Z3d6?=
 =?utf-8?B?ZVRHTVdIK0dPWXp2cDNMZmt0aWhZajF6K1MzZ2FRNFdSK1pzN2RKNURhZ1ZL?=
 =?utf-8?B?MmFDQi9TMzduZnpaZVFSNTZ4dHk1RGhvKzM2ME5IM1VyTXMvbXlEalZTVmJT?=
 =?utf-8?B?ekxocTFzbUZsdFVBSGIvYnZ6c2Q3N2EvUklJSVJSQXdhV1RrMkFHUzg3VTM3?=
 =?utf-8?B?dUhEeERlZlRhYk0rVHRraDlJT2pyQmxNQmtnRTBWQWduNWJSYXE0cTNnRmJa?=
 =?utf-8?Q?ICZO3TFO59dnP6cLIlvPVNJYtEhZxclMRXNriIr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A69C9EDA5560744A6B91C270C3A9E3D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94ecdf4-8325-4e9c-ace1-08d920a7350e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 00:34:37.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8MbhMZiTHA4SZouCT7bduLxEvBbfu4V+/HM0sVpOYGd9NCV6PVUwWWngLsDH8HfB75+/usJ9WYnfM8DM47vAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5677
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMjYsIDIwMjEgYXQgMDM6NTI6NDdQTSArMDgwMCwgRGluZyBIdWkgd3JvdGU6
DQo+IFJlY2VudGx5IHdlIGZvdW5kIHRoYXQgdGhlcmUgaXMgYSBsb3QgTWVtRnJlZSBsZWZ0IGlu
IC9wcm9jL21lbWluZm8NCj4gYWZ0ZXIgZG8gYSBsb3Qgb2YgcGFnZXMgc29mdCBvZmZsaW5lLCBp
dCdzIG5vdCBxdWl0ZSBjb3JyZWN0Lg0KPiANCj4gQmVmb3JlIE9zY2FyIHJld29yayBzb2Z0IG9m
ZmxpbmUgZm9yIGZyZWUgcGFnZXMgWzFdLCBpZiB3ZSBzb2Z0DQo+IG9mZmxpbmUgZnJlZSBwYWdl
cywgdGhlc2UgcGFnZXMgYXJlIGxlZnQgaW4gYnVkZHkgd2l0aCBIV1BvaXNvbg0KPiBmbGFnLCBh
bmQgTlJfRlJFRV9QQUdFUyBpcyBub3QgdXBkYXRlZCBpbW1lZGlhdGVseS4gU28gdGhlIGRpZmZl
cmVuY2UNCj4gYmV0d2VlbiBOUl9GUkVFX1BBR0VTIGFuZCByZWFsIG51bWJlciBvZiBhdmFpbGFi
bGUgZnJlZSBwYWdlcyBpcw0KPiBhbHNvIGV2ZW4gYmlnIGF0IHRoZSBiZWdpbm5pbmcuDQo+IA0K
PiBIb3dldmVyLCB3aXRoIHRoZSB3b3JrbG9hZCBydW5uaW5nLCB3aGVuIHdlIGNhdGNoIEhXUG9p
c29uIHBhZ2UgaW4NCj4gYW55IGFsbG9jIGZ1bmN0aW9ucyBzdWJzZXF1ZW50bHksIHdlIHdpbGwg
cmVtb3ZlIGl0IGZyb20gYnVkZHksDQo+IG1lYW53aGlsZSB1cGRhdGUgdGhlIE5SX0ZSRUVfUEFH
RVMgYW5kIHRyeSBhZ2Fpbiwgc28gdGhlIE5SX0ZSRUVfUEFHRVMNCj4gd2lsbCBnZXQgbW9yZSBh
bmQgbW9yZSBjbG9zZXIgdG8gdGhlIHJlYWwgbnVtYmVyIG9mIGF2YWlsYWJsZSBmcmVlIHBhZ2Vz
Lg0KPiAocmVnYXJkbGVzcyBvZiB1bnBvaXNvbl9tZW1vcnkoKSkNCj4gDQo+IE5vdywgZm9yIG9m
ZmxpbmUgZnJlZSBwYWdlcywgYWZ0ZXIgYSBzdWNjZXNzZnVsIGNhbGwgdGFrZV9wYWdlX29mZl9i
dWRkeSgpLA0KPiB0aGUgcGFnZSBpcyBubyBsb25nZXIgYmVsb25nIHRvIGJ1ZGR5IGFsbG9jYXRv
ciwgYW5kIHdpbGwgbm90IGJlDQo+IHVzZWQgYW55IG1vcmUsIGJ1dCB3ZSBtaXNzZWQgYWNjb3Vu
dGluZyBOUl9GUkVFX1BBR0VTIGluIHRoaXMgc2l0dWF0aW9uLA0KPiBhbmQgdGhlcmUgaXMgbm8g
Y2hhbmNlIHRvIGJlIHVwZGF0ZWQgbGF0ZXIuDQo+IA0KPiBEbyB1cGRhdGUgaW4gdGFrZV9wYWdl
X29mZl9idWRkeSgpIGxpa2Ugcm1xdWV1ZSgpIGRvZXMsIGJ1dCBhdm9pZA0KPiBkb3VibGUgY291
bnRpbmcgaWYgc29tZSBvbmUgYWxyZWFkeSBzZXRfbWlncmF0ZXR5cGVfaXNvbGF0ZSgpIG9uIHRo
ZQ0KPiBwYWdlLg0KPiANCj4gWzFdOiBjb21taXQgMDZiZTZmZjNkMmVjICgibW0saHdwb2lzb246
IHJld29yayBzb2Z0IG9mZmxpbmUgZm9yIGZyZWUgcGFnZXMiKQ0KPiANCj4gU3VnZ2VzdGVkLWJ5
OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBEaW5nIEh1aSA8ZGluZ2h1aUBzYW5nZm9yLmNvbS5jbj4NCg0KVGhhbmsgeW91IHZlcnkg
bXVjaC4NCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5j
b20+DQoNCkFzIGZvciB1bnBvaXNvbl9tZW1vcnkoKSwgSSdtIHdyaXRpbmcgcGF0Y2hlcyB0byBm
aXggdW5wb2lzb24gKG1heWJlIHRha2VzIGENCmZldyB3ZWVrcyB0byBiZSBwb3N0ZWQpIGFuZCB0
aGF0IHdpbGwgYWRkIGEgcmV2ZXJzZSBvcGVyYXRpb24gb2YNCnRha2VfcGFnZV9vZmZfYnVkZHko
KSB3aGljaCBzaW1wbHkgY2FsbHMgX19mcmVlX29uZV9wYWdlKCksIHNvIE5SX0ZSRUVfUEFHRVMN
CmNvdW50ZXIgd2lsbCBhbHNvIGJlIGhhbmRsZWQgY29ycmVjdGx5IHdpdGggdGhlIHBhdGNoZXMu
