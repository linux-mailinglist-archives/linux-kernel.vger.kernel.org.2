Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB07833E984
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCQGJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:09:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:46578 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhCQGJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615961360; x=1647497360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Plha3SIXw9hzITUmYy8bPF611zQMYl621i997gP1BI0=;
  b=fO9Qwte7eKSXbBCGRvu39keHdfPA8LXfu7i87ZCfHanLlAECZaXCagrA
   2VVpUy2PNGZX1jgVgonlEYJBUQQaYABGCJT5RnC5NAUd9jZECjnurT4Yg
   SWmAE4GPvoU1VdEn2DhNgLlTUvi27/OYviXNk1oa6elR4/+3ChQ1PP7Cw
   SYPIrLMebmAYLSDgJ48Y03+LmN0fQDrZbd3RzZA1xrq5hdPdsIhFOH5mM
   EoAaqjf66DRnZjIVFEV6wCkUlGpffcXngfILkgn4dgTPkSd8NunXMlJ8M
   RW4c9tpXHhbU2jlc3uFc/2VPeWK0eE3vr6BgNWU4zr6VZTs/OgaEyiJuv
   w==;
IronPort-SDR: xtt/XVsYvALAuQ5p2FZ6/Dk/tHWrCor5jJCo4ZqPg2EHEdaC40uwm3Z5jmA1VWv8OQRjlNR486
 TUOCV+xGD9SsIYMQXTXGWnEcxwki/pxTr2qjWoUsDY3oB86EabE1yvR+XXRK/JwyQ8sKp9e1bi
 iD/bteLlahmjvqjpzR/SMj4vRAwdYXKjXuO7Abnt3OfVAisYPYvs8ymFgh0cdORjbnq7SNjVQd
 taN087m0YR22yq4NgrGpSuhFAJApwW3vhmVawMax/eK+2QrwESP6OsoAFB2QfoUuxzqs0pd5/8
 SXQ=
X-IronPort-AV: E=Sophos;i="5.81,255,1610434800"; 
   d="scan'208";a="113046639"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2021 23:09:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 23:09:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Tue, 16 Mar 2021 23:09:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhAN9772/kAYsRv5kVCnfMrwXUWnUgNLzPZXl7kkD74KJVTPkX1nuWzXouf1hm3UpGFOl6VAf8SGDTaVBWTdcq3V7pOxbAqWj7vcp7VxlysGuSC96KMVVHCJrAWPFDLkHLELKoPaBOhVC9dFl+aidYsON82/MvY5x7Cw/NzEh7Cg9bTsW8pWeDUqamEjkG6hAy93dapqwVV605GR2AYA05nfrAs29g8UG7N+IKUkFLn5gFeQMz8GB2p0KZC50dt6scxIp51GkoareHdaH223MEIKaRTOSdljm9YSrx7oOKkQ0R6uFcXTSybAEEnyBG5c5NlTu+AgqGBU5+1EdSNcCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Plha3SIXw9hzITUmYy8bPF611zQMYl621i997gP1BI0=;
 b=PTwysHSy/M6fjn/tBD6MlYHrwgOsEHDKvy3Yl9oENE08iY9AlSKSg6ioMgyYcMRgb9PYD63d2v/Fxl6xNb8ms5iWW1fF2fa6mHiuOhicF/cEz5Aa0L4SES7HuqR4CRsqcgp7NX+Bfp6aoSVHfomQMS3WS23ttIyvGQ/cRiODK2hlTGgTHBqEAvxHOBueo5/+GBeEBmotrwJu4H58abkGE+V2tZybk51e3QYmL1DEECCqL9gWvqUuoHV18O0lALbtHAWwfl/Tj505rkQaqKxThHGwd0NTuobUyUKAsD5TsN99ZRXvnQcEYvB2CAfgX0v4lpwRDHt44GyKbmSUIoudLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Plha3SIXw9hzITUmYy8bPF611zQMYl621i997gP1BI0=;
 b=XfqFr2e+VBseiDEWmlydPxCcF9uj9FSCN4XqHg44Y/sjR0BfuiWL4WDAdU4gyL7oFwB6jydbsN0Rp0ExiXfMwXVp0C8yAskaqkzxVrxpjsBNoAigjH+/pSmW6AmgBDRoyyW7tiL0D2IdzgmTGUmJA6/9YUyiMB5n2uoDfv+guBw=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2832.namprd11.prod.outlook.com (2603:10b6:805:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 06:09:17 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f%7]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 06:09:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection logic
 out of the core
