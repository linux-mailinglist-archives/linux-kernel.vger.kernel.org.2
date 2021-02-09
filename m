Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80223152F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhBIPj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:39:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:59028 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232474AbhBIPjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:39:46 -0500
IronPort-SDR: iBz0FwSXLLDHE5puchScT7jVyT1Tv3e54YPSjlnhX2YRe3SwJ9KQV7p9tadvriDez8sC6sTnLK
 Ufb9sYBHoqvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="182042968"
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="182042968"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 07:39:03 -0800
IronPort-SDR: OXA0iDBtPoNB2ogOafjDPCf5w78FarnlJmMhU2wEB/ifpNMmF3vvx9TT2kp8H9drQEk1CN2dOX
 vzaJpEXJtgsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="419861910"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 09 Feb 2021 07:39:03 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 07:39:03 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 07:39:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 9 Feb 2021 07:39:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 9 Feb 2021 07:39:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jov4VshuxaR5YE37Ejxs5DAAncJZOLS8thDxAKydYJvGxAx8aMcJz+efKKvKj6+bHmOG6SuKijYHKZLguXN3hCgZjJCfRaT8bmFH0+vDkrRAXEQ7y+xdZQ5R9KZCNhR2F+zQcsTyVQ8HyIvjDIi2VkXYRQRGLRD2fpO3bBGZFlCrXav1elm1t+QVaYImFvo0aMrkSJvF8kHwJnoBPZV+1ldIz3WnFB7c4e0l2oKyClNmwT6hBpFr2zXcwSNDlMRk6vLJT3EAuA2rY+UBcBBkRJVayV/8RQPbKSackT0spZdv3C5rFlHax0O5OM3FaI+E3h0OvqPvsKGOY9XmDv2gSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC79X/KcUMit1fCqsMfqbcsSac73URyjnlYXp1g4M6s=;
 b=RtSdnkiOxCyptU5dGOAodOYU546ouiO1ZTDUCxYYr27k8Zg6UMqbkt8/EHVQaO9qDfrmzr1MGnnzPe8rzFy87U66vWFX9MPhEsc11eAjAX7TjmYRCO/Y3y5uCexsROq4M5e2d7YaRAEvByfi/pFNa07LzSnndBFBVeOtlCvZdwzQZbfHOkf/Xj32nUv5XqoDhwsbl8YIje6I6B+XqKg5HBBiO0X39tP3ON0HHbXbs2ITS31N7/OkTlvueHcZ2UOusdfQMjQiZLdE5B1bS1TSGyFJaTlgmP/wOYyZtvRFB1n3CC2zJd5zi7YHarhussXDRMgPnz/toXlP3JTYRckI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC79X/KcUMit1fCqsMfqbcsSac73URyjnlYXp1g4M6s=;
 b=PkhxtgMqgXnKhNzu7457fjGSebhESXJ6eVZEQ+c5B1C8uGo+A7yDWuFet2//D+696eM3z98kATpxiHQHB4iGUba+QylDbNPxZDz8NcQbhtFNUXh3mry7LTtU1G+ZzZ+EOsejSktDoeL01uofmFKaZXvJdO3lqNq/t78BLxsEFLA=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 15:38:59 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 15:38:59 +0000
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
Thread-Index: AQHW2UTqFYm5UYpYB0GEyLEco/gga6pOeqwAgABqIgCAASyPAIAAL3UA
Date:   Tue, 9 Feb 2021 15:38:58 +0000
Message-ID: <C97BCE05-8033-4605-8699-8558BB7D905B@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-9-chang.seok.bae@intel.com>
 <20210208123330.GE17908@zn.tnic>
 <AF6E884F-F6DC-4519-B57E-F6CFBDBEF85B@intel.com>
 <20210209124906.GC15909@zn.tnic>
