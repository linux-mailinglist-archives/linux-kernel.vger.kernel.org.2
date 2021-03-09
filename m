Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C37633216A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCII6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhCII5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:57:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0E9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:57:41 -0800 (PST)
Message-Id: <20210309085552.815026890@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615280259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RjGB+NgM5iS0Xu0u/IjAds1E07pnNykvhbvtqJ9R5vg=;
        b=K3diAjT1vyFS//40dbNw+A+FdTknzNVwJxzVuJSKV+owi90vIDv1xE30np/GuIzhtuq8EI
        A0trqJgujioqfCzyTOInyAqTqevUFmDrFkZUFJ1e8UJpxM6YgQ45aZA4Z8RnmJul7NTVyf
        ZpLAZ43ZWqOMIa8OB6x4rwviXDg1BCiOKF9ewjjre2smVuyLJTzb6dXuzRGI8Oso883DFl
        5E2+GrOENKWc9JUIltEGZRBT7CTbJf5ZGgNmQkvoyknKr8xFAfB9EFfTGR9pBVKHGwEf4N
        3DAtMsQGrtEWZXwftUk0raeCA++GeSEkBl8kbaGDsfjPNulDbx0DMFrND54+gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615280259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RjGB+NgM5iS0Xu0u/IjAds1E07pnNykvhbvtqJ9R5vg=;
        b=XMnZOjbOwnJdu9d40opODcxynEz/Op5/LfqFpidmeGa3MC7xg1KRrZwhM6c07AZsdmDGRv
        6IqpkCoOc2S2L9Bg==
Date:   Tue, 09 Mar 2021 09:55:52 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V3 0/6] softirq: Add RT specific softirq accounting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UlQgcnVucyBzb2Z0aXJxIHByb2Nlc3NpbmcgYWx3YXlzIGluIHRocmVhZCBjb250ZXh0IGFuZCBp
dCByZXF1aXJlcyB0aGF0CmJvdGggdGhlIHNvZnRpcnEgZXhlY3V0aW9uIGFuZCB0aGUgQkggZGlz
YWJsZWQgc2VjdGlvbnMgYXJlIHByZWVtcHRpYmxlLgoKVGhpcyBpcyBhY2hpZXZlZCBieSBzZXJp
YWxpemF0aW9uIHRocm91Z2ggcGVyIENQVSBsb2NhbCBsb2NrcyBhbmQKc3Vic3RpdHV0aW5nIGEg
ZmV3IHBhcnRzIG9mIHRoZSBleGlzdGluZyBzb2Z0aXJxIHByb2Nlc3NpbmcgY29kZSB3aXRoCmhl
bHBlciBmdW5jdGlvbnMuCgpUaGUgc2VyaWVzIGFwcGxpZXMgb24gdG9wIG9mCgogICBnaXQ6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgdGFz
a2xldC0yMDIxLTAzLTA5CgphbmQgaXMgY29tcGxldGVseSBhdmFpbGFibGUgZnJvbToKCiAgIGdp
dDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90Z2x4L2RldmVsLmdp
dCBzb2Z0aXJxCgpDaGFuZ2VzIHRvIFYyIHdoaWNoIGNhbiBiZSBmb3VuZCBoZXJlOgoKICBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjAxMjA0MTcwMTUxLjk2MDMzNjY5OEBsaW51dHJvbml4
LmRlCgogLSBTcGxpdCB0aGUgdGFza2xldCBjaGFuZ2VzIG91dCAoc2VwZXJhdGUgc3VibWlzc2lv
bikKIAogLSBSZWJhc2UgaXQgb24gdGhlIHRhc2tsZXQgc2VyaWVzIChubyBmdXJ0aGVyIGNoYW5n
ZXMpCgpUaGFua3MsCgoJdGdseAoK
