Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5C232FD22
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhCFUdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:33:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:59114 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231211AbhCFUdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:33:12 -0500
IronPort-SDR: DsUYztPN5hCdQMaQgRQq1/gOWaz5AFRoVgtpDlVahVCSxzByo5Ahb4kK/SADW2uGAkhbqEEKcO
 9clb5C/ET7Xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9915"; a="187191448"
X-IronPort-AV: E=Sophos;i="5.81,228,1610438400"; 
   d="scan'208";a="187191448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2021 12:33:10 -0800
IronPort-SDR: UOSe9kY9acVy0Zi7KD4794tt+Gc2yL8Su8gxpgWY/YzJFS/18Auk8ZO0b7FGq4g9WfyXH3y0NB
 Lvn8sRz/vTiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,229,1610438400"; 
   d="scan'208";a="385353812"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 06 Mar 2021 12:33:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 6 Mar 2021 12:33:10 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 6 Mar 2021 12:33:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sat, 6 Mar 2021 12:33:09 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sat, 6 Mar 2021 12:33:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du6NvG6xVPFH3xHuVZSrkri5EPD6FZrmDqy3fwiSlL32bNzrlxHfsVrOUoDaLlHRkRSd6ndbeh64x5GdWstaHjZKX4mIXAcFRS+OtB2L2QckoIFNdruQ+j63kG9+rBZgpVwt9M/AY1Goukdat+9V1aIMDvoz13+mUppYIjVIM4zEvSKwpcMWEu1GEUNSytgWn1hq2iTAdzgbPX8xWzlXMe3XEWjT3dxAn5xzp8Ne32+lw62vyl/ef/Vh/M60295/1/OHD1Nq520wdYRWbv/AE0noj9nH6UmLMAHKAOff0kAnpOYbiiHBNfXto1teS7+5KHatgK1giBXAIb1e3QwgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RHwywtyXrSjChezlGeMyo9AGDrKmxPwtpwE0jw+4Lg=;
 b=d48mEPelGAwj3Pt2XKeHanG/xjBCLCgkQl4hKw0wcg4SLjdJBYkekVS468WdC0CgOpbTqdpdp28dRANFdjNwXKd+pPYEtfJsutQsHAlUAJLsalZ4Cd2tLZwRHZXSCFQ/luCpmNEeNsUSlkW90722kHi8H8ZRG3iqJJemCGgpXVR//xa5E5I5v/gGn4Uo2/kEBpii4ketfUoHca71PqNTQt/Y/8TbNVO6bZw8WWRW8ez+fjcVM7dejVuIcuA8VctJRQoSD4zRflFdVcqu9NxIUvZV9HPqJutTjWsVC0skjGFQjgDh064+diwK6EIXrxYc+1QxCqgzXz128jgJ6F5u7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RHwywtyXrSjChezlGeMyo9AGDrKmxPwtpwE0jw+4Lg=;
 b=kDZp+t5mYgVEnNrA4CyoWa0NvqKB6dGBELrWxV/3CdIKGNoatgJcuYDzD/ZJwbBLoIBi2yT7BEH3aQ2Fi4rdJWHQej3wS2u4dWzky/hW0Te8qko/Eig8BaUFlwH2kcEbnJUDjhV4B71ChFrVh7fkqQhQn0udlCsid7+bYnrstqQ=
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 by BYAPR11MB3286.namprd11.prod.outlook.com (2603:10b6:a03:79::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Sat, 6 Mar
 2021 20:33:05 +0000
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5127:2366:9745:85d8]) by SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5127:2366:9745:85d8%7]) with mapi id 15.20.3890.035; Sat, 6 Mar 2021
 20:33:05 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     lkp <lkp@intel.com>, "hare@suse.de" <hare@suse.de>,
        "olkuroch@cisco.com" <olkuroch@cisco.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [block]  52f019d43c: ndctl.test-libndctl.fail
Thread-Topic: [block]  52f019d43c: ndctl.test-libndctl.fail
Thread-Index: AQHXEZMjgzQQGI9GwEqsFA9jwQ3SzKp3bLEA
Date:   Sat, 6 Mar 2021 20:33:04 +0000
Message-ID: <6f40b1f53c029788e20fe175618d8772e36d648c.camel@intel.com>
References: <20210305055900.GC31481@xsang-OptiPlex-9020>
         <20210305074204.GA17414@lst.de>
