Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACF4460F01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 07:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhK2G5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 01:57:46 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:58376 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230022AbhK2Gzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 01:55:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uyd1hns_1638168743;
Received: from 30.240.100.24(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uyd1hns_1638168743)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Nov 2021 14:52:24 +0800
Message-ID: <26487f6c-564e-33a9-f0ae-72d768aafa58@linux.alibaba.com>
Date:   Mon, 29 Nov 2021 14:52:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v4] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211123105404.22166-1-yinan@linux.alibaba.com>
 <20211123105404.22166-2-yinan@linux.alibaba.com>
 <eb65291b-edc3-6968-46a9-fc7e5ac48adb@linux.alibaba.com>
 <20211128225133.65e7c8de@oasis.local.home>
From:   Yinan Liu <yinan@linux.alibaba.com>
In-Reply-To: <20211128225133.65e7c8de@oasis.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/11/29 上午11:51, Steven Rostedt 写道:
> On Mon, 29 Nov 2021 10:13:23 +0800
> Yinan Liu <yinan@linux.alibaba.com> wrote:
> 
>> Is there anything wrong with this patch? Or are you too busy
>> to review? Let me make sure that it has not been forgotten.
> 
> FYI, last week had a major US holiday, and things get a bit busy,
> before hand.
>
> I haven't had time to look at it, but will try to this week or next.
> 

Get it. THX!

cheers～

-- Yinan Liu
