Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2DB39578C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhEaIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:54:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:17253 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhEaIyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622451157; x=1653987157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cys1yC6+uRjxY4klIlSfY+ZTBgFQKeH/vE29yC+pHao=;
  b=aWoIFlI+qd9FOdT8uyiY29/0FZSwH5fZoX8BmpvzQ7zxKdXIwLzeNK5l
   8PfSN4RNaLuxBEdf9p79+IEJUvHcnnNdrtMZOHPvnrx80XEQOX9wnKQUw
   eToFob5T32B+PiFKgRGwz3OGIw/BPJS/jZ8ZzZoDsuvsuQhaDoJIZSGNs
   nbeXw5cvtTjkdKdMpWprdb1m8UI/HjR5qq2sBvJT0jhWEGjlYVv7vJ4tx
   DnsxB31F87FXJXX5nL96YYbdyP7N8Q9k9NwD4vZhnHb5g0bPXW9hv+BsI
   M4j8NINohLYQunmcC9VnhAVfj+/MnAeXqUsavasW5VUjhLcFFiQouJyrw
   g==;
IronPort-SDR: JjEeltAKo0mSCaqksnuf9zCpWQrD16BGBEqD8UIA1ka0FxCi2Y1Re4CUxMb7DbZ8BYG1jZ2Qk9
 gsm+w74Hns3qSFqVhPjGe74egXqHLcmAp1K4t9a8RCHcbtmuKJRXriw3OmCUuLSrYoKgvV2t5n
 9/Li0I3ZHN9ICqqKPeSt9zVTa1TXv5n0OvUgXpOUKRA/7r/6nP8FBkDmxYZm/kwVCRWaZOMvOB
 h7iztmyScfhy1qw/Hx8BsHVgHAdkQ7JSKdXanlwtld67mcHnjxMc9scBG+G/iAbfMh1sd2DSfV
 V8Y=
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="123506544"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 May 2021 01:52:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 01:52:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 31 May 2021 01:52:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aabPFomX8cPvo1eODTnp/5S7JlBD7+nS6IaK2nw6j6zpDg4c0X/GAYGPuUxbePNTNj3IHqW4oPkByuKuMWL1RvgcXkcQHqf3YYIz5UtGWvOY8b+oglGdgiW8qmOQhQMwZZTldeSElbpNQY+YVN5FlquGrrrvncx1KnqlNQILW+gcOJusQnvXNDY0pTQnQDUM0WVvEq98LLcIVi3xu1q9oDnpx89eeuyykRbmkDKTdV9MiEjQmaxUunb4Zq1gEMp/xzvamsaAzGrZaUTjAdM09vuztdjIEaENIniVF2PmZpEq4PDmqPOTPrDM/hrJMlZJZDgF3P5MI0S2tPEIW5ia9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cys1yC6+uRjxY4klIlSfY+ZTBgFQKeH/vE29yC+pHao=;
 b=DlwMWVsmFo5gDAwhwlCTeo+m7ytzI5sb/5+80GIdg6dbN/m7h/jyglJQVpayiD3fqBCkDGFKYHiZQPemu+PGQ/akSgLyiYeI1qFdwSlHGpX1aISNh1VioHF8guWdxSOvlcW80H18yIAN2MX0BOrcAt4mimA/KCRmVBs6ILeldOffYi6iMCywzMaC92NYwXaL8fBSv4L9zYT3nU2xffO8LI3Np+GTVN9idM8i1udRr5T3JsItuUb4CN+hXtin1/YuHmPVY3GzDkr+r1X+tOGE+5LKtQ8ZvKz+zhl62btwxfZA0bBgaZ3QnATbgQ1WsjHLfgF9c4CxU3STl1ww0LzwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cys1yC6+uRjxY4klIlSfY+ZTBgFQKeH/vE29yC+pHao=;
 b=dnySKY4pfxV41iIgeyGtXM+kLK4gW6vyZG0C/opJrvfGEU3JHSKzTSV77LUrEcyllDRxeKyvMOQFwRtaR0DKlnuONKFvlzTPNnpIk7taUaIa7E6bTYU8oU2LeQRmRbzd+5J9LRyfWEA3h+6NESzMDEDL8ikYgJj6f9ZPCJ+ILTE=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 08:52:34 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4173.029; Mon, 31 May 2021
 08:52:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/4] mtd: spi-nor: otp: return -EROFS if region is
 read-only
