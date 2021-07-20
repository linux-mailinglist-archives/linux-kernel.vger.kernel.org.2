Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672743CF99E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhGTLvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 07:51:24 -0400
Received: from mail-m17652.qiye.163.com ([59.111.176.52]:28934 "EHLO
        mail-m17652.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbhGTLvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:51:18 -0400
DKIM-Signature: a=rsa-sha256;
        b=fYXXoAplvpuwubi+JVYieORa2vHlU3KQKPKtIdrHxZj76ootDvb8xC29OkoZBC0+GeJGUvkW+UJClW5Wwjjm5LeGhTxPSBsfJ4XrHCYNk9OVYl0+Kp9a1eA3p4bKHGrJbnknUbJgEqMfscOcq8Yzn26c9D4LboleZn0q2C4RmPI=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=3aSGc8E9xaopmoIEkqKrpHEuNNn6z/u06t690RBGZ5k=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m17652.qiye.163.com (Hmail) with ESMTP id 4EF533C01E5;
        Tue, 20 Jul 2021 20:31:55 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJcAmwDXD1QzgUCoyu2cQKql.3.1626784315314.Hmail.frank.li@vivo.com>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCB2M10gZjJmczogUmVkdWNlIHRoZSBzY29wZSBvZiBzZXR0aW5nIGZzY2sgdGFnIHdoZW4gZGUtPm5hbWVfbGVuIGlzIHplcm8=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 59.36.4.5
In-Reply-To: <9f221a92-6c95-8f2f-a3d9-1d7abf5a6a6e@kernel.org>
MIME-Version: 1.0
Received: from frank.li@vivo.com( [59.36.4.5) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 20 Jul 2021 20:31:55 +0800 (GMT+08:00)
From:   =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Date:   Tue, 20 Jul 2021 20:31:55 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlNT0tWGBpOTx4ZSR9CGk
        sYVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1OSUNIT0JJSExMN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MRg6Fgw*Iz9KKgEcLjgUAg5JGCowChdVSFVKTUlNTENPSEpOTkxLVTMWGhIXVR0JGhUQVRcS
        Ow0SDRRVGBQWRVlXWRILWUFZTkJVSE1VT1VOWVdZCAFZQU5KSEg3Bg++
X-HM-Tid: 0a7ac3e6b7bdd9fckuws4ef533c01e5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEkgQ2hhb++8jAoKRnJvbTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPgpEYXRlOiAyMDIxLTA3
LTIwIDE4OjIzOjE1ClRvOiAgWWFuZ3RhbyBMaSA8ZnJhbmsubGlAdml2by5jb20+LGphZWdldWtA
a2VybmVsLm9yZwpDYzogIGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0LGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKU3ViamVjdDogUmU6IFtQQVRDSCB2M10gZjJmczog
UmVkdWNlIHRoZSBzY29wZSBvZiBzZXR0aW5nIGZzY2sgdGFnIHdoZW4gZGUtPm5hbWVfbGVuIGlz
IHplcm8+T24gMjAyMS83LzIwIDE1OjA2LCBZYW5ndGFvIExpIHdyb3RlOgo+PiBJIHJlY2VudGx5
IGZvdW5kIGEgY2FzZSB3aGVyZSBkZS0+bmFtZV9sZW4gaXMgMCBpbiBmMmZzX2ZpbGxfZGVudHJp
ZXMoKSBlYXNpbHkgcmVwcm9kdWNlZCwKPj4gYW5kIGZpbmFsbHkgc2V0IHRoZSBmc2NrIGZsYWcu
Cj4+IAo+PiBUaHJlYWQgQQkJCQkJVGhyZWFkIEIKPj4gCj4+IGYyZnNfcmVhZGRpcgo+PiAJZjJm
c19yZWFkX2lubGluZV9kaXIKPj4gCQljdHgtPnBvcyA9IGQubWF4Cj4+IAkJCQkJCWYyZnNfYWRk
X2RlbnRyeQo+PiAJCQkJCQkJZjJmc19hZGRfaW5saW5lX2VudHJ5Cj4+IAkJCQkJCQkJZG9fY29u
dmVydF9pbmxpbmVfZGlyCj4+IAkJCQkJCQlmMmZzX2FkZF9yZWd1bGFyX2VudHJ5Cj4+IGYyZnNf
cmVhZGRpcgo+PiAJZjJmc19maWxsX2RlbnRyaWVzCj4+IAkJc2V0X3NiaV9mbGFnKHNiaSwgU0JJ
X05FRURfRlNDSykKPj4gCj4+IFByb2Nlc3MgQSBvcGVucyB0aGUgZm9sZGVyLCBhbmQgaGFzIGJl
ZW4gcmVhZGluZyB3aXRob3V0IGNsb3NpbmcgaXQuIER1cmluZyB0aGlzIHBlcmlvZCwKPj4gUHJv
Y2VzcyBCIGNyZWF0ZWQgYSBmaWxlIHVuZGVyIHRoZSBmb2xkZXIgKG9jY3VweWluZyBtdWx0aXBs
ZSBmMmZzX2Rpcl9lbnRyeSwgZXhjZWVkaW5nCj4+IHRoZSBkLm1heCBvZiB0aGUgaW5saW5lIGRp
cikuIEFmdGVyIGNyZWF0aW9uLCBwcm9jZXNzIEEgdXNlcyB0aGUgZC5tYXggb2YgaW5saW5lIGRp
ciB0bwo+PiByZWFkIGl0IGFnYWluLCBhbmQgaXQgd2lsbCByZWFkIHRoYXQgZGUtPm5hbWVfbGVu
IGlzIDAuCj4+IAo+PiBBbmQgQ2hhbyBwb2ludGVkIG91dCB0aGF0IHcvbyBpbmxpbmUgY29udmVy
c2lvbiwgdGhlIHJhY2UgY29uZGl0aW9uIHN0aWxsIGNhbiBoYXBwZW4gYXMgYmVsb3cKPj4gCj4+
IGRpcl9lbnRyeTE6IEEKPj4gZGlyX2VudHJ5MjogQgo+PiBkaXJfZW50cnkzOiBDCj4+IGZyZWUg
c2xvdDogXwo+PiBjdHgtPnBvczogXgo+PiAKPj4gQmVmb3JlOgo+PiBBQUFBQkJCQl9fXwo+PiAJ
IF4KPgo+cGxlYXNlIHVzZSBibGFuayBpbnN0ZWFkIG9mIHRhYiBiZWZvcmUgJ14nCgpJIGRvbid0
IGtub3cgZXhhY3RseSB3aGF0IGhhcHBlbmVkLiBJbiBmYWN0LCBpbiB2Miwgc3BhY2VzIHdlcmUg
dXNlZC4gVGhlbiBpdCB3YXMgY2hhbmdlZCB0byB0YWIgaW4gdjMuCgo+Cj4+IFRocmVhZCBCIGRl
bGV0ZSBkaXJfZW50cnkyLCBhbmQgY3JlYXRlIGRpcl9lbnRyeTMuCj4+IAo+PiBBZnRlcjoKPj4g
QUFBQUNDQ0NDX18KPj4gCSBeCj4KPkRpdHRvCj4KPj4gCj4+IEluIHRoZXNlIHNjZW5hcmlvcywg
dGhlIGZpbGUgc3lzdGVtIGlzIG5vdCBkYW1hZ2VkLCBhbmQgaXQncyBoYXJkIHRvIGF2b2lkIGl0
LiBCdXQgd2UgY2FuIGJ5cGFzcwo+PiB0YWdnaW5nIEZTQ0sgZmxhZyBpZjoKPj4gYSkgYml0X3Bv
cyAoOj0gY3R4LT5wb3MgJSBkLT5tYXgpIGlzIG5vbi16ZXJvICYgYikgYmVmb3JlIGJpdF9wb3Mg
bW92ZXMgdG8gZmlyc3QKPj4gdmFsaWQgZGlyX2VudHJ5Lgo+PiAKPj4gU2lnbmVkLW9mZi1ieTog
WWFuZ3RhbyBMaSA8ZnJhbmsubGlAdml2by5jb20+Cj4+IC0tLQo+PiAgIGZzL2YyZnMvZGlyLmMg
fCAxNCArKysrKysrKystLS0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9kaXIuYyBiL2ZzL2Yy
ZnMvZGlyLmMKPj4gaW5kZXggNDU2NjUxNjgyZGFmLi5iZmU5NDI3MzNiNWUgMTAwNjQ0Cj4+IC0t
LSBhL2ZzL2YyZnMvZGlyLmMKPj4gKysrIGIvZnMvZjJmcy9kaXIuYwo+PiBAQCAtMTAwMCw2ICsx
MDAwLDcgQEAgaW50IGYyZnNfZmlsbF9kZW50cmllcyhzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCwg
c3RydWN0IGYyZnNfZGVudHJ5X3B0ciAqZCwKPj4gICAJc3RydWN0IGYyZnNfc2JfaW5mbyAqc2Jp
ID0gRjJGU19JX1NCKGQtPmlub2RlKTsKPj4gICAJc3RydWN0IGJsa19wbHVnIHBsdWc7Cj4+ICAg
CWJvb2wgcmVhZGRpcl9yYSA9IHNiaS0+cmVhZGRpcl9yYSA9PSAxOwo+PiArCWJvb2wgZm91bmRf
dmFsaWRfZGlyZW50ICA9IGZhbHNlOwo+Cj5PbmUgbW9yZSBibGFuayBiZWZvcmUgJz0nLgo+Cj5i
b29sIGZvdW5kX3ZhbGlkX2RpcmVudCA9IGZhbHNlOwo+CgpPSy4KClRoeO+8jAoKDQoNCg==
