Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B58533139B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCHQku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:40:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:58493 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhCHQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:40:30 -0500
IronPort-SDR: hKjHy2g7roy84qwNU7DXAMLs5o9PjLXQu95K9TQF8R3jViJh2b6CTTWzIy0jf0JQx5O3AoSjak
 n1E4BI61gbeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175676443"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="175676443"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:40:29 -0800
IronPort-SDR: xL9bg1wIZ9j8P9R4fMT4E7RED2VlpPvBcBKgcjSBRNFyeDTNGg/DtRVcuQqfI0I0c+uhAcvxjz
 Ajr8Ysb0tA0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="430429363"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2021 08:40:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 08:40:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 08:40:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 8 Mar 2021 08:40:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 8 Mar 2021 08:39:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA+/Q8ZBP8PJG7Y/ImbUag1ZnGPtm5NvYepUE5mRtSt8i+tFPxZsov/Tpfj6mwFx2pm2FpTdTaJQ88kafKCaiksmkq5TyL1FzavF0M11gJ51ZqNZIwNB054/nSfDHY1U+B1uPT8HcN1xQcMBksff5yYp09ruRh43wDKjajXHaILKzChewrcxgNAkDVFErbNqN2yR/tCIu4Kdl3l96Ey9/HrsTKPOCZMxAUBGSFWAlktZPbcvYkyuIdBtWHAO+nIyh/GXUFifXsLkZ2zivndXRPyr0shGk/Vp7gwiMT0UjXFVnnYd0do/YmYojBKV/RRv2pMCr4qDlvZJP6HAaIFOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzNkQB95VjVYkSpGGeNLAamjZu5+In5cq68CQM32qvk=;
 b=X+wRVtcB4vTFcmXdL80vUhf5Dgt9ySg7kjCxUe5URq+i1KitSD0LJlMVde7V0n/KrSZ9OGnpZVeq8UOFff0iCOdaHWR7jY2YGIcHHj9qiu64J+jDP1ate5YGw+T5zXtmOaTJPuqhJMCk4w5eddSbyMnZAE1PsEsbjzDkfQwj/7gXSOMxJuIy2L+iRGzuxTsQy3s/htcKU4RZlefjvZyWe0ADGHN1dEXLc6FLdB7eLEzgnoRfIl/lDbVAoakzfNpfVkYratL4OR/kR1CEDUzXovmdhsauajG+zBnPNHuz/dFiCb922CUXGzezd2dG5SfyQeuyGWB9IhU7VOGP7gGXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzNkQB95VjVYkSpGGeNLAamjZu5+In5cq68CQM32qvk=;
 b=QCE0XRpU54jkWhRrTwN3p1yZOUhGKdgUa5NuyrimCYpC+amPrKZRpvoPv9cS+2S1sRBf4O2FO3GVt1tbxiqGHpTi51qf5WJ8StlDpWEkckBrKo5Y/FiucvuWL0WN54hLpRA3QoXMa8u9R+rth7zNXPV5H1Z5elHDP0nr6b3bBnQ=
Received: from SN6PR11MB3055.namprd11.prod.outlook.com (2603:10b6:805:dc::18)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 16:38:59 +0000
Received: from SN6PR11MB3055.namprd11.prod.outlook.com
 ([fe80::d4a0:9ff0:15b8:cd76]) by SN6PR11MB3055.namprd11.prod.outlook.com
 ([fe80::d4a0:9ff0:15b8:cd76%7]) with mapi id 15.20.3890.037; Mon, 8 Mar 2021
 16:38:59 +0000
