Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A680410F47
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 07:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhITFWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 01:22:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50558 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhITFWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 01:22:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 016C61FFFF;
        Mon, 20 Sep 2021 05:20:39 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D61F13AC7;
        Mon, 20 Sep 2021 05:20:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J7epEyUaSGFsSwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 20 Sep 2021 05:20:37 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        longman@redhat.com, bigeasy@linutronix.de, boqun.feng@gmail.com,
        dave@stgolabs.net, linux-kernel@vger.kernel.org
Subject: [PATCH -tip 0/2] locking/rwbase: Two reader optimizations
Date:   Sun, 19 Sep 2021 22:20:29 -0700
Message-Id: <20210920052031.54220-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch 1 is a barrier optimization that came up from the reader
fastpath ordering auditing.

Patch 2 is a resend of the previous broken patch that attempts
to use wake_q for read_unlock() slowpath.

Tested on v5.15.y-rt. Applies against tip/urgent.

Thanks!

Davidlohr Bueso (2):
  locking/rwbase: Optimize rwbase_read_trylock
  locking/rwbase: Lockless reader waking up a writer

 kernel/locking/rtmutex.c   | 19 +++++++++++++------
 kernel/locking/rwbase_rt.c | 11 +++++++----
 2 files changed, 20 insertions(+), 10 deletions(-)

--
2.26.2

