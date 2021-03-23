Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7988346B38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhCWVj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhCWVjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF8DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:39:41 -0700 (PDT)
Message-Id: <20210323213019.217008708@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/KkAsdY9ZK9gBU/srei55hPc2gmHrRAtoBjGfeDELZs=;
        b=kZCl53IA0jOtDZxpvGHI206T1v2sGSXhVWs54IPkszNK/EuNuzW9E/x90Bzx/XiAqiVhxf
        G786HvWotvAC4/xDx+ZEhJRm8qDKrXYs8kK7OWLn6PFEH0PcKivQ+hrPa0JTttGlBYnJ6w
        Bz5yON7pK/fjjfKq+On8mWdPMd8YWMt9ZzofGS72aJNnv5ZX60fovVTHaHvpF3+6OWImaQ
        S67xkbqF7vK+gBxq98nTrcNCUHX2HJh8dcqeuGG87JHDDSL65O169jA+kgqDQo9q5IEH6n
        YkUzHImw7g0W0x32n3e1CnSPyx3sG/9AJJVNEaU1IZWchVWi77EjsrtZO7LI/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/KkAsdY9ZK9gBU/srei55hPc2gmHrRAtoBjGfeDELZs=;
        b=0N2X7Q/m6vIr6+4dUFpoR3P9TZ8jujnQCrtGFiXrmQH7kxbQvOW9sHkczHJDFfcmM2C0CM
        ScGKZ3mewMgZEGAg==
Date:   Tue, 23 Mar 2021 22:30:19 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 00/14] locking/rtmutex: Spring cleaning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hpbGUgd29ya2luZyBvbiB0aGUgcnRtdXRleCByZWxhdGVkIFJUIGJpdHMgd2Ugbm90aWNlZCBx
dWl0ZSBzb21lCmluY29uc2lzdGVuY2llcyBhbmQgYml0cm90IGluIHRoZSBydG11dGV4IGNvZGUu
CgpNb3AgaXQgdXAuCgpUaGFua3MsCgoJdGdseAotLS0KIGIvaW5jbHVkZS9saW51eC9ydG11dGV4
LmggICAgICAgICB8ICAgMzUgLS0tCiBiL2tlcm5lbC9sb2NraW5nL01ha2VmaWxlICAgICAgICAg
fCAgICAyIAogYi9rZXJuZWwvbG9ja2luZy9ydG11dGV4LmMgICAgICAgIHwgIDM3OSArKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogYi9rZXJuZWwvbG9ja2luZy9ydG11dGV4
X2NvbW1vbi5oIHwgICA5OCArKysrLS0tLS0KIGtlcm5lbC9sb2NraW5nL3J0bXV0ZXgtZGVidWcu
YyAgICB8ICAxODIgLS0tLS0tLS0tLS0tLS0tLS0tCiBrZXJuZWwvbG9ja2luZy9ydG11dGV4LWRl
YnVnLmggICAgfCAgIDM3IC0tLQoga2VybmVsL2xvY2tpbmcvcnRtdXRleC5oICAgICAgICAgIHwg
ICAzNSAtLS0KIDcgZmlsZXMgY2hhbmdlZCwgMTg0IGluc2VydGlvbnMoKyksIDU4NCBkZWxldGlv
bnMoLSkKCgo=
