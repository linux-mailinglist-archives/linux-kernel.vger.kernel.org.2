Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CBC30E401
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhBCUZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhBCUZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:25:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5BA64F6C;
        Wed,  3 Feb 2021 20:25:15 +0000 (UTC)
Date:   Wed, 3 Feb 2021 15:25:13 -0500
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
Message-ID: <20210203152513.34492916@gandalf.local.home>
In-Reply-To: <202102031201.FFED9547D@keescook>
References: <20210202213633.755469-1-timur@kernel.org>
        <YBpyzxBYIYapHaDT@alley>
        <YBqlooegQgEfPG4T@alley>
        <19c1c17e-d0b3-326e-97ec-a4ec1ebee749@kernel.org>
        <202102031201.FFED9547D@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 12:02:05 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Feb 03, 2021 at 12:58:41PM -0600, Timur Tabi wrote:
> > On 2/3/21 7:31 AM, Petr Mladek wrote:  
> > > Also please make sure that lib/test_printf.c will work with
> > > the new option.  
> > 
> > As you suspected, it doesn't work:
> > 
> > [  206.966478] test_printf: loaded.
> > [  206.966528] test_printf: plain 'p' does not appear to be hashed
> > [  206.966740] test_printf: failed 1 out of 388 tests
> > 
> > What should I do about this?
> > 
> > On one hand, it is working as expected: %p is not hashed, and that should be
> > a warning.
> > 
> > On the other hand, maybe test_printf should be aware of the command line
> > parameter and test to make sure that %p is NOT hashed?  
> 
> It seems like it'd be best for the test to fail, yes? It _is_ a problem
> that %p is unhashed; it's just that the failure was intended.
> 

I disagree.

With a big notice that all pointers of unhashed, I don't think we need to
print it failed when we expect it to fail.

If anything, skip the test and state:

  test_printf: hash test skipped because "make-printk-non-secret" is on the
  command line.

-- Steve
