Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6254C413F40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhIVCIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:08:47 -0400
Received: from m1353.mail.163.com ([220.181.13.53]:40894 "EHLO
        m1353.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhIVCIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:08:45 -0400
X-Greylist: delayed 923 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2021 22:08:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=0jByO
        U6YoAr0xNi7fOL95kexfWdGhbTncKzQAa9Si+U=; b=dN+MuAwfK4IMJXkyorz/1
        fgElwV/d6AGzwp4Ha/Hwd20kYxZNK18YgCo0r9rxzhfVxDyoUBgEO97DJXop7EDk
        vM0AAcuK7Vp7t5kiJJE5rfI5uRQfogeFAGXjY7GkrIHXtUUYmViKDCLto+RlJdEf
        /dlpYnPtnb9UXfFFOEypRs=
Received: from slark_xiao$163.com ( [223.104.68.0] ) by ajax-webmail-wmsvr53
 (Coremail) ; Wed, 22 Sep 2021 09:51:47 +0800 (CST)
X-Originating-IP: [223.104.68.0]
Date:   Wed, 22 Sep 2021 09:51:47 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Johan Hovold" <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] USB:serial:option Add Foxconn T99W265
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <YUhVKrRJ8M2hKJil@hovoldconsulting.com>
References: <20210917110106.9852-1-slark_xiao@163.com>
 <YUhVKrRJ8M2hKJil@hovoldconsulting.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <2992805f.bc9.17c0b33a78e.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: NcGowACHhOYzjEphBC7NAA--.52284W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbioxMWZFUMY-NuZAAAsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIxLTA5LTIwIDE3OjMyOjI2LCAiSm9oYW4gSG92b2xkIiA8am9oYW5Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj5PbiBGcmksIFNlcCAxNywgMjAyMSBhdCAwNzowMTowNlBNICswODAwLCBTbGFy
ayBYaWFvIHdyb3RlOgo+PiBBZGRpbmcgc3VwcG9ydCBmb3IgRm94Y29ubiBkZXZpY2UgVDk5VzI2
NSBmb3IgZW51bWVyYXRpb24gd2l0aAo+PiBQSUQgMHhlMGRiLgo+PiAKPj4gdXNiLWRldmljZXMg
b3V0cHV0IGZvciAweGUwZGIKPj4gVDogIEJ1cz0wNCBMZXY9MDEgUHJudD0wMSBQb3J0PTAwIENu
dD0wMSBEZXYjPSAxOSBTcGQ9NTAwMCBNeENoPSAwCj4+IEQ6ICBWZXI9IDMuMjAgQ2xzPWVmKG1p
c2MgKSBTdWI9MDIgUHJvdD0wMSBNeFBTPSA5ICNDZmdzPSAgMQo+PiBQOiAgVmVuZG9yPTA0ODkg
UHJvZElEPWUwZGIgUmV2PTA1LjA0Cj4+IFM6ICBNYW51ZmFjdHVyZXI9TWljcm9zb2Z0Cj4+IFM6
ICBQcm9kdWN0PUdlbmVyaWMgTW9iaWxlIEJyb2FkYmFuZCBBZGFwdGVyCj4+IFM6ICBTZXJpYWxO
dW1iZXI9NmM1MGY0NTIKPj4gQzogICNJZnM9IDUgQ2ZnIz0gMSBBdHI9YTAgTXhQd3I9ODk2bUEK
Pj4gSTogIElmIz0weDAgQWx0PSAwICNFUHM9IDEgQ2xzPTAyKGNvbW1jKSBTdWI9MGUgUHJvdD0w
MCBEcml2ZXI9Y2RjX21iaW0KPj4gSTogIElmIz0weDEgQWx0PSAxICNFUHM9IDIgQ2xzPTBhKGRh
dGEgKSBTdWI9MDAgUHJvdD0wMiBEcml2ZXI9Y2RjX21iaW0KPj4gSTogIElmIz0weDIgQWx0PSAw
ICNFUHM9IDMgQ2xzPWZmKHZlbmQuKSBTdWI9ZmYgUHJvdD00MCBEcml2ZXI9b3B0aW9uCj4+IEk6
ICBJZiM9MHgzIEFsdD0gMCAjRVBzPSAxIENscz1mZih2ZW5kLikgU3ViPWZmIFByb3Q9ZmYgRHJp
dmVyPShub25lKQo+PiBJOiAgSWYjPTB4NCBBbHQ9IDAgI0VQcz0gMiBDbHM9ZmYodmVuZC4pIFN1
Yj1mZiBQcm90PTMwIERyaXZlcj1vcHRpb24KPj4gCj4+IGlmMC8xOiBNQklNLCBpZjI6RGlhZywg
aWYzOkdOU1MsIGlmNDogTW9kZW0KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFNsYXJrIFhpYW8gPHNs
YXJrX3hpYW9AMTYzLmNvbT4KPgo+VGhhbmtzIGZvciB0aGUgcGF0Y2ggYW5kIGZvciBpbmNsdWRp
bmcgYWxsIHRoZSBuZWNlc3NhcnkgZGV0YWlscyBpbiB0aGUKPmNvbW1pdCBtZXNzYWdlLgo+Cj5G
aXJzdCwgYSBtaW5vciBzdHlsZSBuaXQ6IFBsZWFzZSBhZGQgc3BhY2VzIGFmdGVyIHRoZSAnOidz
IGluIHRoZSBwYXRjaAo+U3ViamVjdC4KPgoKVGhhbmtzIGZvciB5b3VyIHdhcm0gbm90aWNlLiBJ
IHdpbGwgbWluZCB0aGlzIGluIGZ1dHVyZS4KCj4+IC0tLQo+PiAgZHJpdmVycy91c2Ivc2VyaWFs
L29wdGlvbi5jIHwgMiArKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+PiAK
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3NlcmlhbC9vcHRpb24uYyBiL2RyaXZlcnMvdXNi
L3NlcmlhbC9vcHRpb24uYwo+PiBpbmRleCAyOWM3NjVjYzg0OTUuLmZkZTU5OWZhMmQ3MyAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy91c2Ivc2VyaWFsL29wdGlvbi5jCj4+ICsrKyBiL2RyaXZlcnMv
dXNiL3NlcmlhbC9vcHRpb24uYwo+PiBAQCAtMjA2OCw2ICsyMDY4LDggQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCB1c2JfZGV2aWNlX2lkIG9wdGlvbl9pZHNbXSA9IHsKPj4gIAkgIC5kcml2ZXJfaW5m
byA9IFJTVkQoMCkgfCBSU1ZEKDEpIHwgUlNWRCg2KSB9LAo+PiAgCXsgVVNCX0RFVklDRSgweDA0
ODksIDB4ZTBiNSksCQkJCQkJLyogRm94Y29ubiBUNzdXOTY4IEVTSU0gKi8KPj4gIAkgIC5kcml2
ZXJfaW5mbyA9IFJTVkQoMCkgfCBSU1ZEKDEpIHwgUlNWRCg2KSB9LAo+PiArCXsgVVNCX0RFVklD
RSgweDA0ODksIDB4ZTBkYiksCQkJCQkJLyogRm94Y29ubiBUOTlXMjY1IE1CSU0gZXh0ZW5zaW9u
Ki8KPj4gKwkgIC5kcml2ZXJfaW5mbyA9IFJTVkQoMCkgfCBSU1ZEKDEpIHwgUlNWRCgzKSB9LAo+
Cj5JZiB5b3UgdXNlIFVTQl9ERVZJQ0VfSU5URVJGQUNFX0NMQVNTKCkgaW5zdGVhZCB5b3UgZG9u
J3QgbmVlZCB0bwo+ZXhwbGljaXRseSByZXNlcnZlIHRoZSBNQklNIGludGVyZmFjZXMuIAo+Cj5B
bHNvLCB3aHkgYXJlIHlvdSByZXNlcnZpbmcgdGhlIEdOU1MgaW50ZXJmYWNlIChlLmcuIHVubGlr
ZSBUNzdXOTY4KT8KCkkganVzdCB3YW50IHRvIGtlZXAgc2FtZSBzdHlsZSBhcyBwcmV2aW91cyBw
cm9kdWN0cy4gVGhhdCB3b3VsZCBiZSBtb3JlIGNvb3JkaW5hdGVkLCBJIHRoaW5rLgpBbmQgZm9y
IEdOU1MgcG9ydCwgaXQgY2FuJ3QgYmUgc3VwcG9ydGVkIHdpdGggc2VyaWFsIGRyaXZlci4gSXQg
ZG9lc24ndCBsaWtlIGEgIE5NRUEgcG9ydCB3aGljaCBpcyB1c2luZyBzZXJpYWwgZHJpdmVyLgpJ
IGNoZWNrZWQgaXQgZm9yIFQ3N1c5NjgoTUJJTSBtb2RlKSBhbmQgZm91bmQgc2V0dGluZ3MgYXMg
YmVsb3c6CmlmMC9pZjE6IE1CSU0sIGlmMjogTW9kZW0sIGlmMzpBVCwgIGlmNDogTk1FQSwgaWY1
OiBEaWFnLCBpZjY6IEdOU1MKR05TUyBpcyBhbHNvIHJlc2VydmVkLgoKVGhhbmtzLgo+Cj4+ICAJ
eyBVU0JfREVWSUNFKDB4MTUwOCwgMHgxMDAxKSwJCQkJCQkvKiBGaWJvY29tIE5MNjY4IChJT1Qg
dmVyc2lvbikgKi8KPj4gIAkgIC5kcml2ZXJfaW5mbyA9IFJTVkQoNCkgfCBSU1ZEKDUpIHwgUlNW
RCg2KSB9LAo+PiAgCXsgVVNCX0RFVklDRSgweDJjYjcsIDB4MDEwNCksCQkJCQkJLyogRmlib2Nv
bSBOTDY3OCBzZXJpZXMgKi8KPgo+Sm9oYW4K
