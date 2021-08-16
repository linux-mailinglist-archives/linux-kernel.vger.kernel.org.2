Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1325C3ED93F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhHPOw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:52:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:30016 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231952AbhHPOw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:52:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="301457444"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="301457444"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 07:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="487453718"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2021 07:52:26 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 16 Aug 2021 07:52:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 16 Aug 2021 07:52:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 16 Aug 2021 07:51:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1Iv2xdRPWfR29dj+nLF0s9X9Rb+KZSeCai46HaxGUtujWZdnCVbvdFEMEQxsWvsGbB0BdTkEp0pkRy2d5l/s7Htn3DfvQiasgXQM++/APp32NOnMO4hyShajI9MnBfeSmIHOyxrw5Y8wLiPa4wU8jp+nORFScUK1ISMh2aGjZBQCCx7k4+xiH47yaTqJp9mxwcNX3cDr2Oqv8CPGfixXKbCmEe+2hz5Ozllt8vtvYw5K7ejGIXtGi3+FnariXiumH/SxVKaTaqa1YAPd8Y0PA6MW0j3GXY2SxAb3rCKtKqCCITXBLL3HijkHZJkDYcDh3kbC6ZycCCOQf7IpxvHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBiDwRzRvo13K3rYNYPHgwNyl4qiHr9BO2wIDvZum6w=;
 b=EFwSVaQ0cMDVjQOl9GAJ9rKrZqwvH6BljkL/piMFSnfN6Ps48XRSU++EBFZnLR6Bh9BObYMzdRaPdohAmEf53nfjM/HZhh+h7opgFkMcxQMnBL8RzD8TidkElMaCtr5ukcOfuiPPi8DxWHdHrVPlxL/UaFpndK1hHxwV6uPNTmdrDIvGQN8zlnArZdFRJkKvdZeuhnppV/XLSp/VYekK0w7t3Zbhc0EQB22c9BM8nCcY8S9x9qGfBiIBfNbt+hVE4q36RKE4+hQZm9aguEbXH0Gy+uvO12MaX4mbtdgS0RanvUGDNObCbCiIdfK8kMwkb0n53QUI7uNO+lD0wBBziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBiDwRzRvo13K3rYNYPHgwNyl4qiHr9BO2wIDvZum6w=;
 b=OFOblDODkIQPIOwuukC/ySVpL5vz5grKnDj6Er7B/5NB7h2keUn61yPRHtEEDq3ThU3NOmxZ2iE6TiuCDDrveTYhtpeMcsg8cw36clfE6l43QveJlGcY+IZz68Ku36yYdUFHPv9kxZSPLys04busAWMHPVAO6uVx9nXXPAB8M4o=
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 DM8PR11MB5574.namprd11.prod.outlook.com (2603:10b6:8:39::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Mon, 16 Aug 2021 14:51:33 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::b902:81e5:826d:f731]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::b902:81e5:826d:f731%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 14:51:33 +0000
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "alex.hung@canonical.com" <alex.hung@canonical.com>,
        "hpa@redhat.com" <hpa@redhat.com>,
        "Ma, Maurice" <maurice.ma@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "acelan.kao@canonical.com" <acelan.kao@canonical.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Zha, Qipeng" <qipeng.zha@intel.com>,
        "Thomas, Sujith" <sujith.thomas@intel.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "Dell.Client.Kernel@dell.com" <Dell.Client.Kernel@dell.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2 11/20] platform/x86: intel_turbo_max_3: Move to intel
 sub-directory
Thread-Topic: [PATCH v2 11/20] platform/x86: intel_turbo_max_3: Move to intel
 sub-directory
Thread-Index: AQHXkq40D6i2tK6gpU2n6QFwOZ+Xfg==
Date:   Mon, 16 Aug 2021 14:51:33 +0000
Message-ID: <bd5c2c0c7863375a0bd3c6894194f7ba70915e17.camel@intel.com>
References: <20210816105119.704302-1-hpa@redhat.com>
         <20210816105119.704302-12-hpa@redhat.com>
