Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29A242045E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 00:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhJCWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 18:40:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:22215 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhJCWkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 18:40:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="225558345"
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="225558345"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 15:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="566677036"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2021 15:38:31 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 3 Oct 2021 15:38:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 3 Oct 2021 15:38:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 3 Oct 2021 15:38:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7sr+OeXIqUZms7fN+UWe34ioYAeUnmKT+fADk/EVe1S3wxCz/pOoW8xLV8VHYThwKGGXRuMYqDbaPgZO1obWQ9uA1O3VkxScdx6/NB1PPASa7xw2vHVVLBOyGmN5I3oY/GbDQuNTbx3Z6bZWOE28pG1/hcTMVlDaQOm+Azb5tTu1XMuh9vY6U74M0QWVL6qfVtOh7gYd71fn1vBC3JYevAZlxzxLCOQlQCdyZr7zlhyV1W/YZpGoIyWu9xzR2Ypf3ZpBJnPWvfX0GdDsxxWmzO7C5qf+RMo+nHYnlIwCvIK1LZ6aiTUFDYRSkxN62dtDmrgRFXBhufnbEh6dOOUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XxcbDBuHVwQuIx3P6AtcZdtB31FMuzAlK7nM8obDN4=;
 b=JGQyxRF/gzgtF+xCjZpQb+dXk2Np5F9pocd6uiJ/R7m/Hb4c2gzsDscSRlLqEvk2KYQI2dR2N0hSldLao6FHXjx0QzksZjZdixmqkKdeQMDdrgKlzDKCa6ZURGk8hruRObwT3wZc0NFmYeXtTCxA8/0Kmuym79Ve0rnVxB+zcFfnW7N+aZcgXdDIifQyQ0Dp5NA+96stBifT0kENuijr1aZzUVi0REGszf58I6kOm+90h7B2oq0sUCeHiQyFNzYu8EbsSgjVFgaSrS1nW+SqK2kjdTAs55dLVAxGvEE9FQ+BQHCAE8QdhfKMmQJ2GW6538WToMZfUALQtVPFd6oBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XxcbDBuHVwQuIx3P6AtcZdtB31FMuzAlK7nM8obDN4=;
 b=K4bKTlMoCr9R8XCAxunjn+Yr3/w+9p8oGc07W/hMObZ7VeS/kYavR2qConZMsNLemaBS8+FbWQv/+0sz38tllggSIy0HVjVTBzNG3JDErKQ8gTavCt9W2H1F8KzNRBp1AS4VEL6yUZzmze/biJjdjwaRNIbanD/h62WgBuNqOgQ=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Sun, 3 Oct
 2021 22:38:29 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.022; Sun, 3 Oct 2021
 22:38:29 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 13/28] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Topic: [PATCH v10 13/28] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Index: AQHXmcpyp/UMng9jvEuWIVdsREnfcKu+dzeAgAACHYCAA6HZAA==
Date:   Sun, 3 Oct 2021 22:38:29 +0000
Message-ID: <E5C66E6E-8AB8-4258-814D-C8E94446E2C4@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-14-chang.seok.bae@intel.com> <871r546b52.ffs@tglx>
 <87wnmw4w80.ffs@tglx>
