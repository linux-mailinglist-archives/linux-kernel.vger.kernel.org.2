Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B029944EF79
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhKLWmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:42:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:12367 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235838AbhKLWmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:42:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10166"; a="233061872"
X-IronPort-AV: E=Sophos;i="5.87,230,1631602800"; 
   d="scan'208";a="233061872"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 14:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,230,1631602800"; 
   d="scan'208";a="584116854"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Nov 2021 14:39:18 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 14:39:18 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 14:39:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 12 Nov 2021 14:39:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 12 Nov 2021 14:39:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/uxkTJopKORqszJ4Tv76xzD/gClzZg8xkdUpnF7eVWh2ZZvhaMH05cjYr5DvFxhPBRzWi0xC4zSFhqoDtP210XR5pcmGKuaDWa55wGmx0K1RGd0pBgwb0GnklOI9blCmuy9pZ5tiZ3Is49XXa/p9ciXjK3oTvX8pE33zFP3ZbNL6AVckiF6fJb7tlyAN68LZOXWjZ/NDce2a03YJH83GV+M+G7ssSrU+kAuvHrZGSl3acFwbuxby6pBkW8vGkJ0QgYR9tu1dWgbZQoq2my8WHP01htG/mFB3OKGaCoXt6nCvCcpfSAA+FnvKrEtpqXb0Gj19JDjDxImjjt+0l91/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47NO2bORBlhNN6ao7jbTZeL0+8JZvDJvXIbX/zgH7D0=;
 b=i7wcZ7MAm6/N8Wklq8w/ghUwrL1ykuogct3qECYs647Uv88zhFR4i/eoBmXD2pm2JjvRR7eC9EIfXmmrV56D374xPRfELg87R93Y56VVmDzhCirDaEMvkRs+i98ISrxDxLI85Q7fbc4bxCyQ22TqJFc00JQxcsuO4JsQLKajsO0CirYDCxj0i17rUZaAYx21OYdpnym82MTXznYp95KGL2Cf+87ISIsxVvreUsQR1fxXpv0Jrfca+jxjp8QsmGgVmI9JafRis27pjFIIvS8XdZWNbSoXG5K5S1kjPzgJYvJeNsUj4/hdtPe8p1Npg/a569mCAMyxpEenCKPOI0PPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47NO2bORBlhNN6ao7jbTZeL0+8JZvDJvXIbX/zgH7D0=;
 b=ebU/h3Ml02jTGHfpCq1wsRF2tLLpG2UVCTN6tgXApbuGBD5khpj8ZCCyppDoKFDNdqFwoep9uwCKCkxxvob92V72rUN1Wb6+EN18lk2pQXharFBiw/SeMN12eEO6+V11M3gDCK3koSFXQD186vNYOw5J3YFiNXvQBgQHVOdHgbg=
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB5090.namprd11.prod.outlook.com (2603:10b6:303:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Fri, 12 Nov
 2021 22:39:11 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::bd76:b278:9392:fcd5]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::bd76:b278:9392:fcd5%3]) with mapi id 15.20.4690.026; Fri, 12 Nov 2021
 22:39:11 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "Lutomirski, Andy" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH 4/4] x86/mm: replace GFP_ATOMIC with GFP_KERNEL for direct
 map allocations
Thread-Topic: [PATCH 4/4] x86/mm: replace GFP_ATOMIC with GFP_KERNEL for
 direct map allocations
Thread-Index: AQHX1uvEp8oHH7geiU+Ue+NRNU6yKav+2mAAgAD56QCAAKoXAA==
Date:   Fri, 12 Nov 2021 22:39:11 +0000
Message-ID: <29f9155d0d164d349784b4c40cd806bc1129005d.camel@intel.com>
References: <20211111110241.25968-1-rppt@kernel.org>
         <20211111110241.25968-5-rppt@kernel.org>
         <5aee7bcdf49b1c6b8ee902dd2abd9220169c694b.camel@intel.com>
         <YY5eYEzsp0UKn4Xr@kernel.org>
