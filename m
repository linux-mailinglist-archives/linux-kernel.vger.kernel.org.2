Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466993DEB0F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhHCKio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:38:44 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:19832
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234904AbhHCKim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:38:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXxXqlYFDTiCZH0EZ2fKuit9ZYtqAzlX1rLNyC713ZecHOq089uklhvk/02NHGRJwidakOtDdCSSIoWz3TNU0htbTLKKSep39x4GilA1YTB6xiFgei0tyOGpZYDxzoaXG5tvExuFByZFo+jYQuxU/3AEH0lWcAxgYOmZcdrWQ4FR2ei8FNgJfa3K2m7+0z+440iHW8PsQzg0/VRTxMT1aWG/cL3B2P1nq+CA8uqJRkpXo9FataJQlfNtQ6b0uIMQi6kgWN70u82vLBczruOaXP1rZ9X4bpA7AdjQjutsNyzrK6H6Zg9az9PdZE2/iTK+RaPDFQF6pp91UF0l+yjdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7VOAIrNqtBhZTsSlCnHGykqQMR8vzVTYyhddNMTdoE=;
 b=b5USiCUWA2g8J38/N09VHVxNFRoyHQ3T3MU16B3/yUretOForlPFjacy8Ha8e2MScCtqeIVaJ8JomfxR1yjzsyMVDvdkp2KVcHdd4Nma3of1Z85o/I39x2FRfCJIfC+O+ZGJMtBs5OKApAziatSAFco+UuYNJFKQDPyt3T6C2xmYaUsDlOTV9WAEmN6wdIpBrS/Pdlpv2SoI+5txRXQv/mVqa8sgBlHPynDoJvYsXPBStnkMY4VgvEFyKZTMcgBDoybS9Zzcad4CVPI0/9Lbo9nukPJJ5tDdpqjkksMtZwXbU1a1R+//AVrRsB/RMSfxCs9ZfX7tADDXCanujDU75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7VOAIrNqtBhZTsSlCnHGykqQMR8vzVTYyhddNMTdoE=;
 b=ZU5lm3LHkvEgc0fqxVPMKY1pQt3QRm/ggl0q2hZjGy2nHgR25ae0KwW+m22nnHwSCvk97F7x75twAeW37+lPliWjq1PXJvMT1aDKbqjwYVi9Qw0nq7RZLRqidY4vzGuUUOPrlEQ2NZy73CEcCW2pFbAfpBEZh+1y+DAKVV+SNJA=
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15) by VE1PR04MB6687.eurprd04.prod.outlook.com
 (2603:10a6:803:121::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 10:38:27 +0000
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::91ec:5d59:ce42:dd5]) by VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::91ec:5d59:ce42:dd5%10]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 10:38:27 +0000
From:   Mirela Rabulea <mirela.rabulea@nxp.com>
To:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "dsaxena@plexity.net" <dsaxena@plexity.net>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "nm@ti.com" <nm@ti.com>,
        "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasure@xilinx.com" <nagasure@xilinx.com>,
        "ulli.kroll@googlemail.com" <ulli.kroll@googlemail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "anitha.chrisanthus@intel.com" <anitha.chrisanthus@intel.com>,
        "shubhrajyoti.datta@xilinx.com" <shubhrajyoti.datta@xilinx.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "ralf.ramsauer@oth-regensburg.de" <ralf.ramsauer@oth-regensburg.de>,
        "wilken.gottwalt@posteo.net" <wilken.gottwalt@posteo.net>,
        "chenyu56@huawei.com" <chenyu56@huawei.com>,
        "ssantosh@kernel.org" <ssantosh@kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [EXT] [PATCH v3 4/8] MAINTAINERS: rectify entries with
 documentation-file-ref check
Thread-Topic: [EXT] [PATCH v3 4/8] MAINTAINERS: rectify entries with
 documentation-file-ref check
