Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E5A460C94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 03:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhK2CSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 21:18:44 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33917 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231774AbhK2CQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 21:16:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uyb4swN_1638152004;
Received: from 30.240.100.24(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uyb4swN_1638152004)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Nov 2021 10:13:24 +0800
Message-ID: <eb65291b-edc3-6968-46a9-fc7e5ac48adb@linux.alibaba.com>
Date:   Mon, 29 Nov 2021 10:13:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v4] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     rostedt@goodmis.org, peterz@infradead.org
Cc:     mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211123105404.22166-1-yinan@linux.alibaba.com>
 <20211123105404.22166-2-yinan@linux.alibaba.com>
In-Reply-To: <20211123105404.22166-2-yinan@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/11/23 下午6:54, Yinan Liu 写道:
> When the kernel starts, the initialization of ftrace takes
> up a portion of the time (approximately 6~8ms) to sort mcount
> addresses. We can save this time by moving mcount-sorting to
> compile time.
> 
> Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> Reported-by: kernel test robot <lkp@intel.com>

Hi,

Is there anything wrong with this patch? Or are you too busy
to review? Let me make sure that it has not been forgotten.


Best regards!
-- Yinan Liu
