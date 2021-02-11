Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6900331859E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 08:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBKHRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 02:17:06 -0500
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:21280
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229674AbhBKHQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 02:16:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiGm1KQhsLwKHrp6nbZecpCXW4DH+3tF2bAc3i1Vj/B+cazENRXXLfUmePdq2cHCAJwHhiq5OORDgkAXDzUqXHYdoC2GAPbmlr5ykYQBxJKjxI0H0fECL9P6Jg2JW45G8fxMfsS7fC/MocAkAXQ53FnPdd7ucHY0yvbLFKlfShN1E2U5yg+Zyd7YcN6NIbeepC7gehIDDZVihCaZgEgdq1ysBNx17VRjBheFT76ISEfXIr+Alicp4MceGZ9iMWyBv4PV1HghCf7xvtPpK1h2yboxdDwMz1k1dEpj3Ns8f27zYrbGGizG+UVvupduYqQHCeBi6QYYEBiD9kJjss2e0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqp/fFHZzR0/LLvCcC1t6qv0ftEgJEcDxbSjANxLJ3E=;
 b=gig2mzpepQtOMOrEkyw+KYhkc/SJ2v2FU0HBL+RRzQ/6ZPi6wL4q9ZnST02sQryDcgkjC22cRnrFhm0gfjd8Z/vT/zZYck9zzgsQdhfly/T2O5yGEiPJTHph64PU5vi1AJq8PWFiY+h1J0YeyOieN8ixzMYfuzLZW56MLNIPWmTHGziK9Gxye9ql2aWaNDYfsoDsOV3vcjajcU/U5U4u2WxWTIuh3zWpnSVwg5hRQjbNHZhRdJjKBpA0dRNLCQqRj3LIynFNn+IkTlKuIi3/DhCYk8oWIMp/Pm/2LcXRDHiNAA//Bm5mdUZ1fwk9l894knp5ih3UMXVmFhiA44yzeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqp/fFHZzR0/LLvCcC1t6qv0ftEgJEcDxbSjANxLJ3E=;
 b=BjvNvomRzBoQbGRQu5NEIE2gyyEGNhohDLajFsJ08YpC3LOD1J7EZDsp3xMP2AKoos80M5+7DhtBpdr7H7JwSnBfqoz9fwwPCjUAhvPV+Tv8hmKvTmKnzOFlpVNxTGnYDK96NcMXNzK/O7JFhXFYJ9+OhLbcOrHLkHmXUe921yQ=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2316.eurprd03.prod.outlook.com (2603:10a6:3:2a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10; Thu, 11 Feb 2021 07:15:54 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::c18c:4a01:ca24:78c1]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::c18c:4a01:ca24:78c1%5]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 07:15:54 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/6] mfd: bd9576: Add IRQ support
Thread-Topic: [PATCH v7 3/6] mfd: bd9576: Add IRQ support
Thread-Index: AQHW8MuY+upTtJ7qjEOP1qCzl5FM3A==
Date:   Thu, 11 Feb 2021 07:15:53 +0000
Message-ID: <b72884f9432e9f16d2f03c10011dce5557cbded9.camel@fi.rohmeurope.com>
References: <cover.1611324968.git.matti.vaittinen@fi.rohmeurope.com>
         <8489e5d34a6ae26309772f7cbffaa340fbb6c34e.1611324968.git.matti.vaittinen@fi.rohmeurope.com>
         <20210209152538.GB220368@dell>
         <bd59188a1aa360385edf33bf14de5e82ad60a766.camel@fi.rohmeurope.com>
