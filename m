Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D408A44DCB1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhKKUvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:51:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:20587 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233303AbhKKUvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:51:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="319211917"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="319211917"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 12:48:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="504579815"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2021 12:48:13 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 12:48:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 11 Nov 2021 12:48:13 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 11 Nov 2021 12:48:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNYwkEzHl2dMJ/W9Yb7s8BN9FeASUV6d1PMOWUa2s5f4welqRp3INFa2nn5OmWALdHAnvBUYlTMKFxLrJ888CLj6pJog7MmV+rh5XZtOHDLPc1zCmZ0Bd2UdZMQ3UjkHCu6G6NZdID4pUJYJ/N/XZtYaTkbbWW9xjD9p7LWQPvpeVKQdlmN86zfQ1Ge4dxED91n8jYpBwlR40QUUll2R6ut1tRSqyEEhJd8/G2DwSfkGG5FQKtWBvShg28RWauLEdbkqJkW0X0I9VQ794tz7pAQmWO6O6HJMQ3xtef1p6nqceVgdmcTgHzguidkNO8MCRhVZXVw8vQKvxWfEUZ7LYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ7Wg19aMsirMZhZDnOIWItO/0WZBR//a4O6BNRUPo8=;
 b=WKcvMzXGPM9h7JRRDwa4UqNdTHUrblKAN05YnUxpYZCMykNBWroaWLvgXmgjv96XuZxP8c6lIor2OMRhFCbBX2U6p+VPo8uuGb2I7n5Gt8tr4KtfOnoENdfn4kT76Or0vEA+8MUgdZi2HxiL8q3SHFKt9coBx2NSmSJFtnixN1978NUrwaYaj9AJDMHz+H6y1p4cm0Xr9gsRQTWrPblRY3XQ1OUk+h0iXDBnn613R2dhJRq24R5ARZYvC6S15GPCxWuWyHOXj9yqqBB/I3mlpVz0p023p/Ky6P/jk3llXEJab4WuzFWjThIFtCSVaOR0XjI6t3oVHg7Hb7L3uy8Jbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ7Wg19aMsirMZhZDnOIWItO/0WZBR//a4O6BNRUPo8=;
 b=vtmprc6mAZnkuQbWKXbEvtvQC7bxrnSiiHn9jqIrIntV9o2VW/hAMWgt8IiOyCOwWvHfHYtM9MyquvLyEvfJMZ3DN990bNpMF+G3wMYFNBwYjZCqvQhh2RhdrkDf2MLzze/kAcLXfx+JnSbzxHu5L1kEAkR25ewbtSKMW6HyMAc=
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR11MB1453.namprd11.prod.outlook.com (2603:10b6:301:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Thu, 11 Nov
 2021 20:48:11 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::bd76:b278:9392:fcd5]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::bd76:b278:9392:fcd5%3]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 20:48:11 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "Lutomirski, Andy" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH 3/4] x86/mm: init_64: make set_pte_vaddr_p4d static
Thread-Topic: [PATCH 3/4] x86/mm: init_64: make set_pte_vaddr_p4d static
Thread-Index: AQHX1uu3YOydJQAyrEqWpfBbkJiw4Kv+zQgA
Date:   Thu, 11 Nov 2021 20:48:11 +0000
Message-ID: <15365ca9e044966159ca27b327b9021b2b963108.camel@intel.com>
References: <20211111110241.25968-1-rppt@kernel.org>
         <20211111110241.25968-4-rppt@kernel.org>
