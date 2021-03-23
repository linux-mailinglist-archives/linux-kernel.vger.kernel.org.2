Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A369C346B64
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhCWVwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:52:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:61688 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233684AbhCWVwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:52:17 -0400
IronPort-SDR: BHaeqH9s7LEtaewPhIA+RwKC1Ggvm/DBpSqzv+Ysx39TpsaWzOOXUhP5cwlyD0F95v5pD8w82U
 /O1dTRaWvEUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="275672906"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="275672906"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 14:52:16 -0700
IronPort-SDR: 7GvNhakLv+e51DEPXFDIk0heaxeLVhC0CmOfCe+/NjUtt6KwvHkjzL+1jwPd+gEgY+GjFWyl7e
 /DZMp8Z/HvXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="593145509"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2021 14:52:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 14:52:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Mar 2021 14:52:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Mar 2021 14:52:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny3o9tfFBqfh6zoqVMUQykY39zqWdIEofH9Ypd98lgW3UQ3sX257Mvw4o9t67VAmWCaScRbtduxU5uVfop3L6XvXRb8JpDnxwM7+zb8UvyIUrHpbr1N94AvkVpzs87Z+TZYHqxPaMZFuXaEC1aJ1BlXLH1aV+DwIhT/66QbhaLr6TXIzKTzUh/hsXIW0tOukAdT0L+ugmtg+TBuJxAKNe6AOH8v81i7XHFjDwIFiCzSvVRBc2AypaRl2HOUxN/EJaup/kj6NyUVPcZ4AtOyviXG5Rj5JNnbqEFu4k4zNZR/KZgQ20FjlD/Ve7dz/KHK5Fl0UH+ePpczzN/CD2UB+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmztBolj8YMvS/Bxuh4VpfPyQ0i2X8aXwbIrevci8FM=;
 b=f3SOhXdsEwkcdVphRNipE3tKMlCeU+o5Bs4kgHArdvL1g6nOb9s9I0YLCIgw8VAUnOZjC3HaCMa8CDLJ9biBcGy8OaTa1FZBcaZgZCspJ/LRNeSFN/0tQHkQNPUSHdX7qFvOyrSJGFZa2QH0p5vdZ7iQD7NhLYck+CEfshaw3KTBRM1DslK+BJQk8YMNVcTnwx/zhj1K7oOkVpzbaADBoedpzlExUeZndvIcQ8OQnTAf9FisCFAJaYgC4WqHJGKQwDCqm9pue+Ba7RMWqhq8OMEjc42UxS58BXa9DWrt84C0mWb1GdF72Bs5XO14HpIkjs/J+2CcqjAdYQYZi/o4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmztBolj8YMvS/Bxuh4VpfPyQ0i2X8aXwbIrevci8FM=;
 b=GLnyp6B8/1LP1g+gLmWuW5MgeNb3ZKLLMc2Kj+BkF0ry5g49VkpwxUi2K3ItKrNscs8jslkgPBBq4hloRggYhBuOiik5w20CQSQf9cIfKfspAwXbzPRVL4V78QWCkTWoqUc3n3X7GT6TSHfkBSnbu+rwO4N1xu6F+mS6T2Ckk7Y=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 23 Mar
 2021 21:52:14 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 21:52:14 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "bp@suse.de" <bp@suse.de>, "luto@kernel.org" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 16/22] x86/fpu/xstate: Extend the table to map state
 components with features
Thread-Topic: [PATCH v4 16/22] x86/fpu/xstate: Extend the table to map state
 components with features
Thread-Index: AQHXCIQSdk5yN145nEqzPvFy3N5YcaqNjfCAgAS+mIA=
Date:   Tue, 23 Mar 2021 21:52:14 +0000
Message-ID: <06BA5599-2077-4DE4-8E2A-74BD222C7CDD@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-17-chang.seok.bae@intel.com>
 <87y2eha576.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87y2eha576.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6a42a30-44ed-4847-71b7-08d8ee45eb8c
