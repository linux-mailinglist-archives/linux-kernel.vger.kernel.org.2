Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92663A26C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFJIYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:24:25 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:54151
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230511AbhFJIYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:24:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWEQuuDEph2EiinUF5jOeKIGXQwdu0Px2e+j5ScfTLNPQKemj7oD/hZYlAmod5ojB+2LxIaarKsIlb+WIqYJZcMs3nztXAG92laoN1X8URxU7+VhiPyq3ClHW9g4Ipa5cDE7mhuf4VbOsEjJFiN0BTtRD2v1wEHP0k9p3s12I3JGMs0snIIiBXjl4JSysF4RfJt205kOnTkboutZsOKejhmIaCOoXzp5hA7iidVOu5tPJIY3LWJDZSS4TYhDzhWB6VobIXaK3gaMyzGlG1noUX4otL+KYcgCMaRpZ3lIwF7g3AvCMBnN0y0eDtC91pJQl1r5BLatW99/RNuXBaRO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi50vji0Gmh30KBDNAv/9QpRspzRoIOZHOUjSAHBLLM=;
 b=YoIf6ODb1OdKhHzS9+eSYXkaDgE/4Fc5CBsZ+hWSGj5lVAJ3MOccfUDQFv7g5GloLjZe9Ram6ArwOv+cb7d2fsgEJXWgVUYj7kyyh64svH0YTe9LieoyQYrI2sh+K7ZnlPOeeoqrY1ZXcQcDWNxzNDrxg2igqyZTvZ+WKYF/JgywoOcvdTL9oQUUWN38QxWOh4/ojwZ0qmRVhKu1zIItn1t4IDi+tK5ETt72ZXxSom1c97QXIc0x4Bujq9fMJu57X+0+N4hzLo7Sj3csFI2msocqfaw46v8m2WCqBSzqSRZ/YU05DYysGuCylHCUWZaeXZtHH9BC/Cf8kW16hjB/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi50vji0Gmh30KBDNAv/9QpRspzRoIOZHOUjSAHBLLM=;
 b=WiB+7cjIUh+aHxV87YbbXW8Saq1sDiQamIhYDsMD9glhMxt43JCFryJyf0QX4dpS05Bs9GOY8llTt+CLWq1tc42v9i3HBzLJNV+NOPzJzWypUPWMrCE4bmNVEuEkXa02ssUC9Ktn7rJsQlGmYmJYZbu4kI7upwm15tnMjNswKN4=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2476.eurprd03.prod.outlook.com (2603:10a6:3:6e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Thu, 10 Jun 2021 08:22:16 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::ed91:9c0d:24af:c443]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::ed91:9c0d:24af:c443%6]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 08:22:16 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>
CC:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>
Subject: Re: [PATCH RESEND v2 0/5] Add devm helper for work-queue
 initialization
Thread-Topic: [PATCH RESEND v2 0/5] Add devm helper for work-queue
 initialization
Thread-Index: AQHXXE5aMgfg3W2whU2hmUlchvRGRqsLzikAgAChu4CAAHrsAA==
Date:   Thu, 10 Jun 2021 08:22:15 +0000
Message-ID: <d2944befc1fdc57860f3f8491674e85ba103099b.camel@fi.rohmeurope.com>
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
         <CGME20210609152330epcas1p1fdf700b679879bbed8e5db58a9711663@epcas1p1.samsung.com>
         <2ab1589e-a14b-3058-5582-ac5c304f7e80@redhat.com>
         <5bcb6af7-21d3-b319-36c2-b2a201118df8@samsung.com>
