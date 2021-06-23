Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A93C3B1C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFWOLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:11:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:32487 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhFWOLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624457359; x=1655993359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Iug0HsFT/w9/YMIWbQiAgmvUL8gKodwQMH6M4TFWzhc=;
  b=PTNZcpyw4UVKCgeAB5HYe09B2KNDwNpykOvCZ2a9GXYami6NzQjBCgLV
   /E52JNRqDz6dp/M4T0Y3Bey+MDq7QL3RSdX3k4ELA5kVR0QsDOZYn+RYO
   NuSb72q1N2PFCI11wpP8zkIY+8pAvHRCTHL2WycRNPbO/J2aoTjqxOc6C
   9Tc0ViV47aN29fsH/o8dYze6EXXy1jIdGpbQX3bUdQZrP5X/1FoBDl6nZ
   QrjwNtCBC+wQqmyyVnY44frlkutLTGYkuXZusJTpdLpngFVFtEAhLw6GA
   pSToHawBGcQuEsqV+5bjt/qz7b5at0NlG6PS6TAi2VnKKtlCquKMhNv5Z
   A==;
IronPort-SDR: k4j34klKrwyOm7l4dteKkOYE4LbsYm2kWimmsrIOBimbYCmtNiQSESy5lDkuo410NBW+pK31EN
 do0oUcsvu1+yUL/rRqdOchvQz3xmiGpRddsCtsbsyTl+xyAUFZbgeDO1hL5X0xsCaC7bF4kGVT
 Mc+EYkZlfvU0P8e8Oxs2VL5PMW+YxHaOPoZMfTkeTumZwz8oXm2T0P6SYqD71/jSekBUhoi5nK
 qgFMpRSZJHYMFjg4Zafhr6q3+6v82iWipsuIsysw2GBRr0ao2wF9UD/A/UQh9sqU3DEI+EWZzJ
 wak=
X-IronPort-AV: E=Sophos;i="5.83,294,1616482800"; 
   d="scan'208";a="122290903"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2021 07:09:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 07:09:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Wed, 23 Jun 2021 07:09:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6gI+1iqxhyoJWF1+TWW5MXYGwUf7OimTXXGm77Tsgi9UEEDVOubF+YZy42yqkTpikc+gG1T02nM5bxhSWn9S3xQG0e62r8R93vR9b8GSFLGRvYxYYDGeN0e58/HLqEjaPm4q0ypcjGiNfWAgnHb96Msyt8oFz48dQ2dnY5CK9sRpCdRkfn6zMqdETxTz708IYOmJEaz5sMLWatFhvm9j+L3m0ZJbhXRhx6v+87DHAy50D2Be7RL0wjoW/d+xfPdzF3JF0EI8Leh8sBh7vTELZNg3QbRnvJdYa+hZaR/xHgtCG8FI2/suPCfhTTbxYaDxD+jx/1s+L4T6AO+lPYOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iug0HsFT/w9/YMIWbQiAgmvUL8gKodwQMH6M4TFWzhc=;
 b=V0FzxRbM4ydSxCAv9mJK6lMj+AKcT4HwgO8ycPUf5SG7mRwrqfjNYsU1sJp8IGA1ITbKw/pSoakjp+/pTh6794tn4b5mewbZlHcxvHQRvydK5TxOQ0joEaxBzkqSegg4oG49aRfVgUlMhdwpXf/4v+ev6j5FENw8MHERjqJXW24+KiiqNhRcDfjZatRklJwQVfFYuuqelVJ4CC+QTktXV8/FasGgGGnN+fN/xcj6ELGhE+g8uuIsaxnW5LKG5iOnwjIW/O7qaDms/OxjL56Rh+4CpqZAHen8h8GfuyMkU+YPEB9sBBMvXa2QdNIbToaK6z+dDYQFsKTYYytOq+evqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iug0HsFT/w9/YMIWbQiAgmvUL8gKodwQMH6M4TFWzhc=;
 b=mYvF7Idkl44nOpD6FAbgGOo74uF9bnWVXd9VjY4JpOaxNUvsGbKKSWaAW65NA44le24uHt361ENOOxu6ReSLM7FBhvOVhChOAHSvDb05hdHu1taFG8c7fspL8AHAn17Hvfj40xl45pyOQxYbw7MUefDVuhZ2Ae31kNCPyvMHBAA=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM4PR11MB5280.namprd11.prod.outlook.com (2603:10b6:5:38b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Wed, 23 Jun 2021 14:09:16 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5%5]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 14:09:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Cristian.Birsan@microchip.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Thread-Topic: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Thread-Index: AQHXaC37D+YfoBgtzEKBvdp3Oa3YYg==
