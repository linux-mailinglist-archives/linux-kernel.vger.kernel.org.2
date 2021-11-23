Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5644745A758
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhKWQSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:18:00 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:38689 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbhKWQR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637684090; x=1669220090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WAxfakSEUK3nJF3eWlZnMOcq80GtD/VQbf/DuaQLSm0=;
  b=Kz79HfItvhMZ2ha6ur2PILMwO1rTMbHBoWJ88/FnEohfJ+SsDSEKfD/i
   gkb7YoYIEv2EHsrrFC/58o/r3uc+3R/+bWLDLP3x8r3VuGAL92l4Zreuo
   NfRQdfdgLpb36vgwdc4aIx7hUp61d74xf8KI2bkkuNjP0MNABp/mAlgDF
   8EEMxurMarOPbAkK0gZ45ufM/zLFmNomLNgexqCE+DK5UXVQ8whtHnEs6
   u/RNljGz0LC3cIvXvHLWIWJFKCq/3ZYuvkBR/Bj/A0V83qnaQM7XJp6y2
   OHPzxgm125D5V5QnXI/fQNKGlZ2/RGV7koQgfQwf+Nop8QPkK6e+On8+r
   w==;
IronPort-SDR: fIcXVI6LxsEEMcNzDPxXMN+cb5LQFZ0O4+Vk11DAb9azUaPV5670ZOQPpEy/tiG8YA2tSyVEnB
 IbxxMuLc/guvo/n470lNB9rqnlLXptawl856kg2C9UB72X+yMvDbGzp2NrUI4DME26ndXtkZ/6
 klPp5WHhkkj1Ipmy6DghWetaR3LA3JQBsZqZm6Fr/3EDSkMWsWKVXmPNMvGc9eB/VbznFxzsSM
 2wq4V+lhfrUgXs6e3XJwpzdbbHWgPM+e7UZR+qbTNEHZy5omj7BlUvQjwql0QmqiGJXUHZbWyS
 wtjA/Cvhq84eabM6oczempUo
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="144895192"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2021 09:14:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 23 Nov 2021 09:14:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 23 Nov 2021 09:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieuDHEXSbtC9D1c9xqd8Pad6vsSE4e1QZJ06cKKw92MmrPLGO2ym7vAsGGk7yaZpBNXkRsg0fbBcHcPyex3SmgI6zJW3OLl4wSDCU67fOOsAcTLRGZ5HCVEQXyPSq+C8F8uUgfgNyW2Hk0UqllqyzVzf4FvuvMgC8o25mUlEBtU1DTQqsgJHCMmWH41iv/2U4gIFMaNrCQts2PHVjYL0QY7bfCInYbp0OuPd4mFsx8znYVhszC5q8MLLYZVB3kOU9IIB9V+hzG8//DRMVU+O1QXzEGdkiiYkY1rpPo42eYIEJ9b7AZ8+KRn24/aReuH4zSSSInNpX+G9qP4rvGDplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAxfakSEUK3nJF3eWlZnMOcq80GtD/VQbf/DuaQLSm0=;
 b=G4iaLNCj6YTEiAf6rh0hP1OzRDCVXvyLUD2WR7ZiYn+43BoYninocZtjpMuPQs5mblXnZu3Zh3SFcez5pHLWT1y7gT58n31MfBQwi92hDq4tb7lbrzoRsh1CYWwTILVHZYFLHlGAp9quHUGH+/tNOnAmrLoi6l/d1ynaPeUJv9i/Smt4EPtPMZ5YlG5iOsvFNUpVveqGz63qsHInI+pEAjh2V6N0UsUevQ5Xm4DzX6YJJs5Rfc3CyJiRcC2ZBw8XC13WURYxlyxwUZXDJXpPVrUbX0RyVAjPe5k6pIxjXh6CmmHk9wplOPKQCIhEcYBLyfud9H/jO2MwJnQNoyeAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAxfakSEUK3nJF3eWlZnMOcq80GtD/VQbf/DuaQLSm0=;
 b=tbqAD3X27wfbp6Hha5qW/Dp1heUJQ5MTbXxBcOlDqpz/fk6Kg6E6Pw541gOr8c6MbaFtlcvGmnjZvdm2V6SwLX+AddUVbJA8tbkePCj1/fZ5oW6DE90zT2FApnDHNbSabJCha384Cc45Bz/Nl9OaF/B1JRJbl6Uql05y22ub08E=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Tue, 23 Nov
 2021 16:14:44 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::38e9:ee20:d712:2fd8]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::38e9:ee20:d712:2fd8%7]) with mapi id 15.20.4713.022; Tue, 23 Nov 2021
 16:14:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <alexander.sverdlin@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <p.yadav@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
