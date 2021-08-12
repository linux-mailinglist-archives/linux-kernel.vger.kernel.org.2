Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8593EA178
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbhHLJDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:03:32 -0400
Received: from mail-eopbgr1400051.outbound.protection.outlook.com ([40.107.140.51]:9940
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235451AbhHLJDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVnT2XRKIVxKv2n5jK599ywuobV1KN86o8+YPsmsdyI8F3CFoqESPgUNuJHyyEHDPCB9NvtIUKFXneWNcb7Vwy+zBbL7/LNtyX2iXBnf/0lGSUS+Cux9ixgVLDYXlKS08cAYMenI95y547plzD2yrGG4qZZyQRo0gw8X9C/TkuXFkXKm1nFfGu0vN/K9LwhUAcmbKlRIhzHPME3/a+pJnveEzOhGhcrzP4lt6/M0z5YzDdgMrXnHYepRsuVExawM9H7/nmOcr3jDGezpsF2G0iIJ1aVYHxENc+BPSLxpKp/3S0OlasDqcwl9nmD5203xDKNt0dBxGayf1ZetYFSVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZI5bmIPUbNBFRaKQiRE+He5GlptvRNzYQl18yYCr+A=;
 b=oISpoD/Ozs3EwQGcknd3kgwRldeScVR4h1xZFowo7C8a00bIXbKhbbqn0fPVvjE9Vt4YyL7aqgQthbmN3IOVPnI+YaNtH+XvrgrvT3GD47Yq5urXWQGSB2bUyPhGA7mSEzhhgJ1RvWSLUcyZrN5alxRpFYOTDe3WQwiWGvWTx069T0d6kWzTqZUK7xp/2OPRuvhwrYWUbX48CmcPdlev/fiMzzKfOXtuamVlunsbJdKzKdKtaw8gUmWpnqtuLEIVCOZeo5fegrNw3JYkc7kkX/GdaDNvLMPCF8/eIoz1oopoTcbbaoMMpme6Ff3cU847Y7FsKXaWH4Eu4FaKQunyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZI5bmIPUbNBFRaKQiRE+He5GlptvRNzYQl18yYCr+A=;
 b=iwc/xVuXdeKZPLAntFc4F+Q1cbRKJ3TxZeaDc0+KNpYorWeJXomGunBP3yiuSDNN0AdAUqzgivWo0pMLaRuFwMQ6dAQ8piKRTAGXjQTQtfprU9p8UiGMNn33laP4VL7B7N0QUPUrGFd2OhLdsL1dIWd2P9YyFs4APptNA2gb8OE=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5677.jpnprd01.prod.outlook.com (2603:1096:400:45::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 12 Aug
 2021 09:03:04 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 09:03:04 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] mm,hwpoison: fix race with hugetlb page allocation
Thread-Topic: [PATCH v6 1/2] mm,hwpoison: fix race with hugetlb page
 allocation
Thread-Index: AQHXjzJ9+NCMdIrBR06t41b72146Vatvk1GA
Date:   Thu, 12 Aug 2021 09:03:04 +0000
Message-ID: <20210812090303.GA153531@hori.linux.bs1.fc.nec.co.jp>
References: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
 <20210603233632.2964832-2-nao.horiguchi@gmail.com>
 <20210812042813.GA1576603@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210812042813.GA1576603@agluck-desk2.amr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2492b50-0a8f-4b09-a594-08d95d6ffea8
x-ms-traffictypediagnostic: TYCPR01MB5677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB5677DDFAFA14868B957D6086E7F99@TYCPR01MB5677.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JYtG+BmpL5x9kAn5wmEzv0b5K4mn7Eztshp6BkzDMv6ZvDUv8KP/oMs2E5/vi0d6ig0PVemShWJM6HiF+dKdaMPuBT7fJJB6AEeFGL7K0YS87Mh4+E5ohU3uMYvNYHX/NQX382LWm/k9rtcLPlTt1HJFNl98SYaYhCUa1ATMGqzC3zCuvn9DkmzH76426MEc/jjVdWE8+SMR4LYGGtIFdRN9DK3TtrqSsKoPGqqFQdBTRD0wi/QH9V+XmKXkoWXvUQI+DMlWBbGhu6ih3vK5dONI2I3gMG7dAQ2UDl8eK2LhSbwtIxP5moDxeom7slG3ajZLeLydgZgseRaNeFDsdXQAOLxHMFTk4ubukPsFk2Jy+FCQ4L7DST5M8JTeQ1napEu3GRtAjOkRokuZuPVH37C/Ld+pE+en5EUdG1exDHZXX+QOu/LTqLBEmiQzxDcLTuKwMW7y6iyiMu1ZLCpO/CwoYkw+be1sU79pQq68zjnPml8M16cgPWSNNUYit1KI/LaPMrQM0YmLfVYvvsMIY5zbAubY49L9Smo1A2FTVIs5JT+jdM3RQVFAhz/mMb3b8N78cs30fumJvuee9FXKU++G8pJRRvqq2tmryyyyez2gflS0pSfMhjSEPNrFXjKRlXAO7efbmg58szKow8mvb33PgLupsfBpmvVmUaAoAFHewEqyJlD6pbTdEUxLppo2IyKGRs7EsVoBZZ02MPnRtlNCwEhNCG1oq+flGcigpvBmFkxmtSt7i7Ot24LEbBYCpDnOaHd2jZ+OonqUPVabLgFk/a/lzhTaYTV4z/r3/aA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(85182001)(6916009)(4326008)(478600001)(33656002)(8936002)(8676002)(6486002)(6512007)(2906002)(9686003)(5660300002)(66946007)(66476007)(66446008)(76116006)(71200400001)(6506007)(55236004)(122000001)(186003)(38100700002)(66556008)(64756008)(26005)(86362001)(83380400001)(38070700005)(1076003)(54906003)(316002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEFqWWFycFRjTXZ3Y1N4Sk1mc09wK3JldmJyTGp5VmZuZ09lb0F1U21kU0lE?=
 =?utf-8?B?V3hGQklXdklMNlhwcldiVmJEamNYbzR3UmF1dDJMQTl2U05TRCtoSFZrb0ts?=
 =?utf-8?B?SjJZR0MyajF6Z0JCQ3liL3J1azcwYWN3Vk5vYTZ2Q0QwcjdYbUdVUDlMdXpY?=
 =?utf-8?B?VVBMdEl2SkFmTjRKQy9mdkZoRWttZFpvMFhFUFhGcjVLcTVsY1VGQ0dQUC9a?=
 =?utf-8?B?bklnd0t4Qm1WQW8xRUhlUjEzTGd3WU1nREpQRjh6UFBzbjBSYTQwQWltOTcw?=
 =?utf-8?B?ZXR1KzN6UUdTK1RxeWlXUHdOTTg3UUV1NlV0Z2RRbUtuUzN2UFpybnJlTnFQ?=
 =?utf-8?B?SWdwSVpqZk52NDFoKytFb1ZVbHRlYTFOUGFDZGIyRTBLZW5jaWZwUk1yNFBm?=
 =?utf-8?B?d2Y2UE9XaXY4ak1VeFFTd1R6TUhUM29TdnpjdVNjdU1XOEgyMHUxK3FQTG9F?=
 =?utf-8?B?ZER0b1VEdGU1NDNlUmc3dXpoRUF3MkVEc1B0VXdpbGhkTkMyWVNkTjdEbE5x?=
 =?utf-8?B?K1BIYnozL1hvZS9FcW8wazRBMnByTVdIcFZLSDdydkcwYU1VVUpPbGtpU3Ry?=
 =?utf-8?B?dHJhM0U2NVJ2WVlzZWdIdHVSVE92N2Z5VmlrRDFhL0J2SE9iZ3djVEtndlAr?=
 =?utf-8?B?N3dlRTg1amtJQjY2YVJmTy90WWJZV1JEc3lvQzQvREd6cVZhR1hLQWJmYy9h?=
 =?utf-8?B?UkdGNHh6LzhHK1RuSHMwWC9DRlhyZ3NIOS9mVjQ0blRXcmpQQlR1Q0xzSVB2?=
 =?utf-8?B?QW54MTNiODdwbmtkNnBnSGRxNWJGaGFwNjZwM0tyNUJEeUpDWVRqeEM5ZVln?=
 =?utf-8?B?RUt4T01tTWlnNmp3aDFZVURRQkY2Y1JZS1JUeEJHRHhFdWlYcERSMW51K1BL?=
 =?utf-8?B?YlBQM1B6Yk51RnNBc2lMQW5rQTRXWkpYbUNMTTkrVVdFdm5ZZkhRT3BlVFp5?=
 =?utf-8?B?Z29SNWdXR29hd0RLUTdVdjVPOHJzczhnKy9WRExob24xeDdMMGF5RE5nc1c5?=
 =?utf-8?B?eXJOWkZ6VWlCM1ZITGs2UUNmbjYzUGRuaGliR0lScGRacEhwMUR4ZG10ZFNB?=
 =?utf-8?B?TStDd1cyOERxanRlQ2ZJTUxoY3gwd3N1OW01SW5KQXVSZFppQmEzaWF5ZnJM?=
 =?utf-8?B?WG52L0dua1dmOWc3UEpUa1hlRnZ5d0xWR1Vpbk8rUUxpcGVoQ2ZIRy9qNkh5?=
 =?utf-8?B?MFRUTXE3eXlLbDZlU1NvbEpISTZsM2prZ09iQmhLV1gxbW40UVovZGthZUFI?=
 =?utf-8?B?Wjl6MERGV2tHS3F5Q3ZDeHE2K0x6a052cVJWK1N2ZjdpK2ZFQXNqcTlPYVBT?=
 =?utf-8?B?dXB2b3hhMjdjdFJNbk5NNkZrRmZxdXhVVS9pWkl5a0Q3QWxlOVFIK2F3K0ZR?=
 =?utf-8?B?eXM3Wk9sS1djYmtOYW56KzFHajNONmZ2WEFPK0duYVhSZWEyUlFPUXVoNENk?=
 =?utf-8?B?NG10bEFKSGttZjN2TmZNOFUvK2FWc3lkb2o3RjUrU0M0dmlLZVRlK000Znoz?=
 =?utf-8?B?ajRqRlp2YWVoeXdqV0dmdHQ5K2tmZDN3MzFtdW5jTWprRnd0Y2p4RExjbFBK?=
 =?utf-8?B?WE1qL1dtRDBlaVVMbmhTeGJvUE9mNXNpOWN5SHNMbDdNejJwMHVDT2Nyd29z?=
 =?utf-8?B?VHZqM3NITmtpR2NhWEwrbzRYUDJkQ3ViK1RHY1YvUHJvTjAwemhyVGIwV2JS?=
 =?utf-8?B?Z0dKRlFPK2Nua0hNNzZMVUtheXhBcDdvMnVwQTcrT3VpbC8xMlNabGprSTVu?=
 =?utf-8?Q?yqBtLJYFOU1NduNrQMjgS26uImyBtcI6u0vn/Fj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11C1A1F5F5582A48B6F7983D3858668B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2492b50-0a8f-4b09-a594-08d95d6ffea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 09:03:04.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJwLH0nqCa7euoeuzTZoyd+gQfZS3Gk2bMchPoChcBBOucJ/z2kCe5DxXpIqLkoSmmquQA6FByQQYM9F2W7mwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5677
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMTEsIDIwMjEgYXQgMDk6Mjg6MTNQTSAtMDcwMCwgTHVjaywgVG9ueSB3cm90
ZToNCj4gT24gRnJpLCBKdW4gMDQsIDIwMjEgYXQgMDg6MzY6MzFBTSArMDkwMCwgTmFveWEgSG9y
aWd1Y2hpIHdyb3RlOg0KPiA+IEZyb206IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hp
QG5lYy5jb20+DQo+ID4gDQo+ID4gV2hlbiBodWdldGxiIHBhZ2UgZmF1bHQgKHVuZGVyIG92ZXJj
b21taXR0aW5nIHNpdHVhdGlvbikgYW5kDQo+ID4gbWVtb3J5X2ZhaWx1cmUoKSByYWNlLCBWTV9C
VUdfT05fUEFHRSgpIGlzIHRyaWdnZXJlZCBieSB0aGUgZm9sbG93aW5nIHJhY2U6DQo+ID4gDQo+
ID4gICAgIENQVTA6ICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVMToNCj4gPiANCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnYXRoZXJfc3VycGx1c19wYWdlcygp
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWdlID0gYWxsb2Nf
c3VycGx1c19odWdlX3BhZ2UoKQ0KPiA+ICAgICBtZW1vcnlfZmFpbHVyZV9odWdldGxiKCkNCj4g
PiAgICAgICBnZXRfaHdwb2lzb25fcGFnZShwYWdlKQ0KPiA+ICAgICAgICAgX19nZXRfaHdwb2lz
b25fcGFnZShwYWdlKQ0KPiA+ICAgICAgICAgICBnZXRfcGFnZV91bmxlc3NfemVybyhwYWdlKQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgemVybyA9IHB1dF9wYWdl
X3Rlc3R6ZXJvKHBhZ2UpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBWTV9CVUdfT05fUEFHRSghemVybywgcGFnZSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGVucXVldWVfaHVnZV9wYWdlKGgsIHBhZ2UpDQo+ID4gICAgICAgcHV0
X3BhZ2UocGFnZSkNCj4gPiANCj4gPiBfX2dldF9od3BvaXNvbl9wYWdlKCkgb25seSBjaGVja3Mg
dGhlIHBhZ2UgcmVmY291bnQgYmVmb3JlIHRha2luZyBhbg0KPiA+IGFkZGl0aW9uYWwgb25lIGZv
ciBtZW1vcnkgZXJyb3IgaGFuZGxpbmcsIHdoaWNoIGlzIG5vdCBlbm91Z2ggYmVjYXVzZQ0KPiA+
IHRoZXJlJ3MgYSB0aW1lIHdpbmRvdyB3aGVyZSBjb21wb3VuZCBwYWdlcyBoYXZlIG5vbi16ZXJv
IHJlZmNvdW50IGR1cmluZw0KPiA+IGh1Z2V0bGIgcGFnZSBpbml0aWFsaXphdGlvbi4NCj4gPiAN
Cj4gPiBTbyBtYWtlIF9fZ2V0X2h3cG9pc29uX3BhZ2UoKSBjaGVjayBwYWdlIHN0YXR1cyBhIGJp
dCBtb3JlIGZvciBodWdldGxiDQo+ID4gcGFnZXMgd2l0aCBnZXRfaHdwb2lzb25faHVnZV9wYWdl
KCkuIENoZWNraW5nIGh1Z2V0bGItc3BlY2lmaWMgZmxhZ3MNCj4gPiB1bmRlciBodWdldGxiX2xv
Y2sgbWFrZXMgc3VyZSB0aGF0IHRoZSBodWdldGxiIHBhZ2UgaXMgbm90IHRyYW5zaXRpdmUuDQo+
ID4gSXQncyBub3RhYmxlIHRoYXQgYW5vdGhlciBuZXcgZnVuY3Rpb24sIEhXUG9pc29uSGFuZGxh
YmxlKCksIGlzIGhlbHBmdWwNCj4gPiB0byBwcmV2ZW50IGEgcmFjZSBhZ2FpbnN0IG90aGVyIHRy
YW5zaXRpdmUgcGFnZSBzdGF0ZXMgKGxpa2UgYSBnZW5lcmljDQo+ID4gY29tcG91bmQgcGFnZSBq
dXN0IGJlZm9yZSBQYWdlSHVnZSBiZWNvbWVzIHRydWUpLg0KPiANCj4gSSdtIHNlZWluZyBzb21l
IHN0cmFuZ2UgcmVzdWx0cyB3aGVuIGRvaW5nIGEgc2ltcGxlIGluamVjdGlvbi9yZWNvdmVyeS4N
Cj4gDQo+IEN1cnJlbnQgdXBzdHJlYW0gb2Z0ZW4gZmFpbHMgdG8gb2ZmbGluZSB0aGUgcGFnZSB3
aXRoIG1lc3NhZ2VzIGxpa2U6DQo+IA0KPiAJImhpZ2gtb3JkZXIga2VybmVsIHBhZ2UiDQo+IG9y
DQo+IAkidW5rbm93biBwYWdlIg0KPiANCj4gVGhpbmdzIHdlcmUgd29ya2luZyBpbiB2NS4xMi4g
QnJva2VuIGluIHY1LjEzLg0KPiANCj4gQmlzZWN0IHNheXMgdGhhdDoNCj4gDQo+IDI1MTgyZjA1
ZmZlZCAoIm1tLGh3cG9pc29uOiBmaXggcmFjZSB3aXRoIGh1Z2V0bGIgcGFnZSBhbGxvY2F0aW9u
IikNCj4gDQo+IGlzIHRoZSBjdWxwcml0ICh0aG91Z2ggaXQgaXMgcG9zc2libGUgdGhhdCB0aGVy
ZSBpcyBtb3JlIHRoYW4gb25lDQo+IGlzc3VlIC4uLiBmYWlsdXJlIHN5bXB0b21zIGNoYW5nZWQg
YSBiaXQgZHVyaW5nIHRoZSBiaXNlY3Rpb24pLg0KDQpTb3JyeSBmb3IgdGhlIGZhaWx1cmVzLiBJ
IHRoaW5rIHRoYXQgdGhlIGZvbGxvd2luZyBwYXRjaCAoYW5kIGRlcGVuZGVuY2llcykNCnNob3Vs
ZCBzb2x2ZSB0aGUgaXNzdWUuDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIx
MDYxNDAyMTIxMi4yMjMzMjYtNi1uYW8uaG9yaWd1Y2hpQGdtYWlsLmNvbS8uDQpJJ2xsIHN1Ym1p
dCB0aGUgdXBkYXRlIChtYXliZSB0aGUgcGF0Y2hzZXQgd2lsbCBiZSBzbWFsbGVyIGJ5IGZlZWRi
YWNrcykNCmxhdGVyIHNvb24uDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+IA0KPiBU
aGlzIGNvbW1pdCBkb2Vzbid0IHJldmVydCBhdXRvbWF0aWNhbGx5IGZyb20gdXBzdHJlYW0uIEJ1
dCBpdA0KPiBkb2VzIHJldmVydCBmcm9tIHY1LjEzLiBSdW5uaW5nIHdpdGggdGhpcyByZXZlcnRl
ZCBmcm9tIHY1LjEzDQo+IGdpdmVzIGtlcm5lbCB0aGF0IHJlY292ZXJzIG5vcm1hbGx5WzFdIGZy
b20gaHVuZHJlZHMgb2YgY29uc2VjdXRpdmUNCj4gZXJyb3IgaW5qZWN0aW9ucy4NCj4gDQo+IC1U
b255DQo+IA0KPiBbMV0gQWxtb3N0IG5vcm1hbGx5LiBNeSB0ZXN0IGNhdGNoZXMgU0lHQlVTIGFu
ZCBwcmludHMgdGhlIHZpcnR1YWwNCj4gYWRkcmVzcyBmcm9tIHRoZSBzaWdpbmZvX3Qgc3RydWN0
dXJlLiBTb21ldGltZXMgdGhlIGFkZHJlc3MgaXMgY29ycmVjdA0KPiBvdGhlciB0aW1lcyBpdCBp
cyBOVUxMLg==
