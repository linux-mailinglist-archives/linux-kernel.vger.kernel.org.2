Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE743EFDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbhHRHVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:21:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:43946 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbhHRHVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629271233; x=1660807233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r/qvj+NJaSEgmzD6O6ao93VqgRboowfuP0AAAKZtnbQ=;
  b=D8KbS9Rc0qLNOa9GT428CzOCF1AUM7THKhqahcHaE8Jj/XhSm+svwlfx
   QgZcs2Nh2ito8OHe5b6GtewFKmpdQ1DjYTiTGieRFpn5gOKkFmorXY9oz
   PCdKyPZ2QmlR2v+ZfiHzSlA4M+rpayA29F8tJucYtaG16jbSvAwlCbLpO
   8LGe15oN6tGbof4r5mdiWzZOsu8ffXC+zYTkE3xeDkN3aDFGYjml+4orq
   HIQ2SZ5qySLNoHcFr+GdJSpnXieVZqUml5afJImEYyjD1NAXgJ8KSHdv4
   I63qiM0Nfe67gVXEDI4XnsMhOPff76ge/88ClAdC/ue852glG5bMNqw+4
   A==;
IronPort-SDR: qYHLWoohg7mOTDHixIamRtv8qmY0p5XwkhVxMc5m8T7gQvQAeBGgQkw3/OUXxcX86/Vr5P03FE
 ikV8tdecJp80VsGUCCLpHDjgC864r9bfvVEK4+SuUsqeL+dQkJm5T5m+tbAT24QmY8xT3B8Ly3
 qTz88640PMLxvB3kbHvLCTkQZL4iGsJRxZW7XPENyRtCppH0v8X6tikE98ejbXpF65ReV9SoJH
 KMGcxoGXIkBCA2rfvhteQQgjlgjNmoWH2GVHK9mLeCJWZZlhMQ48uF2HIOz5jt+cpiHqesD6G3
 nVOZgCyAWbgz7dIgrv9WhiW4
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="128720800"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Aug 2021 00:20:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 18 Aug 2021 00:20:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Wed, 18 Aug 2021 00:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEWhNGwR2RTv+ESQbFidovGaL/1H1tJ1MXiMqv4CL3Al/8Ss2OTBt1DGrlLRdTAJ9iQNvy5QdJPArjP1DQj+ErCnJ53r0PJf32LHKMfXvhj+j35SuTYPb+5JKRkiZocuGClVXIPAbC4Ng9/0+/xADSEq34g1anvgr1flTPo0TiRDtCtR3J0wxwpdM5R5PvnftgU26WWM1ejOKX7cYrQ+PKHcWj6pyTvjLAE86POrGoH61Sg0KZPcn8KmOMEuzM7xpsWwWS46iJosVp6rrB+lpgw6IQXB/Qn4egRQ7JX/V/zbdlfBzw78h/096YnB8XEeph3I3CLwGjNDHBDRS54hPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/qvj+NJaSEgmzD6O6ao93VqgRboowfuP0AAAKZtnbQ=;
 b=CmnkrjbUEu8ewSsRZzrbv1KIO1DMlcYKOb7Os5iWLqkmjvzs3MXm54cFKvJ8egNYNgT6xt02QiMPMdwRb5Axc6C9XNIGUdpKTR0YGR9TQa+TIw4v+LMZob/+2TbvWSh3Khm5csFDdauPyk5zFJTO7BpiZx1baO6ywr6eLjEof9iWjcgB0HhTT6Id7Nf38atjA5WuR9w+W6178Pnxer2IzFH05Xj4ILmN7SQC4eDvSl3YLMipzNh55CwiNb31JNlqzMf8wMvBVUbf8STe4dvvTM1tljM12yGt4co+pnPXk5CIdflnp4B5T3mhK15Xw6IXcy/QWWmAGjbFiFxjNVN6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/qvj+NJaSEgmzD6O6ao93VqgRboowfuP0AAAKZtnbQ=;
 b=PTdx3dv32PVSZbpJ9oejTDdYQWBB8J+ZvpNGTxJ/cQhohGHMKyaAVfD0mbktnDpaonPPtJnpV8OG+Qx/E0caTtssgXW9RWqUc7LFafwC3atWTX85wGfMHjCj2D/U9UHScqD6WTkkYmL+MQrrDlakjIVJsL77UCP9DTJGUsc1tRk=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1580.namprd11.prod.outlook.com (2603:10b6:4:10::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Wed, 18 Aug 2021 07:20:30 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 07:20:30 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <lkp@intel.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Eugen.Hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <corbet@lwn.net>
Subject: Re: [PATCH] clk/at91: remove kernel-doc warnings in sama7g5.c
Thread-Topic: [PATCH] clk/at91: remove kernel-doc warnings in sama7g5.c
Thread-Index: AQHXk++xCQIEligc0kWY/q1TClxDLA==
Date:   Wed, 18 Aug 2021 07:20:30 +0000
Message-ID: <1918428f-a808-2a90-5c6d-991e5f5d469c@microchip.com>
References: <20210810005431.22007-1-rdunlap@infradead.org>
 <1670a11e-98d8-1b55-34c0-3369aaa8a615@microchip.com>
 <29f0b5d0-d9ab-6ef3-b280-ba3d64c8d828@infradead.org>
In-Reply-To: <29f0b5d0-d9ab-6ef3-b280-ba3d64c8d828@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b14bd555-eecc-49dc-e688-08d96218a917
x-ms-traffictypediagnostic: DM5PR11MB1580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1580A142B4BA956005B471F187FF9@DM5PR11MB1580.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FS2Xn9s/xpfOsHoxphTf9VqOVU5TunG15ACMHbUJ9RcVJ7xpTdji4S/ZLgXZYK4r2kfHhtiA3idoFMovSZwS0f2zE5mOZ8RsE/w8Po65tqQpu0Zp0URJzdGijydc7+f1Vh6qySSDLjqwQkC/i04WubjBJej3w8RsS4wVi4TbDOgD0/INLUS3i+0ngE0USzc+YtZQSRAq9rQH5wwwiWaksAUrYEHTOLXmobkII15DBl/TZ2ioMArzQN7YFNSEYaS7GlcOGtZqvVyDHyB4AkNRDbOv1Ry7ai6WBEqmv5gyooXsgm3Eeb9u3tIxsZ2+FY6XGBcKUnIU5OI2E08MzhCxePJQUWJ+C3qiC4Ezv5EUWb4WZDSHwxpfR5k/0P2bKMTq702KEv7wRxlGYJ704qVMC+ERrZ8AeHseIje7Vhmn3fzglnjflJ7S2rmC8qpeqyTBVAGHCjCulHgxkZ+rrUZIzeHMQGPFlFgFlFUO69zHIGU7FsuZNL1GfKoEAcZZUfIlEV086OPognaoz8gDD7d298vTwkxvoGzFpui8k3aWAqC7TrJQYv37rqtS+Vdw+NVrT7DQjBQzoK6dNLFAKyEkdeG18yh5+z4XwtQxD+dDnsVYZpNTX7xhFWgFQM3LRElalEGH5LzyeeWEfYbo9LtoD7vOKKQK5rrEuGeaPTO0UnkSqHyB/bynMvjgu0M2PqeYBP5Cjx3J1c7jZIl08VfuKYgW1l4s6DDxgTmvgF7HrPJ2ORSpO3fT49TQeYJENoU4Ohs8KyK1BhmExn1DgJDQFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(53546011)(6506007)(122000001)(31686004)(38100700002)(2906002)(5660300002)(83380400001)(508600001)(54906003)(110136005)(4326008)(316002)(2616005)(71200400001)(8936002)(66556008)(26005)(66446008)(31696002)(64756008)(76116006)(91956017)(66476007)(66946007)(8676002)(6512007)(86362001)(36756003)(6486002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVBBWTl4bjRUZS8xOUpXTTN6a1EvcTVpRnM3dTJja1lIY0lkelUyWnB6OTU2?=
 =?utf-8?B?TzVnbkFEbkl3ZTQvNVU2d05IM0F2N3pzQkl6VUdUZmVwVjhZd2ZwTU9JOXZJ?=
 =?utf-8?B?VGM4cWI0UFF3cVBQWHhERXc2OUJhR25IZmVNYXJpNDRkaFcrcUdsZzJ3RURU?=
 =?utf-8?B?NFlsZWlnOTRGNnFuMGFHaEpJclROcXR6cWc4RHNMV01rTmZ5TjRrVnY4UFF6?=
 =?utf-8?B?RWdCdDVYRThNMENzdkR4bWIzY2V6K0dVQnFraHBtREhEZ1g3UjRBYUZSMXI1?=
 =?utf-8?B?MGVJeGpsKzBLVFppOENOOXZUSzlaeDVVbGNPcGJhZk81Ry83cDAyditndHVn?=
 =?utf-8?B?NHV6NEZIc3hOSTRWamZFblgyaW80cFBCMXJZaFcraUR0K0dtbFZQVFRSVWVl?=
 =?utf-8?B?Q0JUSXZ5OUNCdHFQKzJ0a0svR2h5SjY0TzJRL0lXSWVOOGxqUWpzYmgyQ01Y?=
 =?utf-8?B?cVQ4R2xRSkFiZ1ROVEtqMnhJYjExSXRNODc2N2p2KzB6c2EveGs0RDdoL3Ro?=
 =?utf-8?B?eS9KS2ZVQkRwbmk1M0dvNmRsbzlLR29WSWM1ZUpSM045V0xJajlqcEhJM1Vr?=
 =?utf-8?B?R08yM0wzb3VyeHI3ejR3clRkNVV5MHFvSitmK1EyYUhVV2N4WGxIZXg5VTAz?=
 =?utf-8?B?U3ZyQ3Rmd3RyaEFYVU44ZHNiOG9xb3NZc204TEF4d05tNjBqSHZhREFMRk1X?=
 =?utf-8?B?akNtUzcvU1NmZ2RzQWlMenhzWDA3czYva2xJU2Q3MFVIdnVnVy9VRUtOZVJG?=
 =?utf-8?B?SzhCQ2IyeVVmZmJyWmlWWFhESzl2VExIWGVZMTYya3k1bEhZQUlaamxFZkpB?=
 =?utf-8?B?ZVhPOW9VRTZzUCs5SUkxV1NSd251b1BQeUxWTXYycEpVL0NaTWg0V09GMGF5?=
 =?utf-8?B?dmhYRnRoM0ZUREZISlZqQ3JtK3c5UUx0YzhBVjI2VU9tMUd6YjJ0dkF6bzFp?=
 =?utf-8?B?QlcxQ29laEdtZ1M1MFhKNllKVVFGQlAxeDMrVVJ4d1lHejFidkRKQ1lYZllK?=
 =?utf-8?B?MFYzbjVCeTVMRW1GM0hiU1RRaUZHYnIzOFk0a2tmR2l1bFNEOTVtUkhmbDFV?=
 =?utf-8?B?UnNEazFqVFl2cWN3dnU3dE81TDZyalJwQmdabWduYWpnKzBNY0xnMitmMXRW?=
 =?utf-8?B?ZHlwS01EaWdqS2ZhaUhQT0w4WCtnc05ocGtVditoQ0NsY1JxSW1RcnF1TmQr?=
 =?utf-8?B?eDFzNUY2N2syOUZrRC85VUNBRVhxVFl5eHczNnBPbkZsRUNMM3RHeVBhL2Q4?=
 =?utf-8?B?amZtTk5iamlXZXZiNUJTWHl1ZytYdlZMdGZhZVhxTTJ1SnBPSUY0N3EyUXBP?=
 =?utf-8?B?b2t2eU0wRHB3bzMyN2ZEUnV2SDU3bytDanlhZFVidllFNzdReHhMY2ZCYlVv?=
 =?utf-8?B?M0k4bVJFazB0Z2FYM2VMNEJjcy9kL0ZveWhPU0xsMUxxRnUzUEU5MDFYaU9N?=
 =?utf-8?B?ZmUvenhyL3BTdlE0L0RjaTh2eW53SG9JeXRiOTJEc3JYZjBsalhkU2lPZ3JU?=
 =?utf-8?B?aUhqU1dIOHYzdzhqYmhlcGJpWVBBMGswZUZia1MzZzBWR1RoVU1PR09BSVBy?=
 =?utf-8?B?R3FmRE83Q2ZlV3EvSFl0THBXcjg1MVpXVnh3YWhBTVZYb3NwWVhZQU1memFy?=
 =?utf-8?B?eUp1RStqWHhpS1RaNVpkbHVTakZPQmdCNWZzamRUeW1oVFhMc2JhQ1ZmbHZM?=
 =?utf-8?B?cmV4cmFIS3ZuMzhybk9hSnpIZjNGN0tiMTNSQTU1S2ozeWtlVnN5MWltZDFM?=
 =?utf-8?Q?sI1z9qa7ThPAn1rRMA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A70CF17042D7A49AC293F47279F005E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14bd555-eecc-49dc-e688-08d96218a917
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 07:20:30.3759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FxtQzkmoJ+2d1Qjw7YxpWs576uy3CIurayaFrgB7tXXnL1itCgOewIyhpHMOCjB3ZrNKLlK3Re+AN0T5U9fH/NrF7mr+VQmB5JrcsSRYSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1580
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTguMDguMjAyMSAwODozMiwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDgvMTcvMjEgMTA6MTIgUE0sIENsYXVk
aXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBIaSBSYW5keSwNCj4+DQo+PiBPbiAx
MC4wOC4yMDIxIDAzOjU0LCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0K
Pj4+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IEZpeCBtdWx0aXBsZSBrZXJuZWwtZG9j
IHdhcm5pbmdzIGluIHNhbWE3ZzUuYy4gVGhlcmUgYXJlIHNldmVyYWwNCj4+PiBlbnVtcyBhbmQg
c3RydWN0cyB0aGF0IHdlcmUgbm90IGlkZW50aWZpZWQgYXMgc3VjaC4NCj4+PiBUaGVyZSBhcmUg
YWxzbyBzZXZlcmFsIGFub255bW91cyBzdHJ1Y3RzICh0aGF0IHNjcmlwdHMva2VybmVsLWRvYw0K
Pj4+IGhhcyBwcm9ibGVtcyB3aXRoKSwgc28gYWRkIHN0cnVjdCBuYW1lcyB0byB0aGVtLg0KPj4+
DQo+Pj4gRml4ZXMgdGhlIGZvbGxvd2luZyB3YXJuaW5nczoNCj4+Pg0KPj4+IGRyaXZlcnMvY2xr
L2F0OTEvc2FtYTdnNS5jOjM5OiB3YXJuaW5nOiBUaGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8q
KicsDQo+Pj4gYnV0IGlzbid0IGEga2VybmVsLWRvYyBjb21tZW50LiBSZWZlcg0KPj4+IERvY3Vt
ZW50YXRpb24vZG9jLWd1aWRlL2tlcm5lbC1kb2MucnN0DQo+Pj4gwqAgKiBQTEwgY2xvY2tzIGlk
ZW50aWZpZXJzDQo+Pj4gZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2c1LmM6NjA6IHdhcm5pbmc6IFRo
aXMgY29tbWVudCBzdGFydHMgd2l0aCAnLyoqJywNCj4+PiBidXQgaXNuJ3QgYSBrZXJuZWwtZG9j
IGNvbW1lbnQuIFJlZmVyDQo+Pj4gRG9jdW1lbnRhdGlvbi9kb2MtZ3VpZGUva2VybmVsLWRvYy5y
c3QNCj4+PiDCoCAqIFBMTCB0eXBlIGlkZW50aWZpZXJzDQo+Pj4gZHJpdmVycy9jbGsvYXQ5MS9z
YW1hN2c1LmM6MTIyOiB3YXJuaW5nOiBUaGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKicsDQo+
Pj4gYnV0IGlzbid0IGEga2VybmVsLWRvYyBjb21tZW50LiBSZWZlcg0KPj4+IERvY3VtZW50YXRp
b24vZG9jLWd1aWRlL2tlcm5lbC1kb2MucnN0DQo+Pj4gwqAgKiBQTEwgY2xvY2tzIGRlc2NyaXB0
aW9uDQo+Pj4gZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2c1LmM6Mjg5OiB3YXJuaW5nOiBUaGlzIGNv
bW1lbnQgc3RhcnRzIHdpdGggJy8qKicsDQo+Pj4gYnV0IGlzbid0IGEga2VybmVsLWRvYyBjb21t
ZW50LiBSZWZlcg0KPj4+IERvY3VtZW50YXRpb24vZG9jLWd1aWRlL2tlcm5lbC1kb2MucnN0DQo+
Pj4gwqAgKiBNYXN0ZXIgY2xvY2sgKE1DS1sxLi40XSkgZGVzY3JpcHRpb24NCj4+PiBkcml2ZXJz
L2Nsay9hdDkxL3NhbWE3ZzUuYzozNDE6IHdhcm5pbmc6IFRoaXMgY29tbWVudCBzdGFydHMgd2l0
aCAnLyoqJywNCj4+PiBidXQgaXNuJ3QgYSBrZXJuZWwtZG9jIGNvbW1lbnQuIFJlZmVyDQo+Pj4g
RG9jdW1lbnRhdGlvbi9kb2MtZ3VpZGUva2VybmVsLWRvYy5yc3QNCj4+PiDCoCAqIFN5c3RlbSBj
bG9jayBkZXNjcmlwdGlvbg0KPj4+IGRyaXZlcnMvY2xrL2F0OTEvc2FtYTdnNS5jOjM2NTogd2Fy
bmluZzogVGhpcyBjb21tZW50IHN0YXJ0cyB3aXRoICcvKionLA0KPj4+IGJ1dCBpc24ndCBhIGtl
cm5lbC1kb2MgY29tbWVudC4gUmVmZXINCj4+PiBEb2N1bWVudGF0aW9uL2RvYy1ndWlkZS9rZXJu
ZWwtZG9jLnJzdA0KPj4+IMKgICogUGVyaXBoZXJhbCBjbG9jayBkZXNjcmlwdGlvbg0KPj4+IGRy
aXZlcnMvY2xrL2F0OTEvc2FtYTdnNS5jOjQ1Mzogd2FybmluZzogVGhpcyBjb21tZW50IHN0YXJ0
cyB3aXRoICcvKionLA0KPj4+IGJ1dCBpc24ndCBhIGtlcm5lbC1kb2MgY29tbWVudC4gUmVmZXIN
Cj4+PiBEb2N1bWVudGF0aW9uL2RvYy1ndWlkZS9rZXJuZWwtZG9jLnJzdA0KPj4+IMKgICogR2Vu
ZXJpYyBjbG9jayBkZXNjcmlwdGlvbg0KPj4+IGRyaXZlcnMvY2xrL2F0OTEvc2FtYTdnNS5jOjMz
OTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlcg0KPj4+ICdlcF9jaGdfaWQn
IG5vdCBkZXNjcmliZWQgaW4gJ21hc3Rlcl9jbG9jaycNCj4+Pg0KPj4+IFNvbWUga2VybmVsLWRv
YyB3YXJuaW5ncyBhcmUgc3RpbGwgcHJpbnRlZCwgYnV0IHRoZXkgYXJlIGFsbCBkdWUgdG8NCj4+
PiBwcm9ibGVtcyBpbiB0aGUga2VybmVsLWRvYyBzY3JpcHQgKGlmIGFueW9uZSBpcyBpbnRlcmVz
dGVkIGluIHBsYXlpbmcNCj4+PiB3aXRoIHNvbWUgUGVybCA6KS4gVGhlc2Ugd2FybmluZ3MgYXJl
Og0KPj4+DQo+Pj4gc2FtYTdnNS5jOjI4Nzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9y
IG1lbWJlciAneycgbm90IGRlc2NyaWJlZA0KPj4+IGluICdzYW1hN2c1X3BsbHMnDQo+Pj4gc2Ft
YTdnNS5jOjI4Nzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnJyBub3Qg
ZGVzY3JpYmVkIGluDQo+Pj4gJ3NhbWE3ZzVfcGxscycNCj4+PiBzYW1hN2c1LmM6Mjg3OiB3YXJu
aW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICd9JyBub3QgZGVzY3JpYmVkDQo+Pj4g
aW4gJ3NhbWE3ZzVfcGxscycNCj4+PiBzYW1hN2c1LmM6MzM5OiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdzYW1hN2c1X21ja3gnIG5vdA0KPj4+IGRlc2NyaWJlZCBpbiAn
bWFzdGVyX2Nsb2NrJw0KPj4+IHNhbWE3ZzUuYzozMzk6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFt
ZXRlciBvciBtZW1iZXIgJ30nIG5vdCBkZXNjcmliZWQNCj4+PiBpbiAnbWFzdGVyX2Nsb2NrJw0K
Pj4+IHNhbWE3ZzUuYzozNjA6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIg
J3NhbWE3ZzVfc3lzdGVtY2snDQo+Pj4gbm90IGRlc2NyaWJlZCBpbiAnc3lzdGVtX2Nsb2NrJw0K
Pj4+IHNhbWE3ZzUuYzo0NTE6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIg
J3NhbWE3ZzVfcGVyaXBoY2snDQo+Pj4gbm90IGRlc2NyaWJlZCBpbiAncGVyaXBoX2Nsb2NrJw0K
Pj4+IHNhbWE3ZzUuYzo0NTE6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIg
Jycgbm90IGRlc2NyaWJlZCBpbg0KPj4+ICdwZXJpcGhfY2xvY2snDQo+Pj4gc2FtYTdnNS5jOjQ1
MTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnfScgbm90IGRlc2NyaWJl
ZA0KPj4+IGluICdwZXJpcGhfY2xvY2snDQo+Pj4gc2FtYTdnNS5jOjg0MTogd2FybmluZzogRnVu
Y3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnc2FtYTdnNV9nY2snIG5vdA0KPj4+IGRlc2NyaWJl
ZCBpbiAnZ2VuZXJpY19jbG9jaycNCj4+PiBzYW1hN2c1LmM6ODQxOiB3YXJuaW5nOiBGdW5jdGlv
biBwYXJhbWV0ZXIgb3IgbWVtYmVyICd9JyBub3QgZGVzY3JpYmVkDQo+Pj4gaW4gJ2dlbmVyaWNf
Y2xvY2snDQo+Pg0KPj4gV2hhdCBhYm91dCBrZWVwaW5nIG9ubHkgb25lICcqJyBpbnN0ZWFkIG9m
ICcqKicgd2hlcmUgbmVjZXNzYXJ5IGFzIHRoZXNlDQo+PiBkYXRhIHN0cnVjdHVyZXMgYXJlIG9u
bHkgbG9jYWwgdG8gc2FtYTdnNS5jIGZpbGUgKGFjY29yZGluZyB0bw0KPj4gRG9jdW1lbnRhdGlv
bi9kb2MtZ3VpZGUva2VybmVsLWRvYy5yc3QgIkZ1bmN0aW9ucyBhbmQgZGF0YSBzdHJ1Y3R1cmVz
IGluDQo+PiBoZWFkZXIgZmlsZXMgd2hpY2ggYXJlIGludGVuZGVkIHRvIGJlIHVzZWQgYnkgbW9k
dWxlcyBzaG91bGQgYWxzbyBoYXZlDQo+PiBrZXJuZWwtZG9jIGNvbW1lbnRzLiIpLiBUaGlzIHdh
eSBhbGwgdGhlIHdhcm5pbmdzIHdpbGwgYmUgZ29uZS4NCj4gDQo+IFN1cmUsIHRoYXQgd29ya3Mg
dG9vLg0KPiBJJ2xsIHNlbmQgYW4gdXBkYXRlZCBwYXRjaC4NCg0KQWxzbywgdGhlIHRpdGxlIHNo
b3VsZCBiZSBzb21ldGhpbmcgbGlrZQ0KImNsazogYXQ5MTogc2FtYTdnNTogPHlvdXIgbWVzc2Fn
ZT4iDQoNCj4gDQo+IHRoYW5rcy4NCj4gLS0gDQo+IH5SYW5keQ0KPiANCg0K
