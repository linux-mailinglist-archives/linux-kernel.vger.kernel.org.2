Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66670314041
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbhBHUTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:19:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:29116 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235824AbhBHSyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:54:11 -0500
IronPort-SDR: s601CCa6wuIhWnIdg50mWyXx+RgTXgl2WXBks8x3UWTgVGId9i3Gg/RYtoM1Tgoox/JR6lSAh/
 vFgXzec3afIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="161513135"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="161513135"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 10:53:30 -0800
IronPort-SDR: MzS97+BJg3PQvVFxA2pGb/01GlHnZ2kHk2Gs4u7V9Lf8ralFx5kmq/PfiXgFhH2gTTKDJKryTF
 /eNTiLMjUT5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="374591641"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 08 Feb 2021 10:53:29 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 10:53:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 8 Feb 2021 10:53:29 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 8 Feb 2021 10:53:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLMpEZjGe0CT9cmXqK55dMFfSby48Mm93awyp12lGXPNsPP+CCuUMh3DF77MjD+7fwRVVGk4ejBSs9h6d5Q3fLrb5cGCEr7jbSpN09teO9EwpHSxJmk7uajDKGJNaPOjJEC8vkIciC/G6c0Z41Jx/Teo2NC746x2y7Q2XH8GivkQos9NbD1Z/hmVCIYF/ZDnsB3OSLy4mSsxNCTA1qTNh6lofdvdL0gA8JqE5IGmcaPRgiTLe8IP0DWFbtJenazd9LuaqVNOekC7r90oQOkxKcqnpcdCA8+O9jk1/2rvfUWONWkWEbfN25KZGyoFQWiGMTLbFN+knBQdDvR9hMff5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8xpi0gc2WzcUKwV9pWBmRMOfy+y2+mLOLeYdtKq+IM=;
 b=bb17/Vv6OyKh24xzrZ9yDwj6v+6BqwXW+u6im6wnirZKhPXFRqngies3jHBOgR0gz73SA+qewaHbVi+5vOq7DQmrUTg/sJm78F0UsXv0DcCD/vYvqyEUkXc9QG0WXP4N7HCCNNqd6xiz39pOpLXJ6yysC9fU6ySyCES+zGuJ9cXajinsGM+k6qG534evIpXmVGU018FctOFzSL0kRz8FkukO4hXpRdrhSyL42lWUUlTK8opMGD0oxO44JduAxxMJfL6fdbFgNVFrFTVREVfwGQCaPulmGHWZHVmBqQ9qvQosB62hJKXYNVetCDSI3u8Lwgby0mOBxqe+dmq6F5Kqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8xpi0gc2WzcUKwV9pWBmRMOfy+y2+mLOLeYdtKq+IM=;
 b=O6HGzyMdpPl3iE1aToCl0MDiY+Du89Ex0mN+NzDhfK41AX0MMrlRbdsWAmHHelI43lPx4vZUhFNmbF8fUhjqanxZObrvbOsTqTVej0xx2+lnnP0OZhSt4N7PRN4oHeoqvClm+ku+/DQLJErE0fsu1Qn2L0R6VhbwvMI79+ntuig=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4806.namprd11.prod.outlook.com (2603:10b6:510:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Mon, 8 Feb
 2021 18:53:23 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 18:53:23 +0000
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
Subject: Re: [PATCH v3 08/21] x86/fpu/xstate: Define the scope of the initial
 xstate data
Thread-Topic: [PATCH v3 08/21] x86/fpu/xstate: Define the scope of the initial
 xstate data
Thread-Index: AQHW2UTqFYm5UYpYB0GEyLEco/gga6pOeqwAgABqIgA=
Date:   Mon, 8 Feb 2021 18:53:23 +0000
Message-ID: <AF6E884F-F6DC-4519-B57E-F6CFBDBEF85B@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-9-chang.seok.bae@intel.com>
 <20210208123330.GE17908@zn.tnic>
In-Reply-To: <20210208123330.GE17908@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9dd04c9-7495-4113-81bb-08d8cc62cfe1
x-ms-traffictypediagnostic: PH0PR11MB4806:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB48062669EDAF62FAD0F84486D88F9@PH0PR11MB4806.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PXxfpfNU2PHHecxhC5XeV6faf+gWwLZe28t7zj+QJWqBiNv4QMS0I1H1hHtigOQYy5CO4/wy2lzsqItqqxNVTa9fm1NMroEyRHB7G7t+E2xPZp9xa3t97vC31fdGc0ieBM7TkIwSJe5xZyVlBOViRUCLoujRp89MhPCW733ft8bNw1fesjpbKnYAmEinMA7s9tj+0mvmgQ36rhYXbJsQXWw5hmH1Qn10+NCymqfo73nAohBVWmK+FZNPttNGtyZWg+259Eg/6SN6uoWBx2kwxsoy+fTjGJthoBf3I5k7z/eiGEVxisAUv/LM9yJSkaNMQxJ0Dn4M+VwnJQSdWLp5dOrzvy8222yIOCbDiFlFngcmBIDJawNshXegJeiqCILkW9pq4BGIV3RGJ684FwUcY0uB1JAFRWMtIIM4ki2bGXIXicsRjEeDBLCN9fXVaey67P63zhsaAPOIR1McCI6G1nqeFySd+gEcz485VkHM1XHMIAlEYeGj7tMMRS1H+nsEuerWcH8//SCcNFr6ab+UIExboWMXHGrhBYjTt+6zuFVggTD9/OXhbIFOQXm5+4FJoGA5UA4yakalVnEgmUm7Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(54906003)(6486002)(64756008)(316002)(66476007)(2616005)(8936002)(26005)(71200400001)(83380400001)(76116006)(66446008)(66556008)(6512007)(66946007)(8676002)(33656002)(53546011)(478600001)(4326008)(6506007)(91956017)(6916009)(2906002)(186003)(36756003)(86362001)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SS9rOVB3Umh0NnFCaDhYVjQ4NFdtbU8wZW1GMUduNTFNUHNTaEJ4ci9uZkE3?=
 =?utf-8?B?TWlMQWNPOUlGYWlka3NmNTIxL1dIdjBsWU13TER6aGYrS3pDNGcvSVlDcmpI?=
 =?utf-8?B?em9DL2dIM3V5WHNIV1Bocm9SaE9lWWFSSkl2SmtzR1B3Y3NEYVpWM3IvVWI1?=
 =?utf-8?B?ZjdZR0tsd29UMGNBeklWOEpHUHhqWDFyNU94c0ZaZ2dPcXZpSSt4VHRLbW9m?=
 =?utf-8?B?dWtEY2lCanJKVEVwNlFueFBVWmFLMXZObHhVWEt2b2J5c05QRFlSWjAweTJr?=
 =?utf-8?B?ZElJSUo2MGFiYld3S1lwenZVWUVneDR0ellSTVQ0YTdDVzlqd3pXMksyTFFo?=
 =?utf-8?B?Vys4cWNBMXVSY0NLdGZlRVFxY0ZHOXBuNy80NlNmb3ovcnR2cWkxTjZwS1lp?=
 =?utf-8?B?aEx0M3NjQzZwdGZkVFdDNi95TUhHVXJ4UDBBTFBjYTdEZENsMFZNeDFjdE84?=
 =?utf-8?B?VHFlSzhZNkJiakQ4Q0Vnc0xJSmVVWUhXdldNMWpSU3h0czhNNnUyaGNaZ3JK?=
 =?utf-8?B?QmpTbmFoUnc3MElOazUydGJOTWJKVWx6Yi9zK2tQaWxnLzM3OTFKQ0FYTEU5?=
 =?utf-8?B?bWFkeHl3cjlPSlV6a3VwSGprVEcwWVZualVzMHBhRk9aemwwNFpUTnNOZHJ4?=
 =?utf-8?B?bHRwZk1rWTdURjdCWld2Z0JTMlFaMGEzRStoQ2Jkb1h3bzkxNjQxRm1OSU5P?=
 =?utf-8?B?VU16dU1JeHBxczdZWGo5VEZvNFN1V2Q2WnVEZFVYMGlUalBGYWtaWkpDeTkz?=
 =?utf-8?B?cEc3aU84bk1IVWYxSDE2bGxCZWFpYTV6STRGMWZZVWJjZ0xUMVpSdnFscHZZ?=
 =?utf-8?B?SDZNYXh1WmZBNENINGdpbWNDcFp0VHpIelRkRTZnRGdhOUJVcHJQSU11cjRI?=
 =?utf-8?B?WG5iMFBiSG0rSGQxUDN1ZTBqSmdGMHEweXlXb1pMTDRiVjVhRWVqTFhuU0JR?=
 =?utf-8?B?SFo1LzVvRk9aOGx6RmpwZzBxTndnQnZUeklQbUJ5dUVrVmRXYWFQeXYvNVM1?=
 =?utf-8?B?MW5UZ2VVNXRIR2JFYWFCZTZMTEVuS3RVNlczeStra3hTektTM3Zrby9YaGVy?=
 =?utf-8?B?SitEbWZlQnJCZ3B5c09BTGgweHJ1bWVtTGtmOE1MSzVxVzYyc2NDbWZtdzR6?=
 =?utf-8?B?Z3FmZWMvNTNtUk1XVFRTYkdBek9HRkNmSWdENENmTjdaRzUxaDZKd05pTzh0?=
 =?utf-8?B?WlM4UUlJQ2lyMUNFc05FdDErSVY5eHVUNDJaMTdmTzl0aWNyUlRVNWsvTW1E?=
 =?utf-8?B?Vzk4K2FjR1Q3WEtPVkpueGE1em42M1plQk05N0Y5MW9xTlF0a3pySFJnYlpp?=
 =?utf-8?B?c0pWVXpOVTRyZXh6ZkVLb0d5WFpEWHI5Vm5rWmwzTFhLR1J6Yko4cStSTzdE?=
 =?utf-8?B?cjRhYnlKZHk1VnQwSllKV1BYZ2VEUEhETEZ1MHc1VmNKaHMyM2xrcUoxVklP?=
 =?utf-8?B?aVpPQnJyUFV3UWxjVERYOFhDYlUxTy9NZkJxcnRnRDI1MjBodWE1M2liVS9F?=
 =?utf-8?B?WHp5bURrUEk1bHV3NW44WmU2REhMQXE2MFhNWTlueHg3UnUxMW5YM0dWeHgx?=
 =?utf-8?B?TndwaHdCRlJ0TjdtNzJUUXpEVktBZ2tJRVBiZHFkRzdpdERpT3phT0tjWXlj?=
 =?utf-8?B?MzRlNURFeFNtZ2srRmFHN2EwRGM2QlFqS3dROXBKWmFGcThrQnRyZXJHZW1T?=
 =?utf-8?B?TXdMNTIvek9qbW1leEV6dm90OWxQUXRBRFpSclZ6WVNtWE5pVDdIRXRkdnpI?=
 =?utf-8?Q?RnQPu37xKQrhCaKYqzvHLRZNab+XgM8cJE9mDhi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83EE3A02DD5B8E46A01C9A426338680F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dd04c9-7495-4113-81bb-08d8cc62cfe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 18:53:23.7925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAytXcOBS5f0+Z6RtHKIQW8N65iVvqhyRx7+Tavgd0c5UYaJFCVQvhCsO3n74Qy7bbhYnVEPQfcSlI3nVdWsT190HxC8RhZhBwRyLUnQHeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4806
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRmViIDgsIDIwMjEsIGF0IDA0OjMzLCBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+IHdy
b3RlOg0KPiBPbiBXZWQsIERlYyAyMywgMjAyMCBhdCAwNzo1NzowNEFNIC0wODAwLCBDaGFuZyBT
LiBCYWUgd3JvdGU6DQo+PiBpbml0X2Zwc3RhdGUgaXMgdXNlZCB0byByZWNvcmQgdGhlIGluaXRp
YWwgeHN0YXRlIHZhbHVlIGZvciBjb252ZW5pZW5jZQ0KPiANCj4gY29udmVuaWVuY2U/DQoNClll
cywgdGhpcyBpcyB2YWd1ZS4gSSB0aGluayB0aGUgdXNhZ2UgaXMgd2hlbiAocmUtKWluaXRpYWxp
emluZyB0aGUgcmVnaXN0ZXINCnN0YXRlcywgZS5nLiBmcm9tIGZwdV9fY2xlYXIoKS4NCg0KTWF5
YmUsIGRyb3Ag4oCYZm9yIGNvbnZlbmllbmNl4oCZIGZyb20gdGhpcyBzZW50ZW5jZSwgc2luY2Ug
dGhlIGJ1ZmZlcuKAmXMgdXNhZ2UgaXMNCm5vdCBtdWNoIHJlbGV2YW50IGluIHRoaXMgY2hhbmdl
bG9nLg0KDQo+PiBhbmQgY292ZXJzIGFsbCB0aGUgc3RhdGVzLiBCdXQgaXQgaXMgd2FzdGVmdWwg
dG8gY292ZXIgbGFyZ2Ugc3RhdGVzIGFsbA0KPj4gd2l0aCB0cml2aWFsIGluaXRpYWwgZGF0YS4N
Cj4+IA0KPj4gTGltaXQgaW5pdF9mcHN0YXRlIGJ5IGNsYXJpZnlpbmcgaXRzIHNpemUgYW5kIGNv
dmVyYWdlLCB3aGljaCBhcmUgYWxsIGJ1dA0KPj4gZHluYW1pYyB1c2VyIHN0YXRlcy4gVGhlIGR5
bmFtaWMgc3RhdGVzIGFyZSBhc3N1bWVkIHRvIGJlIGxhcmdlIGJ1dCBoYXZpbmcNCj4+IGluaXRp
YWwgZGF0YSB3aXRoIHplcm9zLg0KPj4gDQo+PiBObyBmdW5jdGlvbmFsIGNoYW5nZSB1bnRpbCB0
aGUga2VybmVsIHN1cHBvcnRzIGR5bmFtaWMgdXNlciBzdGF0ZXMuDQo+IA0KPiBXaGF0IGRvZXMg
dGhhdCBtZWFuPw0KPiANCj4gVGhpcyBwYXRjaCBlaXRoZXIgbWFrZXMgbm8gZnVuY3Rpb25hbCBj
aGFuZ2Ugb3IgaXQgZG9lcy4uLg0KDQpJdCBkb2VzIGZ1bmN0aW9uYWwgY2hhbmdlLCBidXQgaXQg
aXMgY29uZGl0aW9uYWwgdG8gQU1YIGVuYWJsaW5nLg0KDQpJdCBpbmNsdWRlcyBhbGwgdGhlIGlu
aXRpYWwgc3RhdGVzIHdoZW4gQU1YIHN0YXRlcyBub3QgZW5hYmxlZC4gQnV0IGl0IHdpbGwNCmV4
Y2x1ZGUgdGhlIEFNWCBzdGF0ZSAod2l0aCA4S0IgemVyb3MpIHdpdGggdGhlIGNoYW5nZS4NCg0K
Pj4gZXh0ZXJuIHVuaW9uIGZwcmVnc19zdGF0ZSBpbml0X2Zwc3RhdGU7DQo+PiANCj4+ICtzdGF0
aWMgaW5saW5lIHU2NCBnZXRfaW5pdF9mcHN0YXRlX21hc2sodm9pZCkNCj4+ICt7DQo+PiArCS8q
IGluaXRfZnBzdGF0ZSBjb3ZlcnMgc3RhdGVzIGluIGZwdS0+c3RhdGUuICovDQo+PiArCXJldHVy
biAoeGZlYXR1cmVzX21hc2tfYWxsICYgfnhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1pYyk7DQo+
PiArfQ0KPiANCj4gSWYgeW91J3JlIGdvaW5nIHRvIGludHJvZHVjZSBzdWNoIGEgaGVscGVyLCB0
aGVuIHVzZSBpdCBldmVyeXdoZXJlIGluIHRoZSBjb2RlOg0KPiANCj4gJCBnaXQgZ3JlcCAieGZl
YXR1cmVzX21hc2tfYWxsICYgfnhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1pYyINCj4gYXJjaC94
ODYva2VybmVsL2ZwdS9jb3JlLmM6MjM5OiBkc3RfZnB1LT5zdGF0ZV9tYXNrID0geGZlYXR1cmVz
X21hc2tfYWxsICYgfnhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1pYzsNCj4gYXJjaC94ODYva2Vy
bmVsL2ZwdS94c3RhdGUuYzoxNDg6ICAgICAgIGVsc2UgaWYgKG1hc2sgPT0gKHhmZWF0dXJlc19t
YXNrX2FsbCAmIH54ZmVhdHVyZXNfbWFza191c2VyX2R5bmFtaWMpKQ0KPiBhcmNoL3g4Ni9rZXJu
ZWwvZnB1L3hzdGF0ZS5jOjkzMjogICAgICAgY3VycmVudC0+dGhyZWFkLmZwdS5zdGF0ZV9tYXNr
ID0gKHhmZWF0dXJlc19tYXNrX2FsbCAmIH54ZmVhdHVyZXNfbWFza191c2VyX2R5bmFtaWMpOw0K
PiANCj4gYW5kIGlmIHlvdSBkbyB0aGF0LCBkbyB0aGF0IGluIGEgc2VwYXJhdGUgcHJlLXBhdGNo
IHdoaWNoIGRvZXMgb25seSB0aGlzDQo+IGNvbnZlcnNpb24uDQoNCkkgdGhpbmsgdGhleSBhcmUg
aW4gYSBkaWZmZXJlbnQgY29udGV4dC4NCg0KVGhlIGhlbHBlciBpbmRpY2F0ZXMgdGhlIG1hc2sg
Zm9yIHRoZSDigJhpbml0X2Zwc3RhdGXigJkgYnVmZmVyLiBUaGUgcmVzdCBpcyB0aGUNCmluaXRp
YWwgbWFzayB2YWx1ZSBmb3IgdGhlIHBlci10YXNrIHhzdGF0ZSBidWZmZXIuDQoNClNpbmNlIHlv
dSBzdWdnZXN0ZWQgdG8gaW50cm9kdWNlIGdldF94c3RhdGVfYnVmZmVyX2F0dHIoKSwgaG93IGFi
b3V0IHJlcGxhY2luZw0Kd2hhdCB5b3UgZm91bmQgd2l0aCBzb21ldGhpbmcgbGlrZToNCg0KZ2V0
X3hzdGF0ZV9idWZmZXJfYXR0cihYU1RBVEVfSU5JVF9NQVNLKQ0KDQo+PiArDQo+PiBleHRlcm4g
dm9pZCBmcHN0YXRlX2luaXQoc3RydWN0IGZwdSAqZnB1KTsNCj4+ICNpZmRlZiBDT05GSUdfTUFU
SF9FTVVMQVRJT04NCj4+IGV4dGVybiB2b2lkIGZwc3RhdGVfaW5pdF9zb2Z0KHN0cnVjdCBzd3Jl
Z3Nfc3RhdGUgKnNvZnQpOw0KPj4gQEAgLTI2OSwxMiArMjgxLDEyIEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBjb3B5X2Z4cmVnc190b19rZXJuZWwoc3RydWN0IGZwdSAqZnB1KQ0KPj4gCQkgICAgIDog
Im1lbW9yeSIpDQo+PiANCj4+IC8qDQo+PiAtICogVGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgb25s
eSBkdXJpbmcgYm9vdCB0aW1lIHdoZW4geDg2IGNhcHMgYXJlIG5vdCBzZXQNCj4+IC0gKiB1cCBh
bmQgYWx0ZXJuYXRpdmUgY2FuIG5vdCBiZSB1c2VkIHlldC4NCj4+ICsgKiBVc2UgdGhpcyBmdW5j
dGlvbiB0byBkdW1wIHRoZSBpbml0aWFsIHN0YXRlLCBvbmx5IGR1cmluZyBib290IHRpbWUgd2hl
biB4ODYNCj4+ICsgKiBjYXBzIG5vdCBzZXQgdXAgYW5kIGFsdGVybmF0aXZlIG5vdCBhdmFpbGFi
bGUgeWV0Lg0KPj4gICovDQo+IA0KPiBXaGF0J3MgdGhlIHBvaW50IG9mIHRoaXMgY2hhbmdlPyBB
bHNvLCAiZHVtcCI/IQ0KDQpZZWFoLCByaWdodCBub3csIEkgZG9u4oCZdCBzZWUgdGhlIGNoYW5n
ZSBpcyByZWFsbHkgbmVjZXNzYXJ5IGhlcmUuIFNvcnJ5Lg0KDQo+PiAtCW1lbXNldChzdGF0ZSwg
MCwgZnB1X2tlcm5lbF94c3RhdGVfbWluX3NpemUpOw0KPj4gKwltZW1zZXQoc3RhdGUsIDAsIGZw
dSA/IGdldF94c3RhdGVfc2l6ZShmcHUtPnN0YXRlX21hc2spIDogZ2V0X2luaXRfZnBzdGF0ZV9z
aXplKCkpOw0KPj4gDQo+PiAJaWYgKHN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX1hTQVZFUykp
DQo+PiAtCQlmcHN0YXRlX2luaXRfeHN0YXRlKCZzdGF0ZS0+eHNhdmUsIHhmZWF0dXJlc19tYXNr
X2FsbCk7DQo+PiArCQlmcHN0YXRlX2luaXRfeHN0YXRlKCZzdGF0ZS0+eHNhdmUsIGZwdSA/IGZw
dS0+c3RhdGVfbWFzayA6IGdldF9pbml0X2Zwc3RhdGVfbWFzaygpKTsNCj4gDQo+IDwtLS0tIG5l
d2xpbmUgaGVyZS4NCg0KT2theS4gV2lsbCBkbyB0aGF0Lg0KDQpUaGFua3MsDQpDaGFuZw0K
