Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F73F1791
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhHSK5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:57:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:57013 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbhHSK5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629370586; x=1660906586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WWe+d8EC0cjNN9tExjKTdzPpVZcc2bhGs0PCpVpRckA=;
  b=ulNZ1WwTGvVrkFyjtZAZ+h2b4PGzbG2UzAwqqh9z/kIt8eNQy4SqIk7S
   v7leP0enhMf4LgrQXbAgJcjvP8I235GQeGbn3/jvl5KQYCGc7fBagpKUn
   xD/UGd8SxNCFgTH7DXOx2Vn9cZLNNn7itVKabDAVwdPykK1lEPwQKQtzb
   W3iX2sJwqSPO639KNzPACPdef8AJiWMhjsTMGhT2M/1zSaA94SLXS3wIS
   U7NAlRTn+BCq5L4IvqJb+YbY8JuvsWCxnNVzwYcyOtNCtPyC5MEW1ypd1
   qgynCgOkozQQ12d3klDcF7Flb+cfVJAKk8DRA7vL3cnqV0AVq08AZvFR+
   g==;
IronPort-SDR: 8gJeW+CDwKaWkKn99QG8VnPEAgaKqqSU5R11Ta424d5HNljTw/N3oOygoUkpcpH1yOyWVZobBz
 Y2SDsUxuyCivgXsyMZGtg6AjMTMaXNim6X8/HVlL0d+25GdNpYTKpJ9tAEl+xqstCVx53V85YY
 FK+Se5kFnWhn1qwH8IpQow7A6GFuG9FpXnsTWNp6xBnk1h6dIn6TeTyr8gZoksHa991WT3EMVd
 O0PxhE2iibkqQNhYmyPLpfwnHPRIWMVlz/xAk0/w4yyXntHAlpOsFrZ7HA9921JdAK+hb2Lnbe
 OVtEVXjMJDu73iQeX/vpxknV
X-IronPort-AV: E=Sophos;i="5.84,334,1620716400"; 
   d="scan'208";a="66413312"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2021 03:56:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 19 Aug 2021 03:56:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Thu, 19 Aug 2021 03:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBQSlBpCW3Cgq+GtUiPzanCstOdNB4wJVgRGw2UO4YJrtkw04R6VHktH4zkgSa1WCTQ/gic3exg57hjQH2FCj7+4zmnsj2CcYj+Wzp0ehrPiH9sCMXIRYD99kVj3WfHwFVqY8o3OkDtVEEvRs4YsrWSajqctI2eIJshjyKcb7s0RQaV2XwLbSBPjSkSChIBM4WLnS5fpRqQhPijBvhHufWFPITgcG1PxavER+tQ+phzb8mHSkERxciKiv7Qg0eeWHlEY4Vir66RMgljX/J6Jf9tJeJMxDJyI2ldUQC9jx4vP7DXSxCMsbSmmXuENLjy5Mj9UgfrQo/eXyDwkIkj1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWe+d8EC0cjNN9tExjKTdzPpVZcc2bhGs0PCpVpRckA=;
 b=oCnep08NYRQo/c+YQEfinIAWvqOxqj5oMU5I0Knk959xtuZrkqzUqp1RHmyXvVGhuvEcBYM+m7GBleiE/Ddhr1fZ3kCFkvptvP6gUrzvl+ZnqICXb0cs21jGNuEb1i3pw9+nrD0HMb9fIUykMR6vpncJYGlmMRtBm95ySbQwLccLWfjdB1DCRfOMFWkCP3GKlVDHy6/fMrkI1CFVX2o2FhfliLKjlsbyb+Q1+uOkxNHmzwCE5vfJwyfXsLBdONLMc0oibvccMsU4JEvxvuj8xNWgBv6YJ9uZYS/2OdXmXsfZ9mY8ZL2CJgsereQj6rHdEOOB94iBCXypmRsTxvIXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWe+d8EC0cjNN9tExjKTdzPpVZcc2bhGs0PCpVpRckA=;
 b=UKV4538s0UYmO3SmGXB45CWabyjFUG3jPUpMtGQV/leZF72QTkJJy793KwZ73ZDrODmXtyI+HuPpk1NhjrvDFgnnzD1d97UWt57v1QkIQ0uBclhjsDwaJrILJltZKbV6hWMah8gquRbNeyRzTE9v6WnOoISav7UVA6/7E+tOIMA=
