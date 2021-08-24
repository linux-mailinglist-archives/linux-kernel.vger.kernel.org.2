Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8D43F6749
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbhHXRcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:32:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:42352 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241594AbhHXR3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:29:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="217365210"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="217365210"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 10:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="464506845"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2021 10:23:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 24 Aug 2021 10:23:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 24 Aug 2021 10:23:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 24 Aug 2021 10:23:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 24 Aug 2021 10:23:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElfAQVGgOmlpIKyx6CzYxEI8veE7keoxat2t6K7S1bcDxzqFExgMUfe6uvNes5S9+sdmLBpljYE+nlcLDJw7G0kI9xkSz8+nzk4nXETwfqa5Y3vqVEZJ9oObBfihW8vh+4cWwpM99ziVcP2bIoy6AaZ+RgTbH2OyLTJ5NB6PbgzEnsEB1N8OXnwxf6UJE3IRBodxHcrtQGw0WFQy1Ms4F2HRuf4vnD6M0Heqvgf8fye+UJGUc/RonV8aV8NH6SsL9yRVVi9f2I1nXQr+zStziNy1aY65MTZQF2DWYlgCN3+NW+yJJWhZXmahybIcJq557TxMJ50VYktR046dPASsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVjX7JNYqcQds2oX5XrcZzlmam5geihVw3siq5XYBmg=;
 b=Qb3aWd3+rNURix06NTY5Z//Z9Vu1veYmMgxETFi7fQy+2e5BVCPbyPxI6FuT99N6ZePY9NOCk1v60gfPl8wOwzVKkgbu4EloDT2KTAcLYfWU3TQ0AR4BbY6DNlz8e8pDsdxDn6EZOSIeYnLef3qdYpIZfkcNN8NzAeiqTMNJ0FQ3k7ISAIMszUeI4njRFvrw7+LoauGJE/5DCQehTWlcoK8F/dFIU4btvDluQEla7F9hfvNZ3VgGxyy7mtdJ4VW7A0fcyJ+yfDtXPbaCzp54hJHtV8Dppia0Dzstenbma8b7KPblnCrvA9gtic1v7gUUJrrJ8k7lI7E5AzR1B8jaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVjX7JNYqcQds2oX5XrcZzlmam5geihVw3siq5XYBmg=;
 b=xMTSI/s68Y34ibvHc5hh+9qhLwIXqDE5xHzgPBHRoPHX/htg/Saf65S+ytbhGYGaADvlPBJs5xw6K+kXMRa/8fJ/NfTaT/9fsgLSGmcYlkHwsPCeGSz0zQqF7NgkofgUyW0pC+0iGb7r2kwr5k82/2l+k61S2aDs6rACid1u7oM=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA2PR11MB5067.namprd11.prod.outlook.com (2603:10b6:806:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 17:23:04 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e%6]) with mapi id 15.20.4436.019; Tue, 24 Aug 2021
 17:23:04 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@linux.ibm.com" <rppt@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>
Subject: Re: [RFC PATCH 3/4] mm/page_alloc: introduce __GFP_PTE_MAPPED flag to
 allocate pte-mapped pages
Thread-Topic: [RFC PATCH 3/4] mm/page_alloc: introduce __GFP_PTE_MAPPED flag
 to allocate pte-mapped pages
Thread-Index: AQHXmCJlgwCR8xPK80+nkJjgy0+lT6uBivcAgAEVbYCAADwngIAABLYAgAAH3YA=
Date:   Tue, 24 Aug 2021 17:23:04 +0000
Message-ID: <c7ae898069360aff581be5eebeb74c0d03bb3bde.camel@intel.com>
References: <20210823132513.15836-1-rppt@kernel.org>
         <20210823132513.15836-4-rppt@kernel.org>
         <889bdfef8b4acbe840668f27782c3d39a987c368.camel@intel.com>
         <YSTt9XEDfbPOpab4@kernel.org>
         <f4a428040f822d7181acfc6c1658173373f28e40.camel@intel.com>
         <YSUkXqC7P+a0NZeE@linux.ibm.com>
