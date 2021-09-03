Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2013FFC32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348385AbhICIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348336AbhICIlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:41:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83826C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 01:40:20 -0700 (PDT)
Date:   Fri, 3 Sep 2021 10:40:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630658402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxI4ujBpNUJuVZeKZv/RoX2/2de6kE0FPj6oLtETCxA=;
        b=enTX/h/7maWIfEc4W9u+WuDmGa9tTP/rb/UfD6iH+bfdH+U0VotFFPbPMIsKsIzI6/mEiX
        E4ex54FYBwSmRvh01w61Laz5nEqLk0D/CdxfOgWat0XCjf/Rbd3li/TychQSBb0qdXGr+2
        aOOZlLwUl+3ZoEspXZpj6pg9Dqs0H6A+ESvSpBI4RRR5aQYJfNELncuBWxREa3lHAB9MbZ
        smsEiUadEluDJjWqPHfoGIK/YRGH+fIFA6ELyk5YIj23EJoK8glb+8ynDMAv2cVeFApCwX
        8aU1la15we/dDoQ2rSFBzAQsmSzyCgtBBxyRHhNDhbBT9bFTnNHumVNQlhjR/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630658402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxI4ujBpNUJuVZeKZv/RoX2/2de6kE0FPj6oLtETCxA=;
        b=nLkAkdDWZMS9hVzZ/0jW+E4X77VhdVPzrheOaYC/X53gBi/k3Ibgh66+EEPRBUkKg9FDkG
        YrafOUYzKul5kIDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <llong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] lockdep: Let lock_is_held_type() detect recursive read as
 read
Message-ID: <20210903084001.lblecrvz4esl4mrr@linutronix.de>
References: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
 <9af2b074-9fcf-5aea-f37d-9b2482146489@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9af2b074-9fcf-5aea-f37d-9b2482146489@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lock_is_held_type(, 1) detects acquired read locks. It only recognized
locks acquired with lock_acquire_shared(). Read locks acquired with
lock_acquire_shared_recursive() are not recognized because a `2' is
stored as the read value.

Rework the check to additionally recognise lock's read value one and two
as a read held lock.

Fixes: e918188611f07 ("locking: More accurate annotations for read_lock()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - simplify the read check to !!read as suggested by Waiman Long.

 kernel/locking/lockdep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5366,7 +5366,7 @@ int __lock_is_held(const struct lockdep_
 		struct held_lock *hlock =3D curr->held_locks + i;
=20
 		if (match_held_lock(hlock, lock)) {
-			if (read =3D=3D -1 || hlock->read =3D=3D read)
+			if (read =3D=3D -1 || hlock->read =3D=3D !!read)
 				return LOCK_STATE_HELD;
=20
 			return LOCK_STATE_NOT_HELD;
