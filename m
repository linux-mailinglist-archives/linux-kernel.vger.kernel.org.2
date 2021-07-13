Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF3C3C734C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbhGMPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:34:02 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61472 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbhGMPeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626190271; x=1657726271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fS7e4jaLv5R4o9jqAlK3q5NmgS1KLdEcnDQICvkEOq4=;
  b=iy2HRzOMoEVvN6FkbAVt8c1e7B+5rx/+HDXLBz1l8n31mgltlUL5DOsJ
   wxRAR2wcwoqSon01JQ8MTNUv+KJorCxafTEJkJD1dYorDm3lvfmmK32lP
   KUmEcCsveS67xzIkejAIsNgjTxYCGFzS9USin5bbNvDhDYMzSwHRAkzU5
   4eWBOzM/ymBrhb25oL572AYkM06Sx3VxJM70yVq4riKE9js4R9KrWByz3
   2iHF9SVrEw3IkXnUdSJDrXGe42VhwMZl2SMGwszY1jhqaEhRH/VwcSgUh
   Hnt433Jc0hrc1U1jxn5ZIPqIe1Hx8EXFGgUyHz/71HXC1njHCaFsNQhaL
   Q==;
IronPort-SDR: GULcsuWKrEasYVa0BlZDtqWwHIk6LSqw9XuffvSuOv3plelW5sx3qd2uoqZ8mAM2nKDp4IPYNw
 FjPM0TDQc/8n7P3TQlB/gAIgVJ5FnpUjUGjhu5W+KkDwHLmWMyYaeZcuAoQzDI7PjMusV5c62+
 OMJPGqkTN8Z1/d/szzg0+Ud0eFcKxN7uhzd0M4Xy0n5/Q6VZf2bMBOT31LtLpkgiE1Mw0+ol4w
 J7WzBLosMXuSvWK9YEfeVxPnAW9k2vDGJRKcZ+f1J/ePaUuoieIfCqPCRId0SNuXuV2wslgCxa
 LXY=
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="124408891"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2021 08:31:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 08:31:03 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Tue, 13 Jul 2021 08:31:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQL2Y/j2opZZwREXySB+EhBnlkILJE0RV2OSKfPFyJ8x+PQ6TYbGBFDrIc/7qIxmbMMkFkZhFjBUlZo01+Y+Ugn6E/usG9s2JRh8nnFTcL1HxNJeeBI9j/FRbVD1as/98EyXK+ikBRKeOfDYbPtdHRWkwypgcIeUjfrtENuc5hz0dY3OWNpuh1wYdMnN290CyPck3fWBMxS/o6Kgzs1m/7TtI+q5JYxy3zK5/bGJjZsPu8+pBWcv2uIQtailwl2iaF7hvxumchfV/BcR5dtylPTuWPgSgk1lK94EqD9RPAazYokbvt62qd0xHgYwiWQsyfXt0JlZRhcNpSEiEak3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS7e4jaLv5R4o9jqAlK3q5NmgS1KLdEcnDQICvkEOq4=;
 b=mKo7pyVpOf7a0e0Sn4CIMO92nnD2Su/Vhmj9jl/SC5TW1zcmR9Fn8bj+ICVV1kpAmh7Gu/LLtowyD9pBON3Qwa1pkPs/gf4XKQafR08DNunp3afQfDESqmWxO9h1iXLqejHtTN+z2eqKu7wNX7GRUscAmPNpzoNmATrF4X5bha01lID1u07n3KjHX2Forn+iXPk3wgsien5bR5c+Z21wt5QyJUA6WsbfExqkIv9wrbgvuaT9+J7jyiCIfZxXKw9H1r31CDEqoqRRA5Th/DW4T/9zMjENyElg5hDBKl29kd0MjFztov7pqmfQLGoo3sdiikiV0ID1ka6GGM8Jq8+Z6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS7e4jaLv5R4o9jqAlK3q5NmgS1KLdEcnDQICvkEOq4=;
 b=ImLwbcaZiaASEu3YdMh+pzyhL5bGcIx/hs1TzRzKGAZrzVyaGjYpZdERTlZOywGPPoITi/yjNex3eI/ISdGed7FB9sWmgQm8k1C0AWJ96DRALteXwUl5UQIXQkJnLL8TEPcXtlfctxBBKxKSBV2KGB+PDSwAi5U3XnPjsXyxXCI=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by PH0PR11MB5157.namprd11.prod.outlook.com (2603:10b6:510:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Tue, 13 Jul
 2021 15:31:02 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::a825:537d:74ba:2aaf]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::a825:537d:74ba:2aaf%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 15:31:02 +0000
