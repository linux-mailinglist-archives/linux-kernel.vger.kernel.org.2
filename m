Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0598331E666
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 07:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhBRGnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 01:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBRGaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 01:30:22 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FBFC061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 22:29:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwvNgUmwaNdmdBg0Wwks2Quoscutch8ParZE81Mgnndq7jNo8AOuaM0SOubyS9uvrcxkV7FVsG3mEWPNIECzIEwMRgCEz590pKZFDt9zmjy8a77LBXfNT5r+kI2HC3VPUkIOwZnpP8VZ7/XVKq3YaAGP6Chr2InJVrI2fxb3Ku66+iETE2n9ZdzpgvlrE7uf6dUVlYMYxYAOzUlNuaqlfBq75t6QpSEwNSU/yc6hQA5UuOn8avDZ/YZDnplF1k4HtSv2QOqlAdCS+SoJ1HKlvUwAfDw2bXlALsXbQtMcII8+V6LKymLSk+Oyo6V22a9zqIWJ+ohDXk5ieYUMJCbQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T7h0q9aV6a8L7F+I0P+nc+uu9WI0vgpP18hjg0nKf4=;
 b=hFSckaXGu0wEB+Oc1aEA7MG3aXsQiqydq15eoR01HyuX+ogkuhWxEjPPXUIjjVo9+HW+U0YZZLvFl7+Vmmb9tTR6hqypYb7CTPwAuu3POzFShMXx5ccm1MvQy8Y1jwGT2waykW10b53JQnhMzmY1AbkRkeDOT/td5TGUmELnlUUWFzJTaCfXiknrAGDyJqlDhXuEjrZGGs8E+1MWRqV2MQyWygNL0UiWjdh3W7QRhsV2Ad43/OCVQ0gobqr+wRAVvx5qun1Ya9d8dMsgoenp4yadjYKXqf42/hZOmFdLHLR3hoV4I6sOq/UYlcYUr/HvgdDXu64zQXOKwBhueGC9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T7h0q9aV6a8L7F+I0P+nc+uu9WI0vgpP18hjg0nKf4=;
 b=bluvICe2rerf66ENa8PkKZCklTjjNBmnwP6NgeoQHxt/4xmou5SGk74IlFMFJM9gr8Ddr6VOgr7uHKmMIqxgFZjn+9HPruH+gHfmiS77B4RRlpX/xau8Sh1YZuhOSaN4nEWcjv2dyPWEEjr4d0N6n5XWmBy7LkC6k4GQxlu8Muw=
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Thu, 18 Feb
 2021 06:29:20 +0000
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::d4c5:ce2e:d24d:ac92]) by DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::d4c5:ce2e:d24d:ac92%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 06:29:20 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx8mp: Remove the none exist pcie clocks
Thread-Topic: [PATCH] clk: imx8mp: Remove the none exist pcie clocks
Thread-Index: AQHXBbwiq2vhk3rxB06ZCsyn6/vzeapdbUUwgAADLICAAAJ88A==
Date:   Thu, 18 Feb 2021 06:29:20 +0000
Message-ID: <DBBPR04MB7930DB4F7E5F5E0B8720B2DA87859@DBBPR04MB7930.eurprd04.prod.outlook.com>
References: <1613627654-29801-1-git-send-email-hongxing.zhu@nxp.com>
 <DBBPR04MB79308A7CE1800FCEC4042CCD87859@DBBPR04MB7930.eurprd04.prod.outlook.com>
 <AM6PR04MB5848D9A45282AC8FB2A218408C859@AM6PR04MB5848.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB5848D9A45282AC8FB2A218408C859@AM6PR04MB5848.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aff0290b-b470-4349-7130-08d8d3d68661
