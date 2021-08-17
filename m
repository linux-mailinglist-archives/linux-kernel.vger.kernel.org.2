Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71A13EE6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhHQGw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:52:26 -0400
Received: from m1397.mail.163.com ([220.181.13.97]:9571 "EHLO
        m1397.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhHQGwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=aYaIK
        e4jFu+RIxgd6an7uD6w8EIvg+t2wANGRAcMbXE=; b=Gw4Z+qlvss3n2eL1ZQEvM
        DBxAZPZsUNdwFW6mFruOEPX3XQOGhJ2hcqY1qSyKR+X6fw3XgB8q3ZbcgnVQMbIV
        OkIEYM7uuSI4nCzHz9u0LkIOnkpPooNkepQbfVhdTtgcNcv2UUUaEitmV0IMcP61
        UcnDQoQV/Ay7zEM9TjX9do=
Received: from slark_xiao$163.com ( [223.104.68.81] ) by
 ajax-webmail-wmsvr97 (Coremail) ; Tue, 17 Aug 2021 14:51:34 +0800 (CST)
X-Originating-IP: [223.104.68.81]
Date:   Tue, 17 Aug 2021 14:51:34 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "Reinhard Speyerer" <rspmn@arcor.de>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: Re: Re: Re: [PATCH] [V2,1/1]USB: serial: option: add Foxconn
 T77W175 composition 0x901d
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <YRtYTFFCNn/xp2Hr@kroah.com>
References: <20210816035404.4210-1-slark_xiao@163.com>
 <YRoqAJmGBpV/OuZL@arcor.de>
 <d1d16fd.6f62.17b4e3ffa26.Coremail.slark_xiao@163.com>
 <YRot+wBa6v529Z7q@kroah.com>
 <278bcd0d.7189.17b4e479a3a.Coremail.slark_xiao@163.com>
 <YRpJN414JQyfyEGo@kroah.com>
 <ba9a424.f5f.17b51ef0b9d.Coremail.slark_xiao@163.com>
 <YRtYTFFCNn/xp2Hr@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <31fcfd4a.2432.17b52e12d52.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: YcGowADHz+t2XBthR1bCAA--.2027W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiNRfxZFrPc-bklAACsV
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjEtMDgtMTcgMTQ6MzM6NDgsICJHcmVnIEtIIiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+T24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMTA6
Mjc6MDVBTSArMDgwMCwgU2xhcmsgWGlhbyB3cm90ZToKPj4gCj4+IAo+Cj48YmxhbmsgbGluZXMg
c25pcHBlZCwgcGxlYXNlIGZpeCB5b3VyIGVtYWlsIGNsaWVudC4uLj4KPgo+Pj4gQXQgMjAyMS0w
OC0xNiAxOToxNzoxMSwgIkdyZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3Jv
dGU6Cj4+ID5PbiBNb24sIEF1ZyAxNiwgMjAyMSBhdCAwNToyNToyMFBNICswODAwLCBTbGFyayBY
aWFvIHdyb3RlOgo+PiA+PiBBdCAyMDIxLTA4LTE2IDE3OjIwOjU5LCAiR3JlZyBLSCIgPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPj4gPj4gPk9uIE1vbiwgQXVnIDE2LCAyMDIx
IGF0IDA1OjE3OjAwUE0gKzA4MDAsIFNsYXJrIFhpYW8gd3JvdGU6Cj4+ID4+ID4+ICAgU28gc2hv
dWxkIEkgdXNlIFVTQl9ERVZJQ0VfSU5URVJGQUNFX05VTUJFUihRVUFMQ09NTV9WRU5ET1JfSUQs
IDB4OTAxZCwgMHgwMCkgdG8gYmluZCBEaWFnIHBvcnQgb25seT8KPj4gPj4gPgo+PiA+PiA+V2h5
IGlzIHRoaXMgZGV2aWNlIHVzaW5nIHRoZSBRVUFMQ09NTSB2ZW5kb3IgaWQgYW55d2F5PyAgSXMg
dGhpcyBhbGxvd2VkCj4+ID4+ID5ieSBRdWFsY29tbT8KPj4gPj4gPgo+PiA+PiA+dGhhbmtzLAo+
PiA+PiA+Cj4+ID4+ID5ncmVnIGstaAo+PiA+PiAKPj4gPj4gSGkgR3JlZywKPj4gPj4gICBPdXIg
cHJvZHVjdCBhcmUgZGVzaWduZWQgYmFzZWQgb24gUXVhbGNvbW0gU0RYNTUgcGxhdGZvcm0uIFNv
IGl0IHN0aWxsIHN1cHBvcnQgUXVhbGNvbW0gdmVuZG9yIElELgo+PiA+PiAgIEkgdGhpbmsgdGhl
cmUgaXMgbm8gaW5mcmluZ2VtZW50IGFib3V0IHRoaXMgSUQgY29tYm8uCj4+ID4KPj4gPkRvIHlv
dSBoYXZlIHBlcm1pc3Npb24gZnJvbSBRdWFsY29tbSB0byB1c2UgdGhlaXIgdmVuZG9yIGlkPyAg
SSBrbm93Cj4+ID5zb21lIHZlbmRvcnMgZ2V0IHZlcnkgdXBzZXQgYWJvdXQgdGhpcy4uLgo+PiA+
Cj4+ID5XaHkgbm90IHVzZSB5b3VyIG93biB2ZW5kb3IgaWQ/Cj4+ID4KPj4gPnRoYW5rcywKPj4g
Pgo+PiA+Z3JlZyBrLWgKPj4gCj4+IEhpIEdyZWcsCj4+ICAgIEFzIFF1YWxjb21tIG1haW5seSBw
cm92aWRlIHNlcnZpY2UgdG8gdGhlaXIgY3VzdG9tZXIsIGxpa2UgU2Ftc3VuZywgQXBwbGUsIEh1
YXdlaSwgUXVlY3RlbCwgRm94Y29ubiwgU2llcnJhIGFuZCBzbyBvbiwgc28gSSBiZWxpZXZlIGFs
bCBhdmFpbGFibGUgVklEL1BJRHMgYXJlIGFsbG93ZWQgdG8gdXNlLiAKPgo+VGhhdCBpcyBub3Qg
aG93IFVTQiBWSURzIHdvcmssIHNvcnJ5LiAgUGxlYXNlIGdldCBhcHByb3ZhbCBmcm9tIHRoZQo+
Y29tcGFueSB3aG9zZSBWSUQgeW91IHdpc2ggdG8gdXNlLCBvdGhlcndpc2UgdGhleSB3aWxsIGJl
IHVzaW5nIGl0Cj50aGVtc2VsdmVzIGZvciB0aGVpciBvd24gZGV2aWNlcywgYW5kIHlvdSB3aWxs
IGhhdmUgYSBjb2xsaXNpb24uCj4KPnRoYW5rcywKPgo+Z3JlZyBrLWgKCkhpIEdyZWcsCiAgIEkg
YW0gY2hlY2tpbmcgdGhpcyB3aXRoIFF1YWxjb21tIHNpZGUgbm93LiBJIHdpbGwgdXBkYXRlIHRo
ZSByZXN1bHQgb25jZSBJIGdldCBpdC4KICBUaGFuayB5b3UgZm9yIHlvdXIgYWR2aWNlLg==
