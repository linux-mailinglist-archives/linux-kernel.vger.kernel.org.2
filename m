Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A97F437FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhJVVBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 17:01:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:37209 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234309AbhJVVBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 17:01:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="290223695"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="290223695"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 13:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="535075112"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2021 13:59:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 22 Oct 2021 13:58:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 22 Oct 2021 13:58:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 22 Oct 2021 13:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbpBKPY1GkNSTfAe4osVV64Es+8yNPQCg8fv8rVH++9uVRRbnBw3VSATqZ+2KmxLpoNACPHOwvBRTdsj7qkFRet74qJT2Z4Q68d/GKZU9iOD8CB2JxMITK5C8tg458PT0fXiEifxgByEmr8YEzcLrluaOy0vfN00GglJwyk8JpZ1zqZlEzk1hEDrBWzny8Yab0O0Z5yl5fnlLb24W5EaQxt3AB9s8dkpfuX9/ZWO3eWLWdtXHTxGcGIbaPWaEpWdokInY5mhBwNRU2MhwL6JCY7piF0yHrP6QYzCKJ/ZcfFMPbauLizEqIsRGfdNCI5g2MrLzbeju4wxoFC/ixCOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItX2lj6mjG+ufkCN2oP6NXGQFi+xNeQj070Wc7vm4t8=;
 b=lrBHrwvYmYFXwVqe7OOuChED2yz+yWwpxFkc6gvBHMLQ/xU5Qeho+zx0G58aPRufBhqPlQfwF1URgLeusUPFutOcHXqGiPXLXRDCY+JtMXvMNr7jv0sa5d0KLfJSoNRi13cj+a4aPKghKlgRDyaRjdEdSIWyPp3yvDKKO04TlOcFPqbwGjPd3fFtv2dA97aXSzXXAqRj6D5rh1kVMtCsAAgmZKarrgiYH2OEG6cQ7iA2XDIhi97hMJ6xcO17lT8TbKA5SKcGYoHZ80oTYRzVkFRRtFeksBJsEvsiQ6DDkn0I9ADIjmFyy+oAYTkXwawi+LrJySnz5psYj3logSL81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItX2lj6mjG+ufkCN2oP6NXGQFi+xNeQj070Wc7vm4t8=;
 b=UiBLrCwYD7zICoYSS7ARotvJJLT+HkbR24/7GiKcH2d6ZG6Huv4FJYzY+lCq/2EcpnVG/WuXv1DF9s1DrL6JDKYIaIjmL7T1JBJ5lWYfI/hmK+zjnbx0a/Ryt0NX4Y+uvYx+poG0Fokwb2F6F6hLQ0oHG7j2WV6HFjM/HycwIBU=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (20.182.107.76) by
 PH0PR11MB4998.namprd11.prod.outlook.com (20.182.124.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Fri, 22 Oct 2021 20:58:57 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749%7]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 20:58:57 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 01/23] signal: Add an optional check for altstack size
Thread-Topic: [PATCH 01/23] signal: Add an optional check for altstack size
Thread-Index: AQHXxs/KH/zAunRvyU+haqpjnaTycqvfIzASgABecQA=
Date:   Fri, 22 Oct 2021 20:58:57 +0000
Message-ID: <6B4B6D23-AB40-40C8-9E3A-53B0659C7942@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
 <20211021225527.10184-2-chang.seok.bae@intel.com> <87h7d95bnk.fsf@disp2133>
