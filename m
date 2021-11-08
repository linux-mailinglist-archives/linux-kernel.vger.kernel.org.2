Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA49C447A77
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 07:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhKHGbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 01:31:53 -0500
Received: from m13131.mail.163.com ([220.181.13.131]:8768 "EHLO
        m13131.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbhKHGbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 01:31:52 -0500
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 01:31:51 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=hlQJ+
        1bmEUm6futV9zkpFzyaqLv13y3CNtspWRy6Ayo=; b=gkCWM3wxK0Xi0EsqDTqUs
        PFU1Zv+WHGQdLoQL5Shhsetwn2k12gaLO/9h+5YR6SpXOK3uVMMz50pScKZ1O1pW
        jvq/chXwwzH/vMpzK9Fwk71l9hCbCQTUxI6Aw/3rqljOkqe1eGj9ZODUIt6j28Mg
        MAbaVxB24eXfXkqLQ6ULp4=
Received: from slark_xiao$163.com ( [112.97.49.251] ) by
 ajax-webmail-wmsvr131 (Coremail) ; Mon, 8 Nov 2021 14:13:06 +0800 (CST)
X-Originating-IP: [112.97.49.251]
Date:   Mon, 8 Nov 2021 14:13:06 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     hmh@hmh.eng.br, hdegoede@redhat.com, mgross@linux.intel.com
Cc:     markpearson@lenovo.com, njoshi1@lenovo.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re:[PATCH v3] Fix WWAN device disabled issue after S3 deep
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <20211108060648.8212-1-slark_xiao@163.com>
References: <20211108060648.8212-1-slark_xiao@163.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <2fba6bb0.1aad.17cfe2dcd36.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: g8GowACHz4Hzv4hhuJQuAA--.44835W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivxJFZFWBwSyYoAABsM
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29ycmVjdCBhZGRyZXNzIGZvciBwbGF0Zm9ybS1kcml2ZXIteDg2LgoKQXQgMjAyMS0xMS0wOCAx
NDowNjo0OCwgIlNsYXJrIFhpYW8iIDxzbGFya194aWFvQDE2My5jb20+IHdyb3RlOgo+V2hlbiBX
V0FOIGRldmljZSB3YWtlIGZyb20gUzMgZGVlcCwgdW5kZXIgdGhpbmtwYWQgcGxhdGZvcm0sCj5X
V0FOIHdvdWxkIGJlIGRpc2FibGVkLiBUaGlzIGRpc2FibGUgc3RhdHVzIGNvdWxkIGJlIGNoZWNr
ZWQKPmJ5IGNvbW1hbmQgJ25tY2xpIHIgd3dhbicgb3IgJ3Jma2lsbCBsaXN0Jy4KPgo+SXNzdWUg
YW5hbHlzaXMgYXMgYmVsb3c6Cj4gIFdoZW4gaG9zdCByZXN1bWUgZnJvbSBTMyBkZWVwLCB0aGlu
a3BhZF9hY3BpIGRyaXZlciB3b3VsZAo+Y2FsbCBob3RrZXlfcmVzdW1lKCkgZnVuY3Rpb24uIEZp
bm5hbHksIGl0IHdpbGwgdXNlCj53YW5fZ2V0X3N0YXR1cyB0byBjaGVjayB0aGUgY3VycmVudCBz
dGF0dXMgb2YgV1dBTiBkZXZpY2UuCj5EdXJpbmcgdGhpcyByZXN1bWUgcHJvZ3Jlc3MsIHdhbl9n
ZXRfc3RhdHVzIHdvdWxkIGFsd2F5cwo+cmV0dXJuIG9mZiBldmVuIFdXQU4gYm9vdCB1cCBjb21w
bGV0ZWx5Lgo+ICBJbiBwYXRjaCBWMiwgSGFucyBzYWlkICdzd19zdGF0ZSBzaG91bGQgYmUgdW5j
aGFuZ2VkCj5hZnRlciBhIHN1c3BlbmQvcmVzdW1lLiBJdCdzIGJldHRlciB0byBkcm9wIHRoZQo+
dHBhY3BpX3Jma191cGRhdGVfc3dzdGF0ZSBjYWxsIGFsbCB0b2dldGhlciBmcm9tIHRoZQo+cmVz
dW1lIHBhdGgnLgo+ICBBbmQgaXQncyBjb25maW1lZCBieSBMZW5vdm8gdGhhdCBHV0FOIGlzIG5v
IGxvbmdlcgo+IGF2YWlsYWJsZSBmcm9tIFdITCBnZW5lcmF0aW9uIGJlY2F1c2UgdGhlIGRlc2ln
biBkb2VzIG5vdAo+IG1hdGNoIHdpdGggY3VycmVudCBwaW4gY29udHJvbC4KPgo+U2lnbmVkLW9m
Zi1ieTogU2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPgo+LS0tCj4gZHJpdmVycy9wbGF0
Zm9ybS94ODYvdGhpbmtwYWRfYWNwaS5jIHwgMTIgLS0tLS0tLS0tLS0tCj4gMSBmaWxlIGNoYW5n
ZWQsIDEyIGRlbGV0aW9ucygtKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYv
dGhpbmtwYWRfYWNwaS5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvdGhpbmtwYWRfYWNwaS5jCj5p
bmRleCA1MGZmMDRjODQ2NTAuLmYxY2JkMjcyODJlMSAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvcGxh
dGZvcm0veDg2L3RoaW5rcGFkX2FjcGkuYwo+KysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvdGhp
bmtwYWRfYWNwaS5jCj5AQCAtMTE3OCwxNSArMTE3OCw2IEBAIHN0YXRpYyBpbnQgdHBhY3BpX3Jm
a191cGRhdGVfc3dzdGF0ZShjb25zdCBzdHJ1Y3QgdHBhY3BpX3JmayAqdHBfcmZrKQo+IAlyZXR1
cm4gc3RhdHVzOwo+IH0KPiAKPi0vKiBRdWVyeSBGVyBhbmQgdXBkYXRlIHJma2lsbCBzdyBzdGF0
ZSBmb3IgYWxsIHJma2lsbCBzd2l0Y2hlcyAqLwo+LXN0YXRpYyB2b2lkIHRwYWNwaV9yZmtfdXBk
YXRlX3N3c3RhdGVfYWxsKHZvaWQpCj4tewo+LQl1bnNpZ25lZCBpbnQgaTsKPi0KPi0JZm9yIChp
ID0gMDsgaSA8IFRQQUNQSV9SRktfU1dfTUFYOyBpKyspCj4tCQl0cGFjcGlfcmZrX3VwZGF0ZV9z
d3N0YXRlKHRwYWNwaV9yZmtpbGxfc3dpdGNoZXNbaV0pOwo+LX0KPi0KPiAvKgo+ICAqIFN5bmMg
dGhlIEhXLWJsb2NraW5nIHN0YXRlIG9mIGFsbCByZmtpbGwgc3dpdGNoZXMsCj4gICogZG8gbm90
aWNlIGl0IGNhdXNlcyB0aGUgcmZraWxsIGNvcmUgdG8gc2NoZWR1bGUgdWV2ZW50cwo+QEAgLTMx
MjksOSArMzEyMCw2IEBAIHN0YXRpYyB2b2lkIHRwYWNwaV9zZW5kX3JhZGlvc3dfdXBkYXRlKHZv
aWQpCj4gCWlmICh3bHN3ID09IFRQQUNQSV9SRktfUkFESU9fT0ZGKQo+IAkJdHBhY3BpX3Jma191
cGRhdGVfaHdibG9ja19zdGF0ZSh0cnVlKTsKPiAKPi0JLyogU3luYyBzdyBibG9ja2luZyBzdGF0
ZSAqLwo+LQl0cGFjcGlfcmZrX3VwZGF0ZV9zd3N0YXRlX2FsbCgpOwo+LQo+IAkvKiBTeW5jIGh3
IGJsb2NraW5nIHN0YXRlIGxhc3QgaWYgaXQgaXMgaHctdW5ibG9ja2VkICovCj4gCWlmICh3bHN3
ID09IFRQQUNQSV9SRktfUkFESU9fT04pCj4gCQl0cGFjcGlfcmZrX3VwZGF0ZV9od2Jsb2NrX3N0
YXRlKGZhbHNlKTsKPi0tIAo+Mi4yNS4xCg==
