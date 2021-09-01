Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB07E3FE5EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhIAXE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 19:04:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43516 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhIAXE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:04:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BEE8522574;
        Wed,  1 Sep 2021 23:03:28 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7367913B2A;
        Wed,  1 Sep 2021 23:03:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1jXID74GMGEiLgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Wed, 01 Sep 2021 23:03:26 +0000
Date:   Wed, 1 Sep 2021 16:03:20 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        longman@redhat.com, bigeasy@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] locking/rwbase_rt: Lockless reader waking up a writer
Message-ID: <20210901230320.3pogmlyzfgwpvw77@offworld>
References: <20210901222825.6313-1-dave@stgolabs.net>
 <20210901222825.6313-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210901222825.6313-3-dave@stgolabs.net>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Sep 2021, Bueso wrote:

>As with the rest of our sleeping locks, use a wake_q to
>allow waking up the writer without having to hold the
>wait_lock across the operation. While this is ideally
>for batching wakeups, single wakeup usage as still shown
>to be beneficial vs the cost of try_to_wakeup when the
>lock is contended.
>
>Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>---
> kernel/locking/rwbase_rt.c |  4 +++-
> kernel/sched/core.c        | 16 +++++++++++++---

Bleh, this of course is missing:

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 06cd8fb2f409..695efd987b56 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -62,5 +62,6 @@ static inline bool wake_q_empty(struct wake_q_head *head)
  extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
  extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
  extern void wake_up_q(struct wake_q_head *head);
+extern void wake_up_q_state(struct wake_q_head *head, unsigned int state);
  
  #endif /* _LINUX_SCHED_WAKE_Q_H */