In-Reply-To: <YSUkXqC7P+a0NZeE@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db2ad3b3-3a0d-4a8a-ba11-08d96723d4dc
x-ms-traffictypediagnostic: SA2PR11MB5067:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB50677344837A5EC3DBD7A148C9C59@SA2PR11MB5067.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jEzuT5iEfPMdr0O5tNJAZCFatZ/s9m3GbeLfwEqidxHTbsN0+g7Xwh4Szm8E3vKsM9s5/9BwduBP6DW/tMaRAeRE7AgWP2r/kSVL+/p5pvtsw2kNNs38LWPfkv7HDrZoRi01V/DstwiYj2C5LYievuLfseQw6fbWC5adFIdOc2WZ3++eDpWxGwGjXORfcopmc532LwLglS89FZWTxMZAPXe0/LlK6KZniBPGTZNe7WX1WSpOuSiWzSAGNjG0Gjqc9U9Hkn/BYk9Geq6TrVdZTRQOxCeFPe+jlxpfJTAMYPQylwKGHqtrkerA24GT75BSf+I3gt9AIY3qFL8bCmOaOHhi8p1EyZ2VTu4gG/Jrs3HU+jGlghDebFq2lA9tFSWUE0o1TDXIzH/IVKKIZad6flUN3Nit+N3I8xZvzv/iKYGuDnh1LMOYNmYUwTTXvwllQugEO5MtllTZmD1NQLHCD1vPoxZJeU4ACpqVUK5DINdR3gVv7fswxE7n0AkmHSyRiL2KPf8jPDg+YiE+OynuUJG0ANkTtEDB4p4RT34NsPqJKofBIQ9CGtyEaEBMDLs67LPZoCGaVcEXQUpiBAAE/796tIi0TH9d2M9Umlk5enJbBpuhahyHzV8npN73vnUCOpL/TV2vkBHOiBZRu2If4nzEvzSbLaINpTv8gx4A6dauS3L8Ky8MjUzv3F29sjsAaj+UkFHymQv7p+tMy/NIFpfFxsZDMX2BBlnws+xPfM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39850400004)(346002)(366004)(396003)(91956017)(71200400001)(26005)(76116006)(2906002)(8676002)(6512007)(316002)(2616005)(4326008)(86362001)(7416002)(54906003)(36756003)(64756008)(66556008)(122000001)(5660300002)(66446008)(6486002)(186003)(38100700002)(6916009)(38070700005)(66946007)(478600001)(6506007)(66476007)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3NUUEdqM0VodkdIOTh1bFhKN0VaQzdMSGE5STlUY2NqbnhubGhNRHpNWVhL?=
 =?utf-8?B?QW00S1ZXMS9XQVo2OVZJZit5M0RNWG1mMjNNV0k1c2JRa2FiZGtqdTV2SzEv?=
 =?utf-8?B?QjRrb3pBekZBUmdMdHZwcmdjYmNoMjQ0VEFsZXNzc3hlTlZDbTZPRjh5VnhX?=
 =?utf-8?B?L29oR0dDTGZ3Zlp1ajVnT3J1dFI3amJTcTF1KzZjUmgzdUNDa0VEOXhJMHIw?=
 =?utf-8?B?NEhDZmNSUUpidFQ0UXFaRTRpQlVoeUl2dUxKekk0RUV2K01OblpKZmMwT1I5?=
 =?utf-8?B?dTB2cnJ6eXo2M1JNaGdCbHlBMDRieUw4ZENlY2ZYVm02SWVRK1VROEhjOXRv?=
 =?utf-8?B?MkF6c2FJYWV5YlNBeHRRY3dUcmtpMmFKcnErcXdSSFdSWWhsTHcrcVI2dEZm?=
 =?utf-8?B?Nyt4ZUM1RW5scHhIN0VHZXUvL09UZnVLbGhlbGVvN2lNaTVsczRFVXlEcWpT?=
 =?utf-8?B?c1dMdGZ3T28rR0syWldMcnI5bzVURjJ0OXk1YWRVb3JhQndBc1ZuTXVERDY0?=
 =?utf-8?B?NmdQcE5IMkJYQTRqK21zcGtWb1drNEVtVzY4b2ZNTDRkNXdaY2RqSTBiOVFs?=
 =?utf-8?B?OS9RVXh3emFCY3p5VFlFOWp1Z1VETTdHRWhKWU1IRmJkRlpCVUtMM2VjdXhX?=
 =?utf-8?B?TEFOcnhSTWkrWlFHNVNqRG9qSzlZNE5yUjNScUJqQlBMZDg4NWlnRHNyY1BY?=
 =?utf-8?B?cjduSVh4UCtmbFlIQWplK20vTmhIZG4rYnhkelFZa1VZdlFiTlFkYmVUdWNy?=
 =?utf-8?B?Z1VlZWNHNHRGVFBXTkovWkdUWnNYSFBwamZ2dUZpZmJRQlFMZGN5ZkovUlNH?=
 =?utf-8?B?QzhRU3cycHFKcHZ0cHVzY0pnbGE5bGVPcUNZeUdjalJ5YkhUZEVFQk5Rc3Y3?=
 =?utf-8?B?UXFmNW9VMXFvOXhIQ2dNOFRiVDFCUGREcW9ZV0xNNXMrRTE1ZEZKamo2ZHlq?=
 =?utf-8?B?NTFvRk5aZ1Vtd2JKckRrWVVMeDFZUkJGaE0vVmVRZUhHSDRiTjFPeXBKeUJW?=
 =?utf-8?B?YXFQSWU1VHJTeFF4d1lkOVNBQXFHMUg1dlM3clREcGE2cjFrSWR3ck5IM1FF?=
 =?utf-8?B?clZZTjZEVTErakJ1UHRiWEo5NXRPaTRVZ2dWL2VSOUFKSlkzQmNaQ1dYakdT?=
 =?utf-8?B?Tmp2NHR3NytzQ1F2VDZ4UC83WEFCRklOY0dvRkYxSXdkNGxTVklKS2t1eURS?=
 =?utf-8?B?QnY0OFZncUZQYmEySkNZQzZ2QmJjbUI4Q3JQZk9ITUJMaFNiUjBCanhYKyt4?=
 =?utf-8?B?Mzd2TXNhYmxkMmNKQzhjb0xSSnlaeG1uajdqR1RVTThYeFJUSEFYS3lCaWhY?=
 =?utf-8?B?WlBpVlBqMkJRRFpRV2NSazdKc2JBNFJXcXltb2VyRFZmOXN1TkQ3SG9Ia2NY?=
 =?utf-8?B?S0w3NFI3UGllUStib1RRMHVnbjgzZDFkSmNpUVhGaHFPakVqUktKaEtWU2VI?=
 =?utf-8?B?TUorYW9DeWdDeWgrU083L21HZ0h2SnVvMW1aclFoR2JhVU91WGtxeHlWNmVF?=
 =?utf-8?B?cmZaR0U3UXFBaUFnUTJrN0tRQ2JtVXE1eXJod3Q3SzFkbGVoS0lFYWtpNWQ2?=
 =?utf-8?B?bDFFOFU2cFhYdElZU3RscXBLSXp4b0gwMmgweHR4Mk0wZlRMMlJ6S2hOZnRh?=
 =?utf-8?B?QmJIZnFDdUFKR2NYWEtxaTdNQUhnUXhuM2RVSkNtTlFESVRaVWtEMmZDNC9T?=
 =?utf-8?B?L2xSK21NMXBlNG1hNVlaOUh0TFhaRk1rMkZyeTZLVWxDb1JlSm14OXhycTZk?=
 =?utf-8?B?OER2TklLTksxaXRPY01iTFI5K3lwK0dWZ0FwYlZKc1A4WUNFeExjQ1d2YXZO?=
 =?utf-8?B?aU1Xbm14aldmZkpTVDErdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D97B8A0D54270B4F8D4C247603A3D9E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2ad3b3-3a0d-4a8a-ba11-08d96723d4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 17:23:04.1757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnspzhB3d6Sn/wrnFLhI2NtLv/OwH6B6/7Ym2w1oaJJweCmFn0DslcykvrCzIxf6NQbM062C1ssoU+GWz/LCzlJAgQ9MX9iht2+cu2+Et1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5067
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTI0IGF0IDE5OjU0ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBUdWUsIEF1ZyAyNCwgMjAyMSBhdCAwNDozODowM1BNICswMDAwLCBFZGdlY29tYmUsIFJp
Y2sgUCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjEtMDgtMjQgYXQgMTY6MDIgKzAzMDAsIE1pa2Ug
UmFwb3BvcnQgd3JvdGU6DQo+ID4gPiA+IFdlIHByb2JhYmx5IHdhbnQgdG8gZXhjbHVkZSBHRlBf
QVRPTUlDIGJlZm9yZSBjYWxsaW5nIGludG8gQ1BBDQo+ID4gPiA+IHVubGVzcw0KPiA+ID4gPiBk
ZWJ1ZyBwYWdlIGFsbG9jIGlzIG9uLCBiZWNhdXNlIGl0IG1heSBuZWVkIHRvIHNwbGl0IGFuZCBz
bGVlcA0KPiA+ID4gPiBmb3INCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGFsbG9jYXRpb24uIFRoZXJl
IGlzIGEgcGFnZSB0YWJsZSBhbGxvY2F0aW9uIHdpdGggR0ZQX0FUT01JQw0KPiA+ID4gPiBwYXNz
ZWQNCj4gPiA+ID4gYWN0dWFsbHkuDQo+ID4gPiANCj4gPiA+IExvb2tpbmcgYXQgdGhlIGNhbGxl
cnMgb2YgYWxsb2NfbG93X3BhZ2VzKCkgaXQgc2VlbXMgdGhhdA0KPiA+ID4gR0ZQX0FUT01JQw0K
PiA+ID4gdGhlcmUNCj4gPiA+IGlzIHN0YWxlLi4uDQo+ID4gDQo+ID4gV2VsbCB0d28gYWN0dWFs
bHksIHRoZXJlIGlzIGFsc28gc3BwX2dldHBhZ2UoKS4gSSB0cmllZCB0bw0KPiA+IGRldGVybWlu
ZSBpZg0KPiA+IHRoYXQgd2FzIGFsc28gc3RhbGUgYnV0IHdhc24ndCBjb25maWRlbnQuIFRoZXJl
IHdlcmUgYSBsb3Qgb2YgcGF0aHMNCj4gPiBpbi4NCj4gDQo+ICAgDQo+IEl0J3MgYWxzbyB1c2Vk
IGF0IGluaXQgYW5kIGR1cmluZyBtZW1vcnkgaG90cGx1Zywgc28gSSByZWFsbHkgZG91YnQNCj4g
aXQNCj4gbmVlZHMgR0ZQX0FUT01JQy4NCg0KUHJldHR5IHN1cmUgaXQgZ2V0cyBjYWxsZWQgYWZ0
ZXIgaW5pdCBieSBhdCBsZWFzdCBzb21ldGhpbmcgYmVzaWRlcw0KaG90cGx1Zy4gSSBzYXcgaXQg
ZHVyaW5nIGRlYnVnZ2luZyB3aXRoIGEgbGl0dGxlIHNhbml0aXplciBJIGJ1aWx0IHRvDQpmaW5k
IGFueSB1bnByb3RlY3RlZCBwYWdlIHRhYmxlcyBtaXNzZWQuIFNvbWV0aGluZyB0d2Vha2luZyB0
aGUgZml4bWFwDQpJSVJDLiBEaWQgeW91IGxvb2sgYXQgdGhlIHNldF9maXhtYXBfKCkgYW5kIHNl
dF9wdGVfdmFkZHIoKSBmYW1pbHkgb2YNCmZ1bmN0aW9ucz8gTm93IHdoZXRoZXIgYW55IG9mIHRo
ZW0gYWN0dWFsbHkgbmVlZCBHRlBfQVRPTUlDLCBJIGFtIGxlc3MNCnN1cmUuIFRoZXJlIHdlcmUg
YSBmYWlyIGFtb3VudCBvZiBkcml2ZXJzIHRvIGFuYWx5emUuDQo=
