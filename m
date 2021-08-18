Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A7A3EFDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhHRHSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:18:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:60717 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhHRHSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629271048; x=1660807048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZVirQ9gyMezgRxR7QOJvPGZT3UszS7emgFdPHmDwOtM=;
  b=nvOgdCm/erkIBmIF4mKesdWDnK0JVeVOkfpx1EHdF71R9utoSdG/1iD+
   riGxNqw0s6V21Pl+4k/zBQwCumoH7mNFiM2jC+Hj8eVvA7DkXO2i0dhYJ
   ZMvScfnyxoCwwo56TRHHqRlOfpdnveCdKwVDLMMSI83ithPy6/Iy8QViU
   sI3HiU2Ot8Lw+3sBQxqdyIblvql9qJQA+85hLFO79kH4/3tuFOJMA8rkd
   XcKgSYI9AWCQS6gWUytZDaAx3SBTY7dQrpdUFyhNWvCJD1JhYPadQAd3r
   IM2X7fX6e7CfPpTXidH//SsZL1Te91HqS/5YrK0jF8Vaom9X48R1W6inz
   A==;
IronPort-SDR: mfTHezeIqSbK8oeiyTFxxUdm/xUFtDN6NpE43WGPWr2SEx/esajyxBbePkNN1Jw5hJDjbxGjdh
 SmtlWpGoexQRksUohmPLuF5/RSxWY8eqw4gIuXFj0sSTibIkMcDm/z8Wf5kflcilZnSmG46r5L
 nIMD9RN0YE17Ilcy8celpF+4rQBOjvceMRWrFr3nhDg05XKNJghU6ZZMVlC6xhqpHzHUvxiL9Y
 h0ONUzJrEkWoLDJMLwVTl3jmibZl4QzRXTsQjwrrIJKtN27gfZva3QmdeEkAm4xu6VktHuGPtK
 4sCZdq7IAZeRTybPBT8QCQF3
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="140574159"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Aug 2021 00:17:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 18 Aug 2021 00:17:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Wed, 18 Aug 2021 00:17:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y43YUeh/Q62iEbKhwz8ZksnicM7Pc25s1qvdwNCDtoyTuJtPo7vZpEIezYzL6nZT07/t3M9Bz8sxyKHAIv/HOOFq9Lz27pjRqI4EvPkr6Epc27TupOMGMJzeE4/z/CL4Wu6QkhwvydycW4OFy5P3I7pqBgZTS7RuizyJNtd+X+FMQ9u/ffKi98FxOtuX5qnBCxPVGFVVrZJLXTjW9p0hb9HBZVi0VW3/nn8Oz9VFc6HGlYhbl3F/731SXGCuVPZl44G3y3U+1rMPgk4Aj0E0/yuuI11NT5Hd5ObN44ROOGDbICAz5beJAqn6NWWly+Jtb9dWF4qvglmyRtbAKGW5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVirQ9gyMezgRxR7QOJvPGZT3UszS7emgFdPHmDwOtM=;
 b=aEXn3VUf8N6EuOAXXFLTK3mZGd9CKRQcI9dtWdKJM7goHVGlnSP0HjZoPMgkIreBfSUa8UbaBhgUgQC3oM+pvz6ruOHAYkJPQRMO1fkBwF5eh9QZ6yGKBDZww2zk1bOpxgJ7VKGFrSWzU0WzCpI46DayhALXN/WQQ6divwCu/cchaX+JSBHRSWUOyjt5F37YF69RgfBPkT1bR3Bnu1wnuypg0BL8hlEjBpmkedcNTk1D/D0H2HoBtLM/b103yfTuAEdzQpDKbrH5URNxvzSNeugMkyO6Na0Wt5U127w6BOAg8cgwqsQLDWnmnWTKK8/GEUAGPwEgj4skUCGF/YTeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVirQ9gyMezgRxR7QOJvPGZT3UszS7emgFdPHmDwOtM=;
 b=q152f8m64juvaHMtkO2INdrN2O1Pw3aandzKHRQdxfqH4eJCQihVCTITreYYC4uxcfJAYVNy+WdN2ufQvOPoiqMqpldu3nkPRGWNRA8ywOIqVCZ4600CDUuzhh1BsNSoM7SXYWW/fNa7iJ7XV1SMrL/iIxLgzpj9x6ANk3duFK8=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1580.namprd11.prod.outlook.com (2603:10b6:4:10::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Wed, 18 Aug 2021 07:17:25 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 07:17:25 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <soc@kernel.org>,
        <alexandre.belloni@bootlin.com>, <olof@lixom.net>, <arnd@arndb.de>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <Ludovic.Desroches@microchip.com>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 6/7] dt-bindings: ARM: at91: document exegin q5xr5
 board
Thread-Topic: [PATCH v2 6/7] dt-bindings: ARM: at91: document exegin q5xr5
 board
Thread-Index: AQHXlAEXXQ4p6SL5vU2609JASMprJA==
Date:   Wed, 18 Aug 2021 07:17:25 +0000
Message-ID: <c9814716-b662-8e44-fc27-32b0c2692415@microchip.com>
References: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
 <20210816064416.1630674-7-claudiu.beznea@microchip.com>
 <YRwEEQ0SgQRDnd7t@robh.at.kernel.org>
