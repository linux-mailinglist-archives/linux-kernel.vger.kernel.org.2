Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7233D8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbhCPQIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:08:23 -0400
Received: from mail-eopbgr670050.outbound.protection.outlook.com ([40.107.67.50]:21495
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238485AbhCPQIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:08:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLrWW1hvlueC2NPI5JKLDz5EGP3XPdYkgdMHrKr3bz419Xd5GF96bT0Orp0404+jdgLVpLQEG0xb7re/094erpcwuRRmA+eUG0wRZZVJK9xtU2VlQ/14DEDFp/2gVYxWSG41OvFZk72D6FW3LrqFUPH8TD0iMl3btKiqmJ+5GdqhMSE0G9ekgxEgf0u31gs/A1mZCLx/PlSzgra1IJHzH/1Pdu+/DqbLqZ60Wk+lQ2zK5QV/Pu6RdkOGP5LwpsrMYMNWbFlR9iOpSuF4OPnrY7hWRruheVs63wRZP1nlI7Yh9hMGWw0E3xZvOxh6H/fE/lVySt7kjawuX7D+FA5dOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybvluAZhPYYfv9mb9P1OsS+nOZ2ukOE8woydrjqHock=;
 b=nA7QY/g/2H5cVRydwrnlOAYeODBav532Y3ZpaQ0WBMkvTdbYcBL1z8V1DmIps9Qk+J8nXWLzYJ7RU/v82XtQJJkPYze7f9fRKfa32cBauiU9W5LV2lrVy2mM2P1IUid4zC0WgLVAr/anryKGSzrHD4WdUjuhzfQZIUL6dn1JpFQ0SFrW6PVDE2AfdQSzKyF8nG5nygeOm5zYN+QZPnksNZWJmDVJ61KCktWAeq4UxIIWFdvK2EqgAoaqYdgSF4pp/vp0wxGjc1WJLeRitsS+tHopsOSWFYd+WQqLtTk/FQz+K2oXzRQdbS/A+/3XYBgZYyOJSCdnXpDQL4mAlb6Esw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stfx.ca; dmarc=pass action=none header.from=stfx.ca; dkim=pass
 header.d=stfx.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stfxca.onmicrosoft.com; s=selector2-stfxca-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybvluAZhPYYfv9mb9P1OsS+nOZ2ukOE8woydrjqHock=;
 b=R+92XsTfLzOnD5IcRnMx8sTXxO1e1qPVgHzuXpn1qgb+cv07qhRvuDE3JOoNe40XLuZYU1tHVhNZjiTSKYraCFWy1d23rmPE3xSWmqTDY8XsQjMFwozwFKNRvUOPdKDNjk9qKOBGGVHkUvIkPAuhGmmwo6P6nBBmH0X3cnHL6/Y=
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:17::19)
 by YT2PR01MB4781.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 16:08:10 +0000
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3]) by YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 16:08:09 +0000
From:   "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIDAxLzEwXSB0aWNrL25vaHo6IFByZXZlbnQgdGlja19u?=
 =?gb2312?B?b2h6X2dldF9zbGVlcF9sZW5ndGgoKSBmcm9tIHJldHVybmluZyBuZWdhdGl2?=
 =?gb2312?Q?e_value?=
Thread-Topic: [PATCH 01/10] tick/nohz: Prevent tick_nohz_get_sleep_length()
 from returning negative value
Thread-Index: AQHXFnNGiA2JtEhS2EiDRBkCbpwkF6qGkOKAgAAVHICAABBdgIAABRoAgAAI/QCAAAjRv4AAAXDT
Date:   Tue, 16 Mar 2021 16:08:08 +0000
Message-ID: <YTBPR01MB3262D78448BD2FB3AD5EB4F9C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-2-frederic@kernel.org>
 <YFCiycIaViYCy3GH@hirez.programming.kicks-ass.net>
 <20210316133703.GC639918@lothringen>
 <YFDCOYstnDWPSWRU@hirez.programming.kicks-ass.net>
 <20210316145352.GE639918@lothringen>,<ab753f1f-b03d-2a26-a552-b91f98708353@intel.com>,<YTBPR01MB32623E6AC71C9F7670469A47C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YTBPR01MB32623E6AC71C9F7670469A47C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=stfx.ca;
