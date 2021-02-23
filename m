Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D00322490
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 04:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhBWDOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 22:14:11 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:54755
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230008AbhBWDOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 22:14:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMiVA4ZXB0eAkSdxK6bKaaqbjGlACzIWsZWSlgs6wCGET2S0agFAUzkP/WSVaYUHGOCVNun73TJZ6CED5Qd0r+JcUk2inG/2vvSCrmUyB6vb3+gUXdPFIGjYnEKLYT1EL04CHlXHN8zNHhTIYNBwPnBFlOqLDmDoNxeTuoJMj1UTyNwsR1+TkjMBICv9O2oTFBxKiN5l4+8J8OQirfECOt1n4+AP8e9xMYj4JNKYtfg6iXR6Rc1tZormI9oKTPezKGCp32zzlaPVsEgnfgOUlkN6S+CgNc9krPsiHp3VRcfA6SZUCHiAuVq+w/FZ+46JXVxPgJRPiAOStSjnJ4C1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anWkUX7XW+6ismiWoLWvlTJqkqterJwR04JV1eDZW+M=;
 b=SFjf3rumD37P8xwSfaYM/HHKiHrrdFTwv/tuKf6YLWNkz664S1Jb/pTtjrAqMrtvjhnl23RqLnibNLAzIgOO4ctDYDJJUBjYVgZbEiG4Sb93Lji3UB6nJZODodfbgXb2DBq7MTM6s3szyz0/tpwNi2iwXIKyjFHxZZBB/qb0Rz4F68+D7n4qoKjwfMS8aTN4F1pGL1YUr9Oi+CmTsRRSFuk4B4ouQBYUMSZ63IO2cPhHuIQKe4g7oaN0pJm9ZAWrBnlA3WiaD6singZH9D2V4uc9zxJWvFW1mlOF1j2Kzo+wdwNUHRpDeT/2pLICwD4H6ylQtB386kr5FaalCIR5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anWkUX7XW+6ismiWoLWvlTJqkqterJwR04JV1eDZW+M=;
 b=M/igdmXh5EJ05BqtQbYCsBvA6MdDJDN8XsMhzasGxiA7LIfvnxPPY0hffhp1jvZRyr9HNNvVrb6M7/CWPEDKoT7SPyBs+6mpUxCcRAOt2CyPY8F3ptLTKq84TvLsNvh3EFKVJZZFzPit3lPAGrlo/WZ8fiWaksYp+TdVFmK9WN4=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4696.eurprd04.prod.outlook.com (2603:10a6:20b:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 03:12:56 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::394e:4132:3afd:7d94]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::394e:4132:3afd:7d94%3]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 03:12:56 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1] LF-3434: arm64: dts: imx8m: add pmu node
