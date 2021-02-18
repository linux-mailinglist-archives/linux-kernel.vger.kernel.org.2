Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04E231E683
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 07:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhBRGwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 01:52:11 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:54502
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229806AbhBRGgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 01:36:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTljzRbBAt7t5yHJOWsIJIG56/93IhNpCdj5woe/tpIk78H9zX0dqhAW08d+RDo7yh0BLe2DS64A0cBO4sB26wb5ZDWn3zhuuTlG4nsalqep6ouSjBvcVCtkGljRFBz/x7Ns6RcHY4Td6EkD9HmThZxLcZFjwR/3NN8E17KY/U//UtcnmM1utdYThbN9v6K8qtOdaFZd+uhvmbcZXkQPXyJ7oU0gX1WPtkELtEf47+1vVexOHIJA2K7IyhYK3ZdBCBxc//CeMeWJ0UvOcR2EcXDvFYef4D+BY4SozrrgywG8gHwRp7nx81NTYmnB98pJY5j7aFO1rVyqajR769cjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPvQFV4J1HYrgKY0q9jQsasFF2jFasdGDA5NhGgN6Rk=;
 b=iZ+1B4rdY9Va72uVkqjkBePvRpMgn7gsqqbJlKWBGe2F7IyRornHGB0Tjedx0Zk2EMpEkIYJyGqz3PCg8Z4IcwxNN2xyL6bt32jNeIogkAHDhQ5M2PurURkrL6XiOu7/mtJeebZBRppKSMPwDnvrbdKb/MflCccD2xhxi2Nf45dEFLk/M22MNNy9Xv01CLKgbrBqZzPUuV83AwUiFxNb0bAlm528UfbtPe7qxiRC7dUtO9mPOMzSmPYZpFRD6/h9L+J5JBiWJ7fvs/BNxbenry/XL3mezA7m+bg1YnC+XiXEkBtZdOsNskqzQVzZ+C1Xphk/hCRdCxphyyubAbXqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPvQFV4J1HYrgKY0q9jQsasFF2jFasdGDA5NhGgN6Rk=;
 b=LI1UuyQBfpXsowTVJBUjGp3xLL48qluiDrZF5QzCkerEfYZYcWBMr16PMowb/Q9pF7ivwtjYJe0HUBBYh30QIb2sJy39K2gX9759UQQMYBQHQX446dUJEBZCPgGynNSJ+Nl1OUNsZiZfP2W03jIKidAAvi7PpYYq8E0OyKr4aVM=
Received: from AM6PR04MB5848.eurprd04.prod.outlook.com (2603:10a6:20b:a8::19)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38; Thu, 18 Feb
 2021 06:19:05 +0000
