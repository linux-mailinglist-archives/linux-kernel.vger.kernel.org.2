Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD1F406034
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhIIXop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:44:45 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56690 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhIIXoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:44:44 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2EE78C10CF;
        Thu,  9 Sep 2021 23:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1631231014; bh=jaeA4Q2oXxgWqELNXaeRD3obJpVdYhHM4Dh6Tw7ORBI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=h0GRRAZvh+dqMYifNh5c1t86OABhIu6bkSQa8qOvpCuK6kt1RZEtA2flkQlqzkg47
         afavlT6Tb1FXNU6+YEU/q0+9UGPAkTZ8clkH6zUHaEEIZNwrK1ZXSNvXjIArMPVaRa
         w+aVnFkRRCWzD8IoNO0iRl1wFj2RJ4CfgcxZFvuG9qcBTEKhjEPDobDleuPWWE8iTo
         ykyuVGuTVNVbOWjHx8Kj/a3ECuEUfAUmiGuYk70HbJ3hSdJwy+p4p29JIQsikGZ9CL
         uqh0KxOy283EikPv3Dx9sOw3Szsp1Ikz0S3vMZvlLZRT0QZutJdBQcC+Sel568tRh/
         zWGwCQgNLumtA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D3EDBA0071;
        Thu,  9 Sep 2021 23:43:33 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8B8F3802EF;
        Thu,  9 Sep 2021 23:43:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="pUNYAJPb";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzwZ858uITBpGeFLk8VYG0X1XocgLjiDWtK4wtgkhPsqhWrRuc64RV2+P5D+RULiCm/njpsq0oIVmpHcGMNNxY2CXa8JTh+Bg/QDA+RvP2igqUF/bo0pA+5Vxfkp2WrYw1zJCDDpyb3U64MKiVN9i2jfcixnuJfiB71PQrJYRJeVhcu8EmS0zOSpj0cyUfCNMn5IN5xQvnFGnStKMUg5xiArXqC7Aewq+oT6Bb3WGdGccAIABKpWKxB6dTiRWQNN/pNbM3qOffEpfqhTbj8h4z5V5ONL77jzL3xskyewZhTADc7rKqaTj8eqbhmrAScLGLtyOWuDUYNyhu4BMgpquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jaeA4Q2oXxgWqELNXaeRD3obJpVdYhHM4Dh6Tw7ORBI=;
 b=HaOKDR0TrId9m2dV1RVFgShBHcYFDugeNBKg6lT6rEVtRm/JS6b1RXiIiKJ8xWxWY/SkoXyGeLUvTEqvBbvfjh4UaAtZv/t0gybB+CEbZSk/Orn6yE/beOQK7ovvqDLjTDDdph/j82rgQHxJD1A+HnAxPDUr3q3RliHSTzMl0mrz8kcNefJA33KuQYsvede9SdyaHzvvZVUYzC2HhfNJ7nY3WULHVuIPd9SbLx3U8gA5wiE6qfwuGlfF/HHPGK87uP6kmhnJW3yG8iSZZkpoFs++Xka6kAjBawvOIoXE2FleK7vuCeFcrvvrHJtn6ud7e2pRGOMgG4VYKf6azaIrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaeA4Q2oXxgWqELNXaeRD3obJpVdYhHM4Dh6Tw7ORBI=;
 b=pUNYAJPb0SxGuAU3HJOhIkZliJsL2yTtT3wEqMZJXwzlx3B2I5hFYo/u5ygvyq6C0lo+caQslYyyOl6qvg776ICAGJFQrvZHLDOf+8bgz55WqrKqQRm07Ehbxtce10/cd6C+5mTKIx9nREUnLgXPnxiO8ZNVD8xMXAy8yRSmhzg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB4710.namprd12.prod.outlook.com (2603:10b6:a03:9f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 23:43:29 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e%4]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 23:43:29 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Shantur Rathore <i@shantur.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: fix endpoint direction when inputs are more
 than outputs
Thread-Topic: [PATCH] usb: dwc3: fix endpoint direction when inputs are more
 than outputs
Thread-Index: AQHXoxf7R3wBqqczlkKmtu+9UCfOnaucYsoA
Date:   Thu, 9 Sep 2021 23:43:29 +0000
Message-ID: <6305c1ef-12e6-781e-3235-cd206d5b2b62@synopsys.com>
References: <20210906120836.4596-1-i@shantur.com>
In-Reply-To: <20210906120836.4596-1-i@shantur.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: shantur.com; dkim=none (message not signed)
 header.d=none;shantur.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdc94483-80f1-47e5-7e7d-08d973eba064
