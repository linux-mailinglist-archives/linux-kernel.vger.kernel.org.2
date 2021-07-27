Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028B53D6B85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 03:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhG0AqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 20:46:12 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:42909
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229575AbhG0AqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 20:46:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQn8HzM1YfXmE5fz3fJC3M3e8D07d9C/HPMv150pdAqyGfbQe3b9xjkdBTSOgKR6jXu9L+rDPnL5VnfHVSgvOGWJeKqFwa2uAdndm5+DVPJipV69BVkOY8ZXvhHLMeuWy33/uPRh9YSObbGUeoYIx1urLHqXxwGck4kMrX2L5VfaDV4dMmzTLQsPc+ayOTXFx+V3dbD+61hw90Bur6HZLaa5Rg0gCfrgyYPH4KcJ0uTfOHd/qh9e1dtJt1Y8F0K09sobBt2gof4XfSfviWGySKY3TmHe2BcqAOkpTrIh5J5oZSJ1JtUIRbkEuC2q2gnMCPIW4HeF9ZSPGyLDkWM7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37RNn1yzzwfl0fODDfC4j5d9Upgl8txImqofKTeeQCw=;
 b=KG/A6XSaYgQcVJn9eZ2fUB9zyDNP3yoyvgd7feohjaDW7/7Ux+4ym5EEenshH3joRG5i+5UU9yaM0aCyvrA32w7TnjyCfDHmAV9v7mC8Jap/SotqJyfSxKVqJhTzG7kKdS4R1tRLLVLitwlkj8AQ8R59eA7rqwL/0qCyZezp54hMOV69Pj2QF0wG59U0y05npP2hGoaHX+HtJUWfL/0F9db8E7DhligKT7TEOWfih/jQvHauhmyqtEugAVtdY80bD2wjwe1xbgrmVkxJwueKTX8GDlPM+0UGe6v10VOvDHYNjGY86uqvV9Dt1D5JJ9YO8I+53F6VAOrmUsqBteL85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37RNn1yzzwfl0fODDfC4j5d9Upgl8txImqofKTeeQCw=;
 b=h0ctrYYBKPYmiAiTHFNOM/z+XmW8KYqM/hsH5A44O0Iwbg26nYES+I8M74Z0ZVUIqO6ex+4sUFQ8t9Tu8dChyzYQTpV2LXENQD978AV7gk03o+OMJmKoIEo7df45MJWtAcwTS4ego6LVzkrL79VgbASTV5JFeTL5FMsjOfkWiMg=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBAPR04MB7333.eurprd04.prod.outlook.com (2603:10a6:10:1b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 01:26:37 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9c70:fd2f:f676:4802]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9c70:fd2f:f676:4802%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 01:26:36 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 8/8] MAINTAINERS: rectify entry for FREESCALE IMX / MXC
 FEC DRIVER
Thread-Topic: [PATCH v3 8/8] MAINTAINERS: rectify entry for FREESCALE IMX /
 MXC FEC DRIVER
Thread-Index: AQHXgirGasQ5RuXvV0SkQzLtMUZpn6tWB/LQ
Date:   Tue, 27 Jul 2021 01:26:36 +0000
Message-ID: <DB8PR04MB679585B2A7F359F415591356E6E99@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
 <20210726142943.27008-9-lukas.bulwahn@gmail.com>
