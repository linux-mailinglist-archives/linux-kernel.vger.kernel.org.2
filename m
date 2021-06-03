Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C907E399957
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 06:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFCEwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 00:52:02 -0400
Received: from mail-m17641.qiye.163.com ([59.111.176.41]:43220 "EHLO
        mail-m17641.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFCEwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 00:52:00 -0400
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m17641.qiye.163.com (Hmail) with ESMTP id C5B696012C;
        Thu,  3 Jun 2021 12:50:12 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ACYAbADLDo5nvv4af7zOLqqA.3.1622695812793.Hmail.wanjiabing@vivo.com>
To:     Alex Shi <seakeel@gmail.com>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Fangrui Song <maskray@google.com>,
        Bernard Zhao <bernard@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gW3YyXSBkb2NzL3poX0NOOiBhZGQgdHJhbnNsYXRpb25zIGluIHpoX0NOL2Rldi10b29scy9rYXNhbg==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.158
In-Reply-To: <69008e54-003a-eeb5-75f8-96e03f37d2df@gmail.com>
MIME-Version: 1.0
Received: from wanjiabing@vivo.com( [58.213.83.158) ] by ajax-webmail ( [127.0.0.1] ) ; Thu, 3 Jun 2021 12:50:12 +0800 (GMT+08:00)
From:   Jiabing Wan <wanjiabing@vivo.com>
Date:   Thu, 3 Jun 2021 12:50:12 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQh1IHlYYSE9PHRlKTRlPTRhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1PS0lLTkJJT01MN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6OCI6GTo*Nz8UThUNDU8aHUwBNDcKCjpVSFVKTUlJTUJOQ0pISUlDVTMWGhIXVQwaFRESGhkS
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJSkhVQ0hVSk5DWVdZCAFZQU9DTkw3Bg++
X-HM-Tid: 0a79d0351ed6d997kuwsc5b696012c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IAo+IFJlOiBbUEFUQ0hdIFt2Ml0gZG9jcy96aF9DTjogYWRkIHRyYW5zbGF0aW9ucyBpbiB6aF9D
Ti9kZXYtdG9vbHMva2FzYW4+PkhpIEppYWJpbmcsCj4KPlRoYW5rcyBmb3IgdHJhbnNsYXRpb24h
IFRoZSBjb250ZW50cyBhcmUgZ2VuZXJhbGx5IGZpbmUuIAo+SSB0cmllZCB0aGUgcGF0Y2ggd2l0
aCBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgZm91bmQgdGhlcmUgYXJlIGxvdHMgZXJyb3JzCgpIaSxB
bGV4LAoKT2gsIHRoYXQgaXMgc3RyYW5nZS4KCkluIG15IHVidW50dSBzZXJ2ZXIsIEkgcmFuIHNj
cmlwdHMvY2hlY2twYXRjaC5wbCBhbmQgZ290OgoKV2hlbiBEb2N1bWVudGF0aW9uL3RyYW5zbGF0
aW9ucy96aF9DTi9kZXYtdG9vbHMva2FzYW4ucnN0CiJ0b3RhbDogMCBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDQzMSBsaW5lcyBjaGVja2VkIgoKV2hlbiAwMDAxLXYyLWRvY3MtemhfQ04tYWRkLXRyYW5z
bGF0aW9ucy1pbi16aF9DTi1kZXYtdG9vbHMta2EucGF0Y2guCiJXQVJOSU5HOiBhZGRlZCwgbW92
ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM0
MTogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNDQ1
IGxpbmVzIGNoZWNrZWQiCgpObyBlcnJvcnMgYW5kIGp1c3Qgb25lIHdhcm5pbmcuClNvIEkgdGhp
bmsgdGhlcmUgd2FzIGEgcHJvYmxlbSB3aXRoIHlvdXIgcGxhdGZvcm0gb3IgZG93bmxvYWRpbmc/
CgpJZiB0aGVyZSB3ZXJlIG5vIHByb2JsZW0sIEkgd291bGQgY2hlY2sgbXkgZW1haWwgY2xpZW50
IGFnYWluIDspCgo+LS0tCj4uLi4KPkVSUk9SOiBET1MgbGluZSBlbmRpbmdzCj4jNTUyOiBGSUxF
OiBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9kZXYtdG9vbHMva2FzYW4ucnN0OjQz
MDoKPiteTSQKPgo+RVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKPiM1NTM6IEZJTEU6IERvY3Vt
ZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2Rldi10b29scy9rYXNhbi5yc3Q6NDMxOgo+Ky4u
IF9LVW5pdDogaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvZGV2LXRvb2xz
L2t1bml0L2luZGV4Lmh0bWxeTSQKPgo+dG90YWw6IDQzMiBlcnJvcnMsIDEgd2FybmluZ3MsIDQ0
NSBsaW5lcyBjaGVja2VkCj4tLS0KPgo+YW5kIHRoZSBsaW5lcyBpbiB0aGUgcGF0Y2ggYXJlIG5v
dCBhbGlnbmVkIG9uIDgwIGNoYXJzLCAoNDAgY2hhcnMgZm9yIENoaW5lc2UsCj5zaW5jZSBvbmUg
Q2hpbmVzZSBjaGFyIGNvdWxkIHRha2UgMiBwb3NpdGlvbnMuICkKPlRoYW5rcwo+QWxleAoKT0ss
IGdyZWF0IHRpcHMgZm9yIG1lLgpJJ2xsIGZpeCB0aGVtIGluIHYzLgoKVGhhbmtzLApKaWFiaW5n
Cgo+Cj5PbiAyMDIxLzYvMiDkuIvljYg4OjU2LCBXYW4gSmlhYmluZyB3cm90ZToKPj4gQWRkIG5l
dyB6aCB0cmFuc2xhdGlvbnMKPj4gKiB6aF9DTi9kZXYtdG9vbHMva2FzYW4ucnN0Cj4+IGFuZCBs
aW5rIGl0IHRvIHpoX0NOL2Rldi10b29scy9pbmRleC5yc3QKPj4gCj4+IFNpZ25lZC1vZmYtYnk6
IFdhbiBKaWFiaW5nIDx3YW5qaWFiaW5nQHZpdm8uY29tPgo+PiAtLS0KPj4gQ2hhbmdlbG9nOgo+
PiB2MjoKPj4gLSBEZWxldGUgc3BhY2VzIHN1cnJvdW5kIHdpdGggRW5nbGlzaCB3b3Jkcy4KPj4g
LS0tDQoNCg==
