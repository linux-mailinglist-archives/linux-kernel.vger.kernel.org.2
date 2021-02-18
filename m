Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2488A31E93B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhBRLpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:45:34 -0500
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:34116
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231345AbhBRKPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:15:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME/VBP5gCWpv0ql9yZz137qaYGjLUm5KfzJyqGnr52FM4DkYLZFj+LV/+rcSUlrU6ZP8kIG/TfK1awW0KYSuRtuTn+al2mZe+XeJFZZQtAGSMxKPyaVaS3W22lQLUTcsPGoN0h6yARPN5HVQza/ijq+7m5oIvlDlpKm+URSRCia3zTulgsVgmmy3yuyuxyKlWUjucwvnC0F/AW/CR0uCPk4oNfd1to4AoE83xq9kNqd6KVKqZeYgukB1Q/lafwcE16l+rrEdaKLHSAgUGyBDXcpgD42lxMJmRUrZ9WIlZvHzvivRp/hXbnY1iMpFbiO9GFY4hF4i3d2OJ35V0iS44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5QkUuSSlatZFGIWLt/ENGGdCYIPPluHNx4VTyh+0PE=;
 b=CfRMxrJQWjZkYsnDsY0jpAHh4X+p+O+xlRDxJ2cBLO3TX6VE7jSatZWdXJMMhgpsJOeu1+ukDbE2mCf72Jbjd0ShDmBJxa7cAknqh22z88HvXq2G3vf3NjA6IiSb1CLjywwKDlNqtoZldbDvTVNo01GsBF1m+yf9vh9KYO6zgQAPKzDbqe3CKAfoHKKssA4Mcmc03mW1/VaTXJWMBIQXUf5Ob+4G9YoOfRzsd+amWPPFF2hNSW7eEITx92UX+mIDpXetodLFx6+Bf4VFi/K7WmAH5xnO3be3TT/E8zHmionbtMkmEt0mfx36IziBf82Y6OjngehfH+L3bMhaS9Y03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5QkUuSSlatZFGIWLt/ENGGdCYIPPluHNx4VTyh+0PE=;
 b=Kz1K1RZTImj0ePken1PGuPc6tD/o58fb44pkMzoy/g+Fvp3MgtkUtTy8CFTCmvLuSo9bKcBP3flbSuW+3qDki9feUwD4Pt1zO5HRR9ckiVmJWfAxdaVZh+u+iCmS6N1LJIR+m33A0Im8WtbXqfBZQ82XYfk12U7wQ7FeSfMPmlA=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7833.eurprd04.prod.outlook.com (2603:10a6:10:1ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Thu, 18 Feb
 2021 10:14:30 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978%4]) with mapi id 15.20.3846.042; Thu, 18 Feb 2021
 10:14:30 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 0/4] tools: perf: Add JSON metrics for i.MX8M platforms
Thread-Topic: [PATCH V3 0/4] tools: perf: Add JSON metrics for i.MX8M
 platforms
Thread-Index: AQHW9JtY/Flb1M5HB066RDaFAFubB6o7hB2AgCJQQRA=
Date:   Thu, 18 Feb 2021 10:14:29 +0000
Message-ID: <DB8PR04MB67955CC8940C664F4F609690E6859@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
 <83775741-8b38-0182-38af-71c60cee1292@huawei.com>