In-Reply-To: <20210726142943.27008-9-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7817574e-877a-4f93-a694-08d9509d93ce
x-ms-traffictypediagnostic: DBAPR04MB7333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR04MB733348C55593A4ACCF40CB91E6E99@DBAPR04MB7333.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfQk12709m/GGoxXxh1SYA0hr1D60vXjtCoknx+YtO74vep/1H2RPQ0PaCT5tUDfcJu942yPq3HrfHcRsGiAAnh692w2VjwDuzpe9SvtOs1OrN/Zq2zgOuAkIS4uE0i+idb8a+G7WTN9oLImzezRCfRmHPfYLLSTjuTK8+j0ML0+aP8iXd+aThKuh026QB/QfAq/dWb6jRZQSbuSr8JsMv8Ot5ruzIUMhYtUM5EWme7ia8cnBeiIvpr+qku08tkEQ/FxS8oh1bbn54Y3bvvB1cedPQjsSfVf9U/nw3BsRmFVi0SBCyaVny6mUFpHEDCTLyqG+QRZU4nFdPSmbY2DVIKVCuAF3UtBKGbw9hjAZ+8lIFfmHspjTW4jG5CMDEjk5wR5J0jDFWRYYETzAXsF/MHJ7h2kYEyW0SPzIF4TqaH3l9vt/YN2hi32v2HKWp2T7H8ej0eKwacWnIRuCdN4ZC+VHCcR065CvTp/+xoX6/Tx3uUIrRcx2NfApCgDUh2FncUF5xwWOXkyhCBU7fFKozzuuyD6kIA8zCez3lwkLMBcXVxk6n+be6r0PZCPKgl0qCSfoZ8po5ROVAS4gY8i18VlsowlqFQVQJ4JEkf8xzTW9lBs+nqYhklC6OrHWHecgN+6TB1zEFmh4S5VlXXTi6LEkYgsS8F1tXIdh/qr9qGBrMXlzZ9IaD2u7mRUw1SAoOhKJki+GFAtOA81cwZcIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(110136005)(76116006)(316002)(83380400001)(478600001)(5660300002)(122000001)(55016002)(86362001)(33656002)(54906003)(66446008)(26005)(8676002)(66556008)(66476007)(66946007)(7416002)(4326008)(71200400001)(38100700002)(53546011)(2906002)(9686003)(52536014)(6506007)(8936002)(64756008)(186003)(7696005)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MXZFV1R4a0pXOVNyZFZHUk1TV01RS3NnQ3BnSmNRc0k4SEZNcGdGK3Q5QjY0?=
 =?gb2312?B?YkFqNTZwWlRmaEdHWDBDSWkxbDZxQzRhdGdtK1k4ZUxqU1dsVW03OU1rSG43?=
 =?gb2312?B?K0RjR0dPWVFnNFhIbzhqdHljQVAvMzU1UGNSV0lpeWorWGFxL3NoRzVPNDJC?=
 =?gb2312?B?dTVjcmRVQlZNSzFBbUU1SkxqZUYvOXhiVFM4L0VRd0xLMnRoc1J2Ky8yeVpm?=
 =?gb2312?B?OVBpZElyVVE2OGVkYUJoSVlvaFFlUFE2azdZSEh6NlloOFVtK1hWNzFORG5j?=
 =?gb2312?B?ZnZKUURJVE9zc1luSE9oNjhGK2ozWFdzSEFpdmQ3QzhXcDM0TWtHMnlZc1lC?=
 =?gb2312?B?eXJOTEpNamNOTFpkWHBhdnYzeERpNGVDZjFsRjJBSGM1UG5uakw0RjRkb0c0?=
 =?gb2312?B?Nk5lSlkrTExKRlVJaG1Qd0Z5eHZnYjA3blVFMTRSREtzK1NHYkdxRDBPUVVt?=
 =?gb2312?B?NFRYVnNNTmhBUVZSL1JOMkpOQnlZOFFKa25hbVVlaDRxcWF5OXJQSHZZb05o?=
 =?gb2312?B?Wk4vdk0wQmFsMUsrcVB2UXRlQUtIM2lmS1NVODhZaDRlbTlQVW1nSHZUdkZl?=
 =?gb2312?B?VXZZc3lhTHVadFJBOUhzRFFFMEZOdmZmZnIwUCtFL1Q5Y3pGT3FsRi84NTUr?=
 =?gb2312?B?OTZMMUJ5dDNMWVlTTHlqYmFWV3BwNGg4bzdOT1l0RThHTWNzQk02R2svOU5x?=
 =?gb2312?B?L3Bib3c4aGdpcys0R2Z2TUtKQzRCbHYrdld0aWVmcDRBaksxN3d5eDJoclBl?=
 =?gb2312?B?TXRSTUtaNStINnRFbXoyRkRiZWlneWNaWTZMbEFaT2s5RnJ1bk9VblhYcC9O?=
 =?gb2312?B?YVhOd0dLakpDN3YwSkswcG9tY1pFQjdYRWtJdWd6WTQ5Y3lrR1FXNytIZDNO?=
 =?gb2312?B?a0p2VCtzY2pwLzI4SkpIS1FUOTY2ZDNVOUZ5dzMwd1lDRE00a2xWUFNxMXdv?=
 =?gb2312?B?STBmRndtTjdCeEpwYzlWcU1GcmUvcjM4WmozMXMzV2ZsNWsyb1V6VDc4U29j?=
 =?gb2312?B?VTZOc0lYR09TR01qUWxjQ1ZwMXZMSTNyaUZVSWhodWlEcUljc2o1OVJXTEVm?=
 =?gb2312?B?dC9aWitoellwSmh4Q2hvNkdTdnBMQi9vTU9jako5dlNvQzhOMU5MYSsrZmt2?=
 =?gb2312?B?N2pldEpBUzY0RGFVaHR2QTI1ZnQ5YnhlSXB6eFJzN21DN2VFMmpHd0FRQUFZ?=
 =?gb2312?B?dE42clhhWWs1cUIrdVRsQUdHRmJHQWorcFZsVExvQnVRVU1sbWNIT1NtSnIy?=
 =?gb2312?B?WU9JRlVYRXQ3ajE5MG5vN3d0WjlhOExxU2orUko5WGlRSThxUkw1cVMrcnpq?=
 =?gb2312?B?clBZSlBlOHpFcVJTSHJzbmxxU3hYSjV1RG5RMFg2WUZFT0RNV3l1WHhETTlL?=
 =?gb2312?B?K28yS1BlZlQzUTZSODRMODRGRytLUzIzK2VNb3FobER3bUNhYlFIUVc1V1pm?=
 =?gb2312?B?ZTNOYmtLOHJHRjZoTE52aWRxZTFXcUtrZEhibXloekhRVzJXb3R4dlE2QkYy?=
 =?gb2312?B?cDNKcUhpZzN2bXZlTnE2SEtBbFdlUUhBMENLQkVoc283czdQY2ZueU9icm5L?=
 =?gb2312?B?aThmRGhnaEs5Tm12WGY2NnpGS2F1ZG5CR2VyTW9saTF0NUs0N3JMYlZSeTFP?=
 =?gb2312?B?VEY1cU4yb3FhRktPSEJKTWxtSTMzcjBBcGlKUmcrWjJ3cTFVRmNaOU1zUVgw?=
 =?gb2312?B?ejI5TVNLbEU4QUxLRGhheVN1QlZmTmpGKzZZcnFxZ3k4UU93SmpQVjFVRmVP?=
 =?gb2312?Q?DNkF4kJ1B4rY5fCs07MrZ9oTWBP8Xoz3q5R19E2?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7817574e-877a-4f93-a694-08d9509d93ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 01:26:36.8023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4BnN4Z4+AuC/YieAd4GLYq2rxmFioINmTNuSk11Q3hUXSUfr+ABd+CySkqfe/n22UraDtt6UTy1IzllNEZojQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7333
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBMdWthcywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWth
cyBCdWx3YWhuIDxsdWthcy5idWx3YWhuQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyMcTqN9TCMjbI
1SAyMjozMA0KPiBUbzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8xLml3
YW1hdHN1QHRvc2hpYmEuY28uanA+OyBZdSBDaGVuDQo+IDxjaGVueXU1NkBodWF3ZWkuY29tPjsg
QW5pdGhhIENocmlzYW50aHVzDQo+IDxhbml0aGEuY2hyaXNhbnRodXNAaW50ZWwuY29tPjsgSm9u
YXRoYW4gQ2FtZXJvbg0KPiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPjsgTWlxdWVsIFJh
eW5hbA0KPiA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT47IE5hZ2EgU3VyZXNoa3VtYXIgUmVs
bGkNCj4gPG5hZ2FzdXJlQHhpbGlueC5jb20+OyBIYW5zIFVsbGkgS3JvbGwgPHVsbGkua3JvbGxA
Z29vZ2xlbWFpbC5jb20+OyBEZWVwYWsNCj4gU2F4ZW5hIDxkc2F4ZW5hQHBsZXhpdHkubmV0Pjsg
TWlyZWxhIFJhYnVsZWEgPG1pcmVsYS5yYWJ1bGVhQG54cC5jb20+Ow0KPiBOaXNoYW50aCBNZW5v
biA8bm1AdGkuY29tPjsgVGVybyBLcmlzdG8gPGtyaXN0b0BrZXJuZWwub3JnPjsgU2FudG9zaA0K
PiBTaGlsaW1rYXIgPHNzYW50b3NoQGtlcm5lbC5vcmc+OyBTaHViaHJhanlvdGkgRGF0dGENCj4g
PHNodWJocmFqeW90aS5kYXR0YUB4aWxpbnguY29tPjsgV2lsa2VuIEdvdHR3YWx0DQo+IDx3aWxr
ZW4uZ290dHdhbHRAcG9zdGVvLm5ldD47IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRp
LmNvbT47DQo+IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz47IEJyZW5k
YW4gSGlnZ2lucw0KPiA8YnJlbmRhbmhpZ2dpbnNAZ29vZ2xlLmNvbT47IEpvYWtpbSBaaGFuZyA8
cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+Ow0KPiBKb2UgUGVyY2hlcyA8am9lQHBlcmNoZXMuY29t
PjsgUmFsZiBSYW1zYXVlcg0KPiA8cmFsZi5yYW1zYXVlckBvdGgtcmVnZW5zYnVyZy5kZT47IGtl
cm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IEx1a2FzIEJ1bHdhaG4gPGx1a2FzLmJ1bHdhaG5AZ21haWwuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0ggdjMgOC84XSBNQUlOVEFJTkVSUzogcmVjdGlmeSBlbnRyeSBmb3IgRlJFRVNDQUxF
IElNWCAvIE1YQw0KPiBGRUMgRFJJVkVSDQo+IA0KPiBDb21taXQgOTZlNDc4MWIzZDkzICgiZHQt
YmluZGluZ3M6IG5ldDogZmVjOiBjb252ZXJ0IGZzbCwqZmVjIGJpbmRpbmdzIHRvDQo+IHlhbWwi
KSBjb252ZXJ0cyBmc2wtZmVjLnR4dCB0byBmc2wsZmVjLnlhbWwsICBidXQgbWlzc2VkIHRvIGFk
anVzdCBpdHMgcmVmZXJlbmNlDQo+IGluIE1BSU5UQUlORVJTLg0KPiANCj4gSGVuY2UsIC4vc2Ny
aXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtLXNlbGYtdGVzdD1wYXR0ZXJucyBjb21wbGFpbnMgYWJv
dXQgYQ0KPiBicm9rZW4gcmVmZXJlbmNlLg0KPiANCj4gUmVwYWlyIHRoaXMgZmlsZSByZWZlcmVu
Y2UgaW4gRlJFRVNDQUxFIElNWCAvIE1YQyBGRUMgRFJJVkVSLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTHVrYXMgQnVsd2FobiA8bHVrYXMuYnVsd2FobkBnbWFpbC5jb20+DQoNClRoYW5rcy4NCg0K
UmV2aWV3ZWQtYnk6IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQoNCkJl
c3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0K
