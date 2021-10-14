Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2F42D4AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhJNIU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 04:20:27 -0400
Received: from m1353.mail.163.com ([220.181.13.53]:50827 "EHLO
        m1353.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhJNIU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=75iND
        4n1B3U84HQnfyj5d9AwCsFU8IKpJPJZo43r4u8=; b=dBnm6F3e6m6OmirDNnAaJ
        m44nl7xA2L29NyEIpwyjGvjbV5HJEcI+yrKtm9hHW4x0P9R8cr9bIp2/q0OKMSAd
        MbIJ/WXHDpnNzOKrBfY3tfAgQ85AWvygBmrUAkNqw53M0Yf2ZyURqH8NWKPvUEQl
        2GwcQPcXDt49viiy3OZpJc=
Received: from zhanglyra$163.com ( [120.244.194.245] ) by
 ajax-webmail-wmsvr53 (Coremail) ; Thu, 14 Oct 2021 16:18:15 +0800 (CST)
X-Originating-IP: [120.244.194.245]
Date:   Thu, 14 Oct 2021 16:18:15 +0800 (CST)
From:   ChunyanZhang <zhanglyra@163.com>
To:     "Stephen Boyd" <sboyd@kernel.org>
Cc:     "Chunyan Zhang" <zhang.lyra@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, "Baolin Wang" <baolin.wang7@gmail.com>,
        "Orson Zhai" <orsonzhai@gmail.com>,
        "Chunyan Zhang" <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for
 ums512 global registers
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <163419352215.936110.17102590465311356046@swboyd.mtv.corp.google.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
 <20210923064137.60722-3-zhang.lyra@gmail.com>
 <163416267274.936110.2784588823311275089@swboyd.mtv.corp.google.com>
 <5b8198f8.cc.17c7c0fc3e2.Coremail.zhanglyra@163.com>
 <163417628586.936110.17321921086246870791@swboyd.mtv.corp.google.com>
 <4e2e8b98.cc9.17c7c899967.Coremail.zhanglyra@163.com>
 <163419352215.936110.17102590465311356046@swboyd.mtv.corp.google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <71369ca3.307a.17c7de16354.Coremail.zhanglyra@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: NcGowAB3g+XH52dh1F3TAA--.35569W
X-CM-SenderInfo: x2kd0wpo1utqqrwthudrp/xtbBAxEs42B0HUadlAABsa
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ClJlc2VuZCB0aGlzIHNpbmNlIEkgZm9yZ290IHRvIHN3aXRjaCB0byBwbGFpbiB0ZXh0IG1vZGUg
OigKCkF0IDIwMjEtMTAtMTQgMTQ6Mzg6NDIsICJTdGVwaGVuIEJveWQiIDxzYm95ZEBrZXJuZWwu
b3JnPiB3cm90ZToKPlF1b3RpbmcgQ2h1bnlhblpoYW5nICgyMDIxLTEwLTEzIDE5OjAyOjQ0KQo+
PiBBdCAyMDIxLTEwLTE0IDA5OjUxOjI1LCAiU3RlcGhlbiBCb3lkIiA8c2JveWRAa2VybmVsLm9y
Zz4gd3JvdGU6Cj4+ID5RdW90aW5nIENodW55YW5aaGFuZyAoMjAyMS0xMC0xMyAxNjo0OTo0MCkK
Pj4gPj4gQXQgMjAyMS0xMC0xNCAwNjowNDozMiwgIlN0ZXBoZW4gQm95ZCIgPHNib3lkQGtlcm5l
bC5vcmc+IHdyb3RlOgo+PiA+PiA+UXVvdGluZyBDaHVueWFuIFpoYW5nICgyMDIxLTA5LTIyIDIz
OjQxOjM1KQo+PiA+PiA+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21mZC9zcHJkLHVtczUxMi1nbGJyZWcueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZmQvc3ByZCx1bXM1MTItZ2xicmVnLnlhbWwKPj4gPj4gPj4gKwo+PiA+
PiA+PiArZXhhbXBsZXM6Cj4+ID4+ID4+ICsgIC0gfAo+PiA+PiA+PiArICAgIGFwX2FwYl9yZWdz
OiBzeXNjb25ANzEwMDAwMDAgewo+PiA+PiA+PiArICAgICAgY29tcGF0aWJsZSA9ICJzcHJkLHVt
czUxMi1nbGJyZWdzIiwgInN5c2NvbiIsICJzaW1wbGUtbWZkIjsKPj4gPj4gPj4gKyAgICAgIHJl
ZyA9IDwweDcxMDAwMDAwIDB4MzAwMD47Cj4+ID4+ID4+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9
IDwxPjsKPj4gPj4gPj4gKyAgICAgICNzaXplLWNlbGxzID0gPDE+Owo+PiA+PiA+PiArICAgICAg
cmFuZ2VzID0gPDAgMHg3MTAwMDAwMCAweDMwMDA+Owo+PiA+PiA+PiArCj4+ID4+ID4+ICsgICAg
ICBjbG9jay1jb250cm9sbGVyQDAgewo+PiA+PiA+PiArICAgICAgICBjb21wYXRpYmxlID0gInNw
cmQsdW1zNTEyLWFwYWhiLWdhdGUiOwo+PiA+PiA+Cj4+ID4+ID5XaHkgaXMgdGhpcyBhIHN1Ym5v
ZGUgb2YgYSBzeXNjb24gYW5kIHNpbXBsZS1tZmQ/IFdoeSBub3QgcHV0IHRoZT5jbG9jay1jb250
cm9sbGVyQDcxMDAwMDAwIGRpcmVjdGx5IG9udG8gdGhlIGJ1cz8gRG9lcyBtYWtpbmcgaXQgYSBj
aGlsZAo+PiA+PiA+bm9kZSBoZWxwIHNvbWVob3c/Cj4+ID4+IAo+PiA+PiBUaGVzZSBjbG9ja3Mg
YXJlIGF0IHRoZSBzYW1lIHJlZ2lzdGVyIHJhbmdlIHdpdGggZ2xvYmFsIHJlZ2lzdGVycy4gSSBv
cmlnaW5hbGx5IHB1dCB0aGVtIGRpcmVjdGx5IG9udG8gdGhlIGJ1cyBpbmRlZWQgd2hlbiBzdWJt
aXR0aW5nIHRoZSBwYXRjaGVzIGZvciBTQzk4NjNBIGNsb2NrcyBsYXN0IHllYXIsIGFuZCBpdCBo
YWQgYSBwcml2YXRlIHByb3BlcnR5IG5hbWVkICdzcHJkLHN5c2Nvbicgd2hpY2ggY291bGQgcHJv
dmlkZSByZWdtYXAgZm9yIHRoZXNlIGNsb2Nrcy4KPj4gPj4gCj4+ID4+IFJvYiBzdWdnZXN0ZWQg
WzFdIHVzIHRvIG1ha2UgdGhlbSBhIGNoaWxkIG9mIHRoZSBzeXNjb24sIGFuZCB3b3VsZCBub3Qg
bmVlZCB0aGUgcHJpdmF0ZSBwcm9wZXJ0eSAnc3ByZCwgc3lzY29uJyB0aGVuLgo+PiA+Cj4+ID5X
aHkgZG8geW91IG5lZWQgdG8gdXNlIGEgc3lzY29uPyBBcmUgdGhlIHJlZ2lzdGVycyBzaGFyZWQg
d2l0aCBzb21lCj4+ID5vdGhlciBkcml2ZXI/Cj4+IAo+PiBZZXMsIHNoYXJlZCB3aXRoIG1vcmUg
dGhhbiBvbmUgZGV2aWNlcyB3aGljaCBiYXNpY2FsbHkgYXJlIG11bHRpbWVkaWEgZGV2aWNlcy4g
WW91IG1heSBub3RpY2VkIHRoYXQgdGhlc2UgYXJlIGFsbCBnYXRlIGNsb2NrcyB3aGljaCBhcmUg
aW4gdGhlIGdsb2JhbCByZWdpc3RlcnMgcmFuZ2VzIGFuZCBhcmUgdXNlZCB0byBjb250cm9sbCB0
aGUgZW5hYmxlIHN0YXR1cyBvZiBzb21lIGRldmljZXMgb3Igc29tZSBwYXJ0IG9mIGRldmljZXMu
Cj4+IAo+Cgo+V2hlcmUgZG9lcyB0aGUgbXVsdGltZWRpYSBkZXZpY2UgYWRkcmVzcyBzcGFjZSBz
dGFydD8gSSBzZWUgMHg3MTAwMDAwMAoKSXQgZG9lc24ndCBtZWFuIHRoYXQgbXVsdGltZWRpYSBk
ZXZpY2UgYWRkcmVzcyBpcyBpbiB0aGlzIHNwYWNlLCBtdWx0aWRlZGlhIGRldmljZXMgaGF2ZSB0
aGVpciBvd24gYWRkcmVzcyBzcGFjZSBhY3R1YWxseS4KQWxsIHRoZSByZWdpc3RlcnMgaW4gdGhp
cyBzcGFjZSAoc3RhcnRlZCBmcm9tIDB4NzEwMDAwMDApIGFyZSBtb3JlIGxpa2UgY29udHJvbGwg
cmVnaXN0ZXJzIGZvciBkZXZpY2UgcG93ZXIsIGFuZCB0aGV5IHdlcmUgZGVzaWduZWQgYXMgImds
b2JhbCByZWdpc3RlcnMiLgpTb21lIGdhdGUgY2xvY2tzIGFyZSBhbHNvIGluIGdsb2JhbCByZWdp
c3RlciBzcGFjZSwgc28gd2UgbWFrZSB0aGlzIGtpbmQgb2YgY2xvY2tzIGEgc3Vibm9kZSBvZiBz
eXNjb24sIGFuZCBjbG9jayBkcml2ZXIgY2FuIHVzZSByZWdtYXAgd2hpY2ggbWFwcGVkIGJ5IHN5
c2NvbiB0byBhdm9pZCByZW1hcHBpbmcgdGhlIHNhbWUgYWRkcmVzcyBzcGFjZSB0byBtb3JlIHRo
YW4gb25lIHZpcnR1YWwgYWRkcmVzc2VzLgoKSG9wZSBJJ3ZlIG1hZGUgdGhhdCBjbGVhciwgSSdk
IGxpa2UgdG8gZ2l2ZSB5b3UgYW4gZXhhbXBsZSwgYnV0IEknbSBvbiBhIGxvbmcgbGVhdmUgYW5k
IGNhbm5vdCBsb29rIHVwIHRoZSBzcGVjaWZpY2F0aW9uIHJpZ2h0IG5vdyA6KApUaGlzIGlzIG5v
dCBhIG5ldyBpc3N1ZSwgd2UgZGlzY3Vzc2VkIHRoaXMgd2hlbiB0aGUgZmlyc3QgdGltZSBJIHN1
Ym1pdHRlZCB0aGUgcGF0Y2hlcyBmb3Igc3ByZCBjbG9ja3MgSUlSQy4KCj50byAweDcxMDAyMDAw
IGlzIGZvciB0aGUgY2xvY2stY29udHJvbGxlci4gSXMgdGhlIG11bHRpbWVkaWEgZGV2aWNlIGF0
Cj4weDcxMDAyMDAwIHRvIDB4NzEwMDMwMDA/IElmIHNvIHRoZXkncmUgbmV4dCB0byBlYWNoIG90
aGVyIGJ1dCBub3QKPnNoYXJpbmcgdGhlIHNhbWUgcmVnaXN0ZXIgc3BhY2UuIElzIGFwX2FwYl9y
ZWdzIG1vcmUgbGlrZSBhIHNvZnQgbWFjcm8KPnRoYXQgY29tYmluZXMgYSBmZXcgY2xrcyB3aXRo
IHNvbWUgbXVsdGltZWRpYSBkZXZpY2U/Cg==