In-Reply-To: <20210305074204.GA17414@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ca22427-b9d3-44b5-8c39-08d8e0df0bb1
x-ms-traffictypediagnostic: BYAPR11MB3286:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3286C71B12264D265D8556D4C6959@BYAPR11MB3286.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFHWv0fB0HOKPAGmioyLwAwFdK8tV2gBHEWO+lIKSKtCP1nA5AWlL35x5t8vO9lTGADVhu6MqXRGXHGjSdn+AhEXQZcPj152dE5m9FqEsVqd33GrqLX91rhokU0K6QjbxNQn7uD4e2SSU1wyxHHjI3yF/x33ZHy8ikWl3PO1XFez9CQf2YSoWgc2nTNfjmPowj+RTw0dLXbvjNRi1KKgcEJCnCVBTvhapMl3wMRNUxYOwPTv15yYR9tgcRWm6OkAd5LWzJE1j2ioc2Cjpy9MxsnCxShr6U+DL/vT9TpIkbxDeJ5t0S2PhtbVF8a1M0lidVu5Vp9YcsE1sb5mz60uOtbc1aVf1wzGgvEXFOIDpPUC6951FROGg61Ooh2AaMyEgQ32AHHErPv6LgPFyrywNislMqPvxyBQuUmkE5pENXxkmTk79v90HQBIUcvD6CWSmMJxi4eCpKqSGLOOR/f+kHf8CcvVlgZDDCCLkgY387XIcwj/CWiYVGb/IDlUIZW+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5150.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(376002)(396003)(2906002)(478600001)(4326008)(186003)(26005)(5660300002)(83380400001)(6506007)(36756003)(64756008)(8936002)(66476007)(2616005)(316002)(91956017)(6512007)(6916009)(86362001)(66946007)(66556008)(66446008)(71200400001)(54906003)(76116006)(8676002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MzZ2ZUVhRWZSQ3dCVVR4QS93WTZxM3V3dEtXSktQWHlMZmhjOUxHOG5UeU14?=
 =?utf-8?B?cVErZnlsdDhFcU4zUzhrZ1FHbWZ1UzljaVdWVi9LSWhwTGR6em0rdmtjOHJP?=
 =?utf-8?B?R0h6WHJXZVlrcTFyaCtXQktIbE9UTURtUjVlK3pudWZPcFVhZHBSVnhnLzB4?=
 =?utf-8?B?cWVMVCtQdFlvSENPa0pRbXZqRzhYY1pzdHN4R28zTmJXR1plNVorMXRlQ1Y1?=
 =?utf-8?B?ZTVxdGFZY3AwU0h6YUpMdFJRWHhtZXBka2F3Ry91bUhIODBDSFp5UUVabHZ0?=
 =?utf-8?B?aGJ5a0dlTUpNSmpWdzZheVRXYk1TWEFCMUZlRTBZcmVPMDlRYTJZc1JucDk3?=
 =?utf-8?B?UXduQnN3ZmJKWllQcjBxSUxUU3hiUk0wcGJVMUsvdkdla3JkQS9tYmRtQzcz?=
 =?utf-8?B?R3d1eXZUS0x2SjJnL0FwZ3NtTUFFazVKbFNpZWNwYzl0allzblhQdkV0TnZs?=
 =?utf-8?B?WVpzTEwySWI4STBSTFdQVGtyM3VHOThRMUFHZHhYd0NaZnkwM2NqcHNwQ1lD?=
 =?utf-8?B?elQ5OEFNelg2bmtOS1hkbzFSY1FyVFd4TUtzY0NnTzB0UnJIR3R2ekxENzJm?=
 =?utf-8?B?Rm4yTHViM2xldGFDYld1M1c3L0ZndVFZOG1WTXl6Tktza2w1cXhQa3dSZE5a?=
 =?utf-8?B?ZGhXbmdkK0JqSWRVRlZUTEIwTkZ6MzVGQWpEcHVmYmplTEhoRXp1MFlWWjF2?=
 =?utf-8?B?emZlZTQzNVVFVmw4U1ZjZEliRVRwTWxXZzRqU0xWTzVZaHBKTU1OVmhXU29p?=
 =?utf-8?B?M0RTWFBxa1NLekRBUk9UajF5V0tCamtWZTZ0SDQ0aEYyYkRXdURadWM2Q09h?=
 =?utf-8?B?U0hpL2tUOUdTajNuZmUyNFVFNWIzZXV6ZndCM1g3QmtoU2dFZkxBSVJMVHZ0?=
 =?utf-8?B?OU4yNCs5TjYzNU5xbHZKUm5ubGxxUlZDSkNxNUE4L2FnNXMwYU1DSDA4TnNz?=
 =?utf-8?B?YjBudllOYmxOWmw2MGsxS0NZTVFMeGJKeUlvSksvVFd3Y1BvQkdUdjlhMk9w?=
 =?utf-8?B?M2pMMmZtUmRkNUhyYlpsNHh2TlZKeEFmN2UrVDRhNG1BL3hzV0oySDAzVkpz?=
 =?utf-8?B?SFNjRkJwQ0ZNRWhURHg4YkN1NDBjL3hCOVVMd0d4WEhPdWJxMW1UU0NGNFI2?=
 =?utf-8?B?VlJiV1o0bkJsWjZsYnNFNlI3WitXckcxRU1iUk9PMG0wTWtNY2IrRXhtVkZt?=
 =?utf-8?B?cG8rOCtvcFJlbDZQNHhWRFYrYlpHNTZkU3R4SFBPS1QzSmFsb1d1N2FSS0RP?=
 =?utf-8?B?RFBCdThmVnNSdEJwVzJTWEdwREJqbWZlVDN5ZEd3NE5BekI0N090c3o0Y1Fh?=
 =?utf-8?B?N0tPY3dXOEtsWCt2ZE9mVUF5dkVLVUF6VkgyOVRPOHZPNmo4N2VxMVlVeTNQ?=
 =?utf-8?B?dXlaWlRBVUNsY1cwSHRLdllIajZ4dVRMNkhJWVVZcDR5RG1KT0tzNURJQzRq?=
 =?utf-8?B?Qm1EVFk1alJ6T3dWcGtLYnlmRXhPMzhKNDdPN3UwYlozYzJrYUtvQndGMlhm?=
 =?utf-8?B?cmEwdjVwaXpNVDFoM0hTaG0zWTVhYSt4VS9TaXFiRDZGUlZwTmtYT25PYnFL?=
 =?utf-8?B?cDdReFgzdTl2VVpacGhlTDZBL2NwTHdFSG1DMDc4UE14K2tFNXd5eWMyUmxG?=
 =?utf-8?B?L2hzVXEvTTMxcjA1Smo2cGcyTndHS2lsVUllRWdrd0I2MVBjU0FQSm1sWUZB?=
 =?utf-8?B?MUMrS0dmclFNV0JabUZyeXVnOUNRWnExdDVZaTlyeUFXQk1WSDVoQzdxMzl4?=
 =?utf-8?Q?vqcbubfs99dkEKiCmagg8dcAZrjllmdX4YMAvld?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <429AD38932649741A5C0C9E1E934C407@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5150.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca22427-b9d3-44b5-8c39-08d8e0df0bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 20:33:04.9009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: St3n9jBYnZV6ptqVsyddozBSRUTbqwXW63fKn9MnXzgq6GiojehX8KFf1A/+YYzD9BfZBdn//UPfqDBVQx0XQZ0/qDdlYPesP3RhVDBc890=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3286
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAzLTA1IGF0IDA4OjQyICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gRGFuLA0KPiANCj4gY2FuIHlvdSBtYWtlIGFueSBzZW5zZSBvZiB0aG9zIHJlcG9ydD8N
ClsuLl0NCj4gPiBjaGVja19zZXRfY29uZmlnX2RhdGE6IGRpbW06IDAgcmVhZDIgZGF0YSBtaXNj
b21wYXJlOiAwDQo+ID4gY2hlY2tfc2V0X2NvbmZpZ19kYXRhOiBkaW1tOiAweDEgcmVhZDIgZGF0
YSBtaXNjb21wYXJlOiAwDQo+ID4gY2hlY2tfc2V0X2NvbmZpZ19kYXRhOiBkaW1tOiAweDEwMCBy
ZWFkMiBkYXRhIG1pc2NvbXBhcmU6IDANCj4gPiBjaGVja19zZXRfY29uZmlnX2RhdGE6IGRpbW06
IDB4MTAxIHJlYWQyIGRhdGEgbWlzY29tcGFyZTogMA0KPiA+IGNoZWNrX2RheF9hdXRvZGV0ZWN0
OiBkYXhfbmRuczogMHg1NThhNzRkOTJmMDAgbmRuczogMHg1NThhNzRkOTJmMDANCj4gPiBjaGVj
a19kYXhfYXV0b2RldGVjdDogZGF4X25kbnM6IDB4NTU4YTc0ZDkxZjQwIG5kbnM6IDB4NTU4YTc0
ZDkxZjQwDQo+ID4gY2hlY2tfcGZuX2F1dG9kZXRlY3Q6IHBmbl9uZG5zOiAweDU1OGE3NGQ5MWY0
MCBuZG5zOiAweDU1OGE3NGQ5MWY0MA0KPiA+IGNoZWNrX3Bmbl9hdXRvZGV0ZWN0OiBwZm5fbmRu
czogMHg1NThhNzRkOGM1ZTAgbmRuczogMHg1NThhNzRkOGM1ZTANCj4gPiBjaGVja19idHRfYXV0
b2RldGVjdDogYnR0X25kbnM6IDB4NTU4YTc0ZDhjNWUwIG5kbnM6IDB4NTU4YTc0ZDhjNWUwDQo+
ID4gY2hlY2tfYnR0X2F1dG9kZXRlY3Q6IGJ0dF9uZG5zOiAweDU1OGE3NGRhMTM5MCBuZG5zOiAw
eDU1OGE3NGRhMTM5MA0KPiA+IGNoZWNrX2J0dF9hdXRvZGV0ZWN0OiBidHRfbmRuczogMHg1NThh
NzRkOGM1ZTAgbmRuczogMHg1NThhNzRkOGM1ZTANCj4gPiBjaGVja19idHRfYXV0b2RldGVjdDog
YnR0X25kbnM6IDB4NTU4YTc0ZDkxZjQwIG5kbnM6IDB4NTU4YTc0ZDkxZjQwDQo+ID4gbmFtZXNw
YWNlNy4wOiBmYWlsZWQgdG8gd3JpdGUgL2Rldi9wbWVtNw0KPiA+IGNoZWNrX25hbWVzcGFjZXM6
IG5hbWVzcGFjZTcuMCB2YWxpZGF0ZV9iZGV2IGZhaWxlZA0KPiA+IG5kY3RsLXRlc3QxIGZhaWxl
ZDogLTYNCj4gPiBsaWJrbW9kOiBFUlJPUiAuLi9saWJrbW9kL2xpYmttb2QtbW9kdWxlLmM6Nzkz
IGttb2RfbW9kdWxlX3JlbW92ZV9tb2R1bGU6IGNvdWxkIG5vdCByZW1vdmUgJ25maXRfdGVzdCc6
IFJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxlDQo+ID4gdGVzdC1saWJuZGN0bDogRkFJ
TA0KDQpZZXMsIGl0IGxvb2tzIGxpa2UgbXkgdW5pdCB0ZXN0IGNoZWNrcyBmb3IgZXhhY3RseSB0
aGUgYmVoYXZpb3IgeW91DQpjaGFuZ2VkLiBJdCB3YXMgY29udmVuaWVudCB0byB0ZXN0IHRoYXQg
dGhlIGRldmljZSBjb3VsZCBiZSBzd2l0Y2hlZA0KYmFjayB0byBydyB2aWEgQkxLUk9TRVQsIGJ1
dCBJIGRvbid0IHJlcXVpcmUgdGhhdC4gVGhlIG5ldyBiZWhhdmlvdXIgb2YNCmxldHRpbmcgdGhl
IGRpc2stPnJvIHRha2UgcHJlY2VkZW5jZSBtYWtlcyBtb3JlIHNlbnNlIHRvIG1lLCBzbyBJJ2xs
DQp1cGRhdGUgdGhlIHRlc3QgZm9yIHRoZSBuZXcgYmVoYXZpb3VyLg0KDQpJLmUuIEkgZG9uJ3Qg
dGhpbmsgcmVncmVzc2luZyBhIHVuaXQgdGVzdCBjb3VudHMgYXMgYSB1c2Vyc3BhY2UNCnJlZ3Jl
c3Npb24uDQo=
