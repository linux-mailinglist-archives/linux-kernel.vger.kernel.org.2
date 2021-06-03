Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F363C3999A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 07:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhFCFKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 01:10:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48358 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFCFKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 01:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622696936; x=1654232936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nNbisC93iuJidKcb8P6kOt8/b0X1T0tjp01DtC4rHbo=;
  b=AeXG+fttzmB1+ZjL1IzHG77oCYJWQ9tdw+tLCi75ezXpfC2ekhxIINuz
   Oqr05GPL6N66Ab1L02t1lH4Ip6slm4Uvljp2I6tsU/QGoDHB2o8DVo7t8
   vCdARdIGEGP7AxY0OY9oDZEggIXd4CuMEOEAEi8d+s/zHi5V8514sxyzJ
   qNB6ecb+iyUp0yTX0zjcy6UwVvLTTekkkHexuaW5+/Jw/leNh5QTOZJCR
   OhEzD6z+Lv34Cw6L1j/JseX01d8yUZ+rhSEVhjS3NrNwh43VXbRgrSN7j
   RcxBqbYVQOm7QikmIR7/45dk9Db8f/kZ2RW8r/EAiwBjL6+MtUy4AB6Jo
   A==;
IronPort-SDR: 7Jhs2BRm8xoomFE1ONQNFYAVUcF38Xmn3oohOZSDCFnqYziHjEOT+U2u+uWQZOu+dbLvvCSXin
 e9c1sZWQ1gearEjEz7JM98XNngwX//ayYRyY8Z50dO95jrzLbzLHaZpCSRIQxmFXH87nez7CzE
 utodoj6pIbbNe04QuIlNWzy1D+5YeCalm2NqbTi/A7+4J3iwNehZhElRvJgnNLEUiX2V1FHi7j
 cJXsioQQ5ghXRw4YQwJXHbEvZDqyjNIvf6D6IJLg1C3spNDBioaX7kaYQa73qqj5hCtd58rYET
 X/k=
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="120062301"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jun 2021 22:08:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 22:08:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Wed, 2 Jun 2021 22:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaSdQMhN0XC7qN0AbyCgycbe/7xW3gNIx9BHea0ZEDrSnqhvKGqFRMVzX/FwKSq8GJ6ugEJPR77e69KXCq/RE30+TPkIGgy0sAfAnH0GEfgRg4KjO3oVGd7YmPux123ai0kYz8kg32hvla22yEI/nikRzCst0dlq6TTGq6OutdklKtkSA8C8+BLJwFbd2ovy1FAVVqNO9o8vblD/VP37Jf5jqSf6pqE+7/otmUMK2xJ/hBaKv2hO8m5dblT+odiEbtOPwvLqsCt832B2+iHotsH4OUegB1OyJJt9t8nswK0u6JWn4gS0nNSJdshHKviY3H6k82eHFVT9TrCQ3YDhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNbisC93iuJidKcb8P6kOt8/b0X1T0tjp01DtC4rHbo=;
 b=NTvkd2vbaAwXW1MNRLpcbfX86onhKN4k5Dmk1fukBGaUijRvaGTX8DLrPCty91gSRcfN4NAesNi/ZFIdvExvI3iVYiTPs9V1d0s3fzzDI7ysr181qbnz+irYZnYT00jshCk1dRcq8WPScTQ7/0BIy8mZJSRomXN5/YQGQOiLZ3Mm3VyGYWtyr72D5LPi2fVNqWtX1WpSc+gEKLnglHs9ikiOnlCy3n2wxRJ+gDK+LaDVTX7bICldb3T9sjm/x0Wqyb+TRVaA37Heer0PoxMJTtUr3QjRJd+b/AxLDFRsm+VZXjWJvHB2OxEobt8fqrf1sKCw+56q6Pblv0u0yPpoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNbisC93iuJidKcb8P6kOt8/b0X1T0tjp01DtC4rHbo=;
 b=Y2EE73SCgHYg9xsZXMZSEgFPdFdo7gzso0A5LN7qn/iLoxUCKQTgkxISMYyUieb2GV6FvvbXod/0RUCK60hxIxqFvpPASkVCR8A/Svw9rHnvgLM8ac2RpRHAiejWFn3AdhhdTYliWeWt5gBY6j6hBIf+ZPFtSZBUXpQ20e3MlFg=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR11MB1840.namprd11.prod.outlook.com (2603:10b6:300:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 3 Jun
 2021 05:08:29 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 05:08:29 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v4 4/4] mtd: spi-nor: otp: implement erase for Winbond and
 similar flashes
