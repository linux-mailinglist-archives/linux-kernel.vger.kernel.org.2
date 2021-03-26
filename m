Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E3B34AC28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhCZQBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhCZQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A688DC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:01:31 -0700 (PDT)
Message-Id: <20210326152929.709289883@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gfJr7ScbWnQk4pJF0qiiMeeCn5sS/3LAzZ/jU7MLgCQ=;
        b=UgQqzWjD92ytXy5CVwjkEoW0jcdKJIgivxIHTK8xRxfHcalYc8GR01EZBdc+dMWiYkWFI/
        lKZ/NiHjjHsmuTth6A7/sxHBsVyL/ezAZ9xp0sjb0SfYjmWGstPCbiWWdAGcPtxLe3F0zL
        e520n5RL2jksEcfNSVl6uphsju6UzHkqLIInR0+MasTziYJ6qvRx2d6MrpRVyfRhHxKMAL
        R43uunjqHC6YhvDoyF1OmWBBWiQpQ0dkyZP+3ZwxMUkzJAEvcflPHJP4UichM/Z7jsmHwe
        67KoDI+pq2jnmJ2FGGzQNd9KE+PjZBhl0Sy3fTXQNrpc73Pyd6k7212SCXNzwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gfJr7ScbWnQk4pJF0qiiMeeCn5sS/3LAzZ/jU7MLgCQ=;
        b=zvzJ8/qHxZQj0NPlrVK1AmjcjrrfPSD7QKEkIkziRzb83k83meyrZiQxDAAIdB75pU9PIk
        y924zmQeUbBhyuBQ==
Date:   Fri, 26 Mar 2021 16:29:29 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 00/15] locking/rtmutex: Spring cleaning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyBWMiBvZiB0aGlzIGNsZWFudXAuIFYxIGNhbiBiZSBmb3VuZCBoZXJlOgoKICAgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci84N2g3a3lka2EwLmZmc0BuYW5vcy50ZWMubGludXRyb25p
eC5kZQoKV2hpbGUgd29ya2luZyBvbiB0aGUgcnRtdXRleCByZWxhdGVkIFJUIGJpdHMgd2Ugbm90
aWNlZCBxdWl0ZSBzb21lCmluY29uc2lzdGVuY2llcyBhbmQgYml0cm90IGluIHRoZSBydG11dGV4
IGNvZGUuCgpUaGUgc2VyaWVzIGlzIGJhc2VkIG9uCgogICBnaXQ6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQgbG9ja2luZy9jb3JlCgphbmQgYWxz
byBhdmFpbGFibGUgZnJvbToKCiAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90Z2x4L2RldmVsLmdpdCBydG11dGV4CgphcyBhIGNvbWJvLgoKQ2hhbmdlcyB2
cy4gVjE6CiAgLSBGaXggdGhlIGZhbGxvdXQgcmVwb3J0ZWQgYnkgMGRheSBhbmQgU2ViYXN0aWFu
CiAgLSBNYWtlIHRoZSBvcGVuIGNvZGVkIHJlcGxhY2VtZW50cyB3b3JrIGZvciByZWFsCiAgLSBB
ZGQgdGhlIHNpZ25hbCBjbGVhbnVwIHdoaWNoIEkgbWlzc2VkIGxhc3QgdGltZQoKVGhhbmtzLAoK
CXRnbHgKLS0tCiBhL2tlcm5lbC9sb2NraW5nL3J0bXV0ZXgtZGVidWcuYyB8ICAxODIgLS0tLS0t
LS0tLS0tLS0tLS0KIGEva2VybmVsL2xvY2tpbmcvcnRtdXRleC1kZWJ1Zy5oIHwgICAzNyAtLS0K
IGEva2VybmVsL2xvY2tpbmcvcnRtdXRleC5oICAgICAgIHwgICAzNSAtLS0KIGluY2x1ZGUvbGlu
dXgvcnRtdXRleC5oICAgICAgICAgIHwgICAzNSAtLS0KIGtlcm5lbC9sb2NraW5nL01ha2VmaWxl
ICAgICAgICAgIHwgICAgMiAKIGtlcm5lbC9sb2NraW5nL3J0bXV0ZXguYyAgICAgICAgIHwgIDQw
MiArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGtlcm5lbC9sb2NraW5n
L3J0bXV0ZXhfY29tbW9uLmggIHwgIDEwNCArKysrKy0tLS0tCiA3IGZpbGVzIGNoYW5nZWQsIDIw
MiBpbnNlcnRpb25zKCspLCA1OTUgZGVsZXRpb25zKC0pCg==
