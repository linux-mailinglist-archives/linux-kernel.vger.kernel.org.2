Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC077318EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 16:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhBKPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 10:33:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:55928 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhBKPNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:13:34 -0500
IronPort-SDR: m7amtCrSeIh/Dwpe1m0CiTnBdJHYguwRAcdHpaglM2gJdGQ1OkK+zeol2yBnHdezYpU2FCIK93
 BIybbgZZ961Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="169381237"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="169381237"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 07:03:27 -0800
IronPort-SDR: /16sK8yWvSzroaBcCIOAhXUwor3Z9UoF3DXCOW4TBLQEIxwX8IV6mh8ZKYPN7oGhZrVrgHA8pp
 4/re5FdN8VoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="437143112"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 11 Feb 2021 07:03:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 07:03:25 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 07:03:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 11 Feb 2021 07:03:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 11 Feb 2021 07:03:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsjxJDUJ6zdrh8Vkvqea1dGqWi100tS8RBhjD3DsQ11H94zyvpQ+Z4CM1e6DOVuvto9aH0ExP/QuifgkOO86VO9/SR0Loor9FhsxG6TvDUNApyZp1xdlmNFMXGMakpXI9qsuXj31mLZtuX8oL47wgBf4MSesxCGNCOLSHobiFYqMvDmmm74J/bQbqFPpPLVuIW3kpjYx2N3+ComVvMoPvUe6GvjrN3wJ6FG4ETDqBGI35M9pOVj1drz+JDmvxOPvok72E4EmnIcG9hs+QNZtdNgUqq5AlVqDbVkoUJms+616BJ0E0R1lkGdbFVAvuUjpRgujYCw4JTAYPC/PQ9uPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tubSeyBBJwbFalNBDhFIjRXm5RBrXL59tju/Wl869V8=;
 b=DbgMWosqhwJNzuZ7T7ibmvu6+nXxQE0juHsbRo0Uvm5rpsLFernVpWKLRyetXi2Iih/j/U0oP2v/lqSNuE2FSu67e4MZR94VG69U8AGqwtMIH89Zjp+8Nc9tLuZ46B/V6Xs1+ylcwYEOeZQZk/lj8SCczMFchpkMuqHu18aJIjLCndlC0Z3qfdtlWUkm66Wevme0h+Unw8mjgN4aDQJJBP1ek8Z8SfEws2hu6g7R4qTS5TRf0bk/4PBPs62GFyNijBcE0+o4HPkK1bGpePfUwxDvkhcGscIRm6yn37HanKqj6n5Qn876zB1GDE+d6cb/C9f6koHQ+kb2qPtarSuhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tubSeyBBJwbFalNBDhFIjRXm5RBrXL59tju/Wl869V8=;
 b=jqwTIDEo3PXTfC+kcpshKtfw7nFaMHtnEwcjDiyrh9sKj/FrXELy5tbIgzyjM4KzvKf4hT9/0Y9pCMfHdsK2Jz6TMdFRxeaa3K8UrES6S78ddLiUYCDivknxYbxYjZxZFVkzQ8O1/eckMoxPZU3+ejEY7A32J5t36pJ2El3YCQU=
