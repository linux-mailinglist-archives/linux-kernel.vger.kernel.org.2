Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5A53AB36C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhFQMWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:22:15 -0400
Received: from mail-db8eur05on2053.outbound.protection.outlook.com ([40.107.20.53]:60321
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231361AbhFQMWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:22:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ9ZNiKgUPslq650V7azEwjSdavCFEELU8EJaxCPHDGpDDenPK7xXv6BrAgQWRif7aAapKY5uUGKfBc1yGSR2algdEYKzPLwgksgzObsoxX3pyvR0oahRCduQfSd7KZFEp4wYFTy0vy3FottXE08adRj735fyXXqggbG0NgeV34fZ/Izl/pFGTUx8tgwl0jdaPMF6cwckTKN+QqG/HVfNml1EGV0d9ny05ZgDsUdcc8/pz4qBoWfWH2trQbAJEpITUOHwcZ5tO9h+ZMd+KhRGdBl75XhkHTyhmMDg/P6YG2pbj2Vo2P3BgJdkysM1AY1EssYptOk4nJZ23eHwTin6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VrPtquHJmy0pyaqEDhefN3J0oz7MA1uDm/p93tEhOw=;
 b=YZ1C0c8EU0J3iq4DrFk5RhXuRKHUK9+LiACx5mdyMUHNoIiSJFtOwGSOA14otmi/RWmbdMO4y+oiHM1dgtUjkna9EKz5EVF9vJnO1ICxuIjf66RijDPlc8L9HUI/l5xXlO4oQsvSrdB7ACS9aaTLTB3R8wsyn/nfaPmiAMwbBlC2rKXzgL4Fj3PdLE9BmS6nvq8TMGK4Ljs9QWb8eEtWkXdvK1qWAYti/XnXyRsU8WuLObgkYrwm3c/zA0FFGQJIaiNhuZS8c+aURlpiR42Kqk+VUpsChtaseSmUg0fzgWpsePOhaExx3GpzEPcTYj+sl+i9EPymoeZHHJO7F0GjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VrPtquHJmy0pyaqEDhefN3J0oz7MA1uDm/p93tEhOw=;
 b=kJNL8a6b9QvTb/LN0uAXoTqNFR1hdVKK/JBOz1aNQ5gWSCIro+dcJSs8ik9u2mGp91tPoMsHLMJT1JLNrVpn4RLr//NcMKfrZJOf7/ZZTbHgHRwlkvpPAXgvAxHFEMGDsxMkB2n7ui8N7mGPE0ypM+QpDRcxOVD9HRbM+pW475M=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8870.eurprd04.prod.outlook.com (2603:10a6:10:2e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 12:20:02 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2%9]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 12:20:02 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH -next v2 1/2] ARM: imx: add missing iounmap()
Thread-Topic: [PATCH -next v2 1/2] ARM: imx: add missing iounmap()
Thread-Index: AQHXYeTKpYlpL7L3EkyFdgpmU/47nasYIj0w
Date:   Thu, 17 Jun 2021 12:20:02 +0000
Message-ID: <DB9PR04MB84778C8658880848D18AE2F4800E9@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20210615125239.1348845-1-yangyingliang@huawei.com>
 <20210615125239.1348845-2-yangyingliang@huawei.com>
In-Reply-To: <20210615125239.1348845-2-yangyingliang@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 870a577d-988b-4010-3599-08d9318a3bdb
x-ms-traffictypediagnostic: DU2PR04MB8870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DU2PR04MB88709109E26256A7C430E5EF800E9@DU2PR04MB8870.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OF4fbI0LiFhExsPCPNyaSOSQJ+iuHcHl+y/sFryjeP5qJVopn87467IgbanOAm/xotQZ1Kon+yxJ2Ibw6/uE1DLraPT6Xk/OzfANPnMnvei+Vkey957wcKz430jY171rf0I8tcvoi0PlEbjlBCxDaJKTBs1SsYmGJ8/Q9wE91/CTekjfXtbKzQHxuuniJXysxGVBbpOQkvwlFiSjwaN8AISsBwD4Dj4qx3Jsh5EA8gWubRGycEUWBWC6onHnV7w3FuAMDyhI+mC0OIDSvOLl8jKYuCOiiLXz4rGCwCX9DmGhsexASTq2Gv8wPAj0DeEXPk2GzU3PydaN71snMdvvxXb3CnHihr/X2bZhknRC3mJPrSIsneF+RfUOeoc3ptdLJA4D3pDvKix7Wyb6BPhdG8xM23rzY/DDCkivCtQOcMygjUCAREcT0upgXapleUl9kmYwU3RLDqbIm9+AnZna/E61f7QaeLOETrkScpKgwlQmup65iRBpj/h33JG7yW4whSvxLyX3J2bTii8Fnk+HgqJ590ggoflTeOY3Iday3578LBgDyMbx/LaUowBnPjHaVXAVim7blMTkGGNJTAqEGmnc3/5B2WYQQsgE8pwDd4M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(66556008)(66476007)(71200400001)(44832011)(6636002)(66946007)(76116006)(66446008)(64756008)(4744005)(4326008)(52536014)(478600001)(55016002)(2906002)(9686003)(122000001)(26005)(6506007)(38100700002)(186003)(33656002)(110136005)(8936002)(316002)(53546011)(8676002)(7696005)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUNwdXk3VGpCSUNwdlRGN05LZ21BNjBhK1BkcmVKQXQzcGZzSlREbkIzWnM4?=
 =?utf-8?B?RVo4MWRZSFFLRjluQVlNc05FZVlaeExvYWY4UDJxZEVzSkQ3dnZjdEhCdExW?=
 =?utf-8?B?KzNIQkJvVDlOQkVVNGN5TTBBWU1YRE40VFFXeXV6bUVsZ004T2lpamZUQk1P?=
 =?utf-8?B?a2JvV2tPc1J0aXJrRW5ub0VSU0gxQ0l6ZDhjQWgrVCtJMktWTVJYWnZvNU5i?=
 =?utf-8?B?OTBGdUcrQmg3dk5mOE5zQUFlL0svdlFyNUFiMElndzdQUFNYWmdmbGxlS1d1?=
 =?utf-8?B?NkNKSkw2SEpuWk5RakhORWF4RVQ2RFhKY216TzZjN0ZybmoyOUVSY3BuWnh3?=
 =?utf-8?B?VW9pOEJhR254K2dEWGt4WW8vNTUwUW01Zngwa2VObHFjbmo3TE5YNkU1Ylgx?=
 =?utf-8?B?MS84N3FxbGVBZGZiaXBQQjFUdFhSWldXM1lKcVZJVCt6R3lGMDFVMmt4a2Z1?=
 =?utf-8?B?Q3hGdHRibHRoRW1hVkpncXVld0k1bkpUVVJxN1I4bFhqamM3dXZoUjB5K1lO?=
 =?utf-8?B?SWdGVlcrWG1QNG9mNWQrUkhmWVREV1JjeUl2RFg3K0k2cDBwczc2SXZUamJF?=
 =?utf-8?B?ZEkreTV5Tmp4K01VNnVoLzlaZkhRRVdTN25UVStzaVcwMHFOSjRDOHpiWUh1?=
 =?utf-8?B?K3lsbjR6aUQzYytTbjhLU21YYk1TMyt5Y01melF1Q054b0MrSllPKy9pMVpz?=
 =?utf-8?B?TVcxclJoSGVJeldOYXNTQm5vN2krSy8wU1BrWDY3QmN0RUpLeWI0VkhmWFY5?=
 =?utf-8?B?cXhOR1ROanYzanZOVmd2YXFvSzdDMVB5cFYzbThwalk2RWlEdHRCbUs0U2k3?=
 =?utf-8?B?QVIrY0hKa1kzZzFTbmFmcnFJbkVNREtacFczeldCNDlMVWhKZ0lOdTNHQ290?=
 =?utf-8?B?eW1nYTQ1K2QzZWtuQVBJdCtwZGJQZVVJMXBObDZOVlhUWmxhaDhMRjlNTkNm?=
 =?utf-8?B?NGlWekRTN2ZtSGkrUXozd3RlWk5EQjRtKy9XYlRhYjRVRXc1YUhUcW8rbDBo?=
 =?utf-8?B?MzhkKzEvd2Z0VWZFQkV5TlV5RmwxaEtBT1R2MmkxZkVCbjlwVGdSSnRuNXF6?=
 =?utf-8?B?S25LMkZBd3Q3NjdIbkpHaUhVdmdVOUV4SnA1QXZRdlBtMGxJWUtHRGJjQ2VN?=
 =?utf-8?B?NXpabWp0RkZGZFQ2d251U0I4S21UK0VWbTRBWU8wbHExNTI0MGxZclZFVVYr?=
 =?utf-8?B?Qi9tMkJjNTdIOXZGUG5EelZlU3VTRXAzTHh4UzJDNGhDcGNjakJKWHUrK09G?=
 =?utf-8?B?NWMyOGJpelZueUlKblBRVkNSYXh0NjYvNHV5NEcrMWxzS0dkSURMTzVnQTJJ?=
 =?utf-8?B?QjJkZ3cvSURoQk04SzFIemc0RTY0Q2tEb09iaU9pdUx2SUpqejJMZHloRC9M?=
 =?utf-8?B?NjkyRDYvU0kvRnZwNUdFRUY3dkZFZXlHWS9ZTWtzeU45dUFPYk1hR1I1UkFu?=
 =?utf-8?B?SmMyMDJxSzdmY1B2K215UFkyWCs2Q3BsMllLUkZleUJLbzB3c0crSGhUSTBS?=
 =?utf-8?B?Y1R4MFRiNmRMczdZcmNUem1nWXdwUFNWYklyTUFDWmkwRXFlbjhxZWMybGFu?=
 =?utf-8?B?K3EzVkRtNVhNL3NLcnB4VU5QdFdhUjlad1g5WFM5QzdGdUdDSjhlK3FpN2xQ?=
 =?utf-8?B?K2hqUC8ydmNhTTR2a0NaZWZzWllkVU1QY3ZMdlEzRmJIMmZGc2Y1UnNkK01m?=
 =?utf-8?B?ZUNqamxuYURZbnV5SG10cWRGemw0U3ZRQzFRemdyRnpJY21GTFFsSG4xb0Zx?=
 =?utf-8?Q?K/LFwWUu78Bu8LcskMpPEmjw82Kv3XOCsZ/Pkvq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870a577d-988b-4010-3599-08d9318a3bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 12:20:02.8508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeGOIFHH8QA4rBm2rSSVmON7ue/k1gbKffo7qY8SApuAR/dZbXA4/GP860XUpDMxIYlIE9lNpa+18jtwAhVcbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8870
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBZYW5nIFlpbmdsaWFuZyA8eWFuZ3lpbmdsaWFuZ0BodWF3ZWkuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKdW5lIDE1LCAyMDIxIDg6NTMgUE0NCj4gU3ViamVjdDogW1BBVENIIC1uZXh0
IHYyIDEvMl0gQVJNOiBpbXg6IGFkZCBtaXNzaW5nIGlvdW5tYXAoKQ0KPiANCj4gQ29tbWl0IGU3
NmJkZmQ3NDAzYSAoIkFSTTogaW14OiBBZGRlZCBwZXJmIGZ1bmN0aW9uYWxpdHkgdG8gbW1kYyBk
cml2ZXIiKQ0KPiBpbnRyb2R1Y2VkIGlteF9tbWRjX3JlbW92ZSgpLCB0aGUgbW1kY19iYXNlIG5l
ZWQgYmUgdW5tYXBwZWQgaW4gaXQgaWYNCj4gY29uZmlnIFBFUkZfRVZFTlRTIGlzIGVuYWJsZWQu
DQo+IA0KPiBJZiBpbXhfbW1kY19wZXJmX2luaXQoKSBmYWlscywgdGhlIG1tZGNfYmFzZSBhbHNv
IG5lZWQgYmUgdW5tYXBwZWQuDQo+IA0KPiBGaXhlczogZTc2YmRmZDc0MDNhICgiQVJNOiBpbXg6
IEFkZGVkIHBlcmYgZnVuY3Rpb25hbGl0eSB0byBtbWRjIGRyaXZlciIpDQo+IFJlcG9ydGVkLWJ5
OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBZ
aW5nbGlhbmcgPHlhbmd5aW5nbGlhbmdAaHVhd2VpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcg
QWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg==
