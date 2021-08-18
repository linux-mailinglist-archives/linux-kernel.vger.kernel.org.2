Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EBB3EF9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 07:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhHRFDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 01:03:17 -0400
Received: from mail-eopbgr1400075.outbound.protection.outlook.com ([40.107.140.75]:36310
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229449AbhHRFDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:03:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYcHzYdGUpHCgmUNLJ+q73D0cym8xZhqKgWbnUHtHd6JECXZQU7il6NkHQKXYZBFv4uHXfwFHi82lTDPSPBCERcV3g+czMyUpdfRSGlSq1w+1JEHMk3J1cJs/QuPZNXwYFBk5CVkp44eZmGxojqCjuA7EJMuwUWFMu/r/es21TKLpAbd0PGB/nADfkrxa5j+72cNcLfnY9M/+m/r1WHNPJ3eE5QzWr8pyLX1ItzDiXMqirIm4fby9NgsBiHDP5iLfiNitNfswJSOAFzZYGtMNvX0+a9nxc8U6qr0f5GkbHa8JuU76/rtGfsJf8/Xq5+N/w9KlsHZRJJCrxHwnGf5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0WOgCJ5PM21Irdkpg8YJs6+HVVH4bLQhogf02e1fQI=;
 b=V3OfaslR1brFKrxb/DjEGccZ6hK9XT+4nMGCUaAqR4h2FqflZ8pehPR2NyeKlaclZlqpMpM+3ag/Ah9Ujh4VuYFKxhlI4X3hZBeAE73AtDm1LOesTNL/bXBKHs3ra03G7ulKb4o8nceSCH7+7bOSZKbMghSNYRZmbVw4/Ah0iQZDC8u7L9O/zoD8P1+2Ius25jIH+U+jFoM6GDgo9SGi/yXkatSigreTxBRbMaqK/IogDQMT+97f2iazhUUJRgOSdQC4MpY7e/nA4irULcVFnL+HOi5h5dEtj/4Nbk4923SfSl6WdhdIa5IWV3d4Ui1hgL4mhcYmP/aHUevwFmkk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0WOgCJ5PM21Irdkpg8YJs6+HVVH4bLQhogf02e1fQI=;
 b=FGIczM2a2PQ8ErSD8YaQYdU6rztzUhys1kC/umu1uKnzQIiRM/dLV3Zm8mWakuGWKRXUVhc5aPeKwFjTaeizoT26+kqucZdcwuxeiNzCW7xqxuIHmyhgY1yVtWkWvDZC+soOEFR+eSrWK02qRw343587W10tSfnYQn3GMYqb2yI=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB6521.jpnprd01.prod.outlook.com (2603:1096:400:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 05:02:39 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 05:02:39 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
Thread-Topic: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
Thread-Index: AQHXksnkh27YGKOdbE2zWLc64oMBYKt2htMAgAANAoCAAiMggA==
Date:   Wed, 18 Aug 2021 05:02:39 +0000
Message-ID: <20210818050239.GA496938@hori.linux.bs1.fc.nec.co.jp>
References: <20210816180909.3603-1-shy828301@gmail.com>
 <YRq+kCOW4zb4vfxA@casper.infradead.org>
 <CAHbLzkoE6h9dmRp6zfaKdLjq2y24+PV-yBUv6RMXtzKvPFdBkw@mail.gmail.com>
In-Reply-To: <CAHbLzkoE6h9dmRp6zfaKdLjq2y24+PV-yBUv6RMXtzKvPFdBkw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8b6be26-026c-46f1-e24a-08d962056729
x-ms-traffictypediagnostic: TYAPR01MB6521:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB65217C210B18E200CF6D0BE7E7FF9@TYAPR01MB6521.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G/5RI4TPoRcQ1RGrGRjlebY/RCEHsbluKKLd8OsSnI04EDzt1MKqZJBb9DiqGKEnrd1QsHhp1XHoObMnf6RNSliOy8TOMnxA5HPV4Cc9FjqKM2DzqgKUdTTU+eZOFT3Gh/n7OIcm2hy8suC04+46KJh3pf5vY/a81EyyWMCResg+bQh5DUGmdI8PRxUPYv/09NY2xDnf+cz7JtClM4nvtkLRp5gvKbRbwZDT1tKnq99IjSmhDIl9+vue5+fAf8DnlISTO0ynla3Uh7KV8rCa/IWTfvo6J+zpfmdHK+tAmwEsc88oEVSbI1ELUWVDrio40lMHC3HT7eDIjrSyBaRZNctaGSQBuT6u1TYB/geZr/JHEBt3L4/Buh5xk7eQ2E2YS47c1JyBtMOfWTFGjSpoHbEDjkmGXVgpufJb8ptj5NHR7dtVuf8CGaNigEYUkLSjVbj4LcPyb9ApnfV+qRe5EOvcX+DngIwlrZAXGtI/OEBFUyMiRTvbeXXq6gwPCQoZrVzNY/eXg1/ZkbH7nkdR2m1gQdPRrhxrQreEiHWI2qrYlUgakbActs2fibMkmhXjvtdiXc06BWzM6IdWQSzHAyET7AknLyuvFVrLfa2JRtOseaz1YgjJAYNtGuVR8Wkx7dwQB+Wi7AHFa0uqIsqu3pAi8KpiLB13KiKIDMVqXsYzv7ui/NkNLt82GZhZk8Tad78HVN0YS+FKjpCOLM186w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(8676002)(53546011)(55236004)(6916009)(33656002)(6506007)(54906003)(64756008)(66476007)(66446008)(8936002)(26005)(478600001)(5660300002)(38070700005)(316002)(6486002)(71200400001)(1076003)(9686003)(83380400001)(86362001)(85182001)(6512007)(38100700002)(186003)(4326008)(2906002)(76116006)(66946007)(66556008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTJrWG1UR2h4Q3NrS1N0UWVVazdEa3dMTHZSQWtUY3d1Y3R6NnBTaDk1ZmlS?=
 =?utf-8?B?ZW5RZEtLNE15SzVTcmptZUQxK2JJbWZMSXJhdjlGQzljQTNzTXNaQ053K2t5?=
 =?utf-8?B?all5ZEJSbGJhMXhxNWpsZ2VTUHBRSVhaeGtJU2VIMXdSdGlWQ3ovN1Nyc2RG?=
 =?utf-8?B?VFdCVzBkRlhnWVByL21yYkNFT0hNb1VCV3hRTlJEOFdVRWRMYVZ5QmxFOE13?=
 =?utf-8?B?THVQakc0MDV0UStMNzBEZ29lZ0M4Qk55L0NHejVaa2NROFFSVEVVTUs0UUJS?=
 =?utf-8?B?Um1tM0FlYy9iYmRDQzA3N1NVRGtncHNCa2w0TWdWY2hhN3R6ajZRQ0VUWGlC?=
 =?utf-8?B?ZW1BWDNxaFJQQWhva29zc3k3VGt4VFNTYm5Tb2QxTjNPYndxSEtCR0IzVWgr?=
 =?utf-8?B?RHRmcEtxRlFXMW5nLytvcVhOOXl1Tmc5Y1hKL1lwdFNkaVlBdlNqUXpLNFhl?=
 =?utf-8?B?QmxsbkxTVmRocjY3Zzd4TkJ5V0dPeTdJaWc2ak9adGljR0RnRXdJYTR1U2tP?=
 =?utf-8?B?SUN4K291U1FYcUQxVlRkRDRwdkZpcE1lTDJKNllKdVJlRnQzdEh3dGV0N0pJ?=
 =?utf-8?B?dllIWXc2ekJ5cDZmQUIrd0lhbE9VZGFZWUYzTXl3M2h4VWpBMFdoeDQxZkZR?=
 =?utf-8?B?NURScGlEcEozcGlaRXQvSTNlYWMvaVJYeFZXaWk0Uk83eXlad2lqVksyQ1BN?=
 =?utf-8?B?NEpKQUxoeTNIS2tSN2NQbmVBdS9tWmRzZExyaXFkSkMvRm40OG5LVDNKTmgw?=
 =?utf-8?B?M3paaGNnYUJQUmhpUmJrZkZBOEdRUytEdG10WURFV0U5Uk1JanhkVTlKZE8r?=
 =?utf-8?B?T0djR2diZEsvc3hsbVBhaFQ4ZmFRcGJOWTFhbGVHcmpkMUtFYmtyTExqMXNG?=
 =?utf-8?B?SWdFUXIrTjJxaTJBbjQweUo2ZHBRNXF5dVBpR0hCSjBoY2lnQ1QyRXZFUTlY?=
 =?utf-8?B?Q3lLeFJaNDJpM25zWHplL0h1NlRwK2NXNmwrN0hOcXFqQjVYdG1iSStQMlk3?=
 =?utf-8?B?MDJubjdMdHllUEZGK2dmd0hGUXpueitYbksxdW5QNHl1eXJqei83OWhmbG9Z?=
 =?utf-8?B?Vnh6Zm05WWJRdTg1cGpseTZiYXNxSmZ1bVkwK0kweFNjZDB3clVtMkYwNHRp?=
 =?utf-8?B?Z2lNUmQvcnFaeUsrMndTN2tXelRudXU5Nkk0UG56d0YvcFZhQmFEYlFHR21u?=
 =?utf-8?B?ZDU4R1pZbEk1K1RDSmJMeUpEUi9KQ1ErS3VyeXVOR21tWTNSekZqQXhBY0w5?=
 =?utf-8?B?ZHltWHRYUVFUY0w3dXJ2cVJ1b05oNElVcHR2MFlYbHVtZnVIMFBneFJMVGdU?=
 =?utf-8?B?ek0yN2RIMjdTSVFqZy8ySmdlNnJnSVQ5RUdtekhNYzNRM1laYk0rcmxkNW1q?=
 =?utf-8?B?QnJqcEs2NEhJZFIwYVhHRFh2SjJkTDQyZjFkTFQyN2FhUllsZ2ZIcWY2c2V4?=
 =?utf-8?B?a2ZzQy9rZENUOU5UUnliQjdvVXUvcld4bjJ6ZzE1eTE4TkNzL2IxUGIvaFFv?=
 =?utf-8?B?MTA5QjhoallTMDA4K0sveWNHS2l0Yytpalg4akVPQlVaMk9zNXNNZ25iUS9k?=
 =?utf-8?B?VFphSXpIWEVXM2dYcWJxaEZXYTBBR0ZWL20yLzJHN1dzSVhqRU5OZ1psK2k0?=
 =?utf-8?B?N0NxMVk3Rk42eTd6ZDdpVk9CejlReGlYK096Y0tvNWxrb2JYbHBCc1dsNDdm?=
 =?utf-8?B?Uy9UWWZ6Y3Y0OGJaWW9MUG1oVWt2b0dpVVVhVHZpbUtVc0FWMU1qOTA5YVZF?=
 =?utf-8?B?M1k4blFKU0ZsWDhlMlR3dzFvd0NGZVFhUzkxT1daelU1V3cyUzBIRmh1a1Vy?=
 =?utf-8?B?QzdCdzJ1bGd5d1plUFgwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB8306CFB4B3584E80BDF5B0C64095DA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b6be26-026c-46f1-e24a-08d962056729
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 05:02:39.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fqTp+OxQDAToNSBnb7lKVeMzcCiEJp1/u23cRh40AiFIsKfd+IPGzv+YFt0tQbOp9QNUXC+MUS6EyW85MTQbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6521
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMDE6MjQ6MjVQTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDE2LCAyMDIxIGF0IDEyOjM4IFBNIE1hdHRoZXcgV2lsY294IDx3aWxs
eUBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIE1vbiwgQXVnIDE2LCAyMDIxIGF0
IDExOjA5OjA4QU0gLTA3MDAsIFlhbmcgU2hpIHdyb3RlOg0KPiA+ID4gQnV0IHRoZSBtb3N0IGRp
c2FwcG9pbnRpbmcgdGhpbmcgaXMgYWxsIHRoZSBlZmZvcnQgZG9lc24ndCBtYWtlIHRoZSBwYWdl
DQo+ID4gPiBvZmZsaW5lLCBpdCBqdXN0IHJldHVybnM6DQo+ID4gPg0KPiA+ID4gc29mdF9vZmZs
aW5lOiAweDE0NjlmMjogdW5rbm93biBub24gTFJVIHBhZ2UgdHlwZSA1ZmZmZjAwMDAwMDAwMDAg
KCkNCj4gPg0KPiA+IEl0J3MgYSBzaGFtZSBpdCBkb2Vzbid0IGNhbGwgZHVtcF9wYWdlKCkuICBU
aGVyZSBtaWdodCBiZSBtb3JlDQo+ID4gaW50ZXJlc3RpbmcgaW5mb3JtYXRpb24gc29tZXdoZXJl
IGluIHN0cnVjdCBwYWdlIHRoYXQgd291bGQgaGVscCB1cw0KPiA+IGZpZ3VyZSBvdXQgd2hhdCBr
aW5kIG9mIHBhZ2UgaXQgd2FzIGluIHlvdXIgZW52aXJvbm1lbnQuICBGb3IgZXhhbXBsZSwNCj4g
PiBpdCBtaWdodCBiZSBhIHBhZ2UgdGFibGUgcGFnZSBvciBhIHBhZ2UgYWxsb2NhdGVkIGZvciB2
bWFsbG9jKCksIGFuZA0KPiA+IGluIGJvdGggdGhvc2UgY2FzZXMsIHRoZXJlIGFyZSB0aGluZ3Mg
d2UgbWlnaHQgYmUgYWJsZSB0byBkbyAod2UnZA0KPiA+IGNlcnRhaW5seSBiZSBhYmxlIHRvIGZp
Z3VyZSBvdXQgdGhhdCBpdCBpc24ndCB3b3J0aCBzaHJpbmtpbmcgc2xhYiEpDQo+IA0KPiBZZXMs
ICBkdW1wX3BhZ2UoKSBjb3VsZCBwcm92aWRlIG1vcmUgaW5mb3JtYXRpb24gdG8gdXMuIEkgY291
bGQgYWRkIGENCj4gbmV3IHBhdGNoIG9yIGp1c3QgdXBkYXRlIHRoaXMgcGF0Y2ggdG8gY2FsbCBk
dW1wX3BhZ2UoKSBpZiBvZmZsaW5lIGlzDQo+IGZhaWxlZCBpZiB0aGUgaHdwb2lzb24gbWFpbnRh
aW5lciBhZ3JlZXMgdG8gdGhpcyBhcyB3ZWxsLg0KDQpJIGFncmVlIHdpdGggc2hvd2luZyBtb3Jl
IGluZm9ybWF0aW9uIGluIGZhaWx1cmUgY2FzZS4gVGhhbmtzIGZvciB0aGUgaW5wdXQuDQoNCi0g
TmFveWEgSG9yaWd1Y2hp
