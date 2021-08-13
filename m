Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818E83EBCA5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 21:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhHMTo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:44:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:59474 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhHMToZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:44:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="202776782"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="202776782"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 12:43:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="422953313"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 13 Aug 2021 12:43:56 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 13 Aug 2021 12:43:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 13 Aug 2021 12:43:56 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 13 Aug 2021 12:43:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNXW9jqIvpEF1v+1LoUSMDnWVdEDBx7y7pgqJxkwDnCrS+7ZsU9sX2w9971wmLnxwXxaTKKAXqQ8QbYr7yk0OWq7L8Ww22TvO6/gBXIuitvZtL18999jZs+APw5BJi2+A64DSc5eoyuB0kZBGuINvc+Rhuwmrrasu1VRwo6hVkVBlM9Sxp5Fbau49EcgS5eBsY2kBRD96SxCLRkW4vxQljK4bnJeAorubEGgl2HeaR3HIyxnosswMPZ+Zdgha267gkyXdA8MGQsQM0huCp1o45cctrnrAYNyvVQotYf2YPjqDi21mypH0tTnhtXwKBOznGdjylmH6k+DGLBoLBQzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ii8dymLCoW6i6XaFUeOP60Kr0AkQMbh0AjqoNhru8Q=;
 b=YlP0aJxn8TeIgSVvoMP5IQLaYRXZKRmlMv1cpdT5vkpp8WoZYAQWI6fcAhiFMc6RwYvfIhy98XE4Gu72zSGIXYjVs40XlK6C7cHzur0zIey7AJLKXp/IBCBcohHjRmuRPGp7fXfIglLADDVNzd97c0QQumyAbBBqConHcGkU4Teg1VhPYuB4yL5poMytwOqp8O8216rhIB1iEIy1xY8LCimR/puy/Pq+6pGTmtvSmevgsZkFDB57FCF+/unsKRWLZX3nvWQtjHTGNy73dBeAkPn7UXaXXRNn2yex8owgtcKwGv1n4Btas/rvyGLbcKMTRR7HOjf611PYaIyVVhUtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ii8dymLCoW6i6XaFUeOP60Kr0AkQMbh0AjqoNhru8Q=;
 b=M4563RrrdLMcJeM6B7q8Z1OgANuyQiEXCueOlxyCoHxCtjBRa41JWb93LXSeMTaaOsAMLolM99KzWuRkGETPdYwQG1akd1FF4r4OcmDADNO8bd8j2WtNMvzlmUsJS92MgBsqYDtdOSREVbvkqqFKkdIf25OPHUS5rKVIyoVGreE=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 19:43:54 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 19:43:54 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Topic: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Index: AQHXhVRxstI5EaBny0+yAHwtQ/jrKKtwWl6AgADOwYCAACF+gIAAoc+A
Date:   Fri, 13 Aug 2021 19:43:53 +0000
Message-ID: <2B279B5F-ACF2-46F2-9259-684419A57BDF@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com> <YRV6M1I/GMXwuJqW@zn.tnic>
 <2BF12EDA-89F0-40F7-B63E-50ADD0262164@intel.com> <YRZDu2Rk+KdRhh1U@zn.tnic>
