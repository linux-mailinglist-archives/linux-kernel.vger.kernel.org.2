Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7E41FE71
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 00:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhJBWWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 18:22:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:56196 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234037AbhJBWWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 18:22:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10125"; a="205230473"
X-IronPort-AV: E=Sophos;i="5.85,342,1624345200"; 
   d="scan'208";a="205230473"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2021 15:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,342,1624345200"; 
   d="scan'208";a="620289715"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2021 15:20:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 2 Oct 2021 15:20:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sat, 2 Oct 2021 15:20:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sat, 2 Oct 2021 15:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS9T8HRp7TaeybS83Rklkv+a+T40k8GxmWSudB/4jypQoBr/ZSgOg47jN5SadvzQxClqQcakGA2OsdJy7oQHj/+ub19zHSq199U6sWDkvJDOTefUiNqkpRKGuoADExMswyj8EATEAHljR6WljZK/HsYAXOWGPSCCszLCnZSgE1eVMtVvcP6i4wBkCvXfICEMwlGtMv7Qakw1bJU84rZ48Z5+PV9OgLmCuCpm/M0fo4Jv2EuudAh+/SkVLmSC/RfteM4hkHvGTWvl4LTMRuaCJTIJ6L/MtWCfqPynkyvgYdHgjPfwaSrpHYyjkAcvUx59OqXnFMXnHIPToUb9cYWa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpEwnwZjC1OLnjYL4n2371Z5v2jkIeOGySgCpG1HoA0=;
 b=io2/DWFHspPyAw9AkMJ0YDRYcsA8CHUrot2GTAYVrj2u5I3HyeAx/lVp48ddPaKDy+7Nw+jcf6/4Atjhxb7MvFZSJVeEKYR43oI1/cwaQQjWM/d364HymvK2HInm/JVnwGhj6U2hRoy3OkUDs6emq+VC4c8lvd+etFj8E3P0rY9nTZAkiaEXBym3rI6aubFpJIC2QHKAIiJMtEjhEE5+9aMu/J8sSjvKHfnmLP2eu3WMZmN0v0kq3PkJsnyiBL7YOA8W28lhPJLWqCvwo78856R7sQPcfdgO/esjrpJb+rHr5ptgprGceekVo1Sr9l84UCSgjSQ18YZunxKxAU7jLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpEwnwZjC1OLnjYL4n2371Z5v2jkIeOGySgCpG1HoA0=;
 b=xRysGlvCvXnks5QLGFWuNPHs1osEkfWHoOf7qP+8AKW4X4ZW24wFvWsFTbJq79hCjG6AJNfX7KP5anFhMiO97749bPay2GU9zuiw/k9bAdAH1Bw/kvXEJD/9QYVHtrabcRG2zdfdIg/Z8nf1xLrMgF+HlL6ZQm8r6+A6bE6bZ2o=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4823.namprd11.prod.outlook.com (2603:10b6:510:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Sat, 2 Oct
 2021 22:20:15 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.022; Sat, 2 Oct 2021
 22:20:15 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
Thread-Topic: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
Thread-Index: AQHXtxXjpXjC3Qk5Sky+qg9KSaDYk6vAQgwAgAAHHQA=
Date:   Sat, 2 Oct 2021 22:20:15 +0000
Message-ID: <862A89B5-D525-4B72-8C07-0449340E456C@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
 <87mtnrgkij.ffs@tglx>
In-Reply-To: <87mtnrgkij.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0531ddd9-7ea2-4ca4-ca53-08d985f2cf31
x-ms-traffictypediagnostic: PH0PR11MB4823:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB48234528EDED4556888D9918D8AC9@PH0PR11MB4823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k98ltewpqDaYwMmTrsmU59YEaXBoUL6Da6xvfgMQAFewsyKIJFfGTTXiXR1XtstDGGeQ7LtioUxlZbZUtqhoESRrvTcvyX4WgJqIFjc4O7u8n8t68pyjM9NLQAcruOFwHh1IKkriKmJQBBLrvASbhx1W5oLepk2/hdU1NSvQGIfvFlK9N7uoCS3zRG2cSz6eC7aQHlcTRJq4etuI03QDZJldp9nObpDGbAl8LiGpclyD2ThfusHA/i5rhSB3hYs3EY1rZVmW1jbT31Bk4Rov4uwHVRiUGIJnkF00k9t4wg9MsXlROfCkGr7MuomFD2lU1JHiMng54UJ1tqI+uRF7Z9unDY1CBR+jOE44r1OF+jX70xk2BErZNxl6sS4Ejmza2zebMbO7mgSuFGQI6Rmpizhp8kf57RDupqoM+N4ey2knCdE9aQ/TG61cnIyMiqem4sHJboHsQlIh8q/L91Q3bLtGH96XKOVqLv3YpnEKDY2VrAMWfnO9G+KLldf9Rw4vgcXaFF1URdXhjLvEvZ4oPZT8B2XbdZZkbPL/A/2d52a5dlXQuDziNOu3yl8h2WtYpg5SgS0HdlfY0sYKTqDohAThmPY3e907IhOwk45mUeerosAgcyrWvJrgifbKWen4GGlY2c/umJWuR9UvRGG86LBmIugCTtd1F+UkkbttVYYDdbBDiBZ9RM1V/UIVF07oxO8cpJn3ZeDUlN7eLXjqMNkr/beu8ZNh1u2AlpDKaviJnSLhlMsv7IGjgJbN1bcB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(2616005)(2906002)(4744005)(508600001)(122000001)(38100700002)(6512007)(38070700005)(8936002)(316002)(8676002)(54906003)(5660300002)(36756003)(186003)(26005)(86362001)(33656002)(53546011)(6506007)(4326008)(76116006)(66946007)(66556008)(66446008)(64756008)(6916009)(66476007)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2pDUDhCUXBnc251UUdISnBKU051VzZJV3krNXdwTG5zTVFUSmxKUWsrMDRs?=
 =?utf-8?B?STFRSkR2Yk1mNWJKZU9mL0J1VkFjQTkvL0dacnZ1bEh3ZUpadWtpZ1lyR1FJ?=
 =?utf-8?B?c2lwTVpDTXJPVUFDQzNBVjZXMndJeWNUVVBBR2VSdVl6OGx1STBQWlZpVDRU?=
 =?utf-8?B?UTc2dG1ZbHJVNHVCREpvNzFwWUwyTWlRcjhBTGxGSVordVFCcWE5Nk0vb2VY?=
 =?utf-8?B?Uk5FRUg2amhDUnlkekNQRTl2aU04ZU1UNjk0bElieUltUjZvTDJhalorcERV?=
 =?utf-8?B?TlY3Zm4wTW15SStMQmFSRXdnM3BiekQxYkFBVTB1RWxYM3RPZEFhVlJzWi9a?=
 =?utf-8?B?ekUxeWMxL2lhTXJGaEVzb1YwNVQrWElzRVVVU2ZiVC81dXBqcEU2bkNibmVY?=
 =?utf-8?B?MW5vbFJnbjlmMmw2TUdHMVBYT0d5VDhEUkI4dm1YZ2tHM0tVbGNCbzNlWkpU?=
 =?utf-8?B?U0hmWGFmc0Nydm9qMDVlUUphcGlidDJObDFRbGU4UWpmWk1SSmV0ZEhEeisr?=
 =?utf-8?B?cE1CRWJ3cmpJNm1pY2cxK1poNkpsUXAyeXgva2Z2K1JvYlFGRE5ZV2RzWmpr?=
 =?utf-8?B?VE85b0JrdHVKSTcyYmpmYXZWYTdqeDlVNXBucWtDakJGNnN5dld0ZFBLYzJK?=
 =?utf-8?B?Q3RuQWlKWWY1N0Q4bmJqNndIV1daMTBkTUZ6L2w1VFdrblZUNXZqNU5TWlZI?=
 =?utf-8?B?VkVQTGc0WHFZS2xMOEhTeFY3ZnJPM1FtTmVzL2tXVGZsZVVYT3ZBeGpOU1N3?=
 =?utf-8?B?cGN4WGpLQUlObmc0WEpNSXNkR0VaV1oxNnJkWjd0ZHE5bXFVT2FORzA1QUlR?=
 =?utf-8?B?cm1MSGVLeXV5VVJjNmhoSlM2dzhBOVBOSnJBd1I4bFFIdzAycEJkT2VJUWlV?=
 =?utf-8?B?VXFSVUJra29OalRsMmcxcWhwSGdoKzlYeXZYcGw4L0d1bUtUSXlMb3hlejBM?=
 =?utf-8?B?Rmc4ckNrMXY3ckZmam5QZnV2dzZsMXJnaVMvbU9mMDNtMytmMm0vYm5sRFR2?=
 =?utf-8?B?eHNFTk9uWU1QU1lsSmd3N2RaQkRjdmJYNndhRS9sVEMwSERuSm1OZkFXZzRj?=
 =?utf-8?B?eUNZbTFFQjhuWjZjNU1GWUNKZFl4NGVNMWlWZEZWcmtqRndJTnVubGZjeGl5?=
 =?utf-8?B?Q2Fyd3BBNmRBem5wUjFnVWNWbkNzNzJrOVY4WGxkUHp5OTdUOTJwYmlLRzBT?=
 =?utf-8?B?aCszWkl1Z1BlTU9tUUZUOEU3cG1LN1U1YzdLeldoY3dxQUJhRVRhV3plcGNr?=
 =?utf-8?B?L0pJT25jQkthV2Z5ejY5eXN0VzZIdmR1QkVaK1JXcmVwRnlISUxHWVM3VWxO?=
 =?utf-8?B?WHMxTngwaTRSMGdNU1dzOThFUXZmaDhqRjVWOE14eG9CU0Mva1NKcnVGVzg5?=
 =?utf-8?B?QnY2ZFBRS2gwOEZ3R3h4dkpHWTduSWZHbEs2emdjakpTK3BvOEcvSDMyNEtM?=
 =?utf-8?B?Mis5K3hJUStHZjNvY0pFTDQzeWpPWHlVeEpraXZFQUlOL1ltdU12QXByMVN6?=
 =?utf-8?B?Vko4elZEU2RITy92OEdITFdUSVE1ZFdsMUZlWVFGelJxWC9wdWd5WVJ4czFk?=
 =?utf-8?B?cDB1bzFFSk5BZWsvUkhJKzNteml3My8rclhnWGxwam0rUjVyajhrWVFJRnN0?=
 =?utf-8?B?SFRVUkV2UkhaejdaRFlSMSthRDNYRVRFTnhQVy85cHJHUkw0ZzhoVWN2OTFs?=
 =?utf-8?B?d3AvS3BRRC9XZm5pUTIybTFhTzV0MXlQSFROT3pSZW1aNU1rTUtLSE4rUC9Y?=
 =?utf-8?Q?VYRN43mB3uLIN2bls2qMWgHGBiSF5Y67atoZa22?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AF257385E1B4E43B6C4AA5BD822D7EA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0531ddd9-7ea2-4ca4-ca53-08d985f2cf31
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2021 22:20:15.3008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYHzHAypa2+y578dykAf6saBGjZRiEzUT81hTzITHXjNCTL94Bg+u+y7ie1VpUcyhDVgWN4xMnekGy1lPE6i6VdNxnUitEhDZkGLfYuHg2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4823
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gT2N0IDIsIDIwMjEsIGF0IDE0OjU0LCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4gd3JvdGU6DQo+IE9uIEZyaSwgT2N0IDAxIDIwMjEgYXQgMTU6MzYsIENoYW5nIFMuIEJh
ZSB3cm90ZToNCj4+IFRoZSBwYXRjaGVzIGFyZSBidWlsdCBvbiB0b3Agb2YgdGhlIHJlY2VudCB1
cHN0cmVhbSB4ODYgRlBVIGNoYW5nZXMgWzEzXS4NCj4gDQo+IHdoaWNoIGRvZXMgbm90IGFwcGx5
IG9uOg0KPiANCj4gICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdGlwL3RpcC5naXQgbWFzdGVyDQo+IA0KPiBiZWNhdXNlIHRoZSByZWxlbnRsZXNzIHg4NiBm
b2xrcyBjaGFuZ2VkIHRoZSBGUFUgY29kZSBzb21lIG1vcmUuLi4NCj4gDQo+IFlvdSBzaG91bGQg
a25vdyB0aGUgZHJpbGwgYnkgbm93LiANCg0KT2gsIEnigJltIHNvcnJ5LCB0aGF0IHNlbnRlbmNl
IHdhcyBjb3BpZWQgZnJvbSB0aGUgb2xkIGNvdmVyIGxldHRlcnMuDQoNCkkgc2hvdWxkIGhhdmUg
Zml4ZWQgdGhhdCBieSBzYXlpbmcgaXQgaXMgbm8gdG9wIG9mIHRoZSBtYWlubGluZSA1LjE1LXJj
MyBhcw0Kc2hvd24gb24gdGhlIGJvdHRvbToNCg0KPiBiYXNlLWNvbW1pdDogNTgxNmIzZTY1Nzdl
YWE2NzZjZWIwMGE4NDhmMGZkNjVmZTJhZGMyOQ0KDQpUaGFua3MsDQpDaGFuZw0KDQpQUy4gSSB3
aWxsIHJlcGx5IHRvIHlvdXIgY29tbWVudHMgb24gdjEwIHNob3J0bHkuDQpQUFMuIE15IGVhcmxp
ZXIgbWFpbCBzZWVtcyB0byBnbyB3cm9uZywgc29ycnku
