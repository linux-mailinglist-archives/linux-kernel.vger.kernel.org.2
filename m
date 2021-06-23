Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E3C3B207E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFWSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:45:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:12870 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWSpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:45:34 -0400
IronPort-SDR: HMl5yYmxjmttXvOqNeB5nPGwxv9hinzp5idlvhyNYz+z7hbF/iJTcKRFXIx3DT1m6bd6tFKGJy
 X9NN9FGMD5Jw==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="207142911"
X-IronPort-AV: E=Sophos;i="5.83,294,1616482800"; 
   d="scan'208";a="207142911"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 11:43:16 -0700
IronPort-SDR: LFf3jXu1S2BrTuGDUYYcv8b9N4Iy4GdI+R9jY/IEjov7709NC6DFnarBmtTkwoId3CDwNp4Z73
 cV21yM4u7cZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,294,1616482800"; 
   d="scan'208";a="557066372"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2021 11:43:10 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 23 Jun 2021 11:43:09 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 23 Jun 2021 11:43:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 23 Jun 2021 11:43:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 23 Jun 2021 11:43:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgV8/RPJeyDZ/x9EuYzLTXCeJd45D6/MV97lExG3mo3SboHSqmMIgYZogVYWa1hb4IAG17iGDfOom8x6etoGDRpwjKgO50b8cmAnLJ8e3WOUoBtAYtGTgGZtenbluIHVCuD1Y0A85WpHn8rsK04dWSvuE/Cu7zXJgvj1KO1xU1rd6i+zIcWrgqmQFtVOWpcDNB9skxPm8o7sAzPtP/K92N3XG9mRAFueq2zvIVR6744DUTW2vgHu3XTUmqG9FxDhm3cizDHBoijlb003VwGHk8n38BbgENvj6/OWdgv8qxgIXHiBaxa3YUmB2OlGDKOgrshhgJZq/0VYHwEXLuASNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ8ZPx5i1lMpue5zXJBEbeicOiWgWFAskGehE8Gt3lQ=;
 b=KlaETO8B3w9m4nEMMHNZ3TRjnNpvGlEmcPeMHG7+2IyMn/5M5IRx22sXW6PZSIi3Q9Ha+239IoPxqLTB638DjnCRSdGhLcT/AHmhdFJbQXh+wIFt+N0AvhWCMRO5nFNYpHEsYGeDAPSCIyIphamZ4i3UiIJ1xheAltX2lnbNtHnLsJzuo1HUxZXX+vqPdp8P6SoujWFC+loR3lYB/nAYYmHPWS9v3W1Q24w6nEeGIs01zAYIzz3ZjMCZEzM8AQWPf7wUOBG7Jh4mpV4yIcKbkg8YSnVXo0LC5dOrljfpEPGIpFJr5l03ac05P4v4WgzzuJ+Il86wfvxdjFZKPFgbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ8ZPx5i1lMpue5zXJBEbeicOiWgWFAskGehE8Gt3lQ=;
 b=sbVolaNV2kXam3VSd6EhGo4alndkCwIq7qRD6pVZ3AKIYGb73gtJlBY3k9HIALywPFaHMY2Wf6aK/kaP+5Ok9lCuD76d0VU1gVzILFdrSHrQ5cY2zsAiZffVSM5gLEOwxRuP6bJSMAsGSuQj6K2DKs3+/9xLki87PfPjfFEH/wo=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 18:43:07 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%6]) with mapi id 15.20.4264.019; Wed, 23 Jun 2021
 18:43:07 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>
Subject: Re: [patch V4 07/65] x86/fpu: Move inlines where they belong
Thread-Topic: [patch V4 07/65] x86/fpu: Move inlines where they belong
Thread-Index: AQHXaCqhy+HjV0Zu10aNfJwrDnmffash7t+A
Date:   Wed, 23 Jun 2021 18:43:07 +0000
Message-ID: <ACC99D77-BA38-4E13-B6EF-44C9F915C442@intel.com>
References: <20210623120127.327154589@linutronix.de>
 <20210623121452.023118522@linutronix.de>