In-Reply-To: <87wnmw4w80.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 111b8585-00b7-4760-466f-08d986be859e
x-ms-traffictypediagnostic: PH0PR11MB4821:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB48210E56C4C906DE32852C97D8AD9@PH0PR11MB4821.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 53vdNk6pG8TINVup1aCBa6lvMhGL0U13CZZaCB+5/9nRqGSUoQV3ReRQj2ayE/VYNgu3h2jSIGkQWq9B6GzPVBUZCzc1Dst/QpH1YBi2xYcvZLvulCuICh2ium0UiaQrGOiigTzwNEm2No/jUHMoOmx8swDRt1ZyGOyqFegwlREGR4JlIVcH4jM9yKkCc+3+fPfvw952hJUW9ykIYx7leOC9p0zTy7gwi8GIFLhn+I2InQG7ZH3eIatCK1bN/wF1n24nJ9FGWrXzN1cs7upPI8/x8CsW+60Wlj6FwTldL4v4UVG11sIh8xY7alLhrxJuH32PN3Xk8OBWy14tjap3/FYaaPEMKqz30ageJ7+MBsojeNgPaiIcvpWfZ4bPyvhV0ypCnOSyp6XdCTts+ADqFTuhuDmDtU8DS5dm8fSgbYA7O/FwUuQRBUPVmCebuX1xdhrJWI9NOWvp0LqOUdgswHt5Jt5eo1fRy5w5fllM1FcerICichQVX3P8uxXckSRhPubJ0ZD6jX6nUxjtc8A8mZHURNcpqkVqCr5bPrTfzZy3Av/qDTxviA9h1lsP4DIhK3xgUW8kmoz0873QfNR+K4HBqOcNVwFPuxN/Tq9CRBxpPZ+8acHfiOx9Bj21lYimxMx/IOl1Swu9EO4k5lFJqoTRAo960OjJS5Kq7PTp2Cgcu9lT2aDViQ4xI4PYTxHbcFEZK3bF7N9PHEb4kZ9+YLem1XyzOfCL2glnTJuK3v12D927rFtSxQ0m6s5LIBvSVmZ/CknypDPBsMZcojLutHWKeDUoxo66/I0zUCujIkx7VgPVkSuBRcV3L2YoyIEUcFm5I6Mevsi4KVKJTlrLLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6916009)(33656002)(2906002)(4326008)(5660300002)(76116006)(66946007)(66446008)(64756008)(66556008)(86362001)(83380400001)(66476007)(8676002)(966005)(71200400001)(2616005)(186003)(6486002)(316002)(508600001)(6506007)(53546011)(122000001)(36756003)(6512007)(26005)(38070700005)(38100700002)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXVtRlp4NnM3WWl1bXhjalpBYjF3ZEMrYkgwY1p6cHYvRkpsWVRtdXdnVkJE?=
 =?utf-8?B?U2dPUzdLSStGRXU3TmNpU2xkemw5clhObnZQTStBNmJRR0NsMXc1MnQ3MFRD?=
 =?utf-8?B?a2RhNnd1Ri81WmJRUjhCWW5McUo3Q2JpRXhqblZSS2tuZ2NUVUhpSjNOK2tK?=
 =?utf-8?B?Vnh4aUtXcEswZXpUTlliZ0gxc2c5d3ZDdnJOeUVoYWdRcmVBdGhyeHl6Q1Iw?=
 =?utf-8?B?a01jV2pJQlZMV0FsN1c5eHVtTzA0L24rMHhCZlA5Rmw5WWtiY2xlZGRkL2pO?=
 =?utf-8?B?by9Rc1lGZDRmTUtQSkt0TnNFKzhUcEdpODUwWS83V29ORjdBMUE0SXRCbW1V?=
 =?utf-8?B?Ukx4V0RaYy9oS1UrR01rK1ZUbzJ1ODdEUHBFazNhN2tRdUFCWjFYWVB2alhq?=
 =?utf-8?B?WnBockFWWE5JSDljY2o4dWpOODRFWHc1T3RQWUZrUUpCY0g1dHNvMVhudzZL?=
 =?utf-8?B?clE0ODVMUytsanVwZWwzQTY5ODFYMnk4dEFVTUpwbmpFMTFXUUxTcnRFYm85?=
 =?utf-8?B?VzJ1RU5GVFlWaTN5MzhLMTI3QVJ1cFZBSW8vTXNvZHBVUkJ0TGV0UENmZXFn?=
 =?utf-8?B?YlVPcDNtZWd3azRqZXl5L2Q3Y2ZIMHMzSHBjNzRnWllEbUVFZW5DV3czMldi?=
 =?utf-8?B?TzZlSGJxZVBYQVBOdmdaVHJjeElDMk5RUUZkbzZkVW4rWjVuZW1KVG5aYXRw?=
 =?utf-8?B?Q0F3cTlYMmhXL1R5TEY0aWFIejJtY0JYdWh2TXZPMndIczcyWTc3aWhWbys3?=
 =?utf-8?B?R3VMaDd4VU9WQ1BBb1AydmZHQ1ZSNWgrVkxzaEx0RjVZV0M3RTQ0M2ordWVX?=
 =?utf-8?B?bVVmYXkxejFya2ZTWEJzeVVGQ3RUVm5SeGROUURzWHdDa0tqS0RsQ3pSaHRV?=
 =?utf-8?B?OWs0Tzh6SEQ4R0c5eXUrUnFxL0xvdkpQc2xtYk9TRiszaXYrUjVId3VISUdL?=
 =?utf-8?B?dGdKcTVVaTlKbS9rLzJSbEVoT0h4ZUhRelpva2Y3NzlxU2FFREJsZ2lYNWpJ?=
 =?utf-8?B?OUxUOVVvTmc4RjlsTkdnQzhhcVFOakVVV1ZDVWt3cERjTm05aXluczh3Ui9o?=
 =?utf-8?B?STViaTlMSjJzSTJIanE4NW5NcWlta1hSVEdoa0FVdnltYkRyMkhNMWoyVmIr?=
 =?utf-8?B?NWM1dUJhcDFnczd0N0tSUXdrYzFVcXhyL082eE5pVUtpZE0yajMydG9GR1lk?=
 =?utf-8?B?N0llN0s5MWh0aEUyOWowTEErR0hsMUpxTGxYK2YwMmloRHkybUlQanZORDlS?=
 =?utf-8?B?OUFXd1cvK3FuU213ZWVYVFJGK29DZ0ovVm9VdGROOHVvR1pQVlB1bHVodlZL?=
 =?utf-8?B?Rk5XRUEvNzZTcGk5MXJ6SC96NFUybHF2M2pDS2dveEhOUk5aa0hTbjBtbkdm?=
 =?utf-8?B?WWNqMHBJKyt5QmptbUlnTEE3Ym9wb2paTFlZMmoyY2RrWnZEdGFMS3lQQkJF?=
 =?utf-8?B?K3AvRnJnYW5iVEhwcm1GLzY4YmxROXZOV1VkRXY2eEE2TS9oWkFpNml4YlRD?=
 =?utf-8?B?T0V6UHRwcStQY0Z3S2ZkeDFGNHF2OU1GdjF6NGh3RTdaWFNpUXJwcHJGWWRI?=
 =?utf-8?B?MlpiKzFIbVF0ZkREK1drMHRlZTQ0UEY0ei9PbGxWTjNXUmxnVUhudklPNXlR?=
 =?utf-8?B?WVlQd1lzcjRTcmpNNU00ankzN253bXhrK0gycGNVQUZrNVBVKy9VUEo4Y1I4?=
 =?utf-8?B?a1FOL010cFU3bjRGMkcvNDdwZHBQMWZFQURFWDJpd1N5VmllVGcrRW04SDkr?=
 =?utf-8?Q?EmWjj92m30WIEXMyfbYqamDxuhr7XU1dr++FFG/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FE6F852BE5A504F9CE00141F9924C1C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111b8585-00b7-4760-466f-08d986be859e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2021 22:38:29.1444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eA4C0GA61ItYoYgyHLtN50k6K9meLNm9gwtXpcDZ7eERyMOf7bhGSFN7khp+47EbXK7jFSMT99GjkU1bH8/rUMxyDW96yucdtpJlNv9iaRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gT2N0IDEsIDIwMjEsIGF0IDA4OjEwLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4gd3JvdGU6DQo+IE9uIEZyaSwgT2N0IDAxIDIwMjEgYXQgMTc6MDIsIFRob21hcyBHbGVp
