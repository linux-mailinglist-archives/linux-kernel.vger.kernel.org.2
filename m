Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825433FDD80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbhIANyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:54:31 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60947 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244678AbhIANyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:54:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jnwang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Umw3NGj_1630504405;
Received: from B-VE2WML7H-1820.local(mailfrom:jnwang@linux.alibaba.com fp:SMTPD_---0Umw3NGj_1630504405)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Sep 2021 21:53:26 +0800
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
 <e66f501a-0ba9-77f1-b5a2-9a759f8e00d6@linux.alibaba.com>
 <YS5CPGm4JENsFIem@alley>
 <e670c6c0-dd24-bb26-a78f-e8cac10970eb@linux.alibaba.com>
 <YS9okbiLzBflOBsl@alley>
From:   James Wang <jnwang@linux.alibaba.com>
Message-ID: <bcd267ac-f9b7-e9a6-39d8-fbef03617dde@linux.alibaba.com>
Date:   Wed, 1 Sep 2021 21:53:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YS9okbiLzBflOBsl@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/9/1 PM7:48, Petr Mladek 写道:
> The official way to hide kernel messages is using "quiet" or
> "loglevel=1" kernel parameters.

“quiet" will block kernel logo, right?

I want kernel logo keep in screen.


James

