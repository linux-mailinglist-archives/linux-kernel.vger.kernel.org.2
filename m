Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3463A2D14
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhFJNc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:32:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40078 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhFJNc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:32:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 18CF421996;
        Thu, 10 Jun 2021 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623331860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EgJC45Dypvp92B1Ue8sTD50N06sDV0MZrg+QBunGi30=;
        b=q0MaF8Z9GMMrSUwqI+mhwH+Jlw9PwRamEyTXv/+vt8RrPEW3icKsik9ABSqVWqljMWjtEX
        xOqWt1pvDP7taIOe/D6sHtw2gy5GOyHTWdo8Z5gI1dMeIkTRRG1bOSKrZRG//NnMEGf160
        zgGdxg1mU/pkwyjWsPGtZdIPl/XznOQ=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id C36CAA3B8A;
        Thu, 10 Jun 2021 13:30:59 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Martin Liu <liumartin@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tejun Heo <tj@kernel.org>, minchan@google.com,
        davidchao@google.com, jenhaochen@google.com,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/3] kthread_worker: Fix race between kthread_mod_delayed_work() and kthread_cancel_delayed_work_sync()
Date:   Thu, 10 Jun 2021 15:30:48 +0200
Message-Id: <20210610133051.15337-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the race between kthread_mod_delayed_work() and
kthread_cancel_delayed_work_sync() including proper return value
handling.

The original fix, from Martin Liu [1], opened discussion [2] about
the return value. It took me some time to realize that the original
patch was not a correct fix.

The problem is that the return value might be used for reference counting
of the queued works. The return value is boolean. It could distinguish
only two situations where the work is:

    + newly queued => inc(refcnt)                   (ret == false)
    + was queued, removed, added => nope(refcntn)   (ret == true)

The original fix, introduced another situation:

    + was queued, removed => dec(refcnt)   (ret == ???)

The proper solution is to remove the work from the list only when
it can be added again. Fortunately, it can be fixed relatively
easily. I have split it into 3 small steps.

[1] https://lore.kernel.org/r/20210513065458.941403-1-liumartin@google.com
[2] https://lore.kernel.org/r/20210520214737.MrGGKbPrJ%akpm@linux-foundation.org


Petr Mladek (3):
  kthread_worker: Split code for canceling the delayed work timer.
  kthread: Prevent deadlock when kthread_mod_delayed_work() races with
    kthread_cancel_delayed_work_sync()
  kthread_worker: Fix return value when kthread_mod_delayed_work() races
    with kthread_cancel_delayed_work_sync()

 kernel/kthread.c | 96 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 33 deletions(-)

-- 
2.26.2