In-Reply-To: <20210816105119.704302-12-hpa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.0-1 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 887fe2c4-833c-4c25-5db2-08d960c55748
x-ms-traffictypediagnostic: DM8PR11MB5574:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5574A88DFA9DB138DAB56154E4FD9@DM8PR11MB5574.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YFJK3lfcUjjO3gNzPj7aMgZNt3/kqAwYK5/Z9ziU4DfokMJKSGnyIKF4Ipu66QlpDZdcvelIkjf2xG1SycJ82RAimmrtWrHU35Ydy/VErsxVeCB7bP5TtgJFuisimfj7rWh8wRZkgv12tu3tmkPBB05+ODhx7pDObGEc+1uvnJLboY3+8E497Ra1QdYPRGLMgh3waZ9POC1waF0beCi65jlIuYT2sTE7orzBC4e7VAoYV+gBO+9c4YB7RQm/EBQ/N7Sx1jQLl7+XY15R0hyjqcCXEC52y9/1H/mIuOBBpQ+PjOwPS8NrrqS1Gr4N7C6Z903S2SvH9yI0houELyupSYwkX8aDvCKu/kizAS9pALRVLRO2JGEGxBgYgcV74SGLSqBHaTxhH7xux243S89s7eM09sYmt/5omVmBUKyXxOcrQKYA0jjKWvYyEeG2lefgk5LyAAcM0SzR5R7UGMAVDV2Jk3qEJJUEQ7Eyqe1pPgKAI19BtgcWPM7MScoKecusf84wcn8I1la+dBzdERb70iMETB2llHuJgQxlcifc4xpIJnY1iYOrzS5VKfwYRuDZAlbauEkjisxH440Zd5RJitzE9wVq6cRmjrOVxi50yOQDuYlLdbPY2XauPV7ior/gIKtOcOQ3ArtyOlKLpCZ4/1vLMX0gdnwD26KfS7HRz/QJIwak50ItrbbA96kUl59juMuxjWFrYeiGVs+RRMY65CD4HilP+zqlDOsOgbvzH7s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(110136005)(4326008)(66446008)(66476007)(2906002)(8676002)(122000001)(83380400001)(71200400001)(8936002)(64756008)(316002)(921005)(66556008)(66946007)(6486002)(86362001)(91956017)(76116006)(6506007)(478600001)(186003)(26005)(36756003)(6512007)(38070700005)(2616005)(5660300002)(7416002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlZuQ3JQMGtzWXZSM1VqL3gwUFhGZllDWGdjakhvQ2xyQmRjU05vTUE2aDR5?=
 =?utf-8?B?OVEzQjY3VHVxRHdEbEdEQ1pjL3F5ZVNPaER1dlh3bUxsMXV2M0J1UVcrd2RS?=
 =?utf-8?B?UEQ4blZKeUM1VXoySTZPTkpxcktMNitrWWpKRWNvWi9oUmRENjFDMVYyRm1h?=
 =?utf-8?B?eThTK0VIUFZkRWx0QWZJbzl1RnJEZW9INmlodVdGWjR1d1htSHlBUHJlWnk1?=
 =?utf-8?B?YjhvNzZFZUdGa2VHSllwU2tka1Y1OEFSWGFtcGRmc0thUXNYc2ZOd3BVYkpS?=
 =?utf-8?B?SExWZGJHdUdXcXpJQStTTExpL3JISnFyako1U3NYV25wYkluaGVRa1k5MWtL?=
 =?utf-8?B?RTRod1BsbjdacTd1QTNyTmppaHRqaisyM0J1RDlhTnNaRWJVQkdJQ29iQ0Zr?=
 =?utf-8?B?b3U0Z0h6Vy84S1ZwT3dLbHBtUWdCWDNlU0gwcDhZeXNvMGZIcElBNnVCS0ph?=
 =?utf-8?B?TTJWbDFFMWt3T1VUa1lBMlZtd3FWZWRJbzgxUXBhb00rZEhCM0s0Vmx5Qm5v?=
 =?utf-8?B?WmR4eitGWWdFS0VjSGQ0a2o2cnVIM2xtUFFzWDJKVFVJVjBvMmpYYWhoYm94?=
 =?utf-8?B?Ni93MEhLejVicVdBSjN4M2gxTFVYVlQvMWFaMEMyMW9lMDhTT2hoVWplUjRC?=
 =?utf-8?B?VG1DMXNrSGsxbVJ1OWNCUTdzN0NrY1pzRzBzWHcrMFRjRWp5SC9kZmZpRzVP?=
 =?utf-8?B?YXl3NU1rY2J0eWY1a1E4VkxXK0FIYmV4TkM1dHJWQjJGYmNuNGdqQk9mRHh0?=
 =?utf-8?B?WklpOU1TclpOcDdSU2JNWmovVzFldElFSWhjQlNMRlVLMDliZnZTVWRPWGtr?=
 =?utf-8?B?VnA4VGh1dTNndUlZOGZlN0ptRXdIODVhYnZEZHZqVUhJUVRwc1ZBSjh0MnZR?=
 =?utf-8?B?Qm9mZGExM0ZKRExEQmtIeElOVTlYeTIxZ05XaDRWSDR4cENEZVdJU3duQTFh?=
 =?utf-8?B?K085MXRCeFBlcGMwMlJlQlVHT0I5RXVBWGdGYjZCUm1HWjc0bjVoM3VOSWh5?=
 =?utf-8?B?NmxFemdXRHZNZkdmVjJyWmxOTlRYUVE0Ti9ESUJPY1pROTRBR2ptcTdIRVp3?=
 =?utf-8?B?bkVtSi9lYWhTMUNTaTFmMklWRVZqSVBFbFRtQnJBY3dxU0VyK3M5WkVST0ZC?=
 =?utf-8?B?Tk00Nm1VWGYvWmk4dzRqd0dEMkdxYWdIRUg3L1lyZ2NOSS8zMFRibFhJWkJ5?=
 =?utf-8?B?RndzdnBSemRNSzBXU0F4dGpMTEFmaWpUUUVwdEhMR2pyelZQajllT00zN01H?=
 =?utf-8?B?SitsY0U1aHRLUUFFVkZnMmJMMmZTQW1qNUpzbE03ekZ4Z3o3ekZFK1ZhSzN2?=
 =?utf-8?B?RjRtN0pIcStRd1l5ZithQkcwRDg0L0dYMDloRHMwcXpoNFJoRGNMeXYxVnVX?=
 =?utf-8?B?WS9nOWtURW85OTBJenRBanlKVVV2MW5RTFpsMlVueERrT3BmR1k2dXNTS29I?=
 =?utf-8?B?VkdXdDdoeThQZ0U5dWtLeTdONVlGczVqL3hEbjh6YmhiWDFPMXc0dzdIZ01C?=
 =?utf-8?B?L2xKMjl2Y2hiMlJPcksyeHpJdUpXNk5LSVQxMHBGc2g5ZEx5Q0gvbUpjcGh3?=
 =?utf-8?B?T005eFFWT2RnV25TOFo0WVJmeXpZZmJFV0N6ZXhibG5LMlpiZVdaajhpNUNz?=
 =?utf-8?B?SlVOVlpKcjJVdDRZSFpKL1c0YWw5ajJIRWNWRHFTUHBiTElsTFNDaHY3bHBp?=
 =?utf-8?B?TjhNVUhUQWVuUU1aTkJ0VVJmcXBDRnJjdkN1Z0NWWnJ5bTN6bkVCNWEzZTgw?=
 =?utf-8?Q?KbbrYfeofmVvxFk0GsQ6SODCoEeahc1ltuHoAla?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <959795E31C73A14D96D89BD9271429A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887fe2c4-833c-4c25-5db2-08d960c55748
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 14:51:33.7436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMBIA53Pgud4dsUAH2ubG5RPUiqQM/rPDygGYGt7x1xYMdO0kkY5MBAi+GZYLEYex+ajZA0DqL9t195mYDJ8PUvgpy8ihjmYwJVG2YnmI1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5574
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTE2IGF0IDE4OjUxICswODAwLCBLYXRlIEhzdWFuIHdyb3RlOg0KPiBN
b3ZlIGludGVsX3R1cmJvX21heF8zIHRvIGludGVsIHN1Yi1kaXJlY3RvcnkgdG8gaW1wcm92ZSBy
ZWFkYWJpbGl0eQ0KPiBhbmQgcmVuYW1lIGl0IGZyb20gaW50ZWxfdHVyYm9fbWF4XzMuYyB0byB0
dXJib19tYXhfMy5jDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLYXRlIEhzdWFuIDxocGFAcmVkaGF0
LmNvbT4NCkFja2VkLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRh
QGxpbnV4LmludGVsLmNvbT4NCg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29u
ZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDEwIC0tLS0tLS0tLS0NCj4gwqBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtlZmlsZcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstDQo+IMKg
ZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKysrKysrKysrDQo+IMKgZHJpdmVycy9wbGF0Zm9ybS94
ODYvaW50ZWwvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgNCArKy0tDQo+IMKgLi4uL3g4Ni97aW50ZWxfdHVyYm9fbWF4XzMuYyA9PiBpbnRlbC90dXJi
b19tYXhfMy5jfcKgwqAgfMKgIDANCj4gwqA1IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDEzIGRlbGV0aW9ucygtKQ0KPiDCoHJlbmFtZSBkcml2ZXJzL3BsYXRmb3JtL3g4Ni97aW50
ZWxfdHVyYm9fbWF4XzMuYyA9Pg0KPiBpbnRlbC90dXJib19tYXhfMy5jfSAoMTAwJSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnDQo+IGIvZHJpdmVycy9w
bGF0Zm9ybS94ODYvS2NvbmZpZw0KPiBpbmRleCBhOWViMWY2ZTE4NGYuLjY2NjEwM2M3ZjBkZSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvS2NvbmZpZw0KPiArKysgYi9kcml2
ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnDQo+IEBAIC0xMTExLDE2ICsxMTExLDYgQEAgY29uZmln
IElOVEVMX0lNUg0KPiDCoA0KPiDCoHNvdXJjZSAiZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxf
c3BlZWRfc2VsZWN0X2lmL0tjb25maWciDQo+IMKgDQo+IC1jb25maWcgSU5URUxfVFVSQk9fTUFY
XzMNCj4gLcKgwqDCoMKgwqDCoMKgYm9vbCAiSW50ZWwgVHVyYm8gQm9vc3QgTWF4IFRlY2hub2xv
Z3kgMy4wIGVudW1lcmF0aW9uIGRyaXZlciINCj4gLcKgwqDCoMKgwqDCoMKgZGVwZW5kcyBvbiBY
ODZfNjQgJiYgU0NIRURfTUNfUFJJTw0KPiAtwqDCoMKgwqDCoMKgwqBoZWxwDQo+IC3CoMKgwqDC
oMKgwqDCoMKgIFRoaXMgZHJpdmVyIHJlYWRzIG1heGltdW0gcGVyZm9ybWFuY2UgcmF0aW8gb2Yg
ZWFjaCBDUFUgYW5kDQo+IHNldCB1cA0KPiAtwqDCoMKgwqDCoMKgwqDCoCB0aGUgc2NoZWR1bGVy
IHByaW9yaXR5IG1ldHJpY3MuIEluIHRoaXMgd2F5IHNjaGVkdWxlciBjYW4NCj4gcHJlZmVyDQo+
IC3CoMKgwqDCoMKgwqDCoMKgIENQVSB3aXRoIGhpZ2hlciBwZXJmb3JtYW5jZSB0byBzY2hlZHVs
ZSB0YXNrcy4NCj4gLcKgwqDCoMKgwqDCoMKgwqAgVGhpcyBkcml2ZXIgaXMgb25seSByZXF1aXJl
ZCB3aGVuIHRoZSBzeXN0ZW0gaXMgbm90IHVzaW5nDQo+IEhhcmR3YXJlDQo+IC3CoMKgwqDCoMKg
wqDCoMKgIFAtU3RhdGVzIChIV1ApLiBJbiBIV1AgbW9kZSwgcHJpb3JpdHkgY2FuIGJlIHJlYWQg
ZnJvbSBBQ1BJDQo+IHRhYmxlcy4NCj4gLQ0KPiDCoGNvbmZpZyBJTlRFTF9VTkNPUkVfRlJFUV9D
T05UUk9MDQo+IMKgwqDCoMKgwqDCoMKgwqB0cmlzdGF0ZSAiSW50ZWwgVW5jb3JlIGZyZXF1ZW5j
eSBjb250cm9sIGRyaXZlciINCj4gwqDCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gWDg2XzY0DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtlZmlsZQ0KPiBiL2RyaXZlcnMv
cGxhdGZvcm0veDg2L01ha2VmaWxlDQo+IGluZGV4IDAzODlmZTEyZTdjMC4uZmIzOTY0NGRiN2Y5
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtlZmlsZQ0KPiArKysgYi9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtlZmlsZQ0KPiBAQCAtMTIzLDcgKzEyMyw3IEBAIG9iai0k
KENPTkZJR19XSVJFTEVTU19IT1RLRVkpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKz0N
Cj4gd2lyZWxlc3MtaG90a2V5Lm8NCj4gwqANCj4gwqANCj4gwqBvYmotJChDT05GSUdfSU5URUxf
U1BFRURfU0VMRUNUX0lOVEVSRkFDRSnCoMKgwqDCoMKgKz0NCj4gaW50ZWxfc3BlZWRfc2VsZWN0
X2lmLw0KPiAtb2JqLSQoQ09ORklHX0lOVEVMX1RVUkJPX01BWF8zKcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCs9DQo+IGludGVsX3R1cmJvX21heF8zLm8N
Cj4gKw0KPiDCoG9iai0kKENPTkZJR19JTlRFTF9VTkNPUkVfRlJFUV9DT05UUk9MKcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKz0gaW50ZWwtDQo+IHVuY29yZS1mcmVxdWVuY3kubw0K
PiDCoA0KPiDCoA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvS2Nv
bmZpZw0KPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL0tjb25maWcNCj4gaW5kZXggODNm
N2RjM2U5NTA2Li44MDcwODA0ZmU5MTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L2ludGVsL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvS2Nv
bmZpZw0KPiBAQCAtOTksNCArOTksMTQgQEAgY29uZmlnIElOVEVMX1NNQVJUQ09OTkVDVA0KPiDC
oMKgwqDCoMKgwqDCoMKgwqAgQ29ubmVjdCBlbmFibGVkLCBhbmQgaWYgc28gZGlzYWJsZXMgaXQu
DQo+IMKgDQo+IMKgDQo+ICtjb25maWcgSU5URUxfVFVSQk9fTUFYXzMNCj4gK8KgwqDCoMKgwqDC
oMKgYm9vbCAiSW50ZWwgVHVyYm8gQm9vc3QgTWF4IFRlY2hub2xvZ3kgMy4wIGVudW1lcmF0aW9u
IGRyaXZlciINCj4gK8KgwqDCoMKgwqDCoMKgZGVwZW5kcyBvbiBYODZfNjQgJiYgU0NIRURfTUNf
UFJJTw0KPiArwqDCoMKgwqDCoMKgwqBoZWxwDQo+ICvCoMKgwqDCoMKgwqDCoMKgIFRoaXMgZHJp
dmVyIHJlYWRzIG1heGltdW0gcGVyZm9ybWFuY2UgcmF0aW8gb2YgZWFjaCBDUFUgYW5kDQo+IHNl
dCB1cA0KPiArwqDCoMKgwqDCoMKgwqDCoCB0aGUgc2NoZWR1bGVyIHByaW9yaXR5IG1ldHJpY3Mu
IEluIHRoaXMgd2F5IHNjaGVkdWxlciBjYW4NCj4gcHJlZmVyDQo+ICvCoMKgwqDCoMKgwqDCoMKg
IENQVSB3aXRoIGhpZ2hlciBwZXJmb3JtYW5jZSB0byBzY2hlZHVsZSB0YXNrcy4NCj4gK8KgwqDC
oMKgwqDCoMKgwqAgVGhpcyBkcml2ZXIgaXMgb25seSByZXF1aXJlZCB3aGVuIHRoZSBzeXN0ZW0g
aXMgbm90IHVzaW5nDQo+IEhhcmR3YXJlDQo+ICvCoMKgwqDCoMKgwqDCoMKgIFAtU3RhdGVzIChI
V1ApLiBJbiBIV1AgbW9kZSwgcHJpb3JpdHkgY2FuIGJlIHJlYWQgZnJvbSBBQ1BJDQo+IHRhYmxl
cy4NCj4gKw0KPiDCoGVuZGlmICMgWDg2X1BMQVRGT1JNX0RSSVZFUlNfSU5URUwNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL01ha2VmaWxlDQo+IGIvZHJpdmVycy9w
bGF0Zm9ybS94ODYvaW50ZWwvTWFrZWZpbGUNCj4gaW5kZXggZGE4ZmJlODdiZjAzLi5jZmY2NWZh
MmIxYWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL01ha2VmaWxl
DQo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL01ha2VmaWxlDQo+IEBAIC0zMyw1
ICszMyw1IEBAIGludGVsLXJzdC0NCj4gecKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoDo9IHJzdC5vDQo+IMKgb2JqLSQoQ09ORklHX0lOVEVMX1JTVCnCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Kz0gaW50ZWwtcnN0Lm8NCj4gwqBpbnRlbC1zbWFydGNvbm5lY3QtecKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDo9IHNtYXJ0Y29ubmVjdC5vDQo+
IMKgb2JqLSQoQ09ORklHX0lOVEVMX1NNQVJUQ09OTkVDVCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqArPSBpbnRlbC1zbWFydGNvbm5lY3Qubw0KPiAtDQo+IC0NCj4gK2ludGVsX3R1cmJv
X21heF8zLXnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgOj0NCj4gdHVyYm9fbWF4XzMu
bw0KPiArb2JqLSQoQ09ORklHX0lOVEVMX1RVUkJPX01BWF8zKcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCs9DQo+IGludGVsX3R1cmJvX21heF8zLm8NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsX3R1cmJvX21heF8zLmMNCj4g
Yi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC90dXJib19tYXhfMy5jDQo+IHNpbWlsYXJpdHkg
aW5kZXggMTAwJQ0KPiByZW5hbWUgZnJvbSBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF90dXJi
b19tYXhfMy5jDQo+IHJlbmFtZSB0byBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC90dXJib19t
YXhfMy5jDQoNCg==
