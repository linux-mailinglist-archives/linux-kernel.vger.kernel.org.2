Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D303AB37F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhFQM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:26:26 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:61963
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231310AbhFQM0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:26:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggYJTaEn2YIn2v5dyMIFlAXkopvJ75wHry615f6FPyFnsHr7bFcfrH+CiRGtk+6QO1oQZiQnxdlK6ePQw2bSvtRr7r8lI7bLW8MxpNAJvMUqDDgp2QJ/HTeoEzA9mFV12LjPa/DA6VbYNjPGUP+2tw8vJ91SstchcVFeoWWF9jcklvqeAR38sVV3JzuSf9bZG+6n0MxMQAwRvBGJzZyKe+qBR5H01AtoHx3sJhuopQdtbkflACEUu9zL7Zrbnf0/Ws2aM+krFbwd8N2FloPWluWdjH2mY8x7h4sQQ6eVKgdsYtXNO05BK2ee+SC+pwon869FD6V2u0b0ssUsldBWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SfhF7BrKl/88cx5ewQBQRmXdCky3SYGO81AsllaUuQ=;
 b=ADfsbyxYhFG3YyGja0z3Vekj/DAVZ5UNMR5iPlaETuoUgJXZ2xLkhyZE20bBzje2Odm+4RkezIOxUF558KOTgb0CuSxeQc/Qo1HddsOYvqfdHCpushAt0yiN0u2T2reeHwwqACqf+cqEcrDGDQlcqpmZnobOQDcwGnAxa/EWmBU35FCBkBHVFrpxzO9Vzdl88/isabU9TK6nOBcXTV5si/68dstN/VQQ9M1hWHF4an2VQCSNhej1vmuBmWK2fBz1G6lr8oMfsuXs32kxTryYhD1NKAecOe2E9vmjh/GVD03aFEAp5le166CfMbSrBlXPVXkgGlfiGMun749AJnVLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SfhF7BrKl/88cx5ewQBQRmXdCky3SYGO81AsllaUuQ=;
 b=TkWIGZJCuR+1yaTOJmpqvcd3NjDCkBVBjrl3tTW4xRP5ed5o299PFkZLNE0FDp7oO8X7w5FhHCJs3amIt1kF44Qh2nw7pPMIorxFtsSwt+8BJWVCycupkvDLMsNZO8Jr2lTwNtLEVag9mivffZtJ9Pv+kF9TK1jkfUew7qofN6Q=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8837.eurprd04.prod.outlook.com (2603:10a6:10:2e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 12:24:12 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2%9]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 12:24:12 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Frank Li <frank.li@nxp.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers/perf: fix the missed ida_simple_remove() in
 ddr_perf_probe()
Thread-Topic: [PATCH] drivers/perf: fix the missed ida_simple_remove() in
 ddr_perf_probe()
