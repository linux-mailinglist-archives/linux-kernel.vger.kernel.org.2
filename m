Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17583413EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 03:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhIVBQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 21:16:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:36071 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhIVBQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 21:16:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="287165228"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="287165228"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 18:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="518409596"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 21 Sep 2021 18:15:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 18:15:13 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 18:15:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 18:15:13 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 18:15:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQJwyAcJt4AqFPOBoDiWOVTlF8je+GAYfdv3iaw/EX0m4rSc07WuBLZLUox34e5DjxRPgyTSfdpYz7oF5F019lCxQadyvr5B1NPzU+EqCLs17Ivq4F/9Ppdwc5kPD7X1tqdQu72EamlOxWrY43P+NePXx7rPEXBsmmv9lD2ov3kgKQ87uqYsiMSk3/XPomBvNSNgNqxPOAis0IXq97dl6fjsVAkrmB47qGmPlU4/XCHP9znC7V9grAMJNEhVRdeX5lSRU25F9mnoQxqC6gh+cDK6KbtChSsjRL1u0piiXBl1kAg4Jw76OzihsmuQTDqUsG3WN1yJboAWdEOsIG4UcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2nHZQxjhrSvmmJyE2twwGxeLzeWCltlsrAEBrGt1BnQ=;
 b=I66lhwcjH7e0FtuSP9eHDqAV7AwyZbUczZN2hI1C7idW/71pLpl5BUAvVBLrASnkqJx9snExVOxZwjfrjauADX97ptnfSjY59T8FJw76kdpHGb3FLJIRe0OTt1pKsejJdtRUkhhaIAsRN1e1+pQ1a64UnZzLtqcFfREzySXBN0tI9pdqUE4C9WzPOSQBUBJkIdV4i0qYlnevStNXB3la6VOgz9MUS/AwvHmAr7r9xE1726QWhxENz8pBEp6Ld3hHWnXNceOw20Qmjyb+A/aIejR7swXg8fEMubt1M4AmneznHnRyOwgxs2ii1RXwu5wO4n3WE/gC0L5Oa9EPLN6vxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nHZQxjhrSvmmJyE2twwGxeLzeWCltlsrAEBrGt1BnQ=;
 b=CWsbhD4+bSEXC6QSG3LuX6l2HZ6f181cTG9/HRFJ/2zr1TTAQ0/2zy6LZBwy5txW9J/aEYCuGxCouyGrNc55U8k8BMetl+9buRnXnlHcn1TIn37JQeNe9xmlKvwcmoSSFJ77TLERwNqwB0iQm4Oe1AW5Qf/ud3WHV7TZkTdSnx4=
