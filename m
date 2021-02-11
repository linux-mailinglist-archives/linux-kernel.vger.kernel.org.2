Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7470319231
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhBKSZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:25:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231866AbhBKSRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:17:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DD4764E5F;
        Thu, 11 Feb 2021 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613067418;
        bh=a9Mage+YDe1nKc3ePEl7r91KB9eDjlkq0mBjRYUgY7Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MGYKNQBRn+TnI7ZLBVEERLlb/VuyR4+19I141SQ4UHwoe8Ibml0lrpZYdUT8CNwqU
         IuEXpq/g6ui86KXEdSLX7ORPuV9DDI9yDHer/ioujj4ftQNAGaKE5CTwUBI12S54KQ
         PGhq5XDqi1PIcbWb//k7XAfu8KYc8IKb4Mcibk6FaW3nMCAdhbficNqJrULLCQRiiR
         rtFMSE10Iyban/U7OAPBOdSn8Lk4LtIR3ra7LbIBpemVtfi1NjhJkjR9NivfmwpqDG
         nW3IdU4oaDtj2rOU9Cqd44nLKXmUTgrFai1sT051jVAR8NopOBGYQhC+tvqmrK9bEb
         GfYg9W6yd7mcg==
Subject: Re: [PATCH 3/3] [v3] lib/vsprintf: debug_never_hash_pointers prints
 all addresses as unhashed
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210210213453.1504219-1-timur@kernel.org>
 <20210210213453.1504219-4-timur@kernel.org> <YCVvB7skjoN18HKO@alley>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <4a233bef-8ba6-82bb-9075-35793a244a3b@kernel.org>
Date:   Thu, 11 Feb 2021 12:16:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCVvB7skjoN18HKO@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/21 11:53 AM, Petr Mladek wrote:
> I would really like to make it clear here that it is not only about
> consoles. Most people will see only this message. Only few people read
> documentation. Many people will learn the parameter name from another
> context by googling.
> 
> I know that it is not easy to find good words. Especially because
> pointers printed by %pK might still be hashed.
> 
>> +	pr_warn("**                                                      **\n");
>> +	pr_warn("** Kernel memory addresses are exposed, which may       **\n");
>> +	pr_warn("** reduce the security of your system.                  **\n");

> What about replacing the first two paragraphs with something like:
> 
> "This system shows unhashed kernel memory addresses via logs and
>   other interfaces. It might reduce the security of your system."

That works, thanks.  I'll post a v4 soon.