In-Reply-To: <bd59188a1aa360385edf33bf14de5e82ad60a766.camel@fi.rohmeurope.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c872955-405b-436c-ef89-08d8ce5cdebd
x-ms-traffictypediagnostic: HE1PR0301MB2316:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0301MB2316CBBC713491822C5FF9DBAD8C9@HE1PR0301MB2316.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndbg8eJhInIPtKjbWjIi5dhC4fkN8ITI6yHKzR4M+7pJ8Yo+FtJFlVx7eEYzyOkYy8FGq/bocaB8Bg+4cNIx6BNg7TTdk1n7p339gMxjhrhNVqKrgDKxLjWE1yv6hTehfce+ksHvwGEDJa1hfruCLBRw3MlYadTJ27t9XtBPYFpi6OI7lu9ysl1uwwzKXBd1JnxDrPE2Xx8fT85uQARRNPdcroLmTmHUvYQc5faPUk3Q0KsZ8ozlfOv9jgM7TWjONXG9c0IrsG0z2Sxc/nGy+wqg4Yg/ElYqeP0efy4Txt6s5Q6wiWWMHcNj1l7rZmDzPHd5XZnxHmEm1iNggLWiIOMmLuGG9tYK/ta9Jtmc5pwmVyf2iO7v5vbM0C9ylRqtdEuEhoCAXWzGjWKdDtg81giKk1XrdF1wChhK7G5MRFZwkM4zgk4vEWpAkqYNE+wuSZGFpXgtHrBlP9sAEsDJpjbUAgAPv7yOVNDtpedsE2h4pta2/0ZxlJxXroi7jqn4CqamgaWmys7330FFKTTYrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(366004)(346002)(136003)(376002)(2616005)(186003)(6512007)(478600001)(2906002)(5660300002)(64756008)(6916009)(66946007)(76116006)(4744005)(26005)(316002)(86362001)(71200400001)(54906003)(6486002)(3450700001)(8676002)(66446008)(8936002)(66556008)(6506007)(66476007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VEhaeG5JYSsvSmlYKzU2d1JDNFlsc3pzU3VYNXpqRForb1NENUVINnl1QnpF?=
 =?utf-8?B?VXFaMkNIUWx5bFh2ZTZUa0lpOVovQmVCZWNsTnVKK2JNN2FXZ0tFYVZVb003?=
 =?utf-8?B?aWJBUmZZQ29SSjJhYzJyaVpjTmVXRUR4UDkrVERseFhRZkR1Wm9DTlo3S2JE?=
 =?utf-8?B?UHpnenVYa0pMZzhTM1p1Vmlia1BJdk55akFoUEFjZm8zTTF0TlRnM3hzVndi?=
 =?utf-8?B?NS9sYlRZK3FpZ09jL1NLbFkvcWVxUTZvZWhnUksrVUVYcXFiRThTajZiTGJ3?=
 =?utf-8?B?dmdvVGtDOEVEK3JkUFlHZGs3TnBYNUJlUkozTHJ0YWtUT1U3bHczR3BrVTFh?=
 =?utf-8?B?aHFaL1hmMThDT1hGSjgvR3I5OHNqVldVL1ErUzUvSWdkLzR5MGtNL1o2d1c3?=
 =?utf-8?B?azB2dTRUSzJWQWt4QVhLcWVQMU9HU1RoY01odXlacHFPVWU3WEZkdFVKNlVG?=
 =?utf-8?B?UEg1VnptRHhqQmtjc2t3T1RvTlYxUVozNElCMEEwWFFIalF5YmFJbmdiQ1hW?=
 =?utf-8?B?MWZRQXN3bzZ1SFlrSUYwRjJiaC9VbVJaRmxPc3ZtdEpmcnI4a2FVT2Q3Z2JQ?=
 =?utf-8?B?UGt3dHZuazQzcVlsNmhuY2RxMS9MNFJKYnNObmxUcEQydFg1VHJaZzVIblJ5?=
 =?utf-8?B?M0l6YnlreStWQ004V29PSlVhOWVvd2lIaXBWcU4zcHovbk9VQ2VqbUdoczEv?=
 =?utf-8?B?d3VLd0ZsTTlRaGREUmpkN3FrbjQ2N1l1akRPeDY5YlF6eFZ5SXdNRFEvNGdn?=
 =?utf-8?B?bjNjck5NWlVFVHFON0crRmYzZ2oyMlE1MnVHQmU3eWhsR1M4L2xSUmlyWEs3?=
 =?utf-8?B?cEhYL29sbGtDTTVFSDVOcXgzZEVDeWFSYXNIUVR2UEwrd1hmWlZQalZDRm1N?=
 =?utf-8?B?ODJ3TWVZM3diSU9uZVc2TXErcGNvdloyRHNCSUFRVEdUNThKYWd3Y2o3Szdh?=
 =?utf-8?B?eE5GcGhkS0sraHdVRFM0ZnF1eFJMQ0lLTVdMNVpCa3hMaUFHTG82NVBFTlk3?=
 =?utf-8?B?UjRRbXZaVnh5V0gvR0o5SllMVjR2MkpscTIzcDNIVnVnN3ZCMjdBZFpxUUN1?=
 =?utf-8?B?L2NCQzJWYS9mSTlLYnFCSEdKWEkza0FZWjBpUWZHZFU4R3R2cnZlR2FEa2lT?=
 =?utf-8?B?eDlaK2Y4S1JVY29vdjRqa3V3ODN6ay9STlVrMHlvaVhuZ2pERWhsY1dRYkFl?=
 =?utf-8?B?cktBc2t6NVkybkxVZ3VYZVI1QUppTldueWFmRGh1T0dvY2FkcWRHc2p2TjFw?=
 =?utf-8?B?aWMrS0FWV3JaN0Y5dmFLS3d4VDBBNzZTRE9HOHRKNmpJMjlqV1RrbG9leUtn?=
 =?utf-8?B?bGs4cEVNR3diUTZIcXJqQmtETmlxZ3VSRi81cXpoZUx6NFhBZkF4Z1BIWStK?=
 =?utf-8?B?WTVsYnkrTkkvOUhqcCtJcjNpTTdlWkVTdXFyd0JtK2d2cEJ1TjVBam14dGIw?=
 =?utf-8?B?VG1GQ09IYTFZbk5XSUVack8zNkowcm9HT1c4V3lDdEdvVVdEV3ZtWGhjanZa?=
 =?utf-8?B?Njh2aXBJUVFuZVlwN0tJM0xIY1pESE5JL2RBK25LRitYc3VIb0FkZTlpR25D?=
 =?utf-8?B?b1hxNzNScTZTZkwxLyttVEk0SDNTdE9BbjczS3hGZGVUQjV6U2NIWmhqcG5v?=
 =?utf-8?B?aFMwWTY1MlIvUU9aajMwRXlmbk9JeFNRWUVud0p3KzJETEErMEczV0h3ZlUw?=
 =?utf-8?B?KzhSaWJMUHR0QlRLRFZvalZlTC9kM280M09jZVB1SllXNHNwK25zLzByTmJv?=
 =?utf-8?Q?+sVExUoA+PHk9v7pMz7brhTtrN2YgxN2WCzNvH1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C643AF4A6C1D8498AB028604F200090@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c872955-405b-436c-ef89-08d8ce5cdebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 07:15:54.1118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4fq9Nni/RT9yg1i7lt7WVx6Ve+pul2ydTpEwvRLLlHIcnxCzWAqYAQpGQFDCAgndtuDP1FtovjwFEq2s+iGLyawy5nqJ0nJMGWwnovID8WS1Tdr+UUtPksgIlgYWBWC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2316
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQWdhaW4gTGVlICYgQWxsLA0KDQpPbiBXZWQsIDIwMjEtMDItMTAgYXQgMDk6MDEgKzAy
MDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gT24gVHVlLCAyMDIxLTAyLTA5IGF0IDE1OjI1
ICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+ID4gT24gRnJpLCAyMiBKYW4gMjAyMSwgTWF0dGkg
VmFpdHRpbmVuIHdyb3RlOg0KPiA+ICsJCS8qIEJEOTU3MyBvbmx5IHN1cHBvcnRzIGZhdGFsIElS
UXMgd2hpY2ggd2UgZG8gbm90DQo+ID4gPiBoYW5kbGUgKi8NCj4gPiANCj4gPiBXaHkgbm90Pw0K
PiANCj4gQmVjYXVzZSAnZmF0YWwnIGluIHRoZSBjb250ZXh0IG9mIHRoaXMgY29tbWVudCBtZWFu
cyB0aGF0IHdoZW4gdGhpcw0KPiBjb25kaXRpb24gb2NjdXJzIHRoZSBQTUlDIHdpbGwgZG8gZW1l
cmdlbmN5IHNodXQgZG93biBmb3IgcG93ZXINCj4gb3V0cHV0cw0KDQpBZnRlciBoYXZpbmcgYSBm
cmVzaCBsb29rIGF0IHRoaXMgSSBzZWUgdGhlIHdpc2RvbSBpbiB5b3VyIGNvbW1lbnQuIFRoZQ0K
SFcgcHJvdmlkZXMgSVJRcyBhbmQgaWYgdGhleSBhcmUgbGlzdGVkIGluIERUIGZvciBCRDk1NzMg
ZG9lcyBub3QgbWVhbg0Kd2Ugc2hvdWxkIHN0b3AgaGVyZS4gVGhhbmtzIGZvciBwb2ludGluZyBp
dCBvdXQuDQoNCkJlc3QgUmVnYXJkcw0KCU1hdHRpIFZhaXR0aW5lbg0K
