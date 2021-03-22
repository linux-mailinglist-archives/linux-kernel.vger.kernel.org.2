Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BB6343CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVJ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhCVJ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:28:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08138C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:28:39 -0700 (PDT)
Message-Id: <20210322091941.909544288@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616405318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qR0W/jXbda6i28OXgK5oBUBx673pBiRJdHCHkVstEOQ=;
        b=wSC71/U1tnN25a//L2XfG5V3FcEHEb3SxD19bBimjqSekcYK7CoU+qnv3yi4CvTwzPW/hD
        Pax9ibl/2YlPi+CbbyLtJGUqPJeQnoCk6Kb7mBhz8zgjK0T1lcgLmvvtDSCeu5SNMzPrCm
        8Gok3wq9O6s3cr3XHfNGvc6kiZF/K3MXjj/ZgG8TdVlSgudy8escVgEUYBo24zpevvKuPc
        ENKxGSUQuNTvUoaJsAgWXO+YXpqggzcHlcCn5c86hRwGWBojYT/kWNSQvN4VG4yIyW4m8r
        El5OIDlY4zlElQ6kjNi39FU+b1vyplxjCiQaJ+jiqJw1rkWsnNDTvd6NpX2H/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616405318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qR0W/jXbda6i28OXgK5oBUBx673pBiRJdHCHkVstEOQ=;
        b=lJ7sK3MIDKbSFvRgzNWaxrX6yNuWQjD6nsAVmgKokS9x644fAMNRi6xBgQpnkbwCtqv9AC
        igu+e0okWqtMm2AA==
Date:   Mon, 22 Mar 2021 10:19:41 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [patch V4 0/2] signals: Allow caching one sigqueue object per task
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyBhIGZvbGxvdyB1cCB0byB0aGUgVjIvVjMgc3VibWlzc2lvbiB3aGljaCBjYW4gYmUg
Zm91bmQgaGVyZToKCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMDMxMTEzMjAzNi4y
Mjg1NDI1NDBAbGludXRyb25peC5kZQoKU2lnbmFsIHNlbmRpbmcgcmVxdWlyZXMgYSBrbWVtIGNh
Y2hlIGFsbG9jYXRpb24gYXQgdGhlIHNlbmRlciBzaWRlIGFuZCB0aGUKcmVjZWl2ZXIgaGFuZHMg
aXQgYmFjayB0byB0aGUga21lbSBjYWNoZSB3aGVuIGNvbnN1bWluZyB0aGUgc2lnbmFsLgoKVGhp
cyB3b3JrcyBwcmV0dHkgd2VsbCBldmVuIGZvciByZWFsdGltZSB3b3JrbG9hZHMgZXhjZXB0IGZv
ciB0aGUgY2FzZSB3aGVuCnRoZSBrbWVtIGNhY2hlIGFsbG9jYXRpb24gaGFzIHRvIGdvIGludG8g
dGhlIHNsb3cgcGF0aCB3aGljaCBpcyByYXJlIGJ1dApoYXBwZW5zLgoKUHJlZW1wdC1SVCBjYXJy
aWVzIGEgcGF0Y2ggd2hpY2ggYWxsb3dzIGNhY2hpbmcgb2Ygb25lIHNpZ3F1ZXVlIG9iamVjdCBw
ZXIKdGFzay4gVGhlIG9iamVjdCBpcyBub3QgcHJlYWxsb2NhdGVkLiBJdCdzIGNhY2hlZCB3aGVu
IHRoZSB0YXNrIHJlY2VpdmVzIGEKc2lnbmFsLiBUaGUgY2FjaGUgaXMgZnJlZWQgd2hlbiB0aGUg
dGFzayBleGl0cy4KClRoZSBtZW1vcnkgb3ZlcmhlYWQgZm9yIGEgc3RhbmRhcmQgZGlzdHJvIHNl
dHVwIGlzIHByZXR0eSBzbWFsbC4gQWZ0ZXIgYm9vdAp0aGVyZSBhcmUgbGVzcyB0aGFuIDEwIG9i
amVjdHMgY2FjaGVkIGluIGFib3V0IDE1MDAgdGFza3MuIFRoZSBzcGVlZHVwIGZvcgpzZW5kaW5n
IGEgc2lnbmFsIGZyb20gYSBjYWNoZWQgc2lncXVldWUgb2JqZWN0IGlzIHNtYWxsICh+M3VzKSBw
ZXIgc2lnbmFsCmFuZCBhbG1vc3QgaW52aXNpYmxlLCBidXQgZm9yIHNpZ25hbCBoZWF2eSB3b3Jr
bG9hZHMgaXQncyBkZWZpbml0ZWx5Cm1lYXN1cmFibGUgYW5kIGZvciB0aGUgdGFyZ2V0ZWQgcmVh
bHRpbWUgd29ya2xvYWRzIGl0J3Mgc29sdmluZyBhIHJlYWwKd29ybGQgbGF0ZW5jeSBpc3N1ZS4K
CkNoYW5nZXMgdnMgVjIvMzoKCiAgIC0gRHJvcCB0aGUgcHJldmlvdXMgd3JhcHBlciBmdW5jdGlv
biBhbmQgZXhwbGljaXRseSBkcm9wCiAgICAgdGhlIHNpZ3F1ZXVlIGNhY2hlIGF0IHRoZSBlbmQg
b2YgX19leGl0X3NpZ25hbHMoKSB0bwogICAgIGhhbmRsZSB0aGUgc2VsZiByZWFwaW5nIGNhc2Ug
Y29ycmVjdGx5CgpUaGFua3MsCgoJdGdseAotLS0KIGluY2x1ZGUvbGludXgvc2NoZWQuaCAgfCAg
ICAxIAogaW5jbHVkZS9saW51eC9zaWduYWwuaCB8ICAgIDEgCiBrZXJuZWwvZXhpdC5jICAgICAg
ICAgIHwgICAgMSAKIGtlcm5lbC9mb3JrLmMgICAgICAgICAgfCAgICAxIAoga2VybmVsL3NpZ25h
bC5jICAgICAgICB8ICAgNTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLQogNSBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkKCg==