Received: from MWHPR11MB0078.namprd11.prod.outlook.com (2603:10b6:301:67::38)
 by MW3PR11MB4649.namprd11.prod.outlook.com (2603:10b6:303:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 01:15:10 +0000
Received: from MWHPR11MB0078.namprd11.prod.outlook.com
 ([fe80::4d25:f96:4157:545d]) by MWHPR11MB0078.namprd11.prod.outlook.com
 ([fe80::4d25:f96:4157:545d%6]) with mapi id 15.20.4523.019; Wed, 22 Sep 2021
 01:15:10 +0000
From:   "Zhang, Xiang1" <xiang1.zhang@intel.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>, Dmitry Vyukov <dvyukov@google.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Carlos O'Donell <carlos@redhat.com>,
        "Marco Elver" <elver@google.com>,
        Taras Madan <tarasmadan@google.com>
Subject: RE: [RFC 0/9] Linear Address Masking enabling
Thread-Topic: [RFC 0/9] Linear Address Masking enabling
Thread-Index: AQHXrwxtTYdvvM+tok2F2YV6h4iMUquvPSSw
Date:   Wed, 22 Sep 2021 01:15:10 +0000
Message-ID: <MWHPR11MB00787E70E2E0316E5124741DD3A29@MWHPR11MB0078.namprd11.prod.outlook.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <CACT4Y+bh1yaGLs5H3YTM6YLLtyWELvjWR7HcEk0pd9Nod9u4ZQ@mail.gmail.com>
 <20210207141104.ikxbdxhoisgqaoio@box>
 <CACT4Y+YwUgksZBj4YpChqL8iac2us7mOkbVDLsib3Y+MVb31cw@mail.gmail.com>
 <CAMe9rOog08O8xmhhXuJ6aTO+ctv8D2yw1_vu8XjQWwsfw707Mg@mail.gmail.com>
In-Reply-To: <CAMe9rOog08O8xmhhXuJ6aTO+ctv8D2yw1_vu8XjQWwsfw707Mg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3341b0f8-747b-4b46-4c92-08d97d666c25
x-ms-traffictypediagnostic: MW3PR11MB4649:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MW3PR11MB46499D43F75AA2D198629C24D3A29@MW3PR11MB4649.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nVX9hJXO+dn8UAnyWYxwy8u64P1w/v1J7mxek0Sx04aZy9p6yluysR96VsL5FXPvzNEr1NmWi2E7S4tDoVn8mUYZW3NHBPx/11RD0IStHTRBc66kYbDHLDnDcvOzeahz4O2R8r15XO6j8kGxal6R8WyQYvIgv/z1v2m9MtRVJNChIUTCtSjbUldPQK/iEmO02I/l045TjE94eJt+dD5ig3X4JIAlaMRFGQS0RonXz+L6N0fXP5DsSDYgfcUYBimjRXs/eTx5mtUnuvyziWaNrcjpcVQW/nwXrmdWNRUicaXZXAvdG+y5GhXxpBkvMayOkOgXV3PPTSMsWwX9qYG+dgY+td1nRWGyYLM5DmSWeG/1uaHzKflAMSpTHmtqeRj9NdbLBdzsr/auF6Zi/9umPJh558QfdMEWYT9csmqxsI/MlYu2L5cAtXM3DV5XTob4GmNHrvdAtfWjA1xDoMujUoYzTf6wrySxLAanyFplTQ4RDZQhS2HQcl1n2EG5glwMXYUMk0+eE1QyMICbH9XZS/iHVCOlIMay7zKWwO9XYjzixptkuMvokntYueh3iAp0dGI61xq4MNj/I9KIkA0RpWghvZTmVcTJlbnChz6cKKyXJwEeEEbcBodwHPWH/a0+9j3N5WAL8syp/AVJAh9cMX4NOccttO1Lxq5KnEUWe2aBMzxqgK+dE4xcto0B1oawYBt+nDBH3KfP/ZfVHG547DBXUnrtZtzahPm0g95kIGiQ3l+91s5jqukhDfDb+SSsxzpqbJlqNZB5xUz4NBFCv3bRgKhFpzFeeCIqOEfxwFgpvfB+dpOzRrtgYlb/ZAZkY2r2gg988aGHPLqI7TbAHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0078.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(5660300002)(2906002)(76116006)(7696005)(508600001)(83380400001)(66476007)(71200400001)(64756008)(38070700005)(66556008)(53546011)(66946007)(966005)(6506007)(26005)(7416002)(186003)(4326008)(9686003)(316002)(8936002)(86362001)(110136005)(54906003)(122000001)(52536014)(55016002)(8676002)(66446008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXBaU3Zxc080R1JMV0xGMXpvVXlaQU1jTmdkQXJZV09Sd0U1VUowOFZveS9j?=
 =?utf-8?B?NGoxdFp6MkJGcVhqVGtOSWVDc2JlMlRsMjRuREtqR0VOSUFKM2NzcDh2cHVh?=
 =?utf-8?B?N3RnVEhCNDBHOXZCWFQwNk54WE1JY1d0TDEzVVpGNTFwMExRZ2dQazVXU1NK?=
 =?utf-8?B?dktZOFdocEJ0RzA3LzFNc3hMcDF1bjZVdmxHK21admsyeWRzTzgvMDBlUTNp?=
 =?utf-8?B?dE5vaUZsMkJLWVgyTysrMUxIcHlmUG1CZXJGckFaNmhmeVpCMUVianJRQ2hN?=
 =?utf-8?B?Y2J5cmRNcThlMWF6M2dCdnJaeFJra2FqdExCVFkzVHdBdHpmTS9YL3FUOXNI?=
 =?utf-8?B?aEJ0QUc4N3UzKzNFV25wd29QOTZDT3JFcnd4V2xGNG5yNlFrM21mSmgxT21J?=
 =?utf-8?B?RnlNVU9mVHJDSmtPMG1vdDVVbExWMXZsZlgwdHNmNWwvOVhzdzNsWStrVVFp?=
 =?utf-8?B?aitOR3NXNE5iVkJZdWUyTFJVUkNTN0dCWlRWUER4TnUrVkVYc25MZk9pKzhk?=
 =?utf-8?B?UkFycmZTVEl0enRDU0ozd3pJaDI2WGFyYXdHRFFsc2w5cUpFbFduclkvSGpu?=
 =?utf-8?B?MU84ZHN0ZzkybEQ2aHI5ajJGdjJRZU9RRytHeWJVc29xaFNsV3RGWnQ5Z3N1?=
 =?utf-8?B?VFJmWDRlQmRqcHZUdWx5WWdFalVaZ1pycmN6cVJkZFFWc1ZlV2hsK2N2MG9N?=
 =?utf-8?B?anZySldBSEV1QXVISzc4bGFaOTc1MXBCWjJRK1drekFodlpiNzdOMnNkSUJU?=
 =?utf-8?B?ang1dE9zdGZyN3RDQzdaOXFGYTFHWVgxM0RaMmJ5QjNGeFFJZlNaTmlpbHMr?=
 =?utf-8?B?c1h3TTdmSXh2L0JCdGRIVmlqUVdrOHNPSmZIRC8rTGpjRkRoSnNPUEVwQkk1?=
 =?utf-8?B?MUcvRUNQNmw3SnNCT1EyTmtHZVJhUFFjRnBqanFZRytyYmIzOFBnZjVmdkxm?=
 =?utf-8?B?T3hHR0s3Vm9mTkFNSjJMOTBtWEhPZVpMT2hrb3lHK3NNbTIxNXNkdHhoUGZ6?=
 =?utf-8?B?S0ZzTGZ0OUdlOTJKMDkxcmhRODVvRkgrdENNZTBXUnR4TWZudzhQRnMyNElP?=
 =?utf-8?B?ZlFlWVJ0T21HdlVtMk10N3pGc1dyWCtlblJyMzZXSXJCYmV3SlhDMG1Xd0w1?=
 =?utf-8?B?QzhCSllvWW5zcnVHRVlVSmhoRDd2TFJhc3pvVkNvT0xpTkhBMXRYRkRtR1Nw?=
 =?utf-8?B?QUVOR1NCOWJkVWhsbUtZMFpEeDN2alo3MUd5YlRaTzRwTGFmNDR4anFTaGF4?=
 =?utf-8?B?QzIwcDhZZTNXdkdkS1gwcjhrRHNHQmtPV0JBRFFucFhLeHE0aHFiQTR6V0Yz?=
 =?utf-8?B?TUZ6Y1VYRnJ3LzlCR3I1UVJuV2Q4R0VPVmVJc1VucVFSTzF5WUZGQVo2VnNl?=
 =?utf-8?B?VWJVVEN6OWZyOXpXeGVGL21JVGVkRWtQL0VFU2sxNVAwVXl0TkdmM3VhYTl3?=
 =?utf-8?B?WVhlNzdQc0JuZktXbi9FczBlTDdheXhpZWpuM2x0MTcxc0pkRmxTNXN0KzJX?=
 =?utf-8?B?UVp6VDF5VEJxSXlaTjFneWl3ckQveGtrdlBYQWxaNlk5TXdDSWw1MGhQdFcx?=
 =?utf-8?B?MVMxME5oMy9TL1ZkYU5mL3FSUXZXMmxoWkZRdkQ3QlROZlBxUTdoSE5NY1lv?=
 =?utf-8?B?RHFnei9MTHplWG9lb0tvc3U1U3NpMUdiSEFncXJuMkRRQldRQjBlNGdsRFZx?=
 =?utf-8?B?d3NWMk1qTTREdHhwMHBIQWltQ1h2NVJZNlIrTkZFTnBnSXUzSXJFdlRtOUpm?=
 =?utf-8?Q?u1WGV3UHTJoyGQjwFqaF52OqgCwgcmFhs22m9XC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0078.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3341b0f8-747b-4b46-4c92-08d97d666c25
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 01:15:10.2726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09PSu3w1QFzfUqebyhp4BQc5sSYtjUyl02rlVuNqlM3jUgKY0+ib0I6QETa3BfjDVqFXGKx9h8OV5bwMVUXwaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4649
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgYXJlIGFscmVhZHkgaW4gbGx2bS5vcmcuDQpPbmUgb2YgbXkgb2xkIHBhdGNoIGlzIGh0
dHBzOi8vcmV2aWV3cy5sbHZtLm9yZy9EMTAyNDcyIHdoaWNoIGhhcyBiZWVuIGNvbW1pdHRlZCBi
eSBodHRwczovL3Jldmlld3MubGx2bS5vcmcvRDEwMjkwMSAgYW5kIGh0dHBzOi8vcmV2aWV3cy5s
bHZtLm9yZy9EMTA5NzkwDQoNCkJSDQpYaWFuZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogSC5KLiBMdSA8aGpsLnRvb2xzQGdtYWlsLmNvbT4gDQpTZW50OiBXZWRuZXNkYXks
IFNlcHRlbWJlciAyMiwgMjAyMSAxOjE2IEFNDQpUbzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBn
b29nbGUuY29tPg0KQ2M6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsQHNodXRlbW92Lm5hbWU+
OyBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+OyBE
YXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgTHV0b21pcnNraSwgQW5k
eSA8bHV0b0BrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgdGhlIGFyY2gveDg2IG1haW50YWluZXJzIDx4ODZAa2VybmVsLm9yZz47IEFuZHJleSBSeWFi
aW5pbiA8YXJ5YWJpbmluQHZpcnR1b3p6by5jb20+OyBBbGV4YW5kZXIgUG90YXBlbmtvIDxnbGlk
ZXJAZ29vZ2xlLmNvbT47IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+
OyBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgQW5kaSBLbGVlbiA8YWtAbGludXguaW50
ZWwuY29tPjsgTGludXgtTU0gPGxpbnV4LW1tQGt2YWNrLm9yZz47IExLTUwgPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+OyBDYXJsb3MgTydEb25lbGwgPGNhcmxvc0ByZWRoYXQuY29tPjsg
TWFyY28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+OyBUYXJhcyBNYWRhbiA8dGFyYXNtYWRhbkBn
b29nbGUuY29tPjsgWmhhbmcsIFhpYW5nMSA8eGlhbmcxLnpoYW5nQGludGVsLmNvbT4NClN1Ympl
Y3Q6IFJlOiBbUkZDIDAvOV0gTGluZWFyIEFkZHJlc3MgTWFza2luZyBlbmFibGluZw0KDQpPbiBU
dWUsIFNlcCAyMSwgMjAyMSBhdCA5OjUyIEFNIERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xl
LmNvbT4gd3JvdGU6DQo+DQo+IE9uIFN1biwgNyBGZWIgMjAyMSBhdCAxNToxMSwgS2lyaWxsIEEu
IFNodXRlbW92IDxraXJpbGxAc2h1dGVtb3YubmFtZT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBTdW4s
IEZlYiAwNywgMjAyMSBhdCAwOToyNDoyM0FNICswMTAwLCBEbWl0cnkgVnl1a292IHdyb3RlOg0K
PiA+ID4gT24gRnJpLCBGZWIgNSwgMjAyMSBhdCA0OjE2IFBNIEtpcmlsbCBBLiBTaHV0ZW1vdiAN
Cj4gPiA+IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4N
Cj4gPiA+ID4gTGluZWFyIEFkZHJlc3MgTWFza2luZ1sxXSAoTEFNKSBtb2RpZmllcyB0aGUgY2hl
Y2tpbmcgdGhhdCBpcyANCj4gPiA+ID4gYXBwbGllZCB0byA2NC1iaXQgbGluZWFyIGFkZHJlc3Nl
cywgYWxsb3dpbmcgc29mdHdhcmUgdG8gdXNlIG9mIA0KPiA+ID4gPiB0aGUgdW50cmFuc2xhdGVk
IGFkZHJlc3MgYml0cyBmb3IgbWV0YWRhdGEuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBwYXRjaHNl
dCBicmluZ3Mgc3VwcG9ydCBmb3IgTEFNIGZvciB1c2Vyc3BhY2UgYWRkcmVzc2VzLg0KPiA+ID4g
Pg0KPiA+ID4gPiBUaGUgbW9zdCBzZW5zaXRpdmUgcGFydCBvZiBlbmFibGluZyBpcyBjaGFuZ2Ug
aW4gdGxiLmMsIHdoZXJlIA0KPiA+ID4gPiBDUjMgZmxhZ3MgZ2V0IHNldC4gUGxlYXNlIHRha2Ug
YSBsb29rIHRoYXQgd2hhdCBJJ20gZG9pbmcgbWFrZXMgc2Vuc2UuDQo+ID4gPiA+DQo+ID4gPiA+
IFRoZSBwYXRjaHNldCBpcyBSRkMgcXVhbGl0eSBhbmQgdGhlIGNvZGUgcmVxdWlyZXMgbW9yZSB0
ZXN0aW5nIA0KPiA+ID4gPiBiZWZvcmUgaXQgY2FuIGJlIGFwcGxpZWQuDQo+ID4gPiA+DQo+ID4g
PiA+IFRoZSB1c2Vyc3BhY2UgQVBJIGlzIG5vdCBmaW5hbGl6ZWQgeWV0LiBUaGUgcGF0Y2hzZXQg
ZXh0ZW5kcyBBUEkgDQo+ID4gPiA+IHVzZWQgYnkNCj4gPiA+ID4gQVJNNjQ6IFBSX0dFVC9TRVRf
VEFHR0VEX0FERFJfQ1RSTC4gVGhlIEFQSSBpcyBhZGp1c3RlZCB0byBub3QgDQo+ID4gPiA+IGlt
cGx5IEFSTQ0KPiA+ID4gPiBUQkk6IGl0IG5vdyBhbGxvd3MgdG8gcmVxdWVzdCBhIG51bWJlciBv
ZiBiaXRzIG9mIG1ldGFkYXRhIA0KPiA+ID4gPiBuZWVkZWQgYW5kIHJlcG9ydCB3aGVyZSB0aGVz
ZSBiaXRzIGFyZSBsb2NhdGVkIGluIHRoZSBhZGRyZXNzLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGVy
ZSdzIGFuIGFsdGVybmF0aXZlIHByb3Bvc2FsWzJdIGZvciB0aGUgQVBJIGJhc2VkIG9uIEludGVs
IA0KPiA+ID4gPiBDRVQgaW50ZXJmYWNlLiBQbGVhc2UgbGV0IHVzIGtub3cgaWYgeW91IHByZWZl
ciBvbmUgb3ZlciBhbm90aGVyLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgZmVhdHVyZSBjb21wZXRl
cyBmb3IgYml0cyB3aXRoIDUtbGV2ZWwgcGFnaW5nOiBMQU1fVTQ4IG1ha2VzIA0KPiA+ID4gPiBp
dCBpbXBvc3NpYmxlIHRvIG1hcCBhbnl0aGluZyBhYm91dCA0Ny1iaXRzLiBUaGUgcGF0Y2hzZXQg
bWFkZSANCj4gPiA+ID4gdGhlc2UgY2FwYWJpbGl0eSBtdXR1YWxseSBleGNsdXNpdmU6IHdoYXRl
dmVyIHVzZWQgZmlyc3Qgd2lucy4gDQo+ID4gPiA+IExBTV9VNTcgY2FuIGJlIGNvbWJpbmVkIHdp
dGggbWFwcGluZ3MgYWJvdmUgNDctYml0cy4NCj4gPiA+ID4NCj4gPiA+ID4gSSBpbmNsdWRlIFFF
TVUgcGF0Y2ggaW4gY2FzZSBpZiBzb21lYm9keSB3YW50cyB0byBwbGF5IHdpdGggdGhlIGZlYXR1
cmUuDQo+ID4gPg0KPiA+ID4gRXhjaXRpbmchIERvIHlvdSBwbGFuIHRvIHNlbmQgdGhlIFFFTVUg
cGF0Y2ggdG8gUUVNVT8NCj4gPg0KPiA+IFN1cmUuIEFmdGVyIG1vcmUgdGVzdGluZywgb25jZSBJ
J20gc3VyZSBpdCdzIGNvbmZvcm1pbmcgdG8gdGhlIGhhcmR3YXJlLg0KPg0KPiBBIGZvbGxvdyB1
cCBhZnRlciBILkouJ3MgTFBDIHRhbGs6DQo+IGh0dHBzOi8vbGludXhwbHVtYmVyc2NvbmYub3Jn
L2V2ZW50LzExL2NvbnRyaWJ1dGlvbnMvMTAxMC8NCj4gKGFsc28gK0NhcmxvcykNCj4NCj4gQXMg
ZmFyIGFzIEkgdW5kZXJzdG9vZCwgdGhpcyBrZXJuZWwgc2VyaWVzIGRlcGVuZHMgb24gdGhlIElu
dGVsIENFVCBwYXRjaGVzLg0KPg0KPiBXaGVyZSBhcmUgdGhlc2UgY29tcGlsZXItcnQgcGF0Y2hl
cyB0aGF0IGJsb2NrIGdjYyBzdXBwb3J0Pw0KDQpIaSBYaWFuZywNCg0KUGxlYXNlIHNoYXJlIHlv
dXIgY29tcGlsZXItcnQgY2hhbmdlcyBmb3IgTEFNLg0KDQotLQ0KSC5KLg0K
