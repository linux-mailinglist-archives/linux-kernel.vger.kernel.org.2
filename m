Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA81333AEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhCOJfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:35:07 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:43360 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCOJe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615800896; x=1647336896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G38pC9Y7KRItCBlzVkO0aTVLlAL4j6FEzz2mWpX5Ly8=;
  b=v55UZ+UtkOxzuHzYgWyML+/iFEJNgvowEXfwzdwydmKjW0vWc22OANhu
   3RE/IDEPwNDngGExRaxwy0pAb01agCU+B8KDk6AugNyyDA2mvkXX7D4WH
   pRizYtlNJP6d7xgNNi85rj4cT/jQAXdHpIyvrg8ol+1uo+bLuOxD9mg1L
   3bqvf2zPRtaMgwA840MUkO9wQbzi35cM9i2aTSz4UDKUHLrcAbltuynvj
   cj7ZshOKnqC1Zr9rQM0E8vHwi8/FHhwXt4MqW1rHO7jMypBlVZIH7GHMA
   F2bgoFPoyZTZrpWJ8nv+TAw+0pJzZm1crX+bBQinJ24VEvtof7E/QCAcS
   A==;
IronPort-SDR: ScOHZzf0Kht9cwd6Jwdnn2nIFEASM1LPP1Z/AA09lsvL5HPSB2YRC9y5hnHnitOn87VGbtNZlj
 gwhbNCWrV0l3B3+vYc+gX7QOheeOmW7q/px7GmbilJ/OgLq6aeadGkBbYMl2zeNVb99mupZhTX
 MzR3pTvUuUcoWxJMIAMR9VXxcpXiamwMvKg+PyRX6XXPVjlh3VWJ/6xfclicJaFbX9Zbdd3iE0
 juJHRfIMLCLZrD2acDWHkNiFsm3jLzv1IeoFbhBWnOGDjUoakPqCHMEQDm0yFrAMkFPNjNoQY4
 N0c=
X-IronPort-AV: E=Sophos;i="5.81,249,1610434800"; 
   d="scan'208";a="47531450"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Mar 2021 02:34:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Mar 2021 02:34:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Mon, 15 Mar 2021 02:34:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6uRVE1L6wGtjxE2fOb7l3qiTbq4pnwFPtGlD47vNllndQG+e9H8kOZqyEEomKIfM8M+xv4eeGgCO0VL5WeKe4UJsCvSXi2E8R4HMZ0hdRVxB9NC1MmmSB2br1+tihSkvi1W9NS1ciS8dmB35Hxj+vkQHv9bLrC9tmG5CmAJQzA67m/yGXUjmiShU9MhR77vXC1NxNNZaHJ+nWLXMV+bBksYy7qzZbhAsMPHmznZnO2A9Kkm2xfpfLEDkY7zt3FygdE9zTCceyWvifzsoHHHr7gv7nII0Lj2qEJJ4hltRjoro/shEhzAth5mI8/cPSuCHqSCRqwX9JBTUXeLIulHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G38pC9Y7KRItCBlzVkO0aTVLlAL4j6FEzz2mWpX5Ly8=;
 b=NTVmbPtw101IWdiJWgW/WmS5kSSwwlL7BU2gPp5rLLTmztN5H8yY0WwfGLFeqaM3NIt8aBX2k478O7QwUGmOQX7cLWxedG6Pw8NHF6A8ZdrbRuVpX+hEYPkJF1veq1xxiij2xi4IJKaIVDl9KF8LETYALhrEMTS2o3rVklt8AZyHRPYfB/kbbDqKSDr+yvD9rmEHKHjaCDrAiglBJv6zHlZPkyxcHgApCdknMaWWLz7qiNXUtr1943n+A+90twnn8uvcNdnHijFyqFWSPfqxdKZq1T6eDaA8CFRcXdTxtuDcxHkd/khIr8Olg+UyuzQ4kobOaSXw+UXAYd7VDOkedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G38pC9Y7KRItCBlzVkO0aTVLlAL4j6FEzz2mWpX5Ly8=;
 b=l0UYQG0HioX4xhFu79aW1x344EELVx4kT0/TH/LOR5TRVzogZkdLT2JVq40nKmK7wajydF57DQBPE4a/wDq2nxuI+/QZRuzCP4tlz0xDMvu39bzvL2SL9WmrPHbhNA1qoUWLi5C91ezfHHceNDOHHRWIoBYZ85WGgC+aErJJ5RA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 09:34:54 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 09:34:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/4] mtd: spi-nor: winbond: add OTP support to
 w25q32fw/jw
