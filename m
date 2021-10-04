Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6EB420829
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhJDJYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:24:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44856 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhJDJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:24:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 461DB22207;
        Mon,  4 Oct 2021 09:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633339365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6TkKi6hy7vvYkLmG2gjPBwv/cUmkzXYzYFWaAQ5WO7c=;
        b=nwSyrOSht7o81kAxWVu0bZi3YEt1z6jE14a2qlOePHmS8nlgi2jytlROY1WAo7axH5Xn61
        Yfpic9IwlxFSsLiAI6aF27221e+oaJYzEngc0GWlzjcJwluKBQKu2GbgOoobd95wW/4FSN
        CPkPeDtUbjwUaxZSiBL1N5+rnP9MqGU=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AFBD1A3B8C;
        Mon,  4 Oct 2021 09:22:44 +0000 (UTC)
Date:   Mon, 4 Oct 2021 11:22:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        YueHaibing <yuehaibing@huawei.com>, Jessica Yu <jeyu@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] printk: avoid -Wsometimes-uninitialized warning
Message-ID: <YVrH5MUdS6uE/zDj@alley>
References: <20210928093456.2438109-1-arnd@kernel.org>
 <YVLrttKajDU+1ZvX@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVLrttKajDU+1ZvX@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-09-28 11:17:26, Chris Down wrote:
> Arnd Bergmann writes:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > clang notices that the pi_get_entry() function would use
> > uninitialized data if it was called with a non-NULL module
> > pointer on a kernel that does not support modules:
> > 
> > kernel/printk/index.c:32:6: error: variable 'nr_entries' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> >        if (!mod) {
> >            ^~~~
> > kernel/printk/index.c:38:13: note: uninitialized use occurs here
> >        if (pos >= nr_entries)
> >                   ^~~~~~~~~~
> > kernel/printk/index.c:32:2: note: remove the 'if' if its condition is always true
> >        if (!mod) {
> > 
> > Rework the condition to make it clear to the compiler that we are always
> > in the second case. Unfortunately the #ifdef is still required as the
> > definition of 'struct module' is hidden when modules are disabled.
> > 
> > Fixes: 337015573718 ("printk: Userspace format indexing support")
> 
> This changelog should make it clear that this is theoretical and will never
> actually happen, which is salient information for people who are considering
> whether it should go in stable or similar.

IMHO, the sentence "Rework the condition to make it clear that this
is theoretical and will never actually happen" is rather clear.

Well, I am not a native speaker.

Anyway, I have pushed the patch into printk/linux.git, branch
for-5.16.

Best Regards,
Petr
