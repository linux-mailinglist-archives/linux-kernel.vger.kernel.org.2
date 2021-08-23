Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B794C3F468A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbhHWIVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:21:45 -0400
Received: from mail-eopbgr1320080.outbound.protection.outlook.com ([40.107.132.80]:51840
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235316AbhHWIVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:21:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfx52usluhqVe4fMtpiQlhSe/49beZJ3/uIZ7h4N3V5tLUE0oLH/5AR+AepfWb27Zp/9eLyNHBAHOIxzJPVC+503biT1UR+tQcGUjRR7ZAh4RPWBsRsiKsFWwJBnyvrKP9i3NbPGiy9sVmQXrtCxswGfYKPphk5BL2LCIDQvEwnrjtYdM8wzB/SwqUgR9QloISI8eznChHQmTpZ8zdGBsFC0qZhNkM8JrfKuBTT+eVcjrNGquSo/6IuOCR+ZgHIZx0Bs0yRS3iqa5kz+fSSOKu8B0WKOAP4rTnUTCaUa8/lK1MPSoK88bh/d46Pa1QSLIvJoFe+ooY5M/zI0QLiBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pTXDFpb1N/Lm8Y1XITHnJShIV/m0CqLN0d5atCTRWo=;
 b=ntMS2s1roZPf/FtR7cp6adlfAVChNhQPGPg5teWmCJWKWKoQWxsGm56h/A+KdR6aY7wF+XtBzd0fuWfCFzBF9C7kNTot9zAyvsALPESkw15q4WsVhBwUfFKr5sONiuaH9H3r7NtTWM1/4i2uN8yhbE6FV3vzrgxhVZyYZzjBzTJvew+1gk5otJ5CoZEoPDAiKkPGk1uX3UP4d7rW0eTPqQpymcFFCBUKc1AieE03VDDelV05kJ3arlkfg3iJS/Y2zRGpNhdAYlY3cLCZX/4ximt6fZDz6mjb7AFjAqxQnphXlGStuqX1oMPjpdtn0YMTc7Wo6vmLfpXZKlH1S2rWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pTXDFpb1N/Lm8Y1XITHnJShIV/m0CqLN0d5atCTRWo=;
 b=LQeo1YFbqRNDQzG4pGp0Q98OqSaG98Ixir+dVO9TenRK9DARmaMPXXlSXaf/L4YKSfRG1e5G92TcYvdN3wF7HOTL10w14i0/c22mr8vWgp7bP4HdSJQTpxJ9lLXM6+AjcY/pMlYQ9Z5YsxZjo72c9bIZGhI+C0vJUanGNCYcMLI=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB4091.jpnprd01.prod.outlook.com (2603:1096:404:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 08:20:59 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 08:20:59 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "cgoldswo@codeaurora.org" <cgoldswo@codeaurora.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm/memory_hotplug: use helper zone_is_zone_device()
 to simplify the code
Thread-Topic: [PATCH 1/3] mm/memory_hotplug: use helper zone_is_zone_device()
 to simplify the code
Thread-Index: AQHXlnDvTF2Sty6d9UqZSU6Be6HEJ6uAwrcA
Date:   Mon, 23 Aug 2021 08:20:59 +0000
Message-ID: <20210823082058.GA1520304@hori.linux.bs1.fc.nec.co.jp>
References: <20210821094246.10149-1-linmiaohe@huawei.com>
 <20210821094246.10149-2-linmiaohe@huawei.com>
In-Reply-To: <20210821094246.10149-2-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22b56e50-472f-4f2c-8697-08d9660ef003
x-ms-traffictypediagnostic: TY2PR01MB4091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4091FCF2F5865202D14BB74EE7C49@TY2PR01MB4091.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V2SzmlXXUx5KD8rPqYpLJHi3OftV69EO1xj/s6Opf+grQ4UxiUcMDhSl16XageTdSrsaKIe0Vv1IKCMTkwxuRSC8bz/36qVkrGIH179C6sq/Biv7SxQxPfOQ4RA99lxASnDPQh8uAihRp5Cpi4V4Ntq+vxlGp4wpr7GAboK89DYWREyrT369vCcQO4Yh8IeNLl0nIuNg5rIiM58gz60ApnN7+Rh8E1X93p+jkVJ0lqL+zo2lb6QytNn63lWSGSiE2E14+LYZaTXJKsANXHNXAVqW5DtVQrvQZiYwN5u6gkuBt5m5Z7Wwm57/u3Al4G2lskRzAIoRXSLnm8gJsPEtjkuibHywkvgiqQ2W6BDWq3ruKIM1bGc2HI3G/xlfG2Q1S3ZRSbfp4jnUbqmex+mBtfy+NQ8+62yeziHfMR8ZclNmD6H5ueuEljvw2BPLZoP27iD7UF/YcfzD5lGRBj8L2MUU8Aobd+lY2A/izz3h56mS6vIAw/ADuwlHLZqoqSWOOADtommKSrgBBLsc6kTHLnS2rSnhJIeCUvGQkBocBzVArHsWOKPJ/t4v+1EOruoSInIul3Okou4I0AiEVrwbpNmhFl6t0QUK/kGLVdJZD2I51iVdVwTa6LAggxnxtBBwDk8OIz4W4fed/IsvaW0dHqkJHVIOpS7GJ9E0MITYPEJv/CE3W7cJMxJV/Sods6IGrbm1dH1Xo7XlW7DmrKJobw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(38070700005)(1076003)(6486002)(26005)(76116006)(2906002)(8936002)(508600001)(66946007)(85182001)(558084003)(5660300002)(66446008)(6512007)(9686003)(122000001)(55236004)(71200400001)(66476007)(66556008)(64756008)(8676002)(316002)(54906003)(6916009)(38100700002)(4326008)(186003)(33656002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZThyNEJLWnVKdklBdHJqeEhjdGxjVmFuUGw2YlN1U1dWNTRYam9pZ005NDg2?=
 =?utf-8?B?TlZuY2JoeUNQeWVGRUg5NlVRQldlWmsrbXVNdVp6azVWREtURUZ4TlBCdDFH?=
 =?utf-8?B?Zno1VU5ZcHloaVZrbUdQM2xrU1diNWNZN3o3N29WbEdPQlNWeEx4a1RIR1Ez?=
 =?utf-8?B?SS9jOENYYVFFN0lZNFNaVDMvamhWeXRWYjVSU0VrL2w1SEd5RXVEWm55c1lv?=
 =?utf-8?B?VDBYUVFRUWdRYTNWVm9DSU5yZ3p3dWFBUDQveVg0Z3hieDI2RTdyZ2pON2lz?=
 =?utf-8?B?OVkrTDllNk1iTVBLUlErOXdsS2xrVDE0L0FEQ1RhMk5WVTM5QWQ5OFlFei9n?=
 =?utf-8?B?anM4Z0ZqNkd4Yi9aWHNYQVZ1NnV5RU5rNkYxKzk0R01IQWxBUmdwdjk2eWNv?=
 =?utf-8?B?NFlwajhEWWpkaXZDQVJsc3JSa1ViNDVRbUI1V1FKTFU5b1lIYWU3Z0gyRlQr?=
 =?utf-8?B?ZjRKMXVsOExGL0V5ZUtrUWlQajlUS2xxUm9udkhDQ25KVmxDT0NQdVZHZ0Nq?=
 =?utf-8?B?eEdjUER4YVRpazNlMVBBdFpVZFptbS8reGxtY3d1TVJjZ1lIekhZN2lRRVNk?=
 =?utf-8?B?UVZhbVVlc1hzSHRZV0l2TFRhYnBBVkdZMjdYanJHaUhSK3NGYlJ3dW1Gb3dD?=
 =?utf-8?B?ZitnS3hMaU5SZTFZT0VPeitqeHlQZXhpSDhRT2NkMjFEdkJnMlNaN1N2ODBs?=
 =?utf-8?B?VjBkOXJuV0M4d3QzeHM2ak1GSEdDdFZlSml5ejBPRzNHRjlaaXIvM3dPUUI1?=
 =?utf-8?B?WU9qSUdxU1FXbWhvMkNvcjFHWnpvNElycVZJcElaSFF2UlhSc0loMmQ1QUQ3?=
 =?utf-8?B?WHlXa2tVM0dVMzFXY2pmK3o1NnVnVGxwdk5RTUZlVWkwSmlrZTRTaGhXS2Rw?=
 =?utf-8?B?VENWZkRKUFpPNkpNbzg2cnVzaFVQUTNsUlRVN3ppRFlQTTFRZmlBVzBiYlZm?=
 =?utf-8?B?U3Bjemo2WWc5UUxhSnJwdFRyTzVhUTlqLzIxOUU3OFBnS2FnUTBvcFI1YWdF?=
 =?utf-8?B?cENQcVk5clRZWklJVmZNSlJEOWJnSGZuVHU0RkJCRVh2Y0hBbGRhcHJJekd1?=
 =?utf-8?B?dXNkQkI5dkdPeU02YmNaVFRpbEJyM0dDeTh3NVQyd2FubzJQM2RtMXRERUkr?=
 =?utf-8?B?dHZNT3BkNUtOQVF1RU1TRkhUMysxTUF1NUhkM1hlaEIxME1INjFTNHZ3Q05T?=
 =?utf-8?B?LzJUQUZkYm4zOTZJRm54V2xBQWRzeVgvVmVkQWp2TmdMQ1pwK2dCdW12c2Qy?=
 =?utf-8?B?Lyt6Y0ltY3BkVGlnd1BZci9lY0Z0NmpNVjc4VVVFR3dOUHdySzJkRElEakRZ?=
 =?utf-8?B?VVU0UWsxaEQ3ZDRHSVVZbmJ6bHF2MU5WTXRDNzhTSkhSWCtqOGZiVisrYkU3?=
 =?utf-8?B?aUJnVXVzYXlqbG96NkZkQXlqZnRGQXdDWUw2YXp1T2dNS1hRTUlucnByTUtN?=
 =?utf-8?B?dm1hVmdHTk56NGFKTll1ZVlJSmd3QkJzZzdYRi93SFRjTnVDeDJ3R3l1UGk4?=
 =?utf-8?B?YXdFd1Rwekk5cW0zV0laZjRXS0taL0k1QnJBTXhvVkp4d09keWZvTGhzNzdo?=
 =?utf-8?B?TzBacGhpQ3d6c2Vpd1pvRXFSb3U4bTg4MnVpV29sYnNpaU9GS0hxckNDZCtu?=
 =?utf-8?B?eDVPMHJUd0hqWEp0dnRWdDhhZXZOUlNNQVJ1RkY0aUZjdU9TdGt2TURPZEtD?=
 =?utf-8?B?d2owTkY0ZGZiNFVSRnlucVlsTTloRVJpM3RxbTltNWdyWG1Penc0cEVVRU5B?=
 =?utf-8?B?eXo5ZlEzaEVaanNXOVNTMGtKc0lVVUJZTUh6OFdEeStUWklUdzdhZEI2Wlhy?=
 =?utf-8?B?WVc1Z2FneGR6OVFNc2g2UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD54014B5D8AF34395E9476D8626E3F5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b56e50-472f-4f2c-8697-08d9660ef003
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 08:20:59.1204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DujFB0IUheeHE2NY0spIXxM6J4lNMraTUnaI4eWj214wcUxqmU4Fm2FPgpYKqyzMHc2BvpMCO/e6OwV7Bx7Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBBdWcgMjEsIDIwMjEgYXQgMDU6NDI6NDRQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gVXNlIGhlbHBlciB6b25lX2lzX3pvbmVfZGV2aWNlKCkgdG8gc2ltcGxpZnkgdGhlIGNv
ZGUgYW5kIHJlbW92ZSBzb21lDQo+IGV4cGxpY2l0IENPTkZJR19aT05FX0RFVklDRSBjb2Rlcy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0K
DQpSZXZpZXdlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4=
