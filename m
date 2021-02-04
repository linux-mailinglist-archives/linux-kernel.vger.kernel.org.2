Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2B30F36B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhBDMsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:48:07 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3153 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbhBDMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612442881; x=1643978881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tC5DQhuV9EkApNDST/nlclEm4EMm8G3XZ3H9Mpl3XZs=;
  b=pPjSDNtDfnHwod0924UV6G0POdKJqSdsIftZG3ZlSKYbMZtILyRlAN+n
   ryMPJYU7wVFESggoW6mU+NApFLV+aWDmuVHXTDdRVDfHfSXgxd5yo6q7D
   +f44OQITjHBOapNczLW2ySHiGDUCvW8ir++Z0bUUeaaSuheq5nnpy7wgs
   YvsnHoNTqCkKYla21Gg9Al3gAdYYZLK0dxLtFGHICL+T+wgocTaj9aedC
   dV5+WTwr2iqyMCzS6FyFpZyzsowMwLaH7twWKfNpiXfnIdZTtg2DBp/eq
   b4Te7GGtEGxhkOb/WTvsvOTr8J3V1OSTu16N9PS/YppDJgm5GwbDb3tAC
   A==;
IronPort-SDR: ZtHvx7w2eWP4UhurwZjfUMv3qxFFJ3ad9DJ+O0sNL3b0Dx2b6F9f50qOcqogSu6C8BA4NGPiJJ
 yVzRNJX9U6UQKIezEh3tLLAJ4Y/UnQjONeMSC548YKtk5okkNvCKFW/WZPaTGoUdR9KDfaUd66
 b0e5OvSbLPs/FlS9smZuPsjdB6WLadyzTT4Bts00wmcQngUq6yIYnYX2Sv2Xpn1Xu68mXQLlOB
 UReOegdbJDm1UyuJljtjfh/UybZwP59PdlM8MhnJy0WnZcaBD/cBG8n+Uj/JnHshBedFtCrlhO
 AFk=
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="102577941"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2021 05:46:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 05:46:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 4 Feb 2021 05:46:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHTZYGf/BrPvaGHPQHaCvFPS2NeYQPf5O4kVG4I4WYMEdywvGePwd39KNnGdQafxroNlXrsCuveL9hEY7Xk+nDLE6SUvP+7sqyMW1T/8haTlpQpm+QLMEmsn8jPXcKXRYk2NKt5d+xqBAQS3UxodnbeZLoBTu4D6LWFjDDDaHkqBCOQexyGr/jifx1WI6zXpyNlvufAUHveaZwFPIT0xw2Y3Hi9Y7f3ZIccXj6c8x9Aew5UjIUQ2jzMFrYAzI/vyTPIV+hPklBowDEgVDMgwqj8bMzIpNLLrMXz/7Lg1K5zani0A7+etR8rgrO+lKdGQd856yldVXESa/Q9Ln46ueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC5DQhuV9EkApNDST/nlclEm4EMm8G3XZ3H9Mpl3XZs=;
 b=nWN6dlQ5185nQNWb9gx6ROsQ0llFfIe0hSnVkbu4n1SbZ4TEjMGdHrOuurvuGdIXDI2+UW+q0mXx/r8B2ICQku1QfTSRTnNCuVvUHmwyoQl6DrQjBQv9CD1JYaT79DrQX5s9CRuoeAokbPxaX4f04Ahuu1U5POmktvBtjqhhjWLiLUEfkFlB56P9OUGvvZPzgjRBpPiX5vkos4n7VAKF2PKgk+dTNDfXDxzBmbLI2CYOOA4hDpGK74l50RMFPp/cnNwJSd1kSJdhmp3rpaLab1GdaZvDdrwpY8Q8sEiyni1gKWS7GfzZiHYPKCSS8ikZ68ibG7TUTOBTfDBDcUDkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC5DQhuV9EkApNDST/nlclEm4EMm8G3XZ3H9Mpl3XZs=;
 b=nSD4g5t41PRIr0EHn2gxbs/4Q1k0tLygGZVODTI0rlTpITdKCUcEnLFgIrm2rnk52ngk/m9k8GBf2Ys3FZglqvHyua21d6rys7e2l/uc9okv1vCea3hgzGXxvjxh/KOCHfEs/2aW+u7h2hjjUqh5LhGrImXJHAJcIDmerlH/rFM=
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20)
 by BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 4 Feb
 2021 12:46:44 +0000
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::35a4:317b:b504:11ed]) by SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::35a4:317b:b504:11ed%7]) with mapi id 15.20.3805.026; Thu, 4 Feb 2021
 12:46:43 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <saravanak@google.com>, <Tudor.Ambarus@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <a.fatoum@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>, <krzk@kernel.org>,
        <mirq-linux@rere.qmqm.pl>, <Ludovic.Desroches@microchip.com>,
        <geert@linux-m68k.org>, <Codrin.Ciubotariu@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] clk: at91: Fix the declaration of the clocks
