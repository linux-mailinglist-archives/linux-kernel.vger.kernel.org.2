Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1CD44A5F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 05:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbhKIE6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 23:58:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:2574 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236513AbhKIE6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 23:58:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232221981"
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="232221981"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 20:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="545089101"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2021 20:55:51 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 8 Nov 2021 20:55:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 8 Nov 2021 20:55:50 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 8 Nov 2021 20:55:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps/reAlLOwIQuXfQYmepTkd4eVe5CN0m8Y0zBYd5SidHnkOfu/iJjCFSlH8k1wy/SHf4odtO/4gqxSuSQa/PgOAG2Wt3n8ePaFdngHG3CqZehWkbgazUpIEhtGBacVW3K7i43mkzX1/Cp69QSln55oK9S74+87r0927WJwrHrgdYFz6AuzbIyFX/cvUPtMzHS04qjRrda3ViZZYztFyuqDYJwL1sbmUSjjIXrHfFqxDfJrX/vUSsA9nNeHTFI/dMHq9PLZ4nrXxYDV0FqKeUpmaYuvqTvPk1V3L7JqNvUeNF6GRB14g0fCBwPv74CJaAY5LlKu/VYopHjSklub8wIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OazckJFULgXjneyYX3oX+66COaQt3d7XgrtROYbXgew=;
 b=JkH7m+ealGIAbi/YbjQZP2f0P+2o8A4tfL2lakV+qRqt3nOWFVAJZFW6p4Nyg4Tex487Hpa5iP8oslyeoBFZ0GzlXzw4yuSzt+L9Vl7Lxu2bvxF7cLPwHtH/1qNV1JdjJbkWvll7AZyKrKbLQ/I8ngS+wIisCsiLmvVGv0UjSyo9IyOws98IJ/EwZ3jH909DLafPepWLpR1WFVuzFPdFXg7F3hT+9pGE6RQkSd0hVHlDezTI77Cb4KRFFjtsekvRCzRxnUf+ZRuOtXCv3pfrB1PeFAg4iXxWncbbYsyrEFroxy8svfHlO80E4u7jsVbxbubxZU2y2dTo7enR5Gj9CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OazckJFULgXjneyYX3oX+66COaQt3d7XgrtROYbXgew=;
 b=VUyiGd6K5Rp0c/jbF4Svqsb847Iy2/80GyiidMUHG9M7wmU5neSu6RTSrd89SSCxaHQ+kn4tJQDOebmcB0L9FNjliUQaQ3inmVdJx/BaXToR1bkzTVCv18MRrKrdJfPvZSQCj8vEYg2xgp6SS0Ews/OVSFdrlq7b12kHXEDuGUg=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 04:55:28 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 04:55:28 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Zhong, Yang" <yang.zhong@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>
Subject: Re: [PATCH 1/2] x86/arch_prctl: Fix ARCH_REQ_XCOMP_PERM
Thread-Topic: [PATCH 1/2] x86/arch_prctl: Fix ARCH_REQ_XCOMP_PERM
Thread-Index: AQHX1PpF00vH5TX0U0aJp2BUsLSixKv6ohSA
Date:   Tue, 9 Nov 2021 04:55:28 +0000
Message-ID: <C5D433AE-80DD-4EDF-8365-5D628B1FFD7F@intel.com>
References: <20211108233501.11516-1-chang.seok.bae@intel.com>
 <20211108233501.11516-2-chang.seok.bae@intel.com>