Received: from AM6PR04MB5848.eurprd04.prod.outlook.com
 ([fe80::199b:f05:83f6:965b]) by AM6PR04MB5848.eurprd04.prod.outlook.com
 ([fe80::199b:f05:83f6:965b%7]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 06:19:05 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Jacky Bai <ping.bai@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx8mp: Remove the none exist pcie clocks
Thread-Topic: [PATCH] clk: imx8mp: Remove the none exist pcie clocks
Thread-Index: AQHXBbwieYKtjq+YpkauAiQtlWzxB6pdbhMAgAACBFA=
Date:   Thu, 18 Feb 2021 06:19:05 +0000
Message-ID: <AM6PR04MB5848D9A45282AC8FB2A218408C859@AM6PR04MB5848.eurprd04.prod.outlook.com>
References: <1613627654-29801-1-git-send-email-hongxing.zhu@nxp.com>
 <DBBPR04MB79308A7CE1800FCEC4042CCD87859@DBBPR04MB7930.eurprd04.prod.outlook.com>
In-Reply-To: <DBBPR04MB79308A7CE1800FCEC4042CCD87859@DBBPR04MB7930.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f320e53-78db-4615-decd-08d8d3d517d9
x-ms-traffictypediagnostic: AS8PR04MB7557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB7557F8C98C6932C5BA4596088C859@AS8PR04MB7557.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cgx1cD+g8D/y6NGL+JRgE00ROeWnGi3q3EUYj3rXYTyhaZszfA7qzJbB2hSpSlNf1jZ9jGlfK3XyJJ3fb+KDtgNXGtC03gnDRIi+6cpu5QFWuQ6FoioyttZKWZhvjTzW4c9CiT08S8cXjwr+oPW60fDBqzxlpzTPCBLpRuTSOkQI0aju0ryV+yI0nR3A9Fe/SWm1jV41f68Fn9gGOOnXl88kwyqiUSX2W5RFKQXDvUxTG5ui/PjXHECMuIuuODZYLyPLsQuYJDdgIvryt5TuUIASW/DNY8JiiNnO6FFp/zDn4wPgvUL6AfBhcTCwlyy/8ddLunUas9ylUoHFHqZBg9SlMJaignsr9hwgIiOVFJWnz8yefYLNfvPzifTVnXuAd3nC9eo/Du1iyWZpOP6twzSjzIRmWstCVK/5hUKhCc3LxnmPhTBUI0Ahpb+wCK8mSyMdLk4pjuJd6Xxn7320ds++65U8UiDAMxHR/+MsjWKwkLBhYclevL0xfqSoXpeyA0jdbQa4pbh4H8UwkFv9GmoFg/8n6PgZDhFkEAk9TcNmeYEdEM6P0MQRPMAtch5y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5848.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(76116006)(8676002)(26005)(9686003)(110136005)(54906003)(4326008)(7696005)(5660300002)(83380400001)(66476007)(66946007)(66556008)(186003)(66446008)(64756008)(478600001)(52536014)(86362001)(71200400001)(55016002)(8936002)(53546011)(316002)(6506007)(33656002)(2906002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aTRZSFVDaGRDdjBUaEhReURzKzBtblZ4SHRlaEtoc0VTL3QwbWk4SERKRGM2?=
 =?utf-8?B?ZU5RbDVSbFdsVG1FeG5rZWhSOE5Ub2dkemVTL0JVSWxrWjhncDJYK09wT3hu?=
 =?utf-8?B?U3hwVTNtZWNYZjBTbHQ4aHFZUisydFlvMXU1SEVaK2JYenp3SC91QVRHTUts?=
 =?utf-8?B?L1NSZDJ4UkRFYndHMEpveVF5dUY4c2hZeU15b1BoOUZjNVhwQ3RPbjYvTVZV?=
 =?utf-8?B?cld6L2RPS2U3akU3K0Q2R2l4Nm5yVFBDNHJqamhGWmdydXpobm11bUFqZFda?=
 =?utf-8?B?ZGltNmE5Z3ZCb3d5VE1SZXd0T2kwMU1obHM5UHZEUnhwZlpEeCtkZ3NHUkNr?=
 =?utf-8?B?L2NLYVNFZXNpZS8yZGpXOGtYTkFlRWsyREoxWHBjZndPK255Wk1QcnlNNzJG?=
 =?utf-8?B?b2p3QlpzbExONzdQYnpCVEVRMUpKMWZidWhxVDVOb2dnaVQzYWFYZ2E1TXEr?=
 =?utf-8?B?dUhVRW15Y1hsZ01ISFlKbDR4b04wT2xpSUdTWG5iZWZ0YmVtZ25jNVVQcTlD?=
 =?utf-8?B?VXVraWhFOUVvQUxhQjlLT2djeWs3V0ZIalBoWExQUFpqcEN4SVBPM2gxd0Vz?=
 =?utf-8?B?eUlOZHlzUzhhZTJDYW90Z1JWazNBd3EvY0FiZW5kSjRQNmtEdEdSMGlmcDYy?=
 =?utf-8?B?alFuQWM3M1BBMUdwb1hYOTJ0TGJ2d2U4djVkMDc1eHZFV0Jld3cybnVOQXcv?=
 =?utf-8?B?YUd1VzUzV2dwNW1SMGkwck1TRDdBMklaNnA4bVc1ckxsT0lFS1g4ano4Z3Bk?=
 =?utf-8?B?SHBZRGtPVFpmUUFSaFo4dUJJdVhkYnpJZElkbGViNTFyL2pxUk96TW8yYnoy?=
 =?utf-8?B?QjRTMG5UU3Q5Y1hQOWFVZGV1ZlYyNkhrRzJsOG0zYVJNcUhCM3hlajZhaFVG?=
 =?utf-8?B?Q0dFSHdYME4rZmR3NkRVUHZOdk5LLy82RytzSW1pS3NMblhKczVGbmJMdUta?=
 =?utf-8?B?M01Ua3FJOWZwVGhRWm1tU1ZTWkY0TEJhRStuSEZzc0ozdXViOTY3TjliU3R5?=
 =?utf-8?B?UGVUZEM0dytVOWhOR054SlhrdlptRDN6c0FKaXpndHhrMWNuOU1PSWtYakl3?=
 =?utf-8?B?Yk5mVXVjVG84bGVCM2RFS0VmYzVKZDNIRGlZdTlrOFRCUkYzOUFJeFdZa0ZY?=
 =?utf-8?B?L29MKzF5YXA4RlA3dWo1eXExOFFFNWJHSG5ObnpsWFRjd2RCSGNLTW5zeTVv?=
 =?utf-8?B?R0FabnpsR2Z2MGljb1lGTEJDVzlOKzZYbzBDRVh2WndGTXpoeUFpbTNsNHZa?=
 =?utf-8?B?TjZsRGFQSTlYdkxnT3VmTE15S0ZyZDYzRVphc0E3SmtOY0prOE1NU1RNVVlF?=
 =?utf-8?B?ZmJvWGYvQTFicDA1dExSOElYek51SmpvQnB0THc4YzVoZDNWS0hrVlBVWmI4?=
 =?utf-8?B?WmFHNkxlRW1PUTdtdXZQSXkwbHZTbWwzdWFHWVZWY1ErTHVEV0ZJNlMySW14?=
 =?utf-8?B?RVFoRHBrK2tvWVZKbTVYRU5FdXN2c3NzNlFtMHpXSlp3T2E4d09lTkhxb0pQ?=
 =?utf-8?B?VHBjNlBrQVo0enN4TmY0bW5SbEhsc2N1bzZmRVZTaG9xdHdYK2tPTzJvdjU5?=
 =?utf-8?B?VkZmdVdkNE04RmF6dlRzU0Q2cFNhVXF5M0t3L0N2OHhOemV0UE90aEpodmxF?=
 =?utf-8?B?ajdpaVg2ZTk2aFRNR2pXU0ZCRVVEMmMyaERIY1B3T3duQS9EaDJWc0dHeVZT?=
 =?utf-8?B?dVJHQkNGdEU0blMxZFFUOXlxbXpSYmE2a3lvL1graFBsK3BjSmRtWHFFWVJ6?=
 =?utf-8?Q?7R3NDV7UcEJdki/YIBap6CUJjAqk4qQ5/PDllSs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5848.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f320e53-78db-4615-decd-08d8d3d517d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 06:19:05.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vexV0Wv5mL5d6y4EnQnb8ASBktuCrpph2ijOENuJiVQ0qBPmdw47BNJtjZeIomM2qo6UgHg4973HiXClIIUxYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphY2t5IEJhaSA8cGluZy5i
YWlAbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDE4LCAyMDIxIDI6MTEgUE0N
Cj4gVG86IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5l
bC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQ
QVRDSF0gY2xrOiBpbXg4bXA6IFJlbW92ZSB0aGUgbm9uZSBleGlzdCBwY2llIGNsb2Nrcw0KPiAN
Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFJpY2hhcmQgWmh1IFtt
YWlsdG86aG9uZ3hpbmcuemh1QG54cC5jb21dDQo+ID4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5
IDE4LCAyMDIxIDE6NTQgUE0NCj4gPiBUbzogc2hhd25ndW9Aa2VybmVsLm9yZzsgSmFja3kgQmFp
IDxwaW5nLmJhaUBueHAuY29tPg0KPiA+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAu
Y29tPg0KPiA+IFN1YmplY3Q6IFtQQVRDSF0gY2xrOiBpbXg4bXA6IFJlbW92ZSB0aGUgbm9uZSBl
eGlzdCBwY2llIGNsb2Nrcw0KPiA+DQo+ID4gSW4gdGhlIGkuTVg4TVAgUENJZSBkZXNpZ24sIHRo
ZSBQQ0llIFBIWSBSRUYgY2xvY2sgY29tZXMgZnJvbSBleHRlcm5hbA0KPiA+IE9TQyBvciBpbnRl
cm5hbCBzeXN0ZW0gUExMLiBJdCBpcyBjb25maWd1cmVkIGluIHRoZSBJT01VWF9HUFIxNA0KPiA+
IHJlZ2lzdGVyIGRpcmVjdGx5LCBhbmQgY2FuJ3QgYmUgY29udG9sbGVkIGJ5IENDTSBhdCBhbGwu
DQo+ID4gUmVtb3ZlIHRoZSBQQ0lFIFBIWSBjbG9jayBmcm9tIGNsb2NrIGRyaXZlciB0byBjbGVh
biB1cCBjb2Rlcy4NCj4gPiBUaGVyZSBpcyBvbmx5IG9uZSBQQ0llIGluIGkuTVg4TVAsIHJlbW92
ZSB0aGUgbm9uZSBleGlzdCBzZWNvbmQgUENJZQ0KPiA+IHJlbGF0ZWQgY2xvY2tzLg0KPiA+DQo+
IA0KPiBBcyBTaGF3biBzdWdnZXN0ZWQgYmVmb3JlLCBpdCBpcyBiZXR0ZXIgdG8gcmVtb3ZlIHRo
ZSBjb3JyZXNwb25kaW5nIGNsb2NrIElEDQo+IGluIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2sv
aW14OG1wLWNsb2NrLmgNCj4gDQpbUmljaGFyZCBaaHVdIFRoYW5rcyBmb3IgcmVtaW5kaW5nLg0K
SXMgaXQgZmluZSB0byBsZWF2ZSB0aGUgaG9sZXMgaW4gdGhlIElEIGRlZmluaXRpb25zIGluIHRo
ZSBoZWFkZXIgZmlsZSBpZiB0aGV5IGFyZSByZW1vdmVkPw0KDQpCZXN0IFJlZ2FyZHMNClJpY2hh
cmQgWmh1DQo+IEJSDQo+IEphY2t5IEJhaQ0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJk
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEphc29uIExpdSA8
amFzb24uaHVpLmxpdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Nsay9pbXgvY2xr
LWlteDhtcC5jIHwgMTUgLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlt
eDhtcC5jDQo+ID4gYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC5jIGluZGV4IDJmNGUxZDY3
NGUxYy4uYWZiZWI2YmYxOTA5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGst
aW14OG1wLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC5jDQo+ID4gQEAg
LTE1MiwxMCArMTUyLDYgQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBpbXg4bXBfY2FuMl9z
ZWxzW10gPQ0KPiA+IHsib3NjXzI0bSIsICJzeXNfcGxsMl8yMDBtIiwgInN5cw0KPiA+ICAJCQkJ
CQkic3lzX3BsbDFfMTYwbSIsICJzeXNfcGxsMV84MDBtIiwNCj4gInN5c19wbGwzX291dCIsDQo+
ID4gIAkJCQkJCSJzeXNfcGxsMl8yNTBtIiwgImF1ZGlvX3BsbDJfb3V0IiwgfTsNCj4gPg0KPiA+
IC1zdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGlteDhtcF9wY2llX3BoeV9zZWxzW10gPSB7Im9z
Y18yNG0iLA0KPiA+ICJzeXNfcGxsMl8xMDBtIiwgInN5c19wbGwyXzUwMG0iLA0KPiA+IC0JCQkJ
CQkgICAgImNsa19leHQxIiwgImNsa19leHQyIiwgImNsa19leHQzIiwNCj4gPiAtCQkJCQkJICAg
ICJjbGtfZXh0NCIsICJzeXNfcGxsMV80MDBtIiwgfTsNCj4gPiAtDQo+ID4gIHN0YXRpYyBjb25z
dCBjaGFyICogY29uc3QgaW14OG1wX3BjaWVfYXV4X3NlbHNbXSA9IHsib3NjXzI0bSIsDQo+ID4g
InN5c19wbGwyXzIwMG0iLCAic3lzX3BsbDJfNTBtIiwNCj4gPiAgCQkJCQkJICAgICJzeXNfcGxs
M19vdXQiLCAic3lzX3BsbDJfMTAwbSIsDQo+ICJzeXNfcGxsMV84MG0iLA0KPiA+ICAJCQkJCQkg
ICAgInN5c19wbGwxXzE2MG0iLCAic3lzX3BsbDFfMjAwbSIsIH07IEBADQo+ID4gLTM4MCwxNCAr
Mzc2LDYgQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBpbXg4bXBfbWVtcmVwYWlyX3NlbHNb
XSA9DQo+ID4geyJvc2NfMjRtIiwgInN5c19wbGwyXzEwMG0iLA0KPiA+ICAJCQkJCQkJInN5c19w
bGwxXzgwMG0iLCAic3lzX3BsbDJfMTAwMG0iLA0KPiAic3lzX3BsbDNfb3V0IiwNCj4gPiAgCQkJ
CQkJCSJjbGtfZXh0MyIsICJhdWRpb19wbGwyX291dCIsIH07DQo+ID4NCj4gPiAtc3RhdGljIGNv
bnN0IGNoYXIgKiBjb25zdCBpbXg4bXBfcGNpZTJfY3RybF9zZWxzW10gPSB7Im9zY18yNG0iLA0K
PiA+ICJzeXNfcGxsMl8yNTBtIiwgInN5c19wbGwyXzIwMG0iLA0KPiA+IC0JCQkJCQkgICAgICAi
c3lzX3BsbDFfMjY2bSIsICJzeXNfcGxsMV84MDBtIiwNCj4gPiAic3lzX3BsbDJfNTAwbSIsDQo+
ID4gLQkJCQkJCSAgICAgICJzeXNfcGxsMl8zMzNtIiwgInN5c19wbGwzX291dCIsIH07DQo+ID4g
LQ0KPiA+IC1zdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGlteDhtcF9wY2llMl9waHlfc2Vsc1td
ID0geyJvc2NfMjRtIiwNCj4gPiAic3lzX3BsbDJfMTAwbSIsICJzeXNfcGxsMl81MDBtIiwNCj4g
PiAtCQkJCQkJICAgICAiY2xrX2V4dDEiLCAiY2xrX2V4dDIiLCAiY2xrX2V4dDMiLA0KPiA+IC0J
CQkJCQkgICAgICJjbGtfZXh0NCIsICJzeXNfcGxsMV80MDBtIiwgfTsNCj4gPiAtDQo+ID4gIHN0
YXRpYyBjb25zdCBjaGFyICogY29uc3QgaW14OG1wX21lZGlhX21pcGlfdGVzdF9ieXRlX3NlbHNb
XSA9DQo+ID4geyJvc2NfMjRtIiwgInN5c19wbGwyXzIwMG0iLCAic3lzX3BsbDJfNTBtIiwNCj4g
PiAgCQkJCQkJCQkic3lzX3BsbDNfb3V0IiwgInN5c19wbGwyXzEwMG0iLA0KPiA+ICAJCQkJCQkJ
CSJzeXNfcGxsMV84MG0iLCAic3lzX3BsbDFfMTYwbSIsIEBADQo+ID4gLTU4NSw3ICs1NzMsNiBA
QCBzdGF0aWMgaW50IGlteDhtcF9jbG9ja3NfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0K
PiA+ICpwZGV2KQ0KPiA+ICAJaHdzW0lNWDhNUF9DTEtfVlBVX0cyXSA9IGlteDhtX2Nsa19od19j
b21wb3NpdGUoInZwdV9nMiIsDQo+ID4gaW14OG1wX3ZwdV9nMl9zZWxzLCBjY21fYmFzZSArIDB4
YTE4MCk7DQo+ID4gIAlod3NbSU1YOE1QX0NMS19DQU4xXSA9IGlteDhtX2Nsa19od19jb21wb3Np
dGUoImNhbjEiLA0KPiA+IGlteDhtcF9jYW4xX3NlbHMsIGNjbV9iYXNlICsgMHhhMjAwKTsNCj4g
PiAgCWh3c1tJTVg4TVBfQ0xLX0NBTjJdID0gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZSgiY2FuMiIs
DQo+ID4gaW14OG1wX2NhbjJfc2VscywgY2NtX2Jhc2UgKyAweGEyODApOw0KPiA+IC0JaHdzW0lN
WDhNUF9DTEtfUENJRV9QSFldID0gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZSgicGNpZV9waHkiLA0K
PiA+IGlteDhtcF9wY2llX3BoeV9zZWxzLCBjY21fYmFzZSArIDB4YTM4MCk7DQo+ID4gIAlod3Nb
SU1YOE1QX0NMS19QQ0lFX0FVWF0gPSBpbXg4bV9jbGtfaHdfY29tcG9zaXRlKCJwY2llX2F1eCIs
DQo+ID4gaW14OG1wX3BjaWVfYXV4X3NlbHMsIGNjbV9iYXNlICsgMHhhNDAwKTsNCj4gPiAgCWh3
c1tJTVg4TVBfQ0xLX0kyQzVdID0gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZSgiaTJjNSIsDQo+ID4g
aW14OG1wX2kyYzVfc2VscywgY2NtX2Jhc2UgKyAweGE0ODApOw0KPiA+ICAJaHdzW0lNWDhNUF9D
TEtfSTJDNl0gPSBpbXg4bV9jbGtfaHdfY29tcG9zaXRlKCJpMmM2IiwNCj4gPiBpbXg4bXBfaTJj
Nl9zZWxzLCBjY21fYmFzZSArIDB4YTUwMCk7IEBAIC02NDMsOCArNjMwLDYgQEAgc3RhdGljIGlu
dA0KPiA+IGlteDhtcF9jbG9ja3NfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gPiAgCWh3c1tJTVg4TVBfQ0xLX01FRElBX0NBTTJfUElYXSA9DQo+ID4gaW14OG1fY2xrX2h3
X2NvbXBvc2l0ZSgibWVkaWFfY2FtMl9waXgiLA0KPiA+IGlteDhtcF9tZWRpYV9jYW0yX3BpeF9z
ZWxzLCBjY21fYmFzZSArIDB4YmU4MCk7DQo+ID4gIAlod3NbSU1YOE1QX0NMS19NRURJQV9MREJd
ID0NCj4gPiBpbXg4bV9jbGtfaHdfY29tcG9zaXRlKCJtZWRpYV9sZGIiLCBpbXg4bXBfbWVkaWFf
bGRiX3NlbHMsDQo+IGNjbV9iYXNlDQo+ID4gKyAweGJmMDApOw0KPiA+ICAJaHdzW0lNWDhNUF9D
TEtfTUVNUkVQQUlSXSA9DQo+ID4gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZV9jcml0aWNhbCgibWVt
X3JlcGFpciIsDQo+IGlteDhtcF9tZW1yZXBhaXJfc2VscywNCj4gPiBjY21fYmFzZSArIDB4YmY4
MCk7DQo+ID4gLQlod3NbSU1YOE1QX0NMS19QQ0lFMl9DVFJMXSA9DQo+ID4gaW14OG1fY2xrX2h3
X2NvbXBvc2l0ZSgicGNpZTJfY3RybCIsIGlteDhtcF9wY2llMl9jdHJsX3NlbHMsIGNjbV9iYXNl
DQo+ID4gKyAweGMwMDApOw0KPiA+IC0JaHdzW0lNWDhNUF9DTEtfUENJRTJfUEhZXSA9DQo+ID4g
aW14OG1fY2xrX2h3X2NvbXBvc2l0ZSgicGNpZTJfcGh5IiwgaW14OG1wX3BjaWUyX3BoeV9zZWxz
LA0KPiBjY21fYmFzZQ0KPiA+ICsgMHhjMDgwKTsNCj4gPiAgCWh3c1tJTVg4TVBfQ0xLX01FRElB
X01JUElfVEVTVF9CWVRFXSA9DQo+ID4gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZSgibWVkaWFfbWlw
aV90ZXN0X2J5dGUiLA0KPiA+IGlteDhtcF9tZWRpYV9taXBpX3Rlc3RfYnl0ZV9zZWxzLCBjY21f
YmFzZSArIDB4YzEwMCk7DQo+ID4gIAlod3NbSU1YOE1QX0NMS19FQ1NQSTNdID0gaW14OG1fY2xr
X2h3X2NvbXBvc2l0ZSgiZWNzcGkzIiwNCj4gPiBpbXg4bXBfZWNzcGkzX3NlbHMsIGNjbV9iYXNl
ICsgMHhjMTgwKTsNCj4gPiAgCWh3c1tJTVg4TVBfQ0xLX1BETV0gPSBpbXg4bV9jbGtfaHdfY29t
cG9zaXRlKCJwZG0iLA0KPiBpbXg4bXBfcGRtX3NlbHMsDQo+ID4gY2NtX2Jhc2UgKyAweGMyMDAp
Ow0KPiA+IC0tDQo+ID4gMi4xNy4xDQoNCg==
