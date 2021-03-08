Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C92533088E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhCHHDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:03:20 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30032 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235123AbhCHHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:03:09 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12870RiJ023366;
        Sun, 7 Mar 2021 23:03:07 -0800
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com with ESMTP id 374drqu18q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 23:03:07 -0800
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12870tF9023834;
        Sun, 7 Mar 2021 23:03:07 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0b-0016f401.pphosted.com with ESMTP id 374drqu18p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 23:03:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbpSyvMio8QCt3gWwOziaOXJY1DrPt1pnKLqp/iDSuH/FQY+urwCVD7ZRg6woPpzazz9r5GjLdcn4EEaefW3PTwizL2H1hyjciw4H/AcDf1ufgbXPAySQplNCu3ykylBg3TaCH6B+MK67HYDWNlGSLUakzQUuC1a370D/5jP6oTw0Mzx63e8zOl+wLFEap9+/j3b0rc5XyfZQ4OObsKRnoaQoumVgLTxQTO/ajOzXkGpNdJTkltZ+d8kaQit3KjgelpCNs1erwdt49F65+H4JjvihqjGnyVRIR1T4FKyBGTaajnLPANT0xD6ylVtKt5DWDM51leCZzlC06FXolRW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c5Yg1JY1ZU44FvVVrg9FbV9z4zA4+6tFwjXRjXSNo4=;
 b=BW5/feA8mWrlTFhmtq6mbsfzm47D2pREf+8/48KpWwFhAqNpQYUWxlgWMVEX5LCpm/v90KoWNX2s2HxJPDpAxPVWh8EQgI69tkmUQLy6rcieuGDq16SWImqoSE4fC35mXhBwMsyNRZ61JNYXmY9VT2JoDXjtDCHSi34wpoqktES832UC+pC1A95Zp8iU8tdb3t05LB82X0JDtzQmuPGdZX1MlyznGcNcuNBUxfIKhLc2K0aCvs4Gq/OagZ0Uq8yNp39GF5bq1GubRlCjmwTBr6IVbkrjhycOJQi2Z8Qr5/PbfUkdjtyso1EeRAj/JXruSHACpSAFMm37r5KX/THtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c5Yg1JY1ZU44FvVVrg9FbV9z4zA4+6tFwjXRjXSNo4=;
 b=g2FlSMrZTKWpjHIlFyFA7IhTemrzj2xLlnTqO1Muj0qac10iSYIZjOj/acLGoLwCeBXpBw121OtOzETA9PWmK6BSIB1prTrsbHQeqpdJyPDbJ1fTebqeV5N7o/aA+Nfh7W8a5qqfxE5S69sWOAsI8VfMhAHm48J6Uuzw3VEv/B4=