Thread-Index: AQHXY3LbGvPWieJUlUGiOQLqGZfB06sYH/Vg
Date:   Thu, 17 Jun 2021 12:24:12 +0000
Message-ID: <DB9PR04MB84777974EF797DA08E9DFD6F800E9@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20210617122614.166823-1-jingxiangfeng@huawei.com>
In-Reply-To: <20210617122614.166823-1-jingxiangfeng@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f8d1ad1-481a-4dce-8bf3-08d9318ad0b6
x-ms-traffictypediagnostic: DU2PR04MB8837:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DU2PR04MB88370E8333803B3A926CE542800E9@DU2PR04MB8837.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: opkG3W8LRK6wbAOmB4o6y8NBTgvhq9zUB1tkSdyRjd+drfUaDjB03PLEG00penX19dKYyPEWSMtI9Bm+Ta5iV3YbRT1nxaQnkFIHkbe4xxt/bVGpyHQVAwDbpcKhufHnaDk5z9a9nQIal9/Kc4OIvYa3D421nruR3lyXLQObvHRfxRE0+0owI+ibRXYG62LccpzfZamefJFSizaPlLt7NtD9QFMvzSZCjvYakg9+Rv6av8P0Es4Bl1tU5ehxS1bjl8xpWKJQzyLrEBAEo6JfilWnCilIqSWmFJDxFihje1biNHsXSU/dmj9I6GK4ED9EWgmN9WBGD1hx809zFkuJuiOVZkOZtGyWiBDoVOKGnlIR2nAW1tr/mMmYko3QGeo/h2RYepVcD2hQg+aifnSIL8+yMdU9SPzWBfZWIh8LPHTBCDKa49tDUBzPx4ghnv9HShtAX52sBs+Ul+EE4UFeJpm2BW+gHZhd/2XeHj1B1onajorXpE4w3Z7UhFxbC2PS4JdJ3CS1ZF6MpjF7PxI6XvspuBxy0Y0iozawElhv4HxdhBns+h1hVkK3E6YBdTzYaxYfEDA9hAFwxfa8oEfIsA3QWB0pvWp/mMpMuhiJNms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(376002)(136003)(346002)(83380400001)(8676002)(86362001)(71200400001)(478600001)(6506007)(9686003)(55016002)(2906002)(38100700002)(122000001)(53546011)(186003)(76116006)(4326008)(66476007)(64756008)(66446008)(66556008)(6636002)(66946007)(44832011)(316002)(110136005)(5660300002)(8936002)(52536014)(7696005)(26005)(33656002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzhwS1ZHQm4wbm5XYkt3aUU3aUVIYU9qQkhYUG1EVktUVjZPMUdqQ2R0azRZ?=
 =?utf-8?B?cHM4TzlUM2MwWThsU1lmaWJLek1qdkJ2VmpSU0xZVVUrckRQRzBzNStVS3U5?=
 =?utf-8?B?QTUvWnlOYnBrcFZHQXMwYzdkTHp2eGVmcmx4alptVWFHY09iZnBaVDF1YkV6?=
 =?utf-8?B?RjhiWXpycDZobGhWQksyUFpGNDNENDdCUnRmK0t5b2RPY2FqK0Z5amhqVTBl?=
 =?utf-8?B?VE9TM1JEeVI5TG5jZmoxQlg1bkdrQW1Pb1prUWRTZ1J0VmZuSStqd2hzdU8r?=
 =?utf-8?B?OWNEQjVUdkt4OEVSeCtmc0N6T3dFK1VJU2w5ckkyRnlSVzkzQ1VTQmI3TTNz?=
 =?utf-8?B?cXlQeks0YTdaWm4xaTRuTGZUMHlwR25DeU1lM3hRTVd3LzJ2Mm9RUVJWNWs5?=
 =?utf-8?B?M3RSeHowdkxEVFJSck5QMmlvVmpLVTdXVzdPbFl0SHdXdERTcmdvWXZ0UHd1?=
 =?utf-8?B?MldPSDRsYTRRZHZZT1V1UUs1M2RNdFloemhTeVZFS2FQOFNXdk1LTGQ5Rit6?=
 =?utf-8?B?RHpsSnBlR0VyakRUK3BiWnlpSVhTNG0wUnB3a2ZLSU12dlFiMGwwOHVFdU1J?=
 =?utf-8?B?Q1BFdUJ6VkJqTWpQZVhIQ1oyU0RPcDRzaCs5Nkl1Y216YXdTOXBmVGtlK0ZN?=
 =?utf-8?B?b2dBZVluOW15b3VVdWd3dTBUTlFxMTFuTzVpS2NaVTl4bW1UMS9YY25mNHY2?=
 =?utf-8?B?ZEk5RnZ4QnE3NjlJVkkyenc2RDhwZG5BSlhuVEFoSDNKdW1XOUNtLzZCc0N3?=
 =?utf-8?B?Q0JsMDd3TlE4L1RXU0g0b25USVgvd1VSV2cxTHVlelFCTm91bDFzWWd0SnBV?=
 =?utf-8?B?ekpXMmJDQ0oyWi9EOXRuWFBCaitteVBrYzVSZU9NMncwY29qVFlHVkRmZDZU?=
 =?utf-8?B?L0IzVEZqSE9PVEtVZU9IVTdySzV6M2RXcHViUHB4WWRYdzdSVkZOL2FRUVhD?=
 =?utf-8?B?dFE3YzNEeWllSU14Zjd3Nkd0bzJBOG9mYVlTWnpheG1pSUxEMUZtdWxkQjZO?=
 =?utf-8?B?Q24yOExFL3VBa3hyS1d5dS9YOWdkNHhYRTl2TE5aTHFkZGRJWTJDL0dpMHdM?=
 =?utf-8?B?ZWNtZDVVMWtDV2pPc0YxR2R6VHZicStXckRrUzd1UVlkQzZhVTFIeUN6NjZo?=
 =?utf-8?B?aFdiSk4wc1Y2ZVJxNGxjTklBZkZlUTRQU3pSQTNxS04vMHgwYmNhaHZ4SmJw?=
 =?utf-8?B?NWw1dkpSVlRlTVMwYzNwTERIdWhFaXdCZ1JvWWxwTFRKVUdjRmd2M3p5UWs5?=
 =?utf-8?B?QkhvQ2ViSjNsdjh6dW1SWndIY0c3N0tvTzU5R3VnbWFSQ29PcXIrSXpmUHRZ?=
 =?utf-8?B?QzlZaDdnRnBpMElITHNyRzdyT2R0TXdXN0J0TWxoYmpaY09hRjByVFVUMnd5?=
 =?utf-8?B?eGJGQzRjVnhVdFFGZStwcW1oTFR6SzJPVUlnWStORndnNENFeFB4VXhrdklE?=
 =?utf-8?B?cjFiWlZJQ3JrM2pnRVVkZ3B2RmYzVDBFVW4vV2grRkZVN01OWndzamtNRGM4?=
 =?utf-8?B?aGhVYXJ0Ylkrc2FlWDhqTEswRlV2c3ZSaEVieHR3QXlWMXB4aGs0TjJmVDQ1?=
 =?utf-8?B?dlRibUloZHE3L3FCREZuOTArSFo3YWVOWWNaSzVTUCt3Q2llYnA4N3h3dEt3?=
 =?utf-8?B?VUdlTmdVSG1FV0xBM29oRFJ5ZHZjb0JYRml3NFd0UXlrU213YjdTZFkyalV4?=
 =?utf-8?B?RGxzdmZjTHkyVzhZZXdxNlorR01sYnpzSWpZSDF3ZWF0aHdHMTNaMVB5Z3pv?=
 =?utf-8?Q?H46e0P/d8dp7suJWCN6CEkFO6x8pGYHUxAxhJhH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8d1ad1-481a-4dce-8bf3-08d9318ad0b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 12:24:12.5870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: raYooXZS3OGYmnYA+l94L5NXADiVF2o/aXZ0VAtMQXzMigXPHsaZZNYrSgn01cEaacIxW6JT/B6uvtIypbd3Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8837
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKaW5nIFhpYW5nZmVuZyA8amluZ3hpYW5nZmVuZ0BodWF3ZWkuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgSnVuZSAxNywgMjAyMSA4OjI2IFBNDQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJp
dmVycy9wZXJmOiBmaXggdGhlIG1pc3NlZCBpZGFfc2ltcGxlX3JlbW92ZSgpIGluDQo+IGRkcl9w
ZXJmX3Byb2JlKCkNCj4gDQoNCmRyaXZlcnMvcGVyZjogaW14OF9kZHI6IHh4eHgNCg0KT3RoZXJ3
aXNlOg0KDQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4N
Cg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+IGRkcl9wZXJmX3Byb2JlKCkgbWlzc2VzIHRvIGNhbGwg
aWRhX3NpbXBsZV9yZW1vdmUoKSBpbiBhbiBlcnJvciBwYXRoLg0KPiBKdW1wIHRvIGNwdWhwX3N0
YXRlX2VyciB0byBmaXggaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaW5nIFhpYW5nZmVuZyA8
amluZ3hpYW5nZmVuZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGVyZi9mc2xfaW14
OF9kZHJfcGVyZi5jIHwgNiArKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wZXJmL2ZzbF9p
bXg4X2Rkcl9wZXJmLmMgYi9kcml2ZXJzL3BlcmYvZnNsX2lteDhfZGRyX3BlcmYuYw0KPiBpbmRl
eCAyYmJiOTMxODgwNjQuLjdiODdhYWYyNjdkNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wZXJm
L2ZzbF9pbXg4X2Rkcl9wZXJmLmMNCj4gKysrIGIvZHJpdmVycy9wZXJmL2ZzbF9pbXg4X2Rkcl9w
ZXJmLmMNCj4gQEAgLTcwNSw4ICs3MDUsMTAgQEAgc3RhdGljIGludCBkZHJfcGVyZl9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiANCj4gIAluYW1lID0gZGV2bV9rYXNw
cmludGYoJnBkZXYtPmRldiwgR0ZQX0tFUk5FTCwNCj4gRERSX1BFUkZfREVWX05BTUUgIiVkIiwN
Cj4gIAkJCSAgICAgIG51bSk7DQo+IC0JaWYgKCFuYW1lKQ0KPiAtCQlyZXR1cm4gLUVOT01FTTsN
Cj4gKwlpZiAoIW5hbWUpIHsNCj4gKwkJcmV0ID0gLUVOT01FTTsNCj4gKwkJZ290byBjcHVocF9z
dGF0ZV9lcnI7DQo+ICsJfQ0KPiANCj4gIAlwbXUtPmRldnR5cGVfZGF0YSA9IG9mX2RldmljZV9n
ZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCj4gDQo+IC0tDQo+IDIuMjYuMC4xMDYuZzlmYWRl
ZGQNCg0K
