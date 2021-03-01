Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653D5327D07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhCALVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:21:45 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:54958 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232564AbhCALU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:20:59 -0500
Received: by ajax-webmail-mail-app2 (Coremail) ; Mon, 1 Mar 2021 19:20:05
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Mon, 1 Mar 2021 19:20:05 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Kangjie Lu" <kjlu@umn.edu>, "Jens Axboe" <axboe@kernel.dk>,
        linux-ide@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] sata_dwc_460ex: Fix missing check in sata_dwc_isr
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20200917(3e19599d)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <CAHp75Vf86_Ccs7wqzbpWbLDZSSJLbMwZ1TX3dwru9JvXUTMR_Q@mail.gmail.com>
References: <20210301072842.7410-1-dinghao.liu@zju.edu.cn>
 <CAHp75Vf86_Ccs7wqzbpWbLDZSSJLbMwZ1TX3dwru9JvXUTMR_Q@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <44c09a14.a0cbd.177ed8446ea.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBXOzDlzTxgXrTbAQ--.64596W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgcLBlZdtSjgxQAAs7
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNb24sIE1hciAxLCAyMDIxIGF0IDk6NDQgQU0gRGluZ2hhbyBMaXUgPGRpbmdoYW8ubGl1
QHpqdS5lZHUuY24+IHdyb3RlOgo+ID4KPiA+IGF0YV9xY19mcm9tX3RhZygpIG1heSByZXR1cm4g
YSBudWxsIHBvaW50ZXIgYW5kIGZ1cnRoZXIgbGVhZCB0bwo+ID4gbnVsbC1wb2ludGVyLWRlcmVm
ZXJlbmNlLiBBZGQgYSByZXR1cm4gdmFsdWUgY2hlY2sgdG8gYXZvaWQgc3VjaCBjYXNlLgo+IAo+
IENhbiB5b3UgZWxhYm9yYXRlIG1vcmUgb24gdGhpcz8gSXMgaXQgYSByZWFsIGNhc2U/Cj4gSSBo
YXZlIGEgaGFyZHdhcmUsIGhvdyBjYW4gSSByZXByb2R1Y2UgdGhpcz8KPiAKCkluIHRoZSBicmFu
Y2ggJ2lmIChpbnRwciAmIFNBVEFfRFdDX0lOVFBSX05FV0ZQKScsIHdlIGNhbGwgYXRhX3FjX2Zy
b21fdGFnKCkKYW5kIGFjY2VzcyBxYy0+YXAtPmxpbmsuYWN0aXZlX3RhZyBpbW1lZGlhdGVseS4g
SWYgYXRhX3FjX2Zyb21fdGFnKCkgcmV0dXJucwphIG51bGwgcG9pbnRlciwgYWNjZXNzaW5nIHFj
LT5hcC0+bGluay5hY3RpdmVfdGFnIG1heSBjcmFzaCB0aGUgc3lzdGVtLgoKVGhpcyBpc3N1ZSBp
cyByZXBvcnRlZCBieSBteSBzdGF0aWMgYW5hbHlzaXMgdG9vbCwgc28gSSBkb24ndCBoYXZlIHRo
ZQp2dWxuZXJhYmxlIGlucHV0IGN1cnJlbnRseS4KClJlZ2FyZHMsCkRpbmdoYW8K
