Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54108358DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhDHTp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232023AbhDHTp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:45:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9B56610A8;
        Thu,  8 Apr 2021 19:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617911116;
        bh=RrmzvQvr9qsH3jQil+l3BlSa+r14J4WBjmTltJs0MTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZK1uIC6/MYW9cRl+UF7tk55XF4E/3KyWwF/eTlbeFxvtJUWa3mFut+kBSNmu4JV/n
         vHWWsCawZqvAOk0vXhXrsr23Ot4xa+UgRxPRqsBFZHfJ4Y9RILkB79E8hSzWW1344s
         /esEmdjSatMPXKexuGxNmnl4DlOf79xGDTZSMynliA/2XJlkT44+WQB1QTMsOUEBeg
         V5V/b/LWW+6smCMyszPDRJrb5VzFoH8CX+3FI4jF7Vhi710/1uoouSPz9NSDrgiKJ7
         bZEvGs7wFYdef/fwbNVeySzqjEENhSgHTKGCwbnGzZFW9SN4JVHjEuH9vdmh4+qKv1
         UoPf8UvG5Mszw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jian Cai <jiancai@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christopher Di Bella <cjdb@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] block: Disable -Walign-mismatch for blk-mq.c
Date:   Thu,  8 Apr 2021 12:44:58 -0700
Message-Id: <20210408194458.501617-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210408181210.u7cudatr7zcmbmb2@archlinux-ax161>
References: <20210408181210.u7cudatr7zcmbmb2@archlinux-ax161>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM 13 adds a new warning, -Walign-mismatch, which has an instance in
blk_mq_complete_send_ipi():

block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to
32-byte aligned parameter 2 of 'smp_call_function_single_async' may
result in an unaligned pointer access [-Walign-mismatch]
                smp_call_function_single_async(cpu, &rq->csd);
                                                    ^
1 warning generated.

This is expected after commit 4ccafe032005 ("block: unalign
call_single_data in struct request"), which purposefully unaligned the
structure to save space. Given that there is no real alignment
requirement and there have been no reports of issues since that change,
it should be safe to disable the warning for this one translation unit.

Link: https://github.com/ClangBuiltLinux/linux/issues/1328
Link: https://lore.kernel.org/r/20210310182307.zzcbi5w5jrmveld4@archlinux-ax161/
Link: https://lore.kernel.org/r/20210330230249.709221-1-jiancai@google.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 block/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/Makefile b/block/Makefile
index 8d841f5f986f..d69ac0bd8e61 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o
 
+CFLAGS_blk-mq.o := $(call cc-disable-warning, align-mismatch)
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
 obj-$(CONFIG_BLK_DEV_BSG)	+= bsg.o

base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.31.1.189.g2e36527f23

