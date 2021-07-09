Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADF3C2142
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhGIJL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:11:56 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3962 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhGIJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625821753; x=1657357753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qoTCGaKaNTMKDnUqImnQk7FVPbqjiWCVM/wRC2xi/jk=;
  b=TqHZI/bURuQh5xky9kLCo3bcRgWo6idMfCqnlEF1yngWL9U3kf8kpsma
   u8IdVmF7euOXlzE4L9xv32hzhrxtCFlbQr3VHd8+H1Njs6s9CYdeSYTBu
   ClYtC7ImRwzsb7MzI9cIImM51Vo3tdBPRmhL1TSKpChYcoKLCZJCU9ucE
   yfwmrS0PxIIvVv0ODiM4cr/L8/edgv8soT1HlCUW4BFof8GzQfk2wR7ki
   hb+PW1UZuiYjEup+NLSaSnk/UXzdlOS45X5mk7wJVF/dsUa1xsTNqkuQ1
   FeGJpreTWNnQy7aSNVE2gjtWtAPUYCiwmMF0LyiqCgNFHYO/3Oe/GWrT0
   w==;
IronPort-SDR: 9N36sJuu9undiyjtnPTZJNiz5gNmMtCtgNIwfce9O0JGgt+/9v9T+4eeFRpt5DyQqTjRHu3QAc
 bao5ddg7rgLFkLzm6CCZigMO7dg9A4SwISFM8GMXkar1WMCxH1lrotGD9y3XhyqNEDG/bxO6ER
 1DrENnNllEO6Ka+pb9eS+3VOO1TJKlBxSEgCWxgxZoOrbpkIBeEXThz//Ck4drk674noXGESLR
 hHb3vGvSLdOA2ArIjNjxxf3kahXABtOCTXZysgDWjzx6WeuT/Z1psgjMNjf7a858uRCP/4pcHo
 Jwo=
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="135202067"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2021 02:09:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 02:09:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 9 Jul 2021 02:09:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR3qXknXDfonx4vIwJ3M1/3FSgRcqmVY74m3ytqS66YFK25jk5irIT63sW3P/NF234vllN9hc8LjmZ3E0Hu5DDB2TUsjey8Yesp+ZR++t/csTbBJyVNrUGQrbqyvxt5ic/Otw1guWUVjYkp7SdGMrs4sBldw1Jc6pNTq7nG6xEoszXdCu2wXTaakjs8JLRCV7x9rtHkVP0KSSiGVb6IEEgKV+urhYCcQ3LANyA4/BuOzFhz/M9LWt4eOjHaqqTAQ4F1y65nbwRmSCplTVfBNBrVDFkT3CVwoHZ7aMKKtFOmOt5LnGa3oIPyBTS1EuKkUFIqYi9aiDQ2MvfertDOtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoTCGaKaNTMKDnUqImnQk7FVPbqjiWCVM/wRC2xi/jk=;
 b=lrmKyJkRzJMvt4QCBxI51iE49Z7bIZLBKVIsEesZ05P59e2xWwXWIZPH2nTsXt4IyjeNumHX0fFTW7bolJ8E6Fx0WzXmfzNuYFiD37jaoVhmS4a5GLtPiyl/id6/fdYDUQ9U/yncI2EzaZgUebFUJZOrfrb+k8rDinWcB7NWKS7GqZd0p/81DeKlR154dCePnogjZ85+bHt4zaxGdDsARhJ/91Dbr/V9zdev70AhAKCrQ40LHsfefAGdlUOt93ZATJ3wBXdXfN6s9ESkn4oaxcUDNiVYt6BZGEII+h+IJL1vLn4W5AA+1rfqO6fwNEsQOBJW1VWDhra9jPYNBKWzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoTCGaKaNTMKDnUqImnQk7FVPbqjiWCVM/wRC2xi/jk=;
 b=h+XaYKRD8nNM/gBbvEnT/gxUst+dE+2Yr8neIMWa9nnEaL/l2g/LrSFJ0ugtee8VNFhGmdh553Y+MxiKyBAr/G6q5e24JX2F3JtVIrAFY+nJdT/Lt2CZTMbXxAGae6avZ/sbK7vJDhTe1LRWhrnFPDXfHd3kLHRhPLsTnZtsxRc=
