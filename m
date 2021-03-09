Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAA4332258
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCIJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:51:24 -0500
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:3557
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229481AbhCIJvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:51:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CELW/Zv6uQL1cSk8LgLOSUWKZsszMvh96mtSQyhiFgKUB44gjhDmP9eWIsWYkPyvVKc5VbOkWcURnRZ+tSvwGF56OllaCFPePeeXwTrkIgTfW/LKP/Qynv/onPQxWwwrWJmGuIVfs7hcbp2K+bU3VVHFmdCr7wF/sYT7qfKTbqhQj6Ret0NdpoqQVWMEapZkpE8OSAepvrFWYFa92WkHNl2F59iNNTpUMRhO7palpvAwJyJbdGJsaewBD6cvcjRtYdESDmlOTzPd35N9ymT8XfMCyOCcxmyjTXlzUxRVGgY92SPMCPKtYEA+ZBOhZK8Dhpp//b+GMQPrhlAjUxJSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkMyUI6oJU7UvVDte5z8JgCatW4H7BYvOXYEXYSA+Tk=;
 b=mxTwjuG31eVilIi9pxozOSrDiXtHjTvWKfeBfqW1DwF40N+gM13WpdMKbbWXhs+58BHmA+w1ecddzWIadhaZym2ZZZ4XVTYll3IsgCalLogIT2Nr+MCpXiFrK4c6j6S/FUdpIDD2doqPWq3/Au2CFBs3OVRdTJsW+az8CO315yl0aHVESk8NjoqRmicP/e15B4agghVrVe/KyX22ZSue3ewaFsSVW0Eb33QO878CU5uX9ZhqBxF1qeZ1aJK2MUDye8Qlod5L/9lyedWxb6DeglAr70Rw0nw2G9Dh+ZXCalUUbv4kSNmLSVGuLhgX/SGiLwaGJTs5ZeM/ikFfy4Gbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkMyUI6oJU7UvVDte5z8JgCatW4H7BYvOXYEXYSA+Tk=;
 b=Upkb6+oVPA+a5Jlxj9MKozdO8ua3eQY4nM7Qc7sGpZuZ4ZI3uROkmcvBVrlAFGmIi/2nmpr4lsRRobleuzxHVljvRTPRKYrf2VgxuP/ubba0ScGFH6+4kWalotGpNH3oEq5bRkUg/uTiW3Oc725eofA7om4fn0tgJh1LaU4MNxA=
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 9 Mar
 2021 09:51:02 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::d1ae:8c2:d0a0:4aa3]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::d1ae:8c2:d0a0:4aa3%5]) with mapi id 15.20.3890.040; Tue, 9 Mar 2021
 09:51:01 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Hao, Kexin" <Kexin.Hao@windriver.com>
Subject: RE: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Thread-Topic: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Thread-Index: AQHW6uDlVrPMRNLctkuz9Bvou6uZzqpjw5uQgABcSgCAAAJ7AIAABI6AgBeUiwCAAABKUA==
Date:   Tue, 9 Mar 2021 09:51:01 +0000
Message-ID: <PH0PR11MB5191EA634E57B8A5FF0DE991F1929@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20210115015050.26657-1-meng.li@windriver.com>
 <CO1PR11MB48497CB7B11EDA65A3941FDCF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
 <36cc2d810d90237947ad953ebd6b9fb7@kernel.org> <20210222092114.GE376568@dell>
 <CO1PR11MB48499549EB56C7EE119E175DF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
 <20210309094310.GO4931@dell>
