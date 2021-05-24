Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B307538E271
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhEXIoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:44:04 -0400
Received: from mail-eopbgr1300074.outbound.protection.outlook.com ([40.107.130.74]:19828
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232318AbhEXIoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:44:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxMtkt2A3+G2hXpTxc2rn/YdUnfLLyJLtF1r99+VrnO5PU1WEZ8WDdGrBCo/bFpE3key2nFh7J/IfBpeR86mPFId4nrnWCgmjCD2Q5JeZm1xCvumyFa+e88arArCPidtZv2a1/yBOGDpLQne7KqnLGadvbuxO1YcDftnLIq0b/JSIgFB5RawG+OQkXUcisusOvgCSezpKr8te1ovhZ6gRSFGoqTYid4vwC3EklbR9wgZjPqdAfkK6g2ZXcCG6MkGGxvUGvbnEjAM1Rhq6Rr9R4VLr5KXtCRLOY2QG20LfeNfzTQPIHHj66YPUBLStuQ3y2exeVu7ansZ6OSkI6fV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CyAXyxgrl6pxnDkjbzvKHZAiReEf+3SeNrEDeM0OD4=;
 b=C1antTxaRDO1FTFib0/COrsJvp15LbKdLh3xxl3XowtbnniXonbIXQN5qQnaQk1rjlev9TuADm9NFxDAKvq9O/k25C8SWr1hBlx5I78RL2O8Q/VqAclJcFeQBBzN8muJ1WuT1if3Sl639JlD0q7fRO7CPwI/j6adxiMgL3uvX5r93EwYP4fc0mtItuneX1FrBkvIyOYqVLlMmDiZ63ffmyIUAognjfwUMEX5tP8vx0ikD+Bwkz+qsMKfoNXaTYENpvb7LW9o/tPe64F5fsGRZ94wzJ/s2joDY3HmmTHZaEJ2/YHlf+Yyw690QVhVec0Fqj50X/LxTYZvCenEo2UhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CyAXyxgrl6pxnDkjbzvKHZAiReEf+3SeNrEDeM0OD4=;
 b=i+d7mjYCwU5kNgl4Ak/DEDo70B9kOzJI5qMuPEJQLBDDYQ2Ika59gy4eGa9nrbMe7+/gIUYozvqktImhbFVbp0PIalUBQ5QAaksN+wqPjV9+0QgTvb0AH5MFmflx1qXYVekbV6VIN6h0h41qArrMd6UUFEsJmd74KphyBWJCSbw=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB3402.jpnprd01.prod.outlook.com (2603:1096:404:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 08:42:33 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 08:42:33 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Thread-Topic: [PATCH v5 1/3] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Thread-Index: AQHXTe21Fl0BqThmUEiRngoaL9uLIqrwEkYAgAJDVwA=
Date:   Mon, 24 May 2021 08:42:33 +0000
Message-ID: <20210524084232.GA3203898@hori.linux.bs1.fc.nec.co.jp>
References: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
 <20210521030156.2612074-2-nao.horiguchi@gmail.com>
 <20210522150900.39d6832a03c5f772911c5b6d@linux-foundation.org>
In-Reply-To: <20210522150900.39d6832a03c5f772911c5b6d@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a92df197-ef8f-4c92-8f04-08d91e8fdfd7
x-ms-traffictypediagnostic: TY2PR01MB3402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB3402BBE55CD3F139C08375F6E7269@TY2PR01MB3402.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Xm3YOlRzQVDxLtJgzCZg9j5polzt9M282odDqNqEL/Z7/c+wlk9rX4X++QgSb7nOsXlY7wCTF8+DgVcXFz3142MgHFclk3+bLC7gqFX3y4iXKwyEWfrdTQ9QLTzb5LquzcAcZGqDkzLEPBxfeG7w79vTBIuTO9Q/wO1DqZeGQrN4QaWTqRNLjvZ3BCK4yBka9nOpoOi4SU5zjZmHsOyyk1I89XdKk2O+COEJJLSP6GUC0fHc3uIFyubkOMTJ+0ziOK+plRt0jUX3VTQ6Z/5rjAB9dt7eg9z4e+T1mkfVhZEQ78Ske5LjUViOr+t/zWjKQib8HnaexzA3ucRo2banqMi/EyVFrkd4a3L1+qrrpp8Yj6WKv93oiPjJlGrxICgSS+udolOAWo2rGitcp6NEaRAsKZDtdAdEMcSGqUCV/Dx5tgUvjrww9ugRzcQ8W9YYfZZKAg9mJN7ry7oLVNaymD+qlaXCBq93kd1HUz052vRDjDTZdT7cCvLtFoMJo48a5B5Cav7m0D35tJmdTTsf7deSjum6YAVQzQH2LgS2f3+O1lRSpe65+hcPNfGPQqSBj7K60nuO73fxLCcjtRS2Fq7CICWinlD+eS+aIlI53M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(83380400001)(122000001)(6486002)(6916009)(54906003)(55236004)(66556008)(66476007)(478600001)(64756008)(2906002)(66446008)(71200400001)(76116006)(66946007)(6506007)(33656002)(9686003)(26005)(6512007)(5660300002)(8936002)(186003)(85182001)(4326008)(316002)(38100700002)(86362001)(7416002)(1076003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N1ZLQUFQcVFpTCtVYXo2RzYrOE1jNGtmMEtGYjlFdEQzdGlsN1p1YzdnY0cv?=
 =?utf-8?B?ci9qVUZTTDZYS0I3d2ZiRG5FSjVHQ011T1ZzVjVUZlpJaGxGQThGaG1MMy9Z?=
 =?utf-8?B?eVZlUjhmQUNaYTB2RUdkU1hMTG43cUhCR2J0a2lZVGxHN1k4MENDZDJqa3BK?=
 =?utf-8?B?QVIzNHh1RDVpcVZHUEJMUzVuSWNZQmVVajFncEpqcFAySEg2ditqTlBPTS9I?=
 =?utf-8?B?L3BnSndwQjF2SWZSYmZBUDdrV0NzVkVqdEpOTEVnQ0FwWE0yOHRXN0tBSlZL?=
 =?utf-8?B?SVRRYW04RXFZT2RYdEYyL2RLR3F5cWJIZ3kzOHM5R2c5M3lPNnJyOCt6aENk?=
 =?utf-8?B?b2t0TVlVbDN6bkFob1paRjFycjRlcEZGTHgrVzdvV0h1T1dxWHVvQXhmNitQ?=
 =?utf-8?B?NXE2QzNablRUMnUwQ0pOSkpzTXMrYndBc1N1U0lUYTE3UUFsWStIbVp5VW5l?=
 =?utf-8?B?L2dQc2FTMDBpRHdQNjJ3aXdxUHIySGV0Qk95YUNGdUdsODE5T3hHdWRVNXRU?=
 =?utf-8?B?MU5kWk1STG5QbTBlTWtHWnEyQnB0KzgwVE5od0xzc1BlYVpGcnA3K1lJYlg4?=
 =?utf-8?B?RWtxWDh4bThWdVZUdWJyanBYS3hGalpCRktlbzdvaURoSCtqWkZTR1dvdmZa?=
 =?utf-8?B?U3NBeGNJRzZpQmNyaTNrVHYwdnV5WVRRcVU1NVRjcTh3NnV2a1JrK0dEcEQx?=
 =?utf-8?B?cXVHWFhJd2xkaHQ0dm4vL3Z6K2tNNEZtOGkrY05SQXl6RXdmSUZEZlltQjV2?=
 =?utf-8?B?SEFvaXV1WXh4RW9MUkQxRXlpZlVtTjF0S3oyRUNPano3LzM0ZlFOWmhDVEo4?=
 =?utf-8?B?OXJmUmorQUZ6bWJoM3VGRU1iSU5LYjhBOXl1d0poWHFuZkEzVlRqSjM2Mm9j?=
 =?utf-8?B?K3JMTkRXSCszeG1YZlBLVjJ6aC8rdGJWTjA0V0JsTVdHV0dlYlh2eHh0ajJl?=
 =?utf-8?B?ZU1vallOWmZtRG1Yb0FKQU5TdkRyK29FNkF5QS9Dci9RaXRZMGNycWlGY1ov?=
 =?utf-8?B?K0IwVTFiRFZVUnlJbDJWdGhDa3Ywcm56MzNFYmdHN0ZPNk8wN1NtL1hJczZL?=
 =?utf-8?B?VXFQWEtDLzdkZnRwRHFYMFVtMEhTQ2xOTmtScUx4WUFpM1BkdmdjU2RtZ0FI?=
 =?utf-8?B?bENZallPc0djUlIvR2ovek1hOWhSZG1kZUhHNGZxT2ZySXBlVDRsQWVyTW8x?=
 =?utf-8?B?aUdpbVB1R1lQdUJTeVhGNFhQMGE4MHc4eTJwcXg3a0crVDRUdlFwSDB3SG9O?=
 =?utf-8?B?MWNJeVdCRitOOFhCWThTcFBGWVAzcms0dnpnY1JpQ3RHeVpDeW9uUGM3b1dU?=
 =?utf-8?B?ZFR6T1lNbFRGZjY3b083cG9NN1pkK3N3djNYM053NEUvWDRHWm8xSUlzZ2cy?=
 =?utf-8?B?anhNTWxIYVA5V1A5OFYySC9LVERNVFlyUnBMUU1WdTRSRndFckZmOG9mbVdL?=
 =?utf-8?B?c09vMll3b1RMQkJDT2RoWkIwTXA3QSt4WDYyZHFxVWRGWHh5THZIU1F6RGds?=
 =?utf-8?B?ZXEwZGlLNXZJblh1eUQ2UmIrTnh0bWI2SGZwUUhhME41VHhqT254NWhyRDVo?=
 =?utf-8?B?cElBck4wbkJHbHcyRUpFUEdpamFXOFFXeElkME1CWjRvSG5PdTIvQS8zb2s0?=
 =?utf-8?B?Wncyb2FDVkthSE5BWlBtT0tkaWlYQnp1czRpNW1oUnhadElSZmZ6VUFuN3Nn?=
 =?utf-8?B?bFhNem1rTUNtN2lEZnNQWEhhMkNLMnpsRmJTVzM5ZmNhWmcyMzNkdStDa0lT?=
 =?utf-8?Q?PNv4X7E4yX7f865Gv7PRxjGXMLLGZpwtLq1Nots?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2645101AB24FE64CA905379344702CD8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92df197-ef8f-4c92-8f04-08d91e8fdfd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 08:42:33.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 146amvcirfECslckk5ugZJ+WL1wXpcHMG5kPlwoQFTX6SWpdt83n3R/zfNJrdH4lNySXRVEi7AlEzTrU6BDacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBNYXkgMjIsIDIwMjEgYXQgMDM6MDk6MDBQTSAtMDcwMCwgQW5kcmV3IE1vcnRvbiB3
cm90ZToNCj4gT24gRnJpLCAyMSBNYXkgMjAyMSAxMjowMTo1NCArMDkwMCBOYW95YSBIb3JpZ3Vj
aGkgPG5hby5ob3JpZ3VjaGlAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+ID4gVGhlcmUgY2FuIGJl
IHJhY2VzIHdoZW4gbXVsdGlwbGUgQ1BVcyBjb25zdW1lIHBvaXNvbiBmcm9tIHRoZSBzYW1lDQo+
ID4gcGFnZS4gVGhlIGZpcnN0IGludG8gbWVtb3J5X2ZhaWx1cmUoKSBhdG9taWNhbGx5IHNldHMg
dGhlIEhXUG9pc29uDQo+ID4gcGFnZSBmbGFnIGFuZCBiZWdpbnMgaHVudGluZyBmb3IgdGFza3Mg
dGhhdCBtYXAgdGhpcyBwYWdlLiBFdmVudHVhbGx5DQo+ID4gaXQgaW52YWxpZGF0ZXMgdGhvc2Ug
bWFwcGluZ3MgYW5kIG1heSBzZW5kIGEgU0lHQlVTIHRvIHRoZSBhZmZlY3RlZA0KPiA+IHRhc2tz
Lg0KPiA+IA0KPiA+IEJ1dCB3aGlsZSBhbGwgdGhhdCB3b3JrIGlzIGdvaW5nIG9uLCBvdGhlciBD
UFVzIHNlZSBhICJzdWNjZXNzIg0KPiA+IHJldHVybiBjb2RlIGZyb20gbWVtb3J5X2ZhaWx1cmUo
KSBhbmQgc28gdGhleSBiZWxpZXZlIHRoZSBlcnJvcg0KPiA+IGhhcyBiZWVuIGhhbmRsZWQgYW5k
IGNvbnRpbnVlIGV4ZWN1dGluZy4NCj4gPiANCj4gPiBGaXggYnkgd3JhcHBpbmcgbW9zdCBvZiB0
aGUgaW50ZXJuYWwgcGFydHMgb2YgbWVtb3J5X2ZhaWx1cmUoKSBpbg0KPiA+IGEgbXV0ZXguDQo+
IA0KPiBXZSBjYW4gcmVkdWNlIHRoZSBzY29wZSBvZiB0aGF0IG11dGV4LCB3aGljaCBoZWxwcyBy
ZWFkYWJpbGl0eSBhdCBsZWFzdC4NCg0KVGhhbmtzLCB0aGlzIGNoYW5nZSBpcyB0b3RhbGx5IGZp
bmUgdG8gbWUuDQoNCj4gDQo+IC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmN+bW0tbWVtb3J5LWZh
aWx1cmUtdXNlLWEtbXV0ZXgtdG8tYXZvaWQtbWVtb3J5X2ZhaWx1cmUtcmFjZXMtZml4DQo+ICsr
KyBhL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gQEAgLTEzOTcsOCArMTM5Nyw2IEBAIG91dDoNCj4g
IAlyZXR1cm4gcmM7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBERUZJTkVfTVVURVgobWZfbXV0ZXgp
Ow0KPiAtDQo+ICAvKioNCj4gICAqIG1lbW9yeV9mYWlsdXJlIC0gSGFuZGxlIG1lbW9yeSBmYWls
dXJlIG9mIGEgcGFnZS4NCj4gICAqIEBwZm46IFBhZ2UgTnVtYmVyIG9mIHRoZSBjb3JydXB0ZWQg
cGFnZQ0KPiBAQCAtMTQyNSw2ICsxNDIzLDcgQEAgaW50IG1lbW9yeV9mYWlsdXJlKHVuc2lnbmVk
IGxvbmcgcGZuLCBpbg0KPiAgCWludCByZXMgPSAwOw0KPiAgCXVuc2lnbmVkIGxvbmcgcGFnZV9m
bGFnczsNCj4gIAlib29sIHJldHJ5ID0gdHJ1ZTsNCj4gKwlzdGF0aWMgREVGSU5FX01VVEVYKG1m
X211dGV4KTsNCj4gIA0KPiAgCWlmICghc3lzY3RsX21lbW9yeV9mYWlsdXJlX3JlY292ZXJ5KQ0K
PiAgCQlwYW5pYygiTWVtb3J5IGZhaWx1cmUgb24gcGFnZSAlbHgiLCBwZm4pOw0KPiBfDQo+IA==
