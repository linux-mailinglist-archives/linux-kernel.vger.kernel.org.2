Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E463F0D78
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 23:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhHRVix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 17:38:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:8868 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233971AbhHRVir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 17:38:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="196014997"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="196014997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 14:38:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="424381642"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2021 14:38:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 18 Aug 2021 14:38:10 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 14:38:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 18 Aug 2021 14:38:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 18 Aug 2021 14:38:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUWgh+QpO6UZ1ya1dRlG1bKR4G2Lqc5IdDg+bdSHT2kTLB1mygaZJAjZfD8cE5w5wl2sFwb+NUF61DEkjY7gZB6MbAjjB7G1Ku5R2mJ4oGPT2Gw1XXDnP8c5ZxmJBPZwupdPSaVSXwpfDa8USu0/YxehTtj7rqUMw2baTLh8XSiEOPesQi2NIHlZ2vewMkG4eX/1mNAUvXTJPvCOxNjcWAGyoYwGcT2DNktumLNZ6mS+xcDDt77XOft6KUnZNz6SHgStX8ASnptsGzt/bgVCtvb+ZbcOxoRKxEscsv/ZN2r1ev4kzby4wqiIj4O1fJhtMd/W3BKN6gcWgxxz2sZSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/UdN6FKHfKxnkxoretjUIh17dWJiZG3YLcXd1nrSUQ=;
 b=IgtMk8G1M1D+Z4quQ2G3p2zKuLFxO1Ubz2CG1YrQiIxsZWDqm51RdIngzFHW0E70KJh6HgeNYJ4vTWmTHmqxM5Mjxd7Gr0N3hWWy76SXjgp8Y6UcWCGzydCd0lYcqlVSjkEVeDfhyxenNDtPjbg4+sKW+CdL7Y66kXV1PyjpKjnc9VeZAB9UCncTY/fE9xQI28PYIx31ZeoHhhTiWyo2wK3nL/GVEPNaBg/EpxGPjUjl/BcF/IWXOWYVsggWE3hsMvRebEZCc0voiHk+4D6HjXiFqITn2etuDz9vLjtuBqM0epG466uGVQyighz8CODL6HTC5FJIzY4fO4qzkWIPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/UdN6FKHfKxnkxoretjUIh17dWJiZG3YLcXd1nrSUQ=;
 b=H1YIitPyuyuMd0fxeQVpjjP/KCSWkYaX6d93OfbjEfwyO5S+jB5+wiIBFF0ORfvQDnOP4lVlW2f9dJLSFnhT4TTa7hPfZdmjvKxE+LrH0LFzycbHpRL33j1vCFjvRfHVIfP3tXgs1MbJUKwYDF3zofl2IEDIIuemhEf88/xAcY8=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 21:37:58 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 21:37:58 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Topic: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Index: AQHXhVRyjpE4OXS+e0aKA8ZshCCgeqt5kHqAgAAPrgCAAAcJgIAAMaSAgAAJSACAAAXXAA==
Date:   Wed, 18 Aug 2021 21:37:58 +0000
Message-ID: <FC0176FB-32CD-4E7D-8AC7-17452E40FDFE@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
 <3181031.RqgVF4sTRC@tjmaciei-mobl5> <YR1HYRRN0HMTxXrw@zn.tnic>
 <BCC327C2-CF9F-4910-B626-315E515E9A3A@intel.com> <YR14zq2LaExjhFR+@zn.tnic>
