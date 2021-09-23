Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E2415E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbhIWMUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:20:13 -0400
Received: from m13101.mail.163.com ([220.181.13.101]:53335 "EHLO
        m13101.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbhIWMUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:20:12 -0400
X-Greylist: delayed 1802 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Sep 2021 08:20:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=HKqYx
        FSnuMPPDtXTnZobr6aATLcwqztdTi69Fp0el8M=; b=jXUcGIJYu+PQMFqvnDc84
        XA35+LSk2sXWeUKJs3WZkZEqhiYCGFdlyuQOYCvWIICsmmvRgHiUH47uYcbYwQrF
        VnCPoa6/k1t2Lf30nA3SEFYScro2l/OlEUHyNFqiyHmCacTRbc8dHlEwZZBkQNFP
        emkGRomAi2X9ORzPEACF14=
Received: from slark_xiao$163.com ( [120.197.196.160] ) by
 ajax-webmail-wmsvr101 (Coremail) ; Thu, 23 Sep 2021 19:32:27 +0800 (CST)
X-Originating-IP: [120.197.196.160]
Date:   Thu, 23 Sep 2021 19:32:27 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Johan Hovold" <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH] USB:serial:option Add Foxconn T99W265
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <YUxLKCGd0Icl+Mbv@hovoldconsulting.com>
References: <20210917110106.9852-1-slark_xiao@163.com>
 <YUhVKrRJ8M2hKJil@hovoldconsulting.com>
 <2992805f.bc9.17c0b33a78e.Coremail.slark_xiao@163.com>
 <YUxLKCGd0Icl+Mbv@hovoldconsulting.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <fed0c65.8937.17c126da334.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZcGowADn78_MZUxh6AWcAQ--.18435W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiMAwXZFWBzGBGBAACs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjEtMDktMjMgMTc6Mzg6NDgsICJKb2hhbiBIb3ZvbGQiIDxqb2hhbkBrZXJuZWwub3Jn
PiB3cm90ZToKPlsgUGxlYXNlIGNvbmZpZ3VyZSB5b3VyIG1haWwgY2xpZW50IHRvIHdyYXAgbGlu
ZXMgYXQgNzIgY29sdW1ucyBvciBzby4gXQo+Cj5PbiBXZWQsIFNlcCAyMiwgMjAyMSBhdCAwOTo1
MTo0N0FNICswODAwLCBTbGFyayBYaWFvIHdyb3RlOgo+PiBBdCAyMDIxLTA5LTIwIDE3OjMyOjI2
LCAiSm9oYW4gSG92b2xkIiA8am9oYW5Aa2VybmVsLm9yZz4gd3JvdGU6Cj4+ID5PbiBGcmksIFNl
cCAxNywgMjAyMSBhdCAwNzowMTowNlBNICswODAwLCBTbGFyayBYaWFvIHdyb3RlOgo+PiA+PiBB
ZGRpbmcgc3VwcG9ydCBmb3IgRm94Y29ubiBkZXZpY2UgVDk5VzI2NSBmb3IgZW51bWVyYXRpb24g
d2l0aAo+PiA+PiBQSUQgMHhlMGRiLgo+PiA+PiAKPj4gPj4gdXNiLWRldmljZXMgb3V0cHV0IGZv
ciAweGUwZGIKPj4gPj4gVDogIEJ1cz0wNCBMZXY9MDEgUHJudD0wMSBQb3J0PTAwIENudD0wMSBE
ZXYjPSAxOSBTcGQ9NTAwMCBNeENoPSAwCj4+ID4+IEQ6ICBWZXI9IDMuMjAgQ2xzPWVmKG1pc2Mg
KSBTdWI9MDIgUHJvdD0wMSBNeFBTPSA5ICNDZmdzPSAgMQo+PiA+PiBQOiAgVmVuZG9yPTA0ODkg
UHJvZElEPWUwZGIgUmV2PTA1LjA0Cj4+ID4+IFM6ICBNYW51ZmFjdHVyZXI9TWljcm9zb2Z0Cj4+
ID4+IFM6ICBQcm9kdWN0PUdlbmVyaWMgTW9iaWxlIEJyb2FkYmFuZCBBZGFwdGVyCj4+ID4+IFM6
ICBTZXJpYWxOdW1iZXI9NmM1MGY0NTIKPj4gPj4gQzogICNJZnM9IDUgQ2ZnIz0gMSBBdHI9YTAg
TXhQd3I9ODk2bUEKPj4gPj4gSTogIElmIz0weDAgQWx0PSAwICNFUHM9IDEgQ2xzPTAyKGNvbW1j
KSBTdWI9MGUgUHJvdD0wMCBEcml2ZXI9Y2RjX21iaW0KPj4gPj4gSTogIElmIz0weDEgQWx0PSAx
ICNFUHM9IDIgQ2xzPTBhKGRhdGEgKSBTdWI9MDAgUHJvdD0wMiBEcml2ZXI9Y2RjX21iaW0KPj4g
Pj4gSTogIElmIz0weDIgQWx0PSAwICNFUHM9IDMgQ2xzPWZmKHZlbmQuKSBTdWI9ZmYgUHJvdD00
MCBEcml2ZXI9b3B0aW9uCj4+ID4+IEk6ICBJZiM9MHgzIEFsdD0gMCAjRVBzPSAxIENscz1mZih2
ZW5kLikgU3ViPWZmIFByb3Q9ZmYgRHJpdmVyPShub25lKQo+PiA+PiBJOiAgSWYjPTB4NCBBbHQ9
IDAgI0VQcz0gMiBDbHM9ZmYodmVuZC4pIFN1Yj1mZiBQcm90PTMwIERyaXZlcj1vcHRpb24KPj4g
Pj4gCj4+ID4+IGlmMC8xOiBNQklNLCBpZjI6RGlhZywgaWYzOkdOU1MsIGlmNDogTW9kZW0KPj4g
Pj4gCj4+ID4+IFNpZ25lZC1vZmYtYnk6IFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4K
Pgo+PiA+PiAtLS0KPj4gPj4gIGRyaXZlcnMvdXNiL3NlcmlhbC9vcHRpb24uYyB8IDIgKysKPj4g
Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPj4gPj4gCj4+ID4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9zZXJpYWwvb3B0aW9uLmMgYi9kcml2ZXJzL3VzYi9zZXJpYWwvb3B0
aW9uLmMKPj4gPj4gaW5kZXggMjljNzY1Y2M4NDk1Li5mZGU1OTlmYTJkNzMgMTAwNjQ0Cj4+ID4+
IC0tLSBhL2RyaXZlcnMvdXNiL3NlcmlhbC9vcHRpb24uYwo+PiA+PiArKysgYi9kcml2ZXJzL3Vz
Yi9zZXJpYWwvb3B0aW9uLmMKPj4gPj4gQEAgLTIwNjgsNiArMjA2OCw4IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgdXNiX2RldmljZV9pZCBvcHRpb25faWRzW10gPSB7Cj4+ID4+ICAJICAuZHJpdmVy
X2luZm8gPSBSU1ZEKDApIHwgUlNWRCgxKSB8IFJTVkQoNikgfSwKPj4gPj4gIAl7IFVTQl9ERVZJ
Q0UoMHgwNDg5LCAweGUwYjUpLAkJCQkJCS8qIEZveGNvbm4gVDc3Vzk2OCBFU0lNICovCj4+ID4+
ICAJICAuZHJpdmVyX2luZm8gPSBSU1ZEKDApIHwgUlNWRCgxKSB8IFJTVkQoNikgfSwKPj4gPj4g
Kwl7IFVTQl9ERVZJQ0UoMHgwNDg5LCAweGUwZGIpLAkJCQkJCS8qIEZveGNvbm4gVDk5VzI2NSBN
QklNIGV4dGVuc2lvbiovCj4+ID4+ICsJICAuZHJpdmVyX2luZm8gPSBSU1ZEKDApIHwgUlNWRCgx
KSB8IFJTVkQoMykgfSwKPj4gPgo+PiA+SWYgeW91IHVzZSBVU0JfREVWSUNFX0lOVEVSRkFDRV9D
TEFTUygpIGluc3RlYWQgeW91IGRvbid0IG5lZWQgdG8KPj4gPmV4cGxpY2l0bHkgcmVzZXJ2ZSB0
aGUgTUJJTSBpbnRlcmZhY2VzLiAKPj4gPgo+PiA+QWxzbywgd2h5IGFyZSB5b3UgcmVzZXJ2aW5n
IHRoZSBHTlNTIGludGVyZmFjZSAoZS5nLiB1bmxpa2UgVDc3Vzk2OCk/Cj4+IAo+PiBJIGp1c3Qg
d2FudCB0byBrZWVwIHNhbWUgc3R5bGUgYXMgcHJldmlvdXMgcHJvZHVjdHMuIFRoYXQgd291bGQg
YmUKPj4gbW9yZSBjb29yZGluYXRlZCwgSSB0aGluay4KPgo+SSB1bmRlcnN0YW5kIHlvdXIgcG9p
bnQsIGJ1dCBpdCdzIGJldHRlciB0byB1c2UgYSBtb3JlIHNwZWNpZmljIG1hdGNoaW5nCj5ydWxl
IHdlcmUgcG9zc2libGUgc2luY2UgaXQgcHJldmVudHMgZHJpdmVyIGNvcmUgZnJvbSBldmVuIHRy
eWluZyB0bwo+YmluZCB0aGUgZHJpdmVyLgo+Cj5Ob3RlIHRoYXQgZm9yIFQ3N1c5Njggd2UgY291
bGRuJ3QgZG8gc28gc2luY2Ugd2UgbmVlZGVkIHRvIGJpbmQgYWxzbyB0bwo+bm9uLXZlbmRvci1j
bGFzcyBpbnRlcmZhY2VzLgo+Cj5JJ2xsIGp1c3QgY2hhbmdlIHRoaXMgdG8gVVNCX0RFVklDRV9J
TlRFUkZBQ0VfQ0xBU1MoKSB3aGVuIGFwcGx5aW5nLgo+Cj4+IEFuZCBmb3IgR05TUyBwb3J0LCBp
dCBjYW4ndCBiZSBzdXBwb3J0ZWQgd2l0aCBzZXJpYWwgZHJpdmVyLiBJdAo+PiBkb2Vzbid0IGxp
a2UgYSAgTk1FQSBwb3J0IHdoaWNoIGlzIHVzaW5nIHNlcmlhbCBkcml2ZXIuCj4+IEkgY2hlY2tl
ZCBpdCBmb3IgVDc3Vzk2OChNQklNIG1vZGUpIGFuZCBmb3VuZCBzZXR0aW5ncyBhcyBiZWxvdzoK
Pj4gaWYwL2lmMTogTUJJTSwgaWYyOiBNb2RlbSwgaWYzOkFULCAgaWY0OiBOTUVBLCBpZjU6IERp
YWcsIGlmNjogR05TUwo+PiBHTlNTIGlzIGFsc28gcmVzZXJ2ZWQuCj4KPkFoLCB0aGFua3MgZm9y
IGV4cGxhaW5pbmcuIEkgb25seSBzYXcgdGhhdCBUNzdXOTY4IGhhZCBhbiBOTUVBIHBvcnQgYW5k
Cj50aG91Z2h0IGl0IHdhcyB0aGUgc2FtZSBvbmUuCj4KPk5vdyBhcHBsaWVkIHdpdGggdGhlIGNo
YW5nZSBtZW50aW9uZWQgYWJvdmUuCj4KPkpvaGFuClRoYW5rcyBmb3IgdGhhdCE=
