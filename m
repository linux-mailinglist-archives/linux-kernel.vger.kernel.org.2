Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617A14083CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbhIMF1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:27:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:4923 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhIMF1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631510790; x=1663046790;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=XIv11Aove8obvUshuIun+hqN1scvfsdxfENRvBNVgI4=;
  b=uEzX7BxZMQ0+dXcCYUHjNdoH39zvrPoxvFjZ9dJPDRL9TWWiZ99Vr6Qt
   T3s7zgNHTVO4BfF/bsx6ki+DQCBZnH/kfCDMhWUSrMjXzlDkLNGI94S+U
   rJ2wnhCX3PY0ESNGMJBF9NNXVtq1f6lIV739RjWtSzPJwUXKiCxCCCDVN
   GpiaMLXdEOG3JSRvfV1JsmsXH7SgKhl9l95G5lkehvaFpRlwK376kW2Vj
   yPYdFyYY1OaUXTr3EvMzyE/8CETWLjxqhL7pp7HPsiOWgo6tZ+8rQl2le
   tFMN4hXiCUv03oCY87hGf9OCyGxs9b84ZM1LapFh2LP2vsHcu2iR3EtLB
   Q==;
IronPort-SDR: 81ezF+Cdn1jH4rry2Q8dn2X6Ks/o4I4nomqx8RnD1JRW2pOL3l8pcX7bDxQ3lCFHFtoqdQ738P
 iK10FO5kS3tkdAlscPhhy3AKFyKq6oxnPvaITUHE1BPGXfbczoFfmP8vfFgk1+u/d5CpAG7SS+
 +LLjj2MXvBKF3m3FLNpY9Gy+Mg8vzwYjT5C1SbRcbBUy/hF5nBObKfNQ0ypnVLh57cehU4VWtS
 ByxtjrJ7Br46L8ECrFbnzmeAqWN1CcUTemUoav26b2I8ZYkkScBbxzHgrVxilQCCWTIQ1oM6xf
 tYuKq+mOVaSy69EB5sic4Z6+
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="129070427"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2021 22:26:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 12 Sep 2021 22:26:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Sun, 12 Sep 2021 22:26:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYNBA0JIWrzn6vZEFNSZ4POq4AopSlspKQyyb/iq3w0bfcxV+rsa8UL2QNprO/VVhJhB3en8JaqlT8reW2LSUEpysbqc/FKVWI3ytcYT5grLHMLJgnwg9bh0WF6XCduuiPtwHn0b7Tw0dIIVFifoA5FXCPvEOb3n3OAI3M01cRJOdVfSpRjHaVxvucFaVdndToZG7KzSHgCr2KcmN3MjNFbqCDxUCn9wrI0VFweQ8+G4kMbLioyyQ9Xajuy/7Gsffk9Rof26yYq0ij+jtMBygL4nCKDz0GmfC2XGe+sIke5eVwJ+U7+67f2WraxAv1bAADGYt6x2xGy6CB+ci90tOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XIv11Aove8obvUshuIun+hqN1scvfsdxfENRvBNVgI4=;
 b=Fb0cF0eJEFnr7QRw2mgWC/OOggGVFSv6YutVpxLwv01gkMitM6CZmpHpbIfnuh8fPRyBpt1MtrS8ERRaLkfAjcPKO75+Qp0eEMMswXznXwEP5twPb9UZojfHV+q6UR83BojIDECMYfsJIsiqlnLrSe3PEMCt8bqa6BkJMR6Z9Nv0j1n+ws2JG3Iepn4+v17c8w4U2tdgY6F9xOpWW1AEq5tCOLH8o2csKk2b0rOp/KitM/ygXfEiWoabXB6ez8qiY8tw0qnqSNsgIaLvgpWJJyPATL2YQHRW3K2/+t4yK3FAgxNbhGAvkk9MDC58/p8Y5R1YYfGvPr/4dEoKQmi7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIv11Aove8obvUshuIun+hqN1scvfsdxfENRvBNVgI4=;
 b=jB9cvmBe5W16tbjuFgTmr4LvWMM9+YMd9jZTQJVDq9V6vP4wg3YGt033MwaYVRFg8oaWyuwjM8t1PTrE8JgTEotHKBgIgCYeBZ4gNvaZB528EFe6wa5P1CyGT5yftu03k4UAhCv1e6NIFog5kH+OYV8010JUePChAPdPe2/J8GQ=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB0025.namprd11.prod.outlook.com (2603:10b6:4:63::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Mon, 13 Sep 2021 05:26:27 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::acfc:87df:5588:8a78]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::acfc:87df:5588:8a78%3]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 05:26:27 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <ryan_chen@aspeedtech.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Topic: [PATCHv2] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Index: AQHXqF/m2CB7h4a7MEK00XI07m1KlA==
