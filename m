Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9237B40E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 04:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhELCET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 22:04:19 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:9842 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229973AbhELCES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 22:04:18 -0400
X-UUID: 837896f299db42c7b372cb76a202a70c-20210512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=T8K9jXRssUMgZPyRniiOWW1kVzpxyI3Fg5ZYopeSdmA=;
        b=jsk7+4WyMcgmczQF9yimk50VfxbZGAupjqqzr5exHQsJa7Vc15VMuYi6F95UYBW4I9f1dKcMSudMuVR0k/G2tbuae2JvoaTf8ZQDEfKyvPMmhXSPJ8++clafgSKUIhP30zo04sCcRoAiTHCncWtTsWwKPvgr6iM2PMBuVqvmrIE=;
X-UUID: 837896f299db42c7b372cb76a202a70c-20210512
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1048197291; Wed, 12 May 2021 10:03:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May
 2021 10:02:59 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 May 2021 10:02:58 +0800
Message-ID: <1620784978.25159.4.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: core: hub: fix race condition about TRSMRCY of
 resume
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "Oliver Neukum" <oneukum@suse.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Ikjoon Jang" <ikjn@chromium.org>
Date:   Wed, 12 May 2021 10:02:58 +0800
In-Reply-To: <YJpqJr/3XEIYrtko@kroah.com>
References: <20210511101522.34193-1-chunfeng.yun@mediatek.com>
         <YJpqJr/3XEIYrtko@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BB3D69465F189431B6CB5B8CFC24F1B67DD4789539F36897903386BFD931EB7C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA1LTExIGF0IDEzOjI3ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFR1ZSwgTWF5IDExLCAyMDIxIGF0IDA2OjE1OjIyUE0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBUaGlzIG1heSBoYXBwZW4gaWYgdGhlIHBvcnQgYmVjb21lcyByZXN1
bWUgc3RhdHVzIGV4YWN0bHkNCj4gPiB3aGVuIHVzYl9wb3J0X3Jlc3VtZSgpIGdldHMgcG9ydCBz
dGF0dXMsIGl0IHN0aWxsIG5lZWQgcHJvdmlkZQ0KPiA+IGEgVFJTTUNSWSB0aW1lIGJlZm9yZSBh
Y2Nlc3MgdGhlIGRldmljZS4NCj4gPiANCj4gPiBSZXBvcnRlZC1ieTogVGlhbnBpbmcgRmFuZyA8
dGlhbnBpbmcuZmFuZ0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcg
WXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Vz
Yi9jb3JlL2h1Yi5jIHwgNiArKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IERvZXMgdGhpcyBuZWVkIHRvIGdvIHRvIGFueSBv
bGRlci9zdGFibGUga2VybmVscz8gIElmIHNvLCBob3cgZmFyIGJhY2s/DQoNClRoZSBmbG93IGlz
IGNoYW5nZWQgYnkgDQoiYjAxYjAzZjNhZDgyIFVTQjogYWRkIG5ldyByb3V0aW5lIGZvciBjaGVj
a2luZyBwb3J0LXJlc3VtZSB0eXBlIiwgYnV0DQppdCB3aWxsIGNhdXNlIGNvbmZsaWN0IHdpdGgN
CiJhZDQ5M2U1ZTU4MDUgdXNiOiBhZGQgdXNiIHBvcnQgYXV0byBwb3dlciBvZmYgbWVjaGFuaXNt
Ig0KIA0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0K

