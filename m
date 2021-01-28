Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B47B307E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhA1Swa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:52:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232277AbhA1SqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611859487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HV1Cd2GAYL3YVJKz7VTb2JdclTZr2f8HSqd8bbOX5co=;
        b=QF27USlLIiUVpFAfLiCGK+glDcK133kjBYYPnuBXYmw3YOeb905sFgcv1UrbhqG1jgARO0
        VwzxhEKkMW9bbMrdPvyPzN17CARgvbKTEOagnkIZBoRTCCiFKGKVl5a8ixZTTiPq9LhxfK
        P4QcdB+bch+OSI3ajmgoqRYR3yOYoqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-3wO9Fin1OB6ZL0kJR1_Lgg-1; Thu, 28 Jan 2021 13:44:45 -0500
X-MC-Unique: 3wO9Fin1OB6ZL0kJR1_Lgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE41A10054FF;
        Thu, 28 Jan 2021 18:44:42 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D2975D9EF;
        Thu, 28 Jan 2021 18:44:42 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id E721F4178901; Thu, 28 Jan 2021 15:44:20 -0300 (-03)
Message-ID: <20210128184346.781151254@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 28 Jan 2021 15:40:50 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 2/3] nohz: change signal tick dependency to wakeup CPUs of member tasks
References: <20210128184048.287626221@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than waking up all nohz_full CPUs on the system, only wakeup 
the target CPUs of member threads of the signal.

Reduces interruptions to nohz_full CPUs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -446,7 +446,17 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_ta
  */
 void tick_nohz_dep_set_signal(struct signal_struct *sig, enum tick_dep_bits bit)
 {
-	tick_nohz_dep_set_all(&sig->tick_dep_mask, bit);
+	int prev;
+
+	prev = atomic_fetch_or(BIT(bit), &sig->tick_dep_mask);
+	if (!prev) {
+		struct task_struct *t;
+
+		rcu_read_lock();
+		__for_each_thread(sig, t)
+			tick_nohz_kick_task(t);
+		rcu_read_unlock();
+	}
 }
 
 void tick_nohz_dep_clear_signal(struct signal_struct *sig, enum tick_dep_bits bit)


