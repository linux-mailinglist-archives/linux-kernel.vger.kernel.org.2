Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316734074B5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 04:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhIKCkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 22:40:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60718 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbhIKCkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 22:40:51 -0400
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18B2db11057752;
        Sat, 11 Sep 2021 11:39:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sat, 11 Sep 2021 11:39:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18B2dash057749
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 11 Sep 2021 11:39:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
To:     Xiaoming Ni <nixiaoming@huawei.com>
References: <20210214161348.369023-1-timur@kernel.org>
 <20210214161348.369023-4-timur@kernel.org>
 <467a3c3c-8a52-9a74-c77f-bcb51b03d603@huawei.com>
Cc:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5f622c8a-0ada-b516-692c-85414cdc8384@i-love.sakura.ne.jp>
Date:   Sat, 11 Sep 2021 11:39:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <467a3c3c-8a52-9a74-c77f-bcb51b03d603@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/09/11 11:25, Xiaoming Ni wrote:
> Why do we need to export the no_hash_pointers variable and
> not declare it in any header file?

Because lib/test_printf.c wants to use no_hash_pointers for testing
purpose, and lib/test_printf.c might be built as a loadable kernel module.
That is, no_hash_pointers is not meant for general use.

  config TEST_PRINTF
  	tristate "Test printf() family of functions at runtime"

  obj-$(CONFIG_TEST_PRINTF) += test_printf.o

