Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E944DCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhKKUtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:49:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:55115 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232970AbhKKUt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:49:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="213736400"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="213736400"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 12:46:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="534532758"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 11 Nov 2021 12:46:38 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 12:46:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 11 Nov 2021 12:46:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 11 Nov 2021 12:46:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoANeZ6w5aPLjvPMiuUxLaYORC2oQbQg3P4jFnWIpn9vYHGYJsKpGCFeKmy4streqk5M+hoNkPcaT8Qk2yYD5TS6LB4YUDpQ/Z5nbYfLVNzdhDy0Rb2qsFuXpnwnKyFtKdTrMAFv9o0f3u6Xjm0AaxekwP5hdodl1P0YQ0Eet7ncDE0a64PZypQiwSvD/8yqdLty/QE6pZjn6FEwwWRoPsn5wCwfPnKHudhqnRoP8wAZXxUExGLKI9+7BMIAnzK9JqjFacD3q1ebFcpSmvi8wDgaQMxkNmbSoAlXU0DdziVkMNsbZ8dyco39qd4NCAKRb137dqNpTNFp2UHs4qP2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5amLp3anh7iZP0O0KkHuqHoY+CIXkiKqUiTbGorBWc=;
 b=AZHf0edP4ceqXDU0jZMAUUUhQ8qg6KWJenvwoOw4xO6O9brbtE2Waw8zZI4n6EHxVlnEarBaXtj5eL5vSa0Ibmy7m6GaxRz55TL/elJ0EhaqRpHCu1PFuSuTGhqnXapHeHF/AzjiS50tDdYM66/yGZdL5OxRyfPZCmXDED7MXhGRONOR0KpGtw9aRWkrSo9HPe+mSHFgfzFio2e8qH3eN8jWNVVsHuTKV2qUsVw3cwigG1KR/s660zK7/X6nhfGAb4PHgj3u5oiE1ByWxEKfQIdmno13iiJONkJYoLlFnXZhkRz4ZJXNu9rX8nzV8FbK8zzjKpyjnXX6DaoBVW1czQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5amLp3anh7iZP0O0KkHuqHoY+CIXkiKqUiTbGorBWc=;
 b=ObL2/dxFflLk7NSF/RIymBuA7pjelbpUDsbNQCaMUJ3DmQIb/nXsbo+20sQ94/XPLZYaLzJq2TshPnOQAhd2fCv4RIPqMD0TMYyQtApmnrqxgusYyJn4Eyg/dm6oUM1Zpz29/RI8SDSXi7Erq5Ciut4rueGZr9T02lqcRBUioKk=
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR11MB1453.namprd11.prod.outlook.com (2603:10b6:301:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Thu, 11 Nov
 2021 20:46:32 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::bd76:b278:9392:fcd5]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::bd76:b278:9392:fcd5%3]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 20:46:32 +0000
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
Subject: Re: [PATCH 1/4] x86/mm: make init_trampoline_kaslr() __init
Thread-Topic: [PATCH 1/4] x86/mm: make init_trampoline_kaslr() __init
Thread-Index: AQHX1uu155zzKWS+3UqqnfmtQWuHdav+zJKA
Date:   Thu, 11 Nov 2021 20:46:32 +0000
Message-ID: <f7c34899871115498a4737c13ff52be2019920d5.camel@intel.com>
References: <20211111110241.25968-1-rppt@kernel.org>
         <20211111110241.25968-2-rppt@kernel.org>
