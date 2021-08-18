Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE773F0C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhHRTrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:47:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:64621 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhHRTrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:47:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="216409246"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="216409246"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 12:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="441984649"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2021 12:47:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 12:47:12 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 12:47:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 18 Aug 2021 12:47:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 18 Aug 2021 12:47:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R33JwyvByBytTMXbKSEFA0EUU2yXeveZ3Fatb53O80StDg0gMM0dPWJS2rnInsOMtlLhFjDBJyP1n3nzvf/0uJeXM0ZA4ZhfwHhUr6Hzj/z1nseSWvIaiWceTxQJ3+OqHTZ+4HFnqG5SNdgEcmw9xbwZ2ezcx0WUvPgLkOvOSetQvvuTABtBF6BSUZGYMlnrR4GPxOIu9fP1JkmwLJWUIlbG4ybFHNkCYnBNhAu7uIns4kiH7YqVCKWqR5Mls16+94uDh6CURmpRh4y8s0z39gGCkRpsCw/cRzbtVl79C5JsBwzfu1mVMO4J/NxC98h/09xtbOuJgaA3QU9VVx7/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuUN+q9K32Aoy5WQiXZ8BJ+EAcgaWTszBkv42FAFviw=;
 b=BrL/IMRlTltjyOV8vdubEBNnI5q9zAnufKNF8qyLFauYL+iMZ4YbkrBtxgGighdpYqkaVqspqYuvIohfUXCK0VmCxSFvSns58egcSabKmrk4tLNjEw1Rur+pGBw/wJPTb8WwmihidOrY5Jg2aBitkkEW5gzqx3nHmiZnQwzHRPePIvwmh7PDu91S1eaHTG9lga+NjDCx1kRTg+oVDGc0W7wpEz5V0WRKGo2bnDsO6LVDY5pNyQJViGSww66FxJH9VoVKCXETIxxKLnwEyxj9P+GO+rc2EDYOBSLdhU8Iq1JztSMLF6ANJJj3DhFytCBgq2f5I/9ls+J8t2SS1bC/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuUN+q9K32Aoy5WQiXZ8BJ+EAcgaWTszBkv42FAFviw=;
 b=VrfPLVgug+qf0rDnp4kFyJCthN0AdZMXaTmlDlLVU8YrT32ZKFVkFnFx87wG9GuLrmFxRIwmc5TMcNCCtECdukcxooin0I90DBlip54Tl8iHasYOEIznmk+D9pJ7DRBP2L3NrG651LQmvV6g6VjaTPur8s/1V3UHTzaokPsSaxM=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 19:47:04 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 19:47:04 +0000
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
Subject: Re: [PATCH v9 10/26] x86/fpu/xstate: Update the XSTATE buffer address
 finder to support dynamic states
Thread-Topic: [PATCH v9 10/26] x86/fpu/xstate: Update the XSTATE buffer
 address finder to support dynamic states
