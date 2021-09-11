Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E188940786A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhIKNwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:52:19 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:58241 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhIKNwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:52:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uo-HHX6_1631368260;
Received: from localhost(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uo-HHX6_1631368260)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Sep 2021 21:51:03 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     yinan@linux.alibaba.com, rostedt@goodmis.org,
        mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ftrace: improve ftrace during compiling
Date:   Sat, 11 Sep 2021 21:50:41 +0800
Message-Id: <20210911135043.16014-1-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Some business scenarios require the kernel to start as quickly as possible, 
so recently we are optimizing some processing during the kernel startup phase.
When the kernel is started, ftrace_init() takes 15-20ms to execute. Almost 
all of the overhead belongs to the sorting and replacement of nop instructions, 
and other processing only accounts for about 300us. Advance the processing of 
these two parts to the compile time, and the time saved is very important 
for certain scenarios, such as the quick start of containers.

Yinan Liu (2):
  scripts: ftrace - move the sort-processing in ftrace_init to compile time
  scripts: ftrace - move the nop-processing in ftrace_init to compile time

 kernel/trace/ftrace.c   |   9 +++-
 scripts/link-vmlinux.sh |   6 +--
 scripts/recordmcount.h  |  14 +++++++
 scripts/sorttable.c     |   2 +
 scripts/sorttable.h     | 109 +++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 133 insertions(+), 7 deletions(-)

-- 
2.14.4.44.g2045bb6
+++++++++++++++++++++++++++++++++++++++++++++++-
