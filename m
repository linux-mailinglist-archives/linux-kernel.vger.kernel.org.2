Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C223EBCA6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 21:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhHMTof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:44:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:45445 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233887AbhHMToe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:44:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="301203468"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="301203468"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 12:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="518305925"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2021 12:44:05 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 13 Aug 2021 12:44:04 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 13 Aug 2021 12:44:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 13 Aug 2021 12:44:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 13 Aug 2021 12:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Twvc3CUDEd4MuVnoeUlEnQw7JLR4FdMLEW7BWA8EuocD3mLQoysAE9ls9jNTjbATRkHDu9n2Jzc1N5n+FxSMwB7WNlhQ2Bjw8b+JfUih+GPNE+nXPUZvaHsspYT2RUDvOl3q+Uj64isKn9E2Cft9LtRdugFrfIBK7lpj18+iaQFw7AMbuDEVNobmQsOyrZAD/KzhwZaWH24PGJVAXP+W57RngXOmEymXVfW8THUfZHcVgLejgKnwfdLKLorUSyqgqPG/MqVCAkXAVwfHmPMP6OLGtyWe9uZC/CPibNpqQ9x9skVCaG5jSVWDLn5U1OUvAlF1v9M0LoHjIO4n0k//eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iax9VG1/but0+XtheoFPEM1835ba1And98Pg2VzGO+c=;
 b=iKuU6VGUkstfF0K+vMPBFyzxMZbmmG7rJb3SX99GxHcJ+nUXmr9jTmuGlFaPjK6BujuNOFrpKX9O8B/03uJxJjmwcXmZG31q3iDqpkS4jRc0i13Hw18NUS3VzTIvzuBgY0tm9aafnjEN7tDLhdqQGQUGQz5hCa3eJm3Rpn5fyija6KxqhoLJHRvJsLSNUZYnMA/dJAQCkdK01y5yXWD9YgtWD1VegqStX0XNHZEdQhBLChQIrpK1MOHdNTHnbLCMu5CvKLZTBND09rAQ9fO8zbrRk+REg1wXgA1iBBVvoARNXfi8SWEMXC1R1OJn7UmNH2zWYwDD6Dh9bM9gddtJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iax9VG1/but0+XtheoFPEM1835ba1And98Pg2VzGO+c=;
 b=mEnKMpHLptG0VA6bbP00wcHOCFxPC0Vms5DBEr6ZMONLnAC5kQzY5wWCT5iLNZ5nIqs1e93p6o39LZ/zG7mD5BZmXOjOYznKU537SsOFwP+nNQDsJ/FHsC+2kNUywpqstF0oD41I5Gn9WyI1E4hygqjNo6w1IE2D2+fXmHDvQ0E=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 19:44:01 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 19:44:01 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Macieira, Thiago" <thiago.macieira@intel.com>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 14/26] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Thread-Topic: [PATCH v9 14/26] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Thread-Index: AQHXhVR0BYy4P9XafESfiMTncJD6GatmuoMAgAUQ8ICAABpTAIAAFPAAgAXxv4A=
Date:   Fri, 13 Aug 2021 19:44:01 +0000
Message-ID: <B04AD498-8EE3-4D60-8AF1-CF6ED1D6E55C@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <3718618.i2J648eyUT@tjmaciei-mobl5>
 <E9C8AF5E-E229-4BA2-AEC8-4289EF7428CA@intel.com>
 <3144206.qcAzhSVzjS@tjmaciei-mobl5>
 <78846028-6D6F-4E68-AA96-1273334CDF93@intel.com>
