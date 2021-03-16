Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8A33D872
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhCPP6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:58:05 -0400
Received: from mail-eopbgr660080.outbound.protection.outlook.com ([40.107.66.80]:12443
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233786AbhCPP5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:57:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6KWA4/QV4SXL3a7MkQhXrUNy2oY2/DNNnOhSkljVbpgf29ccITgtXxNZ6WgdlCBi4etxFX0Kq+HiCfYQm7hP7sb6RDupAQ98yRxeZqeZGUnUngkC8hNCk7kvaIFNWP1zyrrGOSrIAfOJ8n3+WtH2QL/G5CBqcqx2Kbx/BRC/iY1SSOmOXSuEaAbya+jr73TBs/FxnGlV8+uJd7ISHec1eItz+s2ntdae0eoDMzFgWfPveeH+ueIT5lGyIuzFmvlgdhwQ9zO+GrJaQBgYf9Cy7X+jYC0sqPxnc4F8/IkMJDSf4//jCSCcjze+qooJTdN59yezxf+hKQTmrPUAJw2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LshrN3/NVX9nt6Mea2oNrDKqN4jFX5+pW0qMOi54vFc=;
 b=HqF76kL9njGEd1pXDrpMq/4NrpV0ibIFIX7dxaBdAvEx1UyhvTYL8Sbogt3qV5uTGoScOzs+u5uwitLfmAnrsSFOz+Ha0wpq1SH7M24MOODzqDrdg6Whne3bv8z/OMJfLTuHilSrcGdMF95mMwMolQT3lh2tvlVqGtupSVmBZzqIAmk4UV/EUty8i15VVnEfcWLWitSC7VIfOYk3NNosm/ra6pp+6m7XmpAUSy9UdtVoGKKAhmfCSr4lXwqMwoAY3VygGbxam/z0gbMi54p4ZL7aKoYkwSEfal72Bt/uj4D+bbqxSjbojEdcwHFgGj6oRpWh8VyAHappCrSL/H9RPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stfx.ca; dmarc=pass action=none header.from=stfx.ca; dkim=pass
 header.d=stfx.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stfxca.onmicrosoft.com; s=selector2-stfxca-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LshrN3/NVX9nt6Mea2oNrDKqN4jFX5+pW0qMOi54vFc=;
 b=DTkku+QAK00xksf4rH0oGh/RwT9gy7+wslEwJPOj4atJjGCRztcffHbaCoz+Y/z3rryaiuV6RthY0YCPCue+eTVu5V6eMG+rQiOvMfZULQ5tn+3xDJiW8qXblMpidufGq4QCWdlt/JVPHktVGvdVYM32mkRQEVHdydudkK30DNk=
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:17::19)
 by YTBPR01MB2351.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:19::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 15:57:42 +0000
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3]) by YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 15:57:41 +0000
From:   "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIDAxLzEwXSB0aWNrL25vaHo6IFByZXZlbnQgdGlja19u?=
 =?gb2312?B?b2h6X2dldF9zbGVlcF9sZW5ndGgoKSBmcm9tIHJldHVybmluZyBuZWdhdGl2?=
 =?gb2312?Q?e_value?=
Thread-Topic: [PATCH 01/10] tick/nohz: Prevent tick_nohz_get_sleep_length()
 from returning negative value
Thread-Index: AQHXFnNGiA2JtEhS2EiDRBkCbpwkF6qGkOKAgAAVHICAABBdgIAABRoAgAAI/QCAAAjRvw==
Date:   Tue, 16 Mar 2021 15:57:41 +0000
Message-ID: <YTBPR01MB32623E6AC71C9F7670469A47C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-2-frederic@kernel.org>
 <YFCiycIaViYCy3GH@hirez.programming.kicks-ass.net>
 <20210316133703.GC639918@lothringen>
 <YFDCOYstnDWPSWRU@hirez.programming.kicks-ass.net>
 <20210316145352.GE639918@lothringen>,<ab753f1f-b03d-2a26-a552-b91f98708353@intel.com>
