Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684A230E2F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhBCS72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:59:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhBCS7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:59:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7F9D64F61;
        Wed,  3 Feb 2021 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612378723;
        bh=PEYBOm0OePsiPNwQdE6LWS8QVtji2a0NydsNbpbrheA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YrCJmRIfdfesjuEHIh5wXyFNyprTKwZEUK2NZM3r7LKXVCvzPSc7wSM+DLKbKaxtX
         MceRUV9/p8f6dyB7mdkb4fkf3qMINUAbnDrDMi7FIphV8WGp80jdCmMhdvtnU6mZik
         49DbSe2IktGSDlgN6JRay37YcYdljSAQmXBidcRXQ5EjgRfAacXUaqiIxGfxXM5/Qv
         SQtuNB+rSMR8lvT9rdKx3QuVzifwMV4zxWKf70H77igztHVB8NllFInGH1SzyW7X95
         yJkFTbsLrTBaDD5ABNwqT7q2BBbKj1vDQj7e9xhLFiPHMNvXLaYMIVNYhBl6vbgxTn
         W8tVELKgU/h/A==
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        akinobu.mita@gmail.com
References: <20210202213633.755469-1-timur@kernel.org>
 <YBpyzxBYIYapHaDT@alley> <YBqlooegQgEfPG4T@alley>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <19c1c17e-d0b3-326e-97ec-a4ec1ebee749@kernel.org>
Date:   Wed, 3 Feb 2021 12:58:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBqlooegQgEfPG4T@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 7:31 AM, Petr Mladek wrote:
> Also please make sure that lib/test_printf.c will work with
> the new option.

As you suspected, it doesn't work:

[  206.966478] test_printf: loaded.
[  206.966528] test_printf: plain 'p' does not appear to be hashed
[  206.966740] test_printf: failed 1 out of 388 tests

What should I do about this?

On one hand, it is working as expected: %p is not hashed, and that 
should be a warning.

On the other hand, maybe test_printf should be aware of the command line 
parameter and test to make sure that %p is NOT hashed?