In-Reply-To: <20211108233501.11516-2-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a9dde99-1b45-4aaa-0698-08d9a33d2666
x-ms-traffictypediagnostic: PH0PR11MB4997:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB4997F05B724263DFD094339ED8929@PH0PR11MB4997.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NKsffeee/BoYIuEej1u0dD4F4fNvpWo17x4Zwv+PiOMYEaNQHFi0yZ6ax+hOZlGxUJ8o6qvivYPkoQv7ADqSBe9qBUWWMUY3EiwJS9IyNvEnqxJrcQNRYlvujslkZbYA+QXgOMkPoNYma/bflENqFPLJ9a78ngh3sYEsJjoBI1etUkXgRzpJzSTcnha1rbxziNmIH+9k6I+LRbnUph8V9jwOWLN5lLZ1ENwIa35YfK8QoPJpvPTXUjOLXjMZ7yW+P9q9Qbu+mW0Tz0cJtXHISApDEK2CWXv3iHcW3kpNjQUsdgRJAqgDQGoIhqJJ7CoUJwZvfgDi/L2RLV/Sy2AIZdGEfgwZeeNlJ9ZVsqGtQvZVa9ZBQDvGVNLTN2ZbiSfV8Ngk0CQFRxM7GKG/PrEqAoh1cZ1n8IiB5LyUIgmDbLNfJFDBYCg6X4shZxu7CLuurVESu+Q3vOudqUag0D/cG8TOLmZYWYus9bVH1vgdAniyJ2DBO07BGXW2xqyLC8hxrsMYjZBn27XG9KEVlyg/5y8lCt7mFPvyP4xiQ4DWgELjHTSM+bKoMoWryzvFgAKzts+0LjY2CABqUEh0AXI40lj1nyxOSyV7/Vpi5ga8IK05BxZTQQ+Z+fP6k1okd/oAz778eu3wSLSpmotDd0q8jv8ZsGUIIDJS2SUaa/BkfewUpPi4PwEw32ovjwMVjGITkjsJz60FpmUyud7BkSppVx2r3N0l6y8wZPv+zZvTZeLSvIdn4vm90VfPrHkmG32R68ibhaSJQvy0457oDKMxmMTyXlELWGUxmXbhy3OzUSuvm4h5N311h6hAS45/F3jmmmUviWAFi0rIEXyZG/yusw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(2906002)(38070700005)(508600001)(71200400001)(66556008)(66476007)(64756008)(66446008)(8676002)(38100700002)(54906003)(186003)(316002)(26005)(6486002)(4326008)(5660300002)(2616005)(4744005)(82960400001)(36756003)(122000001)(6512007)(6506007)(86362001)(33656002)(8936002)(53546011)(66946007)(6916009)(83380400001)(966005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGgzemtuM1g1RGQwczRvdVhqc1o1NkkzM0xBajJOelROVUVBc052c1V0TkRi?=
 =?utf-8?B?OXVNUU8yYituZHQ0cUtGdldUMHBPYjJtM2Jwcm9DOU1nejhQdzNrSGY5Q0Jt?=
 =?utf-8?B?UzY3S2xOcjZ3RlRUa2hqby9VMHRnVFg3ci9WWEE2dlVUbkVOd2RnYTFDYU5K?=
 =?utf-8?B?c3ZsU0EvV25JSUVmMFdNdWtoNmRnL1FOclNGaDNsNXVGSFBnWXlTa1FQL2lT?=
 =?utf-8?B?ZUlvM1hFZlN0cHlMOXdBVjNvb0FsNTIycWJVS2ZoNjVDSWxqeDhUWFlYSURh?=
 =?utf-8?B?RjZwMjdPbkZMYlV4bFovM0RHQm1iVkZiN240MlV3eVdwdUkvSEpTbmkyMDlC?=
 =?utf-8?B?YVlidXpzNGFxSmUvQVJWWFdDWHNSdlhPMnN5ZnZWcEQxWGRIL3VXV0E3MmQx?=
 =?utf-8?B?dGNwS3l3L1VnUGVrcHhaSXJlbFRqYnBCUWZKTXBYNVJ2eUVocTFFcCtyZUFv?=
 =?utf-8?B?SWVDM3dsbzNYcmxIMDRucjFpRnBoZ3Y3WmV5ZzZzZXoySTZ1bzlqN1lPTDNU?=
 =?utf-8?B?MTQyZWlTbEovdkFBWWYrWHg4TVF2anVNenFaZnFIeDRLZTBLYWlWbEVlbnpG?=
 =?utf-8?B?ZG9zWENxWGdGOUFrMEIxczNCaXN3OXlDQjZpSDY5Y01STnlJL3R2cS9VcVV4?=
 =?utf-8?B?bzB0REwrUlphL3U0RnYzTnpHZ0YvQ1lVRTJqcnF4a3VDWkN1VEpiZklxQ0hI?=
 =?utf-8?B?R3Mra1daRWw1TndpNXpZOHVCZVhlVmVBZmhRdkwxbGxpL2pjVkZhTFNneG1P?=
 =?utf-8?B?N2k2Y1hveHJrVFFEVmFsRmlkdXROQmRwVk0zSGg3YWVraE0zK0tvTEJ0cmIr?=
 =?utf-8?B?ek1NdTBhakd4ZjVBNS8yd0ZvSjBqNzBIdk1ZSkZ3QTBCSnlhM0xhZ3JIakJ1?=
 =?utf-8?B?WitSRmpCK3NEN3BZRXFwV1ZZWERSQXBsRmdZVnBKYmd5cmoyT1BvS1lJaGJR?=
 =?utf-8?B?NFVLNGp2UFhQT2RnZUk4dERoQ3hjSTJYUU16cE1IWWJLOVc3R0pkVHpJZlFa?=
 =?utf-8?B?Zlpsb09jUnFETzd1N3FYeWI4U3ZTdGRIUUVjSkVoRDE1YkFUTzFQeG5pYVpV?=
 =?utf-8?B?cEJ6MmNJRGpRZ0Jtd2crZ2s3VnUwenlQUm8wWEVvazRyekJtZDZhNjFFQjRD?=
 =?utf-8?B?alpzRVg1TWhHMmdVNlhoNnpJYzQxZk9xL3M0TnJMWGN2YVVIN0NiYjArWnhM?=
 =?utf-8?B?N2VpUTgrM2dqdGRMOXZpUEdYcG5nSUptOXlWT2hZOTVCdTczbXplL05Wem1F?=
 =?utf-8?B?aGJmMFlidlE1Rmh5Tk9WTTdscHREZkN1VkVHdE5RbHZLQ3hmQzJ3R2tiTTlv?=
 =?utf-8?B?VVVHZE5tK1k1MGMvRG1KZHJJWlBWb0NqRjQ2YXdsYkhWbGJxMjcvbitFQXdU?=
 =?utf-8?B?K3FTNW5sK3RMekljbDlNUUt3SzhId21FTWZrb015Y08xYTljMFhjaVlaV1Br?=
 =?utf-8?B?UERqUnJwQk9JdG84L3FqbFVaQ0xEdWl0L0xSYktxQnBpYUU1SVlyRDJpUTEz?=
 =?utf-8?B?dUhsY2FnOW14RDZTbENGZzZjVWFBRVg0NkdvajJVTk9kaDNxOXMrcVpENU90?=
 =?utf-8?B?Q2VMTzdBUDlFait4S1ZGUVljNlI4ZXFUa0ZKNTR6QTFZOFFuYjF5UUpOT1Ux?=
 =?utf-8?B?WENHK2g5U3AySkRoMTF2OVB6clpPU25DWWZOa3BMQkZFZmE3eDRmbmtjTG8z?=
 =?utf-8?B?aGthbEw5bmUxNGFjaFF5NWV0bHh3dG1LOFl3TlFwUDhwenZNYlNCZEZkbWtT?=
 =?utf-8?B?aVB4MUNjMW41anNwVCt3bzZUSkJreEFBVUxrUGNsenlIV3kyQzlCbDV2aXVW?=
 =?utf-8?B?YVljSzk1bWkwb1RRdDBTcjhpaUVkT0lZd2V5ZGU4QlVuSEpCWHhneVlJTk5r?=
 =?utf-8?B?ZGdqaXFJcUpJU1N6WEh1aDBwV3lOYUtmZDVDdndvcUM1ZyswTmVwWG1WTmUx?=
 =?utf-8?B?akRNcnliYWxhNGZYKzVnOEdiVGMzUW1wYndXbGN0Wlp4cG9DWXE2dERXMzNs?=
 =?utf-8?B?ZnEvbEZGaVhFc3NUSlRyOUpCeGVGeHpuVEc4R1JJemp0dG1WbHh6VzRMUjNl?=
 =?utf-8?B?M1ErT1R5dU1HeU9Od04vajJwVVdKZ2M1blRXek5XSXZ5VnYwZTlRbkdEcnEw?=
 =?utf-8?B?M3JYQTZ3V2tVRWsxc212NDBYN2VFckNaRjAzMzBsaXdJQ2x6MjVzcFdBMWpx?=
 =?utf-8?B?T1psZ1p3UTJBTm5CNHNYanhvMG5FVm5jT3pubFhXWmloSCtzb3UxSXZybGxi?=
 =?utf-8?Q?dXSByfONFnYAv8zNtxIMLMWxnB7xqCDXESuR/q/pVo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C39C4BFE6670347ACFB9971FB0CC5A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9dde99-1b45-4aaa-0698-08d9a33d2666
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 04:55:28.1143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dR8A/NopKSC2sRT2LCaeOCyqnuDAZjtBEAhzrfXRNaf8YLs+0Fg0sXoRyGUDHlfMfHk9gasXfwDm5xU8rVyBAhULpomp2Pe6FsC17YkLheo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTm92IDgsIDIwMjEsIGF0IDE1OjM1LCBCYWUsIENoYW5nIFNlb2sgPGNoYW5nLnNlb2suYmFl
QGludGVsLmNvbT4gd3JvdGU6DQo+IEJ1dCB0aGUgY29kZSB1cGRhdGVzIHRoZSBjdXJyZW50IHRh
c2sncyBiaXRtYXAgaW5zdGVhZCBvZiB0aGUgZ3JvdXANCj4gbGVhZGVyJ3MuIA0KDQpUaGlzIHN0
YXRlbWVudCBpcyB3cm9uZywgc29ycnkuIFRoZSBjb2RlIGFscmVhZHkgd3JpdGVzIHRvIHRoZSBn
cm91cCBsZWFkZXLigJlzLg0KDQpWMiBpcyBoZXJlOiANCiAgICBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sLzIwMjExMTA5MDEyMTIyLjExNDItMS1jaGFuZy5zZW9rLmJhZUBpbnRlbC5jb20v
DQoNClRoYW5rcywNCkNoYW5n
