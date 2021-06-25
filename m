Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52383B44A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhFYNjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:39:43 -0400
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:20065
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229615AbhFYNjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:39:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyXvMHCS7qbVQKf/kIzFC8pcHsMoiDk5i7FuSNTsGUt5s2hOvjZP8E7nH8E7j509l148l0kYvsJaFBGM8FPSBu3JeipFwsjyOxQ9tANwX/r4Ce09UnY00z3HGlwytYfSovZUcAi+iZFA3zwktBvj+QTDpmQGQhLE0j2i2gT+ukAkMchLI8zXh6DrPf632Hgk2VDXmH5rwKwQ0r6qwO9OupLH4bzCxo6LzKCpyJYAZaa1Y9iOb1SF80z3vspCszAEiBpW50Xwo9y+XNUM2pwuhCIhqJRNPxD4gjJC3W49XvAvdomSanpcnOLbviyKkEMfU2Y0JZ6a7uo4t5aXwZeYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEaotga76u2TIAT3ZrcpCRjkzNT7KPij6eFywxDcDWg=;
 b=ExLnevSCjN8GanTP9rucsKFvCPn53KN27bNVWqu9Vn+3Oa/MQaX/dAq+SFJrS5WC+pVgxg28wtNGMT4ORvudI78BkhOFjnzsICH8GAx3IK0TjuQWQE3HyN+eUBQKBrDP84Ps3s90Z/bvyc96hiCbcAJk+IdIeBkipohJ5R0aMw7XxBB4cY4a47SEtLFbkAXxIO/43ti67ZnsNYhIAcA0TFkCCFrBqSZ7NEW78e7XRwPCbwqGt/0VzJhYv390+XO6xpc7LJ9SzA0VVV2AaUhCqYMk0kKF8CcBWBhDBY7ksv0WpWAmtgoQOCswfSYN1UU7cFlziGsEZbeFuYr2wU4+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEaotga76u2TIAT3ZrcpCRjkzNT7KPij6eFywxDcDWg=;
 b=L0FHHqjcfekczbQ9TWj4gO0xpkSDCZT33lgxyDHedZ1B24Wt6EF8FUfB4ltpQayp/67sIBGAzoqqAY2K6Wx8kMqMLj0GA85p815zHd+F9+HVCr9cI9tDjeUErooJmQRCkJMyDjbGtzQcPQhm1LtSGJJphdoPqaPS6uNty4v/fYs=