In-Reply-To: <20210209124906.GC15909@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13c692e4-c23f-4be5-7ade-08d8cd10d17b
x-ms-traffictypediagnostic: PH0PR11MB4904:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB49048184C7E47B09694688D4D88E9@PH0PR11MB4904.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BDR9F511JLxJKmg2o/se8HufN9bIg1zx7p5qDm+PRYM0sQQqUjUjNvPopVULcBXcUdy+TbJuHuwEJYGaecQK09u45BLqXgU+gtHHQVcLh0PmIpcHMYqTEJs2oX/EviD3KWuqDxGtPzwtlVjeA/x09h9V60nCMTfJDaXDmoR/mQBhsy314zyKHkTnnBp3t3E208UCd2lqjuuSAoYCDOd5XQEidGjAbxzyKm1gXOIPfBiz1azajuZ5yu0UG/5Wq/TcC/G4n9HBJ36h1PdUnR0fEmduWrQvakwGYQSrrQYinJjkFQoBLr/pWmYLVOvH7kKiu7ef0eHBpvOCBrzQXl9xdFteFdoSwSy6Ha9PbFcKtsuEXsHHumA17CkgqmUTsGliYN2g0NxCLCWkdhUkChb142ZI8+lXYeY1f78GKtnkzhI35Wi/CcpEXWHhITvWBCKkvX1VBGW9egj0eJwvlX2KQsyv9V565xaGl8ZFkq9BZc++Do01xt8oYK5n0lgBTSuv/vSncAYl21d/e2tzYa6v5yuPAhKKJBmCd30Y6yyMOkq7O8sp7nKcxMjedeBvB6hgHCnRuhgGGmHIIdQEAaERVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(26005)(6486002)(2616005)(4326008)(478600001)(36756003)(66446008)(6506007)(6512007)(6916009)(66556008)(33656002)(66946007)(86362001)(2906002)(66476007)(71200400001)(64756008)(54906003)(53546011)(5660300002)(8676002)(186003)(76116006)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?T25Ma256YkFIMTBwZlZQeGRwUVEveXN1MXBUMmRDK0hzTFF3QWlrZjFseFFw?=
 =?utf-8?B?ZXJVTVZobUdvR3dTVVVEMjk2RXNFeUdPcEkyT00zdlpKSHRxZDdhSC9ocGk1?=
 =?utf-8?B?a20vZVlpcElaUUt3bklJRUh6S3grZTRPZXRNK0Q2SGRscVZud0lnakJKOWJu?=
 =?utf-8?B?Z29tMUE2VGhjaW8wVG9CV21MQU5mODZqdFRlYmFzTi9sdFNKTzhIQ2w4SGJB?=
 =?utf-8?B?ZkxzYkc3QWpXcG1zZGJKL2NqWGdET2U1dFFIUVR0RHM1K2J2bXNyWG04N1Vy?=
 =?utf-8?B?bm5sZ3pwQkVKZWMxNlhERVlQY0cvQ3J2QTJIend4d3RxS1VUQW5oZlpKVHBH?=
 =?utf-8?B?OHk4ZjBLdUtSWGxSVW9zYVMvZVViZVBqZDdXNFpIdldKaUt5SytVOHVWbkdL?=
 =?utf-8?B?T3RydGgwUkRKRmNVaFBsOHNhZGE2M2ZFOUYydU9sQXE3dE4xbXZ5MGRxeHVW?=
 =?utf-8?B?ZFhOb3BhZ0M5WnZoV09pTC9qZ2V5WjdFVTNZSXQwQ3IrOENQV2h5bTBRTlBi?=
 =?utf-8?B?emhKTnBTOG13b0NTbldpbkw4N2tKZlVaNHlwMTlxVDRGUHJyWVU1Vm95ZWlk?=
 =?utf-8?B?dDBRb2tMZjc3R2wyRmpzeUw3cXhJMk5VSTlob2M3MTR1c3M1TE8xTWFpRHlw?=
 =?utf-8?B?M1dIc29Zenh3cXM3dCtSbHgySnNnK3ZKQUplOW9PWXVWd3hseW45N2R2K1lL?=
 =?utf-8?B?S2twMHNTU0JTTGptOGplUlF4NGNlcGFoWlkvdFBvNFUrUlJLOFpQa1ByNUx1?=
 =?utf-8?B?elM5ZFFPc1Jjc2t3MWMyUU4wT1kraFFDTHlLb0xobVdYUGk0NzdMZ0dxeEV2?=
 =?utf-8?B?WmI0N0RXOGN5dy9YTjl6K29EbGN1WlNseE1OQldHaDZPcHVnVTdVUW1GcGNR?=
 =?utf-8?B?cW9xdC92ejZEeHZwTnZ5T2hIaUlhcHBtWE9BS3ZodkJOSmw2dit3SVFYWTNU?=
 =?utf-8?B?MnpvSjh4MUNtYU9IM1loSTBrWVBPa2lsbDY5aDhGQWk3TnArcDB5aUQ0d1FB?=
 =?utf-8?B?Q3gzY09vbno5eVJ1ai9xTUFoajNZS1haZ29BbHRXNTcvRHFDK2kvNTA5V3pO?=
 =?utf-8?B?M1ROMUJJc3pXdENvYnZUQVRZVHpFTE1HS3dSd2NIRXlDUUNkRHJEbDRPN1Aw?=
 =?utf-8?B?VHFFRDlpd0l0dVA0b2xVWXFIejRMSFcyRm5jMDdPOUtxMmxaV2djQUd4NCtl?=
 =?utf-8?B?YXRtVXpmeWRTZlZ3eUJtME5YLzVKOVYrY05ubHAxclBpUEQvMExKRWdjM1F3?=
 =?utf-8?B?eVdid2gxRGJJV2FKNExwNE1INkg0MGNkMk9VYVE2bWZLaW5kRk5YQ3VtWWdl?=
 =?utf-8?B?TEw1dS9HeWV5ekFKNnpHcHFiT0ZEdTRzeFZrOVJCT0YxRS81UUVERVN1d0xm?=
 =?utf-8?B?MmtacHZaZWNUWDlOMGw3TCtyQWRoTjNDcUFuaU13UTlEWWpPbWJDTitVMVEx?=
 =?utf-8?B?c2xGakppR2I5djNQV2QyTnNCY3JBcWhrWDJTUUtucUdKM1MzNzRaQUVuYjRv?=
 =?utf-8?B?R3NrbFpIeE9HQ2ZsbXk5VVVwVll1eHlVaUUzUVh0V29RcjBiUWtlOHh0L3JD?=
 =?utf-8?B?aUFaYXJNeC9DMkJGNVBNMzNzbFdpK3p1UGR4Q0J4cVZVZVNsOFhoeGpVbWVU?=
 =?utf-8?B?akFTT3B6Q2J5TlZnZVdwREl5cjZXOWpnM3lWeHVUQU42VDhPZ0NtYXdJNU1R?=
 =?utf-8?B?MHpEYzBlMi9FaHRnQ1R4RmxXV2JWdjNFTTZ0MGM1amFFQnhrSHdnTm1WVnpK?=
 =?utf-8?Q?KuDw2WAcZiFY3k0JLP9haOlyZVHXQrNgCR7GPt4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CC28487185E8F4FAF4335DD0F92E6CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c692e4-c23f-4be5-7ade-08d8cd10d17b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 15:38:58.9212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e66cMgSdVmIwdkUWNTwo4Zo4S9b6hV8z8Q51yfVOLBBQmucFORJX1chPxQZCc/qzBuDa1DStdNj7gicq4Q3G6mCJ0Ym4veOntrOWfjjOWEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4904
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRmViIDksIDIwMjEsIGF0IDA0OjQ5LCBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+IHdy
b3RlOg0KPiBPbiBNb24sIEZlYiAwOCwgMjAyMSBhdCAwNjo1MzoyM1BNICswMDAwLCBCYWUsIENo
YW5nIFNlb2sgd3JvdGU6DQo+IFlvdXJzIGRvZXMuIFNvIGRyb3AgaXQgZnJvbSB0aGlzIG9uZSBh
bmQgZnJvbSBhbGwgdGhlIG90aGVyIHBhdGNoZXMgYXMNCj4gaXQgaXMgY2F1c2luZyBtb3JlIGNv
bmZ1c2lvbiB0aGFuIGl0IGlzIHRyeWluZyB0byBkaXNwZWwuDQoNCk9rYXkuDQoNCj4+IEkgdGhp
bmsgdGhleSBhcmUgaW4gYSBkaWZmZXJlbnQgY29udGV4dC4NCj4+IA0KPj4gVGhlIGhlbHBlciBp
bmRpY2F0ZXMgdGhlIG1hc2sgZm9yIHRoZSDigJhpbml0X2Zwc3RhdGXigJkgYnVmZmVyLiBUaGUg
cmVzdCBpcyB0aGUNCj4+IGluaXRpYWwgbWFzayB2YWx1ZSBmb3IgdGhlIHBlci10YXNrIHhzdGF0
ZSBidWZmZXIuDQo+IA0KPiBXYWl0LCB3aGF0Pw0KPiANCj4gQXJlIHlvdSB0cnlpbmcgdG8gdGVs
bCBtZSB0aGF0IHRoYXQgaGVscGVyIHdpbGwgcmV0dXJuIGRpZmZlcmVudCBtYXNrcw0KPiBkZXBl
bmRpbmcgb24geGZlYXR1cmVzX21hc2tfdXNlcl9keW5hbWljLCB3aGljaCBjaGFuZ2VzIGluIGl0
cyBsaWZldGltZT8NCg0KQXQgbGVhc3QgaW4gdGhpcyBzZXJpZXMsIG5vLiBCdXQgSSB0aG91Z2h0
IGl0IGlzIHBvc3NpYmxlIGluIHRoZSBmdXR1cmUuDQoNCj4gVGhlbiBkcm9wIHRoYXQgaGVscGVy
IGFsdG9nZXRoZXIgLSB0aGF0IGlzIG1vcmUgY29uZnVzaW9uIGFuZCB0aGUgeHN0YXRlDQo+IGNv
ZGUgaXMgYWxyZWFkeSBjb25mdXNpbmcgZW5vdWdoLg0KDQpPa2F5Lg0KDQo+PiBTaW5jZSB5b3Ug
c3VnZ2VzdGVkIHRvIGludHJvZHVjZSBnZXRfeHN0YXRlX2J1ZmZlcl9hdHRyKCksIGhvdyBhYm91
dCByZXBsYWNpbmcNCj4+IHdoYXQgeW91IGZvdW5kIHdpdGggc29tZXRoaW5nIGxpa2U6DQo+PiAN
Cj4+IGdldF94c3RhdGVfYnVmZmVyX2F0dHIoWFNUQVRFX0lOSVRfTUFTSykNCj4gDQo+IEknZCBw
cmVmZXIgbm8gaGVscGVyIGF0IGFsbCBidXQgb25seSBjb21tZW50cyBhYm92ZSB0aGUgdXNhZ2Ug
c2l0ZS4NCg0KWWVzLCBJIHdpbGwgZG8gdGhhdC4NCg0KVGhhbmtzLA0KQ2hhbmc=
