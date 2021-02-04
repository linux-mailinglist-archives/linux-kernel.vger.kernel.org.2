Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E771D30EFCE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhBDJhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:37:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:41882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235226AbhBDJhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:37:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612431376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zfLAgu6wDoaW3SU19yTGtsyEmW59ioXELKxZLdCbwE=;
        b=mPq6nSDmOCLfCgJlhWDE7QJQ3YOrT63IdBip+SS2scqP/7rFImGYLQsDbLm0+mKsiOVqKL
        wZ0AC53ucyeGB50YETkEW61MEiFy/8xs7XjxDBi9wch1cf8Qcu/arfjWbgieYXe62qZmyH
        TOhTuDgEqmHLbtv144hM6h7Dcj8M5oI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9412CAF13;
        Thu,  4 Feb 2021 09:36:16 +0000 (UTC)
Date:   Thu, 4 Feb 2021 10:36:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>, Timur Tabi <timur@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        john.ogness@linutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        akinobu.mita@gmail.com
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <YBvAD/XBn6VoQ8F+@alley>
References: <20210202213633.755469-1-timur@kernel.org>
 <YBpyzxBYIYapHaDT@alley>
 <YBqlooegQgEfPG4T@alley>
 <19c1c17e-d0b3-326e-97ec-a4ec1ebee749@kernel.org>
 <202102031201.FFED9547D@keescook>
 <20210203152513.34492916@gandalf.local.home>
 <202102031234.9BF349F@keescook>
 <20210203154727.20946539@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203154727.20946539@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-02-03 15:47:27, Steven Rostedt wrote:
> On Wed, 3 Feb 2021 12:35:07 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > > With a big notice that all pointers of unhashed, I don't think we need to
> > > print it failed when we expect it to fail.
> > > 
> > > If anything, skip the test and state:
> > > 
> > >   test_printf: hash test skipped because "make-printk-non-secret" is on the
> > >   command line.  
> > 
> > Yeah, I'm fine with "fail" or "skip". "pass" is mainly what I don't
> > like. :)
> 
> Is there any printing of the tests being done? Looks to me that the tests
> only print something if they fail. Thus "skip" and "pass" are basically the
> same (if "skip" is simply not to do the test).

It prints the total number of tests done. It should not count the
skipped tests.

We actually print a warning when crng is not initialized. In this
case, the test passes because we actually check the value and it
is an expected one.

> I mean, we could simply have:
> 
> 
>  static void __init
>  plain(void)
>  {
>  	int err;
>  
> +	if (debug_never_hash_pointers)
> +		return;

I am not 100% sure. But this might work. Just please print a warning
about the tests are skipped.

Best Regards,
Petr
