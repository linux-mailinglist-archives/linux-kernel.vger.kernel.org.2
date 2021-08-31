Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642B63FC68F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241421AbhHaL2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:28:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:30838 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhHaL2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630409248; x=1661945248;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=WGGV7lI8R1R6PZAp8vij88bmsuRv9nzJIdOaUYTsPV8=;
  b=CwNkNykWrHjOK5tY11Krl167G8F95YWs6KleLWnrtnoCLg+pz5XkfL7Y
   Yp+W5lRJhY8dTlhoW9SAQkFzVRC0b03q5wHau2q76wuikNWHZVZsYXH0u
   uBwVilxIUJE9SqfIHnonMpidnGxbSPCzHnLpJtWBAUm93A3lM0/2iTEmu
   M0gn6rCMG5nK4xSaKvdUzX8q82Zkj8Xs4xcLQLFBvxM4Sam752kR7buOj
   IlLNYYLQ8L1nqGL/ORLmdWbwOQ9AfAXjJbGH44qr9Y8lLFcUFWZvkxcYC
   KvJ3lUc2o+kFWVrHpGctlZxLZ5Siyic0iwkN+0eTd0AfXpheeXXBsylV+
   g==;
IronPort-SDR: kCC8FrzBUeJ38xce4/7PHVCDwhxROyg9jzUfdCZjnSgBCUQb/6SOXCCVDIZPTr++UwlVWiy2ya
 M+DxuIC1BtB6btzAyjqUr/DDfTG4ZC7GMx0S8YWVE2oaDEy5O+oXCVECo37r66a2YuSTUjdJh0
 3YJaeMDb8YKLmYV2jGu9tR1Il4hEKGDVhoU32VThiK7UdJv3qPZfgDg6S78lXWKPPMkxKOiaTM
 0I09fHozX+sdDBhKOLJ3Rh0WTkO14TPo6qjxXl2wwu270NB7tL35/oATC5jpT1/94PH3zncXCY
 dj+rZXo02K2OG5fvoVfFrOyr
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="67697738"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2021 04:27:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 31 Aug 2021 04:27:27 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 31 Aug 2021 04:27:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8g2WdGXEmm25LRN9TXTtszeMxWv/rYI7GsXWWWEIqXsczia04QRY6WPVfulXMlOd1/4l4tWRuQsTe2SRvKsrwW7AJ+c0O70vz/0WS6Z8/c0OS712hcJrFvoXINjQLcVgXY9iqElFF2x3Lu4UTBnf55NKCcwzKierA+2qs+ZTWGsTDdLzx5aWG+49HzQM51ra9rY0ps7+bjo4gMh2Ovrmr9hiNgrwoXrQQjbqmHjzYH+bhdCk2boLngvG7YETksfrua/x8GMJAscBTxsYNpTqmqCfDT3j3/lQH2IOIpm3AFPqECOgbspUbAYUG+y+kpI7ETmPTfRyoIrqPTiv2PgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGGV7lI8R1R6PZAp8vij88bmsuRv9nzJIdOaUYTsPV8=;
 b=TRDWCMVKMtxYDanwVa+5jRJO7SLcg9FcwELDXl860mc5wuNOFaYPIy5Uk2mjmA4++F2OLab6K7KU15GCIrTSi8D3lauKItWxvPz3i5g/hp0uBttyBquJG/4VJVCHmKX8VAeumV4n7bdFVA6oKwmIsHrvHfKyxGtnnBFmI3KVkAboQt3jC4gwAklsukg2wqYX3r/g1q+lwr1WPfcROFwvvxjARzvTMDkFzoEL2UcJkiHPLYmbl+w68+8sDbUBv3L3ucNmIZwHseB9OppyEj08zcZr5ni+i0veWpNnRlFF5njFpGa8aYAh50f60Ke9Z+vZQ0hAQch9oDTmRy7r9TK2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGGV7lI8R1R6PZAp8vij88bmsuRv9nzJIdOaUYTsPV8=;
 b=hjooGPpSj/eWeiVZcGfMUY0aEaQFxD1+ezRaItxeDiJhm2uWu3/uvBysb305qB7M7y5cyV7dm0la31jCBviKRzO75vaODgR8vAvd3jdDYJT67sd9eMYyQx0bzGmffNuP9u4tXCo4zYgMxrVgnSzSXsAcsWOV80tMsoqJ8OHGTCs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MWHPR11MB1406.namprd11.prod.outlook.com (2603:10b6:300:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Tue, 31 Aug
 2021 11:27:24 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::d96a:4568:b553:97a4]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::d96a:4568:b553:97a4%9]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 11:27:24 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <robh+dt@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <atish.patra@wdc.com>,
        <sagar.kadam@sifive.com>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] riscv: dts: microchip: add missing compatibles for
 clint and plic
