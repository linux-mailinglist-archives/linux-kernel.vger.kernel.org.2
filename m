Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7952E3F5395
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 01:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhHWXRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 19:17:55 -0400
Received: from mail-eopbgr1410049.outbound.protection.outlook.com ([40.107.141.49]:51360
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233137AbhHWXRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 19:17:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKWovc+injLyDyyNJ++r4dee/ld5JJpwoweyGIJzjKQ0v/jsqdKSgZ2inhoV4CYRztHSULUS1K+cLF8x5UT2/iRG3Rio/oodqelCvpebp12sTNxw5dUovpkytZhORbJ/ThNPgsQzTkYugtkUo9+VC0MWqpo/fF9q5hI3KLsO0b9RxRpm62G6cwPElC1WtNiXmTVCkD6LwYKH3Kwq2afZ5TiAZadEcBCccF7CUFLar1LXjoLCXCi8Piz9PdwkPlCS7DLg3RgfaVdvD2Bg4J2u0HND/K7JgE3i0XGn/DpPEMNT63nu7XTPK5KPlAJkmVrUay54tAKB/eDOV2i2PR5kag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlQtdENtfHXWNiqz8dsc2+rLcbNDTYRBRCFWRV/TsIU=;
 b=DOrWbqPDEQd7XuezL3L0S/j8SJYVV7+3GH7K8b643lpbcWd0VeKNO4l9AumUO/g6iamHn0O4rYjZvQsL40E+TgsAaKB43EXXid1JUWBXGyyhesbFrllVNaGtWsdYkC5Q3YKSt5iv7Jkz+VEnb23B02BPVVSVCJrTB5tduCvP+D2Yrr96k/p1Zhc9AkjjWnTuUgARW/+vyEaMqwi/pbFjp+goaGhH25did/EWBGuk+88yGuHJQ3/XZok8OdHwbYlQeZX+rlcrJ24D6+gnBqti8XOkxaiOFTHgQzbdHIrtaO7K3JO6aZkiasYzeNlJZuFNWd9yKYgBaxDZoGPvw0i13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlQtdENtfHXWNiqz8dsc2+rLcbNDTYRBRCFWRV/TsIU=;
 b=hA4zDhFfWp45Qu+cWMdtdhx32wLx+TLJXHAS7jQexgPpvtDfYj39taokIY8/alBeioY6lTL8p0wZ4UWcHMUAbjJgs+K+i8WLXn49I1t68uSj6zbB2461QhNI30YXO2Ct2lgg4GpYpfX1vPFVjQWvYjGb8JPhrjLuT1hhVWJuWTw=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB6527.jpnprd01.prod.outlook.com (2603:1096:400:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 23:17:03 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 23:17:03 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "osalvador@suse.de" <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        "david@redhat.com" <david@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
Thread-Topic: [v2 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
Thread-Index: AQHXlLzdYeiiCRicSE2McTnzojcv9qt79U4AgADG5ACAA9NMAIAA1MuAgABcMgA=
Date:   Mon, 23 Aug 2021 23:17:02 +0000
Message-ID: <20210823231702.GA1801919@hori.linux.bs1.fc.nec.co.jp>
References: <20210819054116.266126-1-shy828301@gmail.com>
 <20210819054116.266126-3-shy828301@gmail.com>
 <20210820064832.GA63355@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkqnBbqz7rHTQWsBKdq5uSdKDJX=iDz+HDyF2Jo6CX3H1g@mail.gmail.com>
 <20210823050526.GA1452382@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkoUavFuBSHRunvptAUynehFxfs-aAywmE4MjaLi16nL3A@mail.gmail.com>
In-Reply-To: <CAHbLzkoUavFuBSHRunvptAUynehFxfs-aAywmE4MjaLi16nL3A@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fc5e62c-29e3-44bb-00f4-08d9668c1dc6
x-ms-traffictypediagnostic: TYCPR01MB6527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB6527DE41E9EA6B2AF6DB6F36E7C49@TYCPR01MB6527.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uv4KVEfi5iY+xDO8ViaupuYkwLhhLwQnpu6QFntbKAIUVY3gu+99cnFb4PLL2Y3Ei8Lvsd8bDFjCsqgYaRt3ZYnpRzXufeT+xNWwU9GDvlaE/Yo/a6Hg8Zq1MEFPsplapXWBxRa65j2iGz4RaJMVySmmAmvpzPolealn79zM6i019NGNEoLy7cVeuPkVVuXqqUB3T46GjuHGEstNGlb3VLDlY5UJkI0QwgqUg57O8fykhdgDpDLMVU113C+fkj0xkenFRI/G0j7SY0ZDoddfVBDae8sDl+0TC0N4wT7p7TKAneYZzS+x8zk0ul+0EvnBx1Icehb4Uf5h1JxL8br7lxZZRJkFsrBVPhyRq+/yLaTjghcZ4PQ/35LzLVKOO0vQ0YDB9mtSk5OWJcDkGcsEGR80f7VJOaNar0f9seaAzgnp82CR1O7GWAD/EFUZ/OB0vbGZRhMHnW0sHUDUl8Bn3tbytpU9sDD97OBMK7aeJ9PxL5y9SX2NERpmHqMtisLNdjab7YnKIiA9vWNGxz+sXq0ocCqOlRcU9JMThmIHzqmFjn8W33WPvd/UPPMXCIYAsRBVrCWOnIvTMo9ZA4o6Q4e33S4KX4EKYCGUdGXowRiYt2LVjDGvEJ0RSnrXbEcnVf45KKaYjGARJZSUX4tw0S4fcF1TPx3pOL/GyUtsXiZ320dtrDcPWlHoAhNstTlX2rMR26JHv8POim85l1m0Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(376002)(346002)(396003)(136003)(55236004)(6512007)(9686003)(8676002)(85182001)(54906003)(6506007)(53546011)(64756008)(66476007)(186003)(8936002)(66946007)(76116006)(66556008)(66446008)(6486002)(26005)(316002)(83380400001)(1076003)(86362001)(122000001)(478600001)(5660300002)(71200400001)(6916009)(33656002)(2906002)(38100700002)(38070700005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDAzdlFRUmNzcmw0eUh2VkRwdjgvSlAwekFTTUZ1akRyRGRacnhTOS9BMllz?=
 =?utf-8?B?S0toVkpXVWJqcTJUdjYxS1l0aTZCMmkxVDdlblBhb0d0OEVJMEttdHB1ZThz?=
 =?utf-8?B?QWZxbkhGUDV1MnVDNkJNSzdzSWRsTFlsNDI3RFhCU3dNZ2UzcU9vdjBZVTIr?=
 =?utf-8?B?LzJrUm52S3FqWndnNVpneEdraEdsSFBaZFFFaklWR2lzUjhsS2Y5aGswYUdW?=
 =?utf-8?B?MW12VnNqUkJLV2hGRmhveGcvdy9KWGNnUlVTaEpRWWNGbE5ySzEvQVh2VitT?=
 =?utf-8?B?NnhxS0xmbHpPdmE2UlJSY2dmcEZFblhycEdOR2N6SHlHdm9PTERqTWxzMFA5?=
 =?utf-8?B?UFBSVERpazJ3UzlQOGEvUlJSREdObXZxVmJiT1VsaDhmTXdhanpObStySi9t?=
 =?utf-8?B?RkczMXNuQ2g4cG9LM3FiSVMyWFVJd3M2SHJuUzQyMHhLd2Nmby9tcHV6WEQ0?=
 =?utf-8?B?UjROcXdkRHZYb1BBZnFVUUdmZUJnZ0liM3VrM0NWTi9LeVVBZ0FITndCZm1z?=
 =?utf-8?B?dTlUbFY4OFEvL1U2NHZwd0ZqcmhNbkpnMlpKcnlxczVLU1BmVnoyRnZLV1VF?=
 =?utf-8?B?YzZzeXFqamFQYmxXSnZlaVVRZzBRQnZ5Z0FlMUgrK0ltOTFidUs3akNYSWUr?=
 =?utf-8?B?ZTJCaXg3YlFDMGVQUG5ud2hWbzZPZHUrdnNxRXVQa1o5SEpSamNmNHZXOVEr?=
 =?utf-8?B?Vk5vTzk2bXJzaGpXNkNnb282TUU0S2RXSy9jN2w5ampOaTBZQXh0aXEwd3Ru?=
 =?utf-8?B?c0lpVHRobUFHU05GVk50Z3AxbVJIMDVEMjBEa1pjUnd1SzJncUFNcUNibjkw?=
 =?utf-8?B?ZlFsNFg0VFFUTVBOY2Fmc0EwR3daOENveklNeXlZL014bUIyQ3hCemMzbmhu?=
 =?utf-8?B?QW5KcWs4eVFyRkF1Z3JrZUZQMTFreDRoaXg0YXFrNFIzZ3BTQXFaQlcxdUM3?=
 =?utf-8?B?bmFSRWY4eTA1NU1wYzhoMFdwa2JXUEVlOTBsclB1amNieURzdFlyL2pGSi9X?=
 =?utf-8?B?eFd6ZmMvL0dncjRBQkZ4ck90d1o5UjcrNThmR3ltT1F4L2pKK0pMTUx5aHo3?=
 =?utf-8?B?Q2Q5MzFUOS9IYmRsV0VaTjQxNXVLLzFnM2Z1L1RWQ2lpcjR6K1N3M0YyeDVU?=
 =?utf-8?B?eHFsTmFrVVhTNXlEVmRScUtGMDdGTHB4UU5VNEVWRW03cGtlZWU0aVpDZisr?=
 =?utf-8?B?Y0lqbkhlclBxU0NBbnJJYVMzbWg3djcyY1VBSVNnK0VVT0ZDMWYvNmhwTHha?=
 =?utf-8?B?VG85SWxRdExRbXVLUEFuaVFjaHZtb1RkYjZ6Mng1dTNXeGtxZXZqUTZydUVn?=
 =?utf-8?B?cWFHZG85S0JJZk5QMVhEVU1OdkZmeDBLWVRKZE1UK3dQWWNFVm9VNm5BRE9u?=
 =?utf-8?B?c25aajRTTVkxMitFRE1SZ0djVTBZNW5sVUFLWGd4dnZtazZUZ2VlZSt4cWVH?=
 =?utf-8?B?OGYySVRQS1RFUTRkcUJNSTZ1SzBvMlFCYXl2YXFYdnJhSzZFc1lWY0M1SVBO?=
 =?utf-8?B?WFpyTlgvQjJ4VllBUFVpTWRsMFlGRVJGMDVHSUFaekx1TUpVNGFLaDcwV3Ax?=
 =?utf-8?B?RmxPWEtmc0VjdDBma1lQQmhuWVB3YjhPTmR6MHdaVWViOG1lMnloRXVLQ2tu?=
 =?utf-8?B?alFpMmZPdmk5Ny9vU2tEa0tWSWhFQ1BYWnorU0I0RU1ucERBMEg3MU45OFBQ?=
 =?utf-8?B?WWpaalVhVkpHSkpUMUUxZks0STZ1OEJPMzRpa1U4YzQrd1dwZzlkUE1tM0FR?=
 =?utf-8?B?Z3lNK2RwODcrV24rSHNVMlBoMjVtMnhZMUJZcVBrMFhlSnBNNjBONEdoa045?=
 =?utf-8?B?UGdDYnBwVjNDNldMcnZOUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CF47285E5241E4D87FAE843BCCA39A3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc5e62c-29e3-44bb-00f4-08d9668c1dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 23:17:02.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGWoA2VxN0ZMesaDgkwh6EgdWpVxQ5i0bxZCyxnwfkdV5KXgZjkErCniQ4Opun2cRvfLUh8zm7L/kcYAq3S1nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6527
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMjMsIDIwMjEgYXQgMTA6NDc6MDNBTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IE9uIFN1biwgQXVnIDIyLCAyMDIxIGF0IDEwOjA1IFBNIEhPUklHVUNISSBOQU9ZQSjloIDl
j6PjgIDnm7TkuZ8pDQo+IDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBPbiBGcmksIEF1ZyAyMCwgMjAyMSBhdCAxMTo0MDoyNEFNIC0wNzAwLCBZYW5nIFNoaSB3cm90
ZToNCj4gPiA+IE9uIFRodSwgQXVnIDE5LCAyMDIxIGF0IDExOjQ4IFBNIEhPUklHVUNISSBOQU9Z
QSjloIDlj6PjgIDnm7TkuZ8pDQo+ID4gPiA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+IHdyb3Rl
Og0KPiA+ID4gPg0KPiA+ID4gPiBPbiBXZWQsIEF1ZyAxOCwgMjAyMSBhdCAxMDo0MToxNlBNIC0w
NzAwLCBZYW5nIFNoaSB3cm90ZToNCj4gPiA+ID4gPiBDdXJyZW50bHkganVzdCB2ZXJ5IHNpbXBs
ZSBtZXNzYWdlIGlzIHNob3duIGZvciB1bmhhbmRsYWJsZSBwYWdlLCBlLmcuDQo+ID4gPiA+ID4g
bm9uLUxSVSBwYWdlLCBsaWtlOg0KPiA+ID4gPiA+IHNvZnRfb2ZmbGluZTogMHgxNDY5ZjI6IHVu
a25vd24gbm9uIExSVSBwYWdlIHR5cGUgNWZmZmYwMDAwMDAwMDAwICgpDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBJdCBpcyBub3QgdmVyeSBoZWxwZnVsIGZvciBmdXJ0aGVyIGRlYnVnLCBjYWxsaW5n
IGR1bXBfcGFnZSgpIGNvdWxkIHNob3cNCj4gPiA+ID4gPiBtb3JlIHVzZWZ1bCBpbmZvcm1hdGlv
bi4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IENhbGxpbmcgZHVtcF9wYWdlKCkgaW4gZ2V0X2FueV9w
YWdlKCkgaW4gb3JkZXIgdG8gbm90IGR1cGxpY2F0ZSB0aGUgY2FsbA0KPiA+ID4gPiA+IGluIGEg
Y291cGxlIG9mIGRpZmZlcmVudCBwbGFjZXMuICBJdCBtYXkgYmUgY2FsbGVkIHdpdGggcGNwIGRp
c2FibGVkIGFuZA0KPiA+ID4gPiA+IGhvbGRpbmcgbWVtb3J5IGhvdHBsdWcgbG9jaywgaXQgc2hv
dWxkIGJlIG5vdCBhIGJpZyBkZWFsIHNpbmNlIGh3cG9pc29uDQo+ID4gPiA+ID4gaGFuZGxlciBp
cyBub3QgY2FsbGVkIHZlcnkgb2Z0ZW4uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTdWdnZXN0ZWQt
Ynk6IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPg0KPiA+ID4gPiA+IENjOiBO
YW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+ID4gPiA+IENjOiBP
c2NhciBTYWx2YWRvciA8b3NhbHZhZG9yQHN1c2UuZGU+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogWWFuZyBTaGkgPHNoeTgyODMwMUBnbWFpbC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+
ID4gIG1tL21lbW9yeS1mYWlsdXJlLmMgfCAzICsrKw0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbW0v
bWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gPiA+ID4gPiBpbmRleCA3
Y2ZhMTM0YjEzNzAuLjYwZGY4ZmNkMDQ0NCAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9tbS9tZW1v
cnktZmFpbHVyZS5jDQo+ID4gPiA+ID4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+ID4g
PiA+IEBAIC0xMjI4LDYgKzEyMjgsOSBAQCBzdGF0aWMgaW50IGdldF9hbnlfcGFnZShzdHJ1Y3Qg
cGFnZSAqcCwgdW5zaWduZWQgbG9uZyBmbGFncykNCj4gPiA+ID4gPiAgICAgICAgICAgICAgIHJl
dCA9IC1FSU87DQo+ID4gPiA+ID4gICAgICAgfQ0KPiA+ID4gPiA+ICBvdXQ6DQo+ID4gPiA+ID4g
KyAgICAgaWYgKHJldCA9PSAtRUlPKQ0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgZHVtcF9wYWdl
KHAsICJod3BvaXNvbjogdW5oYW5kbGFibGUgcGFnZSIpOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4N
Cj4gPiA+ID4gSSBmZWVsIHRoYXQgNCBjYWxsZXJzIG9mIGdldF9od3BvaXNvbl9wYWdlKCkgYXJl
IGluIHRoZSBkaWZmZXJlbnQgY29udGV4dCwNCj4gPiA+ID4gc28gaXQgbWlnaHQgYmUgYmV0dGVy
IHRvIGNvbnNpZGVyIHRoZW0gc2VwYXJhdGVseSB0byBhZGQgZHVtcF9wYWdlKCkgb3Igbm90Lg0K
PiA+ID4gPiBzb2Z0X29mZmxpbmVfcGFnZSgpIHN0aWxsIHByaW50cyBvdXQgIiVzOiAlI2x4OiB1
bmtub3duIHBhZ2UgdHlwZTogJWx4ICglcEdwKSINCj4gPiA+DQo+ID4gPiBObyBzdHJvbmcgb3Bp
bmlvbiB0byBrZWVwIG9yIHJlbW92ZSBpdC4NCj4gPg0KPiA+IFJlYWRpbmcgdGhlIGV4cGxhbmF0
aW9uIGJlbG93LCBJIHRoaW5rIHRoYXQgY2FsbGluZyBkdW1wX3BhZ2UoKSBpbiB0aGUNCj4gPiBv
cmlnaW5hbCBwbGFjZSBpcyBmaW5lLiAgU28gbGV0J3MgcmVtb3ZlICJlbHNlIGlmIChyZXQgPT0g
MCkiIGJsb2NrIGluDQo+ID4gc29mdF9vZmZsaW5lX3BhZ2UoKS4NCj4gDQo+IFRoZSAiZWxzZSBp
ZiAocmV0ID09IDApIiBibG9jayBpcyB1c2VkIHRvIGhhbmRsZSBmcmVlIHBhZ2UgSUlVQy4gSSdt
DQo+IHN1cHBvc2VkIHlvdSBtZWFuIHRoZSAiZWxzZSBpZiAocmV0ID09IC1FSU8pIiBibG9jayB3
aGljaCBqdXN0IGNhbGxzDQo+IHByaW50ay4NCg0KU29ycnksIHlvdSdyZSByaWdodC4gSSBtaXNz
LWNvcGllZCB0aGUgbGluZS4NCg0KLSBOYW95YSBIb3JpZ3VjaGk=