Received: from DM6PR18MB2698.namprd18.prod.outlook.com (2603:10b6:5:16d::28)
 by DM6PR18MB2474.namprd18.prod.outlook.com (2603:10b6:5:18a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 8 Mar
 2021 07:03:04 +0000
Received: from DM6PR18MB2698.namprd18.prod.outlook.com
 ([fe80::93a:7cf:dc01:461b]) by DM6PR18MB2698.namprd18.prod.outlook.com
 ([fe80::93a:7cf:dc01:461b%7]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 07:03:03 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>
CC:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "terminus@gmail.com" <terminus@gmail.com>
Subject: RE: [EXT] Re: vfio-pci: protect remap_pfn_range() from simultaneous
 calls
Thread-Topic: [EXT] Re: vfio-pci: protect remap_pfn_range() from simultaneous
 calls
Thread-Index: AdbkRnC96D9dwqxzR0eR3ijlJSqy4gAEULUAAnocGfAAW82ggAcKnP6AALubABABSBPnAAAADQmg
Date:   Mon, 8 Mar 2021 07:03:03 +0000
Message-ID: <DM6PR18MB269865BC107C37F100743427E3939@DM6PR18MB2698.namprd18.prod.outlook.com>
References: <20210121043907.76037-1-ankur.a.arora@oracle.com>
 <20210226005333.1576246-1-ankur.a.arora@oracle.com>
 <DM6PR18MB2698B4CB0114D7D1FCE74B4BE3999@DM6PR18MB2698.namprd18.prod.outlook.com>
 <9ece62e2-df7b-09b0-d96a-8105048c0ed0@oracle.com>
In-Reply-To: <9ece62e2-df7b-09b0-d96a-8105048c0ed0@oracle.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [157.36.67.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0973127-08b6-40ac-ea81-08d8e2003800
x-ms-traffictypediagnostic: DM6PR18MB2474:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR18MB2474EA1E285644CF7BAFE05CE3939@DM6PR18MB2474.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8kZeYFlJA6nKNSks0/aq1po1k7nZ2dob8rG/busrorEjT1bmoBxnNP/mBkfstsASwotASo/smFggzpo3N1aJ34DhEp3IA9SkbVYeaJWyKkakk2iU+Ql7aEOOcF9BdRMLkFb0fErcMkyiN0H6GQjjTQ9raW9wqPd/sry23710ZBSVMpZfvjJ3hnlPI6vsHMvpk1TleHGD5br86gPxIUzeYyWRyg2Pzy29e106Th4RYIlzcmfPcWwS+J+dGgXE3xHSXKFKd5ZjZ8b3T4pZtommX3ZTOX3exIyZhulnUAtieloawtsVM7YO+SvNZquRWk0HcnncgNXI8vvU/NjgErH3dP14YAdmFcOhEyW5IPDSDviposxi5kXB3Z/0LC8DvaCCi3PIKescjhHEFAy0wb2quzVT6Uwayx9+NGD50VqM/U01ifPyqoJKUOIDmOOrjrMcWvHuqkbQzzNJ27W9k6w+GIvol+GqCGSKAksrbz03JwQH0S7a631NbNBzoJ9pDn2NImxCq7nn4MP2I7hxvvxJ8OenEnnSLo2DaTjaYQNNQgOQh9pLfu3wD01lCexp0Pxo4BHSnE81+Fub9B/glGfz0nhP5CJGELbToy7CZqMzyOE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2698.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(33656002)(6506007)(53546011)(5660300002)(52536014)(83380400001)(64756008)(66476007)(66446008)(66946007)(66556008)(76116006)(7696005)(966005)(9686003)(6916009)(316002)(478600001)(4326008)(2906002)(54906003)(86362001)(186003)(8676002)(71200400001)(8936002)(55016002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MGlaN3EwRjM5K0dzZEhtZ2xCS2FKMEhJYlhnSGxsKzF0cTRoL1JsV29hNFFO?=
 =?utf-8?B?T0IvMlpBZkVZSzNVYytGdkNTck5qeHExTDk3ODd5ZDI3Qlg0WDdlTWNsTldq?=
 =?utf-8?B?SjVRYVUrSDJ2eXV6dTdDcjUyTXllWDRBT3VVb2ZPN0Y1Vm4za3A5T1dsM1I4?=
 =?utf-8?B?cDZ5NzVreEFHODR3Y0lxeEVMNUhKYzJ1ZDZMZ2ZQLzRIMHQ2eHBCQXhUWHhU?=
 =?utf-8?B?MU9jYSttSUNhMzk2SzlXbkNQbSt4VU5XOG9tSE8rYWZxSlZxRkh1aEZjMEFr?=
 =?utf-8?B?TWhyQ0h1Vm1xa3JuL2IxZDY3SDUwK2xhSVNsZkNhOG1zTlZCZDAyNGsxWHQx?=
 =?utf-8?B?Z3J0R2dqcmwxRGZERERjdEVlVmRKUXE4UFZ4MURDdzR2N05VcnI2MEIzdFpx?=
 =?utf-8?B?YnRNU1h0NFhsMUJWQnRyRS9FcVZxUm9HdE1SbW45Y2V1WTF0L0ZnTko2azBC?=
 =?utf-8?B?a0J3VEo5cGpIUGt3anBjVEJPK0VjSmdsMHQvRHQzWmJJMVQvWWdFbGtqeTYz?=
 =?utf-8?B?bDIwYiswYWhaU2VIcHlWSi92VEVGVDg0NGtxcXptNngzenB4S3pTT1lDMmNB?=
 =?utf-8?B?S0FWd2ZaaGhzSVE1UVlibFlCMFEyT1RmUlhEblhnS2FMRTNqQmx6Q0lybzZN?=
 =?utf-8?B?TmJ2cFhudWt6NWpzZFk5ZU0rK2JQZjVFYjlVNVB4SVJtaDRDTnVMcUNoUFox?=
 =?utf-8?B?NXA5T3ZyRVU3cXhUdUJyc0kyaWoxK3RpZjZ2bnp0NWFsaDJmRm9RVkh5N2pF?=
 =?utf-8?B?aGY4N2NuYzdGSDhUcGNGdFBubldzRUtLT2dpVWdKRE8vOUZVTHVMdzNYWlcy?=
 =?utf-8?B?ODNUUHBWS1dxdWxKT3A3R01RaEo4NmQ2dnBaUUpHLzM1Zjd2UE9GVlB4NFpV?=
 =?utf-8?B?dDVPc3BxUzhFdUdvWWxmblRzL2JURXNFdEhUV0JkZU9xTW1vRmZDVE9HU1lv?=
 =?utf-8?B?QU5WKzZEOHpOVHhCTWJ2STNSQnJwSEpqRGdDR3ZScWRvSTdQRW5aenYycWV6?=
 =?utf-8?B?eVVUYmt0MUxwVm1hY3ptUVdsQlhJNFBmRHBJR3BNRUlaRVZ2WVIzZ3JYZHlX?=
 =?utf-8?B?WjVrV0RsTTA2NndlaVBMejlOTnZTTmxrYUNtcUFqa2wxeG1uMkQxYTFJaVl5?=
 =?utf-8?B?dC96alJvUlZWUXpSUElUaGQyQXRkTXFRTEw4VkNJU0I0SnRmTDlvZDNXQ3FK?=
 =?utf-8?B?aEtGbENqN3plKzFGK0RybkVXc05pcXN0TFFNWkl6bm1hVzdSeXFXRXJFVGl0?=
 =?utf-8?B?ZXRqY1E1Q1BBMys5MElYenpmZGtKUGpqOFhUZkdKdTBaTTlrUFR1bzlxQmlE?=
 =?utf-8?B?ZzBjWGtjdEtKYmQ3Y0lJMFlYNWNmN2MrdVJIbzNoUU1GeWM3cVNSNEJFZmcz?=
 =?utf-8?B?cXZ2WCtGS3Z1aE9ZNFRsNXN1TUFoS2dRdHNVSnJ2SmJwWit1M3JZeENibDQy?=
 =?utf-8?B?ZWxXNkJRNXFwWUlUM0pVc3p5emNMT1VQM2l4WGpxenBsMnNCRnNDV3A0VEhL?=
 =?utf-8?B?TVlheDlTRXZ5OTJkWWxYVlBncS82cFhjajVNbFVyY0xtTW1Jc3VSNmlVTUth?=
 =?utf-8?B?K01KV0dhTnBwZkFhcm9xZ1ZFVGcrUzhFN0VmczUyQ0g2TFBtUnQ3dXE3cVRP?=
 =?utf-8?B?VlJkR1N4RDR2NmhzQzZVMmt5a0phbTBRcDhldUEyZmo1YUQwc3k1MFBnV0pl?=
 =?utf-8?B?VDZ1NWRGRE84d0kwbEw0eHB4SDR2S2lJVGRiQVVqVW4vcmZWakFaYW03Q1VV?=
 =?utf-8?Q?hbGTcgAMl98OBz+NO4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2698.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0973127-08b6-40ac-ea81-08d8e2003800
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 07:03:03.8467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xjJPli+ZaewlsztlS5LuZYKNxyjkR+cBHW7+z5gnREfj9UF+rXCFT99M4Fnm9yV42McrxcR4sgeOHUgdeLtbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2474
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_02:2021-03-08,2021-03-08 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5rdXIgQXJvcmEgPGFu
a3VyLmEuYXJvcmFAb3JhY2xlLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCA4LCAyMDIxIDEy
OjI5IFBNDQo+IFRvOiBCaGFyYXQgQmh1c2hhbiA8YmJodXNoYW4yQG1hcnZlbGwuY29tPg0KPiBD
YzogYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IFN1bmlsIEtvdnZ1cmkNCj4gR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+OyB0ZXJt
aW51c0BnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtFWFRdIFJlOiB2ZmlvLXBjaTogcHJvdGVj
dCByZW1hcF9wZm5fcmFuZ2UoKSBmcm9tIHNpbXVsdGFuZW91cw0KPiBjYWxscw0KPiANCj4gT24g
MjAyMS0wMy0wMiA0OjQ3IGEubS4sIEJoYXJhdCBCaHVzaGFuIHdyb3RlOg0KPiA+IEhpIEFua3Vy
LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEFua3Vy
IEFyb3JhIDxhbmt1ci5hLmFyb3JhQG9yYWNsZS5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgRmVi
cnVhcnkgMjYsIDIwMjEgNjoyNCBBTQ0KPiA+PiBUbzogQmhhcmF0IEJodXNoYW4gPGJiaHVzaGFu
MkBtYXJ2ZWxsLmNvbT4NCj4gPj4gQ2M6IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBhbmt1
ci5hLmFyb3JhQG9yYWNsZS5jb207IGxpbnV4LQ0KPiA+PiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsNCj4gPj4gdGVy
bWludXNAZ21haWwuY29tDQo+ID4+IFN1YmplY3Q6IFtFWFRdIFJlOiB2ZmlvLXBjaTogcHJvdGVj
dCByZW1hcF9wZm5fcmFuZ2UoKSBmcm9tDQo+ID4+IHNpbXVsdGFuZW91cyBjYWxscw0KPiA+Pg0K
PiA+PiBFeHRlcm5hbCBFbWFpbA0KPiA+Pg0KPiA+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPj4gLQ0KPiA+
PiBIaSBCaGFyYXQsDQo+ID4+DQo+ID4+IENhbiB5b3UgdGVzdCB0aGUgcGF0Y2ggYmVsb3cgdG8g
c2VlIGlmIGl0IHdvcmtzIGZvciB5b3U/DQo+ID4NCj4gPiBTb3JyeSBmb3IgbGF0ZSByZXBseSwg
SSBhY3R1YWxseSBtaXNzZWQgdGhpcyBlbWFpbC4NCj4gPg0KPiA+IFJlcHJvZHVjaWJpbGl0eSBv
ZiB0aGUgaXNzdWUgd2FzIGxvdyBpbiBteSB0ZXN0IHNjZW5hcmlvLCBvbmUgb3V0IG9mIH4xNSBy
dW5zLiBJDQo+IHJ1biBpdCBtdWx0aXBsZSB0aW1lcywgb3Zlcm5pZ2h0IGFuZCBvYnNlcnZlZCBu
byBpc3N1ZXMuDQo+IA0KPiBBd2Vzb21lLiBXb3VsZCB5b3UgbWluZCBnaXZpbmcgbWUgeW91ciBU
ZXN0ZWQtYnkgZm9yIHRoZSBwYXRjaD8NCg0KU3VyZSwgcGxlYXNlIHBvaW50IGlmIHRoaXMgaXMg
YWxyZWFkeSBzZW50IGZvciByZXZpZXcuDQoNCj4gDQo+ID4+IEFsc28gY291bGQgeW91IGFkZCBz
b21lIG1vcmUgZGV0YWlsIHRvIHlvdXIgZWFybGllciBkZXNjcmlwdGlvbiBvZg0KPiA+PiB0aGUg
YnVnPw0KPiA+DQo+ID4gT3VyIHRlc3QgY2FzZSBpcyBydW5uaW5nIE9EUCBtdWx0aS10aHJlYWRl
ZCBhcHBsaWNhdGlvbiwgd2hlcmUgcGFyZW50IHByb2Nlc3MNCj4gbWFwcyAoeWVzIGl0IHVzZXMg
TUFQX0RNQSkgdGhlIHJlZ2lvbiBhbmQgdGhlbiBjaGlsZCBwcm9jZXNzZXMgYWNjZXNzIHNhbWUu
DQo+IEFzIGEgd29ya2Fyb3VuZCB3ZSB0cmllZCBhY2Nlc3NpbmcgdGhlIHJlZ2lvbiBvbmNlIGJ5
IHBhcmVudCBwcm9jZXNzIGJlZm9yZQ0KPiBjcmVhdGluZyBvdGhlciBhY2Nlc3NvciB0aHJlYWRz
IGFuZCBpdCB3b3JrZWQgYXMgZXhwZWN0ZWQuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBkZXRhaWwu
IFNvIGlmIHRoZSBjaGlsZCBwcm9jZXNzZXMgc3RhcnQgZWFybHkgLS0gdGhleSBtaWdodCBmYXVs
dCB3aGlsZQ0KPiB0aGUgVkZJT19JT01NVV9NQVBfRE1BIHdhcyBnb2luZyBvbi4gQW5kLCBzaW5j
ZSB0aGV5IG9ubHkgYWNxdWlyZQ0KPiBtbWFwX2xvY2sgaW4gUk8gbW9kZSwgYm90aCBwYXRocyB3
b3VsZCBlbmQgdXAgY2FsbGluZyBpb19yZW1hcF9wZm5fcmFuZ2UoKQ0KPiB2aWEgdGhlIGZhdWx0
IGhhbmRsZXIuDQoNClllcywgdGhhdCdzIGNvcnJlY3QuDQoNClRoYW5rcw0KLUJoYXJhdA0KDQo+
IA0KPiBUaGFua3MNCj4gQW5rdXINCj4gDQo+ID4NCj4gPiBUaGFua3MNCj4gPiAtQmhhcmF0DQo+
ID4NCj4gPj4gSW4gcGFydGljdWxhciwgQUZBSUNTIHlvdSBhcmUgdXNpbmcgT0RQICgtRFBESz8p
IHdpdGggbXVsdGlwbGUNCj4gPj4gdGhyZWFkcyB0b3VjaGluZyB0aGlzIHJlZ2lvbi4gRnJvbSB5
b3VyIHN0YWNrLCBpdCBsb29rcyBsaWtlIHRoZQ0KPiA+PiBmYXVsdCB3YXMgdXNlci1zcGFjZSBn
ZW5lcmF0ZWQsIGFuZCBJJ20gZ3Vlc3NpbmcgeW91IHdlcmUgbm90IHVzaW5nDQo+ID4+IHRoZSBW
RklPX0lPTU1VX01BUF9ETUEuDQo+ID4+DQo+ID4+IEFua3VyDQo+ID4+DQo+ID4+IC0tID44IC0t
DQo+ID4+DQo+ID4+IFN1YmplY3Q6IFtQQVRDSF0gdmZpby1wY2k6IHByb3RlY3QgaW9fcmVtYXBf
cGZuX3JhbmdlKCkgZnJvbQ0KPiA+PiBzaW11bHRhbmVvdXMgY2FsbHMNCj4gPj4NCj4gPj4gdmZp
b19wY2lfbW1hcF9mYXVsdCgpIG1hcHMgdGhlIGNvbXBsZXRlIFZNQSBvbiBmYXVsdC4gV2l0aCBj
b25jdXJyZW50DQo+ID4+IGZhdWx0cywgdGhpcyB3b3VsZCByZXN1bHQgaW4gbXVsdGlwbGUgY2Fs
bHMgdG8gaW9fcmVtYXBfcGZuX3JhbmdlKCksDQo+ID4+IHdoZXJlIGl0IHdvdWxkIGhpdCBhIEJV
R19PTighcHRlX25vbmUoKnB0ZSkpIGluIHJlbWFwX3B0ZV9yYW5nZSgpLg0KPiA+PiAoSXQgd291
bGQgYWxzbyBsaW5rIHRoZSBzYW1lIFZNQSBtdWx0aXBsZSB0aW1lcyBpbiB2ZGV2LT52bWFfbGlz
dCBidXQNCj4gPj4gZ2l2ZW4gdGhlIEJVR19PTiB0aGF0IGlzIGxlc3Mgc2VyaW91cy4pDQo+ID4+
DQo+ID4+IE5vcm1hbGx5LCBob3dldmVyLCB0aGlzIHdvbid0IGhhcHBlbiAtLSBhdCBsZWFzdCB3
aXRoDQo+ID4+IHZmaW9faW9tbXVfdHlwZTEgLS0gdGhlIFZGSU9fSU9NTVVfTUFQX0RNQSBwYXRo
IGlzIHByb3RlY3RlZCBieQ0KPiBpb21tdS0+bG9jay4NCj4gPj4NCj4gPj4gSWYsIGhvd2V2ZXIs
IHdlIGFyZSB1c2luZyBzb21lIGtpbmQgb2YgcGFyYWxsZWxpemF0aW9uIG1lY2hhbmlzbSBsaWtl
DQo+ID4+IHRoaXMgb25lIHdpdGgga3Rhc2sgdW5kZXIgZGlzY3Vzc2lvbiBbMV0sIHdlIHdvdWxk
IGhpdCB0aGlzLg0KPiA+PiBFdmVuIGlmIHdlIHdlcmUgZG9pbmcgdGhpcyBzZXJpYWxseSwgZ2l2
ZW4gdGhhdCB2ZmlvLXBjaSByZW1hcHMgYQ0KPiA+PiBsYXJnZXIgZXh0ZW50IHRoYW4gc3RyaWN0
bHkgbmVjZXNzYXJ5IGl0IHNob3VsZCBpbnRlcm5hbGx5IGVuZm9yY2UNCj4gPj4gY29oZXJlbmNl
IG9mIGl0cyBkYXRhIHN0cnVjdHVyZXMuDQo+ID4+DQo+ID4+IEhhbmRsZSB0aGlzIGJ5IHVzaW5n
IHRoZSBWTUEncyBwcmVzZW5jZSBpbiB0aGUgdmRldi0+dm1hX2xpc3QgYXMNCj4gPj4gaW5kaWNh
dGl2ZSBvZiBhIGZ1bGx5IG1hcHBlZCBWTUEgYW5kIHJldHVybmluZyBzdWNjZXNzIGVhcmx5IHRv
IGFsbA0KPiA+PiBidXQgdGhlIGZpcnN0IFZNQSBmYXVsdC4gTm90ZSB0aGF0IHRoaXMgaXMgY2xl
YXJseSBvcHRpbXN0aWMgZ2l2ZW4NCj4gPj4gdGhhdCB0aGUgbWFwcGluZyBpcyBvbmdvaW5nLCBh
bmQgbWlnaHQgbWVhbiB0aGF0IHRoZSBjYWxsZXIgc2VlcyBtb3JlDQo+ID4+IGZhdWx0cyB1bnRp
bCB0aGUgcmVtYXAgaXMgZG9uZS4NCj4gPj4NCj4gPj4gWzFdDQo+ID4+IGh0dHBzOi8vdXJsZGVm
ZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnXw0K
PiA+PiBsaW51eC0NCj4gPj4gMkRtbV8yMDE4MTEwNTE0NTE0MS42Zjk5MzdmNi0NCj4gPj4NCj4g
NDB3NTIwLmhvbWVfJmQ9RHdJREFnJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRmUSZyPVBBQWxXc3dQ
ZTdkOGdIbA0KPiA+Pg0KPiBHYkNMbXkyWWV6eUs3TzNIdl90MmhlR25vdUJ3Jm09M1pEWHFubjl4
TlVDamdYd045bUhJS1Q3b3lYdTU1UA0KPiA+PiBVN3lWMmowYi01aHcmcz1oaUlDa050cmNINEFi
QVdScmJrdk1VeWxwN0J2MFlIRkNqeE5HQzZDR09rJmU9DQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYt
Ynk6IEFua3VyIEFyb3JhIDxhbmt1ci5hLmFyb3JhQG9yYWNsZS5jb20+DQo+ID4+IC0tLQ0KPiA+
PiAgIGRyaXZlcnMvdmZpby9wY2kvdmZpb19wY2kuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysr
KysrKy0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZmlvL3BjaS92ZmlvX3BjaS5j
DQo+ID4+IGIvZHJpdmVycy92ZmlvL3BjaS92ZmlvX3BjaS5jIGluZGV4IDY1ZTdlNmI0NDU3OC4u
YjlmNTA5ODYzZGIxIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3ZmaW8vcGNpL3ZmaW9fcGNp
LmMNCj4gPj4gKysrIGIvZHJpdmVycy92ZmlvL3BjaS92ZmlvX3BjaS5jDQo+ID4+IEBAIC0xNTcz
LDYgKzE1NzMsMTEgQEAgc3RhdGljIGludCBfX3ZmaW9fcGNpX2FkZF92bWEoc3RydWN0DQo+ID4+
IHZmaW9fcGNpX2RldmljZSAqdmRldiwNCj4gPj4gICB7DQo+ID4+ICAgCXN0cnVjdCB2ZmlvX3Bj
aV9tbWFwX3ZtYSAqbW1hcF92bWE7DQo+ID4+DQo+ID4+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeSht
bWFwX3ZtYSwgJnZkZXYtPnZtYV9saXN0LCB2bWFfbmV4dCkgew0KPiA+PiArCQlpZiAobW1hcF92
bWEtPnZtYSA9PSB2bWEpDQo+ID4+ICsJCQlyZXR1cm4gMTsNCj4gPj4gKwl9DQo+ID4+ICsNCj4g
Pj4gICAJbW1hcF92bWEgPSBrbWFsbG9jKHNpemVvZigqbW1hcF92bWEpLCBHRlBfS0VSTkVMKTsN
Cj4gPj4gICAJaWYgKCFtbWFwX3ZtYSkNCj4gPj4gICAJCXJldHVybiAtRU5PTUVNOw0KPiA+PiBA
QCAtMTYxMyw2ICsxNjE4LDcgQEAgc3RhdGljIHZtX2ZhdWx0X3QgdmZpb19wY2lfbW1hcF9mYXVs
dChzdHJ1Y3QNCj4gPj4gdm1fZmF1bHQNCj4gPj4gKnZtZikNCj4gPj4gICAJc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWEgPSB2bWYtPnZtYTsNCj4gPj4gICAJc3RydWN0IHZmaW9fcGNpX2Rldmlj
ZSAqdmRldiA9IHZtYS0+dm1fcHJpdmF0ZV9kYXRhOw0KPiA+PiAgIAl2bV9mYXVsdF90IHJldCA9
IFZNX0ZBVUxUX05PUEFHRTsNCj4gPj4gKwlpbnQgdm1hX3ByZXNlbnQ7DQo+ID4+DQo+ID4+ICAg
CW11dGV4X2xvY2soJnZkZXYtPnZtYV9sb2NrKTsNCj4gPj4gICAJZG93bl9yZWFkKCZ2ZGV2LT5t
ZW1vcnlfbG9jayk7DQo+ID4+IEBAIC0xNjIzLDcgKzE2MjksMjEgQEAgc3RhdGljIHZtX2ZhdWx0
X3QgdmZpb19wY2lfbW1hcF9mYXVsdChzdHJ1Y3QNCj4gPj4gdm1fZmF1bHQgKnZtZikNCj4gPj4g
ICAJCWdvdG8gdXBfb3V0Ow0KPiA+PiAgIAl9DQo+ID4+DQo+ID4+IC0JaWYgKF9fdmZpb19wY2lf
YWRkX3ZtYSh2ZGV2LCB2bWEpKSB7DQo+ID4+ICsJLyoNCj4gPj4gKwkgKiBfX3ZmaW9fcGNpX2Fk
ZF92bWEoKSBlaXRoZXIgYWRkcyB0aGUgdm1hIHRvIHRoZSB2ZGV2LT52bWFfbGlzdA0KPiA+PiAr
CSAqICh2bWFfcHJlc2VudCA9PSAwKSwgb3IgaW5kaWNhdGVzIHRoYXQgdGhlIHZtYSBpcyBhbHJl
YWR5IHByZXNlbnQNCj4gPj4gKwkgKiBvbiB0aGUgbGlzdCAodm1hX3ByZXNlbnQgPT0gMSkuDQo+
ID4+ICsJICoNCj4gPj4gKwkgKiBPdmVybG9hZCB0aGUgbWVhbmluZyBvZiB0aGlzIGZsYWcgdG8g
YWxzbyBpbXBseSB0aGF0IHRoZSB2bWEgaXMNCj4gPj4gKwkgKiBmdWxseSBtYXBwZWQuIFRoaXMg
YWxsb3dzIHVzIHRvIHNlcmlhbGl6ZSB0aGUgbWFwcGluZyAtLSBlbnN1cmluZw0KPiA+PiArCSAq
IHRoYXQgc2ltdWx0YW5lb3VzIGZhdWx0cyB3aWxsIG5vdCBib3RoIHRyeSB0byBjYWxsDQo+ID4+
ICsJICogaW9fcmVtYXBfcGZuX3JhbmdlKCkuDQo+ID4+ICsJICoNCj4gPj4gKwkgKiBIb3dldmVy
LCB0aGlzIG1pZ2h0IG1lYW4gdGhhdCBjYWxsZXJzIHRvIHdoaWNoIHdlIHJldHVybmVkIHN1Y2Nl
c3MNCj4gPj4gKwkgKiBvcHRpbWlzdGljYWxseSB3aWxsIHNlZSBtb3JlIGZhdWx0cyB1bnRpbCB0
aGUgcmVtYXAgaXMgY29tcGxldGUuDQo+ID4+ICsJICovDQo+ID4+ICsJdm1hX3ByZXNlbnQgPSBf
X3ZmaW9fcGNpX2FkZF92bWEodmRldiwgdm1hKTsNCj4gPj4gKwlpZiAodm1hX3ByZXNlbnQgPCAw
KSB7DQo+ID4+ICAgCQlyZXQgPSBWTV9GQVVMVF9PT007DQo+ID4+ICAgCQltdXRleF91bmxvY2so
JnZkZXYtPnZtYV9sb2NrKTsNCj4gPj4gICAJCWdvdG8gdXBfb3V0Ow0KPiA+PiBAQCAtMTYzMSw2
ICsxNjUxLDkgQEAgc3RhdGljIHZtX2ZhdWx0X3QgdmZpb19wY2lfbW1hcF9mYXVsdChzdHJ1Y3QN
Cj4gPj4gdm1fZmF1bHQNCj4gPj4gKnZtZikNCj4gPj4NCj4gPj4gICAJbXV0ZXhfdW5sb2NrKCZ2
ZGV2LT52bWFfbG9jayk7DQo+ID4+DQo+ID4+ICsJaWYgKHZtYV9wcmVzZW50KQ0KPiA+PiArCQln
b3RvIHVwX291dDsNCj4gPj4gKw0KPiA+PiAgIAlpZiAoaW9fcmVtYXBfcGZuX3JhbmdlKHZtYSwg
dm1hLT52bV9zdGFydCwgdm1hLT52bV9wZ29mZiwNCj4gPj4gICAJCQkgICAgICAgdm1hLT52bV9l
bmQgLSB2bWEtPnZtX3N0YXJ0LCB2bWEtDQo+ID4+PiB2bV9wYWdlX3Byb3QpKQ0KPiA+PiAgIAkJ
cmV0ID0gVk1fRkFVTFRfU0lHQlVTOw0KPiA+PiAtLQ0KPiA+PiAyLjI5LjINCj4gPg0K
