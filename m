Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB433D784
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhCPPcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237940AbhCPPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615908723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=wUQFOksDj/jKmRESP6u0KtBft7Vj0xNarOGRhwkBCGM=;
        b=jO6yhitZm2UHomgADwGECoIwvkc9JZc3ND0uGVqXbEquDC9fK24eMZ0Iv6DBGSDC5ifuLD
        zVl/M/OloEo9ZDwNDJp/EDrDwKtLC6STLsbpGUDDBN+KFee2oq42ir40qk1U9s8JkpzrYa
        RKBV4tATzAy8msmEOCxS7u4bpUj6o8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-2vGj_DYrMFiB5eX1AoX1Ng-1; Tue, 16 Mar 2021 11:32:01 -0400
X-MC-Unique: 2vGj_DYrMFiB5eX1AoX1Ng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04DD4107ACCA;
        Tue, 16 Mar 2021 15:32:00 +0000 (UTC)
Received: from llong.com (ovpn-117-133.rdu2.redhat.com [10.10.117.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D97B21992D;
        Tue, 16 Mar 2021 15:31:58 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/4] locking/ww_mutex: Fix acquire/release imbalance in ww_acquire_init()/ww_acquire_fini()
Date:   Tue, 16 Mar 2021 11:31:17 -0400
Message-Id: <20210316153119.13802-3-longman@redhat.com>
In-Reply-To: <20210316153119.13802-1-longman@redhat.com>
References: <20210316153119.13802-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ww_acquire_init(), mutex_acquire() is gated by CONFIG_DEBUG_LOCK_ALLOC.
The dep_map in the ww_acquire_ctx structure is also gated by the
same config. However mutex_release() in ww_acquire_fini() is gated by
CONFIG_DEBUG_MUTEXES. It is possible to set CONFIG_DEBUG_MUTEXES without
setting CONFIG_DEBUG_LOCK_ALLOC though it is an unlikely configuration.
That may cause a compilation error as dep_map isn't defined in this
case. Fix this potential problem by enclosing mutex_release() inside
CONFIG_DEBUG_LOCK_ALLOC.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/ww_mutex.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 850424e5d030..6ecf2a0220db 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -173,9 +173,10 @@ static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
  */
 static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
 	mutex_release(&ctx->dep_map, _THIS_IP_);
-
+#endif
+#ifdef CONFIG_DEBUG_MUTEXES
 	DEBUG_LOCKS_WARN_ON(ctx->acquired);
 	if (!IS_ENABLED(CONFIG_PROVE_LOCKING))
 		/*
-- 
2.18.1