In-Reply-To: <87h7d95bnk.fsf@disp2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3012dc71-d273-4c4a-cab3-08d9959ec429
x-ms-traffictypediagnostic: PH0PR11MB4998:
x-microsoft-antispam-prvs: <PH0PR11MB4998C3F8754C96DEEE29982ED8809@PH0PR11MB4998.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBoNrHVdRfgmCkiYP7m6vGGj+mIvwZPlgYa1aPrj6pRCJkfbdeL8M/mVg9EFRrfsXMcLqpGt2ofcjHH9nbETmihPM/vMtKQ5OqDvJfAl59H+J4WH6kR2YCfzFOQCclYGHxO5/SbEXiJN13PzaQN4yhPiLtzi4xPxD+93EECXnIcFUeBNaAmY/V5LCfK/bgE36P6acJJJk6PiCH8bey8LSneqkabgUyvF9O8LcK2fwJn9c6zTfa2mzBwh6+/AVu8md2nvW60N7+fzDd34Wr3EkCtzOi+CHdFpFH5BQbhvlk0RZl1yE4NNd4/O1sCmtQ20K2O6SQiInMfx7bFuzjGBeunlZZ1uFWx74Cx8regGRFrlDEqP5kJdzA8m6lAxQrxHI7mYIXMlr6eoyRz2ATjblNAMuRpx08oWs9Wz2cdVKzJQT6xtfTSAX1QaaReQW/jScAL6Lhpy7/oId51gLs+Op3fJYyoJVjGr9KYxHiIYRufIsqQFN7mJmxcFib8WlMXa42z3DLv1e/ghoLO7ND+9jX++iDCppXXEvoEsXxeZeQu7iMQlNsFN8uKnsCNiv+0/53ik4LFL0WxA1ByValDRUSmgRaZ0j7hWB5rTf7pHBTcNfTH8z+7egC5JQ6OgJDMkWH5BOpPaFZUDWt6xjpgAT0tcjRqEZ8hZibM8t/BpA8F02IUroJoY0vg8e/lHihNUfsUq4BuAM3gfZKRRp2nlFHXkSIlB4OCVzV9QCiJRsoa9eMMx8z6EV5h58rbFF8klSOivJJE5rbTcf7izkXEEkyLE7VFYyhLD13Ua8yDURoC70rn7c6oQSeq9uLTxT+DuOJV5aVSTV/vhFi4DOqUtjLPUxmuqhU5M5VlmtbD9tUc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6486002)(83380400001)(186003)(26005)(6506007)(82960400001)(8936002)(316002)(966005)(8676002)(508600001)(66946007)(66476007)(76116006)(71200400001)(6916009)(38070700005)(64756008)(38100700002)(2906002)(5660300002)(66556008)(122000001)(6512007)(54906003)(66446008)(33656002)(53546011)(2616005)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlA2MjgzS2xwaHJWY0xITm1kN0JScGZsVGd5NDlDSlZBV3laci9BdWlwcmJz?=
 =?utf-8?B?emR6dXhDd0pSMFUzaVZZdVNiRzQyakhsYW8xWTRQMVN1d2xOZVMwWFBkbEhM?=
 =?utf-8?B?RTFIMUREbVJ2RStrMHdRTTZnMmJxSmpCbENEYkpCdmhQZFBhcVREdHVVdWhQ?=
 =?utf-8?B?ZHVPVERpMWp2YWs1YTAyVnNGVW5VR1RlOWRCZHJYdUVkS1pBbWFWK1JFOEhY?=
 =?utf-8?B?RFg5S2Z5NHRRTXkvZzhRa3JDcnVkNVF5NzJuZmszL3Npam9lOVppVW5rcndi?=
 =?utf-8?B?ck9yOFpGKzQwMWJBTjNzYy95bDhLek85TTAxN3JRWjNBcjdLQ3RQTXpsNU9J?=
 =?utf-8?B?TElvdFdzU05LdUE2ZFZpOFQvNG1MNi9SUllIT3FSMk04MHozcTNnQ0VSMXdr?=
 =?utf-8?B?eU1DOUNRbGhzOHRVbW9seVZFSHpvUHV1eGNXQnRjcmMvT3FSM3N0dmw3NWpS?=
 =?utf-8?B?MnN6UWIwa082U2N0UXhtMHROTVRiUmpvWTNBd2grbUVYZjY2Ykg4NFYwOU9I?=
 =?utf-8?B?NG13dTVncWowZE4wT0tObnV4YXd3aHhlNlZJeGQvMVc5MVhpYnlBYlhXTDhT?=
 =?utf-8?B?cTZ0cWMza3RZLzdGbmpUVWhwREdseUdaUmtRcmhhUklKZENXQzdmeStrc2VF?=
 =?utf-8?B?MzFxVDhRRUh0N2Z5VmFoZFVHUVlQNTg1S08zSThqNnVsZVk2bldZbnVtL3dv?=
 =?utf-8?B?WWQ4OHV6c2F2UGsyYmxFWStPVUpkK2g0bnYvdWNxTC96SFN4eWpVMCszNnR6?=
 =?utf-8?B?dkcxWjZ6RXpyZGdESHZKcGlNSUJEOGE4RkwzVWdUSmxJbHoxOVVzY1RQVUlv?=
 =?utf-8?B?NmMyOGdGRkNMaERJL3Z2ekU0TlllaWE2TmJGWHU0SnlnT0hNcTRraFRXSHdo?=
 =?utf-8?B?MjZkeENRV2dzT0RFaVF2US9tWUxVY25DQ0lPdldLODVsNGRUMkl0ZnhOMFlC?=
 =?utf-8?B?OVpxVmlsbHpHczJZMGZXTSt5ei9RSzMwdGJDL3pabVBZN2tVT2FGcFVIaXVJ?=
 =?utf-8?B?cVc4eVVwNjliSDFXTUZKRzZYS285TFIzU2k3N3JFWktGRWU3RGlrWGljNnVj?=
 =?utf-8?B?MjdQY3FnUTdSSFFnZTEyRkVBalBZS2Y2eVJDZEtzcGV6WXIyc216V3BWUkpy?=
 =?utf-8?B?dHFTbVBWU241S1k4MkpONlJBSVFWVlNDOTExcUtZdk1maGk2YmZmVks0anJ4?=
 =?utf-8?B?S2IwRXZmTStCL3NyTytRTmpvd1d5V1lVbUluUmczZXV6TWxzSm9SaGpzcitp?=
 =?utf-8?B?VHExRDFmTENsRnJ2M3JNQjJXQ01DVGFrL0MyQU5BUWRVUVp6TkFQSEpXYmNo?=
 =?utf-8?B?VENwU3hSRjBzMGp5eFVmbFVOSXJaa3dZQk40VnpFc1BlV1RIOWZGb2ZSbkZO?=
 =?utf-8?B?Tk8zdWF3YjlORDdaUVBDK3lEUzZKWWhsRGp4dkZxTkNTUndRSG1DMFdzVlBy?=
 =?utf-8?B?TkN5Mm9CUUZ5M3Vqc2tPUXhoV3htNk45M0JNZ1A0N1lFU0U2QS9vRjNHcGxH?=
 =?utf-8?B?Q3NpaEZOS0EvY3JiMzZTUFl3MjhteFRGK21tTnh4b2lWQ0d1bjJnc3RTdkY2?=
 =?utf-8?B?dXNBUmFRRmVsdTZMYjhRNmNPVGg1eGNEbUVQUEM5Q1hYUGlFdzB1eENiVTBi?=
 =?utf-8?B?c3huSWFLT0ZwYTByVUQ4R280c2lsR2xnTzd4ZS9hRTMvMHdQNUhBcERMMElk?=
 =?utf-8?B?alJlbWErbHpRbTZQS3ZKaFRzOFcyUHIzK3lZTnYxT2k1QlFkeTROakNCcjhB?=
 =?utf-8?B?MllZTTZFb1dVNk5Vc2hyb1hpcThtTUFnQ1VyTGhlMnF5T3dwcFgyR0NWdDdE?=
 =?utf-8?B?S0xZdURWT0FLMHl5amQ2N0Ntdjh3cElZQTVISCtrcmc4R0oyU2tKOFNEeDNq?=
 =?utf-8?B?Qks5WWdUYUlraFl6dXNZT284cDhEdkY1dVgrZ0crWEIvbHFEVHhzL3pJeFRC?=
 =?utf-8?Q?WT6CaVH80N2ASHrRjW+IRkUdktCYcZVx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <563D76363E140D4F8EE39C87637EEE75@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3012dc71-d273-4c4a-cab3-08d9959ec429
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 20:58:57.7224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chang.seok.bae@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXJpYywNCg0KT24gT2N0IDIyLCAyMDIxLCBhdCAwODoyMCwgRXJpYyBXLiBCaWVkZXJtYW4g
PGViaWVkZXJtQHhtaXNzaW9uLmNvbT4gd3JvdGU6DQo+IA0KPiAiQ2hhbmcgUy4gQmFlIiA8Y2hh
bmcuc2Vvay5iYWVAaW50ZWwuY29tPiB3cml0ZXM6DQo+IA0KPj4gRnJvbTogVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+PiANCj4+IFRoZSB1cGNvbWluZyBzdXBwb3J0IGZv
ciBkeW5hbWljYWxseSBlbmFibGVkIEZQVSBmZWF0dXJlcyBvbiB4ODYgcmVxdWlyZXMNCj4+IGFu
IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBzYW5pdHkgY2hlY2sgYW5kIHNlcmlhbGl6YXRpb24gb2Yg
dGhlIHN0b3JlIHRvDQo+PiB0YXNrOjpzYXNfc3Nfc2l6ZS4gVGhlIGNoZWNrIGlzIHJlcXVpcmVk
IHRvIGVuc3VyZSB0aGF0Og0KPj4gDQo+PiAgIC0gRW5hYmxpbmcgb2YgYSBkeW5hbWljIGZlYXR1
cmUsIHdoaWNoIGNoYW5nZXMgdGhlIHNpZ2ZyYW1lIHNpemUgZml0cw0KPj4gICAgIGludG8gYW4g
ZW5hYmxlZCBzaWdhbHRzdGFjaw0KPj4gDQo+PiAgIC0gSW5zdGFsbGluZyBhIHRvbyBzbWFsbCBz
aWdhbHRzdGFjayBhZnRlciBhIGR5bmFtaWMgZmVhdHVyZSBoYXMgYmVlbg0KPj4gICAgIGFkZGVk
IGlzIG5vdCBwb3NzaWJsZS4NCj4+IA0KPj4gSXQgbmVlZHMgc2VyaWFsaXphdGlvbiB0byBwcmV2
ZW50IHJhY2UgY29uZGl0aW9ucyBvZiBhbGwgc29ydHMgaW4gdGhlDQo+PiBmZWF0dXJlIGVuYWJs
ZSBjb2RlIGFzIHRoYXQgaGFzIHRvIHdhbGsgdGhlIHRocmVhZCBsaXN0IG9mIHRoZSBwcm9jZXNz
Lg0KPj4gDQo+PiBBZGQgdGhlIGluZnJhc3RydWN0dXJlIGluIGZvcm0gb2YgYSBjb25maWcgb3B0
aW9uIGFuZCBwcm92aWRlIGVtcHR5IHN0dWJzDQo+PiBmb3IgYXJjaGl0ZWN0dXJlcyB3aGljaCBk
byBub3QgbmVlZCB0aGF0Lg0KPiANCj4gTGFzdCBJIGxvb2tlZCBBbCBWaXJvIHdhcyBkb2luZyBh
IGxvdCBvZiB3b3JrIG9uIHNpZ2ZyYW1lcywgYWRkaW5nIGhpbQ0KPiB0byB0aGUgY2MuDQo+IA0K
PiANCj4gVGhhdCBzYWlkIGRlc2NyaXB0aW9uIGluIHRoZSBwYXRjaCBpcyB2ZXJ5IHNvcmVseSBs
YWNraW5nLg0KDQpXaWxsIHVwZGF0ZSB0aGUgY2hhbmdlbG9nIHRob3VnaCwgbGV0IG1lIGNsYXJp
Znkgd2hhdCB5b3UgcG9pbnRlZCBvdXQgaGVyZSANCmF0IGZpcnN0Lg0KDQo+IEZpcnN0IHRoZSBy
ZWFzb24gZm9yIHRoZSBuZXcgbG9ja2luZyBpcyBub3QgcmVhbGx5IGV4cGxhaW5lZCwgaXQgdGFs
a3MNCj4gYWJvdXQgc2VyaWFsaXphdGlvbiBidXQgaXQgZG9lcyBub3QgdGFsayBhYm91dCB3aGF0
IGlzIHByb3RlY3RlZC4NCj4gRXNwZWNpYWxseSBnaXZlbiB0aGF0IHRoZSBzaWduYWwgZGVsaXZl
cnkgY29kZSBhbHJlYWR5IGhhcyB0byBjaGVjayBpZg0KPiB0aGUgc2lnbmFsIGZyYW1lIG9uIHRo
ZSBzdGFjayB3aGVuIHB1c2hpbmcgYSBuZXcgc2lnbmFsIEkgZG9uJ3QNCj4gdW5kZXJzdGFuZCB3
aGF0IHRoZSBjb2RlIGlzIHRyeWluZyB0byBwcmV2ZW50Lg0KDQpMYXRlciBpbiB0aGlzIHNlcmll
cywgYSBuZXcgeDg2LXNwZWNpZmljIHByY3RsKCkgaXMgaW50cm9kdWNlZCBzbyB0aGF0IGFuIA0K
YXBwbGljYXRpb24gbWF5IGFzayBwZXJtaXNzaW9uIHRvIHVzZSBkeW5hbWljIHN0YXRlcy4gSXQg
bWVhbnMgdGhlIHNpZ2ZyYW1lIA0Kc2l6ZSBpcyBhbHNvIGR5bmFtaWMuIEJlc2lkZXMgdGhhdCwg
aW4gdGhlIGltcGxlbWVudGVkIG1lY2hhbmlzbSBbMV06DQoNCiAgICAiVGFzayBhc2tzIGZvciBw
ZXJtaXNzaW9uIGZvciBhIGZhY2lsaXR5IGFuZCBrZXJuZWwgY2hlY2tzIHdoZXRoZXIgdGhhdCdz
DQogICAgIHN1cHBvcnRlZC4gSWYgc3VwcG9ydGVkIGl0IGRvZXM6DQogICAgLi4uDQogICAgMykg
VmFsaWRhdGUgdGhhdCBubyB0YXNrIGhhcyBhIHNpZ2FsdHN0YWNrIGluc3RhbGxlZA0KICAgICAg
IHdoaWNoIGlzIHNtYWxsZXIgdGhhbiB0aGUgcmVzdWx0aW5nIHNpZ2ZyYW1lIHNpemUNCiAgICAu
Li4NCiAgICAiDQoNClRoZSBuZXcgc2lnZnJhbWUgc2l6ZSBvdXQgb2YgbmV3IHBlcm1pc3Npb24g
aXMgdmFsaWRhdGVkIHZpYSBlYWNoIHRocmVhZOKAmXMgDQphbHRzdGFjayBzaXplLiBBY2Nlc3Np
bmcgZWFjaCB0YXNrOjpzYXNfc3Nfc2l6ZSBjYW4gYmUgcmFjeSB3aXRoDQpzaWdhbHRzdGFjaygp
LiBTbywgaXQgaXMgcHJvdGVjdGVkIGJ5IHNpZ2hhbmQgbG9jay4gKDMpIGxvb2tzIGxpa2UgdGhp
cyBpbiBhDQpudXRzaGVsbDoNCg0KCXNwaW5fbG9ja19pcnEoJmN1cnJlbnQtPnNpZ2hhbmQtPnNp
Z2xvY2spOw0KCS4uLg0KCWludCB2YWxpZGF0ZV9zaWdhbHRzdGFjayh1bnNpZ25lZCBpbnQgdXNp
emUpIHsNCgkJc3RydWN0IHRhc2tfc3RydWN0ICp0aHJlYWQsICpsZWFkZXIgPSBjdXJyZW50LT5n
cm91cF9sZWFkZXI7DQoJCXVuc2lnbmVkIGxvbmcgZnJhbWVzaXplID0gZ2V0X3NpZ2ZyYW1lX3Np
emUoKTsNCgkJLi4uDQoJCWZvcl9lYWNoX3RocmVhZChsZWFkZXIsIHRocmVhZCkgew0KCQkJaWYg
KHRocmVhZC0+c2FzX3NzX3NpemUgJiYgdGhyZWFkLT5zYXNfc3Nfc2l6ZSA8IGZyYW1lc2l6ZSkN
CgkJCXJldHVybiAtRU5PU1BDOw0KCQl9DQoJCS4uLg0KCX0NCgkuLi4NCglzcGluX3VubG9ja19p
cnEoJmN1cnJlbnQtPnNpZ2hhbmQtPnNpZ2xvY2spOw0KDQo+IFNlY29uZCB0aGUgcmVhc29uIHRo
YXQgMksgaXMgbm90IGVub3VnaCBtZW50aW9uZWQuICBUaGUgY3VycmVudCB2YWx1ZSBvZg0KPiBN
SU5TSUdTVEtTWiBvbiB4ODYgaXMgMksuDQoNClRoZSBNSU5TSUdTVEtTWiBjb25zdGFudCBpcyAy
SyBidXQgdGhpcyBpcyBhbHJlYWR5IHRvbyBzbWFsbCBpbiB4ODYgd2l0aCANCkFWWDUxMi4gSW5j
cmVhc2luZyB0aGlzIG1pZ2h0IGJyZWFrIGJpbmFyaWVzIHRoYXQgd2VyZSBhbHJlYWR5IGNvbXBp
bGVkIHdpdGggDQp0aGUgb2xkIHZhbHVlLiBUaGV5IHVzZWQgdG8gd29yayBiZWNhdXNlIHRoZWly
IHNpZ2Fsc3RhY2sgd2FzIG5ldmVyIHVzZWQuDQoNCj4gVGhpcmQgdGhlIGlzc3VlcyB3aXRoIG1v
ZGlmeWluZyB0aGUgdXNlcnNwYWNlIEFCSSBhcmUgbm90IGRpc2N1c3NlZC4NCj4gRnJhbmtseSB0
aGF0IGlzIGEgcHJldHR5IGJpZyBjb25zaWRlcmF0aW9uLiAgTUlOU0lHU1RLU1ogaXMgZXhwb3J0
ZWQgdG8NCj4gdXNlcnNwYWNlIGFuZCB1c2Vyc3BhY2UgZnVuZGFtZW50YWxseSBuZWVkcyB0byBh
bGxvY2F0ZSB0aGUgYWx0ZXJuYXRlDQo+IHNpZ25hbCBmcmFtZS4NCg0KTm93LCB0aGVyZSBpcyBh
biBlZmZvcnQgdG8gcmVkZWZpbmUgTUlOU0lHU1RLU1ogYXMgYSBkeW5hbWljIHZhbHVlLg0KVGhl
IGxhdGVzdCBnbGliYyB2Mi4zNCBoYXMgdGhpcyBbMl06DQoNCiAgICAiQWRkIF9TQ19NSU5TSUdT
VEtTWiBhbmQgX1NDX1NJR1NUS1NaLiBXaGVuIF9EWU5BTUlDX1NUQUNLX1NJWkVfU09VUkNFDQog
ICAgIG9yIF9HTlVfU09VUkNFIGFyZSBkZWZpbmVkLCBNSU5TSUdTVEtTWiBhbmQgU0lHU1RLU1og
YXJlIG5vIGxvbmdlciANCiAgICAgY29uc3RhbnQgb24gTGludXguIE1JTlNJR1NUS1NaIGlzIHJl
ZGVmaW5lZCB0byBzeXNjb25mKF9TQ19NSU5TSUdTVEtTWikNCiAgICAgYW5kIFNJR1NUS1NaIGlz
IHJlZGVmaW5lZCB0byBzeXNjb25mIChfU0NfU0lHU1RLU1opLiBUaGlzIHN1cHBvcnRzDQogICAg
IGR5bmFtaWMgc2l6ZWQgcmVnaXN0ZXIgc2V0cyBmb3IgbW9kZXJuIGFyY2hpdGVjdHVyYWwgZmVh
dHVyZXMgbGlrZQ0KICAgICBBcm0gU1ZFLiINCg0KPiBGb3J0aCB0aGUgc2lnZnJhbWUgc2l6ZSBv
biB4ODYgaXMgYWxyZWFkeSBkeW5hbWljIGFuZCBpcyBhbHJlYWR5DQo+IGNvbXB1dGVkIGJ5IGdl
dF9zaWdmcmFtZV9zaXplLg0KDQpBbHNvLCB0aGUgeDg2IGtlcm5lbCBzdXBwb3J0cyBleHBvcnRp
bmcgaXQgdmlhIHRoZSBBVF9NSU5TSUdTVEtTWiBhdXggdmVjdG9yDQpbNF0gc2luY2UgdjUuMTQu
IEkgaGFkIGRldmVsb3BlZCB0aGUgY29kZSB3aXRoIEguSi4gd2hvIGF1dGhvcmVkIHRoZSBnbGli
Yw0KY29kZSBbM10uDQoNCj4gU28gY2FuIHdlIHBsZWFzZSBwbGVhc2UgcGxlYXNlIGhhdmUgYSBi
ZXR0ZXIgZGVzY3JpcHRpb24gb2Ygd2hhdA0KPiBpcyBnb2luZyBvbiBhbmQgdGhlIHRyYWRlIG9m
ZnMgdGhhdCBhcmUgYmVpbmcgbWFkZS4NCg0KT2theSwgYnV0IEkgdGhpbmsgdGhlIGR5bmFtaWMg
TUlOU0lHU1RLU1ogaXMgbm90IHdoYXQgdGhpcyBwYXRjaCBkb2VzLCBubz8NCk1heWJlIHRoZSB0
YXNrOjpzYXNfc3Nfc2l6ZSBwYXJ0IG5lZWRzIG1vcmUgY2xhcml0eSB0aG91Z2guDQoNClRoYW5r
cywNCkNoYW5nDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjExMDIxMjI1
NTI3LjEwMTg0LTctY2hhbmcuc2Vvay5iYWVAaW50ZWwuY29tLw0KWzJdIGh0dHBzOi8vc291cmNl
d2FyZS5vcmcvcGlwZXJtYWlsL2xpYmMtYWxwaGEvMjAyMS1BdWd1c3QvMTI5NzE4Lmh0bWwNClsz
XSBodHRwczovL3NvdXJjZXdhcmUub3JnL2dpdC8/cD1nbGliYy5naXQ7YT1jb21taXQ7aD02YzU3
ZDMyMDQ4NDk4OGU4N2U0NDZlMmU2MGNlNDI4MTZiZjUxZDUzDQpbNF0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8yMDIxMDUxODIwMDMyMC4xNzIzOS0xLWNoYW5nLnNlb2suYmFlQGludGVs
LmNvbS8NCg0K
