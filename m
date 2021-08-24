Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2C3F630F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhHXQpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:45:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:35778 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhHXQpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:45:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="215510446"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="215510446"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="443860370"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2021 09:45:07 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 24 Aug 2021 09:45:06 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 24 Aug 2021 09:45:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 24 Aug 2021 09:45:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 24 Aug 2021 09:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGl4NCQhsVrGpvh+NN7c10IAnaQUnAkC6O5eJ2JlYF+dOLyUfu7jBOqeYCTcL8H1jvxuC2ad3NJ+3yJpNkZ9OZDl5DHi381ie+/PG+cFkqI1i7Cr8k5w6lEBTLDkMGBfUMuMfgW0yFXXNnJkdp773QDZtTX2uIu6505XtPZWFkIGhUjCVxkmYLkVsvEEWzdPgY3PAzjAnHwB/51R+uZ3Po8dd7kspDypD+fYxtxcoHBw/X46LYn5wgyHTzmi9z8c4UXvZpnzl40xvWpGN5dyfmcNdi6+zyBhLV9sjvDRwEkgOOWjaGLPQamEekmh7GbUcQ8FO+RnbbY9rQ0PBXLbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOO9LS0tCxgUlqEE0vhRFl7oEltPPRd9Yh4vixq53eA=;
 b=gCeICOzoOFgW4vc+EMXaN4o0QXfubwBzbo8RVNg+gAXxW5YywF8DJJOgn91K321Bz7Pn0FvJVI0Mg+0qROXhGdTmbJbO1TLkyv46YqHRtNrl94hHCcpVPUyPqfjknu02NDZ9wcWoMKgRW62VhW3LfSq03gsDVGw3YPbt/68wRgfZt5kuo2AC1JsdYLw4u0HChuI1U66bBaR/Y5m4xWipO7amnpQssNlfdN3DAjJAYESfBKHjErM/1v7tncjbb/kdS1XyJrod3qzaUt7ZxdfnSugYfSACfTxniXLqfoObg9yP5Xq9Xdw8Xdj7U3YYImhN/dB7vZJ8rIetCEmfxz8DHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOO9LS0tCxgUlqEE0vhRFl7oEltPPRd9Yh4vixq53eA=;
 b=AC6ibjaUyGcxfNlAgZ7Lzf1M6G1hoRtntQiVRqK4itmZNKkKQDNsfKDzQoA+V5Fuhd0UPa3USvt7pgo/gJPh7NorGh67nFjtDBYb2qxS3EQz7DWON5aSCWcTm5zlo9LIQOERPF0mR8cD3YJlhizlvXCdy58PO8KcViKK301gjEE=
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 by BYAPR11MB2981.namprd11.prod.outlook.com (2603:10b6:a03:83::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 16:45:05 +0000
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::a8f1:e1d0:ca0d:4577]) by SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::a8f1:e1d0:ca0d:4577%6]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 16:45:05 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wency@cn.fujitsu.com" <wency@cn.fujitsu.com>
Subject: Re: [PATCH] x86/mm: Flush before free in remove_pagetable()
Thread-Topic: [PATCH] x86/mm: Flush before free in remove_pagetable()
Thread-Index: AQHXmQdjJMzqpPZRwUOuIBzzpYSVPw==
Date:   Tue, 24 Aug 2021 16:45:04 +0000
Message-ID: <9b9a99da3f68cf11197f2035515f1d441c0d1565.camel@intel.com>
References: <20210818221026.10794-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20210818221026.10794-1-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35b7333c-5e21-4882-5569-08d9671e866a
x-ms-traffictypediagnostic: BYAPR11MB2981:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2981C8EA3EC4DAEAC00B5638C6C59@BYAPR11MB2981.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIkTlN5CG+2N4DVsen/gLKG5ODfnIUM3o4A0nBTaKvFS2voxuui+1wgPNxrSYkPbHes1spOknGRcrBOBd3KsWbhUC6o99N8b6wpaakLbAIx1L+TU+FuorjhMx+utl+Svbcyunbq4mZFj1/xSBr2+9Ec1jlLGLGCrZs73l5XlIQ9ITgOYyTaHYbWA+rr/17UCl+kEgrkLtTyY14lCFliWeZ0GO1zsuPw+9RQv+eTCj5DYFILbt/QRSUKxf1tLnk4AVPSrLN1KOUAI6E51jOh8nSY9EpdS3JJLSO5wPaNfJko5z5do3CupvdUyvBcP/FfNk+2emtXuYy2BpGgY+4BdbTu2k4Hkptt06Izgl+0bZid8Eg6ff5IiqEstw4Tb8617g7qnlNRmFiPZ1cVFmPt9tk3FPAcQKeZqFVrO+jG3LmebZ+hXnoA9hgPCAG3C7fonjApp0VpUG4zE2IdAuN4LE9H88b+8lkAq2Vpz+llvRuNUtlTlEJO0kw4SV/9yiPmjPa61SZAiIehQ23UPidVO12tnGaiW2I45k1j/wXnBK/lTlRYmL8jgTfx8RvrY6+RNRZJhg+sY6bdwWFsXxg5t2nrGJvxG/z9RyavZA6+Aeq8DO2hgYn13TbsfzWgzuJu7I6yR57DGozAayw/3BzyaFDhhkkDrGduSJB6/P7czCJv2R+D/EjcIK5HGT87MJ1f2U/5DCXT/Qq/Z5kmSQISe7XNWrW3w2vZym2iUxN1Vk3k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5150.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(66446008)(478600001)(76116006)(921005)(26005)(91956017)(64756008)(66946007)(122000001)(2906002)(66556008)(66476007)(38070700005)(316002)(110136005)(6486002)(54906003)(186003)(86362001)(5660300002)(36756003)(4326008)(2616005)(8936002)(8676002)(38100700002)(7416002)(71200400001)(6506007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXozcHhzdmMrQitjazBuWCtVMTdGNWhldnFPV2dld3hlZ0JnQkNRaUFmaFlE?=
 =?utf-8?B?OVRLaHNoTCtJRUJOajFZWVErYi9CWXRHYlJXL2N4RURJZVZ0YjhmcU1RdW9a?=
 =?utf-8?B?WlgwRlBCT0ZxeXFqOE5HakU4MEpuTEZrNGZub25OWXd4QXZvRUhHVnMxdnBp?=
 =?utf-8?B?TmZKR1FVQUJPT25LV3dTMTdEWkpUNVVlakM0WlgxYm83aE9RUGdDK25xMTJm?=
 =?utf-8?B?L2hRaDlkTWFHUGxKV29Xd2w5NHNQMkdTdkZYMG1KVFljN0I1ZXpqSDUwUS8x?=
 =?utf-8?B?aVBMdENYaXIvSTZOVHNmVHFKKzdtaG5aWDBRYUlPUW9kS0haUGdUSXVsVnZX?=
 =?utf-8?B?T2RLRDhZbWt0SVM3akZTWnM3Q0FtcHNzWGF2MkhabzZnYnZ2Zkh6WVNzbStZ?=
 =?utf-8?B?VHZqQ1NGUkxuZmRoNHlYRnp6dVE3eUJJRjNYc0xHY3NYOGFhdFZ1VWFJUDhu?=
 =?utf-8?B?WEorV1VSVmR3RExrWkZoY05UU3l6RGFZUzdBY0ZZYnRaVUJXZjZCRWtuQ1Rr?=
 =?utf-8?B?RGRIbUljZGxzanFIMCt1b2I5VkpOWWlRVjNBVEYybk1EbUVnKzlCaWxiV2pC?=
 =?utf-8?B?d0d5WWxhOTRTSEhGZXFLZ05ENlFUM21nWFhQQVZiUnhVRFlEMFI2aEpjZGdS?=
 =?utf-8?B?MVJMSzA2ZFpuQ2gvZ3dKbE4zWWtnb2hhWjdnL005OWQ3RlgwS1RVRUIxVytM?=
 =?utf-8?B?cGRsUkNrZkNZVE1qeHVEVlFQQ0RwRk1xUWFhbjE4NW5UNHJPbUxvbGo4cnM3?=
 =?utf-8?B?WnRCR0tmNWJvWDZwb3ExT1ZleGpjSGVZcjRvZ2V5SjdwdGlYc2ZoR0Z0VDZx?=
 =?utf-8?B?Q2xHVEtreDhVZDI4UlJ5L2hqZlJaR3podXVrOGh6WmJsSlNMVFVoUHhIdE5u?=
 =?utf-8?B?YlJIa0EvSXlYNVdDQStzSHE4aU1WL2VFWG82dHpvZEdjNzRXU3RkQzNJZVBu?=
 =?utf-8?B?UVZjaUptQmVKdlZKalZteDVibzUwZUJUZlQ2SXhCVlh0MXErM2sxU1dwUzdZ?=
 =?utf-8?B?KzVIQTh5UEpzcmhmQVZkR0ZXQUFMenlVVTVsQklDbDZiOWwwdVhuWnppVXJu?=
 =?utf-8?B?U1l3S2RwM0lNNnJBb0VUTDNVWms0a2VvV1ZzVzBUOFRKZ0tRSWJDRTJoa1M2?=
 =?utf-8?B?MFBEOVFsYU5Vbzd2eFh0Nm5LSGZ6MXJwTWpzY3o2NnNpMkFRUkUzWlp6dDVl?=
 =?utf-8?B?TWpJQmZIcXFCSmpIYXBrZXJmQzhXdTUvTEhlbU5EdEZtMmN4NDM4US94S0lq?=
 =?utf-8?B?M2syNnYwUmVlelo5SVNHR2R2NmIrb29ZTzlSOFpxa2xiUkVvVVhIanJSQmZ2?=
 =?utf-8?B?VHI5eDZadmVkQzBId3U1NGhMbFl5K0VHNFBnbUo5dWwwTmVLcThWbGpGLy9L?=
 =?utf-8?B?SDV0RFFOUmFjZXdFSk9jYjlyRFZlbUU4WHF1UEZHWkQwOGNJNnZ2NVlyUG02?=
 =?utf-8?B?eTM3djBTMVBjR0IydFArcUp4d09YSTBlemJqTkhqbzR3dlJqTmxkN2hkQUky?=
 =?utf-8?B?SHdrWkIvY2VvVTZTSjNLbFV3YUtwczNUV0I5ajFSSlRoRFEvSEdsdllqamtp?=
 =?utf-8?B?cEx3b2tQbXFpMVJ6STBHN2o2eFd5K2syQWU1NTZXZDRld2J1Z250dDFmbzl1?=
 =?utf-8?B?ckNBQ1B1cWJxTTZwVEx0OEREQkkxSThOeVZ2SjNtNDVkSjM0Rk8rZ1Uvc1Bp?=
 =?utf-8?B?N0hRWFFjeHpobm5OVWxCZXJGUGRxbFBMTllySDhzUldpeEpYaFlmNUVoYUNn?=
 =?utf-8?B?K0tkNlFYdHR5elpKWWtaNjdkajZHR1BNenVlRk5jVGNRYWtWMHh0S0huMzAy?=
 =?utf-8?B?MWlCaFF3dGhUR1BweWw4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A388C56D21E484EAFB00F5627629E47@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5150.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b7333c-5e21-4882-5569-08d9671e866a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 16:45:05.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4FUSl+VxJw84d2DaY5D4qFRpml1EVZqIwF3l3fNiMxiebTIsqCkCN4JrP9YS3mDkCNrcEpNHO6cs8DgiRBdKk3lunhoIwF4oi0n6wM1+5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2981
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTE4IGF0IDE1OjEwIC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gDQo+IEluIHJlbW92ZV9wYWdldGFibGUoKSwgcGFnZSB0YWJsZXMgbWF5IGJlIGZyZWVkIGJl
Zm9yZSB0aGUgVExCIGlzDQo+IGZsdXNoZWQuIFRoZSB1cHBlciBwYWdlIHRhYmxlcyBhcmUgemFw
cGVkIGJlZm9yZSBmcmVlaW5nIHRoZSBsb3dlcg0KPiBsZXZlbHMuIEhvd2V2ZXIsIHdpdGhvdXQg
dGhlIGZsdXNoIHRoZSBsb3dlciB0YWJsZXMgY2FuIHN0aWxsIHJlbWFpbiBpbg0KPiBwYWdpbmct
c3RydWN0dXJlIGNhY2hlcyBhbmQgc28gZGF0YSB0aGF0IGlzIHdyaXR0ZW4gdG8gdGhlIHJlLWFs
bG9jYXRlZA0KPiBwYWdlIGNhbiBjb250cm9sIHRoZXNlIG1hcHBpbmdzLiBGb3Igc29tZSByZWFz
b24gdGhlcmUgaXMgb25seSBhIGZsdXNoDQo+IGxvd2VyIGRvd24gaW4gcmVtb3ZlX3B0ZV90YWJs
ZSgpLCBob3dldmVyLCB0aGlzIHdpbGwgbm90IGJlIGhpdCBpbiB0aGUNCj4gY2FzZSBvZiBsYXJn
ZSBwYWdlcyBvbiB0aGUgZGlyZWN0IG1hcCB3aGljaCBpcyBjb21tb24uDQoNCkl0J3MgYWxzbyBj
b21tb24gZm9yIGRldmljZS1kYXggcmVjb25maWd1cmF0aW9uIHdoaWNoIHdlIGFyZSBpbiB0aGUN
CnByb2Nlc3Mgb2YgYWRkaW5nIHVkZXYgYXV0b21hdGlvbiB0byByZXBsdWcgZGV2aWNlcyBmcm9t
IFpPTkVfREVWSUNFIHRvDQpaT05FX3tOT1JNQUwsTU9WQUJMRX0gYXV0b21hdGljYWxseSBkZXBl
bmRpbmcgb24gd2hhdCBzZXR1cCB3YXMNCmVzdGFiaXNoZWQgb24gdGhlIHByZXZpb3VzIGJvb3Qu
IFNvIGV2ZW4gaWYgdW5wcml2ZWxlZ2VkIHVzZXJzcGFjZQ0KY2FuJ3QgZm9yY2UgdGhpcywgdGhl
cmUgbWF5IGJlIG1vcmUgb3Bwb3J0dW5pdGllcyB0byBmaW5kIHRoaXMgZ2FwIGluDQp0aGUgZnV0
dXJlLg0KDQo+IA0KPiBDdXJyZW50bHkgcmVtb3ZlX3BhZ2V0YWJsZSgpIGlzIGNhbGxlZCBmcm9t
IGEgZmV3IHBsYWNlcyBpbiB0aGUNCj4gaG90IHVucGx1ZyBjb2RlcGF0aCBhbmQgbWVtcmVtYXAg
dW5tYXBwaW5nIG9wZXJhdGlvbnMuDQo+IA0KPiBUbyBwcm9wZXJseSB0ZWFyIGRvd24gdGhlc2Ug
bWFwcGluZ3MsIGdhdGhlciB0aGUgcGFnZSB0YWJsZXMgdXNpbmcgYQ0KPiBzaW1wbGUgbGlua2Vk
IGxpc3QgYmFzZWQgaW4gdGhlIHRhYmxlJ3Mgc3RydWN0IHBhZ2UuIFRoZW4gZmx1c2ggdGhlIFRM
Qg0KPiBiZWZvcmUgYWN0dWFsbHkgZnJlZWluZyB0aGUgcGFnZXMuDQo+IA0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBGaXhlczogYWU5YWFlOWVkYTJkICgibWVtb3J5LWhvdHBsdWc6
IGNvbW1vbiBBUElzIHRvIHN1cHBvcnQgcGFnZSB0YWJsZXMgaG90LXJlbW92ZSIpDQo+IEFja2Vk
LWJ5OiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQoNCkFj
a2VkLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCg0K
