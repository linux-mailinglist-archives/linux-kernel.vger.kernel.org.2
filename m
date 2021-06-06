Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D2939CDE5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 09:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFFHeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 03:34:07 -0400
Received: from esa11.sap.c3s2.iphmx.com ([216.71.156.61]:51400 "EHLO
        esa11.sap.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFFHeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 03:34:04 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jun 2021 03:34:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sap.com; i=@sap.com; q=dns/txt; s=it-20200722;
  t=1622964736; x=1654500736;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=WnVYQMpZJsgPENynLXRNsB9a21zkxvmbONuYUc51PX8=;
  b=ecjD6Au+JfAKob6YuKKRaEjBm+1YtGMvmnAIsINzdlxP7fjKJUM4lE1a
   5cxtS1y3oCWqeICGW7MTSviON1pP+YJBNwCQfj8G3LN0z8DCOVliRfZrJ
   9DlQqSs2SnvTt4sQvn0SHibCCFJj3+QUYOVvutjF+tkwbRV2bDnczRocg
   isAMZtfuloKGf9LKrz1xqUNYAk0MAVbYNqxhlxRQTREILKGZQvYDckO6L
   6t6kB6jRv/8yJJhRVpa64t3jZFdtLVtgmX9isaw7dXlhQxR5akIgeaLDX
   HKxcgVzh95g37TAAAzXi/F8PcXiZ1VYJs2q7K7+/ToqyCDyedtMMZ/geb
   w==;
IronPort-SDR: czGleJ5pqpndb3Zqskv5tyG9jJDz4H28ZBxiQzjdEJY5tM6JjNUqFS1LrwcLmrueI/bTlvWDey
 5+hQJxBK86JMFJS6KHho7nLxVzomDO5nFVC0zKVgoCZRzPk5PhsmuNQgFvkcUh8Wb9ETnkoTpr
 0d6b9hvYRATewboM812xKpNo6u4mwgkiDcbXUzlQg4NnvwgBfpc29ck0m86sAQpAQWTw0Mj53w
 L3NlCrOmP6Ovr/Ief0GEqnzJkysjh5ktkhEnqw8nhePfgEtV+LoI4Lrfl2nEwVqrq7qsGRRqMj
 SfHMwXs7+pn0RRq58mnxvWxB
X-Amp-Result: SKIPPED(no attachment in message)
Received: from smtpgw02.mail.net.sap (HELO smtpgw.sap-ag.de) ([155.56.66.97])
  by esa11.sap.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 06 Jun 2021 09:25:06 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.174)
 by smtpgw02.mail.net.sap (155.56.66.97) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Sun, 6 Jun 2021 09:25:04 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D67ByXR9JvMLrnHW/tw5K3ltO12Yb2sHxpgQsf9RoIHcO2pRtvSNIM1edavIo6k2grr1YuNZX9S1Ya9ojrQ91z3fJ3ff1l1tabj89CNw2SEXvPdGTjWjRqjTpn0PTsqviiEazP1RvKGFgfSwEapqqW9cKJzLVdbuFe8/bC2pJJs9n62jqQLc21sIi6bTFAH479xKsvNbSFWsjcRIVdP33WL0kLGmLbbOAvGFZKVZLK77y2bAUuucBKJEz8zfoWyxCfhHHnQnLm0eF8fNBoWMx7AcrdC1aOfduXCKigBqD2cWs1/iRy7nLRkg5WAjJeJgtjDi2hp0OE/J+Zuiw2cMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnVYQMpZJsgPENynLXRNsB9a21zkxvmbONuYUc51PX8=;
 b=odKGaXwDwc4l5ZinY+J+bCgVZGnpdL+87ne5aXgll5ReL4zQ7HaEAOBPY3cdgweinjslH6dtjrssrAfPz2nrf+w2ksxwidonoLAs6aQ5ezUVe0i3pztWG5wQr5Loyxty83cYJ5BOkquX1k7t5sWUSzd7yO4Kbb6A/Yuj3GJvCPgJ3Wem+18HfD3V93bQr/qmc2z2BTm9aEJJdYcdUQ++cIurrHphCeAeKjThk7PWG7sw4guxNByyX/MSOoJ3uxoyNgPUiRd3POtJMhUOteWNUrfSA6lCs+bmuqDXKHonPxV0j3VBdElQ8HUNUDIvC/CVcaFAHwDAD5vO8mhXX/3HGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.onmicrosoft.com;
 s=selector2-sap-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnVYQMpZJsgPENynLXRNsB9a21zkxvmbONuYUc51PX8=;
 b=emfE2sJwvJlXXscrfVGPnMvvnkoJw4bFDxEKNJ9KkAPSb6UsfOoydg5sYh/pwhiNzmK1i13fQSP+KP+hEBUtwa5gMVbw2wjwWl8hKi/VuEJaEXieY8Pu9D8F5UFYOp+UnxkSEhKUvVN+EAQq5/MWsSo/ynyCSSO1LFXUjC10cDk=
