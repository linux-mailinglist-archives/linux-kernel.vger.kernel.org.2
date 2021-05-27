Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF25392A47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhE0JNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:13:02 -0400
Received: from foss.arm.com ([217.140.110.172]:54480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhE0JNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:13:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE2DD13A1;
        Thu, 27 May 2021 02:11:27 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 045E63F73D;
        Thu, 27 May 2021 02:11:25 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: Fix debugfs_read_file_str()
Date:   Thu, 27 May 2021 11:11:05 +0200
Message-Id: <20210527091105.258457-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the entire size of the buffer, including the trailing new line
character.
Discovered while reading the sched domain names of CPU0:

before:

cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
SMTMCDIE

after:

cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
SMT
MC
DIE

Fixes: 9af0440ec86eb ("debugfs: Implement debugfs_create_str()")
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 fs/debugfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index e813acfaa6e8..ba7c01cd9a5d 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -893,7 +893,7 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 
 	copy[copy_len] = '\n';
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, copy, copy_len);
+	ret = simple_read_from_buffer(user_buf, count, ppos, copy, len);
 	kfree(copy);
 
 	return ret;
-- 
2.25.1

