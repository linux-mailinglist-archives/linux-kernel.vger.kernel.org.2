Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF13FBF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhH3Xju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:39:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:37853 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbhH3Xjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:39:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218089836"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218089836"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 16:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="459625723"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2021 16:38:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 16:38:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 16:38:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 30 Aug 2021 16:38:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 30 Aug 2021 16:38:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8cgPv7vmc86e8Y8lcU2RDurahUXxH8bxf4cfmHvXCTWaPZXZCzZDv/ZrfHSz4OjsyNMkHOAAqCmzW/nD8tw3pbSwQ/UAsfK5bQEdAwFjNH+xi//9xwfLdYQ8ylHliVTQKdUanv0zgFCN81d9Ly9hTSu1yZ8tR6dx/e/a6YqeZvii2V9u6j/GhDowc8ahba7T6npudGO2xhGNMXeZJSVb0ZCM0thAq7z9Lrm0wMIp4JH43OmqwzOojjrDQQS/J9DHiGmXK6mCnKgQ1pzYspKi1oE/S8uJE0lVUyIHKM2P9gw4lqAv46CbbcZYyJa+4EOQB6F2nxHU3U9YxGakrP/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfUA2JQbtYvdI+/L/MZsbxxGMknvfhIUGJiLQX5vqnc=;
 b=IW0lbklUvCMoZ19BjJKffz71/CcJ3xRleOE1vC5b4RXT5RrPzakJG+6q3F7IIFyJwe5ssw9UTN3Ka/MwypoKQA8GVNyA6sDKb4lk+AEyXrz9tUnvpfFrsPt5IlnU9qAz2+UIxpcm3T/Vxdc/w/v9UnPAtWoJM6zim0RwphKYqWqtZlOBAWtMttwgXswVK5IgpZerZ9wV9u5PPCFJOmHcGK30ujqOK6SvhZ0AsGrGvQcnVb0QQez12S7h2WgCzIulQTlyENsEyY972HLFLE3QwIrrF5cPV/myU5grCA6idvEBFLrc2xfnq8hweosQnbFf68U76bpERYet2WOOmlnRHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfUA2JQbtYvdI+/L/MZsbxxGMknvfhIUGJiLQX5vqnc=;
 b=eYh9lUAMeO4nnbLHKt1otl/NYsA/FYCVM9Ks8eOwbYIhpXvyBQFmdbOE5Yjg2B7d1AFeSxQyAt/mr9es0V+/aDev/Qypz4l8RSvxEWDEQAfiKNQQyxvxIyO/M2U4AgWDZChh9Bz+PLW2iSkKprg8iF8Q9Q6+zobwKLg9DApAdGE=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4967.namprd11.prod.outlook.com (2603:10b6:510:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Mon, 30 Aug
 2021 23:38:37 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 23:38:37 +0000
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
Subject: Re: [PATCH v9 10/26] x86/fpu/xstate: Update the XSTATE buffer address
 finder to support dynamic states
Thread-Topic: [PATCH v9 10/26] x86/fpu/xstate: Update the XSTATE buffer
 address finder to support dynamic states
Thread-Index: AQHXhVR0IWLgliWOpk6soLtHG0iHVqt5PxCAgACJ6YCAErKbgIAAag+A
Date:   Mon, 30 Aug 2021 23:38:37 +0000
Message-ID: <013B70E7-0D57-4EB3-BBD2-D9F5E5555CC5@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-11-chang.seok.bae@intel.com> <YRzwB+fAEotDf4d7@zn.tnic>
 <E134A33E-C6B0-4325-A852-E426F305F387@intel.com> <YS0TA5FlI9nDfV8+@zn.tnic>
In-Reply-To: <YS0TA5FlI9nDfV8+@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2a67e07-c09f-466e-ca82-08d96c0f4a1e
x-ms-traffictypediagnostic: PH0PR11MB4967:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4967782C3DC37182393788DCD8CB9@PH0PR11MB4967.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 11HTh1pF0rXl8GTR6J+kacFScmeg9AxZAFRD4qyzQ70sl4oeid3ZBrGjEQl6Noeu4x5EX0OKecV4+4xDt82xywXeX6FcdDOfB32zMfeKQquyzCe0r1fdpvDa2uvElEKw/k71J6OiE7O4ip/IwULC/Fb26FMclgLe74SQ3kMpMnjEm83QX26zngMeFbSyIk2hAXdqrS/DcQ4vcnq1rF8OC04mtvLTU1ZVvi9MKaL/iIkkQjRXGPdMIivafY5KJZRITYll1k59NxH6L9B8fUfdnrLG/ZJWpuGhO5HWsemzfLJ31AORWHZTr2ui4r7yUFfGdNlw4J5e3Jo0NzF3XkhP+YB96cfRxOi6Goy9g9NiLg9FeIr7wK1Zhf9Ve5sMiI+8KwOowFvCgTOR2Mxod6sjYhB+P0L9Rw7ACMIXynRwYUxnIODOwC2+peJwZYD4VKd9NVmkmwXRLN0tn50k+AVeFSotrf7s8RHths85hB9iXGxEPL9O0/dWeEMBPXg4l3vF+cUZ2ccij4K2RRNd0ec/GuoUKuqaeCuIqh87RBnpFzQZzV5HNc9V4d93oFmO+cwRH1dB1FZIPzKcpqs1Mq11S/JAyuzbSJ3JXyD8a7hqTk1ysCSNWSiYDj5tPEbgVivFJ0Rrz/QMpVVpcgGBA8sPWWPXjcc3NXuR7LdevrxWN5jKkqx/ADaWrzpYd67g2zrL2HmNxFtmL7GUy5fWZpQeITpR03G3MhrR/jBcVWnd8QY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(66556008)(38100700002)(26005)(186003)(76116006)(66946007)(54906003)(4326008)(6486002)(64756008)(53546011)(33656002)(66476007)(478600001)(66446008)(316002)(5660300002)(36756003)(6506007)(8936002)(38070700005)(8676002)(71200400001)(6512007)(122000001)(6916009)(2906002)(2616005)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1YvekxNQkYyNnBGd2VoM3BJd3FJQmN3M0dtcUZDd1haa1JEMnI0UlErMmlv?=
 =?utf-8?B?aDc5TDdQcTlYbXNnK0FzSHVwNzE0QjVlaVR6S2pTdSt4ZjUwS2lZRUt2Y01l?=
 =?utf-8?B?NS9WSndMN3dQMnRub0Y4T3k4TW54S1lLMkllTmRrSGhwWWtRdVpxUDM0d3RL?=
 =?utf-8?B?bi9BMjNyVitGVVMzb3djNFhnYW92RlZhWmtLMTVuaXU5QWdCWjVSUlN0NHRp?=
 =?utf-8?B?MlFGaVluOFdxa3BqQkV0R1ZCNnlMSUdOYW9IVVU2MEJJc0ttNk5KV3JGSWpC?=
 =?utf-8?B?Q2dEd3ExZU1FNHZMRXpzVGRWQnRwY2NUUmRVQnJwaXJuQ0xZMzRzVkZUQmZa?=
 =?utf-8?B?NEVKWW9pT0p2RUlBK1dtUXI0bUxXSFpRaDVuUzlndExycGJnREI3eSszT2Fy?=
 =?utf-8?B?Z0dzZysxbjFrOElqSHdjYUUwNUROUHdyY1ZicDNMSm5LM1pLdExFTXRFeHZT?=
 =?utf-8?B?NWRVZS9EMFBMN1BQMG1xbDZmZllUeXhGN2xoYlZaQllGQUpCTnltSWg2eFNx?=
 =?utf-8?B?VzQ2M2s5VjJ5Y055Wlk3eHFqN0JydUlPcWVKUm1QV0o3eWFEaUtpcHMzVlpl?=
 =?utf-8?B?dlkwRHYwaFBQQUo0Qk43RDhKNlp6M1BCMzhhYjlvd1JuQWlMN040Zm9MVlFL?=
 =?utf-8?B?K1c4ZHNneUl2M09lcmxtOGxLRUU0Z0Joem9Za21jemZLeVAveDVEMFFjZzRO?=
 =?utf-8?B?MUZ4Y1YwOHNIS0gyRnVSMWozaThxd09KaHZGTWpuVFdvZFpjWHBaUU0xeml4?=
 =?utf-8?B?ZExlM3hnWnYzN2VkTFpTSHZJM2gxaVY5OUlJRHkvMlRUNlEzcDhiNXlNelVs?=
 =?utf-8?B?Rnk1UnFDT1EzMWw1cWJmcGdOOE1Ba05lVUV0aUR3Um1MNWV5eVU5VTVYY1gv?=
 =?utf-8?B?eUN5NnlYaXdRZkxVTk5SUE5WbjJLYW9rSjBpcGlnYzJPUUhEUUw4MUlVMlFs?=
 =?utf-8?B?QnBvQzYyV3cxQ2N6VmE1VVhCbFkyK0pYZEhRWm5GYlRCSGJRVVBsMHBWeEF3?=
 =?utf-8?B?aHRkdU54Wm1NZmVYRWFQY2lNMUN0YU1sN0g3eDVCdmZtSWUrenJ6TVY2NnBS?=
 =?utf-8?B?QmUrOTR0WElhRWFvdmF4TkdQWTFSODZJb3Fsdk5XbGl2clQ1Z2hFQm9RNm9p?=
 =?utf-8?B?NVpEMTV1eXNxRmpoRm9LMHk4RmJtRFhZWWYvbTk1RjZRaFZWbFdLRm5ESHU1?=
 =?utf-8?B?SWFyS1hBRFRXd2w5YzhrODMzaHdUTUFyWUJGcmZYL0hkZEZSZzM1T2hnV0xk?=
 =?utf-8?B?Wjc1SEZJcWJpUDFKem4zWUQ5QXVRaFdFRkhOTFFlQm1KUGpMR1lWcEY5M1dB?=
 =?utf-8?B?RXZ6MGJzKzRkdy80TzFyWkJxeHdnYlg3RXFzcEsrcjA2ejVIMFpSZmxhTDl2?=
 =?utf-8?B?bm1jSzliNWR6VEpBdEU1VHg1b3ZUT2JGRFQwWmhvM0JjcVdSdHNpRkorUnpX?=
 =?utf-8?B?VklaSEM2eEZGeGVuVVdpais2VVpQcEtocXRqZ05rTmNCdGdPbU1vL0h5M3hJ?=
 =?utf-8?B?bXZtMkg3VjB6ajkrd3Qrd1J2UTBQTHFGTko4WGNXWlltcGVCUStabUxRMFUy?=
 =?utf-8?B?ajNqSFVZeUhyR2dnaU5VY0d1Y3d3T3hXVmZEeXptbVVvdWdXY21JeFYzTWNi?=
 =?utf-8?B?TFFPZEJNbmRyRnNFZGw4NnJGRnUwUTR1RnFKQ3hxYllPS3ZDL0xJbFd2dndG?=
 =?utf-8?B?YkxYQ21SQlUvdWdESHNHOTQwNng1cHdMMEgxRTBIK2xwbUxNdXptSXhsMjhM?=
 =?utf-8?Q?mCBV7WKSbo/LMps387wVnUi9qjCD+b1AnJ7YE2i?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AEABAA0311DD84091F9882B042FC090@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a67e07-c09f-466e-ca82-08d96c0f4a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 23:38:37.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnqJR+Q3t2WIKJk36mTjHd9ZL9GlVZVpZdvjcg9roGZsuvO6uU3BJpW7CEK24mXmicV00tRmCoP/9ijRRNXgPm0gHZKkZpptC9FAbnrL3is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4967
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDMwLCAyMDIxLCBhdCAxMDoxOCwgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
IHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAxOCwgMjAyMSBhdCAwNzo0NzowNFBNICswMDAwLCBCYWUs
IENoYW5nIFNlb2sgd3JvdGU6DQo+PiBJdCB3YXMgcmVmYWN0b3JlZCB0byB1c2UgaW4gdGhlIG5l
dyBoZWxwZXIgdG8gZmluZCBmZWF0dXJlX25y4oCZcyBzdGFydCBwb2ludC4NCj4gDQo+IFdoaWNo
IG5ldyBoZWxwZXI/DQo+IA0KPj4gSWYgdGhlIHNpemUgaXMgYWRkZWQgdXAgaGVyZSwgaXQgaXMg
bm90IOKAmGnigJkncyBzdGFydCBwb2ludCBhbnltb3JlLg0KPiANCj4gWWVhaCwgc29ycnksIEkg
aGF2ZSBvbmx5IGEgdmVyeSBzbGlnaHQgaWRlYSB3aGF0IHlvdSBtZWFuIGhlcmUgLSB5b3UnbGwN
Cj4gaGF2ZSB0byB0cnkgYWdhaW4uDQoNCkp1c3QgcmVjYXAgd2hhdCBpcyBzYWlkIG9uIFNETSwg
Vm9sMSAxMy40LjMgRXh0ZW5kZWQgUmVnaW9uIG9mIGFuIFhTQVZFIEFyZWE6DQoNCiAgLSBJbiB0
aGUgY29tcGFjdGVkIGZvcm1hdCwgZWFjaCBzdGF0ZSBjb21wb25lbnQgaSBpcyBsb2NhdGVkIGF0
IGEgYnl0ZSBvZmZzZXQNCiAgICBmcm9tIHRoZSBiYXNlIGFkZHJlc3Mgb2YgdGhlIFhTQVZFIGFy
ZWEuDQogIC0gbG9jYXRpb25faSBpcyBkZXRlcm1pbmVkIGJ5IGxvY2F0aW9uX2ogYW5kIHNpemVf
aiwgd2hlcmUgaiBpcyBpbiAxIDwgaiA8IGkNCiAgICBhbmQgdGhlIGdyZWF0ZXN0IHZhbHVlIFhD
T01QX0JWW2pdID0gMToNCiAgICBsb2NhdGlvbl9pID0gbG9jYXRpb25faiArIHNpemVfag0KICAg
IChsZXQncyBzaW1wbGlmeSB3aXRob3V0IHRoZSA2NC1ieXRlIGFsaWdubWVudCBoZXJlKQ0KDQpU
aGlzIGxvb3Agd2FzIG1vdmVkIGZyb20gY2FsY3VsYXRlX3hzdGF0ZV9idWZfc2l6ZV9mcm9tX21h
c2soKSAoaWYgcmVuYW1lZCkgdG8NCmhlcmUgaW4gdGhlIG5ldyBoZWxwZXIgLS0gZ2V0X3hzdGF0
ZV9jb21wX29mZnNldCgpLg0KDQpCdXQgdGhlIHJldHVybmVkIHZhbHVlIGlzIGRpZmZlcmVudC4g
IGdldF94c3RhdGVfY29tcF9vZmZzZXQobWFzaywgaSkgc2hvdWxkDQpyZXR1cm4gdGhlIGxvY2F0
aW9uX2kgYnV0IGNhbGN1bGF0ZV94c3RhdGVfYnVmX3NpemVfZnJvbV9tYXNrKG1hc2spIGNhbGN1
bGF0ZXMNCnRoZSBidWZmZXIgc2l6ZSB3aGljaCBpcyBsb2NhdGlvbl9pICsgc2l6ZV9pIHdoZW4g
dGhlIGdyZWF0ZXN0IGZlYXR1cmUgbnVtYmVyDQppcyBpLg0KDQpUaGFua3MsDQpDaGFuZw==
