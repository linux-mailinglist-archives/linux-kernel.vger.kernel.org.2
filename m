Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB4543DDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 11:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ1JqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 05:46:01 -0400
Received: from zg8tmtm4lje5ny4xodqumjaa.icoremail.net ([138.197.184.20]:36140
        "HELO zg8tmtm4lje5ny4xodqumjaa.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229835AbhJ1Jp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 05:45:57 -0400
X-Greylist: delayed 6067 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Oct 2021 05:45:56 EDT
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwCnO7h+cHphnvZIBg--.23498S2;
        Thu, 28 Oct 2021 17:42:22 +0800 (CST)
Received: by ajax-webmail-mail (Coremail) ; Thu, 28 Oct 2021 17:43:23 +0800
 (GMT+08:00)
X-Originating-IP: [47.241.249.160]
Date:   Thu, 28 Oct 2021 17:43:23 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5oi05b+X6L+c?= <daizhiyuan@phytium.com.cn>
To:     "Marc Zyngier" <maz@kernel.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Hector Martin" <marcan@marcan.st>,
        "Will Deacon" <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] irqchip/gic-v3: Fix EOImode semantics in
 git_cpu_sys_reg_init()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2021 www.mailtech.cn icmhosting
In-Reply-To: <8735olbl8x.wl-maz@kernel.org>
References: <1635408092-5259-1-git-send-email-daizhiyuan@phytium.com.cn>
 <8735olbl8x.wl-maz@kernel.org>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: PPnFUmZvb3Rlcl90eHQ9MjMxODozODM=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5c537930.226.17cc6485afa.Coremail.daizhiyuan@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwA3U9W8cHphuRsAAA--.200W
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/1tbiAQAPCmDcN2oEBQAFsh
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=daizhiyuan
        @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WFW8Ar1rWry5KF18WrWfZrb_yoW8tw17pF
        WDGa4rJr4fGa47WF4Ivw1UuFyYgws3KFWa9aykJF9rWr98Cr97tF4xtay7WF13Jry0yr1j
        vF4jqF9xuw4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmMuCgpTb3JyeSwgSSB3YXMgY2FyZWxlc3MsIEkgZGlkbid0IGxvb2sgY2FyZWZ1bGx5
