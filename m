Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4004234F669
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhCaBx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:53:28 -0400
Received: from mail-eopbgr1310052.outbound.protection.outlook.com ([40.107.131.52]:2048
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232702AbhCaBxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:53:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+Jn4jgnxQkar/OIs0qlPFrTa/vODOYQ4tDyK1D8t9ShFTGR5xrqbhcZc/ixA9iIXBGRw26Qa286FvSi3JpjP1R7N3+7uhWH7TsjM+ki7tTSUnO1Lcc+u3D30qziW5hVhp3/EhIOfGmn/dvKxdBKvrYOqRkIDRYE9WWyJ1rWSq0/u9F1Il/rSmNSXcMYZT3bUnEaxxoArThMl46tV8P+DaOf50BqjUvEs+mElomKZ9Qc5uvybLHF2OCaB6VY2Xog14TL6m2bqmzwZslZhkWW86gfJgmUqYqb3jhkZ8GEg953zqHm07TsZ44hRbUfV874U1ndLClVuTP2LMfb4+/DBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jecA4kVD+flvy7ISSZv8KVVrxjnaS4yqdPKicNqAFlM=;
 b=ivoqOZcE/r9oWvXlW4r91t+1fKDK++8ifKY17skIlRkRZ6we9eTYNK1xXFeofyOrlFKFvhFknTghAeYfUpTIF7f+NTb1YEtBoHKz/t4m0aOHMVrBdziYbE9qBsEN8z1Nw8lrlaBixMtNDQ5rqxlTQW9FeUHs9LYCWQ+ERJZm841otdbUJ4Kkal3j9Ukd6Ik6xtZHRiPMpUQNJTRg33yoyiSf0Ou692pRWo4kd31/wJYrNzkVorBtUYiZuaRZrBRwDTsKep15ONxPS4GXNtkibIXe6ET+kt+ElFlsJFZorz6MAwc5b7TMIMsJ9/MBq4+Z8SIS2JTHnlcVOV3vU5giWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jecA4kVD+flvy7ISSZv8KVVrxjnaS4yqdPKicNqAFlM=;
 b=GDqXdLXie70J5wSOK1rV1pv4CBddwD9NLJA+LDk+tV9klH8x6CPjxCuUpcFOMPHtPiTOOs+BENJQFy6l1Vj6SuL8tVqJqEBRNsd/yc34iV79wsBEl8hcuWNZtPaP8Mb/2cqZkCz3aZ/8dLor14rrA+GUOt74HJVOU9s4T8dcYbI=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB4809.jpnprd01.prod.outlook.com (2603:1096:404:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 01:52:59 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 01:52:59 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Aili Yao <yaoaili@kingsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v5] mm/gup: check page hwposion status for coredump.
Thread-Topic: [PATCH v5] mm/gup: check page hwposion status for coredump.
Thread-Index: AQHXHw8vRUeoHQvqlEOeQuw9KlA/bqqWVRoAgAADxoCABwonAA==
Date:   Wed, 31 Mar 2021 01:52:59 +0000
Message-ID: <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
References: <20210317163714.328a038d@alex-virtual-machine>
 <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
 <20210318044600.GJ3420@casper.infradead.org>
 <20210318133412.12078eb7@alex-virtual-machine>
 <20210319104437.6f30e80d@alex-virtual-machine>
 <20210320003516.GC3420@casper.infradead.org>
 <20210322193318.377c9ce9@alex-virtual-machine>
 <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
 <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
In-Reply-To: <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 899898fa-b7a4-4469-b4ae-08d8f3e7b62f
x-ms-traffictypediagnostic: TY2PR01MB4809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4809CBE53C8DEB5C187D82FFE77C9@TY2PR01MB4809.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s8jGGJbqWfhzmtHS6govPbPIP1+oFTtUakGxX9wH7czoG1aGCNOY1lSAiSNILnPb/UIVC5v/5zRdOXLv42wcnm/9zdkNZgf2AmiWyIgb2/IJMN0k7HJBHRdZERVHvujZThxX8W+juUflan96DcXrHxVQPZme/9jnbzwMMnvlwSDk54q6JhIRAr4wrqh9amPeTpo1ODisLUqZhZDy7d62Wn+NFLXGijv62BvNvoBJWtLuv/e0xjW8y196fY9GE6zyjyawFF5MWEroj8MNZDULOhYqAQ4oaAhCGGn/IMAImbERvU4ZJccGLww/WzXtQhXzQQkdqV9l0Gf4m0rPiKMRUT+CmNbuUlvQeMinA3HMQ/Kec3pYQdVtv6jkFnTB8NdXh5G8tTxhut7KDrVP6KgZukutCTBcn8zGYDPCDraHNhcqTpKwEv+ZJDNAGhKfalihWhq6FeR109aZsxB6K7viYmWFb6Ob7ERfbbY0NDuc7CNkiN7fkZwvEhJiL1lE18768AE2JspJRCdX2+zAwGMKxsz0aWnrosLG98q+TKeSV6Zt7+Hs7qdzFJSIIkj36RsCYxbv4imrQHSSbURmXyJP4l92m1/cgoX+foiNP/Lr4bOiyzhDi/pInfAmtdBZC5j/hIu8wfjwrLpUI00I0MKH6fByZcNQdi+GlLlpfqGGjsPCpaj1ri8GgsEqg+uAJoJZeg3OsB1SxS1qolSryTNkk42O08D+8N8K1wxVrMb07cc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(55236004)(4326008)(6506007)(1076003)(2906002)(5660300002)(66446008)(478600001)(53546011)(966005)(71200400001)(38100700001)(66946007)(26005)(76116006)(64756008)(66476007)(66556008)(186003)(316002)(33656002)(85182001)(54906003)(8936002)(6512007)(6916009)(9686003)(86362001)(7416002)(6486002)(8676002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MUw4ZGtJbmE3RFNNOUl4V1R3dUZOaXFnaDd1c1dMVkE2eHcyUnorb3R2MnlH?=
 =?utf-8?B?V3U4UnFhN1hUUUt2akZnL0MrVW5yQkhCczNFSFgxdmNVNC9LWTl0OWZUNU92?=
 =?utf-8?B?bmxSQmRYNlQ1TUdGaWFwb2xaM1B6cndhWjRQWGJTakhIWndoWTZXWVZpdkR4?=
 =?utf-8?B?eGpMMzRhb3YxTk1TK1lOdjU5YXJseEVYcDJpVWZVTExKaTc1M0pCVVRZR1lO?=
 =?utf-8?B?Y1AwdWNoME9lL2dVdmFFektweEkxSnVvMFFTSnhxSUN4dFIwREU2OG1FWmZ4?=
 =?utf-8?B?NlpuRlFjRzlWSEpFQ05DbEpmQkRtazNRWGFiS1JjbExkRUIvblpHSkdUa0ZN?=
 =?utf-8?B?S2xFWnptVEVKZWpqUkJRNWNIdVZzc2JsTE5ZQlV1ODIxNSt3RWVRYzdOZmRm?=
 =?utf-8?B?N0pYVCtETm9tNElyRVRCVTBTQzFnd0tFUEhNZ2lmSDBhMEFvaThzVHdHQ1pZ?=
 =?utf-8?B?Sk9IbWtqMmxKdXlRNHNEL0F4VE9XMnIvRDhGN3h6bnk1dllmL251NHBxR0xp?=
 =?utf-8?B?M2VjSUFaemoyMUFnN1M4ckQ3bWkwWFYxUDhwNjM2TWIvZVlBaW16TzYvdnZH?=
 =?utf-8?B?Yy8xejNiN3pnd3JlWWE1R2I0Q2Uwb2ljbXFzaFhBR1c4cFMrREE0Y3FCbk5K?=
 =?utf-8?B?TjAxTmRYM3lUTjRUN0VSNEgxRmpFTnRQSEZrNzNFTEJzYkRLOXc0R015UXdn?=
 =?utf-8?B?SEFnKzVIR0NPSDBHNkRXYVVZeW45UE5qWUJVQ3lscndxdStWdGp5ekFoTmNu?=
 =?utf-8?B?RmVHV1BkY1FEM2l3UmpoUkFLYjV0RnVNRVJNY01IZ3hxR0pMYzd5bHJZQVgw?=
 =?utf-8?B?ZU5LTTlvaWp0bDR4V2RBMlRwclRueDJCMzM0MlNTa1o1N3NDaDVKc2VwNy9w?=
 =?utf-8?B?YTk1Q1d5bm1TRS9UTVJ5VDF5V0VMcERPWW1YaDhFZHFJR014bkRyaFVBaENU?=
 =?utf-8?B?R3QzVTUvSzFZdkNha2lxc1cwMHZ4ZFViLzhVbVlIbFFoVGhxbUE5MHA0aXR0?=
 =?utf-8?B?RHlSUytSZjdJRHFrVGk1alhKSjIvV0lSYk9oUVl1aFNZazI1ZDBVdytTNnZ5?=
 =?utf-8?B?ZFhXNXVFQUpjUjlrL28wVkZEL09NWGUyNWFLdVVNbnV2ZXY3aVJuME5sQXhs?=
 =?utf-8?B?aisvSTRpK1YzVU5lWHBVOHNlc3Y3Z0ZGSGpmS0cyQXZZd1VZMjJSd2dJZlJq?=
 =?utf-8?B?cHFPYVBNL3NlU0ZYMCtQb1pFZWlIZUMyelo3WjRwWmRydlgwdUY4UDRFSjgw?=
 =?utf-8?B?b0JraThJMk9xdm9vNTFpTGFjbzdrMWVaVFdTMW5OdERkUk0xeG1iTmw4RVFa?=
 =?utf-8?B?UkwwdFZHekpiWWlDRTVTa24yNGFWN0RoSERQTFA4eCt5cXZGWmlhTUg3R3By?=
 =?utf-8?B?UTdkaisrSUt6clhuZ1RuN0dCTUxudGdMZzRaazFsU0p3SDFPbWlSMHg5N1Fv?=
 =?utf-8?B?R0hUWWxhOGwyWlBWcktjVXRFUEd0UEM1WVZqankvMS9PN0g2aTFodW92RjBn?=
 =?utf-8?B?RFBQSFBKeGR5MGRWNU1ySmQyUkZxOFdCb3g4cjZQdGtHakVhQ255bGkxK1RN?=
 =?utf-8?B?Z1hCRkRVUnhHMjQvUWVjdUwyMEowUk9NV3BPZW90S09DWVNpZkp5VXlxMys3?=
 =?utf-8?B?M2lrT2JBZytyMUlILzFOWk9qbkhETC9rMk9oSkwrOEFqRXNVbUFLSmtwMDZx?=
 =?utf-8?B?SmF2OXhWTURyQkNmU2szQzJPcFZjRXJqQkhiRGxObXpQSVVEMFl5OXhpdWpo?=
 =?utf-8?B?dXpRakprYktQeFdscGNrRkNWUkRYdHJGN3ptN1VNVG9WMFZBTkwzVFg1UE1W?=
 =?utf-8?B?eURsQWZwRFRjamVTZVM4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <120C7706FE09A749A81FF091D69A1522@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899898fa-b7a4-4469-b4ae-08d8f3e7b62f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 01:52:59.1990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vy4nWERGe6z9nNpuuw90oo8MChqCxBfufB0KrbJh1wvmG2zyY1g/D41AMNMIPYnJBMiH43bpGFsFGStqZ/ci/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4809
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMjYsIDIwMjEgYXQgMDM6MjI6NDlQTSArMDEwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IE9uIDI2LjAzLjIxIDE1OjA5LCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToN
Cj4gPiBPbiAyMi4wMy4yMSAxMjozMywgQWlsaSBZYW8gd3JvdGU6DQo+ID4gPiBXaGVuIHdlIGRv
IGNvcmVkdW1wIGZvciB1c2VyIHByb2Nlc3Mgc2lnbmFsLCB0aGlzIG1heSBiZSBvbmUgU0lHQlVT
IHNpZ25hbA0KPiA+ID4gd2l0aCBCVVNfTUNFRVJSX0FSIG9yIEJVU19NQ0VFUlJfQU8gY29kZSwg
d2hpY2ggbWVhbnMgdGhpcyBzaWduYWwgaXMNCj4gPiA+IHJlc3VsdGVkIGZyb20gRUNDIG1lbW9y
eSBmYWlsIGxpa2UgU1JBUiBvciBTUkFPLCB3ZSBleHBlY3QgdGhlIG1lbW9yeQ0KPiA+ID4gcmVj
b3Zlcnkgd29yayBpcyBmaW5pc2hlZCBjb3JyZWN0bHksIHRoZW4gdGhlIGdldF9kdW1wX3BhZ2Uo
KSB3aWxsIG5vdA0KPiA+ID4gcmV0dXJuIHRoZSBlcnJvciBwYWdlIGFzIGl0cyBwcm9jZXNzIHB0
ZSBpcyBzZXQgaW52YWxpZCBieQ0KPiA+ID4gbWVtb3J5X2ZhaWx1cmUoKS4NCj4gPiA+IA0KPiA+
ID4gQnV0IG1lbW9yeV9mYWlsdXJlKCkgbWF5IGZhaWwsIGFuZCB0aGUgcHJvY2VzcydzIHJlbGF0
ZWQgcHRlIG1heSBub3QgYmUNCj4gPiA+IGNvcnJlY3RseSBzZXQgaW52YWxpZCwgZm9yIGN1cnJl
bnQgY29kZSwgd2Ugd2lsbCByZXR1cm4gdGhlIHBvaXNvbiBwYWdlLA0KPiA+ID4gZ2V0IGl0IGR1
bXBlZCwgYW5kIHRoZW4gbGVhZCB0byBzeXN0ZW0gcGFuaWMgYXMgaXRzIGluIGtlcm5lbCBjb2Rl
Lg0KPiA+ID4gDQo+ID4gPiBTbyBjaGVjayB0aGUgaHdwb2lzb24gc3RhdHVzIGluIGdldF9kdW1w
X3BhZ2UoKSwgYW5kIGlmIFRSVUUsIHJldHVybiBOVUxMLg0KPiA+ID4gDQo+ID4gPiBUaGVyZSBt
YXliZSBvdGhlciBzY2VuYXJpbyB0aGF0IGlzIGFsc28gYmV0dGVyIHRvIGNoZWNrIGh3cG9zaW9u
IHN0YXR1cw0KPiA+ID4gYW5kIG5vdCB0byBwYW5pYywgc28gbWFrZSBhIHdyYXBwZXIgZm9yIHRo
aXMgY2hlY2ssIFRoYW5rcyB0byBEYXZpZCdzDQo+ID4gPiBzdWdnZXN0aW9uKDxkYXZpZEByZWRo
YXQuY29tPikuDQo+ID4gPiANCj4gPiA+IExpbms6IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3Iv
MjAyMTAzMTkxMDQ0MzcuNmYzMGU4MGRAYWxleC12aXJ0dWFsLW1hY2hpbmUNCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEFpbGkgWWFvIDx5YW9haWxpQGtpbmdzb2Z0LmNvbT4NCj4gPiA+IENjOiBEYXZp
ZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gPiA+IENjOiBNYXR0aGV3IFdpbGNv
eCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gPiA+IENjOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lh
LmhvcmlndWNoaUBuZWMuY29tPg0KPiA+ID4gQ2M6IE9zY2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JA
c3VzZS5kZT4NCj4gPiA+IENjOiBNaWtlIEtyYXZldHogPG1pa2Uua3JhdmV0ekBvcmFjbGUuY29t
Pg0KPiA+ID4gQ2M6IEFpbGkgWWFvIDx5YW9haWxpQGtpbmdzb2Z0LmNvbT4NCj4gPiA+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTW9ydG9u
IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiAgICBtbS9ndXAu
YyAgICAgIHwgIDQgKysrKw0KPiA+ID4gICAgbW0vaW50ZXJuYWwuaCB8IDIwICsrKysrKysrKysr
KysrKysrKysrDQo+ID4gPiAgICAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykNCj4g
PiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL21tL2d1cC5jIGIvbW0vZ3VwLmMNCj4gPiA+IGluZGV4
IGU0YzIyNGMuLjZmN2UxYWEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9tbS9ndXAuYw0KPiA+ID4gKysr
IGIvbW0vZ3VwLmMNCj4gPiA+IEBAIC0xNTM2LDYgKzE1MzYsMTAgQEAgc3RydWN0IHBhZ2UgKmdl
dF9kdW1wX3BhZ2UodW5zaWduZWQgbG9uZyBhZGRyKQ0KPiA+ID4gICAgCQkJCSAgICAgIEZPTExf
Rk9SQ0UgfCBGT0xMX0RVTVAgfCBGT0xMX0dFVCk7DQo+ID4gPiAgICAJaWYgKGxvY2tlZCkNCj4g
PiA+ICAgIAkJbW1hcF9yZWFkX3VubG9jayhtbSk7DQo+ID4gDQo+ID4gVGhpbmtpbmcgYWdhaW4s
IHdvdWxkbid0IHdlIGdldCAtRUZBVUxUIGZyb20gX19nZXRfdXNlcl9wYWdlc19sb2NrZWQoKQ0K
PiA+IHdoZW4gc3R1bWJsaW5nIG92ZXIgYSBod3BvaXNvbmVkIHBhZ2U/DQo+ID4gDQo+ID4gU2Vl
IF9fZ2V0X3VzZXJfcGFnZXNfbG9ja2VkKCktPl9fZ2V0X3VzZXJfcGFnZXMoKS0+ZmF1bHRpbl9w
YWdlKCk6DQo+ID4gDQo+ID4gaGFuZGxlX21tX2ZhdWx0KCktPnZtX2ZhdWx0X3RvX2Vycm5vKCks
IHdoaWNoIHRyYW5zbGF0ZXMNCj4gPiBWTV9GQVVMVF9IV1BPSVNPTiB0byAtRUZBVUxULCB1bmxl
c3MgRk9MTF9IV1BPSVNPTiBpcyBzZXQgKC0+IC1FSFdQT0lTT04pDQo+ID4gDQo+ID4gPw0KDQpX
ZSBjb3VsZCBnZXQgLUVGQVVMVCwgYnV0IHNvbWV0aW1lcyBub3QgKGRlcGVuZHMgb24gaG93IG1l
bW9yeV9mYWlsdXJlKCkgZmFpbHMpLg0KDQpJZiB3ZSBmYWlsZWQgdG8gdW5tYXAsIHRoZSBwYWdl
IHRhYmxlIGlzIG5vdCBjb252ZXJ0ZWQgdG8gaHdwb2lzb24gZW50cnksDQpzbyBfX2dldF91c2Vy
X3BhZ2VzX2xvY2tlZCgpIGdldCB0aGUgaHdwb2lzb25lZCBwYWdlLg0KDQpJZiB3ZSBzdWNjZXNz
ZnVsbHkgdW5tYXBwZWQgYnV0IGZhaWxlZCBpbiB0cnVuY2F0ZV9lcnJvcl9wYWdlKCkgZm9yIGV4
YW1wbGUsDQp0aGUgcHJvY2Vzc2VzIG1hcHBpbmcgdGhlIHBhZ2Ugd291bGQgZ2V0IC1FRkFVTFQg
YXMgZXhwZWN0ZWQuICBCdXQgZXZlbiBpbg0KdGhpcyBjYXNlLCBvdGhlciBwcm9jZXNzZXMgY291
bGQgcmVhY2ggdGhlIGVycm9yIHBhZ2UgdmlhIHBhZ2UgY2FjaGUgYW5kDQpfX2dldF91c2VyX3Bh
Z2VzX2xvY2tlZCgpIGZvciB0aGVtIGNvdWxkIHJldHVybiB0aGUgaHdwb2lzb25lZCBwYWdlLg0K
DQo+IA0KPiBPciBkb2Vzbid0IHRoYXQgaGFwcGVuIGFzIHlvdSBkZXNjcmliZSAiQnV0IG1lbW9y
eV9mYWlsdXJlKCkgbWF5IGZhaWwsIGFuZA0KPiB0aGUgcHJvY2VzcydzIHJlbGF0ZWQgcHRlIG1h
eSBub3QgYmUgY29ycmVjdGx5IHNldCBpbnZhbGlkIiAtLSBidXQgd2h5IGRvZXMNCj4gdGhhdCBo
YXBwZW4/DQoNClNpbXBseSBiZWNhdXNlIG1lbW9yeV9mYWlsdXJlKCkgZG9lc24ndCBoYW5kbGUg
c29tZSBwYWdlIHR5cGVzIGxpa2Uga3NtIHBhZ2UNCmFuZCB6ZXJvIHBhZ2UuIE9yIG1heWJlIHNo
bWVtIHRocCBhbHNvIGJlbG9uZ3MgdG8gdGhpcyBjbGFzcy4NCg0KPiANCj4gT24gYSBzaW1pbGFy
IHRob3VnaHQsIHNob3VsZCBnZXRfdXNlcl9wYWdlcygpIG5ldmVyIHJldHVybiBhIHBhZ2UgdGhh
dCBoYXMNCj4gSFdQb2lzb24gc2V0PyBFLmcuLCBjaGVjayBhbHNvIGZvciBleGlzdGluZyBQVEVz
IGlmIHRoZSBwYWdlIGlzIGh3cG9pc29uZWQ/DQoNCk1ha2Ugc2Vuc2UgdG8gbWUuIE1heWJlIGlu
c2VydGluZyBod3BvaXNvbiBjaGVjayBpbnRvIGZvbGxvd19wYWdlX3B0ZSgpIGFuZA0KZm9sbG93
X2h1Z2VfcG1kKCkgd291bGQgd29yayB3ZWxsLg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
