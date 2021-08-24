Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A163F62CD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhHXQiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:38:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:13431 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232186AbhHXQiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:38:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="278362908"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="278362908"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="685428990"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2021 09:38:07 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 24 Aug 2021 09:38:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 24 Aug 2021 09:38:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 24 Aug 2021 09:38:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 24 Aug 2021 09:38:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcOKWgYKpIH7APTUz1wTKfHjWxjQxiPJAfLmdBr7UZQ4qOT+AQtI7DkOQYHf5REkJzhOUimFTXu2oiO7snXBs5xr1AxL4o9rw6TOd6nLxYVlJzswHEXQMzTj+LwIs2wetd3r/ZlpsgBDg1C+PL0XOCckdBPNjGjRHXttC+Zc6+WoQRDIWHeZ+gAB7LviHQsksIhzgZukDKFvDOEGaxJ0nDVXi+ZQVBPR6OkfF64oIY1M0CQ+CMu06bjOZuubO+L1B+gIiwMzhtjLy1ELFpBBddyNPvz3SRgrqhDmfHBZc8i70vUz6vGo7xuNDOPA14Dfol/EZZEXzpdpgi+IP941zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7uU0mbn2v65DajLGAUPoBi9/0J9X+aUHJG0F8ja4JE=;
 b=XAj/lG31ma3q2c6nKD3XX1ppHuEYNVC5EADF+wnqGnKVAKXNvIa726KKGDys223TrBMvsFYxJUAVR29zflWDvTZ5vOfjkHf8rrv9jOKWab7FdvCEr+Z0El+k74ztPMhdjBiQzH7mSbNtcNE8K3qil5wutZA1iNtBIfnY4xN6snZM1j5RgrAP/yfKkpqyId752vX4HOTaCTVDpWVUwOhyxm3YbzOCIt8Qr05UCGETOyaYMvqpUK0ZdLOIkoF6b37hqkGJu3W4ct+kl4cmnWtnFKBF98IElxI703vRXRywRQOPuBacBpnSSE9v2BmGDR5XPR7tHCVeID/zgwTHi4jk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7uU0mbn2v65DajLGAUPoBi9/0J9X+aUHJG0F8ja4JE=;
 b=er75x4c8FT5iYeJHgqKLDSU02xsC1+DrRlfxHhARfKnoAAd0rIovrX4Trv1GO+BbvIbEMMB54vS1Ps0kt+g5GBHfQJt0VN9urauG5r/M+pgktp8b2BhB90zqMPeKjQV9U2fnh3FoCdHP5SSDlE0/wz44F9K3pGF7CIc7C/9MCn4=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB2752.namprd11.prod.outlook.com (2603:10b6:805:59::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Tue, 24 Aug
 2021 16:38:04 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e%6]) with mapi id 15.20.4436.019; Tue, 24 Aug 2021
 16:38:04 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "Lutomirski, Andy" <luto@kernel.org>
Subject: Re: [RFC PATCH 3/4] mm/page_alloc: introduce __GFP_PTE_MAPPED flag to
 allocate pte-mapped pages
Thread-Topic: [RFC PATCH 3/4] mm/page_alloc: introduce __GFP_PTE_MAPPED flag
 to allocate pte-mapped pages
Thread-Index: AQHXmCJlgwCR8xPK80+nkJjgy0+lT6uBivcAgAEVbYCAADwngA==
Date:   Tue, 24 Aug 2021 16:38:03 +0000
Message-ID: <f4a428040f822d7181acfc6c1658173373f28e40.camel@intel.com>
References: <20210823132513.15836-1-rppt@kernel.org>
         <20210823132513.15836-4-rppt@kernel.org>
         <889bdfef8b4acbe840668f27782c3d39a987c368.camel@intel.com>
         <YSTt9XEDfbPOpab4@kernel.org>
