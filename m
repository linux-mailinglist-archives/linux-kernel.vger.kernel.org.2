Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC454254A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbhJGNvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:51:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:58560 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241766AbhJGNu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:50:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213201217"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="213201217"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 06:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="522604051"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2021 06:49:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 7 Oct 2021 06:49:01 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 7 Oct 2021 06:49:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 7 Oct 2021 06:49:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 7 Oct 2021 06:49:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOPmjTY2remZvE9qeG498S50LD6o5YzJ90Jue2oOhs6NksKclrob8ta7+7vOz1mQhPY/AfgX0aq0pKHE31FvwCMk+UrPbJuw3ThymfAs1wKhlfR3C9/+X+MYG5HrucsoIKEfP7bs3XCV3pBsyUWL89yGoI4bPIRQKSGQIVzEIg8XCSWw1ecXJxvBeJjJ8QHi56z9Nqf7IfkBQbNl2Eo6MxBorirUZUhWMTpzhZRrnxRDYYF6lcpvQG89aEykmiXe1ne8mee1Uhsoqf4cu7H9taHM+xfRxAfkSWCO7Pc9ACCcOmBlM0msJNdJPKh1KS5PINiNmJpc5VZ9RYoQXmJeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJ6UDAI5g9eaGzYV9KvIgPce5lfb9Kt5EwRIvLJ7U9s=;
 b=oAyICz7SewyhhuR8TeYyp758lr17K047fNcAfUddZviVYqiGhvpSOI9vr94IdYrV6FQl0ozR0xFSFvJL11Tj9JQfijljsUM80TyllbIBfumcr2AsPZn/yky3o7Zqg/+rY/QeL4ZQhH2hb6daK5GSAf1A/YbIc6XYIK0kCgXNtSUDOfBREh8tXTzScyao+/kkMU8LHag2/deC3IFjRSs+IAbIuNwpAfeI8Vo1gGU6njaARsTvOrENoMAFYa01tE33EaCGAW9CvQV0QPYIGkjhpeeUvXzV9M+DYfCa2gOpan8at8CRs4ibxu5pZQOy6Vp4t4gHKy312GJ5OUOb4zw52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ6UDAI5g9eaGzYV9KvIgPce5lfb9Kt5EwRIvLJ7U9s=;
 b=wQXKWljcZCrFSH+ZNvpPqPbArmPpQbiRdTlDaknN1rfUkI6mxxqXetWWOIAdk/wfFcLBqltShCm2p1mbkgBeNzIGH/q4XA5DXWvRIITQ3ApZOqwBQPjgMjvyoiyGSRIK5xacLnDBhL+YdU+yagJ6/SSvPn4E0ILjie42iZyHPoI=
