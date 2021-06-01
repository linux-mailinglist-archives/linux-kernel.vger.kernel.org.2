Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4082839710A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhFAKNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:13:22 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:2624
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233299AbhFAKNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBRES9lvAAVy0pwKz1Hy4oQseEIkRAIoP+Mp9A9iIr0U4uNWCCoC2ZG3Ar3DVOOp6XvoMOPX4oFLMNtKXkpWheoMDOMQ7oALry1enQKh37jSlIftthxehSewzet8xjYIHM2FknnLgyEyT0Gul7ds61Mo3BzDQb6BAnCKwHpvyHA9CiDzSevX1lEjJInOrEf+3mBgmzGGw8gV0rOpm563y5fTqtGaSTu1tenyOxA74zcYq5FJSJ/5vrkIqwDmPzMS6Jt0AFKheP0YWbGkN4MJNdM0iDwsWJLVlpJGNjdMWGThlToS6i1YlA3QklWfbbV/f7meTV7gVT3IfNgnv+PGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YE38eMGQnBgapjWfj0lGug2mDaCmC3KXMvD9p64Jm8=;
 b=X2JdaeKyrwqoA9QADxJCQjcMdRt+eqGj5UrA0gEXWnCMbEFkqsJ6DhldOKSQUi7kLVAdmvPx4uwzlsEHJWp3+bm2kdFu8dP4LYtuNzjpFGXRwZsQ23og2wjlixyB3RePLszeASY56vEizIZd4YYjk/d/cU+90Wt0uh6tEC+ZjdMb0bick2tagzyvkk/UTIQwHl53WwaPDb0XRtJVDliz6D2+LGDhk66YGDpxZX0ZE0ynaZWqTquHNu2IgHXHnLK5eW/EvFgzkeKxzW73cCLTM4Qr2dKkpFygbEm7fg8zho+kiIPB71MJUMIPT4kDFlwUrzrOb6b0mXN6MhIWveeF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YE38eMGQnBgapjWfj0lGug2mDaCmC3KXMvD9p64Jm8=;
 b=o1HMmEG5fd9fbebEYvpU3DFIr9Vj3wMW6RC7piQdzx0Rtbv5zJ2LDOdjb1bdeNmCgsGMSDIRmbXzOE8UGxHIyhm4JCZH6lmj9ieaGZGpUpEG18ZzzMdTnMSbcrGEp5u9EPAk6zTtaZtJEmxSALQpVgFZdXKh3JGARP8hsv8tLDM=
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12)
 by DB8PR04MB6859.eurprd04.prod.outlook.com (2603:10a6:10:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 10:11:28 +0000
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::3921:acd6:3201:b209]) by DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::3921:acd6:3201:b209%4]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 10:11:28 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] soc: imx: gpc: add check for of_match_device in
 imx_gpc_old_dt_init
Thread-Topic: [PATCH -next] soc: imx: gpc: add check for of_match_device in
 imx_gpc_old_dt_init
