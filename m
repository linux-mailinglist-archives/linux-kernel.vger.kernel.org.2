Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A144155A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 04:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbhIWCxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 22:53:42 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:63875
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238905AbhIWCxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:53:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMyl73H4YiUuLicHy0v3XRK4wfstLvi1C8UtqCr5nMf4iOXh2wpQsWWAQrYyrdEM636YMpqZQRPpR3AlHSkosOzO3VIwBVrIFVOGpCTntGnUbZLofIemWUU4EItHYkWFqcYRZrh334PG0NyZQ8PpR4Kz+6SftQa8cgLFP+tYrqssG3ndYO1bSrv/UEIGGpSHH1E2GcegM6nUiaIiZr558h+5V4kk81BmzkyHQyV/ctktqOzFc4Tcuq8qhQJNZFGQztZ7tUhH+QRFBxlkIQHVuSRV6mLoOBy/N8w7wZ+JfY292Xi2ieUAZWFM0RLZD1YozCeuM/DIAYB24BBAEEXrfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LPRfLaPaCcbRFg9Fle3SNdjtOQWYzLXtuxuzdfFexfs=;
 b=a3Z0k+lZCrVXL93Ia+Tlt8MLxmDyDJ4uOZurRfX//LM9RYXsQPdm6Vjc4CYk0pxrzB6xpzu9S7m6DzCoXTF2Mzs3OQCfm8Ydm2Bnit+S80OA/eBPeJucOw/bFHU3S1Y2OlyZjxA805Ds1AumETV8qIQrtBbjVCKREE9SW6aPcRWs3jBFKlRGFCZ9esrU0L62GdCCRYHdyeCf44oIZIJNSdAtqyyvmu67BqhZl9luxvZgSOh0KM9ZycuAAt24eyoKoGu02wEejsUatx5rcYYsAMVIIxj6XVxQ/b09ZDffAOyouZVDhPrCrhwA+WLBZZJ66wnACLqLtdUIlItPxR+K8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPRfLaPaCcbRFg9Fle3SNdjtOQWYzLXtuxuzdfFexfs=;
 b=XhnyBv1qQn927oZTiSLXkHNusM8bm0CyiPDeQhTUNwgGaHsFwEuQv3Iuid9MyKIMwPBYG23C2PTsW5z0puKxwrJA6XYkjSlhdwJpjSBjWho3z5aup/pKU1o4F+oS5+VEWFoffddSa3y2k+Y0i84MLL6EJjAPl6YavWp3tu3++Qg=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2325.eurprd04.prod.outlook.com (2603:10a6:4:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 23 Sep
 2021 02:52:08 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 02:52:08 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/6] nvmem: core: add nvmem cell post processing callback
Thread-Topic: [PATCH 3/6] nvmem: core: add nvmem cell post processing callback
Thread-Index: AQHXpJi95ziTm6aRJ0G9qvylM1rmWKuwAzWAgAD9mjA=
Date:   Thu, 23 Sep 2021 02:52:08 +0000
Message-ID: <DB8PR04MB679522814EBB72EE06B37A0AE6A39@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
 <20210908100257.17833-4-qiangqing.zhang@nxp.com>
 <c76b326d-fbef-8c4c-bda8-cef25cac0266@pengutronix.de>
