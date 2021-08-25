Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9A3F79B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbhHYQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:02:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:25569 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242093AbhHYQB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="204750273"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="204750273"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="643569319"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 25 Aug 2021 09:01:08 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 25 Aug 2021 09:01:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 25 Aug 2021 09:01:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 25 Aug 2021 09:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb3WX85N7NnF2TeRt6nf3C0fTYdoQopEY2JxitfaNfsLs/izlWShi1VMj+j0QOi90VCHlYDHiPKXjmp64vyuIIrWHV7ouuj1iz2zITr9Uu+TrZZpHnTsuuHxeoKWIhWgQXASalwPQmTYHaB4lVTwZSiakLVmaGdfLkR5KLVSKALEq1DJe7HGRVbM4a+a9OtLNuRYeVTM5YQVcIvNweo9p86Zz3TgILpG8DRR/447gu8LkfePIro0Y7/wRFAlNQR+mEs2ME3iSxupCUfgKR9eu1Dbzdq/GZN1hSAC5jnaW9UQqtzqhqT2EZsiUdQbm+FSKIZyUvsBBUipqSyf1uvSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBBULX2kLbLJK/oZbBr58yyy+0Qn1VTvmFnzXUDy+hk=;
 b=nUoZC0oyMbNXcgJd0Uh8sCjZtxwij5vHvAgB9NMUKD5h+xYZdz7eXsxYWVheyryCOU9+bfSt2MapKIVakFUq8gOhdJWoYoc5dG4QazFmbegl5eETg7fHg/nODZwC2rJlRTFP1ANk1oK0rSQ5aAbZjD7I4QYdqoEzWRLDWzGo+cdCc5/8YNCDhm1h5g/uDWQaaDWxDTYWstcpOmQ9GgM+vsfteGpXz17ZT3ZXskSixuExFGcuaJWHusjHvvDKki0HVj5Ko7asLReRgd/YSgQKOwpWXgftKgXsVk30kTdQ2P42thdux9V3yKL8zsm+AG024eiAmeQjhbGOhWCx9PHXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBBULX2kLbLJK/oZbBr58yyy+0Qn1VTvmFnzXUDy+hk=;
 b=BMVmivUSqdBKwPNi7jqXZK02SWJxFPhaOIXg7CtKMXyHSemuOywngZ9ro6FT8uau08JGCfjro7HwBgYSA7xtxTgwYx+kuh7SMad3GvyFd77Hq7wx2Dsg6uVENF+uCXYqc63dOJdxL4J4vzS9hEogi3bFVL363BGgcxM8U/i3WOk=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Wed, 25 Aug
 2021 16:01:05 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%4]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 16:01:05 +0000
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
Subject: Re: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Topic: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Thread-Index: AQHXhVRxstI5EaBny0+yAHwtQ/jrKKtwWl6AgADOwYCAACF+gIAAoc+AgAcvswCAAKzPAIAKwTYA
Date:   Wed, 25 Aug 2021 16:01:05 +0000
Message-ID: <34EC5B9E-305F-4253-96BC-4A6BD38E7AB3@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com> <YRV6M1I/GMXwuJqW@zn.tnic>
 <2BF12EDA-89F0-40F7-B63E-50ADD0262164@intel.com> <YRZDu2Rk+KdRhh1U@zn.tnic>
 <2B279B5F-ACF2-46F2-9259-684419A57BDF@intel.com> <YRzSuC25eHEOgj6h@zn.tnic>
 <B0E262FE-21C3-44EE-B058-752ACDECD716@intel.com>