Thread-Index: AQHXVswBX926mBH/CESBEOgCK4v1tqr+6uUw
Date:   Tue, 1 Jun 2021 10:11:28 +0000
Message-ID: <DBBPR04MB7930A304416458880D69E1C7873E9@DBBPR04MB7930.eurprd04.prod.outlook.com>
References: <20210601100256.70030-1-tongtiangen@huawei.com>
In-Reply-To: <20210601100256.70030-1-tongtiangen@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb70911b-2c8b-4a39-fcda-08d924e59f44
x-ms-traffictypediagnostic: DB8PR04MB6859:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6859F6688337C63D15C37388873E9@DB8PR04MB6859.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4Ct843yxPdKnMUd77ENgChgMNGeYelWuWQnKZ95WLOHXRzIHv2H2wdbZWTw2YLUjUNdaSuG/VqVwVhf7igV+IH4Fov3fN5Q7zQW62k+yQTjEkUVBB4yB13uXGT9POXc6ojQazTISbBfFmDIS50Oz6L18nh8OcQbev15/hFJnEcz/9sPfmS1+crOziZ++a2/0cqsWDLBIRMh0OQhNTxHYkzLN/56MLi8OvokJxsQSqvC0TdcACmrZjdpOLPfuHIJ9EiAWBwdjVprzRiCdOS2ZPWUETbKRJqal4VFR9Su+Fa4KOtFoc/88UlMEh6ZqqPIEiDYBsTmELAHOPX+V/bsW7qQ643l+u5mYQlvA2Ei/Tpe4vgrI5IieSxR9U1u0wWmd6D+s7xhSIeR8/y3EQfhPWLxvTexlFfOKxuNnP4CDD+g5CLE3+/Tn2cZnNkkK4BxLd6saG79JNfL+U1uYdYYoWbnJQ/Z60oSouyErAfSbcZ7zuqlWjx610QbBElDTE2fb1l1nZB2TFdFpD8JKvcbr9pPen2qJA6ECGiGUxN1Vc0C1IgCRhlPJ9FGkSwoJgf9TYHQJ7p5HgAqSwCN86dR2D9FDb5hCoZ8FOEXEAajCJ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7930.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(86362001)(64756008)(66476007)(66556008)(52536014)(122000001)(66446008)(83380400001)(54906003)(8676002)(38100700002)(6636002)(4326008)(76116006)(26005)(66946007)(71200400001)(6506007)(5660300002)(33656002)(9686003)(7696005)(498600001)(8936002)(55016002)(186003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bERSejNGMCt6OTh2WEhOU1dlVHg0bzlJSDdsWnFseWxYdWJJa01USW02TThP?=
 =?utf-8?B?ZUlGN3M0eStJdk1rRk55MWxyR2FFWkRndkVMZFh6NWMwWnZqZGZUT1EvME5Y?=
 =?utf-8?B?QVNYVmVjRjZ6aGY3WEFCQVdlUTBEb1VsTVVyMW0zalVmdUlWcitWWDdKTVN6?=
 =?utf-8?B?Y2NLRUQveEJmMCtlbzd6OUZnNG9pU1NiSEkwQ2Z6UU9PTnR3TStVajg0bVpI?=
 =?utf-8?B?UVM3Q3hkVWt4OWJjb2FqRER3TXBOM2ZkVFlLQ0w0c2g4eGo4aitvT3hwcmg3?=
 =?utf-8?B?NmF3bVE4THFlMkR6QWc1TUNpd05yVlhza0F5Rk1vOVVlRjF0N3JlRDdndjUw?=
 =?utf-8?B?aC9FQ2VFNVJIc2NuV1hXMnk4dThhdTh5Q1ZXYUloUUdRem5tb0Zjb1VPdnl1?=
 =?utf-8?B?R3FYNGJqRzVEbCsvbkZicmNIWW1xNnlzeU1rdXA1MnNwVnJmTFV5Znd3K0JK?=
 =?utf-8?B?SXI1cXZBajZhZ0RaNnV6TFJmMGxSd1pMNHdERFZLV3hlM2o1K21vVTV5VUow?=
 =?utf-8?B?c2t3QThUWnhlZFg0YUJmdkt0RlRlTHV2eDVOSEFDTkJaRW9hQTFvSGwvc3d2?=
 =?utf-8?B?Y0xyU0txNGN5N2JUSW1FOTNxOW1LeGw3NkhVc0FXZ1owZGtldXBhRXZvTE9U?=
 =?utf-8?B?RnVnRnliSWQ1dzBKQ01IRkg3bkNEaExLblprdFNVMTEyUnZTekpNWmkxcTVq?=
 =?utf-8?B?cUNQajNaZUJuUU5BMTNOcEVaaFdEYVllSmJKRWxUTEdrTG9TdWtTTVJOd3Yw?=
 =?utf-8?B?MDN5d0dWenN5M3JoKzFKV1JnOHhnNG10Mk1veUR5YU1aVzdlL2Z3Wnp2eW9v?=
 =?utf-8?B?OGlwQlQybEFMT2JCZW9RWXo2bW1iOUJZeSsxdzJHWk9pazhIWWRtUVQ3UXo5?=
 =?utf-8?B?ZW9YbEQ2RTI3b0NtOEFwVnRLNDJJOWFTWEhIL0ttN29TdkRsU2VTaVFzNUJz?=
 =?utf-8?B?TEp1S0dja3pBbzM5Qys2emRENUZLNzVRQWxrNzFTS205MTdHd0VsQS9pVmw0?=
 =?utf-8?B?MVhXR2lTQlR0K1NSRVRZaE0yVi80bmJMZjdkNWpZWExXcTQ3S2cxU2lzb0ha?=
 =?utf-8?B?aEVBVlhLVytSWmN3bTh3OFZBZHZYSEhqRkovK2dnY1NJTGwvMXhXWnJHZ0d0?=
 =?utf-8?B?cDI3MUhXTXFtZnhwR0NsMnB5UUhrV2NRM1NYcTc3M3pTdHpqRngwMU1qUmhK?=
 =?utf-8?B?emh5SHhzYXFKNkFGV016TkNDRE5BNStraDlpMGllcW4xS1RORUNXeE5Cb0ls?=
 =?utf-8?B?MHdpN05sSHVZdFRjQU0zelc4bnlrK29RMGhxR05ZT0tHS3dVTjhtdDVIZlJU?=
 =?utf-8?B?ZHpDbHZldldqYnkrTVdxbmFkNWFYK0xJbnNvNElMNGtEemVDL2tmclBVY3hL?=
 =?utf-8?B?T0JlbWFQaFoyYmZSdlZnY0xja1pGbG51K05GWXpUS3c3bGRDYmJHTHZUZ3Fp?=
 =?utf-8?B?enkvUzNWUUt2MSs1ZVIxUTlBM0dPV3hjcTk3cmxoMFlXTjBIdEhLdlNkRUxX?=
 =?utf-8?B?dk1Hb0Y1cFpsWFNhcHBvaHhuSHJ3ZWRobTcvVUlqaXJ4ajhSeE9VeW1IR3ps?=
 =?utf-8?B?blBEaXRqT0k0TTFRVnd2SGJJbUtjYTBiOWk5OUtiU0ErbjBncllWN1RIdzc0?=
 =?utf-8?B?TUdzRGJ2K1lUbDhNMGlia2lGUXdWSlpVcFhWcUNtbWhPNitTZGRwa1NpeHRX?=
 =?utf-8?B?akY0YWxTdWhMVnRJNHRlaXNESDBOVXBCWWpCaVpzUTFGQmFtUDBWbkJVYXRo?=
 =?utf-8?Q?yXlmuYYZ+/OuubTB1X5hxkty5mnHeVmUAJQ3sTm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7930.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb70911b-2c8b-4a39-fcda-08d924e59f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 10:11:28.6232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCej1XmN2PQJfSolxaYZHX0vKsHZ00erhNobSJ9xo4OfR4aqICKUkWemv0iFI+SGrxSVmn15OV5VoV7z2SSOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6859
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0ggLW5leHRdIHNvYzogaW14OiBncGM6IGFkZCBjaGVjayBmb3Igb2Zf
bWF0Y2hfZGV2aWNlIGluDQo+IGlteF9ncGNfb2xkX2R0X2luaXQNCj4gDQo+IEFkZCBjaGVjayBm
b3Igb2ZfbWF0Y2hfZGV2aWNlIGluIGlteF9ncGNfb2xkX2R0X2luaXQgdG8gYXZvaWQgcG90ZW50
aWFsDQo+IE5VTEwgZGVyZWZlcmVuY2Ugb2Ygb2ZfaWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBU
b25nIFRpYW5nZW4gPHRvbmd0aWFuZ2VuQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9z
b2MvaW14L2dwYy5jIHwgMTcgKysrKysrKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc29jL2lteC9ncGMuYyBiL2RyaXZlcnMvc29jL2lteC9ncGMuYyBpbmRleA0KPiA5MGE4YjJj
MDY3NmYuLjAxN2E1ZTJiZDRlNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvaW14L2dwYy5j
DQo+ICsrKyBiL2RyaXZlcnMvc29jL2lteC9ncGMuYw0KPiBAQCAtNDAzLDE0ICs0MDMsMjUgQEAg
c3RhdGljIGludCBpbXhfZ3BjX29sZF9kdF9pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gc3Ry
dWN0IHJlZ21hcCAqcmVnbWFwLA0KPiANCj4gIHN0YXRpYyBpbnQgaW14X2dwY19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSAgew0KPiAtCWNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgKm9mX2lkID0NCj4gLQkJCW9mX21hdGNoX2RldmljZShpbXhfZ3BjX2R0X2lkcywgJnBkZXYt
PmRldik7DQo+IC0JY29uc3Qgc3RydWN0IGlteF9ncGNfZHRfZGF0YSAqb2ZfaWRfZGF0YSA9IG9m
X2lkLT5kYXRhOw0KPiArCWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm9mX2lkOw0KPiArCWNv
bnN0IHN0cnVjdCBpbXhfZ3BjX2R0X2RhdGEgKm9mX2lkX2RhdGE7DQo+ICAJc3RydWN0IGRldmlj
ZV9ub2RlICpwZ2Nfbm9kZTsNCj4gIAlzdHJ1Y3QgcmVnbWFwICpyZWdtYXA7DQo+ICAJdm9pZCBf
X2lvbWVtICpiYXNlOw0KPiAgCWludCByZXQ7DQo+IA0KPiArCW9mX2lkID0gb2ZfbWF0Y2hfZGV2
aWNlKGlteF9ncGNfZHRfaWRzLCAmcGRldi0+ZGV2KTsNCj4gKwlpZiAoIW9mX2lkKSB7DQo+ICsJ
CWRldl9lcnIoJnBkZXYtPmRldiwgIk9GIGlkIG1pc3NpbmdcbiIpOw0KPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gKwl9DQo+ICsNCj4gKwlvZl9pZF9kYXRhID0gb2ZfaWQtPmRhdGE7DQo+ICsJaWYg
KCFvZl9pZF9kYXRhKSB7DQo+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIk9GIGlkIGRhdGEgbWlz
c2luZ1xuIik7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKw0KDQpJIHRoaW5rIHRo
ZXJlIGlzIG5vIGNoYW5jZSB0byBwYXNzICdpbnZhbGlkIG9mX2lkJyBhbmQgJ29mX2lkX2RhdGEn
IHRvIHRoZSBwcm9iZSBmdW5jdGlvbi4NClN1Y2ggY2hlY2sgc2VlbXMgbm90IHJlYWxseSBuZWNl
c3NhcnkuDQoNCkJSDQpKYWNreSBCYWkNCg0KPiAgCXBnY19ub2RlID0gb2ZfZ2V0X2NoaWxkX2J5
X25hbWUocGRldi0+ZGV2Lm9mX25vZGUsICJwZ2MiKTsNCj4gDQo+ICAJLyogYmFpbCBvdXQgaWYg
RFQgdG9vIG9sZCBhbmQgZG9lc24ndCBwcm92aWRlIHRoZSBuZWNlc3NhcnkgaW5mbyAqLw0KPiAt
LQ0KPiAyLjE4LjAuaHVhd2VpLjI1DQoNCg==
