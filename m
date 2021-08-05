Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A433E0F2B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhHEH2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:28:52 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:51480 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231499AbhHEH2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:28:51 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Thu, 5 Aug 2021 15:28:31
 +0800 (GMT+08:00)
X-Originating-IP: [10.214.160.77]
Date:   Thu, 5 Aug 2021 15:28:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   LinMa <linma@zju.edu.cn>
To:     "Ammar Faizi" <ammarfaizi2@gnuweeb.org>
Cc:     "Hillf Danton" <hdanton@sina.com>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Ammar Faizi" <ammarfaizi2@gmail.com>,
        "Linux Bluetooth" <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re: WARNING: possible circular locking dependency
 detected(hci_sock_dev_event+0x17d/0x1f0)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <c73c45fa-3d46-915f-02be-f9d2ede12bab@gnuweeb.org>
References: <20210805020048.2509-1-hdanton@sina.com>
 <c73c45fa-3d46-915f-02be-f9d2ede12bab@gnuweeb.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1abc786e.74f8d.17b1536b2ea.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: cS_KCgBnmXQfkwth5KPLAQ--.59202W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwQHElNG3DqHlgAEs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEFzIHRvIHRoYXQgVUFGLCBmZWVsIGZyZWUgdG8gbGV0IHVzIGtub3cgb25jZSB5b3UgaGF2
ZSBhIHJlcHJvZHVjZXIKPiBmb3IgaXQsCj4gPiB0aGVuIGZpeCB0byBpdCBjYW4gYmUgcHJlcGFy
ZWQuCj4gPgo+ID4gSGlsbGYKPiAKPiBBbHJpZ2h0LCBJIHdpbGwgdHJ5IG15IGJlc3QgdG8gYXQg
bGVhc3QgdW5kZXJzdGFuZCB0aGUgVUFGIGlzc3VlIGZpcnN0Lgo+IAo+IEhpIExpbiwgY291bGQg
eW91IGhlbHAgbWUgYWJvdXQgdGhlIFVBRj8KPiAKClN1cmUsIHNvcnJ5IGZvciB0aGUgZGVsYXkK
CkNoZWNrIHRoaXM6IGh0dHBzOi8vd3d3Lm9wZW53YWxsLmNvbS9saXN0cy9vc3Mtc2VjdXJpdHkv
MjAyMS8wNi8wOC8yCgo+IEJUVyBIaWxsZiwgd2h5IGNhbid0IEkgZmluZCBvdXIgY29udmVyc2F0
aW9uIG9uIGxvcmUga2VybmVsLiBJdCBzZWVtcwo+IHdlJ3ZlIG1lc3NlZCB1cCB0aGUgdGhyZWFk
LiBJIGRvbid0IGhhdmUgYW55IGlkZWEgd2h5IHRoaXMgY29udmVyc2F0aW9uCj4gY2FuJ3QgYmUg
Zm91bmQgb24gdGhlcmUuCj4gCj4gLS0gCj4gQW1tYXIKClJlZ2FyZHMKTGluIE1hCg==
