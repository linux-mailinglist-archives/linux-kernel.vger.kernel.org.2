Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD283B091B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhFVPdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:33:14 -0400
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:38625
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230510AbhFVPdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:33:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jheVcPUZvAZDy8yaCKJf83BGNiZmR+VYz7nAUmyXeMfEgVM0rAY88GVhnrqs73bSka/TO74jDNXsnvy7SIrUjT2hTIAWiIBqwa9TUVhdibo7PE42lD0QlmDkztCU4EwRfsYM0hSd52Qz2FyByxMf4t31JwB4vFMMDqnDrbCfrxqxBDKAlfYQ6Nv//R0oxxGPMnt8NaKSSiAAOhV02POBbiwADrTrPRuT3x4GvgPZi3hOWHn2aX4sWCoSmjU8w3/zPc0aRm8vxDEL/vJufGDy1B9NwpYOoifjTabeRSEhz6Q0O36yOvw9qwhn0oxUcIJqJHuutriPVAjiMyIAapQEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czTb50ByHjOC0oHVWr4y1G89989ztz9uXy6PmfkQ1RU=;
 b=idBrvawbMj93VBBliy2w7wcD2B5BdJ4EsYAcNBfdy3ndkQsCkpa8+G4ydr4rc2bzWSclIczikDQ8UWQbUuZ+Dk8hDYGe9zGK41R97z5ssdW73N/EAx9Us8JDeQSc+6g5Dz8dnrnF5T/inqaIDdffzhm8Yc4vrAi+pWXuppIZdRMkvKYW7oKx7LG9Wacezc+thbqeAEchM2wg6gP59ggGTKwmqSgfLkn5rRrJbP4PkaObfnnMgP4g+Gi5FIU6R6Gos64Qn9x6d2n18V107bmrzkNLUQRTf47ePwmA4g0lBDokSuWId7Fsz3TUTNBwSvuAhnztIuLzomGN6zPaKpASNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czTb50ByHjOC0oHVWr4y1G89989ztz9uXy6PmfkQ1RU=;
 b=B08DI5ngz3EXIu4pYi3SuGqSGveynERTi6MjnnkAEOyIo34D0srpSfY+6wkoTF1WwQrRIg98LbmQBF98V9eZt/Or+2zLNohvPLnKhij4pOAF+cqimkSf/v4PAohrW3BOFds/bE+CFJ960wF+EUS67rMmzCgE/ksFktIhwyez98M=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2987.eurprd03.prod.outlook.com (2603:10a6:7:5b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.23; Tue, 22 Jun 2021 15:30:53 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d0d6:aefc:17d9:bcb9]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d0d6:aefc:17d9:bcb9%3]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 15:30:53 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] regulator: bd9576: Fix uninitializes variable
 may_have_irqs
Thread-Topic: [PATCH][next] regulator: bd9576: Fix uninitializes variable
 may_have_irqs