Thread-Topic: [PATCH v4 4/4] mtd: spi-nor: otp: implement erase for Winbond
 and similar flashes
Thread-Index: AQHXVfre5CE4GzTJPUCkLlU8wI3quw==
Date:   Thu, 3 Jun 2021 05:08:29 +0000
Message-ID: <f788aaf1-71a6-85c3-1e57-2c9c0099ea83@microchip.com>
References: <20210521194034.15249-1-michael@walle.cc>
 <20210521194034.15249-5-michael@walle.cc>
 <2d04a7f5-c99e-3177-5a1f-debe49f51ef5@microchip.com>
 <6c8539c4fcfa1e58446826c24fd4e539@walle.cc>
In-Reply-To: <6c8539c4fcfa1e58446826c24fd4e539@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f94539ad-fd02-4452-675a-08d9264da034
x-ms-traffictypediagnostic: MWHPR11MB1840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1840CE7D37C9111E3E5DEF6BF03C9@MWHPR11MB1840.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5bF9Gt4VwqB3Vn1jv69BYREovLe6KtMBvdolSzeHrAZ5z9MHGJEevf6NKl2KIaDF/jkNx36ZSZiFArRXLkN56OYoiBgYeTbqcDLQZFr5Mo3It4XLPitZbz20VUZU8LDaqZcEYMiIriSW0s6cYRMTsX+yxLL8PMLTrur+nnW1p6I7xHIE8ndYfIqqatwdAYliIq2M6gq7my/gaAE0us+pKG6R8b8XrbZICY6lotrov2KSm6+RKnY88u/q8GG9+dt7/bnLtjzKwmZIZ+tr9LKEeoS43Ck9YDMsWYJzkrLpCIHb+wtuOudhspNjGLjYpODKTqVw372h4d+caClZIDUnSImrbL9nAFOttBOQtwDKG101ZEkpUtnCgcikEDi0f5Vfj+7lh1kpP9wwLQUVnYegn5l1/KgVdFy6iM7BUPPJPT9rUzKa+aHZLFD62Tvc+4DgQEWS86/BHPT4oYCQSlNry06Ps77rLuziQMcgfQKK5NuTmhx58NKbeD2h3fvG7mbN7YG3hAMt+4a64tqSTjwZwFs7seZTd0G5MA4BUeXoGtkZ9Pv6g7Wohy31fTTE6tY8H+dVElIZsVC6FvkDQyoyh6AlWtoLgkaDR5tGIhR/af3pFpg5BGATY0dmHCtYUJ9gasLMG7zs/vTqxedp7AWNpiV2njlO77J3giUMWVTujfsf3M+AeZNhY91QaSlh/IL8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(39860400002)(396003)(478600001)(5660300002)(26005)(186003)(122000001)(86362001)(36756003)(76116006)(91956017)(66446008)(66476007)(66556008)(64756008)(66946007)(54906003)(38100700002)(6916009)(8936002)(2906002)(8676002)(6506007)(6486002)(71200400001)(31686004)(83380400001)(31696002)(6512007)(2616005)(53546011)(4326008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WWRaOWt0YlZIUS9PdGZ4STdZWXNZZ3NJTTRZVm1ub2tHWGdLL3ZZbXZkYTdi?=
 =?utf-8?B?UjZnWmpTd3hON3VIbFovektaRlQyb1J6MEE1TEZDWm9TVG9wMHVGRTgySDFK?=
 =?utf-8?B?c1I0Wm5zdWpCUFhzUHVZTDlJQjBtMit2NS9uUFVqTnJlazNwVXZoTEl3UjRV?=
 =?utf-8?B?bllzNHJjK1FoTU94Z3JZc1UxR0MzRFM1R3h4UmUxUU5DUVYvTU52RUtuZTBr?=
 =?utf-8?B?TzV3clk0R0ExdmtaV2s2WUtvdEs2dHh6VXdwRmYxQTJlZG9tS3VFbWFUZjRC?=
 =?utf-8?B?TnZ4cXFuNjBVd0RhZDdLSnBiNHBJeUJkbWcwelR2OVVNUTJKTDE2T0lKWFBn?=
 =?utf-8?B?Q1lsZkd4MFBYTVdhT3cyUy9ZZVUvQkZGeDd1MExZdWQ3U1VtMFF0TXQvL1Rq?=
 =?utf-8?B?S2RRTW9zb0hKRXhOeVhUeFo0UTNpSStZbGVEWWxISExFenJ2U3k5YWtrM2RS?=
 =?utf-8?B?SUdmV05PaiswcWNMeXFiZmdZVjZvdVhESVE0czRWZjNtQXRMZkZ3Z1RJdVRX?=
 =?utf-8?B?cGpFbm5zcG9uUnc0MmhTcFFZTkRDclpLckFhZndZNjlucU9ERlgrT0dURC9t?=
 =?utf-8?B?bXl1V1hWeS8zZE9uRXR3Tkl1SzdONkdFeUZjN3NLdUI3QkExU1paeTA2eUlV?=
 =?utf-8?B?SXBQdkhLaWYvWG9iZUNyLzF0TXQvSXlyNjFxbGVTK2VLbkllbm9Cb1pZb0ds?=
 =?utf-8?B?VHpLMlRMN0RURkR0UE5QZUpvQzc3MGcxMmJ3NnFJYzk3RndDZGVaMXZ3UHha?=
 =?utf-8?B?ZWtkNmt1NnVmM09FYWdGSmJnQTlMSElZbVA0dTBnN0RuZTVhUm1ZR0pWY0tI?=
 =?utf-8?B?VjkyWlB0aVU0U1d5aHVPWVZ4N0NsVDR1S2NhczNhdU8rNVlhWnYxZlBvMDcw?=
 =?utf-8?B?UnEwQmVoSzIwRllTWHhoVEZUT1lEdDd2SFR3am1xaWJEcVN2Wkdqbi9yNEVv?=
 =?utf-8?B?UXZWbEsvTzJqTHM4TFIrblM2MUVkbWh5ek5XMzV2YkdsK3BYRGNERHpkUkc3?=
 =?utf-8?B?am1uRmtYL0xFUjZzbU43MGtQVFdUckJETU1FaHZWMlhNL2tydjgvd3ZHY3Rk?=
 =?utf-8?B?cFMwVE5aUVR6Yk5nZjNBZjh5enh2dmRZMUtKRFNLQ2NMNHhEZ3V1WWU0WStP?=
 =?utf-8?B?Q1Q5bGU0bWZiZjEwRndQTDlEQW1sQjhHRmFZV3lLN3JhODM5RURBRGRyVDFE?=
 =?utf-8?B?bXcvaC9qNW1OV3UrTE9vbUdnMks3MTFoL1dLMG1MZHhhVlUyYUw2ZUFsbXJs?=
 =?utf-8?B?RlJpVFpoSVdDWWVnTHI4NzVBNFplRVl5RDFhbVE1cVlURUZNU3Z1WHZqOWl1?=
 =?utf-8?B?SytoWC83eC9oUlpwaVhjSS9nZStrWHFvSDhuYURxVk1RQS9oZ1l2M1NWNktB?=
 =?utf-8?B?bTYzeld2clBnazRtMmp1QUJ6emNHYmpuNEVvSFhJaFJpMG0zRlM3UDJ5R0RE?=
 =?utf-8?B?VFZEYjQxUGcxRk4vZC8xUmJrRE5Ld1RyVnJRKzVUeElBSDZrcUYrejhHb2pw?=
 =?utf-8?B?dkE1bkE1a0tVR1o3Y0hmLzhMZTAzOHB1NXRVOTJkREFZWnJsd1BoUkVBV2VU?=
 =?utf-8?B?UmRwUDBsOHUwQjZCYll2VlRQTmFZdVd5ZVI0Q1BMZG1jUE1nQU10Q1FaMHFZ?=
 =?utf-8?B?eHBSdFFNejJGU0ZpY1QvbVpuSDVGakszNTZGaGtWdTNIVUFoRnFhb28zRlQ0?=
 =?utf-8?B?b1RXeFd3Vm4xMXdTZTBZMk4waTdVbVFHdTZURURSUnRpdHVVMTZFdVFNWmpw?=
 =?utf-8?Q?Jnbm5vfvNL1XTOiIb4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <737CFFF363AACD4B9C31677085D0A33D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94539ad-fd02-4452-675a-08d9264da034
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 05:08:29.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtVEoNUW96GSebiSkuUMwKHLTVA1crvh31W9Tks1ee910FRppGTNUiA0WblvUim4jae9IHbGjX5M6xxAJw0SO1sAv3jV9eJZEnn/zMIKLVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1840
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xLzIxIDQ6MzAgUE0sIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQW0gMjAyMS0wNS0zMSAxMDo1Niwgc2NocmllYiBU
dWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb206DQo+PiBPbiA1LzIxLzIxIDEwOjQwIFBNLCBNaWNo
YWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiB0aGUgY29udGVudCBpcyBz
YWZlDQo+Pj4NCj4+PiBXaW5ib25kIGZsYXNoZXMgd2l0aCBPVFAgc3VwcG9ydCBwcm92aWRlIGEg
Y29tbWFuZCB0byBlcmFzZSB0aGUgT1RQDQo+Pj4gZGF0YS4gVGhpcyBtaWdodCBjb21lIGluIGhh
bmR5IGR1cmluZyBkZXZlbG9wbWVudC4NCj4+Pg0KPj4+IFRoaXMgd2FzIHRlc3RlZCB3aXRoIGEg
V2luYm9uZCBXMjVRMzJKVyBvbiBhIExTMTAyOEEgU29DIHdpdGggdGhlDQo+Pj4gTlhQIEZTUEkg
Y29udHJvbGxlci4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hh
ZWxAd2FsbGUuY2M+DQo+Pj4gLS0tDQo+Pj4gwqBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuY8Kg
wqDCoCB8wqAgMiArLQ0KPj4+IMKgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmjCoMKgwqAgfMKg
IDQgKysNCj4+PiDCoGRyaXZlcnMvbXRkL3NwaS1ub3Ivb3RwLmPCoMKgwqDCoCB8IDgzDQo+Pj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiDCoGRyaXZlcnMvbXRkL3Nw
aS1ub3Ivd2luYm9uZC5jIHzCoCAxICsNCj4+PiDCoDQgZmlsZXMgY2hhbmdlZCwgODkgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+PiBpbmRleCBi
ZDJjNzcxN2ViMTAuLjk1NTFlZmZiNmE0NCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+Pj4g
QEAgLTEzMTgsNyArMTMxOCw3IEBAIHN0YXRpYyB1MzIgc3BpX25vcl9jb252ZXJ0X2FkZHIoc3Ry
dWN0IHNwaV9ub3INCj4+PiAqbm9yLCBsb2ZmX3QgYWRkcikNCj4+PiDCoC8qDQo+Pj4gwqAgKiBJ
bml0aWF0ZSB0aGUgZXJhc3VyZSBvZiBhIHNpbmdsZSBzZWN0b3INCj4+PiDCoCAqLw0KPj4+IC1z
dGF0aWMgaW50IHNwaV9ub3JfZXJhc2Vfc2VjdG9yKHN0cnVjdCBzcGlfbm9yICpub3IsIHUzMiBh
ZGRyKQ0KPj4+ICtpbnQgc3BpX25vcl9lcmFzZV9zZWN0b3Ioc3RydWN0IHNwaV9ub3IgKm5vciwg
dTMyIGFkZHIpDQo+Pj4gwqB7DQo+Pj4gwqDCoMKgwqDCoMKgwqAgaW50IGk7DQo+Pj4NCj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggYi9kcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuaA0KPj4+IGluZGV4IDI4YTJlMGJlOTdhMy4uOTM5OGE4NzM4ODU3IDEwMDY0NA0K
Pj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+Pj4gKysrIGIvZHJpdmVycy9t
dGQvc3BpLW5vci9jb3JlLmgNCj4+PiBAQCAtMjA3LDYgKzIwNyw3IEBAIHN0cnVjdCBzcGlfbm9y
X290cF9vcmdhbml6YXRpb24gew0KPj4+IMKgICogQHJlYWQ6wqDCoMKgwqDCoCByZWFkIGZyb20g
dGhlIFNQSSBOT1IgT1RQIGFyZWEuDQo+Pj4gwqAgKiBAd3JpdGU6wqDCoMKgwqAgd3JpdGUgdG8g
dGhlIFNQSSBOT1IgT1RQIGFyZWEuDQo+Pj4gwqAgKiBAbG9jazrCoMKgwqDCoMKgIGxvY2sgYW4g
T1RQIHJlZ2lvbi4NCj4+PiArICogQGVyYXNlOsKgwqDCoMKgIGVyYXNlIGFuIE9UUCByZWdpb24u
DQo+Pj4gwqAgKiBAaXNfbG9ja2VkOiBjaGVjayBpZiBhbiBPVFAgcmVnaW9uIG9mIHRoZSBTUEkg
Tk9SIGlzIGxvY2tlZC4NCj4+PiDCoCAqLw0KPj4+IMKgc3RydWN0IHNwaV9ub3Jfb3RwX29wcyB7
DQo+Pj4gQEAgLTIxNCw2ICsyMTUsNyBAQCBzdHJ1Y3Qgc3BpX25vcl9vdHBfb3BzIHsNCj4+PiDC
oMKgwqDCoMKgwqDCoCBpbnQgKCp3cml0ZSkoc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IGFk
ZHIsIHNpemVfdCBsZW4sDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb25zdCB1OCAqYnVmKTsNCj4+PiDCoMKgwqDCoMKgwqDCoCBpbnQgKCpsb2NrKShzdHJ1
Y3Qgc3BpX25vciAqbm9yLCB1bnNpZ25lZCBpbnQgcmVnaW9uKTsNCj4+PiArwqDCoMKgwqDCoMKg
IGludCAoKmVyYXNlKShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3QgYWRkcik7DQo+Pg0KPj4g
bWF5YmUgYmV0dGVyOg0KPj4gaW50ICgqZXJhc2UpKHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZf
dCBhZGRyLCBzaXplX3QgbGVuKTsNCj4gDQo+IFJpZ2h0IG5vdyB0aGVzZSBvcHMgcmVwcmVzZW50
IHdoYXQgaXMgc2VudCB0byB0aGUgaGFyZHdhcmUuIFRoZSBhZGRyZXNzDQo+IGlzIHdoYXQgaXMg
cmVhbGx5IHNlbnQgb3ZlciB0aGUgd2lyZS4gVGhlIHJlYWQgYW5kIHdyaXRlIGhhcyB0aGUgc2Ft
ZQ0KPiBzZW1hbnRpY3MgKGFuZCBsaW1pdGF0aW9ucywgbGlrZSB5b3UgY2FuJ3QgY3Jvc3MgcmVn
aW9uIGJvdW5kYXJpZXMgZXRjKS4NCj4gDQo+IEFzIHRoZXJlIGlzIG9ubHkgb25lIGtpbmQgb2Yg
bWV0aG9kIHRvIGFjY2VzcyBPVFAgcmlnaHQgbm93LCBJIHdvdWxkbid0DQo+IHdhbnQgdG8gcHJl
bWF0dXJlbHkgb3B0aW1pemUgaXQgZm9yIGZ1dHVyZSBvbmVzLiBJdCBpcyBlYXN5IHRvIGNoYW5n
ZQ0KPiBhZnRlcndhcmRzIGlmIHRoZXJlIGlzIG5lZWQgdG8uIEFuZCBzdXBwbHlpbmcgYSBsZW5n
dGggcmlnaHQgbm93IHdvdWxkDQo+IG1lYW4gdG8gaGF2ZSBhIGxvb3AgYW5kIHNvbWUgY2hlY2tz
IGluIHRoZSBlcmFzZSgpIG9wOyB3aGVyZSBpdCBzaG91bGQNCj4gcmVhbGx5IGJlICJlcmFzZSBv
bmUgcmVnaW9uIiBhbmQgbm90ICJlcmFzZSBtdWx0aXBsZSBvbmVzIi4gTWFwcGluZw0KPiBmcm9t
IG11bHRpcGxlIHRvIG9uZSBzaG91bGQgYmUgdGhlIGR1dHkgb2YgdGhlIG90cCBjb3JlIGNvZGUu
DQoNCkluZGVlZC4gRHV0eSBvZiB0aGUgU1BJIE5PUiBvdHAgY29yZSwgYmVjYXVzZSBJIHNlZSBu
b3cgdGhhdCBtdGQgcGFzc2VzDQp0aGlzIHJlc3BvbnNpYmlsaXR5IHdpdGggaXRzIE9UUEdFVFJF
R0lPTkNPVU5ULCBhbmQgaG93IGl0IGhhbmRsZXMgaXRzDQpvdHBfaW5mbyBzdHJ1Y3QuDQoNCj4g
DQo+IFNvLCBvbmUgY291bGQgYXJndWUgYWJvdXQgdGhlIHBhcmFtZXRlciAidW5zaWduZWQgaW4g
cmVnaW9uIiB2cy4NCj4gImxvZmZfdCBhZGRyIiBiZWNhdXNlIGJvdGggcmVwcmVzZW50IHRoZSBz
YW1lIHRoaW5nLiBCdXQNCj4gc3BpX25vcl9vdHBfZXJhc2Vfc2VjcigpIHNob3VsZCByZWFsbHkg
dGFrZSB0aGUgYWRkcmVzcywgYmVjYXVzZQ0KPiB0aGF0IGlzIHdoYXQgdGhlIG9wY29kZSB0YWtl
cyBhcyBhbiBhcmd1bWVudC4gVGh1cywgY2hhbmdpbmcgdGhlDQo+IGFyZ3VtZW50IG9mIHRoZSAu
ZXJhc2UgdG8gInVuc2lnbmVkIGludCByZWdpb24iIHlvdSBjb3VsZG4ndCBqdXN0DQo+IGFzc2ln
biBzcGlfbm9yX290cF9lcmFzZV9zZWNyIHRvIC5lcmFzZSBidXQgeW91J2QgbmVlZCB0byBoYXZl
IGENCj4gc21hbGwgd3JhcHBlciB3aGljaCBjb252ZXJ0cyB0aGUgYXJndW1lbnQuDQo+IA0KDQpP
ay4gTG9va3MgZ29vZC4NCg0KPiBTbyBJTUhPIGZ1dHVyZSB3aWxsIHRlbGwgaWYgd2UgaGF2ZSB0
byBjaGFuZ2UgdGhpcyB0byBzb21ld2hhdA0KPiBtb3JlIGdlbmVyaWMuDQo+IA0KPiAtbWljaGFl
bA0KDQo=