Received: from BY5PR02MB6817.namprd02.prod.outlook.com (2603:10b6:a03:20e::22)
 by SJ0PR02MB7470.namprd02.prod.outlook.com (2603:10b6:a03:2a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 13:37:18 +0000
Received: from BY5PR02MB6817.namprd02.prod.outlook.com
 ([fe80::d0d5:249:813c:42ab]) by BY5PR02MB6817.namprd02.prod.outlook.com
 ([fe80::d0d5:249:813c:42ab%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 13:37:18 +0000
From:   Abhyuday Godhasara <agodhasa@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        Michal Simek <michals@xilinx.com>
CC:     Rajan Vaja <RAJANV@xilinx.com>, Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Tejas Patel <tejasp@xlnx.xilinx.com>
Subject: RE: [PATCH 1/6] firmware: xilinx: add register notifier in zynqmp
 firmware
Thread-Topic: [PATCH 1/6] firmware: xilinx: add register notifier in zynqmp
 firmware
Thread-Index: AQHXU9p4NiVAvkkaxEeOju/yyeI9nasefjeAgAZoLKA=
Date:   Fri, 25 Jun 2021 13:37:18 +0000
Message-ID: <BY5PR02MB681715AA20054EA5DE5257CCA1069@BY5PR02MB6817.namprd02.prod.outlook.com>
References: <1622217566-1856-1-git-send-email-abhyuday.godhasara@xilinx.com>
 <1622217566-1856-2-git-send-email-abhyuday.godhasara@xilinx.com>
 <6d230f7e-d039-a99b-87e9-25b42bdf9cdb@xilinx.com>
In-Reply-To: <6d230f7e-d039-a99b-87e9-25b42bdf9cdb@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [43.250.156.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 202340f4-a7d8-40e9-2ac6-08d937de5a1a
x-ms-traffictypediagnostic: SJ0PR02MB7470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR02MB747021C39D806363FDC7617EA1069@SJ0PR02MB7470.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a7f+Mn+7VhJ8b/kfOMmcVtaXw2TtMOwHLm7lOmnK4Dg5EaVImUomUaaKgTmKbplCMIF1/hrYpAgs2HybcYvHMejPDBKu7UP+RptJCMCq3+Y2qyinXh2HU3ieN61CHEqwLvvSQJdlhrJPBmVUdoemTyBmGW2c+rPoTliyGQ4LVqoCj1wRBQKcu58limnnGTpEMbInvWY1Hg9KToXM15bSaItKnPfeXZO2N1wn9sjY2ny3ieRRqwoAhro2n534hyc8BAnfnASQQQ+GqqyzBPNNNiW4102Jo6Mh54DfdyLZ5nRLIhnHzRLZew4NhXNu1OG3Ed32daFQZpkrkGI6qtVI8tiQnlOKuRd6L2KAXe/XkisFP/GJD63Syb5+UBPHYOeYAm8aZwzWc8xXC3QyMjCbO71D4QQX9x5ILDjXt5C4ORBuRmYfygNPSwwqMw0OxHWk6I7NN4Mk43+E9xnKDn33WlbBcIqMYLhBfNRTEu4L1phdHJS9A3sQgYL1dg73kr5OGJ1QVwlZwKGvHyAx2c1UNg8r+geyaL/vsDPK4PZeqxRVNqCEPgq8hnoyepO+xZ/JvaqZlh3oPuTeH467He8I0cfTi0RmCnb2SLFLYZT2fhQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6817.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(8676002)(478600001)(6636002)(55016002)(9686003)(83380400001)(122000001)(8936002)(38100700002)(2906002)(33656002)(71200400001)(26005)(52536014)(4326008)(66446008)(316002)(53546011)(6506007)(186003)(76116006)(66946007)(107886003)(66476007)(66556008)(64756008)(110136005)(54906003)(7696005)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkpMeVNEWEMrbVFCYmtEZUdYQytIM0xPZENlbzFTeHhGenh4Um1qMDVQemdE?=
 =?utf-8?B?cFZ2RStISHF0L1RFOXBjRW9Nelk4WE9qYVA0eXpGN2hxYnhIek1Wd2lyS2Za?=
 =?utf-8?B?RCtmcEg0ZkJhcEl1cVJMMVc3RloxVlFnZ3NYcUY2MThlTk8zUGdLNXlvcW9N?=
 =?utf-8?B?VitxNGIvMEtQeWpaL0EwOGVyQmlPU2dsVExMbGhOdDlERVZ0bTArMUlvM0lR?=
 =?utf-8?B?STczcmhmZDNydmZYeUwzVThETWZwbDh6RGVYYXhnVmI4dXNEL0RzYkxKaEFN?=
 =?utf-8?B?b1JUVDJkQ2lFWWdDdXlRQ05BejlJcVBMR0R0VEJrQ0lsaDlDVmVoYXVqckE4?=
 =?utf-8?B?QUxPaXJ5TVFDK0UrMTUxbmViNjEwenV6MWttNVFUOU1kMHN4ajZMbnZEc1Ro?=
 =?utf-8?B?bExSVDBzOVBnRUVUOUNaYTdZSk1YdGxGejlFS2NHT2NMMEtHbmdNYU9VUFRo?=
 =?utf-8?B?MVdjRkZPYVVNSDVZQWtiRWl5YWVTRUFFZWFMcEZUT0pTVGJHL2dzTEFXYnlJ?=
 =?utf-8?B?bjJTeFo1dkwwOTB1eGd6U0RDT2JMdnM5VWV1aGpaL0pCWEpSU2FKRS92M0pz?=
 =?utf-8?B?NnM2YUcySkxjRW5VNDNpaXF3c0Fjc2lUSWlOclZFTVJKcVkrcDVDdyszenV4?=
 =?utf-8?B?VmMxUnF0QUdPa2szV3dnVmpEcWJiV3Z3dHNOTElxS2taS2hXU0pZOXBQV2dI?=
 =?utf-8?B?M3liTWdOSjBXM00ycVRFWURmcTJvY1dXU0VQUVIrR3VyTkZXc3NVYWxyWW5U?=
 =?utf-8?B?MWRHZmF2N1hYa3lQOGNVTVRVMDJlSkZHRXBjOXFuRldmd0pIenREVVZXUFpl?=
 =?utf-8?B?UTZJTXFtUWR5dDdYZkU1b09RSlllTlkzMHh6cWZqMkg0d0g3eUJDY0pMa2NT?=
 =?utf-8?B?NnZFazZqMjRuYVBFUXpUbDg0TnZTRWIzai9PTEsveFRQV1Q2UndtYlVCRVRy?=
 =?utf-8?B?dVk3UjFLRi9SdHQ3eXFkMVdpTVVxUzFUMXdnWWt4Q2JoQU42Qm5Cd2RtVnpa?=
 =?utf-8?B?a01PeGdqN2g5TmZENVNzVWl6MXpyd0xycHVucVRSeTZwWkxLWWFtMkwrc0NF?=
 =?utf-8?B?dFVEU1lUZGpOdDNrNTdTdlBNUlFNWllJd1paQWkzM2V4anBGUzlaY0gyWmdD?=
 =?utf-8?B?ZUphdzFlaFNTMk9MeUtLWHViQ2M5QVJyRE1nUjN1blVOSWNwVlZkRjVNWExv?=
 =?utf-8?B?eGJiUkQwdWxCZXRxTFU4UTJNMzVwZmhaK2MxWHR1eUhLbWcyekloVXJNaDJZ?=
 =?utf-8?B?WTg3OW91ZVJuN09GM0NHTlhiNXNJV0ZIL2FBZFl1S2RmeExUSkpVOWNvM0lp?=
 =?utf-8?B?NTdOak1FYzJRbHZoSjhhS1A5RS91RmFjOW10Y1hWOW5rOEdOQ212Z1lXSnY5?=
 =?utf-8?B?YzBnRDNSa25Xa2VxSHl4eEJkRU5WVW1tSmphenYyMFQ5MVBvSmo2SVYzQjAr?=
 =?utf-8?B?ZUljbitIS0Iyckh4ZksrLzE3WGtuNFR5bUF3bXdBaWhLZ2p2dmpUeERGN0My?=
 =?utf-8?B?VVZPUlRxNU5DSVZ6RHpNNFpjSktNOXdETTlMNlkyaUpReDAwaXYrbXJPdmFa?=
 =?utf-8?B?dXE2R0tRVkc0NzQxTTRhb3gremJwcjlDTXpaWjVVejBnTmN2REdHOEpybXRO?=
 =?utf-8?B?N0IvaUtkZEM0QUJEZDVYVkJ0QzhyTG9rQ2p2bnVEalh4M1Nuczk0S240RVJj?=
 =?utf-8?B?NnYyeWxuYmQxaEtncTl3VHlnb1docW5aVzlpQWRFc3c4SWNwQ0dKVDFJSjht?=
 =?utf-8?Q?1z4oD09OfroeaXNeE4FFW7x9MxQ73j3laM0CRdw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202340f4-a7d8-40e9-2ac6-08d937de5a1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 13:37:18.1934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mq0yQsNs911KqmRXqPjKBmVedxZXyNxICjmEuonY49j54z++ea/GFJmPIJu/Pgoe7ldebUFxIlQv354GA/N8Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7470
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFsIFNpbWVr
IDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDIxLCAyMDIx
IDU6MTYgUE0NCj4gVG86IEFiaHl1ZGF5IEdvZGhhc2FyYSA8YWdvZGhhc2FAeGlsaW54LmNvbT47
IE1pY2hhbCBTaW1law0KPiA8bWljaGFsc0B4aWxpbnguY29tPg0KPiBDYzogUmFqYW4gVmFqYSA8
UkFKQU5WQHhpbGlueC5jb20+OyBNYW5pc2ggTmFyYW5pIDxNTkFSQU5JQHhpbGlueC5jb20+Ow0K
PiB6b3Vfd2VpQGh1YXdlaS5jb207IEFtaXQgU3VuaWwgRGhhbW5lIDxhbWl0c3VuaUB4bG54Lnhp
bGlueC5jb20+OyBTYWkNCj4gS3Jpc2huYSBQb3R0aHVyaSA8bGFrc2htaXNAeGlsaW54LmNvbT47
IEppYXlpbmcgTGlhbmcgPGpsaWFuZ0B4aWxpbnguY29tPjsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBUZWphcyBQ
YXRlbA0KPiA8dGVqYXNwQHhsbngueGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAx
LzZdIGZpcm13YXJlOiB4aWxpbng6IGFkZCByZWdpc3RlciBub3RpZmllciBpbiB6eW5xbXANCj4g
ZmlybXdhcmUNCj4gDQo+IA0KPiANCj4gT24gNS8yOC8yMSA1OjU5IFBNLCBBYmh5dWRheSBHb2Ro
YXNhcmEgd3JvdGU6DQo+ID4gSW4genlucW1wLWZpcm13YXJlLCByZWdpc3RlciBub3RpZmllciBp
cyBub3Qgc3VwcG9ydGVkLCBhZGQgc3VwcG9ydCBvZg0KPiA+IHJlZ2lzdGVyIG5vdGlmaWVyIGlu
IHp5bnFtcC1maXJtd2FyZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRlamFzIFBhdGVsIDx0
ZWphcy5wYXRlbEB4aWxpbnguY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFiaHl1ZGF5IEdvZGhh
c2FyYSA8YWJoeXVkYXkuZ29kaGFzYXJhQHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC1kZWJ1Zy5jIHwgIDIgKy0NCj4gPiAgZHJpdmVycy9m
aXJtd2FyZS94aWxpbngvenlucW1wLmMgICAgICAgfCAyMyArKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3hsbngtenlucW1wLmggICB8IDExICsrKysr
KysrKystDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5x
bXAtZGVidWcuYw0KPiA+IGIvZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLWRlYnVnLmMN
Cj4gPiBpbmRleCA5OTYwNmIzLi43ODQxY2I3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZmly
bXdhcmUveGlsaW54L3p5bnFtcC1kZWJ1Zy5jDQo+ID4gKysrIGIvZHJpdmVycy9maXJtd2FyZS94
aWxpbngvenlucW1wLWRlYnVnLmMNCj4gPiBAQCAtMiw3ICsyLDcgQEANCj4gPiAgLyoNCj4gPiAg
ICogWGlsaW54IFp5bnEgTVBTb0MgRmlybXdhcmUgbGF5ZXIgZm9yIGRlYnVnZnMgQVBJcw0KPiA+
ICAgKg0KPiA+IC0gKiAgQ29weXJpZ2h0IChDKSAyMDE0LTIwMTggWGlsaW54LCBJbmMuDQo+ID4g
KyAqICBDb3B5cmlnaHQgKEMpIDIwMTQtMjAyMSBYaWxpbngsIEluYy4NCj4gDQo+IG5vIHJlYXNv
biBmb3IgdGhpcyBjaGFuZ2Ugd2hlbiB5b3UgZG9uJ3QgY2hhbmdlIHRoaXMgZmlsZS4NCltBYmh5
dWRheV0gSSB3aWxsIHJlbW92ZSB0aGlzIGluIG5leHQgcGF0Y2ggc2VyaWVzLg0KDQo+IA0KPiA+
ICAgKg0KPiA+ICAgKiAgTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4g
PiAgICogIERhdm9yaW4gTWlzdGEgPGRhdm9yaW4ubWlzdGFAYWdnaW9zLmNvbT4gZGlmZiAtLWdp
dA0KPiA+IGEvZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLmMgYi9kcml2ZXJzL2Zpcm13
YXJlL3hpbGlueC96eW5xbXAuYw0KPiA+IGluZGV4IDE1YjEzODMyLi4zM2YxOTBlIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jDQo+ID4gKysrIGIvZHJp
dmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLmMNCj4gPiBAQCAtMTAzNyw2ICsxMDM3LDI5IEBA
IGludCB6eW5xbXBfcG1fYWVzX2VuZ2luZShjb25zdCB1NjQgYWRkcmVzcywNCj4gdTMyDQo+ID4g
Km91dCkgIEVYUE9SVF9TWU1CT0xfR1BMKHp5bnFtcF9wbV9hZXNfZW5naW5lKTsNCj4gPg0KPiA+
ICAvKioNCj4gPiArICogenlucW1wX3BtX3JlZ2lzdGVyX25vdGlmaWVyKCkgLSBQTSBBUEkgZm9y
IHJlZ2lzdGVyIGEgc3Vic3lzdGVtDQo+ID4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB0byBiZSBub3RpZmllZCBhYm91dCBzcGVjaWZpYw0KPiA+ICsgKiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZXZlbnQvZXJyb3IuDQo+ID4gKyAqIEBub2RlOglOb2RlIElEIHRv
IHdoaWNoIHRoZSBldmVudCBpcyByZWxhdGVkLg0KPiA+ICsgKiBAZXZlbnQ6CUV2ZW50IE1hc2sg
b2YgRXJyb3IgZXZlbnRzIGZvciB3aGljaCB3YW50cyB0byBnZXQgbm90aWZpZWQuDQo+ID4gKyAq
IEB3YWtlOglXYWtlIHN1YnN5c3RlbSB1cG9uIGNhcHR1cmluZyB0aGUgZXZlbnQgaWYgdmFsdWUg
MQ0KPiA+ICsgKiBAZW5hYmxlOglFbmFibGUgdGhlIHJlZ2lzdHJhdGlvbiBmb3IgdmFsdWUgMSwg
ZGlzYWJsZSBmb3IgdmFsdWUgMA0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIGlzIHVz
ZWQgdG8gcmVnaXN0ZXIvdW4tcmVnaXN0ZXIgZm9yIHBhcnRpY3VsYXINCj4gPiArIG5vZGUtZXZl
bnQNCj4gPiArICogY29tYmluYXRpb24gaW4gZmlybXdhcmUuDQo+ID4gKyAqDQo+ID4gKyAqIFJl
dHVybjogUmV0dXJucyBzdGF0dXMsIGVpdGhlciBzdWNjZXNzIG9yIGVycm9yK3JlYXNvbiAqLw0K
PiA+ICsNCj4gPiAraW50IHp5bnFtcF9wbV9yZWdpc3Rlcl9ub3RpZmllcihjb25zdCB1MzIgbm9k
ZSwgY29uc3QgdTMyIGV2ZW50LA0KPiA+ICsJCQkJY29uc3QgdTMyIHdha2UsIGNvbnN0IHUzMiBl
bmFibGUpIHsNCj4gPiArCXJldHVybiB6eW5xbXBfcG1faW52b2tlX2ZuKFBNX1JFR0lTVEVSX05P
VElGSUVSLCBub2RlLCBldmVudCwNCj4gPiArCQkJCSAgIHdha2UsIGVuYWJsZSwgTlVMTCk7DQo+
ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoenlucW1wX3BtX3JlZ2lzdGVyX25vdGlmaWVy
KTsNCj4gPiArDQo+ID4gKy8qKg0KPiA+ICAgKiB6eW5xbXBfcG1fc3lzdGVtX3NodXRkb3duIC0g
UE0gY2FsbCB0byByZXF1ZXN0IGEgc3lzdGVtIHNodXRkb3duIG9yDQo+IHJlc3RhcnQNCj4gPiAg
ICogQHR5cGU6CVNodXRkb3duIG9yIHJlc3RhcnQ/IDAgZm9yIHNodXRkb3duLCAxIGZvciByZXN0
YXJ0DQo+ID4gICAqIEBzdWJ0eXBlOglTcGVjaWZpZXMgd2hpY2ggc3lzdGVtIHNob3VsZCBiZSBy
ZXN0YXJ0ZWQgb3Igc2h1dCBkb3duDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZmly
bXdhcmUveGxueC16eW5xbXAuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS94bG54LXp5
bnFtcC5oDQo+ID4gaW5kZXggOWQxYTVjMS4uNjU1NzgzMiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L2Zpcm13YXJlL3hsbngtenlucW1wLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L2Zpcm13YXJlL3hsbngtenlucW1wLmgNCj4gPiBAQCAtMiw3ICsyLDcgQEANCj4gPiAgLyoNCj4g
PiAgICogWGlsaW54IFp5bnEgTVBTb0MgRmlybXdhcmUgbGF5ZXINCj4gPiAgICoNCj4gPiAtICog
IENvcHlyaWdodCAoQykgMjAxNC0yMDE5IFhpbGlueA0KPiA+ICsgKiAgQ29weXJpZ2h0IChDKSAy
MDE0LTIwMjEgWGlsaW54DQo+ID4gICAqDQo+ID4gICAqICBNaWNoYWwgU2ltZWsgPG1pY2hhbC5z
aW1la0B4aWxpbnguY29tPg0KPiA+ICAgKiAgRGF2b3JpbiBNaXN0YSA8ZGF2b3Jpbi5taXN0YUBh
Z2dpb3MuY29tPiBAQCAtNjIsNiArNjIsNyBAQA0KPiA+DQo+ID4gIGVudW0gcG1fYXBpX2lkIHsN
Cj4gPiAgCVBNX0dFVF9BUElfVkVSU0lPTiA9IDEsDQo+ID4gKwlQTV9SRUdJU1RFUl9OT1RJRklF
UiA9IDUsDQo+ID4gIAlQTV9TWVNURU1fU0hVVERPV04gPSAxMiwNCj4gPiAgCVBNX1JFUVVFU1Rf
Tk9ERSA9IDEzLA0KPiA+ICAJUE1fUkVMRUFTRV9OT0RFID0gMTQsDQo+ID4gQEAgLTQxMSw2ICs0
MTIsOCBAQCBpbnQgenlucW1wX3BtX3BpbmN0cmxfZ2V0X2NvbmZpZyhjb25zdCB1MzIgcGluLA0K
PiBjb25zdCB1MzIgcGFyYW0sDQo+ID4gIAkJCQkgdTMyICp2YWx1ZSk7DQo+ID4gIGludCB6eW5x
bXBfcG1fcGluY3RybF9zZXRfY29uZmlnKGNvbnN0IHUzMiBwaW4sIGNvbnN0IHUzMiBwYXJhbSwN
Cj4gPiAgCQkJCSB1MzIgdmFsdWUpOw0KPiA+ICtpbnQgenlucW1wX3BtX3JlZ2lzdGVyX25vdGlm
aWVyKGNvbnN0IHUzMiBub2RlLCBjb25zdCB1MzIgZXZlbnQsDQo+ID4gKwkJCQljb25zdCB1MzIg
d2FrZSwgY29uc3QgdTMyIGVuYWJsZSk7DQo+ID4gICNlbHNlDQo+ID4gIHN0YXRpYyBpbmxpbmUg
aW50IHp5bnFtcF9wbV9nZXRfYXBpX3ZlcnNpb24odTMyICp2ZXJzaW9uKSAgeyBAQA0KPiA+IC02
MjIsNiArNjI1LDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50IHp5bnFtcF9wbV9waW5jdHJsX3NldF9j
b25maWcoY29uc3QNCj4gPiB1MzIgcGluLCBjb25zdCB1MzIgcGFyYW0sICB7DQo+ID4gIAlyZXR1
cm4gLUVOT0RFVjsNCj4gPiAgfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlubGluZSBpbnQgenlucW1w
X3BtX3JlZ2lzdGVyX25vdGlmaWVyKGNvbnN0IHUzMiBub2RlLCBjb25zdCB1MzINCj4gZXZlbnQs
DQo+ID4gKwkJCQkJICAgICAgY29uc3QgdTMyIHdha2UsIGNvbnN0IHUzMiBlbmFibGUpDQo+IHsN
Cj4gPiArCXJldHVybiAtRU5PREVWOw0KPiA+ICt9DQo+ID4gICNlbmRpZg0KPiA+DQo+ID4gICNl
bmRpZiAvKiBfX0ZJUk1XQVJFX1pZTlFNUF9IX18gKi8NCj4gPg0KPiANCj4gTQ0KVGhhbmtzLA0K
QWJoeXVkYXkNCg==
