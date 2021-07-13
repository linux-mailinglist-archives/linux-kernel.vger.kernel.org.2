Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641673C73EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhGMQQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhGMQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6A4C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:10 -0700 (PDT)
Message-Id: <20210713151054.700719949@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=p/MvT26WzHCwkG0sEllFG1P7Iuxcd4L3DmWPLt3CZKc=;
        b=MWIpCT3G9C1lpMZCZBT+FDcqyTxIvm1eobgnNA9s7cnjKKoRru31QJ80pAYG2vbYPeZ6zg
        1g1hiXgX4RQGyMTx+Zno+3ZADcN60H0TwbqEzMJsEH5ExnaR5ZU9BHhlfeqL/xro54Ljab
        zxL09yyJUFaT7BuynFG5eDsgDcR3tQECJjJzt2+AGvUvE/Dv28eITOo1wpa57BikW0/Zga
        AR6xwsa1gtYtVvt4sSuikIdnmPVmQgctEg5t+EG3kHmGwmm6tTRaVVwnA/yH2CKhvbkF0Q
        FjPR8paoW39TGgWtvotMFVmm94hY5iU2IOnmWV6M274uKAMfbOd/kqgkYXS2lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=p/MvT26WzHCwkG0sEllFG1P7Iuxcd4L3DmWPLt3CZKc=;
        b=Wwgl6jSxstxLhS3O+Sge5h6Sss28wZZBapHgSedcvD8D4h6+DxULzqq2gIt79UVsFO6iit
        bsPDrd8LwaDpZOAQ==
