Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C8316D09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhBJRmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:42:37 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62870 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhBJRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:42:18 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11AHfZjc062357;
        Thu, 11 Feb 2021 02:41:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Thu, 11 Feb 2021 02:41:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11AHfZVx062313
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Feb 2021 02:41:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/3][RESEND] add support for never printing hashed
 addresses
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210210051814.845713-1-timur@kernel.org>
 <6da0be5a-7cb0-4943-e61f-7c3275e60cb6@i-love.sakura.ne.jp>
 <20210210111836.2468f10a@gandalf.local.home>
 <e996ff2f-d350-1399-bb6b-8373bf70e687@i-love.sakura.ne.jp>
 <YCQPs9qg8dbSOh0S@smile.fi.intel.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <af2488cc-f2e1-533e-0e42-457d756fb5d9@i-love.sakura.ne.jp>
Date:   Thu, 11 Feb 2021 02:41:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCQPs9qg8dbSOh0S@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/02/11 1:54, Andy Shevchenko wrote:
> On Thu, Feb 11, 2021 at 01:39:41AM +0900, Tetsuo Handa wrote:
>> On 2021/02/11 1:18, Steven Rostedt wrote:
>>> The point of this exercise is to be able to debug the *same* kernel that
>>> someone is having issues with. And this is to facilitate that debugging.
>>
>> That's too difficult to use. If a problem is not reproducible, we will have
>> no choice but always specify "never hash pointers" command line option. If a
>> problem is reproducible, we can rebuild that kernel with "never hash pointers"
>> config option turned on.
> 
> I think what you are targeting is something like dynamic debug approach where
> you can choose which prints to enable/disable and what enable/disable in them.

What I'm targeting is "zero interaction from kernel command line options" like
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/usbip?id=f1bdf414e7dd0cbc26460425719fc3ea479947a2 .

> 
> In that case you specifically apply a command line option and enable only files
> / lines in the files.

While there is boot-config feature for specifying very long kernel command line
options, I can't enforce syzkaller users (including syzbot) to switch what to
enable/disable via kernel command line options. Let alone defining a kernel
command line option for single-purpose debug printk() changes like shown above.

