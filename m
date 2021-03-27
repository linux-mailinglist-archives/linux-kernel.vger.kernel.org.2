Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4552B34B3D9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 03:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhC0CjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 22:39:10 -0400
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:54742 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhC0Cig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 22:38:36 -0400
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id 63A92281F97;
        Sat, 27 Mar 2021 10:38:32 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ADMAxQB0Dp4HbUwKbHMPiKq8.3.1616812712398.Hmail.wangqing@vivo.com>
To:     pmladek@suse.com
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrey Ignatov <rdna@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6W1BBVENIIFYzLFJFU0VORF0gd29ya3F1ZXVlL3dhdGNoZG9nOiBNYWtlIHVuYm91bmQgd29ya3F1ZXVlcyBhd2FyZSBvZiB0b3VjaF9zb2Z0bG9ja3VwX3dhdGNoZG9nKCk=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <1616586031-31809-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Sat, 27 Mar 2021 10:38:32 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Sat, 27 Mar 2021 10:38:32 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkkeH0xCSRhLHUMYVkpNSk1DSklMSklPSUNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1JSEhLTU9DTUpCN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6PzY6Ayo5Sz8LTzMZLgwwGTM2KxIwCkNVSFVKTUpNQ0pJTEpJQ0pNVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZSE1VSk5JVUpPTlVKQ0lZV1kIAVlBTkpPSDcG
X-HM-Tid: 0a78718c21de9395kuws63a92281f97
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5WMzoKPi0gTW9kaWZ5IHRoZSBjb21taXQgbWVzc2FnZSBjbGVhcmx5IGFjY29yZGluZyB0byBQ
ZXRyJ3Mgc3VnZ2VzdGlvbi4KPgo+U2lnbmVkLW9mZi1ieTogV2FuZyBRaW5nIDx3YW5ncWluZ0B2
aXZvLmNvbT4KPi0tLQo+IGtlcm5lbC93YXRjaGRvZy5jICB8ICA1ICsrKy0tCj4ga2VybmVsL3dv
cmtxdWV1ZS5jIHwgMTcgKysrKysrLS0tLS0tLS0tLS0KPiAyIGZpbGVzIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4KPmRpZmYgLS1naXQgYS9rZXJuZWwvd2F0Y2hk
b2cuYyBiL2tlcm5lbC93YXRjaGRvZy5jCj5pbmRleCA3MTEwOTA2Li4xMDdiYzM4Cj4tLS0gYS9r
ZXJuZWwvd2F0Y2hkb2cuYwo+KysrIGIva2VybmVsL3dhdGNoZG9nLmMKPkBAIC0yNzgsOSArMjc4
LDEwIEBAIHZvaWQgdG91Y2hfYWxsX3NvZnRsb2NrdXBfd2F0Y2hkb2dzKHZvaWQpCj4gCSAqIHVw
ZGF0ZSBhcyB3ZWxsLCB0aGUgb25seSBzaWRlIGVmZmVjdCBtaWdodCBiZSBhIGN5Y2xlIGRlbGF5
IGZvcgo+IAkgKiB0aGUgc29mdGxvY2t1cCBjaGVjay4KPiAJICovCj4tCWZvcl9lYWNoX2NwdShj
cHUsICZ3YXRjaGRvZ19hbGxvd2VkX21hc2spCj4rCWZvcl9lYWNoX2NwdShjcHUsICZ3YXRjaGRv
Z19hbGxvd2VkX21hc2spIHsKPiAJCXBlcl9jcHUod2F0Y2hkb2dfdG91Y2hfdHMsIGNwdSkgPSBT
T0ZUTE9DS1VQX1JFU0VUOwo+LQl3cV93YXRjaGRvZ190b3VjaCgtMSk7Cj4rCQl3cV93YXRjaGRv
Z190b3VjaChjcHUpOwo+Kwl9Cj4gfQo+IAo+IHZvaWQgdG91Y2hfc29mdGxvY2t1cF93YXRjaGRv
Z19zeW5jKHZvaWQpCj5kaWZmIC0tZ2l0IGEva2VybmVsL3dvcmtxdWV1ZS5jIGIva2VybmVsL3dv
cmtxdWV1ZS5jCj5pbmRleCAwZDE1MGRhLi5iZTA4Mjk1Cj4tLS0gYS9rZXJuZWwvd29ya3F1ZXVl
LmMKPisrKyBiL2tlcm5lbC93b3JrcXVldWUuYwo+QEAgLTU3ODcsMjIgKzU3ODcsMTcgQEAgc3Rh
dGljIHZvaWQgd3Ffd2F0Y2hkb2dfdGltZXJfZm4oc3RydWN0IHRpbWVyX2xpc3QgKnVudXNlZCkK
PiAJCQljb250aW51ZTsKPiAKPiAJCS8qIGdldCB0aGUgbGF0ZXN0IG9mIHBvb2wgYW5kIHRvdWNo
ZWQgdGltZXN0YW1wcyAqLwo+KwkJaWYgKHBvb2wtPmNwdSA+PSAwKQo+KwkJCXRvdWNoZWQgPSBS
RUFEX09OQ0UocGVyX2NwdSh3cV93YXRjaGRvZ190b3VjaGVkX2NwdSwgcG9vbC0+Y3B1KSk7Cj4r
CQllbHNlCj4rCQkJdG91Y2hlZCA9IFJFQURfT05DRSh3cV93YXRjaGRvZ190b3VjaGVkKTsKPiAJ
CXBvb2xfdHMgPSBSRUFEX09OQ0UocG9vbC0+d2F0Y2hkb2dfdHMpOwo+LQkJdG91Y2hlZCA9IFJF
QURfT05DRSh3cV93YXRjaGRvZ190b3VjaGVkKTsKPiAKPiAJCWlmICh0aW1lX2FmdGVyKHBvb2xf
dHMsIHRvdWNoZWQpKQo+IAkJCXRzID0gcG9vbF90czsKPiAJCWVsc2UKPiAJCQl0cyA9IHRvdWNo
ZWQ7Cj4gCj4tCQlpZiAocG9vbC0+Y3B1ID49IDApIHsKPi0JCQl1bnNpZ25lZCBsb25nIGNwdV90
b3VjaGVkID0KPi0JCQkJUkVBRF9PTkNFKHBlcl9jcHUod3Ffd2F0Y2hkb2dfdG91Y2hlZF9jcHUs
Cj4tCQkJCQkJICBwb29sLT5jcHUpKTsKPi0JCQlpZiAodGltZV9hZnRlcihjcHVfdG91Y2hlZCwg
dHMpKQo+LQkJCQl0cyA9IGNwdV90b3VjaGVkOwo+LQkJfQo+LQo+IAkJLyogZGlkIHdlIHN0YWxs
PyAqLwo+IAkJaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywgdHMgKyB0aHJlc2gpKSB7Cj4gCQkJbG9j
a3VwX2RldGVjdGVkID0gdHJ1ZTsKPkBAIC01ODI2LDggKzU4MjEsOCBAQCBub3RyYWNlIHZvaWQg
d3Ffd2F0Y2hkb2dfdG91Y2goaW50IGNwdSkKPiB7Cj4gCWlmIChjcHUgPj0gMCkKPiAJCXBlcl9j
cHUod3Ffd2F0Y2hkb2dfdG91Y2hlZF9jcHUsIGNwdSkgPSBqaWZmaWVzOwo+LQllbHNlCj4tCQl3
cV93YXRjaGRvZ190b3VjaGVkID0gamlmZmllczsKPisKPisJd3Ffd2F0Y2hkb2dfdG91Y2hlZCA9
IGppZmZpZXM7Cj4gfQo+IAo+IHN0YXRpYyB2b2lkIHdxX3dhdGNoZG9nX3NldF90aHJlc2godW5z
aWduZWQgbG9uZyB0aHJlc2gpCj4tLSAKPjIuNy40Cj4KCkhpIFBldHI6CkNhbiB5b3UgZ2l2ZSBh
IHJldmlld2VkIHRhZywgb3IgcGljayBpdCB1cCB0byB3b3JrcXVldWUgdHJlZT8KVGhhbmtzLApR
aW5nCgoKDQoNCg==