x-ms-traffictypediagnostic: BYAPR12MB4710:
x-microsoft-antispam-prvs: <BYAPR12MB471065CB10F7716C8DE8351FAAD59@BYAPR12MB4710.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RJ8SO5vkAPDeaYnLwq5TK75ZqArytHHDSB8yBdu265WkaThlTBM/6mKDomkxP3jExB9knr4oQQncJo7vSIxHf8XOg0q8FZHv0xQrRZQhDU3bsVNqvkpNQnbx+LqLwEjfb6rtzt6RBf/+HFdwtJ5l8pnYgi+GAbmml6fKbeSabtq1/RgNyjBcfzH/zARErLyFngPp/ATyQkHgrowSiE636R5k1oA4RuO9ub+8sU7b4R/U9UuX2waFV0rukkqMWmeJvCDYe5Z992k8AIlXTAANf5kRX/sY1pxKMtyxFdlz77rrEIiyA0t6jZd8jbH+RIeAiWkOyMEHMBHqe66mWCDPV8Nj6r1YLzqfM2tyee8vPUyU5ix3Qc+rNPw8H/6vkuBXUCB9ZP991MnCg6wLQMUZzc9J8aDxP5DmOfmaDbuUPKHdUFlMzVt1OZcELs5/eGh1P1jMpN2Sma+L7YtX3//8AvN1ZYB5nQtseIX+r9xZNp0d9MH16nHpiY6sXx/1s4lnjcybwQNwx1+xH7eScDtdgL1HQnMTetKQUYjDhXzV/q+Q4ItsHk5PtPmWOhdq4O33FzJtBpi9JadkqM8LnUWGQV8zqNDHEuEhI3jjPr/v+Wf2o3LPFD7hIB7+vZ8AaMpCYDwGLjTKWe59u6WMu8zCH/ZQ/2dB8KxrpFgQt8b9XEVgnjVUwm4rSbwMuqRGKvRqOcDoNEC30PxkvWEdwLEoqkSRLQDxQcO4G9CJjieiqZxRd0e+pVBdG2/nLW52jvF0rXn3PyC2bbX3L5AM5Z63h1dyEo5G1OYcyhM45M5gOoStdNhz5fnoUYnXzjPyaTtntXYx+68FL2z3CNOZ+nuwILD18XsH/h6zs1LnaQ9Yep1FgbZJQmlT1OiNoozN9Td+2UOM8d3EJsesJVCSXqy5oQ6WqvtTFEKBZjCsAhteLSA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(376002)(39860400002)(66476007)(5660300002)(66446008)(38070700005)(64756008)(71200400001)(8676002)(6486002)(76116006)(86362001)(316002)(38100700002)(31686004)(66556008)(478600001)(54906003)(6506007)(66946007)(6916009)(2906002)(8936002)(26005)(4326008)(83380400001)(966005)(186003)(36756003)(122000001)(2616005)(6512007)(31696002)(781001)(43740500002)(45980500001)(473944003)(414714003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVRNaTR3RFQrWGdLSEdkZWpJM3FEajlXSm1ucVpqSUlWMnZ1L0poVGNycnNv?=
 =?utf-8?B?TlYyVWtRN2RMbEJOdGZPYnNXNzhLQk1lQ0dkTHQvK3l1NkRqc1lVZUVSdGVD?=
 =?utf-8?B?ZUZ2a2FJd0NCMFR3Mk1teWJwVGZNUUE3TEd3VnVSTjJrLzBWMkY2VGJLTmha?=
 =?utf-8?B?NTVDVzZLclk2aEd5cEZ6U0ozSVVVVzJ6dHk4VEhUandqSElkb1ZzeFNkZ2ow?=
 =?utf-8?B?NnYwMVRHUnRiUjJEb3RCb2MvVitWTFI0R21ZcWdBUnBhU0RncUdOZDI4VUxv?=
 =?utf-8?B?SEpucng0cjB0bmVKWEhsbjdjakJJaFA3V2p3K0pHL3M0OFcvb0FMdzFIaVQ1?=
 =?utf-8?B?cmY2bG5mYy9qTythb0c1ZU5nWXB1NFgvcGI0dEVwV2R4VytLajFwbU5GM0c2?=
 =?utf-8?B?ZUViSlUzS3J6QnlqRUZQcEZidkZVWW8wMTZwMzFDdmgvM1QvNXBFSHIrTDZE?=
 =?utf-8?B?U1ZTaTVGQmlrT0U0WHJDOUVudXdQZ3ovcWhCdXA5T2FWQXRuanhIaVRqTVVk?=
 =?utf-8?B?YXo5Wm1qQUljMFBoOXIwMGFTblZUUmkzM0hsbExoVzZPU3RsUEVZS3BxaHc2?=
 =?utf-8?B?S3FKM3BuQkE3RE9McTQ0L2h4NkVVcmdLL1VpQjAyTmJWY3RyakRka1NJV3NT?=
 =?utf-8?B?T2U3ZnEvZ1VEeUg5dUFBb1R3R0d5YU5pQnlIVjJlM2NXbzhvTFNyS09yOWJE?=
 =?utf-8?B?WHVkeVA4dlFSSzNLVit5a2JWZzVTQ25mSmYxQllFaUlDNUNsb1pzeDZTY3ZV?=
 =?utf-8?B?VXFlSnFxSEJHOUJpVk9mK3Eyc2RZRko2OE5OWnZQUHcyRlRpelBUZm13ZkZ1?=
 =?utf-8?B?QUdPZEhqbnZyV01BbUJtV2YwZVFXZm8zamtCNExqM1lSN0MvVVIyVXdjTXA5?=
 =?utf-8?B?a2t0TlpPcEpyV3ZPcXNSV2plNHRhZC91RjV4MFMwa3hORlhyU282dDkwcVNu?=
 =?utf-8?B?ZnEwTUxkTmtlVUlwOEY0S0trcEp0R2hUL0QzNG9XVXJnb3NkTTM1bHNRV1Nq?=
 =?utf-8?B?L0FsTjFZZFkyU2pZaUM2WGRWMVdtbUgyVmZkOEMyb2YvVkpNSFMrZ21zZ2Nu?=
 =?utf-8?B?eEdmejNlV1VxYjAvUVJtUlZvUUl3bE45aEtBMDUyL2JKRkRpR1VIUW5aTWcx?=
 =?utf-8?B?Tm45SnROSzZGZW1KR01uOGFick9iamQzRnpDaCtCaFdxOWpESFBDT2h3VHRp?=
 =?utf-8?B?VEl0Q2xJeWV4MC9ZdkgvR0dBTTEvVGhZZHpPNStwMS9iU2hFRHh6VUJZMXpy?=
 =?utf-8?B?R0lwWDBhY1Zza2NHZldYQjZOdnR4UHpwOVVEVFlDc05QTUt5NjdyRzRSMVJp?=
 =?utf-8?B?Rm1uZjdwbWduWkQ3aFlhajBlRllONzEyb1IraTNLZUZjWnNyZ1NqL0lGTVd0?=
 =?utf-8?B?aXdGc2wvaVVqUlpIUWdHQm16Syt5ZDhzeEhzbTBoc0Vxa3FtRXNVMkJiUmUv?=
 =?utf-8?B?cUcvakorN3NHdG96S1d3OEFHRjNicGxXdkNwWHJReDZoaVVBVHdYNXQrS2tM?=
 =?utf-8?B?dWxVSTR5a3BoSzRPNGgxS25hUU1LcXlUcUhMcU5QOW9SZWY2TFlZWFEzL0x2?=
 =?utf-8?B?MXFSczFlNjVicjFCeHVDaEdUbWwxVnhyc3ZCTE11RmF5RUFMcXRVTW1tYTFi?=
 =?utf-8?B?TnNseWhDbTdkYyt3Z1B4aW9vODVvbzdDZVIrNVROZTZiNEZ1UWJGc2ZCa3J1?=
 =?utf-8?B?K3B4bTdlampua3lXeGhUeFlFRkh5T2Zkei92d0N5RkdsWk82SldFcDhhb25x?=
 =?utf-8?Q?JTSeMJE55y/EaQT4FE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <37EC0E99EFF37C45AC0169504A106D0B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc94483-80f1-47e5-7e7d-08d973eba064
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 23:43:29.3436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwLlN8y14K6tAm8OgxGhRsemcfxqxk+a7+WwRMlCL9V/ut6NnhntHt3KcKtq3x7kiPLyAGH9nYlFWvTPNiCrAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4710
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2hhbnR1ciBSYXRob3JlIHdyb3RlOg0KPiBJbiBSSzMzOTkgYXMgcGVyIGRvY3VtZW50YXRpb24g
KA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly91c2VybWFudWFsLndpa2kv
RG9jdW1lbnQvUm9ja2NoaXBEZXZlbG9wZXJHdWlkZWxpbnV4NDRVU0IuMzE2MTA4MDZfXzshIUE0
RjJSOUdfcGchSnFZcjZVODdTTDNyWXlsaXJGNlcydndOekMwRnQ4WWlad1RsTVR3V2w3YnBhSEda
dWgtSk1mT3ZVYUc3ODFHS1pJQmQkIA0KPiApLCB0aGVyZSBhcmUgNyBJbnB1dCBFbmRwb2ludHMg
YW5kIDYgT3V0cHV0IGVuZHBvaW50cywgaW4gdG90YWwgMTMNCj4gZW5kcG9pbnRzLg0KPiANCj4g
Q3VycmVudGx5IGR3YzMvZ2FkZ2V0LmMgZHJpdmVyIHVzZXMgdGhlIG51bWJlciBvZiBlbmRwb2lu
dHMNCj4gYXZhaWxhYmxlIGFuZCBzdGFydHMgc2V0dGluZyB0aGVtIHVwIHdpdGggZXZlbiBlbmRw
b2ludHMgYXMgb3V0cHV0DQo+IGVuZHBvaW50cyBhbmQgb2RkIG51bWJlcmVkIGFzIGV2ZW4gZW5k
cG9pbnRzLiBUaGlzIGxlYWRzIHRvIDcgT3V0cHV0DQo+IGVuZHBvaW50cyBhbmQgNiBpbnB1dCBl
bmRwb2ludHMgZm9yIFJLMzM5OS4NCj4gDQo+IElmIHlvdSB0cnkgdG8gY3JlYXRlIGEgY29tcG9z
aXRlIGdhZGdldCB3aGljaCB1c2VzIGFsbCB0aGUgaW5wdXQNCj4gZW5kcG9pbnRzLCBvbmUgY2Fu
IHNlZSB0aGUgaXNzdWUuIFlvdSBqdXN0IG5lZWQgdG8gY3JlYXRlIGZ1bmN0aW9ucyB0bw0KPiB1
c2UgdXAgdGhlIGxhc3QgaW5wdXQgZXAgYW5kIGl0IHdvdWxkIGZhaWwgdG8gY3JlYXRlLiBObyBu
ZWVkIHRvDQo+IGNvbm5lY3QgaXQgdG8gdGhlIGhvc3QuDQo+IFRoaXMgd2FzIGNvbmZpcm1lZCB3
aGVuIHJ1bm5pbmcgYSByb2NrY2hpcC1saW51eCBic3AgaW1hZ2UuDQo+IA0KPiBbcm9vdEByb2Nr
cHJvIHJvY2tdIyBscyAvc3lzL2tlcm5lbC9kZWJ1Zy91c2IvZmU4MDAwMDAudXNiLw0KPiBlcDBp
biAgZXAwb3V0ICBlcDFpbiAgZXAxb3V0ICBlcDJpbiAgZXAyb3V0ICBlcDNpbiAgZXAzb3V0ICBl
cDRpbg0KPiBlcDRvdXQgIGVwNWluICBlcDVvdXQgIGVwNmluICBsaW5rX3N0YXRlICBsc3BfZHVt
cCAgbW9kZSAgcmVnZHVtcA0KPiB0ZXN0bW9kZQ0KPiANCj4gQ3VycmVudGx5IGluIGxpbnV4IG1h
aW5saW5lIGl0IGlzDQo+IA0KPiBbcm9vdEByb2NrcHJvIHJvY2tdIyBscyAvc3lzL2tlcm5lbC9k
ZWJ1Zy91c2IvZmU4MDAwMDAudXNiLw0KPiBlcDBpbiAgZXAwb3V0ICBlcDFpbiAgZXAxb3V0ICBl
cDJpbiAgZXAyb3V0ICBlcDNpbiAgZXAzb3V0ICBlcDRpbg0KPiBlcDRvdXQgIGVwNWluICBlcDVv
dXQgIGVwNm91dCAgbGlua19zdGF0ZSAgbHNwX2R1bXAgIG1vZGUgIHJlZ2R1bXANCj4gdGVzdG1v
ZGUNCj4gDQo+IGVwNiBiZWluZyBvdXQgaW5zdGVhZCBvZiBpbiBhcyBwZXIgdGhlIGhhcmR3YXJl
IHNwZWMuDQo+IA0KPiBVcG9uIGludmVzdGlnYXRpb24gb2Ygcm9ja2NoaXAgYnNwIGtlcm5lbCwN
Cj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0aHViLmNvbS9yb2NrY2hp
cC1saW51eC9rZXJuZWwvX187ISFBNEYyUjlHX3BnIUpxWXI2VTg3U0wzcll5bGlyRjZXMnZ3TnpD
MEZ0OFlpWndUbE1Ud1dsN2JwYUhHWnVoLUpNZk92VWFHNzg4REhKU1VFJCANCj4gDQo+IFRoZSBp
c3N1ZSB3YXMgY2xlYXIsIGN1cnJlbnRseSwgZHdjMy9nYWRnZXQgZHJpdmVyIGRvZXNuJ3QgdGFr
ZQ0KPiBEV0MzX05VTV9JTl9FUFMgaW50byBjb25zaWRlcmF0aW9uIHdoaWxlIGVudW1lcmF0aW5n
IHRoZW0uDQo+IA0KPiBUaGUgcGF0Y2ggYmVsb3cgZml4ZXMgdGhlIGlzc3VlIGFuZCBlcDYgaXMg
Y29ycmVjdGx5IGVudW1lcmF0ZWQgYXMgaW5wdXQuDQoNCk5vIFNpZ25lZC1vZi1ieT8NCg0KPiAt
LS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAgMSArDQo+ICBkcml2ZXJzL3VzYi9k
d2MzL2NvcmUuaCAgIHwgIDEgKw0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDQwICsr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2Vk
LCAyNyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4
IDAxODY2ZGNiOTUzYi4uMjc5YzlhOTdjYjhjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtNTU1LDYg
KzU1NSw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfY29yZV9udW1fZXBzKHN0cnVjdCBkd2MzICpkd2Mp
DQo+ICAJc3RydWN0IGR3YzNfaHdwYXJhbXMJKnBhcm1zID0gJmR3Yy0+aHdwYXJhbXM7DQo+ICAN
Cj4gIAlkd2MtPm51bV9lcHMgPSBEV0MzX05VTV9FUFMocGFybXMpOw0KPiArCWR3Yy0+bnVtX2lu
X2VwcyA9IERXQzNfTlVNX0lOX0VQUyhwYXJtcyk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lk
IGR3YzNfY2FjaGVfaHdwYXJhbXMoc3RydWN0IGR3YzMgKmR3YykNCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXgg
NTYxMmJmZGYzN2RhLi44OWEwOTk4YzYxOGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0xMjI3LDYg
KzEyMjcsNyBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICAJdTgJCQlzcGVlZDsNCj4gIA0KPiAgCXU4CQkJ
bnVtX2VwczsNCj4gKwl1OAkJCW51bV9pbl9lcHM7DQo+ICANCj4gIAlzdHJ1Y3QgZHdjM19od3Bh
cmFtcwlod3BhcmFtczsNCj4gIAlzdHJ1Y3QgZGVidWdmc19yZWdzZXQzMgkqcmVnc2V0Ow0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gaW5kZXggODA0YjUwNTQ4MTYzLi5kOWQxOWRjMGEyOWYgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPiBAQCAtNjkzLDkgKzY5MywxMSBAQCB2b2lkIGR3YzNfZ2FkZ2V0X2NsZWFyX3R4
X2ZpZm9zKHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIAlkd2MtPmxhc3RfZmlmb19kZXB0aCA9
IGZpZm9fZGVwdGg7DQo+ICAJLyogQ2xlYXIgZXhpc3RpbmcgVFhGSUZPIGZvciBhbGwgSU4gZXBz
IGV4Y2VwdCBlcDAgKi8NCj4gLQlmb3IgKG51bSA9IDM7IG51bSA8IG1pbl90KGludCwgZHdjLT5u
dW1fZXBzLCBEV0MzX0VORFBPSU5UU19OVU0pOw0KPiAtCSAgICAgbnVtICs9IDIpIHsNCj4gKwlm
b3IgKG51bSA9IDM7IG51bSA8IERXQzNfRU5EUE9JTlRTX05VTTsgbnVtICs9IDIpIHsNCj4gIAkJ
ZGVwID0gZHdjLT5lcHNbbnVtXTsNCj4gKw0KPiArCQlpZighZGVwKQ0KPiArCQkJY29udGludWU7
DQo+ICAJCS8qIERvbid0IGNoYW5nZSBUWEZSQU1OVU0gb24gdXNiMzEgdmVyc2lvbiAqLw0KPiAg
CQlzaXplID0gRFdDM19JUF9JUyhEV0MzKSA/IDAgOg0KPiAgCQkJZHdjM19yZWFkbChkd2MtPnJl
Z3MsIERXQzNfR1RYRklGT1NJWihudW0gPj4gMSkpICYNCj4gQEAgLTIyNTcsNyArMjI1OSw3IEBA
IHN0YXRpYyB2b2lkIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXJzKHN0cnVjdCBkd2MzICpkd2Mp
DQo+ICB7DQo+ICAJdTMyIGVwbnVtOw0KPiAgDQo+IC0JZm9yIChlcG51bSA9IDI7IGVwbnVtIDwg
ZHdjLT5udW1fZXBzOyBlcG51bSsrKSB7DQo+ICsJZm9yIChlcG51bSA9IDI7IGVwbnVtIDwgRFdD
M19FTkRQT0lOVFNfTlVNOyBlcG51bSsrKSB7DQo+ICAJCXN0cnVjdCBkd2MzX2VwICpkZXA7DQo+
ICANCj4gIAkJZGVwID0gZHdjLT5lcHNbZXBudW1dOw0KPiBAQCAtMjk2MCwxMCArMjk2Miw5IEBA
IHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfaW5pdF9vdXRfZW5kcG9pbnQoc3RydWN0IGR3YzNfZXAg
KmRlcCkNCj4gIAlyZXR1cm4gZHdjM19hbGxvY190cmJfcG9vbChkZXApOw0KPiAgfQ0KPiAgDQo+
IC1zdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2luaXRfZW5kcG9pbnQoc3RydWN0IGR3YzMgKmR3Yywg
dTggZXBudW0pDQo+ICtzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2luaXRfZW5kcG9pbnQoc3RydWN0
IGR3YzMgKmR3YywgdTggZXBudW0sIGJvb2wgZGlyZWN0aW9uKQ0KPiAgew0KPiAgCXN0cnVjdCBk
d2MzX2VwCQkJKmRlcDsNCj4gLQlib29sCQkJCWRpcmVjdGlvbiA9IGVwbnVtICYgMTsNCj4gIAlp
bnQJCQkJcmV0Ow0KPiAgCXU4CQkJCW51bSA9IGVwbnVtID4+IDE7DQo+ICANCj4gQEAgLTMwMTEs
MjEgKzMwMTIsMzAgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9pbml0X2VuZHBvaW50KHN0cnVj
dCBkd2MzICpkd2MsIHU4IGVwbnVtKQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IC1zdGF0
aWMgaW50IGR3YzNfZ2FkZ2V0X2luaXRfZW5kcG9pbnRzKHN0cnVjdCBkd2MzICpkd2MsIHU4IHRv
dGFsKQ0KPiArc3RhdGljIGludCBkd2MzX2dhZGdldF9pbml0X2VuZHBvaW50cyhzdHJ1Y3QgZHdj
MyAqZHdjLCB1OCB0b3RhbCwgdTggbnVtX2luX2VwcykNCj4gIHsNCj4gLQl1OAkJCQllcG51bTsN
Cj4gKwl1OAkJCQludW07DQo+ICsJaW50CQkJCXJldDsNCj4gIA0KPiAgCUlOSVRfTElTVF9IRUFE
KCZkd2MtPmdhZGdldC0+ZXBfbGlzdCk7DQo+ICANCj4gLQlmb3IgKGVwbnVtID0gMDsgZXBudW0g
PCB0b3RhbDsgZXBudW0rKykgew0KPiAtCQlpbnQJCQlyZXQ7DQo+ICsJLyogaW5pdCBpbnB1dCBl
bmRwb2ludHMgYXMgcmVwb3J0ZWQgYnkgaHcgKi8NCj4gKyAgICAgICAgZm9yIChudW0gPSAwOyBu
dW0gPCBudW1faW5fZXBzOyBudW0rKykgew0KPiAgDQo+IC0JCXJldCA9IGR3YzNfZ2FkZ2V0X2lu
aXRfZW5kcG9pbnQoZHdjLCBlcG51bSk7DQo+IC0JCWlmIChyZXQpDQo+IC0JCQlyZXR1cm4gcmV0
Ow0KPiAtCX0NCj4gKyAgICAgICAgICAgICAgICByZXQgPSBkd2MzX2dhZGdldF9pbml0X2VuZHBv
aW50KGR3YywgKG51bSA8PCAxKSArIDEsIDEpOw0KPiArICAgICAgICAgICAgICAgIGlmIChyZXQp
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArICAgICAgICB9DQo+
ICANCj4gLQlyZXR1cm4gMDsNCj4gKyAgICAgICAgLyogaW5pdCByZXN0IGVuZHBvaW50cyBhcyBv
dXRwdXQgZW5kcG9pbnRzICovDQo+ICsgICAgICAgIGZvciAobnVtID0gMDsgbnVtIDwgdG90YWwg
LSBudW1faW5fZXBzOyBudW0rKykgew0KPiArDQo+ICsgICAgICAgICAgICAgICAgcmV0ID0gZHdj
M19nYWRnZXRfaW5pdF9lbmRwb2ludChkd2MsIG51bSA8PCAxLCAwKTsNCj4gKyAgICAgICAgICAg
ICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
KyAgICAgICAgfQ0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KDQoqIERXQzNfTlVN
X0VQUyhwYXJtcykgaXMgdGhlIHRvdGFsIG51bWJlciBvZiBlbmRwb2ludHMgY29uZmlndXJlZCBp
biBIVw0KKiBEV0MzX05VTV9JTl9FUFMocGFybXMpIGlzIHRoZSBtYXggbnVtYmVyIG9mIElOIGVu
ZHBvaW50cyB0aGF0IFNXIG1heQ0KY29uZmlndXJlDQoNClRoZSBudW1iZXIgb2YgT1VUIGVuZHBv
aW50cyBkb2VzIG5vdCBtZWFuIERXQzNfTlVNX0VQUyhwYXJtcykgLQ0KRFdDM19OVU1fSU5fRVBT
KHBhcm1zKS4NCg0KQXMgbG9uZyBhcyBwaHlzaWNhbCBlbmRwb2ludCAwIGFuZCAxIGFyZSBkZWRp
Y2F0ZWQgZm9yIGNvbnRyb2wgZW5kcG9pbnQsDQpvdGhlciBlbmRwb2ludHMgY2FuIGJlIGFzc2ln
bmVkIGFzIElOIG9yIE9VVCBkaXJlY3Rpb24uIFNvLCB5b3UgY2FuIGhhdmUNCmFzIG1hbnkgYXMg
RFdDM19OVU1fRVBTKHBhcm1zKSAtIDEgbnVtYmVyIG9mIE9VVCBlbmRwb2ludHMuDQoNCkN1cnJl
bnRseSwgZHdjMyBkcml2ZXIgYXNzdW1lcyB0aGF0IERXQzNfTlVNX0lOX0VQUyhwYXJhbXMpIGlz
IGF0IGxlYXN0DQpoYWxmIG9mIERXQzNfTlVNX0VQUyhwYXJtcykuIElmIHRoYXQncyBub3QgdGhl
IGNhc2UsIHdlIG1heSBzZWUNCnByb2JsZW1zLiBUbyBjb3ZlciBtb3N0IGFwcGxpY2F0aW9uIHNl
dHVwLCB0aGUgZHJpdmVyIHRyaWVzIHRvIHNldHVwDQpudW1iZXIgb2YgT1VUID0gSU4uDQoNCkZv
ciB5b3VyIGNhc2UsIGlzIHRoZXJlIGFuIGFwcGxpY2F0aW9uIHRoYXQgbmVlZHMgYWxsDQpEV0Mz
X05VTV9JTl9FUFMocGFyYW1zKT8gSWYgeW91J3JlIGdvaW5nIHRvIG1ha2UgYSBjaGFuZ2UsIHBs
ZWFzZSBrZWVwDQppbiBtaW5kIG9mIHRoZSBpbmZvIGFib3ZlIHRvIHByZXZlbnQgcmVncmVzc2lv
bi4NCg0KVGhhbmtzLA0KVGhpbmgNCg==
