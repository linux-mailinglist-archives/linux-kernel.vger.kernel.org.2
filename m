Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE70B45A0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhKWK5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:57:16 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37501 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229924AbhKWK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:57:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UxvDTNN_1637664845;
Received: from localhost.localdomain(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0UxvDTNN_1637664845)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Nov 2021 18:54:06 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     rostedt@goodmis.org, peterz@infradead.org
Cc:     mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] ftrace sorting optimization changelog
Date:   Tue, 23 Nov 2021 18:54:03 +0800
Message-Id: <20211123105404.22166-1-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210911135043.16014-1-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a code alignment problem in patch v3 and 
modified it in patch v4. You can look directly at 
patch v4, cover-letter introduces the changes 
starting from patch v2.

v2 link:https://lore.kernel.org/all/20211116024942.60644-2-yinan@linux.alibaba.com/

v2--->v3(alignment problem)--->v4

Modified the code style issue of if() {} raised by Peter.

Fix the compilation error by changing the position of 
the relevant compilation options of pthread, which is 
reported by the robot.

The two tabs show differences in vim and git diff. 
In patch v3, the display in the patch is directly 
adjusted, resulting in misalignment of the format 
in the code. 
In patch v4, the alignment in the code is maintained, 
but the display in the patch looks very awkward, but 
this is just the display problem.Both are two tabs. 

Best regards!
-- Yinan Liu 

Yinan Liu (1):
  scripts: ftrace - move the sort-processing in ftrace_init to compile
    time

 kernel/trace/ftrace.c   |   6 ++-
 scripts/Makefile        |   2 +-
 scripts/link-vmlinux.sh |   6 +--
 scripts/sorttable.c     |   2 +
 scripts/sorttable.h     | 113 ++++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 119 insertions(+), 10 deletions(-)

-- 
1.8.3.1

