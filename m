Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F1630E43C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhBCUuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232389AbhBCUt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:49:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760A360234;
        Wed,  3 Feb 2021 20:47:29 +0000 (UTC)
Date:   Wed, 3 Feb 2021 15:47:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20210203154727.20946539@gandalf.local.home>
In-Reply-To: <202102031234.9BF349F@keescook>
References: <20210202213633.755469-1-timur@kernel.org>
        <YBpyzxBYIYapHaDT@alley>
        <YBqlooegQgEfPG4T@alley>
        <19c1c17e-d0b3-326e-97ec-a4ec1ebee749@kernel.org>
        <202102031201.FFED9547D@keescook>
        <20210203152513.34492916@gandalf.local.home>
        <202102031234.9BF349F@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 12:35:07 -0800
Kees Cook <keescook@chromium.org> wrote:

> > With a big notice that all pointers of unhashed, I don't think we need to
> > print it failed when we expect it to fail.
> > 
> > If anything, skip the test and state:
> > 
> >   test_printf: hash test skipped because "make-printk-non-secret" is on the
> >   command line.  
> 
> Yeah, I'm fine with "fail" or "skip". "pass" is mainly what I don't
> like. :)

Is there any printing of the tests being done? Looks to me that the tests
only print something if they fail. Thus "skip" and "pass" are basically the
same (if "skip" is simply not to do the test).

I mean, we could simply have:


 static void __init
 plain(void)
 {
 	int err;
 
+	if (debug_never_hash_pointers)
+		return;



-- Steve
