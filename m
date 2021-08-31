Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4B43FC4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbhHaJMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:12:36 -0400
Received: from mail-eopbgr1400041.outbound.protection.outlook.com ([40.107.140.41]:34720
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240548AbhHaJMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:12:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn8C8GDJHtqcxl74iwgtm9rsXCMocz2o53S/jmAGFH24r84aOwnkUQvwd/6hZq+vAqUVF3rVqx6BDke/HdcsbZYB8g4ybKIQOoEXwPPA48Tt17GHp/6l/4l3GOfhGxZGBUb31U53htCDleQ+7lw8/Gpqcjju/oVgtZ/kCwRe7Z6sDiCFyuoVfEZ1xEOxKwW4HQgmf1WJsiaY/tqaSlCHVnM+AonLbrCkNEhzNFflu07/F5adSsLCS4qcFWLtqk5isaLz3FyIZ3t8jnuc8ApGqUkOM/S+sZIoG7DOjvJPuWM0DvzqP9ZfA/Sb3orcrdkiEx+jjNDeKFfUEKDaBk2PJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gabXT7pWAUWBPj7GVXZJYsGCNqG8VRpQgW1ISOZAz8=;
 b=nV5K2PKDRYYImNIEM5WWcXJPLBjHpr+3xGyeAq7SO2fY29GnGzY2nxhRn1sOp3Ma+3t7+ggjrsPqdYU+RezvIQIHG0JJ9Bu+cIrr3/L+wkgsrwlDoZb9HQG5XfdOi5/l1Ygf2+dpcU8ENO6tuZ8kbprU4nyEVJjvPkOMp2/8+2iVK+5Sx6pxUMp8O5aQeaVCsAkFkaXXyMPDXp8LFwYyvkpWsSlUqG9BZxNc/533kyNjh0fKTaJpTyz4ZHrRnSZ7Wc4jafYuBdGd21gewGTsapJeBiUEMlPPFW/V5lG6cNeOudQEmvJK1c5lVSP211Wtp6ZMh1+sOJg4BRiUc3AH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gabXT7pWAUWBPj7GVXZJYsGCNqG8VRpQgW1ISOZAz8=;
 b=SDenOTdOaIa5pB1p7izSClTIvoZq/ePMBVS+khBvdhJD8c0t75UxfiEyjViDERxxMZ7Omq0Dk5gnUaIocS5cR0Kjv5RECzdChWvELcoFz5Sywx+XVTtRc3SqfaaNXiaLfTOVTy1kGcWnBljcsdU/GkpVklB7wfVhE1KEdTuV9mQ=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5869.jpnprd01.prod.outlook.com (2603:1096:400:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21; Tue, 31 Aug
 2021 09:11:35 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 09:11:35 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:HWPOISON MEMORY FAILURE HANDLING" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix panic caused by __page_handle_poison()
Thread-Topic: [PATCH] mm: fix panic caused by __page_handle_poison()
Thread-Index: AQHXnYbw+xEi3gK710uHKvRsmHf/tKuNVVUA
Date:   Tue, 31 Aug 2021 09:11:35 +0000
Message-ID: <20210831091134.GA1075738@hori.linux.bs1.fc.nec.co.jp>
References: <58b6b733-b021-7eb8-4226-1b98d50c8c82@linux.alibaba.com>
In-Reply-To: <58b6b733-b021-7eb8-4226-1b98d50c8c82@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f3a38bb-b5de-427b-132b-08d96c5f551d
x-ms-traffictypediagnostic: TYCPR01MB5869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB5869CBCE47976DB0713B3BCDE7CC9@TYCPR01MB5869.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8mrvyDVrP3mTm9NkS06vPR9D3ZBiOJjnbKxQJCCjQKlcqqc6KvXU1XzCm6gnz0FvLz9NguE7T/qWh1nmrECDRrOOZK8ON0GYfLTKbGdYp6r80lzrP3zvusYL/xfsL0LMtz0gxavKoSRRiYbblgbDxK+fAfXhU7/LD+yqNOjFokiamgDyk3pcL3o4ua8wkzaGrRCdCqVaqcacD+rTRz5YXh+pMRYnZ5Ex/WfbriznrZIwy8hWIKCx1xazf7TrxKXIPBHoXwCVZYW+r17t0uijelGwGPcaCrY3Lbea4tYqQp+yxag6Tl5WvV/Hj7RzuHObPYw6YETP+NIMljyXeE5gpA2R2S1Gq/05QrXRgFJpIbUZk/ZgGmpiLrk8Zyhlk1Ruc0Zx6PDBEzSehk7uVtMvrQcBFxyZ786nkucvlx24V+7vdukSi1tYX3MLgmzgZSzjMNHaS8A4+KCKUwfC9bQE22qtzVMAxJ6Cd7SCxVqLC0okOg6oZPBpoxyYMzYnc0i5Ag68UR27KJaEgvJBDwO+WxD6V+wXMUNZIEwj9sgBlTfcM/q4eHSEgR00cIQWUB78raOxu9V8IAs4WgwE3Woz6ZJkv0n7JXZkEBSxLpJIda8AVJ9nfLkny9UDe8e8+iYDrlvDRTQNLquk8GbyNZxdYk6KEArzmPoHqORFWd39beT9IBAwuNzAo0crxnxiUqF2wmT7acx9dNG43ZEEzfKZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(66556008)(5660300002)(66946007)(6486002)(6916009)(26005)(76116006)(66476007)(66446008)(4326008)(8676002)(55236004)(6506007)(64756008)(8936002)(9686003)(54906003)(186003)(1076003)(478600001)(2906002)(38100700002)(122000001)(38070700005)(33656002)(6512007)(71200400001)(316002)(86362001)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVFmVDgyNlM4QktqQVRlR3pPMlh6VnJTR0NRSXMwL2xKbFVZdzRZL0c2QklW?=
 =?utf-8?B?bE1TYStZYVNDYVJpNWw3ZmZ1U1J1bEFEbnM0aDNqdTV0RzBMVjRpSkZrdDJO?=
 =?utf-8?B?QUVYYzhpYlB3Tmo2YnlVWTBkTDR0ZUJNQU8xSkVTMmZacWlXaEdINXRJeEJD?=
 =?utf-8?B?N3hZdWJVM0xTL3V0RTJCMGZMaXpvczVoVklSN0x1UWx6Mm51QXZGM05mMVZD?=
 =?utf-8?B?VERrTHk4Q1FmUksyQUpOdW9Lc1ZKYnE4b1FxNmc3RGRXcktOdDFzMXh4N2pO?=
 =?utf-8?B?ZnVwQjJERnhpZHJRUkR4UHY0RE9qQzV0WWRNSFFrblk4UElacCtQWTZiOElQ?=
 =?utf-8?B?MU9COXdqaUdkbUZiUFFQeDZpenlXalVmQktrYmV5dnlidG1qZktJbHIrZDRD?=
 =?utf-8?B?NFBRbC9sWmk3TFpNVnd4SFFockZ2WGNKZkM2UnE0MkRHUVFKL2lhNVhlWjQ3?=
 =?utf-8?B?OHhsMVV6Mmc0T2RnSG9tU2UzOFdvaW9hSkpTVFlhZnVlbUxYd0RHUjJkdDFP?=
 =?utf-8?B?aHRPZm9UbzdybTkwVU0yOG1kelJSTXlSSytoK1FrOWF6MTF3NEVRdElGMkdT?=
 =?utf-8?B?SFNmTjQ5d2w2U1NJZXBDZlVudVBtaEZIZlFsRzQ0Smw1R05FQ2o3cyt2b09z?=
 =?utf-8?B?TDRYamUvVHRZcWxkUjdVbFAzdkliTHpiVEJBS2ROU2lUWHJrS2U2d3lzVXdk?=
 =?utf-8?B?Rkxmdk9CZHUwWlJXRkNDSW4vL1VPTVVMc2wrUGpmRmRNSXpGWEJnbUpCWVRZ?=
 =?utf-8?B?Z0xkb0xzRE5OVlZJdUZGM3h0ZllLaTFHNGFjN3ZFNkNJS01JaUpoY21Da1FE?=
 =?utf-8?B?eG5TNDVZdmRBbitubDMydnlQQXhOYnJyTWE4bzQxMlJrU1JwRTRkYVFLMjZx?=
 =?utf-8?B?V0szcDVxWjNpRVpmamt0bmFWUkg0WGx1U01GRVFFSVhNZjV5aUVOeWovQyt5?=
 =?utf-8?B?S3B0SURQV2hWOTZ2QWVabnZCbzlmaUNSWWppaU4veXZGSkdJZWxFOE9TYWpN?=
 =?utf-8?B?OFhkcy80enArdWYxSzZZMCtGbTNweVJka1FPRzl6MzVvVXo4MkFGRlVhV053?=
 =?utf-8?B?d0REMWdXU2ZyWGs0eUtIM09QS3lFTUp5ejdTR2kxNlhETm5oc2M4dEZEaU5O?=
 =?utf-8?B?L1RpSlBpczhNVDNmVTRkN0FFdW9UZ0lqYnMreExzdXZxMmNZSkpRb1A5ck1r?=
 =?utf-8?B?eXpkbHFlRGdlaWJtSFVTK2dab3craGN2NDlsYitiZjVaVC9yazUrcERYZ2Vj?=
 =?utf-8?B?MVMvaStXNlJKVkt3dThCS0ljUEJGVjJ5ZmcrNjd0QkdNM1BlOUdhN3JRazlH?=
 =?utf-8?B?NWtiZjB2UUJWZFp1MktSOVJnY3Y5NWh4TzcyeVppY2RSTXJZZHZWbUViLy9X?=
 =?utf-8?B?ektwdmJ1T2oyVWlNYWVlSGZna3o4ajZnK3d4ZG1QUmZsZXhXMzhNcmdmQnhw?=
 =?utf-8?B?MjQrTzFubzBRSEdqQU01aVpkbEF6UGNMYlp5N1UzZ1VSL1M5OWt3UWJENlV0?=
 =?utf-8?B?R3dqajRCS05hZWdHbS9YSXBPYTZLeU9YZkJuREZOSm40dGZjYjMzb0kvYTVT?=
 =?utf-8?B?YlAxMW5FZEVDVWNnMDJjcFFJaG51ZFNWSmJTOFdWak1xQkZaVUc4UzJLVnBM?=
 =?utf-8?B?dEZlUXZWZzVOc0tPV0hKcGVjb3ZkcWdpSzVRd2JLUmQzbEhDVVlhOGo1bkhJ?=
 =?utf-8?B?K2ppTkl6VzJOT2pRTVdvaS80dG9McUUyL1JHaG1SUUY1NXI0NXlhQStDNEpK?=
 =?utf-8?B?WW5vM0p1dXRwSElXaHYxMm1rQ1Y5QXBTbk82S1hPSVluODM2SU1PcnZoWnFk?=
 =?utf-8?B?R2FJM2wzVm1rQ0VuM2V0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45562478F9897C41B9219FCA3ABB08F5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3a38bb-b5de-427b-132b-08d96c5f551d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 09:11:35.4388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZM41p1+36X2HoWUNaFiot1bsfswYRTL/YZ+sDlbr/MJeV8in5qHRNsS7TGZFNn1zjZr2C/YUWGCydiSnzN5oaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5869
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMzAsIDIwMjEgYXQgMDY6MDc6NTZQTSArMDgwMCwg546L6LSHIHdyb3RlOg0K
PiBCeSBjb21taXQgNTEwZDI1YzkyZWM0ICgibW0vaHdwb2lzb246IGRpc2FibGUgcGNwIGZvcg0K
PiBwYWdlX2hhbmRsZV9wb2lzb24oKSIpLCBfX3BhZ2VfaGFuZGxlX3BvaXNvbigpIHdhcw0KPiBp
bnRyb2R1Y2VkLCBhbmQgaWYgd2UgbWFyazoNCj4gDQo+IFJFVF9BID0gZGlzc29sdmVfZnJlZV9o
dWdlX3BhZ2UoKTsNCj4gUkVUX0IgPSB0YWtlX3BhZ2Vfb2ZmX2J1ZGR5KCk7DQo+IA0KPiB0aGVu
IF9fcGFnZV9oYW5kbGVfcG9pc29uIHdhcyBzdXBwb3NlZCB0byByZXR1cm4gVFJVRSBXaGVuDQo+
IFJFVF9BID09IDAgJiYgUkVUX0IgPT0gVFJVRQ0KPiANCj4gQnV0IHNpbmNlIGl0IGZhaWxlZCB0
byB0YWtlIGNhcmUgdGhlIGNhc2Ugd2hlbiBSRVRfQSBpcw0KPiAtRUJVU1kgb3IgLUVOT01FTSwg
YW5kIGp1c3QgcmV0dXJuIHRoZSByZXQgYXMgYSBib29sIHdoaWNoDQo+IGFjdHVhbGx5IGJlY29t
ZSBUUlVFLCBpdCBicmVhayB0aGUgb3JpZ2luYWwgbG9naWNhbC4NCg0Kcy9sb2dpY2FsL2xvZ2lj
LyA/DQoNCj4gDQo+IFRoZSBmb2xsb3dpbmcgcmVzdWx0IGlzIGEgaHVnZSBwYWdlIGluIGZyZWVs
aXN0IGJ1dCB3YXMNCj4gcmVmZXJlbmNlZCBhcyBwb2lzb25lZCwgYW5kIGxlYWQgaW50byB0aGUg
ZmluYWwgcGFuaWM6DQo+IA0KPiAgIGtlcm5lbCBCVUcgYXQgbW0vaW50ZXJuYWwuaDo5NSENCj4g
ICBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFNNUCBQVEkNCj4gICBza2lwLi4uDQo+ICAgUklQ
OiAwMDEwOnNldF9wYWdlX3JlZmNvdW50ZWQgbW0vaW50ZXJuYWwuaDo5NSBbaW5saW5lXQ0KPiAg
IFJJUDogMDAxMDpyZW1vdmVfaHVnZXRsYl9wYWdlKzB4MjNjLzB4MjQwIG1tL2h1Z2V0bGIuYzox
MzcxDQo+ICAgc2tpcC4uLg0KPiAgIENhbGwgVHJhY2U6DQo+ICAgIHJlbW92ZV9wb29sX2h1Z2Vf
cGFnZSsweGU0LzB4MTEwIG1tL2h1Z2V0bGIuYzoxODkyDQo+ICAgIHJldHVybl91bnVzZWRfc3Vy
cGx1c19wYWdlcysweDhkLzB4MTUwIG1tL2h1Z2V0bGIuYzoyMjcyDQo+ICAgIGh1Z2V0bGJfYWNj
dF9tZW1vcnkucGFydC45MSsweDUyNC8weDY5MCBtbS9odWdldGxiLmM6NDAxNw0KPiANCj4gVGhp
cyBwYXRjaCByZXBsYWNlICdib29sJyB3aXRoICdpbnQnIHRvIGhhbmRsZSBSRVRfQSBjb3JyZWN0
bHkuDQo+IA0KPiBSZXBvcnRlZC1ieTogQWJhY2kgPGFiYWNpQGxpbnV4LmFsaWJhYmEuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbmcgPHl1bi53YW5nQGxpbnV4LmFsaWJhYmEuY29t
Pg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoLCB0aGlzIGZpeCBpcyB0b3RhbGx5IHJpZ2h0Lg0KDQpB
Y2tlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCg0KQ291
bGQgeW91IGFkZCB0aGUgZm9sbG93aW5nIHRhZ3MsIHRvbz8NCg0KRml4ZXM6IDUxMGQyNWM5MmVj
NCAoIm1tL2h3cG9pc29uOiBkaXNhYmxlIHBjcCBmb3IgcGFnZV9oYW5kbGVfcG9pc29uKCkiKQ0K
Q2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDUuMTQNCg0KVGhhbmtzLA0KTmFveWEgSG9y
aWd1Y2hp
