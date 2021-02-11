Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B3A3191AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhBKR5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBKRWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:22:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633CCC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4V4RhiH1UyWnF1PtklR0TeZu/LJmoRUY68pmD70X6pg=; b=cm8aslEvrbI3fGlEgYmSPP8j/o
        WtSGBsoo62PW5j/jduzHluCay3av4lz54ilWJi90oqNk8xxskPcWev3AEzQp77bvGbtMpSou1aOda
        j07498Ev5uESzoV2FaYlmfhqw7K4qIKaWCdmUo/pNitPPeodqmJcG+gE1KAUQGFooIKZobtklFmTH
        5NwPLy0xUwmYHNXNWHujRt2do1DsDv5DyS19YFOTipD+761Blrg6Jf/baKTxiwILgY0OUGXhnWAsQ
        AEzlASSpqtpSW6Bjae5cmxNTgFHiNbyRO+h1PUz1tWxBTtUxKxMbvGQ/5FW44z+4L/LMqXZYaSBqv
        E9og+bnw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lAFdi-00AWc0-SA; Thu, 11 Feb 2021 17:20:28 +0000
Date:   Thu, 11 Feb 2021 17:20:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] [v3] lib/vsprintf: debug_never_hash_pointers prints
 all addresses as unhashed
Message-ID: <20210211172026.GL308988@casper.infradead.org>
References: <20210210213453.1504219-1-timur@kernel.org>
 <20210210213453.1504219-4-timur@kernel.org>
 <20210211123118.GB31708@amd>
 <9f0c02d9-29d6-95ce-b9b7-27342aa70c6f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f0c02d9-29d6-95ce-b9b7-27342aa70c6f@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 11:08:12AM -0600, Timur Tabi wrote:
> 
> 
> On 2/11/21 6:31 AM, Pavel Machek wrote:
> > Can we make this something shorter? Clearly you don't want people
> > placing this in their grub config, so they'll be most likely typing
> > this a lot...
> > 
> > debug_pointers or debug_ptrs would be better.
> 
> dbg_unhash_ptrs?  "debug_ptrs" is too vague IMHO, and I want to keep the
> word "hash" somewhere there to indicate exactly what's happening.

no_hash_pointers ?
