Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C015644DD24
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhKKViv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:38:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:32409 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234010AbhKKVit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:38:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="293840478"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="293840478"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 13:35:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="733415535"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga006.fm.intel.com with ESMTP; 11 Nov 2021 13:35:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 13:35:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 11 Nov 2021 13:35:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 11 Nov 2021 13:35:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnurrLIuKwXuYDH2MFmyGcSiVRIuVfXh+FNCR3VNlDsdlxGhyLolunFCRVwBNQNjJBcs7lwUI4OTOJg3C6apGZJZEGg6zamaQQaRABcKuWkud07zg3VNSQj99Wd85XbSKxdGMcVYwlw7LceI+4EyYSPY5EK8L5hTcOQkOYlxUUISUjHBd8DmIJiyvLdUzCgI4bVfFhEqow/63/KZZw4J3LUxR1CDiAKJzJCIcghi/CMA4pcyewswkQQwqpC16OR87ersBJ/34C3dTD+ZOkDRK/P2EnpefrIdkojWoV/oJgPVJKmXnKytQjACoyHZAUQVdJzJ7/AG3UYcUQ8DJSvciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Dw0DnEaacZ96UbJSqzq7t6MtFczVI2J3d7KInX0LYo=;
 b=iTNez939S2tNW+VzsycCJoOptp/nbrWQbS3ubR1m4m1VyM5DWWt3+gUTFEVLEG7aHU1qd7h2mSNyT0Mg5TQd+jXhL5E61iluRYKcub6DHTXt6mkiDLT0rKMu+sfV2ItbdDoHIn5QFiAaLvLGPVkeDVLeH0I+PkOs2SlR8CS4276/XSkhza8uIhvn+FG+ZtndkC/LMx7gUpLJHCt+AVbk+rycFkrXJloEvJD8MLmIAw7s7jMNx5dDy+MMkRFDXusS5FB8j1eBDFYRHhbWJ9qk4Hqb4/KkdDZz5sgN+8vApUro6PG/EIKuHjFhaLJjoauFbsGklPwYeXpKr7csVpkteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dw0DnEaacZ96UbJSqzq7t6MtFczVI2J3d7KInX0LYo=;
 b=H2Son01UCjF55o4ch2b4uZQoFgVSRsgZ4R9s7rXfAOagg/aqzAdUJO06uINKJSkU3ESz3asYlFMJJMqEFPxRa8jfWUJUlqZFv/rAU45OZ92NCRF745RVecqienEHdB2cexw/58hj0LbJGlWfU0KjmqDZWq13CdvgvPePiJ/cgpI=
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR11MB1391.namprd11.prod.outlook.com (2603:10b6:300:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.14; Thu, 11 Nov
 2021 21:35:56 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::bd76:b278:9392:fcd5]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::bd76:b278:9392:fcd5%3]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 21:35:56 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "Lutomirski, Andy" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH 4/4] x86/mm: replace GFP_ATOMIC with GFP_KERNEL for direct
 map allocations
Thread-Topic: [PATCH 4/4] x86/mm: replace GFP_ATOMIC with GFP_KERNEL for
 direct map allocations
Thread-Index: AQHX1uvEp8oHH7geiU+Ue+NRNU6yKav+2mAA
Date:   Thu, 11 Nov 2021 21:35:56 +0000
Message-ID: <5aee7bcdf49b1c6b8ee902dd2abd9220169c694b.camel@intel.com>
References: <20211111110241.25968-1-rppt@kernel.org>
         <20211111110241.25968-5-rppt@kernel.org>