In-Reply-To: <20211111110241.25968-4-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5e815e8-9473-415c-9a22-08d9a5549345
x-ms-traffictypediagnostic: MWHPR11MB1453:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB1453185B4257A001A381479DC9949@MWHPR11MB1453.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j9Y6IjS2K29AwnrXeALr9ktHz5G4wnX96ottUJTkz8DE7cYNpN0jjt2upzPDXI66IK/Ps1qiRHNipgS1TJgJ8nUqv9QkHGf0Oyy4cSnpYSgdzAtYdlvEi4N/wYnFInrztiJehq+85teLcfPyxtcN5AK3eB9bgSEQdEo4t+c7Z3JGy3VE7hzG8EbXBSIbMXfq8Nn/LQ42Pf9HEj8Ytm4HDwOz2x25YXs0W3syGMYeuFBtmlDZRfF8sIRYh+/GiXeamJGy3IAgKcuXFfkLnjKpwOLM0Rf7oQp/zjciaNJa1arf7LrBken2c98m5WJNz/ujumNN0e9Ls3V90V2JodjSHEXzrKsJI/AVfbl2+tqSYJlQzSfZTnGhE1cyEJpI98pBliIKOSZ9mTM+963tTwJo1UOx5yFkt480uDtnxghIsSrQ1fv99qsWvHm0+Na7QI96SpGqvpEQuMkDNKDK96H54NduDUaN9tLVFHFOqRoKNi5iFtLWy7id771xlwmyW5q15dra1I+crgGAFNlPUF5ZW44RfNiL8IU0IBbtCzxq2qmtryoIQVrUudP4wBQOmUiMzK32ymRbJVP8EGgnoD5ickNFkQvAsAfnvoxNiukIrsdIDGTaVmMSGScp929yjIMr7wH+Uys8a+oCkaKJTIfGIG1nrVTAXv27gvUX+Gd/eeOdjGxVhJLAlhnqfDc33xzSj+kQSNfBxNghNTJXfjd03DnoZYeqTKSY7ggncoiNGDA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2616005)(36756003)(6512007)(5660300002)(508600001)(83380400001)(4326008)(26005)(38070700005)(6486002)(6506007)(2906002)(66946007)(86362001)(110136005)(82960400001)(4001150100001)(316002)(54906003)(8676002)(66556008)(66446008)(64756008)(122000001)(7416002)(8936002)(76116006)(66476007)(71200400001)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkljSDhLZE9lYzVlMEtOUzhiQitTdjJ5a2pvSDhCTStNdjNUampRekE1aXBx?=
 =?utf-8?B?bS9lYXVRa3J3Tkw3eEtHcW8weDlzMXdRL1ptcGl5dmFMaGRzRXYvaEkvTWNa?=
 =?utf-8?B?Rm90R1FVV3VXbE9aZzBtcVlzYWVmZ0ttT3M5NDE4WEJLMGw0MXFNOC83ZSsv?=
 =?utf-8?B?ZDFDZ0o2SUtBRlVFUTFxTTQza3ZrSVRocG5CbVdpVEVHYmgxa3FFbXpKNGl0?=
 =?utf-8?B?VHE5NjVLdEJ2USsyYWZkZ01SbXBaVmZMY3lSS2xhSmFDQURDbmxGTEJ5NW9x?=
 =?utf-8?B?Nk96VXl1TTQ3YXNEbUV5WWZsT0tOTS83Y285VUtJdDVJZGdzeEZUQ1VCZXFR?=
 =?utf-8?B?QXhnRUNlejhPaVFITVVGUlRkaGhJdW05RHg1T3hsTkdsUzRhZWx1dzZvdlk2?=
 =?utf-8?B?cEtqamtRTEJBMTNDSGFDaTBCYzNSS2xmdGlwSlAyRkVvaHNZbjZRaHJuM3Bk?=
 =?utf-8?B?UHlJY1h4UHM2NEliY2hJL2poejBwZkh4a3cwY0hFR1pBcmdvNndlQ3ZtSWVV?=
 =?utf-8?B?M3ptQTNNZkIyS2FNbVZMcnVmYnJ4VnVEeE00WjdlOTQ5RXpTOVRIdUZQYkJ0?=
 =?utf-8?B?dFlrTTkxT1k1LzVlNTdPa3oyNXJsWVV6YS81YU8vdlBxNXJQUXBzOWt6bDFX?=
 =?utf-8?B?UXJFTmErMDlqU0RvT1ZKN29KMUlIdVBiVEFkY2xtakJ1MHJqNGh1eHhHK09E?=
 =?utf-8?B?STZ1S1pZM2hqeUJjRmt6c2l5WUVaUHduNU4zeE83R2pKbUV4S295QnNGZ3I3?=
 =?utf-8?B?Um55TEZ2VS9jTjZ2UC9pSWZaZWFpYTdCTnVMTTBQNmpuLzZnY0VERjVDU0lm?=
 =?utf-8?B?WnFTYlcvbFdNTDJ6bEk1MEJIbTYwUCtnZ0Z2ZzhwRGtBWmZzUnQ3dDJmdmhu?=
 =?utf-8?B?RDdNNXNHdisrZXdSUW5yQTJ0MnJSQjd5MGt3R2ZWVUJCa3RVd24rZVV0UlFH?=
 =?utf-8?B?WWNydFR2Z3FDWjlzS1hPVVJHUlVNbU9BRXlJWTJZaEdZTTEwWEdNTnlKRmxC?=
 =?utf-8?B?UWxDMTBKTUt4Q2tnZ05Ca2g3SERNSmZia2dubjI1SWJOa0VlQ1N1NjhmYWwz?=
 =?utf-8?B?ZkJ4U3U3dlhleFdEaUNBT1ZjQk4zN0FJNmFRa0JBenFoK3BZU2cxYTk2bFdu?=
 =?utf-8?B?c2VkeEVTODAxYm9oZGFSbFU5MGFCWWZkRUxicjlJOUtSWTkxaVN3MllYdzA4?=
 =?utf-8?B?cEVENTFvRnZyd09ZZm1XTlJwRWloSCtZOUxqWDFaTEUrVkdtaDNBZzNTWEVv?=
 =?utf-8?B?V2JQVjIxK2QyWDgwKzVOT2pLOUhtRHRuZDRDRUQ5MlBrdERrUkRaamtJZjd6?=
 =?utf-8?B?QTRkRnFCRjk5QnhZWndoRDZja2RFelpKeWZCQ1NSVFhPQmpDdVRZQ2crSkRi?=
 =?utf-8?B?MkZwbXB1djRPUHZlN3ByYUdJV09ZL1JKOFM5bUNnc1oxQU9jd0Fzc0FqMFdt?=
 =?utf-8?B?L29yYWtUQkVGNGF0UWVxckwzVUg0U1prL1U4bTNTeE9iWHNaRWRxcVI4ZVBU?=
 =?utf-8?B?bC9vcUloTEsvTHVUVktackJnY1VJTkM2NXV3R05JUjg3SlczUTV5eGh6cFB0?=
 =?utf-8?B?WGR0UmpOUkgzUDdPTDZFZ0xvczJWcmdUaDFvTEJpTmxoN2xYb0hSY25QUWwv?=
 =?utf-8?B?Yi82OFdSR3hFaWdFWWtWcU51UTNhZzZGaFVtT2VxKzFoYjgxNTAvWHJTRG5U?=
 =?utf-8?B?RUprbFE3dXV6Wkg0MjZlWUN5TVZ0SlpZeWJxSHpBZXd6VUVEdzFpOVdYeDZY?=
 =?utf-8?B?NllqazlreFE5SU1pWElpc1BUb3NmcFh1Q25ybzM5bWRFcG1TVGs3MVAzQ3NJ?=
 =?utf-8?B?dnpQVWFQK0FtRFo1dUtOQnduYTNvNmd1Zm93YlJlVkcvcVBtZzJyRngzTW55?=
 =?utf-8?B?ZjFNa0owaWU5MEpaMThGRkREanVKaklYa0xOZjNVQ3lKOCtuaDEyMlZQM2x6?=
 =?utf-8?B?Y1BEaTUxL0ZKdnlkVmlrdUVTeGE3T0ZhMytGZ1JyZ2U1SzRhYXMyM2l6Nndp?=
 =?utf-8?B?d1U1eXdjQzBZVURndUZweDl5NnZCdjQzalYwQWdmb0NPeGU2SktnMzhJcGpn?=
 =?utf-8?B?SFl5L08raFhQWGFjb2huMm1hNjczK2NuUHMrdndoM0VJR1pXb1hSVnZ2elZW?=
 =?utf-8?B?K0tuVUxJWjdPVXRsY3lDSDZLdS9ZZTJrbFZTSGdvMVZGUnBlbWc1UVYwSnEr?=
 =?utf-8?B?dEhyME1WNk5LRitIUHdjOXkvUTlFOThWbXhrVk83OHoxM3RtemdpUldqc3VN?=
 =?utf-8?Q?e2mXmWrjfXQ+bu6qp3vHvfEZNdvB6NJ/xicfCCipMM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9F223E6B6EBF1429508E132E0BC1D8F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e815e8-9473-415c-9a22-08d9a5549345
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 20:48:11.5344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaLKui2dpcpNZOv5xSHjXLCwL+vpRQD4wy1zKsKgotedt/gX02Pv0UkHZDfU64H4DC7t5tDSeCwi1heFj1gwgc0rFRcOkZSUKywI2rwdcNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1453
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTExLTExIGF0IDEzOjAyICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBGcm9tOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+IA0KPiBUaGUgZnVu
Y3Rpb24gc2V0X3B0ZV92YWRkcl9wNGQoKSBpcyBuZXZlciBjYWxsZWQgb3V0c2lkZSB0aGUgZmls
ZQ0KPiBhcmNoL3g4Ni9tbS9pbml0XzY0LmMuDQo+IA0KPiBNYWtlIGl0IHN0YXRpYy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg0K
PiAtLS0NCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaCB8IDEgLQ0KPiAgYXJj
aC94ODYvbW0vaW5pdF82NC5jICAgICAgICAgICAgIHwgMyArKy0NCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaA0KPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3BndGFibGVfNjQuaA0KPiBpbmRleCA1NmQwMzk5YTBjZDEuLjlmNGI2ZDQ4Y2UyYiAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV82NC5oDQo+ICsrKyBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaA0KPiBAQCAtNTksNyArNTksNiBAQCBzdGF0aWMg
aW5saW5lIGJvb2wgbW1fcDRkX2ZvbGRlZChzdHJ1Y3QgbW1fc3RydWN0DQo+ICptbSkNCj4gIAly
ZXR1cm4gIXBndGFibGVfbDVfZW5hYmxlZCgpOw0KPiAgfQ0KPiAgDQo+IC12b2lkIHNldF9wdGVf
dmFkZHJfcDRkKHA0ZF90ICpwNGRfcGFnZSwgdW5zaWduZWQgbG9uZyB2YWRkciwgcHRlX3QNCj4g
bmV3X3B0ZSk7DQo+ICB2b2lkIHNldF9wdGVfdmFkZHJfcHVkKHB1ZF90ICpwdWRfcGFnZSwgdW5z
aWduZWQgbG9uZyB2YWRkciwgcHRlX3QNCj4gbmV3X3B0ZSk7DQo+ICANCj4gIHN0YXRpYyBpbmxp
bmUgdm9pZCBuYXRpdmVfc2V0X3B0ZShwdGVfdCAqcHRlcCwgcHRlX3QgcHRlKQ0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvbW0vaW5pdF82NC5jIGIvYXJjaC94ODYvbW0vaW5pdF82NC5jDQo+IGlu
ZGV4IDlhMjQ1MzJkMmI4NS4uZTQ2ZDJmMThkODk1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9t
bS9pbml0XzY0LmMNCj4gKysrIGIvYXJjaC94ODYvbW0vaW5pdF82NC5jDQo+IEBAIC0zMDIsNyAr
MzAyLDggQEAgc3RhdGljIHZvaWQgX19zZXRfcHRlX3ZhZGRyKHB1ZF90ICpwdWQsIHVuc2lnbmVk
DQo+IGxvbmcgdmFkZHIsIHB0ZV90IG5ld19wdGUpDQo+ICAJZmx1c2hfdGxiX29uZV9rZXJuZWwo
dmFkZHIpOw0KPiAgfQ0KPiAgDQo+IC12b2lkIHNldF9wdGVfdmFkZHJfcDRkKHA0ZF90ICpwNGRf
cGFnZSwgdW5zaWduZWQgbG9uZyB2YWRkciwgcHRlX3QNCj4gbmV3X3B0ZSkNCj4gK3N0YXRpYyB2
b2lkIHNldF9wdGVfdmFkZHJfcDRkKHA0ZF90ICpwNGRfcGFnZSwgdW5zaWduZWQgbG9uZyB2YWRk
ciwNCj4gKwkJCSAgICAgIHB0ZV90IG5ld19wdGUpDQo+ICB7DQo+ICAJcDRkX3QgKnA0ZCA9IHA0
ZF9wYWdlICsgcDRkX2luZGV4KHZhZGRyKTsNCj4gIAlwdWRfdCAqcHVkID0gZmlsbF9wdWQocDRk
LCB2YWRkcik7DQo=
