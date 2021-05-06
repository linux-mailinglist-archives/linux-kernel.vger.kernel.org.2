Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F4A374DAF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 04:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhEFCup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 22:50:45 -0400
Received: from mail-eopbgr1410070.outbound.protection.outlook.com ([40.107.141.70]:12757
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229603AbhEFCun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 22:50:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5UCu5S0CuUHo+0rBgbL8X47z7dO5ilm/OD0ZAGrk1JxJH+iinaqoPCNa39XsSjfOMSpbJcD5eDFRthdhbIk7xocK5VuKXsq02rxBBZNAdUhuSsL1pf4TdZjq3RnGF5rMWx7LELVg+z/qXHq6zHI91pskIrxatsKdLkzh2YKpFgAZpqTFxJWScAzpsH9bcvcdkBr33EezlQ6/sVw/tCJuPbWxUxros1vERyc7gOLuofvhByUg6J74oOLfcECPQSse5DsFj+IGwfa206wJnRSHH/S7YrjW+j37pTlBzksM9MKQEf4SdkbRelkDON6EMo9hbN7mvC9gi5n/s3OpoUOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vLATFQB8ap239lcY/nbGKntEyP9Ge+9fKElLx8qAL0=;
 b=N+uFVk1vFuWQqAKwQPIKK8AxfD61X/xz/lj1G5AthbilWK8iMGNnRGie6oBwAfalZriNqQulPz16qJg7fBiv3llp6LMtWmIr2rzXMoxGt3S0EaJI4VDQgT3aGr1Hl8amBK29RoqvXRXiLvp9huPR5qk276ArqUIK0fxmWR/yaowkeeOV/0WCNYXmIwemcgUDXsKABThpzmiqP7Y6M6ENLyauJeYD+ZFw4Tp7FWLHeNkdF5baxJo9AL8cVgZkOSo1ELKkAdAox6QwNgBOZzMZPZyyh1drBB+c2cKbUb2s4n2d2tG3y2ruxD1xLN2exNWTP05VIPli35GeSbvHVKPKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vLATFQB8ap239lcY/nbGKntEyP9Ge+9fKElLx8qAL0=;
 b=fKoWqWThoZXtKaOZ6xmVHvtdFovS1o2iIJQeF8KvnIE/6FweAjnhFxHvV4Up6E58FI1nZhPoPUepM3tJLBQQ2k4L3kggDpkwGpjFF1kZ5tiboYUXDliIR6oa24BGbdyveVTCqjXlbOTdJKibTpAkAOqNWuos9Inmqnb1IHFoZMQ=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3965.jpnprd01.prod.outlook.com (2603:1096:404:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 02:49:44 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 02:49:44 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     David Hildenbrand <david@redhat.com>,
        Ding Hui <dinghui@sangfor.com.cn>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/page_alloc: fix counting of free pages after take
 off from buddy
Thread-Topic: [RFC PATCH] mm/page_alloc: fix counting of free pages after take
 off from buddy
Thread-Index: AQHXNlLKvz3SGzZaekOMSRQ4ewYPVarKEEWAgAvIBIA=
Date:   Thu, 6 May 2021 02:49:44 +0000
Message-ID: <20210506024943.GA1777607@hori.linux.bs1.fc.nec.co.jp>
References: <20210421020426.5914-1-dinghui@sangfor.com.cn>
 <dd242708-e3f5-ab9f-64d4-9efe3b7168ce@redhat.com>
In-Reply-To: <dd242708-e3f5-ab9f-64d4-9efe3b7168ce@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7f9807b-d392-459b-bcec-08d910399ab8
x-ms-traffictypediagnostic: TYAPR01MB3965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3965D70BAA930559C7884BE0E7589@TYAPR01MB3965.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7VlXjN7DcdUNiGbAsInTDYF22JNDgfgCTEEcvn9oMEQvxkroSnklV4A7baUNdUXbspt3dGsJRcsG8WMzPoqzMToiiqyL3xKygF6gdr12F9yk5wL9nhne1JGoa1dDxaUryDgDo1jqe64O5VFsI1lFKNfvqEsVSmKHBGEE4+G69IAzQSm+YDVIe51Z+hakz0zUIxumOcZ6eXGO3J7//pYeXEHUzHjuUqbdW1pPtKFH1sR7IyHO0qa7St/0hI6MEzZulBZELOlSRgMKC7SteTCRhrDyNpByuVaJ44opfldOOEIdhJ99PtvDoQQCQxcK0lUxs0lTXJR5mCpbr66LEhgxpRvF8CJG7fF3E91ahUyPw/Q2om4qxfPQq4dkr5EXSa7RGV88ZSmM0HB8jn1E+T9MZ2FD89p5tWI6GpEwraO5gW7CjXLO1AMn8xkhF3GHrZFa2SjUgCbgWBzmFMpVtYV+hLzacN8+a+j2OnH1zXmqYdHMnbaJYBeo5kyr18m1OCtU3gHcp+iAF9ROq5flvn3QOPusSUBEYV6ptWySlovTPVGZppjuOnmV1TypZx86YDKfAEFqgBe5kUsFHDU9xXAJ5ENjWNlHNNXd6lx1buUXFMA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(66476007)(85182001)(186003)(71200400001)(66946007)(6512007)(1076003)(83380400001)(64756008)(66446008)(76116006)(2906002)(5660300002)(9686003)(66556008)(8676002)(110136005)(86362001)(33656002)(54906003)(38100700002)(122000001)(6486002)(55236004)(6506007)(26005)(4326008)(316002)(478600001)(53546011)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SDI0b1hGQTJRRzBvR0JGOGZEY21tVWVLZlNsZGpCbDY2NUUxOHNSZzZlcFl0?=
 =?utf-8?B?Q1pxdCtLK0tIQUc3UHZmb0hRazdNeWpMTEo2NkNmVVNaTFNJNkFacGVtNVpr?=
 =?utf-8?B?ZnlTdXM5SXZrYTU4V29vbkR6TThhZm8wSE90TFFvM2EvTTUwWGlOdWwvOU1G?=
 =?utf-8?B?cW5SMjFMdVIyVFVXK3BrNklMVjN0alJEU1VSYmswUG0xVnZYTjk3M0Y3MVVo?=
 =?utf-8?B?MGY2S3VwaE5JYzNYeWdjZEpsKzhiaFJoZ0VOYmtONTc1UkFseDhIZXppYXB6?=
 =?utf-8?B?RGpsOU9teWhWY3VzY1gzNzlDUmN4cnVPN0VjVnM5VHdjaU5PNG1wSTB3U1VX?=
 =?utf-8?B?cTBqN0EwejZzNE93Z21XaTV0WUVIVkVSSWMwZS8rQlJlSWlKYnVTaTN6eG1K?=
 =?utf-8?B?QmtJZ2ZkV2NrWlJ1OW9mek0rTXBXK212T2YzZXIybnpsZWdMeGhzVnRpLzZO?=
 =?utf-8?B?QmttSHB1ckxwUmt4QmxmQjRVbnduSFBCUFRTZ3RvVDg4TDZjVks4ZVRmTXh6?=
 =?utf-8?B?bEdVd2FQNVA5bDVzVDZyUWtPRHlYenhhVW5KTlpXRzUzbVVDZDRZTTBmTTBt?=
 =?utf-8?B?bnJ2TzBDd2YxR0NEQVhsbEQ5VG82dEZhRzhBL0d0aDRQaGJnWEpLQjQ2RmND?=
 =?utf-8?B?QXFHbWNGb1QyRDgya2Y0TDVHcm9TQ0U2amttN25uTXIzaFBYS0wxV0NSd3pV?=
 =?utf-8?B?UkxqaUNUbkNKK3hBdDNJWlIrRlhId1JBZ2JBd1BEUHVlT2NSak1wVVhycFh3?=
 =?utf-8?B?RWxPTW1USVc3NGpaaEhzM016T2t6ZUdOVGpJbXZmbUx0UVV0WWJ5eDMyTFh1?=
 =?utf-8?B?aUNMaW5ReGcyalBtTUJHVHBHZU1td09UcVBDNm8ra2YvQ0hEak0zb1NnTTZh?=
 =?utf-8?B?S3EwMExVTHN2d2V4RjR1Nm1CQ0tEZlBZVXZHM0VVZ1RNU2FPN1kxV1hEYnZE?=
 =?utf-8?B?VjZ3V2JTYmFNQ1FQZTJCT0xIRDJ6clJHdDk4SFVEcTAvQWc3MUZTU0cxZ0Jy?=
 =?utf-8?B?MDgzVE55VVNUS1F3QzJPMlJHQnJxV3QzM3VUeVRRYTJDSDJ2ZkVvdXRKd2Fv?=
 =?utf-8?B?d0VKdjFTOG8wcjRrMnhNZ3p3dk1WWWlsNGhjbFZMdlJUeUxuQjRINVRUWGl1?=
 =?utf-8?B?Q0YrOW0wenFlY1NrOUgxNkdTM3E3ZzN6WndrUXNmOGFqY3h6Um9yRmIzN3Mw?=
 =?utf-8?B?RTA3ZHl3eVR5Vy9GWFhUY3Q5MmhERnhSR1JRa3kxZVlXdkt1OUxjTS9oWnBv?=
 =?utf-8?B?NWtSaG1oYjVnSFd1VTZrdjUzbncxUGE4anRiWUE5TGYwUGh2S2MwK2xjank3?=
 =?utf-8?B?bUJNMjhnR1BOdlhaVjE2MW9HV0pQOWRRb2ZvdEtFWjUvV1crQ2RpNWRsUjlW?=
 =?utf-8?B?bFJQZkc4YzRObHZGVDhaM3c3aGFRM2k0cFpaYmFHaGtVd0NpOUQ5MVozN3NI?=
 =?utf-8?B?S25TQ0lQRStwMkJZN1kzNGx0c2dvb3dvQkpiTFNTT2tYMzUraUM5MnpUbzBG?=
 =?utf-8?B?WlR2M2ROUnNiYVFoaXhHblFobnpmWHRZYmh5bHE3NEo2K3lBanRhSnFWYWlO?=
 =?utf-8?B?ejFGaFVQekcxak1wWk1KNll3MnlhL0E1TlJ2N2M4Zms2bU8zY0o4TWxRUkFU?=
 =?utf-8?B?QjllaGlWWncxOGJWbU9rL1VSOWtnVXBZRHZHY25wemRkYmM5RnBFYTlvK21J?=
 =?utf-8?B?VDZVSWNRR1c0SDNaTWlPRXBiK0dzQ29SeU8vVVcvN05kN3BiWUdFcFMyMkJa?=
 =?utf-8?Q?SzNwp3wxFylMeFzb/tr0/CEc6Id1v/7fjxyQgWX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B2B046530B76240B250BF5B8BA03BED@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f9807b-d392-459b-bcec-08d910399ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 02:49:44.3764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQPlnopjX6NsgmuMtW7N0d+iBCnIcrrrs8yHL+EBcoDiqs9SS0h8E8LKMEs206BdJYQOF2HDXXi9aAsrbIh45w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMjgsIDIwMjEgYXQgMDQ6NTQ6NTlQTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IE9uIDIxLjA0LjIxIDA0OjA0LCBEaW5nIEh1aSB3cm90ZToNCj4gPiBSZWNl
bnRseSB3ZSBmb3VuZCB0aGVyZSBpcyBhIGxvdCBNZW1GcmVlIGxlZnQgaW4gL3Byb2MvbWVtaW5m
byBhZnRlcg0KPiA+IGRvIGEgbG90IG9mIHBhZ2VzIHNvZnQgb2ZmbGluZS4NCj4gPiANCj4gPiBJ
IHRoaW5rIGl0J3MgaW5jb3JyZWN0IHNpbmNlIE5SX0ZSRUVfUEFHRVMgc2hvdWxkIG5vdCBjb250
YWluIEhXUG9pc29uIHBhZ2VzLg0KPiA+IEFmdGVyIHRha2VfcGFnZV9vZmZfYnVkZHksIHRoZSBw
YWdlIGlzIG5vIGxvbmdlciBiZWxvbmcgdG8gYnVkZHkNCj4gPiBhbGxvY2F0b3IsIGFuZCB3aWxs
IG5vdCBiZSB1c2VkIGFueSBtb3JlLCBidXQgd2UgbWF5YmUgbWlzc2VkIGFjY291bnRpbmcNCj4g
PiBOUl9GUkVFX1BBR0VTIGluIHRoaXMgc2l0dWF0aW9uLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IERpbmcgSHVpIDxkaW5naHVpQHNhbmdmb3IuY29tLmNuPg0KPiA+IC0tLQ0KPiA+ICAgbW0v
cGFnZV9hbGxvYy5jIHwgMSArDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vcGFnZV9hbGxvYy5jIGIvbW0vcGFnZV9hbGxvYy5j
DQo+ID4gaW5kZXggY2ZjNzI4NzM5NjFkLi44ZDY1YjYyNzg0ZDggMTAwNjQ0DQo+ID4gLS0tIGEv
bW0vcGFnZV9hbGxvYy5jDQo+ID4gKysrIGIvbW0vcGFnZV9hbGxvYy5jDQo+ID4gQEAgLTg5NDcs
NiArODk0Nyw3IEBAIGJvb2wgdGFrZV9wYWdlX29mZl9idWRkeShzdHJ1Y3QgcGFnZSAqcGFnZSkN
Cj4gPiAgIAkJCWRlbF9wYWdlX2Zyb21fZnJlZV9saXN0KHBhZ2VfaGVhZCwgem9uZSwgcGFnZV9v
cmRlcik7DQo+ID4gICAJCQlicmVha19kb3duX2J1ZGR5X3BhZ2VzKHpvbmUsIHBhZ2VfaGVhZCwg
cGFnZSwgMCwNCj4gPiAgIAkJCQkJCXBhZ2Vfb3JkZXIsIG1pZ3JhdGV0eXBlKTsNCj4gPiArCQkJ
X19tb2Rfem9uZV9wYWdlX3N0YXRlKHpvbmUsIE5SX0ZSRUVfUEFHRVMsIC0xKTsNCj4gPiAgIAkJ
CXJldCA9IHRydWU7DQo+ID4gICAJCQlicmVhazsNCj4gPiAgIAkJfQ0KPiA+IA0KPiANCj4gU2hv
dWxkIHRoaXMgdXNlIF9fbW9kX3pvbmVfZnJlZXBhZ2Vfc3RhdGUoKSBpbnN0ZWFkPw0KDQpZZXMs
IF9fbW9kX3pvbmVfZnJlZXBhZ2Vfc3RhdGUoKSBsb29rcyBiZXR0ZXIgdG8gbWUuDQoNCkFuZCBJ
IHRoaW5rIHRoYXQgbWF5YmUgYW4gYWRkaXRpb25hbCBfX21vZF96b25lX2ZyZWVwYWdlX3N0YXRl
KCkgaW4NCnVucG9pc29uX21lbW9yeSgpIGlzIG5lY2Vzc2FyeSB0byBjYW5jZWwgdGhlIGRlY3Jl
bWVudC4gIEkgdGhvdWdodCBvZiB0aGUNCmZvbGxvd2luZywgYnV0IGl0IGRvZXNuJ3QgYnVpbGQg
YmVjYXVzZSBnZXRfcGZuYmxvY2tfbWlncmF0ZXR5cGUoKSBpcw0KYXZhaWxhYmxlIG9ubHkgaW4g
bW0vcGFnZV9hbGxvYy5jLCBzbyB5b3UgbWlnaHQgd2FudCB0byBhZGQgYSBzbWFsbCBleHBvcnRl
ZA0Kcm91dGluZSBpbiBtbS9wYWdlX2FsbG9jLmMgYW5kIGxldCBpdCBjYWxsZWQgZnJvbSB1bnBv
aXNvbl9tZW1vcnkoKS4NCg0KICBAQCAtMTg5OSw4ICsxODk5LDEyIEBAIGludCB1bnBvaXNvbl9t
ZW1vcnkodW5zaWduZWQgbG9uZyBwZm4pDQogICAgICAgICAgfQ0KICANCiAgICAgICAgICBpZiAo
IWdldF9od3BvaXNvbl9wYWdlKHAsIGZsYWdzLCAwKSkgew0KICAtICAgICAgICAgICAgICAgaWYg
KFRlc3RDbGVhclBhZ2VIV1BvaXNvbihwKSkNCiAgKyAgICAgICAgICAgICAgIGlmIChUZXN0Q2xl
YXJQYWdlSFdQb2lzb24ocCkpIHsNCiAgKyAgICAgICAgICAgICAgICAgICAgICAgaW50IG1pZ3Jh
dGV0eXBlID0gZ2V0X3BmbmJsb2NrX21pZ3JhdGV0eXBlKHAsIHBmbik7DQogICsNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgbnVtX3BvaXNvbmVkX3BhZ2VzX2RlYygpOw0KICArICAgICAgICAg
ICAgICAgICAgICAgICBfX21vZF96b25lX2ZyZWVwYWdlX3N0YXRlKHBhZ2Vfem9uZShwKSwgMSwg
bWlncmF0ZXR5cGUpOw0KICArICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgICAgdW5w
b2lzb25fcHJfaW5mbygiVW5wb2lzb246IFNvZnR3YXJlLXVucG9pc29uZWQgZnJlZSBwYWdlICUj
bHhcbiIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBmbiwgJnVucG9pc29u
X3JzKTsNCiAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KDQpUaGFua3MsDQpOYW95YSBIb3Jp
Z3VjaGk=
