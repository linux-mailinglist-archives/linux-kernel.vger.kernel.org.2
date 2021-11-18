Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD9455F91
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 16:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhKRPez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 10:34:55 -0500
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:17317
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231459AbhKRPex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 10:34:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbKq/CQBu35dGQNBEaI40sduJfyvCw36Hl188Vxc6YWYEa1m3EVI+DkPA5XxPRAGWRmJUI4EGbwNtbplH7rQK8ILgXoj7Yt1oKKIgkvzonYGNKHJ2RSFhzgxplG0syGOiNRTvnZFwrSMsYUXYcF76AtbSSGNca2lZxQ4AtRmmZ+SQ7tv1nF7p3th+SIBZqKzHzchvi7cXqjdXTQW/d8/I7Avil7f8jN+jjSCV15sxGPNBmhrsPOfYPOWc/n1ApQZ3DYSOJ8qFBqzfp5L6klQGAdCo0soRFXyTmGCXHu0TDB5sf5fWfxqAzaNJA5B/LfqCOeod1OvECsYsBvWzW1uDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFwzKl0lOcFjpUpWeSEObuvphABMcU+U+StjDxsCzcE=;
 b=D8v8AyDd2UUbRHrQ0OzigNxGTRxBzSu457BWGlcPUb+oIl8lUZdtwIbGj2mtmcWA/ZWjJCDZ3j/wM4h8N9HH7HEHMepHiOGn2WL6SvIXg3mbwMtiPwgn1J2mjGnJqkaadQPA0LSXXZxlA1hsi7d7gyjD2+9RVY418oSK9DPqP9XgJL/g0VLzi8RvTcmNaKGE9VAVAa1Ign93k91XnzUqHTNVBh6GIEBFwoZUczcxAoXSNwBaCxH4cCCviWg6od76lGi4VHx5ibHryoMt7tOU9dKbyJAQhplZMumHPwOnjt0tQHbIe3XVUW2EWdAEwda9h3GrQXTXHuUf9RUsKq8sOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFwzKl0lOcFjpUpWeSEObuvphABMcU+U+StjDxsCzcE=;
 b=LBn2n43tLqK/pAhum53Mj25YaZe7pxH5TMq2wz33XURQKaq4H3/LWAnZwBB2aYaFcHoiogCudX5sPlN2BuoNMsRr1SHO8G3YJ3P0Wj5ROPLf3SQVcOGZoFOjt8ZzleiC/dYumMX2vhd8uHrGEBh1KIXUKX0B3IW/oUuPAb/BGx0=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2939.eurprd03.prod.outlook.com (2603:10a6:7:59::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Thu, 18 Nov 2021 15:31:42 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60%5]) with mapi id 15.20.4690.029; Thu, 18 Nov 2021
 15:31:42 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] regulator: irq_helpers: Allow omitting map_event for
 simple IRQs
Thread-Topic: [PATCH 1/5] regulator: irq_helpers: Allow omitting map_event for
 simple IRQs
Thread-Index: AQHX3HI6MytkM7P/n0u2D9VuZauhBqwJSUqAgAAbpwCAAAHJgIAAAyAA
Date:   Thu, 18 Nov 2021 15:31:41 +0000
Message-ID: <a6c56e79-82b2-8572-fbce-4e4bbdc1774c@fi.rohmeurope.com>
References: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
 <2a5d9589c1c76ce537f795ee0aa6d3a7a6093283.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
 <YZZWh1aIg7TAdOUX@sirena.org.uk>
 <f5a5cd1c-763b-4dc1-e40a-dafbc47a1eaf@fi.rohmeurope.com>
 <YZZvOdci9Y9p1gJq@sirena.org.uk>
