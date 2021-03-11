Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0B33754D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhCKOSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:18:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40672 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbhCKOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:18:17 -0500
Message-Id: <20210311132036.228542540@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615472295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qkKcG1mgbC1GGOdB94l5t8PlzZVU4PCQ1n0hbKnZ59c=;
        b=cv0ECABapO1jZDqwEeRZgDMFpvgJh6XLkO+9TOih/fnGTLEVLF8MLCZ+iHWq+Ybw6lbQSf
        5g5sSJotQirzys4+LKKrRltRAU8wm8PBtqEXQZb7QJJa9dAc6bvvRYa4SA8exjogRRSEMc
        OcF2PjyRSe41jJhTp5XAypspIEY+SG/U41qBMhnBKRuZIW3fI7woJnM8eiJ9hCwOOrdBDc
        7JVCk9i4PnKfa7hciMITfXzOt97vum78rE9Yk0z/iDQ3+2waorcPs2R3qSZizHNLLQsZGh
        zwv8EYwLT2MTi+ICq93XrBXSzhBgxYovi6aA0VdqWNKZ/OgW9nC8V6g4hDPNTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615472295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qkKcG1mgbC1GGOdB94l5t8PlzZVU4PCQ1n0hbKnZ59c=;
        b=uGWQabNQVGvcQvr93kfvH4/oVdzzWKAOj62pIt3pbPRnxFvxV25JUSmTl/H/xDSpQpIjKO
        WeXlPzOnyO1nDHAQ==
Date:   Thu, 11 Mar 2021 14:20:36 +0100
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
Subject: [patch V2 0/3] signals: Allow caching one sigqueue object per task
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyBhIGZvbGxvdyB1cCB0byB0aGUgaW5pdGlhbCBzdWJtaXNzaW9uIHdoaWNoIGNhbiBi
ZSBmb3VuZCBoZXJlOgoKICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEwMzAzMTQyMDI1
LndiYnQybm5yNmR0Z3dqZmlAbGludXRyb25peC5kZQoKU2lnbmFsIHNlbmRpbmcgcmVxdWlyZXMg
YSBrbWVtIGNhY2hlIGFsbG9jYXRpb24gYXQgdGhlIHNlbmRlciBzaWRlIGFuZCB0aGUKcmVjZWl2
ZXIgaGFuZHMgaXQgYmFjayB0byB0aGUga21lbSBjYWNoZSB3aGVuIGNvbnN1bWluZyB0aGUgc2ln
bmFsLgoKVGhpcyB3b3JrcyBwcmV0dHkgd2VsbCBldmVuIGZvciByZWFsdGltZSB3b3JrbG9hZHMg
ZXhjZXB0IGZvciB0aGUgY2FzZSB3aGVuCnRoZSBrbWVtIGNhY2hlIGFsbG9jYXRpb24gaGFzIHRv
IGdvIGludG8gdGhlIHNsb3cgcGF0aCB3aGljaCBpcyByYXJlIGJ1dApoYXBwZW5zLgoKUHJlZW1w
dC1SVCBjYXJyaWVzIGEgcGF0Y2ggd2hpY2ggYWxsb3dzIGNhY2hpbmcgb2Ygb25lIHNpZ3F1ZXVl
IG9iamVjdCBwZXIKdGFzay4gVGhlIG9iamVjdCBpcyBub3QgcHJlYWxsb2NhdGVkLiBJdCdzIGNh
Y2hlZCB3aGVuIHRoZSB0YXNrIHJlY2VpdmVzIGEKc2lnbmFsLiBUaGUgY2FjaGUgaXMgZnJlZWQg
d2hlbiB0aGUgdGFzayBleGl0cy4KClRoZSBtZW1vcnkgb3ZlcmhlYWQgZm9yIGEgc3RhbmRhcmQg
ZGlzdHJvIHNldHVwIGlzIHByZXR0eSBzbWFsbC4gQWZ0ZXIgYm9vdAp0aGVyZSBhcmUgbGVzcyB0
aGFuIDEwIG9iamVjdHMgY2FjaGVkIGluIGFib3V0IDE1MDAgdGFza3MuIFRoZSBzcGVlZHVwIGZv
cgpzZW5kaW5nIGEgc2lnbmFsIGZyb20gYSBjYWNoZWQgc2lncXVldWUgb2JqZWN0IGlzIHNtYWxs
ICh+M3VzKSBwZXIgc2lnbmFsCmFuZCBhbG1vc3QgaW52aXNpYmxlLCBidXQgZm9yIHNpZ25hbCBo
ZWF2eSB3b3JrbG9hZHMgaXQncyBkZWZpbml0ZWx5Cm1lYXN1cmFibGUgYW5kIGZvciB0aGUgdGFy
Z2V0ZWQgcmVhbHRpbWUgd29ya2xvYWRzIGl0J3Mgc29sdmluZyBhIHJlYWwKd29ybGQgbGF0ZW5j
eSBpc3N1ZS4KCkNoYW5nZXMgdnMgVjE6CgogICAtIHRoZSBjYWNoaW5nIGlzIG5vdyB1bmNvbmRp
dGlvbmFsCiAgIC0gZHJvcCB0aGUgcG9pbnRsZXNzIGNtcHhjaGcKICAgLSBzcGxpdCB0aGUgcGF0
Y2ggdXAgZm9yIGJldHRlciByZWFkYWJpbGl0eQogICAtIGFkZCBhIHByb3BlciBhbmFseXNpcyB0
byB0aGUgY2hhbmdlbG9nIHZzLiB0aGUgaW1wYWN0IGFuZCBiZW5lZml0cwoKVGhhbmtzLAoKCXRn
bHgKLS0tCiBpbmNsdWRlL2xpbnV4L3NjaGVkLmggIHwgICAgMSArCiBpbmNsdWRlL2xpbnV4L3Np
Z25hbC5oIHwgICAgMSArCiBrZXJuZWwvZXhpdC5jICAgICAgICAgIHwgICAgMyArLS0KIGtlcm5l
bC9mb3JrLmMgICAgICAgICAgfCAgICAxICsKIGtlcm5lbC9zaWduYWwuYyAgICAgICAgfCAgIDQ0
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiA1IGZpbGVzIGNo
YW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo=