Received: from SN6PR11MB3055.namprd11.prod.outlook.com (2603:10b6:805:dc::18)
 by SN6PR11MB2784.namprd11.prod.outlook.com (2603:10b6:805:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Thu, 11 Feb
 2021 15:03:24 +0000
Received: from SN6PR11MB3055.namprd11.prod.outlook.com
 ([fe80::d4a0:9ff0:15b8:cd76]) by SN6PR11MB3055.namprd11.prod.outlook.com
 ([fe80::d4a0:9ff0:15b8:cd76%7]) with mapi id 15.20.3846.030; Thu, 11 Feb 2021
 15:03:24 +0000
From:   "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
To:     "krzk@kernel.org" <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arm@kernel.org" <arm@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "soc@kernel.org" <soc@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH 02/11] dt-bindings: arm: intel,keembay: limit the dtschema
 to root node
Thread-Topic: [PATCH 02/11] dt-bindings: arm: intel,keembay: limit the
 dtschema to root node
Thread-Index: AQHW/9Dc0diEGUYfXkKilpiLdQ/ydapTDnAA
Date:   Thu, 11 Feb 2021 15:03:23 +0000
Message-ID: <cd79c84f8010d72ef1e63d23e77fdca505c0f3f0.camel@intel.com>
References: <20210210171823.333802-1-krzk@kernel.org>
         <20210210171823.333802-2-krzk@kernel.org>
In-Reply-To: <20210210171823.333802-2-krzk@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.191.232.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eeae956f-67ef-4dea-eb12-08d8ce9e2dec
x-ms-traffictypediagnostic: SN6PR11MB2784:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB278491F8DEB1C77E2914C34CF28C9@SN6PR11MB2784.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6wDUr652LBq8ZDmotD3RJl88NiMkQdUM0gFnI9H4Su1cpJXVJzEYTVYbT0hhws897f7fKodPmVqVvEYmuGalisGHh/1y3F+wOWe6VNNrRzJ79/G3SG9UY7dkj8rswlqN2pKsLauvUuFwDJGoIdGtHAeaJg3SkhldudOz0W9P+bnmn3nImVRPkWJ0HLN3SwmIWgYJnYTlO2qgVHiW1MUZSmqilIy2PFhxlG/gCJ91yulVgZh7H8mqJA2RNWv105zbSsffFQL2m5mj/JjMy8RQmZSCjlOt7rTCXNTPO4FPQxwVEmJM1/bp5IdkBh2D9vpkXKkYXXd0iK7qi0XvJbU/5zEQu6aiBIwqmNf1RummQAy/0bOnmeeys7E5QdYzyVEWV/TCIf7OXOkDgJqxsTUmW9B2sYHZC1nmIEaTwzDnB2pkQ0fJR8eyiosujF6b4QjlbupgT9nDZLnV+cCLyowZF26/pvMltbN3qKMLjauUfp7ihYrYMZge0HmBgtOlRgIGWXaMbz+5xNNEdohUqP8ZXVmHcc7jqv6SXH7J9eu6o1M5Xnk6BLKlvNu5dzpTj81F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3055.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(366004)(346002)(478600001)(86362001)(5660300002)(26005)(91956017)(2616005)(4744005)(186003)(36756003)(6486002)(66946007)(6512007)(316002)(8936002)(6506007)(110136005)(71200400001)(2906002)(8676002)(7416002)(76116006)(921005)(66446008)(66556008)(66476007)(64756008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NExTK0NTbHA1Qlp3WnVqTUZhY3VIVHlxbUNoMitmL0FUaitjNHFPdTBVdXBK?=
 =?utf-8?B?VnZ6SzRac1lsem5zSGx2eFQrZE1ZcXl4dU1oVmFhdlNQbWIvYjl2cU1IeTZm?=
 =?utf-8?B?cTlBUm84eDFTb1lDWEY3RS9vTXBnTEIxcDJTcnUvc05PYlRVeVBaWnE4dXZ3?=
 =?utf-8?B?Q1hIZVEydnBTeG5LOTBFbHRqWXV0NGJESVExVit4djI4VGhhczNnNU5XZ1M4?=
 =?utf-8?B?NWxBdC94Y3RMc1V4a3d4NGJCQmVQb1ltNVpNUTFnTHRsb3dlL3UybWtCZkF3?=
 =?utf-8?B?RUM0dWJadGZsUFcwaDd6dDhpS3RvYkwrR1VCVVBWRlArYXoyWEhuNFlNclBZ?=
 =?utf-8?B?SzdpMXMrdHRSREZHSms2R2dIRVBYRzdaU1pvSWdsVTVRTGIxNXN0Z29mZ1Av?=
 =?utf-8?B?QWl6L3kxRWxSVDIvTm1RV3huamsrMzUyMVZKOS9TMjNNNHVDbVc0SGpzMndK?=
 =?utf-8?B?cG5oU2xWUHZxK0VJTG8yclRaWmZOa2xkVkFRLy9ralE5eUR0SjM0bWdPeUhk?=
 =?utf-8?B?eGt3cWViQWovdXE3RE5ITkVCYS9kQlFIcTh2NnI0NkxBRmh5RTRmM2ZOODdq?=
 =?utf-8?B?U1hqU0JWWjNLdFpsWTE0T0RlNGVYdkM1UU0wdTZVcWZtV3lYeGRsT3lrYUF0?=
 =?utf-8?B?bjFseTJUSW0xVWFucVhMOEpGV1hvVVEyT1ludURlM2JRR3d5N3ZYeGJ6MXNW?=
 =?utf-8?B?dngwOXlHM2dCMUt6UTJPSkZLR09hdS9FQWhVSzZqRG8rYW9pZ3pqVFhRTzVp?=
 =?utf-8?B?amhuUitkT0pKa0NQQllHVk55TVlOVGx0UDJyRHYzV3VPL3dzRG5qNno4NElv?=
 =?utf-8?B?S2wzMUJrUVR5R0ZERC9qRlVBemV3ZkZjeEhkQ1o1dlpRTXIwbllCd0xBN2do?=
 =?utf-8?B?bXU3SlhQTXlpTzhINzNaU3U2dGVqZUx5b1hpVzN6ZThMNTlZazNSM1BtQi9a?=
 =?utf-8?B?UXhBUFZ2bTlYQ0dsUkgyZ2Q0QnYzVjlwdGdaNU9XV1AxTnVub0JyUWNBaVQ5?=
 =?utf-8?B?cDE4QWxXMDRscHpBYWlFMUhpckUvWDV2ZW03by9RekErTTU3MkJPSUd0MnhM?=
 =?utf-8?B?TGZLNTR3cFlEdWwwM0puRHFraUxJVy9iOFIvUE1mRW5DaFNQaUx5TTUvRFFt?=
 =?utf-8?B?ZzdGbkVFQTB4a1hIVlA1L05zOUM2TGdPM2pFZGt3b1N4TDRBL1QzcWtDSWtk?=
 =?utf-8?B?aVNLNzk0Qllkb1U5UEdPYW9xT2F5TisrcVRYVWxVVkdWeU9sUFArMlhhZklq?=
 =?utf-8?B?UE9HL0Z5ZGhsRXlUV0RNWElYU2gvbEpmV0pzdFU0MnhaeVNTdzZTanNoZGZy?=
 =?utf-8?B?dFZ3SVBRaWVrcUdhK1Q2b0dhSUwxNW5ib0ZEd01FTGVtVThKYUZaTVROYUd6?=
 =?utf-8?B?TUxqUDF0RUZ0VDNsZTJLNGVWS3hNTTVjSVJMN0trZldMWHhKamtMVVNPTUxV?=
 =?utf-8?B?WktTb2NuNVY3YXhRbjBPKzUwZ1JkOElJL2R0VzE2RU5YMHVOY1JwNnJZeHBI?=
 =?utf-8?B?WktyYUxGbzBCT3BKZE1tc2ZTR0t1MVBMS3RsUXFKRzR2VmRYb1NtOVo0cCtk?=
 =?utf-8?B?b0pjTXZqNXBla0ptQURkUnllak9MSHZOYmtSWWlxeTN6SUNhQTBYbFpHOHhS?=
 =?utf-8?B?cUg1VlppTUlhM0ZUUU43eFc3b2M2QktTSE0xNy9JVUc3NW9lbzlsYjlWRUVW?=
 =?utf-8?B?d3BCZW43MHNqRlkyOHdrNm14d01Hc2hPVUk2eGcyNGw3UmNPYWRsTmlDM2Za?=
 =?utf-8?B?RFJtcnowZEZ2YWR5WkxlSWk0NHU2dHVYaUtGcjhYLzRQS2I4bDFST0ZMb0VC?=
 =?utf-8?B?VUh0Nm5Vd0haOGpDU3VUQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E20A850623474A4BBE85D9D43DA278FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3055.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeae956f-67ef-4dea-eb12-08d8ce9e2dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 15:03:24.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWxZF1+BSL119oaX4nOBfPfe1bwah6IGynFIhvPEzci3AiiKfFsjCh75jTnC1U2lwXIExJDMcWqMppOVdtvR39/9C35Y/7WcMPegWcfR3n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2784
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSBmaXguDQoNCg0KT24gV2VkLCAyMDIxLTAy
LTEwIGF0IDE4OjE4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBUaGUgY2hl
Y2sgZm9yIHRoZSBib2FyZCBjb21wYXRpYmxlIHNob3VsZCBiZSBsaW1pdGVkIG9ubHkgdG8gdGhl
IHJvb3QNCj4gbm9kZS4gIEFueSBvdGhlciBub2RlcyB3aXRoIHN1Y2ggY29tcGF0aWJsZSBhcmUg
bm90IHBhcnQgb2YgdGhpcyBzY2hlbWENCj4gYW5kIHNob3VsZCBub3QgbWF0Y2guDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IC0t
LQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9pbnRlbCxrZWVtYmF5
LnlhbWwgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCkFja2Vk
LWJ5OiBEYW5pZWxlIEFsZXNzYW5kcmVsbGkgPGRhbmllbGUuYWxlc3NhbmRyZWxsaUBpbnRlbC5j
b20+DQoNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2ludGVsLGtlZW1iYXkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vaW50ZWwsa2VlbWJheS55YW1sDQo+IGluZGV4IDY5Y2QzMDg3MjkyOC4uMTA3ZTY4
NmFiMjA3IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2ludGVsLGtlZW1iYXkueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL2ludGVsLGtlZW1iYXkueWFtbA0KPiBAQCAtMTEsNiArMTEsOCBAQCBtYWlu
dGFpbmVyczoNCj4gICAgLSBEYW5pZWxlIEFsZXNzYW5kcmVsbGkgPGRhbmllbGUuYWxlc3NhbmRy
ZWxsaUBpbnRlbC5jb20+DQo+ICANCj4gIHByb3BlcnRpZXM6DQo+ICsgICRub2RlbmFtZToNCj4g
KyAgICBjb25zdDogJy8nDQo+ICAgIGNvbXBhdGlibGU6DQo+ICAgICAgaXRlbXM6DQo+ICAgICAg
ICAtIGVudW06DQo=
