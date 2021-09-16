Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C7840D5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhIPJTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:19:05 -0400
Received: from mail-am6eur05on2059.outbound.protection.outlook.com ([40.107.22.59]:41665
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235339AbhIPJS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:18:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5ESnWCTFAMsJujqpI1fhk2Cy3RbzKo5cpBO1G3zmGCrl7SRR/X+Mp09b2YqDRDb09kQPgrWGpNrCJsyhLp0sH/M8E+larPCRDKtK6unUNSCzQ4v7JfhodOwL6u4pAdAP9gbHlmCmxhO/NAk+UG2mEUkWHRc5R6DcxpeRvuyyPWkCofQnqfNSBrz4Zsxq8GCPzy38dQgahUxt5JFX37NAIQHMvHnkk5pH1ecMMTvKd+DcN4WdYRF3dqdnicNIQPky8nycQ38CkejMGxxnq5ZjVwkb3qs6IffG7foCsWRsgjgvoAe+LDTQJaMk/899P8g/LrN932AHQVVYLtlBgrrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=llF4ceaT+HbvJi3uTGb32eJmGeDvH2oLRk/hfA1VePg=;
 b=ALmktV9Uup0AWF30G9TQAgXfvL4hZALfOXD81FS6MpQ6+ftPAo7YsbN6KXv8N4yaqmACcnBnMWE4u5yHfn81EH2dr4wLY9E5g0XspmjBR9mnFgrHuUmTbk9qKbavkFSEzyWbTWY2jyCZwTnOfT/h4n10/4t/ygC6iLAc+whiqWgooQQsM2s9RWnB1uN6nuct6MBGdgbpLM5WFoPb+kvTcVxNbLdrIn6dezPvCHGISx978L3qRYLRecN6CAEi0LB+Eo/DgWiCjUr8p7XS78DGO4lEpGd5hG0anOsopzdDVQYnkrNgLkGcv/2Ud/8/phQzSHMT+AjrZ9BdAIwBLLeZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llF4ceaT+HbvJi3uTGb32eJmGeDvH2oLRk/hfA1VePg=;
 b=ddSVvVT29oZM4Fx9FIdinQidvguSTRDxN8UByr6OHPhUvtqyg2yGBVvwj1Qah7msEfiEM1Lhyh+tHB+8EXUJNJzrqFHyOK6Np7VUItJFxw9ggSSpC9l66oXrRZb9hvX3tUOtlxRpjnADWhyI+9b9K+ue4kwFW5Peh5UMmjoAiAs=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4779.eurprd04.prod.outlook.com (2603:10a6:10:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Thu, 16 Sep
 2021 09:17:35 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 09:17:35 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 15/24] MAINTAINERS: update fsl,fec.yaml reference
Thread-Topic: [PATCH 15/24] MAINTAINERS: update fsl,fec.yaml reference
Thread-Index: AQHXqts+YYrh2BqySUKmPgxlfcKVhqumYSeg
Date:   Thu, 16 Sep 2021 09:17:34 +0000
Message-ID: <DB8PR04MB679544FC45BBA0EE1CE6DB09E6DC9@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
 <d6a6a7e5a12478dff3c3176565de3a4a41ac4446.1631783482.git.mchehab+huawei@kernel.org>
In-Reply-To: <d6a6a7e5a12478dff3c3176565de3a4a41ac4446.1631783482.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ee15427-bb6a-48c2-784d-08d978f2d20a
x-ms-traffictypediagnostic: DB7PR04MB4779:
x-microsoft-antispam-prvs: <DB7PR04MB4779100073E076EBA4E9D4BCE6DC9@DB7PR04MB4779.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FHJ5gj0J6Ah4mkmof5q3y5CkwdFXy9j+5XxXx3X8yaEZUmuxwGgGFm7r5qLL995JBTDXg0wja1JeCXa3tgq8JbPHiF0qp2nG/Be6ID/9r+CnRW0vVGe0p5XWOounfQajyeju2KKM9D40xbp3gbTNMD9gaUTSArS/m4gthuICxytSAxo4yp/KbO8octWAjjjJVCGTlfyrRbCWTzlaZf7OxW4BiLCrFEIMkUUP51kbWfGvNq65kaZnRPynDwIEP8g2UoLIzfmtD+3c7in/TVU6a6Xvup8jA6SKpC09KaIxft9U+GWiYGlp1mZHS1VpCaILlBpEUpBLJZURMsSt0sZhgZAInmPIDktwOQJf+ZvxZITK5zaUhwGHl8UPkqmWSHLvIMMPZGt5dlvuyWbEsSJNNjMbXkXfXk3zWJ017voGjn26a0UHKmfk+nc2b5Xb1kekqabh/fkcj/41WtZmPn362fusDKd6U84D4YXiybHKXX1dP/4hYWqQM4ud8KHIm53DxB8hwWHhAE6CBNfsrvbFVF6oePuL2ZrP47f/XwJywhW6JvRiVCrVhPOuSP3tFLWskvs0fIe37VdTdwAE80co9miZXhuMWhRsGucypAzL56rsvjWdldvT37WB+GYA1Z5xq8CIXKFwY2sy2HX7QGlJMbYKj7LIMWSAYrMgYWMnropE/31DrGrw4sLzgGgg62I2IiwHaexI0bH/1hKNKZ4QCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(508600001)(64756008)(55016002)(83380400001)(15650500001)(76116006)(66446008)(7696005)(66476007)(52536014)(66556008)(122000001)(38100700002)(6506007)(53546011)(9686003)(86362001)(66946007)(8936002)(54906003)(38070700005)(26005)(110136005)(316002)(2906002)(4326008)(5660300002)(71200400001)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?emlSSUd2RHVFTmV3WmU5VmY0MTlmWkJ2dk4xbUYxNGdZTEdWZ2tmZkNDM3gv?=
 =?gb2312?B?TlNIUUgvZUVIR2RORFpUeHlEK0hsRTI1aDhreUxPTHFxQ0Z5NHprU0dmYjdF?=
 =?gb2312?B?RytHMW10NGFBQXRIaVJsczE0WE1kcWYvUU56VGVGY1RLb2hWQ2M4Q0h5a2pQ?=
 =?gb2312?B?NTVuQUMvMVU0aHRhOVdiSUhBaTVjT3ExTmVSYk1sR25WR2dQWFZ6cmMwU0N6?=
 =?gb2312?B?WDk1Z1UrUHdrZjJPSWpqaDg4c09IaWZ6UHpIM21pdVJuWDQxc3NYNENnZ3Bp?=
 =?gb2312?B?SkxlMDR5WFFyQVk5dW5wenYyY0NRUnhjM01YSDdFSVAxekJPUmZBWFNEV1FH?=
 =?gb2312?B?U0dxenVSbGdhcEh5SzlDWS9HK25qaFRZczVMN09BZHEwZ0ZHS1hGdUNrVi96?=
 =?gb2312?B?YUdPVFhLQ04vT3pRTTlaZTZPOWh4djd0SnFnZ25XYTFIaUZHZTV4aU1pdFJ5?=
 =?gb2312?B?eklQUm9jUUk0VXZleFdLQ3BjZms5RTB3V20zOU9PbitMNGtRRTV6RmJma1lP?=
 =?gb2312?B?K3ZOclpvSC93RnlPc3FoNnlRTlMvaDNBT1VYT2dtYWZhY1BsWE1aLzJPRzBW?=
 =?gb2312?B?U2RtcjRGeG5HTEtNTzI2cXZ0VldNRlZFcjVudW1MaXI3cC93Q2dzMTMzaC9D?=
 =?gb2312?B?OGJGTk1hMjFIS1RKanAreEd5dmNpZnRYNXBseXRncTFnR29Jd2dyZ09VazJR?=
 =?gb2312?B?NTd2YTFRckU2YU96Nm5wVGFodW1lbGpvNmNBVVBEQlFzcmNLYm5CcUFDV0RF?=
 =?gb2312?B?Q2xWSFdzSlRyclhZWExJTUUydmhWMnhKY0E5RUxGRlBsRmlqQUVoMDFzYlla?=
 =?gb2312?B?blpxNW1hOFptSjcrakU2Z05QNW1ELzZCSlRrUjY2N0l2NElMME56YXNocnZY?=
 =?gb2312?B?ZHZLemp2YTVkMHdJTGZMUzRkYXNJR0lZdFVrWTd0dUFPSGNSUnA4cUFHMHNM?=
 =?gb2312?B?Y0NZTE02czVmck1GSlZvbVJrbVZSb2h2cWwyeUxSMU9iYXFLYWk4Ly8yU3Qz?=
 =?gb2312?B?UXBwckxMelZxMDZOeVlWekpyTGliV1M2OGdka0dGMXJwVE90bEpkbE1QS2Rz?=
 =?gb2312?B?NWN6Y1ZCUHFabjB0WkFQNVc5emlPSXpFL1BmeXJMVXlyOW50ZE05dFIrTHRZ?=
 =?gb2312?B?dHA2MWE2dUE5VWN0ZzJnVUNLdVl1WFRZV1FOY29ZbklyR3ZhRXBFWDZ4T2dS?=
 =?gb2312?B?NlVKd1FER1h3RWY3V05RRDJkdGg3ZW5yTFpldk5Camh6REl4Q1pyWmpaNitw?=
 =?gb2312?B?UDRLeHZTV3cvU1lsN3lKQTlzQSs4ak1zaDRkS1ZCV0lzNEU5MzdDVnhSZXJV?=
 =?gb2312?B?SmVMdndyMTc4L29zNkUreURRUkZ0K1M4U0huc3RqWWUxY0pma1cwaUJvUE1o?=
 =?gb2312?B?OXdGblIveERjUDNSVW5qNTgrR3pDUGk4ZnRRNWJMbzFyUzVrQnh2akJlRDJN?=
 =?gb2312?B?QjhpTnlPN1hWNElqUDVJencxZkJ0N24rUk9FVVVHc2RuVkxoaDFpOXJzOEQx?=
 =?gb2312?B?MExkWFNiMHVHbDFpMWxVWndZU3Q5eTVTVm9jUnZkSE51RytocER0N25xVU4v?=
 =?gb2312?B?ajFZT3NIN0pucXAzbGwvSTdIenlpR082REhHYXhhWjRpaEdXMzBBbGtpa2JE?=
 =?gb2312?B?bU45SWwwNDQ3TjlYV29taEhpVmp5aFM4ajFkWUFPRGtkbTZCT1Y4RGd3Y05w?=
 =?gb2312?B?dE1DelZnTTFFVE1zTDhjRDBDT0NVcjJDcHBmMUdjcEMxaW9ZYnFMYU5VRGxD?=
 =?gb2312?Q?oYaJG8pP4jOKbyZUQw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee15427-bb6a-48c2-784d-08d978f2d20a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 09:17:35.0199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LN8c2245Qygl0IaaEd6zWHwI5ExEMBtk41zsu1sozKsScqsQiJRTkjLFXrjYGZg+6KIi1f4mnqDKTQUpucf4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4779
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hdXJvIENhcnZhbGhvIENo
ZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgTWF1cm8NCj4gQ2FydmFsaG8g
Q2hlaGFiDQo+IFNlbnQ6IDIwMjHE6jnUwjE2yNUgMTc6MTQNCj4gVG86IExpbnV4IERvYyBNYWls
aW5nIExpc3QgPGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDb3JiZXQNCj4g
PGNvcmJldEBsd24ubmV0Pg0KPiBDYzogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiK2h1
YXdlaUBrZXJuZWwub3JnPjsgRGF2aWQgUy4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0
PjsgSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDE1LzI0XSBNQUlOVEFJTkVSUzog
dXBkYXRlIGZzbCxmZWMueWFtbCByZWZlcmVuY2UNCj4gDQo+IENoYW5nZXNldCA5NmU0NzgxYjNk
OTMgKCJkdC1iaW5kaW5nczogbmV0OiBmZWM6IGNvbnZlcnQgZnNsLCpmZWMgYmluZGluZ3MgdG8N
Cj4geWFtbCIpDQo+IHJlbmFtZWQ6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
ZXQvZnNsLWZlYy50eHQNCj4gdG86IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
ZXQvZnNsLGZlYy55YW1sLg0KPiANCj4gVXBkYXRlIGl0cyBjcm9zcy1yZWZlcmVuY2UgYWNjb3Jk
aW5nbHkuDQo+IA0KPiBGaXhlczogOTZlNDc4MWIzZDkzICgiZHQtYmluZGluZ3M6IG5ldDogZmVj
OiBjb252ZXJ0IGZzbCwqZmVjIGJpbmRpbmdzIHRvIHlhbWwiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBN
YXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+DQo+IC0tLQ0K
DQpUaGFua3MgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiLA0KDQpSZXZpZXdlZC1ieTogSm9ha2ltIFpo
YW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpo
YW5nDQoNCj4gIE1BSU5UQUlORVJTIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9N
QUlOVEFJTkVSUw0KPiBpbmRleCBkY2U2Y2FmZWVkYWIuLjBiYTg4NzQzYWY5MiAxMDA2NDQNCj4g
LS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTc0NTEsNyArNzQ1
MSw3IEBAIEZSRUVTQ0FMRSBJTVggLyBNWEMgRkVDIERSSVZFUg0KPiAgTToJSm9ha2ltIFpoYW5n
IDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gIEw6CW5ldGRldkB2Z2VyLmtlcm5lbC5vcmcN
Cj4gIFM6CU1haW50YWluZWQNCj4gLUY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvZnNsLWZlYy50eHQNCj4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvZnNsLGZlYy55YW1sDQo+ICBGOglkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZmVjLmgNCj4gIEY6CWRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+
ICBGOglkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+IC0tDQo+IDIu
MzEuMQ0KDQo=
