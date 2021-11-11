Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D81E44DCAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhKKUuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:50:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:46105 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233303AbhKKUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:50:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="219901399"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="219901399"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 12:47:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="565250740"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2021 12:47:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 12:47:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 12:47:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 11 Nov 2021 12:47:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 11 Nov 2021 12:47:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nzkh80KtWSzecAT4GpFXrrTCEEXNupeSA0NaChFS2MlVvCRqocj1JpbPlFhfjErSVQ3M/T7CmAsQb3ROK64WXq03D5bv+ki3OSdHfSnumMNun6O+gohGZZJ4cZALE1vs0t3M1SMJV7sdLd/x3Uvykr+fgh7KgWCnGnzF/9AwwDIc4h5e2214g40407E1SJFoQpeutTFeaU/o4tFVvZ3oME1cID6VqNQ41DnPhIcE60iT6VX0PlINbZyajXWx++dIyyku+wsVj6hsqzrRslvGN26KFnO4Fa9WzkUWsSnPLXNgcjeSJFTW+8wiuhFYMfCZhmOjn+xqN4L2zhy2VtgHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXLxLig0OwDf5GwrtM+6IsjMu3iqyZ3RizpTT1FWLZY=;
 b=H55AlF9AQjXr6VAz8DpQhqQCNucJQtZgtJrIwFQB7elmGdEu3MycQ1VKHNB5PBIvZSqsIUjEd+eDpVWKVVfi5P6YGrXBRx3atH/7kkXchPzo8B7SGJE0K6O47KALUFchI4XDWaO8Og9tDNqfY9p3upoVRDZnZiQw5vXpxaEjV07w/ek2G8J+02fHmlTcZmjyKCAmfeKVUQArF7K066BIkMor/7DwmXcBFswk+GW70t0l1rNKEhzJvMr+D6liccZJP5+mfr2h4pQJNBeoh41N6cojGvuAfwazZ0ysIuAA7fl9GPgU6+hmpc3N/j28Xcy5nuGowDBqCXXTyHBwZjqR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXLxLig0OwDf5GwrtM+6IsjMu3iqyZ3RizpTT1FWLZY=;
 b=Je1zpvN7p569D4cPQ/JnsI3iVtYMAowsHdtK1iVPnrEW/+s9MBEQVGUg3i7jQS/70sxu8v+ks5er+SCcXOIdNDEiTT5WLAxOhxk7QchW+ybptze0ZrvxSKZcr3MHsH3dYV0ikYAi+lIGZ2LnMiMZchoQzjG9DCC86/8nwSLZhpE=
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR11MB1453.namprd11.prod.outlook.com (2603:10b6:301:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Thu, 11 Nov
 2021 20:47:26 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::bd76:b278:9392:fcd5]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::bd76:b278:9392:fcd5%3]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 20:47:26 +0000
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
Subject: Re: [PATCH 2/4] x86/mm: make kernel_physical_mapping_change() __init
Thread-Topic: [PATCH 2/4] x86/mm: make kernel_physical_mapping_change() __init
Thread-Index: AQHX1uu1rXhztkM5/0Ci7bgIrFadi6v+zNKA
Date:   Thu, 11 Nov 2021 20:47:26 +0000
Message-ID: <e6e47cf8e3a64d36dc411709abf3bd28026afaf7.camel@intel.com>
References: <20211111110241.25968-1-rppt@kernel.org>
         <20211111110241.25968-3-rppt@kernel.org>