x-ms-traffictypediagnostic: PH0PR11MB5046:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5046B6729E821FB4A376F1A9D8649@PH0PR11MB5046.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4iWR+YneeKzl6fwvQDHa5wN2IW8qvXwxSgWXH+AsE6tczHu+g7LolKKsSW2udJG9MP281rQ9ZpI3U4OJLy+spNIiiDEAVvXMb+emBRzZ4VCNGXAg5+MxYWjz/Nus6XAtFJMjFCYjSTi7cubdO6ufwFb/k2eRH+bIGwnH5r/uE5lIodYDmu4FX48pjKU0TDKzMjOvRWS1iSg4qIJXTGFtuhaXW8NRb7N1cQ0ObHHbu5stPT74cFW2jwlxdtQG9H7+e0OglLaTSFlqv/xCe94Z6WDTcCILyCjy5Rvuv7A3Ud4HLeyV+xZCQ9l5aHYAkjPg6nQhbydAaRtqy79H5b+r4u6h3j8rLQcuJ8D+iH47Bvi1gDmC55SdpElhKZyfwAH0r/AOFUEvLBEHNANucQgIf9p6VITYMH0pmMKv3ef/lsbZQTfTNJSkl8Fwao6ETyyGBwmzGMyKfzxTBxmvdWkP785y6/oxFQm5fTFB3iRahiaBsEb2gJdeQVZWJK/3lS3ilWey1hI2fevy2YgeoD/9VmD2djpTbUhtmC13L87WFekQxB64V7pffKHVBIEIkBfS0ZIHchLhcl16kYgBT8qn6dBHDiTxnpgxoRQ62sa/eYu2FsNxMIBRccUBbStTl8wkEwaZSs9RkR42tbYnklxdBDxQ1dGgaETOp39fZn/e8Q6LAev50ElQ1Fl1nBAjsv0z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(366004)(39860400002)(6512007)(66446008)(64756008)(2906002)(66946007)(76116006)(33656002)(66476007)(86362001)(54906003)(66556008)(316002)(26005)(8676002)(53546011)(6506007)(186003)(478600001)(6916009)(38100700001)(71200400001)(4326008)(2616005)(6486002)(5660300002)(36756003)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WlRreWlPNW5qYkVFSUYvckM3RjFrbFl0RDQ0OUdncmJjOHF3OFpzQ3RDOXR2?=
 =?utf-8?B?aTc0cUI1bGtBcUJlSUhWMytxdElTRG1EN1BUUDVtOXZRejBFME01WXJmT3Vk?=
 =?utf-8?B?OEo5VkhYdE5hcWg5eU5WMkJ3WmFuS3J1anZBZ2RDbTljOGl0dkd4UUlZUkRF?=
 =?utf-8?B?ZW5laThPK2xFRk80dWV3K3RWN09SaS9RRlQ5SG4xU3ZNR3hDZnFibG50cFFY?=
 =?utf-8?B?M2ZpRXlXdDJaZ2prZWRkME5BNWZuM1c4aEVsdGlvSk8zckZCN1NBNmI1aGxY?=
 =?utf-8?B?T1Z1bTZYcTJSWndXWGJNOTRrRU56MVNDQms5cTE3bDM3aGp5dzV6b0F5dzZn?=
 =?utf-8?B?ejJGTFpGdkJnY1hGWjcvMW81MGFGTHc1U3F3TlM1NHRtSUN0MUZuVEVWVVZP?=
 =?utf-8?B?Z1IzZkRyYmNsVzdpcUJXWDFYSGdpN1hDWm9SdEFoaW1FM0YwMkpKS05HcnFr?=
 =?utf-8?B?UUVlc05rK3JTaUx6UWRLVnVUT0RhSGJCTHRQUzZQNHdxRTR6N1BnWFZab3Zr?=
 =?utf-8?B?MFI4ZjJiQUdqTlZ3cElVbDhVanVlUjlnQ1pBMGFESi9tZStKVDFRaUJTb2ZB?=
 =?utf-8?B?aU5WZC8vU08vWC96K0ZNK01KNnkzbWRNK24vcVBHN2dnbWg5S0N4Y2pkVVpS?=
 =?utf-8?B?eXJObmZtM3RPaHIwcEI1MUxoQVc2YW9aSDFXUWhML2JWRzZzdjZiTDA2b3dC?=
 =?utf-8?B?OXN1UlRLRloxcVJwN2FiWG9jamRyak5BWjFQTm9abjFDdWVFTWFrQW4reC83?=
 =?utf-8?B?TlBJSnlmTWZ1WEk0ZFo4YXZ3NVJDUTJ0cGZMR0d6bFljbmJBbGc1OUxrZ25C?=
 =?utf-8?B?Um84VkZCUXhQMCtPcTlUWDBiTGM4TDl1U1BSaGVuTkM5SmdEa05MaTlpRzVi?=
 =?utf-8?B?cFBONGZ1aHhXZEhFNTA1UnArQXoxYXZCdmgzNm16YUt3RWsxc1Q3YmF4cTVV?=
 =?utf-8?B?VTk4aS9kY1daSU1yNDdacVFFZnJYM0lvbGhUcGVzRWtwdGh2Tmk0bm1TYUN5?=
 =?utf-8?B?Q0xiaTNHUWdjYUxXc2NveE1maUVBcUw1enh5eWFpeE8wMHBSd1FOVDFXWWxF?=
 =?utf-8?B?cWZWbFhWMG9VV3E4NWNIUVgwL0hXMG5RR2svVlBtanpOVGJSWGdXM2JnK21C?=
 =?utf-8?B?SXZGVzZnR205RHhqQUJPaFhSL0F3azY2QzBBYjMxVk9XMG1KUE51azZFM2ZC?=
 =?utf-8?B?VXI5ZklwTmVWeVVXaUVIeDRMVk1SMGl5bUdjL09TWnBCR2ZtWVNCTTIzODhr?=
 =?utf-8?B?THpHRlk2SkhIaDJ1NUVWR2gvZW45WGpaaE9oaXMrZ1hNOVY1SC9zeEh6RDEy?=
 =?utf-8?B?K0QySXhjUTRDUElFWUgxZXUrYVcrMFFVT3A2ekhuWEl3emxzUXdUOC85dFFQ?=
 =?utf-8?B?MzAzbFlzNXU5dzJNdWg0aFpNN1lpT09GMndKdUFyZWFWNFNBNUNodFE2TnFa?=
 =?utf-8?B?VUc2ZDdXUFRHaE9McytTMDZXSkI4VS9yTlRmKzRnRXZCeThiV2dyeW5BQVhT?=
 =?utf-8?B?bFlDWDdKRDc2YThSNVdLdWgwa1QwWlNaQ1Fkb2Vta2pxSlVreFIzOVQ3amdO?=
 =?utf-8?B?V1ZHL3JFcUZPam9QWU5FRmlKMmZqQ0RPR1kzWXgwYUJFZlJmUVhsenFBd2ZQ?=
 =?utf-8?B?ZzdrWmF1U0N5UjV4RXY1cE1TbFFYcnZ5SnF0QkFjUFpZaDNuNDA5b0ZPMm5H?=
 =?utf-8?B?ZU52NWtySU9RUXdDQ211SDc0VjNaWkt4cmdJY1JueHBJdWtsSWRrbFU0WU9L?=
 =?utf-8?B?VjFXYXlQM3lUNjNocEgreUFHcEo1V3ZXdDc3TjlydWpoZlp3UjAwdEdxOEly?=
 =?utf-8?B?ejk4cmc1K1FDU1hwUnJudz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <899008644B2A384984D13D78F9A60A03@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a42a30-44ed-4847-71b7-08d8ee45eb8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 21:52:14.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2q0kr2sndWoQUaJjFXNmdCQXGkZkgKhTWI61Yz3fcdmJbJ1UAdHNJAskIG1ufYaXkFjXbD/AIyyd/eOxF53n9/BQEp9vJdv8t9zi8mroBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWFyIDIwLCAyMDIxLCBhdCAxNDoyNSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+IHdyb3RlOg0KPiANCj4gQW5kIHlvdSBjb3VsZCBoYXZlIGNoYW5nZWQgdGhlIGV4aXN0