eG5lciB3cm90ZToNCj4+IE9uIFdlZCwgQXVnIDI1IDIwMjEgYXQgMDg6NTMsIENoYW5nIFMuIEJh
ZSB3cm90ZToNCj4+PiBERUZJTkVfSURURU5UUlkoZXhjX2RldmljZV9ub3RfYXZhaWxhYmxlKQ0K
Pj4+IHsNCj4+PiAJdW5zaWduZWQgbG9uZyBjcjAgPSByZWFkX2NyMCgpOw0KPj4gDQo+Pj4gKwlp
ZiAoaGFuZGxlX3hmZF9ldmVudCgmY3VycmVudC0+dGhyZWFkLmZwdSwgcmVncykpDQo+Pj4gKwkJ
cmV0dXJuOw0KPj4gDQo+PiBBcyBJIHNhaWQgYmVmb3JlLCB0aGlzIGlzIHdyb25nIGJlY2F1c2Ug
YXQgdGhhdCBwb2ludCBpbnRlcnJ1cHRzIGFyZSBkaXNhYmxlZC4NCj4gDQo+IFNvIHlvdSB3YW50
IHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiBzdGF0aWMgYm9vbCBoYW5kbGVfeGZkX2V2ZW50
KHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiB7DQo+IAl1NjQgeGZkX2VyciwgeGZkX2V2ZW50LCB4
ZmQsIG1hc2s7DQo+IAlzdHJ1Y3QgZnB1ICpmcHU7DQo+IA0KPiAJaWYgKCFjcHVfZmVhdHVyZV9l
bmFibGVkKFg4Nl9GRUFUVVJFX1hGRCkpDQo+IAkJcmV0dXJuIGZhbHNlOw0KPiANCj4gCXJkbXNy
bF9zYWZlKE1TUl9JQTMyX1hGRF9FUlIsICZ4ZmRfZXJyKTsNCj4gCWlmICgheGZkX2VycikNCj4g
CQlyZXR1cm4gZmFsc2U7DQo+IA0KPiAJd3Jtc3JsX3NhZmUoTVNSX0lBMzJfWEZEX0VSUiwgMCk7
DQo+IA0KPiAJeGZkX2V2ZW50ID0geGZkX2VyciAmIHhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1p
YzsNCj4gDQo+IAkvKiBEaWUgaWYgYSBub24taGFuZGxlZCBmZWF0dXJlIHJhaXNlZCB0aGUgZXhj
ZXB0aW9uICovDQo+IAlpZiAoV0FSTl9PTigheGZkX2V2ZW50KSkNCj4gCQlyZXR1cm4gdHJ1ZTsN
Cj4gDQo+IAkvKiBEaWUgaWYgdGhhdCBoYXBwZW5zIGluIGtlcm5lbCBzcGFjZSAqLw0KPiAJaWYg
KFdBUk5fT04oIXVzZXJfbW9kZShyZWdzKSkpDQo+IAkJcmV0dXJuIGZhbHNlOw0KPiANCj4gCWxv
Y2FsX2lycV9lbmFibGUoKTsNCg0KdjEgaGFkIHNvbWUgc2ltaWxhciBvbmVzIChub3QgdGhlIHNh
bWUgdGhvdWdoKSBbMV0uIEZXSVcsIEkgdGhpbmsgQW5keeKAmXMgcG9pbnQNCmlzIHdvcnRoIHRv
IGJlIG5vdGVkIGhlcmU6DQoNCiAgICBGaXJzdCwgeW91IGNhbid0IGp1c3QgZW5hYmxlIElSUXMg
aGVyZS4gSWYgSVJRcyBhcmUgb2ZmLCB0aGV5J3JlIG9mZiBmb3IgYQ0KICAgIHJlYXNvbi4gU2Vj
b25kbHksIGlmIHRoZXkncmUgKm9uKiwgeW91IGp1c3QgZm9yZ290IHRoYXQgZmFjdC4NCg0KPiAJ
LyogTWFrZSBzdXJlIHRoYXQgZHluYW1pYyBidWZmZXIgZXhwYW5zaW9uIGlzIHBlcm1pdHRlZC4g
Ki8NCj4gCWlmIChkeW5hbWljX3N0YXRlX3Blcm1pdHRlZChjdXJyZW50LCB4ZmRfZXZlbnQpICYm
DQo+IAkgICAgIXJlYWxsb2NfeHN0YXRlX2J1ZmZlcihjdXJyZW50LCB4ZmRfZXZlbnQpKSB7DQo+
IAkJbWFzayA9IHhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1pYzsNCj4gICAgICAgICAgICAgICAg
ZnB1ID0gJmN1cnJlbnQtPnRocmVhZC5mcHU7DQo+IAkJeGZkX3dyaXRlKChmcHUtPnN0YXRlX21h
c2sgJiBtYXNrKSBeIG1hc2spOw0KPiAJfSBlbHNlIHsNCj4gCQlmb3JjZV9zaWdfZmF1bHQoU0lH
SUxMLCBJTExfSUxMT1BDLCBlcnJvcl9nZXRfdHJhcF9hZGRyKHJlZ3MpKTsNCj4gCX0NCj4gDQo+
IAlsb2NhbF9pcnFfZGlzYWJsZSgpOw0KPiAJcmV0dXJuIHRydWU7DQo+IH0NCj4gDQo+IEFsb25n
IHdpdGggYSBjb3JyZWN0IGltcGxlbWVudGF0aW9uIG9mIHJlYWxsb2NfeHN0YXRlX2J1ZmZlcigp
Lg0KDQpUaGFua3MsDQpDaGFuZw0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9D
QUxDRVRyV2pPWWQ0d00wTW43ZlkrdDR6dFU5OUdOUDc3QTZza053alRWaUpZVUVaWVFAbWFpbC5n
bWFpbC5jb20vDQoNCg==
