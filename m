Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42499390524
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhEYPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:22:28 -0400
Received: from mail-eopbgr1410113.outbound.protection.outlook.com ([40.107.141.113]:43419
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230306AbhEYPWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:22:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvteSDfyT7JqKtVKCKTWmpOSqp8fl8RXsdCWwO8Hqb9wlkAyMFXYnBOHsOrTWPBrYff+iYK5PuENgJSEDuUZsmJvqzKtI1ZUnC7IdATf8dNk1hwZU6Dfjy54VWyOPfSy2acuaKKi27iAr/S6Hglx+ViV58oY3LuA020ot4tvuPmq4EHQ+YHREPbgYqrN97S4S+IiMmOs4nS+ySZ2jTHKYOgwj4XzuYdtq1hSZKf1VeEu3w652IlgPJ4LfEszQ7WcapdQLjhv5to4rTyGoY55CsJgqwp6Fy+PyyxJMnNnnh4GQJKyVAO1/JNQ0Yhhl/1mTwG1FacEhZH7T3R8+m8r0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n1gxk6C4v6974RgQX6YUjnaSCL+4dJ9sXBmLcq9sJc=;
 b=aVDDsOjQ6/Aq5FXmEQCEobCQjSEDQmao6oI1DSEvqRh6hzGjk2W/svlQL4OGyoQc2WZ0pOdDL3FOAl9dxpS7q3FSqdo2kFFZ6KAiDW6eB2ntrirmjJSIiz6Y0Mcbc2aTJ5xNnYbPl52cIjCqaedzskEGQBvpGpoPc1IxJ3DJ1/LHCmgklaystidBZYM5RdpvntOZWR4FmsEeZW9fFBN0QBspPIxo4MouZjRNeL2nrzvucePRTH5vBNqNvmOsskNay/cL212OX6Q7dI4Ck9hhuoPBYX6FJ3cowGKBX1muyvXUqNqeZOoUPZzf2zyMD/xf8ZfYof3U20cBnd8h4ZGmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n1gxk6C4v6974RgQX6YUjnaSCL+4dJ9sXBmLcq9sJc=;
 b=o8S+IqFGrciZGPyABIahxg9MMr1VCTTWfHWLmrTPjTz3yHCdCtSjbOjf1TaIO0XE19ADGPubSpJ3oCxuHLEdaTyT3qxsl6uGgbcpfCEfzEYHUp04IL0+X5UGJUKcPg4gx0tCmfLerYI4MEuNBNBuppyAeQr2fbXwtKhC3/oqnxs=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSAPR01MB2020.jpnprd01.prod.outlook.com (2603:1096:603:19::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 15:20:51 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 15:20:51 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXOtSPoxM3P4fkKEmDrY8StfrCU6rqloqAgAnkEuA=
Date:   Tue, 25 May 2021 15:20:51 +0000
Message-ID: <OS3PR01MB6593170DE2814540F6C3F900BA259@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
 <20210519080807.GH805368@dell>
In-Reply-To: <20210519080807.GH805368@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee48e726-418e-4672-9b8e-08d91f90aedf
x-ms-traffictypediagnostic: OSAPR01MB2020:
x-microsoft-antispam-prvs: <OSAPR01MB2020BA04E28913A52CEA46AFBA259@OSAPR01MB2020.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fD9YctodoH921A7TlPdvQt4OAYZ9QUZZn6q3l7/K2P1bDRoxm6lpVIfW3fM098aw9CSLNYxeIQOytjIDBqtpnLaZM77j9ju8pP28tBQKaPQnVNbZZcsX4MFPbFlGvGJ8eE14HASzr3FlVWeWgnWph1T4PRv9oWLv+PdafmcynL4o+HH74Vzq2TV0CHy8mYgyoJNWg9eCYA3N38nL42YBnanP2ochooOiNqIbdh7AdlHsLhjnap4J/C3whX8ZOOlUL34yzVtmVllIxdkCUzwasxDhj/htnjFt3muKXqk1vhVklnQR8F5n3zEUe6Wn77tWiBtfcpjKSIFZ9u8obvYzztpACW71cI5D/rVEoOmzr/zBHPMOx+QdRSumc+zQ39KSibwdCSv9QOF9tMHEAo0glh2timlN5EBUc0PYP+RUNGhnoqPQCPOXpkAF52FcmxV6U3E8X2jYvtL/vx70P6t4+JZULj7YO/9pHBla4DnsFGNRdZBFM3P29+aheJFhmcb1wIg//JaR1xpp13TaCekrlYMxTjUv27cEXRZCFk/YB75zs3KE6YJqt3PQtCA6RM1l52K/8aa6/7roIA0pRdSRdJDyU3WzNDOsv0jszifBmZA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39850400004)(376002)(6506007)(66446008)(7696005)(86362001)(2906002)(33656002)(26005)(66476007)(122000001)(55016002)(64756008)(6916009)(5660300002)(52536014)(478600001)(38100700002)(4744005)(66556008)(71200400001)(4326008)(316002)(54906003)(9686003)(76116006)(8936002)(186003)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MFJ4NVBFQjYzUlV4VGVoMW9RS09FNDdJdDNLcjQ1aWR6aXBVT0FmN1BUVTI5?=
 =?utf-8?B?dlg2QzBaTDdNNjA5Wm5aNDMza3NwU2ZvYzBXNXBMZHZOR25ySGlHamxIVk1Y?=
 =?utf-8?B?djV3UTMwTFVpNEdXTjdoZjgzRjU1N0JsYnBVY2V4ajJjZ0NSeXlaWXVJQWJF?=
 =?utf-8?B?VjMvSUg3ckpDMGdJMFdjYVoyRUk2dEYxS1U4NGZLYVkwdmVlVThoNmNJYUJZ?=
 =?utf-8?B?VXI1ZXN1azRvMGNoSis4MXNsajR3bkU3Wm5PQm56di9pTTZ5dFVCVGNJWW9U?=
 =?utf-8?B?R2c3QmkxZHRTYkFQeFBlcTNPQVlxN0VVUlFoRlFRclhiaS9KdWlKR0xuNG5Q?=
 =?utf-8?B?STRLNkdOMVRzN0FzeG5La0cwbDFQRzRUZFdyRER6dEtZS2RTaDJVcTROVmZ0?=
 =?utf-8?B?R014dThSWkNhSHp6QjNxNnpkbkNVTHQxeDVkSUdPR25hNlR6clJvcXJydmN1?=
 =?utf-8?B?dlNVdGgyT3JpcXdqWEJpd0R6VzJxanlBVzR5YmxsN2ZRajliVXN3aWZ5aEFq?=
 =?utf-8?B?MW5QdmF2NVY4NEw5ODlmcU1yN2d5MG9tWEp1WlFhL21odzUvR250WFlSeDd2?=
 =?utf-8?B?Q3llK3FmUFg4VHErbGl6cFUvL3hqbVV0WW1DU1NKT1RvK0V5dTAzTUFOdk5C?=
 =?utf-8?B?VHF6RUlwUXJnU0Fsd2loS3AyVlcrd0kwbDZSblNvNllQZ25QZUVGYkxmazRl?=
 =?utf-8?B?U21HcjQxc2VBVE1IR0ZsVXVKZXBjWXBObittNnQycDUreHRrS0M5Y1JORGRX?=
 =?utf-8?B?Rm1yRFJ1TFhZMWV5cGMvT21OMHRvZUdMdnNlMWJrM1dzRlhxWGdOekh0M0k3?=
 =?utf-8?B?cFVTTXZFczVtaVVDdnRGeGZzcm5wSUVSeFdmZCsxSXJSM2hCSS94a0x6bmpm?=
 =?utf-8?B?ZERhOGRQTHhFR1FBMmFaKzZWYVZDT3ZSQVRaOW5KbUJHcVYzZEhSb0xmZk9n?=
 =?utf-8?B?eWh2aWZrWUJxbkFPRFR5MC9FcWNPcVl5RW02UGV2aFIxMWxpQ1JIMGkxUEtp?=
 =?utf-8?B?Q2FxaTN0Z29ML1hRbVEyOGtsSjY2YkczT1RSZlJMWWtSUlA2cit6YXVheTlY?=
 =?utf-8?B?RjVzcEdiMTkvUUVwUnZLdmROaVQ2Rm5ucmtiOGtQcXZaWURlMXBZUXhCZkxX?=
 =?utf-8?B?dkRBSHN2V3JNbGZwRXBva21ZRGREQzVubllpdWIyYTEvRVdYeHowWFJYSHV2?=
 =?utf-8?B?bjZQWjFtWUE5MFh2VmpKMXNxYkVvcUhFWTQvSFkzQnoyNTFraFBFendPYjVS?=
 =?utf-8?B?a2dJWEhtZm5tb1BPWWxnWkhaWXdYdFkwUTNYdHRmOU10WUR2TGRZTDQ2TWl5?=
 =?utf-8?B?WVNKcVRoVGZGR0VYUlNZQjd2Ry8zUHkrMEp1ZjY2N0I3a1RuR2RtT0puVjY2?=
 =?utf-8?B?d1BwT2ZoV0lONEprVzdCbkZQS3JDVysyT3lqelRsU2lCOGtzYnExV1puTUJB?=
 =?utf-8?B?UmJYMjU1emYrT0tYR3piMVpPM2t0L3lSQkl4aUZqdm1sMXoya2FZeDlOK0Rz?=
 =?utf-8?B?NkFETmxzTHNpM21kT0hXQmNFaWVJOTc2QmpHelNpRkVKWEFjTmdVMTNWS1Vq?=
 =?utf-8?B?REkvSUk1TnZlYTRPaW9jQkw4SlpkQlVXMDF2MHEwYmxONlV4R2xSaTRSWTk3?=
 =?utf-8?B?WGxNcGFqR1dNa2ZLc3o5WFNyRm5VSXc3eDU4Ny85WWkxSjhGYjB4SjNreTF0?=
 =?utf-8?B?UCtvc3UxemVPYWRyU2dBdUtDVXNXd1hxVmJFd3A5L3VDZTNNdnU5UDhlc0pX?=
 =?utf-8?Q?Lsisn+CzcGSrpb9XcT3ADy7kH/vg/Qk9o7A/P4/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee48e726-418e-4672-9b8e-08d91f90aedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 15:20:51.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ip4sWZfX2OaK2kZSOvx4H6ydKDS+eooyOQhjwRGhGL0RmRl9D3d8yKRmuvyNZGAn8l3xPCH9YcdTeat79zrcmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gPiArLyogQ3VycmVudCBtZmQgZGV2aWNlIGluZGV4ICovDQo+ID4gK3N0YXRpYyBhdG9t
aWNfdCByc211X25kZXZzID0gQVRPTUlDX0lOSVQoMCk7DQo+IA0KPiBDb3VudGluZy9pbmRleGlu
ZyB0aGlzIHdheSBpcyBnZW5lcmFsbHkgbm90IGdvb2QvcmVxdWlyZWQuDQo+IA0KDQpIaSBMZWUN
Cg0KU2luY2UgdGhlcmUgY291bGQgYmUgbW9yZSB0aGFuIG9uZSBkZXZpY2VzIGF0dGFjaGVkIHRv
IHRoZSBzeXN0ZW0sIEkgYW0gdXNpbmcgdGhpcyBjb3VudGVyIHRvIHRyYWNrIHRoZSBpbmRleCBv
ZiBlYWNoIGRldmljZS4NCkhvdyB3b3VsZCB5b3Ugc3VnZ2VzdCB0byBkbyBpdD8gVGhhbmtzDQoN
Ck1pbg0K
