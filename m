Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAF032F8AA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 07:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhCFGtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 01:49:24 -0500
Received: from mail.loongson.cn ([114.242.206.163]:38154 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229572AbhCFGtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 01:49:14 -0500
Received: by ajax-webmail-mail.loongson.cn (Coremail) ; Sat, 6 Mar 2021
 14:48:26 +0800 (GMT+08:00)
X-Originating-IP: [10.20.41.71]
Date:   Sat, 6 Mar 2021 14:48:26 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5p2O5pmo6Ziz?= <lichenyang@loongson.cn>
To:     "Huacai Chen" <chenhuacai@kernel.org>
Cc:     "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "David Airlie" <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        "Maling list - DRI developers" <dri-devel@lists.freedesktop.org>,
        "Huacai Chen" <chenhuacai@loongson.cn>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>
Subject: Reply: Re: [PATCH v5] drm/loongson: Add DRM Driver for Loongson
 7A1000 bridge chip
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10a build 20191018(4c4f6d15)
 Copyright (c) 2002-2021 www.mailtech.cn .loongson.cn
In-Reply-To: <CAAhV-H5pv7aSEgGqCwOFHYQ7OH1dPa59XO4YEC7mFunhasrwgQ@mail.gmail.com>
References: <20210219091146.75364-1-lichenyang@loongson.cn>
 <CAAhV-H5pv7aSEgGqCwOFHYQ7OH1dPa59XO4YEC7mFunhasrwgQ@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <42da178.aba.178064b600d.Coremail.lichenyang@loongson.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AQAAf9Dx39e6JUNg+zYVAA--.5891W
X-CM-SenderInfo: xolfxvxq1d0wo6or00hjvr0hdfq/1tbiAQAMA13QvNB4pwAAsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jmd0OyAmZ3Q7ICt2b2lkIGxzN2FfbW1fd3JlZ19sb2NrZWQoc3RydWN0IGxvb25nc29uX2Rldmlj
ZSAqbGRldiwgdTMyIG9mZnNldCwgdTMyIHZhbCkKJmd0OyAmZ3Q7ICt7CiZndDsgJmd0OyArICAg
ICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7CiZndDsgJmd0OyArCiZndDsgJmd0OyArICAgICAgIHNw
aW5fbG9ja19pcnFzYXZlKCZhbXA7bGRldi0mZ3Q7bW1pb19sb2NrLCBmbGFncyk7CiZndDsgJmd0
OyArICAgICAgIHdyaXRlbCh2YWwsIGxkZXYtJmd0O21taW8gKyBvZmZzZXQpOwomZ3Q7ICZndDsg
KyAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhbXA7bGRldi0mZ3Q7bW1pb19sb2NrLCBm
bGFncyk7CiZndDsgJmd0OyArfQomZ3Q7IFdoeSBsb2NrIGFuZCBkaXNhYmxlIGlycT8gVG8gd29y
a2Fyb3VuZCB0aGUgaHcgaXNzdWUgZnJvbSB0aGUgZmlyc3QKJmd0OyByZXZpc2lvbiBvZiBMUzdB
PyBJZiBzbywgSSBzdWdnZXN0IHRvIHJlbW92ZSB0aGUgd29ya2Fyb3VuZC4gQmVjYXVzZToKJmd0
OyAxLCBtbWlvIHIvdyB3aWxsIGJlIHVzZWQgaW4gaXJxIGNvbnRleHQ7IDIsIG5ld2VyIHJldmlz
aW9uIG9mIExTN0EKJmd0OyBkb2Vzbid0IG5lZWQgd29ya2Fyb3VuZC4KWWVzLHRoZSBsb2NrIGlz
IHRvIHdvcmthcm91bmQgdGhlIGh3IGlzc3VlLEkgaGF2ZSBkZWNpZGVkIHRvIHJlbW92ZSB0aGUg
bG9jay4KJmd0OyAKJmd0OyAmZ3Q7ICsKJmd0OyAmZ3Q7ICsgICAgICAgLyogREMgSU8gKi8KJmd0
OyAmZ3Q7ICsgICAgICAgbGRldi0mZ3Q7aW8gPSAodm9pZCAqKVRPX1VOQ0FDKExTN0FfQ0hJUENG
R19SRUdfQkFTRSk7CiZndDsgVE9fVU5DQUMoKSBpcyBhIE1JUFMtc3BlY2lmaWMgbWFjcm8sIEkg
dGhpbmsgaW9yZW1hcCgpIGlzIGJldHRlci4KT0suSSBoYXZlIHN3aXRjaGVkIHRvIGlvcmVtYXAs
IGFuZCB0aGUgdGVzdCBwYXNzZWQuCiZndDsgCiZndDsgJmd0OyArI2RlZmluZSBMUzdBX0NISVBD
RkdfUkVHX0JBU0UgKDB4MTAwMTAwMDApCiZndDsgJmd0OyArI2RlZmluZSBQQ0lfREVWSUNFX0lE
X0xPT05HU09OX0RDIDB4N2EwNgomZ3Q7ICZndDsgKyNkZWZpbmUgUENJX0RFVklDRV9JRF9MT09O
R1NPTl9HUFUgMHg3YTE1CiZndDsgVGhleSBhcmUgYWxyZWFkeSBkZWZpbmVkIGluIGluY2x1ZGUv
bGludXgvcGNpX2lkcy5oLgpJbiBpbmNsdWRlL2xpbnV4L3BjaV9pZHMuaCBvbmx5IGRlZmluZWQg
UENJX1ZFTkRPUl9JRF9MT09OR1NPTi4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpM
b29uZ3NvbiBMaUNoZW55YW5n