In-Reply-To: <YSTt9XEDfbPOpab4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd10ecc9-e316-425f-e335-08d9671d8b67
x-ms-traffictypediagnostic: SN6PR11MB2752:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2752F3F9F6B582CA2021A7B6C9C59@SN6PR11MB2752.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eye+wiRI0x76guZTkANdI+jLPT/EpmW+NEiLOxhIv8NNiESukbkQSROoJpHzTADQN+qUzF+u6t3vryvBHQjHU7MCqt1NgQkTqw01IIG3bE6NLlZaU+EHJYNfI8i7TXSrymMFbqwnQozIPkKbccHXRxuK0dkaxVm8dvnTBR14RfztVqHFpR7fQMURRYigaI9l3A4gpVh/xt9VK0aaHTR2f431dMfsNHgMjh6bliXl0dRwmXEE509yEhpfIsj+ExQkxAp5iXxWcXOw9u+95nRSgxacl6eM4SSErw/VHFlRjgdX0dyzuugcdS4EUkNTA2mt7v/9q2oYIFvcQs5glzsg/E1U86Mcoo/d9EAyeHt6lYp/meOmkoQJPJi9fAkRAhhf3ky9EIPXJKbUbcXj2TvYJMO7GN86uq0DkYs01KNBacsv1U1gtXFKU692TqvCo1lgyIniui6zA15ROT8zLDGaOgyp33mb6A1Srj5fLb9sHcL3apkwfj3IRBIgV82WNMwAmR2DIZE4arXSYJRqsfiEcGVdzlQCEk+kFAiNM3R1YKjPCy9kkWD07aT1SkgUA3O/7L/8HKcLYi04tqCSWpyFHsgH810aiFn5g73wAdgPh9Ypm9xSN6Ib2Romg7iVa041WRJ13tza6wf2m39BpKHtVO/vm7zieFCfmmWN1C1sx9gC4CbW91qtlm5+M+EX6qKH6Ala3FFx9vNyOrDHbb2RhorDUCmKnyVsbyVacoUKSWo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(478600001)(54906003)(8936002)(86362001)(4326008)(2616005)(6512007)(5660300002)(2906002)(36756003)(71200400001)(6916009)(83380400001)(316002)(7416002)(6506007)(91956017)(8676002)(66476007)(66946007)(64756008)(66446008)(122000001)(66556008)(38070700005)(76116006)(186003)(6486002)(26005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzJDYTFlUmxwemt5WXlxZHI5NE9JcTM3Qkhkbk50MFhGYWlZTHM5RWhtbzQ2?=
 =?utf-8?B?VHVsbTNGM0Exa0Z0d2FwMVAyV1hDMUJVY0NEei91RU1oRGw0c3hSaTdhSUt4?=
 =?utf-8?B?QjBvZzQ3ejBVMWIrbS9iZ1Z5UHBvZDRaSllaZUI5UGFGeVk2U1hldDA2Mktm?=
 =?utf-8?B?Vno0dENIMW82QXNqUjBsRFVua1RLczhidjdWa3NOYjNxWm5CSTFqd1dUeHcw?=
 =?utf-8?B?eWhmdGlqWndBY25lejVPYTVoRkFndE9RYzMxN3Y2V25jRUxtb0JYbUtaSnpZ?=
 =?utf-8?B?eGdvZCtid2tVblN4dkFacVFHTDBONW5TQ1ZnSVhUK2dwN0RCMnF1eWNsOEps?=
 =?utf-8?B?LzkzNkw0c2dTNnVzSkw5VEV0Y3g3S1dmQ3c2VVhyU1ljUDc3VEh4VTFMMDd1?=
 =?utf-8?B?WVVmVDQwdFZSVHQ1UHJmSHlaa09ZdGd2enNoNXZ3V3lMY2YxUHgxa1grSGZH?=
 =?utf-8?B?MTUxNGxaQzVhazMyMFlIS2JrTjJDZ3NORHFzaUZNb3krRWtUNWUvTUtYN3pr?=
 =?utf-8?B?d2d0eWVnRkxaVFVOeTVSbmc0STAxSWZYc3JJOVQ0VUxrUTNwU2NSRFYzMHlF?=
 =?utf-8?B?Z3J5RWdIV3NBVUI0K0JCeDR5dlNLc2h5ekZHWWJuZzU5NkY0eGpIR0FvVGhm?=
 =?utf-8?B?OTZUM0FJVTgrK1crRElGQXJEOHFEempZazdqMFd0MlRUTjAvbmQ1OW1qNTB2?=
 =?utf-8?B?NGgvZGFhRlFwMEFmWU5HYzlHdGRKclZqMFpWSHlwMExhZXJYU003Si90Wmh2?=
 =?utf-8?B?WENiTlJOK1JiRlErcytWTjlKUVROMDRESjcvRGs1a3BGTTJ3Zm9SOXR6NE1H?=
 =?utf-8?B?NmcvL2FZY3Qrd1FkN2dVMlJvek13MlAvR0Y3TnZNRDhraFhKU0p5MXpDa0F2?=
 =?utf-8?B?RWFZcWdWWk9RT1UzWnJnc3JZRXo1ZFR2K3d4bTE2UU0wM2FabHpnZjFRazhT?=
 =?utf-8?B?WHZybE1GVDJlbUYwOG5kY0VEeXozM0YyL0ZwcGZodjVOZDdCUU5OUUQvK1FX?=
 =?utf-8?B?UDErVStNbUxGZG9TcG9OKzRvcnRHQVhjcTRqNXJHVThFWGVDQ0tpUGJDb0hW?=
 =?utf-8?B?NlZoT2xIblJVbnlUenNxMVBQZzk5VW9YZnNyN2hSdVp3bWRNL29rTXN5Q0ZR?=
 =?utf-8?B?c2w3ckh2bEtibHhhODJGdXZGcnhzblhnVVJFblJudlFtQ1dOYytRTGU1YmZ1?=
 =?utf-8?B?WlIzSHlXdDh3QWhUZkRXZXNac2VUR0FacjlGQUJhcjlLbUZvYlIybHliVzFB?=
 =?utf-8?B?M2U3TVVvZEhuRG90QnV6M09pcCtmS2xrZmV2RjhXUmtTSXhoMzV5aTRFVWNN?=
 =?utf-8?B?dWt2TFJCUEVtTHMxWXE5dlNTbnVZR2VxSGJIWXQ1WmV5aml0RzZUTC9nWVpz?=
 =?utf-8?B?M2hNa2pBMXRmZjNkWTJkQTRoSzQzUTRUbU54SlRJbU1ISHdRSkxkUHJaQTM1?=
 =?utf-8?B?bTZvRko0clgrcnpHMW1MMlAwYy90Rks4YUFobk1wSzBBaWtLaDNsRWc2Wkp4?=
 =?utf-8?B?VDgxeVp3aFNvWkNlOHRJNWlJNThudEcyeEJ6WmJ2Q3crc3c2YUt5VE1pZjVK?=
 =?utf-8?B?dmZlU2VldzVIZ1dEK1lSZWI4dERWS2RmS1N0QU40QVpqOWpveW5aWDd3RkZY?=
 =?utf-8?B?Skk2NStsblNzbmN5NFBjUHVWaVJqclMwSGVsT3ZMWWpJZU1PcjJxVUM5R1N6?=
 =?utf-8?B?VzlOVUZDeHRDelI3TXJ0cTZpTmpaVHZLM3k5RHowU21uYkxHSllySkN6Vk1M?=
 =?utf-8?B?QVRoRk5vU2ltVytnRGhVUEZWeHBzN1VTWWlTcFlyR1VQNytCVnVwVDZpRXBM?=
 =?utf-8?B?T3lsV2cwYy91MlUycTBxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <630DF6F9F83ABA4481C5B2317291055B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd10ecc9-e316-425f-e335-08d9671d8b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 16:38:03.9360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dgw3mpXb0wSM0CmH5Z53hKfQ4qVVc1L/J8QCUFLqr/U5Oa6z42OkWS1Qqun7Lm9AxNSeVwd8ybpIWyMq4duxX53yuPdo0FKf3BTZTWUqmEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2752
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTI0IGF0IDE2OjAyICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiA+IFdlIHByb2JhYmx5IHdhbnQgdG8gZXhjbHVkZSBHRlBfQVRPTUlDIGJlZm9yZSBjYWxsaW5n
IGludG8gQ1BBDQo+ID4gdW5sZXNzDQo+ID4gZGVidWcgcGFnZSBhbGxvYyBpcyBvbiwgYmVjYXVz
ZSBpdCBtYXkgbmVlZCB0byBzcGxpdCBhbmQgc2xlZXAgZm9yDQo+ID4gdGhlDQo+ID4gYWxsb2Nh
dGlvbi4gVGhlcmUgaXMgYSBwYWdlIHRhYmxlIGFsbG9jYXRpb24gd2l0aCBHRlBfQVRPTUlDIHBh
c3NlZA0KPiA+IGFjdHVhbGx5Lg0KPiANCj4gTG9va2luZyBhdCB0aGUgY2FsbGVycyBvZiBhbGxv
Y19sb3dfcGFnZXMoKSBpdCBzZWVtcyB0aGF0IEdGUF9BVE9NSUMNCj4gdGhlcmUNCj4gaXMgc3Rh
bGUuLi4NCldlbGwgdHdvIGFjdHVhbGx5LCB0aGVyZSBpcyBhbHNvIHNwcF9nZXRwYWdlKCkuIEkg
dHJpZWQgdG8gZGV0ZXJtaW5lIGlmDQp0aGF0IHdhcyBhbHNvIHN0YWxlIGJ1dCB3YXNuJ3QgY29u
ZmlkZW50LiBUaGVyZSB3ZXJlIGEgbG90IG9mIHBhdGhzIGluLg0KPiAgDQo+ID4gSW4gbXkgbmV4
dCBzZXJpZXMgb2YgdGhpcyBJIGFkZGVkIHN1cHBvcnQgZm9yIEdGUF9BVE9NSUMgdG8gdGhpcw0K
PiA+IGNvZGUsDQo+ID4gYnV0IHRoYXQgc29sdXRpb24gc2hvdWxkIG9ubHkgd29yayBmb3IgcGVy
bWlzc2lvbiBjaGFuZ2luZyBncm91cGVkDQo+ID4gcGFnZQ0KPiA+IGFsbG9jYXRvcnMgaW4gdGhl
IHByb3RlY3RlZCBwYWdlIHRhYmxlcyBjYXNlIHdoZXJlIHRoZSBkaXJlY3QgbWFwDQo+ID4gdGFi
bGVzIGFyZSBoYW5kbGVkIGRpZmZlcmVudGx5LiBBcyBhIGdlbmVyYWwgc29sdXRpb24gdGhvdWdo
DQo+ID4gKHRoYXQncw0KPiA+IHRoZSBsb25nIHRlcm0gaW50ZW50aW9uIHJpZ2h0PyksIEdGUF9B
VE9NSUMgbWlnaHQgZGVzZXJ2ZSBzb21lDQo+ID4gY29uc2lkZXJhdGlvbi4NCj4gDQo+IC4uLiBi
dXQgZm9yIHRoZSBnZW5lcmFsIHNvbHV0aW9uIEdGUF9BVE9NSUMgaW5kZWVkIGRlc2VydmVzIHNv
bWUNCj4gY29uc2lkZXJhdGlvbi4NCj4gIA0KPiA+IFRoZSBvdGhlciB0aGluZyBpcyB3ZSBwcm9i
YWJseSBkb24ndCB3YW50IHRvIGNsZWFuIG91dCB0aGUgYXRvbWljDQo+ID4gcmVzZXJ2ZXMgYW5k
IGFkZCB0aGVtIHRvIGEgY2FjaGUganVzdCBmb3Igb25lIHBhZ2UuIEkgb3B0ZWQgdG8ganVzdA0K
PiA+IGNvbnZlcnQgb25lIHBhZ2UgaW4gdGhlIEdGUF9BVE9NSUMgY2FzZS4NCj4gDQo+ICANCj4g
RG8geW91IG1lYW4gdG8gYWxsb2NhdGUgb25lIHBhZ2UgaW4gR0ZQX0FUT01JQyBjYXNlIGFuZCBi
eXBhc3MgaGlnaA0KPiBvcmRlcg0KPiBhbGxvY2F0aW9uPw0KPiBCdXQgdGhlIENQQSBzcGxpdCBp
cyBzdGlsbCBuZWNlc3NhcnkgaGVyZSwgaXNuJ3QgaXQ/DQpZZXMsIGdyYWJzIG9uZSBhdG9taWMg
cGFnZSBhbmQgZnJhZ21lbnRzIGl0IGluIHRoZSBjYXNlIG9mIG5vIHBhZ2VzIGluDQp0aGUgZ3Jv
dXBlZCBwYWdlIGNhY2hlLiBUaGUgQ1BBIHNwbGl0IGlzIG5lY2Vzc2FyeSBzdGlsbCwgYnV0IGl0
IHNob3VsZA0KYmUgb2sgYmVjYXVzZSBvZiB0aGUgc3BlY2lhbCB3YXkgZGlyZWN0IG1hcCBwYWdl
IHRhYmxlIGFsbG9jYXRpb25zIGFyZQ0KaGFuZGxlZCBmb3IgcGtzIHRhYmxlcy4gSGFzIG5vdCBi
ZWVuIHJldmlld2VkIGJ5IGFueW9uZSB5ZXQsIGFuZA0Kd291bGRuJ3Qgd29yayBhcyBhIGdlbmVy
YWwgc29sdXRpb24gYW55d2F5Lg0K
