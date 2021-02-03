Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85B30E627
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhBCWi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 17:38:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232201AbhBCWiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:38:52 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2533364D99;
        Wed,  3 Feb 2021 22:38:10 +0000 (UTC)
Date:   Wed, 3 Feb 2021 17:38:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        john.ogness@linutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        akinobu.mita@gmail.com
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks
 all addresses as unhashed
Message-ID: <20210203173808.03737e03@gandalf.local.home>
In-Reply-To: <a6556624-71d5-e689-5273-693c69c77c9e@kernel.org>
References: <20210202213633.755469-1-timur@kernel.org>
        <YBpyzxBYIYapHaDT@alley>
        <YBqlooegQgEfPG4T@alley>
        <19c1c17e-d0b3-326e-97ec-a4ec1ebee749@kernel.org>
        <202102031201.FFED9547D@keescook>
        <20210203152513.34492916@gandalf.local.home>
        <202102031234.9BF349F@keescook>
        <20210203154727.20946539@gandalf.local.home>
        <a6556624-71d5-e689-5273-693c69c77c9e@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 15:56:20 -0600
Timur Tabi <timur@kernel.org> wrote:

> On 2/3/21 2:47 PM, Steven Rostedt wrote:
> >   static void __init
> >   plain(void)
> >   {
> >   	int err;
> >   
> > +	if (debug_never_hash_pointers)
> > +		return;  
> 
> So, I have a stupid question.  What's the best way for test_printf.c to 
> read the command line parameter?  Should I just do this in vsprintf.c:
> 
> /* Disable pointer hashing if requested */
> static bool debug_never_hash_pointers __ro_after_init;

It wont be static.

> EXPORT_SYMBOL_GPL(debug_never_hash_pointers);
> 
> I'm not crazy about exporting this variable to other drivers.  It could 
> be used to disable hashing by any driver.

But it is set as "__ro_after_init". That is, every module will see it as
read only. IOW, they wont be able to modify it.

> 
> AFAIK, the only command-line parameter code that works in drivers is 
> module_parm, and that expects the module prefix on the command-line.

This is just a constant variable for others to see. The command line itself
is visible (see saved_command_line, it's even exported to modules in sparc).


-- Steve
