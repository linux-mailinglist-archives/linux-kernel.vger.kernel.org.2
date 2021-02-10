Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75197316C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhBJRW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232312AbhBJRWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:22:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5C2A64EBC;
        Wed, 10 Feb 2021 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612977716;
        bh=lxipoW35mWSIBNIGbM7Z2K+aGwYJwr9dKY4OANlak7k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GGr4C1jJH4Zp9a/mEIU72UybzoYaT9/TIZxXNQmm5bAT/zvaeeSglDED9fUewnpO7
         BrYrmiMW+g9SlVPVQksfYgQAbIVF0MTKkmMfi6NjxV87X1h2j8kZIMaBemRGPmn7+4
         ZC1DyPS/e74GCSezb1hpd4YqPlSuerNNkhZdoLgis7oXUugfa5Lp86K7MOaToF8nkY
         Euzi9bVksgdHYqKG+3cp+jI3MXdlyDiTu6Or/oIdGHWPIOg5OUhFyWq1Z574CStmXU
         /Sq0uns4Ac01xgy0nc3+py4R0tedjVGEpLlH/raD2rf/eJctQlOCrCNFZzIHi93eN+
         0gsZ67yEPIsbw==
Subject: Re: [PATCH 0/3][RESEND] add support for never printing hashed
 addresses
To:     Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
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
From:   Timur Tabi <timur@kernel.org>
Message-ID: <bfb425fb-0254-c1e3-62b3-d55a7cbb46ae@kernel.org>
Date:   Wed, 10 Feb 2021 11:21:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210114633.1b755f6e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/21 10:46 AM, Steven Rostedt wrote:
> Now the question is, why do you need the unhashed pointer?
> 
> Currently, the instruction pointer is what is fine right? You get the
> a function and its offset. If there's something that is needed, perhaps we
> should look at how to fix that, instead of just unhashing all pointers by
> default.

The original version of this patch only fixed print_hex_dump(), because 
hashed addresses didn't make any sense for that.  Each address is 
incremented by 16 or 32, but since they were all hashed, they may as 
well have been random numbers.