Thread-Index: AQHXZ3WIqa81Lmlwr0St9M1rQFlVQKsgKEAA
Date:   Tue, 22 Jun 2021 15:30:52 +0000
Message-ID: <10409fa6738f3a9371985121b2838734249c1c3e.camel@fi.rohmeurope.com>
References: <20210622144730.22821-1-colin.king@canonical.com>
In-Reply-To: <20210622144730.22821-1-colin.king@canonical.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [46.132.21.91]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 658e032d-8ee5-4ba6-fc34-08d93592b8c4
x-ms-traffictypediagnostic: HE1PR03MB2987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR03MB2987363C1B02D29E75A6E9A1AD099@HE1PR03MB2987.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8UFkgUCv0FX/DQCqh6dndaPImq43XPRB+5Xao8eLTJSyIPOoK8XPZU7Tch98ZJ1DVkczZp61tPXpZxMJJL9kSKjgBsCiZsGA3uTXTZPr+L1JH6jmOevf28WAq8VwYP9WD/UOw136kUQYIByL3AVNCSs+osvNsq7SvqOMJFBSfTKRjcCVa7gfkN2WKn7jG29ZVtq/w7yuDBCmvYTUbSFYu1WLNUjv6WJCBMUv39KRf3YCUpQo5abW96NwsLKlj2e7wupZazHS+dFjH3FGL7/SU1SjHGfTlfJdFkrnj/F6zw5qQ5IjnSXK3niuJ74yE+6eyxltTXiNpTIbuv2m5Ri+jQtPCQ5Kfpk4PUVPHDcwXkagEs/Ri2KJcuFlIsdqu4Uv3iQnW2EQQ7B4K9tNo6AOH/GM+lI9afz/yIbhSRX5CV+YA/FtyTNwcP5SfOTZBL1ktxzc9JswRz0vN5XQn+B5gMbvTHF6AU3pVeyrJKKMVf1XhraN1MOTC7OdQWTGNU2iKWoNK+4hDbJEAuitStvXNY41OveM4tQG5R670EyVDe3muiVK/WzuaFARUt7nNcjY3OwgNC50pEGl6swJexMQsHrkNgoRraBvkGS4tl4B0rU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39830400003)(136003)(5660300002)(26005)(478600001)(3450700001)(4326008)(6486002)(83380400001)(86362001)(2906002)(122000001)(2616005)(110136005)(6512007)(66476007)(54906003)(38100700002)(316002)(66556008)(66946007)(71200400001)(64756008)(8676002)(66446008)(6506007)(186003)(76116006)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDFSaDFiZHVyV3E2T0tpUlQzTGhaQWFHR25Tb1daNFUxTlBwbk80bWJNa0o4?=
 =?utf-8?B?VW9GbjZPcFp1VTZUencwcFhxYkRmYWdTbkpWZUdTL3BMWk4xR01HQldUSy9u?=
 =?utf-8?B?aFhiL1duSDh3dEptYnM1TjcvWGkvYjl1NzNZK29ZZGNJb2tqN2tJRXhlcWFq?=
 =?utf-8?B?N0dSZnJ2WXZWeFV6R2RheXh6WDZQamVhR2NZT0lBVjZKeHRJNHpHVDE4dnd2?=
 =?utf-8?B?Y3ZqMU5lejFFbHRwaUl6dGZlc3ZtK0ZrQkkvWnYwZ1hZSHExblhuQy8yZVMv?=
 =?utf-8?B?NjM2L1BjQkdULy83ZXh4VmFsS2ZOMWk2M284L2hKTmY5RDZjZ0Q0b1BxSDFx?=
 =?utf-8?B?Q3NjelBPYk5NVURVL0ZTejd1RTNqNXhGWWcyeDZUWHFndzlScUQ1UmxtYTdC?=
 =?utf-8?B?a0I3R1FVSE9HUGZJQmRuMFNFVGtBRWxzSGprQUlPcW1la1VnekVzZ0RmV3lR?=
 =?utf-8?B?WFNXWWZKWnZQMFNreFE2NGlnR1lqczNLSnUydE5CN0JESjVpQ0RMbm8xMDVq?=
 =?utf-8?B?aHNjNW9XSUR0VmtBdVlMOStTUjEwczhSV0Jnc1lGYWR5UlNza3ArR2F2d0cw?=
 =?utf-8?B?VFg1TXkvV0h6Y0tReGovVTZobytFTk1kVnB0OGlFejdlbTRHVTVORC9yNmpU?=
 =?utf-8?B?UmVRVDlvL2tqL2taZHdPQzQrWUh5RFUzeXJFYzl3bzh1WWZJMlZSZmdtU29u?=
 =?utf-8?B?eXQyZ1ljTlFkbVVPR1BHNlVMR2N1aVFMMEgvTGdlVW0zOU1NZldQNGp3TVNL?=
 =?utf-8?B?VFVqaG9HS0cvRlBEMTVoeU5oZ05FS3A5aGp3S3ZKZmVPMm1yTEZ6bmlXZ1Aw?=
 =?utf-8?B?VXUySFl3WXpqVW8rTFFpbnRlUERiM1RUanh0clpDNGg1cnh3aXowOXhuaUo2?=
 =?utf-8?B?bm01ZVpLbldKL2srR2Y4RVR3MTRUNWREb2swL0JDcnFaN2tHY1FScld5allD?=
 =?utf-8?B?L1JDb2ljQ0UvcVJ0SHhtYktMbDZKS0g1Qk1WYWlLMzAwd2F4UXFnVEpFWjVF?=
 =?utf-8?B?SjdGcmg0OFFjVTF4L2lOZS9JeFFHc1ZmOElxMlhHUUI5OHBlNFJ5dmorS1Fu?=
 =?utf-8?B?SStBYldTVHU1Y3NjK011M0hEblhHNTFHSzRsL0hGOStpR1lMTHZyOG90Z3Vy?=
 =?utf-8?B?c0tKMHkrWExwWFhRa2pjMUhCQjF6b2dDSGtpNno0YnhGejlrdEVaYXgwT2RX?=
 =?utf-8?B?Rm9HRjRrYVQzZ3IybUV4ckcxOUtoTDJmMmc2eUZsZ3VsVFZ4NUtEUjRId2Z2?=
 =?utf-8?B?TEY0NkZ6T01NcjZqcG55M0NTR3hLVmFyTkl5cDdyV2FFV2NPV1Bnb0NUK05j?=
 =?utf-8?B?MEV0VTRURCtRdWVSWi9QeDBWSk1wODZrN2VVUzlFbXNHNTV4MzFacjZwWXg4?=
 =?utf-8?B?bkZCekR5cnYvbU9Nc3Z0ZVNQR2JnR2oxSVN2YnNUMlgrVUlNSHh0YWNVbU5Q?=
 =?utf-8?B?SzREY1NicVFXQWJtWTl3eHo3ampNQnEzaUp4bEZjRTNhTlBzM0x4NXgxRWg2?=
 =?utf-8?B?TGpoQkloTkJjZktBNEptOVBGeUVWMm1KbUtaWDBVeEJYR1BndDdmcGxDbCtV?=
 =?utf-8?B?aWtndnIzNGtnYlRBMThlWXhiMVhDN3I3SktGRGd1UnRlTEFiVGx1TERyWDdI?=
 =?utf-8?B?L01nVDBwUGJ5a0t4UHFiTVk0V1hBWkx1Vjdud2xHYThNTlEzQWZ5VG9DaUMz?=
 =?utf-8?B?UDBJa2QxWEx0OWkzRFJTMlFHQktDdHgycXExUDZCK3FCTWl5K3dOeWVsT3Iy?=
 =?utf-8?Q?dLmvwK9KD3j76KF1wNtyeceDl/gJ2akbHInZf58?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B1C3CE23D5BDB40B2191E77560A5291@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658e032d-8ee5-4ba6-fc34-08d93592b8c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 15:30:53.0081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7qkKjuVkUwr5MX+ZSOJ1uR4+QdknnbWZWaua0w64y38mJbCG7YrajX6oIgKEBiz/6SBj5hDKKyWXO52XtZb/eepDEOCZiqEzchaNdIklBWrgyDRAifv32k0lj80WcQL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2987
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTIyIGF0IDE1OjQ3ICswMTAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBG
cm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gVGhl
IGJvb2xlYW4gdmFyaWFibGUgbWF5X2hhdmVfaXJxcyBpcyBub3QgaW5pbml0aWFsaXplZCBhbmQg
aXMNCj4gb25seSBiZWluZyBzZXQgdG8gdHJ1ZSBpbiB0aGUgY2FzZSB3aGVyZSBjaGlwIGlzDQo+
IFJPSE1fQ0hJUF9UWVBFX0JEOTU3Ni4NCj4gRml4IHRoaXMgYnkgaW5pbml0aWFsaXplZCBtYXlf
aGF2ZV9pcnFzIHRvIGZhbHNlLg0KPiANCj4gQWRkcmVzc2VzLUNvdmVyaXR5OiAoIlVuaW5pdGlh
bGl6ZWQgc2NhbGFyIHZhcmlhYmxlIikNCj4gRml4ZXM6IGU3YmYxZmE1OGM0NiAoInJlZ3VsYXRv
cjogYmQ5NTc2OiBTdXBwb3J0IGVycm9yIHJlcG9ydGluZyIpDQo+IFNpZ25lZC1vZmYtYnk6IENv
bGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9yZWd1bGF0b3IvYmQ5NTc2LXJlZ3VsYXRvci5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9yZWd1bGF0b3IvYmQ5NTc2LXJlZ3VsYXRvci5jDQo+IGIvZHJpdmVycy9yZWd1bGF0b3IvYmQ5
NTc2LXJlZ3VsYXRvci5jDQo+IGluZGV4IDhiNTRkODg4MjdiZS4uZTE2YzM3MjdkYjdhIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9iZDk1NzYtcmVndWxhdG9yLmMNCj4gKysrIGIv
ZHJpdmVycy9yZWd1bGF0b3IvYmQ5NTc2LXJlZ3VsYXRvci5jDQo+IEBAIC04OTcsNyArODk3LDcg
QEAgc3RhdGljIGludCBiZDk1N3hfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRl
dikNCj4gIHsNCj4gIAlpbnQgaTsNCj4gIAl1bnNpZ25lZCBpbnQgbnVtX3JlZ19kYXRhOw0KPiAt
CWJvb2wgdm91dF9tb2RlLCBkZHJfc2VsLCBtYXlfaGF2ZV9pcnFzOw0KPiArCWJvb2wgdm91dF9t
b2RlLCBkZHJfc2VsLCBtYXlfaGF2ZV9pcnFzID0gZmFsc2U7DQo+ICAJc3RydWN0IHJlZ21hcCAq
cmVnbWFwOw0KPiAgCXN0cnVjdCBiZDk1N3hfZGF0YSAqaWNfZGF0YTsNCj4gIAlzdHJ1Y3QgcmVn
dWxhdG9yX2NvbmZpZyBjb25maWcgPSB7IDAgfTsNCg0KVGhhbmtzIGEgbG90IQ0KQWNrZWQtYnk6
IE1hdHRpIFZhaXR0aW5lbiA8DQptYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQoN
CkJlc3QgUmVnYXJkcw0KCU1hdHRpIFZhaXR0aW5lbg0K