In-Reply-To: <83775741-8b38-0182-38af-71c60cee1292@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ed2bdec-d5b2-458e-12a4-08d8d3f5fabe
x-ms-traffictypediagnostic: DBBPR04MB7833:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB7833D4F0DEA0F8A0A8211B4DE6859@DBBPR04MB7833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76yK8fRiFZJy7Em9MriV05keKjaXUnTYI2b5eiMNQN0G+HTZ18ur5wVchA5GjFwVVRdlLy6/SPYTTIFnH+GUtM/3s0LsR5jhpD96X+xvd3VFMdKb8dC6NYr52rGvuVdYXKwiKbSyku+UKCnZcZ3CdoKnZJVDa49yaOMy+Ah+UMWq00s8got/oZFAdKH3fh1g9UMzG+yu0y5/x4cMaI5tLi0QKy/FF1GxU8FHwK4ujz34X8Sh6mEoy+Qx4RcXlwmyuYDqUHliFJtaY7PtW2g0WKXevM6f14ehIPfFDGOAnlaDdG1K5Swd5mbHfy+WfF6vyaMiuZ8yGL9PjWoyk2vyLPBBgOolK49Hz94fPk6lij4LyIASnteULTUHwAoaryS60Iqyg55vBTPcd8UqNdI0RuZYbzbRke/DobodY453EmauToKzooQJ1qMqR2Pd+VTJ89XJYB83/gH+yh0kD9/4rDZKCNj6WF7ymI9quZT8FiLnukEAoFz7iD1P3TZM80xxT4n8Xb0eyTwviQc81VXYUaWuKdFrN3L+FoZ2XE+0Tlfw0npUvCXSdrrgnwaBmNy2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(66446008)(64756008)(53546011)(6506007)(7416002)(66476007)(66556008)(76116006)(26005)(52536014)(66946007)(8936002)(921005)(83380400001)(33656002)(71200400001)(8676002)(186003)(478600001)(54906003)(7696005)(110136005)(4326008)(316002)(9686003)(55016002)(5660300002)(86362001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R241OHdEV0IrajdYdmFxOWNHOGZmVCs3aEJybGdZTVdFMkQ2ZDFOR2VCQ1BE?=
 =?utf-8?B?K0hMaXpZalVaQzVIK1ZRT2FXT0VIeEpBcThoUGhvUGRWNUZzTUhmU3UxK1J3?=
 =?utf-8?B?L2k3Y0lHWUx0Q2oxaHgwWTVGMjFNaVA3ai9ZeGZBalU5L3NXcnZMOWU0VVV5?=
 =?utf-8?B?K2ZqTjR4cnBCVVFTbkNCcmwwS0hrMFRqWXZSUXcvaythcnVKQ3g2UlExbjYw?=
 =?utf-8?B?OUlJTk42ZUZJQTZHQzdEb25DZE4vVkVCOWoybk5sWlAxRmx2dXVSQ2x2UlFZ?=
 =?utf-8?B?Q0hMc09JTjk1NFAzK21NRy9oVVdXWXh0UlJJNGkwVFI0TjZnZndTR1V4UXpQ?=
 =?utf-8?B?a01zeWFjYlBMUktFQ1h1MGNoREZLZXVUempvOGVUUkVWbWVDbkgwZEFrTXZL?=
 =?utf-8?B?b2dxQnNwMlBMS3JxQm50WVkyNVEzWWMzVzJIMkhZN0dBdEdGZmEvMS9wTEJR?=
 =?utf-8?B?ejBlU2h1VTdsWGhmbnIwY2wySnlVQW5QWTVCUnFuVlpBSHkzV1VoNUJLWDZW?=
 =?utf-8?B?OTFDQjBtZnpUOS82TUFEdUwzQzl2ZW9RYTNWbG1CR1FYUG93WmVkVU0xTjBY?=
 =?utf-8?B?aDN5SWU0YUdDaHQ2V01Sd25PczBrckZxSThiVmVsU3ZHN0NPK2ZzY2QxTElN?=
 =?utf-8?B?dXNFb01SVURSakxZMTU1dGQ3ZkNoYWRralRuUEdxWTIrU2o1OTZ3Qlp2ZHJM?=
 =?utf-8?B?SHkrNi82SW1uNHhvSjJ0ZENscmJjSU1vUWVXTlhwY2tBTE9sMlI2bzg1ZG9D?=
 =?utf-8?B?dThWK0xRZmJmY0RpQjBWeno0Q25obHI2eHRiV2ozQWpseU9URmxvcjluQmxq?=
 =?utf-8?B?RmJPSGtkSHg1OW1WL0MvTUhSSkF3eFJZNXE3M2dzT21LaHlXQnJiMUpHQjhJ?=
 =?utf-8?B?ZXpTOWhVN3FKVWxza05tZ0hJeXI3VVp5clpBdXJESGdYak5ROFY3am1Ud1hV?=
 =?utf-8?B?T0xoQmh3YjZHejVEZVNJL0I3RFBjbVJYdGtVb2hVUE1PS0FBdFcvSFV1dWtM?=
 =?utf-8?B?S1RycnVjV0RsVXFyNzcwbE13ME5hZjFDdFZ4eU90QlZ2a254djRNSEZaWHJ4?=
 =?utf-8?B?QWVmRmJwOWVmcEk0VnZOemVRSHMrK1Nkci9uODlUNmNQaDdIVVBGQlRtVVAv?=
 =?utf-8?B?NldHcXU4NHZHZWVyei9xbTZONG15d0pHckNMOVczUHV0QmxxQ3MrS3BoYU1E?=
 =?utf-8?B?OHErTG14Qll0SjM1YjcxRHBrV2xhQmJGVHhHYTVFVnlKWlZ4OUVYczAxNjIx?=
 =?utf-8?B?QkY3dTlZbVMwQm5zeWk2MnJUNC9zK1FwMGVZV1lzV25NeUhCUVlJc2VEUVV5?=
 =?utf-8?B?anlrSm5xRU1lb2xhWkw1dEJSTGtrcmJpRXM4eHNtbm9VcGNZSHY2QzhQSUZu?=
 =?utf-8?B?Z3A1dWR6VS91Q1ppeEFrekFweEpSaXBiWXZsL1dreS9BemNZNXhFRXB2MDd1?=
 =?utf-8?B?QWZjOC91bGlaMU5oSE1xYjU5NTVTbDBiVDlrOW12OUxDNS81SGZ6anVYNzdl?=
 =?utf-8?B?TWFlcUxhRnRkbmZxdSs1N3V1WjRjU0trUmo5MTI1czhMOEY4T1hldENUQVA5?=
 =?utf-8?B?VkJNNlhZWlgvTmlzcDJHZE5YYlptVnBPbGZsRmNycGpBUG9pZzRYK0oxSUR5?=
 =?utf-8?B?YXh5OTBTcjUvb2MzUnNRdUZ5c2lIWUZ0TDNtL29YdzJTNGR5cFBJNGJtaG5F?=
 =?utf-8?B?V3lHTnlrOTV6anVzRW5mbm8ycUQ5bklLeENhN1NDM3RpQTRFRVVIMjBTZXh3?=
 =?utf-8?Q?ueZOUYADqHkbI2AP3lt/1NeL/SFtWK/heazCCx5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed2bdec-d5b2-458e-12a4-08d8d3f5fabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 10:14:29.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6O0PhKoWjd8kontElk03slp2lApZHd4EnT/hvypAznnNdmX9y9+sAqhcFHIkSmUtkKk4pgQqUFC6sN84C79mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7833
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpHZW50bGUgcGluZ2luZy4uLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5
QGh1YXdlaS5jb20+DQo+IFNlbnQ6IDIwMjHlubQx5pyIMjfml6UgMjI6MTQNCj4gVG86IEpvYWtp
bSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyB3aWxsQGtlcm5lbC5vcmc7DQo+IG1h
dGhpZXUucG9pcmllckBsaW5hcm8ub3JnOyBsZW8ueWFuQGxpbmFyby5vcmc7IHBldGVyekBpbmZy
YWRlYWQub3JnOw0KPiBtaW5nb0ByZWRoYXQuY29tOyBhY21lQGtlcm5lbC5vcmc7IG1hcmsucnV0
bGFuZEBhcm0uY29tOw0KPiBhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tOyBqb2xz
YUByZWRoYXQuY29tOw0KPiBuYW1oeXVuZ0BrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3Jn
OyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlDQo+IENjOiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47IGtq
YWluQGxpbnV4LmlibS5jb207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYz
IDAvNF0gdG9vbHM6IHBlcmY6IEFkZCBKU09OIG1ldHJpY3MgZm9yIGkuTVg4TQ0KPiBwbGF0Zm9y
bXMNCj4gDQo+IE9uIDI3LzAxLzIwMjEgMTA6NTcsIEpvYWtpbSBaaGFuZyB3cm90ZToNCj4gPiBB
ZGQgSlNPTiBtZXRyaWNzIGZvciBpLk1YOE0gcGxhdGZvcm1zLg0KPiA+DQo+ID4gQ2hhbmdlTG9n
czoNCj4gPiBWMS0+VjI6DQo+ID4gCSogcmVtb3ZlIGJvYXJkIGxldmVsIG1ldHJpY3MgKGJhbmR3
aWR0aCBtZXRyaWNzKS4NCj4gPiBWMi0+VjM6DQo+ID4gCSogQWRkIHRoZSBtaXNzaW5nICJTY2Fs
ZVVuaXQiLg0KPiA+DQo+ID4gSm9ha2ltIFpoYW5nICg0KToNCj4gPiAgICBwZXJmIHZlbmRvciBl
dmVudHM6IEZpeCBpbmRlbnRhdGlvbiBvZiBicmFja2V0cyBpbiBpbXg4bW0gbWV0cmljcw0KPiA+
ICAgIHBlcmYgdmVuZG9yIGV2ZW50czogQWRkIEpTT04gbWV0cmljcyBmb3IgaW14OG1uIEREUiBQ
ZXJmDQo+ID4gICAgcGVyZiB2ZW5kb3IgZXZlbnRzOiBBZGQgSlNPTiBtZXRyaWNzIGZvciBpbXg4
bXEgRERSIFBlcmYNCj4gPiAgICBwZXJmIHZlbmRvciBldmVudHM6IEFkZCBKU09OIG1ldHJpY3Mg
Zm9yIGlteDhtcCBERFIgUGVyZg0KPiANCj4gRm9yIHRoZSBzZXJpZXM6DQo+IFJldmlld2VkLWJ5
OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+DQo=