In-Reply-To: <5bcb6af7-21d3-b319-36c2-b2a201118df8@samsung.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 856cfd8e-5971-4b17-a576-08d92be8db43
x-ms-traffictypediagnostic: HE1PR0301MB2476:
x-microsoft-antispam-prvs: <HE1PR0301MB24763F3D7716370F634D8CD3AD359@HE1PR0301MB2476.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4FK9/T5xgs1ZxXYuJrnjcC3aeLXVrVvbNTHFllfOULyUi+bMNalTlK4fJJn3dFWkUUeWE4eVsKFSAIB/MDfVxS4EmtnHRYxpzisEfGZflrz84MKpqpHnuGun7qCndq6Kys3W5bW2mVnnMr1HqLlbDn5GX7lTMh8W8gPiZ1y+Sj+ZA9s0C6sRsBsJ//PxuEYcuhYPWv1V/SV9f4s37ijjgippw3pVISqMXTS75X/CAmDSlqmnlmBMCH78mGtKPy4EWOMBdEe36818NT3rho8KSbgWWLDCsJGvT8tTlNRhFLrkc/XeTLjBXgLkeWJqKMrDQ/D0vXWmPTj3FOBKYlx0Iio30EiaeKcl9ZvKnejckYgwdC4Kx/zjNmndRC1c5EZNkbjW7Oa+a10WYgpdEB1vFLAt+VjvzQYSeD88akAJ/j7Rpsiw7nWspUheVmtb1AtJ7UJHjbBieo9T7spdF0WO0vRXI1iEBaUbJETN59X/HIIWv+EeryEC5ObQGosk6e7MXqlLS2KuEcCrs4a/mGqBGiDrJj1DOpMYjad4UokRWGRienVq0e/vBcoHET14khe2n8EuUBThrCm/SEPuh/NY0EVuvq/mweTz4/ncMJHkb/DWH1B6P8fa2TdMaEuSCamgEvaDyJqXKaKT8KxVEUKrjauyXF7pQ2/Rw27OhRm+RvYz9GqMz5InzY8GXbRPp9/r7r5p49DJo9W3H3ZvRXtfVfbVADl/vcgqndQhcm+J/VM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39850400004)(366004)(3450700001)(478600001)(8676002)(53546011)(86362001)(54906003)(6512007)(316002)(6506007)(8936002)(76116006)(66446008)(5660300002)(186003)(64756008)(66556008)(66476007)(966005)(66946007)(2906002)(122000001)(71200400001)(83380400001)(6486002)(38100700002)(2616005)(110136005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SlR5cUc4K2xGK1hXZWppc1pRblhEZXQ2K092L0VxYmM1SjlwR1ZDbVZxUUNo?=
 =?utf-8?B?ZFVMZnRvUElzNklWaDdwcUptanFmWEpIMFZYbnVmWk1qTjhEeXZWSzU1V0dO?=
 =?utf-8?B?TzZCMHVjRTZrR29rUjF1V3Qvb3lpU0IvbklZK2NJdjhVbFN5TW5DNFByMWVJ?=
 =?utf-8?B?SExYRVdkcVRyeERiQytRVVAyaEdYWFBUR1g3d1dvQkhvWEpYRDV0Q2hwbGZ2?=
 =?utf-8?B?UjNSaDFLVFpmNVJDMldCamo1NVU2eCtzSjAxVGVjVWMxZjQ3RXUxVkc5RFRq?=
 =?utf-8?B?Qm45TWNhaDBPS0tQVmRiSXVtdHBNZ3VUQ2M3eXc2N2lYclhIWWo2eVc1VVBQ?=
 =?utf-8?B?UmFPU2k3UVdhVW1tMG0yOUsyOXFEaGRKdHZ6WmlleDNTQndSdVppOTd4c0tW?=
 =?utf-8?B?NHVLdHUrMzQ5VTFtdHVVbjBiWVVkdHdFQXNXcXhTaTFBRHVTVWo2VTNRcWVu?=
 =?utf-8?B?WEtkWnNtVkJBVWpJc0RlOXF0cjhUdWl1M01UZDBpU0lRMVFPcEhGVVR2dmg2?=
 =?utf-8?B?dTcyNUR0eTdwWkdWUEJkS1Z2K3dJNW5mUWtkYjVqOW1NU000OE9mcWEzM202?=
 =?utf-8?B?VWxXVkpiR00xMStzYTZHanQrUHhWMVdTUmZjZkpDNmFhcjZsNmo3ZXVVVmtu?=
 =?utf-8?B?QmllNENEc1VIRkJ1QWRncFdXYmNUNmlsZEg0UEpqSnlpTEFVRGs2OGsxRWdy?=
 =?utf-8?B?Y3BEaFlMTDZuN1lQdmNKVTJ6alNHUm5reXZWcjdvQWc4amtncklBOXBRQkJ5?=
 =?utf-8?B?QWdQbjB3Nm9qSVFDUnJORXl6eXNUWXNnNjVicGlvOHVDU2YvRDU1U2lYYUMr?=
 =?utf-8?B?bEFmNVprUDBpNjhZaXNHcFpsSVJTOWlNcEdYRDlSRFZiQkxRejIweVFhN3M0?=
 =?utf-8?B?Y3U3VGVSbytFMlVCZmJhc0VZMmQzU1diQUFVbVovZEdycVhlMHRDM3JEdjBp?=
 =?utf-8?B?TkZxdkVwVHNVOVRTT1ExMzVJSkxrVTFLcjNtT25ZTVh5WkIxbk55ekc3R0hw?=
 =?utf-8?B?UUVuUWxnWGdpTkkrOGFBY2p2WmxnVFBKUmpHeWFaY1ZxQlhPcVh6emdmdm83?=
 =?utf-8?B?bjNKd2EyWko3Vms4YXNtRGJWdDFxQnVDaUxIc3habjhzY3h0UXBnUU1yUmlw?=
 =?utf-8?B?R3dRa3ZlWlVVM2ZFZ2xickhNVWJxRDlNSDE0OHByaDlvWWtwQmVnUGtBQXpC?=
 =?utf-8?B?cUdwc0J1MmFUSFhFUmhDM1BkRk84QkphMWYvZCt1a3Rjb2YyN0o1ajM2RjN6?=
 =?utf-8?B?M3JGdk5CUGV0U1Y4VUtJcVN3cTlEVmlCOXRKQlVwRzR2VmlhcFBHbWtXMktl?=
 =?utf-8?B?TzNrZU5PSHFieFBXakdKbGdwaEVaQlBjeDJ2U0MxVHR5QUFZQ3pEQktjS1VX?=
 =?utf-8?B?V3ZyTG1aTmZ6L3J4RnMwd0h1WWJBSVE4ZmxmekhHcjhVVndGT0NXeFYrbFBn?=
 =?utf-8?B?dmtKMEZzbElDUU5qY0ZxSEFkdXB4a29CY1pDbGsxQjM2NFR3TUplR3NVeVJp?=
 =?utf-8?B?ekdIRlY4S3hXV0NvcTV6UXcrOWpFZkh6TUNsS3JJYXJya0lpSTIxU3Q1dlhh?=
 =?utf-8?B?aFJSTkVpQXVpeGJsVElmZjVseVE4cFhucC9lN1VrbzRiK3phNjBrUzFpRUN1?=
 =?utf-8?B?UDNNdlRsWUFTRXBBK0ZIeTNrL1lXZVpDVllkRGFEU3Y3TUpSN0QxRGpBdys0?=
 =?utf-8?B?NHAycXdxbDZJUU9MekZTZzkxQUdqVVBCVXY1bG9zZ0xXS0ZJdlpVL0NGWlpI?=
 =?utf-8?B?UzdrNHU4cTA0ZFBKb2tUZGxoYmVSL3R2TmMvY0ZYaEFaRVZtQVZzbllRbWRS?=
 =?utf-8?B?blFkTlU1MnN2eVFMUXExUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D780BEB26B45B54192A181F56CAB10BB@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856cfd8e-5971-4b17-a576-08d92be8db43
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 08:22:15.9816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82e38ZtGJibfmJg10X5co6yqi8TBpMbCKS0L8f3Vp2BYvFBHrIxvNpl+9P3g0vvrw6iY3IKuc78Lty1sdR8+mL8vNf+AGPdYbg7vmYnmzynH56CqUvqmuBRZLXQxrfbA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2476
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEhpIEhhbnMsIA0KPiANCj4gT24gNi8xMC8yMSAxMjoyMyBBTSwgSGFucyBkZSBHb2VkZSB3
cm90ZToNCj4gPiBIaSBBbGwsDQo+ID4gDQo+ID4gT24gNi84LzIxIDEyOjA5IFBNLCBNYXR0aSBW
YWl0dGluZW4gd3JvdGU6DQo+ID4gPiBUaGlzIHNlcmllcyBhZGRzIG5ldyBkZXZtX3dvcmtfYXV0
b2NhbmNlbCgpIGhlbHBlci4NCj4gPiA+IA0KPiA+ID4gTm90ZToNCj4gPiA+ICJUaGUgYmVlZiIg
b2YgdGhpcyBzZXJpZXMgaXMgdGhlIG5ldyBkZXZtLWhlbHBlci4gVGhpcyBtZWFucyB0aGF0DQo+
ID4gPiBub3JtYWxseSBpdCB3b3VsZCBiZSBwaWNrZWQtdXAgYnkgSGFucy4gSW4gdGhpcyBjYXNl
IEhhbnMgYXNrZWQNCj4gPiA+IGlmIHRoaXMNCj4gPiA+IHNlcmllcyBjb3VsZCBiZSB0YWtlbiBp
biBleHRjb25uIHRyZWU6DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2ZiYmZi
YTcxLWJkY2MtYjc4Zi00OGJlLWQ3YzY1N2FkY2U2MUByZWRoYXQuY29tLw0KPiA+IA0KPiA+IFll
cywgYW5kIGdpdmVuIHRoYXQgbW9zdCBvZiB0aGUgY2hhbmdlcyBhcmUgaW4gdGhlIGV4dGNvbiBj
b2RlIEkNCj4gPiBzdGlsbA0KPiA+IGJlbGlldmUgdGhpcyBpcyBiZXN0Lg0KPiA+IA0KPiA+IEFs
dGVybmF0aXZlbHkgSSBjYW4gY3JlYXRlIGFuIGltbXV0YWJsZSBicmFuY2ggd2l0aCB0aGVzZSA1
IHBhdGNoZXMNCj4gPiBvbg0KPiA+IHRvcCBvZiA1LjEzLXJjMSBhbmQgdGhlbiBzZW5kIGEgcHVs
bC1yZXEgdG8gQ2hhbndvbyBhbmQgTXlvbmdKb28uDQo+IA0KPiBSaWdodC4gQWZ0ZXIgY3JlYXRp
bmcgdGhlIGltbXV0YWJsZSBicmFuY2gsIHBsZWFzZSBzZW5kIHB1bGwtcmVxdWVzdA0KPiB0byBt
ZS4NCj4gSSdsbCBtZXJnZSB0aGVtLiBUaGFua3MuDQoNCkNoYW53b28sIEkgdGhpbmsgdGhlIHNl
cmllcyBoYXMgbm8gZm9ybWFsIGFjayBmcm9tIHlvdS4uLiBDYW4gdGhpcyBiZQ0KdHJlYXRlZCBh
cyBzdWNoPw0KDQpCZXN0IFJlZ2FyZHMNCglNYXR0aSBWYWl0dGluZW4NCg0KDQotLQ0KTWF0dGkg
VmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1pY29uZHVjdG9ycywgRmlu
bGFuZA0KU1dEQw0KS2l2aWhhcmp1bmxlbmtraSAxRQ0KOTAyMjAgT1VMVQ0KRklOTEFORA0KDQp+
fn4gIkkgZG9uJ3QgdGhpbmsgc28sIiBzYWlkIFJlbmUgRGVzY2FydGVzLiBKdXN0IHRoZW4gaGUg
dmFuaXNoZWQgfn5+DQoNClNpbW9uIHNheXMgLSBpbiBMYXRpbiBwbGVhc2UuDQoibm9uIGNvZ2l0
byBtZSIgZGl4aXQgUmVuZSBEZXNjYXJ0ZSwgZGVpbmRlIGV2YW5lc2Nhdml0DQoNCihUaGFua3Mg
Zm9yIHRoZSB0cmFuc2xhdGlvbiBTaW1vbikNCg0K
