Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC76433357
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhJSKSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:18:37 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17865 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhJSKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634638583; x=1666174583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KWkC2h2gPnfQC2H7Ffy6sXU3yjerYxua/wZLiSHU8i8=;
  b=mkKNbKMJ61XN7PrGjnsXwTa6LvotHAHDWughwRi8sQ2K/bybqCmHvEaP
   3Z5YTsRZwZ3nNwofbKbQwLB4Vmd1xs8dp+g9sQO60zKcI7EVOg5PjRWKr
   LfdmEnHnNKgWsahijwExX+mWuD6mbVAf11jB5+MgEVFuihEzOHwqji33D
   NEKNjuGMExIHF3XubEi0aJmsVR5//RdBDJ9t8NJsD/4MFl2HxB9vmUfbZ
   VkUqpHjmPVevS/rPFwWOMp7BE1f1W/+xPtgre4vqbohryYZqWFX7B4F58
   VMsaBNQoRTageyjmW7mdmuV7zVOgMbp/xu+5VNy8Cj3ua0NkpLWgsJ8zI
   g==;
IronPort-SDR: NI4+SYP5kv11fVx1s7Ns9h7qXcB3Pf444jLND/A2uPGrZ/NOThMzV3ByWGtiixImnl8n4Q+3Wx
 HCY2fX9+2ZagH3aurjNUTjA9lGuyQ7ucrBIB0gG7y+6LYEu4m08th1sqWP4BL+/hW/W8u4bdZa
 0hfhVNeGjgzJ6pLsPk6tyJI2vtLdUmr2TEIpQFHhFsM1iuYmlkHv5fVDq4u77g2PTwlPXQ1xnf
 NpxhWGlmLV3zM80sPWtyjG6sIT40RaEg92w8K5XHAuro6SWjwXDfL0kYeQIbHkKnQgYD0dRmw0
 ANLxEfD10w+JHBx2mNhmgdGU
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="133569504"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 03:16:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 03:16:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Tue, 19 Oct 2021 03:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPRgRfZ1kqcOna3Lj22xodQUxFOccFW+gr4vccGWL/aOZX1uNrNwubXfSsRTDdF7WviCrerx4t4VlXtzXK7noO9n4WUJ6fuosdYtP1O6UmuMJMG/WeElpaaNwGjLxoGzobhk2h9lKFZgELju/Hl7PJy9CSn7nkQVzyFb5H6lzXOCuZBOygOeI8iYvCLZDz/tpRlWht2b6PedKmVaK397ZFjPAztAWX16tw+m3TGB6QWJsiqs1cKCaYycmyvq1hQlCVILcPXO+2iqHB2A2mHUdGjjuhWylTUbuKVMDIgUzco6ZY6RuM9fGQ4BkBm0Vhe1MSSKgA4J/wIfjEmz5sZp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWkC2h2gPnfQC2H7Ffy6sXU3yjerYxua/wZLiSHU8i8=;
 b=PW2KjtGCbOIhktCVhc82/YKynCfsajFIhKUPwMhBplviIpDTfbT/BK4GydGW47ybTgyV8Z2gD1yOszDeShEnNsZf/GKI1AF7wDniwnl1DDFujD+O5sIQ55r0m7FxP7I478fq3SgeexFFosMdWrp/MgBVK98sqnX+i5SHbmTDPHKoFBBUMVUowUB7sTM1gBeIrCQBg32BJt120/hwaCelAC7N05qQWhIfSue0xiCsuB5GvnBtjoBtNxJONxGVMXFmRsqrgInB1jrUVFjf/H0K9l79jGotkUGHUx0XPTfulY8P4+9KvCt0/lMtVatvNJbrsLrZuXQrKxvjWvdIxkmUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWkC2h2gPnfQC2H7Ffy6sXU3yjerYxua/wZLiSHU8i8=;
 b=AkeRQAicgB7nF7JFNEr8d4w0b4Tfn1eBW/b9dDdl/bdKR1dRpJAzuf94RZLDOYx7oxXyV0tkdl0YEDu7BrSMH0qOxtu1pG03qKXmv8vJpBjAmLUm/tjynjIANGrG/djOO//6rg+GVwoIn+2SBv/t3vXX9FQvFMmpPjZwigXO1CE=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4687.namprd11.prod.outlook.com (2603:10b6:806:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 10:16:18 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213%9]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 10:16:18 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <novikov@ispras.ru>
