Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8234B39CDE4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 09:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhFFHeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 03:34:04 -0400
Received: from esa10.sap.c3s2.iphmx.com ([68.232.156.179]:3295 "EHLO
        esa10.sap.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFHeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 03:34:03 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jun 2021 03:34:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sap.com; i=@sap.com; q=dns/txt; s=it-20200722;
  t=1622964734; x=1654500734;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=1v0+I1B8Yhey5nHE2QRf6q/VtAIGOi960BV/PsjHhwc=;
  b=XnXd5KmfWXhTrkH/WFzdW+doDVJQ/K2w4h+NdtTW/cG0UwQwFlFxSN0c
   l7F4A9wKvpb1rKQz9wUOUb8sLoByMcHLDISz1+A1pCYPE6XaXxIV7a649
   cjG0GmhgnoMEokCQkGCBN0p+BpItgeJXiRbYW25OMWpcUGxrlrQVYqK8u
   7CvSvxPGzMjXSqNiasgLsU08N4LV0/q0wRtYR+JWrzgYxL8ir/ajETKGN
   qkGabo+uv8MSFgWyzCnHYkpLi/Aa7vNgycCLSVJNFwL97gRqoby3NSWjh
   CQTLFx+dhCOlZ8ecMsNLHpFFjVsc7iqAKjRGWkYlU7sdzwIBlcIMsUoAL
   g==;
IronPort-SDR: zOXpo7svUbwDo3eN4ctM5vm1ASCUZaU0PTJpxYF2OCgJgHqV3oR3KGt6QtDhKIOrY/SgGsAa2c
 Y/UlJMkkXyXVB+fi4E37GRTFZxt+C/va76t1d8+gYWiemXaaXpFnjH+G5zXgaxFJNWOElLycdU
 3fG2AB6sT9igZ3Fdwt013dwLZNC+CQg7Tx4smUpP+3CB9n6eF8t0Y87uBq2PfDcGHOeak4D8ys
 ti5G1WTO+Pd0GPwJNbg5aAtiGlDjJyr+Xrioxt5PZlGvDfG0YyT33xTGmMBY6j1O4jqIFgAKuZ
 6OuU0b9GkbGeyvfH3vhoX3FF
X-Amp-Result: SKIPPED(no attachment in message)
Received: from smtpgw02.mail.net.sap (HELO smtpgw.sap-ag.de) ([155.56.66.97])
  by esa10.sap.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 06 Jun 2021 09:25:04 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.171)
 by smtpgw02.mail.net.sap (155.56.66.97) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Sun, 6 Jun 2021 09:25:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUy/6s8Cm2qrzFI0Ucmct40QfKPJFrDzWvCWan1wHC/dxcfqE706pGM9DnARaKI+JzzUUXNkdT7TcvWr+dtgxKA16BS9PWwb9N0AaQ7Ty1miIGuMHOGVPQ4UZx0okIa6eJC/Qsjk25wB5IOJXbKe0JDoxJJqr67Ywa6+puCfNWrq2YYSy2IeJ7+ggall1iZyBXQjAaqFCayrGfFwEHoMKBaTQ/zMhXAvcXmdPO+VDvsD6k2g0mQtsyoXVcSXMihp55Gqu4A2X4cZcxYIpO9uqS76G8EZu2PbpfaqV88fCYoFSIoKxx4ghTcn8FZAh7AQZDfYw99ot9qMcUcaxZ66Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v0+I1B8Yhey5nHE2QRf6q/VtAIGOi960BV/PsjHhwc=;
 b=M20Mx3npkRm9JNGYMDO/ih6khPHPhePUsy84chlLmlFV/uOgUrVWwWiofn4sf4tf6NwqUVYSvQhxiEsEGge6A1/v+bsu2lQG6OVsUtRMCEjZkvhP1KsDO1OqN/XuNJ8RYCTn6Txg2ZKb3Zz9JsHwBMiRA/Z80bOA2ehUQDFgvyO6gUtjNA/r/UHwZ79BN7bsPUyP3kAkQDUkpc535ruS18BqlvuOeR6MCstuE5KMf8IG+ErIO1yK9rMP9i889/+2jtjpy4qSAgwOcV+/WB1kO2GxtoGV4mwwIh7C6dIJFLwt12kEkBU/2ydSi2B1qMeYASwLpKrpPMrpUJ0DQYZyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.onmicrosoft.com;
 s=selector2-sap-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v0+I1B8Yhey5nHE2QRf6q/VtAIGOi960BV/PsjHhwc=;
 b=OSCSpgdHDsdosORTJ9XEUjVAglanEKIdW/GCxq2P6xPGKtpDqujm4/QSupYCfZaIWV4Jr5AK9MCYYtA59XvdUmaAYGU0oBpHzbAfPCjkBhuz++awaosQeSyKoxRzdaExYV0wfh9aOQASSMmAOhC+iP1TCcqGJfMeW96tWmXb6s8=