Date:   Tue, 13 Jul 2021 17:10:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 00/50] locking, sched: The PREEMPT-RT locking infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9sa3MsCgp0aGUgZm9sbG93aW5nIHNlcmllcyBjb250YWlucyB0aGUgYnVsayBvZiB0aGUgUFJF
RU1QVC1SVCBsb2NraW5nCmluZnJhc3RydWN0dXJlLiBJbiBQUkVFTVBULVJUIGVuYWJsZWQga2Vy
bmVscyB0aGUgZm9sbG93aW5nIGxvY2tpbmcKcHJpbWl0aXZlcyBhcmUgc3Vic3RpdHV0ZWQgYnkg
UlQtTXV0ZXggYmFzZWQgdmFyaWFudHM6CgogIG11dGV4LCByd19zZW1hcGhvcmUsIHNwaW5sb2Nr
LCByd2xvY2sKCnNlbWFwaG9yZXMgYXJlIG5vdCBzdWJzdGl0dXRlZCBiZWNhdXNlIHRoZXkgZG8g
bm90IHByb3ZpZGUgc3RyaWN0IG93bmVyCnNlbWFudGljcy4KCnd3X211dGV4ZXMgYXJlIGFsc28g
bm90IHN1YnN0aXR1dGVkIGJlY2F1c2UgdGhlIHVzYWdlIHNpdGVzIGFyZSBub3QgcmVhbGx5ClJU
IHJlbGV2YW50IGFuZCBpdCB3b3VsZCByZXF1aXJlIGEgZnVsbCByZWltcGxlbWVudGF0aW9uIHRv
IG1ha2UgdGhlbSB3b3JrCmNvcnJlY3RseSBiYXNlZCBvbiBydG11dGV4LiBUaGF0IG1pZ2h0IGNo
YW5nZSBpbiB0aGUgZnV0dXJlLCBidXQgZm9yIG5vdwp1dGlsaXppbmcgdGhlIGV4aXN0aW5nIHZh
cmlhbnQgaXMgY29uc2lkZXJlZCBhIHNhZmUgYW5kIHNhbmUgY2hvaWNlLgoKT2YgY291cnNlIHJh
d19zcGlubG9ja3MgYXJlIG5vdCB0b3VjaGVkIGVpdGhlciBhcyB0aGV5IHByb3RlY3QgbG93IGxl
dmVsCm9wZXJhdGlvbnMgaW4gdGhlIHNjaGVkdWxlciwgdGltZXJzIGFuZCBoYXJkd2FyZSBhY2Nl
c3MuCgpUaGUgbW9zdCBpbnRlcmVzdGluZyBwYXJ0cyBvZiB0aGUgc2VyaWVzIHdoaWNoIG5lZWQg
YSBsb3Qgb2YgZXllYmFsbHMKYXJlOgoKICAtIHRoZSBzY2hlZHVsZXIgYml0cyB3aGljaCBwcm92
aWRlIHRoZSBpbmZyYXN0cnVjdHVyZSBmb3Igc3BpbmxvY2sgYW5kCiAgICByd2xvY2sgc3Vic3Rp
dHV0aW9uIHRvIGVuc3VyZSB0aGF0IHRoZSB0YXNrIHN0YXRlIGlzIHByZXNlcnZlZCB3aGVuCiAg
ICBibG9ja2luZyBvbiBzdWNoIGEgbG9jayBhbmQgYSByZWd1bGFyIHdha2V1cCBpcyBoYW5kbGVk
IGNvcnJlY3RseSBhbmQKICAgIG5vdCBsb3N0CgogIC0gdGhlIHJ0bXV0ZXggY29yZSBpbXBsZW1l
bnRhdGlvbiB0byBoYW5kbGUgbG9jayBjb250ZW50aW9uIG9uIHNwaW5sb2NrcwogICAgYW5kIHJ3
bG9ja3MgY29ycmVjdGx5IHZzLiB0aGUgdGFzayBzdGF0ZQoKICAtIHRoZSByd19zZW1hcGhvcmUv
cndsb2NrIHN1YnN0aXR1dGlvbnMgd2hpY2ggdXRpbGl6ZSB0aGUgc2FtZQogICAgaW1wbGVtZW50
YXRpb24gdnMuIHRoZSByZWFkZXIvd3JpdGVyIGhhbmRsaW5nCgogIC0gdGhlIGlzb2xhdGlvbiBv
ZiB0aGUgd3dfbXV0ZXggY29kZSB3aGljaCBhbGxvd3MgdG8gYnVpbGQgaXQgc3RhbmQgYWxvbmUu
CiAgICBUaGUgdHlwZWRlZiBiYXNlZCBzb2x1dGlvbiBtaWdodCBsb29rIGEgYml0IG9kZCBvbiB0
aGUgZmlyc3QgZ2xhbmNlLAogICAgYnV0IHRoYXQgdHVybmVkIG91dCB0byBiZSB0aGUgbGVhc3Qg
aW50cnVzaXZlIHZhcmlhbnQuCgogIC0gdGhlIFBJIGZ1dGV4IHJlbGF0ZWQgYml0cyB0byBoYW5k
bGUgdGhlIGludGVyYWN0aW9uIGJldHdlZW4gYmxvY2tpbmcKICAgIG9uIHRoZSB1bmRlcmx5aW5n
IHJ0bXV0ZXggYW5kIGNvbnRlbnRpb24gb24gdGhlIGhhc2ggYnVja2V0IGxvY2sgd2hpY2gKICAg
IGlzIGNvbnZlcnRlZCB0byBhICdzbGVlcGluZyBzcGlubG9jaycuCgpUaGUgcmVzdCBzdXJlbHkg
bmVlZHMgYSB0aG9yb3VnaCByZXZpZXcgYXMgd2VsbCwgYnV0IHRob3NlIHBhcnRzIGFyZSBwcmV0
dHkKc3RyYWlnaHQgZm9yd2FyZC4gUXVpdGUgc29tZSBjb2RlIHJlc3RydWN0dXJpbmcgYW5kIHRo
ZSBhY3R1YWwgd3JhcHBlcgpmdW5jdGlvbnMgdG8gcmVwbGFjZSB0aGUgZXhpc3RpbmcgIVJUIGlt
cGxlbWVudGF0aW9ucy4KClRoZSBzZXJpZXMgc3Vydml2ZWQgcXVpdGUgc29tZSBpbnRlcm5hbCB0
ZXN0aW5nIGluIFJUIGtlcm5lbHMgYW5kIGlzIHBhcnQKb2YgdGhlIHJlY2VudCA1LjEzLXJ0MSBy
ZWxlYXNlLgoKRm9yICFSVCBrZXJuZWxzIHRoZXJlIGlzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlLgoK
VGhlIHNlcmllcyBpcyBhbHNvIGF2YWlsYWJsZSBmcm9tIGdpdDoKCiAgZ2l0Oi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0IHJ0bXV0ZXgKClRo
YW5rcywKCgl0Z2x4Ci0tLQogYS9rZXJuZWwvbG9ja2luZy9tdXRleC1kZWJ1Zy5oICAgICAgIHwg
ICAyOSAtCiBiL2luY2x1ZGUvbGludXgvbXV0ZXguaCAgICAgICAgICAgICAgfCAgMTY1ICsrKyst
LQogYi9pbmNsdWRlL2xpbnV4L3JidHJlZV90eXBlcy5oICAgICAgIHwgICAzNCArCiBiL2luY2x1
ZGUvbGludXgvcndiYXNlX3J0LmggICAgICAgICAgfCAgIDM3ICsKIGIvaW5jbHVkZS9saW51eC9y
d2xvY2tfcnQuaCAgICAgICAgICB8ICAxNDAgKysrKysKIGIvaW5jbHVkZS9saW51eC9zcGlubG9j
a19ydC5oICAgICAgICB8ICAxNTEgKysrKysKIGIvaW5jbHVkZS9saW51eC9zcGlubG9ja190eXBl
c19yYXcuaCB8ICAgNjUgKysKIGIva2VybmVsL2xvY2tpbmcvcnRtdXRleF9hcGkuYyAgICAgICB8
ICA2NDcgKysrKysrKysrKysrKysrKysrKysrKysrCiBiL2tlcm5lbC9sb2NraW5nL3J3YmFzZV9y
dC5jICAgICAgICAgfCAgMjYzICsrKysrKysrKwogYi9rZXJuZWwvbG9ja2luZy9zcGlubG9ja19y
dC5jICAgICAgIHwgIDI1NyArKysrKysrKysKIGluY2x1ZGUvbGludXgvZGVidWdfbG9ja3MuaCAg
ICAgICAgICB8ICAgIDMgCiBpbmNsdWRlL2xpbnV4L3ByZWVtcHQuaCAgICAgICAgICAgICAgfCAg
ICA0IAogaW5jbHVkZS9saW51eC9yYnRyZWUuaCAgICAgICAgICAgICAgIHwgICAzMCAtCiBpbmNs
dWRlL2xpbnV4L3J0bXV0ZXguaCAgICAgICAgICAgICAgfCAgICA0IAogaW5jbHVkZS9saW51eC9y
d2xvY2tfdHlwZXMuaCAgICAgICAgIHwgICAzOSArCiBpbmNsdWRlL2xpbnV4L3J3c2VtLmggICAg
ICAgICAgICAgICAgfCAgIDU4ICsrCiBpbmNsdWRlL2xpbnV4L3NjaGVkLmggICAgICAgICAgICAg
ICAgfCAgIDc3ICsrCiBpbmNsdWRlL2xpbnV4L3NjaGVkL3dha2VfcS5oICAgICAgICAgfCAgICA3
IAogaW5jbHVkZS9saW51eC9zcGlubG9jay5oICAgICAgICAgICAgIHwgICAxNSAKIGluY2x1ZGUv
bGludXgvc3BpbmxvY2tfYXBpX3NtcC5oICAgICB8ICAgIDMgCiBpbmNsdWRlL2xpbnV4L3NwaW5s
b2NrX3R5cGVzLmggICAgICAgfCAgIDQ1ICsKIGluY2x1ZGUvbGludXgvd3dfbXV0ZXguaCAgICAg
ICAgICAgICB8ICAgMTYgCiBrZXJuZWwvS2NvbmZpZy5sb2NrcyAgICAgICAgICAgICAgICAgfCAg
ICAyIAoga2VybmVsL2Z1dGV4LmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDQ2NiArKysrKysr
KysrKystLS0tLQoga2VybmVsL2xvY2tpbmcvTWFrZWZpbGUgICAgICAgICAgICAgIHwgICAgMyAK
IGtlcm5lbC9sb2NraW5nL211dGV4LWRlYnVnLmMgICAgICAgICB8ICAgMjUgCiBrZXJuZWwvbG9j
a2luZy9tdXRleC5jICAgICAgICAgICAgICAgfCAgMTM5ICsrLS0tCiBrZXJuZWwvbG9ja2luZy9t
dXRleC5oICAgICAgICAgICAgICAgfCAgIDM1ICsKIGtlcm5lbC9sb2NraW5nL3J0bXV0ZXguYyAg
ICAgICAgICAgICB8ICA5MzAgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGtl
cm5lbC9sb2NraW5nL3J0bXV0ZXhfY29tbW9uLmggICAgICB8ICAxMTAgKystLQoga2VybmVsL2xv
Y2tpbmcvcndzZW0uYyAgICAgICAgICAgICAgIHwgIDEwOCArKysrCiBrZXJuZWwvbG9ja2luZy9z
cGlubG9jay5jICAgICAgICAgICAgfCAgICA3IAoga2VybmVsL2xvY2tpbmcvc3BpbmxvY2tfZGVi
dWcuYyAgICAgIHwgICAgNSAKIGtlcm5lbC9zY2hlZC9jb3JlLmMgICAgICAgICAgICAgICAgICB8
ICAxMTEgKysrLQogbGliL3Rlc3RfbG9ja3VwLmMgICAgICAgICAgICAgICAgICAgIHwgICAgOCAK
IDM1IGZpbGVzIGNoYW5nZWQsIDMwMzEgaW5zZXJ0aW9ucygrKSwgMTAwNyBkZWxldGlvbnMoLSkK