Thread-Topic: [PATCH v2 4/5] riscv: dts: microchip: add missing compatibles
 for clint and plic
Thread-Index: AQHXmbJK24GNG6e5kkiiaVImeMyyJ6uNgvGA
Date:   Tue, 31 Aug 2021 11:27:24 +0000
Message-ID: <5b05d1e0-24be-f013-bb4e-f69b061b62e4@microchip.com>
References: <20210825130452.203407-1-krzysztof.kozlowski@canonical.com>
 <20210825130639.203657-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210825130639.203657-1-krzysztof.kozlowski@canonical.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdadc3b3-4f1a-4c15-0024-08d96c724e15
x-ms-traffictypediagnostic: MWHPR11MB1406:
x-microsoft-antispam-prvs: <MWHPR11MB1406C4F3B227FEA7311FE9B398CC9@MWHPR11MB1406.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jG89RryUU2ATeLBQIkzWkCRVumthHQ0gde9BhmNe5IGqfYd6YzxiBmFh2GyLlI7E9tkvPvtZ1Riw6IOs/e1D0CD/Ns56Sx+O5akstvB29RyJ2RzRFpTH36yb2pAqi02XhP62Xojacr2Sh+fMbIRmlKP7KH6j47Jk/lRqXZ5qBnFrst3EUzzYXZu4OC/T+HH+wMzavEWHr232vvonUfg28td1y5uEHyGbWPr12qxe39mkKwZjODBEIcyPZiZ6JeeIG4cC1ppgQqjbeJYjQSProXirjrlzWMs4vnsPwpjO18K3WuVLgVzFxODd5Oj/vIL0TcVJvEJ9uyH34X39U6YY/Pj8ZIzOQQzmjsTvCOr/D+gLVmGNKAUmrxgqVrAsDF+JkmBrRuHCc2QJ5Bod3vS1aW6QAX6RjIu++UGw8BwAHNj1467dallezhaqz7zS1mobBkbjpKI1gck7xh/vxV/Eyr7N8U2fL2YjO7lnWznL7AtyOKWVL6MoQ3q0mseHE+vtGmtgbBRwTufrUv7SwsDhKbB7izVGyz3xUHo0eoZY8gfgywGJucSSNACSKW/XgiofFl8vhuectNbDofa79RnC2BG0GlZrir1SkOz5D9OIpIFfkWoMwzYhtGEJ+EWBZxMdEsiUcO2oe7ykunhvi9p4ovTYQewIzjF4jL5h/QlO2JjPsm6ZIe/HranPk6b/3GLgG6gxaOHErJJPQmh8VtnTniXfvK+XCRc51Z8NQwmg2hpL5fJC/9n1kHmn4cBG4Idz6gJ2WLQhsbfnw8Rbg5/jGJD/q1X+KrdiEFDHRenk9ZT+TmbA1B9bzXW8b/L4/K7/pnrLLL45pcQWZPsxXvwqyABH3QhZCfgf6a+EAN8wPec1oQB+t72xm05BE+i5ISi5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(346002)(136003)(396003)(83380400001)(66556008)(8676002)(64756008)(53546011)(66446008)(66946007)(26005)(31686004)(66476007)(6506007)(186003)(110136005)(316002)(8936002)(478600001)(2616005)(36756003)(7416002)(6486002)(38100700002)(86362001)(921005)(6512007)(5660300002)(122000001)(31696002)(38070700005)(966005)(91956017)(2906002)(76116006)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU1vVFowR21vUmNwSGNHc2JGMjFETDJ2SEJNbyt1V1JBMlREM3h5Ui9MdFVK?=
 =?utf-8?B?emc4eGlWbFRNMGp1WmoyeHpwUXJaTjFiTkxtMCtGVHRLalhKQng4aVJwNVhw?=
 =?utf-8?B?dVI4VmtNOGpjWDZvenBPdWlIYzVhRGR2N1NNcTBockFLWm9yQ25UVlhiK3BZ?=
 =?utf-8?B?V1lPQXdhWEt1ejF2eW0zTmp4VzRSem5PWk42Y0pVNVkvaFpvcnFxOVZDOUlM?=
 =?utf-8?B?ODdRTXV5ei9TbzEyL2VLd1ovaGtYR2NVMjdObVlEMHFTUC9XdThQNFh2UXE4?=
 =?utf-8?B?RHQwYmRmeFJaUldRVXVMeFBCNE5FOHNhSjFJaVkwZTR6SU5HNW55c1lwekNl?=
 =?utf-8?B?OGk5Q3c3U3drTUpDdXZWLzhhNUlxN1hjdm1WZGdNb2I4U2c3cjZLbWNNM0I3?=
 =?utf-8?B?WEYvbnhmdWFWNWZDSGlIOXFaMEVXOUNJWFRYSXJ5QkR3by84SmFxQ28yamlC?=
 =?utf-8?B?Y0d4bmZDRUVZODJJY1dnWVpYRG1PbkM4azBtZHUzZzhGQXlDMlphdEt0US9J?=
 =?utf-8?B?dHJIZUdyQ01wTWR5MEJrS0E0RWFPN0RSazRjS0I3TjY5MUhSVUt4YUxJSFpn?=
 =?utf-8?B?NEl1RHNFQ1VWbXBlRGNGZGVkNElRZmJ6YlpLemxiZkpTaVgvaE5PUjI0bnlj?=
 =?utf-8?B?SHM1aWhQQ085emhrUVcwQkRUMXBsNDdTM0hSMEZCQlB5NUFtbkdzNFlEL1l3?=
 =?utf-8?B?eHEyN0RvZnhDV3pxRGJQL0lYcjR4UnBwdVVnZVRaUDJyYXRrYzBuVWJyckdt?=
 =?utf-8?B?ZVVlSDJSc0dPZzkweFJhV21sZkRNVFpQRUVFc0QyVzFCVmhhenJWYzhEU0xm?=
 =?utf-8?B?Tm9DNTVWdFZEdWR4ZE05SkNkbVQzYTlCcUl4S01FbU5ZeE1rQzFPZ3lKVnR5?=
 =?utf-8?B?T1E0d2xMcW5vbkM3YkZydTdSREo0MjRuMGkrWkl5cHRRZ3pyOGhNVGlkMHFI?=
 =?utf-8?B?UTJaSG9iaytlSjJINStrL3dCb2dwaXA1OG53ak91RC9aQkozQVc5amF2dERS?=
 =?utf-8?B?SkdLVnJYMTh4YTBISC9ML2hQVFl1K2xLQURxREF1TFA1SFFoUDVOdVYxNENE?=
 =?utf-8?B?d2FGN203ZEhMQzV2VVNzdUZGdld6MWNkTlNUMGdFekNhNGF1V3JjY2VnR0NW?=
 =?utf-8?B?Z3IyYlBWWXlzcmZxWkVtbTU4NDBhaW11U0dCeVFlanZhUVdQaFlNOHVoVm4x?=
 =?utf-8?B?d3d4OWFUL3VPWlo3KzVKalZmazZWWHk3VmEyK2xaUFNOK3RYblV2SEtudEJj?=
 =?utf-8?B?ZnhCK0hSZWtUSUJPNGoyZjNUbGJISnA3b1pKV0ZYZ2hoMWlqUmlncWpxbEx3?=
 =?utf-8?B?UVNvRTFoclY0U0xnaGtDbzhDbk0rUEZPS2RzMTltQ3RmandCbGJaL01veDF0?=
 =?utf-8?B?dTU4R0crSE1BQ1gvaGFBRUxQU1YwNTF4UDIxdkg4b2paMC82TlF3MW4vU3VN?=
 =?utf-8?B?MHhBVUxMMGZUTVp6bm96ZHUyUUY4SEhOT2NyaW9TNmZES0VkOUVnT3FvKzhP?=
 =?utf-8?B?NEdzR1R3Q2FQNi9JaDhicndaS1BNY3luUldpTnJYeUVwUzUvSFFhQ3paQzg1?=
 =?utf-8?B?aGt2OHZDazFldGlGUW1Hc0szZXJCdXhVV3Vnb0YxMjJpb0pVTTl6b3hRZXgy?=
 =?utf-8?B?OVhuWEFVWGk4aG5hU1FhZENjTk90MjFHU3NhUVhVaEJlNmFVL2hnb2FqekY2?=
 =?utf-8?B?ZDF2YUgybjhrSWlHY0VPZVNNQkN1dGRsU2NsbkVWVTJmS2RGYTVlNEJDSzc2?=
 =?utf-8?Q?wK00oF7XF7cESLBOIixZ6ztzRSW0vt+Au3pk/Ac?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD885D0ABCC4454190ABD7A18CDFA41F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdadc3b3-4f1a-4c15-0024-08d96c724e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 11:27:24.0720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06yI9KoDx0SMuRpaWpB01sN0T2xV8iq2P3JhppGtJs/bU/Sy6qrbup73aGlNrDLXPDQwxT5lg05lUJroDmQ+oikSqf8gXKESEKrgCkOhJLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1406
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUvMDgvMjAyMSAxNDowNiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IFRoZSBNaWNyb2NoaXAgSWNpY2xlIGtp
dCB1c2VzIFNpRml2ZSBFNTEgYW5kIFU1NCBjb3Jlcywgc28gaXQgbG9va3MgdGhhdA0KPiBhbHNv
IENvcmUgTG9jYWwgSW50ZXJydXB0b3IgYW5kIFBsYXRmb3JtLUxldmVsIEludGVycnVwdCBDb250
cm9sbGVyIGFyZQ0KPiBjb21pbmcgZnJvbSBTaUZpdmUuICBBZGQgcHJvcGVyIGNvbXBhdGlibGVz
IHRvIHNpbGVuY2UgZHRic19jaGVjaw0KPiB3YXJuaW5nczoNCj4NCj4gICAgY2xpbnRAMjAwMDAw
MDogY29tcGF0aWJsZTowOiAnc2lmaXZlLGNsaW50MCcgaXMgbm90IG9uZSBvZiBbJ3NpZml2ZSxm
dTU0MC1jMDAwLWNsaW50JywgJ2NhbmFhbixrMjEwLWNsaW50J10NCj4gICAgaW50ZXJydXB0LWNv
bnRyb2xsZXJAYzAwMDAwMDogY29tcGF0aWJsZTowOiAnc2lmaXZlLHBsaWMtMS4wLjAnIGlzIG5v
dCBvbmUgb2YgWydzaWZpdmUsZnU1NDAtYzAwMC1wbGljJywgJ2NhbmFhbixrMjEwLXBsaWMnXQ0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93
c2tpQGNhbm9uaWNhbC5jb20+DQo+DQo+IC0tLQ0KPg0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAx
LiBOb25lDQo+IC0tLQ0KPiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hp
cC1tcGZzLmR0c2kgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9t
aWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaSBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9j
aGlwL21pY3JvY2hpcC1tcGZzLmR0c2kNCj4gaW5kZXggZDlmN2VlNzQ3ZDBkLi42Zjg0M2FmYWNm
YWQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hp
cC1tcGZzLmR0c2kNCj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9j
aGlwLW1wZnMuZHRzaQ0KPiBAQCAtMTYxLDcgKzE2MSw3IEBAIGNhY2hlLWNvbnRyb2xsZXJAMjAx
MDAwMCB7DQo+ICAgICAgICAgICAgICAgICAgfTsNCj4NCj4gICAgICAgICAgICAgICAgICBjbGlu
dEAyMDAwMDAwIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaWZp
dmUsY2xpbnQwIjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzaWZp
dmUsZnU1NDAtYzAwMC1jbGludCIsICJzaWZpdmUsY2xpbnQwIjsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgIHJlZyA9IDwweDAgMHgyMDAwMDAwIDB4MCAweEMwMDA+Ow0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50ZXJydXB0cy1leHRlbmRlZCA9IDwmY3B1MF9pbnRjIDMgJmNwdTBf
aW50YyA3DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmY3B1MV9pbnRjIDMgJmNwdTFfaW50YyA3DQo+IEBAIC0xNzIsNyArMTcyLDcgQEAgJmNwdTNf
aW50YyAzICZjcHUzX2ludGMgNw0KPg0KPiAgICAgICAgICAgICAgICAgIHBsaWM6IGludGVycnVw
dC1jb250cm9sbGVyQGMwMDAwMDAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgI2ludGVy
cnVwdC1jZWxscyA9IDwxPjsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9
ICJzaWZpdmUscGxpYy0xLjAuMCI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAic2lmaXZlLGZ1NTQwLWMwMDAtcGxpYyIsICJzaWZpdmUscGxpYy0xLjAuMCI7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4YzAwMDAwMCAweDAgMHg0MDAwMDAw
PjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJpc2N2LG5kZXYgPSA8MTg2PjsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1jb250cm9sbGVyOw0KPiAtLQ0KPiAyLjMw
LjINCj4NCkxvb2tzIGdvb2QsIHdlJ3ZlIHN3aXRjaGVkIHRvIHVzaW5nIHRoaXMgb25lIG91cnNl
bHZlcyBhbHNvLg0KUmV2aWV3ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+DQoNCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmlu
ZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1yaXNjdg0KDQoNCg==