Thread-Topic: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection
 logic out of the core
Thread-Index: AQHXFLXahW+TwdBlzkur1VDkcdYBtg==
Date:   Wed, 17 Mar 2021 06:09:17 +0000
Message-ID: <45d00a12-cb79-774e-f8e8-d65602629a90@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
 <963232a4-9100-ebca-927c-7f5a1e947fbe@ti.com>
 <9889bae0-8eba-7cbc-d9bb-04e038bd28c8@microchip.com>
 <6016b725-a779-1d2c-9884-099c58f53557@ti.com>
In-Reply-To: <6016b725-a779-1d2c-9884-099c58f53557@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bb69ad3-2fc3-44c0-0e4d-08d8e90b329c
x-ms-traffictypediagnostic: SN6PR11MB2832:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB28322E6443C4F4BF59E54128F06A9@SN6PR11MB2832.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6oI/ryQqoEh6uWOcK1NdjvbY3MM4xqBZP7+RGvEUhABfR95DFgG4H2naxXG2Q1CPpeTtmdTD5Sqhlmt7Op/H5iQKgJ7NXA+DsLwirdetyGVdrZp2fUGh2Qd6YsXezGufeEE8QPRAqQowfkRVdkV3Q87CuS49Jyu44MUpXukG2CJb70Tjj2+J4dLg9j7H+KrV5wo74CR+zlHO/gensYhBkSzPboPlkUNPxvnA5idjmDaDvCz3aWKNewD4doDQ1SpAhTZBePze8IiBIcOjMfoo7L1lNHItrj8Y/s6O5M53Iyu3x9ViY+cd/XON+hODnPZgtm6ZzhxNCySqbmeWVsdycXhducpyd5WRxsc/FYgWvyuq8OpOsDh+UnPeGazQg8WAcSqjugTmldoS4yvnp778cIZFtY+fUbCKn0x/u9k/J+NkmzU364YbiVMj568k5t3CuIo0rdYgC9kZxJABF4dBxxTWalGSGw6ZAnOu6ATJsFp48I2PsFIfMuZJ9TiE0auXyae0ggIvhWy1OYcTaYWJ41xw8HPM9OQeIaRQCxreG2G/ZfYS45w6bLkllVN4viPcFOZPHWZUbxKl3YMlE8c5C8exmxO7ltnErqkID74YACZUu28pTnB8cBqg+UozLINQ3PBYgcafCD0UkEcEq4c4zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(136003)(366004)(376002)(4326008)(36756003)(53546011)(316002)(31686004)(54906003)(86362001)(6506007)(8936002)(31696002)(66446008)(8676002)(110136005)(186003)(64756008)(2906002)(478600001)(76116006)(26005)(71200400001)(91956017)(66476007)(66946007)(83380400001)(2616005)(6512007)(6486002)(5660300002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bk9XWXNkaFdmaDF4Y1I5OHU2dVYvbmVBSExFb1JjcDVRd3NaSm0yeTZKck9k?=
 =?utf-8?B?MXQrYlQ3WkFCcGd6cmFuZ0ttRFZnWjhEYm1UN0xORVQra2pGcWU5bFcrZmlj?=
 =?utf-8?B?OTZ2bEZTMHM3bjF0R1pOTy9mVUt0SGFSa3EyVFVRb01WWmx5eE9LcEFwZkFl?=
 =?utf-8?B?bHJ1Y21OOUd3T0lYUkIzVzdDL05RYjBWcndwaHFkL2FvRmxKQVFVL2pqVUZW?=
 =?utf-8?B?QjVnRzZUM2I2b2l0NE4zUko5cnBXRy91NzJTYjY5WjhycEZta1RNZnhxMG5j?=
 =?utf-8?B?TmlJcDd0NUdjVVUwNitiR3RWN2RzNmJ5S3lhUi9jRHZvSXhjbi9SaU9uSlpI?=
 =?utf-8?B?WnF2OW1mVjcxd3lNY2FVZmFDQ3EzT005cjlHQ3RVbWF0Z2xnQTQzOHB1bHNK?=
 =?utf-8?B?K1dhenlmWkpQMlM4ekZzQnFaQkN4QWJSVTV3ZXJlUWwvRHVrS2t0Q2RIS1lS?=
 =?utf-8?B?cng4M2ZHM3ZXbjduSTZIcCtXYnBhajBJbnlHWE9icmROZ0YwSE5zdDZjU0dt?=
 =?utf-8?B?bUgrM0R6TFpkRDVMTUREeUR1V0Vjd3lNSWZtbktCZElURTBuZWQzUGFYb29k?=
 =?utf-8?B?Ly9kdkhrMGFvK2FvbkJTUFVIREFQRzM5cUNya0IzNTRxNmZESGpOSjJMb3gz?=
 =?utf-8?B?WXI3SU5JR1N0OGJMaWZFbklSbFBwdVNWWVNFUkdLcFROVVcrMWIrS1ZWV1lS?=
 =?utf-8?B?UUc1SERCd2dUMUFCdFY0cVd1YkZOSDBETU02RmF6UGFvMWlzUmJ5OXZKM1pu?=
 =?utf-8?B?UlRlbytSUzc0SjdpUzhNci9SZ1JXdmU1THNPMmpBTnJDMXJxeUt0b3pKa3h1?=
 =?utf-8?B?TGdvYU00K3JLZmxCQUhXMHJaSjU3VFZFVm1zTk9jTmJkeUlqWGNFRUI1c3l3?=
 =?utf-8?B?ZTZlVDBJZWZ6dVM3YVp1TmJYTmNXby9ENFRiVEIyLzlicWo0cVJSMDQ0L0g1?=
 =?utf-8?B?aWxkdHNyZnFFd1FVWThzNXF5UW5tNG5zdURpY1V4Y1dodEY2aUxnSE16OW9S?=
 =?utf-8?B?b0FVT3NQRzA5NC9VV0syUFV6dURrMFlTcVlOWjhyR3ByUjlldjJwN2g3d3VL?=
 =?utf-8?B?VlNnQm5KYlVJM3hOaDhRb0x3dHQrdWF4ZlQ2TU56cTBDTUx1QzZ3a25wRkdH?=
 =?utf-8?B?WExkK0t4VVYzazJTT2VXamhWN0ZBT05UNmM1NnUxWlJZZVBWRm9vbTk1ek13?=
 =?utf-8?B?N2RpZHNhVEFIdlFzN0kxcFZVVU0zc1ZKRWVNSzFpM0ticzRiQlErS2phVm80?=
 =?utf-8?B?TVRXeGlRS1NHamRTTGlHZzFURFJGeUFZMXgxNkxPbHdhWHBLQkFHUi92TGhp?=
 =?utf-8?B?bDFjQXJJU1h1bUxrc2xheElDOVFoWkxmMEw4OE9uTjBEczFodHJZaFBtRGhP?=
 =?utf-8?B?NURTQVVZeFhGNkduOUU1K2RNQ0szb3YrTk1vTkp1eG1YaGYwdk1WeHlCaHJL?=
 =?utf-8?B?NE9NQ1hNMU5RZCtHZ3pwYWFBNTlpL3k4cFVjY0RWUldya3p5M0EvMUJQQ0Q0?=
 =?utf-8?B?WmRmbkpzMUdiNTJmc1FhOWtaR3RIWDJ2TnlqTkd2VUsxK3g5REw5bGRlYTlO?=
 =?utf-8?B?TyszcWNwWTQ2Wk9lblVqWTBZbkx2ejh6Tk1YVFZqc05zdFdrVkNZMlRqNjJD?=
 =?utf-8?B?Q25DNzlkQzR5VUVPRnpDTGlEVmJaZldaaDdJZUJPV3lDUU9xcnBNWTd5NXdt?=
 =?utf-8?B?UHFIQzJsOCtHZWY5N1RucGtBWWZQQXRLNm9hQ254b2IvcHRpbjVJREFlZ1Bx?=
 =?utf-8?Q?1tuY4KQzSCcjZMsaiM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <731C115E97BB7F4287E77759502BECCC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb69ad3-2fc3-44c0-0e4d-08d8e90b329c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 06:09:17.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGawYEJlLCU+ZsQybVGhlyNeuKuo4LkVh73knTkIjKFJZGJiOGH8Mr2SWsozhOu2elJtSrGQ4aQ8GX8K9ZlPH8xyE6PhKvtHIqczOSZTkxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2832
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8yMSA4OjIzIEFNLCBWaWduZXNoIFJhZ2hhdmVuZHJhIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDMvOS8yMSAxMjo1OCBQTSwgVHVk
b3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMy84LzIxIDc6MjggUE0sIFZp
Z25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+Pj4NCj4+PiBPbiAzLzYvMjEgMzoyMCBQTSwgVHVkb3IgQW1iYXJ1cyB3cm90ZToN
Cj4+Pj4gSXQgbWFrZXMgdGhlIGNvcmUgZmlsZSBhIGJpdCBzbWFsbGVyIGFuZCBwcm92aWRlcyBi
ZXR0ZXIgc2VwYXJhdGlvbg0KPj4+PiBiZXR3ZWVuIHRoZSBTb2Z0d2FyZSBXcml0ZSBQcm90ZWN0
aW9uIGZlYXR1cmVzIGFuZCB0aGUgY29yZSBsb2dpYy4NCj4+Pj4gQWxsIHRoZSBuZXh0IGdlbmVy
aWMgc29mdHdhcmUgd3JpdGUgcHJvdGVjdGlvbiBmZWF0dXJlcyAoZS5nLiBJbmRpdmlkdWFsDQo+
Pj4+IEJsb2NrIFByb3RlY3Rpb24pIHdpbGwgcmVzaWRlIGluIHN3cC5jLg0KPj4+Pg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+
DQo+Pj4+IC0tLQ0KPj4+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9NYWtlZmlsZSB8ICAgMiArLQ0K
Pj4+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgICB8IDQwNyArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCAgIHwg
ICA0ICsNCj4+Pj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3dwLmMgICAgfCA0MTkgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pg0KPj4+IEhtbW0sIG5hbWUgc3dwLmMgZG9l
cyBub3Qgc2VlbSBpbnR1aXRpdmUgdG8gbWUuIEhvdyBhYm91dCBleHBhbmRpbmcgaXQgYQ0KPj4+
IGJpdDoNCj4+Pg0KPj4+IHNvZnQtd3ItcHJvdGVjdC5jIG9yIHNvZnR3YXJlLXdyaXRlLXByb3Rl
Y3QuYyA/DQoNCkhhdmluZyBpbiBtaW5kIHRoYXQgd2UgaGF2ZSB0aGUgU1dQIGNvbmZpZ3MsIEkg
dGhpbmsgSSBwcmVmZXIgc3dwLmMuDQpCdXQgbGV0J3Mgc2VlIHdoYXQgbWFqb3JpdHkgdGhpbmtz
LCB3ZSdsbCBkbyBhcyBtYWpvcml0eSBwcmVmZXJzLg0KTWljaGFlbCwgUHJhdHl1c2g/DQoNCj4+
Pg0KPj4NCg0KY3V0DQoNCj4gDQo+IEkgYW0gbm90IGEgZmFuIG9mIHJlbmFtaW5nIEtjb25maWcg
b3B0aW9ucyBhcyBpdCBicmVha3MgbWFrZQ0KPiBvbGRkZWZjb25maWcgZmxvdyB3aGljaCBtYW55
IGRldmVsb3BlcnMgcmVseSBvbi4NCj4gDQoNCkknbSBmaW5lIGtlZXBpbmcgdGhlbSBhcyB0aGV5
IGFyZSBmb3Igbm93LiBJZiBzb21lb25lIGVsc2Ugc2NyZWFtcyB3ZSB3aWxsDQpyZWNvbnNpZGVy
Lg0K