Thread-Topic: [PATCH v4 3/4] mtd: spi-nor: winbond: add OTP support to
 w25q32fw/jw
Thread-Index: AQHXGXTasCA5v1Asb0eWrA7CFF4dWw==
Date:   Mon, 15 Mar 2021 09:34:54 +0000
Message-ID: <cdc69d63-06e7-3b10-acd2-03e6cc83af25@microchip.com>
References: <20210306000535.9890-1-michael@walle.cc>
 <20210306000535.9890-4-michael@walle.cc>
 <8e7147bb-a9ba-2b4b-abea-69e72ddd82f4@microchip.com>
 <2442f8a2e9ed1333fb45e90176200c11@walle.cc>
In-Reply-To: <2442f8a2e9ed1333fb45e90176200c11@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68177785-f959-4ff8-699d-08d8e7959718
x-ms-traffictypediagnostic: SA2PR11MB5115:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5115BED2048A62441038E13BF06C9@SA2PR11MB5115.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c27imiJ+EcEKz+d9qyEf4GjLc+WUkbVgpgM2N+LLhGX8h+7QzrB7nYcvlCfrtEc4+Q7V9cZTz8lmZ5Q/nA+V9/uiV3n/3RCTTXHz4r5nJmdUDtjaNi3m7OrOvdiUIutTSunq5jTfeF+gDt7tvPyGB16RCD/6GObAp+zDOquRwaoQ4wzH5KudwjCi/wg2+nUbT1oD/HsheEbep0m6/RbohVKyXoJrZl+IkNh5VtqjAbLWoFaR9OWwtZSYfoErZByhpUmLm7TlnSde+krmTlOUZ7NSZb/m9MXvm9pi6/tUmBayfi3pQlMwh5kFr1IYqjiXOKP2B6CLmNulslYt8x2S9dgIurGhA+79s6QbATaMEJ91YEznllCgKAgWub1ujGj68J7Os/vQF0zEnS/F995CY6iVKrrc4B6iS8M2blm0spd+Qiom0qR2+SeXLh8HR3ZjVY3LqGDX///qkSVdA3PZ7FvMeSs8m/1Dx/wqIgllqiHGQbK7RxGr05mRmATNP1XNqUjbmCd/HCH5mgeESokbAmuJRC6M1m4SQuG4G5D/9kHAHYniHLCcANCRfXZ9SwZcHIvgamLWXwDIrbRYUCuRYobiFD8aRY5cWCv/6BKvUAN6WIskdfxqeklUkxifGZfdF/JGVNo2IFiRCzjSZuo9hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(136003)(366004)(396003)(71200400001)(53546011)(86362001)(66946007)(6506007)(316002)(31686004)(4326008)(186003)(2906002)(83380400001)(31696002)(66476007)(64756008)(8676002)(6486002)(2616005)(54906003)(6916009)(8936002)(26005)(76116006)(478600001)(66556008)(66446008)(91956017)(5660300002)(36756003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aXpVc0o2TGFoRXRaeTVnNllESWJaTmZDd3p3OFZQRi80TEIyK05LdVJmZ3dV?=
 =?utf-8?B?ZnJwU0UveEw5d0RlUGpiNGc0VDBQRkJ0UEhUc3VaZVJiRTI2MUNuVzQzOTRw?=
 =?utf-8?B?YVZlalBtZmVRYmRlUllMSEtzRjlYbk5WejZCOVBNSk9qSVUvNzF0SHVjclVI?=
 =?utf-8?B?YitTTm55UE9MaVBCZW9vZEdUU0UyVWVkMm5YRUJ2a1U2R0pZd0NMM201RzM2?=
 =?utf-8?B?NU1ON3MrdjJiOHJaN3U5cUFHMExtNGRKSFNLU2ZHQytkdnJ3T2JHQTFwdXU1?=
 =?utf-8?B?TXN1OWNxR0RVdlA3OFZKOFJOVzMyU3JER2xGMnBUTWF1MEVMZDlJNUpJMDBF?=
 =?utf-8?B?L0dJU1dhZG42S2swem1rS1BoU1htYnRMUWpjVmE1SGdLMUgvVDJDWUhGd28v?=
 =?utf-8?B?Rk1zZkpiM3FEaFF5ZlhhdmovRENMaXA5RE5Cc2tQUzhiYWNNajhtaFpZVC9V?=
 =?utf-8?B?U0pHRXRrbm0xVnBmeFFveko4YTZMTFV5WkMyYlhkdjNmSzZYQ2lDa3NHN3pH?=
 =?utf-8?B?ZWJTTlBzbytuNjZkOWRvN01aSjllTTRuZDRBWHlPUkU3eUFiWW42UTRtMWZB?=
 =?utf-8?B?Z0lKclRhRDlkcWhHQzZmcEVjeDNhbVo4dlJnM2NZZExacjNFZTZxdVplNWc4?=
 =?utf-8?B?bTkwTzZVbWVqckZTTXcrMWFVdEV1d1dZMGVpbHpxQjlYcDFMK2NVRW9YNlRT?=
 =?utf-8?B?ME90d1QwOHRnQ25Wb3h4eThSaVNWWlJGSkVlMktVU3U2SldtUFhtWnJ6WU8w?=
 =?utf-8?B?Z08rUlNwZGxJcjgyaGF1emVkTU9Ja0dVa2cvRERhS2c1dVNRbEd6QnRmQ1lX?=
 =?utf-8?B?ZVRKTndXQVRhbDMzempPVHoxQm56UW00ek1Lb0Yzb0l4MitvKys2aVoyOTNX?=
 =?utf-8?B?Q1AwbnpkVVlHR29IZDhEcnBkRXpDb1hTQXFpRkpLaTJtTjJBYmlaV2tzTzcx?=
 =?utf-8?B?bmZRbG5jaGNiSUFjWmJrdFNxYWNOODdiSUdZRUdqRzQwN2pTdzJkNE9xSDZX?=
 =?utf-8?B?OXludGUza3VoOGliZTlYaXVJdGVMWUkzWGFjL01VcnlGeFpBbzJ6SzZNRm0x?=
 =?utf-8?B?N2RheVhRQnFrSTJ3RzBsTTBaa2JnL1FsaE9HcGRhQUpGenpEcU1MZ2h0TjVm?=
 =?utf-8?B?WUZ5R09yRjA5L0lQM1JDYkJ6L083bkE1V1cwcGdDVTh0NWdhVCttNFh2YzY5?=
 =?utf-8?B?dXRZNGw1UEhrelpJS0hZUWsvSVI0ZHZ0Y1UyeUtpdlV6d2VXajZnUDJUaG9s?=
 =?utf-8?B?OG1icWkwL3dmd2oyTkdLSFhXTDQ2b3BBZmZabFZrMVFONUpVaEFsd0gvWmpa?=
 =?utf-8?B?d2JBYUFPUkJrTHFYZ2N1dGMyYlVxcy9DZFRWbUFseXV3cDNFZCtTS1U4VFNW?=
 =?utf-8?B?bWZqRWdRbDRkWW1zSjJDR2ZsNWVsMms4TkxaR21ZMnc5aVhtVU5qd2VOTEhS?=
 =?utf-8?B?SHE1WkwwWVZvVzN4QnhBcU1WbkJ3NWcrMnZmT0psSmR1M1NHcWw2QTV4VGtY?=
 =?utf-8?B?Y0tJVWM2RG9paDdHb1VVTVdpK201d3NQLzFienhjRlVTdHVSY0p3UTg1dndK?=
 =?utf-8?B?RlJ6c1RPL1dxM0dVR25rS3orS0tLV3ZFb2dieFA0OXJLMmFiQTN6UmE2Q2Z0?=
 =?utf-8?B?UzhpZW5xekpveU1wRVJsRGwreU1jUm8yNnYwVnhRZVptcUYzMlhhV0JtZ3BF?=
 =?utf-8?B?WDd3RUJmMXBPMmhHMnlrK2FCUG1ldG1QT2pGczV2aWt5eGdhRng5ekZpYW8z?=
 =?utf-8?Q?GrQuzleJflvUw8B23U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A32A6D453231F468665CFB59ECDCE31@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68177785-f959-4ff8-699d-08d8e7959718
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 09:34:54.3400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XThZAsJjp8vznj901SuVdLY4pTglbQGYVdTNbxr9UwnP1vqeRvk85DXT8pndjBmogovcWD16weOBjSXc8m+3bT9uiNKg5geNurvoe733ZsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8yMSAxMToyNiBBTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIxLTAzLTE1IDA5OjI2LCBzY2hyaWVi
IFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDMvNi8yMSAyOjA1IEFNLCBNaWNo
YWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiB0aGUgY29udGVudCBpcyBz
YWZlDQo+Pj4NCj4+PiBXaXRoIGFsbCB0aGUgaGVscGVyIGZ1bmN0aW9ucyBpbiBwbGFjZSwgYWRk
IE9UUCBzdXBwb3J0IGZvciB0aGUNCj4+PiBXaW5ib25kDQo+Pj4gVzI1UTMySlcgYW5kIFcyNVEz
MkZXLg0KPj4+DQo+Pj4gQm90aCB3ZXJlIHRlc3RlZCBvbiBhIExTMTAyOEEgU29DIHdpdGggYSBO
WFAgRlNQSSBjb250cm9sbGVyLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxs
ZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4+PiAtLS0NCj4+PiDCoGRyaXZlcnMvbXRkL3NwaS1ub3Iv
d2luYm9uZC5jIHwgMTcgKysrKysrKysrKysrKysrLS0NCj4+PiDCoDEgZmlsZSBjaGFuZ2VkLCAx
NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jDQo+Pj4gYi9kcml2ZXJzL210ZC9zcGktbm9yL3dp
bmJvbmQuYw0KPj4+IGluZGV4IGU1ZGZhNzg2ZjE5MC4uOWEzZjhmZjAwN2ZkIDEwMDY0NA0KPj4+
IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jDQo+Pj4gKysrIGIvZHJpdmVycy9t
dGQvc3BpLW5vci93aW5ib25kLmMNCj4+PiBAQCAtNTUsMTQgKzU1LDE4IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZmxhc2hfaW5mbyB3aW5ib25kX3BhcnRzW10gPSB7DQo+Pj4gwqDCoMKgwqDCoMKg
wqAgeyAidzI1cTMyIiwgSU5GTygweGVmNDAxNiwgMCwgNjQgKiAxMDI0LMKgIDY0LCBTRUNUXzRL
KSB9LA0KPj4+IMKgwqDCoMKgwqDCoMKgIHsgIncyNXEzMmR3IiwgSU5GTygweGVmNjAxNiwgMCwg
NjQgKiAxMDI0LMKgIDY0LA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwNCj4+PiBTUElf
Tk9SX1FVQURfUkVBRCB8DQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFNQSV9OT1JfSEFTX0xPQ0sgfCBTUElfTk9SX0hBU19UQikgfSwNCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU1BJ
X05PUl9IQVNfTE9DSyB8IFNQSV9OT1JfSEFTX1RCKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPVFBfSU5GTygyNTYsIDMsIDB4MTAwMCwg
MHgxMDAwKQ0KPj4+ICvCoMKgwqDCoMKgwqAgfSwNCj4+PiArDQo+Pj4gwqDCoMKgwqDCoMKgwqAg
eyAidzI1cTMyanYiLCBJTkZPKDB4ZWY3MDE2LCAwLCA2NCAqIDEwMjQswqAgNjQsDQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTRUNUXzRL
IHwgU1BJX05PUl9EVUFMX1JFQUQgfA0KPj4+IFNQSV9OT1JfUVVBRF9SRUFEIHwNCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNQSV9OT1Jf
SEFTX0xPQ0sgfCBTUElfTk9SX0hBU19UQikNCj4+PiDCoMKgwqDCoMKgwqDCoCB9LA0KPj4+IMKg
wqDCoMKgwqDCoMKgIHsgIncyNXEzMmp3bSIsIElORk8oMHhlZjgwMTYsIDAsIDY0ICogMTAyNCzC
oCA2NCwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwNCj4+PiBTUElfTk9SX1FVQURf
UkVBRCB8DQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgU1BJX05PUl9IQVNfTE9DSyB8IFNQSV9OT1JfSEFTX1RCKSB9LA0KPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNQSV9OT1Jf
SEFTX0xPQ0sgfCBTUElfTk9SX0hBU19UQikNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPVFBfSU5GTygyNTYsIDMsIDB4MTAwMCwgMHgx
MDAwKSB9LA0KPj4+IMKgwqDCoMKgwqDCoMKgIHsgIncyNXE2NGp3bSIsIElORk8oMHhlZjgwMTcs
IDAsIDY0ICogMTAyNCwgMTI4LA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfA0KPj4+
IFNQSV9OT1JfUVVBRF9SRUFEIHwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU1BJX05PUl9IQVNfTE9DSyB8IFNQSV9OT1JfSEFTX1RC
KSB9LA0KPj4+IEBAIC0xMzEsOSArMTM1LDE4IEBAIHN0YXRpYyBpbnQgd2luYm9uZF9zZXRfNGJ5
dGVfYWRkcl9tb2RlKHN0cnVjdA0KPj4+IHNwaV9ub3IgKm5vciwgYm9vbCBlbmFibGUpDQo+Pj4g
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIHNwaV9ub3Jfd3JpdGVfZGlzYWJsZShub3IpOw0KPj4+IMKg
fQ0KPj4+DQo+Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9vdHBfb3BzIHdpbmJvbmRf
b3RwX29wcyA9IHsNCj4+PiArwqDCoMKgwqDCoMKgIC5yZWFkID0gc3BpX25vcl9vdHBfcmVhZF9z
ZWNyLA0KPj4+ICvCoMKgwqDCoMKgwqAgLndyaXRlID0gc3BpX25vcl9vdHBfd3JpdGVfc2VjciwN
Cj4+PiArwqDCoMKgwqDCoMKgIC5sb2NrID0gc3BpX25vcl9vdHBfbG9ja19zcjIsDQo+Pj4gK8Kg
wqDCoMKgwqDCoCAuaXNfbG9ja2VkID0gc3BpX25vcl9vdHBfaXNfbG9ja2VkX3NyMiwNCj4+PiAr
fTsNCj4+DQo+PiBTaG91bGQgd2UgaGF2ZSB0aGlzIGluIG90cC5jPyBJdCBjYW4gYmUgc2hhcmVk
IHdpdGggZ2lnYWRldmljZSBhcyB3ZWxsDQo+PiBhcyBmYXIgYXMgSSB1bmRlcnN0b29kLg0KPiAN
Cj4gSXQgc2hvdWxkIHdvcmsgaW4gcHJpbmNpcGxlIGZvciBib3RoIHZlbmRvcnMsIGJ1dCBJIGNv
dWxkbid0IHRlc3QgaXQuIFNvDQo+IGZvciBub3csIEkndmUga2VwdCBpdCBwcml2YXRlIHRvIHdp
bmJvbmQuYy4gSWYgdGhlcmUgd2lsbCBiZSBPVFAgc3VwcG9ydA0KPiBmb3Igb3RoZXIgZmxhc2hl
cyB3aXRoIHRoZSBzYW1lIG9wcywgaXQgc2hvdWxkIGJlIG1vdmVkLg0KPiANCg0KT2suDQoNCg==