Thread-Index: AQHXgirAoG5npB/tIEqK3WknhaxHGathowqA
Date:   Tue, 3 Aug 2021 10:38:27 +0000
Message-ID: <647389a9a4db416550bb4c44c9ef87b6f3091fac.camel@nxp.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
         <20210726142943.27008-5-lukas.bulwahn@gmail.com>
In-Reply-To: <20210726142943.27008-5-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb41f027-02d3-4f41-f00c-08d9566ad452
x-ms-traffictypediagnostic: VE1PR04MB6687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6687BE1E7D2FA2FE2775BFD98FF09@VE1PR04MB6687.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A+sLdzBb9D40whhw44+M+oFL9kFCIudTYhC81fYbzlJStQ1DXcRA7vJ8zdReM+qKNvTo0YATSzxTZm1ultgLDHG79H/BPAmVnpHwbB0pYLeXILpacfSM44zBWtY7FmDw9U4YbU9Gh48S7elk0EV7P9GnJXwArke0QNSomV82+g+WXQDE72SlUoAqHHcHI2YrPbVE4GqVzNyHAlkhPO9awZxB+lJs4t4WgOh/+1LrgOVJtEozf6f7MFnRSRdDq9s9C0GDSaO6KtB9ULA3u4HKhRcmUxVyy8lWp+2rNWUSi/7Lb1+nWvf8braL8zqZakpnM60n056Zn/t80mz3efjHYwEUni60Fdyw974+SFBFJN5Iq7bIP7Mze4nLNm+xmxL45jm6bjxWG9uS4vdLcT1Y43+UrgcTlZMVeklPcGxEz51FvY1DT5+pae4XndLzn/to48jAw+GCoZGD6/3BKrkr5xB039eoGrkeUCtPBk8QDtcWpTcFfp60ekg+YK79QIF15HOXRn5Fk9NUAXoGCRfU4kbEPIVKsarQcixZOn2duuV461o1kCT9+8eJ8/TGzRVGvnX4wpCtL4uXs+1lzKN1V3Y6monY8nrjDwtCt4+DgbVIVjdS8uymrrdrapK+VZoy52dt1T5cYQMWJ7daeMp+J8BC1oQ34eaouwQq9K3Nz2iE9fShu4cuIw0lX8HtKYWd+OnSY56rAAskYQRBkfki1f1Uew+vEFfbNTX078dLd7ogaMmK3rGO0oikNQH7ALIXYNoBcjdJcw15x0eHELFye8vPLOocPX9dAu3TaHOXhJI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2495.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(44832011)(2616005)(966005)(66446008)(5660300002)(478600001)(71200400001)(86362001)(6512007)(83380400001)(76116006)(66946007)(66476007)(66556008)(64756008)(6486002)(36756003)(38070700005)(26005)(54906003)(8676002)(7416002)(186003)(122000001)(6506007)(4326008)(316002)(2906002)(38100700002)(8936002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWhRZXhHSllxVkhsOUJqTzBiOHp3ZXlUMkI0RExsSENTb1NRMGVJWGZpeElo?=
 =?utf-8?B?NkZqeUh0TVJNck9uK0xCemY3SXRPTVhRcSt3NC9pNnlnL0RnVnVmeHV1NmF4?=
 =?utf-8?B?Q1NLMUQ4THRBN1JWUDl3bkJLKzZVWUpScm5SRkxWNVd2T0ZYQkRXeVZLMllk?=
 =?utf-8?B?S0JoMW93TUlBYUJUa004VHBKTk9KOFI5a2tpZlVMUGtSVk5qU3JJN3EyMjdt?=
 =?utf-8?B?WUgrOXBITkFvODg2Tm9ieWp2VGhLZGVGN3FJRXYvOGJVWDB3cUFFRUNiMnRi?=
 =?utf-8?B?UFBDNDBNZjNBUmc4WWFDK0NsbTVyS3E3Z2EycW1SaHp1bzNEbnNidnVYVVU0?=
 =?utf-8?B?VWZxcnhSbmJEQzlEVVA3V1lFOEcrdGlYbkJXQ1d0NXFsRFozMmNNM3B4SzZ2?=
 =?utf-8?B?U2lnMjlYUmNRekxLb1AyQ3hwNnNsdUJnc3QzQktwSHdnV2ZKT2pMU3VpNkVU?=
 =?utf-8?B?T0Y1dGNjUXdSbDVCdW03akJRZUxCVk5jV2RVT2xZS3B6LzdZUDhQUDlsVm96?=
 =?utf-8?B?dUtQNzYyNVhIa0lRQXRvZjZTVEt4b28waGhtQlcrZkxUNjBoVHRLWjIvVU1s?=
 =?utf-8?B?ME9ZeDlXS3pTTHBkOXNPZmd3KzdiNEs5OWpOVFZIMXU5Q3Vobk5HdkVNWUJp?=
 =?utf-8?B?OURNWVZmTkdJbGRZYmdvOC9aMmxndS83d05YM3phNXQ2ZkVibHc5TXVCbjVE?=
 =?utf-8?B?ZFVrblVUcHEyNXBFbUsydjJ6R3UwVzk3TGRKM0pFUnRIUEUxWHczK0EzL3Rt?=
 =?utf-8?B?K0FJTUZhcU5Zc2hqRkE4NllXdnRQZnNiWnFndjYyQmhjdTNOMkZrTjlUdmNl?=
 =?utf-8?B?SXc4MlVKQmN3SXJMM24yS2xTb2FuRklBNmpDMmMyLzlKUDg1aE0zZTlUSDlE?=
 =?utf-8?B?Q0htYTlKOHdWUGYvMnhzZ0hxc01GcXdlMnZvcy9xbHBqak1nSXFyYWFYMzhT?=
 =?utf-8?B?bHNTemhvb0xENGZOVkZISkZTK1lqZ0xHaHhtcFZRb1NmYlpOS3NPd3RKWEhK?=
 =?utf-8?B?SXB0YnJoMDFNRGIrNEpybitxZVhqQTBmNDQ3OE5YSjVLa2RZbVZwdkZkd1Ja?=
 =?utf-8?B?bEVrSUxXSDJoTjBib1d4d2Z0dk1xR1JGbW9odlIyOHc0MEVzNW5hcG9EM0kr?=
 =?utf-8?B?NllzeWZ2WDRFdTBhNjU0MUFUQTFYRzFEUFRvTVZUaGV4Rkx3M09aWHhGWjBX?=
 =?utf-8?B?aG5ud3FwdzBtYUNDWStlbDBOK2dNZ0RQbTZNMWxhaXNGeHN4eERLMENuL1pq?=
 =?utf-8?B?SFRLWnJrWEVjTlI0ZDBISXdyWkJ4RXN1d0Y4UzR6UVViY3FZYXg4ZWRxNytq?=
 =?utf-8?B?NWE0MHpYR2xFUmRHOS9RUi9iL2FYeGkrbDZqWmlLSnFUeTh4MGdGLzF4Ymlr?=
 =?utf-8?B?YUVlWFR5NGU1VmRZdXJWaVlDUktUWEVoRVR6VHJGLzUvdnlsYjM3UzRuTk9s?=
 =?utf-8?B?WVF1aWFBZFNZSWl3OFlhZEZNdDk4M2Z0dXcyc0UweVNIbEZkWlBQQXZuQUtZ?=
 =?utf-8?B?c3czdTJyQmx0L2VHbzZtSGpBQTN2Z0hwa3B6RVZyMk0vZXB5d3hTaityZGxs?=
 =?utf-8?B?SStvcVRBblJvcUJtQURIbXhrSGg0dXFlSmNUM1BUS2Q5QTQwYjV0RUN6aEdr?=
 =?utf-8?B?Ym15U1Y5UzJKTEZ3UWhNVkRTZ3l6REQzeE41S0NZMjlHdzVGdi9QM1hXS2ht?=
 =?utf-8?B?VFg4VzVTT1RYUXZEQUlXd3BoMXBOV3V6cjRoSUtTcXJGbHdsSWVDZ1ZwaU5q?=
 =?utf-8?Q?BHrRVHV+VnWy4bxPGuwkYWHdWuT5EwNfYOKBNkx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75269899F66C3B43AEC30BD45D6F0C3D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2495.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb41f027-02d3-4f41-f00c-08d9566ad452
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 10:38:27.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECvTJciQQ/30EAUn4yvBbf/YUXLYJmXFBxF0yQDE6e6s0TvaC984d/oxnveZMSgbJpNjAXfGYxabGClmeeZ/eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6687
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVrYXMsDQoNCk9uIE1vbiwgMjAyMS0wNy0yNiBhdCAxNjoyOSArMDIwMCwgTHVrYXMgQnVs
d2FobiB3cm90ZToNCj4gDQo+IEEgbnVtYmVyIG9mIGZpbGUgZW50cmllcyBjYW4gYmUgYXV0b21h
dGljYWxseSByZXBhaXJlZCB3aXRoDQo+IC4vc2NyaXB0cy9kb2N1bWVudGF0aW9uLWZpbGUtcmVm
LWNoZWNrIC0tZml4Lg0KPiANCj4gVGhlIGNoYW5nZXMgZnJvbSB0aGlzIHNjcmlwdCB3ZXJlIG1h
bnVhbGx5IGNyb3NzLWNoZWNrZWQgZm9yIHNhbml0eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1
a2FzIEJ1bHdhaG4gPGx1a2FzLmJ1bHdhaG5AZ21haWwuY29tPg0KPiAtLS0NCj4gIE1BSU5UQUlO
RVJTIHwgMTYgKysrKysrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01B
SU5UQUlORVJTDQo+IGluZGV4IGJkOTQzYmU3Mzc1Yy4uYzVhNDA3MDE1ZTJkIDEwMDY0NA0KPiAt
LS0gYS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMTQ4OCw3ICsxNDg4
LDcgQEAgTTogICAgICAgIE1pcXVlbCBSYXluYWwgPA0KPiBtaXF1ZWwucmF5bmFsQGJvb3RsaW4u
Y29tQGJvb3RsaW4uY29tPg0KPiAgTTogICAgIE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2Fz
dXJlQHhpbGlueC5jb20+DQo+ICBMOiAgICAgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi0NCj4gc3Vic2NyaWJlcnMpDQo+ICBTOiAgICAgTWFp
bnRhaW5lZA0KPiAtRjogICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQv
YXJtLHBsMzUzLXNtYy55YW1sDQo+ICtGOiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21lbW9yeS0NCj4gY29udHJvbGxlcnMvYXJtLHBsMzUzLXNtYy55YW1sDQo+ICBGOiAg
ICAgZHJpdmVycy9tZW1vcnkvcGwzNTMtc21jLmMNCj4gDQo+ICBBUk0gUFJJTUVDRUxMIENMQ0Qg
UEwxMTAgRFJJVkVSDQo+IEBAIC0xNTI1LDcgKzE1MjUsNyBAQCBBUk0gUFJJTUVDRUxMIFZJQyBQ
TDE5MC9QTDE5MiBEUklWRVINCj4gIE06ICAgICBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlq
QGxpbmFyby5vcmc+DQo+ICBMOiAgICAgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnIChtb2RlcmF0ZWQgZm9yIG5vbi0NCj4gc3Vic2NyaWJlcnMpDQo+ICBTOiAgICAgTWFpbnRh
aW5lZA0KPiAtRjogICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1
cHQtDQo+IGNvbnRyb2xsZXIvYXJtLHZpYy50eHQNCj4gK0Y6ICAgICBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LQ0KPiBjb250cm9sbGVyL2FybSx2aWMueWFtbA0K
PiAgRjogICAgIGRyaXZlcnMvaXJxY2hpcC9pcnEtdmljLmMNCj4gDQo+ICBBUk0gU01DIFdBVENI
RE9HIERSSVZFUg0KPiBAQCAtMTg1MCw3ICsxODUwLDcgQEAgVDogICAgICAgIGdpdCBnaXQ6Ly9n
aXRodWIuY29tL3VsbGktDQo+IGtyb2xsL2xpbnV4LmdpdA0KPiAgRjogICAgIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZ2VtaW5pLnR4dA0KPiAgRjogICAgIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY29ydGluYSxnZW1pbmktDQo+IGV0aGVybmV0
LnR4dA0KPiAgRjogICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJs
L2NvcnRpbmEsZ2VtaW5pLQ0KPiBwaW5jdHJsLnR4dA0KPiAtRjogICAgIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvZmFyYWRheSxmdHJ0YzAxMC50eHQNCj4gK0Y6ICAgICBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2ZhcmFkYXksZnRydGMwMTAueWFt
bA0KPiAgRjogICAgIGFyY2gvYXJtL2Jvb3QvZHRzL2dlbWluaSoNCj4gIEY6ICAgICBhcmNoL2Fy
bS9tYWNoLWdlbWluaS8NCj4gIEY6ICAgICBkcml2ZXJzL2NyeXB0by9nZW1pbmkvDQo+IEBAIC04
NjMzLDcgKzg2MzMsNyBAQCBROiAgICAgICAgDQo+IGh0dHA6Ly9wYXRjaHdvcmsub3psYWJzLm9y
Zy9wcm9qZWN0L2xpbnV4LW10ZC9saXN0Lw0KPiAgQzogICAgIGlyYzovL2lyYy5vZnRjLm5ldC9t
dGQNCj4gIFQ6ICAgICBnaXQNCj4gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L210ZC9saW51eC5naXQgY2ZpL25leHQNCj4gIEY6ICAgICBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2N5cHJlc3MsaHlwZXJmbGFzaC50eHQNCj4gLUY6ICAg
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL3RpLGFtNjU0LWhibWMudHh0
DQo+ICtGOiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC90aSxhbTY1
NC1oYm1jLnlhbWwNCj4gIEY6ICAgICBkcml2ZXJzL210ZC9oeXBlcmJ1cy8NCj4gIEY6ICAgICBp
bmNsdWRlL2xpbnV4L210ZC9oeXBlcmJ1cy5oDQo+IA0KPiBAQCAtOTQxMCw3ICs5NDEwLDcgQEAg
RjogICAgICAgIGluY2x1ZGUvbGludXgvc29jL2l4cDR4eC9xbWdyLmgNCj4gIElOVEVMIElYUDRY
WCBSQU5ET00gTlVNQkVSIEdFTkVSQVRPUiBTVVBQT1JUDQo+ICBNOiAgICAgRGVlcGFrIFNheGVu
YSA8ZHNheGVuYUBwbGV4aXR5Lm5ldD4NCj4gIFM6ICAgICBNYWludGFpbmVkDQo+IC1GOiAgICAg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvaW50ZWwsaXhwNDZ4LQ0K
PiBybmcueWFtbA0KPiArRjogICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9y
bmcvaW50ZWwsaXhwNDZ4LXJuZy55YW1sDQo+ICBGOiAgICAgZHJpdmVycy9jaGFyL2h3X3JhbmRv
bS9peHA0eHgtcm5nLmMNCj4gDQo+ICBJTlRFTCBLRUVNIEJBWSBEUk0gRFJJVkVSDQo+IEBAIC0x
MzQyOCw3ICsxMzQyOCw3IEBAIE06ICAgICAgTWlyZWxhIFJhYnVsZWEgPA0KPiBtaXJlbGEucmFi
dWxlYUBueHAuY29tPg0KPiAgUjogICAgIE5YUCBMaW51eCBUZWFtIDxsaW51eC1pbXhAbnhwLmNv
bT4NCj4gIEw6ICAgICBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcNCj4gIFM6ICAgICBNYWlu
dGFpbmVkDQo+IC1GOiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlh
L2lteDgtanBlZy55YW1sDQo+ICtGOiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21lZGlhL254cCxpbXg4LWpwZWcueWFtbA0KDQpUaGFua3MgYSBsb3QgZm9yIGZpeGluZyB0
aGlzLCBpbmRlZWQsIHRoaXMgZmlsZSBjaGFuZ2VkIG5hbWUgZHVyaW5nDQpyZXZpZXcgcHJvY2Vz
cywgYW5kIEkgZm9yZ290IHRvIHVwZGF0ZSB0aGUgTUFJTlRBSU5FUlMgZmlsZS4NCg0KUGxlYXNl
IG5vdGUgdGhhdCB0aGVyZSBpcyBhbm90aGVyIHBhdGNoIHNldCB0aGF0IGZpeGVzIG9ubHkgaW14
OC1qcGVnDQpyZWZlcmVuY2UgaW4gTUFJTlRBSU5FUlMgZmlsZSBmcm9tIE1hdXJvIENhcnZhbGhv
IENoZWhhYi4gSSBhZGRlZCB5b3UNCmFuZCBNYXVybyB0byBib3RoIGVtYWlsIHRocmVhZHMuIFBs
ZWFzZSBzdGF5IGluIHRvdWNoIHdpdGggTWF1cm8sIHRvDQpkZWNpZGUgd2hpY2ggcGF0Y2ggdG8g
YXBwbHkuDQpBcHBvbG9naWVzIGZvciBteSBsYXRlIHJlcGx5LCBhcyBJIHdhcyBvbiBQVE8uDQoN
CkZvciB0aGUgbGluZSB3aGljaCByZWN0aWZpZXMgbnhwLGlteDgtanBlZy55YW1sOg0KUmV2aWV3
ZWQtYnk6IE1pcmVsYSBSYWJ1bGVhIDxtaXJlbGEucmFidWxlYUBueHAuY29tPg0KDQpSZWdhcmRz
LA0KTWlyZWxhDQoNCj4gIEY6ICAgICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2lteC1qcGVnDQo+
IA0KPiAgTlpYVC1LUkFLRU4yIEhBUkRXQVJFIE1PTklUT1JJTkcgRFJJVkVSDQo+IEBAIC0xODM1
NCw3ICsxODM1NCw3IEBAIE06ICAgICAgU2FudG9zaCBTaGlsaW1rYXIgPA0KPiBzc2FudG9zaEBr
ZXJuZWwub3JnPg0KPiAgTDogICAgIGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KPiAgUzogICAgIE1haW50YWluZWQNCj4gIEY6ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL2tleXN0b25lL3RpLGszLXNjaS0NCj4gY29tbW9uLnlhbWwNCj4gLUY6
ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2tleXN0b25lL3RpLHNj
aS50eHQNCj4gK0Y6ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2tl
eXN0b25lL3RpLHNjaS55YW1sDQo+ICBGOiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Nsb2NrL3RpLHNjaS1jbGsueWFtbA0KPiAgRjogICAgIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtDQo+IGNvbnRyb2xsZXIvdGksc2NpLWludGEueWFt
bA0KPiAgRjogICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQt
DQo+IGNvbnRyb2xsZXIvdGksc2NpLWludHIueWFtbA0KPiBAQCAtMjAzODEsNyArMjAzODEsNyBA
QCBSOiAgICAgIFNyaW5pdmFzIE5lZWxpIDwNCj4gc3Jpbml2YXMubmVlbGlAeGlsaW54LmNvbT4N
Cj4gIFI6ICAgICBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPg0KPiAgUzog
ICAgIE1haW50YWluZWQNCj4gIEY6ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZ3Bpby9ncGlvLXhpbGlueC50eHQNCj4gLUY6ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZ3Bpby9ncGlvLXp5bnEudHh0DQo+ICtGOiAgICAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vZ3Bpby16eW5xLnlhbWwNCj4gIEY6ICAgICBkcml2ZXJz
L2dwaW8vZ3Bpby14aWxpbnguYw0KPiAgRjogICAgIGRyaXZlcnMvZ3Bpby9ncGlvLXp5bnEuYw0K
PiANCj4gLS0NCj4gMi4xNy4xDQo+IA0K
