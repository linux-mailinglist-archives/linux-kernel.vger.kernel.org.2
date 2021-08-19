Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D763F1F61
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhHSRvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:51:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57742 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHSRvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:51:18 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C83122144;
        Thu, 19 Aug 2021 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629395441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jAS4YOSs/Qhzw7Dj7vxV4dRXUqwtGbcxDiszG8vKWP8=;
        b=JoVwIWwiWVQtEBK5FKWYqOtsJD1WkBAJJFrLfPnAhhHVgl87ZQ5eoU7l9Ki14Zbi5hu6ef
        cqV5bCj/qSa4ybKpmHfw5ib/SYRuWegmEuzsUC59KtQAOlMs1GTA4/MbZymQ2tODf2WawS
        TxjCxfqtsFM5bunOF4ZXPDkNTolSLTk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DE9CC13AAE;
        Thu, 19 Aug 2021 17:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Z4E6NfCZHmHnOQAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Thu, 19 Aug 2021 17:50:40 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [RFC PATCH v2 0/5] leaf_cfs_rq_list cleanups and fix
Date:   Thu, 19 Aug 2021 19:50:29 +0200
Message-Id: <20210819175034.4577-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is an extension of the simplification patch posted previously. The
original goal was to make the code a bit more readable but I noticed a
bug meanwhile and included it in the series.

Reason for RFC:
- I noticed an asymmetry in update_cfs_group(se) calls between
  unthrottle_cfs_rq() and enqueue_task_fair(), not sure if the omission
  is warranted. It's marked XXX in the patch "sched/fair: Simplify
  ancestor enqueue loops"

Patch 1
- fix of load_cfs_rq_list handling

Patches 2, 3
- just (re)naming things

Patch 4, 5
- simplifications of load_cfs_rq_list and ancestor processing loops
- no functional changes intended



RFC v1:
https://lore.kernel.org/r/20210225162757.48858-1-mkoutny@suse.com

Michal Koutný (5):
  sched/fair: Add ancestors of unthrottled undecayed cfs_rq
  sched: Add group_se() helper
  sched/fair: Rename leaf_list to more fitting load_list
  sched/fair: Simplify load_cfs_rq_list maintenance
  sched/fair: Simplify ancestor enqueue loops

 kernel/sched/core.c  |   4 +-
 kernel/sched/fair.c  | 220 +++++++++++++++++--------------------------
 kernel/sched/sched.h |  25 ++---
 3 files changed, 104 insertions(+), 145 deletions(-)

-- 
2.32.0

