Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49DC31F4A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 06:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBSFT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 00:19:29 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:8848 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229481AbhBSFT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 00:19:26 -0500
Received: by ajax-webmail-mail-app3 (Coremail) ; Fri, 19 Feb 2021 13:18:00
 +0800 (GMT+08:00)
X-Originating-IP: [210.32.145.131]
Date:   Fri, 19 Feb 2021 13:18:00 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Tom Rix" <trix@redhat.com>
Cc:     kjlu@umn.edu, "Cezary Rojewski" <cezary.rojewski@intel.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        "Liam Girdwood" <liam.r.girdwood@linux.intel.com>,
        "Jie Yang" <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Julia Lawall" <Julia.Lawall@inria.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ASoC: Intel: Skylake: Fix missing check in
 skl_pcm_trigger
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20200917(3e19599d)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <e53684a9-afda-8c06-1b54-7327e95b0b01@redhat.com>
References: <20210215151356.15252-1-dinghao.liu@zju.edu.cn>
 <e53684a9-afda-8c06-1b54-7327e95b0b01@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4644524e.89b27.177b8b932a0.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgDnHggISi9g9W6ZAQ--.53589W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgIBBlZdtScDEwABsP
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAKPiBPbiAyLzE1LzIxIDc6MTMgQU0sIERpbmdoYW8gTGl1IHdyb3RlOgo+ID4gV2hlbiBjbWQg
PT0gU05EUlZfUENNX1RSSUdHRVJfU1RPUCwgd2Ugc2hvdWxkIGFsc28gY2hlY2sKPiA+IHRoZSBy
ZXR1cm4gdmFsdWUgb2Ygc2tsX2RlY291cGxlZF90cmlnZ2VyKCkganVzdCBsaWtlIHdoYXQKPiA+
IHdlIGhhdmUgZG9uZSBpbiBjYXNlIFNORFJWX1BDTV9UUklHR0VSX1BBVVNFX1JFTEVBU0UuCj4g
Pgo+ID4gU2lnbmVkLW9mZi1ieTogRGluZ2hhbyBMaXUgPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+
Cj4gPiAtLS0KPiA+ICBzb3VuZC9zb2MvaW50ZWwvc2t5bGFrZS9za2wtcGNtLmMgfCAzICsrKwo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2ludGVsL3NreWxha2Uvc2tsLXBjbS5jIGIvc291bmQvc29jL2ludGVsL3NreWxh
a2Uvc2tsLXBjbS5jCj4gPiBpbmRleCBiMWNhNjRkMmY3ZWEuLmE1YjFmMzMzYTUwMCAxMDA2NDQK
PiA+IC0tLSBhL3NvdW5kL3NvYy9pbnRlbC9za3lsYWtlL3NrbC1wY20uYwo+ID4gKysrIGIvc291
bmQvc29jL2ludGVsL3NreWxha2Uvc2tsLXBjbS5jCj4gPiBAQCAtNTE2LDYgKzUxNiw5IEBAIHN0
YXRpYyBpbnQgc2tsX3BjbV90cmlnZ2VyKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3Ry
ZWFtLCBpbnQgY21kLAo+ID4gIAkJCXJldHVybiByZXQ7Cj4gCj4gSXMgdGhlcmUgYW55IGFkZGl0
aW9uYWwgZXJyb3IgaGFuZGxpbmcgdG8gYmUgZG9uZSBmb3IgdGhlCj4gCj4gc2tsX3N0b3BfcGlw
ZSB0aGF0IGp1c3QgaGFwcGVuZWQgPwo+IAoKSSB0aGluayB0aGUgY2hlY2sgaXMgZW5vdWdoIGhl
cmUuCgpSZWdhcmRzLApEaW5naGFv