In-Reply-To: <B0E262FE-21C3-44EE-B058-752ACDECD716@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cae9b1e9-7f38-44a2-8cc7-08d967e18b70
x-ms-traffictypediagnostic: PH0PR11MB4999:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4999C62FFC17E6F62DECB6A7D8C69@PH0PR11MB4999.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GpwdvFMdqfWcADEzvX1QQDtussc4/WyKMqlU4ep/xEc7voStrn/YdqU9mcDeL+9C/5PDLJ1v38cWwWWa5hd/o9TWZFN9K6SZwl0RCHsvz7Uu0jHSn30nWJq9IHeDeJfB0Yfq8YIdbNM8q/CgUmjCiGdVe5Twg1au0RnhF7eebp60Y10b0u1FDNqFFEQbIJUZ0G7tw8LZcpvnlxGAciCRLAdTDyyDKHANEw/dGRBd/fJP3+rIMMUPChqWcIJQJO6PDQB0YwyIeiTdIHYZA5cYENrmatCmcV4OE7CSSg8WgGLeB9icpcfWXpNxfwwj0T0eywThGLI4mMkHkEUSs3cVqcqodChyrz1E3UR3x0ndKe+otc/m4UQXl9ozfb8sU+eBEX2n2a+M9M6cxOb5/CS+2GXEXNa/Y8wJl8R+68Nbb4f+CcE6sitBSpIDu3ZRG63N+Ii4hqc4/EuwFq1oDio/+LmOsinqc5nYdaK5XabrKALsrPL3WyWmkQP/8pY1Nmw0ndD/p/5eW1LLUYa4o1V61HGaq4h2VvFyr5ohifFgqdMQDpxpfkQPcfKslETqvZRQ2QrD3ZCS/BI9L3YpVhgTmyqPp5I7LrGK5KvAjIuvnLWLUdpjRzEMQ5YPyfhln20MAvWkIcLTSgZvsvqduQmGVP0fLYs8p5IZ0CFcPY6r5Q3YM8Loinuna7L4VybF8mQdusiyy20t7zFFW1ks7GFA/69Jwq9mnkdPyjbdbyCVj04=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(33656002)(26005)(86362001)(186003)(6916009)(6486002)(38100700002)(71200400001)(6512007)(478600001)(122000001)(83380400001)(66446008)(64756008)(66556008)(66476007)(66946007)(36756003)(76116006)(54906003)(316002)(2616005)(38070700005)(5660300002)(2906002)(6506007)(8936002)(4326008)(8676002)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEtuWmxMOW9WZnUydnhiaEE2T2dBRHhqU1JhcFhyZ0Zoc2JYakpCanpnTjha?=
 =?utf-8?B?L1hRcS9iQkdONHgwWEQwMVpYOGJERnYxbHZmQlVYL2xicEJEY1BwYnNrU0ls?=
 =?utf-8?B?ejhkMG5hTkE0aENibzlEVWpYYy9BTVJKanQva2ZrZXlFR2pkM0Fsa0tKWGdm?=
 =?utf-8?B?QWU0QytZTmNHYXNzM3k1MnNLaFVvZ0JpeG9MQmVKNVN1YlE3NFl1SjhmZDNi?=
 =?utf-8?B?cVBqU2p0ajZUblpEenZCbnNQK1hCM1hJSjl1NVU4dWhwSW5WcnpFbUYvZHpz?=
 =?utf-8?B?Y1g5cEptdDZPaC82Zk9SSFdlSTAxTm4xTDJMeGh6aE5wU3JST2tqdjFMOGlM?=
 =?utf-8?B?b2J3SG5GL2ZaeUVTeDVmcGZFSUNraUJOQkx5MFpLRUVTQ2FpYlErRzNqbk14?=
 =?utf-8?B?eUo2bENyaGU3eEdMNzFxaFVUek1aa3o4dG1Pa1F6bUMySnRlVXZPV2VucmRZ?=
 =?utf-8?B?SllJZTdXQm5yQzFmOE8ySjdDUG9LeVM0eG1JZlQwSk91OU5POEdOT0NrNlQz?=
 =?utf-8?B?cnoxN1c2ZFltWmtZUHN2dE9TUFFFNmIzYkFPcGpHZEJCN3hZV0MzdHhFZUFK?=
 =?utf-8?B?V2RlcFJUZ3J1ZklyRk9heERjVjNVampJNHdyZGpTdysyOFBUYlI5UWI1THVt?=
 =?utf-8?B?a0h0UVNiVTdrb2tEeS9iZ0V6dkZnVkVXVnFxeS9WYkhKUFIvMzkxRW8xQXpI?=
 =?utf-8?B?MVgvOTYrNHVBY3BZMWlWWWJZbnBtTmY2d1lUcFBBb01hSFlOWFhpTkVxZVAz?=
 =?utf-8?B?SDJidmc0Tk9OQXJWQUFkVVQ4Y2ROWmx1Rm96ck5icCtiWFpjV2N0TkNxSEs3?=
 =?utf-8?B?U0pGb1JabTNSSHhQb0w4bHZDYkZkd0FvV1paQUxmTlByUEJFSzgxdFI5TGFl?=
 =?utf-8?B?U1RIVTJ2dUliYjIrS3VrNnJReWVxbXBMVi9SL3F6aE1uSDNUUTlWTGFIMXdz?=
 =?utf-8?B?aWdYNWc0ZEJMZlEyOHNJa1I0RThobmFzWmNoYVIzbjhWSDZGd3NqOFRSeUJL?=
 =?utf-8?B?QzVoN1liTllqcmtwWUlpQnhLUW5WSEhZVFBjNkFiUXE4NHlSSlJiQlVlbE0x?=
 =?utf-8?B?MWdVTFJ2WXhielduMnRKcFlCYnpmeFVoNVV0cGhobG9BODBUNG0yejFZZHY2?=
 =?utf-8?B?STJ4UWFHUVBjUS9mV3k4TVBIbG0rbWpVM3pWQ2tHWE9qRVBjQ05EemN6RFV0?=
 =?utf-8?B?VzI1MGpQM2VuamNOWjhyN0phMEJMUDREV2wwVXE2NlBNaWFKb2llcW1sREJt?=
 =?utf-8?B?Qk83RXBEelN4OUU0VTJIUXZVWTlwVjdMY1N0YkNmUk1IOStFdFVWcURqRHc2?=
 =?utf-8?B?bUs3dzRyNE0wK1Ztb2cxN21PT3IxOWtITTlNWHdTOTgrYUJoVzBBQStwY1FC?=
 =?utf-8?B?UEk3d1dwcVd5eC9uUGFoZmVIc0VTWU52ZEM4TWZuVVl4cWw1UWN4dWZ0MDJz?=
 =?utf-8?B?RDYyWmM5VmMxZDMyU3o3Y21RL3E4TEdKWlUvWEhiOFBnRHVuMTkyMk44Wkxr?=
 =?utf-8?B?alBXMUNYNXNHaENXWjJZSHdaT2wyNWYrelhyNnI3ZHdDZUNtaWZwSEoyOHhy?=
 =?utf-8?B?cjdGTnNtODZNbW96bDhjSytieE1FZHZQMmRXdVpkVm9uOTY4bG5TWTB5aU40?=
 =?utf-8?B?VkJJUFFyaDFJcDBWWmtkbXZDTEVWWWZKM3NydUl4czlPN0hYZlBhc0JrNWRp?=
 =?utf-8?B?c3Z0d3VNSnZtbjNqWko0VDZ0aWJkdE1vVHJvUWRUY1FZMlZkTWlIeEw4ZHNB?=
 =?utf-8?Q?sJCV0+Y6gerJ4tCIZ3Rqlznrg2N2nYN4Lk++56B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58B12B51D1EAF84AB7D4D42F198B7CD7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae9b1e9-7f38-44a2-8cc7-08d967e18b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 16:01:05.2744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZo4qAAVCg0BA/nglI3uXjDKG3xyBMl80ceL+Pe5JGli4G72sJPj13mCAzXd26hJVve7O9FaXtY7fzN3J6Li4npMisii6lKQK475oDt7Fsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDE4LCAyMDIxLCBhdCAxMjo0NiwgQmFlLCBDaGFuZyBTZW9rIDxjaGFuZy5zZW9rLmJh
