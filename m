Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1489A4169DB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbhIXCKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:10:23 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:28958
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243863AbhIXCKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:10:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdDQT1/fdRUAd3FSTyPEgpqg74zCLAHapxcSHfbaAozUepSDCGiwfsgJRd6weml6OuIWK2/OsJKAjUf4p81S0wwXmFo47E2kR8xfpCFwdCIDIrB3GEk0zgQzkDoXOI61qQUyvaBCaIKzauH49hFm6XzAPQbHkdHodYORexqX6RSh6i8/T0tuWXjdog13vefiRaC/CA6bhVI/O6LvYMhmJFfhRPX7/+btyEYPMQ1a9+sfDz+gilO1jTMZIO3AWnLP0k8fKbH9P2uUonM+CfZBuP8fmbgzCYdhMTMHcf53wE9nzJSpXhplbI+Sc/rzJ6B/Gs0eEV6XXajNmQ9OcGqieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UpWs0WA6+EpJ7LgURUeDNuUzZHiCkEz31d7FQ8McC+M=;
 b=KMwoyKAKD7oKXgmOL2gaC7CY7ftHPRKp07bEh8/u3+jsiH0YgEzGbgjDw3UR81KOQY3alWpsJinOE/3DUEgdczmuc1EXH5KixtEP3kqf3BZ5rdB3g7d0e++qwmIeQyriZ7f/GFuMj2ODZ80bcnjdm8ulOy+nl4B46Y54wQjDedVD+IKiv7sqOFkeNtXmb53tZOG8GBjEDHyTmb+jiEgn7xum8XlDo1smeqP4Q4K+GDHfNWivO9osCCOzjUAAyQzcXdPMhFUkCbn3bhDt/odV7tMd7SZ6VfxCs/YinxptHaJVLsZ10cim+teuyXk7cKSuwZJkxihfOAYANDdpfH6VDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpWs0WA6+EpJ7LgURUeDNuUzZHiCkEz31d7FQ8McC+M=;
 b=n9UB5wI+A7+F59OUxZFgvfY5o5UFp6rvEmBPu1M1SQNKJ1Sbls3E/cKvmNQoHsgGClE8tNogB28kskkSjUWH81GwDUWrSGi+Gd3QgUb2Hw69PAEDWvQAHrDUYgForJQi7ZpZ3DaQsitYLqB5YDPR5v9J/R0TJCpdZk7pQisMuS4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8530.eurprd04.prod.outlook.com (2603:10a6:20b:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 24 Sep
 2021 02:08:47 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::c5ef:f538:c3e0:c4c2]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::c5ef:f538:c3e0:c4c2%9]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 02:08:47 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/4] dt-bindings: phy: phy-imx8-pcie: Add binding for the
 pad modes of imx8 pcie phy
Thread-Topic: [PATCH 1/4] dt-bindings: phy: phy-imx8-pcie: Add binding for the
 pad modes of imx8 pcie phy
Thread-Index: AQHXq29U8Xq0ppHtP0iI4eEm7KofLauweGAAgACtOQCAAJZSAIAAvx2Q
Date:   Fri, 24 Sep 2021 02:08:46 +0000
Message-ID: <AS8PR04MB8676167A1A61409BABAD2BF88CA49@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1631845863-24249-1-git-send-email-hongxing.zhu@nxp.com>
 <1631845863-24249-2-git-send-email-hongxing.zhu@nxp.com>
 <YUuDMjBGWfNsMf2n@robh.at.kernel.org>
 <AS8PR04MB86766122EB2D851844FC7D7C8CA39@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAL_JsqJJhSB1ZYUU_nB+U+1yr0kbWQLeO1CUs5PCQ85MEOb=Og@mail.gmail.com>