CC:     <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <lee.jones@linaro.org>,
        <bianpan2016@163.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ldv-project@linuxtesting.org>
Subject: Re: [PATCH v2] mtd: spi-nor: hisi-sfc: Remove excessive
 clk_disable_unprepare()
Thread-Topic: [PATCH v2] mtd: spi-nor: hisi-sfc: Remove excessive
 clk_disable_unprepare()
Thread-Index: AQHXxNJbhHPn7W4G1UehA45qb3zE5g==
Date:   Tue, 19 Oct 2021 10:16:18 +0000
Message-ID: <94539db8-e6d7-fd1e-46f1-af3ff1525685@microchip.com>
References: <20210709144529.31379-1-novikov@ispras.ru>
In-Reply-To: <20210709144529.31379-1-novikov@ispras.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: ispras.ru; dkim=none (message not signed)
 header.d=none;ispras.ru; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bbbfd19-d01d-44f5-291a-08d992e97d9c
x-ms-traffictypediagnostic: SA0PR11MB4687:
x-microsoft-antispam-prvs: <SA0PR11MB46876AD347D16028779C66EBF0BD9@SA0PR11MB4687.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXoJIpmTKK3moDUfJj1NwBzzhra81mA+4ZqkQUQwMe/P369H3FLGZ2kaexSDGnwORgRQ/g6lPzesgWeU5EIJsqtN5kPUj3TJBViGBHJAfWGglwpUWNZOdiU0TjssAzhhz0g37bMhCFJ9krVXnLYmWksBZYzo5PZl22+3YY+2tFLoe8/pA5jV0+2PQlnCuTW/96cIoccgOpUtHTL291qXECvAsuH9bCEBtmqC88edEaaQFW70vJ94/SJtkkwyliH4BV/sm7r230FoYVZ4ov9Wg/PCkicVZPfyCEWZE7fo/RBv/phgRCeKsFQ65LPRYI7Js9iGu++CgJVpDo5oORAMTUqk+6d2lhZfrTTnjrEinzrILv7VSkpLR+KJB+SCpkrc1peQaJiahpVdrVvCKtaxtgIBiTBeiy39S7H3QTA9cisApH32CjEjauaW/S0D2sCFm/gaKJn8y2V9aCyfGxTJJwuhAcHXUGToPOj/Wh4kM6ZfCdJ8JdBYOoefTGprVc9tHeQh8NHVGLXRP0mJjCycFFUDfTTpi0NVUA1dubWN+BopyCvO9IVmPcUqORX2nGNXXV6Ksf+9o1HPXh8+vaXwIURF0Shle0OH0S3Nq3hNuoeoWkD7KDjeuf1QqfZlmfBk26l82JtvWp8VrQQwtKs5u9sS4UFKwSrEFcoKvMCLE9U3W8MGjObBdpUTobQoPCM/Ha9VGcWoeyM+RQ9+JBM24yC9Wr2J5+BL3NRnbhTEnkKEJEsA/uRT4JkFTA5QlJXZQa1CpO/8c+M5CCyoxsCvhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(7416002)(6506007)(53546011)(6916009)(6512007)(86362001)(5660300002)(8936002)(76116006)(91956017)(316002)(83380400001)(38100700002)(26005)(64756008)(4744005)(508600001)(66476007)(66946007)(2616005)(2906002)(38070700005)(71200400001)(4326008)(31696002)(6486002)(31686004)(54906003)(122000001)(186003)(66556008)(66446008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3g1d1RuOWd1TWpIT3FqZXVBSlhWZXlLKzIzeENBdHF0dFN2TDdjR3RZdzI5?=
 =?utf-8?B?a25HN2tTakJxbERiOFdCcVVlZlBCSW1VV1oyQWI0NWxUV1VnZnZMdjZNUk81?=
 =?utf-8?B?V3Jqa1ppYXpWVkFVVTJXeGkveHlaUzhEV3A0L05XRGVDVVJKRDBwUGNya0Fk?=
 =?utf-8?B?Q3NJSWRBdXZRdW51RisyQldkQ09COUh0eXViL2I1aitCRWdzQXM0Mnp4VEYw?=
 =?utf-8?B?M3RsWUxwYnhXMGVmdVdBcDlWRzA3dGVNK3l5QmVEc0kySEwwUE1pTnBRbWtO?=
 =?utf-8?B?Y1RWdjBMQ09kRUdVaG5QSndRVnAwUmNUdWg5RURETGN6SnJuTDVlTjhDOGRY?=
 =?utf-8?B?b2ZwbTcvc1d5L3dqN05Bc00vRlN6ckIyVjF0MkRLb2VleXNFWjQ4UzB1SmJB?=
 =?utf-8?B?bk01UEk1NjlSSzVDNHN2UFczSlJPN0x6K1Y3WERraXQ1MDAyQjhTMWZtelB5?=
 =?utf-8?B?RnpGSGIwcTkwb011MG9kM0JuRUdHamNvVnhWM0t6WUlpV29kbjFmTEFheHhS?=
 =?utf-8?B?ZGR2UTNJd0R1U1o5eERjdXRQVHhBR2NlQnk0NGMyR08rUDFCaTZ4ZEdIaHQ3?=
 =?utf-8?B?NXpZSTBqczI0dVZ5VW8xY3pkaFpQY201S3kwa1dEaG1jblRPdGkxSnRoT29X?=
 =?utf-8?B?T2dkd1NPSGtJQmpKajFkV05pOFRwYnRrZkRONUJ1b2tLejk4L1pkWjAweU9t?=
 =?utf-8?B?RVYvMjBGMUJ2YXFnNDBQR1k4ZVc0THZDL1JJSUhZY2IydFJrb3FLb0JCZnNL?=
 =?utf-8?B?YXZ6MC9ad0o2WTErVTV0Sk5yWDdBaFZLZUt1bTIwYUwxS2JEY1VTSCt3OVpi?=
 =?utf-8?B?cFlkVE56TDJ6bmRzTGFrN1hjL1ZZU1Ura1UxaDFmQlE1QnlDWU1uNjljOWNH?=
 =?utf-8?B?dkVtVDdnU1N0YmV1RHhoazVyajZHOUg3RUR1elFlT0FUSkZkK0VNRDJPQ3Fm?=
 =?utf-8?B?S3dlOGM1bXQ0MWZIZ3VwWlMyazlwckNVRzBaUFF0b2tJZTFwUWYyRFJtYzlv?=
 =?utf-8?B?a2JDVlJIY1ppR054dENCUWc0TXJTalpVZzQzM2lScmt2cko4RkJyVGttZXJv?=
 =?utf-8?B?ZTRYN3lvYXIwb1BTMVZaeDB6RFNmclRvZ3RuNG9hNHAvMnRwa3BRZG50NmFF?=
 =?utf-8?B?bzZTNHNwU1c3eGZFUFBnVm8xRFZpbDdhUytHSWZzSVhXNUhUdnZYenVnZWlB?=
 =?utf-8?B?KzF4dzE2V2l3UU4xM2plUnd6b1YxSU45dlBybTFhWngreVJVWTU2bnZlWnpT?=
 =?utf-8?B?TUtLUDRVUDNoMzFYV0V0OUt2NUZWQjVaT0JtV3JoakJtdERBcEZMU0Qxb3d5?=
 =?utf-8?B?aVF4eDUwVGlxbGRsdllvVVRFWkFOMHpZZlFCMy9JWi9EeDFIUktiQVpWQ0Jz?=
 =?utf-8?B?WEx4c2F6Zlo4SHJpanNoRVE1dzFEQ2lYb0dmK0lBeHpLN01NcU5DQjRndFhm?=
 =?utf-8?B?NjRSVEJBUUY1cG53QUM2WXc0MmRPREZ4NExDOXpGVmhOUkRhUWpSTFB3YWdo?=
 =?utf-8?B?MEpXYjF6YUFQbXFjaDlSSHJCeitLU24xQWt6T2h5SmFkNTZyVVZyYVhQVjNC?=
 =?utf-8?B?c2xZRkhKNWVWbHFRa3pZTzJyb0tESHI2c0w1bTRxZXIraFlUVCtjVXZuN09i?=
 =?utf-8?B?ZGc1MGd0MEFlUjVXUWs3N2dYOWZVM3llcmcwWXprYVFiK2oxWGlXM1d4WW9J?=
 =?utf-8?B?cThLcE1PT09Qb1QvS0VNOHFFdmNRVEZvNlhnK3hQTTljbVcxNUkvOVQ1OHkz?=
 =?utf-8?Q?AJ1nssFP8wwIIp80K0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0164690B21D91A45866E082A1DF5C889@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbbfd19-d01d-44f5-291a-08d992e97d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 10:16:18.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNlGygPg+WP5/OtRqN0IHDE58NlF3a4x5P5kNw/p/S2ke+CM12n3AcRtOrlnh/YmVY3nX8SccYlkfpAF4rCACqCpRQwpvHNHHVeVCVnh9A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy85LzIxIDU6NDUgUE0sIEV2Z2VueSBOb3Zpa292IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IGhpc2lfc3BpX25vcl9wcm9iZSgpIGludm9rZXMg
Y2xrX2Rpc2FibGVfdW5wcmVwYXJlKCkgb24gYWxsIHBhdGhzIGFmdGVyDQo+IHN1Y2Nlc3NmdWwg
Y2FsbCBvZiBjbGtfcHJlcGFyZV9lbmFibGUoKS4gQmVzaWRlcywgdGhlIGNsb2NrIGlzIGVuYWJs
ZWQgYnkNCj4gaGlzcGlfc3BpX25vcl9wcmVwKCkgYW5kIGRpc2FibGVkIGJ5IGhpc3BpX3NwaV9u
b3JfdW5wcmVwKCkuIFNvIGF0IHJlbW92ZQ0KPiB0aW1lIGl0IGlzIG5vdCBwb3NzaWJsZSB0byBo
YXZlIHRoZSBjbG9jayBlbmFibGVkLiBUaGUgcGF0Y2ggcmVtb3Zlcw0KPiBleGNlc3NpdmUgY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKCkgZnJvbSBoaXNpX3NwaV9ub3JfcmVtb3ZlKCkuDQo+IA0KPiBG
b3VuZCBieSBMaW51eCBEcml2ZXIgVmVyaWZpY2F0aW9uIHByb2plY3QgKGxpbnV4dGVzdGluZy5v
cmcpLg0KPiANCj4gRml4ZXM6IGU1MjNmMTExNDFiZCAoIm10ZDogc3BpLW5vcjogYWRkIGhpc2ls
aWNvbiBzcGktbm9yIGZsYXNoIGNvbnRyb2xsZXIgZHJpdmVyIikNCj4gU2lnbmVkLW9mZi1ieTog
RXZnZW55IE5vdmlrb3YgPG5vdmlrb3ZAaXNwcmFzLnJ1Pg0KPiBSZXZpZXdlZC1ieTogUHJhdHl1
c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KPiAtLS0NCj4gdjI6IEZpeCBub3RlcyBmcm9tIFBy
YXR5dXNoIFlhZGF2Og0KPiAgICAgLSBEZXNjcmliZSBiZXR0ZXIgd2h5IGNsb2NrIGRpc2FibGlu
ZyBpcyBub3QgbmVjZXNzYXJ5IGF0IHJlbW92ZSB0aW1lLg0KPiAgICAgLSBBZGQgdGFnIEZpeGVz
Lg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvaGlzaS1zZmMuYyB8
IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gDQoNCkFwcGxpZWQsIHRo
YW5rcy4NCg==
