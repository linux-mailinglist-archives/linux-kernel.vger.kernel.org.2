Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD6731FF57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhBSTUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:20:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:12886 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhBSTT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:19:59 -0500
IronPort-SDR: NQsy4u+IFJNcEYJt/3KpmP2T1ihUEfBo+8xQBwyG5xmJOTTnv6MjZwHHShBoXEIg8vUDtWVCQc
 FcMryGgFxvRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="171066313"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="171066313"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 11:19:18 -0800
IronPort-SDR: FWXsBQDGu92+i/l4k5fPIcQzlMe1Q5tKWpuZm+qHOQ6WFanMxczS0rwybU+lYlPCM16N6HMg5D
 9lz9HZMgDfTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="513774280"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 19 Feb 2021 11:19:18 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Feb 2021 11:19:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 19 Feb 2021 11:19:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 19 Feb 2021 11:19:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcEVSeNob8Gq1bi5kX7XJ2MuAD6uH5d7S+Y5311LgzqlLBC6yxbbMTHCAOhbrirOtJVlaoBlyALysCjaVZPN5zf4R1h/XQUfR0wWJ2v5bt4WVq3kZH/82PgXi9k6yj6CQvYKdVa/P9Fjka0acqfxW5jKwOBRxvFvgl0d1CL79KQu63Hqj19SDcfpr+QHj8rYcBWvhK76XisZmhnTYALRQvT1VDTlEiVkQHC/HZd7z4OYlGmO1NbLiP9GENtmbFXVuDGDDQkN17UzeQLrV4DrHv1mtkrxHmxc+28PIFJqGePhGeGT4JC0gPwi/E8sfNVWTxXNEedSc5zal9MQnKzgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ1Rw6c2uw/g1mjoWtJnbD39TS87k1y2ozRYAcjGPyM=;
 b=ETkhC7dfVLe8MK9dkfXwr6VNNMTn8FHny2s0xLwQWqe4NhhlnrehdcHQDIONKeEdNiCDf2UawyOxp7fGwft2qf0iJZA/+6qgs5Fxk2VbZbgot3rcAJ7l27v3uAcQD7AwNS2lb9zyZgJebqWBKI7bU7otHlRcVZFCn/KKnVZtmStCJLbwxok2Yu1KphYVMXatnIciqxaWmDQpDBzqQPNegKL3hFXi0Ey7oTLiytOWJHFwv2ohv3hD1+OSAL5U3eGbTO53X+FXTfxlav+63kO5n3xyCR1xjS2NQHUbqXDHjsKaVw2Nkt2Js0YNtsZS/GqjIUjoLDNnNYbJDVYd0wFL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ1Rw6c2uw/g1mjoWtJnbD39TS87k1y2ozRYAcjGPyM=;
 b=tN5kavw4C0NaP7dvj+yOdBogvj4yg0fUi5Tg6VTRoQYfVfi+5W+sVgdyEwYrRJNdYSZT09VxyEtxKWXC6u63Q/TvxHrVJ7rwIQufyiAVTO72rQSsfe/9K43yeesSYJiaZB394QfyHjidFNtT2yse9SWKUCwHXf7I95XcAQqNUVw=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5158.namprd11.prod.outlook.com (2603:10b6:510:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 19:19:16 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3868.029; Fri, 19 Feb 2021
 19:19:15 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Andy Lutomirski <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/21] x86/fpu/xstate: Update xstate buffer address
 finder to support dynamic xstate
Thread-Topic: [PATCH v3 11/21] x86/fpu/xstate: Update xstate buffer address
 finder to support dynamic xstate
Thread-Index: AQHW2UTpVbiLreS2l0Si1dAMjGOjzqpf7XsAgABIMgA=
Date:   Fri, 19 Feb 2021 19:19:15 +0000
Message-ID: <2CC38936-F8B6-499B-9FEF-333390BA9B05@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-12-chang.seok.bae@intel.com>
 <20210219150050.GC26068@zn.tnic>