In-Reply-To: <20211111110241.25968-5-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 588b59e0-0e05-44c6-6826-08d9a55b3f1d
x-ms-traffictypediagnostic: MWHPR11MB1391:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB139178826DE27C484CC8645DC9949@MWHPR11MB1391.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqDnRi2DWM1SmP9SeuZ0DsFLtFEjCoCUyyTpS16Z4ij3lFGldubFgiPwpoiq7lZC2YurmAN/wPp7mQKmVjOmXHdVVetLxPnq0QPbUUjXkALKhtqbepRWW3+HC/fU+SRcofxg6kF4UX5uuXQ0QfoI4TvRxMxuUxWaryvY5WL+2oTDw0SFVXfuhmqD3O7+V6sSjWoqjVmz23RbMEwMoEJ8G+RGRMdseqgIbQH8NNGK85g5IPBLRSaGjXGp1U8P+y3Ro+UQYOhn85CwHrifEccdr0STpRZDs6sJOnpMoK3pVXh3YC91w0ouDI5F36fkLWKm2nY62e/wuewXI4ABNKErtT9OHRW9tC3r/QrjXd6VZfgK/Al+75ZgMFYQJq1pC6X0Inu7qFI9xSGldcQtFqz4nvac1sUIdulXUERJvFhirmjHYoiucvjvcibuXpXctLkd24uraNCYQQeBnhBMfvL2X8rg4J7AdLz2fRWOy1VlN1YgZm6JkOKGOOaqA5FD+Wl7PegG9QjRUiezkQhIiPRQ0QAmW4kBVza1NM2eoj1qev6Zy5jU+mHPzSUKfqt46dB1RGe/Nr0Lf5XiLkHNKciLnd4Tjhr2+CzC2LbP7YWAenZxVmr/E6X/SEU7wbpb6HkcGkNvuNCKEh1/RzCTebdOccu0HMmja4EQ+WBBNmGwgetPwpablfAU7PCEplSbebmjudN9k5TYmGToYvQUSZ+EGXyEjHEbQatb1Ck342tnBMc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(186003)(66946007)(508600001)(8936002)(6506007)(36756003)(4001150100001)(122000001)(8676002)(4326008)(2616005)(38070700005)(83380400001)(38100700002)(5660300002)(64756008)(6512007)(82960400001)(316002)(6486002)(86362001)(110136005)(54906003)(7416002)(76116006)(66556008)(66476007)(26005)(2906002)(66446008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHNBMnhJbmdQK2crTEkzZktUVXc1MzZFVVE0aTEwRWI5aUVjeGZlcnRTWk1l?=
 =?utf-8?B?Q3lEaUkyZFBPQ3paMXpoYXZiTGoyRFl2RU5yd2FWQ3F1WVRmRWtHTlF1c1My?=
 =?utf-8?B?SUhrS0hUTDlCM1lXcnFYaGNBcmpISUNqZkpSU2pjSmxkMXp5YTBMKzJnYTll?=
 =?utf-8?B?REZqWmRDL3NMbkx1QXJDRGJRZlZ2eUR1ZU1TWCsyejdja0RCRExtaUR5R2FX?=
 =?utf-8?B?dnptb2J0ejVsMkJoYVdTTDBRL1pxK1l2c1lDc3FYWEIvOW5sM3ZWb255UnN1?=
 =?utf-8?B?cVBFVURTODlFWGlZK2FBMFN5dUdrcUhZMk5hQ0k4Z2kvVXIyVEgvakFwNDFO?=
 =?utf-8?B?RVBuZDRYZS9pY2laUW9PYUZ6WDQ0NXJTdENPL0JPYU5HTjhrRFFYQUUvY0ls?=
 =?utf-8?B?b1lxUGtJWG5mMWpUUHh3UzhuYWp0cmVDNVNCS0lKT2RoeWxRNkUyQm9wdjlN?=
 =?utf-8?B?RFRacE5QSXJvQ2JudlZ6b1F2bjJPbHNLM3oyclExR2FRTFpyZ1hVUE5GUkZL?=
 =?utf-8?B?Smpad3dDNTZYWEZDcEFxWXU5Y2MwUjNPUVozV05ic2VsdWpad3Vtd0tqVit2?=
 =?utf-8?B?NWZ1MGFYM01CSU1iejNJQlJZUlkrOHhsbHpvL2tLTTl0MSt0RU5ZNVBUQWE0?=
 =?utf-8?B?SHNTQk01N05CaVFKS3lSYWNxUnpDZUIwL3ZVcjVEQ3FBbWRLRkpuVXhwc3dp?=
 =?utf-8?B?MlBKejYySERtalhSVk1HYUF4M2hFTm01T0dEb1VKYWFLbG9sTkJ5V3JTNHhD?=
 =?utf-8?B?eUJJR3J6d2ZwU0RmQ0hId1NOVmkyN0ttMmpSN05OY3J4Q0hDbGJiNllFWm1w?=
 =?utf-8?B?RjRkN0hoRG03UUJsZW00ZnQ1RTA1Qzg0VFV6dW5HYlZSc2R2bVhBd1NJcUJU?=
 =?utf-8?B?L2FTM29nQndIZzFZVUlMc3BjcU5YRGRDcHB3Um1MckVQdlpoOFZOWThVTU5j?=
 =?utf-8?B?YUZuU21USDIycUVMRmpudFBQZ0xSS3dsY2M5QXRYc00xdnJGWFRXZnUza3cr?=
 =?utf-8?B?eWs3TXFXVzd1Y2ZmUDN5MWVBMUR2cVVtR0Npb1l5czR4eW44Wlh5UE9ZdXUx?=
 =?utf-8?B?T3hnYUM3T2txdkJLemlQcGNtczFDT1BFZGE0QmV2S1EveWIwcjk2RElvOFJw?=
 =?utf-8?B?YkcxazFjSjVTajErSnI1OHdscjFaenhNZk96NG5RZGdnMmlBdzRFU0JHbFhU?=
 =?utf-8?B?OC9vVzZLM0FLeHY4Q0NGekg2ZTBnd2lNTlEveFVNaGx1WXNqdzhWbVpZZEpj?=
 =?utf-8?B?VjIxeW53VHcrQWMzSVdmbmhWbDFKWmdRa3pMWEdxRXFpV25Ga2xYQVFBL1VE?=
 =?utf-8?B?NGdNQTc2a3RQMmR5aDZIQ3VnUkJ5NmUvb092U3B3NW1relNzdllpZGRyVitk?=
 =?utf-8?B?QkJ1MnVxMWova21nRHBIbUtubkMwTldJL3ZCWnVnWTI4MHRmTVNWRzdwSTh4?=
 =?utf-8?B?SndaajVzR0RNOHhOWEQ3WmFVVE1iMU1NQ2IzRXc3Sld6Y2Exb3hVYkZVTlRE?=
 =?utf-8?B?QVZqelAxMlNSaXQvSm5DQmg3SkJlTEJjQXRFWURuSGZnWTIzWEJ0S1BHWDZB?=
 =?utf-8?B?dDIwVEovMzVwYWhiRzduSHZiRHRNZS9qd0I1WWxoSU8zc2FRVXVVR0JsK200?=
 =?utf-8?B?NWw5WWpyblpqWmhHcFU3TVRxYTB6d0p1bkw0bGhla05STldnOXJOUlNkMGlT?=
 =?utf-8?B?SCtMRnk3Zm5xZFpHcERzMGZ1Q3k5Yms3YjY2OGpoQVdCY0Y2NVlPU2ZIaFhq?=
 =?utf-8?B?Q2tNK2ZtL0RxeGE5dHd0cTQ4Y0lyNFFscVE5TU5sK2xhMFA1YUI0V3RmRFEz?=
 =?utf-8?B?OVBiNUdsMDQyamJEdUZLOGp5U1BkRlJFc1hkdThzamxza1lWTEFhTDZFZGxh?=
 =?utf-8?B?YkFuTVAvMHhLTmtqbWRwM0lUQnlFbGF5RCtRTzM3VGMwNjkwVHUyUkRRKzJ4?=
 =?utf-8?B?OVk5UTEvaWtkbGlRczVwOEJ1QzJ3bVBXY1JXUG9wTmhrOEZISTJwSTN5ZFBE?=
 =?utf-8?B?MjlDTDJzeGJlR2dRU2JUVUtud2w5QzJBb1Z6cGlvYTVVQ1greURiNVIvbE9M?=
 =?utf-8?B?WWNTelRtdzhJZnZlL1cxbWlCaGhOclJnUXh5bWxTclNFZUVyRXQyRmNjTzJz?=
 =?utf-8?B?aGRmRmNmZEQrUSs1Qkk4YUNFM0FraXVUQ092aVpJWksvbGkrcFloL0wxRm1x?=
 =?utf-8?B?NlA1TnZxT3VLNzJpQUh2UHlSenV3SDBPaVJKZnUxNndPdzlidmd1SDJvcDU4?=
 =?utf-8?Q?28MuWG/np32nP00P7y1Xc0P7QDQa2pjCblPD0JATsA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F06AF5C79801F449DC8A43261F00311@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588b59e0-0e05-44c6-6826-08d9a55b3f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 21:35:56.8554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llrCymRqYV4KCtLq8tFHMfmZvManJLOLKE5XfGiiJHu6MF4tpW5z6tdZwkqHLA93Q0tt0YkymAOuQcQJWt52jHNfa+p5Re8n5yPfITIOtqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1391
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTExLTExIGF0IDEzOjAyICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBUaGUgYWxsb2NhdGlvbnMgb2YgdGhlIGRpcmVjdCBtYXAgcGFnZXMgYXJlIG1vc3RseSBoYXBw
ZW4gdmVyeSBlYXJseQ0KPiBkdXJpbmcNCj4gdGhlIHN5c3RlbSBib290IGFuZCB0aGV5IHVzZSBl
aXRoZXIgdGhlIHBhZ2UgdGFibGUgY2FjaGUgaW4gYnJrIGFyZWENCj4gb2YgYnNzDQo+IG9yIG1l
bWJsb2NrLg0KPiANCj4gVGhlIGZldyBjYWxsZXJzIHRoYXQgZWZmZWN0aXZlbHkgdXNlIHBhZ2Ug
YWxsb2NhdG9yIGZvciB0aGUgZGlyZWN0DQo+IG1hcA0KPiB1cGRhdGVzIGFyZSBnYXJ0X2lvbW11
X2luaXQoKSBhbmQgbWVtb3J5IGhvdHBsdWcuIE5laXRoZXIgb2YgdGhlbQ0KPiBoYXBwZW4gaW4N
Cj4gYW4gYXRvbWljIGNvbnRleHQgc28gdGhlcmUgaXMgbm8gcmVhc29uIHRvIHVzZSBHRlBfQVRP
TUlDIGZvciB0aGVzZQ0KPiBhbGxvY2F0aW9ucy4NCg0KVGhlcmUgYXJlIHNvbWUgb3RoZXIgcGxh
Y2VzIHdoZXJlIHRoZXNlIHBhdGhzIGNvdWxkIGdldCB0cmlnZ2VyZWQuDQphbGxvY19sb3dfcGFn
ZXMoKSBnZXRzIGNhbGxlZCBieSBhIGJ1bmNoIG9mIG1lbXJlbWFwX3BhZ2VzKCkgY2FsbGVycy4N
CnNwcF9nZXRwYWdlKCkgZ2V0cyBjYWxsZWQgZnJvbSB0aGUgc2V0X2ZpeG1hcCgpIGZhbWlseSBv
ZiBmdW5jdGlvbnMuIEkNCmd1ZXNzIHlvdSBhcmUgc2F5aW5nIHRob3NlIHNob3VsZCBub3QgZW5k
IHVwIHRyaWdnZXJpbmcgYW4gYWxsb2NhdGlvbg0KcG9zdC1hZnRlcl9ib290bWVtPw0KDQpJIHdl
bnQgYWhlYWQgYW5kIGRpZCBhIHNlYXJjaCwgYW5kIGZvdW5kIHRoaXMgZ2V0dGluZyBjYWxsZWQg
aW4gYSB0aW1lcg0KZGVsYXk6DQpnaGVzX3BvbGxfZnVuYygpDQogIHNwaW5fbG9ja19pcnFzYXZl
KCkNCiAgZ2hlc19wcm9jKCkNCiAgICBnaGVzX3JlYWRfZXN0YXR1cygpDQogICAgICBfX2doZXNf
cmVhZF9lc3RhdHVzKCkNCiAgICAgICAgZ2hlc19jb3B5X3RvZnJvbV9waHlzKCkNCiAgICAgICAg
ICBnaGVzX21hcCgpDQogICAgICAgICAgICBfX3NldF9maXhtYXAoKQ0KICAgICAgICAgICAgICAu
Li5zcHBfZ2V0cGFnZSgpPw0KDQpJ4oCZbSBub3Qgc3VyZSBpZiBpdOKAmXMgcG9zc2libGUgdG8g
aGl0LCBidXQgcG90ZW50aWFsbHkgaXQgY291bGQgc3BsYXQNCmFib3V0IG5vdCBiZWluZyBhYmxl
IHRvIHNsZWVwPyBJdCB3b3VsZCBkZXBlbmQgb24gc29tZXRoaW5nIGVsc2Ugbm90DQphbHJlYWR5
IG1hcHBpbmcgdGhlIG5lZWRlZCBmaXhtYXAgcHRlLCB3aGljaCBtYXliZSB3b3VsZCBuZXZlciBo
YXBwZW4uDQpJdCBzZWVtcyBhIGxpdHRsZSByaWNrZXR5IHRob3VnaC4NCg0KRm9yIGFsbG9jX2xv
d19wYWdlcygpLCBJIG5vdGljZWQgdGhlIGNhbGxlcnMgZG9u4oCZdCBjaGVjayBmb3IgYWxsb2Nh
dGlvbg0KZmFpbHVyZS4gSSdtIGEgbGl0dGxlIHN1cnByaXNlZCB0aGF0IHRoZXJlIGhhdmVuJ3Qg
YmVlbiByZXBvcnRzIG9mIHRoZQ0KYWxsb2NhdGlvbiBmYWlsaW5nLCBiZWNhdXNlIHRoZXNlIG9w
ZXJhdGlvbnMgY291bGQgcmVzdWx0IGluIGEgbG90IG1vcmUNCnBhZ2VzIGdldHRpbmcgYWxsb2Nh
dGVkIHdheSBwYXN0IGJvb3QsIGFuZCBmYWlsdXJlIGNhdXNlcyBhIE5VTEwNCnBvaW50ZXIgZGVy
ZWZlcmVuY2UuDQoNCkkgY2hlY2tlZCBvdmVyIHRoZSBhbGxvY19sb3dfcGFnZXMoKSBjYWxsZXJz
IGFuZCBJIGRpZG7igJl0IHNlZSBhbnkNCnByb2JsZW1zIHJlbW92aW5nIEdGUF9BVE9NSUMsIGJ1
dCBJIHdvbmRlciBpZiBpdCBzaG91bGQgdHJ5IGhhcmRlciB0bw0KYWxsb2NhdGUuIE9yIHByb3Bl
cmx5IGNoZWNrIGZvciBhbGxvY2F0aW9uIGZhaWx1cmUgaW4gdGhlIGNhbGxlcnMsIHRvDQpwcmV2
ZW50IHByZS1leGlzdGluZyByaXNrIG9mIGNyYXNoLiBHRlBfS0VSTkVMIGRvZXNu4oCZdCBsb29r
IHRvIG1ha2UgaXQNCmFueSB3b3JzZSB0aG91Z2gsIGFuZCBJIGd1ZXNzIHByb2JhYmx5IHNsaWdo
dGx5IGxlc3MgbGlrZWx5IHRvIGNyYXNoLg0K
