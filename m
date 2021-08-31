Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFAC3FC9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbhHaOjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:39:47 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57106 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237410AbhHaOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:39:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jnwang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UmloMMs_1630420722;
Received: from B-VE2WML7H-1820.local(mailfrom:jnwang@linux.alibaba.com fp:SMTPD_---0UmloMMs_1630420722)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 Aug 2021 22:38:43 +0800
Subject: Re: kernel hang during reboot when cmdline include a non-exist
 console device
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com>
 <YS2fZ1sknFYKtJFi@google.com> <YS3k5TRf5oLLEdKu@alley>
 <YS3stL0cTn5ZQSNx@google.com>
 <fc18d17a-b185-7a1e-2135-ec83f3f8c70f@linux.alibaba.com>
 <YS490P27YM6UlB2z@alley>
From:   James Wang <jnwang@linux.alibaba.com>
Message-ID: <e66f501a-0ba9-77f1-b5a2-9a759f8e00d6@linux.alibaba.com>
Date:   Tue, 31 Aug 2021 22:38:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YS490P27YM6UlB2z@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/31 PM10:33, Petr Mladek 写道:
> On Tue 2021-08-31 21:45:05, James Wang wrote:
>> 在 2021/8/31 PM4:47, Sergey Senozhatsky 写道:
>>> And may I ask, just in case, if James can revert a revert of Petr's commit:
>>>
>>>          revert a91bd6223ecd46addc71ee6fcd432206d39365d2
>>>
>>> boot with wrong console argument and see if the kernel reboots without
>>> any problems.
>> After test, revert Petr's commit can work; reboot without any problem;
> Interesting, it looks like the panic() is really caused by missing
> stdout, stdin, and stderr, for the init process.
>
> Unfortunately, the fix is not easy, as described in the commit
> a91bd6223ecd46addc71e ("Revert "init/console: Use ttynull as
> a fallback when there is no console").

OK. But I suppose you could find a quick workaround to mitigate this issue.


James