In-Reply-To: <20210219150050.GC26068@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7bf68be-38b5-44be-88ff-08d8d50b3f81
x-ms-traffictypediagnostic: PH0PR11MB5158:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5158881E1CC60775A8BEB846D8849@PH0PR11MB5158.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PeVlDJvfto0/z9PeVg097rXcyuMaXJWgt0E/fNtfTaxfUYYckAT/k+0XQT7iCLj2oBNQo4Kh4cSGTWvmuXkzqmZEALyXqlJGWOFVoBAABGgZUlkNAJ3uQdJLpa5vjA0plSMrZDW7aF/5lMkVpmHVkVRzHPJsLEI05xcYXk/+EnWl8eX9hWY3l6XUUpBGltJ+oPNAs/1GDuNI8WACEDtZdBxrSzB3QvJV3WF1hXvZc4kBzJ3OSf66ukZ2dSvZRAcx6pfbK+z+Vvw9cDL5+iAeMVRMt+YwxScwNfiL6cDAJdaMBh4nbaQy9jHK84GjHwyDtejpjYLDME7hnRjgpGq9XqX4iOpc3/zRL3DCndWNlb3U2S7iYhCyD/cLNG4sM6Yyr3kMbZcWsJ+2jvUHAmu9u0SZJnSJVJPTA1Tq3Rwd4yzyYnXa8WPJIIYZN2asxZpVkLd/aT5gnr7uC6k1IC0fjIaDkT7Mic5ol9v+zlf5UHroM5B/DgUY4tPidlP5CmN/XL8T2FfhFQer8+bOxWyKXNlxoJfUWPPeAuaeMrDJUHBinLZmj4ITaFtyLbAJtIyOVHAC7JQnimx0LptKTyD4Fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(346002)(376002)(66446008)(76116006)(26005)(8676002)(5660300002)(8936002)(186003)(91956017)(316002)(33656002)(36756003)(6486002)(6916009)(2616005)(54906003)(6512007)(66946007)(53546011)(4326008)(2906002)(66476007)(71200400001)(86362001)(478600001)(64756008)(6506007)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y0RJVnJsU0JDQ0M5M3o0QzR0a0wyRGhYaC9VT2tFT29sUVVYL1FXVjAxQU5r?=
 =?utf-8?B?OVdISzYzY3ZnR0drc3lLSmVWUkVheGtxTEd0UUlhckRJOEdReDJza0R6VSsv?=
 =?utf-8?B?NmdweTZwVTBSTTNoaWdLTSt1SUlIZCttQXNJK1l0a1QvbVVyK2dRemZuK3E1?=
 =?utf-8?B?VjFCMGdCWnFKcllrZ3MweURNdis1cHlLREI3YWd2QjVMVGc4M21GTjBSMEVY?=
 =?utf-8?B?WndmYWFFeXFlTXNtSGg2emE1bjJPeHNXenJhWWxUdXh3bkl1dCt1QzZISjI3?=
 =?utf-8?B?ZEFld1F1cGVlMkYrLzFjYXhFYThVcEdKNndqUDNnSEpHOXgxejh4NDZFbEhG?=
 =?utf-8?B?QisxZmFHcC9vM2UyemRDOFcwSHB4NEpxV2Y4NUFneDRsZ0YrYWZsdVFFWmdD?=
 =?utf-8?B?MGEvT2VWdXdsZHBsRHNuSGZkcmdEWWk5QndKTEpONTZ1LzVVbWZkVjIxd3RU?=
 =?utf-8?B?WnFqNk5aaHhoNE1aN3FmaUVPUERvTWpIRjlSZmxWVjVWWU85QTE1c0xzT2VX?=
 =?utf-8?B?ZVlYRDJwYS9MSzZwazVEL1JVRTBNZFJxM0lMOEwyR1F5dElLcG4xU2Y2MTR5?=
 =?utf-8?B?bDJneHBHNEgzczdGRG82cnBRdVVtQ0k2dkhvc0ZFTkJJWU5DQmhsY0FpU1U0?=
 =?utf-8?B?bWMyc0NNQjUwSTRmYVNnQzZ4MnQ0dXUrYVRkcU0vRStRbWFIZFZ0MWtOMUdB?=
 =?utf-8?B?c3lmQnVja2REVmdrNXR5S0tzR2RtZXEwSjNrQVVZTlp1RFRvVUJxMVdvSTR3?=
 =?utf-8?B?aG0zNFlNd2ZGUXZyMFJLakhKOWw1NzB1eFBKTzU4a3lJVWVIUTAyTDVXanV4?=
 =?utf-8?B?U2lrWUpyVkJTTzF1NGVveTQ4T016UWRGc0ZRazlzcXIrejBxNk13aFkvZlY4?=
 =?utf-8?B?SE4ybWNid0NOZVl3M3p4ajNLY2RVWkRmQ3NTdXloYmdKSzhyS2pSaWROWGIw?=
 =?utf-8?B?SVhHeFloK1BoMStITHRaOU51dk1Wc0ZDVCtUd3BFT3ZBc2dYVXUveHVqT01Z?=
 =?utf-8?B?QVNSQTBsemlvS3Y5bGs0b2tPYklxS1ZHRll1THhncWRUcmV6T1pYUkwvN2xG?=
 =?utf-8?B?M09INmRKM1dMRmNkS05MdnYyQzA2ekNDQThRQlVoZVF4UklqcFI5TkJTOERs?=
 =?utf-8?B?dW5HQitDL0ZHMXhrdTEzNm8rWlVyQlUzQ2E5Qm1iSngxT1ZldTFxWDVvb2Qw?=
 =?utf-8?B?d2c1Sm00eWY5akhyT3l0Q3IrREhhd1BtamVMdW9FcDB6SE9wOXRNVCtOYTM3?=
 =?utf-8?B?c0pVSG05UUtyTkZ4UDZ6ZzVlcGpOMWVpR3VKa0RiWCt5WmFwV2FINC9ybTVE?=
 =?utf-8?B?VGhiVitaVUxrM0xRaGdLTmxTUSsrMHpIU1NvdktURjIwRXpSN05uaG0xQ0g3?=
 =?utf-8?B?MGJ0TkhCRnd4K1lsSWROMlA2V3pSaFFRWmRuZVUwY3RaOWE4dE1ibGRWNysz?=
 =?utf-8?B?ZlhYL1hvQXhaYUsvaEpYalN6alZjYWtDVERrUFh6NENkbjY5WFJaZ1JobXc2?=
 =?utf-8?B?UzdOVi9yUTZCUDhtK2dwQkJoMnU5K0JsYmRRTFB6RmpjWmY2U3MxN0ZqbURV?=
 =?utf-8?B?R2syTEV3ZU5tTmFpWjBqLzhyREs3dTJmbEJvL0N1TlRrWHN4VDEzaWtESlAw?=
 =?utf-8?B?YktLZXZDTXlBNWNFQkhKVGtxTFpNMUJUTm1lbERqdVpmZlBLR3k4OVUxaXc4?=
 =?utf-8?B?NmNiejdPSkhnbU45d3V4TlJFNFJDb3FoWDdSYWNSMU5kNGZScms5dlU5VW9B?=
 =?utf-8?Q?Fsy8YbaTEdwJC6q2NGuCTCK8zYDYZ859ltcF5AE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CD6AC2A3E9B6443A825E47D1E5978DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bf68be-38b5-44be-88ff-08d8d50b3f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 19:19:15.7833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2M/Q2m0FyBvp18jvcdF+9Mf+2yfW7rnInewzSf32r6AsTgXXKtEtAvRcqFnp95Jl9jrAnxMbIsGkRlhyc8uZsl+wyD+SipgrAj2VBZDHRB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5158
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRmViIDE5LCAyMDIxLCBhdCAwNzowMCwgQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPiB3
cm90ZToNCj4gT24gV2VkLCBEZWMgMjMsIDIwMjAgYXQgMDc6NTc6MDdBTSAtMDgwMCwgQ2hhbmcg
Uy4gQmFlIHdyb3RlOg0KPj4gDQo+PiANCj4+ICsvKg0KPj4gKyAqIEF2YWlsYWJsZSBvbmNlIHRo
b3NlIGFycmF5cyBmb3IgdGhlIG9mZnNldCwgc2l6ZSwgYW5kIGFsaWdubWVudCBpbmZvIGFyZSBz
ZXQgdXAsDQo+PiArICogYnkgc2V0dXBfeHN0YXRlX2ZlYXR1cmVzKCkuDQo+PiArICovDQo+IA0K
PiBUaGF0J3Mga2luZGEgY2xlYXIsIHJpZ2h0PyBBcHBhcmVudGx5LCB3ZSBkbyBjYWNoZSBGUFUg
YXR0cmlidXRlcyBpbg0KPiB4c3RhdGUuYyBzbyB3aGF0IGlzIHRoYXQgY29tbWVudCBhY3R1YWxs
eSB0cnlpbmcgdG8gdGVsbCB1cz8gT3IgZG8geW91DQo+IHdhbnQgdG8gYWRkIHNvbWUgc29ydCBv
ZiBhbiBhc3NlcnRpb24gdG8gdGhpcyBmdW5jdGlvbiBpbiBjYXNlIGl0IGdldHMNCj4gY2FsbGVk
IGJlZm9yZSBzZXR1cF94c3RhdGVfZmVhdHVyZXMoKT8NCg0KWWVzLCBpdCBsb29rcyBhcHBhcmVu
dCB3aXRob3V0IHNheWluZyB0aGF0LiBJIGRvbuKAmXQgdGhpbmsgYXNzZXJ0aW9uIG5lZWRlZC4N
Cg0KPiBJIHRoaW5rIHlvdSBzaG91bGQgc2ltcGx5IGFkZCBrZXJuZWwtZG9jIHN0eWxlIGNvbW1l
bnQgZXhwbGFpbmluZyB3aGF0DQo+IHRoZSBpbnB1dHMgYXJlIGFuZCB3aGF0IHRoZSBmdW5jdGlv
biBnaXZlcywgd2hpY2ggd291bGQgYmUgYSBsb3QgbW9yZQ0KPiB1c2VmdWwuDQoNCk1heWJlIHNv
bWV0aGluZyBsaWtlIHRoaXM6DQoNCi8qKg0KICogZ2V0X3hzdGF0ZV9jb21wX29mZnNldCgpIC0g
RmluZCB0aGUgZmVhdHVyZSdzIG9mZnNldCBpbiB0aGUgY29tcGFjdGVkIGZvcm1hdA0KICogQG1h
c2s6CQlUaGlzIGJpdG1hcCB0ZWxscyB3aGljaCBjb21wb25lbnRzIHJlc2VydmVkIGluIHRoZSBm
b3JtYXQuDQogKiBAZmVhdHVyZV9ucjoJRmVhdHVyZSBudW1iZXINCiAqDQogKiBSZXR1cm5zOgkJ
VGhlIG9mZnNldCB2YWx1ZQ0KICovDQoNCj4+ICtzdGF0aWMgdW5zaWduZWQgaW50IGdldF94c3Rh
dGVfY29tcF9vZmZzZXQoc3RydWN0IGZwdSAqZnB1LCBpbnQgZmVhdHVyZV9ucikNCj4+ICt7DQo+
PiArCXJldHVybiBfX2dldF94c3RhdGVfY29tcF9vZmZzZXQoZnB1LT5zdGF0ZV9tYXNrLCBmZWF0
dXJlX25yKTsNCj4+ICt9DQo+IA0KPiBKdXN0IGdldCByaWQgb2YgdGhlIF9fIHZhcmlhbnQgYW5k
IGhhdmUgYSBzaW5nbGUgZnVuY3Rpb24gd2l0aCB0aGUNCj4gZm9sbG93aW5nIHNpZ25hdHVyZToN
Cj4gDQo+IAlzdGF0aWMgdW5zaWduZWQgaW50IGdldF94c3RhdGVfY29tcF9vZmZzZXQodTY0IG1h
c2ssIGludCBmZWF0dXJlX25yKQ0KDQpZZWFoLCBJIHNob3VsZCBoYXZlIGRvbmUgbGlrZSB0aGlz
Lg0KDQpUaGFua3MsDQpDaGFuZw==
