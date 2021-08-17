Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0CE3EE48D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 04:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhHQCnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 22:43:04 -0400
Received: from m1397.mail.163.com ([220.181.13.97]:6521 "EHLO
        m1397.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhHQCnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:43:03 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Aug 2021 22:43:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=2l0RO
        Ftycxsn8LbV9SdJRrGWPtNvqewxqPbIBIKUQFw=; b=es1H6Gzf4tvzQKv/UGeM+
        5JVl3UOmPd8Yxoc/vRW2Gyq2bvGZZdqHbZ38ZktWQpLeI5f1Pk59NU1TAFO4KM8v
        ufugOF0/TmsT1Q+UTUxLylbgcEmSBxWKVEKU3ww7NH/uu4aQH8QZzb8XZ/2Xsn6G
        znwDVC0QMw1lAOe6F0iZUA=
Received: from slark_xiao$163.com ( [223.104.68.60] ) by
 ajax-webmail-wmsvr97 (Coremail) ; Tue, 17 Aug 2021 10:27:05 +0800 (CST)
X-Originating-IP: [223.104.68.60]
Date:   Tue, 17 Aug 2021 10:27:05 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "Reinhard Speyerer" <rspmn@arcor.de>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: Re: Re: [PATCH] [V2,1/1]USB: serial: option: add Foxconn
 T77W175 composition 0x901d
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <YRpJN414JQyfyEGo@kroah.com>
References: <20210816035404.4210-1-slark_xiao@163.com>
 <YRoqAJmGBpV/OuZL@arcor.de>
 <d1d16fd.6f62.17b4e3ffa26.Coremail.slark_xiao@163.com>
 <YRot+wBa6v529Z7q@kroah.com>
 <278bcd0d.7189.17b4e479a3a.Coremail.slark_xiao@163.com>
 <YRpJN414JQyfyEGo@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <ba9a424.f5f.17b51ef0b9d.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: YcGowAD3_+t5HhthHDrCAA--.29429W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiMAfxZFWByq46TwABsm
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjEtMDgtMTYgMTk6MTc6MTEsICJHcmVnIEtIIiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+T24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMDU6
MjU6MjBQTSArMDgwMCwgU2xhcmsgWGlhbyB3cm90ZToKPj4gQXQgMjAyMS0wOC0xNiAxNzoyMDo1
OSwgIkdyZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4+ID5PbiBN
b24sIEF1ZyAxNiwgMjAyMSBhdCAwNToxNzowMFBNICswODAwLCBTbGFyayBYaWFvIHdyb3RlOgo+
PiA+PiAgIFNvIHNob3VsZCBJIHVzZSBVU0JfREVWSUNFX0lOVEVSRkFDRV9OVU1CRVIoUVVBTENP
TU1fVkVORE9SX0lELCAweDkwMWQsIDB4MDApIHRvIGJpbmQgRGlhZyBwb3J0IG9ubHk/Cj4+ID4K
Pj4gPldoeSBpcyB0aGlzIGRldmljZSB1c2luZyB0aGUgUVVBTENPTU0gdmVuZG9yIGlkIGFueXdh
eT8gIElzIHRoaXMgYWxsb3dlZAo+PiA+YnkgUXVhbGNvbW0/Cj4+ID4KPj4gPnRoYW5rcywKPj4g
Pgo+PiA+Z3JlZyBrLWgKPj4gCj4+IEhpIEdyZWcsCj4+ICAgT3VyIHByb2R1Y3QgYXJlIGRlc2ln
bmVkIGJhc2VkIG9uIFF1YWxjb21tIFNEWDU1IHBsYXRmb3JtLiBTbyBpdCBzdGlsbCBzdXBwb3J0
IFF1YWxjb21tIHZlbmRvciBJRC4KPj4gICBJIHRoaW5rIHRoZXJlIGlzIG5vIGluZnJpbmdlbWVu
dCBhYm91dCB0aGlzIElEIGNvbWJvLgo+Cj5EbyB5b3UgaGF2ZSBwZXJtaXNzaW9uIGZyb20gUXVh
bGNvbW0gdG8gdXNlIHRoZWlyIHZlbmRvciBpZD8gIEkga25vdwo+c29tZSB2ZW5kb3JzIGdldCB2
ZXJ5IHVwc2V0IGFib3V0IHRoaXMuLi4KPgo+V2h5IG5vdCB1c2UgeW91ciBvd24gdmVuZG9yIGlk
Pwo+Cj50aGFua3MsCj4KPmdyZWcgay1oCgpIaSBHcmVnLAogICBBcyBRdWFsY29tbSBtYWlubHkg
cHJvdmlkZSBzZXJ2aWNlIHRvIHRoZWlyIGN1c3RvbWVyLCBsaWtlIFNhbXN1bmcsIEFwcGxlLCBI
dWF3ZWksIFF1ZWN0ZWwsIEZveGNvbm4sIFNpZXJyYSBhbmQgc28gb24sIHNvIEkgYmVsaWV2ZSBh
bGwgYXZhaWxhYmxlIFZJRC9QSURzIGFyZSBhbGxvd2VkIHRvIHVzZS4gCiAgIEkgYWxzbyBjaGVj
a2VkIHdobyBpcyB1c2luZyBRdWFsY29tbSdzIFZJRCBpbiB0aGUgd2hvbGUga2VybmVsLCBhbmQg
SSBmb3VuZCBvbmx5IHNvbWUgb2xkIHBsYXRmb3JtIChHb2JpIDFLLDJLLDNLIHdoaWNoIGRvbid0
IGRvIGFueSB1cGRhdGUgZm9yIGFsbW9zdCBtb3JlIHRoYW4gMTAgeWVhcnMpIGluIHFjc2VyaWFs
LmMgYW5kIFpURSwgU0lNY29tLCBRdWVjdGVsIGluIG9wdGlvbi5jIGFyZSB1c2luZyB0aGlzIFZJ
RC4gU2VlbXMgUXVhbGNvbW0gd29uJ3QgZG8gdGhpcyB1cGRhdGUgaW4gdGhlIGtlcm5lbCBzaWRl
IGJ5IHRoZW1zZWx2ZXMobGV0J3Mgc2F5IHNvbWUgbmV3IFBJRCwgOTAxeCw5MDJ4LDkwM3gsOTA0
eCw5MDV4Li4uOTBGeCwgYW5kIDkxeHgpLiAKICAgQWJvdXQgdGhlIHF1ZXN0aW9uIHdoeSBub3Qg
dXNlIG91ciBvd24gVklELCBiZWNhdXNlIHRoaXMgUENJRStVU0IgbW9kZSBpcyBmb3IgZGVidWcg
cHVycG9zZS4gV2UgbmVlZCB0byBrZWVwIGEgY29tbW9uIGRlYnVnIHNldHRpbmdzIGZvciBib3Ro
IExpbnV4IGFuZCBXaW5kb3dzIHBsYXRmb3JtLCBhbHNvIGZvciBhbGwgb3VyIGN1c3RvbWVycyBs
aWtlIExlbm92bywgRGVsbCwgSFAsIFRlbGl0LiAKICAgSG9wZSB5b3UgY2FuIHVuZGVyc3RhbmQg
dGhhdC4KClRoYW5rcwpTbGFyawo=
