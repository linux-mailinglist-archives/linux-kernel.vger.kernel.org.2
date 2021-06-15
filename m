Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF03A862A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhFOQQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:16:04 -0400
Received: from mg.richtek.com ([220.130.44.152]:36150 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhFOQQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:16:04 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2021 12:16:03 EDT
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(14676:0:AUTH_RELAY)
        (envelope-from <prvs=179711C503=cy_huang@richtek.com>); Wed, 16 Jun 2021 00:13:57 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(7300:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 16 Jun 2021 00:04:58 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Wed, 16 Jun 2021
 00:04:57 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0858.010; Wed, 16 Jun 2021
 00:04:57 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: rt6160: Remove vsel_active_low from struct
 rt6160_priv
Thread-Topic: [PATCH] regulator: rt6160: Remove vsel_active_low from struct
 rt6160_priv
Thread-Index: AQHXYdLPWOiSrOYaEEmzo+neCpG1NKsUqK8AgAACnYCAAALIAIAACIgA
Date:   Tue, 15 Jun 2021 16:04:57 +0000
Message-ID: <1623773096.4571.13.camel@richtek.com>
References: <20210615103947.3387994-1-axel.lin@ingics.com>
         <162376572819.36399.17993990572863185568.b4-ty@kernel.org>
         <1623770667.4571.4.camel@richtek.com> <20210615153424.GJ5149@sirena.org.uk>
In-Reply-To: <20210615153424.GJ5149@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.8.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CA02DD22470D44F9C4FE24EEA15E617@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcms6DQoNCk9LLiBMYXRlciBJJ2xsIHNlbmQgb25lIHRvIGZpeCBpdC4NCkJ1dCBiYXNl
ZCBvbiByZWd1bGF0b3ItbmV4dCBicmFuY2g/DQoqKioqKioqKioqKioqIEVtYWlsIENvbmZpZGVu
dGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKioNCg0KVGhlIGluZm9ybWF0aW9uIGNv
bnRhaW5lZCBpbiB0aGlzIGUtbWFpbCBtZXNzYWdlIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRz
KSBtYXkgYmUgY29uZmlkZW50aWFsLCBwcm9wcmlldGFyeSwgcHJpdmlsZWdlZCwgb3Igb3RoZXJ3
aXNlIGV4ZW1wdCBmcm9tIGRpc2Nsb3N1cmUgdW5kZXIgYXBwbGljYWJsZSBsYXdzLiBJdCBpcyBp
bnRlbmRlZCB0byBiZSBjb252ZXllZCBvbmx5IHRvIHRoZSBkZXNpZ25hdGVkIHJlY2lwaWVudChz
KS4gQW55IHVzZSwgZGlzc2VtaW5hdGlvbiwgZGlzdHJpYnV0aW9uLCBwcmludGluZywgcmV0YWlu
aW5nIG9yIGNvcHlpbmcgb2YgdGhpcyBlLW1haWwgKGluY2x1ZGluZyBpdHMgYXR0YWNobWVudHMp
IGJ5IHVuaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHN0cmljdGx5IHByb2hpYml0ZWQgYW5kIG1h
eSBiZSB1bmxhd2Z1bC4gSWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRo
aXMgZS1tYWlsLCBvciBiZWxpZXZlIHRoYXQgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwg
aW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSAoYnkgcmVwbHlp
bmcgdG8gdGhpcyBlLW1haWwpLCBkZWxldGUgYW55IGFuZCBhbGwgY29waWVzIG9mIHRoaXMgZS1t
YWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIgc3lzdGVtLCBhbmQgZG8g
bm90IGRpc2Nsb3NlIHRoZSBjb250ZW50IG9mIHRoaXMgZS1tYWlsIHRvIGFueSBvdGhlciBwZXJz
b24uIFRoYW5rIHlvdSENCg==
