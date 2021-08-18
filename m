Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98F33EFE47
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhHRHyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:54:02 -0400
Received: from mail-eopbgr1310041.outbound.protection.outlook.com ([40.107.131.41]:13376
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237962AbhHRHxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:53:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiE7Db+d7PfPsBgu6yBLgRGxxUmX7/vBOsHAOSPiK0POd/rCTqh7mpNbSLp6b59RTzo7nWI/gG+H1eaUTnq+VEqtaWNNgRYqUqNaIFySuFrS5qckCMg+bx1+cRlY+1MQRng+zXfYgOSQvYbxOb+5BhJzg2yEiVFFpcK0C/l+I19c9zj/NBowNG+k+3QTMkyTfjGIn7jSLkBgDW2FwNFfaWqav+ZPg8W0lvI64sS1OTm1eQK45zw/KoqW5WA4v98tcnWLi6NWbngZU7O024iOFUpH6UQfLxPWDB3m6DRjP+cmLznqNzDm8D3pSOjhqkdlowoZIvma5bBpeeChUHw8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKgaskeUGrgEHZ0A6Fxxkbc2BI67LC3c7qWlwryuGdA=;
 b=OUaWIVbRMGzmLWo8hQjW+dl9yp+CpBORnqqrN6xifCTlmOtm2maeGwoAmnUut/oVhDJb8RgOlfVJtYffjNVMKkZeMouSQezZqe+A4J8qwXW4n8emCK6hHEzRnxlmGgZ45824NR+8cAfEI/J/okyX0gKmVil54z3t7/tPTQBbXVolxE5q1zA3ustv+kqeNfWer48crNj08PurjkN+Z6+/lwWrFfXWV6Rji76bidwP4mphR+lAQAc31IkTbbQh4X3ynCD4eue7c41HI4I+fFZyWnaVPUhrNo6dKsG1ctWhXvkm0oI8bJO60CxAtBfaO1Vv9OVBJkMyNVVteMwZmWDGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKgaskeUGrgEHZ0A6Fxxkbc2BI67LC3c7qWlwryuGdA=;
 b=TJ/qje73un2XMCOkWBuBm6PcRC83QHnmUOAqQrpQnV0vhdRfT0bl2Y1h4k8esTUi3BSFzVlmFwYOaWhngAR8kUyFINFyTWggqyLHSdUC7xTCZj2uEYtcCXkHUOm8/pSA3Ki2Q3M/JXmVpcv9k36nY2B3CjeY5zhcjne+VVb/W6E=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB3884.jpnprd01.prod.outlook.com (2603:1096:404:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 07:53:17 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 07:53:17 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Yang Shi <shy828301@gmail.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
Thread-Topic: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
Thread-Index: AQHXksnkh27YGKOdbE2zWLc64oMBYKt4z44AgAAO5oCAAAgsAA==
Date:   Wed, 18 Aug 2021 07:53:17 +0000
Message-ID: <20210818075316.GB501393@hori.linux.bs1.fc.nec.co.jp>
References: <20210816180909.3603-1-shy828301@gmail.com>
 <20210818063042.GA2310427@u2004>
 <dd225992-ec89-a911-b318-f4a91c70ed42@redhat.com>
In-Reply-To: <dd225992-ec89-a911-b318-f4a91c70ed42@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48c10b84-cad9-415a-9602-08d9621d3d74
x-ms-traffictypediagnostic: TY2PR01MB3884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB3884444EA3F48E5F5C4E1D19E7FF9@TY2PR01MB3884.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DphnKKKV9ap7jFtH+Q0ukm2W24jWLyggD3v0j+d2mZLDNVk1yZxngSGOAb1vFqLLr/LnK+3tYwq1CZRQzVJs9oYqbfofhagwBXwx2PUO2RNal9HIkVvyGvL+B6DMBoajz0pz0mVaRixmGovlJxSlCXaO53EnvjAJcONkgxdEmIhNd0UWe6U0lZUjJqtf2G4q8yyNvwEMxfSARvM0xzJpCc2z8vYcZZz150T8Ol/JFlSaurtTjIjWSQiMBNxGJS0sR5GXsH89kHXuvcYEclYQHgf24+SM0tQ/irBk2hNd1Te29rv7XueMGIa0uFpvIyb2yrMYNl+o1zDy1FTTctRLJLlsT9h2xJQS8LImaejrFxRtv5hSAk4glZWPhAIG2Z5/KAGKLEz19bi4RJVPhKsbR7wePCBVfq3KTQB3BiIBmcTYYjGBvv6++jv1tc1NU4qLzbR70nh0vURKfyi9l98mW39w/qoqToMNydJWVHJs1aLRyjiBGnfzR5/jAccXFKNWBzR0BjmWR2MJAd0yvEJD6TPeyCOEvsUgYjronWLmMk0mNjDyCXDwUj8HYiFhSdrcREcmzJsAuWkR4ynHtk5U8hK5oZfTmbGRrcurwWk1OlDlaZy2j7J6p9vBKTzBe8AyPsQNk2PjI9PjoNiVarbgxuyhTaDi1SaRqyNPpcsVM4De0PbXTca7/pyZ8X+ZwXjRRCltLbbaHSdd/n7TAO8/bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(316002)(1076003)(85182001)(66446008)(76116006)(64756008)(4326008)(66946007)(4744005)(66556008)(54906003)(6506007)(9686003)(66476007)(38070700005)(8676002)(55236004)(86362001)(38100700002)(26005)(122000001)(6916009)(8936002)(2906002)(6512007)(71200400001)(83380400001)(33656002)(186003)(6486002)(5660300002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW1BOVVBcWF2WnJGdWJIaHNkc0NBWTZ3bGt4TVN1TzVvRDFxQzhNcFhHVGcr?=
 =?utf-8?B?Q2RTeVdUbFRIK0xaN05POURBSHUzUFFKV3Y5bTgrUm10cVp1L2cyTTJ5ZnZI?=
 =?utf-8?B?a0JzZm9abnF0RnRnMnZsbFlRMXUzdDl1WVVmV1hTb0FFbG1vK0FMcnVKeUN5?=
 =?utf-8?B?TG04a0QybTdyT3FRc3hHNlI3Yzc0Sk1RQkJ1R01GVFVMdUZSUi8zYlFvVzky?=
 =?utf-8?B?OUc5QkNwV3BTVnB6MzBOa1JIY2hjeEtIbDJEbk43MEtNUXZmdTlmWWdDYXcv?=
 =?utf-8?B?TVlrVStIRmVtNG9vZGxVSDBTV0FnaDdRdVpOZEcxbjRyTlBEUnQrazN0U3NQ?=
 =?utf-8?B?bGVlc0tDbzBMR0E5N2RVYUtOMTRoSjM5eWxBck8vYWoxMEl3MUhRb0hGSklJ?=
 =?utf-8?B?STFCMlpJOElKdHVpRTZXRzEwdDN5QTNDRFQ2cUtHcVl5OU5HTC9Jak9PUzJw?=
 =?utf-8?B?N1FaalZSN2pWcW5DOWFFNzdzUHRIaVl2Nng5WStaMU9zRnRiYis2WVZFUFVh?=
 =?utf-8?B?RVV2a2F1SmdWa0VEL2lIallrV1FRWExNVWJmZmFuY1JQQ0JMTndHekJlK1JW?=
 =?utf-8?B?eUhXbFBSR3VmOEQxd0RSVnBEUUcySkhiQVZ2TXVkRDlhbG5iUDVjYmtFQ3Bu?=
 =?utf-8?B?UUsyRU1yTjBPVUdoRWY2T0hLeFhPSjlmbmt2SFJJUVozZ3BjaTdXdUZZdi9R?=
 =?utf-8?B?TE9JOGUyQWdZeXJiaWlkaTZGMVFLRGdyMUllL1NiSzNpenQvUjRDZWVib3FZ?=
 =?utf-8?B?RldBL2xia0VFWjF5TUZpN0FJbWJtQThUVXhPZzYrSmt4TW12YlEwa0NYUndy?=
 =?utf-8?B?TXRIZ09IOWhmU2VZMzRtc3NkQ0s0ZlY5ekh6RnhaUDBpZTl1alJKMUdSR09y?=
 =?utf-8?B?cUVYZkR5Ym5wSkN6Sm12WTRhbVplQ2dHZ1JTdU9sTlRCNCtKOVE0ZUZDM0Jy?=
 =?utf-8?B?d1Nod29WbTJhZnRTU0M1aDA2T1JUSWNUblc5R0VBRHVwOEVHNVZwN0pNUldE?=
 =?utf-8?B?RG5vOTZONFk5akc5M0tkaU9JQmlXamRyVlVTY1V3N1VyOENSOWRBSUw0bDZI?=
 =?utf-8?B?MDVIV2lLTUhubUhHdDBnMmdwVTBMWUt1TGY4UVVxeVlaamliNkxnc2JNVlNs?=
 =?utf-8?B?YTFuNHhFa3BKVFF6WFd3YllhNnZkU3NkTlZmVytFTU9zRjdaN3lxK2J4cnFy?=
 =?utf-8?B?MWJLQy94aWk4NDZ0MjVaeTNCYXRhK3FFVDN2NWdIOEhMY3I1WVpRLzVGTDhw?=
 =?utf-8?B?aC9scjZCVitUZGltUkdIMEkyMXJHRWEvVzFCU2dKNWhncDB0NzRVVHFsR3c0?=
 =?utf-8?B?VDBSQW9ZRjk5UkdqRlVmUHlRVk9sZE9WMUNsUStMdEFxaHVUMldFYkRwSEJD?=
 =?utf-8?B?SUg4c1ZKd3hrUFZQdGFPZzc2VDZxUmZjOHRtUUlJbDZSaWJVZUhudmxTOGJN?=
 =?utf-8?B?Q3FnWlpqeGxHTG1HSGZ0amVvdlJVcmp3K1FrVXcydW83S2JGZjZHVEpPU0FH?=
 =?utf-8?B?eGhzSWhqajBnSHU3dVFtN1hERCtEOXV6RlNvL2M0QXVaWHB4clZiam1ZeUVP?=
 =?utf-8?B?UlAyMllwMkg5T1VvS1F6bFJNRURmV3dUT3Y0WkpsLzRtZ0JrSG9EWXZLUVV1?=
 =?utf-8?B?NitEeDZKQkQrZE40b2VNbG5mYVpOZ1JLWTNveEM4MEptTm5PeWhFWEJ0c3A2?=
 =?utf-8?B?MlRoRVR6MitGYU5DeXRQQ0FMS250WjVGTUp3ZXowUDVyK2ZSSDY5blYvL3lI?=
 =?utf-8?B?R2NUV09oYVVzYlhCdkkzNlFhV0J0UXlNWGJOVkhYT0p0SWFyb3FjWG50MG1C?=
 =?utf-8?B?VXZVT2Q4WHB4bUIwZGdDUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5DDE0030F10C8438B96AC8EC8A04ED5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c10b84-cad9-415a-9602-08d9621d3d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 07:53:17.2631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zuzqF4UXWpXWgo3Xea1pfC+2jmkEfOfC8RoFbn2OZxlcJeOWszG3Kh0AJXeDghbZkYzvVaNuJjLd0ZMYDXm2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3884
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMTgsIDIwMjEgYXQgMDk6MjQ6MDFBTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQouLi4NCj4gDQo+IE1pZ2h0IHdlIHdhbnQgdG8gYWRkIGEgVE9ETyBpbiB0aGUg
Y29kZT8gV2UgaGF2ZSBhIHNpbWlsYXIgb25lIGluDQo+IG1tL3BhZ2VfaXNvbGF0aW9uLmM6c2V0
X21pZ3JhdGV0eXBlX2lzb2xhdGUoKSBhbmQgaXQncyBjZXJ0YWlubHkgYSByZW1pbmRlcg0KPiB0
aGF0IHNvbWV0aGluZyBvZiB2YWx1ZSBpcyBtaXNzaW5nLg0KDQpZZXMsIHRoYXQgd2lsbCBiZSBo
ZWxwZnVsLiAgVGhlIGJlbG93J3Mgd2hhdCdzIGluIG15IG1pbmQsIGJ1dCBpZiBzb21lb25lDQpo
YXMgYmV0dGVyIGlkZWEsIHRoYXQncyBmaW5lLg0KDQpAQCAtMjk2LDExICsyOTYsOSBAQCB2b2lk
IHNoYWtlX3BhZ2Uoc3RydWN0IHBhZ2UgKnAsIGludCBhY2Nlc3MpDQogCX0NCiAJDQogCS8qDQot
CSAqIE9ubHkgY2FsbCBzaHJpbmtfbm9kZV9zbGFicyBoZXJlICh3aGljaCB3b3VsZCBhbHNvIHNo
cmluaw0KLQkgKiBvdGhlciBjYWNoZXMpIGlmIGFjY2VzcyBpcyBub3QgcG90ZW50aWFsbHkgZmF0
YWwuDQorCSAqIFRPRE86IENvdWxkIHNocmluayBzbGFiIGNhY2hlcyBoZXJlIGlmIGEgbGlnaHR3
ZWlnaHQgcmFuZ2UtYmFzZWQNCisJICogc2hyaW5rZXIgd2lsbCBiZSBhdmFpbGFibGUuDQogCSAq
Lw0KLQlpZiAoYWNjZXNzKQ0KLQkJZHJvcF9zbGFiX25vZGUocGFnZV90b19uaWQocCkpOw0KIH0N
CiBFWFBPUlRfU1lNQk9MX0dQTChzaGFrZV9wYWdlKTsNCg0KDQotIE5hb3lhIEhvcmlndWNoaQ==