aW5nIHRhYmxlIGp1c3Qgc286DQo+IA0KPiBzdGF0aWMgdW5zaWduZWQgc2hvcnQgeHNhdmVfY3B1
aWRfZmVhdHVyZXNbXSBfX2luaXRkYXRhID0gew0KPiAJW1hGRUFUVVJFX0ZQXSAgICAgICAgICAg
ICAgICAgICAgICAgICAgPSBYODZfRkVBVFVSRV9GUFUsDQo+IAlbWEZFQVRVUkVfU1NFXSAgICAg
ICAgICAgICAgICAgICAgICAgICA9IFg4Nl9GRUFUVVJFX1hNTSwNCj4gCVtYRkVBVFVSRV9ZTU1d
ICAgICAgICAgICAgICAgICAgICAgICAgID0gWDg2X0ZFQVRVUkVfQVZYLA0KPiAJW1hGRUFUVVJF
X0JORFJFR1NdICAgICAgICAgICAgICAgICAgICAgPSBYODZfRkVBVFVSRV9NUFgsDQo+IAlbWEZF
QVRVUkVfQk5EQ1NSXSAgICAgICAgICAgICAgICAgICAgICA9IFg4Nl9GRUFUVVJFX01QWCwNCj4g
CVtYRkVBVFVSRV9PUE1BU0tdICAgICAgICAgICAgICAgICAgICAgID0gWDg2X0ZFQVRVUkVfQVZY
NTEyRiwNCj4gCVtYRkVBVFVSRV9aTU1fSGkyNTZdICAgICAgICAgICAgICAgICAgID0gWDg2X0ZF
QVRVUkVfQVZYNTEyRiwNCj4gCVtYRkVBVFVSRV9IaTE2X1pNTV0gICAgICAgICAgICAgICAgICAg
ID0gWDg2X0ZFQVRVUkVfQVZYNTEyRiwNCj4gCVtYRkVBVFVSRV9QVF9VTklNUExFTUVOVEVEX1NP
X0ZBUl0gICAgID0gWDg2X0ZFQVRVUkVfSU5URUxfUFQsDQo+IAlbWEZFQVRVUkVfUEtSVV0gICAg
ICAgICAgICAgICAgICAgICAgICA9IFg4Nl9GRUFUVVJFX1BLVSwNCj4gCVtYRkVBVFVSRV9QQVNJ
RF0gICAgICAgICAgICAgICAgICAgICAgID0gWDg2X0ZFQVRVUkVfRU5RQ01ELA0KPiB9Ow0KPiAN
Cj4gYW5kIHRoZSBpbXBsZW1lbnRhdGlvbiB0bzogICAgICAgICAgICANCj4gDQo+ICAgICAgICBm
b3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh4c2F2ZV9jcHVpZF9mZWF0dXJlcyk7IGkrKykgew0K
PiAtCQlpZiAoeHNhdmVfY3B1aWRfZmVhdHVyZXNbaV0gfHwgIWJvb3RfY3B1X2hhcyh4c2F2ZV9j
cHVpZF9mZWF0dXJlc1tpXSkpDQo+ICsJCWlmICh4c2F2ZV9jcHVpZF9mZWF0dXJlc1tpXSB8fCAh
Ym9vdF9jcHVfaGFzKHhzYXZlX2NwdWlkX2ZlYXR1cmVzW2ldKSkNCj4gICAgICAgICAgICAgICAg
CXhmZWF0dXJlc19tYXNrX2FsbCAmPSB+QklUX1VMTChpKTsNCj4gDQo+IEV2ZW4gd2l0aCB0aGUg
Z2FwcyBmb3IgWFRJTEUgdGhlIHRhYmxlIGlzIHNtYWxsZXIsIHRoZSBjb2RlIGlzIHNpbXBsZXLi
gKYNCg0KVHJ1ZSwgSSB3aWxsIGZvbGxvdyB5b3VyIHN1Z2dlc3Rpb24uIE1heWJlIGZvbGxvdy11
cCB3aXRoIGEgbmV3IHBhdGNoIGJlZm9yZQ0KcG9zdGluZyB2NS4NCg0KVGhhbmsgeW91IGZvciB0
aGUgc3VnZ2VzdGlvbi4NCg0KQ2hhbmcNCg0K