In-Reply-To: <ab753f1f-b03d-2a26-a552-b91f98708353@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=stfx.ca;
x-originating-ip: [141.109.104.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 754e3516-225a-4256-bf12-08d8e8943b36
x-ms-traffictypediagnostic: YTBPR01MB2351:
x-microsoft-antispam-prvs: <YTBPR01MB23511C3FCEB369C39DA4A532C46B9@YTBPR01MB2351.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IzcuxIG+JQkP66GaNwlhLfBJL91o/6I8gxab5keiGtD/uBIabIc6BqSQO942KENnS0CYb7+l2eVR4ckHxNZB2cOGrD1cyM47JW16ZuUVEYvdr5sgOijX35ZRiRXJ7uw9rvohdr93NUNNQr3aAxcc75n/LsF1gLcnkOTNaGIMVSct7uCc9+7+7YtXLa3431aDTJnwCH/of+jWSF9zz3NrrjDTWAqHKpOdno4TEBze5VacmDhvb8KtB9y2F5JP7hfzcxpdODFRHvlZtr/wmbMOfYOlJ/sxBqmtLSM973j8qhmxoTvQeZt2NVeRRfz7Pp/Khs7M64X7PM6LpXp1vPMWHlGRHba+cPykBt2K3tAhN7QydNwECRPMsmYJ3V8QOD72ihIgEOgDEFT9Ug6N8vEFpDHN0RbaYLGCZsj1zCOmOZTnOBj/ox4tmrG9naMKE0Eo+86A4QyUQPk6n0AZqJyVr/p15c5Sm03IL3tzIj00BkQ/nhRDo52/Usdwwf9JVpGS0Klp9ASFKemUdkq5MrKU5ZIezXcDGYk1peLynIyvxsTXyT/kFRAyilDLjUbNjrjq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(366004)(376002)(396003)(346002)(26005)(66556008)(66476007)(33656002)(2906002)(55016002)(66446008)(76116006)(53546011)(83380400001)(64756008)(9686003)(6506007)(4326008)(54906003)(86362001)(478600001)(71200400001)(316002)(786003)(110136005)(5660300002)(52536014)(7696005)(66946007)(224303003)(7416002)(186003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?akNCYWNuY0Q5NXVlQXM4QlZFdGV3YkI4dTA1RmwvM3A5K3pBTk5rcUM4WENS?=
 =?gb2312?B?a1FiYndxbEZNVVpyOERNSWJmeXhxS3o5eEtoZU0yZzE1TXNSSDg3S1gxYkR1?=
 =?gb2312?B?UEFEQnpjV05IOGxFeXM0ZWN4ZVlxWjRUYldrK1dIWUI2djZTQmRGNkdlMFE0?=
 =?gb2312?B?ZlpLcTdJK0dneWV0UGFGVmlkR1MzK256VjFacTJpN0VPOSs5OGRLSXcxSVB6?=
 =?gb2312?B?V1ZrTFhPbklzOFpXSDZRbGcxbFgyVnltUkl2LzVQUUZjQUNIWmIwT2RENitU?=
 =?gb2312?B?RzZlTTdBdjd2dXl5OHJlT281cUlsOC9sdW1PSSs2ZzdRR0Z1Ykt6VUkrKzN4?=
 =?gb2312?B?MkNETGl5L3diOXY3ZkpEYnZmNVpyQ0tOMVhicnBaTkNUQStOcFZSbkdzWWp0?=
 =?gb2312?B?V3NUaFBCTm0wcUIvSVRYNDdWREplZjJocE5mMUltRmE1RXdBVkVYNVNZQzAx?=
 =?gb2312?B?UW1tSC90Mk54dysyZlVobHlOSjFMYVZpZWNWU0RldDJsU29Nd3J3aVFOZnFS?=
 =?gb2312?B?YnJpSXk3Tzc5dE4vcEFRTVlqQit6blNsR2V5K3h5WWMvL3Ivc2YzQi9yd3M3?=
 =?gb2312?B?azg1bkh1Nlc1cnNNdmNPSHk4MDFnRlQ0WWphS29XbUxuajlnUVJEMWdid1NV?=
 =?gb2312?B?VnhYVVBCZi9PWC9kVEVuMlp5TXlyWHVCSW0weHlON3BLbTUzOUI4LytRSzFq?=
 =?gb2312?B?VXpuT2FORy8rNTh1ZXBaUmVWUlFoL0hlTVRIMUNjcWN3WXNGVWlidGlTWnkw?=
 =?gb2312?B?S2t2UTdrMjh5NE9xeWRNZUR6ZTV5WG85NnVseC94ZkI0MGQxb1dZaWJhYThS?=
 =?gb2312?B?amtvdjF0QnNFSGU1SXB5ME56WjN5dytHd3FRcDVJL1NxVWZHb2wwaGlMRFpL?=
 =?gb2312?B?VnZqenRVUjErQ2FFaWRlWldPalRkUktTaG9Gc0VuekVHb2xHN2F2NmhIeTRy?=
 =?gb2312?B?S05SV1lmR2QvVk5aM1p0bWxFTTlSWEpITnhBaHREam5Ia0YvZ1c2QSt3cGR6?=
 =?gb2312?B?MmZyaU04QmU3R2gyNlJxVld1ZjFWekRzSTlvVHRveHl1TVdXZU5lQkUzVGZi?=
 =?gb2312?B?ZE5HWVVERW5yMFVjNCtMZnVyeE9HYTFWZlp1TGM2Y3N6M3N4VWJLVE4wQzBV?=
 =?gb2312?B?Yi9uWmV2dmh1WTZ2UzBZdmRzUzhFVlloTGNVUXVHOEFXWVJVOEkyMEl5WnpQ?=
 =?gb2312?B?cVgyNjhJSnN2bktmU0F1MGk2SG5peExwRkVTeEJHRDE5RGludW4zTVR6aWk4?=
 =?gb2312?B?cjJmL3dBRWttSHNjaFhhYStUMXNyR2JKckpPZGdTRk8zSDRMcThlZ2J2aGxm?=
 =?gb2312?B?WGhnTmxaVDlFMmxHcWFlWTl3UXdpbjVLUkhMVytDcjhVQ3AxUFl6ZEdFZ0V3?=
 =?gb2312?B?cHJkSlNiOHFUMWVjTUlpM1pBUEVtMUxpSTlialVtaDlCTU8vZ3lWei8wdkNV?=
 =?gb2312?B?OEhjUjZMU2V3b1YxcExadHgwN0p0QXZyYUhlYnYyaEh6TmJaYVNleHR2TmlM?=
 =?gb2312?B?WmVhYnd0VG5tMVBzMzdYVUdqQm41WnZIUGRIMXlyRjArcTJlcE1PYlMxM24r?=
 =?gb2312?B?VHBaNjFXU3VLUlcvZEtGSnB1N3ZOUldoU2lWMElJSG5GVmM5bUd2bXZ2ZEZZ?=
 =?gb2312?B?OHgyY1E5L0NwWHV2d25PaTBZL1ZnRktqRmVyTjRoWXIyZzZkbmJEV3ZQSHZZ?=
 =?gb2312?B?cGFBWVliVFJseEFrODljRVBaVkJRVi9GcGxQNDZRUmxZMW9lRHhhL01VMVpU?=
 =?gb2312?Q?i5f3r0CysZpZdQuX+k=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: stfx.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 754e3516-225a-4256-bf12-08d8e8943b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 15:57:41.8023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c46abc7-960b-4124-8950-1628b2b192f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5X6Xtx7swoeKsM2d52/48i9ungKK52e3BaFw59RJ7MEfbNS2+Izbm0W5OkjgjRLlKdJMrjKrgw3oyjzuCNm+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2351
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzLCB0aGUgcmV0dXJuIG9mIGEgbmVnYXRpdmUgbnVtYmVyIHJlc3VsdHMgaW4gYSB2ZXJ5IGxh
cmdlIHVuc2lnbmVkIGludGVnZXIsIHdoaWNoIGlkbGUgZ292ZXJub3JzIHVzZSBhcyBhIGJhc2Vs
aW5lIHByZWRpY3Rpb24gZm9yIGZ1dHVyZSBpbnRlcnJ1cHRzIGFuZCB0byBjb3JyZWN0IHRoZWly
IG93biBwYXJhbWV0ZXJzLiBUaGlzIHByb2JsZW0gY2FuIGxlYWQgdG8gdGhlIHNlbGVjdGlvbiBv
ZiBpZGxlIHN0YXRlcyB0aGF0IGFyZSB0b28gZGVlcCwgd2hpY2ggY2FuIGJlIGRldHJpbWVudGFs
IHRvIGJvdGggZW5lcmd5IGFuZCBwZXJmb3JtYW5jZS4NCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmou
d3lzb2NraUBpbnRlbC5jb20+DQq3osvNyrG85DogMjAyMcTqM9TCMTbI1SAzOjI2DQrK1bz+yMs6
IEZyZWRlcmljIFdlaXNiZWNrZXI7IFBldGVyIFppamxzdHJhDQqzrcvNOiBUaG9tYXMgR2xlaXhu
ZXI7IExLTUw7IFpob3UgVGkgKHgyMDE5Y3dtKTsgWXVuZmVuZyBZZTsgUGF1bCBFIC4gTWNLZW5u
ZXk7IE1hcmNlbG8gVG9zYXR0aTsgSW5nbyBNb2xuYXI7IHJhZmFlbEBrZXJuZWwub3JnDQrW98zi
OiBSZTogW1BBVENIIDAxLzEwXSB0aWNrL25vaHo6IFByZXZlbnQgdGlja19ub2h6X2dldF9zbGVl
cF9sZW5ndGgoKSBmcm9tIHJldHVybmluZyBuZWdhdGl2ZSB2YWx1ZQ0KDQpPbiAzLzE2LzIwMjEg
Mzo1MyBQTSwgRnJlZGVyaWMgV2Vpc2JlY2tlciB3cm90ZToNCj4gT24gVHVlLCBNYXIgMTYsIDIw
MjEgYXQgMDM6MzU6MzdQTSArMDEwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+PiBPbiBUdWUs
IE1hciAxNiwgMjAyMSBhdCAwMjozNzowM1BNICswMTAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdy
b3RlOg0KPj4+IE9uIFR1ZSwgTWFyIDE2LCAyMDIxIGF0IDAxOjIxOjI5UE0gKzAxMDAsIFBldGVy
IFppamxzdHJhIHdyb3RlOg0KPj4+PiBPbiBUaHUsIE1hciAxMSwgMjAyMSBhdCAwMTozNjo1OVBN
ICswMTAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdyb3RlOg0KPj4+Pj4gRnJvbTogIlpob3UgVGkg
KHgyMDE5Y3dtKSIgPHgyMDE5Y3dtQHN0ZnguY2E+DQo+Pj4+Pg0KPj4+Pj4gSWYgdGhlIGhhcmR3
YXJlIGNsb2NrIGhhcHBlbnMgdG8gZmlyZSBpdHMgaW50ZXJydXB0cyBsYXRlLCB0d28gcG9zc2li
bGUNCj4+Pj4+IGlzc3VlcyBjYW4gaGFwcGVuIHdoaWxlIGNhbGxpbmcgdGlja19ub2h6X2dldF9z
bGVlcF9sZW5ndGgoKS4gRWl0aGVyOg0KPj4+Pj4NCj4+Pj4+IDEpIFRoZSBuZXh0IGNsb2NrZXZl
bnQgZGV2aWNlIGV2ZW50IGlzIGR1ZSBwYXN0IHRoZSBsYXN0IGlkbGUgZW50cnkgdGltZS4NCj4+
Pj4+DQo+Pj4+PiBvcjoNCj4+Pj4+DQo+Pj4+PiAyKSBUaGUgbGFzdCB0aW1la2VlcGluZyB1cGRh
dGUgaGFwcGVuZWQgYmVmb3JlIHRoZSBsYXN0IGlkbGUgZW50cnkgdGltZQ0KPj4+Pj4gICAgIGFu
ZCB0aGUgbmV4dCB0aW1lciBjYWxsYmFjayBleHBpcmVzIGJlZm9yZSB0aGUgbGFzdCBpZGxlIGVu
dHJ5IHRpbWUuDQo+Pj4+Pg0KPj4+Pj4gTWFrZSBzdXJlIHRoYXQgYm90aCBjYXNlcyBhcmUgaGFu
ZGxlZCB0byBhdm9pZCByZXR1cm5pbmcgYSBuZWdhdGl2ZQ0KPj4+Pj4gZHVyYXRpb24gdG8gdGhl
IGNwdWlkbGUgZ292ZXJub3JzLg0KPj4+PiBXaHk/IC4uLiBhbmQgd291bGRuJ3QgaXQgYmUgY2hl
YXBlciB0aGUgZml4IHRoZSBjYWxsZXIgdG8NCj4+Pj4gY2hlY2sgbmVnYXRpdmUgb25jZSwgaW5z
dGVhZCBvZiBhZGRpbmcgdHdvIGJyYW5jaGVzIGhlcmU/DQo+Pj4gVGhlcmUgYXJlIGFscmVhZHkg
dHdvIGNhbGxlcnMgYW5kIHBvdGVudGlhbGx5IHR3byByZXR1cm4gdmFsdWVzIHRvIGNoZWNrDQo+
Pj4gZm9yIGVhY2ggYmVjYXVzZSB0aGUgZnVuY3Rpb24gcmV0dXJucyB0d28gdmFsdWVzLg0KPj4+
DQo+Pj4gSSdkIHJhdGhlciBtYWtlIHRoZSBBUEkgbW9yZSByb2J1c3QgaW5zdGVhZCBvZiBmaXhp
bmcgZWFjaCBjYWxsZXJzIGFuZCB3b3JyeWluZw0KPj4+IGFib3V0IGZ1dHVyZSBvbmVzLg0KPj4g
QnV0IHdoYXQncyB0aGUgYWN0dWFsIHByb2JsZW0/IFRoZSBDaGFuZ2Vsb2cgZG9lc24ndCBzYXkg
d2h5IHJldHVybmluZyBhDQo+PiBuZWdhdGl2ZSB2YWx1ZSBpcyBhIHByb2JsZW0sIGFuZCBpbiBm
YWN0IHRoZSByZXR1cm4gdmFsdWUgaXMgZXhwbGljaXRseQ0KPj4gc2lnbmVkLg0KPj4NCj4+IEFu
eXdheSwgSSBkb24ndCB0ZXJyaWJseSBtaW5kIHRoZSBwYXRjaCwgSSB3YXMganVzdCBjb25mdXNl
ZCBieSB0aGUgbGFjaw0KPj4gb2YgYWN0dWFsIGp1c3RpZmljYXRpb24uDQo+IEFuZCB5b3UncmUg
cmlnaHQsIHRoZSBtb3RpdmF0aW9uIGlzIHB1cmUgRlVEOiBJIGRvbid0IGtub3cgZXhhY3RseQ0K
PiBob3cgdGhlIGNwdWlkbGUgZ292ZXJub3JzIG1heSByZWFjdCB0byBzdWNoIG5lZ2F0aXZlIHZh
bHVlcyBhbmQgc28gdGhpcw0KPiBpcyBqdXN0IHRvIHByZXZlbnQgZnJvbSBwb3RlbnRpYWwgYWNj
aWRlbnQuDQo+DQo+IFJhZmFlbCwgZG9lcyB0aGF0IGxvb2sgaGFybWxlc3MgdG8geW91Pw0KDQpO
bywgdGhpcyBpcyBhIHByb2JsZW0gbm93LiAgQm90aCBnb3Zlcm5vcnMgdXNpbmcgdGhpcyBhc3Np
Z24gdGhlIHJldHVybg0KdmFsdWUgb2YgaXQgdG8gYSB1NjQgdmFyIGFuZCBzbyBuZWdhdGl2ZSB2
YWx1ZXMgY29uZnVzZSB0aGVtLg0KDQpUaGF0IHNhaWQgSSB0aGluayBpdCdzIGJldHRlciB0byBk
ZWFsIHdpdGggdGhlIGlzc3VlIGluIHRoZSBjYWxsZXJzLg0KDQpJIGNhbiBzZW5kIGEgcGF0Y2gg
Zm9yIHRoYXQgaWYgbmVlZGVkLg0KDQoNCg==