Date:   Wed, 23 Jun 2021 14:09:16 +0000
Message-ID: <a5c68849-a48c-5224-7ba3-1ad44e0d9874@microchip.com>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
 <20210609230735.GA1861855@rowland.harvard.edu>
 <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
 <20210623135915.GB491169@rowland.harvard.edu>
In-Reply-To: <20210623135915.GB491169@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: rowland.harvard.edu; dkim=none (message not signed)
 header.d=none;rowland.harvard.edu; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.78.167.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f9e9ddc-6529-44d7-2a58-08d936507cae
x-ms-traffictypediagnostic: DM4PR11MB5280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB5280D11CC2E07CE35EEF404887089@DM4PR11MB5280.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4XnpiQZwWKXviQBDY/Gplgre8JIwb0PHCWiUmeJR46ZqaNbLe5jS1T+1/uOZZnR8TuG2hmm16gxNyYnFyhvdnoeu+ovea7LGguNo9VS3J3RiU0XZzYoPvoxJBxVh24Ts4WLL7QfgwHIIU3wOZx9DHSO8qxyDJmFKgcisniUoXD98QQs11sUXusZuhIQhFiXAzUSywXEsLpzWymdV5LKiB5ROr7PeKqPZT8a2WISJH67C2McYvTBseJJyqQrhRwHrjd5Lhrz+LjE8Ed6hlnNLXtUZiIwoRZXM/JNSTTU5RXwJ1xeYBG3j2xUE/MJrKVwq3cYrTk3g0m1ymW18tqIhxn20kqyRt6yOQ5gRkWx9H51SGnUxEf0ZQxO263tXgwirOgHe8NFfbSkP+g69PjIkFmkHAlwVFY5h+y73DBE1wK6Hr5LmDTh2VvWd7+IRFLPh6s1kUih0ztRLKOAo1nJEVB9tPdNvY9UiN6aXF5T1CzSSOUJmnFgNmElIYpnV4SM63BsZCVjOU9Z/8FVHX1Gf/ZR8Q+bdBQkwrBa6AWXbuJAURNhkCoIjPgPRF1aNISvUH9DbJCrGIQtMlUFmKFEVaRvTBvDG48uKmQSbfHNVVW3ygOXN2g8F7KH+DjSkym7BP7++2i6k5hAPISW7h5t/awxXExrPF5Ew7Lcu5IZ/eT3ZcmyAjZHTZkw1/dFOz+fY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(346002)(376002)(6512007)(31696002)(36756003)(6916009)(5660300002)(316002)(4326008)(8676002)(86362001)(66574015)(122000001)(38100700002)(186003)(54906003)(26005)(66946007)(478600001)(2906002)(53546011)(2616005)(15650500001)(91956017)(66556008)(76116006)(66476007)(8936002)(6506007)(64756008)(71200400001)(6486002)(83380400001)(31686004)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWdWVzhvWmhOcm9sbGV5a21LV2ZsZXZEVU5ZMzVuVEF1NWZPbElRUFBwZjFK?=
 =?utf-8?B?dy9YL3dGVnExZ25BVEVYOWdmVlRaL0F1aWd6RHVieFRXOUFiczRkRVB5aXdG?=
 =?utf-8?B?L1hRMnFXYTZ5SlUyQi81OXlSdnJDaXlUbXZKbGcxMUJGYUk5eGpKd0NaRDdv?=
 =?utf-8?B?eXJHa1o1YWt4WnE2M0ZmVnk5MytLODUyVFRKT2IvMHpSQzU2SnBZdUFIa2VO?=
 =?utf-8?B?TWxrTDlxcmJjSGZsY2JHVkFZNnozby8vSEhDQ3p5aG9mdEdrV2ZhZGlRT3NG?=
 =?utf-8?B?OHk0dTVxalVwTEVZOW9WZ29kV2crUExvY2lXTUd6MVRBNFVUN1d4MFd1a29I?=
 =?utf-8?B?dWJJMmdLQ0lpMjR0SFhFSXRrSFYvUmpNMlEvV2tCaHorb0VOSFk5RUVUTTBi?=
 =?utf-8?B?cnkxNmhHMEhEaVpFSUJzYVdqcU40TmdLYkRDZHhzMU9nNFRkL0lWdGovT3Fw?=
 =?utf-8?B?Ung4WVVOaTYrL1ZkWFVTT2NZWjJscDJpTVRLbDNqaEoyZVZDbEV2Z1lhY1Uz?=
 =?utf-8?B?WDU5T3ZmVDd6MVdUbEVRbFR1blZMdTVvRmc1VG9nQ2lxeEY4TlBCRmRDeXpy?=
 =?utf-8?B?QTYrclBWaUZXTnpVTFNRVm1xSThmRlVlQllXVUc0dzE1MTVmU0VObmV1VVF5?=
 =?utf-8?B?QWVlYmhKZEgya2h6UndXb3JnL2Y4N2c5TjRnNjRxVnhsb0pCcDRxdlRmeGxJ?=
 =?utf-8?B?SDJURHoxcXM3bXorV3lIOTRkcFBPWmpzZUZDZ2pwM2ZkOU55b08ydWpWT3RT?=
 =?utf-8?B?M2xBZGdhVG0yaGRFZjUzZkg1MGlKNEw0MTNqWXBSODVOL3J6TmN0L1FtOWZK?=
 =?utf-8?B?MS9rQ3p0WVRkamRnamJZN0hFUjRmeEpjaThtYXFCVEdVckJnTXBqK0VTWS8x?=
 =?utf-8?B?VnpyRC9Nc1F5OWwydlYrdU1TVkJPZ3JYUktFaEtmaG10ZTlxb0wrMnlqSUoy?=
 =?utf-8?B?bTZDM1hhbjE0RXovR2ZXVGd5RDJOV2JnWG9BS3VtY2pUc1huTkM1Q1NUbE5q?=
 =?utf-8?B?akFMQmlVUmJSOHV3T0d4S2VZenVVZU92ekkxR0Fzbm4weXlOa1BhOUttbVRT?=
 =?utf-8?B?aTlDQ3RpWU1nSGllRXZTMVFzM0x0czQvT0FlSWdyVkJEWnExQmJlUnp1MWEw?=
 =?utf-8?B?RERta2YvT0RHa0VwbmNacnFMMlhuOHljMU4zVE4zOUN3dS9hOGNqTVN2SXNr?=
 =?utf-8?B?UjVHdDNlQkxtWjdmWGw2eGc0bXZ5UUFvM08rbWxTQU4zVFVheHNaVjRGWUh4?=
 =?utf-8?B?ajJ1MklneThPb3A5VUx4Y2VTQlVuS3dvVjU5SExGRHkzSlBVUXAxbWUwaEgr?=
 =?utf-8?B?eHhyd1UwMjI5dmVQQ2lrcGxtbi9yUzRtSGl5eGluNU9XUE92dGh2R0dZVkFV?=
 =?utf-8?B?WGdPb213dW9vNHMyMmhyb2g1MlhZUnBNU0VrSGJiZEM1TXVlQVI0ZGU3R1N2?=
 =?utf-8?B?OTVTZTIwekVFdk91S2JVVGxvVndESHF3YmQ2YXI1c3EyZVpnSXpLVTYwVGJa?=
 =?utf-8?B?UlJHaTFFdmF3eFhEUGEwZmFGQm5RZmptRjk3VEtQa2lpT1NGWi80czRZV0tQ?=
 =?utf-8?B?NHgvMElHSk1TY3M1bldLMVhvWC9XS1VzQzMrQnZRWTJ1WlpIbjNWeldkblZI?=
 =?utf-8?B?czNSRlhTT1B3SHVYSlZYRm13ZGliOTUrMTZ3VFdoVWhCcXFhSG1uYW94YmFC?=
 =?utf-8?B?aXRuVkhlc2tHVnRrdVpjbzZHbFh6TnpKaWRtL1FVYnZQdDMyM3ZBYXdpZzhi?=
 =?utf-8?Q?556oX3AOIGT+XSyOs0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF51FEAC91511E44BB18123EC2040B65@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9e9ddc-6529-44d7-2a58-08d936507cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 14:09:16.5914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrchFGeX0qfY8wm+vvJRRjQ8W9//SF8emmaOwTaapi5g1ueBcYgxd3vS3to6ntWnUIdCn9mYKMaTJC/zN671gMxci5/Qs6cEYCrKN610Ya0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5280
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMuMDYuMjAyMSAxNjo1OSwgQWxhbiBTdGVybiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIEp1biAyMywgMjAyMSBhdCAxMjo0Nzo1
NlBNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMTAu
MDYuMjAyMSAwMjowNywgQWxhbiBTdGVybiB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIFdlZCwgSnVuIDA5LCAyMDIxIGF0IDAzOjEwOjI3
UE0gKzAzMDAsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4+PiBPbiBTQU1BN0c1IHN1c3BlbmRp
bmcgcG9ydHMgd2lsbCBjdXQgdGhlIGFjY2VzcyB0byBPSENJIHJlZ2lzdGVycyBhbmQNCj4+Pj4g
YW55IHN1YnNlcXVlbnQgYWNjZXNzIHRvIHRoZW0gd2lsbCBsZWFkIHRvIENQVSBiZWluZyBibG9j
a2VkIHRyeWluZyB0bw0KPj4+PiBhY2Nlc3MgdGhhdCBtZW1vcnkuIFNhbWUgdGhpbmcgaGFwcGVu
cyBvbiByZXN1bWU6IGlmIE9IQ0kgbWVtb3J5IGlzDQo+Pj4+IGFjY2Vzc2VkIGJlZm9yZSByZXN1
bWluZyBwb3J0cyB0aGUgQ1BVIHdpbGwgYmxvY2sgb24gdGhhdCBhY2Nlc3MuIFRoZQ0KPj4+PiBP
Q0hJIG1lbW9yeSBpcyBhY2Nlc3NlZCBvbiBzdXNwZW5kL3Jlc3VtZSB0aG91Z2gNCj4+Pj4gb2hj
aV9zdXNwZW5kKCkvb2hjaV9yZXN1bWUoKS4NCj4+Pg0KPj4+IFRoYXQgc291bmRzIHZlcnkgc3Ry
YW5nZS4NCj4+DQo+PiBUaGUgY2xvY2sgc2NoZW1lIGZvciBPSENJIGFuZCBFSENJIElQcyBvbiBT
QU1BN0c1IGlzIGFzIGZvbGxvd3MNCj4+IChJIGhvcGUgaXQgaXMgcmVhZGFibGUpOg0KPj4NCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTWFpbiBYdGFsDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0t
LS0rDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgfA0KPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICAg
ICAgICAgIFwgLyAgICAgICAgICAgIHwNCj4+IHwgICAgICAgICAgICAgICAgICstLS0tLS0rICB8
IDYwTUh6ICArLS0tLS0tLS0tLS0tLS0tLS0tLS0rICB8DQo+PiB8ICAgICAgICAgICAgICAgICB8
ICAgICAgfCAgfCAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgfC0tLS0tLSsNCj4+IHwgICAg
ICAgICAgICAgICAgIHwgUG9ydCB8PC0tLS0tLS0tLS18IFVUTUkgVHJhbnNjZWl2ZXIgQSB8ICB8
ICAgfA0KPj4gfCAgICAgICAgICAgICAgICAgfCAgICAgIHwgIHwgICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgIHwtLS0tKyB8DQo+PiB8ICBVU0IgMi4wIEVIQ0kgICB8Um91dGVyfCAgfCAgICAg
ICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgfCB8IHwNCj4+IHwgSG9zdCBDb250cm9sbGVyIHwg
ICAgICB8ICB8IDYwTUh6ICArLS0tLS0tLS0tLS0tLS0tLS0tLS0rICB8IHwgfA0KPj4gfCAgICAg
ICAgICAgICAgICAgfCAgICAgIHw8LS0tLS0tLS0tLXwgVVRNSSBUcmFuc2NlaXZlciBCIHw8LSsg
fCB8DQo+PiB8ICAgICAgICAgICAgICAgICB8ICAgICAgfCAgfCAgICAgICAgKy0tLS0tLS0tLS0t
LS0tLS0tLS0tKyAgfCB8IHwNCj4+IHwgICAgICAgICAgICAgICAgIHwgICAgICB8ICB8IDYwTUh6
ICArLS0tLS0tLS0tLS0tLS0tLS0tLS0rICB8IHwgfA0KPj4gfCAgICAgICAgICAgICAgICAgfCAg
ICAgIHw8LS0tLS0tLS0tLXwgVVRNSSBUcmFuc2NlaXZlciBDIHw8LSsgfCB8DQo+PiB8ICAgICAg
ICAgICAgICAgICB8ICAgICAgfCAgfCAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgICB8
IHwNCj4+IHwgICAgICAgICAgICAgICAgICstLS0tLS0rICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgfA0KPj4gfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCB8DQo+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IHwNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
fA0KPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCB8DQo+PiB8ICAgICAgICAgICAgICAgICArLS0tLS0tKyAgfCAgICAgICAg
IFVIUDQ4TSAgICAgICAgICAgICAgICAgICB8IHwNCj4+IHwgICAgICAgICAgICAgICAgIHwgUm9v
dCB8ICB8PC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgfA0KPj4gfCAgVVNCIDEu
MSBPSENJICAgfCBodWIgIHwgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
DQo+PiB8IEhvc3QgQ29udHJvbGxlciB8IGFuZCAgfCAgfCAgICAgICAgIFVIUDEyTSAgICAgICAg
ICAgICAgICAgICAgIHwNCj4+IHwgICAgICAgICAgICAgICAgIHwgaG9zdCB8ICB8PC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPj4gfCAgICAgICAgICAgICAgICAgfCBTSUUg
IHwgIHwNCj4+IHwgICAgICAgICAgICAgICAgICstLS0tLS0rICB8DQo+PiB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfA0KPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4+DQo+
PiBXaGVyZSBVVE1JIHRyYW5zY2VpdmVyIEEgZ2VuZXJhdGVzIHRoZSA0OE1IeiBhbmQgMTJNSHog
Y2xvY2tzIGZvciBPSENJDQo+PiBmdWxsLXNwZWVkIG9wZXJhdGlvbnMuDQo+Pg0KPj4gVGhlIHBv
cnRzIGNvbnRyb2wgaXMgZG9uZSB0aHJvdWdoIEFUOTFfU0ZSX09IQ0lJQ1IgdmlhDQo+PiBvaGNp
X2F0OTFfcG9ydF9zdXNwZW5kKCkgZnVuY3Rpb24gd2hlcmUuIFNldHRpbmcgMCBpbiBBVDkxX1NG
Ul9PSENJSUNSDQo+PiBtZWFucyBzdXNwZW5kIGlzIGNvbnRyb2xsZWQgYnkgRUhDSS1PSENJIGFu
ZCAxIGZvcmNlcyB0aGUgcG9ydCBzdXNwZW5kLg0KPj4gU3VzcGVuZGluZyB0aGUgcG9ydCBBIHdp
bGwgY3V0IHRoZSBjbG9ja3MgZm9yIE9IQ0kuIEkgd2FudCB0byBtZW50aW9uIHRoYXQNCj4+IEFU
OTFfU0ZSX09IQ0lJQ1IgcmVnaXN0ZXIgaXMgbm90IGluIHRoZSBzYW1lIG1lbW9yeSBzcGFjZSBv
ZiBPSENJLCBFSENJIElQcw0KPj4gYW5kIGlzIGNsb2NrZWQgYnkgb3RoZXIgY2xvY2tzLg0KPj4N
Cj4+PiBTdXBwb3NlIG9uZSBvZiB0aGUgcG9ydHMgaXMgc3VzcGVuZGVkLCBzbyBhY2Nlc3MgdG8g
dGhlDQo+Pj4gT0hDSSByZWdpc3RlcnMgaXMgYmxvY2tlZC4gIFRoZW4gaG93IGNhbiB5b3UgcmVz
dW1lIHRoZSBwb3J0Pw0KPj4NCj4+IEZvciBydW4tdGltZSBjb250cm9sICh2aWEgb2hjaV9hdDkx
X2h1Yl9jb250cm9sKCkpLCBJIGFncmVlIHdpdGggeW91IHRoYXQNCj4+IHRoZSBjdXJyZW50IGlt
cGxlbWVudGVkIGFwcHJvYWNoIGlzIG5vdCBoZWFsdGh5ICh0YWtpbmcgaW50byBhY2NvdW50IHRo
ZQ0KPj4gY2xvY2sgc2NoZW1lIGFib3ZlKSBhbmQgdGhlIGZhY3QgdGhhdCB3ZSBkbyBmb3JjZSB0
aGUgcG9ydHMgc3VzcGVuZCBvbg0KPj4gb2hjaV9hdDkxX2h1Yl9jb250cm9sKCkuIEZvciBzdXNw
ZW5kL3Jlc3VtZSBpdCBzaG91bGQgYmUgT0sgYXMgdGhlIHBvcnRzDQo+PiBhcmUgc3VzcGVuZGVk
IGF0IHRoZSBlbmQgb2YgYW55IE9IQ0kgYWNjZXNzZXMgKEkgZG9uJ3Qga25vdyBob3cgdGhlIExp
bnV4DQo+PiBVU0Igc3Vic3lzdGVtIGJlaGF2ZXMgc28gcGxlYXNlIGRvIGNvcnJlY3QgbWUgaWYg
SSdtIHdyb25nKS4NCj4gDQo+IChJIGhhdmVuJ3QgY2hlY2tlZCB0aGUgZGV0YWlscyByZWNlbnRs
eSwgc28gSSdtIG5vdCBjZXJ0YWluIGFib3V0DQo+IHRoaXMuKSAgSW4gc29tZSAtLSBwZXJoYXBz
IGFsbCAtLSBjYXNlcywgd2UgZG9uJ3Qgc3VzcGVuZCB0aGUgcG9ydHMgYXQNCj4gYWxsIGR1cmlu
ZyBzeXN0ZW0gc3VzcGVuZC4gIFdlIGp1c3QgcmVseSBvbiB0aGUgVVNCIGRldmljZXMNCj4gYXV0
b21hdGljYWxseSBnb2luZyBpbnRvIHN1c3BlbmQgd2hlbiB0aGUgcm9vdCBodWIgc3RvcHMgc2Vu
ZGluZw0KPiBwYWNrZXRzLg0KPiANCj4+PiBEb24ndCB5b3UgaGF2ZSB0bw0KPj4+IGFjY2VzcyB0
aGUgT0hDSSByZWdpc3RlcnMgaW4gb3JkZXIgdG8gdGVsbCB0aGUgY29udHJvbGxlciB0byBkbyB0
aGUgcG9ydCByZXN1bWU/DQo+Pg0KPj4gT24gb3VyIGltcGxlbWVudGF0aW9uIHdlIGNvbnRyb2wg
dGhlIHBvcnQgc3VzcGVuZC9yZXN1bWUgdmlhDQo+PiBBVDkxX1NGUl9PSENJSUNSLCBhIHNwZWNp
YWwga2luZCBvZiByZWdpc3RlciwgbWVtb3J5IG1hcHBlZCBhdCBkaWZmZXJlbnQNCj4+IGFkZHJl
c3MgKGNvbXBhcmVkIHcvIE9IQ0ksIEVIQ0kgSVBzKSwgc28gY2xvY2tlZCBieSBvdGhlciBjbG9j
a3MuDQo+Pg0KPj4+DQo+Pj4gV2hhdCBoYXBwZW5zIHdoZW4gdGhlcmUncyBtb3JlIHRoYW4gb25l
IHBvcnQsIGFuZCBvbmUgb2YgdGhlbSBpcyBzdXNwZW5kZWQgd2hpbGUNCj4+PiB0aGUgb3RoZXIg
b25lIGlzIHN0aWxsIHJ1bm5pbmc/ICBIb3cgY2FuIHlvdSBjb21tdW5pY2F0ZSB3aXRoIHRoZSBh
Y3RpdmUgcG9ydCBpZg0KPj4+IGFjY2VzcyB0byB0aGUgT0hDSSByZWdpc3RlcnMgaXMgYmxvY2tl
ZD8NCj4+DQo+PiBGb3IgdGhpcyBraW5kIG9mIHNjZW5hcmlvICh0aGUgcnVuLXRpbWUgc3VzcGVu
ZCBvZiBhIHBvcnQsIG5vdCBzeXN0ZW0NCj4+IHN1c3BlbmQvcmVzdW1lKSBhIGRpZmZlcmVudCBt
ZWNoYW5pc20gc2hvdWxkIGJlIGltcGxlbWVudGVkIHRha2luZyBpbnRvDQo+PiBhY2NvdW50IHRo
ZSBjbG9jayBzY2hlbWEgcHJlc2VudGVkIGFib3ZlLg0KPiANCj4gT2theSwgSSBzZWUuICBJdCBz
ZWVtcyBsaWtlIHRoZSBkcml2ZXIgd2lsbCBuZWVkIHNvbWUgc2lnbmlmaWNhbnQNCj4gY2hhbmdl
cyB0byBoYW5kbGUgcnVudGltZSBwb3dlciBtYW5hZ2VtZW50IHByb3Blcmx5Lg0KPiANCj4gT25l
IHRoaW5nIHlvdSBtaWdodCBjb25zaWRlciBjaGFuZ2luZzogVGhlIG5hbWUgb2YgdGhlDQo+IG9o
Y2lfYXQ5MV9wb3J0X3N1c3BlbmQgcm91dGluZSBpcyBtaXNsZWFkaW5nLiAgSXQgZG9lc24ndCBy
ZWFsbHkNCj4gaGFuZGxlIHN1c3BlbmRpbmcgdGhlIHBvcnQ7IGluc3RlYWQgaXQgaGFuZGxlcyB0
aGUgY2xvY2tzIHRoYXQgZHJpdmUNCj4gdGhlIGVudGlyZSBPSENJIGNvbnRyb2xsZXIuICBSaWdo
dD8NCg0KSXQgZG9lcyBib3RoIGFzIGZhciBhcyBJIGNhbiB0ZWxsIGF0IHRoZSBtb21lbnQuDQoN
Cj4gDQo+IEFsYW4gU3Rlcm4NCj4gDQoNCg==
