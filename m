Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A563FA31A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 04:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhH1CTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 22:19:10 -0400
Received: from mail-m176231.qiye.163.com ([59.111.176.231]:61504 "EHLO
        mail-m176231.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhH1CTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 22:19:09 -0400
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m176231.qiye.163.com (Hmail) with ESMTP id AB1256C00F3;
        Sat, 28 Aug 2021 10:18:17 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJ*AdQAQD9tzCOr4iYm-E4pL.3.1630117097688.Hmail.wangqing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCxSRVNFTkRdIHNvZnRpcnE6IEludHJvZHVjZSBTT0ZUSVJRX0ZPUkNFRF9USFJFQURJTkc=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.158
In-Reply-To: <87k0k61q21.ffs@tglx>
MIME-Version: 1.0
Received: from wangqing@vivo.com( [58.213.83.158) ] by ajax-webmail ( [127.0.0.1] ) ; Sat, 28 Aug 2021 10:18:17 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Date:   Sat, 28 Aug 2021 10:18:17 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRoYTxpWGR0YGkxDSRgfTh
        5MVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1NSE1MS0pKQ0pJN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MVE6Hyo6Kj9CDwE4NAlPEiIWVj5PCzdVSFVKTUhLSkpMS0JDS0lIVTMWGhIXVQwaFRwKEhUc
        Ow0SDRRVGBQWRVlXWRILWUFZTkNVSUpIVUNIVUpOQ1lXWQgBWUFOQ0lCNwY+
X-HM-Tid: 0a7b8a8cf0ecd9a9kuwsab1256c00f3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5XYW5nLAo+Cj5PbiBNb24sIEF1ZyAyMyAyMDIxIGF0IDExOjMzLCBXYW5nIFFpbmcgd3JvdGU6
Cj4KPj4gQXQgcHJlc2VudCwgd2hldGhlciB0aGUgc29mdGlycSBpcyBleGVjdXRlZCB3aGVuIHRo
ZSBpbnRlcnJ1cHQgZXhpdHMgCj4+IGlzIGNvbnRyb2xsZWQgYnkgSVJRX0ZPUkNFRF9USFJFQURJ
TkcuIFRoaXMgaXMgdW5yZWFzb25hYmxlLiBJdCBzaG91bGQgCj4+IGJlIHNwbGl0IGFuZCBhbGxv
d2VkIHRvIHRha2UgZWZmZWN0IHNlcGFyYXRlbHkuCj4KPlRoZXJlIGlzIG5vdGhpbmcgdW5yZWFz
b25hYmxlIGFib3V0IGl0LiBXaGVuIGludGVycnVwdCBmb3JjZSB0aHJlYWRpbmcKPmlzIGluIGVm
ZmVjdCB0aGVuIGl0IG9idmlvdXNseSByZXF1aXJlcyB0aGF0IHNvZnQgaW50ZXJydXB0IHByb2Nl
c3NpbmcKPmdvZXMgaW50byB0aHJlYWRlZCBtb2RlIGFzIHdlbGwuIEJ1dCB0aGUgdGhyZWFkZWQg
ZXhlY3V0aW9uIHN0aWxsIHRha2VzCj5wbGFjZSB3aGVuIHRoZSBmb3JjZSB0aHJlYWRlZCBpbnRl
cnJ1cHQgaGFuZGxlciBjb21wbGV0ZXMuIE9ubHkgc29mdGlycXMKPndoaWNoIGFyZSByYWlzZWQg
ZnJvbSBoYXJkIGludGVycnVwdCBjb250ZXh0IChlLmcuIHRpbWVyIGludGVycnVwdCkgYXJlCj5m
b3JjZWQgb2ZmIHRvIGtzb2Z0aXJxZC4KPgo+V2hhdCB5b3UgYXJlIHByb3Bvc2luZyBoZXJlIGlz
IGNvbXBsZXRseSBkaWZmZXJlbnQgYXMgeW91IGVuZm9yY2UKPnNvZnRpcnEgZXhlY3V0aW9uIGlu
IGNvbnRleHQgb2Yga3NvZnRpcnFkIG9ubHkuCgpUaGFuayB5b3UgZm9yIHJlcGx5IGFuZCBleHBs
YW5hdGlvbiwgSSBqdXN0IHByb3ZpZGUgYSBjaG9pY2UgdG8gYmFsYW5jZQp0aGUgZXhlY3V0aW9u
IG9mIHNvZnRpcnEgYWNjb3JkaW5nIHRvIHRoZWlyIG93biBidXNpbmVzcyBzY2VuYXJpb3MuCgo+
Cj4+IEF0IHRoZSBzYW1lIHRpbWUsIHdlIHNob3VsZCBpbmNyZWFzZSB0aGUgcHJpb3JpdHkgb2Yg
a3NvZnRpcnFkIHdoZW4KPj4gZm9yYmlkZGVuIHRvIGV4ZWN1dGUgaW4gaW50ZXJydXB0IGV4aXRz
LiBJIHJlZmVyIHRvIHRoZSBpbXBsZW1lbnRhdGlvbiAKPj4gb2YgUFJFRU1QVF9SVCBhbmQgdGhp
bmsgaXQgaXMgcmVhc29uYWJsZS4KPgo+V2hhdCBhcmUgeW91IHJlZmVycmluZyB0bz8gUFJFRU1Q
VF9SVCBkb2VzIG5vdCBtb2RpZnkgdGhlIHByaW9yaXR5IG9mCj5rc29mdGlycWQuIElmIHN5c3Rl
bSBkZXNpZ25lcnMgd2FudCB0byBkbyB0aGF0LCB0aGVuIHRoZXkgY2FuIGRvIHNvIGZyb20KPnVz
ZXIgc3BhY2UuIAoKSSByZWZlciB0byB0aGUga2VybmVsLTMuMTQgUlQgUGF0Y2hlcy4gSSB1c2Vk
IGl0IGF0IHRoYXQgdGltZSBhbmQgYWNoaWV2ZWQgCnZlcnkgZ29vZCByZXN1bHRzLgpJIHJlbWVt
YmVyIHdoZXJlIEkgc2F3IHRoYXQgc29mdGlycWQgd2FzIHNwbGl0IGludG8gdGhlIG9yaWdpbmFs
IHByb2Nlc3MgCmFuZCB0aGUgUlQgcHJvY2Vzcy4gVGhpcyBjYW4gcGFydGlhbGx5IHNvbHZlIG15
IHByb2JsZW0uCgo+Cj5BbmQgZG9pbmcgc28gY2FuIGJlIHByb2JsZW1hdGljIGRlcGVuZGluZyBv
biB0aGUgd29ya2xvYWQgYXMgdGhpcwo+ZWZmZWN0aXZlbHkgYnJlYWtzIHRoZSBzb2Z0aXJxIG92
ZXJsb2FkIG1pdGlnYXRpb24gbWVjaGFuaXNtIHdoaWNoCj5kZXBlbmRzIG9uIGRlZmVycmluZyB0
byBrc29mdGlycWQgc28gdGhhdCBlLmcuIHRoZSBjb25zdW1lcnMgb2YgcmVjZWl2ZWQKPm5ldHdv
cmsgcGFja2V0cyBjYW4gYmUgc2NoZWR1bGVkIGFuZCB0aGUgc3lzdGVtIGNhbiBtYWtlIHByb2dy
ZXNzLgo+Cj5KdXN0IGJlY2F1c2UgaXQgZG9lcyBub3QgYnJlYWsgb24geW91ciBzeXN0ZW0gd2l0
aCB5b3VyIHBhcnRpY3VsYXIKPndvcmtsb2FkIGFuZCBjb25maWd1cmF0aW9uIGRvZXMgbm90IG1h
a2UgaXQgc3VpdGFibGUgZm9yIGdlbmVyYWwKPmNvbnN1bXB0aW9uLgo+Cj4+ICsjaWZkZWYgQ09O
RklHX1NPRlRJUlFfRk9SQ0VEX1RIUkVBRElORwo+PiArc3RhdGljIGlubGluZSB2b2lkIGludm9r
ZV9zb2Z0aXJxKHZvaWQpCj4+ICt7Cj4+ICsJd2FrZXVwX3NvZnRpcnFkKCk7Cj4KPkRlcGVuZGlu
ZyBvbiB0aGUgY29uZmlndXJhdGlvbiBhbmQgdGltaW5nIHRoaXMgYnJlYWtzIGFueSBlYXJseSBi
b290Cj5tZWNoYW5pc20gd2hpY2ggZGVwZW5kcyBvbiBzb2Z0aXJxcyBiZWluZyBoYW5kbGVkIGJl
Zm9yZSBrc29mdGlycWQgaXMKPmF2YWlsYWJsZS4gVGhpcyB3YXMgY2xlYXJseSBuZXZlciB0ZXN0
ZWQgd2l0aCBmdWxsIFJDVSBkZWJ1Z2dpbmcKPmVuYWJsZWQuIAo+Cj5Bc2lkZSBvZiB0aGF0IHRo
ZSBjaGFuZ2Vsb2cgbGFja3MgYW55IGZvcm0gb2YgdGVjaG5pY2FsIGFuYWx5c2lzIGFuZAo+anVz
dGlmaWNhdGlvbiBmb3IgdGhpcy4gSnVzdCBjbGFpbWluZyB0aGF0IHRoaW5ncyBhcmUgW3VuXXJl
YXNvbmFibGUgYW5kCj5tYWtpbmcgdW5pbmZvcm1lZCBzdGF0ZW1lbnRzIGFib3V0IFBSRUVNUFRf
UlQgZG9lcyBub3QgcXVhbGlmeS4gUXVpdGUKPnRoZSBjb250cmFyeSBpdCdzIGRlZmluaXRlbHkg
dW5yZWFzb25hYmxlLgo+Cj5UaGFua3MsCj4KPiAgICAgICAgdGdseAo+Cj4KClRoYW5rIHlvdSBm
b3IgeW91ciBwYXRpZW50IGd1aWRhbmNlLCBpZiBuZWNlc3NhcnksIEkgd2lsbCBhZGQgaXQgaW4g
dGhlIG5leHQgdmVyc2lvbi4KClRoYW5rcywKUWluZwoKDQoNCg==
