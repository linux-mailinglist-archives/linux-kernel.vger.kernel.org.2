Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91C634DDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhC3Bpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:45:54 -0400
Received: from m176151.mail.qiye.163.com ([59.111.176.151]:41856 "EHLO
        m176151.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhC3Bps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:45:48 -0400
X-Greylist: delayed 683 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2021 21:45:47 EDT
Received: from vivo.com (wm-11.qy.internal [127.0.0.1])
        by m176151.mail.qiye.163.com (Hmail) with ESMTP id A2C0C481FE3;
        Tue, 30 Mar 2021 09:34:22 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ADoALwDyDqqKqolXZoBMHqqQ.3.1617068062644.Hmail.wanjiabing@vivo.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Aric Cyr <aric.cyr@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Jacky Liao <ziyu.liao@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kael_w@yeah.net
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gYW1kOiBkaXNwbGF5OiBkYzogc3RydWN0IGRjX3N0YXRlIGlzIGRlY2xhcmVkIHR3aWNl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <CADnq5_PSnvFAcUt7T9q=L8v6sFGnLM72cot=Lq_+cs8cNHK5sg@mail.gmail.com>
MIME-Version: 1.0
Received: from wanjiabing@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 30 Mar 2021 09:34:22 +0800 (GMT+08:00)
From:   =?UTF-8?B?5LiH5a625YW1?= <wanjiabing@vivo.com>
Date:   Tue, 30 Mar 2021 09:34:22 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTU9LSUtNHkhLT0oeVkpNSkxLTUNLTUlNQkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1JT09DTUlKS01PN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6PxQ6Nww*Aj8KCjAKFBcjIRQ5NjMKCipVSFVKTUpMS01DS01IS01JVTMWGhIXVQwaFRESGhkS
        FRw7DRINFFUYFBZFWVdZEgtZQVlITVVKTklVSk9OVUpDSVlXWQgBWUFDTklCNwY+
X-HM-Tid: 0a7880c477d393b5kuwsa2c0c481fe3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IAo+T24gU2F0LCBNYXIgMjcsIDIwMjEgYXQgMzoyOCBBTSBXYW4gSmlhYmluZyA8d2FuamlhYmlu
Z0B2aXZvLmNvbT4gd3JvdGU6Cj4+Cj4+IHN0cnVjdCBkY19zdGF0ZSBoYXMgYmVlbiBkZWNsYXJl
ZCBhdCAyNzNyZCBsaW5lLgo+PiBSZW1vdmUgdGhlIGR1cGxpY2F0ZS4KPj4gRGVsZXRlIGR1cGxp
Y2F0ZSBibGFuayBsaW5lcy4KPgo+Q2FuIHlvdSBzcGxpdCB0aGVzZSBpbnRvIHNlcGFyYXRlIHBh
dGNoZXM/Cj4KPkFsZXgKCk9LLiBCdXQgaW4gZmFjdCwgd2hhdCBJIGRpZCAgaXMgc2ltcGxlLgpU
aGUgbW9zdCBpbXBvcnRhbnQgdGhpbmcgaXMgcmVtb3ZpbmcgdGhlIGR1cGxpY2F0ZQpzdHJ1Y3Qg
ZGNfc3RhdGUgZGVjbGFyYXRpb24gYXQgNTg1dGggbGluZS4KT3RoZXJzIGFyZSBhbGwgZGVsZXRp
bmcgZHVwbGljYXRlIGJsYW5rIGxpbmVzLgoKU28gbWF5YmUgSSBzaG91bGQgc2VuZCB0d28gcGF0
Y2hzLCBvbmUgaXMgcmVtb3ZpbmcKZHVwbGljYXRlIGRlY2xhcmF0aW9uLCB0aGUgb3RoZXIgaXMg
ZGVsZXRpbmcgYmxhbmsgbGluZXM/Cgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBXYW4gSmlhYmluZyA8
d2FuamlhYmluZ0B2aXZvLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGMuaCB8IDEwIC0tLS0tLS0tLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Yy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKPj4gaW5kZXggMThlZDBk
M2YyNDdlLi5kYzY2NzI5OGFiNWIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kYy5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Yy5oCj4+IEBAIC0yMzQsNyArMjM0LDYgQEAgc3RydWN0IGRjX3N0YXRpY19zY3JlZW5fcGFyYW1z
IHsKPj4gICAgICAgICB1bnNpZ25lZCBpbnQgbnVtX2ZyYW1lczsKPj4gIH07Cj4+Cj4+IC0KPj4g
IC8qIFN1cmZhY2UgdXBkYXRlIHR5cGUgaXMgdXNlZCBieSBkY191cGRhdGVfc3VyZmFjZXNfYW5k
X3N0cmVhbQo+PiAgICogVGhlIHVwZGF0ZSB0eXBlIGlzIGRldGVybWluZWQgYXQgdGhlIHZlcnkg
YmVnaW5uaW5nIG9mIHRoZSBmdW5jdGlvbiBiYXNlZAo+PiAgICogb24gcGFyYW1ldGVycyBwYXNz
ZWQgaW4gYW5kIGRlY2lkZXMgaG93IG11Y2ggcHJvZ3JhbW1pbmcgKG9yIHVwZGF0aW5nKSBpcwo+
PiBAQCAtMjcyLDcgKzI3MSw2IEBAIHN0cnVjdCBkYzsKPj4gIHN0cnVjdCBkY19wbGFuZV9zdGF0
ZTsKPj4gIHN0cnVjdCBkY19zdGF0ZTsKPj4KPj4gLQo+PiAgc3RydWN0IGRjX2NhcF9mdW5jcyB7
Cj4+ICAgICAgICAgYm9vbCAoKmdldF9kY2NfY29tcHJlc3Npb25fY2FwKShjb25zdCBzdHJ1Y3Qg
ZGMgKmRjLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgZGNfZGNjX3N1
cmZhY2VfcGFyYW0gKmlucHV0LAo+PiBAQCAtMjgxLDcgKzI3OSw2IEBAIHN0cnVjdCBkY19jYXBf
ZnVuY3Mgewo+Pgo+PiAgc3RydWN0IGxpbmtfdHJhaW5pbmdfc2V0dGluZ3M7Cj4+Cj4+IC0KPj4g
IC8qIFN0cnVjdHVyZSB0byBob2xkIGNvbmZpZ3VyYXRpb24gZmxhZ3Mgc2V0IGJ5IGRtIGF0IGRj
IGNyZWF0aW9uLiAqLwo+PiAgc3RydWN0IGRjX2NvbmZpZyB7Cj4+ICAgICAgICAgYm9vbCBncHVf
dm1fc3VwcG9ydDsKPj4gQEAgLTU4MSw3ICs1NzgsNiBAQCBzdHJ1Y3QgZGNfYm91bmRpbmdfYm94
X292ZXJyaWRlcyB7Cj4+ICAgICAgICAgaW50IG1pbl9kY2ZjbGtfbWh6Owo+PiAgfTsKPj4KPj4g
LXN0cnVjdCBkY19zdGF0ZTsKClJlbW92aW5nIHRoZSBkdXBsaWNhdGUgaXMgaGVyZS4KQW5kIG90
aGVycyBhcmUgYWxsIGRlbGV0aW5nIGR1cGxpY2F0ZSBibGFuayBsaW5lLgoKSSB0aGluayB0aGV5
IGFyZSBpbiB0aGUgc2FtZSBmaWxlLiBJIHdhbnQgdG8gcmVtb3ZlIHRoZSBkZWNsYXJhdGlvbiBm
aXJzdC4KQnkgdGhlIHdheSwgSSBkZWxldGVkIHRoZSBibGFuayBsaW5lLgoKWW91cnMsCldhbiBK
aWFiaW5nCgo+PiAgc3RydWN0IHJlc291cmNlX3Bvb2w7Cj4+ICBzdHJ1Y3QgZGNlX2h3c2VxOwo+
PiAgc3RydWN0IGdwdV9pbmZvX3NvY19ib3VuZGluZ19ib3hfdjFfMDsKPj4gQEAgLTc1Nyw3ICs3
NTMsNiBAQCBlbnVtIGRjX3RyYW5zZmVyX2Z1bmNfcHJlZGVmaW5lZCB7Cj4+ICAgICAgICAgVFJB
TlNGRVJfRlVOQ1RJT05fR0FNTUEyNgo+PiAgfTsKPj4KPj4gLQo+PiAgc3RydWN0IGRjX3RyYW5z
ZmVyX2Z1bmMgewo+PiAgICAgICAgIHN0cnVjdCBrcmVmIHJlZmNvdW50Owo+PiAgICAgICAgIGVu
dW0gZGNfdHJhbnNmZXJfZnVuY190eXBlIHR5cGU7Cj4+IEBAIC03NzAsNyArNzY1LDYgQEAgc3Ry
dWN0IGRjX3RyYW5zZmVyX2Z1bmMgewo+PiAgICAgICAgIH07Cj4+ICB9Owo+Pgo+PiAtCj4+ICB1
bmlvbiBkY18zZGx1dF9zdGF0ZSB7Cj4+ICAgICAgICAgc3RydWN0IHsKPj4gICAgICAgICAgICAg
ICAgIHVpbnQzMl90IGluaXRpYWxpemVkOjE7ICAgICAgICAgLyppZiAzZGx1dCBpcyB3ZW50IHRo
cm91Z2ggY29sb3IgbW9kdWxlIGZvciBpbml0aWFsaXphdGlvbiAqLwo+PiBAQCAtNzg0LDcgKzc3
OCw2IEBAIHVuaW9uIGRjXzNkbHV0X3N0YXRlIHsKPj4gICAgICAgICB1aW50MzJfdCByYXc7Cj4+
ICB9Owo+Pgo+PiAtCj4+ICBzdHJ1Y3QgZGNfM2RsdXQgewo+PiAgICAgICAgIHN0cnVjdCBrcmVm
IHJlZmNvdW50Owo+PiAgICAgICAgIHN0cnVjdCB0ZXRyYWhlZHJhbF9wYXJhbXMgbHV0XzNkOwo+
PiBAQCAtMTAxNCw3ICsxMDA3LDYgQEAgZW51bSBkY19zdGF0dXMgZGNfdmFsaWRhdGVfZ2xvYmFs
X3N0YXRlKAo+PiAgICAgICAgICAgICAgICAgc3RydWN0IGRjX3N0YXRlICpuZXdfY3R4LAo+PiAg
ICAgICAgICAgICAgICAgYm9vbCBmYXN0X3ZhbGlkYXRlKTsKPj4KPj4gLQo+PiAgdm9pZCBkY19y
ZXNvdXJjZV9zdGF0ZV9jb25zdHJ1Y3QoCj4+ICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3Qg
ZGMgKmRjLAo+PiAgICAgICAgICAgICAgICAgc3RydWN0IGRjX3N0YXRlICpkc3RfY3R4KTsKPj4g
QEAgLTExNjcsNyArMTE1OSw2IEBAIHN0cnVjdCBkY19jb250YWluZXJfaWQgewo+PiAgICAgICAg
IHVuc2lnbmVkIHNob3J0IHByb2R1Y3RDb2RlOwo+PiAgfTsKPj4KPj4gLQo+PiAgc3RydWN0IGRj
X3NpbmtfZHNjX2NhcHMgewo+PiAgICAgICAgIC8vICd0cnVlJyBpZiB0aGVzZSBhcmUgdmlydHVh
bCBEUENEJ3MgRFNDIGNhcHMgKGltbWVkaWF0ZWx5IHVwc3RyZWFtIG9mIHNpbmsgaW4gTVNUIHRv
cG9sb2d5KSwKPj4gICAgICAgICAvLyAnZmFsc2UnIGlmIHRoZXkgYXJlIHNpbmsncyBEU0MgY2Fw
cwo+PiBAQCAtMTIyOSw3ICsxMjIwLDYgQEAgc3RydWN0IGRjX2N1cnNvciB7Cj4+ICAgICAgICAg
c3RydWN0IGRjX2N1cnNvcl9hdHRyaWJ1dGVzIGF0dHJpYnV0ZXM7Cj4+ICB9Owo+Pgo+PiAtCj4+
ICAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKgo+PiAgICogSW50ZXJydXB0IGludGVyZmFjZXMKPj4g
ICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKiovCj4+IC0tCj4+IDIuMjUuMQo+Pgo+PiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0Cj4+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKDQoNCg==
