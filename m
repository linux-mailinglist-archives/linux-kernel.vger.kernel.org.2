Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67533401B5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCRJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:16:18 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:10567
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229806AbhCRJQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MA2/KNjLh7bHX0GMtLUa0JyxEbEiRUfKzPpIECHYe62Yo5+dHRYBsp8pEoYNIaawYilvmJOFSQkpImZa/CO4RvRAO3uw38FypgM63CyyuouiZ4vrzPbzU2k13jhH0F3h3B+JRoBW5hW3R3P9chszX9rgn2OZhmHlOzJbLZTtMYgx6F01PlUe1wVHRBUJQKcyoGeyGSx8ZUpeKSkufttmNcsTOF6Oa155GzXgrfpEwu4gQY0LeR00F3xqaKGmjrsa0k4F5ydjpjs6jSf9EX3n8UNAh3ilw3WhR/2MaV9X0E22Z84HhTN2YzdoRE86BIQ0bbc16jTuUPfRdUEhOR102w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIJpte9Y0WKPzsEF8yOFu9B4THrwFZFjsJZItHlPElQ=;
 b=Xrv+FK+XOWdLrIKCwuddclRfPBvD70+BJYhrHFmAsHfG48J0rUzXjzDuohdh5Aed3hTDJNs/2TXQ3/j51fseydASVyokFngXN8B4aXh/HzIp/OAb4KD5khqhDZ9Ggkf4jAbdp6ThpTK0RwRUi9TfJHOOk5Gvvyfv1oQVs0arlqddNbaIrALUwUmOBOYnmtUWy7me2NW9CaUnc7BJRtHOXSGaaonECwI7uiKReH3UC7gH6cgTWz2SAn1bzaLMTw1IULlLyNWMib2krjhls2oehQN4KlsPfbNSuPCl9c987Q9dgMD6Ywe/H5jUswr7HBZjqJHdj7adNiu4HQ8ptD3R7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIJpte9Y0WKPzsEF8yOFu9B4THrwFZFjsJZItHlPElQ=;
 b=gGfnCVNHz5HqAY9M57gGrmrhijU/B7NSWzbj3RLhtu8/KEpy32GorPuwGNFXjWTzlignkSqZg8oSj7HrFq+KSMKlCTFJopxcYVrNQIOG6N6/STt0l0Xnfr/tv8ROxYCB/dawERYAzZlY3pvUtCL9jkXlFSnDs4pLqWPZjdxdrzU=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7705.eurprd04.prod.outlook.com (2603:10a6:10:209::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 09:16:09 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9598:ace0:4417:d1d5]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9598:ace0:4417:d1d5%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 09:16:09 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1] arm64: dts: imx8mp: fix FEC can't work when attached
 to generic phy driver
Thread-Topic: [PATCH V1] arm64: dts: imx8mp: fix FEC can't work when attached
 to generic phy driver
