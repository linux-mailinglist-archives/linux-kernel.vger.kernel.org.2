Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B5F42A45D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhJLM1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:27:17 -0400
Received: from m13110.mail.163.com ([220.181.13.110]:31634 "EHLO
        m13110.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbhJLM1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:27:15 -0400
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Oct 2021 08:27:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=TIAtM
        D8zyP353QHxeXQD98xSxRsX+TO8B1XwJMBwpm8=; b=lNlwDqSkP48DKBslxpfVY
        pDopDyJVhq+ioz7oLmik5CgVjnlOuubGVZtEv10ZeoTh0ISBR82V00P364wVqJOy
        A0R1kqXuA12t/Ix2cvwzqjv06QppYE2LGZtKzy9nyks3S1hqKo4Zwo4IO8g4yzNw
        6qbZnWZOYK9BN+ShD+JKwA=
Received: from zhanglyra$163.com ( [120.244.194.206] ) by
 ajax-webmail-wmsvr110 (Coremail) ; Tue, 12 Oct 2021 20:09:02 +0800 (CST)
X-Originating-IP: [120.244.194.206]
Date:   Tue, 12 Oct 2021 20:09:02 +0800 (CST)
From:   ChunyanZhang <zhanglyra@163.com>
To:     "Chunyan Zhang" <zhang.lyra@gmail.com>
Cc:     "Stephen Boyd" <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, "Baolin Wang" <baolin.wang7@gmail.com>,
        "Orson Zhai" <orsonzhai@gmail.com>,
        "Chunyan Zhang" <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>
Subject: Re:[PATCH v4 0/4] Add Unisoc's UMS512 clock support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <20210923064137.60722-1-zhang.lyra@gmail.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <6bebbd44.428e.17c7467f4fd.Coremail.zhanglyra@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bsGowACXW5reemVhRS3TAA--.6986W
X-CM-SenderInfo: x2kd0wpo1utqqrwthudrp/1tbioxQq41UMZQngjQACsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwKCkNvdWxkIHlvdSBwbGVhc2UgaGVscCB0byBhcHBseSB0aGlzIHdob2xlIHBh
dGNoLXNldCBpZiBubyBtb3JlIGNvbW1lbnRzPwoKVGhhbmtzLApDaHVueWFuCgpBdCAyMDIxLTA5
LTIzIDE0OjQxOjMzLCAiQ2h1bnlhbiBaaGFuZyIgPHpoYW5nLmx5cmFAZ21haWwuY29tPiB3cm90
ZToKPkZyb206IENodW55YW4gWmhhbmcgPGNodW55YW4uemhhbmdAdW5pc29jLmNvbT4KPgo+Q2hh
bmdlcyBzaW5jZSB2MzoKPiogQWRkZWQgYmFjayAncmVnJyBwcm9wZXJ0eSBhcyByZXF1aXJlZDsK
PiogQWRkZWQgUm9iJ3MgUmV2aWV3ZWQtYnkgb24gcGF0Y2ggMi80Owo+KiBDaGFuZ2VkIHRvIGR1
YWwgbGljZW5zZSBmb3Igc3ByZCx1bXM1MTItY2xrLmg7Cj4KPkNoYW5nZXMgc2luY2UgdjI6Cj4q
IEZpeGVkIGJpbmRpbmdzIGNoZWNrIGVycm9yczsKPiogQWRkcmVzc2VkIFJvYidzIGNvbW1lbnRz
Owo+KiBBZGRlZCBhbiBleGFtcGxlIG9mIHN5c2NvbiB3aGljaCBkb2Vzbid0IGluY2x1ZGUgIiNh
ZGRyZXNzLWNlbGxzIiwKPiAiI3NpemUtY2VsbHMiLCAicmFuZ2VzIiBwcm9wZXJ0aWVzLCBzbyBy
ZW1vdmVkIHRoZXNlIHRocmVlCj4gIHByb3BlcnRpZXMgZnJvbSAicmVxdWlyZWQiLgo+Cj5DaGFu
Z2VzIHNpbmNlIHYxOgo+KiBGaXhlZCBlcnJvcnMgZm91bmRlZCBvbiBzcHJkLHVtczUxMi1jbGsu
eWFtbDsKPiogQWRkZWQgYSBuZXcgYmluZGluZ3MgZmlsZSBmb3IgZ2xvYmFsIHJlZ2lzdGVyIHdo
aWNoIHdvdWxkIHByb3ZpZGUgcmVnaXN0ZXIgbWFwIGZvciBjbG9ja3MuCj4KPkNodW55YW4gWmhh
bmcgKDIpOgo+ICBkdC1iaW5kaW5nczogY2xrOiBzcHJkOiBBZGQgYmluZGluZ3MgZm9yIHVtczUx
MiBjbG9jayBjb250cm9sbGVyCj4gIGR0LWJpbmRpbmdzOiBtZmQ6IHNwcmQ6IEFkZCBiaW5kaW5n
cyBmb3IgdW1zNTEyIGdsb2JhbCByZWdpc3RlcnMKPgo+WGlvbmdwZW5nIFd1ICgyKToKPiAgY2xr
OiBzcHJkOiBBZGQgZHQtYmluZGluZ3MgaW5jbHVkZSBmaWxlIGZvciBVTVM1MTIKPiAgY2xrOiBz
cHJkOiBBZGQgVW5pc29jJ3MgVU1TNTEyIGNsb2NrIGRyaXZlcgo+Cj4gLi4uL2JpbmRpbmdzL2Ns
b2NrL3NwcmQsdW1zNTEyLWNsay55YW1sICAgICAgIHwgICA3MiArCj4gLi4uL2JpbmRpbmdzL21m
ZC9zcHJkLHVtczUxMi1nbGJyZWcueWFtbCAgICAgIHwgICA2OCArCj4gZHJpdmVycy9jbGsvc3By
ZC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgIHwgICAgOCArCj4gZHJpdmVycy9jbGsvc3By
ZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArCj4gZHJpdmVycy9jbGsvc3By
ZC91bXM1MTItY2xrLmMgICAgICAgICAgICAgICAgIHwgMjE5NyArKysrKysrKysrKysrKysrKwo+
IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svc3ByZCx1bXM1MTItY2xrLmggICB8ICAzOTYgKysr
Cj4gNiBmaWxlcyBjaGFuZ2VkLCAyNzQyIGluc2VydGlvbnMoKykKPiBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3NwcmQsdW1zNTEyLWNs
ay55YW1sCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZmQvc3ByZCx1bXM1MTItZ2xicmVnLnlhbWwKPiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9jbGsvc3ByZC91bXM1MTItY2xrLmMKPiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9k
dC1iaW5kaW5ncy9jbG9jay9zcHJkLHVtczUxMi1jbGsuaAo+Cj4tLSAKPjIuMjUuMQo=
