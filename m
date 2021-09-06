Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21E0401D01
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243385AbhIFObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243274AbhIFObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:31:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D19C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 07:30:10 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630938607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ExnEWtc4xI4X1bkxlxoBcGUYdKcp48vBckwlNxAdZ28=;
        b=doze4f6OqbN1EIY+cxyV15He9Dz+gxZUhtP583TcZhX6R6dObp6P5wgWsoLuoNndEH1ekS
        Gmsf8HuHSjN0ps5whxGW4r6xcjIgWzg749TzdJpL3rhBdq7NoGDPkGBKORPCi3M4szEUJX
        PoEjpJ0sfU7LXeFzoaL8BufVb7yi0HAsI4qPLxwTg+PgJxzCjn447ismCFfpnav+CzDSC3
        rKBp5G68Eq4vMSUw7N06UcpnO6g9+hTKi9SdECC1ryz4TRksGg4bTtPLiPEDmovLwXBNUL
        aTbyLXI/gzvsYU3zftN1wUcbUXweXarX4zarDs+Nlaj/ZAc1TgnaKEgpDcUftA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630938607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ExnEWtc4xI4X1bkxlxoBcGUYdKcp48vBckwlNxAdZ28=;
        b=nXYvgwvxCtM+eTeKnNeJpxV3XlU0yW0EcnK7rObRPJapyCnv3IEsMeKRXrZ7nele4VLgfB
        rYTcMyT0dPVXEVCA==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] locking: Provide {rwlock|spin}_is_contended on PREEMPT_RT
Date:   Mon,  6 Sep 2021 16:30:02 +0200
Message-Id: <20210906143004.2259141-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lkp bot reported that rt_rwlock_is_contended() is not used so I
looked closer.

#1 wires up rwlock_is_contended() with rt_rwlock_is_contended() as it
was probably intended. As noted in the patch description, a writer
will always see true based on the current implementation. This could be
solved by looking at the waiters of the rtmutex underneath as done in #2
for spin_lock (which is missing). The helper is not exported and would
be also needed for rwsem_is_contended() because it is using the same
rw_base_is_contended() implementation.

Maybe it is not worth the trouble given that on PREEMPT_RT the rwlock/
spinlock is preemptible so it might be just best to return false and
wait for the scheduler to do its magic.

Sebastian


