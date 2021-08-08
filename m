Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D884A3E3CC3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 22:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhHHUlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 16:41:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53060 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhHHUln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 16:41:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E4CD1FD35;
        Sun,  8 Aug 2021 20:41:23 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3055A13310;
        Sun,  8 Aug 2021 20:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1BJPN29BEGH9NQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Sun, 08 Aug 2021 20:41:19 +0000
Date:   Sun, 8 Aug 2021 13:41:16 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V3 15/64] rtmutex: Provide rt_mutex_base_is_locked()
Message-ID: <20210808204116.rckeqq7hu4ofbitg@offworld>
References: <20210805151300.330412127@linutronix.de>
 <20210805153953.683678014@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210805153953.683678014@linutronix.de>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>+/**
>+ * rt_mutex_base_is_locked - is the rtmutex locked
>+ * @lock: the mutex to be queried
>+ *
>+ * Returns true if the mutex is locked, false if unlocked.
>+ */
>+static inline bool rt_mutex_base_is_locked(struct rt_mutex_base *lock)
>+{
>+	return lock->owner != NULL;

Does this want to be READ_ONCE()? While not a big deal because
it's ultimately only used by drm debugging, I don't see any harm
in avoiding potential tearing.

Thanks,
Davidlohr
