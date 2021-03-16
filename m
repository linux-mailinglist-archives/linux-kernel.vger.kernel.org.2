Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9139E33D783
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhCPPc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237913AbhCPPcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615908720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=L+QUsDdj1cGfWtEiTZlWUvMjeY+cW2r5Q8JPqHBvK5g=;
        b=fvF0M70/HPOnRtJz5d/Cm59dOkKFAm9a2NZWExNsTtbfZKKINODhvVXvbrd5lE/x+XK47s
        RuzgvhdsTta5MNvDMThPsH4sdaoArVggEjKhGze7wI+848345ddX/2j18QzD2d1EBAlwNc
        3eRVh33pSj60csNqW8QF7YcduJCBdQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-qLK1jNPEPwOImw-Wr5hAlQ-1; Tue, 16 Mar 2021 11:31:58 -0400
X-MC-Unique: qLK1jNPEPwOImw-Wr5hAlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5741C3E74D;
        Tue, 16 Mar 2021 15:31:57 +0000 (UTC)
Received: from llong.com (ovpn-117-133.rdu2.redhat.com [10.10.117.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1A9219D61;
        Tue, 16 Mar 2021 15:31:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/4] locking/ww_mutex: Fix locktorture ww_mutex test problems
Date:   Tue, 16 Mar 2021 11:31:15 -0400
Message-Id: <20210316153119.13802-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that lockdep splat was produced whenever the ww_mutex
locktorture test was run on a kernel with lockdep enabled. It turns out
that there are bugs both in the ww_mutex and the locktorture code. This
patch series fix these bugs so that the ww_mutex locktorture test is
able to run without producing unexpected lockdep splat.

Patches 1 & 2 are clean-up patches for ww_mutex. Patch 3 fixes the lockdep
bug in ww_mutex and patch 4 fixes a bug in the locktorture code.

Waiman Long (4):
  locking/ww_mutex: Simplify use_ww_ctx & ww_ctx handling
  locking/ww_mutex: Fix acquire/release imbalance in
    ww_acquire_init()/ww_acquire_fini()
  locking/ww_mutex: Treat ww_mutex_lock() like a trylock
  locking/locktorture: Fix incorrect use of ww_acquire_ctx in ww_mutex
    test

 include/linux/ww_mutex.h     |  5 ++-
 kernel/locking/locktorture.c | 86 +++++++++++++++++++++++-------------
 kernel/locking/mutex.c       | 30 ++++++++-----
 3 files changed, 77 insertions(+), 44 deletions(-)

-- 
2.18.1