Received: from AM0PR02MB5668.eurprd02.prod.outlook.com (2603:10a6:208:159::21)
 by AM4PR02MB3028.eurprd02.prod.outlook.com (2603:10a6:205:f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sun, 6 Jun
 2021 07:25:04 +0000
Received: from AM0PR02MB5668.eurprd02.prod.outlook.com
 ([fe80::ecd4:f127:8555:8c4b]) by AM0PR02MB5668.eurprd02.prod.outlook.com
 ([fe80::ecd4:f127:8555:8c4b%7]) with mapi id 15.20.4195.029; Sun, 6 Jun 2021
 07:25:04 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     SAP vSMP Linux Maintainer <linux.vsmp@sap.com>
Subject: [PATCH 2/2] MAINTAINERS: add entry for vsmp_64.c
Thread-Topic: [PATCH 2/2] MAINTAINERS: add entry for vsmp_64.c
Thread-Index: AddapPHXdoQkzL0sTweIODxkOUlOqQ==
Date:   Sun, 6 Jun 2021 07:25:04 +0000
Message-ID: <AM0PR02MB56682723C711D6ED55EBC57881399@AM0PR02MB5668.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [176.231.4.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71456c40-6caa-4270-9b3b-08d928bc3407
x-ms-traffictypediagnostic: AM4PR02MB3028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR02MB3028DA4BFE9B7D1C5F46CD5D81399@AM4PR02MB3028.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pyuUZ5R2hVdb8wZP+rIWtuL4hH/zW0aSIWnVZT+F0X2npaQBKsTZW+4o2xgYzc3Hk4PzE7HcKUsASaHcZTQTdu+lx1W1nb97eTldxOJVvl0hYrgp0MqqVtvaUdJGONYTwFcLOqNRDCT/kGRwhHD/HwJClPcZtVqnLF0w8vc2BplO2+pxXPV+uy/dfbe9PnecTHvt4JtjM0JjANSGP6dEFP1FGqTaOUa/QaJsiBaxaVVrPqNprOdHusKO/ir7McY/j0EW+ONtjFYzNwxT5vwWH79wPJW3mlidwYSXgjg/SVMMhxlPrsc0UyjVI0M0boFkRjlDgdWYfyl4Vz8IwUF7PfiRYdH+OqmETYKsNyGbk2izM2uBRQWnRS15o8p7vM1AVLhlmEETk4FUndE8JbctiupHiSfDsbLVF/UjDPC3hevMT4umc3ARrPFoDmCoUFooTNK6sGzxvfq9JC4iv1F87VRRSZKWIS1izOfoBhnGkIV8CKNcVzKGL72QccobVYdTbM0vu2pO5CoeTfxmFctV9jZ40mlqawA3zbx8yyveH69dYh6QsOTwuKj7+Az9QDw4WDcmVT3LfM/iq1lY0aYhI18nbeXGlX70G+k85uoHJ58=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5668.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(8676002)(6916009)(66946007)(52536014)(4744005)(64756008)(26005)(33656002)(66476007)(5660300002)(66446008)(86362001)(71200400001)(122000001)(76116006)(9686003)(7696005)(8936002)(55016002)(4326008)(2906002)(6506007)(316002)(38100700002)(186003)(478600001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0dQa3N0ZEN5UnJKdHRGUDJMeDFDcEkwRmlGcUVoOEREVUR3NERKajhabFdL?=
 =?utf-8?B?UHQrWmw1RTgxMVpGR0JpN1lEY083K2hxa2Jub0V4UlowbjVZSlB1SCtBRGtO?=
 =?utf-8?B?MlBBaUxFc0NFVS9rYWtvL05GRmF5NjRGSmVQNHUwNXphM1pzME10djF1TTJX?=
 =?utf-8?B?Ylp2Q21KUzJYOWUwckR3aWMxcHRhTnpWdnBoWkVaTk5yeEhXWTlIRjg0TmdK?=
 =?utf-8?B?MGIxV1VwVXhOd0o5S1U0dnh0THM2clRMMGx2U0FGekRoTGpNampCbWhWZVkr?=
 =?utf-8?B?WjBWNzBxRVhaUVNmOVV1SG5lTnMxVTBGa1BoNU90c0FiWUt1ci9QczlMZHo2?=
 =?utf-8?B?cy9qM1gyU2R1bmgzNmhEMmh1RDJDV3Erc0ZObkpUZ0hkK1pIZ2w3K3FMMlY0?=
 =?utf-8?B?OFo4YnQxcUltUUFGNWUvTmUxdytiTXI2RnArTEdIZXVQeDVTMjJYL0lUQXRj?=
 =?utf-8?B?M2dZc2o5dTM1dW53dVdqSTNtM2RZVVRpMFBVam9VTTFxcWJNa2xzWnFFQXhz?=
 =?utf-8?B?YWd4Q2lJMkdQWEVSSWV0MWltSW95Mkh4K3NucWduV2w2SURFcGxhb0FQZWp2?=
 =?utf-8?B?TExxT2RvSDJYTWlTSnNYeWZibDdiQUYxNXBSMEl2N1lPNzBPc0pNMjR5bzdy?=
 =?utf-8?B?ZzNKby9PQW95S1JhWFF4aUEvbU81TXA5a2NBcDdHYnh4dS8raXMvME1oOWc1?=
 =?utf-8?B?dGJGVDNTUHFGN3dlUnRDSGVhem8rNTd0WHFKSEFXQWhmWGxwSkVjQVVKLzVU?=
 =?utf-8?B?VVI4bG5SVE9Gd1djV2tCaHkxUWhiQ0tCeitDRnhRS1RnL0NGOWpwYWMvQ015?=
 =?utf-8?B?SkhPUDI4akc2OHRTdnJySEd5blJNYXBWZjRuV2UzMTB2emI3WWdSTUxXZEhU?=
 =?utf-8?B?emoyTFJzK3FVZE5rclJicnhXTXZ0YWJuV1FOd2w5Z3JUUHNUaVlaTjFwTUpY?=
 =?utf-8?B?azBGMUhaT2thTnVLR0dtQ2U5TE8vM3RkdlcwV0kvMmhNOEhYaEpOaWgvMUlE?=
 =?utf-8?B?Z2Q1c0JoTFhYU3p6U2RWdG01WXc3VHJUQStxYW1RN0hkSkdiM0YxTVNjSTdD?=
 =?utf-8?B?SEhxTDYwUnF3N0hYVXhENU45Mkxqc1ViQ2N1VWFEaW52T2FSRUsvSURjdmFv?=
 =?utf-8?B?Yy8vUis2OTBnZFFhRXQ5SXJHUjJKOURVYVQ0a3dUVTJNc0hZWCtWUWFRbUhZ?=
 =?utf-8?B?T3V2Z0xvV0dId3pBaytLbDFILzFDNW10NmI5dXZWUXNYQUVpdk9qa1Bia1di?=
 =?utf-8?B?WnJrR3Nqd0Yxb3QrVXpQUndsZkJjTTEzRFhVSFVHYmN4NkRKZld1cnRnSFJ0?=
 =?utf-8?B?Q0N1WlUxYi8vOWFSUTh6TzhRV2xDRGpPeHJ2M1o0UXRFUHFtZGpJbzNRZUhM?=
 =?utf-8?B?eGtvZE9Td1hjTFcyY0xpcTVXekphQlR3d0ljUU8rb0pjKzltZXVwaGVvYWNV?=
 =?utf-8?B?WmpiRFJYbmdmWGg0ODVtc1R3UG5ocUQ0ZEtRNmZmaSs1ZnpZcVh2S2pHZE8z?=
 =?utf-8?B?RUk1SmZIaExrZ1JTcmU3d0ZwajZReTFRN0haVGlPdVkraUxTT1hnMVg3QjJD?=
 =?utf-8?B?UTJDQ2p0cFNyZnJpS0xDMXJMSHRwNjE2TFFvRU9HYTJoNFFXcHpYSk04ZEY3?=
 =?utf-8?B?SHhtR1Jib0xadXVic2duUVJoY1RSYjg0U2F2SVgza3d2QWlLT1FEbVg4bzZ5?=
 =?utf-8?B?TEg0eXVCTVkzRTRFZW1RRzd2Mm1QNVhUZHNRQm1WeVlqaGdibXpNOU10QWtW?=
 =?utf-8?Q?ul3GyFg4MODS1PS9hnimp/aYxM0WQ8HqtbLC6+r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5668.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71456c40-6caa-4270-9b3b-08d928bc3407
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2021 07:25:04.0253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bn5gs1AZuU8/xQpHtbCNe2ZYiczCjztw8ndQXvdzcENiV8pIKCJGeUQedG6s8gHfPTUl4usCJi8aKJjb/6Z/aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR02MB3028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIG1pc3NpbmcgZW50cnkgZm9yIHZzbXBfNjQuYw0KDQpTaWduZWQtb2ZmLWJ5OiBFaWFsIEN6
ZXJ3YWNraSA8ZWlhbC5jemVyd2Fja2lAc2FwLmNvbT4NCi0tLQ0KIE1BSU5UQUlORVJTIHwgNiAr
KysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9N
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQppbmRleCA5NDg3MDYxNzRmYWUuLjI5YmMxZWI3ZjY3
ZCAxMDA2NDQNCi0tLSBhL01BSU5UQUlORVJTDQorKysgYi9NQUlOVEFJTkVSUw0KQEAgLTE5NTg3
LDYgKzE5NTg3LDEyIEBAIEY6ICAgICBEb2N1bWVudGF0aW9uL2NvcmUtYXBpL3ByaW50ay1mb3Jt
YXRzLnJzdA0KIEY6ICAgICBsaWIvdGVzdF9wcmludGYuYw0KIEY6ICAgICBsaWIvdnNwcmludGYu
Yw0KDQorVlNNUA0KK006ICAgICBFaWFsIEN6ZXJ3YWNraSA8ZWlhbC5jemVyd2Fja2lAc2FwLmNv
bT4NCitNOiAgICAgbGludXgtdnNtcEBzYXAuY29tDQorUzogICAgIE1haW50YWluZWQNCitGOiAg
ICAgYXJjaC94ODYva2VybmVsL3ZzbXBfNjQuYw0KKw0KIFZUMTIxMSBIQVJEV0FSRSBNT05JVE9S
IERSSVZFUg0KIE06ICAgICBKdWVyZyBIYWVmbGlnZXIgPGp1ZXJnaEBnbWFpbC5jb20+DQogTDog
ICAgIGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZw0KLS0NCjIuMzEuMQ0K