In-Reply-To: <20210623121452.023118522@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adbb0b93-fe9d-40f8-42a2-08d93676be1f
x-ms-traffictypediagnostic: PH0PR11MB4775:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB477558381E1A0A03953057BAD8089@PH0PR11MB4775.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eST9kiXEGaIXYZWybQ57/0SZz6ue0T/HCTElYDyNZOQV9arCqxFiXeYcyvLR5iREf/O4cPD80O48huppa3BRJirB70Cnu/A6U7Dnc26OeK5z6CTtyJAkRPXDl5/ICdZ+Oj2LV+Gw/zHr8TkdNv9wbfcQu6KR0mMVhzHW0cIsjpcohRKYOK6kGFLMZVzhmLhYYh0j+hGg4kQ35dAvZHyE5xrCQGaoT8IwNOaZ95yHP22a6YaZj9GniyDbaVL0Ei7ufsBtYDI29+MFoHlRm8mRROlO8pkmwa9RLxQn57hf2Kpm1lgSrGGt44i3MWkXRM0JRmPLRWorvqMyyJXEqSducSVlZi8NM5mp6r34xfgjnixkKE+uHR7PvxrLhlmP6gQ2dLaeKqONSfY5uEKbC8x3ltSbUQyhqrV/IW2fkOAMq9/hrncZ/pLtQcCWU86M4t2Sw8Guf6eiIVWtEgZmO/I6sB3I54Jir5DaLhSIfURGSXDlCavdKWGPQFYdTORYNid0BfCArmznwiFCGoV1Mm5OaqSShdTbQwrDAnZOeGR5qUchBad1rQGC0zrIsGWYNVfFq2V2MA1xR/8oCu+VND1lr9c3B2aDO3z6HRbfiTPHKWwlBFMiKNe+xHlF32wtun+AZJU/AnyGp2SYBaXEpufn9aCk6rNWkcYth3r/7WnxaRXubztytXu1Oj5ERhOeuo5ITV0iPlS1qbZGuy6Hol/g+T1jvaTJv4p2WQp8TRj5VdaJ7SZN+UPLx2JqO0KoW5op4yzgeclPpQOmjexUoKwYhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(6512007)(36756003)(316002)(8676002)(5660300002)(2906002)(122000001)(54906003)(2616005)(8936002)(966005)(4744005)(6916009)(86362001)(71200400001)(6486002)(478600001)(33656002)(186003)(66556008)(38100700002)(4326008)(26005)(53546011)(6506007)(66946007)(66446008)(66476007)(64756008)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1RXc1BMNEx0MFYzZUlrSSs1d25seDZPK3U1cUVSMHZFd2V0SzB1dXlpRlIx?=
 =?utf-8?B?eWpPVytPbG40dlcvZnhQZ2VtREFFOEN2U3FJZEN5T1MzOENlRlZnSmgzNkxr?=
 =?utf-8?B?b2dJYUNqSmNlakxkRCtDVVd2bzFMaHRBY3pZeXQ3UlduUnYxVkhvcTBWMTJT?=
 =?utf-8?B?bVdxZ00wRWFjQXZ5QzdzdEdYNDNta3ZsUlpwcTBjRVFUQkpFUThPYlQ4clFy?=
 =?utf-8?B?WWJ3cFFRRDdhVEdrTHdIeUxRZEkrRTVOVEtMc0RxSWM4ak8xa0JOTS9YVWw0?=
 =?utf-8?B?YVA5bFNuWXdBRVhBRm8vUjQzWEFBdVBySmU5U0RxZUFYdHVmWG1xRjZEMlVM?=
 =?utf-8?B?akxtY0ZuVEVrWWNkTEZVd2ZNVEJ2U1NEenB2aTNtQlBHM3NYbCtZM3BrZ0lt?=
 =?utf-8?B?VkVQL0hDT3NSN3ViM01OclV2bXBwa0JQZC9DZzFheUw2dmlDeTZEQkh1a2w0?=
 =?utf-8?B?YndUalJyemt1dlBsV216Y2o5cFJXZnlQejVCMTduL1RTOXlDYUF6UzlkRDRo?=
 =?utf-8?B?SlFaYUVyZVpZUkkwc0tuQUNjZ25SR1RYUk9ScVFaVHk2OXl5Zmk2cHFSK3pN?=
 =?utf-8?B?RVpWcjlCYmNPdnJPeDQvaU01cDRmL1Y2N2F2cFpWbFNVMGJhNmRERXh0WTI3?=
 =?utf-8?B?UDdsMUpJaGVVT1hPZ0NkVFYzQW9nR1V3L0lNT1p6OFcwUzg1RHhjTVNka2tx?=
 =?utf-8?B?ekNWVlJRVzBpSUtiUEtnVTI1ZGo4ZnpvZDdFRHpjeFJrbXRRa3BlRnJqTm9v?=
 =?utf-8?B?TzJMQ2p3alhveGpVem4xRmxZUVhFYUJIaEFMMlVPeVpiYkNCT0ltNmtwN2hD?=
 =?utf-8?B?dzE2TVRvUGdyN291emYybDdtbThOWTJoWVEvSjh1U3ZXblduVHJtbVIyb3d2?=
 =?utf-8?B?dkFDSFpjVldtdFpocVM0c255b0tObnJjTDBkYSs5QXQzSzlLWUE1M1ZJL3Ix?=
 =?utf-8?B?RURia213WXF2ZlhCSVJvT3RET0pDSkdJK0s1OUIvMVl3L3BJc1NQNEg3QllC?=
 =?utf-8?B?ZUNrbFFPTnJOZDhFdmRDdjBGaVB5SFQ0ZmhuK2Z1cXdITktrMlVtWHRPN3Ft?=
 =?utf-8?B?bjBWMG9paUtKS2lzUVk4SEwrWnZlL1RhMlN5UUUyMWxMUlFsa3NzS2dOaTlq?=
 =?utf-8?B?NU9JeVlNUDhYQ1Rsai9ueDFFam5pTGhHamwxWDB1RGplMzAvOVVsR0l0a1l4?=
 =?utf-8?B?S1k1eG85NG0yOUU4Wkp4WXJoVVY5NTZIT2tocnh6UncybE5BYkdKT283cFh0?=
 =?utf-8?B?RTc5WDB1cWNHYUR0Z3IyS1EvRUJqMnBRbm52NnBVdnJPNVJPUUt0b0F1dE4z?=
 =?utf-8?B?TVYvMUlFcVNyYVhLOHJ6UHFkZVZNenlDMk1YeWVNU1daTDQwN3JzYjF1dUpi?=
 =?utf-8?B?ck5jYmR5VU9ibmovMUpHb2VZZ2lsaUNwTEN1RmIyS2FGWnpPM1RPdjk5QU1S?=
 =?utf-8?B?SkIyWlUyaFVMWDdYNUdjUnRldHVadlhxb0oxcVlRRGg3RjFJUjJtSkxqdk5S?=
 =?utf-8?B?R282U2dFbU54NDNrVjd0ZDQxYXB4VWxRcVoxUTloWm1nQUpWRkJTNFAybjBK?=
 =?utf-8?B?TUpOWDlCZWtlejhSUnZVa3NIZFJETWxHcFBCU3RDdVJ4dUpCdXJDWFBpL1Rm?=
 =?utf-8?B?ckF3Zlpqem15c2ZCNE0zOUZHNE8zMEpmZlZJbkVPdG0ycUxRUGk5MDZGY1JC?=
 =?utf-8?B?U0kvT2RmdFM0cFhtb2MxQm1pZVUvTERKbjhVaEt6VVdneGJCUUE4ak56Misw?=
 =?utf-8?Q?yUmqJh7FHM2MsVLWLaHT3AoBYVzpq/X1tZ8HK/q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17338CDE0F0A3C45B5720171E303477D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbb0b93-fe9d-40f8-42a2-08d93676be1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 18:43:07.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dK/Y0n+DslxpH4bqNfL66WWbSsQa549/oczK39LxHqOX9jo0P1E21LWRw7I7M/4LqNWp39YlDQbXB6euYP3jNGnfrSvrYbyWT2B22bz0Row=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVuIDIzLCAyMDIxLCBhdCAwNTowMSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+IHdyb3RlOg0KPiANCj4gVGhleSBhcmUgb25seSB1c2VkIGluIGZwc3RhdGVfaW5pdCgp