Thread-Topic: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
Thread-Index: AQHX4IU5aog517p4mEKV2tXjGhUFYA==
Date:   Tue, 23 Nov 2021 16:14:43 +0000
Message-ID: <328da19c-c38a-93b6-0037-7b0c7e1dac35@microchip.com>
References: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
 <9a158e2ef6635212c1e353590e3b773b@walle.cc>
 <1e133bc6-5edb-c4ce-ad44-3de77048acf2@nokia.com>
 <e9589af968d7b9dafbce17325dbf8472@walle.cc>
 <2bf37a35-1ccf-f4fa-c999-42b9154a2914@nokia.com>
 <88db136a146edf53801d86509b52d40f@walle.cc>
 <46f438c2-6f5f-645e-23b4-95216ec23ca3@nokia.com>
 <06ce3d8eabd689f8755021d7ce08c3e0@walle.cc>
In-Reply-To: <06ce3d8eabd689f8755021d7ce08c3e0@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57a6d647-e812-46cd-b849-08d9ae9c5c85
x-ms-traffictypediagnostic: SA0PR11MB4750:
x-microsoft-antispam-prvs: <SA0PR11MB475002ADA7FCFA6AC921F157F0609@SA0PR11MB4750.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1cxkVOcTynSuPxPLU2GgBubexHwONTNMsyJSoyy6rMY5qqyd8e3FH1B272ZoQ8IndUqaxaYwSlkSGoHwi/bmmqYDiBgUAD8ItEmK9Q0PDkhWUrz3Im5ddp8R7b7N4sVyBcgc631tuZ1ungYbKm6bB65kGU7qPBbGgVZ37e4ZcuJhkGCrF0XuIjeut2sazNFjLmIx7Z0DmpaAQG7ngdoeaSDKt1wkpYDelJZm7W2MSmUKnr7KivYNgO2c2P1ogUpSpfmrFPOs7Cbczp6NyjTj2hEhwmTDE1Er8Vzk2cyeZ9rDgY8bt0sMkPDWntfI7QngM4od9GQQ7piyB42DNAVyUfjE2tDj6NZBsLqJHPwpLVyQDen6FlNOLKHaMTOHI43SQjcQbsg9c+cRXvfqs4WnrpfSilU7Lkg7lZy6PmBXnAfw446ElrVBGT8a0h+gvgUdsw1+apvaADpjznb0Zte2UXu3UChKU5mEcqpWIWOaizmFZZPygGlcCgc/u/dQYFnJX1cYFq8NWHiVAv0tQ+qWTugqHNPDaYyXmJJ5e+SknnEvH2kI7CpTVNimuNL9Jv6F7LY/+JFY6ssDCCBwO/JtWt2b4vCYLx2tWtz1rMHpKHTw5lWGX+ET1w2T/XYgltbvB7N5nFqOXq3jL8LdiY2XkZqEcHVF9QeiRvTEFkGZkfoBZLsjnJ006l/LAjOl5qk86Wp66N9v5iVEvY+DwranMOZcuKjLLQhub2cZs9y1d2VBjVWfflC7Cwu/i6aSKpHZyxXqZtW8DvZAH2MaZMvUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(186003)(54906003)(6506007)(122000001)(4001150100001)(5660300002)(31686004)(8936002)(8676002)(38100700002)(86362001)(6512007)(110136005)(91956017)(76116006)(2906002)(4326008)(26005)(316002)(64756008)(66446008)(71200400001)(31696002)(66556008)(83380400001)(66946007)(66476007)(53546011)(6486002)(38070700005)(508600001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajVuWmxDYTBoV3grMnFSUnJWaFkwbStZRy80YUZBNFRTT2ZsVEpLVi9Nb1VE?=
 =?utf-8?B?VVZEWVB0RVBjaXJBb0d3R3dKTmhXUTF0SUR5TmYvSUMydVo5ZEVxLzNmY3M0?=
 =?utf-8?B?WW1UY2l6My8xbkMxaWRrSmhnRWs1NkRKVko4aHpDaEx6ZlA5SXEwZkp2akVS?=
 =?utf-8?B?N2tHQW91UThzZnVzVU9nWlB6b1NZa1VKT0lZNlVaU2NWdGNLRmhtUmFVMVlH?=
 =?utf-8?B?TWVVeVpZWG9XTkZvZE9PbVc3TDFEWi9yUmJTZVF6YiszT1V0blJ4RVFKZUJt?=
 =?utf-8?B?b2l6ZVpmcmtYTkwzOXdsUThPc2VWTkpkVWkvbTh0RVhoUW5Gamg5ZTdpTEZx?=
 =?utf-8?B?bERMSTJvcXJyWXdMWFFZT1QyVVR0MXk2YlF6Z1A1RHNrZTZjTEFaMC9lcDRI?=
 =?utf-8?B?QjJHbHF0b3JReWM5U3pSeTJWTW1icmFuT2l1bDVOSXhTdGVpVXllRm1aaTFO?=
 =?utf-8?B?TnVpZS9ZN3hPdVoxcno0RmtKaytBRW83QVltY3hmUm1Yb3VZQVlma2VyNmx0?=
 =?utf-8?B?OGFOM2tIWFA3amhNeDgyZmNYanpqSTBWMXQyQUZvYWk4SEpCYmdRVzlFaTgw?=
 =?utf-8?B?dnN4ZUFyNnkydXlzeXhLVGVYcUEwUjlzaDlGbVY4akx3MHEveUNKdlU5Vnlw?=
 =?utf-8?B?dW0xak9sbWNTdXBNYVZsamx3STBnQlRETlpneU5pVm9peU1iS2g1YS9EclpP?=
 =?utf-8?B?ZVBHKy93YVIrNHFOSU45R2dwQlludUFXUHdsdUlSdmFXUjJNQUx1SXhXSmQr?=
 =?utf-8?B?RFdRL2dHNWptdjk3K28xdS9tWGg3NW9naGNwMHN6QVhBVHFZUUgxbTM5c3Qz?=
 =?utf-8?B?MVlwcHNLeUlxNUxwUkc5Sm1WUVR4VXNaQ1NuVzhrNWxHcWY5YUxKUG4ydEZE?=
 =?utf-8?B?RERtS29FYkJUNE1DMGZBMXZQenJCR0x1c01zRXd3cW1xSFVrQVBRV1h6Lzhv?=
 =?utf-8?B?bndHTlFGM1M3MTlDWDl6ZDFwbzliYkFUQ3ZHcHRJRFlBWGVqMmlVUkorcWhO?=
 =?utf-8?B?UzZtYXRRazJZVDNHOWkrWFdYVW04RmU3dE9MZWpCdE1GQ2ljWEhsMCtMZW03?=
 =?utf-8?B?bU1UWnNTVjQvL3VjNHRpUHRlQmc5a3JxYVRGRE5aY1U2ZG9ZWTFJRXdhSVhj?=
 =?utf-8?B?VnV3Zkw4L2MvNExGVFE1OXFWMHBWNTBlQk9VSGNidlBXa3orS0JGdDNmUDJV?=
 =?utf-8?B?NHdRZFREZHZCSmNGTmRyZGNVeHRZSDVzVzYvWkVnWWxGbXpnL3M2VUUvMXJt?=
 =?utf-8?B?aVpkSzB3cjM4dFJaVlBlcnBaK1I1NDZvZTV6Q1lWa0hreHFHWVN6MXExS1o5?=
 =?utf-8?B?bWhYciswZ2hUZmhGaUNYanNLMEM5emMxNFZsamt1dEFHdVQwcUxzdWE0UDEz?=
 =?utf-8?B?Skd5QTZiaDl0VWZjcWJJbEdONmtMWjBFSVpQa1E3ZUlxaHJXenQ5WnNncnA4?=
 =?utf-8?B?UDE2akdPQkhiSlhnTDd0NkVhRkZxcTdKN3FDRnRrSTN4aXgzUGF0Ti9hL3lJ?=
 =?utf-8?B?ckNoZWhWZEdFeVFMYTQvanlPSGFJYnNFY1EvUlFiNEFscU9aSU9ZcExjNTBi?=
 =?utf-8?B?dVlaOEhwZEt5bm94M1hqUTRwcU9GbEtOcTgyb0ZoZFI3OCtPU3pnVmlVWFZm?=
 =?utf-8?B?bnc3RXM5TFZzY052a1NmNHBDa2xuRE12YTN5c01WNE1GdXJLV0V4eXlpbjRu?=
 =?utf-8?B?aHlJSHBSSnAzTWV2UlZqLzVIQWJ1d1NmZzkxbi9BL0d5c2FCNEFnTHprT2Z4?=
 =?utf-8?B?RW9pOFVrNHN0alBMZWdxNi83RkdDQVl1Z2RySFI4UFhPdGM4RUx1NFE2TURm?=
 =?utf-8?B?ZDRXYVdzZjVDUm1WL1YrK0RPY0hZN29ZcmhqclJxazNZNG1WUWUzYStudTNL?=
 =?utf-8?B?UE9sSmpCQjd2UFpQYkFtdmMzYXZodkdweUJNVk16UjB0MDB2MVZieVJORFlY?=
 =?utf-8?B?Q2tvQlhkRjJEOERWS2pYUnhsU0JXYkdNMCtGZDNabEVVWHBZWnFURTJ2VTFK?=
 =?utf-8?B?MmFYUGVUQTBOK29KSFczMWZURndiWDMxUnJ5UUlJSzdUUTc3aWkvUlAzVUFM?=
 =?utf-8?B?VUpyOFR5K21VdVlFalNiY3BXc2RCbU8zWEY5dGJaQ0dNYU5ONnRVK1QzdlB3?=
 =?utf-8?B?RFQxODFUaG9peElpRzlic2JzdVZaMlZsem1yR29qckxDeWE0MkY0emx6andk?=
 =?utf-8?B?dGM2Yk1lcjZrMnNMeGxUbjNQcWFsUFVVb1lqQ2dlczFmc3ZnQXB5eXJIak9V?=
 =?utf-8?B?NXVlZXdUdkVncm8xVENFM1RzN3FRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D966F6EDAF060E438386747338E2811E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a6d647-e812-46cd-b849-08d9ae9c5c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 16:14:43.9397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDxu5NYNV04ItTLYhe2xNzOqNlisQlg2CsSTqKdzQkLevH2ms01NMxT7RGOhz34sB38XpUMpuLRdkqP96xjlAwco4tkAObEsRtnUlPdQLvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjMvMjEgNDowMSBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSwNCj4gDQo+IEFtIDIwMjEtMTEtMjMgMTM6
NDAsIHNjaHJpZWIgQWxleGFuZGVyIFN2ZXJkbGluOg0KPj4gT24gMjMvMTEvMjAyMSAwOToxNCwg
TWljaGFlbCBXYWxsZSB3cm90ZToNCj4+Pj4NCj4+Pj4gU29tZSBwZW9wbGUgYXNrIHRoZW1zZWx2
ZXMgd2h5IHRoaXMgdGFibGUga2VlcHMgZ3Jvd2luZyBpZiB0aGVyZSBpcw0KPj4+PiBTRkRQLi4u
DQo+Pj4+IEkgc2VlIHRoZSBwb2ludCBpbiBmaXh1cHMsIGJ1dCBtYXliZSBhdCBzb21lIHBvaW50
IHdlIHdpbGwgYmUgYWJsZSB0bw0KPj4+PiBzdXBwb3J0DQo+Pj4+IHNvbWUgZGV2aWNlcyBqdXN0
IG91dCBvZiB0aGUgYm94Pw0KPj4+DQo+Pj4gQXJlIHRoZXNlIGZlYXR1cmVzIGRldGVjdGFibGUg
YnkgU0ZEUD8gV2l0aG91dCBrbm93aW5nIGFueXRoaW5nLCBhcw0KPj4+IHlvdSBpZ25vcmVkDQo+
Pj4gbXkgZm9ybWVyIHF1ZXN0aW9uLCBJJ2Qgc2F5IG5vLg0KPj4NCj4+IFdlbGwsIEkganVzdCBo
YWQgbm90aGluZyB0byBzYXkgb24geW91ciBxdWVzdGlvbi4NCj4+IEl0IHdhc24ndCBteSBpbnRl
bnRpb24gdG8gc3R1ZHkgc2VjdXJpdHkgZmVhdHVyZXMgb2YgYSBjaGlwLCB3aGljaCBJDQo+PiBk
b24ndCB1c2UuDQo+IA0KPiBMaWtlIEkgc2FpZCwgd2l0aG91dCB0aGF0IGluZm9ybWF0aW9uIGl0
cyBoYXJkIGZvciBtZSBkbyBkZWNpZGUgaWYgd2UNCj4gY2FuIGp1c3QNCj4gaWdub3JlIHRoYXQg
bGFzdCBieXRlLiAoQW5kIHllcyBJJ3ZlIGFscmVhZHkgdHJpZWQgdG8gZ2V0IHRoYXQgTkRBIFBE
Rg0KPiB2aWEgJFdPUkssDQo+IGJ1dCBJIGRvbid0IGhhdmUgaGlnaCBob3BlcyB3aXRoIHRoYXQp
Lg0KPiANCg0KSXQgd291bGQgYmUgbmljZSB0byB1bmRlcnN0YW5kIHdoYXQgaXMgdGhlIGRpZmZl
cmVuY2UgYmV0d2VlbiB0aGUgdHdvLA0Kb3RoZXJ3aXNlIGtlZXBpbmcgYSBzaW5nbGUgZmxhc2gg
ZW50cnkgd2lsbCBiZWNvbWUgYSBtYWludGVuYW5jZSBidXJkZW4uDQpGb3IgZXhhbXBsZSwgd2hh
dCBpcyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSAidG9wL2JvdHRvbSBibG9jayBhZGRyZXNz
DQpwcm90ZWN0aW9uIGxvY2siIGFuZCB0aGUgQklUKDUpIChUb3AvQm90dG9tKSBvZiB0aGUgU3Rh
dHVzIFJlZ2lzdGVyPw0KDQpJcyB0aGUgbmV3ZXIgZmxhc2ggY29tcGxldGVseSBiYWNrd2FyZCBj
b21wYXRpYmxlIHdpdGggdGhlIDB4MDAgdmFyaWFudD8NCkknbSBub3QgdGFsa2luZyBhYm91dCB0
aGUgZmxhc2hfaW5mbyBmbGFncyB0aGF0IGFyZSBjdXJyZW50bHkgc3BlY2lmaWVkDQppbiB0aGUg
Zmxhc2hfaW5mbyBlbnRyeSwgYnV0IGFib3V0IGFsbCB0aGUgZmVhdHVyZXMgb2YgdGhlIDB4MDAg
dmVyc2lvbg0KKGFsc28gdGhlIG9uZXMgdGhhdCBhcmUgbm90IGltcGxlbWVudGVkIGluIGxpbnV4
IFNQSSBOT1IpLg0KDQpJZiB0aGUgbmV3ZXIgZmxhc2ggaXMgZnVsbHkgYmFja3dhcmQgY29tcGF0
aWJsZSB3aXRoIHRoZSBvbGRlciBvbmUsDQppdCBzaG91bGQgYmUgZmluZSB0byBzdHJpcCB0aGUg
NnRoIGJ5dGUgb2YgSUQuIEFzIE1pY2hhZWwgaGFzIHN1Z2dlc3RlZCwNCmlmIHRoZSBzZWN1cml0
eSBmZWF0dXJlcyBhcmUgbm90IFNGRFAgZGlzY292ZXJhYmxlIChlaXRoZXIgdmlhIGEgZ2VuZXJp
Yw0KdGFibGUgb3IgYSB2ZW5kb3Igc3BlY2lmaWMgdGFibGUpIGFuZCBvbmUgd2FudHMgdG8gdXNl
L2ltcGxlbWVudCB0aGUNCnNlY3VyaXR5IGZlYXR1cmVzLCBvbmUgd2lsbCBoYXZlIHRvIHJldmVy
dCB0aGUgcGF0Y2ggdGhhdCBkcm9wcyB0aGUgNnRoDQpieXRlIG9mIElELCBhbmQgdG8gaW50cm9k
dWNlIGEgbmV3IGZsYXNoX2luZm8gZW50cnkgYW55d2F5Lg0KDQpDaGVlcnMsDQp0YQ0K