Received: from DM6PR11MB4185.namprd11.prod.outlook.com (2603:10b6:5:195::29)
 by DM4PR11MB5437.namprd11.prod.outlook.com (2603:10b6:5:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 10:56:22 +0000
Received: from DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::199b:aeaf:73e5:c4ac]) by DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::199b:aeaf:73e5:c4ac%6]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 10:56:22 +0000
From:   <Hari.PrasathGE@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <robh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/2] ARM: at91: dts: at91-sama5d2_xplained: Add comments
 for sama5d29
Thread-Topic: [PATCH 2/2] ARM: at91: dts: at91-sama5d2_xplained: Add comments
 for sama5d29
Thread-Index: AQHXj4OHTkczeiuEmkWOx7AIRbtGAKtwQNYAgApx0gA=
Date:   Thu, 19 Aug 2021 10:56:21 +0000
Message-ID: <78b26b01-b66f-5779-9f67-fdd13e473dfc@microchip.com>
References: <20210812140758.28273-1-Hari.PrasathGE@microchip.com>
 <20210812140758.28273-2-Hari.PrasathGE@microchip.com>
 <YRV13nfgpEEuOOxB@piout.net>
In-Reply-To: <YRV13nfgpEEuOOxB@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 401503e8-2474-43c1-7105-08d962fffb36
x-ms-traffictypediagnostic: DM4PR11MB5437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB5437A8416543F8A09088DE438EC09@DM4PR11MB5437.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wc5crzYmITxitaXhUvV21fJ/St78cXrTACOJbtkIBMTRybnYYu3ce8KzOdZpJPaOMIDpjRx0zr4qJgzvarUKCNTvP+B6Sh2//4Y8ENLU+1Qr4cUMuKdks2ANU2sZRI7F1zQvyaF3XissWPKkQnSltGQHjPBzRrO8ThzL6VP5zRCwPZuERtfc9zddWf5NZNdX9FBv/XtxgAw1jysFFfOLTMC68VAYddnH/AnnlGSX8mGW4mrMGOb10fUobB266kk0G5Qd7/e8iWuz/3Ea4Qr7GunM/bKn1JQ2ysrbmBHjzLDE+FbiYzl//rDHedqeEITUbzPw66uaTFZ3FA44zUqZ8b+zhbZUAkk1dd7hDJ3c21fBy/thjeULNDEZlmCMx6fbxHacmY7Yxhg6gGpXNmuzC40xaNgxxy9elxPfTj7SBv138V+2vO28hSizPa9qoVIt5NzGW8Jf1KhbzkEMHX2LrhChBNg4QemLlRF8/zoU3fPS3etJSW1neM8rMK5C8OICY9a58EM31LNUA7ficm2vhA4niCKhJ5yATrBw7/ijBPoIA1FeYoUvajgMHAYItHWtEXZ3nPC33hSKsFvrrZraniC1RlAcsJpOBbY8ueGkvcJg2hYbKiCwZKpSapRz85bREIrKMF9KwxdEm1YWQ/glsM5eR4YGQFtIBHefui8YxoLDecUgMAAkgVutGhP8AzfI0wzTzReNIZdWtykyhMZIBV1EOEbNtLsXukgnhv/Z+XXX5E2qsRgC0Xfs/EhlxfNiOot73+noHOsaG6Dk5KPjIxZ16jKlagTWC8lZyUkAPdZ0tn6Ue6jE/WuDvmCDgAx+qXZJpa47AGhWooji1Uh9biKOin7N0cMLlqo7aIz+htw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(366004)(39860400002)(478600001)(66556008)(966005)(8676002)(66476007)(26005)(76116006)(91956017)(186003)(71200400001)(66946007)(54906003)(53546011)(6506007)(2906002)(36756003)(38070700005)(66446008)(5660300002)(38100700002)(122000001)(83380400001)(4326008)(6512007)(64756008)(6916009)(6486002)(31696002)(31686004)(316002)(86362001)(2616005)(8936002)(138113003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0o2bnZ5YXlpR1h1WTJhYTZHVWJkL0dNTTNSRFhXdnZWK29JNEVkbEtRbFVM?=
 =?utf-8?B?VEkyRVJDUmZacGRBR2FRN1lGREhiRTlJVzlrTnF3dlNDVHdnaHhZSEZ4cER0?=
 =?utf-8?B?TWVhb2VNV0J3NDlIU0paOGFXM2M3RjMyd2hFU244WHhGSmFNNUZpWWR2cEVM?=
 =?utf-8?B?WjYrVWZRR2hOY21mWXNpcU8yWFdmNE42VnhUSTNiTjBiNFUzR1IwVFV2Zmo1?=
 =?utf-8?B?cTdVZUk2MXEvSngrZ0R6VW85RFlFbFlOdXNQMVlHeWZrR0x0Vnl1eGtGdFdO?=
 =?utf-8?B?TlZmK3BKOHVUQnlTV0ZtSW1VVmFlcDBBeTNLa0ZvYXZLSnpMbUVHYnhiYU9D?=
 =?utf-8?B?enpRWlJQczlCWTE3aTdUWjJiN2JNQ2FyZjBjdGZnN25CWWZZb2FKaXZxOFdm?=
 =?utf-8?B?VWl6eERIL3l3bXRtdFJrTXY5ZTQ0WjBOLysxMXRDL2RidTNyNWtETk5TUUlV?=
 =?utf-8?B?RUw4TUIveTA5SU1kaGhLZDJBeS8ydnByMThWMU9nTkVrV3hSdHNZU0tNZFMv?=
 =?utf-8?B?cVlYU1RrTjJwZTZSQWM2bC90N29acFVBcjhPUWEwNzZXV3FldnEwb0kyY3dv?=
 =?utf-8?B?UG82Rm41ZXUvY0xxUWF1dUFUVy9COE1XdmtjWXIvT0Z2bUFwT3duYWZ2V0ND?=
 =?utf-8?B?M2ZyNU00anpSV3FYT3dtaW0vS0J2dS9WZE9ZOUp1SjlnUkNTNkV1YkFGQ1pm?=
 =?utf-8?B?aXIzUVhxV3dMMXRYY0MrSUdzK3NNNmp6LzFWZGw2d3l5aHlaQ3gyRml1eUhE?=
 =?utf-8?B?U0VOaVZGWitaNlhiZmtQejhzTXIyQ3FhYkREbitVVzZieTlpRTFwdG1NZ0Zh?=
 =?utf-8?B?T2gvbUZqbUg3bVhOZWJhcG9KRWgrSkoyVVJXNy9lRkt1M29xL21SRGZTR3RM?=
 =?utf-8?B?VjQxUDN4V0VRejF2c1NZbG1GVjc4bWZhVUhVSnNlSzliRGtSVHFjUld3MWR0?=
 =?utf-8?B?RWlvZm9XN1lnVVBRYm9OenFmTzdORTBJZjhuUWRGZng4TkZFUzZZNE0vZ3VD?=
 =?utf-8?B?UlRpNFFIOEtKbDcvU0VLRG5VOERSN1M0OTV6UXRKbmtoOCtPQjRKNHRIL3NC?=
 =?utf-8?B?MkhmU2dxdzF5MDF0Y0xoN08rbGlOa2ZPcDQ3c1BJMjJjeUdpN1FkdWM3Rkgr?=
 =?utf-8?B?ZlQ0OHM3UlpKN01xcVRCV1Q3RzFJcEczdDNKWUwwREFjS1F6Q0FCQXh1VnBF?=
 =?utf-8?B?eENqTnRvOVl3ZVNKNGdMcDNlM0FyeTBETlRQTWRGcmFUcHNqSVkwVy9hdHc3?=
 =?utf-8?B?QXBjVDZxYjBZRzhobXAyWXpLTkcyRGwzVHBub1pPcG5jeWdLOHRESnN0cjFB?=
 =?utf-8?B?TmRCSU4zd3c3UDFYNC9mUXNYWFFaSTNYOWhtQW1mMjdRVnFQQVBZUUJ2ZHli?=
 =?utf-8?B?UVBXYUlSK2U0UmhERkl6clZVMy9MalNoUGEwamhuNzJxNERSbEpSdjJ0NkUz?=
 =?utf-8?B?SVkyODR6THJ2Qld0MnNyRjRjZDZKTE5ITzVwSWFoMHhLOW9QREhLWGlCM3lr?=
 =?utf-8?B?enhnMkRpRFNXbnN4OXh0OU8yRFNIaUd5Q2c1cEg0NVF0c0tmYlVvV1JuTFpY?=
 =?utf-8?B?NnFCSUkrVkJWOEw1Q0YzZG82K2dsRi80UzBIbFNqSFFvZCt2eFdlelhoNmdU?=
 =?utf-8?B?SXBMTU15MVMvMERmczgvYjJmaVFUVkZ0REFSaU5Ma0RTUVQ1b1RjVDZzdzhj?=
 =?utf-8?B?OFhwSmtzMzQ0WkE3RWdYUkFtNElGQkVzclNHamcyOW9jSHZNeUY4SWo5dFdq?=
 =?utf-8?Q?EmUGMVADNc4o99zJnVesW91z0XAkh0YrGQ3aHq1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1E2DCF2DE36994DB7C9A21CC1FB5E07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401503e8-2474-43c1-7105-08d962fffb36
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 10:56:21.9458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkKtgyGJNBYO+ehHzzbbbBXeoOmsGqElbD/lQl8a/SfQrjHTUbOtqndc6z6v4wEx9LhryZ3Q9m3OIwKQgtJYyR7WTdLR3bdhC3yRMvcm6Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5437
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCk9uIDEzLzA4LzIxIDEyOjU2IGFtLCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIZWxsbywNCj4gDQo+
IE9uIDEyLzA4LzIwMjEgMTk6Mzc6NTgrMDUzMCwgSGFyaSBQcmFzYXRoIHdyb3RlOg0KPj4gQWRk
IGNvbW1lbnRzIGZvciB0aGUgZW5kIHVzZXIgZm9yIG1vZGlmeWluZyB0aGUgRFRTIGZpbGUgZm9y
DQo+PiBpbnN0YW50aWF0aW5nIHRoZSBzYW1hNWQyOSBTb0MuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogSGFyaSBQcmFzYXRoIDxIYXJpLlByYXNhdGhHRUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+
PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxhaW5lZC5kdHMgfCA1ICsrKysr
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyX3hwbGFpbmVkLmR0cyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxhaW5lZC5kdHMNCj4+IGluZGV4IDYyN2I3YmY4OGQ4
My4uZmFhMzAwNjNkOWE5IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1z
YW1hNWQyX3hwbGFpbmVkLmR0cw0KPj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1h
NWQyX3hwbGFpbmVkLmR0cw0KPj4gQEAgLTYsNiArNiwxMSBAQA0KPj4gICAgKiAgICAgICAgICAg
ICAgICAyMDE1IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAYXRtZWwuY29tPg0KPj4gICAg
Ki8NCj4+ICAgL2R0cy12MS87DQo+PiArLyoNCj4+ICsgKiBSZXBsYWNlIHRoZSBsaW5lIGJlbG93
IHdpdGggInNhbWE1ZDI5LmR0c2kiIGluIG9yZGVyIHRvIGluc3RhbnRpYXRlIHRoZQ0KPj4gKyAq
IHNhbWE1ZDI5IFNvQyBvZiB0aGUgc2FtYTVkMiBmYW1pbHkuT3RoZXJ3aXNlLCBsZWF2ZSBpdCB1
bmNoYW5nZWQgd2hlbg0KPj4gKyAqIHVzaW5nIHNhbWE1ZDI3IFNvQyBmb3IgaW5zdGFuY2UuDQo+
PiArICovDQo+IA0KPiBJIGd1ZXNzIGl0IHdvdWxkIGJlIGJldHRlciB0byBoYXZlIGEgYXQ5MS1z
YW1hNWQyOV94cGxhaW5lZC5kdHMgKGFuZCB3ZQ0KPiBzaG91bGQgaGF2ZSBoYWQgYSBhdDkxLXNh
bWE1ZDI3X3hwbGFpbmVkLmR0cyksIGVsc2UsIHlvdSBjYW4ndCBjcmVhdGUgYW4NCj4gaW1hZ2Ug
dGhhdCB3aWxsIHN1cHBvcnQgYm90aCB2YXJpYW50cy4NCj4gDQo+IA0KVGhlIG5ldyBTb0MgJ3Nh
bWE1ZDI5JyBiZWxvbmdzIHRvIHRoZSBzYW1lIHNhbWE1ZDIgZmFtaWx5LiBJdCBpcyANCmVzc2Vu
dGlhbGx5IGEgbmV3IGNoaXAgcmV2aXNpb24gb2YgdGhlIGV4aXN0aW5nIHNhbWE1ZDI3IHdpdGgg
YSBuZXcgR01BQyANCmNvbnRyb2xsZXIgSVAgdGhhdCBhZGRyZXNzZXMgZmV3IHNpbGljb24gaXNz
dWVzLiBUaGVyZSB3b3VsZG4ndCBiZSANCnNlcGFyYXRlIGV2YWx1YXRpb24gYm9hcmRzIHRoYXQg
c2hhbGwgYmUgbWFkZSBidXQgd2Ugd2lsbCBiZSB1c2luZyB0aGUgDQpleGlzdGluZyBzYW1hNWQy
IFhQbGFpbmVkIGJvYXJkcyBpdHNlbGYgYnV0IHdpdGggdGhlIG5ldyBTb0MgcG9wdWxhdGVkLiAN
CkhlbmNlIHdlIGhhdmUgdGFrZW4gdGhpcyBhcHByb2FjaCBvZiBoYXZpbmcgYSBzZXBhcmF0ZSBE
VFNJIGZpbGUgYW5kIA0KcmV1c2UgdGhlIGV4aXN0aW5nIGJvYXJkIHNwZWNpZmljIERUUyBmaWxl
Lg0KDQpXZSBkb24ndCB3YW50IHRvIGNyZWF0ZSBzaW5nbGUgaW1hZ2UgdGhhdCB3aWxsIHN1cHBv
cnQgYm90aCB2YXJpYW50cy4gSW4gDQpmYWN0LCB3ZSBkb24ndCB3YW50IG91ciBjdXN0b21lcnMg
dG8gZW5hYmxlIGNlcnRhaW4gZmVhdHVyZXMgdGhhdCBhcmUgDQpicm9rZW4gYXQgdGhlIHNpbGlj
b24gbGV2ZWwgaW4gdGhlIGV4aXN0aW5nIHJldmlzaW9uIG9mIHRoZSBTb0MgaS5lIA0Kc2FtYTVk
MjcuIEluc3RlYWQsIHRoZXkgY291bGQgZG8gdGhpcyBjaGFuZ2UgbWFudWFsbHkgYW5kIHVzZSBp
dCBpbiB0aGUgDQpuZXcgU29DIGkuZSBzYW1hNWQyOS4NCg0KUmVnYXJkcywNCkhhcmkNCg0KPiAt
LQ0KPiBBbGV4YW5kcmUgQmVsbG9uaSwgY28tb3duZXIgYW5kIENPTywgQm9vdGxpbg0KPiBFbWJl
ZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+IGh0dHBzOi8vYm9vdGxpbi5jb20N
Cj4gDQo=
