Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32A539579A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhEaI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:58:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:46641 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhEaI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622451402; x=1653987402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=piK1XbY7jcBDQj8Xy0QLZptWNmt4Tdfoj6wfPDC7wdo=;
  b=QwGeL1EJWtq1esWCHcRNDq0zFy6ygba5hb0dLJnrSyHHXwJg3GBPwLww
   zxz3hpW/4yZAznm/2Ia5cfvuuc3g8MxnzouHad+c3a4TsEI9GA0J1uMV9
   LayJsU9m4GtlapjCF7OvhZ+W3CCE7j1KqIAlKlaGv1XlTrez89B7YaWlC
   ii0upqaPVyp7Sky3bklVb6jlU9fyBFYYr4p8GVMI0XIQdVtK9p8mE5MH5
   519OF+Ubh5bM097t9Dtssv/LQtmjhpj0SZwkYR4ZW5X8A0MGW5YcNYRJH
   WMMXU0L9qIBQYglWU6ITYBcHYENab2RmWY3txiLQr9iMKTIj3qAaMiLtc
   g==;
IronPort-SDR: ktdcm5B57fSt3FlykvyEHbm7zE2AljYGs57ySwoqGpcg9r6T496AvARLcC1jd370Rpu4kTpFDa
 v4n57F0P9+mVGYKVLaEGxZPeTiMN6ye+Qqkqd/dyloZO5Mbz4qBPYAr+5ddROVmOGl081C804R
 WaZS5bjThQ/Kdq666s8jbGn087h6ggTPO6c7hvSdHLENEA9uZjfqUtZT/9NxkV6yAC6e5VkN+8
 oV4l3G/j/V2iREnDaUgsk1Q3uZLJv8eQug5v6IztReTi4ur/T3LHv9Q7t+g19GiwCqFbk8YEvb
 N68=
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="122957300"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 May 2021 01:56:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 01:56:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Mon, 31 May 2021 01:56:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkvQxzaxh1ecxSNqQSn0u9BvXSS98s3BzleQCpSpMSaERJgCf8fUZXCZHfQv5k5uQriEIfnvKacToRyQbRnz0Ms04lLhyM2cfEs7scUTfTZBlhV4hKCFw6wpU7QbXdes0X//fmmKXOLDc0Gkqri8mC9NeC6+0ggDH9Solnx83FDpQ448Kle08qjITO+dJjNi051b7Fp9H1Jf7z0pCa1H3DSRNfgAziKf6V2YVTk3gb6PCOUVMHCpVEnuhI+2ryZ5EjwSOF5OBcsZM84dllDzRVAFRrpt9hiDpitVpNFFVi/seuWvFmOMudHzT7YDAZBZw69EhSu8DeHRFQadLWXeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piK1XbY7jcBDQj8Xy0QLZptWNmt4Tdfoj6wfPDC7wdo=;
 b=KdQPW9J0Q8xnpg5AoVj/2vkPOk7s/oNJX5dsw9MK7t+vKNJeIz6rlRKx7dj2ihLwild+EAH0AlTXB0cJSUzDPQbVE/xMBx+xaD1ZLWTVTKvVmExmcJn43T+4qrfI3L7VjuqeTZifpcXOWZ7cWQIn8DxCIw1umKowjOtka6rf16CuqwDirVwtvuYLty4zRlAGLM1+Mj3y8LaIkuqCWk7xOFzw6gjfKVWWPiEDXuBW1CeDiaowfhptzKeZd3Y+kPgyxlkBkjDUkCk15m+CaQlq9O5pkge2FRx4fLMKET+6skiOaMs304sM5Poc5EnGsgeehkG9GgpdlRUduvoGLdPN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piK1XbY7jcBDQj8Xy0QLZptWNmt4Tdfoj6wfPDC7wdo=;
 b=KHO+GVscG1DnShECYhGdKxg8u961+JT3kyyBszuEUUrjS+RUwVN0zdllgQ7jX9niKegr5Tvwjc8ZAmK3L+KUAkZCDpNPvCa5HzEKkHHGgVIUSrrnXTpwIuZSvEEZr/gn8TcjyBFxSacf+3FAv5BJdtKocri9feoExsREEJOuecc=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR11MB1840.namprd11.prod.outlook.com (2603:10b6:300:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 08:56:39 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4173.029; Mon, 31 May 2021
 08:56:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v4 4/4] mtd: spi-nor: otp: implement erase for Winbond and
 similar flashes
