Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716333E8B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhHKIJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:09:28 -0400
Received: from mail-db8eur05on2047.outbound.protection.outlook.com ([40.107.20.47]:64032
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235976AbhHKIH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:07:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMcac1k0nIf4WkGCtjJL873FnN3gJiRT/eg1/cGWncjyC/72Sy9kk2qPNmhR0l/ktG7mO0MYBsVC7La0YAJ/cGEOGss1U2Wtmrbmoe8DMadd+D/GphwiK6npo/nvD6vzjxrr1ZTRLCB+CV9Pzwr96pv3YNFW7XkvwhL5+wT12v0v7oQ2lqd22mHW5QHU0UAifzDRXtWD+pTGe3vkJMyXaUhqkuir7ew1JSPQnNvRhPE4f6oPLQNdY8L2ILGR0DSHCFanxPauKZrUS4OLypjHjmTi3G5cUVf4NDHv8vdmYtxnGbZNNjAoPpCiOmVxz3pqCDK5Rd2plQlhZgnOSsClEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTn6DLOOzqpUMrGqdqjeV0KrwKMqez/DfuN1R0XbC7s=;
 b=l1OexEyEsEtBxyDCDmvrHUM2HQnaPm7uYouUi4hpC7+in27WnSBYJe3AlGhRDUwfs+y+54UhIXwe3lxx2IGqw3PqEBtOtTIdDlTRxMarA++qlSFVhYkspJ9UOz4i4z4nz4h7VQi0s8/7HqN+aUFmXvxeYqaq5wV5vP1e/sLeJFKFAzvBMSCOoObUO23uAPJsQyHWFem4NR/Cg7wvthyYnNB0QToWXiLTR5LI4/ECfcIbOBEHv3vlrrxvUN3yD7la5Ou46T/SzxlNVLoWmqKJSYSd2YBDARcf9jXjDWz+dS3l0KhD2TIzdwKMxq/lGdmQDk6Ridqd2M+hUodhcp0K6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTn6DLOOzqpUMrGqdqjeV0KrwKMqez/DfuN1R0XbC7s=;
 b=futeqR0C3KIhU0ZDaYvHxzbndCgeEvTIPm6AyqyjMcF1G97pkBOlNXg8aZWXmwgrqpXu3GLGzeafP5Kg0n7AC50B0ykWJnW4l3LXkmC4hsC32osFkTeU5GSWiv1KUc3Am+mqorkeC4QA5EUIdY4tfeFZoaWFvhjj4q81sF/iVds=
Received: from VI1PR04MB6800.eurprd04.prod.outlook.com (2603:10a6:803:133::16)
 by VI1PR04MB7054.eurprd04.prod.outlook.com (2603:10a6:800:12d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Wed, 11 Aug
 2021 08:06:33 +0000
Received: from VI1PR04MB6800.eurprd04.prod.outlook.com
 ([fe80::498:421b:7d3:a0c3]) by VI1PR04MB6800.eurprd04.prod.outlook.com
 ([fe80::498:421b:7d3:a0c3%8]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 08:06:33 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     =?gb2312?B?SmFuIEyouWJiZQ==?= <jlu@pengutronix.de>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data" property
Thread-Topic: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
 property
Thread-Index: AQHXjbpIBwDJH2bCBk6a1JjgGNijp6ts2VGAgAEYXzCAAAIpcA==
Date:   Wed, 11 Aug 2021 08:06:33 +0000
Message-ID: <VI1PR04MB6800D794307B1BDF7100E773E6F89@VI1PR04MB6800.eurprd04.prod.outlook.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
         <20210810073510.18218-2-qiangqing.zhang@nxp.com>
 <17daf0f387dff8145559df6a983b0a222c100514.camel@pengutronix.de>
 <VI1PR04MB6800F6169275A323DE0FD782E6F89@VI1PR04MB6800.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB6800F6169275A323DE0FD782E6F89@VI1PR04MB6800.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ce50fc5-d68a-45b9-785b-08d95c9eeeff
x-ms-traffictypediagnostic: VI1PR04MB7054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB7054F631A36235532E7C0BACE6F89@VI1PR04MB7054.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9vtb+KtIEs3hnSR+L7FZTte0T3QrsjqrzkbcKbIN7xTtT9kh8V2A/NSF5Vy7+Zxekygk4M4oJ1LYY0FsqMb8G9VjVumqp0bYZgjLwprxRMRoEnSJJtMyXoG/ezuMO3IQm9dvK0UcBeUE4/xQxtXOunZhAJ0+Dv951no7CskKVT7dtt/1072Y4bj/V3JXAbyGew4UnqrwRG2jOBC6aWXs66/9FmuUcDH91qyiqgoacYZYsrrafcTKVJ5MZdwqEBl9vFs6qbbd+516/AumAW4tfnHNib7aCLlnc5x318p0+Ht6NGWuu5YoBB35a4cwbPDYZ4kGO1up7TMrDDImokpgIKupyEgGX1gnR6c/A7RRSAypluDSq8okidnZQ3Q9TR8aqvKbJovxbnSt1v3NWOWajHqR6+gL8+4CXEdWwTU+rs3HFCLpMuXClMT4D9lYkT6/WAD8pdihwcTLH4/U4VF1JgJjGHsVgvYtrloeNbc6/Xk03MjL48NDFuE916coUdW3lNXJ2mm/iNIXAYnGpnCF5s+9+g2IaZ4KAgy7RgjR0sfSbsFRjrARfabyi7XbgQP+8lgeBncQgcV2MRf+Fpnzgstsr3HZ671CEgWiUz4FXMou33E+jmZJHVjl/7BzwS/M6NhDDK3XsYeCzezGupomtJFmdsinnn7BE0OGBF1sHaLpwrN8cuXBX6geH0YRx4UwgbaEPmODaAfJSKAVtCeW1eHpyehS7FI7HWmceSOYuIOdHRQ0CYwrv9Tt55JLobfKrOE1nzPxq0TmgZkcCh6MBsp+LNFX04jAQBKAmBupzRU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(76116006)(66446008)(64756008)(2906002)(55016002)(66556008)(66946007)(71200400001)(66476007)(7696005)(122000001)(38100700002)(5660300002)(9686003)(52536014)(4326008)(86362001)(83380400001)(66574015)(316002)(8676002)(26005)(6506007)(966005)(186003)(2940100002)(478600001)(8936002)(110136005)(54906003)(38070700005)(53546011)(45080400002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dWlsdTBIeUluY0N4dmROMkFsdVozUVhpcVJKdXBtKytxNEc1NEpFenc2QVFi?=
 =?gb2312?B?WCszc2pjQkg0UlNPQWJlWDJYbTVUYkdLWE5PeGV5Yi9PaHBkZDQwNFk5Szcz?=
 =?gb2312?B?ZS9SVzZhYTdMWVJGenFHelo5OU5yOXc5aDUyQ21DSlcyZmFtbWdOTVRxZEtv?=
 =?gb2312?B?Vkx4bU14WTBFcHFyV2hlbTZ3bVpUd3IrTStGY2JHdHFkbU5Cckl0Q21lVXdB?=
 =?gb2312?B?VEhLNXhMV1ZhYnVLQkxuN2poVGdndDE2SkthZXhuSWptRm4wQUNEVlNnaW0v?=
 =?gb2312?B?djN6ZTN3SDRsWEdtMWNNaXZQNDkwbkRkS3QranNGeXBqeHg1TVRPeHJSN0NR?=
 =?gb2312?B?ZXloU2FqZ3p3bEJnTzN6b3FrSzJVMG9MMUNFaVovNXU4ZiswdTBCODlUSDNK?=
 =?gb2312?B?L0RRRlMyNnVNZE9taGRFR0Zhd3VSZ2xyeVBjbDh0V0JFTHpoZUM1TVVudnJE?=
 =?gb2312?B?QVpmdE9DY1laNndtaVFqV2FkZEZkN1RVL2lVWDRVa2ViNFArT24rZDU2RGR3?=
 =?gb2312?B?QWIvL0hsMUlNa201aExoT0IvbFE4UXk0N3drNE1WU28xcnQ4K3hkeXUvMFor?=
 =?gb2312?B?b2JYaDBrWTF4ZnJLVG9HazBjcVlQbk9IVkQyVjk5Mk9sR2EycUljdWpheG03?=
 =?gb2312?B?NlY2M3lNWmQ4cytzeWZ0RkYrV0dQR1ZWUDEwYlVPRTR6S1hGUFBDVmwyd1FQ?=
 =?gb2312?B?dTdoUVVCM1ZpanA1NGo4dDZyZGpVYUhJSFhyYm5LVlBaV2FZMHFOSzZTbUYx?=
 =?gb2312?B?NEQ4TkQvaTVkbGUzTDJCWUhaNnF3dk1NeW1MT28wR3hCZkw4MllpM3hKaHFi?=
 =?gb2312?B?RWdLbzhNL1VKRmd1VWlOMVQ4dFQ0UHUvWEpaWTZxTExhc29jU2t5MVp1MUNH?=
 =?gb2312?B?YloxZFJIZnNUWlNVcC8zL1UvUmVudFZVckVDWmVIYjkxbk5rKzFNN3ZuUXFr?=
 =?gb2312?B?N1Jacnp1VkdrS2krVk9mQzc3OUhQekpJLzk2NTZhS0xHN3FieGhiWUNIeVVF?=
 =?gb2312?B?bU1jYU9pdGtjYjRybDFpeEFycUpCczJKUkNOTlhJdFpETUREQUlFWUx6WHJW?=
 =?gb2312?B?SXQ2UWtSWTdZOU9QMkN1eUlob2JmODRCYlNDK2lvZE50Qkp1SDNaM1NlVmpR?=
 =?gb2312?B?ejBPZ1FPa3ZOR0VTVWR4VHNYUDlaNk4yTUtMQzBLa0xGQmVYeEJicFo2bEhk?=
 =?gb2312?B?cmowNVZEVGFEK3U1Q3ovdXY5cGhDSndUQlNJdjl6cGFqUmptWnlRdzE0TWlG?=
 =?gb2312?B?YkxldjRVbktacTFRcDlpVTY5MnN3UVgxVWFMdk8xSHJFNXk4clhYa2Q1clNT?=
 =?gb2312?B?b2IwZ0FacUZ1VW9tN3Uyc1FQVkNGV1QvUlFyYkpYL0psUElEY3I4bDU5aEpN?=
 =?gb2312?B?cVFMUFNKQUlpa00vVzFHd3hwOC9tVUFhVm1hK1FrL2llOHlzeVhKbjEzc2ZV?=
 =?gb2312?B?YmRqa0w4Smd5d290S3c2MlNBVGF2TXhFRjFUM3owRzVEQllZMnU0VXNHSHkw?=
 =?gb2312?B?ZjRBRUgyL0NVMElTNFhWaUhBd1ZKbFdoL3RrRTRXUUw4SjJzVHJSWG03ZXQ1?=
 =?gb2312?B?TE5ZeVVNUktlY0pDYzZtYVVXUE13QjNON0lERXlYbzh5VC9wck5kanlvN3Bw?=
 =?gb2312?B?NEFjTmxhSFlUQmtzRXZrL1MwQzdTVVJBdkY2cDlPNDNwZnhUS1FHUXJENVFv?=
 =?gb2312?B?SCs0ZThleDRVVEwrdk5KcEl3eW5BTm9DK0I0a29HeWY2WkVxd2V2ODNmOUFu?=
 =?gb2312?Q?VzVDfnGfy/McnNofhwhgndXxDwQWuY5yARGtNpl?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce50fc5-d68a-45b9-785b-08d95c9eeeff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 08:06:33.2430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBQCux10ZfpGx6hlN4iC9z9gA1sRDh1IFrwOHpy5E4HkECG+xys9qWti3qd+YNSral2TrbW//eJm5kLRDy3ttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9ha2ltIFpoYW5nIDxx
aWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gU2VudDogMjAyMcTqONTCMTHI1SAxNjowNQ0KPiBU
bzogSmFuIEyouWJiZSA8amx1QHBlbmd1dHJvbml4LmRlPjsgc3Jpbml2YXMua2FuZGFnYXRsYUBs
aW5hcm8ub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmcNCj4g
Q2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjEgMS80XSBiaW5kaW5nczogbnZtZW06IGlu
dHJvZHVjZSAicmV2ZXJzZS1kYXRhIg0KPiBwcm9wZXJ0eQ0KPiANCj4gDQo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBKYW4gTKi5YmJlIDxqbHVAcGVuZ3V0cm9uaXgu
ZGU+DQo+ID4gU2VudDogMjAyMcTqONTCMTDI1SAyMzoxNA0KPiA+IFRvOiBKb2FraW0gWmhhbmcg
PHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsNCj4gPiBzcmluaXZhcy5rYW5kYWdhdGxhQGxpbmFy
by5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gPiBzaGF3bmd1b0BrZXJuZWwub3JnDQo+ID4g
Q2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPjsNCj4gPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFYxIDEvNF0gYmluZGluZ3M6IG52bWVt
OiBpbnRyb2R1Y2UgInJldmVyc2UtZGF0YSINCj4gPiBwcm9wZXJ0eQ0KPiA+DQo+ID4gT24gVHVl
LCAyMDIxLTA4LTEwIGF0IDE1OjM1ICswODAwLCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4gPiBJ
bnRyb2R1Y2UgInJldmVyc2UtZGF0YSIgcHJvcGVydHkgZm9yIG52bWVtIHByb3ZpZGVyIHRvIHJl
dmVyc2UgYnVmZmVyLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBaaGFuZyA8
cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0vbnZtZW0ueWFtbCB8IDUgKysrKysNCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9udm1lbS55YW1sDQo+ID4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9udm1lbS55YW1sDQo+
ID4gPiBpbmRleCBiOGRjM2QyYjZlOTIuLmJjNzQ1MDgzZmM2NCAxMDA2NDQNCj4gPiA+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9udm1lbS55YW1sDQo+ID4g
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0vbnZtZW0ueWFt
bA0KPiA+ID4gQEAgLTYxLDYgKzYxLDExIEBAIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ID4gICAg
ICAgICAgICAgICAgZGVzY3JpcHRpb246DQo+ID4gPiAgICAgICAgICAgICAgICAgIFNpemUgaW4g
Yml0IHdpdGhpbiB0aGUgYWRkcmVzcyByYW5nZSBzcGVjaWZpZWQgYnkgcmVnLg0KPiA+ID4NCj4g
PiA+ICsgICAgICByZXZlcnNlLWRhdGE6DQo+ID4gPiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90
eXBlcy55YW1sIy9kZWZpbml0aW9ucy9mbGFnDQo+ID4gPiArICAgICAgICBkZXNjcmlwdGlvbjoN
Cj4gPiA+ICsgICAgICAgICAgUmV2ZXJzZSB0aGUgZGF0YSB0aGF0IHJlYWQgZnJvbSB0aGUgc3Rv
cmFnZSBkZXZpY2UuDQo+ID4NCj4gPiBJJ2QgcHJlZmVyIGlmIGl0IHdhcyBtb3JlIGV4cGxpY2l0
IHRoYXQgdGhlICpieXRlcyogd2lsbCBiZSByZXZlcnNlZC4NCj4gPiBPdGhlcndpc2UgYSByZWFk
ZXIgbWlnaHQgdGhpbmsgdGhhdCB0aGlzIGlzIHJldmVyc2luZyBvbiB0aGUgKmJpdCogbGV2ZWwu
DQo+IA0KPiBNYWtlIHNlbnNlLCBob3cgYWJvdXQgJ3JldmVyc2UtYnl0ZS1vcmRlcic/DQoNClNv
cnJ5LCAncmV2ZXJzZS1ieXRlcy1vcmRlcicuDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFu
Zw0KPiBCZXN0IFJlZ2FyZHMsDQo+IEpvYWtpbSBaaGFuZw0KPiA+IEphbg0KPiA+DQo+ID4gPiAr
DQo+ID4gPiAgICAgIHJlcXVpcmVkOg0KPiA+ID4gICAgICAgIC0gcmVnDQo+ID4gPg0KPiA+DQo+
ID4gLS0NCj4gPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0K
PiA+IHwNCj4gPiBTdGV1ZXJ3YWxkZXIgU3RyLiAyMSAgICAgICAgICAgICAgICAgICAgICAgfA0K
PiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwJTNBJTJGJTJGd3d3LnANCj4gPiBlDQo+ID4NCj4gbmd1dHJvbml4LmRlJTJGJmFtcDtkYXRh
PTA0JTdDMDElN0NxaWFuZ3FpbmcuemhhbmclNDBueHAuY29tJTdDNzkNCj4gPg0KPiAzYTYwMTg4
NTQwNDU1OTE5YjYwOGQ5NWMxMTg4NzglN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYz
DQo+ID4NCj4gNSU3QzAlN0MwJTdDNjM3NjQyMDUyNjM3OTk0NzQ5JTdDVW5rbm93biU3Q1RXRnBi
R1pzYjNkOGV5SldJDQo+ID4NCj4gam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJU
aUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzENCj4gPg0KPiAwMDAmYW1wO3NkYXRhPVMyN084
QVY4bFJ2R3h5RXV0Smw2VWg0QWpiQXJEJTJCa3ZRbCUyRkkwNVpVMVA4JTNEDQo+ID4gJmFtcDty
ZXNlcnZlZD0wICB8DQo+ID4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAg
ICAgIHwgUGhvbmU6DQo+ICs0OS01MTIxLTIwNjkxNy0wDQo+ID4gfA0KPiA+IEFtdHNnZXJpY2h0
IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICAgICAgICAgICB8IEZheDoNCj4gPiArNDktNTEyMS0yMDY5
MTctNTU1NSB8DQoNCg==
