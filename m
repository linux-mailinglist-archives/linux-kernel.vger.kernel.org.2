Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345D1357BEE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhDHFof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:44:35 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:10312 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229734AbhDHFoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:44:34 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Thu, 8 Apr 2021 13:44:04
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.72.8]
Date:   Thu, 8 Apr 2021 13:44:04 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Mark Brown" <broonie@kernel.org>
Cc:     kjlu@umn.edu, "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        "Peter Ujfalusi" <peter.ujfalusi@ti.com>,
        "Rob Herring" <robh@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ASoC: codecs: Fix rumtime PM imbalance in
 tas2552_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <20210407125147.GD5510@sirena.org.uk>
References: <20210407065402.17729-1-dinghao.liu@zju.edu.cn>
 <20210407125147.GD5510@sirena.org.uk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <8ef359a.40bbb.178b0024d3e.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCH2Q0kmG5giemaAA--.34955W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoGBlZdtTQGhAAxsx
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIEFwciAwNywgMjAyMSBhdCAwMjo1NDowMFBNICswODAwLCBEaW5naGFvIExpdSB3
cm90ZToKPiAKPiA+IC0JcG1fcnVudGltZV9zZXRfYWN0aXZlKCZjbGllbnQtPmRldik7Cj4gPiAt
CXBtX3J1bnRpbWVfc2V0X2F1dG9zdXNwZW5kX2RlbGF5KCZjbGllbnQtPmRldiwgMTAwMCk7Cj4g
PiAtCXBtX3J1bnRpbWVfdXNlX2F1dG9zdXNwZW5kKCZjbGllbnQtPmRldik7Cj4gPiAtCXBtX3J1
bnRpbWVfZW5hYmxlKCZjbGllbnQtPmRldik7Cj4gPiAtCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1
c3koJmNsaWVudC0+ZGV2KTsKPiA+IC0JcG1fcnVudGltZV9wdXRfc3luY19hdXRvc3VzcGVuZCgm
Y2xpZW50LT5kZXYpOwo+ID4gLQo+ID4gIAlkZXZfc2V0X2RydmRhdGEoJmNsaWVudC0+ZGV2LCBk
YXRhKTsKPiA+ICAKPiA+ICAJcmV0ID0gZGV2bV9zbmRfc29jX3JlZ2lzdGVyX2NvbXBvbmVudCgm
Y2xpZW50LT5kZXYsCj4gPiBAQCAtNzMzLDYgKzcyNiwxMyBAQCBzdGF0aWMgaW50IHRhczI1NTJf
cHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwKPiA+ICAJaWYgKHJldCA8IDApCj4gPiAg
CQlkZXZfZXJyKCZjbGllbnQtPmRldiwgIkZhaWxlZCB0byByZWdpc3RlciBjb21wb25lbnQ6ICVk
XG4iLCByZXQpOwo+ID4gIAo+ID4gKwlwbV9ydW50aW1lX3NldF9hY3RpdmUoJmNsaWVudC0+ZGV2
KTsKPiA+ICsJcG1fcnVudGltZV9zZXRfYXV0b3N1c3BlbmRfZGVsYXkoJmNsaWVudC0+ZGV2LCAx
MDAwKTsKPiA+ICsJcG1fcnVudGltZV91c2VfYXV0b3N1c3BlbmQoJmNsaWVudC0+ZGV2KTsKPiAK
PiBJdCdzIG5vdCBjbGVhciB0byBtZSB0aGF0IGp1c3QgbW92aW5nIHRoZSBvcGVyYXRpb25zIGFm
dGVyIHRoZQo+IHJlZ2lzdHJhdGlvbiBpcyBhIGdvb2QgZml4IC0gb25jZSB0aGUgY29tcG9uZW50
IGlzIHJlZ2lzdGVyZWQgd2UgY291bGQKPiBzdGFydCB0cnlpbmcgdG8gZG8gcnVudGltZSBQTSBv
cGVyYXRpb25zIHdpdGggaXQgd2hpY2ggQUZBSVIgd29uJ3QgY291bnQKPiByZWZlcmVuY2VzIGFu
ZCBzbyBvbiBwcm9wZXJseSBpZiBydW50aW1lIFBNIGlzbid0IGVuYWJsZWQgc28gaWYgd2UgbGF0
ZXIKPiBlbmFibGUgcnVudGltZSBQTSB3ZSBtaWdodCBoYXZlIHRoZSByZXN0IG9mIHRoZSBjb2Rl
IGluIGEgY29uZnVzZWQgc3RhdGUKPiBhYm91dCB3aGF0J3MgZ29pbmcgb24uCgpUaGFua3MgZm9y
IHlvdXIgYWR2aWNlLiBJIGNoZWNrZWQgdGhlIHVzZSBvZiBkZXZtX3NuZF9zb2NfcmVnaXN0ZXJf
Y29tcG9uZW50KCkgCmluIHRoZSBrZXJuZWwgYW5kIGZvdW5kIHNvbWV0aW1lcyBydW50aW1lIFBN
IGlzIGVuYWJsZWQgYmVmb3JlIHJlZ2lzdHJhdGlvbiAKYW5kIHNvbWV0aW1lcyBhZnRlciByZWdp
c3RyYXRpb24uIFRvIGJlIG9uIHRoZSBzYWZlIHNpZGUsIEkgd2lsbCBzZW5kIGEgbmV3CnBhdGNo
IHRvIGZpeCB0aGlzIGluIGVycm9yIGhhbmRsaW5nIHBhdGguCgpSZWdhcmRzLApEaW5naGFvCg==