Thread-Topic: [PATCH v1] LF-3434: arm64: dts: imx8m: add pmu node
Thread-Index: AQHXCZEV1J2ZZFowbU6/bAgVzJOP1aplEGlQ
Date:   Tue, 23 Feb 2021 03:12:56 +0000
Message-ID: <AM6PR04MB6053F0F98DFB19B0AD77384EE2809@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20210223030815.8056-1-alice.guo@oss.nxp.com>
In-Reply-To: <20210223030815.8056-1-alice.guo@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e72c391a-4630-4038-06fa-08d8d7a8eac4
x-ms-traffictypediagnostic: AM6PR04MB4696:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB46960C984BE73D294F39C675A3809@AM6PR04MB4696.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o5Pb83GpE6ykpC1fBLl8yhpgeJOLS4PVTeRGWuTabvkD9s4+fkTB/6+QaIZ478LCek3u72cKADtMegTQfu2LbuZehs+9Vp7aZfDgcuhyB4yi19+4oxB5WsrNR1Mz5wc4texWu9dZ0l5myOsYguvO2+jkn/5qfcwxXUMEO7TDFdlGqPdOWlJkW5gZFnxZRJG+QNlE4SIHLC/yepYlbVSGHf6lUvoesCrND95f2IDg3bxueOB9Mrj8CO8ooHq3vJe9uUL3IPCIqBBTt719dJI+TxdJ0ddn8T26VOS7f+NkFjlvjQmkz9uTSuDQ6c/ybvysidmI+i4q6n+xgq1OZnQUpdlPXV9yZ50/4LAN0HWZazkOU5GuN0ORj4Eoqr9YhnPuppUZS/3QQmiUbc84fS1P5IsfFUdIyvuVWS5wdgkpcWWHTZvIOU5oLqJt14aDKEAK0KUYjQoSxkh24SSVkooIyUiSl8SjR1mPi9iKRfWI48OdyiNX6LPotYUJ/d+HsqZaxoNPhkcwYc7ZCyAZQYVkK8DKqIWDXfJCLTSJIfq/xnZZ4R5vaMjbeAb891oOOqejEpllTRPdOQRttKA932CdpvK8jIPP47ucZkGMUaiWchoI/fvroN0nVykwa0Phxb8VgL1w6Z5m6NAfbTE4AtzDOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(71200400001)(186003)(76116006)(52536014)(66556008)(966005)(55016002)(110136005)(4326008)(8676002)(66446008)(54906003)(64756008)(53546011)(6506007)(8936002)(33656002)(2906002)(66476007)(83380400001)(66946007)(316002)(9686003)(7696005)(26005)(86362001)(478600001)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?SitLdE1Xa1JIT2xUK0pXRkpuL0xPcWJuSXk3TXJodzVFNjk2UzJBSys5aURx?=
 =?gb2312?B?TjVtQ0RnQ3dDL0V0WjMwMHhRVi9kM3F5NFlMTlZ3SGlpeGZ1Vk5zbTVoZFVU?=
 =?gb2312?B?dVZrUXJhVExuQ1BoOFRqanBkMjVwRm1IVG91WHVIN3pKWTZpa3RBb21nUW1n?=
 =?gb2312?B?a2x6SStjQlplT3JoSlRiNWVLM3lVL1EzeUoxOU5LLzE0cWo0L2w1MmtmcTFy?=
 =?gb2312?B?ODRjOU9PSW8waGpDSms3dllvWm1yUDN3K2xUalI3RERtSkc2NlBKY3FxQWMv?=
 =?gb2312?B?WUlRc2dOUklJZDF2cy9RNVY2WW4yVlQ5UkJPZEYvbUVxdzIwZW1kUms1em1m?=
 =?gb2312?B?Y29lbytEWWMvZkpHbzJ5aFlUaDVoRmdvZWlFV0I3NFg0ZFNCTTVRVkt3ZzZ4?=
 =?gb2312?B?UnFna2hOZXhaN3FUb3k3RGh1Y3lOQkhlaUtvdmNyZjBGclo2NTRPUWR6M05J?=
 =?gb2312?B?Ujh5M1dnTEMrZm5PdVhYQk9tNDc0Nk8ySU50NlhYZ25QT0tSR1I2RkR0alFw?=
 =?gb2312?B?S3lUbkl0NkNDdUNaaWhCTGY1dGFQaXJ0K2hCOXpYZDhqanczQWJseTNDNEdD?=
 =?gb2312?B?SmxESUgzdEZ0Z0pBYW0xcndnZ2FxTHNJaWY4NnFPY2RPTW1GVytQcXFLdlZF?=
 =?gb2312?B?UEQ2c0NIa2k0K1dhSzJxUkgwTUJ1QVg3Uy9yYzdWZzAzZ2dsUmtGZ0NiUE9W?=
 =?gb2312?B?by82aHJBa2gwMVhGOEo0R0RTVS8xNlFTczRiM0VhWFc1N0xqTkZyZGJ0OTZ0?=
 =?gb2312?B?M1MxazJzWWRWWk5rUnZndHBKSWtJSzFBR09uamtiN0FPNERZVXV5SjF2elVR?=
 =?gb2312?B?RVB1Y2VsTHlYRTdUTFVEWXVCbkFXakpxRFArYm4rTElzZmljT1FmQ0dYTU5D?=
 =?gb2312?B?c0F5OXJvQnFQZElFMk5oWWVTaHBoWkExSlhURnZwUm9Yd2ZKNVJ2ME9UMmps?=
 =?gb2312?B?eDRWOUtFdEd0QWlZcmVyOEtFU3dCKytkWlhTMy9WRURzQzlzRGtZYlRwN3Fw?=
 =?gb2312?B?cEFxQjFDQlZVaURXbTZxVEVGVks0MjZ3SlJ3NXFobTZ6NDdDUUsxNG44cGp1?=
 =?gb2312?B?YWFWblhVRFhocW9wVUsrUFZRYTVQdlNxcGtGU1RRTkY0YW1WRXZGbFQyeXZV?=
 =?gb2312?B?K1pPaWxXcjJXd1dmcWNnUy9idVMxWXc3OXFsS0oxWGYxMStJMHhmcHI1V3pE?=
 =?gb2312?B?aWJMTWFBR2Y3YWs4YldNQjlucmtVK2YzZi8zeFZ3NGlzYWtOTmlNcXdGVzZZ?=
 =?gb2312?B?RHR3aVE4eFFnbUVySUZYdmZ0YzJHcXFjbkhsMVd1emFOOTFoM29QeTBMRDM1?=
 =?gb2312?B?T3VVSXpNWjY4K282YkR0MmVIcDlaZG1VUkx3a3NSY3ZaeVhWUTJadEpiRDdj?=
 =?gb2312?B?aXpXWE1FczY3L3JaZjB5SkpPQXBzcFQ3ZUhQVURTMC9OUkI4NmpGY3N6bmRx?=
 =?gb2312?B?ODlCRCs3SFdCNEhUb2VmYkJoZ2VFTnpqaXNGQnpZR1FsSDIxS3p5WUVkWXBy?=
 =?gb2312?B?enRQRjdIbldWVmhXaHJ4RmRERUZRTFdTVHFFVFdtWCszc0JlejE3Z05oRnNM?=
 =?gb2312?B?bmtyaG4zZUdHeVR3TTdoZ0xCY01nR2xUMWV6VTR4eUVaRnFqdStCQ0IvNzNw?=
 =?gb2312?B?L01waEw1djZha3hQOHdhWU04QkhoRG1mRUduZlBFbTlSNXRjWW5Sd3c5WjBa?=
 =?gb2312?B?WXg4QXhGYTdlWjRLeWlZaDBwcnUvZWZYNENLSGZNTGhLZUpmNFM0NmhFUHA4?=
 =?gb2312?Q?F9S6Xyw5ESVAqqK05UqXD9dT+bqxx746wnly/TN?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72c391a-4630-4038-06fa-08d8d7a8eac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 03:12:56.5478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mj4sIaMTPkLmx5WI2QeCmmMwkTCFLBO3KT771DyXwi98MvwnIaA5Hs4Q/6G6bAe4eMUGhykTH/d4UtB6QGHDbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4696
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWdub3JlIHRoaXMgcGF0Y2guDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogbGludXgtYXJtLWtlcm5lbCA8bGludXgtYXJtLWtlcm5lbC1ib3VuY2VzQGxpc3RzLmluZnJh
ZGVhZC5vcmc+IE9uDQo+IEJlaGFsZiBPZiBBbGljZSBHdW8gKE9TUykNCj4gU2VudDogMjAyMcTq
MtTCMjPI1SAxMTowOA0KPiBUbzogcm9iaCtkdEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwu
b3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4g
Q2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDog
W1BBVENIIHYxXSBMRi0zNDM0OiBhcm02NDogZHRzOiBpbXg4bTogYWRkIHBtdSBub2RlDQo+IA0K
PiBGcm9tOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiANCj4gQWRkaW5nIHBtdSBu
b2RlIHN1cHBvcnRzIHRvIHVzZSBwZXJmIHRvb2wgdG8gbW9uaXRvciB0aGUgQ1BVIHBlcmZvcm1h
bmNlIG9mDQo+IHRoZSBpbm1hdGUgY2VsbCB3aGVuIGVuYWJsaW5nIEphaWxob3VzZSBhbmQgcnVu
bmluZyBkdWFsIExpbnV4IE9TLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGlj
ZS5ndW9AbnhwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0tZXZrLWlubWF0ZS5kdHMgfCA3ICsrKysrKysNCj4gYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1uLWV2ay1pbm1hdGUuZHRzIHwgOCArKysrKysrKw0KPiBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLWlubWF0ZS5kdHMgfCA4ICsrKysrKysrDQo+
IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1ldmstaW5tYXRlLmR0cyB8IDcg
KysrKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay1pbm1hdGUu
ZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay1pbm1hdGUu
ZHRzDQo+IGluZGV4IGZlOWQ5NjEzMTA0NS4uNmFmY2NjMmMxNDBlIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLWlubWF0ZS5kdHMNCj4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay1pbm1hdGUuZHRzDQo+
IEBAIC00OCw2ICs0OCwxMyBAQA0KPiAgCQl9Ow0KPiAgCX07DQo+IA0KPiArCXBtdSB7DQo+ICsJ
CWNvbXBhdGlibGUgPSAiYXJtLGFybXY4LXBtdXYzIjsNCj4gKwkJaW50ZXJydXB0cyA9IDxHSUNf
UFBJIDcNCj4gKwkJCSAgICAgKEdJQ19DUFVfTUFTS19TSU1QTEUoNikgfCBJUlFfVFlQRV9MRVZF
TF9ISUdIKT47DQo+ICsJCWludGVycnVwdC1hZmZpbml0eSA9IDwmQTUzXzI+LCA8JkE1M18zPjsN
Cj4gKwl9Ow0KPiArDQo+ICAJcHNjaSB7DQo+ICAJCWNvbXBhdGlibGUgPSAiYXJtLHBzY2ktMS4w
IjsNCj4gIAkJbWV0aG9kID0gInNtYyI7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZXZrLWlubWF0ZS5kdHMNCj4gYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZXZrLWlubWF0ZS5kdHMNCj4gaW5kZXggNTg0YzFmYTE5ZjU2
Li5mMjQzNGFkMzY5ZGMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtbi1ldmstaW5tYXRlLmR0cw0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bW4tZXZrLWlubWF0ZS5kdHMNCj4gQEAgLTQ4LDYgKzQ4LDE0IEBADQo+ICAJ
CX07DQo+ICAJfTsNCj4gDQo+ICsJcG11IHsNCj4gKwkJY29tcGF0aWJsZSA9ICJhcm0sYXJtdjgt
cG11djMiOw0KPiArCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0KPiArCQlpbnRlcnJ1cHRz
ID0gPEdJQ19QUEkgNw0KPiArCQkJICAgICAoR0lDX0NQVV9NQVNLX1NJTVBMRSg2KSB8IElSUV9U
WVBFX0xFVkVMX0hJR0gpPjsNCj4gKwkJaW50ZXJydXB0LWFmZmluaXR5ID0gPCZBNTNfMj4sIDwm
QTUzXzM+Ow0KPiArCX07DQo+ICsNCj4gIAlwc2NpIHsNCj4gIAkJY29tcGF0aWJsZSA9ICJhcm0s
cHNjaS0xLjAiOw0KPiAgCQltZXRob2QgPSAic21jIjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmstaW5tYXRlLmR0cw0KPiBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmstaW5tYXRlLmR0cw0KPiBpbmRleCAyNzdl
ZjcwZjI5MDMuLmJlNTM4ZjUxMDM0MCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1wLWV2ay1pbm1hdGUuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmstaW5tYXRlLmR0cw0KPiBAQCAtNDgsNiArNDgsMTQg
QEANCj4gIAkJfTsNCj4gIAl9Ow0KPiANCj4gKwlwbXUgew0KPiArCQljb21wYXRpYmxlID0gImFy
bSxhcm12OC1wbXV2MyI7DQo+ICsJCWludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+ICsJCWlu
dGVycnVwdHMgPSA8R0lDX1BQSSA3DQo+ICsJCQkgICAgIChHSUNfQ1BVX01BU0tfU0lNUExFKDYp
IHwgSVJRX1RZUEVfTEVWRUxfSElHSCk+Ow0KPiArCQlpbnRlcnJ1cHQtYWZmaW5pdHkgPSA8JkE1
M18yPiwgPCZBNTNfMz47DQo+ICsJfTsNCj4gKw0KPiAgCXBzY2kgew0KPiAgCQljb21wYXRpYmxl
ID0gImFybSxwc2NpLTEuMCI7DQo+ICAJCW1ldGhvZCA9ICJzbWMiOw0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLWV2ay1pbm1hdGUuZHRzDQo+IGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLWV2ay1pbm1hdGUuZHRzDQo+IGlu
ZGV4IGIxZGI2M2NkYjk4Yy4uNTdlMGFiMmJmNGQzIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLWlubWF0ZS5kdHMNCj4gKysrIGIvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLWV2ay1pbm1hdGUuZHRzDQo+IEBAIC00OCw2
ICs0OCwxMyBAQA0KPiAgCQl9Ow0KPiAgCX07DQo+IA0KPiArCXBtdSB7DQo+ICsJCWNvbXBhdGli
bGUgPSAiYXJtLGNvcnRleC1hNTMtcG11IjsNCj4gKwkJaW50ZXJydXB0cyA9IDxHSUNfUFBJIDcg
SVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsJCWludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+
ICsJCWludGVycnVwdC1hZmZpbml0eSA9IDwmQTUzXzI+LCA8JkE1M18zPjsNCj4gKwl9Ow0KPiAr
DQo+ICAJcHNjaSB7DQo+ICAJCWNvbXBhdGlibGUgPSAiYXJtLHBzY2ktMS4wIjsNCj4gIAkJbWV0
aG9kID0gInNtYyI7DQo+IC0tDQo+IDIuMTcuMQ0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCg==