x-ms-traffictypediagnostic: DBAPR04MB7285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR04MB72851B8887DE9131EC7CC60787859@DBAPR04MB7285.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2kAgECB+0Wp3w5xvdcLXuw+da9kOSKR2ClN/Gjy22sBx7bpNvKEgkClIDfikYa5PX06DN5h6de6L4SEAqrvxX/8e+rnd/MXf3LGK6u15APUIfsbr6tPv+p+QIKr6xg+wE6k6pSeoNN73udRlPN+CanrVTB8T2h62kN/qL01BzFW/S3xoPUyXm4hkOTjoOZwAerXCgz8Lf7DNh0royg24alrp9U9kGbsv9jD+NyqKZZPotXW12LmMoV/IAvCBO/CNi31Dv8DY/oVCHBAflLbpFjo4V6bc/OlhLk5qwOxXYcRaQG36l0UTHOB6Wqw6gZu8O/z6F2FD6ZVZ5tvgbuZpC51dRlbn8K0xdw/08NxvqW8wBXtdH5SU+ypwEJDgikWe1rFrtcLKixVA17v0fIZcUWBX1IBwlXXjyMV8eX847dog6EVwvPJ0TgxV1HSvJMkSUeDE2G1Ef7ihgihKEZcZuXhgGVvI/jKTXo9dLWN0YZp8Erfm6p8VhsS4cBWbYCS+2co8DurHU7EjQNmvSqC9RAz8bbzJQCxM3M2o/HkAZgAYuspZwFuqLWRL/qgIA07
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7930.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(86362001)(33656002)(478600001)(110136005)(54906003)(8936002)(4326008)(26005)(186003)(71200400001)(55016002)(9686003)(76116006)(52536014)(7696005)(66446008)(53546011)(2906002)(316002)(66476007)(5660300002)(83380400001)(64756008)(66946007)(66556008)(8676002)(6506007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MnlGVm1IcE8vYUZLOWRLK21SK0xSQTdDK2paeFNPbDhVRzVBTGpKSGxpa0cz?=
 =?utf-8?B?TEpoa2pyK2psMUdoYkJpQmVacmRXQkZVWW9uTkpBYXdiUkVDeUQvQU1ZdCtJ?=
 =?utf-8?B?cGxjNlhtUFR0ZTJDV0VFSHhSaEhHMXJ0RGsycnBWd2dqOTRUTE93ajY4R2k5?=
 =?utf-8?B?TUVEMWwyTkg1Vkk2blZRUWlWeGNlcHhWcnZVVzhqekpiSHdvZW9BdmhJOU0v?=
 =?utf-8?B?L1cwYTNQMy82ekw2SVcxUUFZTzF2QTF6UFJMVFpZU05iTERSdVNuVm53WFRx?=
 =?utf-8?B?M05aRmtGaFR0cnBUV2JKZzFCTnpxKzlFMnFqNzBLVzRweE00eCtobkk0N09w?=
 =?utf-8?B?OFJYS2lBZVo4WTNzU0NTeDFUSWcvdFVaeTFtQjBaYjk4WGNXTFBoMmVtR3Fr?=
 =?utf-8?B?d1JySGhIY2pWREdJajFQNTZyMlhYWmdoc2hDd1lGUkdQTldrQnhYTDMvSld4?=
 =?utf-8?B?c2kvY0hoRUNTY1JzeEF3Sk9nWTR3QkE1Y0w1Wi9HWTRjSHVibGJKd2xaU3dT?=
 =?utf-8?B?UGMxWkM5ZnpmdWt1Z2FZRFJwRk05UnJSVmtwL3hOQ3RBcTVpbkZzUXJWZnB4?=
 =?utf-8?B?Q1RkL29mdVZIR0V4d0JNdkR4WkdCYkNWRzlNckZ5NWFVNjRKT1hqNXdwRnkw?=
 =?utf-8?B?d3hhbGd0a0hMSmNicW5WQ041K2Z6WWV4bHN6WEtEcktZUnREOVhWNzhLRkNV?=
 =?utf-8?B?bFg5cDdMcTR0QXJHSk0rclJCcUQ1UmZ1SnlCaWhEaFZFTGlHbW1ndUVnells?=
 =?utf-8?B?VDJWMk54NnNDYmlmZmU1SXlFdkdCZld5RFo4b1hWZ1pxWlgxeG9YbUMzVWk3?=
 =?utf-8?B?dVNQdlkrb1R5V1JIZ2YzOUs3OTVleXQxQjRPTFZPZGJXWUFyYTN0Skh2Q2tX?=
 =?utf-8?B?NWZPbGRNcGdHT2RWMzBaM3h3VTZoc1pSTkI1Y2E4dUhrMDlvemFEMTRpbzhC?=
 =?utf-8?B?WStPeTFrNXRkYU1POVJRYlcydFBSNUlFQU9DRkw0bU51MGZOWWFpVHFHU2dh?=
 =?utf-8?B?b2Zld3NaWVhvdU5yVk80cmI1NldydWU3TmJEVDNPeXJ4aS9VT3hXVnVwbVFy?=
 =?utf-8?B?c0d2T1FhZlV0azk1Znd6eEJjTDYwV3NiVmthdzZHS2ErdkxweGdtdlp6QTUz?=
 =?utf-8?B?VTRoTkd5aEx2WitOQ0lGOExEWFhaTWdlUms2Nm9yczBJTDhzczIvc2o0eXRx?=
 =?utf-8?B?aFdTWDZRN0F5TVZqSU5CUS8zTGVURnZxMkFWUWc4YWZwcmJ1dzU1L0RubXNr?=
 =?utf-8?B?TGc0cndvSWhHNnJDQW9PbjA0elZXRDBSZURNZ0ZZNm1wdGI5amRldllJeTZ1?=
 =?utf-8?B?MzJvczlGQnd4VW9McXRuRVN0V0NjN3ljMWdPcTZzZW8xUEIwZDV1dzhmTzVr?=
 =?utf-8?B?L2QzSnpQMkgvSXo3VVo3azhLOCtYQjc1NkVqM2M0NkxDSmJQRUU0SG0wcG1w?=
 =?utf-8?B?cVV5Mlc0YUIwT0JycDArUDdZb0ExcVRRVzQ5TnRsS1d0bFhoSWMyWDEzMHpW?=
 =?utf-8?B?R3BoQlVYMW1nZXQrekhOSm1WYldVKzdZaXBSY1YrTHF6Mk5KK1RLclFXOVJS?=
 =?utf-8?B?UkJrbDlLd1pibG9wbnFqZytJU0U4ZTZtaEdmcDlHbkZkaHR5UkZCaFdyOCt0?=
 =?utf-8?B?Z3IvY1Y1bGQwdDVscU9IblkrKzRSVnZRV1B6dEZFQ2U1dE5PeFF0b3dTUUlz?=
 =?utf-8?B?UUd3TzNmZmdtSGgrUlorMFRUT3pwdzVBNjBTaWpZaVR3R0VwYTRWMW9nd3JI?=
 =?utf-8?Q?rZHCJ/cPhsinhZHCuUHFNp0eToYNONzRrnuGLFj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7930.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff0290b-b470-4349-7130-08d8d3d68661
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 06:29:20.3352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LuXTM56zdUeozeXHeGf9tq07FomL9sSihiQpemTJ+OlZWiUdu2dXIfnRZWiqAGg/pgjrl1eAWbqWsAAPnkLtfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFpodQ0KPiBTZW50
OiBUaHVyc2RheSwgRmVicnVhcnkgMTgsIDIwMjEgMjoxOSBQTQ0KPiBUbzogSmFja3kgQmFpIDxw
aW5nLmJhaUBueHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENI
XSBjbGs6IGlteDhtcDogUmVtb3ZlIHRoZSBub25lIGV4aXN0IHBjaWUgY2xvY2tzDQo+IA0KPiAN
Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEphY2t5IEJhaSA8cGlu
Zy5iYWlAbnhwLmNvbT4NCj4gPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTgsIDIwMjEgMjox
MSBQTQ0KPiA+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBzaGF3bmd1
b0BrZXJuZWwub3JnDQo+ID4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0K
PiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
ID4gU3ViamVjdDogUkU6IFtQQVRDSF0gY2xrOiBpbXg4bXA6IFJlbW92ZSB0aGUgbm9uZSBleGlz
dCBwY2llIGNsb2Nrcw0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gRnJvbTogUmljaGFyZCBaaHUgW21haWx0bzpob25neGluZy56aHVAbnhwLmNvbV0NCj4gPiA+
IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAxOCwgMjAyMSAxOjU0IFBNDQo+ID4gPiBUbzogc2hh
d25ndW9Aa2VybmVsLm9yZzsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPg0KPiA+ID4gQ2M6
IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiA+ID4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogW1BB
VENIXSBjbGs6IGlteDhtcDogUmVtb3ZlIHRoZSBub25lIGV4aXN0IHBjaWUgY2xvY2tzDQo+ID4g
Pg0KPiA+ID4gSW4gdGhlIGkuTVg4TVAgUENJZSBkZXNpZ24sIHRoZSBQQ0llIFBIWSBSRUYgY2xv
Y2sgY29tZXMgZnJvbQ0KPiA+ID4gZXh0ZXJuYWwgT1NDIG9yIGludGVybmFsIHN5c3RlbSBQTEwu
IEl0IGlzIGNvbmZpZ3VyZWQgaW4gdGhlDQo+ID4gPiBJT01VWF9HUFIxNCByZWdpc3RlciBkaXJl
Y3RseSwgYW5kIGNhbid0IGJlIGNvbnRvbGxlZCBieSBDQ00gYXQgYWxsLg0KPiA+ID4gUmVtb3Zl
IHRoZSBQQ0lFIFBIWSBjbG9jayBmcm9tIGNsb2NrIGRyaXZlciB0byBjbGVhbiB1cCBjb2Rlcy4N
Cj4gPiA+IFRoZXJlIGlzIG9ubHkgb25lIFBDSWUgaW4gaS5NWDhNUCwgcmVtb3ZlIHRoZSBub25l
IGV4aXN0IHNlY29uZCBQQ0llDQo+ID4gPiByZWxhdGVkIGNsb2Nrcy4NCj4gPiA+DQo+ID4NCj4g
PiBBcyBTaGF3biBzdWdnZXN0ZWQgYmVmb3JlLCBpdCBpcyBiZXR0ZXIgdG8gcmVtb3ZlIHRoZSBj
b3JyZXNwb25kaW5nDQo+ID4gY2xvY2sgSUQgaW4gaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9p
bXg4bXAtY2xvY2suaA0KPiA+DQo+IFtSaWNoYXJkIFpodV0gVGhhbmtzIGZvciByZW1pbmRpbmcu
DQo+IElzIGl0IGZpbmUgdG8gbGVhdmUgdGhlIGhvbGVzIGluIHRoZSBJRCBkZWZpbml0aW9ucyBp
biB0aGUgaGVhZGVyIGZpbGUgaWYgdGhleSBhcmUNCj4gcmVtb3ZlZD8NCj4gDQoNCkkgdGhpbmsg
aXQgaXMgZmluZSwgbmVlZCBTaGF3biBjb21tZW50cyBtb3JlLg0KDQo+IEJlc3QgUmVnYXJkcw0K
PiBSaWNoYXJkIFpodQ0KPiA+IEJSDQo+ID4gSmFja3kgQmFpDQo+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+IFJldmlld2Vk
LWJ5OiBKYXNvbiBMaXUgPGphc29uLmh1aS5saXVAbnhwLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4g
IGRyaXZlcnMvY2xrL2lteC9jbGstaW14OG1wLmMgfCAxNSAtLS0tLS0tLS0tLS0tLS0NCj4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTUgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1wLmMNCj4gPiA+IGIvZHJpdmVycy9jbGsvaW14
L2Nsay1pbXg4bXAuYyBpbmRleCAyZjRlMWQ2NzRlMWMuLmFmYmViNmJmMTkwOQ0KPiA+ID4gMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC5jDQo+ID4gPiArKysg
Yi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC5jDQo+ID4gPiBAQCAtMTUyLDEwICsxNTIsNiBA
QCBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGlteDhtcF9jYW4yX3NlbHNbXSA9DQo+ID4gPiB7
Im9zY18yNG0iLCAic3lzX3BsbDJfMjAwbSIsICJzeXMNCj4gPiA+ICAJCQkJCQkic3lzX3BsbDFf
MTYwbSIsICJzeXNfcGxsMV84MDBtIiwNCj4gPiAic3lzX3BsbDNfb3V0IiwNCj4gPiA+ICAJCQkJ
CQkic3lzX3BsbDJfMjUwbSIsICJhdWRpb19wbGwyX291dCIsIH07DQo+ID4gPg0KPiA+ID4gLXN0
YXRpYyBjb25zdCBjaGFyICogY29uc3QgaW14OG1wX3BjaWVfcGh5X3NlbHNbXSA9IHsib3NjXzI0
bSIsDQo+ID4gPiAic3lzX3BsbDJfMTAwbSIsICJzeXNfcGxsMl81MDBtIiwNCj4gPiA+IC0JCQkJ
CQkgICAgImNsa19leHQxIiwgImNsa19leHQyIiwgImNsa19leHQzIiwNCj4gPiA+IC0JCQkJCQkg
ICAgImNsa19leHQ0IiwgInN5c19wbGwxXzQwMG0iLCB9Ow0KPiA+ID4gLQ0KPiA+ID4gIHN0YXRp
YyBjb25zdCBjaGFyICogY29uc3QgaW14OG1wX3BjaWVfYXV4X3NlbHNbXSA9IHsib3NjXzI0bSIs
DQo+ID4gPiAic3lzX3BsbDJfMjAwbSIsICJzeXNfcGxsMl81MG0iLA0KPiA+ID4gIAkJCQkJCSAg
ICAic3lzX3BsbDNfb3V0IiwgInN5c19wbGwyXzEwMG0iLA0KPiA+ICJzeXNfcGxsMV84MG0iLA0K
PiA+ID4gIAkJCQkJCSAgICAic3lzX3BsbDFfMTYwbSIsICJzeXNfcGxsMV8yMDBtIiwgfTsNCj4g
QEANCj4gPiA+IC0zODAsMTQgKzM3Niw2IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgaW14
OG1wX21lbXJlcGFpcl9zZWxzW10NCj4gPiA+ID0geyJvc2NfMjRtIiwgInN5c19wbGwyXzEwMG0i
LA0KPiA+ID4gIAkJCQkJCQkic3lzX3BsbDFfODAwbSIsICJzeXNfcGxsMl8xMDAwbSIsDQo+ID4g
InN5c19wbGwzX291dCIsDQo+ID4gPiAgCQkJCQkJCSJjbGtfZXh0MyIsICJhdWRpb19wbGwyX291
dCIsIH07DQo+ID4gPg0KPiA+ID4gLXN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgaW14OG1wX3Bj
aWUyX2N0cmxfc2Vsc1tdID0geyJvc2NfMjRtIiwNCj4gPiA+ICJzeXNfcGxsMl8yNTBtIiwgInN5
c19wbGwyXzIwMG0iLA0KPiA+ID4gLQkJCQkJCSAgICAgICJzeXNfcGxsMV8yNjZtIiwgInN5c19w
bGwxXzgwMG0iLA0KPiA+ID4gInN5c19wbGwyXzUwMG0iLA0KPiA+ID4gLQkJCQkJCSAgICAgICJz
eXNfcGxsMl8zMzNtIiwgInN5c19wbGwzX291dCIsIH07DQo+ID4gPiAtDQo+ID4gPiAtc3RhdGlj
IGNvbnN0IGNoYXIgKiBjb25zdCBpbXg4bXBfcGNpZTJfcGh5X3NlbHNbXSA9IHsib3NjXzI0bSIs
DQo+ID4gPiAic3lzX3BsbDJfMTAwbSIsICJzeXNfcGxsMl81MDBtIiwNCj4gPiA+IC0JCQkJCQkg
ICAgICJjbGtfZXh0MSIsICJjbGtfZXh0MiIsICJjbGtfZXh0MyIsDQo+ID4gPiAtCQkJCQkJICAg
ICAiY2xrX2V4dDQiLCAic3lzX3BsbDFfNDAwbSIsIH07DQo+ID4gPiAtDQo+ID4gPiAgc3RhdGlj
IGNvbnN0IGNoYXIgKiBjb25zdCBpbXg4bXBfbWVkaWFfbWlwaV90ZXN0X2J5dGVfc2Vsc1tdID0N
Cj4gPiA+IHsib3NjXzI0bSIsICJzeXNfcGxsMl8yMDBtIiwgInN5c19wbGwyXzUwbSIsDQo+ID4g
PiAgCQkJCQkJCQkic3lzX3BsbDNfb3V0IiwgInN5c19wbGwyXzEwMG0iLA0KPiA+ID4gIAkJCQkJ
CQkJInN5c19wbGwxXzgwbSIsICJzeXNfcGxsMV8xNjBtIiwNCj4gQEANCj4gPiA+IC01ODUsNyAr
NTczLDYgQEAgc3RhdGljIGludCBpbXg4bXBfY2xvY2tzX3Byb2JlKHN0cnVjdA0KPiA+ID4gcGxh
dGZvcm1fZGV2aWNlDQo+ID4gPiAqcGRldikNCj4gPiA+ICAJaHdzW0lNWDhNUF9DTEtfVlBVX0cy
XSA9DQo+IGlteDhtX2Nsa19od19jb21wb3NpdGUoInZwdV9nMiIsDQo+ID4gPiBpbXg4bXBfdnB1
X2cyX3NlbHMsIGNjbV9iYXNlICsgMHhhMTgwKTsNCj4gPiA+ICAJaHdzW0lNWDhNUF9DTEtfQ0FO
MV0gPSBpbXg4bV9jbGtfaHdfY29tcG9zaXRlKCJjYW4xIiwNCj4gPiA+IGlteDhtcF9jYW4xX3Nl
bHMsIGNjbV9iYXNlICsgMHhhMjAwKTsNCj4gPiA+ICAJaHdzW0lNWDhNUF9DTEtfQ0FOMl0gPSBp
bXg4bV9jbGtfaHdfY29tcG9zaXRlKCJjYW4yIiwNCj4gPiA+IGlteDhtcF9jYW4yX3NlbHMsIGNj
bV9iYXNlICsgMHhhMjgwKTsNCj4gPiA+IC0JaHdzW0lNWDhNUF9DTEtfUENJRV9QSFldID0gaW14
OG1fY2xrX2h3X2NvbXBvc2l0ZSgicGNpZV9waHkiLA0KPiA+ID4gaW14OG1wX3BjaWVfcGh5X3Nl
bHMsIGNjbV9iYXNlICsgMHhhMzgwKTsNCj4gPiA+ICAJaHdzW0lNWDhNUF9DTEtfUENJRV9BVVhd
ID0NCj4gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZSgicGNpZV9hdXgiLA0KPiA+ID4gaW14OG1wX3Bj
aWVfYXV4X3NlbHMsIGNjbV9iYXNlICsgMHhhNDAwKTsNCj4gPiA+ICAJaHdzW0lNWDhNUF9DTEtf
STJDNV0gPSBpbXg4bV9jbGtfaHdfY29tcG9zaXRlKCJpMmM1IiwNCj4gPiA+IGlteDhtcF9pMmM1
X3NlbHMsIGNjbV9iYXNlICsgMHhhNDgwKTsNCj4gPiA+ICAJaHdzW0lNWDhNUF9DTEtfSTJDNl0g
PSBpbXg4bV9jbGtfaHdfY29tcG9zaXRlKCJpMmM2IiwNCj4gPiA+IGlteDhtcF9pMmM2X3NlbHMs
IGNjbV9iYXNlICsgMHhhNTAwKTsgQEAgLTY0Myw4ICs2MzAsNiBAQCBzdGF0aWMgaW50DQo+ID4g
PiBpbXg4bXBfY2xvY2tzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
PiAgCWh3c1tJTVg4TVBfQ0xLX01FRElBX0NBTTJfUElYXSA9DQo+ID4gPiBpbXg4bV9jbGtfaHdf
Y29tcG9zaXRlKCJtZWRpYV9jYW0yX3BpeCIsDQo+ID4gPiBpbXg4bXBfbWVkaWFfY2FtMl9waXhf
c2VscywgY2NtX2Jhc2UgKyAweGJlODApOw0KPiA+ID4gIAlod3NbSU1YOE1QX0NMS19NRURJQV9M
REJdID0NCj4gPiA+IGlteDhtX2Nsa19od19jb21wb3NpdGUoIm1lZGlhX2xkYiIsIGlteDhtcF9t
ZWRpYV9sZGJfc2VscywNCj4gPiBjY21fYmFzZQ0KPiA+ID4gKyAweGJmMDApOw0KPiA+ID4gIAlo
d3NbSU1YOE1QX0NMS19NRU1SRVBBSVJdID0NCj4gPiA+IGlteDhtX2Nsa19od19jb21wb3NpdGVf
Y3JpdGljYWwoIm1lbV9yZXBhaXIiLA0KPiA+IGlteDhtcF9tZW1yZXBhaXJfc2VscywNCj4gPiA+
IGNjbV9iYXNlICsgMHhiZjgwKTsNCj4gPiA+IC0JaHdzW0lNWDhNUF9DTEtfUENJRTJfQ1RSTF0g
PQ0KPiA+ID4gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZSgicGNpZTJfY3RybCIsIGlteDhtcF9wY2ll
Ml9jdHJsX3NlbHMsDQo+ID4gPiBjY21fYmFzZQ0KPiA+ID4gKyAweGMwMDApOw0KPiA+ID4gLQlo
d3NbSU1YOE1QX0NMS19QQ0lFMl9QSFldID0NCj4gPiA+IGlteDhtX2Nsa19od19jb21wb3NpdGUo
InBjaWUyX3BoeSIsIGlteDhtcF9wY2llMl9waHlfc2VscywNCj4gPiBjY21fYmFzZQ0KPiA+ID4g
KyAweGMwODApOw0KPiA+ID4gIAlod3NbSU1YOE1QX0NMS19NRURJQV9NSVBJX1RFU1RfQllURV0g
PQ0KPiA+ID4gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZSgibWVkaWFfbWlwaV90ZXN0X2J5dGUiLA0K
PiA+ID4gaW14OG1wX21lZGlhX21pcGlfdGVzdF9ieXRlX3NlbHMsIGNjbV9iYXNlICsgMHhjMTAw
KTsNCj4gPiA+ICAJaHdzW0lNWDhNUF9DTEtfRUNTUEkzXSA9IGlteDhtX2Nsa19od19jb21wb3Np
dGUoImVjc3BpMyIsDQo+ID4gPiBpbXg4bXBfZWNzcGkzX3NlbHMsIGNjbV9iYXNlICsgMHhjMTgw
KTsNCj4gPiA+ICAJaHdzW0lNWDhNUF9DTEtfUERNXSA9IGlteDhtX2Nsa19od19jb21wb3NpdGUo
InBkbSIsDQo+ID4gaW14OG1wX3BkbV9zZWxzLA0KPiA+ID4gY2NtX2Jhc2UgKyAweGMyMDApOw0K
PiA+ID4gLS0NCj4gPiA+IDIuMTcuMQ0KDQo=
