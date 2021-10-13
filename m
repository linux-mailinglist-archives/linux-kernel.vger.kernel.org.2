Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346EA42CF66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 02:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhJNAH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 20:07:29 -0400
Received: from m1390.mail.163.com ([220.181.13.90]:1735 "EHLO
        m1390.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJNAH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 20:07:28 -0400
X-Greylist: delayed 935 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2021 20:07:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=BbFum
        IPt2O0/wUgVCjhIJEV8pEe1M2t/kA6VAymf0rc=; b=QKJpY1AJl9JFFnB2C6MOR
        nmhxik7dojhyW1NsjHPKE61FFFIuaiYXB4AmPMyCOP5yC+5/TEhCcljXTMI8lkeV
        msSJgrPdWTVc3T3BtweifjqVMcC4DmcCAm+a7QNh+v2D5iOQVOf98x2ORBGM33fJ
        EfSXAQHZE+uI764HHy3fjk=
Received: from zhanglyra$163.com ( [120.244.194.245] ) by
 ajax-webmail-wmsvr90 (Coremail) ; Thu, 14 Oct 2021 07:49:40 +0800 (CST)
X-Originating-IP: [120.244.194.245]
Date:   Thu, 14 Oct 2021 07:49:40 +0800 (CST)
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
In-Reply-To: <163416267274.936110.2784588823311275089@swboyd.mtv.corp.google.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
 <20210923064137.60722-3-zhang.lyra@gmail.com>
 <163416267274.936110.2784588823311275089@swboyd.mtv.corp.google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5b8198f8.cc.17c7c0fc3e2.Coremail.zhanglyra@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: WsGowAAXl8WUcGdhfWjTAA--.43112W
X-CM-SenderInfo: x2kd0wpo1utqqrwthudrp/1tbivwYr41WBv-IejwABs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCkF0IDIwMjEtMTAtMTQgMDY6MDQ6
MzIsICJTdGVwaGVuIEJveWQiIDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZToKPlF1b3RpbmcgQ2h1
bnlhbiBaaGFuZyAoMjAyMS0wOS0yMiAyMzo0MTozNSkKPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvc3ByZCx1bXM1MTItZ2xicmVnLnlhbWwgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3NwcmQsdW1zNTEyLWdsYnJlZy55
YW1sCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMzUyMmYz
ZDJkOGRlCj4+IC0tLSAvZGV2L251bGwKPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC9zcHJkLHVtczUxMi1nbGJyZWcueWFtbAo+PiBAQCAtMCwwICsxLDY4IEBA
Cj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNs
YXVzZSkKPj4gKyVZQU1MIDEuMgo+PiArLS0tCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9zY2hlbWFzL21mZC9zcHJkLHVtczUxMi1nbGJyZWcueWFtbCMKPj4gKyRzY2hlbWE6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIwo+PiArCj4+ICt0aXRsZTog
VW5pc29jIFN5c3RlbSBHbG9iYWwgUmVnaXN0ZXIgRGV2aWNlIFRyZWUgQmluZGluZ3MKPj4gKwo+
PiArbWFpbnRhaW5lcnM6Cj4+ICsgIC0gT3Jzb24gWmhhaSA8b3Jzb256aGFpQGdtYWlsLmNvbT4K
Pj4gKyAgLSBCYW9saW4gV2FuZyA8YmFvbGluLndhbmc3QGdtYWlsLmNvbT4KPj4gKyAgLSBDaHVu
eWFuIFpoYW5nIDx6aGFuZy5seXJhQGdtYWlsLmNvbT4KPj4gKwo+PiArZGVzY3JpcHRpb246Cj4+
ICsgIFVuaXNvYyBzeXN0ZW0gZ2xvYmFsIHJlZ2lzdGVycyBwcm92aWRlIHJlZ2lzdGVyIG1hcAo+
PiArICBmb3IgY2xvY2tzIGFuZCBzb21lIG11bHRpbWVkaWEgbW9kdWxlcyBvZiB0aGUgU29DLgo+
PiArCj4+ICtwcm9wZXJ0aWVzOgo+PiArICAiI2FkZHJlc3MtY2VsbHMiOiB0cnVlCj4+ICsgICIj
c2l6ZS1jZWxscyI6IHRydWUKPj4gKwo+PiArICBjb21wYXRpYmxlOgo+PiArICAgIGl0ZW1zOgo+
PiArICAgICAgLSBjb25zdDogc3ByZCx1bXM1MTItZ2xicmVncwo+PiArICAgICAgLSBjb25zdDog
c3lzY29uCj4+ICsgICAgICAtIGNvbnN0OiBzaW1wbGUtbWZkCj4+ICsKPj4gKyAgcmFuZ2VzOgo+
PiArICAgIG1heEl0ZW1zOiAxCj4+ICsKPj4gKyAgcmVnOgo+PiArICAgIG1heEl0ZW1zOiAxCj4+
ICsKPj4gK3BhdHRlcm5Qcm9wZXJ0aWVzOgo+PiArICAiXi4qQFswLTlhLWZdKyQiOgo+PiArICAg
ICMgQ2hpbGQgbm9kZQo+PiArICAgIHR5cGU6IG9iamVjdAo+PiArICAgICRyZWY6ICIuLi9jbG9j
ay9zcHJkLHVtczUxMi1jbGsueWFtbCIKPj4gKyAgICBkZXNjcmlwdGlvbjoKPj4gKyAgICAgIENs
b2NrIGNvbnRyb2xsZXIgZm9yIHRoZSBTb0MgY2xvY2tzLgo+PiArCj4+ICtyZXF1aXJlZDoKPj4g
KyAgLSBjb21wYXRpYmxlCj4+ICsgIC0gcmVnCj4+ICsKPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVz
OiBmYWxzZQo+PiArCj4+ICtleGFtcGxlczoKPj4gKyAgLSB8Cj4+ICsgICAgYXBfYXBiX3JlZ3M6
IHN5c2NvbkA3MTAwMDAwMCB7Cj4+ICsgICAgICBjb21wYXRpYmxlID0gInNwcmQsdW1zNTEyLWds
YnJlZ3MiLCAic3lzY29uIiwgInNpbXBsZS1tZmQiOwo+PiArICAgICAgcmVnID0gPDB4NzEwMDAw
MDAgMHgzMDAwPjsKPj4gKyAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Owo+PiArICAgICAgI3Np
emUtY2VsbHMgPSA8MT47Cj4+ICsgICAgICByYW5nZXMgPSA8MCAweDcxMDAwMDAwIDB4MzAwMD47
Cj4+ICsKPj4gKyAgICAgIGNsb2NrLWNvbnRyb2xsZXJAMCB7Cj4+ICsgICAgICAgIGNvbXBhdGli
bGUgPSAic3ByZCx1bXM1MTItYXBhaGItZ2F0ZSI7Cj4KPldoeSBpcyB0aGlzIGEgc3Vibm9kZSBv
ZiBhIHN5c2NvbiBhbmQgc2ltcGxlLW1mZD8gV2h5IG5vdCBwdXQgdGhlPmNsb2NrLWNvbnRyb2xs
ZXJANzEwMDAwMDAgZGlyZWN0bHkgb250byB0aGUgYnVzPyBEb2VzIG1ha2luZyBpdCBhIGNoaWxk
Cj5ub2RlIGhlbHAgc29tZWhvdz8KClRoZXNlIGNsb2NrcyBhcmUgYXQgdGhlIHNhbWUgcmVnaXN0
ZXIgcmFuZ2Ugd2l0aCBnbG9iYWwgcmVnaXN0ZXJzLiBJIG9yaWdpbmFsbHkgcHV0IHRoZW0gZGly
ZWN0bHkgb250byB0aGUgYnVzIGluZGVlZCB3aGVuIHN1Ym1pdHRpbmcgdGhlIHBhdGNoZXMgZm9y
IFNDOTg2M0EgY2xvY2tzIGxhc3QgeWVhciwgYW5kIGl0IGhhZCBhIHByaXZhdGUgcHJvcGVydHkg
bmFtZWQgJ3NwcmQsc3lzY29uJyB3aGljaCBjb3VsZCBwcm92aWRlIHJlZ21hcCBmb3IgdGhlc2Ug
Y2xvY2tzLgoKUm9iIHN1Z2dlc3RlZCBbMV0gdXMgdG8gbWFrZSB0aGVtIGEgY2hpbGQgb2YgdGhl
IHN5c2NvbiwgYW5kIHdvdWxkIG5vdCBuZWVkIHRoZSBwcml2YXRlIHByb3BlcnR5ICdzcHJkLCBz
eXNjb24nIHRoZW4uCgpUaGFua3MsCkNodW55YW4KClsxXSBodHRwczovL2xrbWwub3JnL2xrbWwv
MjAxOS8xMi8yNi8yMTIKCj4KPj4gKyAgICAgICAgcmVnID0gPDB4MCAweDIwMDA+Owo+PiArICAg
ICAgICAjY2xvY2stY2VsbHMgPSA8MT47Cj4+ICsgICAgICB9Owo+PiArICAgIH07Cg==
