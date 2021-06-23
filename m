Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24803B1A78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFWMuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:50:18 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62532 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624452479; x=1655988479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JoEURsDsMJB/vpgy0DacnIrTpetu2R0TYKdn+dxIiCk=;
  b=g/Xb4E+Aq2tuwOLhck5XnuM7RZytLPavwd1aWBvm2srdtD1KO6WHvmX9
   uuvmCknzfB94Vve1A8YjT8n4ileSccrkZpD/PrIqXlQJc16oTDSgL1/dB
   EWW2SG1c2XXWoPPEW3ziUbSqu7C9StmDzqlZXEj6O0ZQXpHgRHt/effye
   r7g8vJdGclS/M5oX0fq72dl8XO4GIOkMXhP1eB4yS339/IrA4qrcPqY3x
   8t/jBlA3VN99yhnXY+k8hjrhxdahL5dMFsKTumly7QRmpXY1ry5dzUlGe
   6HInvSYMNK8BUlLmvrPHKg4PihOuJXOMi7EqZbXlFSQMk52hdwOGgFNGd
   g==;
IronPort-SDR: J+OWzLaokhkCwXPQT3GSrVUO7UX5j6c6SyslWZUYHAqRsnkeHfZPfNuwwSOlIm3BndxV3bH/FT
 ccXZG9FxORv6wnosI27gZzN5yQqrN+sYRY4MQ10TXLDCm3J7WrR8R/jAXd5LZrMRS+0C6bRouv
 u8Thw69cgTi1xF15jvZd8zgF5gdxE8WH+y3GpftkXE3PW7RJAk926+9EYT78yHwJWBwKxdjB1I
 i8UYt+SJ0H1BRgDy/Big0AdnQ0NS2ux0kpEb0YdRP/8s3ameV3I7iPnH2SD5VYbzLQ1aL6gOWH
 4P8=
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="59936361"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2021 05:47:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 05:47:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Wed, 23 Jun 2021 05:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGvUjjbTum6mPQpY+3Zp3HL1EVHQ1rboGuFYdYzl32Io3do1dUaqAJUgft/2YAJAPT2wgaDFsC+X0S4CBO2rBb6xZfKEwJGJNjqEtB2XwYZrWffRyXW/ssRdFmmLWIg4ZwTSfGFdr7to7DgYYDFS6O4CtaiwEkyoB042nWcidi5rOimtsKzYReWTNr3ucPPXeBOEzJGDFlnytTNwzGqzjd6LCBm08zmnwHkS5lKfP0vPgSqtyIIHYlUi+fgQjn5SuWgPNEuJWA4hP/07fobR6mE1lG2pLBRM8sJ9gSyzOru4wY3ze0jbpZ0w23Qsos/pyE8/hvPtXgDmPMV+QzriQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoEURsDsMJB/vpgy0DacnIrTpetu2R0TYKdn+dxIiCk=;
 b=mFuo6CBSY6IKxtDKNlZBQqOLXblviFmWpCKff5pjPTD2ZmfPMBiWCISSQ05eTEHZOBejkICPVGoubl5qd9Yha3EkzD3fyvKfVu5q8AEiOy/EEivEPwzqwIRC0cotVlDZZPTD1jDk9Vm+HPh0OkEREKdXQSQ62XL1PGL/hVzJ7InKSIHY1ZsAt2XOSWxZQD1CXPNJt97N8kptEiMcoklILVhmCtWa2+eQCC41a0SWVHBmSZsi6skp7KLUZ356E9s8bvqOTNpcx/lu7PkkAMaQqc1HfjyShc3y298J3U/F0nMhFXSefHt4B8P7X5oWKIY2dPk9TtkD6MpFKShO176vhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoEURsDsMJB/vpgy0DacnIrTpetu2R0TYKdn+dxIiCk=;
 b=frLz9DzF24KkJ4l1AD3HwlbyWqdTQFVvnUOFsmtpTbpn0s6ro1nqXbVwEMjO2yxZIIpORw1JNGoSAmNYRMXTmHspBuTqd1z9LG0gJCpnkt027OAp5h7yjdNf/+Kwe+T3ek1AuX+E09S5D9EB/o6OmIDlk5sqo4DaS8QrDBZUqtg=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB2985.namprd11.prod.outlook.com (2603:10b6:5:66::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Wed, 23 Jun 2021 12:47:57 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::831:1c4d:711f:3ee5%5]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 12:47:57 +0000
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
Date:   Wed, 23 Jun 2021 12:47:56 +0000
Message-ID: <0621eaba-db4d-a174-1b15-535e804b52ac@microchip.com>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
 <20210609230735.GA1861855@rowland.harvard.edu>