In-Reply-To: <YZZvOdci9Y9p1gJq@sirena.org.uk>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9919538a-b10b-4e8e-3782-08d9aaa88585
x-ms-traffictypediagnostic: HE1PR03MB2939:
x-microsoft-antispam-prvs: <HE1PR03MB293945AF212049D750C7D609AD9B9@HE1PR03MB2939.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZIdlLF9sSQjs6dP3VhwL+iD7VgaUiyow6LcqNDqtRX7YSl+q9uoSDJQt1bZieIWePM1EaeibNIKneFRa9RqO9YPDVF8uqy15lmlmriiaFgzn/CaqqexeTB4wvQfei8AfyvnkXU1iHJWRfSLRLlUdD0LQt+kVnzpwf4fCSHyW6LEXBhN9rgCDe/Ma9f/BabYhn7RdexwFRRBKRH6j/ZqKTZBenvKcuxffDY9NwyVlW0zRx7r0K81lzn+f7EI/rA0IaZMNX6dBR1jHcrHvdNjhvDXRndQuD57cA7UU5shVlTTAxIfUj0M5kbFo5sclPcCv7TcfiE133Yl60FZoX+bN5xhTTvKEm0xFnSXoxRfNdsr/yr3HHu4Uiy9YDB9RRBj2ZZ3VzM+zOy7zvWsxTr5ItvW3+jOVuUp6GaD/XrL1rJSwj9Nrcg9FeesLY+6EXI+AVDjBe+hct6oXiZ3u4d4tWXjrRZp0Lant+/UmxN+uGuGvaZBYnw6FZaYxOHvJmZPS+TbNobLXs+/twmlBK7vNYXj1zK/a57RIp2lO0CZuqPXjPrFAn8ZieHXA7nKW5sZfd2gFMdcU4GCxtCBDWGwjVJMPu+PSQuLr5zsQa78Zydp+u0HoguMullomSaYKyF/nudlXNW/p9nArn9Eyg8NN2pD6gmTvobS9rNdCkoXsn/B6TF6bsPooiM/vhTj2iYo4aXS07d/MVKhc3GAQ3bBmWlqSx+HHcFgLA9MXQOXwKCAzVtduiK1qtRdG26fN7bBcay6DF7BPPn3oxIolztfK3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(6512007)(316002)(64756008)(4326008)(5660300002)(54906003)(508600001)(186003)(31696002)(83380400001)(66446008)(38100700002)(6506007)(6486002)(53546011)(66476007)(8936002)(66946007)(2906002)(6916009)(2616005)(76116006)(31686004)(38070700005)(8676002)(86362001)(66556008)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzcrcVplV0hja2FzelVXRmw4ZzV2dVRXZDFVNjBDYnhjUC9nOEVCSi82QXQz?=
 =?utf-8?B?Z2p0ZGp1STA1Zzl1TzRxbTJHemQ1MEt3bTJRbDE2Z0FFL0hjQkRHRzdhcHRt?=
 =?utf-8?B?MkVsSzNIazJsQmVsZXZpYkxSZmRXc01zZEovN0JvaGVmZlpZV09mcktJUnhh?=
 =?utf-8?B?L2lQRi9tNVgvaHQ5WUlJd0Q1Sm5BYzF4NHNmSTg2UGhwN2ZwQ25FVmhpZFpl?=
 =?utf-8?B?MzBtczlyWUlkbEx6cVBMZWI5dkhWOUZ4NElCSlpuNElDVld3elVnY0IzRURu?=
 =?utf-8?B?M29yLzQ2Mk1NM3VrOXA4elNYTDhxL2JCZThaNVNrK1o0R0lOU1NNTGZ3UjFY?=
 =?utf-8?B?OXBvR3AzNFlVUnFEV2dQRnRkSTNYMGRzZkRuTDRQYXZNMFd4aFgvYlIxTXRO?=
 =?utf-8?B?b00zb01OQk1Sb09kM0ZROGdwYlI5UktxTFYwRVNETGJLbXEvcFFod0lSMk1J?=
 =?utf-8?B?ZWFBRm9hb3R3bC9rWFREZllUUGpyZ1p1NENFQmxhVWN1eUVIWlNPbUQ1Rm1o?=
 =?utf-8?B?RzAwd0czc1pYWktrbkZGTG5rWkZEMG9oamMvankyQTRpUlVoWjRYVVpocU9p?=
 =?utf-8?B?azk5TEtHb3gvY1NYTm1CZU9iekVRWExseXVzRkluMUp0bCs0SHRKMGRyL1FY?=
 =?utf-8?B?MCtsL2E0anRMM3B0UTZkS3FLZDJRVklWT0dMYW1xcEtpdEI2ZlFLQ1VUN2RS?=
 =?utf-8?B?RDJ0OTRJdEQ2aWt4RkJ0Nk01RndlTHRqOWJsOFFVRDRXRFk2WDhURTVtTmFO?=
 =?utf-8?B?dTR3NTEvU0ZraFZqR3FCY0dXS3NqS25DblFZY3F4UytIMmFhdHY5dmZzNG1Q?=
 =?utf-8?B?ZmhlakF6VUhNVlFZbEczSU1HQnlPb3YzZVNlNFZDVzhBdTdxbGMrNTRVQ0I4?=
 =?utf-8?B?Sktpd3IxNmlTUW9zcjg2bkJIVEJIUGhjUExnNkdHUy9HNUQ3QS9oZmJPLy9J?=
 =?utf-8?B?b1U2RWtaNGYySnBvaCtRM1dhZ1d2bmd5cXd0c1Z1eU82a042N2laMjUvV0VO?=
 =?utf-8?B?MzBDb2RGWnBVYWJqNjFuRXJtSk1lY0IxK3o5YVA0Sm1DaWlkQzJvdGIvNWln?=
 =?utf-8?B?WXowY3JJZHV1MGRzTS9kdk5CTUlZM3hyWlBtQXRDNDFuVTJEY0lVOUdoTU01?=
 =?utf-8?B?TkdiZGgrVFhiWEEzcjg4U2hwZUs0K2ErK3ZwOFFMTGs5SGhKK2VDdW5hY2Vw?=
 =?utf-8?B?aWQ5TkZOb0hEajJOeGFJd01KdU5jRnpmQTE4cWxFSTgrcEgwMWtQd2pwS2NH?=
 =?utf-8?B?QU5PS3lmOFpXZkswOC80Z3hBaDVMM05qQ3FYVXlDc1ZqYy9ZSitxazdvanJZ?=
 =?utf-8?B?MWtJZ21EZnNINWNCWnBwZ3VEYmYyUEFSWmtKRCtSRWpZOGpBMUZKcTJVeU01?=
 =?utf-8?B?WTdEUVIvMTVzODEzbUk5eE5SNWU5QXNuUTRlcU52WDMzdkMxZmhrWDJGV3d0?=
 =?utf-8?B?ZDBKR1BGTE8vemJIQzZoUlMvTWs1di9tZDVOS2ZCTXU1eE5UVVZJNExtYWg3?=
 =?utf-8?B?TDNEcG0rdno5dXRCaHh5ZVRUZFh2OU5ZZUxkQnMvT20zcGZtQUQ3SmtSSWVL?=
 =?utf-8?B?NmhqVDVGUEw1RjhNWlpJYnltMWttL1pzL1BrNlViSTA1Ui8wdEFnSFFvYXZJ?=
 =?utf-8?B?Q3pWbTBGcG1XT1RiWTlZOWkrOWNjZ3FiM0RMdE8yRThyOUh2Z3RlWXZ2YU5x?=
 =?utf-8?B?YnNWNi82RXYwZHNBaHBCY295TDM3Z1FreFk4d0JFMmtsbkJHRTJwSHRqdE83?=
 =?utf-8?B?WlRqRklram1HMDZEVHFIVGNMVFgwN3g2Y05zUzRMbFBuZ2xPSndqN25KUmNm?=
 =?utf-8?B?UG5ZcjM2eXVIajNiYk5RR2Z4Nml2N1oyWlJNWVh6L29XT2JDdmNGUWhJMXJj?=
 =?utf-8?B?SjlkRGQ3aGZHeWl5Nm45MVdRMjVmVXZTRGRLYUF2OXVoU1M1dFpIQ1Q5VFBl?=
 =?utf-8?B?UEM2NTdHdXdlb0VBOUNEdFpsaHRiZW4rc3VyUlhVc3ZSbWgrTHBVZVZXU2hi?=
 =?utf-8?B?TTFkNUFZeXN1L0pyenhmRWxnZ0tlMTl2eUg5Q2o4ZzlQS1FNWFIyTGt2Vlpi?=
 =?utf-8?B?QkpVb0ZqUlQ3bXZicS9WaXhHSlBVZFhKQi9WNVBIY3E3N0lYNU1SOW9zaTg0?=
 =?utf-8?B?SVdVN0wvZFEwNmMzM3o4MWdmeWlCUlluUkhRZHUvQTF3bkFOOGlKRDRkVTRR?=
 =?utf-8?B?eGFzZms5dUcrejUzNjZOU3QrZmpsSFc1Uk5jSkFDTi9EMlZMWVlkbU15T3Yx?=
 =?utf-8?B?SE8vWnozNXJBbEVta0ZaZG0xZ01IZ3Y5VXRhdndvRm12RGErNzgwMVBhL0RX?=
 =?utf-8?B?aFJSWEV3NGIzdmlrVFJ2c2tCbDBPb0Y1YUplK0JLSEo5TlBCRWtPZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EA1A8D71C363845960C1B357B7EC0D0@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9919538a-b10b-4e8e-3782-08d9aaa88585
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 15:31:41.9304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcxURlnm/fQyxnqjCuYOXXz+zAJpxPxIP2ZvmXFpvVs68k4dIb4yXtzzMnhQC2QrAG3eC1W6c35oIkFhxIg82zEryZjUmvBwb+LKUIfj/tPtzCJASOt1khx2QdJslWNE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2939
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTgvMjEgMTc6MjAsIE1hcmsgQnJvd24gd3JvdGU6DQo+IE9uIFRodSwgTm92IDE4LCAy
MDIxIGF0IDAzOjE0OjAyUE0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+PiBPbiAx
MS8xOC8yMSAxNTozNSwgTWFyayBCcm93biB3cm90ZToNCj4+PiBPbiBUaHUsIE5vdiAxOCwgMjAy
MSBhdCAwMTo0ODoyNlBNICswMjAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6IA0KPj4gbGVhdmUg
b3V0IHRoZSBzYW5pdHkgY2hlY2sgcmVnYXJkaW5nIHRoZSBjb25kaXRpb25zIChvbmx5IG9uZSBj
b21tb24NCj4+IGVycm9yIGFuZCBvbmx5IG9uZSByZGV2KT8gT3Igc2hvdWxkIHdlIGNvbXBhcmUg
dGhlIGdpdmVuIG1hcCBmdW5jdGlvbiB0bw0KPj4gdGhlIGFkcmVzcyBvZiB0aGUgbWFwX2V2ZW50
X3NpbXBsZSgpIGFuZCBwZXJmb3JtIGNoZWNrcyBpZiBpdCBtYXRjaGVzPw0KPj4gSXQgbG9va3Mg
YSBiaXQgc3RyYW5nZSB0byBtZS4gT3IgZGlkIHlvdSBoYXZlIHNvbWUgb3RoZXIgdmlzaW9uPw0K
PiANCj4gSSBkb24ndCByZWFsbHkgbWluZCBlaXRoZXIgd2F5IG9uIHRoZSBjaGVja3MsIHRoZXkg
bWlnaHQgaGVscCBzb21lb25lDQo+IGJ1dCBvbiB0aGUgb3RoZXIgaGFuZCBoYXZpbmcgdGhlbSBi
YXNlZCBvbiBhIGNoZWNrIHRoYXQgYSBwYXJ0aWN1bGFyDQo+IGhlbHBlciBpcyB1c2VkIGlzIGEg
Yml0IG9kZCBsaWtlIHlvdSBzYXkgc28gSSB3b3VsZG4ndCBtaW5kIGlmIHRoZXkNCj4gd2VudC4g
IEkgZG9uJ3QgcmVhbGx5IGhhdmUgYW55IG90aGVyIGlkZWEgZm9yIGRvaW5nIHRoZW0uDQoNClRo
YXQncyBmaW5lLiBJJ2xsIGRyb3AgdGhlIGNoZWNrcy4gSWYgdGhlIGNhbGxlciB1c2VzIHRoZSAN
Cm1hcF9ldmVudF9zaW1wbGUoKSAtIHRoZW4gdGhlIGNhbGxlciBzaG91bGQgaGF2ZSBjaGVja2Vk
IGl0IHN1aXRzIGhpcyANCm5lZWRzLiBCZXNpZGVzLCB0aGVzZSByZXN0cmljdGlvbnMvZXhwZWN0
YXRpb25zIGNhbiBiZSBkb2N1bWVudGVkIGF0IA0Ka2VybmVsZG9jIHdoZW4gbWFwX2V2ZW50X3Np
bXBsZSgpIGdldHMgZXhwb3J0ZWQuIEkgdGhpbmsgdGhhdCBpcyBzdWZmaWNpZW50Lg0KDQpJJ2xs
IGNoYW5nZSB0aGVzZSBmb3IgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMNCiAgICAgTWF0
dGkNCg0KLS0gDQpUaGUgTGludXggS2VybmVsIGd1eSBhdCBST0hNIFNlbWljb25kdWN0b3JzDQoN
Ck1hdHRpIFZhaXR0aW5lbiwgTGludXggZGV2aWNlIGRyaXZlcnMNClJPSE0gU2VtaWNvbmR1Y3Rv
cnMsIEZpbmxhbmQgU1dEQw0KS2l2aWhhcmp1bmxlbmtraSAxRQ0KOTAyMjAgT1VMVQ0KRklOTEFO
RA0KDQp+fiB0aGlzIHllYXIgaXMgdGhlIHllYXIgb2YgYSBzaWduYXR1cmUgd3JpdGVycyBibG9j
ayB+fg0K
