Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF9A3EE64B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 07:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhHQFlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 01:41:21 -0400
Received: from mail-eopbgr1400041.outbound.protection.outlook.com ([40.107.140.41]:7808
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233928AbhHQFlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 01:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmCnrsmPjXGe/pCAcZtlKDHY18D/+SdVqR1WuG3V0b7U05sEZBW9G1+BYDk5GtUoVu8Br36KiruVFodCOHsaxngyFW0ELpQQ0kpDIQD1CeR7Ni1Yw9yuL6ujmSTBFy52QSYi/FZ0t80GDIuLyrxLkxq25amNoR5MwtUyUY6q7OdxTVT0dxIN5LOUOzgcv4Z66ArotWWutsQ2O9cMzmNQsnSRVRZxxxEEtywQ8WWjHjFsej6u0SFjPw+jSQS3xAIi9RFF8+eWb8XZVyAggzVgfzCoasOyUX7MCJ+toZk1Id1a+9bnmqicNlYs7kPomLdMmBkXDv0BedDPsFdonMo8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtGely+I9zuWVf9vQgoyPJwuAh4VWg35EwQBmrbGxhM=;
 b=GSoe897fcm7oKcTDmSrXbV/avt6YpHTYGFFZHaCKVuLroHqeVWymfGLM5VfiD85CbMkcYuFHAatAnrQDVOGMvyXIY8uxlTRZMwaSZHFms7ERABjf3Hl+046wne8dpM8x2JNMSwYBAJkWbguGm+McwoXog7SGXzIQLEj8yoxgpw6pGF0VBdZFDBJUlNEmuW4va8yuXR/+F+/NE9z6zJ5d34W+5BS+r4gTsojftdEK8DoKrTwyXMWvKaHTtsux2IG4UKjZMUhfAACgSLAarPC5rnxpGsgSKOpqhZl/+BJVkQNKyadiYS6zo9E4MmdBW40mw9dKf1cbPtL0kXo2K2rSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtGely+I9zuWVf9vQgoyPJwuAh4VWg35EwQBmrbGxhM=;
 b=DvEm4MbIk07AdHVLHSaQHmCxbtQHJG6C+eeyJ3+aGwxiuhxEC/zirYr8Te3xKqZkG2R5VkpBlT3rvvtW0CuWVvwS9+RxQ3TSA1BS0YaxHxXot93ikUA+Pz6VoHKh+3W+cr8POsj3fvofjeeXNvO7kN8bbFx9xaLRS7UmT6Jq/+A=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3614.jpnprd01.prod.outlook.com (2603:1096:404:bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 05:40:45 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 05:40:45 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
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
Thread-Index: AQHXjzJ9+NCMdIrBR06t41b72146Vatvk1GAgABq8QCAAPyWgIAAkJYAgATZ24CAAAx6AIAAxK8A
Date:   Tue, 17 Aug 2021 05:40:45 +0000
Message-ID: <20210817054044.GA449241@hori.linux.bs1.fc.nec.co.jp>
References: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
 <20210603233632.2964832-2-nao.horiguchi@gmail.com>
 <20210812042813.GA1576603@agluck-desk2.amr.corp.intel.com>
 <20210812090303.GA153531@hori.linux.bs1.fc.nec.co.jp>
 <20210812152548.GA1579021@agluck-desk2.amr.corp.intel.com>
 <20210813062951.GA203438@hori.linux.bs1.fc.nec.co.jp>
 <96d4fd8b75e44a6c970e4d9530980f21@intel.com> <20210816171207.GA2239284@u2004>
 <20210816175646.GA1600630@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210816175646.GA1600630@agluck-desk2.amr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9081d01-cf5c-44a8-7ca0-08d961418f2b
x-ms-traffictypediagnostic: TYAPR01MB3614:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3614C8921A1212A5E83096B9E7FE9@TYAPR01MB3614.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CSg8D2/sSVfRXDq4zeODJU8tckUma3VKsPV+qqvuk+KnB+VTJxJgcKAnJ8V67K0wSkbrvbGERhPoE2SKilaCuybeiov48vE7/WcNzxx4cMYGzsehN+X/yhLPAvnbU4Ki56tciZO1tRQ/y3if/wakRjO4CF9szQlPx+Zn8LlqBFWXwN3rAB9H/ybXTqEf0U358OGVBtO963amLSDfjQcC+KmzKFvCTHehIabIvwvEXK9kptslzF28n6EwQ2RX2qVhXLp97LKAAlc3hdBV8rS399bjNeDAs4G4gUwQnAWNkp8p7PawCVT7/GGZySCshzVfnu1HjAD6y7iXjQHGAUh+sVcFQqmtkuf1WyEMEeJWMX89Fno7dY0x2yCvMNPiMCV+fDUFknJptloxqf31j5Uh2Zntfvwnof/ryrQjFaSBFFBGfqWb54dwm2hub+9KZAgt369jQQT0GARUKPtU6axex70rlH9GsDZVFKcspOKms/jmvOJKy6c6O67An58/iUdJCUPkCZaGvb0DhroVkwwDE2z0Ds4fBAD3oXWf05y/T2ntW+4VNATkj6crR0z+nhBMgegU72EVpOouwcAC6zp+YfMubiCuuXv6R4hi5N2a7+ERV3FNqj34zcjDi5HA5O3dbxcN0TwKQueZpu8lzdgxCXpepzzKp8soWJ9AXvPjDoeICn1OMHI0rvAzdDjdyBNEp1rN1eIHHKugwePmYaR2Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(508600001)(4744005)(76116006)(122000001)(66946007)(66476007)(38100700002)(316002)(6916009)(66556008)(8936002)(8676002)(1076003)(2906002)(64756008)(66446008)(85182001)(9686003)(38070700005)(5660300002)(55236004)(7416002)(6512007)(26005)(4326008)(6486002)(186003)(33656002)(6506007)(54906003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzBTaFFWSk9FMUR3Z0pRUjIrNUVsK0RvMzZ4V1Z0ekg0MHkrVkNYOVBsZ1Bl?=
 =?utf-8?B?OVdSNFNGaE02cUk5OVRQcjJxaUhHSGZQeHdjc0lRQ25kQUlKcnJua1dEOFht?=
 =?utf-8?B?TUNrN1dDV08zeVZKK1dyYWtJcmtMdjk4N0U5ejV6NnF1MGtHL0ZYd2RUWkJt?=
 =?utf-8?B?UlVkVWU3YWg5NHlkUFplM0cvRVBXNE1NZVJXYVpqOVlsQmpsVkpCbnNRdWdh?=
 =?utf-8?B?RjFua1hreGYxK3NwVTVhbm4rV2lEcGV0bnAzTzd5Vm5pang5d1pNcjYwRkNw?=
 =?utf-8?B?Zi9zUG5xV3NsaGJ5MDY4TVlQQzJJSC9EeFY3TXlhbVJPTHRkY3EwUlkrdGp5?=
 =?utf-8?B?Y09RbU9DY2VmWllkU0FIMnNOMVdnTGVrTXBPRkhTbVBuTHZrbVFsSUN3WlZo?=
 =?utf-8?B?OGxEZm9UMk1TQTl4STlYa3BQMUpoeFNKdnNyeWQwcXRPaGR2dklQRHlWM2gz?=
 =?utf-8?B?aHZ2ZHViOEVRQi90UWxmK1VERW5ORmgyUXJwZkpIQW11SU4wU2NvZUZBTk42?=
 =?utf-8?B?SlcwZEpWK0gyTUVVUXFuOUZvK0N2Ri8rNytnRTZ6c0diZlpqQUdqZ1NLS0Rh?=
 =?utf-8?B?QytFZnVVVUF5SG9nVU85aTk0SXJkd0h2eGwvSG80ZjBFNUFBZGNwMHpHcDln?=
 =?utf-8?B?QjhETExkQ3AzcGprVlBNejFleTdjbnpPYm0yQzVyQ2wreEdYZFNBczNpeldn?=
 =?utf-8?B?MTVVaDQxM3pjRWxqdzdWbG8rakUwY3I0aDI2N1A1OUl5VUQ4RUJnT0ptL0hj?=
 =?utf-8?B?UkxQMkh6SnFxMk15d3JlZlVtOGlaTFM4VEFxRXloMTYzbTFDNE04bXdoWXAr?=
 =?utf-8?B?TTZzWFlnVEpsNkZDM2tRR1FFeE8wSUxLOXVwV2NIc0dhdVdacjlpbVpHeXRz?=
 =?utf-8?B?ZDc1RVFLa294Tk9wSmlyT0xQcDJ0U2VIZG4wMmpEbUlEVkVLbzFqV1pSSFdq?=
 =?utf-8?B?S3JlaHdUR01NZmJFVGdSRXlBazdQV3hnKzZZQzV0WEN4LzlOK25BQlgzYm9N?=
 =?utf-8?B?ckRvUjlKRGMzdm5EVlFqb2hSUDk5Mi9UNzY4L2NZVGlldFJUVTcxQzNUemxN?=
 =?utf-8?B?bzdoZlJTZjY2K1N4dmpzSmY4WWRHcG16eHF2d1FoRy9YdkVxT0IvdlV6YXV2?=
 =?utf-8?B?cFhUT2wrYUd5Ly9FbEVXMlh5NFJPSllza2cwcXU2cHVvaUtzL3ZkZ0l1blRi?=
 =?utf-8?B?cXpJelFKOVVPbkhvVmc5TGpQWGRJZTRaN2diTU5pSDJuOFVLeEVKMHBkSkRz?=
 =?utf-8?B?aDR2UEhiY1pIUE1oNFB2a0VRVi91YVZqb1MxV0pkSnNGN1NyeWlXeUlDM2cz?=
 =?utf-8?B?M2hya0xDeVJOcytwcWlQRFdlY2NWOXNmZ0xlTkx0cUJyWUoxZlBOMS9LUitY?=
 =?utf-8?B?cERZdGlJWERBODBPRXlueWNibGh1Sjd4Um9scVVtbDlNMHYzRzRSYzNEUkVh?=
 =?utf-8?B?cms2a1FoWVJza0V2OFB4dExLdmtzeTVpOU9ySzFMZzVaVUpGeW52emlNdHVV?=
 =?utf-8?B?Z1ZvTk05R0N3aElhMTlvaTJRMEtHb2kwcGxwNHlFRkVEaWxLQkpmaXJtMlFO?=
 =?utf-8?B?S2hUN1hTNkhKcjNaVk1MVE9HME8rNTJ6dW5tbmo4eUEvYThORHRyQVNtMDFQ?=
 =?utf-8?B?Vjg2dGdmQ2pMUjEraFJqaUNNeVlTZG9xejJWOGJTb1FpSGMwTnVBcXVjMTAw?=
 =?utf-8?B?VmxEc3htRHU1VzIyMzZ1NnFGVzd0dHNsL3M2VUcraGJVK3AxdS85dDJoVHRT?=
 =?utf-8?B?SDN4VDhVTUpyaERQNVFpaUdiWGlOTDlVU3Q2NHlzeDRUdThWSVlkcmdNU0ZZ?=
 =?utf-8?B?TzRKdVpEVDAxdXhKRmd2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FE38009B7AE5945B4DCD1416E29D6E4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9081d01-cf5c-44a8-7ca0-08d961418f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 05:40:45.1806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72wuE70vO67GfEev04ETx+QYwKaZAlCuAjkj3nShocwL85KKshhhzNweIcf4njNGpwG9jTbbCE8pj0B6PH7kpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3614
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMTA6NTY6NDZBTSAtMDcwMCwgTHVjaywgVG9ueSB3cm90
ZToNCj4gT24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMDI6MTI6MDdBTSArMDkwMCwgTmFveWEgSG9y
aWd1Y2hpIHdyb3RlOg0KPiA+IFRoaXMgZHVtcCBpbmRpY2F0ZXMgdGhhdCBIV1BvaXNvbkhhbmRs
YWJsZSgpIHJldHVybmVkIGZhbHNlIGR1ZSB0bw0KPiA+IHRoZSBsYWNrIG9mIFBHX2xydSBmbGFn
LiAgSW4gb2xkZXIgY29kZSBiZWZvcmUgNS4xMywgZ2V0X2FueV9wYWdlKCkgZG9lcw0KPiA+IHJl
dHJ5IHdpdGggc2hha2VfcGFnZSgpLCBidXQgZG9lcyBub3Qgc2luY2UgNS4xMywgd2hpY2ggc2Vl
bXMgdG8gbWUNCj4gPiB0aGUgcm9vdCBjYXVzZSBvZiB0aGUgaXNzdWUuIFNvIG15IHN1Z2dlc3Rp
b24gaXMgdG8gY2FsbCBzaGFrZV9wYWdlKCkNCj4gPiB3aGVuIEhXUG9pc29uSGFuZGxhYmxlKCkg
aXMgZmFsc2UuDQo+ID4gDQo+ID4gQ291bGQgeW91IHRyeSBjaGVja2luZyB0aGF0IHRoZSBmb2xs
b3dpbmcgZGlmZiBmaXhlcyB0aGUgaXNzdWU/DQo+ID4gSSBjb3VsZCBzdGlsbCBoYXZlIGJldHRl
ciBmaXggKGxpa2UgaW5zZXJ0aW5nIHNoYWtlX3BhZ2UoKSB0byBvdGhlcg0KPiA+IHJldHJ5IHBh
dGhzIGluIGdldF9hbnlfcGFnZSgpKSwgYnV0IHRoZSBiZWxvdyBpcyB0aGUgbWluaW11bSBvbmUu
DQo+IA0KPiBUcmllZCBpdCAuLi4gYW5kIGl0IHdvcmtzISBJbmplY3RlZCBhbmQgcmVjb3ZlcmVk
IGZyb20gYSB0aG91c2FuZA0KPiBlcnJvcnMgd2l0aG91dCBzZWVpbmcgYW55IHByb2JsZW1zLg0K
DQpUaGFuayB5b3UgZm9yIHRlc3RpbmcsIEkndmUgc3VibWl0dGVkIGEgcGF0Y2gganVzdCBub3cu
DQoNCi0gTmFveWE=