In-Reply-To: <CAL_JsqJJhSB1ZYUU_nB+U+1yr0kbWQLeO1CUs5PCQ85MEOb=Og@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f03ae80-e40e-4489-8b9f-08d97f003e65
x-ms-traffictypediagnostic: AS8PR04MB8530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8530D4D7C97B4690B18C37958CA49@AS8PR04MB8530.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0m7ixz61kxahBc0W91MsAo4WuHsFR3Xwfv+xbyEAdZMZaJRhcDWt8+gHulsIs7VrBnJMkXWOeKDq34aL4SMnd7bm2SLkr9LaE0eiOlKHRjkQBnq46xTjGZQK4YUYW8Byf2GrRkgueQ+AF/Y4Yz7uKymDiMCJ1V3Zi01SHqkCpR5HXSdD/LeMhDolBf1FSQ73RjpO9NZhvRtTa7s2fFevl0rSHCAYCgUjoI0AxgSuzbeenjZdZigEc7qq+I752r2aQSd5nXuIYMUvUtgjEFkNnyQ4kfaOxGNioVgr+etJo4Kn8oUqkC46MD9cVHy+ofK5X4CZN4u5Xr9ASj4MczmONOuqb8YnSmiPMNARm3POEdYqOQzT4R455+84pSV6tL0Se6wnrRXxxHB4v1sqfjptRmZhv4ct059UI5DSQpg+S0TAbpIqvVG4hexjfsBlayVGHbUri/cLqOM6qHB++Uc02JYZr/Hr2kPMpiW7IfDSjKtYB1MaH2SdRVlUxpHXVW+AZ5n9pfL2F0sbDtfxBK+1q3w1VPV7UOvKolFJBW1qsb14052vNW51MinFZ5m7cEjwQ4YH55CtF5aoDqOobd30yAfAJwIbRSKz/nmHBnNUEi73Mql3nRFtriN7/8SYY0HOWUIDKIbRBPzr4Dixxp5KC2IJ0w8ivrq6IP/eZY9sPXKbhmq19Xi2VaD43ikAl+51+2QLvfHVv9ESil99PxPplQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(71200400001)(52536014)(26005)(54906003)(186003)(86362001)(8676002)(4326008)(66446008)(66556008)(66946007)(64756008)(316002)(7416002)(38100700002)(9686003)(55016002)(122000001)(38070700005)(508600001)(53546011)(7696005)(6506007)(33656002)(2906002)(5660300002)(66476007)(76116006)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG1QMVJRTlhJc05zeXpBS3NtMDJWbnRlQUNTOUk0RE00NGFIOUw5Mno2OGVv?=
 =?utf-8?B?R3NYMlYvTUJHWmRPWi85OTdxRDd4UWZMbGFuUktoRVRZVTQzWEUvZVIyMmdV?=
 =?utf-8?B?bmk0emQxZ2kxcEMwRmJjM0l2bjFGajlkR1Y2bHBDRW5MRkRXSUZHNkUxNmFY?=
 =?utf-8?B?NzNuSHhBUnBxVzYxcHl5akl5b0N4R0FyZFIyYk4veko2SjhWb2ozbDRDeFpy?=
 =?utf-8?B?NExrRS9vYUsrVWlOQnVaMDNIcEdGRU5BcDJSejIwNS9OR3R4YnRaaHZ5bmtp?=
 =?utf-8?B?bW52cTg3QXhqRDFuL2J3bVRVR3FuUlZtMFVkVDJObEpRVit4b0RIVHBYaGVI?=
 =?utf-8?B?RFVGdjRqMjNaclBvdG9KMXpDYW04Zno1TGJ1WmlZYnVJMjA2Y0N1d0N6Z3A1?=
 =?utf-8?B?UjlSQUpBUFBRZ1plR0xjNXp0aHZxL05ka2lyWGc2eVc2c3d2eWQ4MU1Rbndz?=
 =?utf-8?B?NWJYMDBYQklScFNPcWsrL1pITkQ3NXlrMmd3RzAvTjRSMjZEb3ZZbHY4VzdR?=
 =?utf-8?B?Zzk0Q1lIQS9uSG1YNThHNU1NMmh0QVlic3pIYU92ZHVSMUpTSHFHTjdiZlZT?=
 =?utf-8?B?M3JaQmNsb3ZCa2plRytBWXd5WXdNZHZHSFlyT21KQVdUM21hZEorWitZeHBG?=
 =?utf-8?B?SzNGV3VYZko2Z0hQbFpGYjloVm4wL28yeE1sWnBMbCttaXBETlh5dTlPcEFO?=
 =?utf-8?B?UzlHNUU5dEVWOVYwenZKdVd0dFRlSmxMazNWY2ZKcGRzS0pLRFNXaWVFZHhj?=
 =?utf-8?B?My8vWHVBYko4d3FVN0pPalJNWVp6Tmg5aWhLbXNPeEtsVDJ1K0IxSHdheVZo?=
 =?utf-8?B?UERJZ1VPY25PVGVOU1NyWmxOcGpCUU9sb3pZMjdxeUxRSk5rRVFHSWxjRlpn?=
 =?utf-8?B?eE9DWWM1MExraTZCSHBZcndySG1jN3lJNmtubWJ1TnBNKzhXMWdEWnE3L2pt?=
 =?utf-8?B?Y2IxZG5xM01jcHBUMjl4VDdsdERBOFBnK0kwTXJYNTdnTTNPUG9RQjRSbXV2?=
 =?utf-8?B?cGE2Z0YrYVlOcFpHMC9ETnA5dFBVU2d3TElzMVl0MVJvUE1ma28xdVhqdkI1?=
 =?utf-8?B?Y0dwb1EyUzdmQ2dHUWI0VmZucHBFSDZIVHlLdjhDd3FDMkdBS081c0VuN0cy?=
 =?utf-8?B?WlVYTjJjY0haYnpLYmx6YjJrQXdxRDljeUV6U2RPblpLc0xRbnJuUGdFLzNM?=
 =?utf-8?B?Tm1WS21hSng3c1JCSVl5U0l5VUpJM3dOLyt6bDFySVVHbEhtTmR5NjhTUmIw?=
 =?utf-8?B?bHFsZmc1NVR3a3BWV1JXUjc1VUNTYy9qc2RnQmxBQ0xXaHMwM3dqblBPUFJ3?=
 =?utf-8?B?T3R4ZnMrU21jOVBzcDRGQ1hNUFRuYllidnlkUWhFbjNEQ0NkdkV4NWNPNE5I?=
 =?utf-8?B?L3BTZ0gxT01BT2lqbnlyVC9oZHFMb0lXZkVabDJTa0F0a0JtckEyMWdzNkly?=
 =?utf-8?B?TVJMOTIxMk9zbng3WnlFWmJ5TTRnVUFYYThOclVLNzcybjVMWDE1WDhMemNy?=
 =?utf-8?B?SU9ZSloyN09ld05YM2x3NW9VQUJ1eDJqQUpGbkhnVUZ3Y3JrYk9FZFlXU2Fy?=
 =?utf-8?B?akdiRDN5Q2k1dUhiUk9nRXd4REFtZHZUZUlXbkZMcUZ0Nmg2N2xDMUEyMGw1?=
 =?utf-8?B?ZDBpRkR4TGpkMldGZk5PRE95MTFxTFVNU2ZCcUxJemI3WC9yazhoLytLc2lt?=
 =?utf-8?B?VHB4SkFhY1ZndVZ5M0VmRmRyWkpxWTNlNlpsdmV3c1d2L3VoUTIzbjkyWnR5?=
 =?utf-8?Q?+KgeumVN4iK9TWA8MWpwMUpW4+SLwdKhkZfGZYR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f03ae80-e40e-4489-8b9f-08d97f003e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 02:08:47.0597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rP5FMvyy4C7t1EdGbojcL6M7E2qOPd4gZNNMm9f/kSI/uuGrVsyf/qghdUmIT55pn6vgMdg3pm5BIGL35XNq2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8530
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjMsIDIwMjEgMTA6NDQg
UE0NCj4gVG86IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3Rh
Y2hAcGVuZ3V0cm9uaXguZGU7IGtpc2hvbkB0aS5jb207IHZrb3VsQGtlcm5lbC5vcmc7DQo+IGdh
bGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IGxpbnV4LXBo
eUBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkdC1iaW5kaW5nczogcGh5OiBw
aHktaW14OC1wY2llOiBBZGQgYmluZGluZyBmb3IgdGhlDQo+IHBhZCBtb2RlcyBvZiBpbXg4IHBj
aWUgcGh5DQo+IA0KPiBPbiBUaHUsIFNlcCAyMywgMjAyMSBhdCAxMjo1NiBBTSBSaWNoYXJkIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBrZXJu
ZWwub3JnPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyMywgMjAyMSAzOjI2IEFN
DQo+ID4gPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gQ2M6
IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGtpc2hvbkB0aS5jb207IHZrb3VsQGtlcm5lbC5vcmc7
DQo+ID4gPiBnYWxha0BrZXJuZWwuY3Jhc2hpbmcub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0K
PiA+ID4gbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPiA+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBk
bC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzRdIGR0LWJpbmRpbmdzOiBwaHk6IHBoeS1pbXg4LXBjaWU6IEFkZA0KPiA+ID4gYmluZGlu
ZyBmb3IgdGhlIHBhZCBtb2RlcyBvZiBpbXg4IHBjaWUgcGh5DQo+ID4gPg0KPiA+ID4gT24gRnJp
LCBTZXAgMTcsIDIwMjEgYXQgMTA6MzE6MDBBTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+
ID4gPiA+IEFkZCBiaW5kaW5nIGZvciByZWZlcmVuY2UgY2xvY2sgUEFEIG1vZGVzIG9mIHRoZSBp
Lk1YOCBQQ0llIFBIWS4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGluY2x1ZGUv
ZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaCB8IDE0ICsrKysrKysrKysrKysrDQo+ID4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaA0KPiA+ID4g
Pg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9waHkvcGh5LWlteDgt
cGNpZS5oDQo+ID4gPiBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaA0K
PiA+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LmZlMTk4YTBjYzEyYw0KPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+ICsrKyBiL2luY2x1
ZGUvZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaA0KPiA+ID4gPiBAQCAtMCwwICsxLDE0
IEBADQo+ID4gPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiA+
ID4NCj4gPiA+IFBlcmhhcHMgdGhpcyBzaG91bGQgbWF0Y2ggdGhlIGR0cyBmaWxlcyBsaWNlbnNl
Li4uDQo+ID4gPg0KPiA+IEhpIFJvYjoNCj4gPiBXaGF0J3MgdGhlIG1lYW5zIG9mIHRoZSAiZHRz
IGZpbGVzIGxpY2Vuc2UiPw0KPiANCj4gWW91IGluY2x1ZGUgdGhpcyBpbnRvIC5kdHMgZmlsZXMg
YW5kIHRob3NlIGFyZSBkdWFsIGxpY2Vuc2VkLiBUaGUgbGljZW5zZXMgc2hvdWxkDQo+IG1hdGNo
IChvciBiZSBjb21wYXRpYmxlKS4NCj4gDQpbUmljaGFyZCBaaHVdIFRoYW5rcyBhIGxvdC4gSSdt
IGNsZWFyIG5vdy4NCldvdWxkIGNoYW5nZSB0aGUgbGljZW5zZSB0byAiU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjArIiB0byBtYWtlIGl0IGNvbXBhdGlibGUgbGF0ZXIuDQoNCkJlc3Qg
UmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gPiBJJ20gbm90IGNsZWFyIHVuZGVyc3RhbmQgdGhhdC4N
Cj4gPiBJIGZvdW5kIHRoYXQgdGhlcmUgYXJlIGFsbW9zdCBzaW1pbGFyICIvKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiAqLyIgbGljZW5zZSBjb250YWluZWQgaW4gdGhlIGZp
bGVzIG9mIHRoZSAvaW5jbHVkZS9kdC1iaW5kaW5ncy9waHkgZm9sZGVyLg0KPiANCj4gWWVzLCBs
aWNlbnNlcyBhcmUgYSBtZXNzLiBCdXQgd2hhdCBvdGhlciBmaWxlcyBpbiBpbmNsdWRlL2R0LWJp
bmRpbmdzL3BoeSBoYXZlDQo+IGRvbid0IG1hdHRlci4gV2hlcmUgeW91IHVzZSB0aGlzIGZpbGUg
aXMgd2hhdCBtYXR0ZXJzLg0KPiANCj4gUm9iDQo=
