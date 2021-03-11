Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2923133726C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhCKMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:22:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:39418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233313AbhCKMVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:21:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615465313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gFPPFFLt6yA5U8JKMg3q6g9x9pxQY7MKnHJ+J9g6+B0=;
        b=BWtJgfz+4pdpVw17Fghon2FhSXEa75Z8ZXoV10LBO6Dn+PweYaJO1Ue048B71fuoF2G1sj
        3M3GVYyYs5qdH4Ma0twg8pKBMc7LY1xwQv79D0WW/FTn4mU2bSAtKEtRudUBG9qKRsdLhi
        OgsZ1G4HqHb2NT3ChWpWuX+AJMTuFjc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 849C4AB8C;
        Thu, 11 Mar 2021 12:21:53 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 0/7] watchdog/softlockup: Report overall time and some cleanup
Date:   Thu, 11 Mar 2021 13:21:23 +0100
Message-Id: <20210311122130.6788-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending. The original post is [1].

I dug deep into the softlockup watchdog history when time permitted
this year. And reworked the patchset that fixed timestamps and
cleaned up the code[2].

I split it into very small steps and did even more code clean up.
The result looks quite strightforward and I am pretty confident
with the changes.

[1] v2: https://lore.kernel.org/r/20201210160038.31441-1-pmladek@suse.com
[2] v1: https://lore.kernel.org/r/20191024114928.15377-1-pmladek@suse.com

Petr Mladek (7):
  watchdog: Rename __touch_watchdog() to a better descriptive name
  watchdog: Explicitly update timestamp when reporting softlockup
  watchdog/softlockup: Report the overall time of softlockups
  watchdog/softlockup: Remove logic that tried to prevent repeated
    reports
  watchdog: Fix barriers when printing backtraces from all CPUs
  watchdog: Cleanup handling of false positives
  Test softlockup

 fs/proc/consoles.c |  5 +++
 fs/proc/version.c  |  7 ++++
 kernel/watchdog.c  | 97 ++++++++++++++++++++++++++--------------------
 3 files changed, 66 insertions(+), 43 deletions(-)

-- 
2.26.2

