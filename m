Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D742452813
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 03:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbhKPCyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 21:54:39 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52090 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379137AbhKPCwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 21:52:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uwmflza_1637030986;
Received: from localhost.localdomain(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uwmflza_1637030986)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 10:49:47 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ftrace optimization at compile time
Date:   Tue, 16 Nov 2021 10:49:40 +0800
Message-Id: <20211116024942.60644-1-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210911135043.16014-1-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Steven
  
This is my V2 patch. If you haven't reviewed patch V1 yet,
just review this one. Thank you.

Yinan Liu (2):
  scripts: ftrace - move the sort-processing in ftrace_init to compile
    time
  scripts: ftrace - move the nop-processing in ftrace_init to compile
    time

 kernel/trace/ftrace.c   |  12 +++++-
 scripts/link-vmlinux.sh |   6 +--
 scripts/recordmcount.h  |  14 +++++++
 scripts/sorttable.c     |   2 +
 scripts/sorttable.h     | 109 +++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 136 insertions(+), 7 deletions(-)

-- 
2.14.4.44.g2045bb6

