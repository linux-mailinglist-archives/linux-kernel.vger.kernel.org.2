Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74603FE57D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbhIAWaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:30:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39638 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhIAWaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:30:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C48452251F;
        Wed,  1 Sep 2021 22:29:23 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2D8A13B03;
        Wed,  1 Sep 2021 22:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VhRiJ8D+L2FiJgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Wed, 01 Sep 2021 22:29:20 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        longman@redhat.com, bigeasy@linutronix.de, boqun.feng@gmail.com,
        dave@stgolabs.net, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] locking/rwbase_rt: Use wake_q for lockless reader waker
Date:   Wed,  1 Sep 2021 15:28:23 -0700
Message-Id: <20210901222825.6313-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch 1 does some necessary code reordering.

Patch 2 introduces wake_up_q_state() and converts rwbase_read_unlock()
slowpath to use wake_q instead of holding the wait_lock across the
entire wakeup.

I have tested equivalent changes in the preempt_rt kernel (v5.14.y-rt)
stressing mmap_sem, without anything falling out.

Thanks!

Davidlohr Bueso (2):
  sched: Move wake_q code below try_to_wake_up()
  locking/rwbase_rt: Lockless reader waking up a writer

 kernel/locking/rwbase_rt.c |   4 +-
 kernel/sched/core.c        | 182 +++++++++++++++++++------------------
 2 files changed, 99 insertions(+), 87 deletions(-)

--
2.26.2

