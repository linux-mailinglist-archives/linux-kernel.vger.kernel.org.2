Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB913EF62C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 01:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhHQXhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 19:37:46 -0400
Received: from mail-eopbgr1310078.outbound.protection.outlook.com ([40.107.131.78]:60057
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229466AbhHQXhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 19:37:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx3mWN/YliRSvo3iZ1gHXphQ+Zs2U5pXSFn7q6A+ZcE2M+/WGPoxdfvjAH90h6Gwm2pLCEyQsyebeA2Mub1teJeFQAE/3TxBqMUpMqTSpULkP4YJ1/hpv/iksYkKwD+udIrSasmCgynETbx+CIKetJW3rHz6IPIlfmsn1DJ1aATKpe5tncAXhHJHz2xNMw1+AxBVHZ3QK5/BfpB8pcoNBWiaK4hrLMBtNVPfWLJbLeOD+4+1QbLaKiz0UmZgmE7q+pWOkNc150pkUW1x3bZ7C+qCQ/GYBUI/qX/2cOGC2AKTd4cAPCfZq8keHBcPDRCozYLeH4sqk9ZqD8RQFtV2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx9mbdPe+DcPb5O8E024IyXlFhk5/0oCbaMcZoh+PLs=;
 b=PP4bwiajLV//ISr4IWbsYqKku8TK8DCLvzIE3RAULjzgkasqqsk7N6VxceRPjP2yPvy6nPmNiSbi3ghp3hGoC466IYKU20MnGFpI4KpvuIbRgRaycRJUQY21O5Olv9pPfCnCRxQ453h5vEEoyYwyxwOnbgr6s8t1Rqyom7mQeWJpuiFxVf9w7EMNuNINNuu2Ro0h4FYD4MUJeVUBeAoE/H5Yxx7z0rxxVPet654viBvyN1e8nrkng14W+lO9sgvd0/HdDqH4nMtTipS+rSw7JVsxOO5G2ZNQze7jVkG4uTniO5tmd3nBkXk+K8VsoNP/CuedOCKCbJIVZ17uHqrIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx9mbdPe+DcPb5O8E024IyXlFhk5/0oCbaMcZoh+PLs=;
 b=avrrYrCT038D1olBSAvY197oUfYHhXgJRCsRBgMTSCuA8WLWV+nlezGfSKV9j5U0Jhn8XNTMlmX1/3HS1IulyEsOZjOCS9GO326IO3T3ysP4H2vMU0NSwJLbuwvExnpIoBJUduqowBymlHdidByLdEl34aheLTHYfdW0PononoY=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB3882.jpnprd01.prod.outlook.com (2603:1096:404:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Tue, 17 Aug
 2021 23:37:01 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 23:37:01 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] mm/hwpoison: fix potential pte_unmap_unlock pte error
Thread-Topic: [PATCH 2/4] mm/hwpoison: fix potential pte_unmap_unlock pte
 error
Thread-Index: AQHXkPpfFGXqAXhUhE+s+6RCLjYWAqt3USMAgAAPkYCAAP7kgA==
Date:   Tue, 17 Aug 2021 23:37:01 +0000
Message-ID: <20210817233701.GA485476@hori.linux.bs1.fc.nec.co.jp>
References: <20210814105131.48814-1-linmiaohe@huawei.com>
 <20210814105131.48814-3-linmiaohe@huawei.com>
 <20210817072900.GA452155@hori.linux.bs1.fc.nec.co.jp>
 <4b0a5fcd-0b1b-6198-b6a7-d9cab5b9fae2@huawei.com>
In-Reply-To: <4b0a5fcd-0b1b-6198-b6a7-d9cab5b9fae2@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37d787e0-19a2-4524-0e9f-08d961d7e9b4
x-ms-traffictypediagnostic: TY2PR01MB3882:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB388236D5E48F1E6EED4F2755E7FE9@TY2PR01MB3882.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8DyoGhIEgEqULyBDZfYFHLgSZnIJTbjq4WMTMsiEresq8qHPPTENfad4BiSPZjGucZUtWoW9/mSPhPuP15c9DCWaiuIyVNWkAhQod54ftFKRjoTOic4wzeD3Pn0BM8Ld20sVeEgl0yYo/X5mVxy8u/McOT4yPLyHB3kHrJB+0hn6R20DT5jPBNchV4kcus218YrQ3kwF5cJxGmcHGBLX+ODFkuvOjBg2/wN/S/S4IoO2W0zz4YnhTNFFtj/m0M/0VO/plQgZz/X4uAyPp6ATgPHlVd7TCjlcKHeuJD2ILOU+qcZJLm/5evmnPlLrP0BwtJQ61PRDncAVz0oVkCedCnIGhsSkjYuUHxo0enqCnRrqN5Sl967/kjqnqzeWSRJOlKuAnFEQNwEE/FoTOmk5+h2gVDlhrbYwlgDGloF5N3uJIZrY/DygkKwTO6i3uLDMp45UIDydoeUw774Xs2P+LV96ZxYvQcKH+64swAx942vzxJI3q7s6s82sKuCauE58HGPw5EaWV8701I0PPgZIqodhjbOe/uwEfFeCceAU6LFlG36Xj1fWUEnbr4VDk0rIhyRQJhTflzbmKpfK+AjR0gw214xEwn92pR6WHgqznXWH8mf3c6A8FBUaZDJHc/oJpmLf4bAIK7lBG90TqttmkTawT5rk0UBD55LDAE2ZO/YG89iVLr6br7Eyqm/E+3FYPg34X1fRjkUB30kznCwkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4326008)(6916009)(508600001)(1076003)(316002)(186003)(6512007)(4744005)(64756008)(26005)(9686003)(71200400001)(6506007)(54906003)(53546011)(76116006)(55236004)(6486002)(66446008)(66476007)(33656002)(66556008)(66946007)(2906002)(83380400001)(8936002)(85182001)(8676002)(122000001)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmFLelVWTDIrczUrMjJaMFJOcERMSVM5bm9GcG5qS3g2Rk1QVVFHb1J2aDJ2?=
 =?utf-8?B?Tm5OSVIxTGdwTzBLa3UzdXoyNkhsQkZsdCtJMzVxeHFDdzhUUkQvb1VYUTF2?=
 =?utf-8?B?T0NxTHZRdExQOVV0bW5NM250eDhyYmFoREMya0x6a0xBY3pTUDJDYXNOcGlu?=
 =?utf-8?B?a1ZPcXd2RDhRSHNzamg3MFZrQUJBQlV3WTVzUWp0c0srb3hVd3NLVnVuWVRI?=
 =?utf-8?B?dmh5L3c2enlKcFBPRGt1YnhYTE5HenlrVktiekJLTnk1T1dhaGdWWC82UHNa?=
 =?utf-8?B?bjB6TkhreC83NGFmMVdlZGlKSFZIcE5hb2RSS0ZqRElDdm52SG1MRDl0bVU4?=
 =?utf-8?B?SEFQMmFCVmliWnp5YW10TCtmNEpsUXdQMGRINnRWUHhLMzkyZSswYUVzQnlS?=
 =?utf-8?B?S1FRaEhKdXl4UmQvTUZYdG9MdFJIZzREbVd3SEJyNzUvS0lXZkQzRW5JdkYv?=
 =?utf-8?B?STM1ZFIvZFZLTU9OL2UrQ2c2TW9HQ3lQaTFDbzR2T3JQVTFFajVncE4xSDFi?=
 =?utf-8?B?RndQWmpLUUMwVWxQNFZzRnVJd0srNkxXdW90S0dYQitjQ1hRQnJjYnRWMXlN?=
 =?utf-8?B?TDFTWEltSGlmUnRRdjhzVGI0c29XKzJJQ3k1OEV6bDE4RU0rWFA4RkRVbFVS?=
 =?utf-8?B?SXI5Rmc4cWpmN1VleW9YOWcrellJYXU2NHNnbzR4RjRRNDlnN2tMd2U0QXNS?=
 =?utf-8?B?aE56cmNvV3VVSkVnbXNObll1SWdOS2REL3VhUy9jNVZ6NkxLOG9HcFpwOStZ?=
 =?utf-8?B?ZGRSdVNRVHNXekU0aGpZWTZQVGV1RjBtc0R5RHptdWZQZGU4ZzdwK2hpczJ1?=
 =?utf-8?B?bW1GZnhmcksxTFFpaTB6R3lWa2pGRFgvTytWeHBIWWdTMTFFakl6bGZOc1dO?=
 =?utf-8?B?ZUExeUN0NlVWQVRFT2JybFRkaVNocWtBQ0VFMHFvRkdFOGMwR2tDajhaU3d6?=
 =?utf-8?B?aEF0NnZEMFFVTEhyV3R4T0pJakk5NTNUZU9STFQ4QVVmdGNYekdqTEdvdlMz?=
 =?utf-8?B?UEI0M3g0QjYrZE40NjkydW5KOHpTd0ovR2FiNHh3QXpKckhpNmg1Y0xJdEtY?=
 =?utf-8?B?K3poZ01BT2xBS3JqUjhabktwWURmYnFkYWkvMnRwanNKSWl6ZDZvT09ZMVRF?=
 =?utf-8?B?VkNwK2hQZ3A1UlV0MkttRGZwYmhlOVhNalNNSndYdFFWMnlySThaVDgxTUhy?=
 =?utf-8?B?K1h6MzJGQUh5UTR0UkpMNnJocnltWU04RFJueEEzWHZFczBSZ2J0K05XK1Av?=
 =?utf-8?B?Q3o4TFpHaStLdzgrTmFiSFBHRCtwMUVWakJCLzdhcGJxT1BjaUhDaUZNTzFs?=
 =?utf-8?B?aGloVG1NeHlwL25EU1duWGVDTGlyVXpVVmlEVGZMdjc3ZlUxWFlPMVdPbllY?=
 =?utf-8?B?M2VmVUpjU0pUQll5NklBa0R2N01BSHhrOGtyR0owb3BRQ1hxaTUwaTJacnZj?=
 =?utf-8?B?Tm1jRGFWV3NFeWNTWEtKb0VUSGNra21GRWw4QnVmMEowb29ma3RkUDBBcEkx?=
 =?utf-8?B?elJ6aGhrOFJsN1Y1blJwRk1FeGN1L0xsSVJtQWg0c2luQzRuMkNwRlBjVXZK?=
 =?utf-8?B?SzdMMUltUHZ6aVRmTkZFVmFHa3ZWa3lKcnZVZmNUVEozcTF6Y3dmSit3SVU1?=
 =?utf-8?B?OFJNRi9ZbmJ3SHozK0hEcXJYeVZWTXVmRDRycTdIUE50OTE2REkrWGxWRDA5?=
 =?utf-8?B?NTEwdGx3SXVQeHpUOHZ4Vjk1VkJVYWh2aEoyZ1NWKzBXRXo2aXAycnZWbVA4?=
 =?utf-8?B?TDA3aUh6Tyt2TnpVVkVJQzl1MXNWUHRmUTBSdGN2UlJHcUNFQWRXdUgzSGNE?=
 =?utf-8?B?QTUwSEtlMmFWY1NrWEFBQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <801EECCD6350CB46BAC719CA753255B7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d787e0-19a2-4524-0e9f-08d961d7e9b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 23:37:01.5950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UN+bFiA4MnGvruVek1cqnIZyArSgGo3mWaB9JWdh/KIdgsg8pnS2gVDvkMTi7xPYR6l4AtIeXvCMpEgnKmjtmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3882
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMDQ6MjQ6NDNQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMS84LzE3IDE1OjI5LCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykg
d3JvdGU6DQouLi4NCj4gPiBPbmUgcXVlc3Rpb24gaXMgdGhhdCBhY2NvcmRpbmcgdG8gImdyZXAg
LXIgcHRlX3VubWFwX3VubG9jayAuIiBjb21tYW5kIG92ZXINCj4gPiB3aG9sZSBrZXJuZWwgc291
cmNlIGNvZGUsIHB0ZV91bm1hcF91bmxvY2soKSBpcyBjYWxsZWQgd2l0aCAicHRlcCAtIDEiIGlu
IHNvbWUgcGxhY2VzLg0KPiA+IEkgdGhpbmsgdGhhdCBub25lIG9mIHRoZW0gc2VlbXMgdG8gaGF2
ZSAiYnJlYWsgaW4gZm9yIGxvb3AiIGluIGxvY2tlZCBwZXJpb2QsDQo+ID4gc28gdGhlIHNhbWUg
cHJvYmxlbSBkb2VzIG5vdCBvY2N1ciB0aGVyZS4gIEJ1dCBJJ20gc3RpbGwgbm90IHN1cmUgd2h5
IHNvbWUgcGxhY2UNCj4gPiBjYWxsIHdpdGggInB0ZXAgLSAxIiBhbmQgdGhlIG90aGVycyBjYWxs
IHdpdGggcHRlIHJldHVybmVkIGJ5IHB0ZV9vZmZzZXRfbWFwX2xvY2soKS4NCj4gDQo+IElNTyBw
dGVfdW5tYXBfdW5sb2NrKCkgd29ya3MgYXMgbG9uZyBhcyB0aGUgcGFzc2VkIGluIHB0ZSBiZWxv
bmdzIHRvIHRoZSBzYW1lIHBhZ2UgcmV0dXJuZWQNCj4gZnJvbSBwdGVfb2Zmc2V0X21hcF9sb2Nr
KCkuIEkgaGF2ZSBmaXhlZCBzb21lIHNpbWlsYXIgcGxhY2Ugd2hlcmUgcHRlX3VubWFwX3VubG9j
aygpIGlzIGNhbGxlZA0KPiB3aXRoIHdyb25nICJwdGVwIC0gMSIgd2hlbiBJIHdhcyBsZWFybmlu
ZyB0aGUgcmVsYXRlZCBtbSBjb2RlLg0KDQpHcmVhdCwgdGhhbmtzIGZvciBjbGFyaWZpY2F0aW9u
Lg0KDQotIE5hb3lh