In-Reply-To: <78846028-6D6F-4E68-AA96-1273334CDF93@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efb002f5-912b-4f8f-f9b4-08d95e92b355
x-ms-traffictypediagnostic: PH0PR11MB5109:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5109D62250409EED420D49D6D8FA9@PH0PR11MB5109.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ftOxZ86iqKImoPBVOJDDXjVihzHsXHI8mNzAfUY9mQ262iPrqkfgKevXrYO5/wpRw+OAQ9gqIzAWRcW/kugew8XRxifzwxE0yIgkIc9DrbL6ZmHeH98urVx5X8wZsotbGQ1CUR+Sv8bdr6ldz0MiksD+qczkVWGbAQsjlZioqUrE2rhP2OcqlgGEP47Iz7tc9Lv/Cru0nkc6ZO0GwwMNIR47lAKJZNwDNsANkr0nkd9IPzbs3m8CEzamJyVyN3RiQX9Zs+zvSL1ztnDhuk5TEhoPOrTOWxRdyY59Pa+RZpgGneA7r5AQbGgklPjRpjCzmvp5/0kCW5DROXnEIOXrFrmfVOorj39geSdPFAsvPR3mySyyFRFykCGiY8ekdt8UkR8Sb7rWNXV5OWN8S1S5uqQnV9B2AhdG18ypTHrAeDZjxZcn3bpEL6CPPZl9kaRzGd4ZSQR68UdUEvc43D55tjPwU0FNEA1vs74IpNn8D3/ZNdlzjQs02PYduobqSFILYjnZ9WMwPUndASLdGxNxJzttkp33AyH/IWwTDwpLR5myap+mcUdJ32k9l+fKtJkWDEo8BaRMCBBylUPaQq2O8HFXhB+WxZG0W0EYROHnqMDb0HB2k/niW07pB/hli4iErYgh44rIJ8U4fF65ZLUNEP4t1GNSPc6OqzEKNCBfCU/KkqKMTIAsEFqJ0EWwQomPuCGLsQTJGWfOFd/lJLi10bI7UBjTJxLOriQtMyHkFNd2N7XMZoESWzmfxNXx8U5J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(8676002)(8936002)(2616005)(5660300002)(33656002)(4326008)(6862004)(38070700005)(6506007)(6486002)(6512007)(4744005)(186003)(26005)(66476007)(66946007)(64756008)(53546011)(66446008)(122000001)(6636002)(66556008)(54906003)(37006003)(36756003)(76116006)(38100700002)(2906002)(86362001)(478600001)(316002)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3c2dndKY0hXblQ5Qjl3TStCeUNkZGhWV2hnOENoampPdHkxUkYxcWNDWUps?=
 =?utf-8?B?ekR3SkNpMEF6TnM2RXRpS085Sm9CdWpCcG5Yb0cwdE81Mzd0bFVvR3AwcXlY?=
 =?utf-8?B?R1lmZnd6SU9BQmJ5UjVCc2JPNmsrdi8xTWJCTzJXYVRjM1ZQeng5U01xbmJY?=
 =?utf-8?B?WThTR2g3bGkvMC9VbEcrRWlmdEpVMkNuZExUTjMrcDJsZDZjV3ZHa1lmTHpR?=
 =?utf-8?B?TytaN3R2Nk9WRTU4R1R1a2NZaXl1K0RBTWl5SmJoZFJZVXgzT3F6Y3JWYjFV?=
 =?utf-8?B?YTRkQXJiM2c0VXNQNEJVN0lMZXdwY3NjdWQwSVpnTjE5ZmhkeGg4ajZNbTVD?=
 =?utf-8?B?SUx5UlhqaWUxTWhoMWU1cjNaVkN1NW03R3ZueGVMZElzRTZUNWw3dTdhaXFC?=
 =?utf-8?B?OE81aVVZSElaZzFpcTAwUTJJTkxHYXdnSVRhOGxwTW5FUTVYQUFrYXhoOFBj?=
 =?utf-8?B?RWpUVStabmNFWUFMUHJEemdHNVMxR3d5bkdQSkNCclV3eVE3ZVZ4Z2JGRkNR?=
 =?utf-8?B?OXA1SEtuSGNSZHFrN0FnV2RRelBIOERZbmIvRFRlK2M5MGJoemZmQzR5cEpR?=
 =?utf-8?B?TEFqT1NXNkFPWkhRdXRGbU5TZ3VKNmkvU04reG45WDdVd1pINWpqTk1Cb1JQ?=
 =?utf-8?B?RGVjU3VFVlRaZjRPUzBhUTg2VU9tTjN5RG8zaTFjcVMxenVGNlUxSzZCWWJl?=
 =?utf-8?B?SnpsTU5zSmpHc0FtYUZGaldYNnFNRXZWcExCYWcrb2pTVzM1SGVYbHB5KzJw?=
 =?utf-8?B?WmJISEF5c3RGdldKTTcxOGFQdnJ0SHFhYzFYR2RCbEtvRnVUUnd3clJvQlJ4?=
 =?utf-8?B?TlY4bWUyOFRCK1hyUUNCSXRkOXkvM3I2Q25ucTREU0NIeVpBRUkvZEtkNm1n?=
 =?utf-8?B?bDdXWDdzU3Q4Z2Z6Z0JmeEdNSjB5TUMxTEYwQjd1WUw1WCs0YVFlZ09DRExG?=
 =?utf-8?B?MFBla2t4MEVEam9sNjYwZkV2aEN1OGRnNkNmTmYwZjh3VXdrdnByREIxaUo3?=
 =?utf-8?B?SkExd3JLRENteWxQZHBaMVhGdGpyWEVsa1ZYeForbDYrcWprdGZOZGp6M29y?=
 =?utf-8?B?R3hxc0JrYVBCYTJ6bDN5VkVTNlhnKzJVQ1dBV3VJYmdibFZqL29SSitGeUZP?=
 =?utf-8?B?L0d3cWVsREJBUVhGc21VMUhJb1ZxeFErOURrdkpsT01pSkVNeW5QUzNuYXNp?=
 =?utf-8?B?NFhQckl1bjlxakVscnFPU3JwMnNpUlgrUFlqYWphL0NReEd0TEV1K3EzZ3dh?=
 =?utf-8?B?WEV6R3dxaXBKM2JSN0NtRGRYd3NFQjFJUDFxTWwyR2g5RDlPTTc4YU5mZW5p?=
 =?utf-8?B?cVdYWHpnMjdOWGloNXdBMXdTNlQzem0wOEJ6RXRza0tENFYzNFdmbmNZaWln?=
 =?utf-8?B?VkJ5MDR5VmVxNlNlcEEya0s1OHorZ1N2WnNURXE4bFNjQnl6c3ZVMEZLamln?=
 =?utf-8?B?RjZTcTVyOU5JMXptSWx1aEU1eE91dkZJVElHV1E0ODhlVHlxb0gvaDJVcVNx?=
 =?utf-8?B?YmEzMHlEdkF6OFYwOElOK3UvUDVndEJFTWF0SEFaUkhZc3E0ZjNCTktpL3BT?=
 =?utf-8?B?WEJCY2lIKzdocjRQbG5NRlFPNGdvejRabFo1VzNGUFppdFRuZkdRc3BTTnp4?=
 =?utf-8?B?ZTNaUGQva1hGN04wdS9USzJ4OE1nTkgyeHhNR1oyM3A3OEhaekp4MmUzOFpJ?=
 =?utf-8?B?VHdZK1JEek1DR29KbVFqbnBCVG1GMWxpenIwVndtZ1E4UzhHK2NsbFp1ZWc3?=
 =?utf-8?Q?cy6Hpr58iusOjmn9ehrvhbo2bdH4nddSqmEg7gW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49B16194DC67D44FB662618DF7DA44C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb002f5-912b-4f8f-f9b4-08d95e92b355
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 19:44:01.5458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqgq05I0Re97hqtO2PE/hnfN3KM7Oe0SJvCh+ihb5Z4W4HuQmkY3eFNH1c/8qkY0kS5Kv7kTf3p7CcPCr1VtbFJ0NySWAFI+Haui7QjnhTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDksIDIwMjEsIGF0IDE3OjU3LCBCYWUsIENoYW5nIFNlb2sgPGNoYW5nLnNlb2suYmFl
QGludGVsLmNvbT4gd3JvdGU6DQo+IE9uIEF1ZyA5LCAyMDIxLCBhdCAxNjo0MiwgTWFjaWVpcmEs
IFRoaWFnbyA8dGhpYWdvLm1hY2llaXJhQGludGVsLmNvbT4gd3JvdGU6DQo+PiANCj4+IFRoaXMg
bWVhbnMgdGhlIGNvcnJ1cHRpb24gY2FuIGdldCB3b3JzZSBzaW5jZSB0aGUgcm9sbGJhY2sgY29k
ZSBjYW4gdW5kbyBvciANCj4+IHBhcnRpYWxseSB1bmRvIHRoZSBwcm9ncmVzc2lvbiBvZiB0aGUg
b3RoZXIgQVJDSF9TRVRfU1RBVEVfRU5BQkxFLg0KPiANCj4gTWF5YmUgc29tZXRoaW5nIGxpa2Ug
dGhpcyBjYW4gaGVscCBoZXJlIHRvIGVuc3VyZSBhIHZhbGlkIHJvbGxiYWNrLg0KDQpBZnRlciBy
ZWNvbnNpZGVyaW5nIHRoaXMsIEkgdGhpbmsgdGhlIGdyb3VwX2xlYWRlciB0YXNr4oCZcyBwZXJt
aXNzaW9uIHZhbHVlIGlzDQpyZWxpYWJsZS4gUGVyaGFwcywgcmVmZXJlbmNlIGdyb3VwX2xlYWRl
cuKAmXMgZXZlcnl3aGVyZSwgaW5zdGVhZCBvZiBlYWNoDQp0YXNrJ3MuIEkgdGhpbmsgdGhhdCB3
YXkgcmVzb2x2ZXMgdGhlIGNvcm5lciBjYXNlIGluIGEgc2ltcGxlIHdheS4NCg0KVGhhbmtzLA0K
Q2hhbmcNCg0K
