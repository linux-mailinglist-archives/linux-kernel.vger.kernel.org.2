Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E8D38272B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhEQIik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:38:40 -0400
Received: from mail-m176231.qiye.163.com ([59.111.176.231]:45476 "EHLO
        mail-m176231.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbhEQIii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:38:38 -0400
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m176231.qiye.163.com (Hmail) with ESMTP id 0DE9D6C0101;
        Mon, 17 May 2021 16:37:21 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AGAAqwBWDoTN1eybqS54h4qu.3.1621240641040.Hmail.wangqing@vivo.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCBWOSAxLzJdIHdhdGNoZG9nOiBtdGs6IHN1cHBvcnQgcHJlLXRpbWVvdXQgd2hlbiB0aGUgYmFyayBpcnEgaXMgYXZhaWxhYmxl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <ac2a3762-0b5d-a406-33e0-fca3073cd5ac@roeck-us.net>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 17 May 2021 16:37:21 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Mon, 17 May 2021 16:37:21 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUhNT1ZMGh4YHksZS0saGkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1ISElPTU5OTkpPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6PDo6Cgw5LD8ULzVKHgIZCihOTxNPCg5VSFVKTUlKSU9LTU9KT0tKVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZSE1VSk5JVUpPTlVKQ0lZV1kIAVlBSExDTDcG
X-HM-Tid: 0a797978f624d9a9kuws0de9d6c0101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiA1LzUvMjEgNjo1MSBQTSwg546L5pOOIHdyb3RlOgo+PiAKPj4+IE9uIDQvMjQvMjEgNjo1
MiBQTSwgV2FuZyBRaW5nIHdyb3RlOgo+Pj4+IFVzZSB0aGUgYmFyayBpbnRlcnJ1cHQgYXMgdGhl
IHByZXRpbWVvdXQgbm90aWZpZXIgaWYgYXZhaWxhYmxlLgo+Pj4+Cj4+Pj4gV2hlbiB0aGUgd2F0
Y2hkb2cgdGltZXIgZXhwaXJlcyBpbiBkdWFsIG1vZGUsIGFuIGludGVycnVwdCB3aWxsIGJlCj4+
Pj4gdHJpZ2dlcmVkIGZpcnN0LCB0aGVuIHRoZSB0aW1pbmcgcmVzdGFydHMuIFRoZSByZXNldCBz
aWduYWwgd2lsbCBiZQo+Pj4+IGluaXRpYXRlZCB3aGVuIHRoZSB0aW1lciBleHBpcmVzIGFnYWlu
Lgo+Pj4+Cj4+Pj4gVGhlIHByZXRpbWVvdXQgbm90aWZpY2F0aW9uIHNoYWxsIG9jY3VyIGF0IHRp
bWVvdXQtc2VjLzIuCj4+Pj4KPj4+PiBWMjoKPj4+PiAtIHBhbmljKCkgYnkgZGVmYXVsdCBpZiBX
QVRDSERPR19QUkVUSU1FT1VUX0dPViBpcyBub3QgZW5hYmxlZC4KPj4+Pgo+Pj4+IFYzOgo+Pj4+
IC0gTW9kaWZ5IHRoZSBwcmV0aW1lb3V0IGJlaGF2aW9yLCBtYW51YWxseSByZXNldCBhZnRlciB0
aGUgcHJldGltZW91dAo+Pj4+IC0gaXMgcHJvY2Vzc2VkIGFuZCB3YWl0IHVudGlsIHRpbWVvdXQu
Cj4+Pj4KPj4+PiBWNDoKPj4+PiAtIFJlbW92ZSBwcmV0aW1lb3V0IHJlbGF0ZWQgcHJvY2Vzc2lu
Zy4gCj4+Pj4gLSBBZGQgZHVhbCBtb2RlIGNvbnRyb2wgc2VwYXJhdGVseS4KPj4+Pgo+Pj4+IFY1
Ogo+Pj4+IC0gRml4IHNvbWUgZm9ybWF0dGluZyBhbmQgcHJpbnRpbmcgcHJvYmxlbXMuCj4+Pj4K
Pj4+PiBWNjoKPj4+PiAtIFJlYWxpemUgcHJldGltZW91dCBwcm9jZXNzaW5nIHRocm91Z2ggZHVh
bG1vZGUuCj4+Pj4KPj4+PiBWNzoKPj4+PiAtIEFkZCBzZXRfcHJldGltZW91dCgpLgo+Pj4+Cj4+
Pj4gVjgvVjk6Cj4+Pj4gLSBGaXggc29tZSBmb3JtYXR0aW5nIHByb2JsZW1zLgo+Pj4+Cj4+Pj4g
U2lnbmVkLW9mZi1ieTogV2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNvbT4KPj4+Cj4+PiBSZXZp
ZXdlZC1ieTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pgo+Pj4KPj4+IE5vdGUg
dGhhdCB0aGUgdmVyc2lvbiBoaXN0b3J5IHNob3VsZCBiZSBhZnRlciAiLS0tIi4KPj4+Cj4+PiBH
dWVudGVyCj4+Pgo+PiAKPj4gVGhhbmtzLCBHdWVudGVyLgo+PiBBbmQgd2hhdCBkbyBJIG5lZWQg
dG8gZG8gaWYgSSB3YW50IG1lcmdlIGludG8gdGhlIG5leHQtdHJlZT8KPj4gCj5XaW0gc2hvdWxk
IHRha2UgY2FyZSBvZiB0aGF0Lgo+Cj5HdWVudGVyCj4KV2ltLCBjYW4geW91IGhlbHAgdG8gcGlj
ayBpdCB1cCB0byB0aGUgbmV4dC10cmVlPwoKVGhhbmtzLApRaW5nCg0KDQo=