IGF0IHRoZSBhY2Nlc3MgcHJvcGVydGllcyBvZiBlYWNoIGZpZWxkLiAKClRoYW5rIHlvdSBmb3Ig
eW91ciBjb3JyZWN0aW9uLgoKPiAKPiBIaSBaaGl1eWFuLAo+IAo+IE9uIFRodSwgMjggT2N0IDIw
MjEgMDk6MDE6MzEgKzAxMDAsCj4gWmhpeXVhbiBEYWkgPGRhaXpoaXl1YW5AcGh5dGl1bS5jb20u
Y24+IHdyb3RlOgo+ID4gCj4gPiBJQ0NfQ1RMUl9FTDEgaXMgYSA2NC1iaXQgcmVnaXN0ZXIuRU9J
bW9kZSwgYml0IFsxXSBFT0kgbW9kZQo+ID4gZm9yIHRoZSBjdXJyZW50IFNlY3VyaXR5IHN0YXRl
Lgo+ID4gCj4gPiBjdXJyZW50IGNvZGUgc2VtYW50aWNzIGlzIHNldCBJQ0NfQ1RMUl9FTDEgcmVn
aXN0ZXIgdG8gemVyby4KPiA+IFRoaXMgcGF0Y2ggb25seSBzZXQgdGhlIEVPSW1vZGUgQml0IHRv
IHplcm8uCj4gPiAKPiA+IHJlZnM6IFNlZSBBcm0gSUhJIDAwNjlHLCBwYWdlIDEyLTIyOS4KPiA+
IAo+ID4gU2lnbmVkLW9mZi1ieTogWmhpeXVhbiBEYWkgPGRhaXpoaXl1YW5AcGh5dGl1bS5jb20u
Y24+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My5jICAgICAgIHwgOSAr
KysrKysrLS0KPiA+ICBpbmNsdWRlL2xpbnV4L2lycWNoaXAvYXJtLWdpYy12My5oIHwgMyArLS0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+
IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLmMgYi9kcml2ZXJz
L2lycWNoaXAvaXJxLWdpYy12My5jCj4gPiBpbmRleCBmZDRlOWEzLi45NjQ2NmZjMCAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLmMKPiA+ICsrKyBiL2RyaXZlcnMv
aXJxY2hpcC9pcnEtZ2ljLXYzLmMKPiA+IEBAIC05NjcsNiArOTY3LDcgQEAgc3RhdGljIHZvaWQg
Z2ljX2NwdV9zeXNfcmVnX2luaXQodm9pZCkKPiA+ICAJdTY0IG5lZWRfcnNzID0gTVBJRFJfUlMo
bXBpZHIpOwo+ID4gIAlib29sIGdyb3VwMDsKPiA+ICAJdTMyIHByaWJpdHM7Cj4gPiArCXUzMiB2
YWw7Cj4gPiAgCj4gPiAgCS8qCj4gPiAgCSAqIE5lZWQgdG8gY2hlY2sgdGhhdCB0aGUgU1JFIGJp
dCBoYXMgYWN0dWFsbHkgYmVlbiBzZXQuIElmCj4gPiBAQCAtMTAwOSwxMiArMTAxMCwxNiBAQCBz
dGF0aWMgdm9pZCBnaWNfY3B1X3N5c19yZWdfaW5pdCh2b2lkKQo+ID4gIAkgKi8KPiA+ICAJZ2lj
X3dyaXRlX2JwcjEoMCk7Cj4gPiAgCj4gPiArCXZhbCA9IGdpY19yZWFkX2N0bHIoKTsKPiA+ICsK
PiA+ICAJaWYgKHN0YXRpY19icmFuY2hfbGlrZWx5KCZzdXBwb3J0c19kZWFjdGl2YXRlX2tleSkp
IHsKPiA+ICAJCS8qIEVPSSBkcm9wcyBwcmlvcml0eSBvbmx5IChtb2RlIDEpICovCj4gPiAtCQln
aWNfd3JpdGVfY3RscihJQ0NfQ1RMUl9FTDFfRU9JbW9kZV9kcm9wKTsKPiA+ICsJCXZhbCB8PSBJ
Q0NfQ1RMUl9FTDFfRU9JbW9kZTsKPiA+ICsJCWdpY193cml0ZV9jdGxyKHZhbCk7Cj4gPiAgCX0g
ZWxzZSB7Cj4gPiAgCQkvKiBFT0kgZGVhY3RpdmF0ZXMgaW50ZXJydXB0IHRvbyAobW9kZSAwKSAq
Lwo+ID4gLQkJZ2ljX3dyaXRlX2N0bHIoSUNDX0NUTFJfRUwxX0VPSW1vZGVfZHJvcF9kaXIpOwo+
ID4gKwkJdmFsICY9IH5JQ0NfQ1RMUl9FTDFfRU9JbW9kZTsKPiA+ICsJCWdpY193cml0ZV9jdGxy
KHZhbCk7Cj4gCj4gSSByZWFsbHkgd29uZGVyIHdoeSB5b3Ugd291bGQgbmVlZCBhIHJlYWQtbW9k
aWZ5LXdyaXRlIHNlcXVlbmNlLiBUaGVyZQo+IGFyZSBubyBiaXRzIGluIElDQ19DVExSX0VMMSB0
aGF0IHdlIHdvdWxkIHdhbnQgdG8gcHJlc2VydmU6Cj4gCj4gLSBQSE1FOiBpZiBpdCBpcyB3cml0
YWJsZSwgd2UgcmVhbGx5IHdhbnQgaXQgdG8gYmUgMCwgYXMgd2UgZG9uJ3QgdXNlCj4gICAxOk4g
ZGlzdHJpYnV0aW9uCj4gCj4gLSBDQlBSOiBXZSBvbmx5IHVzZSBHMSBpbnRlcnJ1cHRzLCBhbmQg
d2UgdXNlIElDQ19CUFIxX0VMMSBmb3IKPiAgIHByZWVtcHRpb24sIGhlbmNlIHRoZSB2YWx1ZSBi
ZWluZyAwCj4gCj4gQWxsIHRoZSBvdGhlciBmaWVsZHMgKGFwYXJ0IGZyb20gRU9JbW9kZSwgb2J2
aW91c2x5KSBhcmUgcmVhZC1vbmx5IG9yCj4gUkVTMCwgYXMgcGVyIHRoZSBhcmNoaXRlY3R1cmUu
Cj4gCj4gQ2FuIHlvdSBleHBsYWluIHdoYXQgeW91IGFyZSB0cnlpbmcgdG8gYWNoaWV2ZSBoZXJl
Pwo+IAo+IFRoYW5rcywKPiAKPiAJTS4KPiAKPiAtLSAKPiBXaXRob3V0IGRldmlhdGlvbiBmcm9t
IHRoZSBub3JtLCBwcm9ncmVzcyBpcyBub3QgcG9zc2libGUuCgoNCg0K5L+h5oGv5a6J5YWo5aOw
5piO77ya5pys6YKu5Lu25YyF5ZCr5L+h5oGv5b2S5Y+R5Lu25Lq65omA5Zyo57uE57uH5omA5pyJ
LOWPkeS7tuS6uuaJgOWcqOe7hOe7h+WvueivpemCruS7tuaLpeacieaJgOacieadg+WIqeOAguiv
t+aOpeaUtuiAheazqOaEj+S/neWvhizmnKrnu4/lj5Hku7bkurrkuabpnaLorrjlj68s5LiN5b6X
5ZCR5Lu75L2V56ys5LiJ5pa557uE57uH5ZKM5Liq5Lq66YCP6Zyy5pys6YKu5Lu25omA5ZCr5L+h
5oGv44CCDQpJbmZvcm1hdGlvbiBTZWN1cml0eSBOb3RpY2U6IFRoZSBpbmZvcm1hdGlvbiBjb250
YWluZWQgaW4gdGhpcyBtYWlsIGlzIHNvbGVseSBwcm9wZXJ0eSBvZiB0aGUgc2VuZGVyJ3Mgb3Jn
YW5pemF0aW9uLlRoaXMgbWFpbCBjb21tdW5pY2F0aW9uIGlzIGNvbmZpZGVudGlhbC5SZWNpcGll
bnRzIG5hbWVkIGFib3ZlIGFyZSBvYmxpZ2F0ZWQgdG8gbWFpbnRhaW4gc2VjcmVjeSBhbmQgYXJl
IG5vdCBwZXJtaXR0ZWQgdG8gZGlzY2xvc2UgdGhlIGNvbnRlbnRzIG9mIHRoaXMgY29tbXVuaWNh
dGlvbiB0byBvdGhlcnMu

