Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD9F42D049
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhJNCU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:20:27 -0400
Received: from m1353.mail.163.com ([220.181.13.53]:21671 "EHLO
        m1353.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhJNCUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:20:24 -0400
X-Greylist: delayed 929 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2021 22:20:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=QyyUB
        CC7Whmk5CbCao8V+6eJHZUJ32YamdrVAxhM3Y4=; b=QLkSs69mW8Y60rrPIu9Ry
        oheJcoMJJq+34SrYBWxUBra1ue7pMW/EHR4oKOnYxpbqhjHn37fXD6cpqZOVkeYQ
        9CS/MKjx8wkzSxgKt+g/PdyDdmIhPxSW4NQfP/6oaXRliVfwnnDaGQl5TOGwQkjy
        IRq8U4pMnu3JfL8H7jGV90=
Received: from zhanglyra$163.com ( [120.244.194.245] ) by
 ajax-webmail-wmsvr53 (Coremail) ; Thu, 14 Oct 2021 10:02:44 +0800 (CST)
X-Originating-IP: [120.244.194.245]
Date:   Thu, 14 Oct 2021 10:02:44 +0800 (CST)
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
In-Reply-To: <163417628586.936110.17321921086246870791@swboyd.mtv.corp.google.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
 <20210923064137.60722-3-zhang.lyra@gmail.com>
 <163416267274.936110.2784588823311275089@swboyd.mtv.corp.google.com>
 <5b8198f8.cc.17c7c0fc3e2.Coremail.zhanglyra@163.com>
 <163417628586.936110.17321921086246870791@swboyd.mtv.corp.google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <4e2e8b98.cc9.17c7c899967.Coremail.zhanglyra@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: NcGowAAHE+XFj2dhqi7TAA--.40322W
X-CM-SenderInfo: x2kd0wpo1utqqrwthudrp/1tbiNQQs41rPdrutvQAAs2
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXQgMjAyMS0xMC0xNCAwOTo1MToyNSwgIlN0ZXBoZW4gQm95ZCIgPHNib3lkQGtlcm5lbC5vcmc+
IHdyb3RlOgo+UXVvdGluZyBDaHVueWFuWmhhbmcgKDIwMjEtMTAtMTMgMTY6NDk6NDApCj4+IEF0
IDIwMjEtMTAtMTQgMDY6MDQ6MzIsICJTdGVwaGVuIEJveWQiIDxzYm95ZEBrZXJuZWwub3JnPiB3
cm90ZToKPj4gPlF1b3RpbmcgQ2h1bnlhbiBaaGFuZyAoMjAyMS0wOS0yMiAyMzo0MTozNSkKPj4g
Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvc3By
ZCx1bXM1MTItZ2xicmVnLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWZkL3NwcmQsdW1zNTEyLWdsYnJlZy55YW1sCj4+ID4+ICsKPj4gPj4gK2V4YW1wbGVzOgo+PiA+
PiArICAtIHwKPj4gPj4gKyAgICBhcF9hcGJfcmVnczogc3lzY29uQDcxMDAwMDAwIHsKPj4gPj4g
KyAgICAgIGNvbXBhdGlibGUgPSAic3ByZCx1bXM1MTItZ2xicmVncyIsICJzeXNjb24iLCAic2lt
cGxlLW1mZCI7Cj4+ID4+ICsgICAgICByZWcgPSA8MHg3MTAwMDAwMCAweDMwMDA+Owo+PiA+PiAr
ICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47Cj4+ID4+ICsgICAgICAjc2l6ZS1jZWxscyA9IDwx
PjsKPj4gPj4gKyAgICAgIHJhbmdlcyA9IDwwIDB4NzEwMDAwMDAgMHgzMDAwPjsKPj4gPj4gKwo+
PiA+PiArICAgICAgY2xvY2stY29udHJvbGxlckAwIHsKPj4gPj4gKyAgICAgICAgY29tcGF0aWJs
ZSA9ICJzcHJkLHVtczUxMi1hcGFoYi1nYXRlIjsKPj4gPgo+PiA+V2h5IGlzIHRoaXMgYSBzdWJu
b2RlIG9mIGEgc3lzY29uIGFuZCBzaW1wbGUtbWZkPyBXaHkgbm90IHB1dCB0aGU+Y2xvY2stY29u
dHJvbGxlckA3MTAwMDAwMCBkaXJlY3RseSBvbnRvIHRoZSBidXM/IERvZXMgbWFraW5nIGl0IGEg
Y2hpbGQKPj4gPm5vZGUgaGVscCBzb21laG93Pwo+PiAKPj4gVGhlc2UgY2xvY2tzIGFyZSBhdCB0
aGUgc2FtZSByZWdpc3RlciByYW5nZSB3aXRoIGdsb2JhbCByZWdpc3RlcnMuIEkgb3JpZ2luYWxs
eSBwdXQgdGhlbSBkaXJlY3RseSBvbnRvIHRoZSBidXMgaW5kZWVkIHdoZW4gc3VibWl0dGluZyB0
aGUgcGF0Y2hlcyBmb3IgU0M5ODYzQSBjbG9ja3MgbGFzdCB5ZWFyLCBhbmQgaXQgaGFkIGEgcHJp
dmF0ZSBwcm9wZXJ0eSBuYW1lZCAnc3ByZCxzeXNjb24nIHdoaWNoIGNvdWxkIHByb3ZpZGUgcmVn
bWFwIGZvciB0aGVzZSBjbG9ja3MuCj4+IAo+PiBSb2Igc3VnZ2VzdGVkIFsxXSB1cyB0byBtYWtl
IHRoZW0gYSBjaGlsZCBvZiB0aGUgc3lzY29uLCBhbmQgd291bGQgbm90IG5lZWQgdGhlIHByaXZh
dGUgcHJvcGVydHkgJ3NwcmQsIHN5c2NvbicgdGhlbi4KPgo+V2h5IGRvIHlvdSBuZWVkIHRvIHVz
ZSBhIHN5c2Nvbj8gQXJlIHRoZSByZWdpc3RlcnMgc2hhcmVkIHdpdGggc29tZQo+b3RoZXIgZHJp
dmVyPwoKWWVzLCBzaGFyZWQgd2l0aCBtb3JlIHRoYW4gb25lIGRldmljZXMgd2hpY2ggYmFzaWNh
bGx5IGFyZSBtdWx0aW1lZGlhIGRldmljZXMuIFlvdSBtYXkgbm90aWNlZCB0aGF0IHRoZXNlIGFy
ZSBhbGwgZ2F0ZSBjbG9ja3Mgd2hpY2ggYXJlIGluIHRoZSBnbG9iYWwgcmVnaXN0ZXJzIHJhbmdl
cyBhbmQgYXJlIHVzZWQgdG8gY29udHJvbGwgdGhlIGVuYWJsZSBzdGF0dXMgb2Ygc29tZSBkZXZp
Y2VzIG9yIHNvbWUgcGFydCBvZiBkZXZpY2VzLgoKPgo+MjAxOSB3YXMgdHdvIHllYXJzIGFnby4u
LgoKSHVtbS4uLiB5ZXMsIHN1Ym1pdHRlZCB0aGF0IHBhdGNoIHNldCBmcm9tIDIwMTkgdG8gMjAy
MCA6KQ==