ZUBpbnRlbC5jb20+IHdyb3RlOg0KPiBMZXQgbWUgY29uc2lkZXIgYSBjYXNlIHRvIG1pbWljIHRo
ZSBzaXR1YXRpb24gc29tZWhvdy4NCg0KT25jZSB0aGUgYmVsb3cgY2hhbmdlcyB3ZXJlIGFwcGxp
ZWQgb24gdG9wIG9mIHRoaXMgc2VyaWVzIHY5LCB0aGUgc2VsZi10ZXN0DQpyYW46DQoNCiAgICAk
IC4vdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMveDg2L2FteF82NA0KICAgICAgICAgICAgSW5qZWN0
IHRpbGUgZGF0YQ0KICAgIFRpbGUgZGF0YSB3YXMgbm90IHdyaXR0ZW4gb24gcHRyYWNlZS4NCg0K
Q2hlY2sgdGhlIGtlcm5lbCBtZXNzYWdlczoNCg0KICAgICQgc3VkbyBkbWVzZyB8IHRhaWwgLW4g
Mg0KICAgIFsgICA4Mi43ODA4ODJdIHg4Ni9mcHU6IEFzc3VtZSBuZXcgcmUtYWxsb2NhdGlvbiBm
YWlscyBoZXJlIGFuZCBmcHUtPnN0YXRlDQogICAgcmV0YWlucyB0aGUgb2xkIHJlLWFsbG9jYXRp
b24gKDB4MDAwMDAwMDA5ZjNhODNjYykNCg0KVGhlIHB0cmFjZWUgbG9hZGVkIHRpbGUgZGF0YSwg
c28gaXTigJlzIFhTVEFURSBwZXItdGFzayBidWZmZXIgaGFkIGJlZW4NCnJlLWFsbG9jYXRlZC4g
VGhlbiwgdGhlIHB0cmFjZXIgYXR0ZW1wdGVkIHRvIGluamVjdCBuZXcgdGlsZSBkYXRhIGJ1dCB0
aGUNCmtlcm5lbCByZXR1cm5lZCBFTk9NRU0gYWxvbmcgd2l0aCB0aGUgbWVzc2FnZS4gVGhpcyBl
bXVsYXRlcyB0aGUgYmVoYXZpb3Igd2l0aA0KcmVhbGxvY2F0aW9uIGZhaWx1cmUgb24gdGhlIHB0
cmFjZSBwYXRoLg0KDQogICAgWyAgIDgyLjc5MzEyN10gcHJvY2VzczogeDg2L2ZwdTogRnJlZSB0
aGUgcmUtYWxsb2NhdGVkIGJ1ZmZlciBhdA0KICAgIDB4MDAwMDAwMDA5ZjNhODNjYw0KDQpUaGUg
cHJvZ3JhbSBleGl0ZWQuIFRoaXMgbWVzc2FnZSBpbmRpY2F0ZXMgdGhlIG9sZCBidWZmZXIgd2Fz
IGZyZWVkIGF0IHRoYXQNCm1vbWVudC4NCg0KVGhhbmtzLA0KQ2hhbmcNCg0KDQpkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva2VybmVsL2ZwdS9yZWdzZXQuYyBiL2FyY2gveDg2L2tlcm5lbC9mcHUvcmVn
c2V0LmMNCmluZGV4IGVlNzFmZmQ3YzIyMS4uMzE1M2RjOTFjNzE1IDEwMDY0NA0KLS0tIGEvYXJj
aC94ODYva2VybmVsL2ZwdS9yZWdzZXQuYw0KKysrIGIvYXJjaC94ODYva2VybmVsL2ZwdS9yZWdz
ZXQuYw0KQEAgLTE3MCw4ICsxNzAsNyBAQCBpbnQgeHN0YXRlcmVnc19zZXQoc3RydWN0IHRhc2tf
c3RydWN0ICp0YXJnZXQsIGNvbnN0IHN0cnVjdCB1c2VyX3JlZ3NldCAqcmVnc2V0LA0KIAkgKg0K
IAkgKiBDaGVjayBpZiB0aGUgZXhwYW5zaW9uIGlzIHBvc3NpYmx5IG5lZWRlZC4NCiAJICovDQot
CWlmICh4ZmVhdHVyZXNfbWFza191c2VyX2R5bmFtaWMgJiYNCi0JICAgICgoZnB1LT5zdGF0ZV9t
YXNrICYgeGZlYXR1cmVzX21hc2tfdXNlcl9keW5hbWljKSAhPSB4ZmVhdHVyZXNfbWFza191c2Vy
X2R5bmFtaWMpKSB7DQorCWlmICh4ZmVhdHVyZXNfbWFza191c2VyX2R5bmFtaWMpIHsNCiAJCXU2
NCBzdGF0ZV9tYXNrLCBkeW5zdGF0ZV9tYXNrOw0KIA0KIAkJLyogUmV0cmlldmUgWFNUQVRFX0JW
LiAqLw0KQEAgLTE4Niw5ICsxODUsMTMgQEAgaW50IHhzdGF0ZXJlZ3Nfc2V0KHN0cnVjdCB0YXNr
X3N0cnVjdCAqdGFyZ2V0LCBjb25zdCBzdHJ1Y3QgdXNlcl9yZWdzZXQgKnJlZ3NldCwNCiAJCQkJ
Z290byBvdXQ7DQogCQkJfQ0KIA0KLQkJCXJldCA9IGFsbG9jX3hzdGF0ZV9idWZmZXIoZnB1LCBk
eW5zdGF0ZV9tYXNrKTsNCi0JCQlpZiAocmV0KQ0KKwkJCWlmIChmcHUtPnN0YXRlICE9ICZmcHUt
Pl9fZGVmYXVsdF9zdGF0ZSkgew0KKwkJCQlwcl9pbmZvKCJ4ODYvZnB1OiBBc3N1bWUgbmV3IHJl
LWFsbG9jYXRpb24gZmFpbHMgaGVyZSBhbmQgIg0KKwkJCQkJImZwdS0+c3RhdGUgcmV0YWlucyB0
aGUgb2xkIHJlLWFsbG9jYXRpb24gKDB4JXApXG4iLA0KKwkJCQkJZnB1LT5zdGF0ZSk7DQorCQkJ
CXJldCA9IC1FTk9NRU07DQogCQkJCWdvdG8gb3V0Ow0KKwkJCX0NCiAJCX0NCiAJfQ0KIA0KZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvcHJv
Y2Vzcy5jDQppbmRleCA1YjRmOWI4MmFlYTEuLmMwNDA5OGRiNThiNiAxMDA2NDQNCi0tLSBhL2Fy
Y2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMN
CkBAIC05OSw4ICs5OSwxNSBAQCB2b2lkIGFyY2hfdGhyZWFkX3N0cnVjdF93aGl0ZWxpc3QodW5z
aWduZWQgbG9uZyAqb2Zmc2V0LCB1bnNpZ25lZCBsb25nICpzaXplKQ0KIA0KIHZvaWQgYXJjaF9y
ZWxlYXNlX3Rhc2tfc3RydWN0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaykNCiB7DQotCWlmIChj
cHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0ZQVSkpDQotCQlmcmVlX3hzdGF0ZV9idWZm
ZXIoJnRhc2stPnRocmVhZC5mcHUpOw0KKwlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVB
VFVSRV9GUFUpKSB7DQorCQlzdHJ1Y3QgZnB1ICpmcHUgPSAmdGFzay0+dGhyZWFkLmZwdTsNCisN
CisJCWlmIChmcHUtPnN0YXRlICE9ICZmcHUtPl9fZGVmYXVsdF9zdGF0ZSkNCisJCQlwcl9pbmZv
KCJ4ODYvZnB1OiBGcmVlIHRoZSByZS1hbGxvY2F0ZWQgYnVmZmVyIGF0IDB4JXBcbiIsDQorCQkJ
CWZwdS0+c3RhdGUpOw0KKw0KKwkJZnJlZV94c3RhdGVfYnVmZmVyKGZwdSk7DQorCX0NCiB9DQog
DQogLyoNCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYvYW14LmMgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYvYW14LmMNCmluZGV4IGFmZDhjNjZjYTIwNi4uNjM5
M2VjMDFhOWExIDEwMDY0NA0KLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMveDg2L2FteC5j
DQorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYvYW14LmMNCkBAIC02MTAsOCArNjEw
LDYgQEAgc3RhdGljIHZvaWQgdGVzdF9jb250ZXh0X3N3aXRjaCh2b2lkKQ0KIA0KIC8qIFB0cmFj
ZSB0ZXN0ICovDQogDQotc3RhdGljIGJvb2wgcHRyYWNlZV9zdGF0ZV9wZXJtOw0KLQ0KIHN0YXRp
YyBpbnQgaW5qZWN0X3RpbGVkYXRhKHBpZF90IHRhcmdldCkNCiB7DQogCXN0cnVjdCBpb3ZlYyBp
b3Y7DQpAQCAtNjI0LDEyICs2MjIsOCBAQCBzdGF0aWMgaW50IGluamVjdF90aWxlZGF0YShwaWRf
dCB0YXJnZXQpDQogCXNldF9yYW5kX3RpbGVkYXRhKHhzYXZlX2J1ZmZlciArIHhzYXZlX3h0aWxl
ZGF0YV9vZmZzZXQpOw0KIAltZW1jcHkodGlsZWRhdGEsIHhzYXZlX2J1ZmZlciArIHhzYXZlX3h0
aWxlZGF0YV9vZmZzZXQsIHh0aWxlZGF0YV9zaXplKTsNCiANCi0JaWYgKHB0cmFjZShQVFJBQ0Vf
U0VUUkVHU0VULCB0YXJnZXQsICh1aW50MzJfdClOVF9YODZfWFNUQVRFLCAmaW92KSkgew0KLQkJ
aWYgKGVycm5vICE9IEVGQVVMVCkNCi0JCQllcnIoMSwgIlBUUkFDRV9TRVRSRUdTRVQiKTsNCi0J
CWVsc2UNCi0JCQlyZXR1cm4gZXJybm87DQotCX0NCisJaWYgKHB0cmFjZShQVFJBQ0VfU0VUUkVH
U0VULCB0YXJnZXQsICh1aW50MzJfdClOVF9YODZfWFNUQVRFLCAmaW92KSkNCisJCXJldHVybiBl
cnJubzsNCiANCiAJaWYgKHB0cmFjZShQVFJBQ0VfR0VUUkVHU0VULCB0YXJnZXQsICh1aW50MzJf
dClOVF9YODZfWFNUQVRFLCAmaW92KSkNCiAJCWVycigxLCAiUFRSQUNFX0dFVFJFR1NFVCIpOw0K
QEAgLTY0MCwxOCArNjM0LDE5IEBAIHN0YXRpYyBpbnQgaW5qZWN0X3RpbGVkYXRhKHBpZF90IHRh
cmdldCkNCiAJCXJldHVybiAtMTsNCiB9DQogDQotc3RhdGljIHZvaWQgdGVzdF90aWxlX3dyaXRl
KHZvaWQpDQorc3RhdGljIHZvaWQgdGVzdF9rZXJuZWxfeGJ1ZmZlcl9mcmVlX3dpdGhfcHRyYWNl
X2ZhaWx1cmUodm9pZCkNCiB7DQogCWludCBzdGF0dXMsIHJjOw0KIAlwaWRfdCBjaGlsZDsNCi0J
Ym9vbCBwYXNzOw0KIA0KIAljaGlsZCA9IGZvcmsoKTsNCiAJaWYgKGNoaWxkIDwgMCkgew0KIAkJ
ZXJyKDEsICJmb3JrIik7DQogCX0gZWxzZSBpZiAoIWNoaWxkKSB7DQotCQlpZiAocHRyYWNlZV9z
dGF0ZV9wZXJtKQ0KLQkJCWVuYWJsZV90aWxlZGF0YSgpOw0KKwkJY2xlYXJfeHN0YXRlX2hlYWRl
cih4c2F2ZV9idWZmZXIpOw0KKwkJc2V0X3hzdGF0ZWJ2KHhzYXZlX2J1ZmZlciwgWEZFQVRVUkVf
TUFTS19YVElMRURBVEEpOw0KKwkJc2V0X3JhbmRfdGlsZWRhdGEoeHNhdmVfYnVmZmVyICsgeHNh
dmVfeHRpbGVkYXRhX29mZnNldCk7DQorCQl4cnN0b3Jfc2FmZSh4c2F2ZV9idWZmZXIsIC0xLCAt
MSk7DQogDQogCQlpZiAocHRyYWNlKFBUUkFDRV9UUkFDRU1FLCAwLCBOVUxMLCBOVUxMKSkNCiAJ
CQllcnIoMSwgIlBUUkFDRV9UUkFDRU1FIik7DQpAQCAtNjY0LDE2ICs2NTksMTEgQEAgc3RhdGlj
IHZvaWQgdGVzdF90aWxlX3dyaXRlKHZvaWQpDQogCQl3YWl0KCZzdGF0dXMpOw0KIAl9IHdoaWxl
IChXU1RPUFNJRyhzdGF0dXMpICE9IFNJR1RSQVApOw0KIA0KLQlwcmludGYoIlx0SW5qZWN0IHRp
bGUgZGF0YSAlcyBBUkNIX1NFVF9TVEFURV9FTkFCTEVcbiIsDQotCSAgICAgICBwdHJhY2VlX3N0
YXRlX3Blcm0gPyAid2l0aCIgOiAid2l0aG91dCIpOw0KKwlwcmludGYoIlx0SW5qZWN0IHRpbGUg
ZGF0YVxuIik7DQogDQogCXJjID0gaW5qZWN0X3RpbGVkYXRhKGNoaWxkKTsNCi0JcGFzcyA9IChy
YyA9PSBFRkFVTFQgJiYgIXB0cmFjZWVfc3RhdGVfcGVybSkgfHwNCi0JICAgICAgICghcmMgJiYg
cHRyYWNlZV9zdGF0ZV9wZXJtKTsNCi0JaWYgKCFwYXNzKQ0KLQkJbmVycnMrKzsNCi0JcHJpbnRm
KCJbJXNdXHRUaWxlIGRhdGEgd2FzICVzd3JpdHRlbiBvbiBwdHJhY2VlLlxuIiwNCi0JICAgICAg
IHBhc3MgPyAiT0siIDogIkZBSUwiLCBlcnJzID8gIm5vdCAiIDogIiIpOw0KKwlpZiAocmMpDQor
CQlwcmludGYoIlRpbGUgZGF0YSB3YXMgbm90IHdyaXR0ZW4gb24gcHRyYWNlZS5cbiIpOw0KIA0K
IAlwdHJhY2UoUFRSQUNFX0RFVEFDSCwgY2hpbGQsIE5VTEwsIE5VTEwpOw0KIAl3YWl0KCZzdGF0
dXMpOw0KQEAgLTY4MSwxNyArNjcxLDYgQEAgc3RhdGljIHZvaWQgdGVzdF90aWxlX3dyaXRlKHZv
aWQpDQogCQllcnIoMSwgInB0cmFjZSB0ZXN0Iik7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIHRlc3Rf
cHRyYWNlKHZvaWQpDQotew0KLQlwcmludGYoIltSVU5dXHRDaGVjayBwdHJhY2UoKSB0byBpbmpl
Y3QgdGlsZSBkYXRhLlxuIik7DQotDQotCXB0cmFjZWVfc3RhdGVfcGVybSA9IGZhbHNlOw0KLQl0
ZXN0X3RpbGVfd3JpdGUoKTsNCi0NCi0JcHRyYWNlZV9zdGF0ZV9wZXJtID0gdHJ1ZTsNCi0JdGVz
dF90aWxlX3dyaXRlKCk7DQotfQ0KLQ0KIC8qIFNpZ25hbCBoYW5kbGluZyB0ZXN0ICovDQogDQog
c3RhdGljIGJvb2wgaW5pdF90aWxlZGF0YSwgbG9hZF90aWxlZGF0YTsNCkBAIC05NTEsMTMgKzkz
MCw4IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCiAJaWYgKHNjaGVkX3NldGFm
ZmluaXR5KDAsIHNpemVvZihjcHVzZXQpLCAmY3B1c2V0KSAhPSAwKQ0KIAkJZXJyKDEsICJzY2hl
ZF9zZXRhZmZpbml0eSB0byBDUFUgMCIpOw0KIA0KLQl0ZXN0X2FyY2hfcHJjdGwoYXJnYywgYXJn
dik7DQotCXRlc3RfcHRyYWNlKCk7DQotDQogCWVuYWJsZV90aWxlZGF0YSgpOw0KLQl0ZXN0X2Nv
bnRleHRfc3dpdGNoKCk7DQotCXRlc3RfZm9yaygpOw0KLQl0ZXN0X3NpZ25hbCgpOw0KKwl0ZXN0
X2tlcm5lbF94YnVmZmVyX2ZyZWVfd2l0aF9wdHJhY2VfZmFpbHVyZSgpOw0KIA0KIAljbGVhcmhh
bmRsZXIoU0lHSUxMKTsNCg0K
