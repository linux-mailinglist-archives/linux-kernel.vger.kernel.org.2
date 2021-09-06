Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3494014FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 04:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbhIFCPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 22:15:34 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:8078 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232050AbhIFCPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 22:15:33 -0400
Received: by ajax-webmail-mail-app2 (Coremail) ; Mon, 6 Sep 2021 10:14:24
 +0800 (GMT+08:00)
X-Originating-IP: [10.214.16.36]
Date:   Mon, 6 Sep 2021 10:14:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Heinz Mauelshagen" <heinzm@redhat.com>
Cc:     kjlu@umn.edu, "Alasdair Kergon" <agk@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] dm raid: add missed unlock in raid_ctr
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <CAM23VxrzCk4XxbsG3dwqCq2PAnxNiEXoFXyp=t4t41o32THYrA@mail.gmail.com>
References: <20210903075531.20310-1-dinghao.liu@zju.edu.cn>
 <CAM23VxrzCk4XxbsG3dwqCq2PAnxNiEXoFXyp=t4t41o32THYrA@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <37fdfa89.be2a1.17bb8e29eee.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgC3aBWBeTVhbF5gBQ--.28492W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgYABlZdtVpN8wABsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4gPiBPbiBGcmksIFNlcCAzLCAyMDIxIGF0IDEwOjAyIEFNIERpbmdoYW8gTGl1IGRpbmdoYW8u
bGl1QHpqdS5lZHUuY24+IHdyb3RlOgo+ID4gbWRkZXZfdW5sb2NrKCkgaXMgY2FsbGVkIG9uIGFs
bCBwYXRocyBhZnRlciB3ZSBjYWxsIG1kZGV2X2xvY2tfbm9pbnRyKCksCj4gPiBleGNlcHQgZm9y
IHRocmVlIGVycm9yIGhhbmRsaW5nIHBhdGhzLCB3aGljaCBtYXkgY2F1c2UgYSBkZWFkbG9jay4g
VGhpcwo+ID4gYnVnIGlzIHN1Z2dlc3RlZCBieSBhIHN0YXRpYyBhbmFseXNpcyB0b29sLCBwbGVh
c2UgYWR2aXNlLgo+ID4gSGksICAgIAo+ID4gICAgIAo+ID4gICAgIGNvcnJlY3QsIHRob3NlIHVu
bG9jayBjYWxscyBhcmUgbWlzc2luZy4gICAgCj4gPgo+ID4gICAgIEFzIHdlIGFyZSBiYWlsaW5n
IG91dCBhZnRlciBtZF9ydW4oKSB3aXRoIGxvY2sgaGVsZCwgICAgIAo+ID4gICAgIHdlIGNhbiBj
bGVhbiB0aGUgbG90IG9mIGVycm9yIHBhdGhzIHVuZGVybmVhdGggdXAgYnkganVtcGluZyB0byBi
ZWZvcmUKPiA+ICAgICBtZF9zdG9wKCkgYW5kIGFkZCB0aGUgbWRkZXZfdW5sb2NrIHVwZnJvbnQg
aXQgbGlrZTogICAgCiAgICAKVGhhbmtzIGZvciB5b3VyIGFkdmljZSEgSSB3aWxsIGZpeCB0aGlz
IGFuZCBzZW5kIGEgbmV3IHBhdGNoIHNvb24uCgpSZWdhcmRzLApEaW5naGFvCgo=