In-Reply-To: <YRZDu2Rk+KdRhh1U@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd639967-89cd-4adb-1842-08d95e92aed8
x-ms-traffictypediagnostic: PH0PR11MB5109:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB510961764E17019207B46337D8FA9@PH0PR11MB5109.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MlsG+y+yzD9eUXKTrWHK/RNzUSaVDzCWO2JVRBB0XL8eiMpMzCBPoOskvRT+7f+artX2rGfF+6v1o4wLzWTeGyyj8fe+tFXjU90zoq5d5U2cBQDSV9RYDljn85r+2ZP4SQBZkRSwGUHkCqDfk5zG7Ti9POaRVpw6uIEVRyot0U6Y5ge0HhSEcMhj9yT3b+4v5UVdeO5p2OSJS/JlkOxJg3kE5MRP3l1LAc8D+Fxsxh90Jo2IImVSuJMHKo4p7Oz56z4DyjZHJifCbRdvK3VnYUVCqKPNyzaWUuBI32ldf+EypsRBuYkuVRiMpHkq3lmZkP2DIfXKWd6ir8hAfLVWyUlS/rnOtL0MrlUNcltnvCy3bS8hEx5/uMT53UHtBNkkJRelKM1QtovHiwLjgymclf9RMGCq0xwhI3m3zYbfzDaqxQqM7Tb5LWUKHNCbnaBC+CfFTYYGJdYinNtT4NCsWoEmTwxvv8I2MlU3Tf1ul3iPc1qx1zuCZGUytcMD2is4I2tAYxcbt0xbccYPtJzCAWhU2Kr5NcVJGLsO9a7mk5pzOrddOYcBKBhQd/zlzA9uI4q7cfgDfoBb/o95By9ib+Q5OjPYMQF92eBh7/f200g7Qdhe1LfZMug7gV1dbWqv9UEP+FX8vggeOB8KuUiHnX6V2Emx+pZ40fXkDU7NUBUHRMDyyX2xrKUt04V3UD7aUAIvp9JRJE+y9XpbpIpG8k0W2ao7+oM05gO6pv7lI6xyQ8GPfFFMJVvJbegvC0u6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(8676002)(8936002)(2616005)(5660300002)(33656002)(4326008)(38070700005)(6506007)(6486002)(6512007)(186003)(83380400001)(26005)(66476007)(66946007)(64756008)(53546011)(66446008)(122000001)(6916009)(66556008)(54906003)(36756003)(76116006)(38100700002)(2906002)(86362001)(478600001)(316002)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlRlNnh0ZEw1UHVIWEFOUGsyVmlzZGhmUkppL2pJcmlISEk3NHgvdy9PU2k0?=
 =?utf-8?B?L1hsL3drVlBNR0NZZXNkVXlwWk4xZnBCbklzYXdMWUdhbHUwMUVydU1QTW1y?=
 =?utf-8?B?a1JPQk10RlUzb2NGQWlDenBIUjFJcGdtT0VkZUkzNWNVTEVWOW56MGdDMVhj?=
 =?utf-8?B?UlVnYmFxcm5YT1RjQmN1bFhNWEJWd25HcDBMZHgvb09RakRJMHBhUjRSOE1q?=
 =?utf-8?B?RHBZL0MvYXBZeDN1VzFrbURxTEk2WUVYNk5qRjErblR3R3J5N3EwN2ZzaTh2?=
 =?utf-8?B?SGRjWGpzNkU5N2l3Z1VLVitUaGhQN01uYVFxL3dXQTVTdmFSems4U0d0Yytq?=
 =?utf-8?B?bzZIUy9oTWtRM3MzUFk4NHdCTnNaZTI3YW5KMkdUYnJEVDZCQ1AyaUtlc2Vu?=
 =?utf-8?B?QUdST3doZWhVa1Q0aTkyNlU4NG5BUTdoNmFqVGhMUmNnTDgxditJSjR1eXBD?=
 =?utf-8?B?bE1GdmhtVG8zRWhzbEtJekRxRHI1N1hmd0lzcXJHLytDS1ZKeXZLdEhVNGU5?=
 =?utf-8?B?cExXcG9CMGtJWnBjcU42N21JMTVPUkhKeTc1SG9ZQmF6QzZLMmIvaXdBZXhx?=
 =?utf-8?B?YkpmS1pNL1hheUtNZWtPTnRYemFSYXMyZkxOYVNRRHRIZFE3TUN3Q0I4RHZX?=
 =?utf-8?B?SGdrZW03MFRTMDJBaFdJTXBqMU9lV3o0VlUzWkxRRUZIandYNWVWelN6QTVC?=
 =?utf-8?B?dVBCeCtCOFlTaGN2V3J6MG41REw2YWxvbDRzSi9aOSszZXY1NjVhekxIOHhv?=
 =?utf-8?B?cTQ4V01qL3FDUTZING1xaTdnUVlMWFY3bmR6RjNwaHNoUEFOOFl2clhSdlRY?=
 =?utf-8?B?a0RRUzBpb0NkeGRPUXNKQ0xBTVQrZ1U4bGRqcE1xeVNVNVdaUUtWSy91RWgx?=
 =?utf-8?B?dTZOTW52a0N6OXJvbkNQK0RmTW03Q0w4QjQrYUlsNitXdzFiZFgxajRJNmtt?=
 =?utf-8?B?TlBYbDdpdjNlYkVhaXVjWkFOdE1ZNEFsWmFLRDdlWEE5czdmUG1rL0d2SGVP?=
 =?utf-8?B?S2xNMDRPdkF2QWJHZE5hbjBMNlZCVVZwd0xKVjgwTHBqaGxzSjAyTlZ4Sk1s?=
 =?utf-8?B?VVIraG5pN3lSWnNTaVpKWkVkYnpQRUpaUy9QYmtqcW5KV09ENEtna1FmSGJq?=
 =?utf-8?B?WHEzVWd4Wkxlajh4RFpxRmhHUGxvbFh6c2g5TzhQYitHWXh3aG52WFE1cEF4?=
 =?utf-8?B?WEd5NW4zWkFucythQTcrVk5PQjBOV1BHTm1rU2ZlQUFqaVBJWG4rSy9ocGQ3?=
 =?utf-8?B?emZSaE45TTJGV093dHBHU2FSRXpwWnAxV1JuWksyRjkzZUZuUDFjSG1zNDY5?=
 =?utf-8?B?TFVDbExTbmQ2TjZFQVpyZ0pqUGpYTTlEbWxaY29kRkRDd0YrV242Nkg5RG5N?=
 =?utf-8?B?ODkvWVFDYmVPWk83NjFDclVzOUxlb3V1QXFUUTUxeWY3dFdIM2JLR3NXbFNo?=
 =?utf-8?B?QTJBVUZ1SUhRVEppOUJaaVBUZitjQkJISmpQWDJYa1g0aW42THkyb05vTUNX?=
 =?utf-8?B?Qi9EY2diSi9MSklPRDRGeXhaUlB0SzhhTkU1aDUydVROeHRDYlp2Tk9acE1R?=
 =?utf-8?B?Y0ZjTmVTMTlUMzVDaU1DaFZ3Z3c5SkJSRmIzazhTNld2cDNvUzl6TGg1Y3VM?=
 =?utf-8?B?c2hDcVd2S0xrUDBTcS9mNnlLV1lNbG05T0pIWjlyU2c3eU1SK3Bucm1HVlJj?=
 =?utf-8?B?ZGJtMEtKSE0xVDZpemUzZ0Y3bmpaYmVZcGlOK0lBV3BMN0xhVVZGaVR4UkFx?=
 =?utf-8?Q?hgJyDSe1RsgFUfYOPcn5h15wNbiVa2DdMWS0X6Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8583C1D6665E1C4ABBD2B026425AE346@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd639967-89cd-4adb-1842-08d95e92aed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 19:43:53.9019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d66OhWs7FUDjag/+s/49JPA9JVFW0i+dGKtllw5bHneMQbSHBviM1GWbjAbVAkjNdNPNtZ3/tcD3pR84dubAMBQNlu0GEpJiGzYzhAninfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDEzLCAyMDIxLCBhdCAwMzowNCwgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