Received: from DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) by
 DM6PR11MB4578.namprd11.prod.outlook.com (2603:10b6:5:2a7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20; Fri, 9 Jul 2021 09:09:10 +0000
Received: from DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::44ef:d8cf:6e86:2cd5]) by DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::44ef:d8cf:6e86:2cd5%5]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 09:09:10 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <lee.jones@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <romain.izard.pro@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mfd: atmel-flexcom: use resume_noirq
Thread-Topic: [PATCH 2/2] mfd: atmel-flexcom: use resume_noirq
Thread-Index: AQHXcZGe7OXGogNlJ0iPorfIse7dbas6YQOA
Date:   Fri, 9 Jul 2021 09:09:10 +0000
Message-ID: <f0ca6431-8143-9e47-9f7f-d1d14dbd5fb7@microchip.com>
References: <20210705113104.579535-1-claudiu.beznea@microchip.com>
 <20210705113104.579535-3-claudiu.beznea@microchip.com>
In-Reply-To: <20210705113104.579535-3-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2197618-eee4-4b08-7cb9-08d942b93701
x-ms-traffictypediagnostic: DM6PR11MB4578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4578F007BCE9C11CA4C2B70EE7189@DM6PR11MB4578.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: moNu9bWurQ5p3ZR9URurzkdHwxLtVo2Vy0FEZV6v9uyOOqxXEj/o+fX55Rk3cUmfAf6KPwIZu6eBXgMPz8hmCBHqbF1KMW4jcrJ+K1qbqHnC7ssqhh053tc8G3NXQoxuUwPqGm/hIuhW5oNNFKpZlKhv1dfbT0EfnDQXtnwlQfIVHw0go0djdLqvGX0h/bqFlrzYwAtOzDd9YexNsM7kUVPOCIQ+OvfdtG8Mc+9YtZF2JrhoBCTuXu5RL0p590CjJTmJfVB+mKb/nZlOOnPUh9NkcILVvLVXUQkKyuA+Ws20Y3kcA0FJCpBLLt+hntINc+BZHecCvdrn248+QbnZu9rZ6/7imjmJ2W1Yy3tFkbXHMYdX1nHlmAlsTxPdWzxf1OPrYbgvZuD8wuIptloy67c1Ak+xvMIsdoE0+ZgLIJDfP6RwTHny5EmuKle0ieOhepkesijTZIdLL0M7dlNAnpaO4ImlHLUOOFmJ5StBLhsnkF7Cj+g6ZXczcTgw2WQWLAKeTNhpH0gfb3xXvn7EZd5hQGVVaWWwS6qrUiUgEplcxN1g1x3e0bSWuUjWo3sH2oI+nCiCfYVshMSxXZDh/UaEKc+9RqDLlo0QYeG7yrmDKxCF4lAKF79rJwRsxNDQqrJjUL3N0AAjkcW4hc3c/5UeZiZXmlQIycuG+UA9fgUaAPG80PN+ScuN5wOlrsnAfVIvFIdmXbz+48kWu5D8QDgpb44aUyV9LUhUGz5+V1s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(8676002)(83380400001)(2616005)(4744005)(71200400001)(4326008)(478600001)(31686004)(31696002)(26005)(316002)(6486002)(186003)(5660300002)(38100700002)(86362001)(66446008)(91956017)(53546011)(6512007)(6506007)(66946007)(66556008)(66476007)(76116006)(54906003)(64756008)(36756003)(122000001)(110136005)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emhYeU1jM3pLYU1zZWxhS1l2aDY3N1FzdTdhUFM1Q1MzWEtmYllObE84K2Ft?=
 =?utf-8?B?cExCM05HL2JjeldTRWVwOEQ5d05CY1Z1bWZtVTRuMkJhcjEzdFh6VitqYkR6?=
 =?utf-8?B?UmZPRDhDL0I2RjFQSE1NNUxQWG1pR3dDVlUxWWJ4cWliU1IwRVJ3K2drczNN?=
 =?utf-8?B?b05iS1BSb1ZuZjgyOFBtbDRDTDFLS2R1QlhsUHlLb2UvZXRNRGxmSVd1NGlp?=
 =?utf-8?B?Y3MwVVljME5nellOM2U4djkwdTZQQnEyNHlVaWZLcWlhNU03Z1hIbXhJMEZM?=
 =?utf-8?B?NXZJQnp2OGpSNjRjQ1ByekJtYlZJalJlYVhINGtDTEF4c1dxZUVxM1NERTEz?=
 =?utf-8?B?WUE3R2RmUUdXczd3c0IzaGJHTXZWMnczVUt2RHpJZ0R0a0MvUVE0WndBaUZm?=
 =?utf-8?B?MDlmQ04xMHptQVd0c2hsYTFBeTRubmJhYzV3RzVmYlZDY3hGaWpCcnBlOThy?=
 =?utf-8?B?SzIzTklGcDE2Y29lbnlUODhIdGxOQ09iVUl1dXpHMS9rbnJWYi8zUjQxNEVD?=
 =?utf-8?B?dGVrRjNXMDhhWTczTmdOYldtaGhmNkU1TUN1Z0xLOGNQWGRzSFFDVFEzT1Bv?=
 =?utf-8?B?T0FrTHBzeWpOWVNmb1JXNW1yaWl3cEpIZlBobzhjUHlDekE4YXI4WXZJTkY4?=
 =?utf-8?B?MmJhTFBNREk2cWtHQUI1VTRxUlp6VTMrb0NuTEZxOXErbzNuUjY5akpmOUl2?=
 =?utf-8?B?MUtrNCs3dW9rRG1ENUpkRGNHdFhPZERpSnRJRVNhWUc5USs5eUFPTE9mQ0NE?=
 =?utf-8?B?M1N6YWNSRmxQeUJoaWpYUU5ESWtyckhJWTZWd0F4cEdtQlVveFkyOFN3OWtG?=
 =?utf-8?B?NzVrKzBoQ1JHNWZjUko0ZGE3TDY4YXh5dkluaGhveEJEUW5DNENGRGFlYWgr?=
 =?utf-8?B?NjlyS3RYY0tjdVFYQ0Vuam1IVFpFQzJWVzJ2RllZYytTTWo0emYxZjd3WTh5?=
 =?utf-8?B?NGxwUG43WlBrTTBZQU4xUUVzenRFOEdoOXpyR3l1Z2R1WThGeHZNbEFQMitt?=
 =?utf-8?B?UXNaN1Q3bUlqcEpSRHgxUVYxN1B2SUhXVkJmOWpYOWJFUlZ3bGFCQ1hXdStJ?=
 =?utf-8?B?VlZlWUFWUHdvZ2xFZk4zVUE3Zitxdy9ZaEFzdklVY2pJNVZOaWpTbjFEOGlt?=
 =?utf-8?B?NTNubjRzRFpvQmllUlI0cVhOcWNXL0U3blBISnVhWXhPYmQ0Q1ZDMzU0My9w?=
 =?utf-8?B?d3I3MFNPREVTeVRpNzBEWjN6TnFjV25PRkxhb29DMnh0ZHIvQkFJSFFqOERB?=
 =?utf-8?B?aFRTbzE5eTI3VUE0SC9ZRjdkZis1OFY4Q01yaVVWNGExVkFkQVBmbTF4QlpB?=
 =?utf-8?B?MkpHTCtCV09KM2tKUHRkakFUQVh6OVNVaktIaWpvLzNaL3RGTmpGbW5kcWtD?=
 =?utf-8?B?Q2F0NHBDN2tTdE1yTTlISFpZOE0yN1ZNK1dqeE1VRnEzS3VSdnZoZnFDb1dy?=
 =?utf-8?B?cnF1TWNuSVF2TkJzYU9PRmx2Q1RvY1VyMWJWcmVDR2VzbzZTZ0NtOWlhdmRE?=
 =?utf-8?B?elVScDVBQUdFL3RMYzZ6N0hYa2ZQWjNUWGZUZEFLc3pTU3FIRzJ4SmFKUHFo?=
 =?utf-8?B?eXF4QkJmRDBXanp1OW1pTFNMU2lRM3cvL3VwK1VocVNhRExOZVMwT2NlMU1Q?=
 =?utf-8?B?U3dMbDE4RlNrVzZXZWxPaXNwZTB3dnpqZkNYV00zL3l5L0J5ZFE1c2pFNVF4?=
 =?utf-8?B?Nm5IemFpL0hFWXRZdzgwbUVmRlNRWHNzeXIvdFdEUkpQcjJaUklmVkRwVytN?=
 =?utf-8?Q?L4bbFs7jWFBxtIH4aw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <002605EF9C17194998DA72BCCC402DEC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2197618-eee4-4b08-7cb9-08d942b93701
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 09:09:10.7200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHpOgeeZND4AXp76ZH3pdANi/TP9YjxG9y821QXLWJqyfHZhBaS0OStbKqw6fcGT+YVh4MbxGbqTYYbftSVPQsqDOJCO2l+ymKjwujFuV+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4578
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMDcuMjAyMSAxNDozMSwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEZsZXhjb20gSVAg
ZW1iZWRzIDMgb3RoZXIgSVBzOiB1c2FydCwgaTJjLCBzcGkgYW5kIHNlbGVjdHMgdGhlIG9wZXJh
dGlvbg0KPiBtb2RlICh1c2FydCwgaTJjLCBzcGkpIHZpYSBtb2RlIHJlZ2lzdGVyIChGTEVYX01S
KS4gT24gaTJjIGJ1cyB0aGVyZSBtaWdodA0KPiBiZSBjb25uZWN0ZWQgY3JpdGljYWwgZGV2aWNl
cyAobGlrZSBQTUlDKSB3aGljaCBvbiBzdXNwZW5kL3Jlc3VtZSBzaG91bGQNCj4gYmUgc3VzcGVu
ZGVkL3Jlc3VtZWQgYXQgdGhlIGVuZC9iZWdpbm5pbmcuIGkyYyB1c2VzDQo+IC5zdXNwZW5kX25v
aXJxLy5yZXN1bWVfbm9pcnEgZm9yIHRoaXMga2luZCBvZiBwdXJwb3Nlcy4gQWxpZ24gZmxleGNv
bQ0KPiB0byB1c2UgLnJlc3VtZV9ub2lycSBhcyBpdCBzaG91bGQgYmUgcmVzdW1lZCBiZWZvcmUg
dGhlIGVtYmVkZGVkIElQcy4NCj4gT3RoZXJ3aXNlIHRoZSBlbWJlZGRlZCBkZXZpY2VzIG1pZ2h0
IGJlaGF2ZSBiYWRseS4NCj4gDQo+IEZpeGVzOiA3ZmRlYzExMDE1YzMgKCJhdG1lbF9mbGV4Y29t
OiBTdXBwb3J0IHJlc3VtaW5nIGFmdGVyIGEgY2hpcCByZXNldCIpDQo+IFNpZ25lZC1vZmYtYnk6
IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQpUZXN0ZWQt
Ynk6IENvZHJpbiBDaXVib3Rhcml1IDxjb2RyaW4uY2l1Ym90YXJpdUBtaWNyb2NoaXAuY29tPg0K
