Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE083EA8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 18:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhHLQtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 12:49:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:25392 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233101AbhHLQtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:49:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215387095"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="215387095"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 09:49:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="422596234"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 12 Aug 2021 09:49:15 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 12 Aug 2021 09:49:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 12 Aug 2021 09:49:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 12 Aug 2021 09:49:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP45sW6HcZgxMOSme0yRikOrTM0u7qrag437H+LpH6rc9JSRxyPFsqPxUmthQNN9hf6Qmqw6DtLEA4t7bNzGdn+0jB0nI3bpgThMTaEBDa7evXQ/BsMka5a+O5gqd6JUt2BZKH7YOOzJ2APRMX/svF62fSiZ7WkWT9xQMnqSkPTRoLbZ/MeFi3bhhHZ7tCwMUKSIGsr7TRsl4rawVrPlT7HiuRQ7ol1cbHyTCbboTOQne1bNjvvrSaFFeeWTw9G7kks68Cnsq4+einubaNzOQGgAtpx7DYhWktkb6aEbaUEghxNuAXbbQ8P5axGdGTonpYn4ghsHCsioX3/0V22pRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gE8HY9grlI9DYnSPqU3odSSmQHfLFoXYfETT9uMfLk=;
 b=hN62d8iDqY5kjN1+rdNEmi044SvfhTSi8e+05RwG8kTZ3wNqQbpBBdtwxQ1G2ukthCd1bMGyOgDLAzt9obGwyfZxgedaxt9hd2TTtlN5YmME3lb0Yg9UfGV8OaHdNhyAmReWCGOiSnhj4vJAgSCGkqDqfRyMbGDtrLdwG8TLAF8eRv7Bjmzst0FLxmVK+C7DFGzk5Y6tIytNn7Y4teMPMQpSHQO2BVRuYU38AUek1bwo6DZkBuifMLuFCsuSkKdPVUx3dsVazOJZhnmWiCDw35nzhuUr0pJnSPLNhsu83B/Sk77j39lgA5AENYDny/wuFR2uCcusARvKMGqhmmseww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gE8HY9grlI9DYnSPqU3odSSmQHfLFoXYfETT9uMfLk=;
 b=FoLCVd6IaElUFG8fTgtdmilXxuRefsxDwq6vMN43DFsXw2/m1CQe6hZmdo+jmPa5yUnm7ciQWS2hSR6J1mbpmpe9DYbCID/690QV/gdAiIXCQ5y0VsepjiYUTM9KNLK4hfD43e3bzzNOuqXa75w3qyIa4WfP7gcYx+TAcGCJOOc=