In-Reply-To: <20210309094310.GO4931@dell>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d442cf2-ab4e-4dcc-5c4c-08d8e2e0d942
x-ms-traffictypediagnostic: PH0PR11MB4997:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4997C92C434C659BE150ACEFF1929@PH0PR11MB4997.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KPSCs6j/QTCpyHn2L8yQikdy5p2zae7zPvMoLjl9ggnBaKSgyQ6xr1gvgA+RfVIJOBr321xLvQ0Fca7GCSjo5CI0l6PoGeodyJbP2sH1nHWX5Pm9CgRBBwUMXGwktGFWCeSnnxnualh56iavihF9wxXcGNEOfnRwxswEagwcuPUzMg78/B1/CxFpGf2O21zhqUPdweUZDW8feQo11U6t+QL2B46lr3XSMLn13x7Ub2Ds4Tr5y4iiQQ+Pdp+f7G5CHx/xtpQeenD/IjHbyvW767k73vV+WOIhqus4BcG04enY5VpiehJtqoVk7Dd//WzXkobd7ZoSpY6T005wOUaog+Mi3NVMHcXOz5pgb11PFh2kvUMpUPSuBtGrX04ngxW7gmJXArIxx/dARAMV+UuXMXrUF2NNOoY0P+K4z9tXwhklFWk3dz0h88XJ21LkbZ+quJ3aFbyIU450i3aNuth24jNyGfrgkKu3V+2Cm56cCjxiFY9A+6DKlvtSym916q8kzJNUsh/gBqGgh5W0CCMFSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(346002)(376002)(136003)(86362001)(83380400001)(26005)(33656002)(5660300002)(316002)(6506007)(76116006)(53546011)(7696005)(66946007)(478600001)(66446008)(66476007)(9686003)(54906003)(66556008)(64756008)(55016002)(107886003)(4326008)(2906002)(186003)(8676002)(71200400001)(6916009)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TzRrNkZCdmJDUVBvZUR3eUk1WWU0NHVsek5EMUdScWZER0dubWJuYS9wWHVS?=
 =?utf-8?B?eEhxUXh3U3I5aHIrSGEwQ2lTbitVWGtEbk5YTHlib2J0aFVmUzB6WVoxbTE1?=
 =?utf-8?B?STBROTRXZ0R5WDdpWVVvNjJ1V3MzOG5pOCtsbmxucmtiUy9MbmpDWC91NC9L?=
 =?utf-8?B?MWxXeUNkeGFLZGFWd2lPWHpkTzk3UE1UTjRFSUZYUnc2MEZISENqekVNT3lw?=
 =?utf-8?B?elpqaTVXbG5JeTA0b2s5YWRTRVZZbXpWMkxSVEpQeEN4VVRUQkF5UUh6d0c3?=
 =?utf-8?B?Uy9oUlNBUUs0QkhUZ2JvUGxRMktDb2RmZWRrVmdJczc4ZEVvOW9wSUtJOXhM?=
 =?utf-8?B?NXFmU0ptRE5EeGYyZlZLd2pjZGdBckRUL1g1KzkvVDdqWDZWTFExaXViRmNJ?=
 =?utf-8?B?dE5uRHIrTlN5SUZYc2VYY29pdEc5R2pjZXZjWlY2aldVTjMrSTVjS3FHNHp5?=
 =?utf-8?B?bHBmeHN1WGxIakhnRlJXeFB4MFhxaXZ2c3I5aUhLL0cwVWRBaGg0WllsNVNt?=
 =?utf-8?B?RnlZT2tJZVZqMTRzVlRVeDRaa01kc0JOTWNlbFhVRVNyRkU5RjMwVlJ3cmh6?=
 =?utf-8?B?d25mRTY2bWFjMkRKMWw1cmEvcjZnT3dnSEJXcjNWWFhyaDJHdTBGSUpZM2F2?=
 =?utf-8?B?bXVuVit0ODI3cUtwUnVKNTVYWnBuc3BEM2hDNDdwdmhDR09EN1lvbGd6ZWN5?=
 =?utf-8?B?TkRQQ0lpOTl5RzROME0zZnpBRVZWS0pVM1NwNEpOZ1JVLzV2VTNQRi9GdnFT?=
 =?utf-8?B?QmgvMlo3dGJHYjZFUndjdkl0ZzZrM1Y2TXFsT1hWajhMU0VacVdHaFFpNWhM?=
 =?utf-8?B?MTFBTnhSVXNKM1dITlQyQTNJa1czbTQ4dzVQRlZzWXdzSkJNYmhwaDhPbmJY?=
 =?utf-8?B?ZHB0cFRic1pBOFNWL05aS2x0U2NKazczb0xDUmk4SlJtN3cxaWJkRklWWkxr?=
 =?utf-8?B?R3loSUgvVzR5T0JXTkdwTGRwWU5qUVAzS0M4MzB6TjFncTFXdzZmYTRPTExv?=
 =?utf-8?B?N2JQTUsrVXFVVk5laCtRTmNOb3U4Sy9PU1ZlWWVYOFgvWDdzYjQ4dHdWbU9Y?=
 =?utf-8?B?bm9oYnhNakpnS1VLb0NzeWxFZDVZWFpRNGVDdUtUZGhQb240Z3UwRkcxZG8v?=
 =?utf-8?B?KzlFTWdsbmxFYTV2dHJlREgvakFjNU43eVJaNzhjOXJhOVRreENxTkNNUXBY?=
 =?utf-8?B?eWxDVGpPSGYxbVdPb3N1Rm5BUmtIcTJLZGRuOW9iWG53elFOVG92d0tGUEtF?=
 =?utf-8?B?WVhTWXlkUnVyYkYyVTFRNUJIbzdoTEZGWDIwTktVU2RMUHdtUkFleFcyeGpB?=
 =?utf-8?B?L3RwT2lyY0Nkd0hHRHFmNU9QSUZnZWo4M2Z0b05KZ3NuZXRYcGk5akt2YUFx?=
 =?utf-8?B?U3ZpNTNaS1RZcTBoeFJyWkRhK1BwZDJ0REs3cjVWS0JQZ25maWdSL3pPT3ps?=
 =?utf-8?B?bndPaHQvZ3lKa1lPVk5CQ2NSSVNDQ1ZpY2F2clYzN3RJcVBCYzFPZFljcnpj?=
 =?utf-8?B?MlhYSzlhc2sreUl6S3h5RVVPa3ArYmNubGRjSTlGd3MxK1BzcHUzeG1zek1y?=
 =?utf-8?B?ZFlQMVBpdWhtK213UnlKYUdlU0loL29GZlZtK08xTUZrQnYrbC8ySUI1WG90?=
 =?utf-8?B?cklScHZNbzQrb3ZMNlFmNVNvOFlyc3VhQk0zaitPb3NZeXphM2VPZlZudDhK?=
 =?utf-8?B?TGtYV0FxNXBSM0E3akJuTXF5MjlJSzdaZ1VUQkVuUGZGaW1XNE9hU2tKT2pu?=
 =?utf-8?Q?4DaFBJaBzfoZWvwZa4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d442cf2-ab4e-4dcc-5c4c-08d8e2e0d942
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 09:51:01.7486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+sN2eEhgQstCGiCO5TQpg/oVXyn+g/kBfPodX+YGbkwETl8agWE1jVMqQvWuouj1i/QUC4OOPcTLWpEqqf+Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVlIEpvbmVzIDxsZWUu
am9uZXNAbGluYXJvLm9yZz4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggOSwgMjAyMSA1OjQzIFBN
DQo+IFRvOiBMaSwgTWVuZyA8TWVuZy5MaUB3aW5kcml2ZXIuY29tPg0KPiBDYzogTWFyYyBaeW5n
aWVyIDxtYXpAa2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGFy
bmRAYXJuZGIuZGU7IEhhbywgS2V4aW4gPEtleGluLkhhb0B3aW5kcml2ZXIuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW3YyXVtQQVRDSF0gUmV2ZXJ0ICJtZmQ6IHN5c2NvbjogRG9uJ3QgZnJlZSBhbGxv
Y2F0ZWQgbmFtZSBmb3INCj4gcmVnbWFwX2NvbmZpZyINCj4gDQo+IFtQbGVhc2Ugbm90ZTogVGhp
cyBlLW1haWwgaXMgZnJvbSBhbiBFWFRFUk5BTCBlLW1haWwgYWRkcmVzc10NCj4gDQo+IE9uIE1v
biwgMjIgRmViIDIwMjEsIExpLCBNZW5nIHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiA+IEZyb206IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+DQo+
ID4gPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDIyLCAyMDIxIDU6MjEgUE0NCj4gPiA+IFRvOiBN
YXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPg0KPiA+ID4gQ2M6IExpLCBNZW5nIDxNZW5nLkxp
QHdpbmRyaXZlci5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gYXJu
ZEBhcm5kYi5kZTsgSGFvLCBLZXhpbiA8S2V4aW4uSGFvQHdpbmRyaXZlci5jb20+DQo+ID4gPiBT
dWJqZWN0OiBSZTogW3YyXVtQQVRDSF0gUmV2ZXJ0ICJtZmQ6IHN5c2NvbjogRG9uJ3QgZnJlZSBh
bGxvY2F0ZWQNCj4gPiA+IG5hbWUgZm9yIHJlZ21hcF9jb25maWciDQo+ID4gPg0KPiA+ID4gW1Bs
ZWFzZSBub3RlOiBUaGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFMIGUtbWFpbCBhZGRyZXNz
XQ0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgMjIgRmViIDIwMjEsIE1hcmMgWnluZ2llciB3cm90ZToN
Cj4gPiA+DQo+ID4gPiA+IEhpIExpbWVuZywNCj4gPiA+ID4NCj4gPiA+ID4gT24gMjAyMS0wMi0y
MiAwMzo0NSwgTGksIE1lbmcgd3JvdGU6DQo+ID4gPiA+ID4gSGkgTWFyYyZMZWUsDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBJcyB0aGVyZSBhbnkgY29tbWVudCBvbiB0aGlzIHBhdGNoPw0KPiA+ID4g
PiA+IENvdWxkIHlvdSBwbGVhc2UgaGVscCB0byByZXZpZXcgdGhpcyBwYXRjaCBzbyB0aGF0IEkg
Y2FuIGltcHJvdmUNCj4gPiA+ID4gPiBpdCBpZiBpdCBzdGlsbCBoYXMgd2Vha25lc3M/DQo+ID4g
PiA+DQo+ID4gPiA+IElmIHlvdSBhcmUgY29uZmlkZW50IHRoYXQgdGhlIHJvb3QgaXNzdWUgaGFz
IGJlZW4gZml4ZWQsIG5vDQo+ID4gPiA+IG9iamVjdGlvbiBmcm9tIG1lLCBidXQgSSdtIG5vdCBp
biBhIHBvc2l0aW9uIHRvIHRlc3QgaXQgYXQgdGhlDQo+ID4gPiA+IG1vbWVudCAodGhlIGJvYXJk
IEkgZm91bmQgdGhlIHByb2JsZW0gb24gaXMgaW4gYSBiaXQgb2YgYSBzdGF0ZSkuDQo+ID4gPg0K
PiA+ID4gSSdtIG5vdCBrZWVuIG9uIGZsaXAtZmxvcHBpbmcgdGhpcyBwYXRjaCBpbiBhbmQgb3V0
IG9mIHRoZSBrZXJuZWwuDQo+ID4gPiBTb21lb25lIHJlYWxseSBuZWVkcyB0byBzcGVuZCBzb21l
IHRpbWUgdG8gbWFwIG91dCB0aGUgZnVsbA0KPiA+ID4gbGlmZS1jeWNsZSBhbmQgcHJvcG9zZSBh
IChwb3NzaWJseSBjcm9zcy1zdWJzeXN0ZW0pIHNvbHV0aW9uLg0KPiA+ID4NCj4gPiBUaGFua3Mg
Zm9yIGFsbCBvZiB5b3VyIGNvbW1lbnRzLg0KPiANCj4gSGF2ZSB5b3UgbG9va2VkIGludG8gdGhp
cyBmdXJ0aGVyIGF0IGFsbD8NCj4gDQoNCk5vLg0KTWFpbnRhaW5lciBleHBlY3RzIGJldHRlciBz
b2x1dGlvbiB0byBzb2x2ZSB0aGlzIGlzc3VlIGZyb20gZnJhbWUgbGV2ZWwsIGFuZCBjb25zaWRl
ciBjcm9zcy1zdWJzeXN0ZW0uDQoNClRoYW5rcywNCkxpbWVuZw0KDQo+IC0tDQo+IExlZSBKb25l
cyBb5p2O55C85pavXQ0KPiBTZW5pb3IgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2Vydmlj
ZXMgTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2UNCj4gc29mdHdhcmUgZm9yIEFybSBTb0NzIEZv
bGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cNCg==
