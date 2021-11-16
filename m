Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5BE453257
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhKPMp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:45:29 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:34092 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232312AbhKPMp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:45:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UwsMn-._1637066548;
Received: from 30.240.105.70(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0UwsMn-._1637066548)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 20:42:29 +0800
Message-ID: <edb15f83-ddf9-ae48-6d1e-6ef7802e6f50@linux.alibaba.com>
Date:   Tue, 16 Nov 2021 20:42:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt@goodmis.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211116024942.60644-1-yinan@linux.alibaba.com>
 <20211116024942.60644-2-yinan@linux.alibaba.com>
 <20211116080730.GV174703@worktop.programming.kicks-ass.net>
From:   Yinan Liu <yinan@linux.alibaba.com>
In-Reply-To: <20211116080730.GV174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/11/16 下午4:07, Peter Zijlstra 写道:

> /me hands a bucket of {} your way. 

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6406,8 +6406,10 @@ static int ftrace_process_locs(struct module *mod,
         if (!count)
                 return 0;

-       sort(start, count, sizeof(*start),
-            ftrace_cmp_ips, NULL);
+       if (mod) {
+               sort(start, count, sizeof(*start),
+                    ftrace_cmp_ips, NULL);
+       }

hi，peter

you mean like this? I hope I'm not mistaken.


 > Also, can't sorttable be ran on modules ?

The .ko file will be relocated after insmod or modprobe.
And the mcount redirection in .ko is based on ".text",
".init.text", ".ref.text", ".sched.text", ".spinlock.text",
".irqentry .text", ".softirqentry.text", ".kprobes.text", 
".cpuidle.text", ".text.unlikely". These sections‘ loading
position are not in definite order.

So sorting this part at compile time doesn't make much sense.




Best regards!
--Yinan liu