IGFuZCB0aGVyZSBpcyBubyBwb2ludCB0byBoYXZlIHRoZW0gaW4NCj4gYSBoZWFkZXIganVzdCB0
byBtYWtlIHJlYWRpbmcgdGhlIGNvZGUgaGFyZGVyLg0KDQo8c25pcD4NCg0KPiAtc3RhdGljIGlu
bGluZSB2b2lkIGZwc3RhdGVfaW5pdF94c3RhdGUoc3RydWN0IHhyZWdzX3N0YXRlICp4c2F2ZSkN
Cj4gLXsNCj4gLQkvKg0KPiAtCSAqIFhSU1RPUlMgcmVxdWlyZXMgdGhlc2UgYml0cyBzZXQgaW4g
eGNvbXBfYnYsIG9yIGl0IHdpbGwNCj4gLQkgKiB0cmlnZ2VyICNHUDoNCj4gLQkgKi8NCj4gLQl4
c2F2ZS0+aGVhZGVyLnhjb21wX2J2ID0gWENPTVBfQlZfQ09NUEFDVEVEX0ZPUk1BVCB8IHhmZWF0
dXJlc19tYXNrX2FsbDsNCj4gLX0NCg0Kc3RhdGljIHZvaWQgX19pbml0IHNldHVwX2luaXRfZnB1
X2J1Zih2b2lkKQ0Kew0KLi4uDQoNCglpZiAoYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX1hTQVZF
UykpDQoJCWluaXRfZnBzdGF0ZS54c2F2ZS5oZWFkZXIueGNvbXBfYnYgPSBYQ09NUF9CVl9DT01Q
QUNURURfRk9STUFUIHwNCgkJCQkJCSAgICAgeGZlYXR1cmVzX21hc2tfYWxsOw0KDQoNCkJ1dCB0
aGlzIGxpbmUgWzFdIGNhbiBiZSBleGFjdGx5IHJlcGxhY2VkIHdpdGggdGhlIGlubGluZSBmdW5j
dGlvbiBhYm92ZS4gQXQNCmxlYXN0LCBJIGRvbuKAmXQgc2VlIGNvbnNpc3RlbmN5IG9uIHRoZSBt
YWlubGluZS4NCg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2FyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRl
LmMjbjQ2MA0KDQpUaGFua3MsDQpDaGFuZw0KDQo=