Received: from MWHPR11MB1919.namprd11.prod.outlook.com (2603:10b6:300:106::22)
 by MWHPR1101MB2095.namprd11.prod.outlook.com (2603:10b6:301:5b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 7 Oct
 2021 13:49:00 +0000
Received: from MWHPR11MB1919.namprd11.prod.outlook.com
 ([fe80::698e:991:9d18:3727]) by MWHPR11MB1919.namprd11.prod.outlook.com
 ([fe80::698e:991:9d18:3727%6]) with mapi id 15.20.4587.019; Thu, 7 Oct 2021
 13:49:00 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     "Liao, Bard" <bard.liao@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Bard liao <yung-chuan.liao@linux.intel.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, Rander" <rander.wang@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        "Yang, Libin" <libin.yang@intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        "Paul Olaru" <paul.olaru@oss.nxp.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "Song, Gongjun" <gongjun.song@intel.com>
Subject: RE: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate
 rt5682s
Thread-Topic: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate
 rt5682s
Thread-Index: AQHXus4W5/VsLw98jkS1akrmyRygKavGNrGAgAABwICAAJzyAIAAuFKQ
Date:   Thu, 7 Oct 2021 13:49:00 +0000
Message-ID: <MWHPR11MB1919202E2EE479BD1EF540D997B19@MWHPR11MB1919.namprd11.prod.outlook.com>
References: <20211006161805.938950-1-brent.lu@intel.com>
 <20211006161805.938950-4-brent.lu@intel.com>
 <fdcdf447-352f-3dbc-f55d-b3bb3588dca3@redhat.com>
 <ecde4150-2782-9529-3288-b1eb9e247883@linux.intel.com>
 <DM6PR11MB40743B517390C8F04938CBBEFFB19@DM6PR11MB4074.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB40743B517390C8F04938CBBEFFB19@DM6PR11MB4074.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2d29d3e-094d-4a3a-36b0-08d9899937b8
x-ms-traffictypediagnostic: MWHPR1101MB2095:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB209555BAE41A19E86AAAFA0E97B19@MWHPR1101MB2095.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aks0XjtwBzgM8ns5tU+RA6jbEa52cp8QNU/NVw1TYojc6bcNXcp0UgvDBa/3oC/pFTR3Xg0jwoTo3tiNR3pz7w1e1mmkiz/6thfEOGyItEdMjKGp5HsK8uVTrce+TkO8CrZ9rzatXIcjZN8pilW8juKPztP6xJ2/shtRm4OfT2j8PAOsStd4CYehFQU38HIcbw5r5/6qqgEBPdUZvToWayAHEP43YpNLI4IL3XstZ2hLJJuV8GhZ+Gn7rDMPx3ZhdmucXhxFROsDZ8aSSAEcqB4SZR89KGuRUtQkdgZ4nVAsTbAmkN9aIOJYuLT/eErxA+ts76EjXIlPXEpyrJORKmXAeD8Lg50vJV/mZ1D1xrP0d2OxUW/TQdDYeW0NY1oBGI9hSqzO4/7EH7Slf47CrzC5QhbJg0neaOj9SxeBD7Guw++RnGwsBrqZdxGNmfhUlrUM5vPL4jg8tgtkG31+ecb5uH1p6FLxAQ/eF6lAUJZ/p82QisSjINNPSF+qtM7UqURW/62O7nFq5hQzLcvLRwMkQsgkVoIv+JhhmM2Ub4zBSWXr3d4ecMlt6X0uWfAj8GJOiw8MQNFYQNt3QaE4BTHdlTwmN2rikXHiMhtsuQVe3qSpCjNIB1nmMT+fD6jx2RF8iwhOyLPs/vK3JA3ZjOU59vM7FvNJHFksjNy02I3V33s7MwQ/i+JWM8bHq5GmIhBG27g59zp0IgZ1YUrw39+TsTEg6ruUqoewmazza4w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1919.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(7696005)(6506007)(316002)(110136005)(71200400001)(8936002)(54906003)(2906002)(26005)(186003)(33656002)(122000001)(38070700005)(8676002)(4326008)(7416002)(5660300002)(38100700002)(9686003)(508600001)(4744005)(55016002)(76116006)(66446008)(52536014)(66946007)(66556008)(64756008)(66476007)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTZ2Z1poN2hCNCtyLzJJZU4rdHBRT0REU1lJNTY0VjYycEhKbzhBVGUwQlNp?=
 =?utf-8?B?ZVZvb0tyMnVsRTlKVVhiMWpaN2hkQm40SERqS1JjaXo1cEhyaFh5dTNSQ0FI?=
 =?utf-8?B?bmlaT0orU1VKd2ZzLzZubWZBWXlqUnhpMmRHOVFpYWpFa2dSZURxSnZsUlU5?=
 =?utf-8?B?cEhFKytCR0Y1cnRhSWxkaFE5TEc1R0ordHRmVkdXbUxxREdibjZZdnJRL2tE?=
 =?utf-8?B?RFdYdXpjQVRkYzhUUy94d2RGV2ozUkU0dENRaUN0S0ROY3B4RDdsbmFpYXdE?=
 =?utf-8?B?a3ViSmxsa0MrTWJrbFBWNnVROWdaRUQrR3JpcnBqbFVTdTRHVmYvVkVFUVdt?=
 =?utf-8?B?bHJjanBWM1d4cDBiR3ZSN2p0QjBsbjZzcWtVemF6RDEvWUE0U3duRExaU3Z4?=
 =?utf-8?B?RlF4QzgrQlkvdG11SHhXNXhnbGtyYjNtMmUvU2FEZmsxQktlVnJJbjJyZE0r?=
 =?utf-8?B?d3UvOXpqU3V6eVFZTGZtc3VLb0tnZzMyMGZjWFlJaVRvUmZxTVdSbWdqeFNS?=
 =?utf-8?B?cHNpdG1ITHpXVVA4QzBwVUZoK05oNkxodG1kKy8yaEpla3Z5RllpQVBOazZj?=
 =?utf-8?B?Ti9aZnRyTnRXQUFqR0lNSTI5SkFCVGZ5RllESlI3K09jc0sycnRpa2w2YTVU?=
 =?utf-8?B?ODczWUxzcWJTQVZ4bERMN2ozWjFFcm9jYlo2SXFRdUhCN3J2d2tkK0JMR2ht?=
 =?utf-8?B?WXoxb1BEUFRwWmVNVEdXelArNHJyRjlLNUlJMWl2czZnd2RkSmZIZWJOQ3oy?=
 =?utf-8?B?Z3ByQnd1MzY5N29SSkR0ZVd5elJIanRKaTMxdHphSkxiSHEranQwMWtTcS9W?=
 =?utf-8?B?VXUyYzJyNDJmWmFYakJaZytrZjQ5SzBXd0ZpOXp0ZlIvUkhRcEU0VjIyZHFl?=
 =?utf-8?B?RFhvcXYvenNrZjJUcHZmcktwdFVYN0ZHS01oSk03V1lUNXVORGJnaVR4UHFt?=
 =?utf-8?B?V1l3dm40eUdNM1pYNnBlS2lzbjUxN2t2ckNHMk03OWJCLzVjTGxaV1RDNU9l?=
 =?utf-8?B?UkhQY3FzNnBMRWFVVS9Ic1Z3ckpVL1hsUHB3aFp1ZnNsZnZKaGJraDYwc3la?=
 =?utf-8?B?ek9GSzhXSVVMQlQzOWNtazMyK285SkdnQjMvSzlKYWlEOC9URGpDSlhmVHlR?=
 =?utf-8?B?ZkN3Vk5RMWlETEZiWjNLWlB6MGY5N090amtuYmliQXFwcWpQMUp1QW9CRGlS?=
 =?utf-8?B?MlFBYWZMVGVGdTBHK1RCVHk0RlR0S1lhOExXRHZrNkpHOTMyNUkwRUo0anA4?=
 =?utf-8?B?d1MrMU1kaUVpajZldm16dmZtRjdJb1Z0a1habnNaYUhROUxTbHVmUkdLRG1x?=
 =?utf-8?B?RVl3eHArNHJJSEM4bDNnZFpQK3R1R3pjTnliVjIxRVpMZzdLaFRUUk8xQ2pL?=
 =?utf-8?B?QmlMMUxKdkdTNEdJLzRHYVJ1RU9XaFU4TGNMMi8wanlkY1pRNVVsUjdmcU00?=
 =?utf-8?B?SkxSc3psalUweFNVU0ovRkIxcGJnZWVQdlVXTHlzVFI1dzYxb3pibWxFV01G?=
 =?utf-8?B?NlpFempqZW9STXZmeU9uS0ZyaEM0SWdhMDFuSC9hN1FCUEJPMkFoYmNaQmt3?=
 =?utf-8?B?KzdabWhsQzJkQXB5RHVhdVdNRjhwY2ZZbnRqUjAxbE52OGQvUFpZN0dZcFhn?=
 =?utf-8?B?bXVpWGllWVJNMEFyN3Y2VWZqSVVyYktUV2h2RGIyKytCdytIeVZSSk9QeG9I?=
 =?utf-8?B?R2RFOTR1NFM2R3hqTHFWUHV1WXNmSXVzL0dMMDNpalpDakVnY3Y2NEZ5Sndm?=
 =?utf-8?Q?1Etpy1tz5LoVKMSXFQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1919.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d29d3e-094d-4a3a-36b0-08d9899937b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 13:49:00.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4gEBaSMSZ5ZZugD/yF55VND9tFm1bcoJhhI595i4dd5Z3WiYOH43Bg2bW1x2Z50QJ66XOoUqUNlgIIZFKKy8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2095
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gSW4gdGhlIHBhc3Qgd2UgdXNlZCB0aGlzIGNvbmZpZ3VyYXRpb24gZm9yIFNPRiBD
SSB0ZXN0cyB3aXRoIHRoZQ0KPiA+IE1pbm5vd0JvYXJkDQo+ID4gKyBhbiBSVDU2ODIgZXZhbCBi
b2FyZC4gV2UgZ3JhZHVhbGx5IGZyaWVkIG1vc3QgYm9hcmRzIGFuZCBubyBsb25nZXINCj4gPiAr
IGNoZWNrDQo+ID4gdGhpcyBjYXBhYmlsaXR5IGZvciBlYWNoIFNPRiBQUi4NCj4gPg0KPiA+IFNv
IEkgd291bGQgYWdyZWUgd2UgY2FuIGF2b2lkIGNoYW5naW5nIGFueXRoaW5nIGZvciBCWVQvQ0hU
IGFuZA0KPiA+IHBvc3NpYmx5IEFQTCwgaXQnZCBiZSBhbiB1bnRlc3RlZCBjb25maWd1cmF0aW9u
Lg0KPiA+DQo+ID4gaW4gb3RoZXIgd29yZHMsIGxldCdzIGFkZCB0aGlzIGNvbXBhdGlibGUvYWx0
X2lkIGZvciBwbGF0Zm9ybXMgd2hlcmUNCj4gPiB3ZSBrbm93IGl0J2xsIGJlIHVzZWQuDQo+IA0K
PiBBZ3JlZSB3aXRoIFBpZXJyZS4gIlJUTDU2ODIiIGlzIGEgbmV3IGNvZGVjIHdoaWNoIGlzIGRp
ZmZlcmVudCBmcm9tDQo+ICIxMEVDNTY4MiIgYW5kIG5vdCB0ZXN0ZWQgb24gb2xkIHBsYXRmb3Jt
cy4NCg0KQXMgSSBrbm93IHRoZSBwYXJ0IGlzIGludHJvZHVjZWQgdG8gSlNMIGFuZCBBREwgcHJv
amVjdHMgc28gbWF5YmUgd2UgY2FuDQprZWVwIHRoZSBjaGFuZ2UgdG8gSlNML1RHTC9BREwgYm9h
cmRzPw0KDQoNCg==