Date:   Mon, 13 Sep 2021 05:26:27 +0000
Message-ID: <4571c9ae-0287-4f70-2adb-9c227e706736@microchip.com>
References: <20210908091845.4230-1-ryan_chen@aspeedtech.com>
In-Reply-To: <20210908091845.4230-1-ryan_chen@aspeedtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: aspeedtech.com; dkim=none (message not signed)
 header.d=none;aspeedtech.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b386f049-0929-4b7a-8c82-08d9767708f8
x-ms-traffictypediagnostic: DM5PR11MB0025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB0025D12D70CF1ABFB6BFA71E87D99@DM5PR11MB0025.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9sNYlXVbMAvdOcbjfaPcMAuJYVNkVRk+nA9WWYX3LgGsFqRtc8KCoSeBpFmp+ZNhlsxBNCfaDjizW5p8sQ8a3E9I49XZpLIKJBmOPs4c6uNiFQefd/DDlvoZpDIKnAUuALDJq/lIdBt9OCpLyNW2j7VyXViceFSzkWQBnGya6E6g+ijsQi39Kl+BZb1b8XXY0lMtDAAzFg6Am0/owSLhLxKxW7JOwLkKy3xLJh7i+p80RtDzUNb2iSz/Egvh0/KDa3ul+S7+dwvpq62xycm/JOe3ByFFTHQ+C6ThdUw/bJOPgQvsaMdTpKC7NRuL+J/1y+rHbiH/XbbrCJdoPPLb5jQFrYIf9XgkTrrbPEyFJQXJybyT5QscA+2y3Xjw2yJALbi7rUsBGOnQSmGGohrGRFPSjXNRnXr8LJsNpnIumXYNBnKH0EmUJvLhXdOIFNVwfXLXjPm7lGkh3j+/a1Fo+CvZWJOL1tdKNS7F+JkZZL6wqsiUFHM40f5I0+KjTO92KS9X0uRSHle0NCMv5cM1dEVoAGVNtO/WTmxyfXfvafAQZLWDw7XFf3w1wmODEQJtLKJEei5a5B28o6BZEV/JMddmZHo7jevEzp62ns3QPHaQ3CRIS4cjXtUHw4MduPL1oGP1NvlXafCLnBxMAJ8Cc0qnNut80ImMawHaqYMBLYCzMpFnzPqT0yrSIDewpTE/T/X2D6dG1U9w4+LC7kn3EbqfAgL73hJNXMTjhkCzzSFr8pv9oSrSTebrC2S+H6foYE1xzviFGBrKSCr4wvfNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39860400002)(64756008)(66446008)(86362001)(83380400001)(26005)(5660300002)(53546011)(71200400001)(8676002)(38070700005)(6512007)(8936002)(66946007)(91956017)(110136005)(6506007)(38100700002)(6486002)(122000001)(66556008)(316002)(478600001)(36756003)(186003)(2616005)(31696002)(66476007)(31686004)(76116006)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWIxWTZkQTJoUHFjYkxUeUpxcnNQM2dKSlBuZkJpNTV5dEhabUJtVWt0c25k?=
 =?utf-8?B?b2dLYXM5SlpWQWRhWFJWOTZkU2pxaXlxTWtJRFJtUHNLYUpQNmNHTTBZYmx2?=
 =?utf-8?B?ZjVFMVFGK2ZIb3kxTVlYWEw4bkZRTHVhLzlSdk8vdm55Q2hhZXRuNEJ6YVhI?=
 =?utf-8?B?Y0ZQcWZzRmhHNXMyQkVnd0hGcG13aHNXOUlNbEc3V0loTWowcUQ0SzdzTmN6?=
 =?utf-8?B?cnFBRFpvckdnQ2wrQzBadGx0T29RMEJ4NU1WSERiRk5zVkp5OVFrcEdQai8y?=
 =?utf-8?B?OUYrMVVzbzRKNTh5ekg1M2pyZTUyVVJpbHh4YjFUUVZXWlcxakp0RWlNT2tL?=
 =?utf-8?B?STZXUW9HTTRyVDFZWmpyQlhxU3BOcmRxdjRTQXZpdlVGVUdORnk3U0pFbWdw?=
 =?utf-8?B?anVGVjZzd1JXNlQ5bG44VTNEUzgrN3FQVzd3SGdxN3VWaUJ5RnRBbXd4cWVa?=
 =?utf-8?B?WVlZcXdLWDJpTHdnNjZiaTJiaW1CNmQ5Ky8zdG5VSkZOa0N0ZjdOdTZmMVR3?=
 =?utf-8?B?RjhCSk95M0JEaW9jZk5FT24wYURUVjcvWVgreElhRnhwK2ppSmp1R3dYR0JW?=
 =?utf-8?B?TmVJNFNtdnpOeGtnQW9oWTBoTHd5emhsbUs0SHd4ejhpQ2FqQzJsWHFUbWF1?=
 =?utf-8?B?cVBLUU5renhwWlJKSmVVTFI4WjVjN3ZIcTZjZmlOQjNDa2NyV296d3hrSTBO?=
 =?utf-8?B?NjNCaVk3K0RmbFROUGpXNnR2b2hmQ1NRVnRaa2VmYjVYa3VjVkRuYzBEY1RW?=
 =?utf-8?B?d0NibWxSQ3FNaUtUT0UzWGI0S2tkL2lXVTdmQnhHMFRrL1M5Y1puaFJuQ3R0?=
 =?utf-8?B?YnFQbHM1empuU3YrZWlZSUc4WkdBOXdraFRhQXlpUkhieTRDenJ5ai9ERnBM?=
 =?utf-8?B?aDJYQ3RxdUhpdnpRZ05XODVEVDF0TzJmLzlUTUFvK2xaYXk4aGVCbXlERVBk?=
 =?utf-8?B?b1cvZXFzNlR0clZDMnBSNTd4REUvNkNmL3ZtSHI0a0pERUVta2Q0M2VWYlJ0?=
 =?utf-8?B?VXAyczVHN2hMd1RtUTFyazBaZkZHV1lGL0Z4Yi9BMklpZ1FoUW8vSFpOcmRz?=
 =?utf-8?B?aTRDSDhzYmhsNmVrODFnSzBSQkc0eHpESC8zNjlCSXp2Z3lJT0xES0xvazhr?=
 =?utf-8?B?T0NqQkVzLzN3L2tjSk8zY2FRVjMwcnJCMnUyNmNvb1ZWNHQxb0Zod2lIZzJM?=
 =?utf-8?B?bUFyV2ZBaDZ2UUF2cjlaemxONnBsS014aFFFaE9BZXlGNVZDT0RidFNLeklr?=
 =?utf-8?B?ZHlsYnA5YlJOMVlKNkNvbEFTU21RTVpESkJUUGN6SHVMZGFXQWQ1ZlJ4eTk2?=
 =?utf-8?B?RDk0SjNydFFTaEw0VXVGZmVzRmpEM1JTeHY0Q1JnSEFDSm1LRmlOOFdTc1Qz?=
 =?utf-8?B?N0JQWldLNmJlbkNYOTM2QmRXc2lKWHdOZVg1VU44VTFKdkR6M1h1VWh1VGhO?=
 =?utf-8?B?WEdnS3hKN3NPOUxmUy9WWEVxdzFvdnNlaU9mL1FKYlB3bFNnYlpwdDh1enJM?=
 =?utf-8?B?eXJIcmYvbWR6ZHFURjdDQjZDZndjNnpSQlFRcVlKcmZaa01Tdkd4eWY5M3RG?=
 =?utf-8?B?ck5TaVJVb1hlSVhwczhaS0FzZkpoZUFUU3o2YkNXR2J4Y0JXVTFLT2JiOXFl?=
 =?utf-8?B?ZDJtVUhLeElDVWZhNkl5QUVlY1prajNEbjJhNHZ0SVFaNE1rSDNzbTRXRkQ0?=
 =?utf-8?B?RUhza2dtT2JxK2VaRnlzc2xiNk0rMFI2TUI0R0lFajZuWms3QUd3RGhhdDBH?=
 =?utf-8?Q?Y+ruFO9KwynphQIm3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1477E20EA55014083A44AABA590C0B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b386f049-0929-4b7a-8c82-08d9767708f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 05:26:27.2668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPvfxLYvCmGy1FX6czj2q9C62YbmaFF9hmRyxAtNKLvh1fh861Y83Is6AyLwqqoPKU01REFvGKHpyXj8bPf03ex4Of5FfIsEY3JUJx2EWpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDkuMjAyMSAxMjoxOCwgUnlhbiBDaGVuIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFTVDI2MDAgSFBMTCBjYWxjdWxhdGUgZm9ybXVsYSBb