Thread-Index: AQHXEOsfGZoksDr6hU+Kq56FPsGR4KqJjLbw
Date:   Thu, 18 Mar 2021 09:16:09 +0000
Message-ID: <DB8PR04MB67953BE3A68D7703518DB63AE6699@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210304114013.18494-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20210304114013.18494-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5be10587-9a80-442b-fecb-08d8e9ee77fa
x-ms-traffictypediagnostic: DBBPR04MB7705:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB7705DDC02DFA4A1378A9F339E6699@DBBPR04MB7705.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSuuF2PtQlUXpFaqsTGd4e/3cgr5K0a0u5aP4tw8zkOQr3FktLE5tMt2jJMyfFOkccsEGcqD2YtbxcZQoOAdb4S7ezdEyQs0WGY6xsooZv96HRESclkhJbHjDuIZndnyG2HIeWubCNvzCH8HclEwJQ6Ij8FzkMYAcleAT9wggPjFuMqvVnvsIoYBbYqLeHO6ik/5oNRIP+bSSlFaxjrcJeFGycgMjbhA2F4hXhs/gNKZp2xEoGu2XKZHbqlQtk4tQG7cPtZNvrfjwbJicIdXnVmZnOyzm642PnKjUhwMeP+CqmEwh0BTdnrRjJA+R6EGzWGgLJ04qledhBAA9o8vhWJ7xL2Um06WhiTWZW8UJfd5q2A9jFkLuP3EV7DR5xI/FXerJkfmAdPSG4jj3CHsvU9EL9eqR4+QrsHXASm6ByZWYbQoWGcTZkNOquOLfClue8c1KmJM/WY8kMC7iVCCdo9OpPcdrRqhq5A3EFQPgPYEnxUqp6auEqqonRS+7zXTZk2W3F7mAFcYftJvs3D2v1FKf1wDAkmHVv4l/ac8rLQNHed94d34L+6Cla+LNR3POuwYMNo8PAsHhXB7ulGAyBJqetTUNHp7gzPvjF0pBHISq3Y2p8Kvv9dMpMbR+A5flM+ZtxEsVtdS71vMjoxeGDrFb9dsYjLqClOb7NfffBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(2906002)(186003)(4326008)(110136005)(7696005)(8936002)(316002)(5660300002)(66946007)(54906003)(52536014)(478600001)(9686003)(66556008)(71200400001)(66446008)(8676002)(53546011)(83380400001)(64756008)(33656002)(66476007)(6506007)(38100700001)(76116006)(55016002)(26005)(86362001)(41533002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?eDdrTGRWQit2QUlhMjNVcTVsVjI4Z0JDWVQ0cHI3QnJNWXR3b0RuTzBERjdD?=
 =?gb2312?B?bXdtVFQrbzZ6U09sMFVJeGhqdW5xdEJ1TjB5RG4yaStVMnJEUkFmNE5lMU5J?=
 =?gb2312?B?LzRVMnlMNUYxa2NZdTRBM0VPaGxlMU1ISC9aNjBMSmw0VzMyOHRSN1E4cFdF?=
 =?gb2312?B?a09od1FUZWtOai9xQU5nUmhtcVhUaHNxOFFkNFkzK1JqNktpMElqUzcxUXFR?=
 =?gb2312?B?VVVNNkpUaU5GSktLNjZSRSt6SmJxSno1RFJnczA0Qkp0d1BRR1FpdTFiZ3FP?=
 =?gb2312?B?MDFyKzF0djRaVURtQUtnc1g1Q09qdGxaSVZQY015T3JQSzJaM3BLN2wvUDhp?=
 =?gb2312?B?ZWJKcThwUjBzMC9ySmlzZGNqczBMejgzem45ZkRWUUxtN2hnRXhCMllxd1Fn?=
 =?gb2312?B?K0tqTEdtaFp5SURIUFlmMUZCbitJYmdtS1BsTFNDaitUa2ZvL1JFVVNhVDVQ?=
 =?gb2312?B?NE9maFhPa2NXMThaM0F2cWw2M2IwMStjYmczb3dwcVFLb3pGMzhRYVJTdUM0?=
 =?gb2312?B?M05iSGhzdzV5WnZsdUl6UTE3SDZRc2EvUHdxWm9WdnFrMk9mRTFTeDdldTg1?=
 =?gb2312?B?UG41a0hOcDlBQ2czLzhXblJ4K0VDOVkwK2RFZVVGenVvMHpJcmEzMTZITHUz?=
 =?gb2312?B?WVhVVHV1akkyaGNUKzFMRFF0WVdMRzNQZzFEbC85ODg3T3FXRUgrVkZtaHEz?=
 =?gb2312?B?R3ZVeXpxTnVITGMzbnpXMmVONHVPYWdJOTV2L3lDUXJsMGlSRnZrdXdZNVZX?=
 =?gb2312?B?akJ1c1JseFJhNUQ1MER5NU9hd0hEbUV3WUxJRUl3aW9XTC9WQ242OWMzL1JH?=
 =?gb2312?B?ZVF5QTRLZGYwd2NyejFnQXI1VktiOWVucmVCRGdaanVKaHpxSXhheGFlMERX?=
 =?gb2312?B?N0NadzdhWGJDSXU2U1BrditwY3VFNDhCME5PVkI2NmxUV2hKbUk3d3RDQVRx?=
 =?gb2312?B?TFVLeVRLeXc0QlAwSW8wZHBGNWpRRHRJRzNkRFJydUFtRjdtMVNpbHYvRzBB?=
 =?gb2312?B?L0FBUkg5dmk3RlJubEsxZ3F1eVNKdW9mR3hYMlhBVE1OTXloOGdIYmhXQmlx?=
 =?gb2312?B?d0FWTnVFYmJLUHdKMDdXaTJmQlZJbnJNZTAzaUcxQU5CTWtOWUJZUkQyMkhR?=
 =?gb2312?B?K0ZwVE4vOXVNVDNQT1o5SkN0NVRKNVVEUm12M084THpZZ2xSMytWYlVDLzBm?=
 =?gb2312?B?QndIZWFXNnJySGNjdGNEZFlYR0RlZ3hYempEN2QwcWJKWnhJcnQ4Wkx5ZE1H?=
 =?gb2312?B?clQwMXpsU2hWUHVGY1JKbzFsZEVwb0kza0x1NlZnejZhT0R2MlJ4VjdlTG84?=
 =?gb2312?B?U29RWTJ1T3d6cndrS2xKUHhFUDBITEJzVjQyTEhCaExDbGdCaEZQcWI0RFhQ?=
 =?gb2312?B?d1p4ZzlUU2ZyWjdaR2Fwa3FEbm11UjVRZ0k4UTJldm1uUjhIdVRZc1c2aExT?=
 =?gb2312?B?N3l0aVFndFZwMnc0WTdYTW14Kzlhc2xJOGVkM2pmcWFMZ0x2U3Y0VE9teElE?=
 =?gb2312?B?VWlKOEI2MXZjaGpaVHNyY1JuendxUE1iVHFuZ3gzR1JhSkZydU5ZZEVFcTBX?=
 =?gb2312?B?ZlpMODhTdVFHQkx6R21CUCtmd3lNOGd6RjF2NXJOQzhweUF1RER1bDVBOFIr?=
 =?gb2312?B?NjdEbWpHZmZ2WnJrYnl1MDVhYjFsNkNlMnVIa2cyMjA1K3ZSRnBhSzJpc3Fr?=
 =?gb2312?B?bUFSQ0lHYzNyWkk5WERrdVlhVk53bjdvcDVBV1dtM2ZwVktyRnZ1MmlYQnd1?=
 =?gb2312?Q?ZwSA3Rnl34kGOlp06aZKrpP9UHbhum2HwYWzfqI?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be10587-9a80-442b-fecb-08d8e9ee77fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 09:16:09.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61MwcvMfrvNA8ZvPJlketDx+sYFxCprLZIcK6vrs2gbca4VZsHN8EeDBq/ZgvEq5ol+auQ7QRxpG3VMtsUC7dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7705
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpLaW5kbHkgcGluZ2luZy4uLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2FraW0gWmhhbmcgPHFpYW5ncWlu
Zy56aGFuZ0BueHAuY29tPg0KPiBTZW50OiAyMDIxxOoz1MI0yNUgMTk6NDANCj4gVG86IHJvYmgr
ZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5k
ZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tDQo+IENjOiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRs
LWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCBWMV0gYXJtNjQ6IGR0czogaW14
OG1wOiBmaXggRkVDIGNhbid0IHdvcmsgd2hlbiBhdHRhY2hlZCB0bw0KPiBnZW5lcmljIHBoeSBk
cml2ZXINCj4gDQo+IFNvbWUgdXNlcnMgcmVwb3J0IHRoYXQgRkVDIGNhbid0IHdvcmsgb24gaS5N
WDhNUCBFVksgYm9hcmQsIGl0IGJyaW5ncw0KPiBpbmNvbnZlbmllbmNlLiBUaGUgcm9vdCBjYXVz
ZSBzaG91bGQgYmUgRkVDIGNvbnRyb2xsZXIgYXR0YWNoZWQgdG8gZ2VuZXJpYyBwaHkNCj4gZHJp
dmVyLCBhcyBSZWFsdGVrIHBoeSBkcml2ZXIgaXMgYnVpbHQgYXMgbW9kdWxlIGluIHRoZSBkZWZj
b25maWcgZmlsZQ0KPiAoQ09ORklHX1JFQUxURUtfUEhZPW0pLCBzbyBpdCBpcyB1bmF2YWlsYWJs
ZS4gSWYgcHJvdmlkZSAicmVzZXQtZ3Bpb3MiDQo+IHByb3BlcnR5LCBpdCB3aWxsIHJlc2V0IHBo
eSB3aGVuIHByb2JlZCwgYW5kIG5vIHdheSB0byByZS1jb25maWcgcGh5IHNpbmNlIHdlDQo+IHVz
ZSB0aGUgZ2VuZXJpYyBwaHkgZGlydmVyLCB3aGljaCBsZWFkcyBGRUMgY2FuJ3Qgd29yay4NCj4g
DQo+IFRoZXJlIGFyZSB0d28gd2F5cyB0byBsZXQgRkVDIHdvcms6DQo+IA0KPiAxLiBJZiB5b3Ug
d2FudCB0byB1c2UgZ2VuZXJpYyBwaHkgZGlydmVyLCBwbGVhc2UgZGVsZXRlICJyZXNldC1ncGlv
cyINCj4gcHJvcGVydHksIGtlZXAgcG93ZXItb24gc3RyYXBwaW5nIHBpbnMgY29uZmlndXJhdGlv
bnMuDQo+IA0KPiAyLiBJZiB5b3Ugd2FudCB0byB1c2UgUmVhbHRlayBwaHkgZHJpdmVyLCBwbGVh
c2UgYnVpbGRpbiBkcml2ZXINCj4gKENPTkZJR19SRUFMVEVLX1BIWT15KSwgYW5kIGhhZCBiZXR0
ZXIgYWRkIGFub3RoZXIgdHdvIHJlc2V0DQo+IHByb3BlcnRpZXM6DQo+IAlyZXNldC1hc3NlcnQt
dXMgPSA8MjAwMDA+Ow0KPiAJcmVzZXQtZGVhc3NlcnQtdXMgPSA8MTUwMDAwPjsNCj4gQWNjb3Jk
aW5nIHRvICBSVEw4MjExIHNlcmlhbHMgUEhZIGRhdGFzaGVldCwgZm9yIGEgY29tcGxldGUgUEhZ
IHJlc2V0LCByZXNldA0KPiBwaW4gbXVzdCBiZSBhc3NlcnRlZCBsb3cgZm9yIGF0IGxlYXN0IDEw
bXMgZm9yIGludGVybmFsIHJlZ3VsYXRvci4NCj4gV2FpdCBmb3IgYXQgbGVhc3QgNzJtcyAoZm9y
IGludGVybmFsIGNpcmN1aXRzIHNldHRsaW5nIHRpbWUpIGJlZm9yZSBhY2Nlc3NpbmcgdGhlDQo+
IFBIWSByZWdpc3Rlci4NCj4gDQo+IFRoaXMgcGF0Y2ggc2VsZWN0cyBtZXRob2QgMSwgc2luY2Ug
dXNlcnMgbWF5IHdhc3RlIHRpbWUgdG8gZmluZCBvdXQgRkVDIGZhaWx1cmUsDQo+IGluIG1vc3Qg
Y2FzZXMsIHRoZXkganVzdCB3YW50IHRvIHVzZSBuZXR3b3JraW5nIHRvIGRlYnVnIG90aGVyIG1v
ZHVsZXMuDQo+IA0KPiBGaXhzOiBjb21taXQgOWU4NDc2OTNjNmYzNCAoImFybTY0OiBkdHM6IGZy
ZWVzY2FsZTogQWRkIGkuTVg4TVAgRVZLIGJvYXJkDQo+IHN1cHBvcnQiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0KPiAtLS0NCj4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmsuZHRzIHwgMSAtDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmsuZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMNCj4gaW5kZXggN2RiNDI3M2NjODhiLi40ZjVjMmZi
MzNlZGEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cC1ldmsuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1l
dmsuZHRzDQo+IEBAIC05Nyw3ICs5Nyw2IEBADQo+ICAJCQljb21wYXRpYmxlID0gImV0aGVybmV0
LXBoeS1pZWVlODAyLjMtYzIyIjsNCj4gIAkJCXJlZyA9IDwxPjsNCj4gIAkJCWVlZS1icm9rZW4t
MTAwMHQ7DQo+IC0JCQlyZXNldC1ncGlvcyA9IDwmZ3BpbzQgMiBHUElPX0FDVElWRV9MT1c+Ow0K
PiAgCQl9Ow0KPiAgCX07DQo+ICB9Ow0KPiAtLQ0KPiAyLjE3LjENCg0K