In-Reply-To: <c76b326d-fbef-8c4c-bda8-cef25cac0266@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c92b8c6-e84b-497f-fc4a-08d97e3d2255
x-ms-traffictypediagnostic: DB6PR0401MB2325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB23255AF6D46C8EAF017C9C64E6A39@DB6PR0401MB2325.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r00Q4XxAcLY0ekFdEjaAIwnDUqbEMywAQduQi+BZ8oozS79WiN2PPz0bcQ9LXr3FJUp1q07A5QMlbNWVv1oWfkUCYdzwosueAsMQEauoj5P0lZSEpQiyEtqwV7wjzCeLCSeL49WKXi2FNaHuFzRPtzHm/riEaicNzbGENppGXf+Kf3j0m76Huq9vJlt8JRNG+3bZOT+qbs9yXFwdKJj2+ho504P9tOv6Cm68kFpcx3viD/BuJgFDHIudGJlkJNQsKBxiXwk9EmhYrYtBl6uvAoOIzR0pqWdNpooou9tnoQZLPHjSSE2aVv9+eCz3wtYHZ3v6omgykhHqRMoWBmW1+YaPYDGxvvZ0I1B84M/2LyV0tj/rR8gyKxZCGf8CJzpQgVxtVvYyZUztkaRh4uo37IlplIwahBmFCDqJ2zHx4Qp76FrmNQJ9Y9qRY1YJjEehvIGYFXxDaGpWwRUEoBRWTxzh7qs0DMeeb/VVbmdewGPrN1nq787n1h3Kfd0K3VZfZ424qLgqCHQ6ZnvALxB+Uf/cdkzopTFAAR3wI//i/CyPR2v3nF4e0zevxIMKPCpdAIZKwEeBhnQorYlze2CPwur0J6nW3dKX3kCTdyxvGaB5ptFgi5bpybsYE0b9CheTnhhHtyxm55qyjwFkryjUVB9hWvBDxI5QdB6NP7korqUwouoBe7DTKAcPxw6XI1wRfI1NRLwPqxdEmtuhI8TExzFKagJcywMII4gD6Pwnd40F00sJDhWyexzs1YDFybZMdgSmc30g6gW11cBmPu/BSkv+hpPbytzlqgPIlJwemOE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(54906003)(7696005)(71200400001)(66476007)(5660300002)(66556008)(2906002)(64756008)(316002)(508600001)(110136005)(45080400002)(33656002)(83380400001)(8936002)(186003)(38100700002)(122000001)(8676002)(6506007)(4326008)(66946007)(55016002)(86362001)(52536014)(53546011)(38070700005)(76116006)(26005)(966005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WVU4Z3ZHb0liTjV4MlhaQUpIdmo4QUYzUkhPZVlKZ3VkQmdCWm5pSVk4MHFr?=
 =?gb2312?B?dkZLdGhFWmZ1eWNicE9FaWdiZ21OOFNmVnNFNVFlUEF5WXRiMGhrc0lQK1Iz?=
 =?gb2312?B?c3RJNkRNQTNFbEZCZmJza05NcE1GcVYzT0J0Q2V3eDE5YnFmeHF0OHNwT0Vn?=
 =?gb2312?B?MHdrbDVFUTB1TjJESG5XYm92MTJkU1ZtTDNXUExJbFQzTDRsR3dGb2xueVB1?=
 =?gb2312?B?bExsTm1ZQUZsS0QwN1pNWTY3REZGQndUeEJleHdKUVNHRG1mNVhBdGZEd21U?=
 =?gb2312?B?ZldySmVISGRPdUkzWjJsOWF5VFg4bW9hb1liV1h3Sm9rMGhhSnJSOEVtOVJS?=
 =?gb2312?B?RnU5ek5NN2lKVS8xblhqbTRkOW92dkMva0NIcC9PMk90dkdHbldsd1Q2L3FP?=
 =?gb2312?B?UkgxdVhVeHN4dzJ4MDR5Z3pJNXRRUDc2YXN5dEZKZmxrS1JRMWJySmsrSUxL?=
 =?gb2312?B?Q0VuWk9HWTNQWExJN2FHbHdGYVp0aWZSY2Zkc0VuUjNQS0ZJMzI2dlVvbVpP?=
 =?gb2312?B?Q1hBWmNta1JEc0ZVSkdsNERna3pKUUk1RHpvMEhtS3N3dTBMbzdVdDh5OEJ0?=
 =?gb2312?B?bkFKZy9DQTRsTEJKRDZ3N3NZenVZT3pHSm9rd1dpUEpiZ3RkUDQ5eG9hVEQr?=
 =?gb2312?B?OGFMTkNnbURDUm54bml4TlVjdkNmRFpydEJxdElsUG5vSDNaZHZ1YmQ3V2Nw?=
 =?gb2312?B?bWZ4T3NPY29tdTg1NFhhTWt0MFRGS3p6L2N0SVgzcUNhNUlJemRMVCtwbHBm?=
 =?gb2312?B?dmhLWXQzK1RQV0hoVXlYSHcxYnFVWTVQblVHYkRPNU9NUXZhRk1hQWtwT2dE?=
 =?gb2312?B?WmdNczV0R1B5MkVtNzR1OXl1cE1LWm02eW81RDk3b0tPdklRRC9JRm5LYW5k?=
 =?gb2312?B?dzkxMmlDVEVRZmxhaFVCQnRtQk45RlBNcWxZUFhSUDlnSzJodGp2YWI0R0RR?=
 =?gb2312?B?S0Jkenp0VFhQQjJLTGhSQ1ZZL0VOTjBUMk9kS0luUGdMS3BzM1l3azB3M2JQ?=
 =?gb2312?B?L0VoeVcvbyt5dzJzcThwbDYyRXFGaEY1dW1HY1YrWnZxVmt6czJidkVaMFI0?=
 =?gb2312?B?VVpYOEpKcGc1VGFrSGt2MENkbGJyd0o5aE9JL2YxejNSclE1Yk9jVzA1N200?=
 =?gb2312?B?Z01lNit0TDZmb2J3Z0Z6b3Rmd1VLd2FLNUYrN0JFTGJkc1p2dFUrVTRXY1Bu?=
 =?gb2312?B?TFF3SWUwSGtuejBPNmppOEQrcklMUDZUWStGRHlxeHNqalY2Z0ltUG9IWWRn?=
 =?gb2312?B?VDdnT0REczVMVFk1ODZLQ3E3dHk3QkJEYUIrWjFCTkc4Q1hyMGg3WXMreUxD?=
 =?gb2312?B?bXJJWlJPUmk1bTlnd3MzbGZhTEdJbldqb084ekhDc1FsaUducTRUVW83THJt?=
 =?gb2312?B?TU1TUWtmdlVIcm10TkY5aDBUdnl4QlVvMUdhbUFzejk0anc1L0xDOU5HaEpM?=
 =?gb2312?B?RFU3cm9oY08vR2NmWnk3aUNZSitsUFlKdFRxT0kyLzRaOXpoYVN2S05BcTFN?=
 =?gb2312?B?MXhDckVnUW1GODlWdi9DeGM4QTlzdUpNanZIdXV5OGwxRmc4WkRabzA3Yk1n?=
 =?gb2312?B?a2VKRXlObDczRjNLaUlBT1lsTlNocVlMUVJzc1JPd3VXZWtGYjJZODFtOFBm?=
 =?gb2312?B?N01kQTczbTIyUmxiM1RWTDRlRjVScFZRSW9mY0tONlh4bi9hUy9UZVdkam5x?=
 =?gb2312?B?NnFUWEppaGlNR1c3OGhuMkRBUjZqNU5iWmF6ak5sL0hxSzNzN3krVDJaNWg1?=
 =?gb2312?Q?rkSrWuLENEOocc0Y9tl53qxwatnRUO7B/mgYg/a?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c92b8c6-e84b-497f-fc4a-08d97e3d2255
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 02:52:08.2238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CvxkGnuqSSu0Am8Qadz+6AqKJ/ao4mGt0bOrBrsvVK/aNG8b27xE692J20FmjMylJd8rt0DMEO2wxap2EoznGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2325
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBBaG1hZCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBaG1h
ZCBGYXRvdW0gPGEuZmF0b3VtQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIxxOo51MIyMsjV
IDE5OjM3DQo+IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsNCj4g
c3Jpbml2YXMua2FuZGFnYXRsYUBsaW5hcm8ub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IHNoYXdu
Z3VvQGtlcm5lbC5vcmcNCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBkbC1saW51
eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy82XSBudm1l
bTogY29yZTogYWRkIG52bWVtIGNlbGwgcG9zdCBwcm9jZXNzaW5nDQo+IGNhbGxiYWNrDQo+IA0K
PiBPbiAwOC4wOS4yMSAxMjowMiwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+IEZyb206IFNyaW5p
dmFzIEthbmRhZ2F0bGEgPHNyaW5pdmFzLmthbmRhZ2F0bGFAbGluYXJvLm9yZz4NCj4gPg0KPiA+
IFNvbWUgTlZNRU0gcHJvdmlkZXJzIGhhdmUgY2VydGFpbiBudm1lbSBjZWxscyBlbmNvZGVkLCB3
aGljaCByZXF1aXJlcw0KPiA+IHBvc3QgcHJvY2Vzc2luZyBiZWZvcmUgYWN0dWFsbHkgdXNpbmcg
aXQuDQo+ID4NCj4gPiBGb3IgZXhhbXBsZSBtYWMtYWRkcmVzcyBpcyBzdG9yZWQgaW4gZWl0aGVy
IGluIGFzY2lpIG9yIGRlbGltaXRlZCBvcg0KPiByZXZlcnNlLW9yZGVyLg0KPiA+DQo+ID4gSGF2
aW5nIGEgcG9zdC1wcm9jZXNzIGNhbGxiYWNrIGhvb2sgdG8gcHJvdmlkZXIgZHJpdmVycyB3b3Vs
ZCBlbmFibGUNCj4gPiB0aGVtIHRvIGRvIHRoaXMgdmVuZG9yIHNwZWNpZmljIHBvc3QgcHJvY2Vz
c2luZyBiZWZvcmUgbnZtZW0gY29uc3VtZXJzIHNlZQ0KPiBpdC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNyaW5pdmFzIEthbmRhZ2F0bGEgPHNyaW5pdmFzLmthbmRhZ2F0bGFAbGluYXJvLm9y
Zz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL252bWVtL2NvcmUuYyAgICAgICAgICAgfCA5ICsr
KysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L252bWVtLXByb3ZpZGVyLmggfCA1ICsrKysrDQo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZW0vY29yZS5jIGIvZHJpdmVycy9udm1lbS9jb3JlLmMgaW5kZXgNCj4g
PiAyM2MwOGRiYWY0NWUuLjRmODFhM2FkZjA4MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL252
bWVtL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbnZtZW0vY29yZS5jDQo+ID4gQEAgLTM4LDYg
KzM4LDcgQEAgc3RydWN0IG52bWVtX2RldmljZSB7DQo+ID4gIAl1bnNpZ25lZCBpbnQJCW5rZWVw
b3V0Ow0KPiA+ICAJbnZtZW1fcmVnX3JlYWRfdAlyZWdfcmVhZDsNCj4gPiAgCW52bWVtX3JlZ193
cml0ZV90CXJlZ193cml0ZTsNCj4gPiArCW52bWVtX2NlbGxfcG9zdF9wcm9jZXNzX3QgY2VsbF9w
b3N0X3Byb2Nlc3M7DQo+ID4gIAlzdHJ1Y3QgZ3Bpb19kZXNjCSp3cF9ncGlvOw0KPiA+ICAJdm9p
ZCAqcHJpdjsNCj4gPiAgfTsNCj4gPiBAQCAtNzk3LDYgKzc5OCw3IEBAIHN0cnVjdCBudm1lbV9k
ZXZpY2UgKm52bWVtX3JlZ2lzdGVyKGNvbnN0IHN0cnVjdA0KPiBudm1lbV9jb25maWcgKmNvbmZp
ZykNCj4gPiAgCW52bWVtLT50eXBlID0gY29uZmlnLT50eXBlOw0KPiA+ICAJbnZtZW0tPnJlZ19y
ZWFkID0gY29uZmlnLT5yZWdfcmVhZDsNCj4gPiAgCW52bWVtLT5yZWdfd3JpdGUgPSBjb25maWct
PnJlZ193cml0ZTsNCj4gPiArCW52bWVtLT5jZWxsX3Bvc3RfcHJvY2VzcyA9IGNvbmZpZy0+Y2Vs
bF9wb3N0X3Byb2Nlc3M7DQo+ID4gIAludm1lbS0+a2VlcG91dCA9IGNvbmZpZy0+a2VlcG91dDsN
Cj4gPiAgCW52bWVtLT5ua2VlcG91dCA9IGNvbmZpZy0+bmtlZXBvdXQ7DQo+ID4gIAlpZiAoY29u
ZmlnLT5vZl9ub2RlKQ0KPiA+IEBAIC0xNDA0LDYgKzE0MDYsMTMgQEAgc3RhdGljIGludCBfX252
bWVtX2NlbGxfcmVhZChzdHJ1Y3QNCj4gbnZtZW1fZGV2aWNlICpudm1lbSwNCj4gPiAgCWlmIChj
ZWxsLT5iaXRfb2Zmc2V0IHx8IGNlbGwtPm5iaXRzKQ0KPiA+ICAJCW52bWVtX3NoaWZ0X3JlYWRf
YnVmZmVyX2luX3BsYWNlKGNlbGwsIGJ1Zik7DQo+ID4NCj4gPiArCWlmIChudm1lbS0+Y2VsbF9w
b3N0X3Byb2Nlc3MpIHsNCj4gPiArCQlyYyA9IG52bWVtLT5jZWxsX3Bvc3RfcHJvY2Vzcyhudm1l
bS0+cHJpdiwgY2VsbC0+dHlwZSwNCj4gPiArCQkJCQkgICAgICBjZWxsLT5vZmZzZXQsIGJ1Ziwg
Y2VsbC0+Ynl0ZXMpOw0KPiA+ICsJCWlmIChyYykNCj4gPiArCQkJcmV0dXJuIHJjOw0KPiA+ICsJ
fQ0KPiA+ICsNCj4gPiAgCWlmIChsZW4pDQo+ID4gIAkJKmxlbiA9IGNlbGwtPmJ5dGVzOw0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbnZtZW0tcHJvdmlkZXIuaA0KPiA+IGIv
aW5jbHVkZS9saW51eC9udm1lbS1wcm92aWRlci5oIGluZGV4IDEwNDUwNWU5MDI4Zi4uZDk4MGM3
OWY5NjA1DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9udm1lbS1wcm92aWRl
ci5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9udm1lbS1wcm92aWRlci5oDQo+ID4gQEAgLTE5
LDYgKzE5LDkgQEAgdHlwZWRlZiBpbnQgKCpudm1lbV9yZWdfcmVhZF90KSh2b2lkICpwcml2LCB1
bnNpZ25lZA0KPiBpbnQgb2Zmc2V0LA0KPiA+ICAJCQkJdm9pZCAqdmFsLCBzaXplX3QgYnl0ZXMp
Ow0KPiA+ICB0eXBlZGVmIGludCAoKm52bWVtX3JlZ193cml0ZV90KSh2b2lkICpwcml2LCB1bnNp
Z25lZCBpbnQgb2Zmc2V0LA0KPiA+ICAJCQkJIHZvaWQgKnZhbCwgc2l6ZV90IGJ5dGVzKTsNCj4g
PiArLyogdXNlZCBmb3IgdmVuZG9yIHNwZWNpZmljIHBvc3QgcHJvY2Vzc2luZyBvZiBjZWxsIGRh
dGEgKi8gdHlwZWRlZg0KPiA+ICtpbnQgKCpudm1lbV9jZWxsX3Bvc3RfcHJvY2Vzc190KSh2b2lk
ICpwcml2LCBpbnQgdHlwZSwgdW5zaWduZWQgaW50IG9mZnNldCwNCj4gPiArCQkJCQkgIHZvaWQg
KmJ1Ziwgc2l6ZV90IGJ5dGVzKTsNCj4gPg0KPiA+ICBlbnVtIG52bWVtX3R5cGUgew0KPiA+ICAJ
TlZNRU1fVFlQRV9VTktOT1dOID0gMCwNCj4gPiBAQCAtNjIsNiArNjUsNyBAQCBzdHJ1Y3QgbnZt
ZW1fa2VlcG91dCB7DQo+ID4gICAqIEBub19vZl9ub2RlOglEZXZpY2Ugc2hvdWxkIG5vdCB1c2Ug
dGhlIHBhcmVudCdzIG9mX25vZGUgZXZlbiBpZg0KPiBpdCdzICFOVUxMLg0KPiA+ICAgKiBAcmVn
X3JlYWQ6CUNhbGxiYWNrIHRvIHJlYWQgZGF0YS4NCj4gPiAgICogQHJlZ193cml0ZToJQ2FsbGJh
Y2sgdG8gd3JpdGUgZGF0YS4NCj4gPiArICogQGNlbGxfcmVhZF9jYWxsYmFjazogQ2FsbGJhY2sg
Zm9yIHZlbmRvciBzcGVjaWZpYyBwb3N0IHByb2Nlc3NpbmcNCj4gPiArIG9mIGNlbGwgZGF0YQ0K
PiANCj4gVGhlIG1lbWJlciBiZWxvdyBpcyBjYWxsZWQgY2VsbF9wb3N0X3Byb2Nlc3MNCg0KR29v
ZCBjYXVnaHQhIFdpbGwgZml4IGl0IGluIFYyLiBUaGFua3MuDQoNCkJlc3QgUmVnYXJkcywNCkpv
YWtpbSBaaGFuZw0KPiA+ICAgKiBAc2l6ZToJRGV2aWNlIHNpemUuDQo+ID4gICAqIEB3b3JkX3Np
emU6CU1pbmltdW0gcmVhZC93cml0ZSBhY2Nlc3MgZ3JhbnVsYXJpdHkuDQo+ID4gICAqIEBzdHJp
ZGU6CU1pbmltdW0gcmVhZC93cml0ZSBhY2Nlc3Mgc3RyaWRlLg0KPiA+IEBAIC05Miw2ICs5Niw3
IEBAIHN0cnVjdCBudm1lbV9jb25maWcgew0KPiA+ICAJYm9vbAkJCW5vX29mX25vZGU7DQo+ID4g
IAludm1lbV9yZWdfcmVhZF90CXJlZ19yZWFkOw0KPiA+ICAJbnZtZW1fcmVnX3dyaXRlX3QJcmVn
X3dyaXRlOw0KPiA+ICsJbnZtZW1fY2VsbF9wb3N0X3Byb2Nlc3NfdCBjZWxsX3Bvc3RfcHJvY2Vz
czsNCj4gPiAgCWludAlzaXplOw0KPiA+ICAJaW50CXdvcmRfc2l6ZTsNCj4gPiAgCWludAlzdHJp
ZGU7DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KPiB8DQo+IFN0ZXVlcndhbGRlciBTdHIuIDIxICAgICAgICAgICAgICAg
ICAgICAgICB8DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwJTNBJTJGJTJGd3d3LnBlDQo+IG5ndXRyb25peC5kZSUyRiZhbXA7ZGF0YT0w
NCU3QzAxJTdDcWlhbmdxaW5nLnpoYW5nJTQwbnhwLmNvbSU3Qzg1DQo+IDRkY2FkNDYxOTE0YWE0
MjI3ZTA4ZDk3ZGJkNTZmMCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1DQo+ICU3
QzAlN0MwJTdDNjM3Njc5MDc0NDI0NjcxNjQ4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJ
ag0KPiBvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbjAlM0QlN0MxMA0KPiAwMCZhbXA7c2RhdGE9bll4bnVGYkZCOVBoR2ZFVVBpd2c3ZEpPUjJo
UUhWNU5iamZUMU55S1dCTSUzRCZhDQo+IG1wO3Jlc2VydmVkPTAgIHwNCj4gMzExMzcgSGlsZGVz
aGVpbSwgR2VybWFueSAgICAgICAgICAgICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0w
DQo+IHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4
Og0KPiArNDktNTEyMS0yMDY5MTctNTU1NSB8DQo=
