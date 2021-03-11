Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D53336AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 04:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhCKD02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 22:26:28 -0500
Received: from mg.richtek.com ([220.130.44.152]:58726 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhCKD0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 22:26:14 -0500
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 22:26:14 EST
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(14680:0:AUTH_RELAY)
        (envelope-from <prvs=170085B779=cy_huang@richtek.com>); Thu, 11 Mar 2021 11:26:11 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(6561:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Thu, 11 Mar 2021 11:16:26 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 11 Mar 2021
 11:16:26 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0721.013; Thu, 11 Mar 2021
 11:16:26 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hulkci@huawei.com" <hulkci@huawei.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] regulator: rt4831: Fix return value check in
 rt4831_regulator_probe()
Thread-Topic: [PATCH -next] regulator: rt4831: Fix return value check in
 rt4831_regulator_probe()
Thread-Index: AQHXEXFUkVoT+b3/0UWqQC0QCmDAxKp9oNgA
Date:   Thu, 11 Mar 2021 03:16:26 +0000
Message-ID: <1615432586.3112.19.camel@richtek.com>
References: <20210305034930.3236099-1-weiyongjun1@huawei.com>
In-Reply-To: <20210305034930.3236099-1-weiyongjun1@huawei.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.19.169]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0BDDE82B379634AB55240E6BAEC6279@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFueSB0aGFua3MgdG8gZml4IGl0LiBJIGRpZG4ndCBub3RpY2UgdGhpcyBmYXVsdC4NCj4gIGRl
dl9lcnIoJnBkZXYtPmRldiwgIkZhaWxlZCB0byBpbml0IHJlZ21hcFxuIik7DQo+IC1yZXR1cm4g
UFRSX0VSUihyZWdtYXApOw0KPiArcmV0dXJuIC1FTk9ERVY7DQo+ICB9DQo+DQo+ICAvKiBDb25m
aWd1cmUgRFNWIG1vZGUgdG8gbm9ybWFsIGJ5IGRlZmF1bHQgKi8NCj4NCioqKioqKioqKioqKiog
RW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0KDQpUaGUg
aW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2UgKGluY2x1ZGluZyBh
bnkgYXR0YWNobWVudHMpIG1heSBiZSBjb25maWRlbnRpYWwsIHByb3ByaWV0YXJ5LCBwcml2aWxl
Z2VkLCBvciBvdGhlcndpc2UgZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1bmRlciBhcHBsaWNhYmxl
IGxhd3MuIEl0IGlzIGludGVuZGVkIHRvIGJlIGNvbnZleWVkIG9ubHkgdG8gdGhlIGRlc2lnbmF0
ZWQgcmVjaXBpZW50KHMpLiBBbnkgdXNlLCBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24sIHBy
aW50aW5nLCByZXRhaW5pbmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGl0
cyBhdHRhY2htZW50cykgYnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMgc3RyaWN0bHkgcHJv
aGliaXRlZCBhbmQgbWF5IGJlIHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCBy
ZWNpcGllbnQgb2YgdGhpcyBlLW1haWwsIG9yIGJlbGlldmUgdGhhdCB5b3UgaGF2ZSByZWNlaXZl
ZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0
ZWx5IChieSByZXBseWluZyB0byB0aGlzIGUtbWFpbCksIGRlbGV0ZSBhbnkgYW5kIGFsbCBjb3Bp
ZXMgb2YgdGhpcyBlLW1haWwgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIGZyb20geW91ciBz
eXN0ZW0sIGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBlLW1haWwgdG8g
YW55IG90aGVyIHBlcnNvbi4gVGhhbmsgeW91IQ0K