In-Reply-To: <20211111110241.25968-2-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8500b8d4-38ce-4927-9b2b-08d9a5545844
x-ms-traffictypediagnostic: MWHPR11MB1453:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB1453B3982A373DAE19DA9209C9949@MWHPR11MB1453.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tgy6XdPp+9GXGxJxC2RSETWLjvBUDqJY5ZERRLgHlNL0Q3PbuxJW9r+sptyfspOZXz477uqA2ztgAQ8qiSApnfLGchH18dBOLItj2ErbMdgVjvB7Knt1YGt87l+lj3hxJOc3M16YgrpUoc++btpRedltDqIk6BxTMcqL20QekrY2cpJWLbd66xRB77vTN5GwHshAnOsbTONIWZlqpEkeUgCQH4keiVDSu/xbOadSwVsnkMOgR9T+eNmJSPWQSt1VKot7ZrlUyMuZKN4F4xFsD9QKWJRbpxgTeacH+APGsJOFG3Mnf9IF8mkHL1rHz9yyYKuOv+dA+ABh5XIGTh9XRDjvt+lYGqQYZaaFx58mG9yktND2N3PoZOtid4CYRSdRntZkkj6tMW9+CdHDFthaF00Q5rVWf5sVl1caPLQA4zEpJ3Xci0DvSmGMqOqASlq8b24qRe75AUMKCTMaQ09chL5GT3ebMaAbjvvne629ZiJlhApIbsxszWPvrHbNu2F+mhC7GGIkbSpMw9HNqV77u+RmDgNihPwACAuoY6/2wFd1QM33S+NIYvdCwgpj1GLwyk5UUkqGtgH7TBAdUq8uLW1VhvEfSwzP9gbPNkI8WhMa5s3sjIykdxXn1LHHyc6+62eEgEaz9Dkll0G4IN1HJ4U0aRclK0G0SDhnTB6YIaUvNe80AuTQzfzlUOZLX5B3ssPggpAdH2nHwKOdaxj20r56Z2hNAFqpDfsGQoLPpnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2616005)(36756003)(6512007)(5660300002)(508600001)(83380400001)(4326008)(4744005)(26005)(38070700005)(6486002)(6506007)(2906002)(66946007)(86362001)(110136005)(82960400001)(4001150100001)(316002)(54906003)(8676002)(66556008)(66446008)(64756008)(122000001)(7416002)(8936002)(76116006)(66476007)(71200400001)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzkzbGdhWVVsdGRlRmMzQWNFRjExVnV2cjR0S01UbG9tQjQ0Y3lDOW1VbTdZ?=
 =?utf-8?B?bWw4bUtiVTN3bmFEZllVWmFZcUxCMXpYNUUxb21zdURuR2V0dEE1RzhWRURC?=
 =?utf-8?B?ajV4UXcyUUZpcVNrRFRhZ3oyK3NQNnNmdGtNQTdPdlA2Q3ZxZmgyQ3VGNDRF?=
 =?utf-8?B?ejJ2aTVsR2ZPN1laZnNMWjIzZFEvZCtMdGNOZmt0ZGoycTd6MmY0cUN3MWMr?=
 =?utf-8?B?TDRvZS9YcTYwV3R2RG1nT0VqenpqcG0wTnJIOXBCcGFHS1B2M1A0cm9JeGZ2?=
 =?utf-8?B?Ly9LMUhMdlV1cjFkenY5dEpWM2tRL1RvRks2UXJLOG9wUTBYSXIxcHRXYXA2?=
 =?utf-8?B?cTg5NE5penZ6dVB3aTJqMmpjWlJBSUNlanJwREZYcWV4L0hVbU40REJJaEtz?=
 =?utf-8?B?OGFLdXhmRkh4RGhkSWpyNDRlb1lDQnlmcllOeStYZWlrVVlsb2pheDVtcUl5?=
 =?utf-8?B?WFJLNkplZE9UY2NPdDA5YWN3cERpWUkwNXJ2bm5PQXhvMllzOG05QnlUR1lM?=
 =?utf-8?B?bmNRMUJKNU9EQjFyakNNd0N3b2FtUDdScDJYbUluZktiNjJkK01TbVVJUC80?=
 =?utf-8?B?UWRzYmZJbnZGeDhRRU1DY2RMVVY1SmdTZHd5Sm1BNHpjWmxWaEdtaG5jZE9I?=
 =?utf-8?B?WGJPb0Npd256SVdkNHUyQzd5QStESXBCWGFsa05Ea0ZGNS8rcmlmVzZuOXhz?=
 =?utf-8?B?eFE3dW9sb0VSNWZpSnBRdjRtMGZVSVhoZTJ5NnUyeEI2TjY4NVFFdTBaUzJX?=
 =?utf-8?B?Q2ZsVVNqTENScFNOOXBtMWZueFlLclA4MGF3NGc3ZUkzQ1lIUHhhTVFFK1N1?=
 =?utf-8?B?cmg0S1B1MWpndEU3R1RSOFpkcjBUaWVXU1BuUExiSjVJSzhoMVJ3bmJuelFl?=
 =?utf-8?B?ZkY3RHpIb1JFOXpRSlBHTkRzcDN4T0huWjZDUUtaa2UyVVVJSkRLWGYydU5B?=
 =?utf-8?B?WmRvS0lCU0VOUUNLdm9CUFM5TUh6LzBzYTdDUEdiL0o4NHlyWDdNSWxIa2Ey?=
 =?utf-8?B?SXRFb0xzRk8vRUliQXE3Q2RieTdqSXlMYUtWMGowaE1ORi9KS1hXKzFiTFlk?=
 =?utf-8?B?clBHcy9FVG1vQWY3TXRIeGhkZXg4TUQ1VkFvMU5Qd3BBNHROQ0lUUXFlaC9h?=
 =?utf-8?B?VExmNlFDTVIveEFhL2ljZHFtOXpQS1hhYnhBckg5UzVoV1hJUDNpdFBkQmU3?=
 =?utf-8?B?dFYxaVpZY0QvRmVyUGtISzJrcGc2cC9oZm1zeTkwK2xSOVUwa29KOGI3VzdG?=
 =?utf-8?B?WXJOYURIOFgyRXFEY0ZnZWVsVHdzRW1LVy83U3U2U0NUWVQ5dC9EUTFrLzg1?=
 =?utf-8?B?M2NFTXJONGtFWXpYRFJ4eHF5YWRRY1ZoMk9aQzZlbFprR01WUHg4ZzIvVitn?=
 =?utf-8?B?YXdubWV4NE81U0xjZlMrY09FS0xCRkEvWmlvcVpFQ2tUOWt2VEJIVkhjaHg3?=
 =?utf-8?B?dFVJa0tDeG4ySWZRNm9UM2xmTy9FeDZQTVltdjJRY1dsWmc5LzU5VGV5WWpM?=
 =?utf-8?B?WlRTS0ZpM3VyMHgyNDQ2UVJOVGxCUGw0Wk05OVllNnlJTlQydzM3MXg1cjY5?=
 =?utf-8?B?cE12dlptQU1pWFg4eUN2b3Nkb3RldDNFUy95d0RBV1dXTVdIaklvZmZNeVAw?=
 =?utf-8?B?TVJha1AvalRXR2l0YnBvUEtIbHFSM29CbGg4WHVmNVptRFJxTzFsYjJvdzFM?=
 =?utf-8?B?cjNoUHBOQ2dQdS9sdDJIaHo5d1NoUGJ5ZnVOM2hoK0t0cHJLTnZkZGRiRkdF?=
 =?utf-8?B?VmdnMU0rRGo1Y1FSYmIyUUlTV1lJWTFYTHEzVmxOcG10V08vTzV0RWM5c0o5?=
 =?utf-8?B?VjYraGRlZ1BqRGhOSVQrWm1TK2JVQVJ0STlDdjh6L1RGd2pLbThBQmhJNUpW?=
 =?utf-8?B?QzFKd1dxb1l0U01uYkRjN3h2a212QkpVZDVMTEFHSHlCeTFtOTJmQ0V2WWVh?=
 =?utf-8?B?MkhURW8yZHJheEF1cWozYVhOWEd4N0Y3Uis3dGVtSlNLYkMxMVFmc1NYNkhU?=
 =?utf-8?B?dW4xcjVaVGJPZ1AwUno5bXFiamw4MFJRWTBmcFk0NlNkSUdxTmJCbFl3VCs1?=
 =?utf-8?B?a0QyWWJnYzRvNVk4WW4raktwbnRZeS9sQ1J2OE9jaXcwVWpScFJEV0dLY2s2?=
 =?utf-8?B?KzFZaXExN1B4c1c3Rmt0MHFnektWZFFiclhMRzkyV2xUbkU0R1pQSjhGbE12?=
 =?utf-8?B?TEJwblljQU44MFhkUDVUU2ZjRllTOUN6dUZDOUR2amxCRkVjTGVPZ3VBSjVp?=
 =?utf-8?Q?HFrxwzkh8y19MPOpTHmckFuWnLBnB5CNX8sSZ1QrPk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37B97A010BD0C042AE5B1CC7172CCF95@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8500b8d4-38ce-4927-9b2b-08d9a5545844
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 20:46:32.5613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrvZIccJvEpfho5EJr1K2m08Sn3eXxhGME//vDlVKdnlFaMHbRblyFYEar6UuO9hl+MreVsWDIFnD56HFhYXycunWEK4MyEc+iK+Vv43AVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1453
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTExLTExIGF0IDEzOjAyICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBGcm9tOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+IA0KPiBpbml0X3Ry
YW1wb2xpbmVfa2FzbHIoKSBpcyBfX21lbWluaXQgYWx0aG91Z2ggaXQgaXMgb25seSBjYWxsZWQg
YnkNCj4gX19pbml0DQo+IGZ1bmN0aW9uIGluaXRfdHJhbXBvbGluZSgpLg0KPiANCj4gTWFrZSBp
bml0X3RyYW1wb2xpbmVfa2FzbHIoKSBfX2luaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWtl
IFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vj
b21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQoNCj4gLS0tDQo+ICBhcmNoL3g4Ni9t
bS9rYXNsci5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0va2FzbHIuYyBiL2FyY2gv
eDg2L21tL2thc2xyLmMNCj4gaW5kZXggNTU3ZjBmZTI1ZGZmLi5kNDBiYjRmZWVkYTMgMTAwNjQ0
DQo+IC0tLSBhL2FyY2gveDg2L21tL2thc2xyLmMNCj4gKysrIGIvYXJjaC94ODYvbW0va2FzbHIu
Yw0KPiBAQCAtMTM4LDcgKzEzOCw3IEBAIHZvaWQgX19pbml0IGtlcm5lbF9yYW5kb21pemVfbWVt
b3J5KHZvaWQpDQo+ICAJfQ0KPiAgfQ0KPiAgDQo+IC12b2lkIF9fbWVtaW5pdCBpbml0X3RyYW1w
b2xpbmVfa2FzbHIodm9pZCkNCj4gK3ZvaWQgX19pbml0IGluaXRfdHJhbXBvbGluZV9rYXNscih2
b2lkKQ0KPiAgew0KPiAgCXB1ZF90ICpwdWRfcGFnZV90cmFtcCwgKnB1ZCwgKnB1ZF90cmFtcDsN
Cj4gIAlwNGRfdCAqcDRkX3BhZ2VfdHJhbXAsICpwNGQsICpwNGRfdHJhbXA7DQo=