In-Reply-To: <YR14zq2LaExjhFR+@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd146705-eb07-49ad-44f1-08d962907250
x-ms-traffictypediagnostic: PH0PR11MB4821:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB482118225AAB5EA4467B02A8D8FF9@PH0PR11MB4821.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mpfpsg5xvjV3L9YbIvLwcd8elSlBdXKLjpYXvd5y77DQ5DXBH2a+VZGzoZ3jaVEDAyjzbAA2lY0vfh2U9d7Td2HsA+dJxJkdAydP8rkfugaJd6xYYaMq//3sZcEbQjuG5y3oEoTSh2kV2nGqj06+UGOT4GcfPp6RC0ZU5AufdHS0BI1g+J8mYO4ZJsdfWg5C0166fBcJ5fYEO8uJ/Gxb4Xd1A3Qz+9XAAfSEqKg0RQnQLO1tYWR447pWM0VMibiOOCyY5q9M19EPFX4w36giUynflAMaNuPiy6KVrZVTmH08TyBGg/m0qmG8/D6zYyxwU50gSXMk80kTgQm5hn/hWLeRahNLuZtH7Pd6uROZYncpvwwrEVwQgAa6FTLuedjs+MuFVTEoiHEG6bqzyAy4gsWa2uWshiMCR7S9Gkw3meYG2rYEEs+Yksjrpdg3meZUEKVETzrHw96II4BIZ6AewL+SwzcWttQD7AbaEav6NHYQknZbvbf8UVcBb6fRQ/zuzRBvROOc2Mm8x2aiQU3XUJkJQ0KCd2EL75z2Stv/BUmd9H6bWyXV24dRDuX+7z06lDlnycCEEswePyEUHsjTaZHowp/e6J62D4nW3GqKmRfsjA3ZlaKIIZVhViZ37cCDy0y6GY4rsh2z56Fyhlt0+mqROUNUMPtuIYWs+4WFm6YEiTqIdyyec7+j0NQptGCu3HYE7m/d5PYaySv8stBj7+jpuV4CUkUOYxaB7lv20WKd5t1uCfBSa79637iPWm3q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(66446008)(2906002)(478600001)(86362001)(53546011)(186003)(38070700005)(64756008)(4744005)(6512007)(6506007)(66946007)(83380400001)(66476007)(66556008)(76116006)(122000001)(6916009)(38100700002)(36756003)(316002)(71200400001)(4326008)(33656002)(6486002)(54906003)(26005)(8676002)(8936002)(5660300002)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V05Va2N6Z1U2YS9oWlNRYzlBQk56MytjbVIxdUJzNEpQeFRDd1ZRc1JEOXk2?=
 =?utf-8?B?dzBCREFwOEVRK3pmUnVlSFBSQm95dnZWUkE2WjRPLzlLc0llS05tSDVLSjM5?=
 =?utf-8?B?Y01WRWRGOGlmKy9vNnNKVmFNd2FyWTlDYWw5cXhMZ09PTWd3UElGSTI1bEpB?=
 =?utf-8?B?L1Q3REUxRHo4WS9NV0NweUgvR0pBS2R3OGhic3lFVjc4bzhGMDMxTld2Tnh1?=
 =?utf-8?B?VXlOZXpxak1iWStlWEZqdm9TZ1p5dWl1eEpVL3pGTVNGYm5xNkJqUXI1dzh3?=
 =?utf-8?B?ZHFUdVNpeEJnZ2E3eDRDWG1tc0xGem5LNUcrd3JJaFkwdC93MGJKRVRGVG9z?=
 =?utf-8?B?Y1pBTVZEMWhnNGVqVWUvTGF5UGZTdmV6bmJmNjdUSHNCSXhQYkhxOXd6bjZQ?=
 =?utf-8?B?RTlhSjlpVjEraGIyY3FGaEVQeWdpKzh5Mzh1ZEZPOVZUWGFIaTZ2OXB6aExY?=
 =?utf-8?B?a091VTliN0U3MG1sTHNYUklPeVZtTkJ0YnUzK3c1RGh1UUVMeHRNZmw0NFBq?=
 =?utf-8?B?ZXRxamRWRVY3Q2M4VHltdlZVUkovTEtRVUVJMUNEWld2WVk4OFIvTnc2all6?=
 =?utf-8?B?bklGUXdRZVA4UndkK04xeGwwemdWRHJ1cUZkcjUwQ2diM2Y4M1VqSWFGWHlX?=
 =?utf-8?B?eXNUcHhZd0pvbXZIRG1qYkNrQmJDZkxQNkl6SGlidUEzcktKZm5BYUdlSzBW?=
 =?utf-8?B?REE0R1pSazY3T0ttdkNVbXlXZUhWbWdhTytualduZ2ZCcHp3SzZIcU5zQ084?=
 =?utf-8?B?TmttWHorTDBEaGxjeXA0cmlEMEVWanF0dzRiMlNWMGVra3A1UnFJQk51Nnpj?=
 =?utf-8?B?YURvVU8rTU9PTXpRSmNaVWpsSDRQemsxOEZNbUZwMkVqU0h1dGdFVEI2N1lH?=
 =?utf-8?B?ZlVIempONDkrbDlsSHR0RldZSFAvTVgyM29seEhzMkdpTVBGT3NrbnJLRUJm?=
 =?utf-8?B?MEJWeldHMkhDbWNkbFJoVFloYlYwVmtjcEV6TEtqaVFPbjFsUGFMbUNEVHZJ?=
 =?utf-8?B?Z0dSRUJlZE1yV2d5b3JabEVsWUxsdjFCeW85R01CZ3RCTkpxWEhUU0ViR1VI?=
 =?utf-8?B?SmZmRThwRFloUjVkalBVM0pMdG9PQlZiUmlLL3ZUNDJqUGVMVVljcTBxdElM?=
 =?utf-8?B?aGw4cFA1Tjc5UFVXWWtoWFU5TnF4eFpwaiswNGF0eWI0WGRVYWQzdjdqc2xN?=
 =?utf-8?B?djVkRW1pOVJnOHJUVzZYS1Q5d2FTV0xPRDVuWEF0emEvMEYvRkZNbnh2YVc2?=
 =?utf-8?B?azB5bjBiOGxXbk1uaHFucTJGNTNOSjhKd1BJOTJIM1VRT00yMXZhSGsyWEFD?=
 =?utf-8?B?YkFmZFFEVHc2K29KS1ZRYmt1ZjRNRXllNnN0dTQyUlpSZWdoMDMzWnNUUUFD?=
 =?utf-8?B?ZzQ1elYvcTQ4TjRINkpmazN0RzFLYkhRR3FlWWlNclkzV3M3dTRLbm1PQjQy?=
 =?utf-8?B?cjYxK2FOczZiRHhrRXlXMGVMcU4vdGtScDI0bDJMVnBhejZ0cVFiOU1SZlBH?=
 =?utf-8?B?aTI3U1Bra3JIbVNqdW5PdWJjdGZjZWdVTGxzdkxQcTdNWk5XOHh0cEQweGZv?=
 =?utf-8?B?ay96aHBzbitSdERPQU5DS1BJd1Bxem9mdEVIWVZtVWtScElEMVQyNisyazll?=
 =?utf-8?B?QUJQamJ5dGN2b0RoR3NrS3NFYnFRNnR0dU10enY2ZXN6Z3NGOTR5VmlEWkVN?=
 =?utf-8?B?SUU1aVVETHZuTU1uY1lnSm1OK3g3Yi9nU21zNC9wcXhYYndBamJXYzdIT1Vu?=
 =?utf-8?B?YUxzYWFKYUlxZnhTRVZoTGVyVjBJWmpGK3k0c1ZGbSsvakhMeXMwSFgzVkdB?=
 =?utf-8?B?c0lRQVgvb2hyeXZQR0dEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A24597A5C718046A8435F6D51CABA83@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd146705-eb07-49ad-44f1-08d962907250
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 21:37:58.0250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F50pBAjOSR+4/Ond0b4NTM6Or2cMPgzmIGzOdRClfrpSlMtcK8vS5EGrAmE5yfGx5qS9Q8BNh2lLxRBZPk2HzY6icdGPU+dxnBFuwFE+4+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDE4LCAyMDIxLCBhdCAxNDoxNywgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
IHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAxOCwgMjAyMSBhdCAwODo0Mzo1MFBNICswMDAwLCBCYWUs
IENoYW5nIFNlb2sgd3JvdGU6DQo+PiBNYXliZSBJ4oCZbSBtaXNzaW5nIHNvbWV0aGluZywgYnV0
IEkgd29uZGVyIHdoYXTigJlzIHRoZSBkaWZmZXJlbmNlDQo+PiBmcm9tIHJlYWRpbmcgWENSMC4N
Cj4gDQo+IFdueSwgYmVjYXVzZSBhZGRpbmcgYW5vdGhlciBwcmN0bCgpIGlzIHRvbyBkYW1uIGhh
cmQ/DQoNCldlbGwsIElJVUMsIG1lcmVseSBYR0VUQlYoMCkgaW4gdGhlIGtlcm5lbCBpbnN0ZWFk
IG9mIGZyb20gdXNlcnNwYWNlLg0KDQo+IFdoYXQgaWYgdGhpcyBtb2R1cyBvcGVyYW5kaSBvZiBm
ZWF0dXJlcyB1c2Vyc3BhY2UgY2FuIHVzZSB3aXRoIGtlcm5lbA0KPiBhc3Npc3RhbmNlIGJ1dCBu
ZWVkIGFuIGV4cGxpY2l0IHJlcXVlc3QgYW5kIGFyZSBvZmYgb3RoZXJ3aXNlLCBnZXRzDQo+IGV4
dGVuZGVkIGJleW9uZCBYU0FWRS1tYW5hZ2VkIGZlYXR1cmVzPw0KDQpXaGF0IGlmIGl0IG5ldmVy
IGhhcHBlbnM/IEl0IHdpbGwgYmUganVzdCB0aGUgc2FtZSBhcyBYR0VUQlYoMCkuIEkgdGhpbmsg
b24NCnRoZSBmbGlwIHNpZGUgdGhlcmUgaXMgYWxzbyBhIGJlbmVmaXQgb2YgbWFpbnRhaW5pbmcg
YSBzaW1wbGUgQVBJIGFzIHBvc3NpYmxlLg0KDQpUaGFua3MsDQpDaGFuZw==