Received: from AM0PR02MB5668.eurprd02.prod.outlook.com (2603:10a6:208:159::21)
 by AM4PR02MB3028.eurprd02.prod.outlook.com (2603:10a6:205:f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sun, 6 Jun
 2021 07:25:02 +0000
Received: from AM0PR02MB5668.eurprd02.prod.outlook.com
 ([fe80::ecd4:f127:8555:8c4b]) by AM0PR02MB5668.eurprd02.prod.outlook.com
 ([fe80::ecd4:f127:8555:8c4b%7]) with mapi id 15.20.4195.029; Sun, 6 Jun 2021
 07:25:02 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     SAP vSMP Linux Maintainer <linux.vsmp@sap.com>
Subject: [PATCH 1/2] vsmp_64: change ownership
Thread-Topic: [PATCH 1/2] vsmp_64: change ownership
Thread-Index: AddapG4OXXzX0NGmTLahlslWwNMXzQ==
Date:   Sun, 6 Jun 2021 07:25:01 +0000
Message-ID: <AM0PR02MB56685F1C8190E0993003C60A81399@AM0PR02MB5668.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [176.231.4.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a62c28df-c079-4159-0c9c-08d928bc32d0
x-ms-traffictypediagnostic: AM4PR02MB3028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR02MB3028C343990842BAB6EBE3E981399@AM4PR02MB3028.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTrvnr70WP0ma4NiPPNw8SqAt+TGYUvwLqrZlpzge0TXs/JTSVoKwkLD+sSGbp3xDFHvl0nub9n+rYHqIuOR1c00k1CcKWAvoQFwfUcgcAlbx6inbwh08APS8LdS6MjftS+mT2uzmYIL94iZs7zrPs9JwviWK+Zz91LwEQYZvSxi1bfOI9B1Z0BwE+iKygALYE3Ob+5amMuv8UDpIfKj1NxWqqsbAVfwEbnqHOCxdTkWZF8M2nH0wsuEFTSmJfpETU22ZPZchM2cw7xFctvCJSt7nnPSic8wQkqxWe3Mnr/ijoF9+lXR4H3ZQj5iLng3UP32gocQU3lFh9Vq5gy7Q9uXuF1fFtAC5x7Z5/kJ6YBf92ednWmzihFm3aINkBaP2gevu3W8YEqgna9cAfMk1rk5y+pq+kVoejtvujx9kAeFvtCDydvhD9ex2lcaocFgAwPaQbO518iBh4/f0ELDbEK9PkfkaUrmj/S15ngqFWPK2SW/G8tkfdKreWweRLeUIrCxv4Ui5E+IcxBxjUiYDeT09U77VGqBmuee3Ayxjz4plc0Tag0DqgYSWYGX1i8fypOXe9oX4D+zsK6dqrLgGJX1Rf2sFKCeIeIKNTG6VkA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5668.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(8676002)(6916009)(66946007)(52536014)(4744005)(83380400001)(64756008)(26005)(33656002)(66476007)(5660300002)(66446008)(86362001)(71200400001)(122000001)(76116006)(9686003)(7696005)(8936002)(55016002)(4326008)(2906002)(6506007)(316002)(38100700002)(186003)(478600001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXM5QUY1UG5VWktsQm9uU2ozMEZFUUt2ZmdMNmJSQ0xLMXUxMmlhY0JFNk5m?=
 =?utf-8?B?QVFVVmpzNWt0bUlkU1hPNlNiWDM2bFA3Yi8rN3JvWE5IdmNyZGg1dXdwemVs?=
 =?utf-8?B?Nmk0dnNrdlFSSkV4eGZ6bTVWMnZUOGZ0SHFLTHJqYlR1d255QnNIUGNIVVVL?=
 =?utf-8?B?OWZ5Mmx3Q21PTGZhQXF3ejE0MEZRNUZML3dCU1RmMUpNZGxJeTBTS2RDRC91?=
 =?utf-8?B?QVN1ZEg4ajlFaVBlVDMxSW1CUFVQTDZERGxUT0JwRkFIM3JDZUJ5eE9lODk2?=
 =?utf-8?B?MUkveHA3aStucWtWdmR6TE9ZSmkyNStnK3kxZitkeDM3L2RCY0xxYUpPallS?=
 =?utf-8?B?dS8xd0J5dVJpMjNKWkhhY0pTaU1wK1RXc3VkVEJPUDMwREVMSkpTQTlVMjR2?=
 =?utf-8?B?SlBqbzdtcEVNc0ptRGpEdjQrckk5SU5GSExqQjJpQnNsbDB1by91S084Y0Z1?=
 =?utf-8?B?L2pJaUVBV2lYZnlnTU5TaHFIUElySHI4V3k4ZVpTT050cWdndDVnc2RWeWs5?=
 =?utf-8?B?L3RXTGdyQ2FNVldEamI3d1pKdTRXRGR5ZnhMV2s1VnpXbFpYVXYrWHhZSUZo?=
 =?utf-8?B?Y2ZUZSt6R2phQk9jQ3V3SjQ0TGU4MEJESFYrTVkzSlhjc1gxYXpKZE8zaTd0?=
 =?utf-8?B?TGpZT0VIRG9EL3E2ejJOZTM4UURvNzlZZi9vQzUyZGdpUjRubk11WXFHb2ZE?=
 =?utf-8?B?S01rMHprTkk3TGx6dE5ucjg5M3lFVVBSTGZqWExuc0xJWUJCNWdwc1lscHVL?=
 =?utf-8?B?MUI5OGZwdU94V2hkUmZCTVlzN2E3NnFqc3E3bVN0SGJ4Y2tWTlgzRnowMXg2?=
 =?utf-8?B?aHUxOFRpejBMM2kvOTBycjRYTHhlbkZFalJPZ2J6Um9zYmdTNkRMSHh1VUJU?=
 =?utf-8?B?Nm5sZXUwYTVxckd5cXBUTHNzSE1TNjBSUms3WS9EK1h0M3FQUE1na0hFZEg2?=
 =?utf-8?B?L2M2VXVGZ2JZcXM4eStPVTRqTng3b2NhZzdBNTVZZitKRWlMU0twNm9xOFBY?=
 =?utf-8?B?SUNFUHFYalZiU2RuNUtsYVJjSExjc3ZGQ2lMTWFlWEc5VWNkWXRQRU8zQnJm?=
 =?utf-8?B?ZDlMZWhoRVpIVWJMWmNtbXl2WWFSQVZ3dzRldndVcjkvNllyaGdObitnWHFJ?=
 =?utf-8?B?WE9tc3IzOWpEMDNadEZoaStreGc4WiswQjNLanR6d1JCa3ZKdkdQSWdidkZx?=
 =?utf-8?B?cFZqZ1ZQZ3UzOHM5ZHY0bFpxVWlTVjZTMVg0Yzc1TDhTSkNnNjgzSUJjZms1?=
 =?utf-8?B?VTBLNW40RVY5YWRBeEhwT3V6TXkzRGhBS3QxWUsvOFJLWjRnbWZBaHpla0Nv?=
 =?utf-8?B?TU9kV2wwVmVxV0svYW5CR3N2bVBWek9KNVR6Q1R4amxqVll1OW9tMXNUOG5h?=
 =?utf-8?B?QjlQYWJzeVFKNndHZDdzM2RBc0g3ZEhrSThKazBjZFQ5NTgzTGNwbUVEdHNH?=
 =?utf-8?B?cGpnQ1VQK0ZZbVJxbitwVXlwVTM3TzJjT2hyc0NxNEJnUDF4RTBFaldPQUZs?=
 =?utf-8?B?RjN1QngrU2pMcGh1djBhSVNpRENCbll6dURaTnJPWlpOSjZwRm0zSW1XcTRB?=
 =?utf-8?B?cExzVkhBWWkxN3dYcW94L2M2T3NQRTVOalFNM2taVHAzRXhEVHdVZUhJZUp2?=
 =?utf-8?B?d05tS2VxSDFvUXN6REY0ZThEb1hselJ4Y0xZR2dKdTRpdXpVbkZySVBTM3Q0?=
 =?utf-8?B?ZWZHSUpBMTRPUnliQWhvYTVZeFhSUVVpRFJKKzlXYkFNcHhrMkdhSy9vQ1BX?=
 =?utf-8?Q?FTG04c+WgZvVKYDD0T+ZcNFjQVgEj4RJiamUehO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5668.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62c28df-c079-4159-0c9c-08d928bc32d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2021 07:25:02.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rC1J7duUGw7JRs6KLIfBlrOAvoSEp7ycIwulvGAwo87rkfDSk881t6TzwYpUSQysCweeImENOCg9h0r8uYK4iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR02MB3028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T3duZXJzaGlwIG9mIFNjYWxlTVDigJlzIElQIHdhcyBhY3F1aXJlZCBieSBTQVAsIGFuZCB0aGUg
dGVhbSBtYWludGFpbmluZyB0aGlzIGNvbXBvbmVudCBpbiB0aGUga2VybmVsIGhhcyBtb3ZlZCB0
byBTQVAsIGhlbmNlIHRoZSBjaGFuZ2UgaW4gZW1haWwgYWRkcmVzcy4NCg0KU2lnbmVkLW9mZi1i
eTogRWlhbCBDemVyd2Fja2kgPGVpYWwuY3plcndhY2tpQHNhcC5jb20+DQotLS0NCiBhcmNoL3g4
Ni9rZXJuZWwvdnNtcF82NC5jIHwgNSArKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC92c21w
XzY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvdnNtcF82NC5jDQppbmRleCA3OTZjZmFhNDZiZmEuLmMz
OThhZjNjMWNmMyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC92c21wXzY0LmMNCisrKyBi
L2FyY2gveDg2L2tlcm5lbC92c21wXzY0LmMNCkBAIC0xLDEyICsxLDE1IEBADQogLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KIC8qDQogICogdlNNUG93ZXJlZCh0bSkg
c3lzdGVtcyBzcGVjaWZpYyBpbml0aWFsaXphdGlvbg0KLSAqIENvcHlyaWdodCAoQykgMjAwNSBT
Y2FsZU1QIEluYy4NCisgKiBDb3B5cmlnaHQgKEMpIDIwMDUgLSAyMDIxIFNjYWxlTVAgSW5jLg0K
ICAqDQogICogUmF2aWtpcmFuIFRoaXJ1bWFsYWkgPGtpcmFuQHNjYWxlbXAuY29tPiwNCiAgKiBT
aGFpIEZ1bHRoZWltIDxzaGFpQHNjYWxlbXAuY29tPg0KICAqIFBhcmF2aXJ0IG9wcyBpbnRlZ3Jh
dGlvbjogR2xhdWJlciBkZSBPbGl2ZWlyYSBDb3N0YSA8Z2Nvc3RhQHJlZGhhdC5jb20+LA0KICAq
ICAgICAgICAgICAgICAgICAgICAgICAgICBSYXZpa2lyYW4gVGhpcnVtYWxhaSA8a2lyYW5Ac2Nh
bGVtcC5jb20+DQorICoNCisgKiBDb3B5cmlnaHQgKEMpIDIwMjEgU0FQLg0KKyAqIEVpYWwgQ3pl
cndhY2tpIDxlaWFsLmN6ZXJ3YWNraUBzYXAuY29tPg0KICAqLw0KDQogI2luY2x1ZGUgPGxpbnV4
L2luaXQuaD4NCi0tDQoyLjMxLjENCg==