x-originating-ip: [141.109.104.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e1952bc-46bb-47ad-180c-08d8e895b10c
x-ms-traffictypediagnostic: YT2PR01MB4781:
x-microsoft-antispam-prvs: <YT2PR01MB47816F9C7136036CA3134F92C46B9@YT2PR01MB4781.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tc7u5V9KrCBkOploh1wSk6UMi/1fv3xzDV3APjQtWyY7UkM6ZjgjrF/0jF4sr6N5fap2KZIQnYj5qo7DiVIu9vAYSMPM8G22F0h69YrU1AZIZV9mQiyVWWBV8fPkkGp7oLjr8WhpgDSBLv1m8+7vUdAjbGtAxjsommXsvOz7NrAJTwmMXQkzIeXNppMi9dtPciirQtJxPdU0bF8Nb5gpFRum7XZizkdE0jRmOSQLOkxTCv89bZOoD9eqb663QSka3rthsSsNNDh62zW1qP8QiFvnpbybFGLOdlO6FJJcvy7yzjl+UqYzKXTD3xnEgIzMYrYH4/hQf8aJXms9WFS1mq5tqplnOm05WuFosqoLF6YMkQhfZhUpfigdZPhcFGiwkY794cmu66sQYVOo/BD4qnyLZGaMiCxt9xFxAYaE3DblFqvkXPrG6KoTtARNua/9KEcYhX7b8OLv+17u+P6Ccx/hqVLx7WpIN4B0jqnT/oRY44VQua+jiWPgSS16poVtM/ZBdZzPKnQm6ySp+1nO1+IiI6prYmKrxezQCuR10kuQxfaWqlDA51ehYaW+gvw0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39850400004)(396003)(346002)(33656002)(71200400001)(186003)(478600001)(4326008)(7416002)(76116006)(316002)(224303003)(2906002)(54906003)(786003)(8936002)(55016002)(7696005)(110136005)(66556008)(5660300002)(9686003)(86362001)(66946007)(26005)(53546011)(64756008)(2940100002)(66476007)(52536014)(6506007)(83380400001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?aDk2amxzbGEwYWJieVNXOTgxUVp2SG1xazhnR2dhbGVyTDgxYldxWGk0WGVM?=
 =?gb2312?B?R3ZNNmJMWnU3aWllb2ljVVRmNVhJWlAzQUlUcFpudTFINU56WHc2YWZsZUdw?=
 =?gb2312?B?ZTZSRXh4cUNRb2YrTDRIVHN0UldEMXpuY1c0L1YyWDcrbzJ5MjYvbmFva3RX?=
 =?gb2312?B?V0ZGVFNpeW51aWJSdGJtTDRuS0t0enpIandsaTZQTkNveXM1RkE2eHF1TUg2?=
 =?gb2312?B?TEM4Q1ZMR3BSYjZ0cVRBNUJ3RnV6RXJySWJwMU9hTWtSc1RJeFlJd29WWG92?=
 =?gb2312?B?TkhrTWdoM0hLTFVscnpkMUtvWXA0a3VvZWQvN3M2UjFCWGJRcHdSaVpFbzRY?=
 =?gb2312?B?VGdtM28vOE93SExudTJjODBvRzhKOS8wcHc3SWRSL0FrUWNuYnp4cFhYaXp6?=
 =?gb2312?B?NXVDeDdKUi9BNE82Q1BWWUo4QitEV1IvRTBsa1VhTUlqMHU3cWRSM2JjSWsw?=
 =?gb2312?B?QVJSOG5xR3d2OUJoQnZnS3pzYzV2RUxMTHF1QVJmOWkxWTI3cVlTY2gvM1E2?=
 =?gb2312?B?VVZtdklxTTZCdDIyWVhKdGl0TURqRlQrakY5cmExbG8rcHY3UmVnKzJJQTYv?=
 =?gb2312?B?TG5oWnBzQ0QwMStaSzZGbmdLSnl5bWVqTVhCUUY2QjhxbXRqWWlRZ3ZkcDhE?=
 =?gb2312?B?aG9pdFlScGljVjU3M0hTQTZnMDZPNjZITDZTMmtEczhlODRadHRXYk90VHN1?=
 =?gb2312?B?bXZCSmplWXU2ZHc2L3M5WEZBKzd6S1YyOVkwcldFblRhelJOWlR4Z2VMdnNE?=
 =?gb2312?B?RURMMWg5YTY0VHNTRGhHUFJkYWZ3cGJ3anM2UUtlc3kxS1k3anZKWEhoamxO?=
 =?gb2312?B?cmRNT0RaaUx2OEpjS2t6YjFBVGdPT3lxbDh2UUlLTUJTTHdiL3o5R3JpWXc2?=
 =?gb2312?B?ZmlZeStZd2NkRnc1RkNFTVhjUFFpQk9oRHE0MGxwdURqMzJEVUg4eU5ETW1V?=
 =?gb2312?B?TlU3U3NDempwTHNCbUJCMkNYQnVQaHdWK0hkK2FaOEhWdVVhRXBxemNmUDN6?=
 =?gb2312?B?c1ZhQ3QrVCtZK2FPMUR1WVVReFVKdEk5ZW1XNW9rSC94OUNWKy9raFQxRldZ?=
 =?gb2312?B?NUhQWjQzZjUwbWtjOThZZGFsVkVqSFovTXlHYlFGTFM2M2ZuTXJSQzNHWEY1?=
 =?gb2312?B?dHVjbklza3pXaS9EbUc3aHNGZnRVVVJmaUlwYlBjVGR3aVcwSXc4SUFkeHBy?=
 =?gb2312?B?ME4vUG15Q29rMGF6Tzd5R2hxYWJ2bllUK00vc2hXOVh5Z3REUElUTlBpbGlZ?=
 =?gb2312?B?R0x6ZHhzN1plakNQVlhTYy96V1JrNHBPMVlPTDBBeDNvNTRsMlc0VGpicHJt?=
 =?gb2312?B?YktPTWlJWU1QL0xUQTBLYXJidDJ5Q0dHTnBHWXBaL3ZTNjNnMUFhUko4K1pp?=
 =?gb2312?B?c2g3bU1CdWZ5QndTbHR2eGw4Y3FTUmY5VzdUaCtPWEpVUjFRYkxrTmNzN0Jo?=
 =?gb2312?B?dnRRMlM3M3htWktCT0xDQ08vc28rekxxQkdzN0gxSHFGdHZBa0I1V1N0Rkxo?=
 =?gb2312?B?bUtjTXdYcDNTL2FDVXdVdFQzYUI5WXl0ZWNHZ2pBcTdpVTR6Rzg5UEpTV3NN?=
 =?gb2312?B?eXA0LzV6eDVlYUp4L0lTMnNRVVI4Yk9Ob1kxQzdiemF3Y3hGS2JVNmVZT0dI?=
 =?gb2312?B?aU5SL21Nb2lZbjR5T3VMTTNUSGQyU08zeXZmYVlsL2w1VE1NTmZycHN0cS9B?=
 =?gb2312?B?THdVRGRaMjJ4V0RoUEgwamM3VGVtVk1NZlBzdmp1Nkc1QmUrUEhhcHJaOVJa?=
 =?gb2312?Q?3mX/yD+sRu2MgWCS1e+2HFOlJjo76FbzqWtEFXp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: stfx.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1952bc-46bb-47ad-180c-08d8e895b10c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 16:08:08.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c46abc7-960b-4124-8950-1628b2b192f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBWCc4qjFVoAYUjVxS4E7SfUGMVc8ru3fC1jx74xU1rrYWg99VBBuWWF2tjeCOmbDQBe9LE7yiH1pxU7VUlCjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB4781
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QnV0IEkgZG9uJ3QgdGhpbmsgaXQncyBhIGdvb2QgaWRlYSB0byBoYW5kbGUgdGhpcyBpbiBjYWxs
ZXJzLCBiZWNhdXNlIGxvZ2ljYWxseSB0aGUgZnVuY3Rpb24gc2hvdWxkbid0IHJldHVybiBuZWdh
dGl2ZSB2YWx1ZXMuIFJldHVybmluZyAwIGRpcmVjdGx5IHdvdWxkIGFsbG93IGlkbGUgZ292ZXJu
b3JzIHRvIGdldCBhbm90aGVyIGNoYW5jZSB0byBzZWxlY3QgYWdhaW4uDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogWmhvdSBUaSAoeDIwMTljd20p
IDx4MjAxOWN3bUBzdGZ4LmNhPg0Kt6LLzcqxvOQ6IDIwMjHE6jPUwjE2yNUgMzo1Nw0KytW8/sjL
OiBSYWZhZWwgSi4gV3lzb2NraTsgRnJlZGVyaWMgV2Vpc2JlY2tlcjsgUGV0ZXIgWmlqbHN0cmEN
CrOty806IFRob21hcyBHbGVpeG5lcjsgTEtNTDsgWXVuZmVuZyBZZTsgUGF1bCBFIC4gTWNLZW5u
ZXk7IE1hcmNlbG8gVG9zYXR0aTsgSW5nbyBNb2xuYXI7IHJhZmFlbEBrZXJuZWwub3JnDQrW98zi
OiC72Li0OiBbUEFUQ0ggMDEvMTBdIHRpY2svbm9oejogUHJldmVudCB0aWNrX25vaHpfZ2V0X3Ns
ZWVwX2xlbmd0aCgpIGZyb20gcmV0dXJuaW5nIG5lZ2F0aXZlIHZhbHVlDQoNClllcywgdGhlIHJl
dHVybiBvZiBhIG5lZ2F0aXZlIG51bWJlciByZXN1bHRzIGluIGEgdmVyeSBsYXJnZSB1bnNpZ25l
ZCBpbnRlZ2VyLCB3aGljaCBpZGxlIGdvdmVybm9ycyB1c2UgYXMgYSBiYXNlbGluZSBwcmVkaWN0
aW9uIGZvciBmdXR1cmUgaW50ZXJydXB0cyBhbmQgdG8gY29ycmVjdCB0aGVpciBvd24gcGFyYW1l
dGVycy4gVGhpcyBwcm9ibGVtIGNhbiBsZWFkIHRvIHRoZSBzZWxlY3Rpb24gb2YgaWRsZSBzdGF0
ZXMgdGhhdCBhcmUgdG9vIGRlZXAsIHdoaWNoIGNhbiBiZSBkZXRyaW1lbnRhbCB0byBib3RoIGVu
ZXJneSBhbmQgcGVyZm9ybWFuY2UuDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCreivP7IyzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50
ZWwuY29tPg0Kt6LLzcqxvOQ6IDIwMjHE6jPUwjE2yNUgMzoyNg0KytW8/sjLOiBGcmVkZXJpYyBX
ZWlzYmVja2VyOyBQZXRlciBaaWpsc3RyYQ0Ks63LzTogVGhvbWFzIEdsZWl4bmVyOyBMS01MOyBa
aG91IFRpICh4MjAxOWN3bSk7IFl1bmZlbmcgWWU7IFBhdWwgRSAuIE1jS2VubmV5OyBNYXJjZWxv
IFRvc2F0dGk7IEluZ28gTW9sbmFyOyByYWZhZWxAa2VybmVsLm9yZw0K1vfM4jogUmU6IFtQQVRD
SCAwMS8xMF0gdGljay9ub2h6OiBQcmV2ZW50IHRpY2tfbm9oel9nZXRfc2xlZXBfbGVuZ3RoKCkg
ZnJvbSByZXR1cm5pbmcgbmVnYXRpdmUgdmFsdWUNCg0KT24gMy8xNi8yMDIxIDM6NTMgUE0sIEZy
ZWRlcmljIFdlaXNiZWNrZXIgd3JvdGU6DQo+IE9uIFR1ZSwgTWFyIDE2LCAyMDIxIGF0IDAzOjM1
OjM3UE0gKzAxMDAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4gT24gVHVlLCBNYXIgMTYsIDIw
MjEgYXQgMDI6Mzc6MDNQTSArMDEwMCwgRnJlZGVyaWMgV2Vpc2JlY2tlciB3cm90ZToNCj4+PiBP
biBUdWUsIE1hciAxNiwgMjAyMSBhdCAwMToyMToyOVBNICswMTAwLCBQZXRlciBaaWpsc3RyYSB3
cm90ZToNCj4+Pj4gT24gVGh1LCBNYXIgMTEsIDIwMjEgYXQgMDE6MzY6NTlQTSArMDEwMCwgRnJl
ZGVyaWMgV2Vpc2JlY2tlciB3cm90ZToNCj4+Pj4+IEZyb206ICJaaG91IFRpICh4MjAxOWN3bSki
IDx4MjAxOWN3bUBzdGZ4LmNhPg0KPj4+Pj4NCj4+Pj4+IElmIHRoZSBoYXJkd2FyZSBjbG9jayBo
YXBwZW5zIHRvIGZpcmUgaXRzIGludGVycnVwdHMgbGF0ZSwgdHdvIHBvc3NpYmxlDQo+Pj4+PiBp
c3N1ZXMgY2FuIGhhcHBlbiB3aGlsZSBjYWxsaW5nIHRpY2tfbm9oel9nZXRfc2xlZXBfbGVuZ3Ro
KCkuIEVpdGhlcjoNCj4+Pj4+DQo+Pj4+PiAxKSBUaGUgbmV4dCBjbG9ja2V2ZW50IGRldmljZSBl
dmVudCBpcyBkdWUgcGFzdCB0aGUgbGFzdCBpZGxlIGVudHJ5IHRpbWUuDQo+Pj4+Pg0KPj4+Pj4g
b3I6DQo+Pj4+Pg0KPj4+Pj4gMikgVGhlIGxhc3QgdGltZWtlZXBpbmcgdXBkYXRlIGhhcHBlbmVk
IGJlZm9yZSB0aGUgbGFzdCBpZGxlIGVudHJ5IHRpbWUNCj4+Pj4+ICAgICBhbmQgdGhlIG5leHQg
dGltZXIgY2FsbGJhY2sgZXhwaXJlcyBiZWZvcmUgdGhlIGxhc3QgaWRsZSBlbnRyeSB0aW1lLg0K
Pj4+Pj4NCj4+Pj4+IE1ha2Ugc3VyZSB0aGF0IGJvdGggY2FzZXMgYXJlIGhhbmRsZWQgdG8gYXZv
aWQgcmV0dXJuaW5nIGEgbmVnYXRpdmUNCj4+Pj4+IGR1cmF0aW9uIHRvIHRoZSBjcHVpZGxlIGdv
dmVybm9ycy4NCj4+Pj4gV2h5PyAuLi4gYW5kIHdvdWxkbid0IGl0IGJlIGNoZWFwZXIgdGhlIGZp
eCB0aGUgY2FsbGVyIHRvDQo+Pj4+IGNoZWNrIG5lZ2F0aXZlIG9uY2UsIGluc3RlYWQgb2YgYWRk
aW5nIHR3byBicmFuY2hlcyBoZXJlPw0KPj4+IFRoZXJlIGFyZSBhbHJlYWR5IHR3byBjYWxsZXJz
IGFuZCBwb3RlbnRpYWxseSB0d28gcmV0dXJuIHZhbHVlcyB0byBjaGVjaw0KPj4+IGZvciBlYWNo
IGJlY2F1c2UgdGhlIGZ1bmN0aW9uIHJldHVybnMgdHdvIHZhbHVlcy4NCj4+Pg0KPj4+IEknZCBy
YXRoZXIgbWFrZSB0aGUgQVBJIG1vcmUgcm9idXN0IGluc3RlYWQgb2YgZml4aW5nIGVhY2ggY2Fs
bGVycyBhbmQgd29ycnlpbmcNCj4+PiBhYm91dCBmdXR1cmUgb25lcy4NCj4+IEJ1dCB3aGF0J3Mg
dGhlIGFjdHVhbCBwcm9ibGVtPyBUaGUgQ2hhbmdlbG9nIGRvZXNuJ3Qgc2F5IHdoeSByZXR1cm5p
bmcgYQ0KPj4gbmVnYXRpdmUgdmFsdWUgaXMgYSBwcm9ibGVtLCBhbmQgaW4gZmFjdCB0aGUgcmV0
dXJuIHZhbHVlIGlzIGV4cGxpY2l0bHkNCj4+IHNpZ25lZC4NCj4+DQo+PiBBbnl3YXksIEkgZG9u
J3QgdGVycmlibHkgbWluZCB0aGUgcGF0Y2gsIEkgd2FzIGp1c3QgY29uZnVzZWQgYnkgdGhlIGxh
Y2sNCj4+IG9mIGFjdHVhbCBqdXN0aWZpY2F0aW9uLg0KPiBBbmQgeW91J3JlIHJpZ2h0LCB0aGUg
bW90aXZhdGlvbiBpcyBwdXJlIEZVRDogSSBkb24ndCBrbm93IGV4YWN0bHkNCj4gaG93IHRoZSBj
cHVpZGxlIGdvdmVybm9ycyBtYXkgcmVhY3QgdG8gc3VjaCBuZWdhdGl2ZSB2YWx1ZXMgYW5kIHNv
IHRoaXMNCj4gaXMganVzdCB0byBwcmV2ZW50IGZyb20gcG90ZW50aWFsIGFjY2lkZW50Lg0KPg0K
PiBSYWZhZWwsIGRvZXMgdGhhdCBsb29rIGhhcm1sZXNzIHRvIHlvdT8NCg0KTm8sIHRoaXMgaXMg
YSBwcm9ibGVtIG5vdy4gIEJvdGggZ292ZXJub3JzIHVzaW5nIHRoaXMgYXNzaWduIHRoZSByZXR1
cm4NCnZhbHVlIG9mIGl0IHRvIGEgdTY0IHZhciBhbmQgc28gbmVnYXRpdmUgdmFsdWVzIGNvbmZ1
c2UgdGhlbS4NCg0KVGhhdCBzYWlkIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gZGVhbCB3aXRoIHRo
ZSBpc3N1ZSBpbiB0aGUgY2FsbGVycy4NCg0KSSBjYW4gc2VuZCBhIHBhdGNoIGZvciB0aGF0IGlm
IG5lZWRlZC4NCg0KDQo=
