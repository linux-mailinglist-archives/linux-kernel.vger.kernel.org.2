Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A534DF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhC3DoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:44:16 -0400
Received: from m176151.mail.qiye.163.com ([59.111.176.151]:10545 "EHLO
        m176151.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhC3DoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:44:01 -0400
Received: from vivo.com (wm-11.qy.internal [127.0.0.1])
        by m176151.mail.qiye.163.com (Hmail) with ESMTP id 472CF4849A1;
        Tue, 30 Mar 2021 11:43:59 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <APcAuQDuDoaKZeMS7b0m6apU.3.1617075839282.Hmail.wanjiabing@vivo.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gbGludXgvdHJhY2VfZXZlbnRzLmg6IFJlbW92ZSBkdXBsaWNhdGUgc3RydWN0IGRlY2xhcmF0aW9u?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <20210329232901.038ecb4f@gandalf.local.home>
MIME-Version: 1.0
Received: from wanjiabing@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 30 Mar 2021 11:43:59 +0800 (GMT+08:00)
From:   =?UTF-8?B?5LiH5a625YW1?= <wanjiabing@vivo.com>
Date:   Tue, 30 Mar 2021 11:43:59 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSxlMHRlMThgaQ09DVkpNSkxLTE5DSEJIQk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1JT05CSEpDQ0hPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Kxg6Dio*Dj8UGjAhHjYoTBlLFk0aCy5VSFVKTUpMS0xOQ0hCTUNNVTMWGhIXVQwaFRESGhkS
        FRw7DRINFFUYFBZFWVdZEgtZQVlITVVKTklVSk9OVUpDSVlXWQgBWUFITENKNwY+
X-HM-Tid: 0a78813b213d93b5kuws472cf4849a1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IAo+T24gVHVlLCAzMCBNYXIgMjAyMSAwOTo1NToxNyArMDgwMD5XYW4gSmlhYmluZyA8d2Fuamlh
YmluZ0B2aXZvLmNvbT4gd3JvdGU6Cj4KPj4gc3RydWN0IHRyYWNlX2FycmF5IGlzIGRlY2xhcmVk
IHR3aWNlLiBPbmUgaGFzIGJlZW4gZGVjbGFyZWQKPj4gYXQgZm9yd2FyZCBzdHJ1Y3QgZGVjbGFy
YXRpb24uIFJlbW92ZSB0aGUgZHVwbGljYXRlLgo+PiBBbmQgc29ydCB0aGVzZSBmb3J3YXJkIGRl
Y2xhcmF0aW9ucyBhbHBoYWJldGljYWxseS4KPgo+VW0sIG5vIHRoYXQncyBub3QgaG93IHdlIHNv
cnQgdGhpbmdzLgo+Cj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBXYW4gSmlhYmluZyA8d2FuamlhYmlu
Z0B2aXZvLmNvbT4KPj4gLS0tCj4+ICBpbmNsdWRlL2xpbnV4L3RyYWNlX2V2ZW50cy5oIHwgNyAr
KystLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQo+PiAKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdHJhY2VfZXZlbnRzLmggYi9pbmNs
dWRlL2xpbnV4L3RyYWNlX2V2ZW50cy5oCj4+IGluZGV4IDI4ZTdhZjE0MDZmMi4uMjlhZTNlYzVj
YWI5IDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3RyYWNlX2V2ZW50cy5oCj4+ICsrKyBi
L2luY2x1ZGUvbGludXgvdHJhY2VfZXZlbnRzLmgKPj4gQEAgLTEwLDExICsxMCwxMSBAQAo+PiAg
I2luY2x1ZGUgPGxpbnV4L3BlcmZfZXZlbnQuaD4KPj4gICNpbmNsdWRlIDxsaW51eC90cmFjZXBv
aW50Lmg+Cj4+ICAKPj4gLXN0cnVjdCB0cmFjZV9hcnJheTsKPj4gIHN0cnVjdCBhcnJheV9idWZm
ZXI7Cj4+IC1zdHJ1Y3QgdHJhY2VyOwo+PiAtc3RydWN0IGRlbnRyeTsKPj4gIHN0cnVjdCBicGZf
cHJvZzsKPj4gK3N0cnVjdCBkZW50cnk7Cj4+ICtzdHJ1Y3QgdHJhY2VyOwo+PiArc3RydWN0IHRy
YWNlX2FycmF5Owo+Cj5OQUsgdG8gdGhlIGFib3ZlLiBJZiBhbnl0aGluZywgd2Ugc29ydCBpdCBi
eSBsZW5ndGguIEJ1dCB0aGUgYWJvdmUgZG9lc24ndAo+bmVlZCB0byBiZSB0b3VjaGVkLgo+CgpP
SywgSSBrbm93LiBJIHJlc2VuZCB0aGUgdjIuClBsZWFzZSByZXZpZXcuCgpZb3VycywKV2FuIEpp
YWJpbmcKCj4+ICAKPj4gIGNvbnN0IGNoYXIgKnRyYWNlX3ByaW50X2ZsYWdzX3NlcShzdHJ1Y3Qg
dHJhY2Vfc2VxICpwLCBjb25zdCBjaGFyICpkZWxpbSwKPj4gIAkJCQkgIHVuc2lnbmVkIGxvbmcg
ZmxhZ3MsCj4+IEBAIC00MDQsNyArNDA0LDYgQEAgdHJhY2VfZ2V0X2ZpZWxkcyhzdHJ1Y3QgdHJh
Y2VfZXZlbnRfY2FsbCAqZXZlbnRfY2FsbCkKPj4gIAlyZXR1cm4gZXZlbnRfY2FsbC0+Y2xhc3Mt
PmdldF9maWVsZHMoZXZlbnRfY2FsbCk7Cj4+ICB9Cj4+ICAKPj4gLXN0cnVjdCB0cmFjZV9hcnJh
eTsKPgo+VGhpcyBwYXJ0IGlzIGZpbmUuCj4KPlRoYW5rcywKPgo+LS0gU3RldmUKPgo+PiAgc3Ry
dWN0IHRyYWNlX3N1YnN5c3RlbV9kaXI7Cj4+ICAKPj4gIGVudW0gewo+Cg0KDQo=