Thread-Topic: [PATCH v4 3/4] mtd: spi-nor: otp: return -EROFS if region is
 read-only
Thread-Index: AQHXVfpM0f/OzqNCxE+GIZpPHw2egA==
Date:   Mon, 31 May 2021 08:52:34 +0000
Message-ID: <bf3a9cf9-fc72-8ea4-de0a-1f0e123cb644@microchip.com>
References: <20210521194034.15249-1-michael@walle.cc>
 <20210521194034.15249-4-michael@walle.cc>
In-Reply-To: <20210521194034.15249-4-michael@walle.cc>
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
x-ms-office365-filtering-correlation-id: c1b49ebd-81bd-4ef8-8321-08d924116f3e
x-ms-traffictypediagnostic: MW3PR11MB4588:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45888015CBE87C8F17BAF5D3F03F9@MW3PR11MB4588.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lXRuk1UAKSYgs+xFxh6MbxbaXySOlJ4n0OHkU3hVBwk8xC4FZRROvcDwDdu+fWzAs8J3F456wrq+bwI0C6bOvGrohY/CImoXxxpDWrcMCu7RhsN8EmATNBKtqcsRD8lb/BrUR9IYeTkB73bMqN9VnInixhdGFx7btUfEWFmLYCVHmdLvu5oy8/Vy0z6hC/By0wifOd+3gxFujN1GyaaiqrPCHBE64orVbNBCFvqazRqj2az7tKU2CKTnv3QFH11z3L69Oeyym2IropgtrbNzsLVMVRZ7QTysrez1slTUYzmagWbdKkEdk4qN8GV7WgiAYp5FhRGR+YmZZlA2Jy67Qt0khMRVIdz8OuJ1U/WRv7E0Xq0RXHwzlxxsaDb3Jbt08RlA6iuOnhtH3vW/Gw48d8qwWGeg4sErnIHuApgYZUVjIB/vkA0g2ZAlcgbHT6goDF3AEx6EtSkqrMc7grWpScg35v6SDCqRkfSAViFz2isRr2I9ai9QqaFEqRtWew73kR5z0yGHKgVf5Cbtv3jqhtDbeBhWdfDJmw3RFIWetam7UX7g9nPRmM+njGK6BNxii38OWLX9b/TbBoFwnyW3v3l4n773/isnWGnsW756egC5NY+r+EgNOLGluHNhBK+Q/DOrGY3kJ5GLzQeghCWOsJCxZQnGl5JX/9gQ4fcZ4nPLjV0j8TgQkQ12Wl/jUd8b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(346002)(376002)(396003)(31696002)(76116006)(91956017)(5660300002)(6486002)(122000001)(66946007)(36756003)(2906002)(2616005)(38100700002)(478600001)(53546011)(186003)(66476007)(86362001)(64756008)(26005)(66446008)(66556008)(316002)(110136005)(54906003)(83380400001)(6512007)(4326008)(31686004)(8676002)(6506007)(71200400001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dzhBU0MxWG9udlZobjQ5ME4rdllZdXpKekRkVTFTZTFOYmZCVkJ4UmtLNUZN?=
 =?utf-8?B?d0IrN2hjZkxWUjR0NkhxbVZYTkh5d3J2WEFDZno0dTFtdVI0a2x6Y0hlVUN5?=
 =?utf-8?B?ZUh2T0xBVUZBalhsWWVxbE8zdUdNTWNGcVVHbFEzUUVXOXJHVmdHT2kybnJZ?=
 =?utf-8?B?MmJMQmx3ZHNoS2lOVit4MzlxRjlVYWQ4aFhJcFpYaEIrakQvMG1nV0tONjVR?=
 =?utf-8?B?TlFjUXo5OXo1Vk5LZjBtWFJXbEtpNkxBMFcwYWMxN0htTUFJc1RJL1dBSEVt?=
 =?utf-8?B?Yk5va3IyNGVPaURSTGdEVXg2cUdQaSsyVy9JMTExcldFYUt4RFNvT2lvMGEr?=
 =?utf-8?B?S0lrTXlrZWs3b1lvU3VoVS9JQitZdFlOY2JHS2ZMaDloVjZpaG5SU2hpQlJM?=
 =?utf-8?B?Rkx4YzlpeVNxRFUrYnJ3NnJ1SmlocmdJQ0NveW5rcE96NmEzWjkwMDhRMW5j?=
 =?utf-8?B?bEQ0eVJXZExQeS9Ka0ZFU1JiS2tqS0U5dHdYbDFENlN1bk9rNnNwd3FHZjFJ?=
 =?utf-8?B?c2h4a1lqVGtWRksxT0kxR3FBVDV6TU43TDVDYVVTOVNrNllNenhzdExPKytn?=
 =?utf-8?B?RlgzYk5rK3N6aC9TWDVQY3M0WjdwZFErMmRaQWUvZ0ZsZGVYVzNKYnppVVY5?=
 =?utf-8?B?TCtFTUNIS3pkd1VjYm5veERIb2lCdTUrZWEwOHh1VEhOSGZVVXlOcVZ2MnA5?=
 =?utf-8?B?TmRneFVJS1lDUmZqemxXRjJ5a1JsUjE1a09QVFY3QTNXNlphT1RiQWRkT0s3?=
 =?utf-8?B?eHhUWlByckNadHVVemxhalRuR2lZdVh6UlNQYUpGTld2MFdnd0RJSUp5YmNt?=
 =?utf-8?B?aFpkZ3ZYUC94WmIxRUFUVmNTZzRWb0p2RXR0UHFjVUNFUUY4cktpcVVwanJj?=
 =?utf-8?B?TjFZaWZ5bU5zbFd4dGlPcVZFNUphaWtrOER1UGUza3NmV3JSL29IUy9kZ2RZ?=
 =?utf-8?B?R0p6MEpGRTlxbGJOdTEvUldXbDQyVWs3ZFphLzRhcnY2RHdhQnRNQmF2emJW?=
 =?utf-8?B?N0U0VzBWMmxuMzRRYnZNTHk3YUZqN1hyRlhTekRsZ0QycmZxM2ZFaTJWc0Fa?=
 =?utf-8?B?M3owaUFKVzJ3QU5GQ1dYeHpkbEEzemtXUXppR2pDTTdtMVJOY3lCZlN3bUx0?=
 =?utf-8?B?c2cxdzVEeWg1cFpmZm03T0lXR0N2bXJqNXVHdU1vUnhZSDI1Y2VDMEg4UnJX?=
 =?utf-8?B?RXlUV0hXNW1qQlVnb04xNTlSQkdPOHhFZFYvNUdYdUxyZk5xTUc2bk95eFRn?=
 =?utf-8?B?RmprMnNZZkRtZ3A5NFExbUJjWGsrd01ER1JaY2NaS0NBN2YwQkJmWVlmN0sw?=
 =?utf-8?B?TjNtaVoycUpsTUw1eHZsZEFpU1B4SEYzVEgrdTlPb01DUURYOFYwVE9YZ01J?=
 =?utf-8?B?eXB5STRTTjNGRGJGMTcydjB5eWwvY1dCOHZVZTVkNTN5SW5tZlFLRDB3R3pi?=
 =?utf-8?B?akRPMEpEYWE4UFZmRlVSem9PQnp0RkJKNW9qNDBUV1FTWk1tUWV4Unl2RGkx?=
 =?utf-8?B?QXQzY1JVNkhobHgwTnNEUzR1bUh6b2hZRXJFeEtPek5pcDRsazNkNjJXV3la?=
 =?utf-8?B?NFUxK0Jhb1BacDk1S2V0N3lWTmJNRFI0dUZ4L2Fid2FtcmRHejE5NzNYcWwz?=
 =?utf-8?B?akxyTXRZYTNjVG0yL2ZVZWFRVW03ZFVGTjZobGRKQTVOK3ZxYVozcmlsZ3Fp?=
 =?utf-8?B?WjdmMWcwYVgyOGk2N21uMXlkN3owaHVSSjFzOE4wZXRxaWlNS1B5RmJ2d21J?=
 =?utf-8?Q?AhAMV7sz5W8DKjdOnQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67818B2E3F379846939272123631F9EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b49ebd-81bd-4ef8-8321-08d924116f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 08:52:34.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UMfjLDmELRr8OvLl88MN8ld4ZEOozIh2wwZz8Mih12pV+0+/XmMZBC04AKvBn4iIOc1jfveFxZbkEZWgUSyHR9H1/LRs6voKGOPjFOukIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMS8yMSAxMDo0MCBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTUEkgTk9SIGZsYXNoZXMgd2lsbCBqdXN0IGln
bm9yZSBwcm9ncmFtIGNvbW1hbmRzIGlmIHRoZSBPVFAgcmVnaW9uIGlzDQo+IGxvY2tlZC4gVGh1
cywgYSB1c2VyIG1pZ2h0IG5vdCBub3RpY2UgdGhhdCB0aGUgaW50ZW5kZWQgd3JpdGUgZGlkbid0
IGVuZA0KPiB1cCBpbiB0aGUgZmxhc2guIFJldHVybiAtRVJPRlMgdG8gdGhlIHVzZXIgaW4gdGhp
cyBjYXNlLiBGcm9tIHdoYXQgSSBjYW4NCj4gdGVsbCwgY2hpcHMvY2ZpX2NtZHNldF8wMDAxLmMg
YWxzbyByZXR1cm4gdGhpcyBlcnJvciBjb2RlLg0KPiANCj4gT25lIGNvdWxkIG9wdGltaXplIHNw
aV9ub3JfbXRkX290cF9yYW5nZV9pc19sb2NrZWQoKSB0byByZWFkIHRoZSBzdGF0dXMNCj4gcmVn
aXN0ZXIgb25seSBvbmNlIGFuZCBub3QgZm9yIGV2ZXJ5IE9UUCByZWdpb24sIGJ1dCBmb3IgdGhh
dCB3ZSB3b3VsZA0KPiBuZWVkIHNvbWUgbW9yZSBpbnZhc2l2ZSBjaGFuZ2VzLiBHaXZlbiB0aGF0
IHRoaXMgaXMNCj4gb25lLXRpbWUtcHJvZ3JhbW1hYmxlIG1lbW9yeSBhbmQgdGhlIG5vcm1hbCBh
Y2Nlc3MgbW9kZSBpcyByZWFkaW5nLCB3ZQ0KPiBqdXN0IGxpdmUgd2l0aCB0aGUgc21hbGwgb3Zl
cmhlYWQuDQoNCjopDQoNClNob3VsZG4ndCB3ZSBjaGFuZ2UNCnN0cnVjdCBzcGlfbm9yX290cF9v
cHMgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgDQoJLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAg
IGludCAoKmxvY2spKHN0cnVjdCBzcGlfbm9yICpub3IsIHVuc2lnbmVkIGludCByZWdpb24pOyAg
ICAgICAgICAgICAgICAgIA0KICAgICAgICBpbnQgKCppc19sb2NrZWQpKHN0cnVjdCBzcGlfbm9y
ICpub3IsIHVuc2lnbmVkIGludCByZWdpb24pOyAgICAgICAgICAgICANCn07IA0KDQp0bzoNCnN0
cnVjdCBzcGlfbm9yX290cF9vcHMgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgDQoJLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgDQogICAgICAgIGludCAoKmxvY2spKHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZf
dCBhZGRyLCBzaXplX3QgbGVuKTsgICAgICAgICAgICAgICAgICANCiAgICAgICAgaW50ICgqaXNf
bG9ja2VkKShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3QgYWRkciwgc2l6ZV90IGxlbik7DQp9
OyANCg0KaW5zdGVhZD8NCg0KPiANCj4gRml4ZXM6IDA2OTA4OWFjZjg4YiAoIm10ZDogc3BpLW5v
cjogYWRkIE9UUCBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWlj
aGFlbEB3YWxsZS5jYz4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL290cC5jIHwgMzUg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAz
NSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9v
dHAuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivb3RwLmMNCj4gaW5kZXggMzg5OGVkNjdiYTFjLi5i
ODdmOTY1OTNjMTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivb3RwLmMNCj4g
KysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9vdHAuYw0KPiBAQCAtMjQ5LDYgKzI0OSwzMSBAQCBz
dGF0aWMgaW50IHNwaV9ub3JfbXRkX290cF9pbmZvKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBzaXpl
X3QgbGVuLA0KPiAgICAgICAgIHJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiArc3RhdGljIGludCBz
cGlfbm9yX210ZF9vdHBfcmFuZ2VfaXNfbG9ja2VkKHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZf
dCBvZnMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXpl
X3QgbGVuKQ0KPiArew0KPiArICAgICAgIGNvbnN0IHN0cnVjdCBzcGlfbm9yX290cF9vcHMgKm9w
cyA9IG5vci0+cGFyYW1zLT5vdHAub3BzOw0KPiArICAgICAgIHVuc2lnbmVkIGludCByZWdpb247
DQo+ICsgICAgICAgaW50IGxvY2tlZDsNCj4gKw0KPiArICAgICAgIGlmICghbGVuKQ0KPiArICAg
ICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIElm
IGFueSBvZiB0aGUgYWZmZWN0ZWQgT1RQIHJlZ2lvbnMgYXJlIGxvY2tlZCB0aGUgZW50aXJlIHJh
bmdlIGlzDQo+ICsgICAgICAgICogY29uc2lkZXJlZCBsb2NrZWQuDQo+ICsgICAgICAgICovDQo+
ICsgICAgICAgZm9yIChyZWdpb24gPSBzcGlfbm9yX290cF9vZmZzZXRfdG9fcmVnaW9uKG5vciwg
b2ZzKTsNCj4gKyAgICAgICAgICAgIHJlZ2lvbiA8PSBzcGlfbm9yX290cF9vZmZzZXRfdG9fcmVn
aW9uKG5vciwgb2ZzICsgbGVuIC0gMSk7DQo+ICsgICAgICAgICAgICByZWdpb24rKykgew0KPiAr
ICAgICAgICAgICAgICAgbG9ja2VkID0gb3BzLT5pc19sb2NrZWQobm9yLCByZWdpb24pOw0KPiAr
ICAgICAgICAgICAgICAgaWYgKGxvY2tlZCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIGxvY2tlZDsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gK30N
Cj4gKw0KPiAgc3RhdGljIGludCBzcGlfbm9yX210ZF9vdHBfcmVhZF93cml0ZShzdHJ1Y3QgbXRk
X2luZm8gKm10ZCwgbG9mZl90IG9mcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplX3QgdG90YWxfbGVuLCBzaXplX3QgKnJldGxlbiwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB1OCAqYnVmLCBib29sIGlzX3dyaXRlKQ0K
PiBAQCAtMjcxLDYgKzI5NiwxNiBAQCBzdGF0aWMgaW50IHNwaV9ub3JfbXRkX290cF9yZWFkX3dy
aXRlKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBsb2ZmX3Qgb2ZzLA0KPiAgICAgICAgIC8qIGRvbid0
IGFjY2VzcyBiZXlvbmQgdGhlIGVuZCAqLw0KPiAgICAgICAgIHRvdGFsX2xlbiA9IG1pbl90KHNp
emVfdCwgdG90YWxfbGVuLCBzcGlfbm9yX290cF9zaXplKG5vcikgLSBvZnMpOw0KPiANCj4gKyAg
ICAgICBpZiAoaXNfd3JpdGUpIHsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IHNwaV9ub3JfbXRk
X290cF9yYW5nZV9pc19sb2NrZWQobm9yLCBvZnMsIHRvdGFsX2xlbik7DQo+ICsgICAgICAgICAg
ICAgICBpZiAocmV0IDwgMCkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsN
Cj4gKyAgICAgICAgICAgICAgIH0gZWxzZSBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldCA9IC1FUk9GUzsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7
DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgfQ0KPiArDQo+ICAgICAgICAgKnJldGxl
biA9IDA7DQo+ICAgICAgICAgd2hpbGUgKHRvdGFsX2xlbikgew0KPiAgICAgICAgICAgICAgICAg
LyoNCj4gLS0NCj4gMi4yMC4xDQo+IA0KDQo=