U0NVMjAwXQ0KPiBIUExMIE51bWVyYXRvcihNKTogaGF2ZSBmaXhlZCB2YWx1ZSBkZXBlbmQgb24g
U0NVIHN0cmFwLg0KPiBNID0gU0NVNTAwWzEwXSA/IDB4NUYgOiBTQ1U1MDBbOF0gPyAweEJGIDog
U0NVMjAwWzEyOjBdDQo+IA0KPiBpZiBTQ1U1MDBbMTBdID0gMSwgTT0weDVGLg0KPiBlbHNlIGlm
IFNDVTUwMFsxMF09MCAmIFNDVTUwMFs4XT0xLCBNPTB4QkYuDQo+IG90aGVycyAoU0NVNTEwWzEw
XT0wIGFuZCBTQ1U1MTBbOF09MCkNCj4gZGVwZW5kIG9uIFNDVTIwMFsxMjowXSAoZGVmYXVsdCAw
eDhGKSByZWdpc3RlciBzZXR0aW5nLg0KPiANCj4gSFBMTCBEZW51bWVyYXRvciAoTikgPSAgU0NV
MjAwWzE4OjEzXSAoZGVmYXVsdCAweDIpDQo+IEhQTEwgRGl2aWRlciAoUCkgICAgICAgICA9ICAg
ICAgU0NVMjAwWzIyOjE5XSAoZGVmYXVsdCAweDApDQo+IA0KPiBGaXhlczogZDNkMDRmNmMzMzBh
ICgiY2xrOiBBZGQgc3VwcG9ydCBmb3IgQVNUMjYwMCBTb0MiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBS
eWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Ns
ay9jbGstYXN0MjYwMC5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLWFzdDI2MDAuYyBiL2RyaXZlcnMvY2xrL2Nsay1hc3Qy
NjAwLmMNCj4gaW5kZXggMDg1ZDBhMThiMmI2Li41ZDhjNDZiY2YyMzcgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvY2xrL2Nsay1hc3QyNjAwLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvY2xrLWFzdDI2
MDAuYw0KPiBAQCAtMTY5LDYgKzE2OSwzMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19kaXZf
dGFibGUgYXN0MjYwMF9kaXZfdGFibGVbXSA9IHsNCj4gIH07DQo+IA0KPiAgLyogRm9yIGhwbGwv
ZHBsbC9lcGxsL21wbGwgKi8NCj4gK3N0YXRpYyBzdHJ1Y3QgY2xrX2h3ICphc3QyNjAwX2NhbGNf
aHBsbChjb25zdCBjaGFyICpuYW1lLCB1MzIgdmFsKQ0KPiArew0KPiArICAgICAgIHVuc2lnbmVk
IGludCBtdWx0LCBkaXY7DQo+ICsgICAgICAgdTMyIGh3c3RyYXAgPSByZWFkbChzY3VfZzZfYmFz
ZSArIEFTUEVFRF9HNl9TVFJBUDEpOw0KPiArDQo+ICsgICAgICAgaWYgKHZhbCAmIEJJVCgyNCkp
IHsNCj4gKyAgICAgICAgICAgICAgIC8qIFBhc3MgdGhyb3VnaCBtb2RlICovDQo+ICsgICAgICAg
ICAgICAgICBtdWx0ID0gZGl2ID0gMTsNCj4gKyAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAg
ICAgICAgLyogRiA9IDI1TWh6ICogWyhNICsgMikgLyAobiArIDEpXSAvIChwICsgMSkgKi8NCj4g
KyAgICAgICAgICAgICAgIHUzMiBtID0gdmFsICAmIDB4MWZmZjsNCj4gKyAgICAgICAgICAgICAg
IHUzMiBuID0gKHZhbCA+PiAxMykgJiAweDNmOw0KPiArICAgICAgICAgICAgICAgdTMyIHAgPSAo
dmFsID4+IDE5KSAmIDB4ZjsNCj4gKw0KPiArICAgICAgICAgICAgICAgaWYgKGh3c3RyYXAgJiBC
SVQoMTApKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBtID0gMHg1RjsNCj4gKyAgICAgICAg
ICAgICAgIGVsc2Ugew0KPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoaHdzdHJhcCAmIEJJ
VCg4KSkNCg0KWW91IG1heSB3cml0ZSBpdCBkaXJlY3RseToNCgkJICBlbHNlIGlmIChod3N0cmFw
ICYgQklUKDgpKQ0KDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbSA9IDB4QkY7
DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICAgICBtdWx0ID0gKG0gKyAxKSAv
IChuICsgMSk7DQo+ICsgICAgICAgICAgICAgICBkaXYgPSAocCArIDEpOw0KPiArICAgICAgIH0N
Cj4gKyAgICAgICByZXR1cm4gY2xrX2h3X3JlZ2lzdGVyX2ZpeGVkX2ZhY3RvcihOVUxMLCBuYW1l
LCAiY2xraW4iLCAwLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBtdWx0LCBkaXYpOw0KPiAr
fTsNCj4gKw0KPiAgc3RhdGljIHN0cnVjdCBjbGtfaHcgKmFzdDI2MDBfY2FsY19wbGwoY29uc3Qg
Y2hhciAqbmFtZSwgdTMyIHZhbCkNCj4gIHsNCj4gICAgICAgICB1bnNpZ25lZCBpbnQgbXVsdCwg
ZGl2Ow0KPiBAQCAtNzE2LDcgKzc0Myw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBhc3BlZWRfZzZf
Y2Moc3RydWN0IHJlZ21hcCAqbWFwKQ0KPiAgICAgICAgICAqIGFuZCB3ZSBhc3N1bWUgdGhhdCBp
dCBpcyBlbmFibGVkDQo+ICAgICAgICAgICovDQo+ICAgICAgICAgcmVnbWFwX3JlYWQobWFwLCBB
U1BFRURfSFBMTF9QQVJBTSwgJnZhbCk7DQo+IC0gICAgICAgYXNwZWVkX2c2X2Nsa19kYXRhLT5o
d3NbQVNQRUVEX0NMS19IUExMXSA9IGFzdDI2MDBfY2FsY19wbGwoImhwbGwiLCB2YWwpOw0KPiAr
ICAgICAgIGFzcGVlZF9nNl9jbGtfZGF0YS0+aHdzW0FTUEVFRF9DTEtfSFBMTF0gPSBhc3QyNjAw
X2NhbGNfaHBsbCgiaHBsbCIsIHZhbCk7DQo+IA0KPiAgICAgICAgIHJlZ21hcF9yZWFkKG1hcCwg
QVNQRUVEX01QTExfUEFSQU0sICZ2YWwpOw0KPiAgICAgICAgIGFzcGVlZF9nNl9jbGtfZGF0YS0+
aHdzW0FTUEVFRF9DTEtfTVBMTF0gPSBhc3QyNjAwX2NhbGNfcGxsKCJtcGxsIiwgdmFsKTsNCj4g
LS0NCj4gMi4xNy4xDQo+IA0KDQo=