IHdyb3RlOg0KPiBPbiBGcmksIEF1ZyAxMywgMjAyMSBhdCAwODowNDo1NEFNICswMDAwLCBCYWUs
IENoYW5nIFNlb2sgd3JvdGU6DQo+PiBZZXMsIGVhY2ggc3RhdGUgb2Zmc2V0IGluIHRoZSBub24t
Y29tcGFjdGVkIGZvcm1hdCBpcyBmaXhlZCBpbiBhIG1hY2hpbmUNCj4+IHJlZ2FyZGxlc3Mgb2Yg
UkZCTS4gU28sIHNpbXBseSB0YWtlIHRoZSBzaXplIGxpa2UgdGhhdC4NCj4gDQo+IENvbW1lbnQg
YWJvdmUgaXQgcGxlYXNlLg0KPiANCj4gQWxzbywgd2h5IGlzIHRoaXMgc3BlY2lhbCBjYXNlIG5l
ZWRlZCBhdCBhbGw/DQoNCldpdGhvdXQgdGhlIOKAnGNvbXBhY3RlZOKAnSBub3Rpb24gaW4gdGhl
IGZ1bmN0aW9uIG5hbWUsIG9uZSBtaWdodCBjYWxsIHRoaXMgZXZlbg0Kd2l0aCAhWFNBVkVTLiBC
dXQgY2hhbmNlcyBhcmUgdmVyeSBsb3cgaW4gcHJhY3RpY2UuDQoNCj4+IFRoZSBxdWVyeSBpcyBp
bnRlbmRlZCB0byBjaGVjayB3aGV0aGVyIHRoZSB4c3RhdGUgYnVmZmVyIGlzIGZ1bGx5IGV4cGFu
ZGVkIG9yDQo+PiBub3QgLS0gbm8gbmVlZCB0byBlbmxhcmdlLg0KPj4gDQo+PiBJZiB0aGUgYnVm
ZmVyIGlzIGFscmVhZHkgdGhlIG1heGltdW0sIHRoZSBjb2RlIHRvIHJldHJpZXZlIFhTVEFURV9C
ViwgdGhpcw0KPj4gY2FsbCwgZXRjIHNob3VsZCBiZSBza2lwcGVkIHRoZXJlLiAgDQo+PiANCj4+
IElmIHRoZSBxdWVyeSBpcyBtb3ZlZCBoZXJlLCBJIGd1ZXNzIHRoaXMgY2FsbCBzaXRlIGNvZGUg
YmVjb21lcyBhIGJpdCB1Z2x5Lg0KPiANCj4gV2h5IGRvZXMgaXQgYmVjb21lIHVnbHk/DQo+IA0K
PiBZb3Ugc2ltcGx5IHJldHVybiBlYXJseSB3aXRob3V0IHRvdWNoaW5nIHRoZSBidWZmZXIgYXQg
YWxsLg0KDQpQZXJoYXBzLCB0aGUgY2FsbCBzaXRlIGluIHRoZSBwdHJhY2UgcGF0aCBiZWNvbWVz
IGxpa2UgdGhpcywgSSB0aGluazoNCg0KKwlpZiAoeGZlYXR1cmVzX21hc2tfdXNlcl9keW5hbWlj
KSB7DQorCQl1NjQgc3RhdGVfbWFzazsNCisNCisJCS8qIFJldHJpZXZlIFhTVEFURV9CVi4gKi8N
CisJCW1lbWNweSgmc3RhdGVfbWFzaywgKGtidWYgPzogdG1wYnVmKSArIG9mZnNldG9mKHN0cnVj
dCB4cmVnc19zdGF0ZSwgaGVhZGVyKSwNCisJCSAgICAgICBzaXplb2YodTY0KSk7DQorDQorCQkv
KiBFeHBhbmQgdGhlIHhzdGF0ZSBidWZmZXIgYmFzZWQgb24gdGhlIFhTVEFURV9CVi4gKi8NCisJ
CXJldCA9IHJlYWxsb2NfeHN0YXRlX2J1ZmZlcihmcHUsIHN0YXRlX21hc2sgJiB4ZmVhdHVyZXNf
bWFza191c2VyX2R5bmFtaWMpOw0KKwkJaWYgKHJldCkNCisJCQlnb3RvIG91dDsNCisJfQ0KDQpN
YXliZSByZXRyaWV2ZSBYU1RBVEVfQlYgaXMgaW5ldml0YWJsZSBoZXJlLiBUaGVuLCBpdCBpcyBu
b3QgdGhhdCB1Z2x5Lg0KDQo+PiBObywgaXQgaXMgc3RpbGwgcG9pbnRlZCBieSBmcHUtPnN0YXRl
IGFuZCB3aWxsIGJlIGZyZWVkIGluIHRoZSBleGl0IHBhdGguDQo+IA0KPiBFeGl0IHBhdGggb2Yg
dGhlIHRhc2s/DQo+IA0KPiBBbGwgSSBzZWUgaXMgInJldHVybiAtRU5PTUVNIiBhbmQgbm8gY2Fs
bGVycyBvZiBhbGxvY194c3RhdGVfYnVmZmVyKCkNCj4gYXJlIGNhbGxpbmcgZnJlZV94c3RhdGVf
YnVmZmVyKCkuLi4NCj4gDQo+IEFuZCBsb29raW5nIGZ1cnRoZXIgaW50byB0aGUgcGF0Y2hzZXQ6
DQo+IA0KPiBleGNfZGV2aWNlX25vdF9hdmFpbGFibGUgZG9lcyBub3QgY2FsbCBmcmVlX3hzdGF0
ZV9idWZmZXIoKSBJJ20gYXNzdW1pbmcNCj4gDQo+IAlmb3JjZV9zaWdfZmF1bHQoU0lHSUxMLCBJ
TExfSUxMT1BDLC4uDQo+IA0KPiBsYXRlciB3aWxsIGNhdXNlIGFyY2hfcmVsZWFzZV90YXNrX3N0
cnVjdCgpIHRvIGhhcHBlbiB3aGljaCB3aWxsIGNhbGwNCj4gZnJlZV94c3RhdGVfYnVmZmVyKCku
IFllcywgbm8/DQoNClllcy4NCg0KPiBJIGRvbid0IHNlZSBhbnkgZnJlZWluZyBpbiB4c3RhdGVy
ZWdzX3NldCgpIGVpdGhlciwgc28gd2hhdCdzIGhhcHBlbmluZw0KPiB0aGVyZSB3aGVuIGl0IHJl
dHVybnMgLUVOT01FTT8NCj4gDQo+IEkgZ3Vlc3MgdGhlcmUgd2UgcmVtYWluIHdpdGggdGhlIG9s
ZCBidWZmZXIsIGkuZS4sIHRoZSBwdHJhY2Ugb3BlcmF0aW9uDQo+IGZhaWxzLg0KPiANCj4gQW0g
SSBjbG9zZT8NCg0KSW4gdGhpcyBjYXNlLCB0aGUgcHRyYWNlciBqdXN0IGZhaWxlZCB0byBpbmpl
Y3Qgc29tZSBjb250ZXh0LiBCdXQgdGhlDQpwdHJhY2Vl4oCZcyBjb250ZXh0IGluIHRoZSAob2xk
KSBidWZmZXIgaXMgaW50YWN0LiBJdCB3aWxsIHJlc3VtZSBhbmQgZXZlbnR1YWxseQ0KZXhpdC4g
SSB0aGluayBhcmNoX3JlbGVhc2VfdGFza19zdHJ1Y3QoKS0+ZnJlZV94c3RhdGVfYnVmZmVyKCkg
d2lsbCB0YWtlIGNhcmUNCm9mIHRoZSBvbGQgYnVmZmVyLg0KDQpUaGFua3MsDQpDaGFuZw0KDQoN
Cg0K
