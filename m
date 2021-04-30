Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C681A36F3B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 03:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhD3BfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 21:35:01 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:43655
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229519AbhD3Be7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 21:34:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABoqVSMr96SvqtvO7vD6cuhc/+8wNHIbQ/XXMitjJPNwJG0XCQLuCYlK2RLEcFbBg3TA9tKYmd9GQWn6mtgxSFKHeVnXU75NvPI9V5t9n5xuzHuX84BQsDqEaG+/Hpp1Q9GkvhyMNQlW6eOXV9Bq4uUOYC68ReBTsjLvYnsYIfOHfIa1X1rhlu9NeecYYiJUwLq7KB+V7XeEbgBKQmNqZTK2+xwZuzOwwg5tzmAOmB+N2E4cFepFfFK3QEQTsMpzaO8RBudxUYez7O/Q1CiICGkx45dOqxJz87ka+P4NKAQbXg0vZz/5gJySCPBLKtrOFg6GZzUJfnvxyqjexsJq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/akEEyiwzTbLA85YtMLSaT14HkRhEDPaVCZUvG1iN0=;
 b=gkNNiXkI5Pv9qcIS2bWyd59lHtH5fj2o3vTYP8kHq3s92pGDvt7Jvm/BsFAZVNjoF7tMIt1MRk4jF1MdU0hn7sn/e2Qx/lhF1Q4xYsEr0e7DWxsFD2LkpWbne6C8YVFTlID0Xl+yHQZoID9lLnYFG23+b8YL01FeDQzWeCePITrjIqUBMlY6BAfcAIF66phoDJDlDLehustK0IMnlYzxYf0wealTsF10MnfCZRWdXKHkU5KHXduG55WXLOClbM/2UPdyQ9C+XZDAYL3JiPPqcP0SNFtG3UkcPk1zFPlVaVuz6ZpPIsj+5lOSd3dKW1yIMR7egFYQ2U3MSCQNkD64mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/akEEyiwzTbLA85YtMLSaT14HkRhEDPaVCZUvG1iN0=;
 b=cZmg+HbRRkpYY6pC5ygwn+XcxUaRBX+l9CyqGAVWbWghe2Jmj2NbtPyGrMOD9RDQGv2dsX6/8YiHw7gFPmgzYEGiwUVB6SSBriyBFu+xBvYmo2w9vgqHSEnKE70Lj6Bi/U4xt2CZvLCHKp+lsll0aMxrsJbVigVVC15xm/7ZkAA=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Fri, 30 Apr
 2021 01:34:00 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Fri, 30 Apr 2021
 01:34:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH 00/16] soc: imx: gpcv2: support i.MX8MM