In-Reply-To: <YY5eYEzsp0UKn4Xr@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de75d308-d0a9-4add-74f2-08d9a62d3f4e
x-ms-traffictypediagnostic: CO1PR11MB5090:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO1PR11MB5090F4EC63F5782DE4636959C9959@CO1PR11MB5090.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H2KdU+YoOnwi7hqEIO0HVKn86y3DBk7oDgEE5TBVWQ+l5xMQlXPlCCF5wAtonGG3qqcPuYOUQTXCVUOUtZ7OvRpOQOKk2eu8X1Bl5olD4TtmDr4vJ+r8R2lWlelPANNSdNyX/0kAPfcus7RrDSqw4xQS0vmehEOzytgSB2i0+EeaqsemPvSrXUavNtNBM6SYocjR46rAezY5FXgy8It8xdxtCNjSXTXFkO0u0FFujbp9zPqX3gQN0mnfXe+KxfkOqlm7+hhdblf0/o0ZGEhuLEXWk6+2rtjrAWkQuHhVe0JQUQnVvhRKpr4ffS3pavv83D0hMhHK1GGtb3b5Ckya/z+OXNaasGNlLkRwuqagkPFRtb7tXah2skWmN8kDm2ETdhrz0KtgrKMBoDsHu6/XbI3Pz4gNyvINGhKWG6aGVN2CW8hlswneOjV59sLmS+TDKOJh/MsaurFamrx/YlWRLNWgN4FDNcGKMPxxhUn4NgFY1Ca9/JXksbV+QHPLwCrunzP9hAweKhYI65t7pZwxB6WEItiYZq2f4R7HfkOvqlc8Ycpz248FQ0zQocBoZtCVVxisnKyKRnR/hnMbgtsYqxzg6jqni7PIQJpGWIBRqRJXVVg5kTt1SW7t7oNfog/s7yKtx1s1ohm6djVY+Se57ngQnoMKVNiGB2MwMZqV0hynXuC/Edx5tReExdEr1ojzE6a7pW9AVmqlDurWFbCoCxQayIdOSreZQkOxlyjOTqo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(26005)(4001150100001)(6506007)(316002)(83380400001)(6486002)(5660300002)(2616005)(54906003)(82960400001)(8676002)(86362001)(71200400001)(4744005)(186003)(6512007)(2906002)(508600001)(66556008)(4326008)(66476007)(122000001)(64756008)(8936002)(7416002)(66946007)(38070700005)(36756003)(38100700002)(66446008)(76116006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnI2MVFTdWFTMVVtMWwyanhjU0ozUXdrUXp4NTJnSWI2eUI5UzdlMSt3N2NU?=
 =?utf-8?B?QjFCWnIzMUc0b0g4QzhxOThLbi8wcURIWWtNbFZpZWtTWFl5OGNFZmZ3cmxC?=
 =?utf-8?B?ZWpQUEpoOUszMHVzd0duVUpydFNXNjhkT1ZreWlXYzUxU28xdFdMMmlMZUFj?=
 =?utf-8?B?Q2oxRFQ5MDJxWGhYcWJvcW13emFERjBYUzAvUWlpeEpOb01QTTNyNk5LQ3F0?=
 =?utf-8?B?bGM5UG1sT3BEMnVJYVQ5TzRXcndvNXcyZjRSYkEyWi9ZdDY2M2c4dzBteS9R?=
 =?utf-8?B?bGNnU2hUT0ZVVktyWVZPVURXMkhZL1kvTm9wQTlkb3FTckpXQXRrL1ZIR3Uw?=
 =?utf-8?B?V1hRTTB5aE5SSEJHUUxtSzZvTGozYkg0WWgyY3gybXNxay93QnNmbnpOYVVo?=
 =?utf-8?B?UUkveWJ1ZGMzMjhzVTNtM292VTdUQVJoVjZIQTVoeDhRSW9BaGxOc3RXMW5U?=
 =?utf-8?B?bndjLzlqS2FSZzR5ZVZvNnBDRGlHdUlTQWFOcm0vWnJmUEc2WDFXZTVzckcz?=
 =?utf-8?B?WUVnckV3TGhwRHNIMWJBUmJBMDRZYlFIVE80WW5PWmt5YkM2bHJLdTE3Ykt2?=
 =?utf-8?B?SXZ4MTJtNGVHMVJ1RmxxMXV0NCs3TkFCa1lvK1U1R0NiVXR2SWtDZHFlZ2or?=
 =?utf-8?B?RXdjZlpGNFgxR24rSkdyYzZFQ2QzYXJNQjN1QkJscjhaQ0U2TEtGLzh4L2t3?=
 =?utf-8?B?Z3V1dTBxdG1XK3BVclRobUw2NG81a2krM3lKK3h1VFo3NDZ0RUhCQS9CLzY1?=
 =?utf-8?B?TnNZVzRBS2NqVkRON3p5N2VmdnpPNkVMZXlmZkdGVnpyaWw1NkVCZHN3d2RT?=
 =?utf-8?B?TU5IN0R1Qlk0NkV2Rk5NbWdUZTY4YVgxZy8vQzhjNERoZjBwbXQ1OEt4TDNj?=
 =?utf-8?B?QjJXTXpGZlBob0Y0TFlwRjZXbGFTRkZGMThTamdwNmNOdWZ4Q3VhTU41dEhY?=
 =?utf-8?B?RUFaY3VuQTRHR2xsTzkrOTduelJnUy9KY0o0L3hPOUhrbG50aVZ1c3ozNWYw?=
 =?utf-8?B?UHdEOStsZ0FIYjJyYUUrYVVoTzNQZlpiSWdmUGlBZW1yVS9OSDhqc0U0Ym1v?=
 =?utf-8?B?enpzOE1SUkZ0QmxzcDJyOEV3ZFhWZkFXcS9wbkQrbWMwVGRDRVZTTm1ISzB5?=
 =?utf-8?B?VjFGZ1NjOVZnS0NQTW5rSHRaQURVSCtLNXUzQy80ellYRC9pZmNSbWNsay9Y?=
 =?utf-8?B?SVFBcERpUXhINXBtRHViQjFRVnk4ZWdEUEgwUmsyRVd3cUpIajUvbUJPTkhQ?=
 =?utf-8?B?UFVCV0lBeDh6RDdkem14N2d0L3lNQ3pmUEJmbDZPb1JweEZRdW9HYUtPK3pu?=
 =?utf-8?B?WGlvKzQ3RmxGM21SdmhCOWdPKzByRzkxVE1YSUhxei9jZWFBZTdPaWdxU2NV?=
 =?utf-8?B?N0htTWZ0NkJreUJYWVpaUmdTc2F3T1ZpVTdVTWhJeWNEVS8vbGp6WmNyTERs?=
 =?utf-8?B?Z1FWSGpGV09PNmFmZ3lPK1BaZm1CVHhmN0N3Qm5HQnNvcWIyWlVreDE0SnhV?=
 =?utf-8?B?Qm9zN3RSdUVjbndXTFV0RWxvMmdwWGRydGZzSkNLRE9BZUZFdDh1NWo0d3dl?=
 =?utf-8?B?U3lHR3Q5TVdwRzIxandUQUtPOXFwYVBOQkZXMnVqdmNjSzZRUGU0eFlaM0dv?=
 =?utf-8?B?c0lBZDVYQjNnVmNsV0lwNnYwOWFCb3BWVUdBSEJ1SkdwQ0JlL3JRU3NnR2J6?=
 =?utf-8?B?bFg2VGxDSWNKUWpkVHM4MHJUZFI3TU9XRFJwcll3dXNscUdVY1hJN09ra1hS?=
 =?utf-8?B?UEpZU1BRa0dNVmI3Um05ZFBtVFBEemt6SXE5cndobkt4UDBROWlDZ1kvT0gy?=
 =?utf-8?B?UjJRZG1wVnkvaWV3YjJqc0NRVFhpbHkrQS80NTFBMGlCdWw1ZmkxK0RKcVNP?=
 =?utf-8?B?QVRrcERYeTdJdEhPTU5nbm5rZ2JmcUUzOFBPRlRocExNaFVLTWxoWWNBVWs3?=
 =?utf-8?B?Ymx6dDdCZHl2WU1QdXByTGttdHNRTWxtMHNNd3FhbVpTdVIybENQL0lEcFFE?=
 =?utf-8?B?ekhUdi9ZUTVjZjdrekJjTkU4WVoyZUFuS3c2RVhHMVJnZUlqNWtaSVJnNEdr?=
 =?utf-8?B?bzJaU2FNamJOa2RHSlFGd04yVjIwZ1d5TzBqMzNvWUxtOTFJWEI4WStJZURk?=
 =?utf-8?B?OEc0a29GaVVGcHJlSmZnYndMTzZtNU1NZnRaYUZHNDJVRTlRTkZwUXVrZzhD?=
 =?utf-8?B?b3hHa1RxT2ZxZFpjck9xRG8zR29Ec1E4QXhqcUNIOWs2SjZ0eVllRUZsdXQ3?=
 =?utf-8?Q?oYz+65f2mAhj2JrjY193tq+xk0ICcxGKtdoPR0MU54=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63E9EE560B3A17419E1DA4AF6E78C65F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de75d308-d0a9-4add-74f2-08d9a62d3f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 22:39:11.4541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWDMl6zZo2QuI1wCLeS6U/rRUkm6PBMWmKqUtYWsbzjxFMbgfq/IH9hUjeLyQvm6u2yocl7kbPIib+qltGQNh8rzuW05NDnLMvPBM+HGy6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5090
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTExLTEyIGF0IDE0OjMwICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBUaGUgZml4bWFwIGlzIGxlc3MgMk0gc28gYWxsIHRoZSBwYWdlIHRhYmxlcyB3aWxsIGJlIGFs
bG9jYXRlZCBmcm9tDQo+IGdwdA0KPiBjYWNoZS9tZW1ibG9jayBzbyBfX3NldF9maXhtYXAoKSB3
aWxsIGJlIGVzc2VudGlhbGx5IGEgY2FsbCB0bw0KPiBzZXRfcHRlKCkuDQoNCklmIHlvdSBjb25m
aWd1cmUgQ09ORklHX0RFQlVHX0tNQVBfTE9DQUxfRk9SQ0VfTUFQIGl0IGNhbiBiZSBsYXJnZXIu
DQoNCj4gDQo+IEknbGwgc2VlIGhvdyB0byBlbnN1cmUgdGhhdCBwYWdlIHRhYmxlcyBmb3IgZ2hl
eCBmaXhtYXBzIGFyZQ0KPiBleHBsaWNpdGx5DQo+IHByZWFsbG9jYXRlZCBhdCBpbml0IHRpbWUu
DQo+ICANCg0KSW52ZXN0aWdhdGluZyBhIGJpdCBmdXJ0aGVyLCBmaXhtYXAgcHRlJ3MgYXJlIGFs
bG9jYXRlZCBzdGF0aWNhbGx5IHdpdGgNCmxldmVsMV9maXhtYXBfcGd0LCBzbyBzZXRfZml4bWFw
KCkgc2hvdWxkIG5ldmVyIGNhbGwgc3BwX2dldHBhZ2UoKSBwcmUNCm9yIHBvc3QgYWZ0ZXJfYm9v
dG1lbS4gU28gSSBndWVzcyBHRlBfS0VSTkVMIHNob3VsZG4ndCBjb21lIGludG8gcGxheQ0KZm9y
IGFsbCB0aGUgZml4bWFwIGNhbGxlcnMuDQoNClRoYW5rcyENCg0KUmV2aWV3ZWQtYnk6IFJpY2sg
RWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg==
