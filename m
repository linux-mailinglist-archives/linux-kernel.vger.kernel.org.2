Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E7E356123
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344200AbhDGByp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:54:45 -0400
Received: from mail-eopbgr1410070.outbound.protection.outlook.com ([40.107.141.70]:39776
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241963AbhDGByk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:54:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIS1kMi1HgmzJxtFDoy9zZyOR/21TOpy5k+S1254BxWwDhZRUsICH4NoK4hjSTlrrjHxN1mXyDNjaMTIfKIajXGWoy4zM5/GigZG9sLm6DR2lLWThqLipKBYr76V+VrAO0uU/jeiADyMW7d6fZSYCxvGVyQ+NjHMekkoC7vsADlaULZxCldckX+4tCU93kanvG+Z0Nd6YtoiGmfV58+u6p5OAmcHQk9lw0FL/3m4zXqR0hHswpukrUMttWN3CIkLXhTnrv4R4ylGgQWOU2+lTxXOW5T9yNygTO6x4dmjBCwpU3KBWWwuoMEHuB9dnYGgMX7HNpvlDlQK/F3x7x1B9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l0Puq/BFUdT9JzBf8DhI5gwvv71h00CjD8+PPEEdZU=;
 b=ahGP0F3ZVRJxjumeMmWXEEplkyiJgSx+HDg5orRdSLIJf0p9JhLz4TFFwnJFkj6wDrHUcU3C77nVxf2EaCpDqFmNhq+5czZ7KzHi0qvc25b9ZXBqyi/xFinhpITTqVE/uFqX/ocdFq38GfYV/oUFJ6Zq/U5bHbHq3WfAHqmxcNWIpP9pnou5A2o0MzJILdPVRF44WOr4IwpkKmCivm2YV8JDyXmdGvWGoUlQbPimUSdI9n3UgDvcx20j0WUYtvNXqXNsZof9P2uT4frRnmdJelO3iRko4dbPJlna4+UgObSUkrl/Uvf6rjdT/KqazZI6DZh0a7ijvVctrJ7vZr/nIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l0Puq/BFUdT9JzBf8DhI5gwvv71h00CjD8+PPEEdZU=;
 b=Tqsv4iGNqjK4RTUbaM9TiDepoOc6jb9U0oAQ14HM3LkAyG4WjanUxmtsFnJekhfxMTnfCIo4nTCba6V3TWttn835hUo7ibqhhKZ7NzyXPS1FetNd7r2Next8xxG7TZOBv0xiMa/pXNwgFfhx+z3h/2kaIcSI336jTAsw/mJ2UL0=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB2272.jpnprd01.prod.outlook.com (2603:1096:404:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 7 Apr
 2021 01:54:30 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 01:54:30 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v7] mm/gup: check page hwpoison status for memory recovery
 failures.
Thread-Topic: [PATCH v7] mm/gup: check page hwpoison status for memory
 recovery failures.
Thread-Index: AQHXKo5a7F4McOLmGEGmPHaWGLPvQqqoTMYA
Date:   Wed, 7 Apr 2021 01:54:28 +0000
Message-ID: <20210407015428.GA26707@hori.linux.bs1.fc.nec.co.jp>
References: <20210320003516.GC3420@casper.infradead.org>
 <20210322193318.377c9ce9@alex-virtual-machine>
 <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
 <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
 <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
 <20210331104303.145aea53@alex-virtual-machine>
 <20210331043231.GA26013@hori.linux.bs1.fc.nec.co.jp>
 <9f49c415-a75a-1ea3-b80c-5ba512331de6@redhat.com>
 <20210406102346.3890ceb2@alex-virtual-machine>
 <20210406104123.451ee3c3@alex-virtual-machine>
In-Reply-To: <20210406104123.451ee3c3@alex-virtual-machine>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kingsoft.com; dkim=none (message not signed)
 header.d=none;kingsoft.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df47e00e-c640-46e0-b652-08d8f968156e
x-ms-traffictypediagnostic: TYAPR01MB2272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB22728EECE8046A31C9E5D1D9E7759@TYAPR01MB2272.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KmcasLOroRKc3qn7X3bqqoySAnpBJX4nLfl26O4+o6+EmqyyjyrEAHVUszz9x02uYnrXgmY9Ikp42BO9/pr471a+nZh3r4S1hfpx+Fzl9vydvqDHm834QLXsPFQLf33Q21OMZBCGv9WJuQ2wyAnlnKX2R9sgDJZv5tQSjdaQkFdFbS261etpK6n9RGl6Me68j9ZVXWWChkpnPA7q0ZV9Rf1UnYncDQwaBctsUuE+Qm/pWlieVmkEN8LdjfM4bJkVotu3WjzPPPQPFsVDOdnW4BmC33AqSMo6izqOl5P6cXokMeZvQt61HArIYoigsSE7POIxe1UXYaIKBJ9cLs3Zz9rPEDuJIB1WJuyrdMFdCwsoFOYc6Jf/0aQEizQNBSpQAuiZ8c9iWvhK5+WG1soXBA2NJLuybCCZj3c8TUG5ZmGNoQuA9/OFIRubOKWRWyjFRo4jZOwl6FNgZvRT9hdV8FW3vSBIJnyIWVf6cry28x00v4hTBi9WtMod5ATgOQ4Z9K83k7mQ2diGzsNuvjs2M5FeefuiOnnujMdqW5LSIt2GAPUobT2uN7tyN5HChNWKkUQv2yyPW10hHV9J0E126xqkH0qsH4tRj1Y6X2kbb+o3qMkgib6I+OXofGopC+Uy0uT8/qQAXA4JFL1uh4V47GZAyDcnmTB3OqR3Wq1sFhU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(1076003)(66476007)(8676002)(64756008)(66446008)(478600001)(7416002)(86362001)(5660300002)(66556008)(66946007)(316002)(186003)(83380400001)(6916009)(8936002)(6512007)(9686003)(76116006)(71200400001)(33656002)(38100700001)(6506007)(55236004)(2906002)(26005)(6486002)(85182001)(54906003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eEFwL0FXM2JaNktINkV2TXpUWXd5N2IzOC9KNFBqUG56alcyRzRyREk0akpI?=
 =?utf-8?B?MWJTLzJuVDNUQWZhdFVZOStKdnVJQ0NEMG93YkVyb0tCRXVDb2NhemZoSjlC?=
 =?utf-8?B?ZmZHM2diUkV0RXVIYnNEY01yeTJKWTRUdk42SmxjSGZ3YndNdGc4VTZNRjFI?=
 =?utf-8?B?NWI1ZVYwRERkZXZMdWY4bk5Xa1ozS3V2VFFmaGJWTE1NbGVLcmlTQjlRQmxm?=
 =?utf-8?B?RTdrSmpmajdpUnlablpMVHAwYjdwbWFpY0dXeUtvTXkrZFYrVlUyK2xLcEZ2?=
 =?utf-8?B?MDFRLzF2bEx0cUg2R2ozanZXVG1aZGlhamN3QXZYNU9oejZ4T1k3TmQ5bmFp?=
 =?utf-8?B?MTV6TnRvMm1ucXJ0eGhrT094aHZZZ1RZQXdhS0VLdGloT2FhOXVzSDY5dEdK?=
 =?utf-8?B?UHpqVHloeEZ1alg4WUpMeVdVSWpzYVdjWXY0ZWpQUitrU3Q2UFdZTUpIZDlF?=
 =?utf-8?B?aWduOWswbnh5Q0dONlZtQjZhRlpXVjJYaGJOai91bmdwaVg5alpBbzYxSHBi?=
 =?utf-8?B?VmJnZFh4L0NhTk1aVForT0xGZkFIWGlJK0xvajVVUTg5bTJFVFhtbVJmbjlM?=
 =?utf-8?B?U3BDYWlIbVV1d0tNdkVncS9JcWZjRml2TGJUV3lBL211VVU5OC9waEdYSG9B?=
 =?utf-8?B?VXNXN1VwTExneDZzMVdGZ3dWSUtaVkNUcEpqN1BOaVNxaVdpTUp3aU5ZdGVD?=
 =?utf-8?B?cUVpTVMwQVdJWGdwb3lVYTVBaWh0aXNNZUwrMnpZUFhyRTZlYkgxRVF5QkdR?=
 =?utf-8?B?WEtxaENYNGlOTVI4NStSQWtPRUYyMWh6T2oyR2VSL1RRVldZdXFrWSs2eUc3?=
 =?utf-8?B?aUVXVTc2MFVMUjkzRUFRZkNmQ1BoY0FyblcxL1Y5S0hDOW5NU0hvVFE4WVlU?=
 =?utf-8?B?Nk5IQ0N4WUp5TVpNZjV1YkQzdHloK0V2bUVrdVRWNThWWUJyU2QxSGMzVkxO?=
 =?utf-8?B?dHdRelQ5M2hhWGFlV09CWDIxbXB1Ly9nRDVvL1Z2NE5GamNqTVNIK01GRWd2?=
 =?utf-8?B?RzFWWEhHWk05UU5tVjJWTFZ3UCtIUmhWdlNqSG5lb1hYSmdsT3dMaWR0MUJq?=
 =?utf-8?B?QjdzQUx4RWtsRFp5TEJaRlhwZEd0MXc2SXF4dUlLVGllQkNkbDFZOWFVaHJk?=
 =?utf-8?B?WExaMEZsRUtMWDZEMlMxaWRHaXN3aDZqbUM4V3U2UzB0UG83ZTBvejZQU1lq?=
 =?utf-8?B?N2xqWGZsWlRzbUN5bGgwRG45cjR1T2VUU2ZVdnJRNHZCZ2l4V2pJRGNJc3dT?=
 =?utf-8?B?NUpoWkRDUjRxUFpmQVBocWcxUkFTQUF3ek9WNlhGRDVwc3ZtOU9PZis1LytN?=
 =?utf-8?B?Y3pQZlMvZDhXOEwrV2c4TjEwd0ZjWWV4cUY1K2tNK3RiNVFlaFFlYStPUGVI?=
 =?utf-8?B?N0t3SzBDQ0JhQnNVTkNDMHVIeHJ0S3MxQlpJU1hQWHRjZFVSbVVDc1dJZzlP?=
 =?utf-8?B?Wk9Ka2Q4RXRiRFM0SnZvR296RVFObmRtcXBySmJKdFo3SGpaUDNRVlBBTXRQ?=
 =?utf-8?B?TktPb2VVbnVLaXhySW5tUzYweThuUC9KY2d5U0krYmkzbGN3UzFFM3JWa2J1?=
 =?utf-8?B?NStqY29CWEVlVWh2c2dqNjc2bXdyYzU2WnJaTmVvVEpkSy9ueTQ0YzVmU0FX?=
 =?utf-8?B?MHhYSnJ2ZXVTYzE4VzJCeGJMelk5LzdteGtkNmp2RGgwb2pkWTkxM29JWEJN?=
 =?utf-8?B?c3FIekhnT29sWlU1bnVhN3loMk1SMzErbWNjZEFtc0wxblh1UzJVQXhOUUlp?=
 =?utf-8?B?bnRoeHpqcGhvckIrLzkzb3JKZTlUM1c2MEZSN2RKVDIyVnF5UXVWU3p5Vm1t?=
 =?utf-8?B?NlE0cGtpRzRUV282QU1CZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <410DCA529FE60E4381A8E8CA741B44EC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df47e00e-c640-46e0-b652-08d8f968156e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 01:54:29.9690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gm/s7nyeo2XTz888Nk6CkXBedHLV+dJiAKtn4q1QDhowxr3iLCPMzETd/AnXjj9OV2RllAWtb4w2P+LWMk/Ljw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2272
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDYsIDIwMjEgYXQgMTA6NDE6MjNBTSArMDgwMCwgQWlsaSBZYW8gd3JvdGU6
DQo+IFdoZW4gd2UgY2FsbCBnZXRfdXNlcl9wYWdlcygpIHRvIHBpbiB1c2VyIHBhZ2UgaW4gbWVt
b3J5LCB0aGVyZSBtYXkgYmUNCj4gaHdwb2lzb24gcGFnZSwgY3VycmVudGx5LCB3ZSBqdXN0IGhh
bmRsZSB0aGUgbm9ybWFsIGNhc2UgdGhhdCBtZW1vcnkNCj4gcmVjb3Zlcnkgam9kIGlzIGNvcnJl
Y3RseSBmaW5pc2hlZCwgYW5kIHdlIHdpbGwgbm90IHJldHVybiB0aGUgaHdwb2lzb24NCj4gcGFn
ZSB0byBjYWxsZXJzLCBidXQgZm9yIG90aGVyIGNhc2VzIGxpa2UgbWVtb3J5IHJlY292ZXJ5IGZh
aWxzIGFuZCB0aGUNCj4gdXNlciBwcm9jZXNzIHJlbGF0ZWQgcHRlIGlzIG5vdCBjb3JyZWN0bHkg
c2V0IGludmFsaWQsIHdlIHdpbGwgc3RpbGwNCj4gcmV0dXJuIHRoZSBod3BvaXNvbiBwYWdlLCBh
bmQgbWF5IHRvdWNoIGl0IGFuZCBsZWFkIHRvIHBhbmljLg0KPiANCj4gSW4gZ3VwLmMsIGZvciBu
b3JtYWwgcGFnZSwgYWZ0ZXIgd2UgY2FsbCBmb2xsb3dfcGFnZV9tYXNrKCksIHdlIHdpbGwNCj4g
cmV0dXJuIHRoZSByZWxhdGVkIHBhZ2UgcG9pbnRlcjsgb3IgbGlrZSBhbm90aGVyIGh3cG9pc29u
IGNhc2Ugd2l0aCBwdGUNCj4gaW52YWxpZCwgaXQgd2lsbCByZXR1cm4gTlVMTC4gRm9yIE5VTEws
IHdlIHdpbGwgaGFuZGxlIGl0IGluIGlmICghcGFnZSkNCj4gYnJhbmNoLiBJbiB0aGlzIHBhdGNo
LCB3ZSB3aWxsIGZpbHRlciBvdXQgdGhlIGh3cG9pc29uIHBhZ2UgaW4NCj4gZm9sbG93X3BhZ2Vf
bWFzaygpIGFuZCByZXR1cm4gZXJyb3IgY29kZSBmb3IgcmVjb3ZlcnkgZmFpbHVyZSBjYXNlcy4N
Cj4gDQo+IFdlIHdpbGwgY2hlY2sgdGhlIHBhZ2UgaHdwb2lzb24gc3RhdHVzIGFzIHNvb24gYXMg
cG9zc2libGUgYW5kIGF2b2lkIGRvaW5nDQo+IGZvbGxvd2VkIG5vcm1hbCBwcm9jZWR1cmUgYW5k
IHRyeSBub3QgdG8gZ3JhYiByZWxhdGVkIHBhZ2VzLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2NjoN
Cj4gLSBGaXggd3JvbmcgcGFnZSBwb2ludGVyIGNoZWNrIGluIGZvbGxvd190cmFuc19odWdlX3Bt
ZCgpOw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWlsaSBZYW8gPHlhb2FpbGlAa2luZ3NvZnQuY29t
Pg0KPiBDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IENjOiBNYXR0
aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IE5hb3lhIEhvcmlndWNoaSA8
bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+IENjOiBPc2NhciBTYWx2YWRvciA8b3NhbHZhZG9y
QHN1c2UuZGU+DQo+IENjOiBNaWtlIEtyYXZldHogPG1pa2Uua3JhdmV0ekBvcmFjbGUuY29tPg0K
PiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBtbS9ndXAuYyAgICAgICAgIHwgMjcgKysr
KysrKysrKysrKysrKysrKysrKystLS0tDQo+ICBtbS9odWdlX21lbW9yeS5jIHwgMTEgKysrKysr
KystLS0NCj4gIG1tL2h1Z2V0bGIuYyAgICAgfCAgOCArKysrKysrLQ0KPiAgbW0vaW50ZXJuYWwu
aCAgICB8IDEzICsrKysrKysrKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkNCg0KVGhhbmsgeW91IGZvciB0aGUgd29yay4NCg0KTG9va2lu
ZyB0aHJvdWdoIHRoaXMgcGF0Y2gsIHRoZSBpbnRlcm5hbCBvZiBmb2xsb3dfcGFnZV9tYXNrKCkg
aXMNCnZlcnkgY29tcGxpY2F0ZWQgc28gaXQncyBub3QgZWFzeSB0byBtYWtlIHRoaXMgaHdwb2lz
b24tYXdhcmUuDQpOb3cgSSdtIGdldHRpbmcgdW5zdXJlIHRvIGp1ZGdlIHRoYXQgdGhpcyBpcyB0
aGUgYmVzdCBhcHByb2FjaC4NCldoYXQgYWN0dWFsbHkgSSBpbWFnaW5lZCBtaWdodCBiZSBsaWtl
IGJlbG93ICh3aGljaCBpcyB0b3RhbGx5DQp1bnRlc3RlZCwgYW5kIEknbSBzb3JyeSBhYm91dCBt
eSBwcmV2aW91cyBtaXNsZWFkaW5nIGNvbW1lbnRzKToNCg0KZGlmZiAtLWdpdCBhL21tL2d1cC5j
IGIvbW0vZ3VwLmMNCmluZGV4IGU0MDU3OTYyNGYxMC4uYTYwYTA4ZmM3NjY4IDEwMDY0NA0KLS0t
IGEvbW0vZ3VwLmMNCisrKyBiL21tL2d1cC5jDQpAQCAtMTA5MCw2ICsxMDkwLDExIEBAIHN0YXRp
YyBsb25nIF9fZ2V0X3VzZXJfcGFnZXMoc3RydWN0IG1tX3N0cnVjdCAqbW0sDQogCQl9IGVsc2Ug
aWYgKElTX0VSUihwYWdlKSkgew0KIAkJCXJldCA9IFBUUl9FUlIocGFnZSk7DQogCQkJZ290byBv
dXQ7DQorCQl9IGVsc2UgaWYgKGd1cF9mbGFncyAmIEZPTExfSFdQT0lTT04gJiYgUGFnZUhXUG9p
c29uKHBhZ2UpKSB7DQorCQkJaWYgKGd1cF9mbGFncyAmIEZPTExfR0VUKQ0KKwkJCQlwdXRfcGFn
ZShwYWdlKTsNCisJCQlyZXQgPSAtRUhXUE9JU09OOw0KKwkJCWdvdG8gb3V0Ow0KIAkJfQ0KIAkJ
aWYgKHBhZ2VzKSB7DQogCQkJcGFnZXNbaV0gPSBwYWdlOw0KQEAgLTE1MzIsNyArMTUzNyw3IEBA
IHN0cnVjdCBwYWdlICpnZXRfZHVtcF9wYWdlKHVuc2lnbmVkIGxvbmcgYWRkcikNCiAJaWYgKG1t
YXBfcmVhZF9sb2NrX2tpbGxhYmxlKG1tKSkNCiAJCXJldHVybiBOVUxMOw0KIAlyZXQgPSBfX2dl
dF91c2VyX3BhZ2VzX2xvY2tlZChtbSwgYWRkciwgMSwgJnBhZ2UsIE5VTEwsICZsb2NrZWQsDQot
CQkJCSAgICAgIEZPTExfRk9SQ0UgfCBGT0xMX0RVTVAgfCBGT0xMX0dFVCk7DQorCQkJCSAgICAg
IEZPTExfRk9SQ0UgfCBGT0xMX0RVTVAgfCBGT0xMX0dFVCB8IEZPTExfSFdQT0lTT04pOw0KIAlp
ZiAobG9ja2VkKQ0KIAkJbW1hcF9yZWFkX3VubG9jayhtbSk7DQogCXJldHVybiAocmV0ID09IDEp
ID8gcGFnZSA6IE5VTEw7DQpkaWZmIC0tZ2l0IGEvbW0vaHVnZXRsYi5jIGIvbW0vaHVnZXRsYi5j
DQppbmRleCBhODZhNThlZjEzMmQuLjAzYzNkMzIyNWMwZCAxMDA2NDQNCi0tLSBhL21tL2h1Z2V0
bGIuYw0KKysrIGIvbW0vaHVnZXRsYi5jDQpAQCAtNDk0OSw2ICs0OTQ5LDE0IEBAIGxvbmcgZm9s
bG93X2h1Z2V0bGJfcGFnZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgc3RydWN0IHZtX2FyZWFfc3Ry
dWN0ICp2bWEsDQogCQkJY29udGludWU7DQogCQl9DQogDQorCQlpZiAoZmxhZ3MgJiBGT0xMX0hX
UE9JU09OICYmIFBhZ2VIV1BvaXNvbihwYWdlKSkgew0KKwkJCXZhZGRyICs9IGh1Z2VfcGFnZV9z
aXplKGgpOw0KKwkJCXJlbWFpbmRlciAtPSBwYWdlc19wZXJfaHVnZV9wYWdlKGgpOw0KKwkJCWkg
Kz0gcGFnZXNfcGVyX2h1Z2VfcGFnZShoKTsNCisJCQlzcGluX3VubG9jayhwdGwpOw0KKwkJCWNv
bnRpbnVlOw0KKwkJfQ0KKw0KIAkJcmVmcyA9IG1pbjMocGFnZXNfcGVyX2h1Z2VfcGFnZShoKSAt
IHBmbl9vZmZzZXQsDQogCQkJICAgICh2bWEtPnZtX2VuZCAtIHZhZGRyKSA+PiBQQUdFX1NISUZU
LCByZW1haW5kZXIpOw0KIA0KDQpXZSBjYW4gc3VyZWx5IHNheSB0aGF0IHRoaXMgY2hhbmdlIG9u
bHkgYWZmZWN0cyBnZXRfdXNlcl9wYWdlcygpIGNhbGxlcnMNCndpdGggRk9MTF9IV1BPSVNPTiBz
ZXQsIHNvIHRoaXMgc2hvdWxkIHBpbnBvaW50IHRoZSBjdXJyZW50IHByb2JsZW0gb25seS4NCkEg
c2lkZSBub3RlIGlzIHRoYXQgdGhlIGFib3ZlIGNoYW5nZSBvbiBmb2xsb3dfaHVnZXRsYl9wYWdl
KCkgaGFzIGEgcm9vbSBvZg0KcmVmYWN0b3JpbmcgdG8gcmVkdWNlIGR1cGxpY2F0ZWQgY29kZS4N
Cg0KQ291bGQgeW91IHRyeSB0byB0ZXN0IGFuZCBjb21wbGV0ZSBpdD8NCg0KVGhhbmtzLA0KTmFv
eWEgSG9yaWd1Y2hp