Thread-Topic: [PATCH 00/16] soc: imx: gpcv2: support i.MX8MM
Thread-Index: AQHXPMUjgiaegUodmkmDlRRxrgvZXarLb+IAgADYIQA=
Date:   Fri, 30 Apr 2021 01:33:59 +0000
Message-ID: <DB6PR0402MB276065DF476EBEDABF312CF9885E9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <CAHCN7xL11GUSVB3PThsfhxXPtgu1nm1LWSzkJYqj4MHf-aLbVw@mail.gmail.com>
In-Reply-To: <CAHCN7xL11GUSVB3PThsfhxXPtgu1nm1LWSzkJYqj4MHf-aLbVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd30216d-162b-46d0-4f37-08d90b780797
x-ms-traffictypediagnostic: DB8PR04MB6858:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6858A873DCBA0CAB3B3848FE885E9@DB8PR04MB6858.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NDoJhm16F9LSXWVq+1JFg7BLFlir3fghlEZY8Wp+pwFUK0ug3wQajxAxDEfGWasjIz1FFJWLO9oD1u1V85LjeIYnzgvIiq6k/VUSVCFYnu/5BQtzkJ1j3dRWN+njEgmw03tPG8WG36wyNElnPWklN6YL57Vt/q8HPXnjFEGYF+oqvjyL36CS6+HpD03GyCRuR1mYZCr6niPGuYUxommZNxJB7zXgi0qTSNa7NBARK/t6vjdXWzPsGCki6jK6zSFtSJJu8K0pLVSByIKAZWNML7W5WcjX18XARZF1AggDElCER3i/OiusVdvq51iLapPwKa4vsrX4pmQZghyrDJqCuDXl9WQYTIYs3AsoDGMg6MJEaTPommQ/BBo6y5ineMqpjcD/Mgr9IEuMQEH4XR3J4H6R+VBcoGagBrSLqs/aUlRcVamO40UETZrrTxNidoQ+W/Mev4jyMp85UFn8F0YfCVPmtAQZG5mVsxDv2kAfny4zVUnDgAil1wWmAcMD821pNlV6fPyCuafXT5qWSxLtI7byEPb1BG+QgZMaPlwLlTsGdiCNVzDBqa5PFy3eoiydFgqvbkWXb8UFlod0HWNC3Ve1Rn/vSBusbuDmmBQ77KM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(8936002)(478600001)(66946007)(76116006)(5660300002)(64756008)(110136005)(6506007)(71200400001)(66446008)(66476007)(8676002)(55016002)(9686003)(26005)(83380400001)(33656002)(2906002)(4326008)(44832011)(52536014)(53546011)(54906003)(38100700002)(122000001)(86362001)(316002)(7416002)(7696005)(186003)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TEw2T0g4dHBOM1JmV01yMlFlUnVKU3dZNkRlSklzSFBRZ21NdXg1alFCYXM0?=
 =?utf-8?B?QTJMOHh3MjVHOG50aXphU3k1ZUFSaTFjeEVPeGVzZEZ6S0hUbFBYejJvL3Ex?=
 =?utf-8?B?Z1pJS1RYUTBqQnNKTTB0andrSENEVmRRYzBjT2R2ODFBM2pTd29BZHhZSlZL?=
 =?utf-8?B?ekd5L2lIYVBKbVFPd3hURnd5eEFvYXI4ajhOQmppNncyQ29hWll1b05DZzdG?=
 =?utf-8?B?Mjk3SksyK1FXeU1GbXVSMHlKYU0ybUdmZFJXQUJDRk53VlE4eE4rTGRwMlJI?=
 =?utf-8?B?dDdkM1FtOXZqYVFqL2p6SmlZUnZySFFiNWh5cjkwUWs0SE1tamd5UXlDU0tL?=
 =?utf-8?B?UVhKK25pZTUwU2VlNXFGSnBuUlRsQ0FEVjk0TzBIK1I2aXhyc0pqdmxBYkt4?=
 =?utf-8?B?VFAzK1pFVXo5WE5sYndvVlNnOS9ZRytEbFV0Rzd1ZFhFNEJ1bWcyYXhqQkVw?=
 =?utf-8?B?b2lzYW5yaVpuaFJkRjY1NlVXWlc3QzZzamtvaTcvaWZuL09BV0hmSlRLYkFJ?=
 =?utf-8?B?b0ZnNU9WajFsSzRsdzBsT2pMWjFZRHBSTjlONFlnTloyTXc3Vm9zYmdGS0ZQ?=
 =?utf-8?B?c29zSGE1TkpEQnBNVk1VZVkyME96RStLMDUySmpLZUprczFqZTlhU1JZZGla?=
 =?utf-8?B?YnhoZVdSTE56VWJJaXVTbTdUc1Rldm5DaUlrTDBMU08xd1hTdFF0U3ZtbGN4?=
 =?utf-8?B?bStjbUVUY1VLYjJnT29iQ2tTWnRSKzhNVkZialk3ZzdEU2dIVForL25ZTko4?=
 =?utf-8?B?clNiSkIyVldZNUdnelhUeVJRMHJNK0UxaXpWRkZJZDAwNGVDOHMydVdVclN1?=
 =?utf-8?B?WWpBckZIRWZPVFNhb25nVS9HbHVPRFdkWDVkSm5UMFpIT2QxYUs3UWhGNURa?=
 =?utf-8?B?NFM4VStTdmZiOSszM09jOWtEbVh1MHpkTVpYU3cydUt2T2JNbFhReDRNNDVI?=
 =?utf-8?B?MWQycWxLUU1JQkdMZmpER3Q4Q2hCQmtPdDMwN3crUFRIMEpKVlVhSlZXb1VS?=
 =?utf-8?B?eXZ0TTdPcmZwR2xja1Y0bzBZTDNQRENxcVdMZWVtczZ6cHJmWjc5QlNaYTMr?=
 =?utf-8?B?OHVkL3FxcC9LeUdYL3VoTkFydjFjdUhBbmVldTdON2ozRkljWFN4WWsvQzhD?=
 =?utf-8?B?dmV3K21FRDVoUWlLa0NUOGNGM3Fhb3dPVUNHSWJMTy93RUZkU1VGcXRsNVJj?=
 =?utf-8?B?TDJWK0h0WnFFSHVwL3k4NjJNellVNCtZdVdQUTE2dW5KOU04Z05HMXloRlU3?=
 =?utf-8?B?RWhTMENaNjQ5bEhxSHk1eHlqRkNtYnNaeXlseUVQRzIzMmtwQnpaeW80V2U1?=
 =?utf-8?B?ZmVmWVJDZFNVelpGZjA1Vm5TREFYRmQ4KzZ6QjBscEN1Ym1SbzdnSGlsMkJS?=
 =?utf-8?B?QWxGcGpBVVdFaktkc09RUEtHTTIzWlFYYlBaTEplOENqVVUremFSeUpzbmRo?=
 =?utf-8?B?ZGFUVTJVYm5OYkVMbUJRaThsTG9Kd0FUVlNBTWlIa0hBbWZaUmhGZ21LZEMv?=
 =?utf-8?B?MGd3bTFxYjJlRUNYNTZxZjc4TkNGT0JVUVpuM3ExNzI3U2dhYUlQbXBkdElx?=
 =?utf-8?B?N3QwVWM5STY0czUxczk3eDRHU05WQm9LUFFnb1lSVmJQa04rQVF2YUdlUWdQ?=
 =?utf-8?B?ZDVKNmovSFRtZ2FvM2FLSElDYnYybDJBa2xSZUx6anZjZnNtaFV0eElTeDBF?=
 =?utf-8?B?b21ISVU0RVhOUEtiMXhCQmxyUWNmSi9JTkVOaHJDN0tkdDk0NVpGR1Y3dlkv?=
 =?utf-8?Q?CK5d9E8zrTilU6ieKrY9SMdfruGzTcfLxOE4BKD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd30216d-162b-46d0-4f37-08d90b780797
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 01:33:59.9644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JeUcnHIr7Tejjod/zVNzSASg0hqF7MNaZANKR9+s6z7nUjR3kdeNw40qQEZA8Pibm6y38eNNWKHmbYc+scOVnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzE2XSBzb2M6IGlteDogZ3BjdjI6IHN1cHBvcnQgaS5N
WDhNTQ0KPiANCj4gT24gVGh1LCBBcHIgMjksIDIwMjEgYXQgMTo1OSBBTSBQZW5nIEZhbiAoT1NT
KSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoc2V0IGlzIGEgcGljayB1
cCBMdWNhcydzIGdwY3YyIHdvcmsgZm9yIGkuTVg4TU0gYW5kIHNldmVyYWwNCj4gPiBtaW5vciBj
aGFuZ2VzIGZyb20gbWUgdG8gbWFrZSBpdCBjb3VsZCB3b3JrIHdpdGggaS5NWCBCTEstQ1RMIGRy
aXZlci4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgTHVjYXMncyB3b3JrIGFuZCBzdWdnZXN0aW9uLCBG
cmllZGVyIFNjaHJlbXBmIGZvcg0KPiA+IGNvbGxlY3RpbmcgYWxsIHRoZSBwYXRjaGVzLCBKYWNr
eSBCYWkgb24gaGVscCBkZWJ1ZyBpc3N1ZXMuDQo+IA0KPiBUaGFuayBmb3IgeW91IGFsbCB0aGUg
d29yay4gIEkgaGF2ZSBhbiBpLk1YOE0gTmFubyB0aGF0IEknbGwgd29yayB0byBhZGQNCj4gc3Vw
cG9ydCBmb3IgZ3BjdjIgdW5sZXNzIE5YUCBoYXMgc3RhcnRlZCB0aGlzIGFscmVhZHkuICBBdCBv
bmUgdGltZSwgSSBwb3N0ZWQNCj4gc29tZSBwYXRjaGVzIGZvciBOYW5vIGJhc2VkIG9uIEx1Y2Fz
JyB3b3JrLCBidXQgc2luY2UgdGhhdCB3b3JrIHdhc24ndA0KPiBhY2NlcHRlZCwgbWluZSB3YXNu
J3QgZWl0aGVyLg0KDQpQbGVhc2UgY29udGludWUgeW91ciB3b3JrIG9uIGkuTVg4TU4sIEkgbm90
IHdvcmsgb24gdGhpcy4gVGhlIGZvbGxvd2luZw0Kd29yayBmcm9tIG1lIGlzIGkuTVg4TVAuDQoN
ClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IGFkYW0NCj4gPg0KPiA+IEx1Y2FzIFN0YWNoICgxMik6
DQo+ID4gICBzb2M6IGlteDogZ3BjdjI6IG1vdmUgdG8gbW9yZSBpZGVvbWF0aWMgZXJyb3IgaGFu
ZGxpbmcgaW4gcHJvYmUNCj4gPiAgIHNvYzogaW14OiBncGN2MjogbW92ZSBkb21haW4gbWFwcGlu
ZyB0byBkb21haW4gZHJpdmVyIHByb2JlDQo+ID4gICBzb2M6IGlteDogZ3BjdjI6IHN3aXRjaCB0
byBjbGtfYnVsa18qIEFQSQ0KPiA+ICAgc29jOiBpbXg6IGdwY3YyOiBzcGxpdCBwb3dlciB1cCBh
bmQgcG93ZXIgZG93biBzZXF1ZW5jZSBjb250cm9sDQo+ID4gICBzb2M6IGlteDogZ3BjdjI6IHdh
aXQgZm9yIEFEQjQwMCBoYW5kc2hha2UNCj4gPiAgIHNvYzogaW14OiBncGN2MjogYWRkIHJ1bnRp
bWUgUE0gc3VwcG9ydCBmb3IgcG93ZXItZG9tYWlucw0KPiA+ICAgc29jOiBpbXg6IGdwY3YyOiBh
bGxvdyBkb21haW5zIHdpdGhvdXQgcG93ZXItc2VxdWVuY2UgY29udHJvbA0KPiA+ICAgZHQtYmlu
ZGluZ3M6IGlteDogZ3BjdjI6IGFkZCBzdXBwb3J0IGZvciBvcHRpb25hbCByZXNldHMNCj4gPiAg
IHNvYzogaW14OiBncGN2MjogYWRkIHN1cHBvcnQgZm9yIG9wdGlvbmFsIHJlc2V0cw0KPiA+ICAg
ZHQtYmluZGluZ3M6IHBvd2VyOiBhZGQgZGVmaW5lcyBmb3IgaS5NWDhNTSBwb3dlciBkb21haW5z
DQo+ID4gICBzb2M6IGlteDogZ3BjdjI6IGFkZCBzdXBwb3J0IGZvciBpLk1YOE1NIHBvd2VyIGRv
bWFpbnMNCj4gPiAgIHNvYzogaW14OiBncGN2MjogQWRkIHN1cHBvcnQgZm9yIG1pc3NpbmcgaS5N
WDhNTSBWUFUvRElTUE1JWCBwb3dlcg0KPiA+ICAgICBkb21haW5zDQo+ID4NCj4gPiBQZW5nIEZh
biAoNCk6DQo+ID4gICBzb2M6IGlteDogZ3BjdjI6IGNvcnJlY3QgcG1fcnVudGltZV9nZXRfc3lu
YyB1c2FnZQ0KPiA+ICAgc29jOiBpbXg6IGdwY3YyOiBtb3ZlIHJlc2V0IGFzc2VydCBhZnRlciBy
ZXF1ZXN0aW5nIGRvbWFpbiBwb3dlciB1cA0KPiA+ICAgc29jOiBpbXg6IGdwY3YyOiBzdXBwb3J0
IHJlc2V0IGRlZmVyIHByb2JlDQo+ID4gICBzb2M6IGlteDogZ3BjdjI6IHJlbW92ZSB3YWl0aW5n
IGhhbmRzaGFrZSBpbiBwb3dlciB1cA0KPiA+DQo+ID4gIC4uLi9iaW5kaW5ncy9wb3dlci9mc2ws
aW14LWdwY3YyLnlhbWwgICAgICAgICB8ICAgOSArDQo+ID4gIGRyaXZlcnMvc29jL2lteC9ncGN2
Mi5jICAgICAgICAgICAgICAgICAgICAgICB8IDUzNA0KPiArKysrKysrKysrKysrKy0tLS0NCj4g
PiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9pbXg4bW0tcG93ZXIuaCAgICAgIHwgIDIyICsN
Cj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA0NTAgaW5zZXJ0aW9ucygrKSwgMTE1IGRlbGV0aW9ucygt
KSAgY3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9pbXg4
bW0tcG93ZXIuaA0KPiA+DQo+ID4gLS0NCj4gPiAyLjMwLjANCj4gPg0K