In-Reply-To: <20211111110241.25968-3-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5be5e39c-d896-467d-7763-08d9a5547856
x-ms-traffictypediagnostic: MWHPR11MB1453:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB1453F1D56FDF8809F4A43163C9949@MWHPR11MB1453.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9fu4YwG53/0xzsI1YHy15WWaP6/LdSVXI2PveKcTNsxxdxc8DUAB2BghCAcOlOpQVKRVDVgQN0tVZBzz4naINXs4daxU5bwZ8nc74y36Yts/KvCX5nhugJ6MdgLZoP414TqmXLoyQvzc4aoo49lT1W4Z2ljQC2o7Nb/yCT9qMqYxIy78F3nl3ba0Tl4ZzIqQbXVqjAYDb0UeG7rMH+obCMkYJVh7+DZo57Reuzwe1RcSmEm59paJLsz+ayzZ9+S1tcIdD47gRfbuBMq3px54PBhD6tIzmYx1xIgL61OdEnD07cGLrVWxlk0XnJ2gQIUoPWBSt33je438fbawnjkVaGP2UmWvppOOqZe7LkGF3RVjYIPHUhO5k4R4SOhI6yPF+zlKXxBj0l3fQzSUPlHo66In75AOYp2D28o5leC54my76SpaJbsQ/8L7KOi8NLI3iqBtAVMqQs3/pS2ON+C501vT5IBo9gHvMGXOktBzxZAyhyJixyO2nPbKhrXiHd9f/PfvwwppbFiBvFyYXoECWYjgT4hxCA77FyW8phNsqKY4CKtMqEK4Uwfa6v8MTT4G1s3pBIRBfuL3ePC50cgvX7alFZWzBC72T/6yeQG/kCsFc9d1CX48Fb7CC9JIA/svibWElzgLj5zIBH6sFyipS/xGaPVj0NPEpvUHBEXoHs5ahroAxCsx691WDqW87PMFBEdv2bBKAVEgP8eNVCt9CVeCcwYQ+MZOqNk05zlH+kM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2616005)(36756003)(6512007)(5660300002)(508600001)(83380400001)(4326008)(4744005)(26005)(38070700005)(6486002)(6506007)(2906002)(66946007)(86362001)(110136005)(82960400001)(4001150100001)(316002)(54906003)(8676002)(66556008)(66446008)(64756008)(122000001)(7416002)(8936002)(76116006)(66476007)(71200400001)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1VZNkJTN2F0TkEvNmY4c1Z0M0paN3hrR21nUXFSeEhLbHVrSVVyc1pzdXhK?=
 =?utf-8?B?alBHRWpyak5waCtEZGJIc1VFRVl0MzRKS01scmFxQXNPa3RYL3VIK3I1Rzhy?=
 =?utf-8?B?R0RqWU52WmhWbUIxN1pVNHNzQmRzY2NwdEpGbTBObWlORFhVSWMzK3N4M3dq?=
 =?utf-8?B?UWFjL1RDSUo4WXFENU5RRkpJdGdQaUwvU2FrQkVFMzNrRUtWM1ZJOGlKWnQy?=
 =?utf-8?B?VkxicUNjZTJZTWMxRUZGK0U2SytLNldUWUhJYlYrcG1Sd3I0R3hUZVRsZHdq?=
 =?utf-8?B?SEsxWEhBdHNYRnZvSGN3TUlBRUk2M2s2aGdjUmNCRG5IcUpQT1NCS1lLeldX?=
 =?utf-8?B?c3ppVDVOWkdiSWtKTkR5YzBmUjRFdXdSYitLVTZhNXU2VmdzcFVWSVVMb21Q?=
 =?utf-8?B?WXQwOUt4dHFvUDd5aUZhYlZtUGtPc3BmTE1vOThPbVM2NUVuVGREb2l5M0hX?=
 =?utf-8?B?c0FvUkFYOFQydnJJQWNBNnM1c2FvUmdBZytvWVFYVDlNeUw4cTc4QitaRElt?=
 =?utf-8?B?d3lSYmdkZFdNczlRcTY0amdWWm1RWUlCMTE3TTdiR2xLM0RpeEFlSTJ3SlVh?=
 =?utf-8?B?UDlMa295eEdVbVVaV2hhNk1SVElaTE1rN0Y3WjFXY0pkV0c4VmYyeGg4MDhF?=
 =?utf-8?B?Nzg4VWNBZGhYVG9GYmxGOEM5YjdzTWVFM1R5b1pPam5ST1VST04rVFNIVnRR?=
 =?utf-8?B?cGdpK3JDR2dhZDVwS3NnOVlSWHpRMmNKcEMveDRvanBZbENaQnMzQndVYlRt?=
 =?utf-8?B?SHM0dTFEY2hwSVJKYnVqQmE2S0lCQ0NSeDdpY2w3UkxTS091OUI4aGdTYkZB?=
 =?utf-8?B?Z2FqclJrMHZncU1BZUNabno0OHhwSzd1c3BRU1FwWHdEN0doQVpmUDVsVDdU?=
 =?utf-8?B?bkZneVZlUi9udXNwRWVRYUp0RUlzRGVtYkpOeVR5T0lMNFVhN3pGZ1hBUXpI?=
 =?utf-8?B?aW9EbmlXVEN0UDMyTzZxa0Rhd1luL3A5d3U4MnhjMW5KZXdiZVlzdmVCWmZk?=
 =?utf-8?B?dG8ybVZVYmQvRzBkeXRXUi9NM0JqL2xPQXp5OVczOTVoMkRPRU5KYzRBZVJL?=
 =?utf-8?B?ejVlK1BEaDdTSjFWTFJ6aEdTdzBSanVUM1l6MERKM0pKbWFYdzQwTnhEZ2hH?=
 =?utf-8?B?MkdsSTkxTjI2TnQ2U3J1c2ZxdGs1Qnh0S2czNjFodWU0aWhBWk9qek5lNDkr?=
 =?utf-8?B?aThjcEhEK2ZDNXJHaXZ0TnRhYVdGckJYQ3lEaTJNeFF2bzZ1K1BGUFBEeXRu?=
 =?utf-8?B?SEpLQURCb2Z6T28zTHdxMDVoMUFHWCtiaHNpQTdlR3FKdmdTR3BmTGM3Z2kv?=
 =?utf-8?B?WFVMOThFeGhRbkZkc1hQM0w2b2JjbEl4VnRoYUI2ZjRsN1puRnZPUGt2aVcv?=
 =?utf-8?B?Rzk0SkVUc0E5aFYrdUZvbTZzNm51RWVGV3RUTlZQVlZzZTNOTWNSSzI5MHda?=
 =?utf-8?B?czAwNW5nTU9XNXpWVHVyOWZ3SEF0Vmw5YUVwdGd6cGl1bWt2WjVrRUhQVHlr?=
 =?utf-8?B?dFFpdEUyV2ZjVDZXazBZRVdhaDJxaDRkRDdmRU5kTytQek5FR1Z6aitMNDRx?=
 =?utf-8?B?ditQUmdBQjQrQ3pjQ1RxRmdoQzhNSlR1Q1lWamdHby82UEZwd2hQaVUrcXNh?=
 =?utf-8?B?UkV3TldVNmRMWUx5bit4by9rcVpIdTFqdWxLa25zYWVMLzZtQWxCZ1FZRE84?=
 =?utf-8?B?V3RLQUdlQ3lMYkVWOUx4ZUo2dksyaU5uSENxbUgzc3dVamwxNGtHSm45ZHBy?=
 =?utf-8?B?OTRpMWtKdGdkT0ZWOW5saXNMNzV6MGc4ZTNPN0t4MTJzaUlFV2gvaVMvNVpo?=
 =?utf-8?B?VUwwU3BwWXl4S2JFbVk4N2dXMHFBL3FpRmtkNEYzSy9FNS9xdmRzcnBlUUFC?=
 =?utf-8?B?cDdFcEZ6ZmxaOWtXWlR5SHZqamJwWC9IV0FKRUZKTURLam5WNXIxYm1KaXVY?=
 =?utf-8?B?dXViUi9qVWJjWmM2RWE4OUM1dVJxWVVUMjRVNkFhRmV2cUZaZERtbjBjMWpZ?=
 =?utf-8?B?WG5PZmRLQXNCcUlnTmQyOFZoanhrUnVuQjdJaGJWRHpPNEx6NGdaSDZ5ZUly?=
 =?utf-8?B?UFBHVk9tTFZjTlh3UXU5M0F4cUREQnU4aW9vRDBJdDM0ak85T2RGa3FGeHFQ?=
 =?utf-8?B?ZU9JMStLUm9waU5kL1NFajdoMGM2NkdvN3dDYzRIbVh1UjY4cnBIZ3orcWpy?=
 =?utf-8?B?TWJlZjVlQmw0N0tPRkRFNUcya1pMOXhyOG1EYktCUytyaGxXL0k5Q0RncHpp?=
 =?utf-8?Q?JyS8nJHuXKILxQm0cM1/coh3thZ32HKj1m1Ty61hA0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E91229F456CB2C4E9E6942C73484BDC9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be5e39c-d896-467d-7763-08d9a5547856
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 20:47:26.3824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giTHlygAmgJSrvfpfjkbgdCn9guEl3JMQ7g76E5MGevFjJiaQespcfsM5GOOIgmpY4/rN8JzWeqYZueGFcTJ0QArnS2v6xmfOk8cBk86fgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1453
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTExLTExIGF0IDEzOjAyICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBGcm9tOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+IA0KPiBrZXJuZWxf
cGh5c2ljYWxfbWFwcGluZ19jaGFuZ2UoKSBpcyBfX21lbWluaXQgYWx0aG91Z2ggaXQgaXMgb25s
eQ0KPiBjYWxsZWQgYnkNCj4gX19pbml0IGZ1bmN0aW9uIGVhcmx5X3NldF9tZW1vcnlfZW5jX2Rl
YygpLg0KPiANCj4gTWFrZSBrZXJuZWxfcGh5c2ljYWxfbWFwcGluZ19jaGFuZ2UoKSBfX2luaXQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+
DQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5j
b20+DQoNCj4gLS0tDQo+ICBhcmNoL3g4Ni9tbS9pbml0XzY0LmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9tbS9pbml0XzY0LmMgYi9hcmNoL3g4Ni9tbS9pbml0XzY0LmMNCj4gaW5kZXgg
MzYwOTgyMjZhOTU3Li45YTI0NTMyZDJiODUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L21tL2lu
aXRfNjQuYw0KPiArKysgYi9hcmNoL3g4Ni9tbS9pbml0XzY0LmMNCj4gQEAgLTc5NCw3ICs3OTQs
NyBAQCBrZXJuZWxfcGh5c2ljYWxfbWFwcGluZ19pbml0KHVuc2lnbmVkIGxvbmcNCj4gcGFkZHJf
c3RhcnQsDQo+ICAgKiB3aGVuIHVwZGF0aW5nIHRoZSBtYXBwaW5nLiBUaGUgY2FsbGVyIGlzIHJl
c3BvbnNpYmxlIHRvIGZsdXNoIHRoZQ0KPiBUTEJzIGFmdGVyDQo+ICAgKiB0aGUgZnVuY3Rpb24g
cmV0dXJucy4NCj4gICAqLw0KPiAtdW5zaWduZWQgbG9uZyBfX21lbWluaXQNCj4gK3Vuc2lnbmVk
IGxvbmcgX19pbml0DQo+ICBrZXJuZWxfcGh5c2ljYWxfbWFwcGluZ19jaGFuZ2UodW5zaWduZWQg
bG9uZyBwYWRkcl9zdGFydCwNCj4gIAkJCSAgICAgICB1bnNpZ25lZCBsb25nIHBhZGRyX2VuZCwN
Cj4gIAkJCSAgICAgICB1bnNpZ25lZCBsb25nIHBhZ2Vfc2l6ZV9tYXNrKQ0K
