Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715D3316C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBJRIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:08:40 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61123 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhBJRIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:08:10 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11AH7QGZ037842;
        Thu, 11 Feb 2021 02:07:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Thu, 11 Feb 2021 02:07:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11AH7QoT037837
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Feb 2021 02:07:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/3][RESEND] add support for never printing hashed
 addresses
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
 <20210210114633.1b755f6e@gandalf.local.home>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <cd421230-f6cd-fb79-64ad-d029bcee7b4e@i-love.sakura.ne.jp>
Date:   Thu, 11 Feb 2021 02:07:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210114633.1b755f6e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/02/11 1:46, Steven Rostedt wrote:
> On Thu, 11 Feb 2021 01:39:41 +0900
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> 
>> On 2021/02/11 1:18, Steven Rostedt wrote:
>>> The point of this exercise is to be able to debug the *same* kernel that
>>> someone is having issues with. And this is to facilitate that debugging.  
>>
>> That's too difficult to use. If a problem is not reproducible, we will have
>> no choice but always specify "never hash pointers" command line option. If a
>> problem is reproducible, we can rebuild that kernel with "never hash pointers"
>> config option turned on.
> 
> Now the question is, why do you need the unhashed pointer?

Because unhashed pointers might give some clue. We can rebuild the same kernel
using the same kernel config / compiler etc. and compare unhashed pointers with
addresses in System.map / kallsyms files without reproducing the problem.

> 
> Currently, the instruction pointer is what is fine right? You get the
> a function and its offset. If there's something that is needed, perhaps we
> should look at how to fix that, instead of just unhashing all pointers by
> default.

I'm not refusing to use kernel command line options. I'm expecting that we can
also hardcode using kernel config options. Since boot-time switching via kernel
command line options makes the kernel behave differently, less boot-time
switching is better for avoiding unexpected problems (e.g. unintended LSM was
enabled).

