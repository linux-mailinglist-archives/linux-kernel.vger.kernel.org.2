Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A6836EA85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhD2McA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:32:00 -0400
Received: from mail-m17642.qiye.163.com ([59.111.176.42]:44732 "EHLO
        mail-m17642.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2Mb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:31:59 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Apr 2021 08:31:59 EDT
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m17642.qiye.163.com (Hmail) with ESMTP id AD4B3220082;
        Thu, 29 Apr 2021 20:31:09 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AL*ACQCtDqK3Fh4IaI0da4om.3.1619699469579.Hmail.wanjiabing@vivo.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Aric Cyr <aric.cyr@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Jacky Liao <ziyu.liao@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBSZW1vdmUgZHVwbGljYXRlIGRlY2xhcmF0aW9uIG9mIGRjX3N0YXRl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <20210429120841.egvj3m23kehofsfc@outlook.office365.com>
MIME-Version: 1.0
Received: from wanjiabing@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Thu, 29 Apr 2021 20:31:09 +0800 (GMT+08:00)
From:   Jiabing Wan <wanjiabing@vivo.com>
Date:   Thu, 29 Apr 2021 20:31:09 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkIYSlZPTB9CTU0eSEhNSE9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1ISUhNSk5CSEJMN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6N1E6OCo4Dz8KMEg9E08yGjJLHxpPFBZVSFVKTUpCTUJCT0xLS0xLVTMWGhIXVQwaFRESGhkS
        FRw7DRINFFUYFBZFWVdZEgtZQVlITVVKTklVSk9OVUpDSVlXWQgBWUFPTE9MNwY+
X-HM-Tid: 0a791d9c8d96d998kuwsad4b3220082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IAo+SGkgV2FuLAo+Cj5JbnN0ZWFkIG9mIHJlbW92ZSB0aGUgZmlyc3QgZGNfc3RhdGUsIHJlbW92
ZSB0aGUgc2Vjb25kIG9uZS4KPgo+VGhhbmtzCgpIaSBSb2RyaWdvLAoKVGhhbmtzIGZvciB5b3Vy
IHJlcGx5LgoKT0ssIGluIGZhY3QsIHRoZXJlIGFyZSBubyBmdW5jdGlvbnMgdXNpbmcgc3RydWN0
IGRjX3N0YXRlIGJldHdlZW4gdHdvCnN0cnVjdCBkZWNsYXJhdGlvbnMuIFNvIEkgdGhpbmsgcmVt
b3ZpbmcgYW55b25lIGlzIE9LLgpSZW1vdmUgdGhlIGZpcnN0IG9uZSB0byBtYWtlIGl0IG1vcmUg
Y2xvc2VyIHRvIHVzZXIuClJlbW92ZSB0aGUgc2Vjb25kIG9uZSBtb3JlIHNlY3VyZS4KSSB3aWxs
IHNlbmQgdjIuIFlvdSBjYW4gY2hvb3NlIG9uZSBvZiB0aGUgdHdvLgoKPk9uIDA0LzI5LCBXYW4g
SmlhYmluZyB3cm90ZToKPj4gVGhlcmUgYXJlIHR3byBkZWNsYXJhdGlvbnMgb2Ygc3RydWN0IGRj
X3N0YXRlIGhlcmUuCj4+IFRoZSBsYXRlciBvbmUgaXMgY2xvc2VyIHRvIGl0cyB1c2VyLiBSZW1v
dmUgdGhlIGZvcm1lciBkdXBsaWNhdGUuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBXYW4gSmlhYmlu
ZyA8d2FuamlhYmluZ0B2aXZvLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGMuaCB8IDIgLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQo+
PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKPj4gaW5kZXggODEwOGI4MmJhYzYw
Li5jYWQwNDVkYjZlYTIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kYy5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCj4+
IEBAIC0yNzYsOCArMjc2LDYgQEAgZW51bSBzdXJmYWNlX3VwZGF0ZV90eXBlIHsKPj4gIC8qIEZv
cndhcmQgZGVjbGFyYXRpb24qLwo+PiAgc3RydWN0IGRjOwo+PiAgc3RydWN0IGRjX3BsYW5lX3N0
YXRlOwo+PiAtc3RydWN0IGRjX3N0YXRlOwo+PiAtCj4+ICAKPj4gIHN0cnVjdCBkY19jYXBfZnVu
Y3Mgewo+PiAgCWJvb2wgKCpnZXRfZGNjX2NvbXByZXNzaW9uX2NhcCkoY29uc3Qgc3RydWN0IGRj
ICpkYywKPj4gLS0gCj4+IDIuMjUuMQo+PiAKPgo+LS0gCj5Sb2RyaWdvIFNpcXVlaXJhCj5odHRw
czovL3NpcXVlaXJhLnRlY2gKCllvdXJzLApXYW4gSmlhYmluZwoNCg0K