Received: from BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27)
 by BYAPR11MB3176.namprd11.prod.outlook.com (2603:10b6:a03:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 12 Aug
 2021 16:49:13 +0000
Received: from BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4]) by BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4%5]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 16:49:13 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v5 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Topic: [PATCH v5 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Index: AQHXhDwnISnVoEGfdkW14/liUG7Tv6tg1zUAgAH+PcCAACl8AIANLFFQ
Date:   Thu, 12 Aug 2021 16:49:13 +0000
Message-ID: <BYAPR11MB3128F143273F060C33DCA9C8F1F99@BYAPR11MB3128.namprd11.prod.outlook.com>
References: <20210729053937.20281-1-shruthi.sanil@intel.com>
 <20210729053937.20281-2-shruthi.sanil@intel.com>
 <YQh1HMMkJyO8g/RP@robh.at.kernel.org>
 <BYAPR11MB31281638EBA0C2B815DF56F9F1F19@BYAPR11MB3128.namprd11.prod.outlook.com>
 <CAHp75VeAnm-9oy5BinY8DU5tRj0EhU_vVxkvcp0M+wXPSv8Wdw@mail.gmail.com>
In-Reply-To: <CAHp75VeAnm-9oy5BinY8DU5tRj0EhU_vVxkvcp0M+wXPSv8Wdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e96183a-4801-401e-c6ae-08d95db11d65
x-ms-traffictypediagnostic: BYAPR11MB3176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB317632842C97D1E5BE5818AAF1F99@BYAPR11MB3176.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MpzGBQBH0kWWKdGEo4zFQ7iOIe63ezIFaQ4JJPCzzS5oCuNsg4lTOuFtANybMiSDu4jnLjiYSAThq9AdnAxQNfxzjCMZ/67PNJWDu4HEhfCUGlsOFfaECkTku9ftat/ioB0p3np+ikAxd57KkHhv7krmHpRFDuoiz9fSZ0ZHwmxFj7ianw7dZWD4m8xrHn0XPs/RrDNU6haeo1HWY2lYmxGSq3VEfEDS+1uzqMGOYT0wOtFzvZQaoLS6YHTHXcNHOCWCKg/FRDoGbWJADLKDQYASJ4Jt0yWJKVWNgwB96F50k3uoqHCXpWyAF1s5aEU+7rMpn+RLJVn6aPy6yULDkAdgZKcaYFJ9Gs2oCoLL8AQfesEKWrFVg8olND6sIreCtRAue5vwZBxX461QfqVPGeTFPdQfhmrm8o+5cmxYjfzEK6o58R6CBYNRxCmpWBy7UaQ/Xs2md/YzCbbktZDy8mGD2m9t8C1Zivf9iYjOQDgWU6xAkaTnvmuNJ1gBAk9HtBUwSJyh9wap6/ia2fFe5r8mFjLFczaZljplxgo7ORb0Dv67YHB4SW+jqj5pFHbUpygCNTUkWw7Nhgt10gQWQwwBR9v3nVduYNbn8GVliPv9V/CV0xP/JUEkHJNW8r1IZExgoiI1HPu2cEgPWLugYXB2srnUWNJM9wQ8hTNbWXaUyZO9IxEQwLLw8VBisG4Ru7ETzDKexsmkQTqRNCb90w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3128.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(478600001)(316002)(83380400001)(8676002)(33656002)(86362001)(186003)(6916009)(2906002)(52536014)(54906003)(66946007)(9686003)(26005)(6506007)(53546011)(4326008)(38070700005)(7696005)(8936002)(122000001)(76116006)(66476007)(5660300002)(66446008)(38100700002)(66556008)(55016002)(64756008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1JxK1VQVDQyTy9rdm52bVlBZ0VLVWc0b0MxOGRjbFhXYlpkaW1pL2tpVk1N?=
 =?utf-8?B?d2I1Rkg4RWprcGtwMGRHTDcvQVZKMmUycWplbjBQWXRhQkFaaVFBR2RCN0dW?=
 =?utf-8?B?bjZsazM0VFlJRXlqTU83clpTZUV2eWJlaVlBcWpxSWVsSklxaDZnMnd2d0Vh?=
 =?utf-8?B?VHVtRytDUWF2R3JaYUM0TUdqdVkyN2RHalJIdUJOcTZ6elRrdGxOVEcvUWps?=
 =?utf-8?B?NnBsUCtRVndWb1hDMlFyNlFjdnBYS2hLMDFyZmdETVllTXUxaGVzTitPRDZs?=
 =?utf-8?B?ZjVZQ2pQTFV5SkRSZjNXRmxEci9hNUNpUUNaaWl3ZllPRi9oazdZTm5qNmJu?=
 =?utf-8?B?a3lDUHRGZDdLQ3J4SEpGRU9Ocnk1S2dBQzRrR1VqZE4zUFJvNEY2MlRwK3BC?=
 =?utf-8?B?S0lUMjk1Y1NQRFgwckRLNk51WTZkTkxoenIyTWRqM2dzOFN4bk1VWUNFeFgx?=
 =?utf-8?B?d1lCUHc4RmpROEdGcG13bWNtMzVUSzJwWFVxZmJ3Zko4UjFFaUs0d1B6T2xN?=
 =?utf-8?B?RFFPRTh6aFFTemxoc0pFa2xQZURNNFMwaytFUmdkNlI3bUxhUDF4WEhmdkFW?=
 =?utf-8?B?MkJGZGJnK3JUNDVrWWRxcEUyakNVQVFsTGJRMEtkT1VISTNNTXRLWGkvajVh?=
 =?utf-8?B?QUt2T0wyY05adEthSFJ5WmIxcWhsZjgvcTFQTjc0RWQ0QStoOU51d1E5WlE1?=
 =?utf-8?B?dldoMHVNbVZGRkZSMVFzL1JkemRrbC9HdmpGcGx1SjllblFaRTlWeTNpMzlB?=
 =?utf-8?B?OEZsVUJZRFBzTVNpWlR1NTlYQlMrN2l5TERGT25xYnkvM3BkZHRwc25tdnFL?=
 =?utf-8?B?U2VLQUdTOW1IODZ5NHo5WWhyTHFNeEpjR2tEWU41d1U3VHhpS3V1N1FsN2d0?=
 =?utf-8?B?NlBqOW5EMnJXbXNjekxEQkpBUHljMlZ4bWNXOEVvRFozL1VLdlc4TGJYc0h0?=
 =?utf-8?B?SnFodG83WGJJUk5VaWxyZkwrQlNKRUhRcGxuaE9zRTIzaDNNQUhsMG9mN2wv?=
 =?utf-8?B?V0VSSFlRV3NwaFNmV1JhSzY2Qk5GSzB3K3NYTTQxQ3lRckVpWXZzZXVmL1hk?=
 =?utf-8?B?OEk1elNyYjNYZ3JjRDNEQW9KRWdEdW9JcytHT1FXTHVkeTZhNFlkNDdMNnlD?=
 =?utf-8?B?ZWplbWdvOVFqYk1wMXZBSnZURmZzZGtyMm5mRHJ5RDExc2pVczZpQVNkOFlu?=
 =?utf-8?B?Qk9WblBEZEVnYmVoNkJaK3lZWUZHZGNlVGJpdWRnQnRpNkg5V2hxSDBmQ2J0?=
 =?utf-8?B?djNiRW8rR1h0RFdHZXBYVXZzNWt1LzNES3JjM0VxQ2hwRlgraGI0RzNsSDNy?=
 =?utf-8?B?WUovVklnanUyUG1XQVR2SUN6Rmtqdm00aS9QQlVIb08vU0svaHF0TnhrNnZF?=
 =?utf-8?B?K0NlcitJeWhUczN3b0dRaW9LVXV5VjFUZjBNOGRUTWcyVXBLcjFCSTU3K1lj?=
 =?utf-8?B?bGxPL1hRMEJDbTcxSCtkU1E0RWtyNndCQWx2NUs4ZTZaOHlRSmFmT3p4aVJM?=
 =?utf-8?B?eGYxd3M1VE9oakpFZVQvNVBuUnJVTUJQS2laRm9zTm93L3B6UlRzemxURnlB?=
 =?utf-8?B?VlNCTVlGSjloMmhiV2MwZ0F0TGVUVzhjR3dHbUhHWWNHaU9YemlQWHRDL0Fw?=
 =?utf-8?B?MnNuajRUL3VjYnoyRnN4NnRxQlJHUk5XNEF3dnVzU09WVmtBQnlwNiszcDUr?=
 =?utf-8?B?MzUvVHZPTU5ob0dNYzhsTGcrRCtiTFMrZDFnc21iZjFMZHJ3c0h6TlRUOFVl?=
 =?utf-8?Q?iieF8WFXufKFZx64KsmlQ1ZYPTr+3d+IKCoMgoj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3128.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e96183a-4801-401e-c6ae-08d95db11d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 16:49:13.1687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8gjU3tkxVqaNNurEQUOjfTtV4r9IUKXBbPqO4D8FNuymc/Ak3IJ7L5DHB1GZ6igF9G45MPTGum6u8pipYyheg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3176
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDQsIDIw
MjEgMTowOCBQTQ0KPiBUbzogU2FuaWwsIFNocnV0aGkgPHNocnV0aGkuc2FuaWxAaW50ZWwuY29t
Pg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IGRhbmllbC5sZXpjYW5vQGxp
bmFyby5vcmc7DQo+IHRnbHhAbGludXRyb25peC5kZTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGFuZHJpeS5zaGV2Y2hlbmtvQGxp
bnV4LmludGVsLmNvbTsNCj4ga3Jpcy5wYW5AbGludXguaW50ZWwuY29tOyBtZ3Jvc3NAbGludXgu
aW50ZWwuY29tOyBUaG9rYWxhLCBTcmlrYW50aA0KPiA8c3Jpa2FudGgudGhva2FsYUBpbnRlbC5j
b20+OyBSYWphIFN1YnJhbWFuaWFuLCBMYWtzaG1pIEJhaQ0KPiA8bGFrc2htaS5iYWkucmFqYS5z
dWJyYW1hbmlhbkBpbnRlbC5jb20+OyBTYW5nYW5uYXZhciwgTWFsbGlrYXJqdW5hcHBhDQo+IDxt
YWxsaWthcmp1bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDEvMl0gZHQtYmluZGluZ3M6IHRpbWVyOiBBZGQgYmluZGluZ3MgZm9yIEludGVsIEtl
ZW0NCj4gQmF5IFNvQyBUaW1lcg0KPiANCj4gT24gV2VkLCBBdWcgNCwgMjAyMSBhdCA4OjM1IEFN
IFNhbmlsLCBTaHJ1dGhpIDxzaHJ1dGhpLnNhbmlsQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4g
PiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogVHVlc2Rh
eSwgQXVndXN0IDMsIDIwMjEgNDoxNCBBTQ0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiArcHJvcGVy
dGllczoNCj4gPiA+DQo+ID4gPiBZb3UgbmVlZCBhICdjb21wYXRpYmxlJyBoZXJlLiBPdGhlcndp
c2UsIGhvdyBkb2VzIG9uZSBrbm93IHdoYXQgJ3JlZycNCj4gPiA+IGNvbnRhaW5zLiBBbHNvLCB3
aXRob3V0IGl0LCB0aGlzIHNjaGVtYSB3aWxsIG5ldmVyIGJlIGFwcGxpZWQuDQo+ID4gPg0KPiA+
DQo+ID4gVGhpcyBpcyBhIHBhcmVudCBibG9jayB0aGF0IGhhcyB0aGUgY29tbW9uIGNvbmZpZ3Vy
YXRpb24gcmVnaXN0ZXIgYWRkcmVzcw0KPiBkZWZpbmVkIHdoaWNoIHdlIHdvdWxkIG5lZWQgZHVy
aW5nIHRoZSBpbml0aWFsaXphdGlvbiBvZiB0aGUgY2hpbGQgbm9kZXMuIFRoaXMNCj4gYmxvY2sg
aW4gaXRzZWxmIGlzIG5vdCBkb2luZyBhbnl0aGluZy4gV2UgaGF2ZSB0aGlzIGJlY2F1c2UsIHdl
IGhhdmUgYQ0KPiBjb21tb24gcmVnaXN0ZXIgdGhhdCBpcyByZXF1aXJlZCB0byBiZSBhY2Nlc3Nl
ZCBkdXJpbmcgYWxsIHRoZSB0aW1lcnMgYW5kDQo+IGNvdW50ZXIgaW5pdGlhbGl6YXRpb24uDQo+
ID4gVGhlIGNoaWxkIG5vZGVzIGhhdmUgdGhlIGNvbXBhdGlibGUgc3RyaW5nLCB3aGljaCBpcyB1
c2VkIGluIHRoZSBkcml2ZXIuIEkNCj4gaGF2ZSB2YWxpZGF0ZWQgdGhpcyBvbiB0aGUgS2VlbSBC
YXkgSFcgYW5kIHNlZSB0aGF0IHRoZSB0aW1lciBwcm9iZXMgYXJlDQo+IGJlaW5nIGNhbGxlZCBh
bmQgdGhlIHRpbWVycyBhcmUgZnVuY3Rpb25hbCBhcyBleHBlY3RlZC4NCj4gDQo+IEkgdGhpbmsg
SSB1bmRlcnN0YW5kIG5vdy4gVGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgY3VycmVudCBzdGF0ZSBv
ZiBhZmZhaXJzIHdpdGgNCj4gdGhpcyBibG9jayBpcyBpbmNvcnJlY3Qgc29mdHdhcmUgcmVwcmVz
ZW50YXRpb24uIFdoYXQgeW91IG5lZWQgaXMgdG8gY3JlYXRlIGFuDQo+IE1GRCBkZXZpY2UgZHJp
dmVyIChmb3Igd2hpY2ggdGhlIGNvbXBhdGlibGUgd2lsbCBleGFjdGx5IHRoZSBvbmUgUm9iIGlz
IHRlbGxpbmcNCj4gYWJvdXQpIGFuZCBmcm9tIGl0IHlvdSByZWdpc3RlciB0aGUgcmVzdCBvZiB5
b3VyIGRyaXZlcnMuIFRoZSBleGlzdGluZyBkcml2ZXJzDQo+IGZvciB0aGlzIGJsb2NrIHNob3Vs
ZCBiZSBjb252ZXJ0ZWQgdG8gTUZEIHNjaGVtYS4NCg0KU3VyZSBBbmR5LCBJIHNoYWxsIGNoZWNr
IG9uIHRoaXMgYW5kIGdldCBiYWNrLg0KVGhhbmsgWW91IQ0KDQo+IA0KPiAtLQ0KPiBXaXRoIEJl
c3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
