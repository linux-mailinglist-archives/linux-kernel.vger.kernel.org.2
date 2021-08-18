Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655523F0C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhHRTrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:47:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:3073 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhHRTrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:47:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="203559770"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="203559770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 12:47:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="594143213"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 18 Aug 2021 12:46:59 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 12:46:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 18 Aug 2021 12:46:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 18 Aug 2021 12:46:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4fePQ7P0Oj7uJHiE4giIu8EWRf9WAXHDhHNrfKrUMi8El0Os4CEDH4nLkiCXpQ572IO30cZr5eoMsrh/Hhc2VzU8WCPZpaFoUJ0tfhpgC0vFyf6IeIgzz/LSNy2bpLkqYdiDr00Aj7lCoFPKGXpkp82Ldbgv9wbfjsRlgbkuwWzZFrdv4O1lo3Two6D4HmvjWYeF7qpOP3/UrN8L5cG2P1R/r9xxXgFhIlOGi6OlPdOH+VXxjeoBYHs1+GLnmk2bidQr5W6Rt4x9mHzhQ+D9unZfklofpNWCXALaIP+L5sOJ+Peiur9CCMEVEOdBFTWEJp4N/6dJcZeB3b8uEoMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3udsWWP4awr0u4ZqMXDMipgW9iNcQa/oyxrmQqoci6Y=;
 b=WmD0Ct1nRKvdDo43WZbyys0m011hvd6PGKgf00N7CR3Ii/vrPNIXGlgamRQU96CXYVwwXmxFM3Gf+EhltlLHfg/kRDWVS5HBSNUm+WgmCQk12KPGRd4zDzx3zVu/la5x6PXakk+QyIbH9fpzwf3azcSVsLFP6EmWM24YVMfxpExITwwlxYZe49LN5R6Xti/ePxD4ir21U3E8HG9Fm3+fZGKrVOMeYhRcBJAa51eV1daFWpmiegdysPA+mRvucWvVsNLxTeOj/AXPoLdEa2qTrOl5S6uYDNZIwZvpudK1278qpLttFC8CtWQh0JwFh1FOA23LMmOo60JRwKQSS4q/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3udsWWP4awr0u4ZqMXDMipgW9iNcQa/oyxrmQqoci6Y=;
 b=YyfMajiYEKlnmOMEk5E6B6ixHPPEfQ9jd/Ud4d2D/ZW7voItOD4KdzCzFAj5ZesWDg0IGVIM0uo4WQRyP0bwGwd9IlF3xV+3EPEna3JtZMxuB+4soN0kHDs/AhKcwq3pvztyyHxqJSz6CMGeRDBrIL4DI5yTKtujh17iRByhfnc=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5206.namprd11.prod.outlook.com (2603:10b6:510:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 19:46:55 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 19:46:55 +0000
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
Subject: Re: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Topic: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Index: AQHXhVRxstI5EaBny0+yAHwtQ/jrKKtwWl6AgADOwYCAACF+gIAAoc+AgAcvswCAAKzPAA==
Date:   Wed, 18 Aug 2021 19:46:55 +0000
Message-ID: <B0E262FE-21C3-44EE-B058-752ACDECD716@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com> <YRV6M1I/GMXwuJqW@zn.tnic>
 <2BF12EDA-89F0-40F7-B63E-50ADD0262164@intel.com> <YRZDu2Rk+KdRhh1U@zn.tnic>
 <2B279B5F-ACF2-46F2-9259-684419A57BDF@intel.com> <YRzSuC25eHEOgj6h@zn.tnic>
In-Reply-To: <YRzSuC25eHEOgj6h@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 437b3bcd-112b-403f-8e2a-08d96280eede
x-ms-traffictypediagnostic: PH0PR11MB5206:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB520658509520D944B9C2379DD8FF9@PH0PR11MB5206.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f2INg6EicL85LkWs5mKqXvuMSXMbkX6K4BeKYy4cU7KtrqEzHOD727QzckgNwRJZ6aH/yUZq9mAXO4TzKz6rtnIOCfXHsDjIHPft5ZCiiSx1MkmNh9J+bhgNXF0O/pIJMAqkIhHPys3xLNXpm3OVgKuuLph7xUxsSC0+KiamgpGsJtJ9kp128ydVcXrlfmKeRVU1Pi/IPfDLr/LtFBuQY0xXRDNgf9u0ciKlFmuuyeXdi8rBJYS89aX2Ul7s/XplWxJkD881xPilagH66qPi4B7XpyJNAsJCVMnuT47/5aG/Xi7F0X38Bv149DkkzA2qiW+qxUMU3aYITa+9KvHHncKqoDzDGCkjGxeo7QiPSP1CDHSVP53TB5uQMmO0o+2l5Ri8n/huPkcPG11AMKD4LweTGtPgKhL+HUNM9PAsKFanXsQrAPOaVFShz6/98dcSdMZSKaxnV6jpWUru/E3Li2e35Xr3rlshNwHR9cSN722JJTjUhwA1tZCJMlTowDnaeAJWHdQRq6jvV25TiV9HG32vYTPrNE8UXT+igTH9k/jPB3/xOyRlTliA+VNtUmP4cNUDQxQQH6dc2R2UfmYjgkHDi4YnpjU9+DYUQSbngZ8GTJtKJ5dNiYuwMJ1Nw513nYp8ewbWDUTQhfyx+YsZ8wcGtaSkAEo6nt2EzWUkv+rmkjbi+u3ZS3GTTluXHolcW3TW/sze78E3M0G1orpO83oV6OWP1+UHIDOYaV8tl2WuDrIEpKy01HgqW2HH7PW0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(33656002)(66476007)(478600001)(53546011)(6506007)(36756003)(316002)(26005)(8676002)(6916009)(38070700005)(4326008)(5660300002)(38100700002)(64756008)(71200400001)(122000001)(54906003)(66946007)(8936002)(76116006)(2906002)(186003)(86362001)(6512007)(83380400001)(2616005)(6486002)(66446008)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDZnM01hdDRqTURiVVJxVkxsREJpYUxMOWp1bHpIZkd6SDlLRUFKOXlyRmhG?=
 =?utf-8?B?RDJHbTFrakFERk41MjdXMXdzMm5nQnREanhhMi9qc2Z2Mld3ZERVMEtRR21L?=
 =?utf-8?B?VHpHenJNRFprSkxIRUIybVJpVlN3ZmhvM1VLZVo0bDhrUkZnR25veWFibnJM?=
 =?utf-8?B?aDhZaDRRYmxqV3F3WXBDUWU4TW5DdVBiUHpCdElvVjNsN0R3OEVFYkZpRThH?=
 =?utf-8?B?dHVsSWUxS1V6MmtEbVRUU3BBd3BGU3BSOEVSQWpObzBJYUxvSm5vVnIyY0tY?=
 =?utf-8?B?YUM2eHhnMTIxajROTUxUWGZPMWNiUmpKdTZLUS8ydmlCNHhuNGcxaFduQy9v?=
 =?utf-8?B?UjBuNnVhb2FlbDNQbmQxaEorSVBzKytFR1JYZmo5VW8wSytCaW1qMEIyTXZo?=
 =?utf-8?B?VUNNNlYyNUVaeFdOR1pNY2NYUEFITGxrb3ZMTUhWWGJ2YTFTaStmeXJDK3R2?=
 =?utf-8?B?TDRvUzRvYTdhVC9hdXJlWkg4aktVd1ZKek5EZ01YS29QTktvQVcrZityS0U0?=
 =?utf-8?B?VjNUU2lqblBoZUxzeTdaZjEzOC9XZythN2U2RGJ0NGVzNm53YVptS2xUNVJu?=
 =?utf-8?B?cFAwakM0S1dGMklOMnQrbWhhZnNDYlRmQlhDU0NHV0ZQNXRqWWhWWUFrT29y?=
 =?utf-8?B?cDYvRkZxUlNaK3JkbzMvMDlTTWo5RS8vdlpzMnpSREhnM3JYOUlKZmFMRHM4?=
 =?utf-8?B?b05TdFExVG1OQUxIcjRUVm5qL1d3OXFqM2xYUlI4clZoRzhoR0dRQXF4THdv?=
 =?utf-8?B?ckZTRVEvcmF2NmRETHM4SzJyOXo4TXNJQTExc0RRT0JlUVFzOTA3RlE0VzlI?=
 =?utf-8?B?VGh5ZVRjaHFhS0xvQ3pLblZ4aExTeFlHaFl5S01JZGtyZGw5MFNVeVNxUTBw?=
 =?utf-8?B?TmprWWtaNDRJdGQzb2ZLZXAvUGIwVHMvdm1lTXBJVVdRdDJkT241a0Zrc2xw?=
 =?utf-8?B?M0Y5UUpCOXh5ejlOc2w1VEZaMEZqNlR0amZHeGhPdFdQcUJZajZwVzNKQUpm?=
 =?utf-8?B?YStidlVpZ1NuUlZsYkQ1OW9sNkZWS0dySmdDV1FBcVhvd0crSzQ2ZWdrbG9X?=
 =?utf-8?B?Nks4dWp2K0RNYS9BK3ptR3BGZi83ZUhZK3dRczNvRmptcVNrY3ZqdHB4WHI5?=
 =?utf-8?B?bFd4bnNjVm4xME9CUjVVZjBXbTc4Q1QzZFdlSWdLRFp6YWk3eGpQV3VUc3dT?=
 =?utf-8?B?TDYrNGhQbUhteG5WalZWY21WbXZ1Rmh1U2FBbGQ0U09NS1JEMUM4U0c5clQ5?=
 =?utf-8?B?Q2JEN01IMGFYQ3FpY0dZc1YybVNRdTRGT0hjeTJjL3M5Y0N4OWFweFM2ek1u?=
 =?utf-8?B?Y3YyL081MjNSL0d6d1pjcnZNR2VhQ1V2bEEzdXcyOWhvU09yZHQwUEIydncv?=
 =?utf-8?B?U041SkJMWEwvREhla3p0aW1aRmthSGhkZ1RRU3dML1F6TWM2Ry9PcUlkVkJt?=
 =?utf-8?B?SVU0dlkzM1JmVEUvbHhHSXNXS1BKNkpSNlAwdTAxbVg2azVNY01SS0hRTk1q?=
 =?utf-8?B?aVIvVWVxci91S0YvQ3JJbGtHSUJuenYyZG8vSWxSSXZBd1pyV3RvN1cxc2pq?=
 =?utf-8?B?M0diVGYxR3U2Q0RFZlpENys3OU5qZ0tVdW04RFBNSlMzYUh4ZU50YTlYUUtT?=
 =?utf-8?B?MWhaODhxZFRzSlhnT3lXYjk1cjIyd2t2dWorYnQvb1lqN0RUanU0aXJHME8v?=
 =?utf-8?B?THRZdWdEbW9FYUJTUHRoWnlTV2lqNlM1RWVpMkJSMVZ6NEo1Z29TbXZkNlM2?=
 =?utf-8?Q?zw1g7yU4Srn0ASI1EOVNJRkJS1iFaHrIDA/y99t?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D7A32A14B359C4EA132A75E62F3A1B2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437b3bcd-112b-403f-8e2a-08d96280eede
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 19:46:55.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKLHZGPNo8FdQNZADx5HzVi/r2WgY0J1qdnDw3IdYhY698osbR62+ewvv5GE5gQuVdHtm4n5xYq83WDX+wN55sCocTD5/F0ilRrSMEkBFXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5206
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDE4LCAyMDIxLCBhdCAwMjoyOCwgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
IHdyb3RlOg0KPiBPbiBGcmksIEF1ZyAxMywgMjAyMSBhdCAwNzo0Mzo1M1BNICswMDAwLCBCYWUs
IENoYW5nIFNlb2sgd3JvdGU6DQo+PiBXaXRob3V0IHRoZSDigJxjb21wYWN0ZWTigJ0gbm90aW9u
IGluIHRoZSBmdW5jdGlvbiBuYW1lLCBvbmUgbWlnaHQNCj4+IGNhbGwgdGhpcyBldmVuIHdpdGgg
IVhTQVZFUy4gQnV0IGNoYW5jZXMgYXJlIHZlcnkgbG93IGluIHByYWN0aWNlLg0KPiANCj4gU28g
bGVhdmUgb25seSB0aGUgZmlyc3QgdHdvIHdoaWNoIGFyZSBvYnZpb3VzIGFuZCBhcmUgbW9yZSBs
aWtlbHkgdG8NCj4gaGFwcGVuIC0gdGhlIGZpcnN0IG9uZSBpcyBnb2luZyB0byBiZSB0aGUgbW9z
dCBsaWtlbHkgb24gbm9uLWR5bmFtaWMNCj4gc2V0dXBzIGFuZCB0aGUgc2Vjb25kIG9uZSBpcyBv
biBkeW5hbWljIHN5c3RlbXMuDQo+IA0KPiBGb3IgYWxsIHRoZSBvdGhlciBjb25maWd1cmF0aW9u
cywganVzdCBkbyB0aGUgbG9vcCBhbmQgdGhhdCdzIGl0Lg0KPiANCj4gKklGKiBhbiBvcHRpbWl6
YXRpb24gbmVlZHMgdG8gaGFwcGVuIHRoZXJlLCB0aGVuIGl0IGNhbiBoYXBwZW4gbGF0dGVyLA0K
PiBzdXBwbGllZCB3aXRoIHBlcmYgbnVtYmVycyB0byBqdXN0aWZ5IGl0Lg0KDQpObywgdGhpcyBu
b24tY29tcGFjdGVkIHRoaW5nIGlzIG5vdCBmb3Igb3B0aW1pemF0aW9uLiBTRE0gaXMgbm90IHF1
aXRlIGNsZWFyDQphYm91dCB0aGUgbG9naWMgYmVoaW5kIHRoZSBub24tY29tcGFjdGVkIGZvcm1h
dCAtLSBzb21lIHN0YXRl4oCZcyBvZmZzZXQgZG9lcw0Kbm90IGFsd2F5cyBtYXRjaCB3aXRoIHRo
ZSAnc2l6ZSArIG9mZnNldCcgb2YgdGhlIHByZXZpb3VzIG9uZSwgZXZlbiB3aXRob3V0DQo2NEIt
YWxpZ25tZW50LiBTbywgdGhlIGxvb3AgaXMgb25seSBmb3IgdGhlIGNvbXBhY3RlZCBmb3JtYXQs
IG5vdCB0aGUNCm5vbi1jb21wYWN0ZWQgb25lLiANCg0KSXQgd2FzIHJlZmFjdG9yZWQgdG8gdXNl
IGluIHRoZSBuZXcgaGVscGVyIHRvIGZpbmQgZmVhdHVyZV9ucuKAmXMgc3RhcnQgcG9pbnQuDQpJ
ZiB0aGUgc2l6ZSBpcyBhZGRlZCB1cCBoZXJlLCBpdCBpcyBub3Qg4oCYaeKAmSdzIHN0YXJ0IHBv
aW50IGFueW1vcmUuDQoNCj4+IFBlcmhhcHMsIHRoZSBjYWxsIHNpdGUgaW4gdGhlIHB0cmFjZSBw
YXRoIGJlY29tZXMgbGlrZSB0aGlzLCBJIHRoaW5rOg0KPj4gDQo+PiArCWlmICh4ZmVhdHVyZXNf
bWFza191c2VyX2R5bmFtaWMpIHsNCj4+ICsJCXU2NCBzdGF0ZV9tYXNrOw0KPj4gKw0KPj4gKwkJ
LyogUmV0cmlldmUgWFNUQVRFX0JWLiAqLw0KPj4gKwkJbWVtY3B5KCZzdGF0ZV9tYXNrLCAoa2J1
ZiA/OiB0bXBidWYpICsgb2Zmc2V0b2Yoc3RydWN0IHhyZWdzX3N0YXRlLCBoZWFkZXIpLA0KPj4g
KwkJICAgICAgIHNpemVvZih1NjQpKTsNCj4+ICsNCj4+ICsJCS8qIEV4cGFuZCB0aGUgeHN0YXRl
IGJ1ZmZlciBiYXNlZCBvbiB0aGUgWFNUQVRFX0JWLiAqLw0KPj4gKwkJcmV0ID0gcmVhbGxvY194
c3RhdGVfYnVmZmVyKGZwdSwgc3RhdGVfbWFzayAmIHhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1p
Yyk7DQo+PiArCQlpZiAocmV0KQ0KPj4gKwkJCWdvdG8gb3V0Ow0KPj4gKwl9DQo+PiANCj4+IE1h
eWJlIHJldHJpZXZlIFhTVEFURV9CViBpcyBpbmV2aXRhYmxlIGhlcmUuIFRoZW4sIGl0IGlzIG5v
dCB0aGF0IHVnbHkuDQo+IA0KPiBMZW1tZSBzZWUgaWYgSSBjYW4gZm9sbG93OiBoZXJlLCBhIHRh
c2sgaXMgYmVpbmcgcHRyYWNlZCBhbmQgdGhlIHRyYWNlcg0KPiBwcm9jZXNzIGRvZXMgUFRSQUNF
X1NFVFJFR1MgdG8gc2V0IHRoZSB4cmVncyBhbmQgeW91IHdhbnQgdG8gZ28gYW5kIHJlYWQNCj4g
b3V0IHRoZSBYU1RBVEVfQlYgdmVjdG9yIGZyb20gdGhlIHN1cHBsaWVkIHhzdGF0ZSBidWZmZXIg
dG8gc2VlIGhvdyBtdWNoDQo+IHRvIGVubGFyZ2UgdGhlIGJ1ZmZlci4NCj4gDQo+IFdoaWNoIG1h
a2VzIG1lIGdvLCB3aHV0Pw0KPiANCj4gV2h5IGRvZXNuJ3QgdGhlIHRhc2sgYWxyZWFkeSBoYXZl
IGEgbGFyZ2UgZW5vdWdoIGJ1ZmZlcj8NCj4gDQo+IElPVyBhbmQgSUlVQywgeW91IHNob3VsZCBu
b3QgaGF2ZSB0byBldmVyIHJlc2l6ZSB0aGUgeHN0YXRlIGJ1ZmZlciBvZiBhDQo+IHRhc2sgaW4g
cHRyYWNlLg0KDQpTb3JyeSwgaXQgbG9va3MgbGlrZSBJIG1pc3NlZCBhZGRpbmcgdGhlIHBlcm1p
c3Npb24gY2hlY2sgaW4gdGhlIGFib3ZlLg0KDQpbIEkgc2F3IHRoZSBkaXNjdXNzaW9uIGhhcyAo
cmUtKXN0YXJ0ZWQgZm9yIHRoZSBhbGxvY2F0aW9uIEFQSSB0aG91Z2gsIGFzc3VtZQ0KICB0aGF0
IHRoZSByZXNpemUgaGFwcGVucyB0cmFuc3BhcmVudGx5IGZvciBub3cuIF0NCg0KU2F5aW5nIHRo
ZSBwdHJhY2VlIGhhcyBuZXZlciB1c2VkIEFNWCAtLSBpdCBoYXMgYSBzbWFsbCBidWZmZXIuIFRo
ZW4sIGlmIHRoZQ0KcHRyYWNlciBhdHRlbXB0cyB0byBpbmplY3QgdGlsZSBkYXRhLCBhbmQgdGhl
IGJ1ZmZlciBpcyByZXNpemVkIGhlcmUsIGl0DQpmYWlscy4gVGhpcyBwcmVjbHVkZXMgQU1YIHN0
YXRlIGluamVjdGlvbiBhcyBhbGxvd2VkIG9ubHkgYWZ0ZXIgdGhlIHB0cmFjZWUNCmV2ZXIgdXNl
ZCB0aGUgc3RhdGUuIE15IGNvbmNlcm4gaXMgaXQgbWF5IG1ha2UgaXQgY29uZnVzaW5nIHRvIHB0
cmFjZSB1c2VycyBhdA0KbGVhc3QuDQoNCj4+IEluIHRoaXMgY2FzZSwgdGhlIHB0cmFjZXIganVz
dCBmYWlsZWQgdG8gaW5qZWN0IHNvbWUgY29udGV4dC4gQnV0IHRoZQ0KPj4gcHRyYWNlZeKAmXMg
Y29udGV4dCBpbiB0aGUgKG9sZCkgYnVmZmVyIGlzIGludGFjdC4gSXQgd2lsbCByZXN1bWUgYW5k
IGV2ZW50dWFsbHkNCj4+IGV4aXQuIEkgdGhpbmsgYXJjaF9yZWxlYXNlX3Rhc2tfc3RydWN0KCkt
PmZyZWVfeHN0YXRlX2J1ZmZlcigpIHdpbGwgdGFrZSBjYXJlDQo+PiBvZiB0aGUgb2xkIGJ1ZmZl
ci4NCj4gDQo+IFlvdSB0aGluayBvciB5b3Uga25vdz8NCj4gDQo+IEhvdyBhYm91dCB2ZXJpZnlp
bmcgaXQuDQoNCkxldCBtZSBjb25zaWRlciBhIGNhc2UgdG8gbWltaWMgdGhlIHNpdHVhdGlvbiBz
b21laG93Lg0KDQpUaGFua3MsDQpDaGFuZw0KDQoNCg0K