Thread-Topic: [PATCH v4 4/4] mtd: spi-nor: otp: implement erase for Winbond
 and similar flashes
Thread-Index: AQHXVfre5CE4GzTJPUCkLlU8wI3quw==
Date:   Mon, 31 May 2021 08:56:39 +0000
Message-ID: <2d04a7f5-c99e-3177-5a1f-debe49f51ef5@microchip.com>
References: <20210521194034.15249-1-michael@walle.cc>
 <20210521194034.15249-5-michael@walle.cc>
In-Reply-To: <20210521194034.15249-5-michael@walle.cc>
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
x-ms-office365-filtering-correlation-id: 59fba66c-600a-4885-044d-08d9241200e4
x-ms-traffictypediagnostic: MWHPR11MB1840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1840629A9AA81F71909E7258F03F9@MWHPR11MB1840.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F2giyjrtueOCNJI3EuBWR2lyYOOfoO6lN8DwmFN82FsUzUuICNvrviJfC5uRoLRzO4YnDjW2PYqB4L7dzskkcS+hEARF2H+YpEWecM0JyTLbAQHu1/yILfCFaBd/oE0F26MALv67N1LzaMF/AqGnFAhRsrvr5RWZMLs1ow4Lb07nmyLWN/EOIBodzoGMHqEkHzOaIgY9KFY+IZJnoLY+jaomPoUK0UiSZG8CbDvJDE/08CO0a/5krN9sNWCYuRlAH6rbJ6Oj/T5ng4SMxFQnDlF/9eoqsnBtSIkS7sGeGjwZlnBmaWJileyOAUxtCvCym0SZBFzoE0qIHM7kOmx6BPj5MPp3MyB3Xyqnv7iQidHy8bix1NCbnu+U2oEQOVPYCcGbiMMTeMqt60SVjCq8aKhIIsk//EZ9Y8POtMv4E50Y7PBslFOiiliyTcn7D4dX37NGiWlC+hhxERaO/+f6nKbZNoqjL526/V74dADn1yBbq41ERUCr12r65BmbsnTgFfdUGKEnh7YpQvLZX+2WB/4uS/bH2T3oTB5mxtuYFiJlwv88C9FSjWXDdoeUZhqcgZi+xRsPsQfe+vKIk42eHDf4l3bsdiluVe/96yrn26J7v1Qk1nJ63VqZpjf8EHJcTWL+AvJjcrclZIEdMW6MOgwjseKZf/WZOjINYWQhSfn+cqf3L3nQfpmsvtU2ROQj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(366004)(346002)(396003)(76116006)(66946007)(91956017)(2616005)(66476007)(54906003)(4326008)(66556008)(6486002)(66446008)(31686004)(83380400001)(36756003)(6512007)(38100700002)(478600001)(26005)(31696002)(53546011)(6506007)(5660300002)(2906002)(71200400001)(8676002)(86362001)(110136005)(64756008)(122000001)(8936002)(316002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VzF3QVlhWEpLN1JEWWphdG5pb2s0aTd6YWY1TGFKVFo3Z2VLSjdEN1E0Q0R4?=
 =?utf-8?B?TWlOa04rdW9oWjRaS2Raa1ZyT1lvL1Q1N0FXcFNLNzJyaUFXekRZT1YxWlJZ?=
 =?utf-8?B?RFFTbWNUME1QQTFjSUw5U0I2L21zMGRHYnZVSVFBM1VvTFBlZjJ5OEpZaDBl?=
 =?utf-8?B?VWp3MWE2T2l0QkhsYU1VaFZydlAxYnZ0bng2MVdPV2E0ZE4zVjlSZGZEOWNp?=
 =?utf-8?B?Y2xuQVFhMWdjbmkxaXU3Nk1XZDV2eDNEeDVQb1l0cTZJeUE5anhoUktzK1l0?=
 =?utf-8?B?VUJYYko1VU04NmNweGsrWjFFQmlnUUZHL3drT3M2TGhmdkpQRXNYbk0wWEdU?=
 =?utf-8?B?M2dZeUx5QksybUVWK0xkMnB2TzdDeDVXbUdFajNoY0tTVHZ2RTNuQk9vNU8w?=
 =?utf-8?B?SVg4UzVyRmlCdjhFM1AwWGdwSnRJV1p6bU9RMFBXTHFCS0lwRFU4b21ZSXdC?=
 =?utf-8?B?eEo4SkdoSHhjYTRERFFEQkNaT1dLQXA2dWk5Kzd6L1k1NUU1RHZoRTBacG9J?=
 =?utf-8?B?NklqYXZidWdWeStoS2crcWErSEpoZmQzazZhUUE2SzlxL1J6M2RlUUxaQTN6?=
 =?utf-8?B?T3hvalM3aUhxN2FaUnhOVVdhMTJEQ2d3RjdpczcyT2FYcDdtMkFrSVFXQnM3?=
 =?utf-8?B?RE14NlhFOXI0UUpZa2xSOXdSbldxSUtGVno5eER0cFlTTjNlNEdVRE4vcm05?=
 =?utf-8?B?Z2tzVzdIUUYyYU9yeVUvOHBWLzVxdHRxQ3ZheUdUSzRRVU9tcCt0VFBmS0NU?=
 =?utf-8?B?M3NLVGdnZVBpVngzVkR1bURna3EwazF4VkwzWW0vRnhXNmVFaUFMeVJVcDNl?=
 =?utf-8?B?amJaNEZ1VjluZ29PZ2E4dTdGZURUUTJCdmRGZFE2c0lKaGZqKzdkQzgzZTNh?=
 =?utf-8?B?V1RUVnBka1UxbjdwaTNMckg4U3drdXlaaXZpTHJFYkorS3dRTFNyZDhjR2pa?=
 =?utf-8?B?Z1FOT1VIQVo0ZjN3SXoyTEtGb2p6VFRKTlBTZ2I5T1RQTzFPNCt4b0dQVTl3?=
 =?utf-8?B?RnZqenRrSHFSajZpNWtDMWt1LzExeTc5N2NDV1ZMUzZmcFdMcWw3V0JsbXgx?=
 =?utf-8?B?UEpBRjE1T2dlUDhTVGlGcm9NTmdxZ3psQnAvYmFBOHlHN2pqVGhOeVlxRjlF?=
 =?utf-8?B?eGY5U0xFeXBmVnEyT0I3TFZVd0ZuVCtjQW4yVm1NUDc5dkNuRmo4SUc1dmty?=
 =?utf-8?B?MnY5akNHYzBwbm15UXJBSTMzUWVkVDdBc0FtbzlwaUJlUXNKV0E0RlRKMlZY?=
 =?utf-8?B?ZS9VNG5UcXVpd1IxbWozc2dwVUlPbEFmRmVtM2lYYjNGdW44YXBUZEpPWGRL?=
 =?utf-8?B?a0tPMHR2WkZyYjR4NlpDK3lqMzlvUm1QTmkzb3ZURjE1aHFMdmYvQVNpSlJH?=
 =?utf-8?B?UzBKSjFOMzJrSkgrOFd6WGJPdXo3b1JyVWRFVHIvTGNMcTdiSTZqY2lzVGw1?=
 =?utf-8?B?d2FpTVgyVkEzK3Iwd0FIcjRaUXVQb1JvYm00aEwzcERwaldsaHVaZXlpVEx4?=
 =?utf-8?B?MlVNUENqcnpTa1V4SVJUdUFRYTVDVFdjSkYzb0hKdWlmTlNJU3RxdC9COEg5?=
 =?utf-8?B?eVlVVE04N1BsQ2tFRlBIK0hvVGpMWk4rSjA2WFh3cjZ2bTI1a0NHSFVlb216?=
 =?utf-8?B?VmN3cEt1RDVLVFN5c3pFRStVTCs4bGVSM2d2TkR1Tnk3UWhvNWFvek5VclY2?=
 =?utf-8?B?clNrVHNYRS9WbWNkdjNxMDhiNTJENjBrenJJM3E3MEcrdW00SVpsVXM2Z3B5?=
 =?utf-8?Q?UKPvoZ9YvLIuonGF74=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D89BF85BECD2E4CBAE0780F067FFEDB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fba66c-600a-4885-044d-08d9241200e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 08:56:39.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcH4RD+4M7NUXXr/zA2/Ck7Xprxbr7vsNoD3JaLJKtBOFHkqQBjHVsZYA0tfNzrUFRjIZqD130MUsWI+0nx1fC2BghgbjMQAxJ5Uxd2nTss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1840
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMS8yMSAxMDo0MCBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBXaW5ib25kIGZsYXNoZXMgd2l0aCBPVFAgc3Vw
cG9ydCBwcm92aWRlIGEgY29tbWFuZCB0byBlcmFzZSB0aGUgT1RQDQo+IGRhdGEuIFRoaXMgbWln
aHQgY29tZSBpbiBoYW5keSBkdXJpbmcgZGV2ZWxvcG1lbnQuDQo+IA0KPiBUaGlzIHdhcyB0ZXN0
ZWQgd2l0aCBhIFdpbmJvbmQgVzI1UTMySlcgb24gYSBMUzEwMjhBIFNvQyB3aXRoIHRoZQ0KPiBO
WFAgRlNQSSBjb250cm9sbGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8
bWljaGFlbEB3YWxsZS5jYz4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyAg
ICB8ICAyICstDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCAgICB8ICA0ICsrDQo+ICBk
cml2ZXJzL210ZC9zcGktbm9yL290cC5jICAgICB8IDgzICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYyB8ICAxICsNCj4g
IDQgZmlsZXMgY2hhbmdlZCwgODkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3Bp
LW5vci9jb3JlLmMNCj4gaW5kZXggYmQyYzc3MTdlYjEwLi45NTUxZWZmYjZhNDQgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5jDQo+IEBAIC0xMzE4LDcgKzEzMTgsNyBAQCBzdGF0aWMgdTMyIHNwaV9ub3Jf
Y29udmVydF9hZGRyKHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZfdCBhZGRyKQ0KPiAgLyoNCj4g
ICAqIEluaXRpYXRlIHRoZSBlcmFzdXJlIG9mIGEgc2luZ2xlIHNlY3Rvcg0KPiAgICovDQo+IC1z
dGF0aWMgaW50IHNwaV9ub3JfZXJhc2Vfc2VjdG9yKHN0cnVjdCBzcGlfbm9yICpub3IsIHUzMiBh
ZGRyKQ0KPiAraW50IHNwaV9ub3JfZXJhc2Vfc2VjdG9yKHN0cnVjdCBzcGlfbm9yICpub3IsIHUz
MiBhZGRyKQ0KPiAgew0KPiAgICAgICAgIGludCBpOw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbXRkL3NwaS1ub3IvY29yZS5oIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4gaW5k
ZXggMjhhMmUwYmU5N2EzLi45Mzk4YTg3Mzg4NTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IEBA
IC0yMDcsNiArMjA3LDcgQEAgc3RydWN0IHNwaV9ub3Jfb3RwX29yZ2FuaXphdGlvbiB7DQo+ICAg
KiBAcmVhZDogICAgICByZWFkIGZyb20gdGhlIFNQSSBOT1IgT1RQIGFyZWEuDQo+ICAgKiBAd3Jp
dGU6ICAgICB3cml0ZSB0byB0aGUgU1BJIE5PUiBPVFAgYXJlYS4NCj4gICAqIEBsb2NrOiAgICAg
IGxvY2sgYW4gT1RQIHJlZ2lvbi4NCj4gKyAqIEBlcmFzZTogICAgIGVyYXNlIGFuIE9UUCByZWdp
b24uDQo+ICAgKiBAaXNfbG9ja2VkOiBjaGVjayBpZiBhbiBPVFAgcmVnaW9uIG9mIHRoZSBTUEkg
Tk9SIGlzIGxvY2tlZC4NCj4gICAqLw0KPiAgc3RydWN0IHNwaV9ub3Jfb3RwX29wcyB7DQo+IEBA
IC0yMTQsNiArMjE1LDcgQEAgc3RydWN0IHNwaV9ub3Jfb3RwX29wcyB7DQo+ICAgICAgICAgaW50
ICgqd3JpdGUpKHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZfdCBhZGRyLCBzaXplX3QgbGVuLA0K
PiAgICAgICAgICAgICAgICAgICAgICBjb25zdCB1OCAqYnVmKTsNCj4gICAgICAgICBpbnQgKCps
b2NrKShzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1bnNpZ25lZCBpbnQgcmVnaW9uKTsNCj4gKyAgICAg
ICBpbnQgKCplcmFzZSkoc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IGFkZHIpOw0KDQptYXli
ZSBiZXR0ZXI6DQppbnQgKCplcmFzZSkoc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IGFkZHIs
IHNpemVfdCBsZW4pOw0KDQo+ICAgICAgICAgaW50ICgqaXNfbG9ja2VkKShzdHJ1Y3Qgc3BpX25v
ciAqbm9yLCB1bnNpZ25lZCBpbnQgcmVnaW9uKTsNCj4gIH07DQoNCg==