Thread-Index: AQHXhVR0IWLgliWOpk6soLtHG0iHVqt5PxCAgACJ6YA=
Date:   Wed, 18 Aug 2021 19:47:04 +0000
Message-ID: <E134A33E-C6B0-4325-A852-E426F305F387@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-11-chang.seok.bae@intel.com> <YRzwB+fAEotDf4d7@zn.tnic>
In-Reply-To: <YRzwB+fAEotDf4d7@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da104d17-156a-41cb-a587-08d96280f499
x-ms-traffictypediagnostic: PH0PR11MB5208:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5208D937CB5B01E7F8E96AE1D8FF9@PH0PR11MB5208.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XDwsoPJ4mdirdIXgQaY0J32g3rwOkmKT3c2DAF79qosprMlX/1Xia+tYs4hT6SJeaBYpvOuaqvKXRCaH/pwNpghU3EjCuKDNAGPCyS9ILLEDjyLxRa/BYjLUv70n3CFOT0leCJDCKTxIyx086BE/nixhodtRoKFLt6YGkWj4SH+4w6prpy+PFw3a03Pupim/AgZWlH9kcGj/307PufLiDIIp/lwUcfN7ccKOKyY49PWixVHWRC9Wu275sfQM7WWri9AnrO6go19F6kaBArgyGowJp85sYj75FGM+iT5bK7/kEyl8g/i0K6hWzceM0FH5k5rWDiBFY9aMnzu33Bo2RV3P6LfFU/jXgfhrcfuapnySEJ935ZD2sJKhMCoA7DzuRuWtVtFm1Hv2c2Tw7cCRcD5MeUwi3kuh6MNlmVyG+4k/JFqM3C2WJUJ+nmVU/B2T4VgldfbpkljFov02eYdM2OTkoLX01WjygZF1gn6sb25K+WNxY/N0jArjE9cbIjT+dbjrr2E4YaeDeX1U93t6wLSaeDKP3FsQVT7MEMSdEaUUSjbjfEwmD6hu85PoAnX/EvYSgZZZHiS2qIiYIokqwA4EZIw9Cv8fbJPSGFu3lgE0kMuoSqHodlOW5YT06hAvcmJtnJmnjZMH63gSL29gnc9bOnv4ll/W7TosG4JaFKmST0FRFFnFZCY9FyZnXOVnDTvsj//35n3wq4rLjEtVJAiKcFSB9nkpx0+EuhL44hs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(53546011)(38100700002)(186003)(122000001)(71200400001)(36756003)(4326008)(8676002)(8936002)(33656002)(6512007)(6486002)(76116006)(38070700005)(5660300002)(86362001)(66946007)(2906002)(66476007)(66556008)(64756008)(66446008)(6916009)(2616005)(478600001)(316002)(26005)(6506007)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bENrMnFobUZ0bXpvakowUWI4ZlJRRUhQRXZBcUovVFl6RHJDM2d4ZUUwbHlp?=
 =?utf-8?B?ZmNyYjdaajdtZnRSVW53c0U0RDNuWnEyVEV0WVRYL1ZNbnlTam45SkZPczBN?=
 =?utf-8?B?OVpFNnFHOVNPNmJaUFlFb01XSHlyaVNFR3ZOR1pGV2h4M3ZDVFdqbUZZZlRr?=
 =?utf-8?B?TnBPZ0NSaGE2UnBOUmlib2JmcmRDQU53NnZ0M291Vkw1ZHpTN0I0WngyWWg0?=
 =?utf-8?B?aTBFTkVPZWlXSnJLejVycWNNNDVDWUowUTQwZndJTExuUlNXK01NWjd1V0pQ?=
 =?utf-8?B?d0Zta2l3OUFhdEdXUDRuSnNhbHptVnk1YXVDVnpPLysrdzY0Y1RJeHQ1akNS?=
 =?utf-8?B?UGNMSmFZbTBoRTNnVnlhdHp4Q1pHYStFY3hrWHp1aG0yQ3E5MkxMU3VmY1lx?=
 =?utf-8?B?ZkVOOHYvY0RGc3FjS1U4emNYMEE4d2JWTFM4NUNlV3d6cXJxTGtEbDB0QjJL?=
 =?utf-8?B?VGU5eTJLRXN5WjRMSkhNRkttYXgwL2ZaUm1lZHFpYlhmbXlKMUZaOFEybmxw?=
 =?utf-8?B?RDdCTnJ6Nk9CSTRubzdwMkRXWTB1d25scXVVUkM0ekRtMnZxUjJaV3lVNDd4?=
 =?utf-8?B?bmhGN2QvVjFPKzRTTE5qT3dnWUtKaDIvZlJxY2t2cHNFSE9NSmVibTM1Vzd6?=
 =?utf-8?B?d0l5MnFpcnIraWVvSkkyenVGNWZMc2ZGcklsRit5U3EzVlNmc0xWVmJWVGxy?=
 =?utf-8?B?SCtyYWVKSnlJSkdETXBEbk1CRGQybS9EZ0RnRFN0WHlqYzFZWGRRc3JrNGpH?=
 =?utf-8?B?dS9uYXQ2azZwRE9JSzRtZFlMQ0ZjZ3NUV1hzN2xmeWEvL0VpRURKVWxHUWpD?=
 =?utf-8?B?eXdMenJCUXo2NXFMNURleXZLZEtuRGJMWlRqS1pPQ0JvclQ0YkE3bGlwQk9y?=
 =?utf-8?B?K1BtSWwwVFJCTENmVmRhTEVvQ0ExcVBTai90K2srZWxKcXBMWnVLM2IzbkdT?=
 =?utf-8?B?aG1MZ0x1N0Jnc3JnazZzTFlvbzdZVWVDeDZvNVFLakV3dTdhUG5xazViOW1J?=
 =?utf-8?B?dFpOdDdnMU83K2dYcUlFQklCT21uZkEzMXdseWw0RUcxMEZPSWdYNjZNa2Nx?=
 =?utf-8?B?ZHgzc21kdDhFajllenV0ZHZ5ZzhrSjdBZ1JsMjF4bWNJdlpxWEIrSm1TSzBq?=
 =?utf-8?B?WlN0S1pwajBjK1NBbzA4bTRTSVBNZGV3ZXhnZmpXMkgrQlZ2UGtKaHVISlVj?=
 =?utf-8?B?SlBLNUNaN0kwdC8zZkZlR2hCRE9KNitPTVR4WmxaYzJKZERpY213THJ1M2NO?=
 =?utf-8?B?ZW56alZpL3dPWWVZRk0yazRNWnByMjVVUktwbm5jWmh5VFg5QnZiOEdjNFpZ?=
 =?utf-8?B?VE1LMDJtOFJlT0xPRE0yY2Vaa2N0SnhNMkRteW43ZXcwYjRyQ2NKbmJLeVhl?=
 =?utf-8?B?dEhlMkhGK2lXUjlnOVRLOUh2a3VvU2JpRkhaMEc3TGMyd1l5TGNBYUd5dGRz?=
 =?utf-8?B?MTNybU5yd3loMFh3eEdoZ3VEcmpFU0lZRURrSWIrQlp4UVBYcWltOGtTbjhn?=
 =?utf-8?B?d04zYi83UlpjMFBpVzFpeStpeWw1aCtMRVhqTXBFKzEwc0xTZHd5Y3Jkb3NH?=
 =?utf-8?B?N2RCWUFLY3ozRVVRZVdpOWZWQnVERW1Ec2ZoSzdPVFk3Ums5cGxSaytkZm45?=
 =?utf-8?B?MHRYSmlRZ3NwOUVtYWljYUtiK3cwc1VQMXpiMURSVTZQM1lTZnIxcVVGYk1M?=
 =?utf-8?B?THdhYmFmZ2YyN2ZkZWVBS2JqSlhXVXRwN2ZHUGxFeWtXd3BOZHVEMFlnekcw?=
 =?utf-8?Q?rAa33FY/86YSC01STZQDBwVIM1L2TABhCFsMLpM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B3237B3DD2C5C42AE07D5F0CF8427AF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da104d17-156a-41cb-a587-08d96280f499
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 19:47:04.6715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjsAe+eraJ7m3cQYLUZG7mjEXEeOrAj8OVvXFLdfIR8j9mqV5Tnpi6WQGrOnwrr3KrKtce4UVW5fvRxt9hT9i0R85pZGUbYMLNWL4r6iMhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDE4LCAyMDIxLCBhdCAwNDozMywgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
IHdyb3RlOg0KPiBPbiBGcmksIEp1bCAzMCwgMjAyMSBhdCAwNzo1OTo0MUFNIC0wNzAwLCBDaGFu
ZyBTLiBCYWUgd3JvdGU6DQo+PiANCj4+ICsgKiBAZmVhdHVyZV9ucjoJVGhlIGZlYXR1cmUgbnVt
YmVyDQo+PiArICoNCj4+ICsgKiBSZXR1cm5zOglUaGUgb2Zmc2V0IHZhbHVlDQo+PiArICovDQo+
PiArc3RhdGljIHVuc2lnbmVkIGludCBnZXRfeHN0YXRlX2NvbXBfb2Zmc2V0KHU2NCBtYXNrLCBp
bnQgZmVhdHVyZV9ucikNCj4+ICt7DQo+PiArCXU2NCB4bWFzayA9IEJJVF9VTEwoZmVhdHVyZV9u
ciArIDEpIC0gMTsNCj4+ICsJdW5zaWduZWQgaW50IG5leHRfb2Zmc2V0LCBvZmZzZXQgPSAwOw0K
Pj4gKwlpbnQgaTsNCj4+ICsNCj4+ICsJaWYgKCh4ZmVhdHVyZXNfbWFza19hbGwgJiB4bWFzaykg
PT0gKG1hc2sgJiB4bWFzaykpDQo+PiArCQlyZXR1cm4geHN0YXRlX2NvbXBfb2Zmc2V0c1tmZWF0
dXJlX25yXTsNCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogV2l0aCB0aGUgZ2l2ZW4gbWFzaywgbm8g
cmVsZXZhbnQgc2l6ZSBpcyBmb3VuZC4gQ2FsY3VsYXRlIGl0IGJ5DQo+PiArCSAqIHN1bW1pbmcg
dXAgZWFjaCBzdGF0ZSBzaXplLg0KPj4gKwkgKi8NCj4+ICsJZm9yIChuZXh0X29mZnNldCA9IEZY
U0FWRV9TSVpFICsgWFNBVkVfSERSX1NJWkUsIGkgPSBGSVJTVF9FWFRFTkRFRF9YRkVBVFVSRTsN
Cj4+ICsJICAgICBpIDw9IGZlYXR1cmVfbnI7IGkrKykgew0KPj4gKwkJaWYgKCEobWFzayAmIEJJ
VF9VTEwoaSkpKQ0KPj4gKwkJCWNvbnRpbnVlOw0KPj4gKw0KPj4gKwkJb2Zmc2V0ID0geHN0YXRl
X2FsaWduc1tpXSA/IEFMSUdOKG5leHRfb2Zmc2V0LCA2NCkgOiBuZXh0X29mZnNldDsNCj4+ICsJ
CW5leHRfb2Zmc2V0ICs9IHhzdGF0ZV9zaXplc1tpXTsNCj4gDQo+IFdoeSBpcyB0aGlzIG1vcmUg
Y29tcGxleCB0aGFuIGl0IGhhcyB0byBiZT8NCj4gDQo+IElPVywgd2h5IGNhbid0IHlvdSBzaW1w
bHkgZG86DQo+IA0KPiAgICAgICAgb2Zmc2V0ID0gRlhTQVZFX1NJWkUgKyBYU0FWRV9IRFJfU0la
RTsNCj4gICAgICAgIGZvciAoaSA9IEZJUlNUX0VYVEVOREVEX1hGRUFUVVJFOyBpIDw9IGZlYXR1
cmVfbnI7IGkrKykgew0KPiAgICAgICAgICAgICAgICBpZiAoIShtYXNrICYgQklUX1VMTChpKSkp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+IA0KPiAgICAgICAgICAgICAg
ICBpZiAoeHN0YXRlX2FsaWduc1tpXSkNCj4gICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXQg
PSBBTElHTihvZmZzZXQsIDY0KTsNCj4gDQo+ICAgICAgICAgICAgICAgIG9mZnNldCArPSB4c3Rh
dGVfc2l6ZXNbaV07DQo+ICAgICAgICB9DQo+ICAgICAgICByZXR1cm4gb2Zmc2V0Ow0KPiANCj4g
bGlrZSBpdCB3YXMgYmVmb3JlPw0KDQpJdCB3YXMgcmVmYWN0b3JlZCB0byB1c2UgaW4gdGhlIG5l
dyBoZWxwZXIgdG8gZmluZCBmZWF0dXJlX25y4oCZcyBzdGFydCBwb2ludC4NCklmIHRoZSBzaXpl
IGlzIGFkZGVkIHVwIGhlcmUsIGl0IGlzIG5vdCDigJhp4oCZJ3Mgc3RhcnQgcG9pbnQgYW55bW9y
ZS4NCg0KVGhhbmtzLA0KQ2hhbmcNCg0K
