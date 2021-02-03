Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF330E420
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhBCUfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhBCUfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:35:50 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A991C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 12:35:10 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w14so595896pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ctpZix2vdpsWlT58CTksomBebLVeiR0jpEeIeen1iD4=;
        b=R+iJ2/PVt8eXXtNb0UBgNjBP3+Ne7x/JiSY+KQ/U0xq8U7bdSk9jxNoz10LRy/yK1N
         6qXw5MZn5Zsso4+1uPJzvjCXAack+UHQ3H66wH4hmCOCXVTM8zlwiH5i9KQgKxGpHF5y
         AE5VKH3s+FuYVSovVvsXwXsHGgLNGxO+gb9xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ctpZix2vdpsWlT58CTksomBebLVeiR0jpEeIeen1iD4=;
        b=l807t7uwP1oeK92LpiBIG/Q3jtsQtxKkhOQKcbzvpMRXesoY7SdBku1vbAqHIatemX
         LnJxlRkUY16cpVj6KMGLDBHpiVdl8AX5PnK2W8JUWFrriLSlikkiuTN8NhuxIHplAoTy
         CCXN6+en+Wwt/nZ09GkfJcmGX8+QtY4DQOUt/hOOEDPErMHrnSKpuvKqcQOYdAFx9O2B
         CtrhwnwhraVle+adSYBNYPVooqbOgY6enm37xd6XQ2ePRPnXoMoz9bFj2dnquj/wFJJY
         9GNLp3PnMYCKSDbQf1RPBnV4xnil7FxOVDXWjB1/4jaoYPgJbZaSWez9lsR3kQLYSZqL
         PnJw==
X-Gm-Message-State: AOAM532D+1n9tSeUlvVw7QE22grvAFG0uznBC1VD70+R3RRUshhd0z2h
        CEQWuueCH++pBY/Mc3kzLDTmRA==
X-Google-Smtp-Source: ABdhPJwXUA/dXsJaA9jxmgNGitJw3u7SCmOQCBw4IiJAy6ZehY0vVxUrfwPVtq4pl873LCWPMm3J0g==
X-Received: by 2002:aa7:904c:0:b029:1c9:c2ed:b229 with SMTP id n12-20020aa7904c0000b02901c9c2edb229mr4806193pfo.11.1612384509887;
        Wed, 03 Feb 2021 12:35:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 34sm3968558pgn.56.2021.02.03.12.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 12:35:08 -0800 (PST)
Date:   Wed, 3 Feb 2021 12:35:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
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
Message-ID: <202102031234.9BF349F@keescook>
References: <20210202213633.755469-1-timur@kernel.org>
 <YBpyzxBYIYapHaDT@alley>
 <YBqlooegQgEfPG4T@alley>
 <19c1c17e-d0b3-326e-97ec-a4ec1ebee749@kernel.org>
 <202102031201.FFED9547D@keescook>
 <20210203152513.34492916@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203152513.34492916@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:25:13PM -0500, Steven Rostedt wrote:
> On Wed, 3 Feb 2021 12:02:05 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Wed, Feb 03, 2021 at 12:58:41PM -0600, Timur Tabi wrote:
> > > On 2/3/21 7:31 AM, Petr Mladek wrote:  
> > > > Also please make sure that lib/test_printf.c will work with
> > > > the new option.  
> > > 
> > > As you suspected, it doesn't work:
> > > 
> > > [  206.966478] test_printf: loaded.
> > > [  206.966528] test_printf: plain 'p' does not appear to be hashed
> > > [  206.966740] test_printf: failed 1 out of 388 tests
> > > 
> > > What should I do about this?
> > > 
> > > On one hand, it is working as expected: %p is not hashed, and that should be
> > > a warning.
> > > 
> > > On the other hand, maybe test_printf should be aware of the command line
> > > parameter and test to make sure that %p is NOT hashed?  
> > 
> > It seems like it'd be best for the test to fail, yes? It _is_ a problem
> > that %p is unhashed; it's just that the failure was intended.
> > 
> 
> I disagree.
> 
> With a big notice that all pointers of unhashed, I don't think we need to
> print it failed when we expect it to fail.
> 
> If anything, skip the test and state:
> 
>   test_printf: hash test skipped because "make-printk-non-secret" is on the
>   command line.

Yeah, I'm fine with "fail" or "skip". "pass" is mainly what I don't
like. :)

-- 
Kees Cook
