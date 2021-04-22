Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E993687E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhDVUaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVUaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:30:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:29:36 -0700 (PDT)
Message-Id: <20210422194417.866740847@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619123374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9IPpxOQaJ5pE7oVBrs7UcE1Vi+DsS/Jb4vcM/2UZpxg=;
        b=Xwteei1c2UDL8gRK2gkHhLaA0Q5dQ2ti8Ye63/qcM2UAStaHxn0XjLyShx6dacaMdM9+5F
        lBlzS6vaQiHv1+dCUYn5OehqBpSF6mwkhRPyv79OAXoug4UuxSrS8nhDIRae2YzbMgOtfz
        znpqgoPiCjY6rLRjfoNZwHhrXSWGDByqCkJ8hFrXM+L7XVIO5tNfAfyXBkSVqmz8Nkjz/9
        iY+Pz4C6Q/5wsMusuVsQTXa/mrwFKYuQ6CHFVAetAX2TvFTKbWAu68V9vwaYcoEhg0Tcmt
        LG0eKRKTZ0H5SD1SuQ/grM0UAqNJbVHe5pUG2BRAv1Lh2PnkLntQX21GCWG3tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619123374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9IPpxOQaJ5pE7oVBrs7UcE1Vi+DsS/Jb4vcM/2UZpxg=;
        b=MGUy6Yxcvcslj9MMRuBUEqOs3rvpG/KsRbjyG/mKXFMYh6B8mNlUXyEGBXwlYpTacIXat8
        BQ30jLLtgNSiqVDg==
Date:   Thu, 22 Apr 2021 21:44:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Lukasz Majewski <lukma@denx.de>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [patch 0/6] futex: Bugfixes and FUTEX_LOCK_PI2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGZvbGxvd2luZyBzZXJpZXMgc3RhcnRlZCBvZmYgbG9va2luZyBpbnRvIHN1cHBvcnRpbmcg
c2VsZWN0YWJsZSBjbG9ja3MKZm9yIEZVVEVYX0xPQ0tfUEkgd2hpY2ggaXMgaGFyZGNvZGVkIHRv
IENMT0NLX1JFQUxUSU1FIGFuZCBjYW5ub3QgYmUKY2hhbmdlZC4KCk9uIHRoZSB3YXkgSSBmb3Vu
ZCB0d28gYnVncyByZWxhdGVkIHRvIHRoZSB0aW1lb3V0IGhhbmRsaW5nOgoKICAtIFRoZSBhbGxv
d2FuY2UgZm9yIEZVVEVYX1dBSVQgdG8gdXNlIEZVVEVYX0NMT0NLX1JFQUxUSU1FIGlzIGJyb2tl
biBhbmQKICAgIG5ldmVyIHdvcmtlZC4KCiAgLSBUaGUgcmVjZW50IHRpbWUgbmFtZXNwYWNlIHN1
cHBvcnQgd3JlY2thZ2VkIEZVVEVYX0xPQ0tfUEkgdGltZW91dHMgd2hlbgogICAgdGhlIHRhc2sg
YmVsb25ncyB0byBhIG5hbWVzcGFjZSB3aGljaCBoYXMgYW4gQ0xPQ0tfTU9OT1RPTklDIG9mZnNl
dC4KCkJvdGggc2hvdWxkIGhhdmUgYmVlbiBjYXVnaHQgYnkgdGhhdCBHbGVpeG5lciBkdWRlIHdo
ZW4gbWVyZ2luZyB0aGVtLApidXQgaXQgc2VlbXMgaGUncyBnZXR0aW5nIG9sZC4KCk5vdCBoYXZp
bmcgYSBzZWxlY3RhYmxlIGNsb2NrIGZvciBQSSBmdXRleGVzIGlzIGluY29uc2lzdGVudCBiZWNh
dXNlIGFsbApvdGhlciBpbnRlcmZhY2VzIGhhdmUgaXQuIFVuZm9ydHVuYXRlbHkgdGhpcyB3YXMg
ZmlndXJlZCBvdXQgYnkgZ2xpYmMgZm9sa3MKcXVpdGUgc29tZSB0aW1lIGFnbywgYnV0IG5vYm9k
eSB0b2xkIHVzIDooCgpUaGUgbmFzdHkgaGFjayB0byBzdXBwb3J0IGl0IHdvdWxkIGJlIHRvIHRy
ZWF0IEZVVEVYX0NMT0NLX1JFQUxUSU1FIGludmVyc2UKZm9yIEZVVEVYX0xPQ0tfUEksIGJ1dCB0
aGF0J3MgYSBob3JyaWJsZSBpZGVhLiBBZGRpbmcgYSBuZXcgZmxhZyB0byB0aGUKZnV0ZXggb3As
IGkuZS4gRlVURVhfQ0xPQ0tfTU9OT1RPTklDIHdvdWxkIGJlIHBvc3NpYmxlLCBidXQgdGhhdCdz
IHlldAphbm90aGVyIHZhcmlhbnQgd2hpY2ggbWFrZXMgaXMgaGFyZGVyIGZvciBsaWJyYXJpZXMg
dG8gaGF2ZSBhIGNvbnNpc3RlbnQKY2xvY2sgc2VsZWN0aW9uIGhhbmRsaW5nLgoKU28gSSB3ZW50
IHRoZSB3YXkgdG8gbGV0IEZVVEVYX0xPQ0tfUEkgYWxvbmUgYW5kIHRvIGFkZCBGVVRFWF9MT0NL
X1BJMgp3aGljaCBoYW5kbGVzIHRoZSBjbG9ja3MgdGhlIHNhbWUgd2F5IGFzIHRoZSBvdGhlciBv
cGVyYW5kcy4KClRob3VnaHRzPwoKVGhlIHNlcmllcyBpcyBhbHNvIGF2YWlsYWJsZSBmcm9tIGdp
dDoKCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RnbHgv
ZGV2ZWwuZ2l0IGZ1dGV4CgpUaGFua3MsCgoJdGdseAotLS0KIGluY2x1ZGUvdWFwaS9saW51eC9m
dXRleC5oIHwgICAgMSAKIGtlcm5lbC9mdXRleC5jICAgICAgICAgICAgIHwgICA4OSArKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwg
NDcgaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0pCgo=