In-Reply-To: <YRwEEQ0SgQRDnd7t@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e3abbdb-a2ab-4434-0e03-08d962183af9
x-ms-traffictypediagnostic: DM5PR11MB1580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB15802603111AD9FBFD8958A587FF9@DM5PR11MB1580.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PqqUg/QB0wapTuFcYhkfnnBhfJi7I4RPgeUFvOb78ILn1kOyDfLng53HI5J2/f54V3QgxoXwRpErMpHnp3bqW0T0FKL7L8f3yqmy72lS46dmhIwR26AAG3ZnY9NL8jfojojAXTPK9ToGVzO9sgojNwOcQ4GPWLp5nT2hsF+edYX/9P2HfiMvbC2TLz2TNIG2ClmhEfAbK9Oydv/UQjDklSHmbILHbpgtd7Ug5uVUkOQ4YFHVJFS9aNz1LbvchRY5BV4CR5uUMas0STxrPPf9YHttVQ3N82rIzotJ3Xd94iBoM+AAVksB4/A5jpfsNxehDJbSo++2hUgoMKGaQYV7pnU1F9/RoaPfqpnpC/ULdFPSFqInZVONgvXLgklLhM2EBoMQRiXomMWr8qj+ekEMl1KisNgNUNOjY3UlkZGry+ZBeymJNksMu9ZqNxj/VluSstjOYEdMwY2Q5ovpxydoPyy0EaRlJ+TN01NNYZZoQRHD8hXHWbN5yyJ1apGdY69jZ+yOvkhRmxWKynrRK1GzRGSDgfNtelXLw261yy0j8wAbE+klQ4q8ActqCK2nqY1bc6NN0w5KQHrz2Zqe6ZBIBdb9aAgKZDijwCgpU7fx/UqMuKkyEikNrDQq+bCXsDNE1TJUnfZa4V5+Tm1a+ASpjH6ZRiCcvwt0WoWgPBz8Yi3lxmNFrdVY8lu80g3CshNSC653vYy6GVlEjcd6D+ZsDMLmNePFwJW4jhl95pDjL1N4ZsnyMsEIYSDHr4xdz1EWC3G6tZwGh1NTL4qgSQKkKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(53546011)(6506007)(122000001)(6916009)(31686004)(38100700002)(2906002)(5660300002)(508600001)(54906003)(4744005)(4326008)(316002)(107886003)(2616005)(71200400001)(8936002)(66556008)(26005)(66446008)(31696002)(64756008)(76116006)(91956017)(66476007)(66946007)(8676002)(6512007)(86362001)(36756003)(6486002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bStkL2V4emtUYk0wZVdNdWxvQ1RpYjF6SmZzaGVzczlSaGMvWWtSSEpVL2xs?=
 =?utf-8?B?VlJxaHozSEJrK2VYbWt0blY3a09EU1lUUVc3eWFmdkxZVUVYd29EMFRJVWgz?=
 =?utf-8?B?Vjk1djF0K0plQ29YZis1SzZOODViZXNkUmJydURld3pRSE9xS0E2cG5jZUVI?=
 =?utf-8?B?NWNocjNsUzBzdHc0dUNrQzNVNndpZ0IwY0xaMlNQQll3MFdOWURlZCtabzdM?=
 =?utf-8?B?R0NBSVhtdVZodnFCS05NcVdnamgzS2xnTG5kS1JwZUR2TjBYYlY2TU5TTkxO?=
 =?utf-8?B?MlZhc0ZuRSt1STdySXRqVnpJM2lNd1l4TXpWVmZ2clhTYTdOajlVVmZlaEt3?=
 =?utf-8?B?SnRiQ3JYeHpYcmFic2todHV5WEcwK2NWQU45SDd2d2NnbVNEdUxxaDBnaFo2?=
 =?utf-8?B?cFNnSE5HNGVLRTViYXZtempTd3phRXljblJKKytxMXA2Mzg3Y2dFSXZnQlNH?=
 =?utf-8?B?cWNSZDBMbkwwVjVjY1dTUlI0dzl5a0lOU1I0b0syczF4ZGpUMEpnREsxY2lq?=
 =?utf-8?B?TGFEUmQzZTk3S3BRYk8vZjhRT2VJSVdnakxqRUlTRGVQeThBdWhURERPR2RW?=
 =?utf-8?B?UVFTN2k3N05VTHd5aUZucVlINGN5cHBlT3ZnL3BtWE12ZGVQS3p1eGlEem52?=
 =?utf-8?B?MWtFN0dJb1h1eE4rVXlDU2ZJUGhoUXNnZ0hyLzlieGhFRWdSRHIrNVRzYldo?=
 =?utf-8?B?Z1ZkUC9GdVJaT3Z1UFNIc2hNMG52eW9QU051S2R0eFRad0lBaXNrL1d6djFj?=
 =?utf-8?B?TnVoMkt0cDB1L3lpUmM5Zk5QVjdwNys5VGoyY0VCeUR2NzY0bG00Sk9VMUpV?=
 =?utf-8?B?WWo0TXdHMjhEUXhXbnl3eHJqa3gxZy95UDgzQVJ5NVV6R0NsTmVZOGJveThu?=
 =?utf-8?B?K09QTms4RUxOOE14bTE4SmxDM25DdTJjZ0FnMm5LaWlmL0IzMHF4T1A3bVFS?=
 =?utf-8?B?WXo4YUpWdHJqc0FXVmdua25iZ2xIdVVBWVZhSXdLUXZIUHA1UDIyS3BjWVRo?=
 =?utf-8?B?NlJzWk5ZaUNzYi9pdXZObUdrZkJjdjFRVWNnT0ZVWjlBVDR4SGo4ZDFsZEs0?=
 =?utf-8?B?Y3ZybVYyMUxEYk01bm9iOXZRUTZaN3Rza3JGcng5MXovbXptOGxwQzVFQnhG?=
 =?utf-8?B?L0twMmdmQ1RTRDU4Q3RVeEtqeUlWZDdSMW5WSWdka3JHMmJ3RStBY21NYzdj?=
 =?utf-8?B?U3JQTFdnVmFGdVhXZDdFSFd1ZkZaeVpoMkI1YzN0QlJGS25MNkJvVkdlV0Ni?=
 =?utf-8?B?RlJicjJCWmM1TDdtdmRpN0F3NzRPWHA4Snh5NytIWVBNcXdCd3hvU3dtcmxk?=
 =?utf-8?B?cG92S01vQlB0d0dpUjNiWE9PaEdkK1oweW5hMnR3ZXA3MkE0Q0NFdmVvSUlk?=
 =?utf-8?B?MnlKM25SV2JvQzd6UzRUR2NDdmlyRC8wd1NyeFJ3WUNyQStFQmw3NWJaSGV2?=
 =?utf-8?B?Q244YU5XL0lyOSttZURZcFphQ2E5STZ2bFJSQ2xORURRQ1dIMWNRNVROSWd5?=
 =?utf-8?B?ckRwMWNQdEttK1p2d0pRY2h1RkQxWFZBNXFadVFaYWpFUEdPNi9QM2J6VkNH?=
 =?utf-8?B?ZytHREVLSnRYZCt6Q05CWmErWEU3ZGdVaFVmMU94dWRCeDhWWmlNM3JDYjly?=
 =?utf-8?B?K0ZQR0FNek5TV3pIWDZnOHNpRDh1SjF6WlBvMEZ6eUlOazF4dnR2NXdWbEI2?=
 =?utf-8?B?d1pwN3BiYnhaVzErbHVVaHErakVlay9CR2FubXlNblU3R0dsMC9PUUM3cWU4?=
 =?utf-8?Q?ovlYR0MtkZT7viMiRk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F5AFBF692D3674EB6338327EECAC53A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3abbdb-a2ab-4434-0e03-08d962183af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 07:17:25.6284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3r2OJprIV34RNPNxFT6edLi+wPD36quCksiwkVZDbsF3oaxa70gk9URjBKR+bjLWhAmRNDgv7S7KXFQflFkGiaLVHT0mK/BsVYC20oTDmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1580
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDguMjAyMSAyMTo0NiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCAxNiBBdWcgMjAyMSAwOTo0NDoxNSAr
MDMwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBEb2N1bWVudCBFeGVnaW4gUTV4UjUgYm9h
cmQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVh
QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFtbCB8IDYgKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4gDQo+IA0KPiBQbGVhc2UgYWRkIEFja2VkLWJ5L1Jldmll
d2VkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5ldyB2ZXJzaW9ucy4gSG93ZXZlciwNCj4gdGhlcmUn
cyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBhZGQgdGhlIHRhZ3MuIFRoZSB1
cHN0cmVhbQ0KPiBtYWludGFpbmVyIHdpbGwgZG8gdGhhdCBmb3IgYWNrcyByZWNlaXZlZCBvbiB0
aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0KPiANCj4gSWYgYSB0YWcgd2FzIG5vdCBhZGRlZCBvbiBw
dXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5IGFuZCB3aGF0IGNoYW5nZWQuDQo+IA0KDQpPbiB0aGlz
IHBhdGNoIEkgaGF2ZW4ndCByZWNlaXZlZCBhIHRhZyBvbiB2MSBhcyBJIHN3YXBwZWQgdGhlIGNv
bW1pdCBtc2cNCmFuZCBkaWZmIGIvdyB0aGlzIG9uZSBhbmQgcGF0Y2ggMy83LiBPbiBwYXRjaCAz
LzcgSSBnb3QgYSB0YWcgZnJvbSB5b3UgYnV0DQp5b3UgaGFkIHRha2VuIGl0IGJhY2sgd2hlbiAo
cHJvYmFibHkpIHlvdSByZWFsaXplZCBJIGRpZCB0aGUgc3dhcHBpbmcuDQo=