Thread-Topic: [PATCH] clk: at91: Fix the declaration of the clocks
Thread-Index: AQHW+kN/rMRI/R4xSkOw8bLIB8o/T6pGvHEAgAE2mwA=
Date:   Thu, 4 Feb 2021 12:46:43 +0000
Message-ID: <7a9e6113-3281-04c8-00e2-c5286d8b0b01@microchip.com>
References: <20210203154332.470587-1-tudor.ambarus@microchip.com>
 <CAGETcx9ki6tM7Z8B8ghm9cZVNbwUo9rQPY1H0-s2rRifC=_m8A@mail.gmail.com>
In-Reply-To: <CAGETcx9ki6tM7Z8B8ghm9cZVNbwUo9rQPY1H0-s2rRifC=_m8A@mail.gmail.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.24.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4748b450-52de-427c-2f27-08d8c90aed3c
x-ms-traffictypediagnostic: BY5PR11MB3976:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB397661B19D9071E427DBD32EE8B39@BY5PR11MB3976.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vv0AEik/VeEAQYp3XUmlmtAQpT3yetMm4avf5rxDbV8CKQoxGWMU4rjSdkkayFs+qtZmxsk4GNkNjKQuqgfw3wpoUj4NEDtjtANpzlk6mOoYpeqP9PJhezupXDWLakmwg+Xe1XM2DbJpX99wm3Asv2rUNPWpKI77xEmUAlwbA1SSRbfjZbx9WWo2VHbeS1MkEp4RYRFR4M/mCULtoSJBqMtZuGphM1qC1mzdmt2YklQnhCZuWe/Oeb8SxJTbZvytET/3tWuzn2jdr+9v4+sEjgemfe6AdoC32VTxdf8eyYX6YdGGEWP7krCpbikozAafQ0xS7quEsuuzGslRvJaHYSZGAkC1x3q2QMYx4qBVYlsZwJd1f1ORoSYEkjr2hujc8Qpf7/7RvDvQvisaS8JXZd8s1aIW273L7Pbuyb/FOL8cfxvzrhPxE+BckI5UahT+BjAi942dAFGJzijEz78ihTjBkk5MxrkKThRcCNWZxANeFhpOi365C7t4sSFcp6PMLmSOXqU4gS83gcJQp9y9vlpQ+qON2c7Gx5WRALXUpus7yCDHzzp0V4BVuwIOyw7RnqvosYVKBOpAOhAxOurjgsJE/t8NK3gfYueDsY5XBK4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(376002)(136003)(346002)(53546011)(31696002)(86362001)(31686004)(6506007)(110136005)(54906003)(83380400001)(8676002)(478600001)(91956017)(64756008)(2616005)(26005)(5660300002)(2906002)(6512007)(71200400001)(4326008)(186003)(7416002)(76116006)(4744005)(316002)(6636002)(36756003)(66946007)(6486002)(66446008)(8936002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Njk2Nlcyd085MUJkdE90Y05XeVptTGR6ODQ3SjMwdWdLZ2V2M2Y0RHJtSlMw?=
 =?utf-8?B?Q25tcVJrZHRVQnQ4RkFMSDl5VEZrTnRFNVFEbnFyQks3U2lvOS9BKzZvWW5S?=
 =?utf-8?B?bVM1aS9zWUZVaXhjd1JzcjM2VEVMVjNwQkFqMlVnL1FIQm5Ndjg5UHJFT0N1?=
 =?utf-8?B?d2RnNG56eE1PcXdnNVhBbTFKZUthTmFVYlVCbTFHMjM2d1kvNnlIa2pSYnc3?=
 =?utf-8?B?RUd0R0RUNHNtUkhVZXJKU1FpVHhMSnBNSnpQTm1PZUZRM2RLUGJOUXR3dUhh?=
 =?utf-8?B?RDFWaDQ2SGk3ZlNqV2VuV3BqV1ZOM2tRNzR0aVFIT0U2KzFQQXoxamZyeW1H?=
 =?utf-8?B?S01YTzk4U0VVcHAreTJVdGFPY3ZxSlgxQU9oNy9wN29qQ2dyalk5ZnpWM0Jn?=
 =?utf-8?B?MjZoNlJBd3BhS2EyV2tBYlplUVFuVVUxLzRhVTN0cnRjOExKdVcvMjdQWkFz?=
 =?utf-8?B?VENoM1gwOWQxNGpSb2JyaTE5YmJGdUM4Z2UxS3BRTlZaQXhyL0xRSXVIL1BZ?=
 =?utf-8?B?V1ZWSkxkcmZWM0Z2Wmk1aVhzdEhxcnhUdFlUSEo1NnZtaU1rOFU5NW5tWlpP?=
 =?utf-8?B?dXQrYnVMclM0RjdLR0VCdlh4WTlTeVA2UUV6Vm9YNkxMdkczQW1kdFJwTmp1?=
 =?utf-8?B?OU1IMW9lSGRJaHlMT2NNSG9xaWx0SEtCTnBBZVpTNXkzUGFhbGVvQStCaDRu?=
 =?utf-8?B?M1dCTE0rbnFmcko1dldxK2tqbWpQdWVkaHJ3V0R5Z1BnMTdkckI4QjFaZC9D?=
 =?utf-8?B?TTFHb2szR210QkxDQmNQU0tZRzlnT2NZNXVXMFVtL1ljMDRoSUl5VnZoQWpS?=
 =?utf-8?B?WGxnamtVdEFvc1ExZkVoVVFIb1RlNjBGeVBPT3BzZnZkZERkVlR1Z0JwK2o3?=
 =?utf-8?B?K2dkVkhoVkpxd080Z0VldmpCZWlRTmhKcW1pMkxLS3pib0lBRFd3VnlOeVBS?=
 =?utf-8?B?ZVgvS0l1cUxmaVhQR0xIZHhMOXJhMll5L21MSzZFUmhCUzFrNW1hbUpXQ1FZ?=
 =?utf-8?B?WTRmQ0tQOW5KVktCUXREcmtoeFM5bEJpRWJxdzNYL0d5aTZrNVVGdzFDRVFX?=
 =?utf-8?B?SzQ0eUZuUW4yWngwenlkdmlVQS9sU0dYRVN0N0tNRC9xRkZyUERLQ3cwR0cx?=
 =?utf-8?B?OERGMWlOMWdzR3BzVFordXpleXhYMjJMYkV3RXdPSVltLzQxekJSM1JUaGdV?=
 =?utf-8?B?WEFOMXpPNDZMY2hzK0pSSk8wZWgvL0hZbDNnK015TUpuUzNTd1FzYWtxbW5T?=
 =?utf-8?B?emRveUt2d1RmYjFHMENmN2VxWTR5N2xZOFVpTTNLRUV5cXNMNGlLd0doSGRZ?=
 =?utf-8?B?aFRSQW83a0ZPVVJOYW4rSGwydW54SFA5VTF4TFlJWjhDTndGMHljV0sxblRz?=
 =?utf-8?B?bW01R2dnY095NW5xZkRYR1JCK2lCcENxcXphY2Y2VW1LWE5xamV6TzFLMUlQ?=
 =?utf-8?B?cElIYjB2YzRGNUlCS3IvMUt5Yy8xdmp1cmMyMUtnTWd4N0kzTWMxVmRqL0Ju?=
 =?utf-8?B?T2pOektJNklOQ1Y5TnpJWmxzMEQvNndLdVQxWXIxTGxhRzNtU0oxR0VPOStC?=
 =?utf-8?B?eC9kZzc0cklnNTdmSXN5OXRzT0JNWjhUSmdYblcyNzdZN2FhYWY1NmNkSXFh?=
 =?utf-8?B?YTBDKzlzaDZxdFlkZmE5SEpoZG9VMW9aWVNJZnBPZXRyT1czQ2FrY2VKR0l5?=
 =?utf-8?B?cmV6R3dPdk9CaVQ5NDRQdWRsbVI1YStGTWhaL2tpTlEwb2ZLRjE1YmpLaFFZ?=
 =?utf-8?Q?JYx4+zbdD0Ja7JNihg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C286FA8263D6C748B6B09C7450408353@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4748b450-52de-427c-2f27-08d8c90aed3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 12:46:43.8053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LOfpnKrUOHkhehuO8c6eWRI9XvTD2NeZ2WIgyIJ6q8PjXuh1dpLfRBu6wFt1MgZO/TEiCGUoJvxRp39HhgdI3oluUUeftrijMlbWjRqIQtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3976
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDIuMjAyMSAyMDoxNSwgU2FyYXZhbmEgS2FubmFuIHdyb3RlOg0KPiBPbiBXZWQsIEZl
YiAzLCAyMDIxIGF0IDc6NDMgQU0gVHVkb3IgQW1iYXJ1cw0KPiA8dHVkb3IuYW1iYXJ1c0BtaWNy
b2NoaXAuY29tPiB3cm90ZToNCj4+DQo+PiBUaGVzZSBhcmUgYWxsICJlYXJseSBjbG9ja3MiIHRo
YXQgcmVxdWlyZSBpbml0aWFsaXphdGlvbiBqdXN0IGF0DQo+PiBvZl9jbGtfaW5pdCgpIHRpbWUu
IFVzZSBDTEtfT0ZfREVDTEFSRSgpIHRvIGRlY2xhcmUgdGhlbS4NCj4+DQo+PiBUaGlzIGFsc28g
Zml4ZXMgYSBwcm9ibGVtIHRoYXQgd2FzIHNwb3R0ZWQgd2hlbiBmd19kZXZsaW5rIHdhcw0KPj4g
c2V0IHRvICdvbicgYnkgZGVmYXVsdDogdGhlIGJvYXJkcyBmYWlsZWQgdG8gYm9vdC4gVGhlIHJl
YXNvbiBpcw0KPj4gdGhhdCBDTEtfT0ZfREVDTEFSRV9EUklWRVIoKSBjbGVhcnMgdGhlIE9GX1BP
UFVMQVRFRCBhbmQgY2F1c2VzDQo+PiB0aGUgY29uc3VtZXJzIG9mIHRoZSBjbG9jayB0byBiZSBw
b3N0cG9uZWQgYnkgZndfZGV2bGluayB1bnRpbA0KPj4gdGhlIHNlY29uZCBpbml0aWFsaXphdGlv
biByb3V0aW5lIG9mIHRoZSBjbG9jayBoYXMgYmVlbiBjb21wbGV0ZWQuDQo+PiBPbmUgb2YgdGhl
IGNvbnN1bWVycyBvZiB0aGUgY2xvY2sgaXMgdGhlIHRpbWVyLCB3aGljaCBpcyB1c2VkIGFzIGEN
Cj4+IGNsb2Nrc291cmNlLCBhbmQgbmVlZHMgdGhlIGNsb2NrIGluaXRpYWxpemVkIGVhcmx5LiBQ
b3N0cG9uaW5nIHRoZQ0KPj4gdGltZXJzIGNhdXNlZCB0aGUgZmFpbCBhdCBib290Lg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNv
bT4NCj4gDQo+IFRoYW5rcyBUdWRvciENCj4gQWNrZWQtYnk6IFNhcmF2YW5hIEthbm5hbiA8c2Fy
YXZhbmFrQGdvb2dsZS5jb20+DQo+IA0KPiAtU2FyYXZhbmENCj4gDQo+PiAtLS0NCj4+IFRlc3Rl
ZCBvbiBzYW1hNWQyX3hwbGFpbmVkLg0KPj4NCg0KRm9yIHNhbWE1ZDNfeHBsYWluZWQsIHNhbWE1
ZDRfeHBsYWluZWQsDQpUZXN0ZWQtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWlj
cm9jaGlwLmNvbT4NCg==
