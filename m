Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA2D30E54F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhBCV51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232430AbhBCV5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:57:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64C3364D90;
        Wed,  3 Feb 2021 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612389383;
        bh=KlqMz0AxDAOewwpGjJMp9MSlBYUAqgp9ZkKxph73xJk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hsz8CLyqqjck4bzLjA1rUO2vj3NHLNp+ADj16T6Jv3rjoLQKWc013iaR9ISh+glcF
         w75zcKGZKpk5/9M/8/fVJnvADPEO5j4+ffFLS1MK0ybu/tmBP1jCQFlGEfx1dg/T2z
         S1Yl25qfwaKMKe21n16App3VbJcx7MQrfoq6BBjlEJjCmQz8LZGH4K/soSlaHW0V/i
         imM7AdA9HHCCGjOpwOtTd9wB4SQsqfXxvCuBKLOV/FAwHnlPIQIHrl0oFq+g/rWE6F
         MKqHJNqZpXvur1adiaMWcQjHmO8OiLS93PQAmQThBB8Ba8XIE2wkqtqm+j8MJUDg8W
         JtbU9LOyyJfFA==
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
To:     Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        john.ogness@linutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        akinobu.mita@gmail.com
References: <20210202213633.755469-1-timur@kernel.org>
 <YBpyzxBYIYapHaDT@alley> <YBqlooegQgEfPG4T@alley>
 <19c1c17e-d0b3-326e-97ec-a4ec1ebee749@kernel.org>
 <202102031201.FFED9547D@keescook>
 <20210203152513.34492916@gandalf.local.home> <202102031234.9BF349F@keescook>
 <20210203154727.20946539@gandalf.local.home>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <a6556624-71d5-e689-5273-693c69c77c9e@kernel.org>
Date:   Wed, 3 Feb 2021 15:56:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210203154727.20946539@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/21 2:47 PM, Steven Rostedt wrote:
>   static void __init
>   plain(void)
>   {
>   	int err;
>   
> +	if (debug_never_hash_pointers)
> +		return;

So, I have a stupid question.  What's the best way for test_printf.c to 
read the command line parameter?  Should I just do this in vsprintf.c:

/* Disable pointer hashing if requested */
static bool debug_never_hash_pointers __ro_after_init;
EXPORT_SYMBOL_GPL(debug_never_hash_pointers);

I'm not crazy about exporting this variable to other drivers.  It could 
be used to disable hashing by any driver.

AFAIK, the only command-line parameter code that works in drivers is 
module_parm, and that expects the module prefix on the command-line.
