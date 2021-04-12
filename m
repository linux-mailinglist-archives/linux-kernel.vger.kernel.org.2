Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0066635B9DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 07:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhDLFfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 01:35:39 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:35246 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhDLFfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 01:35:38 -0400
Received: by ajax-webmail-mail-app2 (Coremail) ; Mon, 12 Apr 2021 13:35:11
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.139.175]
Date:   Mon, 12 Apr 2021 13:35:11 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Peter Chen" <peter.chen@kernel.org>
Cc:     kjlu@umn.edu, "Pawel Laszczak" <pawell@cadence.com>,
        "Roger Quadros" <rogerq@kernel.org>,
        "Aswath Govindraju" <a-govindraju@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] usb: cdns3: Fix rumtime PM imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <20210410010631.GA3862@b29397-desktop>
References: <20210407052226.1056-1-dinghao.liu@zju.edu.cn>
 <20210410010631.GA3862@b29397-desktop>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <58e92f05.49985.178c4939c14.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgAnf20P3HNgdNYBAQ--.33789W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUKBlZdtTUxDAASsv
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyMS0wNC0wNyAxMzoyMjoyNiwgRGluZ2hhbyBMaXUgd3JvdGU6Cj4gPiBXaGVuIGNkbnMz
X2dhZGdldF9zdGFydCgpIGZhaWxzLCBhIHBhaXJpbmcgUE0gdXNhZ2UgY291bnRlcgo+ID4gZGVj
cmVtZW50IGlzIG5lZWRlZCB0byBrZWVwIHRoZSBjb3VudGVyIGJhbGFuY2VkLgo+ID4gCj4gPiBT
aWduZWQtb2ZmLWJ5OiBEaW5naGFvIExpdSA8ZGluZ2hhby5saXVAemp1LmVkdS5jbj4KPiA+IC0t
LQo+ID4gIGRyaXZlcnMvdXNiL2NkbnMzL2NkbnMzLWdhZGdldC5jIHwgNSArKysrLQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMzL2NkbnMzLWdhZGdldC5jIGIvZHJpdmVycy91c2Iv
Y2RuczMvY2RuczMtZ2FkZ2V0LmMKPiA+IGluZGV4IDU4MmJmZWNlZWRiNC4uYWQ4OTFhMTA4YWVk
IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy91c2IvY2RuczMvY2RuczMtZ2FkZ2V0LmMKPiA+ICsr
KyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NkbnMzLWdhZGdldC5jCj4gPiBAQCAtMzI1NSw4ICszMjU1
LDExIEBAIHN0YXRpYyBpbnQgX19jZG5zM19nYWRnZXRfaW5pdChzdHJ1Y3QgY2RucyAqY2RucykK
PiA+ICAJcG1fcnVudGltZV9nZXRfc3luYyhjZG5zLT5kZXYpOwo+ID4gIAo+ID4gIAlyZXQgPSBj
ZG5zM19nYWRnZXRfc3RhcnQoY2Rucyk7Cj4gPiAtCWlmIChyZXQpCj4gPiArCWlmIChyZXQpIHsK
PiA+ICsJCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koY2Rucy0+ZGV2KTsKPiA+ICsJCXBtX3J1
bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGNkbnMtPmRldik7Cj4gPiAgCQlyZXR1cm4gcmV0Owo+IAo+
IEl0IGRvZXNuJ3QgbmVlZCB0byBkZWxheSBlbnRlcmluZyBydW50aW1lIHN1c3BlbmQsIEkgcHJl
ZmVyIHVzaW5nIHBtX3J1bnRpbWVfcHV0X3N5bmMgZGlyZWN0bHkuCj4gCgpTb3VuZHMgcmVhc29u
YWJsZSwgdGhhbmtzISBJIHdpbGwgc2VuZCBhIG5ldyBwYXRjaCBzb29uLgoKUmVnYXJkcywKRGlu
Z2hhbw==
