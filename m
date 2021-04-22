Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A98367C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhDVI2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:28:25 -0400
Received: from mail-eopbgr1400071.outbound.protection.outlook.com ([40.107.140.71]:54157
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230365AbhDVI2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:28:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFhQkw1YTXf4n+Zl9um+8FXsL+tU56+oLRUrvnzQtJVidVtJ+YslPAPmbh/wuCk6UoB+VP7F//jNJ52u8rz/L/uhX4TnPy4ZjmRzailk3pg0TIr4M2mFS8jirkq+p06wmh2lloNQ+Ns7SyvKsuvUa2JUKoFtPjSq5fbxpG1hT+IVoVfgo7B/6TJW7MJtay9ARbPKw4huversiKq7x28H26jF2mCu0TERkFk/acBh9FfZOQZboSmwa6t5K9VBB5N+S/1RFWRmoEL9vxe754JqgudnSyVz3NU5kIWSuQWXkRp0tkN00llWDAAjxaiwi5hKsGmDT26wVC+/LmVUGPO3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp9TWtERFcp5OFhxYcOX1nVJ/Cr1zQ77ezU10djSQdc=;
 b=Nh687nssGV/iXLKwPGbrwEqQlld+FOxxef1/zgSVzEDuVaVkwdUb9nBCKnRGuG9XBDQClKU4t3hVEcCqu2Qu5jlyLbaiUh1yqu5h5JmSgb8Ng3A+ATmKLocvhot8+UYO4v/cppoBymiHMX6uhsDQzTUlbpjDftQl+uqpiY7MEJIcqMRjAvKc0fq2UcPZcI9okaT9T8PUjVif4AnJL3f5gFMTwM1vZ1ABSVilo31eB6rFP4B3Mgsc+IYUO7ypl1U3h2N8vhITawGrZBasK7ZoWzF/GSfxG27+jbBpIWdPMvetrC3KfNpk1SEZf1chRuHt6uOlyjUMNENr0z20L2rYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp9TWtERFcp5OFhxYcOX1nVJ/Cr1zQ77ezU10djSQdc=;
 b=Yg5goH9xuQD94DHhe9qIhcrwXqAOyspA+pDHB45dla3gkDeyHKr6DfcyMdDg6J5wNBnxPqULPGQBbQr1gq0vwDdmtZT0d/CiapRsRjnQ52ZvWLPpDzW5O6C6r6OYtVqspq8BnQX6ok5Re8v5HwccWMe0t0prWrrETq9YTvbVloA=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB6639.jpnprd01.prod.outlook.com (2603:1096:400:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 22 Apr
 2021 08:27:47 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 08:27:47 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
Thread-Topic: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
Thread-Index: AQHXNoTZ/dsTmwNUxkyFM7XUqHdaa6q+pOiAgACfTACAAPGAAA==
Date:   Thu, 22 Apr 2021 08:27:46 +0000
Message-ID: <20210422082746.GA33308@hori.linux.bs1.fc.nec.co.jp>
References: <20210421060259.67554-1-songmuchun@bytedance.com>
 <YH/cVoUCTKu/UkqB@dhcp22.suse.cz>
 <20210421083315.GA7552@hori.linux.bs1.fc.nec.co.jp>
 <57892496-a391-2eb9-eda0-1db9f3b98902@oracle.com>
In-Reply-To: <57892496-a391-2eb9-eda0-1db9f3b98902@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3539798e-40f6-45a2-7240-08d905688251
x-ms-traffictypediagnostic: TYCPR01MB6639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB6639E4216B4FAB0238D49ACCE7469@TYCPR01MB6639.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4lsMDsznRC2awXKufClvy0/5UGK85YGQMPJtiSLzgD9RyGLzc8/7CJRs2euXgTJ2DYOtiNCnc00g44819fpiwwOtjmFZDymzaudQKK3ioGH9MKVtgSGsQ4gLcKIiJWLVWYREBv655kOemijBzVzm56gAUn2DKnSqhqf1F09aGclLZqMRyDou3fR24RLF4stoa35UJpU56i0WHhdDkl83mH3znFcB+YZJ028D8otzkv8U5OBEurMGUGFXbPFMJiNnSJK2ENEKn72j+o1gQq/+1anMjAc6/n7uk4lt2LJobwAnu2XpJzZSM8lSdTSagYX3r9vmQDUZYvcBfjDmP/YYTnwI4/4RE9UTlEmm7l5mPfgDJSSlJfTZ7V7qVvBHwg3v5V8cILvWfFKKouYjebTGkmf4e389j95KRByMthitjbWjyzQZhjeRHY5teyjHZdyXqup2pk5IgrwAeXeuWqbu3enw+uxoXfCxfJWlGFmbIwyiw/UImLnuYa1ZXsduLi1zkQKQQ0QxRMmFOt6xvdNIPeWIgmjZ8XGNBY7MLmIeW/Jma1A5A4wGZKuK1M8Pd0DC1BgZgq2vC2oUwrU17XBbD46pW4AsOHtmDkBPo9Dxqe0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(8676002)(54906003)(122000001)(83380400001)(316002)(4326008)(6512007)(6916009)(53546011)(85182001)(64756008)(5660300002)(66556008)(6506007)(66476007)(86362001)(186003)(55236004)(1076003)(2906002)(66446008)(9686003)(33656002)(8936002)(76116006)(71200400001)(38100700002)(6486002)(478600001)(26005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R3ZDZzEwMzBPMFFvRkk4MDFEdnE1aVArNWxvcGNNWjFtSTFOZThGZCt5b0pW?=
 =?utf-8?B?WHNvTU5teEtMTWJMZGE5dit0QXpGQTcwSjEydnFxaTRBdm9ZaFk4OHY4bldp?=
 =?utf-8?B?emlKZ3FuWFFxdVd1dEFWa1p2V0dDYWp1Ui9RQ3JpVmRvc0UyUjhrN3ZrYWNR?=
 =?utf-8?B?SzVrelZMZGZDSFg3TGlhWitEdXo1clBIczB6SUFlOTlPV0s1Wm5mdDd5T2JZ?=
 =?utf-8?B?enpvQmlNazF2dzdsMWNRRnBBWFZJUFVGSllvYzN1bHlrUzVMVFBZSy8vRGZL?=
 =?utf-8?B?ZjBFUU1iWjlwZEJqZ29hb082MlN2WkxhSTZBLytqMFgvamFTTFZ2aXFqcXow?=
 =?utf-8?B?MlBNSjZSNzQwTnI3elR4Y1czdjdrUldOcDhvUnZtMmY4eVFGNklkUzFweGtn?=
 =?utf-8?B?ODF5ZTZZZmtHQ2hVaDVuNHA4enhUN0RaRDNYdG9hWG1DZXlVOFZQbzcyMnh4?=
 =?utf-8?B?UlpuSng5bmtiZnAxeHQ3c2w2a1psRWc2V2JvTzl6NEFqSWtJclZ5eHNiaC9o?=
 =?utf-8?B?ZG5NSU53KytUZ3ZYTi94SHpJN3RDTWJDNFBkTWZsQnl6NXQ5VmpZdnp3c1F2?=
 =?utf-8?B?MnVydTZ1K3A5Ty9wMTdMWWtTWXZpaWI1R2I2VEFkV3BVMmNnT1pzcFRXTXEx?=
 =?utf-8?B?SFYzWnpBNGxIR0JpNEczajhIcVkrSlZTdTdHeWhDMExmSUk1Q0MrTXZEWmxT?=
 =?utf-8?B?bTR5TTdkeUx2cjFaSjJXK1FTd3I1T1FIRDl5bmI3S3dOZHpFNFJYajQ4cEhs?=
 =?utf-8?B?Z2J4NG04MmRFemNPdzJpbkJtQWR6cXIvZWVYeGxiRStubVdiSGJSd3IwWjdp?=
 =?utf-8?B?bmhmaW5KNldvaXlCN3B1eU1pd1dpNVBkNU9nSXgxOFhCbnkvdmRqc1g1VG1G?=
 =?utf-8?B?aExBb3hvOTZQK1FFUkJFL09rTHI0WTZ1SnhmR0ZpTDFDMUdwM2ptVFNSNmlH?=
 =?utf-8?B?MkF0MVpYUU9KUDlldVRKRlAvSzR0VFV3d0hpamoyOEtnVjhFS3RlTVFRT2kr?=
 =?utf-8?B?QUxYalRaS0hjNlpSTlRvREdPa1lCdFNxTzhXTTRoRjllcEJYRGducm9EQUor?=
 =?utf-8?B?cEg3akw5RFBKUXlCMHI1ZVpqWjlsVGRlRGpEdnUrWk90cktud2ZzSE9iK0xk?=
 =?utf-8?B?SVVuRHBRamh6eUc4R3cyYTkyMkhRQ2drV2g0U3ZhWlZmYlNYRk5YcGdTakNi?=
 =?utf-8?B?U2dGNGp3eWlUVDBsNW5rZ3pwWGJlSjkvSVZKVWlZUzgzSk9LU3UwQlFVdWtW?=
 =?utf-8?B?NE1GOXF6L1E2R1djdHV3U2oxdXhKL2ZJUEZDYUZXd2cxNWJTUmZSbUIrckU2?=
 =?utf-8?B?ODJEN1dabmFMZ0xCcGxkNVh5Um5pbjVId2lIOU5JVXZNRnQrQWI4ZWJ4Rzdr?=
 =?utf-8?B?enRybG9iQ3QxU3ZmSmpCWFlyWktHcGxNWkZkS3JSZW1ZWlYyemVsOTJGME85?=
 =?utf-8?B?eW4wWUdhbHZPazNHSmhxZ0hYUTB2VGhWUTl2UWpqaGU1YVdBbjFSWVlKSlMz?=
 =?utf-8?B?V1lyWTdwbGpnWVhUTVR0Wm1tTWJuNW5lWjR3dkY0ZWcwRDZRYzZHdU9WOVYy?=
 =?utf-8?B?eXV4a3grVUFnZHhQckVmL1hyZ2phZnhSbWw1Y0dKZktPaTg3aHV2VUtGenE0?=
 =?utf-8?B?Y3kwOTVTSHhhNWFxQ0ZzcW4rRnlNVkVZa2F5UVBvdmx3Tm5Sa2F1enBEemJm?=
 =?utf-8?B?c1RNNDN0RE9hRFRzME1aNktDalZZM2ZUcWVCNTcrd0h6Y01wVHBMTEhRWTFw?=
 =?utf-8?Q?jnD0okVxMCJzzNJDysjBBuOgXVBe5i5asEVyx27?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A5C574AE0593542B0CA46A060386A5D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3539798e-40f6-45a2-7240-08d905688251
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 08:27:47.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtTjuN7B6oC6tH90E+9oRajo8AXlNar/REP2Z1gE1c2B7bWka8VTXDwUFIncwEJt29Mrn7LgiibEfOgGvsLi2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6639
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMjEsIDIwMjEgYXQgMTE6MDM6MjRBTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiA0LzIxLzIxIDE6MzMgQU0sIEhPUklHVUNISSBOQU9ZQSjloIDlj6Mg55u05Lmf
KSB3cm90ZToNCj4gPiBPbiBXZWQsIEFwciAyMSwgMjAyMSBhdCAxMDowMzozNEFNICswMjAwLCBN
aWNoYWwgSG9ja28gd3JvdGU6DQo+ID4+IFtDYyBOYW95YV0NCj4gPj4NCj4gPj4gT24gV2VkIDIx
LTA0LTIxIDE0OjAyOjU5LCBNdWNodW4gU29uZyB3cm90ZToNCj4gPj4+IFRoZSBwb3NzaWJsZSBi
YWQgc2NlbmFyaW86DQo+ID4+Pg0KPiA+Pj4gQ1BVMDogICAgICAgICAgICAgICAgICAgICAgICAg
ICBDUFUxOg0KPiA+Pj4NCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2F0
aGVyX3N1cnBsdXNfcGFnZXMoKQ0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBhZ2UgPSBhbGxvY19zdXJwbHVzX2h1Z2VfcGFnZSgpDQo+ID4+PiBtZW1vcnlfZmFpbHVy
ZV9odWdldGxiKCkNCj4gPj4+ICAgZ2V0X2h3cG9pc29uX3BhZ2UocGFnZSkNCj4gPj4+ICAgICBf
X2dldF9od3BvaXNvbl9wYWdlKHBhZ2UpDQo+ID4+PiAgICAgICBnZXRfcGFnZV91bmxlc3NfemVy
byhwYWdlKQ0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHplcm8gPSBw
dXRfcGFnZV90ZXN0emVybyhwYWdlKQ0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFZNX0JVR19PTl9QQUdFKCF6ZXJvLCBwYWdlKQ0KPiA+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGVucXVldWVfaHVnZV9wYWdlKGgsIHBhZ2UpDQo+ID4+PiAgIHB1
dF9wYWdlKHBhZ2UpDQo+ID4+Pg0KPiA+Pj4gVGhlIHJlZmNvdW50IGNhbiBwb3NzaWJseSBiZSBp
bmNyZWFzZWQgYnkgbWVtb3J5LWZhaWx1cmUgb3Igc29mdF9vZmZsaW5lDQo+ID4+PiBoYW5kbGVy
cywgd2UgY2FuIHRyaWdnZXIgVk1fQlVHX09OX1BBR0UgYW5kIHdyb25nbHkgYWRkIHRoZSBwYWdl
IHRvIHRoZQ0KPiA+Pj4gaHVnZXRsYiBwb29sIGxpc3QuDQo+ID4+DQo+ID4+IFRoZSBod3BvaXNv
biBzaWRlIG9mIHRoaXMgbG9va3MgcmVhbGx5IHN1c3BpY2lvdXMgdG8gbWUuIEl0IHNob3VsZG4n
dA0KPiA+PiByZWFsbHkgdG91Y2ggdGhlIHJlZmVyZW5jZSBjb3VudCBvZiBodWdldGxiIHBhZ2Vz
IHdpdGhvdXQgYmVpbmcgdmVyeQ0KPiA+PiBjYXJlZnVsIChhbmQgaGF2aW5nIGh1Z2V0bGJfbG9j
ayBoZWxkKS4NCj4gPiANCj4gPiBJIGhhdmUgdGhlIHNhbWUgZmVlbGluZywgdGhlcmUgaXMgYSB3
aW5kb3cgd2hlcmUgYSBodWdlcGFnZSBpcyByZWZjb3VudGVkDQo+ID4gZHVyaW5nIGNvbnZlcnRp
bmcgZnJvbSBidWRkeSBmcmVlIHBhZ2VzIGludG8gZnJlZSBodWdlcGFnZSwgc28gcmVmY291bnQN
Cj4gPiBhbG9uZSBpcyBub3QgZW5vdWdoIHRvIHByZXZlbnQgdGhlIHJhY2UuICBodWdldGxiX2xv
Y2sgaXMgcmV0YWtlbiBhZnRlcg0KPiA+IGFsbG9jX3N1cnBsdXNfaHVnZV9wYWdlIHJldHVybnMs
IHNvIHNpbXBseSBob2xkaW5nIGh1Z2V0bGJfbG9jayBpbg0KPiA+IGdldF9od3BvaXNvbl9wYWdl
KCkgc2VlbXMgbm90IHdvcmsuICBJcyB0aGVyZSBhbnkgc3RhdHVzIGJpdCB0byBzaG93IHRoYXQg
YQ0KPiA+IGh1Z2VwYWdlIGlzIGp1c3QgYmVpbmcgaW5pdGlhbGl6ZWQgKG5vdCBpbiBmcmVlIGh1
Z2VwYWdlIHBvb2wgb3IgaW4gdXNlKT8NCj4gPiANCj4gDQo+IEl0IHNlZW1zIHdlIGNhbiBhbHNv
IHJhY2Ugd2l0aCB0aGUgY29kZSB0aGF0IG1ha2VzIGEgY29tcG91bmQgcGFnZSBhDQo+IGh1Z2V0
bGIgcGFnZS4gIFRoZSBtZW1vcnkgZmFpbHVyZSBjb2RlIGNvdWxkIGJlIGNhbGxlZCBhZnRlciBh
bGxvY2F0aW5nDQo+IHBhZ2VzIGZyb20gYnVkZHkgYW5kIGJlZm9yZSBzZXR0aW5nIGNvbXBvdW5k
IHBhZ2UgRFRPUi4gIFNvLCB0aGUgbWVtb3J5DQo+IGhhbmRsaW5nIGNvZGUgd2lsbCBwcm9jZXNz
IGl0IGFzIGEgY29tcG91bmQgcGFnZS4NCg0KWWVzLCBzbyBnZXRfaHdwb2lzb25fcGFnZSgpIGhh
cyB0byBjYWxsIGdldF9wYWdlX3VubGVzc196ZXJvKCkNCm9ubHkgd2hlbiBtZW1vcnlfZmFpbHVy
ZSgpIGNhbiBzdXJlbHkgaGFuZGxlIHRoZSBlcnJvci4NCg0KPiANCj4gSnVzdCB0aGlua2luZyB0
aGF0IHRoaXMgbWF5IG5vdCBiZSBsaW1pdGVkIHRvIHRoZSBodWdldGxiIHNwZWNpZmljIG1lbW9y
eQ0KPiBmYWlsdXJlIGhhbmRsaW5nPw0KDQpDdXJyZW50bHkgaHVnZXRsYiBwYWdlIGlzIHRoZSBv
bmx5IHR5cGUgb2YgY29tcG91bmQgcGFnZSBzdXBwb3J0ZWQgYnkgbWVtb3J5DQpmYWlsdXJlLiAg
QnV0IEkgYWdyZWUgd2l0aCB5b3UgdGhhdCBvdGhlciB0eXBlcyBvZiBjb21wb3VuZCBwYWdlcyBo
YXZlIHRoZQ0Kc2FtZSByYWNlIHdpbmRvdywgYW5kIGp1ZGdpbmcgb25seSB3aXRoIGdldF9wYWdl
X3VubGVzc196ZXJvKCkgaXMgZGFuZ2Vyb3VzLg0KU28gSSB0aGluayB0aGF0IF9fZ2V0X2h3cG9p
c29uX3BhZ2UoKSBzaG91bGQgaGF2ZSB0aGUgZm9sbG93aW5nIHN0cnVjdHVyZToNCg0KICBpZiAo
UGFnZUNvbXBvdW5kKSB7DQogICAgICBpZiAoUGFnZUh1Z2UpIHsNCiAgICAgICAgICBpZiAoUGFn
ZUh1Z2VGcmVlZCB8fCBQYWdlSHVnZUFjdGl2ZSkgew0KICAgICAgICAgICAgICBpZiAoZ2V0X3Bh
Z2VfdW5sZXNzX3plcm8pDQogICAgICAgICAgICAgICAgICByZXR1cm4gMDsgICAvLyBwYXRoIGZv
ciBpbi11c2UgaHVnZXRsYiBwYWdlDQogICAgICAgICAgICAgIGVsc2UNCiAgICAgICAgICAgICAg
ICAgIHJldHVybiAxOyAgIC8vIHBhdGggZm9yIGZyZWUgaHVnZXRsYiBwYWdlDQogICAgICAgICAg
fSBlbHNlIHsNCiAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsgIC8vIGFueSB0cmFuc2llbnQg
aHVnZXRsYiBwYWdlDQogICAgICAgICAgfQ0KICAgICAgfSBlbHNlIHsNCiAgICAgICAgICAuLi4g
Ly8gYW55IG90aGVyIGNvbXBvdW5kIHBhZ2UgKGxpa2UgdGhwLCBzbGFiLCAuLi4pDQogICAgICB9
DQogIH0gZWxzZSB7DQogICAgICAuLi4gICAvLyBhbnkgbm9uLWNvbXBvdW5kIHBhZ2UNCiAgfQ0K
DQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