From:   "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "soc@kernel.org" <soc@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "arm@kernel.org" <arm@kernel.org>
CC:     "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [RESEND PATCH 00/10] arm64: dts: intel: socfpga: minor cleanups
Thread-Topic: [RESEND PATCH 00/10] arm64: dts: intel: socfpga: minor cleanups
Thread-Index: AQHXFDdLiAT7SJnenUabQRnCJXmG7Kp6SqQA
Date:   Mon, 8 Mar 2021 16:38:59 +0000
Message-ID: <1fe9e98c7b3cc380e43a3aa0048a733a18c8816b.camel@intel.com>
References: <20210308162228.62614-1-krzk@kernel.org>
In-Reply-To: <20210308162228.62614-1-krzk@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.151.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0d2eb5c-3bf6-48a5-cd7b-08d8e250ac83
x-ms-traffictypediagnostic: SA0PR11MB4655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB46553F0ACC173DD0DB042624F2939@SA0PR11MB4655.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Z86HUSrokXH46gVrtxnZBfHqqpkpul6FHnnXyFHnE4hmj9v1P5fGfg9W/WqaFysiDtgNwRij6qfyb8r9FAZl+m9isl4dqHsU94qIeQTGlOrF5TCJT8XajZKz2kr7x+4wl06ZqYk1yMXzzhATSY833sjRiM6ANHR+1iVv5B0rkBRAUJ0mQAv2b7m3BAmkjias2jKALiynoqoa4uSDzEWK4HC+n95qBZTr+QnBKYEZdd+LMDrzFQclar35AxefQdedNIbAqQ7w0fNtFByZAueCtioMnnlWIA0Bp6JWvRe4kAzoRvT+WIvR99FgojENak0TOrCxfmimGmvV6Ie2Pv1G8u3H9sWE740e+90hk5tYXrxbR//EnXjggeDUi3sc52eEs3e/47HP7mXRL48d+9wdspXhFkDF0znR+q6qEzSYDYedGHj/n6JgsqwDxDn+kcNizsGVl/EYxI2Fd9Vg8oBdTdS1aSr6UYR+JYSMjKTPc3QXfKiHb9hGl9XkEbTom3feBFMp1yg11jJzdH2Vlu/gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3055.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(5660300002)(66946007)(478600001)(2906002)(66556008)(71200400001)(66476007)(4326008)(110136005)(64756008)(8676002)(54906003)(86362001)(91956017)(6506007)(8936002)(76116006)(36756003)(66446008)(26005)(186003)(2616005)(6512007)(316002)(6486002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QUhpaytGdmJGUG5kQTZoYy9mSVkrSmFJY0J1YW85ZktLNFFmbnpYZ0tYR3NO?=
 =?utf-8?B?ZkdKYldadFpNZ2trTTY4OW5MaDZ0a2I5WlFtVlIvZXBRcnlmWkRydk9WTnlt?=
 =?utf-8?B?S1VHZUJRblNLbjVRd29mZzdnOVRBdy9MYmgzSVJpZzc5ZnE3QTVDbFRuSG9r?=
 =?utf-8?B?MjkxaGRwSjlNanlTdWE4OGprOTlaODRpclV0bDIvY0JWUUdHR0I4ZmJyTnBZ?=
 =?utf-8?B?czVET2F3RmdwZ3AralJwbzAwTmtKZzcvaFdlTC9pZlVxVUI4NThSNzlHc1Rm?=
 =?utf-8?B?Vm5Hd1VJbmUycGtDVFlWdlpyWHNOK2M2OUZRMVZCL0hmMzFHVUFkN3phSFlC?=
 =?utf-8?B?TDJ3ejRLOURlRVh2cnlHaG5BSVpIRUZwNk1MbjNOUFc2a3V0Q2NPR1QvSDNI?=
 =?utf-8?B?bFBEZ2Zyb2JaVkdsM0NteXVvNHNuWFU5ZE5OUE1nN2pFQzR0N1hMVzFPNDNF?=
 =?utf-8?B?V1VEV1Z0K3Q0WW44WDgyd1FHQjJucmdoUVE1UEM5bno0ZzAwZTZhSEg5MTQv?=
 =?utf-8?B?US9ISTJjM3pVeFh0eVViRHQ4c2ZlRGxGTEdZSmM1U1NFRWtnUVV4eVlnNDNS?=
 =?utf-8?B?YWpLMFFLYnlhQTZUbVJIcndiUGg4alR1TmpBcjRFZUtLb1RRb3ZvR3RRVnUw?=
 =?utf-8?B?b0JvMGw3VzZKZGM1bUpTV25jdjdMYVhFU1hxd2lLWXlwNHpxUENabndOVE5n?=
 =?utf-8?B?K0REU3p2T294UjJxQThJeGZnZ3RFMmFRSDVYcUJibG1zU1AyVjFzb3Z2MjVh?=
 =?utf-8?B?UWZYKythMk9BNWNzTVdlWCszK05VRk1LSjhyb3IySm5JWEhGMzk0N2tiemV1?=
 =?utf-8?B?eUJ5YTNsT01hSXNxNXowUHRmYm9vSTZrRjFPcnhGQlVmVU5VSFlaMjNYNFV4?=
 =?utf-8?B?ZWhXLzI2NWQydXBXWC9GUlpocXhIaG53dG1ad0p6emZKcXd4OVl0ZzYzdk9T?=
 =?utf-8?B?NFVlbHZzZkhWZDh4RTNCUllRdHR5QTh5aGFXQnZoQWY1dDRiRjBjZk1ldVNN?=
 =?utf-8?B?WVQ2akdrZURGTlVVN1liR01TM3JTUVJnSWJETmlZVXlCN3ByTjQ4MXc2dDZ3?=
 =?utf-8?B?bVNYbTZmSjBxV0xLYjB5d0JPSGF3ZXRnV1FuY1hYR3FEc21HM2lLcGUzbi9v?=
 =?utf-8?B?cldrbmRFVmVyZG9pNmNDTUdnT3N1TVRESGpXVWtucVBxRWhjQXBEQ2FHYzU2?=
 =?utf-8?B?alZtQlBZT0E5ZGg0R25mN3JER0ZKVUxjcDF3SmJmcmd4SXhZRHJyTlRycGZD?=
 =?utf-8?B?OTBGcEluaGxwWkdyMlBkS2t3MGhEQzNzdEUwODluNy9KNFhIT2UrUGNvdnNr?=
 =?utf-8?B?NEN5Rjk5MGpzOHNxN3VmWjZzS05JaXAyNUV2QW9ZdThLNVNRNTlmRnJsT201?=
 =?utf-8?B?Z0ZGZDdDclRFNG10c2lqN2E3Ylo5dEVsSVhQUURFNUF2ZFduUlUxNHZjK0tC?=
 =?utf-8?B?WkxjQlNJdnNQVXhYS2pVQTFvdHA2anpNd0VTdVVDK2V2TmxFMzZ5OXV4OTZG?=
 =?utf-8?B?RjJiN1J0cW5zeVArMVg0OGo5ZjFkTFh5TGtYaW9meWdFejJiNWtJdk02M1h3?=
 =?utf-8?B?QndXN29xUTVaREFMNmZBM1JjOTdOYU1lbGsySU9MRUJscUNya1I1T29VTzBn?=
 =?utf-8?B?U0h2cUplN2lOaVVoNzJYU2k1SmxZS05UQ1A1UDNHNTJJQkdydk8xbGR0QmNT?=
 =?utf-8?B?eDFNUEVlQlhwcjB0U2U4aVFCVEVDQm82MTVUOGtWL3R3VVdsVEZES3ZUcDc3?=
 =?utf-8?B?ZVdTV3ZtcVNXQjhJbGo2eTg4Z1gyK2ZYeUdjY2FrTmV1NkZlOE5KdFVtQVps?=
 =?utf-8?B?cHVkMFIxZURTNGR2WVVvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD17A3829076FF4EA3288F2FF6856829@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3055.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d2eb5c-3bf6-48a5-cd7b-08d8e250ac83
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 16:38:59.1365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0WuNT8SczelbVUdbWNLeCaEWaFd7eLYZ2r3TDIexKPadRdZgQ8XItq3NQ0Kpz26gJ6TGcQ/HzOssrQKALhKEi4+AdR85XMxuL8yEFKY6Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTA4IGF0IDE3OjIyICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBIaSBBcm5kIGFuZCBPbG9mLA0KPiANCj4gVGhpcyBpcyBqdXN0IGEgcmVzZW5kIG9m
IHByZXZpb3VzIHBhdGNoLiBTaW5jZSBJIGRpZCBub3QgZ2V0IHJlcGxpZXMNCj4gZnJvbSBJbnRl
bCBtYWludGFpbmVycywgSSBhc3N1bWUgdGhpcyBjb3VsZCBnbyB2aWEgc29jIHRyZWUgZGlyZWN0
bHkuDQoNCkkgdGhpbmsgdGhlIHRvL2NjIGxpc3QgaXMgbWlzc2luZyBEaW5oLCB0aGUgc29jZnBn
YSBtYWludGFpbmVyOg0KRGluaCBOZ3V5ZW4gPGRpbmd1eWVuQGtlcm5lbC5vcmc+IA0KDQpJIGFs
cmVhZHkgYWNrZWQgdGhlIG9ubHkgcGF0Y2ggSSBjb3VsZCByZXZpZXcsIGkuZS46DQpkdC1iaW5k
aW5nczogYXJtOiBpbnRlbCxrZWVtYmF5OiBsaW1pdCB0aGUgZHRzY2hlbWEgdG8gcm9vdCBub2Rl
DQoNClJlZ2FyZHMsDQpEYW5pZWxlDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQo+IA0KPiANCj4gS3J6eXN6dG9mIEtvemxvd3NraSAoMTApOg0KPiAgIGR0LWJpbmRpbmdzOiBh
cm06IGludGVsLGtlZW1iYXk6IGxpbWl0IHRoZSBkdHNjaGVtYSB0byByb290IG5vZGUNCj4gICBh
cm02NDogZHRzOiBpbnRlbDogc29jZnBnYTogb3ZlcnJpZGUgY2xvY2tzIGJ5IGxhYmVsDQo+ICAg
YXJtNjQ6IGR0czogaW50ZWw6IHNvY2ZwZ2FfYWdpbGV4OiBtb3ZlIGNsb2NrcyBvdXQgb2Ygc29j
IG5vZGUNCj4gICBhcm02NDogZHRzOiBpbnRlbDogc29jZnBnYV9hZ2lsZXg6IG1vdmUgdGltZXIg
b3V0IG9mIHNvYyBub2RlDQo+ICAgYXJtNjQ6IGR0czogaW50ZWw6IHNvY2ZwZ2FfYWdpbGV4OiBy
ZW1vdmUgZGVmYXVsdCBzdGF0dXM9b2theQ0KPiAgIGFybTY0OiBkdHM6IGludGVsOiBzb2NmcGdh
X2FnaWxleDogbW92ZSB1c2JwaHkgb3V0IG9mIHNvYyBub2RlDQo+ICAgYXJtNjQ6IGR0czogaW50
ZWw6IHNvY2ZwZ2FfYWdpbGV4OiB1c2UgZGVmaW5lZCBmb3IgR0lDIGludGVycnVwdHMNCj4gICBh
cm02NDogZHRzOiBpbnRlbDogc29jZnBnYV9hZ2lsZXg6IGFsaWduIG5vZGUgbmFtZXMgd2l0aCBk
dHNjaGVtYQ0KPiAgIGFybTY0OiBkdHM6IGludGVsOiBzb2NmcGdhX2FnaWxleF9zb2NkazogYWxp
Z24gTEVEIG5vZGUgbmFtZXMgd2l0aA0KPiAgICAgZHRzY2hlbWENCj4gICBhcm02NDogZHRzOiBp
bnRlbDogc29jZnBnYV9hZ2lsZXhfc29jZGtfbmFuZDogYWxpZ24gTEVEIG5vZGUgbmFtZXMNCj4g
ICAgIHdpdGggZHRzY2hlbWENCj4gDQo+ICAuLi4vYmluZGluZ3MvYXJtL2ludGVsLGtlZW1iYXku
eWFtbCAgICAgICAgICAgfCAgIDIgKw0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9pbnRlbC9zb2Nm
cGdhX2FnaWxleC5kdHNpIHwgMjIyICsrKysrKysrKystLS0tDQo+IC0tLS0NCj4gIC4uLi9ib290
L2R0cy9pbnRlbC9zb2NmcGdhX2FnaWxleF9zb2Nkay5kdHMgICB8ICAxOCArLQ0KPiAgLi4uL2R0
cy9pbnRlbC9zb2NmcGdhX2FnaWxleF9zb2Nka19uYW5kLmR0cyAgIHwgIDE4ICstDQo+ICAuLi4v
Ym9vdC9kdHMvaW50ZWwvc29jZnBnYV9uNXhfc29jZGsuZHRzICAgICAgfCAgMTIgKy0NCj4gIDUg
ZmlsZXMgY2hhbmdlZCwgMTQ0IGluc2VydGlvbnMoKyksIDEyOCBkZWxldGlvbnMoLSkNCj4gDQo=
