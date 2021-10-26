Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C581B43B7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhJZQzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:55:41 -0400
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:44961
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236279AbhJZQz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:55:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW4mq6XiON2fsMa6xUE64bsjyjaJrmyeRppfg4v1sWD2h/K5Sypcn+ZTcITqDRjVNqCvBuBxvXwmey+koi5eJoloWbjK7sO0dKzRfUMvYB40DlTH5wj1ujlI9Fr62Ij9HV9NesrswJQNwMDf5GOIf6SYgg3IBxFOKUiPztUc37eioe4FfNCbUHS3mPUViYFVYEnK+IEWTa9EOSy5zlQ/vJ8+8Zqu9TtLlGaX1Ovt/50gVR+VA0/mWmnYCtDbZGSK/5Rnzyu4NVphfayjpAknpoM5u8+hA33Y0H59Cq0PwpcM88WbJPbr+dO256x1BBgFtH16AtUsdIG0j1fADnuwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JGk9cq+H3Pl1dHysFHhd3U//mUm4a9kitiEZOjgBe4=;
 b=izYo5HSp4YT/YbGWa88+RAlB8y7+aY0xhQ8/Yoo2pQLwohXgu/uGKR8f2GtASLTT6EABq2Yio4wc9+lBMSaaGpXfFMgT1p5li6QDsnqDzJ0S2XAAeN/aoLepRSqTyL1WQx6aIAo23su6zfNAK0g/zMSC5v4Sn1AnDFwEhF/32eHYGupwFrWe5EQY23N5MMwJA1EbQBJgWZfjhZGZZZrtef9VQrMe8K9pWLUrZemR0HYvaQDIZDDsKGbBJnyvUrpiQ2ozR1gwBP/Lx3nlAaReZ65OfajKco52Is3uQlCWrXaaLmV2G8BWhHYCpiylhjOh9A1nxS9C7e9P4SotGK5gaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JGk9cq+H3Pl1dHysFHhd3U//mUm4a9kitiEZOjgBe4=;
 b=wweX1//iK+WhSm/57KOtsvMoQ0GJicKn1Dwp4JfyJ62yEmeFl+eNTqEm6r00ww4zrRq44KvE//hifF6SaE/uH76/9KovMQ8rF9STEVTnInHmaJ5ybcjAKCRyCM7KEXkKuTAi4wZlCbCKmoO8G9c4Hch8WRMrlwY52yxldqa8uwA=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB4006.namprd05.prod.outlook.com (2603:10b6:a02:89::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Tue, 26 Oct
 2021 16:53:02 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::fd9a:e92c:5d9e:9f6d]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::fd9a:e92c:5d9e:9f6d%9]) with mapi id 15.20.4649.014; Tue, 26 Oct 2021
 16:53:02 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/5] mm: avoid unnecessary flush on change_huge_pmd()
Thread-Topic: [PATCH v2 2/5] mm: avoid unnecessary flush on change_huge_pmd()
Thread-Index: AQHXyoPdr2060q99kU260UDK4yiy6KvlfWsA
Date:   Tue, 26 Oct 2021 16:53:02 +0000
Message-ID: <E38AEB97-DE1B-4C91-A959-132EC24812AE@vmware.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-3-namit@vmware.com>
 <c415820a-aebb-265c-7f47-e048ee429102@intel.com>
