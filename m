Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81ED3CC393
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhGQNgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 09:36:17 -0400
Received: from mail-m17652.qiye.163.com ([59.111.176.52]:53472 "EHLO
        mail-m17652.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhGQNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 09:36:16 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Jul 2021 09:36:15 EDT
DKIM-Signature: a=rsa-sha256;
        b=AZBJtlrH+ns0Wmc11Ad0TcE6gQ+l2pyhsXrfKTZjuiOANzdCXmsTXWv/DnzLWJiWtA1bkgrrrhWGIch6pCBvP9CUBTERAczfMZ+bQTDBaiAn0uF0e+2taxeESKfBOE/tSvKXqEoAxzztMAHZgQGl33oa/O4a6ap9Ssjm8f+kliM=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=LtvisgyOL6o8S6prWoa7+r/wo7a6rAned5lX/FaCHH8=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m17652.qiye.163.com (Hmail) with ESMTP id 2A0653C014C;
        Sat, 17 Jul 2021 21:25:46 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AAoAygBXD7UuY6twAU03JKpm.3.1626528346162.Hmail.frank.li@vivo.com>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: =?UTF-8?B?UmU6UmU6IFtmMmZzLWRldl0gW1BBVENIXSBmMmZzOiBmaXggY3R4LT5wb3MgaW4gZjJmc19yZWFkX2lubGluZV9kaXIoKQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.231
In-Reply-To: <2d651236-40de-2e7b-d6c6-9a18ce9a25ff@kernel.org>
MIME-Version: 1.0
Received: from frank.li@vivo.com( [58.251.74.231) ] by ajax-webmail ( [127.0.0.1] ) ; Sat, 17 Jul 2021 21:25:46 +0800 (GMT+08:00)
From:   =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Date:   Sat, 17 Jul 2021 21:25:46 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpITE1WGR0ZTEMeQhpPQx
        0dVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1OSUtDTExNTkpPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6OhQ6Ahw5Iz9MLg4iTQ8MOi5LSDEwCxZVSFVKTUlNTklDSE9NT01DVTMWGhIXVR0JGhUQVRcS
        Ow0SDRRVGBQWRVlXWRILWUFZTkNVSU5KVUxPVUlISllXWQgBWUFOTUxMNwY+
X-HM-Tid: 0a7ab4a4f03dd9fckuws2a0653c014c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEkgQ2hhbywKCkZyb206IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KRGF0ZTogMjAyMS0wNy0x
NyAxNjo1NjowMQpUbzogIFlhbmd0YW8gTGkgPGZyYW5rLmxpQHZpdm8uY29tPixqYWVnZXVrQGtl
cm5lbC5vcmcKQ2M6ICBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLGxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0ClN1YmplY3Q6IFJlOiBbZjJmcy1kZXZdIFtQQVRDSF0g
ZjJmczogZml4IGN0eC0+cG9zIGluIGYyZnNfcmVhZF9pbmxpbmVfZGlyKCk+T24gMjAyMS83LzE3
IDExOjQ5LCBZYW5ndGFvIExpIHdyb3RlOgo+PiBJIHJlY2VudGx5IGZvdW5kIGEgY2FzZSB3aGVy
ZSBkZS0+bmFtZV9sZW4gaXMgMCBpbiBmMmZzX2ZpbGxfZGVudHJpZXMoKSBlYXNpbHkgcmVwcm9k
dWNlZCwKPj4gYW5kIGZpbmFsbHkgc2V0IHRoZSBmc2NrIGZsYWcuCj4+IAo+PiBUaHJlYWQgQQkJ
CQkJVGhyZWFkIEIKPj4gCj4+IGYyZnNfcmVhZGRpcgo+PiAJZjJmc19yZWFkX2lubGluZV9kaXIK
Pj4gCQljdHgtPnBvcyA9IGQubWF4Cj4+IAkJCQkJCWYyZnNfYWRkX2RlbnRyeQo+PiAJCQkJCQkJ
ZjJmc19hZGRfaW5saW5lX2VudHJ5Cj4+IAkJCQkJCQkJZG9fY29udmVydF9pbmxpbmVfZGlyCj4+
IAkJCQkJCQlmMmZzX2FkZF9yZWd1bGFyX2VudHJ5Cj4+IGYyZnNfcmVhZGRpcgo+PiAJZjJmc19m
aWxsX2RlbnRyaWVzCj4+IAkJc2V0X3NiaV9mbGFnKHNiaSwgU0JJX05FRURfRlNDSykKPj4gCj4+
IFByb2Nlc3MgQSBvcGVucyB0aGUgZm9sZGVyLCBhbmQgaGFzIGJlZW4gcmVhZGluZyB3aXRob3V0
IGNsb3NpbmcgaXQuIER1cmluZyB0aGlzIHBlcmlvZCwKPj4gUHJvY2VzcyBCIGNyZWF0ZWQgYSBm
aWxlIHVuZGVyIHRoZSBmb2xkZXIgKG9jY3VweWluZyBtdWx0aXBsZSBmMmZzX2Rpcl9lbnRyeSwg
ZXhjZWVkaW5nCj4+IHRoZSBkLm1heCBvZiB0aGUgaW5saW5lIGRpcikuIEFmdGVyIGNyZWF0aW9u
LCBwcm9jZXNzIEEgdXNlcyB0aGUgZC5tYXggb2YgaW5saW5lIGRpciB0bwo+PiByZWFkIGl0IGFn
YWluLCBhbmQgaXQgd2lsbCByZWFkIHRoYXQgZGUtPm5hbWVfbGVuIGlzIDAuCj4KPk5pY2UgY2F0
Y2ghCj4KPj4gCj4+IEFuZCByZXR1cm5pbmcgZWFybHkgaW4gZjJmc19yZWFkX2lubGluZV9kaXIg
d2lsbCBjYXVzZSB0aGUgcHJvY2VzcyB0byBiZSB1bmFibGUgdG8gc2VlCj4+IHRoZSBjaGFuZ2Vz
IGJlZm9yZSByZW9wZW5pbmcgdGhlIGZpbGUuCj4+IAo+PiBTbyBkb24ndCByZXR1cm4gZWFybHkg
YW5kIHJlbW92ZSB0aGUgbW9kaWZpY2F0aW9uIG9mIGN0eC0+cG9zIGluIGYyZnNfcmVhZF9pbmxp
bmVfZGlyKCkuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5ndGFvIExpIDxmcmFuay5saUB2aXZv
LmNvbT4KPj4gLS0tCj4+ICAgZnMvZjJmcy9pbmxpbmUuYyB8IDUgLS0tLS0KPj4gICAxIGZpbGUg
Y2hhbmdlZCwgNSBkZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2lubGlu
ZS5jIGIvZnMvZjJmcy9pbmxpbmUuYwo+PiBpbmRleCA1NmEyMGQ1YzE1ZGEuLmZjNjU1MTEzOWEz
ZCAxMDA2NDQKPj4gLS0tIGEvZnMvZjJmcy9pbmxpbmUuYwo+PiArKysgYi9mcy9mMmZzL2lubGlu
ZS5jCj4+IEBAIC03MjksOSArNzI5LDYgQEAgaW50IGYyZnNfcmVhZF9pbmxpbmVfZGlyKHN0cnVj
dCBmaWxlICpmaWxlLCBzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCwKPj4gICAKPj4gICAJbWFrZV9k
ZW50cnlfcHRyX2lubGluZShpbm9kZSwgJmQsIGlubGluZV9kZW50cnkpOwo+PiAgIAo+PiAtCWlm
IChjdHgtPnBvcyA9PSBkLm1heCkKPj4gLQkJcmV0dXJuIDA7Cj4+IC0KPj4gICAJaXBhZ2UgPSBm
MmZzX2dldF9ub2RlX3BhZ2UoRjJGU19JX1NCKGlub2RlKSwgaW5vZGUtPmlfaW5vKTsKPj4gICAJ
aWYgKElTX0VSUihpcGFnZSkpCj4+ICAgCQlyZXR1cm4gUFRSX0VSUihpcGFnZSk7Cj4+IEBAIC03
NDcsOCArNzQ0LDYgQEAgaW50IGYyZnNfcmVhZF9pbmxpbmVfZGlyKHN0cnVjdCBmaWxlICpmaWxl
LCBzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCwKPj4gICAJbWFrZV9kZW50cnlfcHRyX2lubGluZShp
bm9kZSwgJmQsIGlubGluZV9kZW50cnkpOwo+PiAgIAo+PiAgIAllcnIgPSBmMmZzX2ZpbGxfZGVu
dHJpZXMoY3R4LCAmZCwgMCwgZnN0cik7Cj4KPkFmdGVyIHRoaXMgZnVuY3Rpb24sIGN0eC0+cG9z
IHdpbGwgcG9pbnQgdG8gc3RhcnQgcG9zaXRpb24gb2YgZmlyc3QgZnJlZSBzbG90IGFmdGVyCj5s
YXN0IGRpcl9lbnRyeSwgd2UgY2FuJ3QgZ3VhcmFudGVlIHRoYXQgdGhlIGZyZWUgc2xvdCB3b24n
dCBiZSB1c2VkIGluIGFib3ZlIHJhY2UKPmNvbmRpdGlvbiwgcmlnaHQ/Cj4KPk1vcmVvdmVyLCB3
L28gaW5saW5lIGNvbnZlcnNpb24sIHRoZSByYWNlIGNvbmRpdGlvbiBzdGlsbCBjYW4gaGFwcGVu
IGFzIGJlbG93LCByaWdodD8KPgo+ZGlyX2VudHJ5MTogQQo+ZGlyX2VudHJ5MjogQgo+ZGlyX2Vu
dHJ5MzogQwo+ZnJlZSBzbG90OiBfCj4KPkJlZm9yZToKPkFBQUFCQkJCX19fCj4gICAgICAgICBe
Cj5UaHJlYWQgQiBkZWxldGUgZGlyX2VudHJ5MiwgYW5kIGNyZWF0ZSBkaXJfZW50cnkzLgo+Cj5B
ZnRlcjoKPkFBQUFDQ0NDQ19fCj4gICAgICAgICBeCgpUYWtpbmcgaW50byBhY2NvdW50IHRoZSBh
Ym92ZSBzaXR1YXRpb25zLCBJIHRoaW5rIHRoaXMgY2FzZSB3aGVyZSBkZS0+bmFtZV9sZW4gaXMg
MCBpbiBmMmZzX2ZpbGxfZGVudHJpZXMoKQpzaG91bGQgYmUgbm9ybWFsIGFuZCB0aGVyZSBpcyBu
byB3YXkgdG8gYXZvaWQgaXQuIE1heWJlIHdlIHNob3VsZG4ndCBzZXQgZnNjayBmbGFnIGF0IHRo
aXMgdGltZT8KQmVjYXVzZSB0aGUgZmlsZSBzeXN0ZW0gaXMgbm90IGRhbWFnZWQuCgpNQlIgLyBZ
YW5ndGFvCg0KDQo=