In-Reply-To: <20210609230735.GA1861855@rowland.harvard.edu>
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
x-ms-office365-filtering-correlation-id: 7c5b8c44-41da-474b-c6ce-08d93645202f
x-ms-traffictypediagnostic: DM6PR11MB2985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2985BCADDE40D636F3720D9887089@DM6PR11MB2985.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +JahQBHtwc+jgzxmaEO531V6Y85mNccvqMxnm+PLY3q6RGJR+GGGqNUwVGKZ1XlDPZyWf+0IQFbpep6kMN3LcvI3Vzrg9bkJdrdFTH0EhJr39OAa/Thbrd1tkxEw10soLBIvu4jOoRBs0nxJ33RT18G37QVlgaSi8Yf5EIzJtu/0NDJ9YIIRo/EhB20T/m1D37s6xEvvY7CEOXZ09ebnKD8tm6OKPrNaJ9ShJRD3bawzS7GS/9vFhCMoLIrdL6+k2949osDZhzlLtKzg+gEjjYEQwshNypugI/5l7mAHveVjLXOkB6/SR/QSHV9RrLfxvE8dljQT/ejFeDlgPJZu2UC6XlBZA34BWi6vvPs/FI+hx9ifQ/iVkYMWr+8ni/pc2KQdUrVEqTcMHhPhXFDTs2Ti1/HJvnEcXOOXNtAbDmcMMk+/sW3VAfdZEX1YI7wOQULt2zE1/66WFIz1tjQ0bD9ft4nMrZ1Hxj2Xyvq7YyY0aOrsqKbmmEFNcpeiZdMkS75xYdJpBEnsVe5a/U+oHn15MNnTaSDBBUuUXge+beyqja8oamH7h55xZKr/Ln3MbuuyB1WJ5SPhPodVzS4XPSMKG/KWlSzbWM0XNSOgigD2HT8G4/9ae4Wc3iQ/s9Jfj0Bwss9UGJEo4wmxfKeSlBawHY3Glwluo4o/pHfIwy4q8hmFu78RSb45lFyV/pVE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39860400002)(346002)(396003)(36756003)(31686004)(66574015)(91956017)(31696002)(86362001)(66476007)(76116006)(71200400001)(66946007)(83380400001)(64756008)(6512007)(26005)(66556008)(478600001)(54906003)(6486002)(6506007)(53546011)(5660300002)(4326008)(8676002)(8936002)(38100700002)(2906002)(186003)(6916009)(316002)(15650500001)(2616005)(66446008)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXJkUWlWSXcydGRNWlFCYlZJL2ZMb1I4VjRpMFJnUTM4Q2tWUitsNHE5NmRv?=
 =?utf-8?B?SEFidkNnZm9YYkwrSG9wL2g1QzY5QWVNVjE1Q0p3ZlZJYlRNS2FDMlQwNlk5?=
 =?utf-8?B?ekF2VHMweVJoOHVNcmVTbUJpb0FDSGxZalAzZ0k4YTFXZVJieEdaY2VqNi9I?=
 =?utf-8?B?T0RqcE91N05sSDJoVjh1SHRNOFF1UUlsaVl0MTNsTndBMW5ORUdXalJuOXVp?=
 =?utf-8?B?cFppQURoYXNMb3JHaGhZOWlmbFVJM3o5cDJXMGlrODErcEZickYvT00ySFdQ?=
 =?utf-8?B?TGJKdFVKemg2RlVmMDBJUGhhMXV6d0RhZ2JVVEFReDduVitkM2lzZWp1Zml2?=
 =?utf-8?B?M2t2c3FHU1R2end1VnVQb0hzSDY5QU45VFZ4NVpvTzRSTEY0Q1ZDMGJ6eGYv?=
 =?utf-8?B?SUZoQmpPY1haemsyQlYzcVEzMjB3TWIvU3ZaK1pCMmZ0TUJJakVlUnRCd3ZB?=
 =?utf-8?B?R2M2cmMxVy9xMXM2TjVMa3N0eXkwZ0Y0RnlZTE9zM2gwR0dlYXg4UUVKT1Nt?=
 =?utf-8?B?TjZCdXYxYUNxUTRiUVVtbXVvdzgwcVpoc3J5NzlnMHJDV3dtNUQxVGM4Vmk4?=
 =?utf-8?B?OHZhc1RFOU5DSUQvTGs0L2prR0ozT3NHZDRUZjg3RFJ3ejQ3VkhidUMwMGhM?=
 =?utf-8?B?bjJSUEQ2YWNZajRsZGZqNUNzckdLK3ljSklJTmpXbWRVMUc4KzF0eUZEaE5F?=
 =?utf-8?B?VFRwTE0zbGtsNnI4TU9rTWlyZTZURlFoZUNUMzFzcWdlNEtFYjhHQ3FTYjJC?=
 =?utf-8?B?NVd5azFVQmtjZGNqZFlkWjF0dXlDUk44TzJqQ29oRjYzM2VTWFlzV1BCK29z?=
 =?utf-8?B?T2RUbzdnMkV0aFMrVkthdUE2cCt3K2hQU2ZWdlJWRE9pTWJNOW1pM2VFL3B4?=
 =?utf-8?B?Z3RReFVrL2dJTHYrRFZ1MDhuWG1WSUZwTTdsaW5mYXJ4MGJsMlJRcEVxcjJR?=
 =?utf-8?B?b1lReU9BVjRUZUpieXJoUUVpeWtWUXBFblltRklmZGVNQVQySUNFVHZiYncr?=
 =?utf-8?B?TXMwaWlGY3R2RGF5TDlFeFd1Mjg0dWN0UXhwQW5VUEpSTkVCN1lFcFh2a1Vw?=
 =?utf-8?B?blVwTmJpcnphaC9rUjdiUXhKcDJrR0F0bnZkSWZvU1lJZVlBK2NLMUIxYTZZ?=
 =?utf-8?B?b29GbWZCZzg2Y1dHa3BVenJFeTJSbXhVNHJkZWtYK0E4R3FpRjY0OWRINXdK?=
 =?utf-8?B?VjhEUHptclI1NTRMZk5jeXdPTG9zN2xnRkhnNXQvdmlRN3AydEROa1R4TjJq?=
 =?utf-8?B?NGlWMXNpTG9pdjl2MDZTbXFmYXlvODgvY0N5ZFduMEZiMCtqNWJJbytkVmc0?=
 =?utf-8?B?V2ZtdXZZenBqRTM1N1JOMllraVdSU0pwRlE1RHBzdGFoS2g5bSsyOFlxdkVn?=
 =?utf-8?B?Z1dKWUZycWVsUFRyVXVKdmdDZ09ON1VDSEpqbGd0d0wxZE9nT2l1cFdaZEFx?=
 =?utf-8?B?cWdURWhPajV2RGdzUUF1VDJLNk8wSzdka01DWEJHR2Y0ZkNieUg2YUxPK3Bl?=
 =?utf-8?B?My9MOC84dWRrSTBkOHFyKzhZTmRJOVhrMFpsUVVIUnA3SXZhdzZFUlpwc3N1?=
 =?utf-8?B?dndBUmxqNzQ2SHNFWmFPczZkdnFJbTBBWngxRFVRVGhFTHRHMmhZM0NhSXNW?=
 =?utf-8?B?RzBrOVpGQjJBZDhTK0JqZ2dIbThNOXFiYlNmT0toNXpzSmdqRXJCSEU4eUNJ?=
 =?utf-8?B?NmN2d1NReHBET25rbUJuVEphL3Q2MFhXdUdaR1E3RlJXM0NRMllDU2lzUzNu?=
 =?utf-8?Q?kF58qoC/j3CIq3wEMU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6CE2CD483652044A2B530165A3BA5D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5b8c44-41da-474b-c6ce-08d93645202f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 12:47:56.8604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WpcsruksSI+ApqMYPWeToWEqL0fgf7H5WLuAj5ZNI26AX9C86Fvf5St3lwhklfXLVwI/C8qBqQIrOJ0JmgZeOPDxNaNvGj/GHuwhDnBc6ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2985
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDYuMjAyMSAwMjowNywgQWxhbiBTdGVybiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIEp1biAwOSwgMjAyMSBhdCAwMzoxMDoy
N1BNICswMzAwLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IE9uIFNBTUE3RzUgc3VzcGVuZGlu
ZyBwb3J0cyB3aWxsIGN1dCB0aGUgYWNjZXNzIHRvIE9IQ0kgcmVnaXN0ZXJzIGFuZA0KPj4gYW55
IHN1YnNlcXVlbnQgYWNjZXNzIHRvIHRoZW0gd2lsbCBsZWFkIHRvIENQVSBiZWluZyBibG9ja2Vk
IHRyeWluZyB0bw0KPj4gYWNjZXNzIHRoYXQgbWVtb3J5LiBTYW1lIHRoaW5nIGhhcHBlbnMgb24g
cmVzdW1lOiBpZiBPSENJIG1lbW9yeSBpcw0KPj4gYWNjZXNzZWQgYmVmb3JlIHJlc3VtaW5nIHBv
cnRzIHRoZSBDUFUgd2lsbCBibG9jayBvbiB0aGF0IGFjY2Vzcy4gVGhlDQo+PiBPQ0hJIG1lbW9y
eSBpcyBhY2Nlc3NlZCBvbiBzdXNwZW5kL3Jlc3VtZSB0aG91Z2gNCj4+IG9oY2lfc3VzcGVuZCgp
L29oY2lfcmVzdW1lKCkuDQo+IA0KPiBUaGF0IHNvdW5kcyB2ZXJ5IHN0cmFuZ2UuDQoNClRoZSBj
bG9jayBzY2hlbWUgZm9yIE9IQ0kgYW5kIEVIQ0kgSVBzIG9uIFNBTUE3RzUgaXMgYXMgZm9sbG93
cw0KKEkgaG9wZSBpdCBpcyByZWFkYWJsZSk6DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTWFpbiBYdGFsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKy0tLS0tLS0tLS0tLS0rDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgfA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLSsgICAgICAgICAgICAgICAgIFwgLyAgICAgICAgICAgIHwNCnwgICAgICAgICAgICAg
ICAgICstLS0tLS0rICB8IDYwTUh6ICArLS0tLS0tLS0tLS0tLS0tLS0tLS0rICB8DQp8ICAgICAg
ICAgICAgICAgICB8ICAgICAgfCAgfCAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgfC0tLS0t
LSsNCnwgICAgICAgICAgICAgICAgIHwgUG9ydCB8PC0tLS0tLS0tLS18IFVUTUkgVHJhbnNjZWl2
ZXIgQSB8ICB8ICAgfA0KfCAgICAgICAgICAgICAgICAgfCAgICAgIHwgIHwgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgIHwtLS0tKyB8DQp8ICBVU0IgMi4wIEVIQ0kgICB8Um91dGVyfCAgfCAg
ICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgfCB8IHwNCnwgSG9zdCBDb250cm9sbGVyIHwg
ICAgICB8ICB8IDYwTUh6ICArLS0tLS0tLS0tLS0tLS0tLS0tLS0rICB8IHwgfA0KfCAgICAgICAg
ICAgICAgICAgfCAgICAgIHw8LS0tLS0tLS0tLXwgVVRNSSBUcmFuc2NlaXZlciBCIHw8LSsgfCB8
DQp8ICAgICAgICAgICAgICAgICB8ICAgICAgfCAgfCAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0t
LS0tKyAgfCB8IHwNCnwgICAgICAgICAgICAgICAgIHwgICAgICB8ICB8IDYwTUh6ICArLS0tLS0t
LS0tLS0tLS0tLS0tLS0rICB8IHwgfA0KfCAgICAgICAgICAgICAgICAgfCAgICAgIHw8LS0tLS0t
LS0tLXwgVVRNSSBUcmFuc2NlaXZlciBDIHw8LSsgfCB8DQp8ICAgICAgICAgICAgICAgICB8ICAg
ICAgfCAgfCAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgICB8IHwNCnwgICAgICAgICAg
ICAgICAgICstLS0tLS0rICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgfA0K
fCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCB8DQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8IHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgfA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCB8DQp8ICAgICAgICAgICAg
ICAgICArLS0tLS0tKyAgfCAgICAgICAgIFVIUDQ4TSAgICAgICAgICAgICAgICAgICB8IHwNCnwg
ICAgICAgICAgICAgICAgIHwgUm9vdCB8ICB8PC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSsgfA0KfCAgVVNCIDEuMSBPSENJICAgfCBodWIgIHwgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8DQp8IEhvc3QgQ29udHJvbGxlciB8IGFuZCAgfCAgfCAgICAgICAg
IFVIUDEyTSAgICAgICAgICAgICAgICAgICAgIHwNCnwgICAgICAgICAgICAgICAgIHwgaG9zdCB8
ICB8PC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KfCAgICAgICAgICAgICAg
ICAgfCBTSUUgIHwgIHwNCnwgICAgICAgICAgICAgICAgICstLS0tLS0rICB8DQp8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCg0KV2hl
cmUgVVRNSSB0cmFuc2NlaXZlciBBIGdlbmVyYXRlcyB0aGUgNDhNSHogYW5kIDEyTUh6IGNsb2Nr
cyBmb3IgT0hDSQ0KZnVsbC1zcGVlZCBvcGVyYXRpb25zLg0KDQpUaGUgcG9ydHMgY29udHJvbCBp
cyBkb25lIHRocm91Z2ggQVQ5MV9TRlJfT0hDSUlDUiB2aWENCm9oY2lfYXQ5MV9wb3J0X3N1c3Bl
bmQoKSBmdW5jdGlvbiB3aGVyZS4gU2V0dGluZyAwIGluIEFUOTFfU0ZSX09IQ0lJQ1INCm1lYW5z
IHN1c3BlbmQgaXMgY29udHJvbGxlZCBieSBFSENJLU9IQ0kgYW5kIDEgZm9yY2VzIHRoZSBwb3J0
IHN1c3BlbmQuDQpTdXNwZW5kaW5nIHRoZSBwb3J0IEEgd2lsbCBjdXQgdGhlIGNsb2NrcyBmb3Ig
T0hDSS4gSSB3YW50IHRvIG1lbnRpb24gdGhhdA0KQVQ5MV9TRlJfT0hDSUlDUiByZWdpc3RlciBp
cyBub3QgaW4gdGhlIHNhbWUgbWVtb3J5IHNwYWNlIG9mIE9IQ0ksIEVIQ0kgSVBzDQphbmQgaXMg
Y2xvY2tlZCBieSBvdGhlciBjbG9ja3MuDQoNCj4gU3VwcG9zZSBvbmUgb2YgdGhlIHBvcnRzIGlz
IHN1c3BlbmRlZCwgc28gYWNjZXNzIHRvIHRoZQ0KPiBPSENJIHJlZ2lzdGVycyBpcyBibG9ja2Vk
LiAgVGhlbiBob3cgY2FuIHlvdSByZXN1bWUgdGhlIHBvcnQ/IA0KDQpGb3IgcnVuLXRpbWUgY29u
dHJvbCAodmlhIG9oY2lfYXQ5MV9odWJfY29udHJvbCgpKSwgSSBhZ3JlZSB3aXRoIHlvdSB0aGF0
DQp0aGUgY3VycmVudCBpbXBsZW1lbnRlZCBhcHByb2FjaCBpcyBub3QgaGVhbHRoeSAodGFraW5n
IGludG8gYWNjb3VudCB0aGUNCmNsb2NrIHNjaGVtZSBhYm92ZSkgYW5kIHRoZSBmYWN0IHRoYXQg
d2UgZG8gZm9yY2UgdGhlIHBvcnRzIHN1c3BlbmQgb24NCm9oY2lfYXQ5MV9odWJfY29udHJvbCgp
LiBGb3Igc3VzcGVuZC9yZXN1bWUgaXQgc2hvdWxkIGJlIE9LIGFzIHRoZSBwb3J0cw0KYXJlIHN1
c3BlbmRlZCBhdCB0aGUgZW5kIG9mIGFueSBPSENJIGFjY2Vzc2VzIChJIGRvbid0IGtub3cgaG93
IHRoZSBMaW51eA0KVVNCIHN1YnN5c3RlbSBiZWhhdmVzIHNvIHBsZWFzZSBkbyBjb3JyZWN0IG1l
IGlmIEknbSB3cm9uZykuDQoNCj4gRG9uJ3QgeW91IGhhdmUgdG8NCj4gYWNjZXNzIHRoZSBPSENJ
IHJlZ2lzdGVycyBpbiBvcmRlciB0byB0ZWxsIHRoZSBjb250cm9sbGVyIHRvIGRvIHRoZSBwb3J0
IHJlc3VtZT8NCg0KT24gb3VyIGltcGxlbWVudGF0aW9uIHdlIGNvbnRyb2wgdGhlIHBvcnQgc3Vz
cGVuZC9yZXN1bWUgdmlhDQpBVDkxX1NGUl9PSENJSUNSLCBhIHNwZWNpYWwga2luZCBvZiByZWdp
c3RlciwgbWVtb3J5IG1hcHBlZCBhdCBkaWZmZXJlbnQNCmFkZHJlc3MgKGNvbXBhcmVkIHcvIE9I
Q0ksIEVIQ0kgSVBzKSwgc28gY2xvY2tlZCBieSBvdGhlciBjbG9ja3MuDQoNCj4gDQo+IFdoYXQg
aGFwcGVucyB3aGVuIHRoZXJlJ3MgbW9yZSB0aGFuIG9uZSBwb3J0LCBhbmQgb25lIG9mIHRoZW0g
aXMgc3VzcGVuZGVkIHdoaWxlDQo+IHRoZSBvdGhlciBvbmUgaXMgc3RpbGwgcnVubmluZz8gIEhv
dyBjYW4geW91IGNvbW11bmljYXRlIHdpdGggdGhlIGFjdGl2ZSBwb3J0IGlmDQo+IGFjY2VzcyB0
byB0aGUgT0hDSSByZWdpc3RlcnMgaXMgYmxvY2tlZD8NCg0KRm9yIHRoaXMga2luZCBvZiBzY2Vu
YXJpbyAodGhlIHJ1bi10aW1lIHN1c3BlbmQgb2YgYSBwb3J0LCBub3Qgc3lzdGVtDQpzdXNwZW5k
L3Jlc3VtZSkgYSBkaWZmZXJlbnQgbWVjaGFuaXNtIHNob3VsZCBiZSBpbXBsZW1lbnRlZCB0YWtp
bmcgaW50bw0KYWNjb3VudCB0aGUgY2xvY2sgc2NoZW1hIHByZXNlbnRlZCBhYm92ZS4NCg0KVGhh
bmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4gQWxhbiBTdGVybg0KPiANCg0K