In-Reply-To: <c415820a-aebb-265c-7f47-e048ee429102@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e622b66-149e-499b-4db1-08d998a112fe
x-ms-traffictypediagnostic: BYAPR05MB4006:
x-microsoft-antispam-prvs: <BYAPR05MB4006FDDFD4DC0BEB098654E3D0849@BYAPR05MB4006.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ecku0ZRy4JQ8+mLEMSrE9UkfrbrFr0KH5xKi2roSazeCXBY0wqd6XoowVl9/tW5Dp+04mr0YW88h93DmCZ9bf4BSzzKKHtvYrz7ajYXX440/vIL5UXQ1bNN1zRhevIj5zqMgA+faO+3Px4ONjfDXNgRTNmd3Pk3Mne11O+kECxVRR50xilC5iRk0OgQhe5in3Nod0+VBpX2snFi9mB9LEabqWZ7PEqSsP2THZ6ETRR6AHCvkBK3BFso2nHoRZ9i3ftAypaxp6RZqD1KewDidSi7WhapKpy6HZ7VGnf4u7PpHZFVzBJFxnkygEdHHLaxIWvOT+u5TggVIzwcmhOYFwAnm8Uva0QYBw0mskr5Siumb1VOXoM8YuMuNv9qHEt03pL59dIOw5J8MZ3k6aVnVydxDcn0Soj/aV2mwfUiKU6Q+JXfkCA1XaaQLFcm7WhbpzCb8Jvkd5nDJzaXcFaH/IZtvgmCfhqPBYjn8JXF6v1DtVvcEUOegWx1ezLla3OjfT4DHeGbkwAgnkGg6NeveqavNyBNxTy1a/1DHX10D23G0zQsmpLHz0T9rQb9mZPHqUIK39DOz2eaDy+lW9YYhDx6wWtE3bNCburROikwCdsNNKeM38Z8wykYs9SYER3IMWmJ+mZku4NprayYMEBZGT12ZKHsbDRZgy70eKjr6+oyMi7MdiG/Sza7jS1CfSsQfLisYOsWM308x6Z4nEylLd1henC45hCe3N8ymtBFTEHUpVRGDd1Zg27Kat7NtNkW4vS2d/8zz69rWAMl6VMGWsWAhCvks9clgHFE90MxJ952DidOWUazlvhRODuArql9b+eBaoAefOSLaU3BZORJvLirRyRCWGgyVR4uuCIpl4hc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(53546011)(86362001)(54906003)(7416002)(66446008)(26005)(122000001)(6512007)(5660300002)(8676002)(36756003)(83380400001)(8936002)(4326008)(38100700002)(316002)(45080400002)(6486002)(38070700005)(71200400001)(6916009)(186003)(76116006)(966005)(66476007)(508600001)(33656002)(66946007)(64756008)(66556008)(2906002)(2616005)(14583001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VCtBYUUzamtWQUx5WXp4NFVYaEhVdEN4bUJKdHZCZm1jUmxFS2xxUTU2dWNj?=
 =?utf-8?B?anpwbU1oYVlhTkxhWm0vdlFjYmxpVkFYdkl0MmVGRWFiZ2lxb0dVOXpaZDVQ?=
 =?utf-8?B?dzRkUUJ5R0t6V1R3bG04TFBGOXF1UExOeGJrWjJyOUpMaXpUSUhpUFl3NGNh?=
 =?utf-8?B?anVhRmg4TDhxcXh4M1A1ME5YTmc3VjZqTk5hMFFLOVFtUitaMWpCMVg4Y3dK?=
 =?utf-8?B?cGtzbjFNdmJ4d2owSGF6Mkt6eFdyMk1zT2U0SzFEWHZTWDZhN1poT2I5Wmdr?=
 =?utf-8?B?ZVdDUGIzVzVRbEkyRlJxYkJ2KzlNK0lXMENtcGRhN25XR2tHSkprb21zemx0?=
 =?utf-8?B?YVdvS3FqcmJPSC9nb0FzbXlwN1BpZVNEemorTDYyb3FaNzRsTmlzVmNhRDdC?=
 =?utf-8?B?ZC9BR0Rnc0Y1VERDQlhWYTl5MTNFZjdhN3BmS3lXZks0T0cxeUVhTEsxZFRP?=
 =?utf-8?B?aE1QK3k3ajdndkwrSk5kQVVWcFdPS3FIbjZMY1ZLTVRtQk0xcmZ4ZVoxWGta?=
 =?utf-8?B?U2ZmTGE1bVBnNFdudGpDeVlHM1dkWk5VcW9udlVYRGRTc1hQU3lFc0MyTDBs?=
 =?utf-8?B?cUs4VjAveGNCMXo2SjRKcE9MTit2L3JsZHNzYkdJRFpQclh1bkIyMXlCb1gz?=
 =?utf-8?B?TTlvN01tYm15VGxKN2w2WHpoeFZIcDUyN3FzMTlxay92TlA4Y200eFd1dSti?=
 =?utf-8?B?OHZ4Rk51RFNCb1pWRTFFQWpCNWFzTDkwNkJmT0JmZ3YyZGtsRXV2Q2FHRnVn?=
 =?utf-8?B?d3JEYTZ4R1FaSGFXaWhXWmlhS2VzeW9NRkxWU3F3L2ZrOGJkSVM2S1RlMXhB?=
 =?utf-8?B?eG1uc05tTnFIbFd5N2xIV1E2TXZuc0loMEN4WWpOcXFjL1E2N3YvV1RYbUxV?=
 =?utf-8?B?SC9ZazNHcHFrZHlLQ1MyMlkvMWVzclRtSklMQTlUajFiakVaRjIxTVJEVldT?=
 =?utf-8?B?NUFrMHJvKytYNmx4OVUyTWFsWmdOR3p5T3lEd0tCMmFuR3grS2h2K0xmakNq?=
 =?utf-8?B?dGhHeEh5bEgxQUVLTGgrU2xtbHIzZDhaREFrWGZPbmJsU0srYjNwZmpKcEpG?=
 =?utf-8?B?NXZNdzh2cDh4QXA5RHZ2QlFiMVlVZk14VkdBL0NPNXorclIvM096Tlpqc0Vm?=
 =?utf-8?B?M3NkNHRDQVB3SHZ1L1NkOUhhZ1UyNEl6OTVaN08zaTJrZ2Q1eFdrcWtuM25T?=
 =?utf-8?B?b0prQkVrTW1sbm5DWExKenpWMk1RNlJZUU96YnlJTmxaM1FzY1gwSFQyUWNQ?=
 =?utf-8?B?Z3RyaEdBNzJjWHEyQnYzZ1FCa3NMU2I0WFZlbHFyeTVCN1hXZ3BXY3BjTnA0?=
 =?utf-8?B?VTNDZGVha3hwUDR6RTFtM3UzM3pwRHhsV3ExZmg2T3Z4M20wdVY1RFpNYjZZ?=
 =?utf-8?B?d0JwWkxEZDBaS2hwWURPOHk5S3pTczFPQjY1UVorSFAwVVplZ3lIblNZVlhC?=
 =?utf-8?B?a2pOTFErOVdBRWcxN0dGZkVSdThuOTVDYVQwTDF4N21oRTZmeVJZUEN3WDFt?=
 =?utf-8?B?NjU1eU9Jbk95NmNseEdweTkvQjRRczRPMXhOdXc1WWxqRmEraHhBOFpGQ0pk?=
 =?utf-8?B?REVWby9xTUp6aFBxdk1lb2tkZTRhWEI5dXpFbXhmVFJ5ZjBYWHFwMmp6NHVB?=
 =?utf-8?B?ZlJDRnlXbElBWUFQQkVwRUlQOEFza2plUXlhc2xLYkpYNkZJUnhnc0hReTQ3?=
 =?utf-8?B?WmJVNmhkVDFwZ2JJeU1JY3BaQm1aM0c5SFh5bVRoWjlaRXd0OEVvdHRlQjEv?=
 =?utf-8?B?cUpiSEp2QkIrNHF6VE5UaXdOTkhJbVBPQzFqVlUrMzFIQ3FSQnBONWhZWHNB?=
 =?utf-8?B?MVBLdXZJb3BIT2oxbzRxc0RNbWUxaUhHZS83OTFIK0hrZ3ZBRHVZcjFCK0Rt?=
 =?utf-8?B?OEczazZ0ZXNXeVFMcXZVaWd4RDBUcnJLV2VwYjNJN3V4TGNubGw3ZkRCY3BU?=
 =?utf-8?B?bGNKVkozR1ZHbTJnN05PQVBwQ0E4a0NWNDZhc01TcmZzUklTaEk2Rmx2R3FD?=
 =?utf-8?B?MC9KSGw3bWUvVzdOSjE4c1pOaDJNTDkyYmpNNm9palZwd3ZDTDdONE1xWlBX?=
 =?utf-8?B?Njc0eitoRnlNKytLZU9DS1FFVkdIOEg1V29kRGNYK2wxQnVXd2I3cEd6c01W?=
 =?utf-8?B?bUVnOGVDc2djc1A1N2J2Tk1GZ1V3RW56b1h1ODlMRU5xMUJuK0hFS3R2QlI5?=
 =?utf-8?Q?Z0x84EgPETZ77syJ/qj9a30=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9C4391F650CE44F80D96C3D9310CDC7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e622b66-149e-499b-4db1-08d998a112fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 16:53:02.3865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiuc7HmxCbTnwhYdCEaN6ONsiI43Jf38ohuCrX2ye4xTKwsSJpQnqsJIrGyGocSn/ttmMjT0udzFeRW8+wkqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDI2LCAyMDIxLCBhdCA5OjA2IEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5z
ZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDEwLzIxLzIxIDU6MjEgQU0sIE5hZGF2IEFt
aXQgd3JvdGU6DQo+PiBUaGUgZmlyc3QgVExCIGZsdXNoIGlzIG9ubHkgbmVjZXNzYXJ5IHRvIHBy
ZXZlbnQgdGhlIGRpcnR5IGJpdCAoYW5kIHdpdGgNCj4+IGEgbGVzc2VyIGltcG9ydGFuY2UgdGhl
IGFjY2VzcyBiaXQpIGZyb20gY2hhbmdpbmcgd2hpbGUgdGhlIFBURSBpcw0KPj4gbW9kaWZpZWQu
IEhvd2V2ZXIsIHRoaXMgaXMgbm90IG5lY2Vzc2FyeSBhcyB0aGUgeDg2IENQVXMgc2V0IHRoZQ0K
Pj4gZGlydHktYml0IGF0b21pY2FsbHkgd2l0aCBhbiBhZGRpdGlvbmFsIGNoZWNrIHRoYXQgdGhl
IFBURSBpcyAoc3RpbGwpDQo+PiBwcmVzZW50LiBPbmUgY2F2ZWF0IGlzIEludGVsJ3MgS25pZ2h0
cyBMYW5kaW5nIHRoYXQgaGFzIGEgYnVnIGFuZCBkb2VzDQo+PiBub3QgZG8gc28uDQo+IA0KPiBG
aXJzdCwgZGlkIEkgbWlzcyB0aGUgY2hlY2sgaW4gdGhpcyBwYXRjaCBmb3IgWDg2X0JVR19QVEVf
TEVBSz8gIEkgZG9uJ3QNCj4gc2VlIGl0IGFueXdoZXJlLg0KDQpObywgaXQgaXMgbWUgd2hvIG1p
c3NlZCBpdC4gSXQgc2hvdWxkIGhhdmUgYmVlbiBpbiBwbWRwX2ludmFsaWRhdGVfYWQoKToNCg0K
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL3BndGFibGUuYyBiL2FyY2gveDg2L21tL3BndGFibGUu
Yw0KaW5kZXggMzQ4MWIzNWNiNGVjLi5mMTRmNjRjYzE3YjUgMTAwNjQ0DQotLS0gYS9hcmNoL3g4
Ni9tbS9wZ3RhYmxlLmMNCisrKyBiL2FyY2gveDg2L21tL3BndGFibGUuYw0KQEAgLTc4MCw2ICs3
ODAsMzAgQEAgaW50IHBtZF9jbGVhcl9odWdlKHBtZF90ICpwbWQpDQogCXJldHVybiAwOw0KIH0N
CiANCisvKg0KKyAqIHBtZHBfaW52YWxpZGF0ZV9hZCgpIC0gcHJldmVudHMgdGhlIGFjY2VzcyBh
bmQgZGlydHkgYml0cyBmcm9tIGJlaW5nIGZ1cnRoZXINCisgKiB1cGRhdGVkIGJ5IHRoZSBDUFUu
DQorICoNCisgKiBSZXR1cm5zIHRoZSBvcmlnaW5hbCBQVEUuDQorICoNCisgKiBEdXJpbmcgYW4g
YWNjZXNzIHRvIGEgcGFnZSwgeDg2IENQVXMgc2V0IHRoZSBkaXJ0eSBhbmQgYWNjZXNzIGJpdCBh
dG9taWNhbGx5DQorICogd2l0aCBhbiBhZGRpdGlvbmFsIGNoZWNrIG9mIHRoZSBwcmVzZW50LWJp
dC4gVGhlcmVmb3JlLCBpdCBpcyBwb3NzaWJsZSB0bw0KKyAqIGF2b2lkIHRoZSBUTEIgZmx1c2gg
aWYgd2UgY2hhbmdlIHRoZSBQVEUgYXRvbWljYWxseSwgYXMgcG1kcF9lc3RhYmxpc2ggZG9lcy4N
CisgKg0KKyAqIFdlIGRvIG5vdCBtYWtlIHRoaXMgb3B0aW1pemF0aW9uIG9uIGNlcnRhaW4gQ1BV
cyB0aGF0IGhhcyBhIGJ1ZyB0aGF0IHZpb2xhdGVzDQorICogdGhpcyBiZWhhdmlvciAoc3BlY2lm
aWNhbGx5IEtuaWdodHMgTGFuZGluZykuDQorICovDQorcG1kX3QgcG1kcF9pbnZhbGlkYXRlX2Fk
KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsDQorCQkJ
IHBtZF90ICpwbWRwKQ0KK3sNCisJcG1kX3Qgb2xkID0gcG1kcF9lc3RhYmxpc2godm1hLCBhZGRy
ZXNzLCBwbWRwLCBwbWRfbWtpbnZhbGlkKCpwbWRwKSk7DQorDQorCWlmIChjcHVfZmVhdHVyZV9l
bmFibGVkKFg4Nl9CVUdfUFRFX0xFQUspKQ0KKwkJZmx1c2hfcG1kX3RsYl9yYW5nZSh2bWEsIGFk
ZHJlc3MsIGFkZHJlc3MgKyBIUEFHRV9QTURfU0laRSk7DQorCXJldHVybiBvbGQ7DQorfQ0KDQo+
IA0KPj4gLQkgKiBwbWRwX2ludmFsaWRhdGUoKSBpcyByZXF1aXJlZCB0byBtYWtlIHN1cmUgd2Ug
ZG9uJ3QgbWlzcw0KPj4gLQkgKiBkaXJ0eS95b3VuZyBmbGFncyBzZXQgYnkgaGFyZHdhcmUuDQo+
IA0KPiBUaGlzIGdvdCBtZSB0aGlua2luZy4uLiAgSW4gaGVyZToNCj4gDQo+PiBodHRwczovL25h
bTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZs
b3JlLmtlcm5lbC5vcmclMkZsa21sJTJGMjAxNjA3MDgwMDE5MDkuRkIyNDQzRTIlNDB2aWdnby5q
Zi5pbnRlbC5jb20lMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3Q2Y2
YTJhNjllZWMwOTRiMTI2MzgxMDhkOTk4OWFmYjYwJTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgz
ZDlkZDYyZjAlN0MwJTdDMCU3QzYzNzcwODYxMzczNTc3MjIxMyU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1vOGZZYm04QktIdld4WUM5YU81ZTNNRkxr
YU9uUXh2RE15JTJCRW5ZeHo1NkklM0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+IEkgd3JvdGU6DQo+
IA0KPj4gVGhlc2UgYml0cyBhcmUgdHJ1bHkgInN0cmF5Ii4gIEluIHRoZSBjYXNlIG9mIHRoZSBE
aXJ0eSBiaXQsIHRoZQ0KPj4gdGhyZWFkIGFzc29jaWF0ZWQgd2l0aCB0aGUgc3RyYXkgc2V0IHdh
cyAqbm90KiBhbGxvd2VkIHRvIHdyaXRlIHRvDQo+PiB0aGUgcGFnZS4gIFRoaXMgbWVhbnMgdGhh
dCB3ZSBkbyBub3QgaGF2ZSB0byBsYXVuZGVyIHRoZSBiaXQocyk7IHdlDQo+PiBjYW4gc2ltcGx5
IGlnbm9yZSB0aGVtLg0KPiANCj4gSXMgdGhlIGdvYWwgb2YgeW91ciBwcm9wb3NlZCBwYXRjaCBo
ZXJlIHRvIGVuc3VyZSB0aGF0IHRoZSBkaXJ0eSBiaXQgaXMNCj4gbm90IHNldCBhdCAqYWxsKj8g
IE9yLCBpcyBpdCB0byBlbnN1cmUgdGhhdCBhIGRpcnR5IGJpdCB3aGljaCB3ZSBuZWVkIHRvDQo+
ICpsYXVuZGVyKiBpcyBuZXZlciBzZXQ/DQoNCkF0ICphbGwqLg0KDQpFcnLigKYgSSByZW1lbWJl
cmVkIGZyb20gb3VyIHByZXZpb3VzIGRpc2N1c3Npb25zIHRoYXQgdGhlIGRpcnR5IGJpdCBjYW5u
b3QNCmJlIHNldCBvbmNlIHRoZSBSL1cgYml0IGlzIGNsZWFyZWQgYXRvbWljYWxseS4gQnV0IGdv
aW5nIGJhY2sgdG8gdGhlIFNETSwNCkkgc2VlIHRoZSAocmVsYXRpdmVseSBuZXc/KSBub3RlOg0K
DQoiSWYgc29mdHdhcmUgb24gb25lIGxvZ2ljYWwgcHJvY2Vzc29yIHdyaXRlcyB0byBhIHBhZ2Ug
d2hpbGUgc29mdHdhcmUgb24NCiBhbm90aGVyIGxvZ2ljYWwgcHJvY2Vzc29yIGNvbmN1cnJlbnRs
eSBjbGVhcnMgdGhlIFIvVyBmbGFnIGluIHRoZQ0KIHBhZ2luZy1zdHJ1Y3R1cmUgZW50cnkgdGhh
dCBtYXBzIHRoZSBwYWdlLCBleGVjdXRpb24gb24gc29tZSBwcm9jZXNzb3JzIG1heQ0KIHJlc3Vs
dCBpbiB0aGUgZW50cnnigJlzIGRpcnR5IGZsYWcgYmVpbmcgc2V0IChkdWUgdG8gdGhlIHdyaXRl
IG9uIHRoZSBmaXJzdA0KIGxvZ2ljYWwgcHJvY2Vzc29yKSBhbmQgdGhlIGVudHJ54oCZcyBSL1cg
ZmxhZyBiZWluZyBjbGVhciAoZHVlIHRvIHRoZSB1cGRhdGUNCiB0byB0aGUgZW50cnkgb24gdGhl
IHNlY29uZCBsb2dpY2FsIHByb2Nlc3NvcikuIFRoaXMgd2lsbCBuZXZlciBvY2N1ciBvbiBhDQog
cHJvY2Vzc29yIHRoYXQgc3VwcG9ydHMgY29udHJvbC1mbG93IGVuZm9yY2VtZW50IHRlY2hub2xv
Z3kgKENFVCnigJ0NCg0KU28gSSBndWVzcyB0aGF0IHRoaXMgb3B0aW1pemF0aW9uIGNhbiBvbmx5
IGJlIGVuYWJsZWQgd2hlbiBDRVQgaXMgZW5hYmxlZC4NCg0KOigNCg0KDQo=