From:   <Conor.Dooley@microchip.com>
To:     <bmeng.cn@gmail.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <atish.patra@wdc.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <bin.meng@windriver.com>
Subject: Re: [PATCH] riscv: dts: microchip: Define hart clocks
Thread-Topic: [PATCH] riscv: dts: microchip: Define hart clocks
Thread-Index: AQHXYni+ww8V9O36KECu4yl9LqyAo6tBMzmA
Date:   Tue, 13 Jul 2021 15:31:02 +0000
Message-ID: <cd14275c-4a81-ad92-ffc7-d81ead203fad@microchip.com>
References: <20210616062739.398790-1-bmeng.cn@gmail.com>
In-Reply-To: <20210616062739.398790-1-bmeng.cn@gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 769eadc0-22ed-47d6-e8b0-08d946133919
x-ms-traffictypediagnostic: PH0PR11MB5157:
x-microsoft-antispam-prvs: <PH0PR11MB515733CFD6E22048F3B1E95A98149@PH0PR11MB5157.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9xRZG8cms5Q/BBGr+VBbC0ncHIvw6Y/gofCO7VXdpc24DtM18bqdGygK6WLXYj1RkxHRHqrPaOXZd6bpN/P7gsh6ahizHlUo/WAbc7Gu72RwYSnDbVZAatJZ5V3HL3NsRaNw1shr2qbXH7NrZfutgvOoH2E7o9VzHUUqLAcxCCSehX3gpM3CD8pU6cdmmksZEsK12En3kXNQxGUnoS6JmplyujojYYywkhwxvnjAMdQAusS9/X441CSoHxKoaFtYttUa/K+ip3rC4101R69zgjJBS0sCWZCZ/Xy9GhE2LqqnlCH9HAPNHw900qOVk0l3TMDWtoZmKMm0Rc1eSL7qLWUsIF71h5zZE0rxDgInd0MpB/CvNJNKa3rmro7Hkbkb8GLAbV3UQ0zBn/ZnHiWWQcXWyZ3YZU4/GPytEkRb6yFtzVl3qVqO8y496Af5MxVMWUq49zpOKBb9QpGjPj3aNbaBsteBuHkXXPDKyTSdiZMd1tUljs3nPs1Ukuibk8Gpl7ETdVAhJXatL6aF7Gpop3im0m/Uvj+LTOKXPcI2rqm3fP/t2y34Tm7hk9QhzOLlyNE7/IL2kRrXIF13ZUI6JR2tySrzeQ3GsMy5bVOFvD/lFf2oGf3rm+RISoTw8QoeDBM1rONcjP4Mrs1J2FdGV27s01g3j6s49IpHPmy38WNI+9twd2zkqidlmzWcqkNjc3KLpSs2dC7bbmCc5jEPR/bVIDa+ezOaK4XQX6w0WysNQwTdcFdXqvhQyPQUTZdCRSBMkLIQdOdFPKzV+yRpW/AyY5aI1s4msAVFXLMkAN9E4k+M/FJYqlqUpBSXbqnw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(366004)(136003)(376002)(6512007)(2616005)(36756003)(31696002)(966005)(122000001)(6486002)(4326008)(110136005)(8936002)(8676002)(316002)(91956017)(6506007)(76116006)(5660300002)(83380400001)(66556008)(86362001)(2906002)(66946007)(66476007)(66446008)(478600001)(31686004)(186003)(53546011)(38100700002)(26005)(71200400001)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVBKYnE3OWNocktHSzdpRFF0UXZPRUdmVU05aDNiTzdtR2gwR09VZFBkWlVz?=
 =?utf-8?B?cEJtQ3JkVUNqQWwybGg2dnBnTzlLa05UeVZSTW5XOWcwQXo1Tzh4NFQwSzc5?=
 =?utf-8?B?NjFHOXZSVEljNTdDUVZuajNUcEllaUE3RXcwcmowVmJwYVBkR2ZiSWRKOFNB?=
 =?utf-8?B?MHlwVGR5NnM4N1F2OUlVbFkrVUFBMUlxVW9hdCtTYVhJb2Rxa2ZSdmJjOFZ1?=
 =?utf-8?B?SXJ3Z0E3VlVZMnVMUkExWVlJQnNpbWhDSXZCQ0xDNUI1NFVpMGI1WDBwUVg4?=
 =?utf-8?B?M2t5MEg2RVJqeHRtNFV6ZXZRQmpaUGhUb3R0MGoyQ3R0T2N4b0V2S3l3dkgx?=
 =?utf-8?B?bVhxTkNUUDQyanNkT1pjL2toNDZ5TWdoZjBILzRCcXU1NWU2SXRneHRwL0tG?=
 =?utf-8?B?bVc5R1k5QlFOYlRHbWNhSm5PSlduNXg0RTRCNmR4WWkyU1ZCUDUxRE1vQzZv?=
 =?utf-8?B?REpPTUVmWmhGV2dFT1lXY0xoVWpqTkJqL1ZKN0pNVFZReHNtbFNkVGY4amF5?=
 =?utf-8?B?Q2NhNnhBTEFyUDc5MnBpZW5Oam54RDJnZHZnTUxScEpIdi9zUnpDNm9ScEVD?=
 =?utf-8?B?SnRBdGo1QnpyQVRIUkc1ZHIzOE54STJWdlVnOERGQzBWcmgvQkxMUk1hRk9U?=
 =?utf-8?B?ZWdSNGtWQ1NLZlhhWE9reEhOdE56S2xVWHZhL0dUNkYwQnJzVkpZWm1rNWVH?=
 =?utf-8?B?bnJYK1VQdlpTa2JQeHZzeWtOc2g4N2JnS1dwYTdFQkpkVWRORnJLbFF3clM1?=
 =?utf-8?B?UHBSa08xUXhYc0drUzB4WmRyUWx6SWMzSy9JMlFzR3N2Y3lxNUxkLzNUbWEx?=
 =?utf-8?B?dUlRODJLbEFzemtxK2hZZzZGRElPcFErbzdGNGNGR1BOVkZXUVcrWUNwSGRH?=
 =?utf-8?B?WDEwT3VacTJqbW9zcmpNRGd2TXdDZHhtTzVVbS9nWnR6SUU4WVhxbzljdFJC?=
 =?utf-8?B?SHJhSXdZNjJPNzlhaXJ1dkdZK3lDM3NaMTRMdmoxU2d4aEw3Y2VPNEFBa3Qz?=
 =?utf-8?B?MEFTVDNHUEpCYVRVTEhlUk5mQWZZUkY0MUdLQm8zUmxYbWJqWnI2dktZaGw5?=
 =?utf-8?B?N29ack8rRTRrQ1BSZ3pkYktIcFBacWR0b1dnVzN6SEpCZzMvWnEwS2JEUXl1?=
 =?utf-8?B?NE15Z0lnK1dXbDZOU01IRTg0VXl0Q3JxOGp4L1hubjZUamszaTI5aXFZZmIy?=
 =?utf-8?B?TFNkM2kwajEyNDUydHlNeExZSEEvT1pibW04OVh6M1Q4ZXM4czFEWFJjUWVC?=
 =?utf-8?B?MW9XWkdHMmR5c0Y5Y0tSekgrdTNTbjNLOXpRWXhraTdaVTNzYzZNajVQdDNK?=
 =?utf-8?B?dHIrdHdKQWJkcDRsM2hCTVdITUV2YVVTdzk3aVZHSi9KZ0I5RHl3WnlKeWNC?=
 =?utf-8?B?RVpZZlZ6OWNlOEdzQ2ZxaEszQkhBY24wSW0xQkl5YjNSWDBCWHJaQmRkWGFs?=
 =?utf-8?B?VzZwWDNCaGJWTVlRRm0wM1pSdExVSW42Q21iV2F3N1pqeVMrU3daZ1hMaThL?=
 =?utf-8?B?WXI1c0JENStSNnRHd0VjYUgzRnJOaThxNjUyVGVnNmRGNFJaUWsrSXlIL3hV?=
 =?utf-8?B?REVBc3VPSUJkb2pLcHJXRDZWa0FKZW1KaUtYbklReHpYU2hwRko1bm55MU1K?=
 =?utf-8?B?ODlLVVR4M1M1SFVNNXlKbllUUWFpWmpxYkdOaDhNMlhwbGZHcFZIdjBRZ0py?=
 =?utf-8?B?VDdDK0s1dnN0Mm1KRUdEd3diVG5kNzJ0Ri8wbkdmNXpXTDBESW9JU1RHcWNk?=
 =?utf-8?Q?mziCkU8VoqwRQQe8WyaYbcd4XjtYKpxVsJo1D6E?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FD7CC67539AA64F928B4934EC22D8A9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769eadc0-22ed-47d6-e8b0-08d946133919
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 15:31:02.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pI8MpUcAH1nFTWsLuzoq57pHMVSBgW95HY5I7kFKl/zJHNOWbKAlAhmUOkOMqhDQHMnfoBGSKR/9yAU+hI8Z+QAxEUUe68dy2cKxwO6srcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDYvMjAyMSAwNzoyNywgQmluIE1lbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBGcm9tOiBCaW4gTWVuZyA8YmluLm1lbmdAd2luZHJpdmVy
LmNvbT4NCj4NCj4gRGVjbGFyZSB0aGF0IGVhY2ggaGFydCBpbiB0aGUgRFQgaXMgY2xvY2tlZCBi
eSA8JmNsa2NmZyAwPi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQmluIE1lbmcgPGJpbi5tZW5nQHdp
bmRyaXZlci5jb20+DQo+DQo+IC0tLQ0KPiBTaW1pbGFyIHRvIGh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC1yaXNjdi9wYXRjaC8xNTkyMzA4ODY0LTMwMjA1LTMtZ2l0
LXNlbmQtZW1haWwteWFzaC5zaGFoQHNpZml2ZS5jb20vLA0KPiB0aGlzIGFkZHMgdGhlIHNhbWUg
PGNsb2NrPiBwcm9wZXJ0eSB0byBQb2xhckZpcmUgU29DIENQVSBub2RlcyBzbyB0aGF0IHdlIGNh
bg0KPiBjYWxjdWxhdGUgdGhlIHJ1bm5pbmcgZnJlcXVlbmN5IG9mIHRoZSBoYXJ0Lg0KPg0KPiAg
IGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kgfCA1ICsr
KysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaSBiL2Fy
Y2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kNCj4gaW5kZXgg
YTAwZDlkYzU2MGQzLi4wNjU5MDY4YjYyZjcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9v
dC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kNCj4gKysrIGIvYXJjaC9yaXNjdi9i
b290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaQ0KPiBAQCAtMjQsNiArMjQsNyBA
QCBjcHVAMCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBpLWNhY2hlLXNpemUgPSA8MTYz
ODQ+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmlzY3YsaXNhID0gInJ2NjRpbWFjIjsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgY2xvY2tzID0gPCZjbGtjZmcgMD47DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1
MF9pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+IEBAIC01MCw2ICs1MSw3IEBAIGNwdUAx
IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwxPjsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIHJpc2N2LGlzYSA9ICJydjY0aW1hZmRjIjsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgIHRsYi1zcGxpdDsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0g
PCZjbGtjZmcgMD47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7
DQo+DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBjcHUxX2ludGM6IGludGVycnVwdC1jb250
cm9sbGVyIHsNCj4gQEAgLTc2LDYgKzc4LDcgQEAgY3B1QDIgew0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmVnID0gPDI+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgcmlzY3YsaXNh
ID0gInJ2NjRpbWFmZGMiOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgdGxiLXNwbGl0Ow0K
PiArICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsa2NmZyAwPjsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4NCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgIGNwdTJfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXIgew0KPiBAQCAtMTAyLDYg
KzEwNSw3IEBAIGNwdUAzIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwzPjsN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJpc2N2LGlzYSA9ICJydjY0aW1hZmRjIjsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIHRsYi1zcGxpdDsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgY2xvY2tzID0gPCZjbGtjZmcgMD47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBz
dGF0dXMgPSAib2theSI7DQo+DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBjcHUzX2ludGM6
IGludGVycnVwdC1jb250cm9sbGVyIHsNCj4gQEAgLTEyOCw2ICsxMzIsNyBAQCBjcHVANCB7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8ND47DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICByaXNjdixpc2EgPSAicnY2NGltYWZkYyI7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICB0bGItc3BsaXQ7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xr
Y2ZnIDA+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgY3B1NF9pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8
MT47DQo+IC0tDQo+IDIuMjUuMQ0KPg0KDQpSZXZpZXdlZC1ieTogY29ub3IgZG9vbGV5PGNvbm9y
LmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiBsaW51eC1y
aXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg0KDQo=
