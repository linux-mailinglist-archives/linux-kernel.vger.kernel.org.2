Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B65541A19A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhI0WAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237503AbhI0WAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:00:01 -0400
Received: from oasis.local.home (unknown [209.210.2.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A2D061058;
        Mon, 27 Sep 2021 21:58:23 +0000 (UTC)
Date:   Mon, 27 Sep 2021 17:58:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] printk: avoid -Wsometimes-uninitialized warning
Message-ID: <20210927175822.6c928128@oasis.local.home>
In-Reply-To: <CAK8P3a264UGrqV648i3v_z_MciRO+eYN8f9RhJL9ksDuKVdAkg@mail.gmail.com>
References: <20210927125007.1581919-1-arnd@kernel.org>
        <YVHE1qclD6ZyjvvD@chrisdown.name>
        <20210927122138.56cb1d8e@oasis.local.home>
        <CAK8P3a264UGrqV648i3v_z_MciRO+eYN8f9RhJL9ksDuKVdAkg@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 20:32:12 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> On Mon, Sep 27, 2021 at 6:21 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Mon, 27 Sep 2021 14:19:18 +0100
> > Chris Down <chris@chrisdown.name> wrote:
> >  
> > > Having IS_ENABLED and then an #ifdef seems to hurt code readability to me.  
> >
> > I agree.
> >
> > Would this be a better solution?  
> 
> Sounds good, I'll follow up with that version after the next round of randconfig
> builds.

OK, but can you remove the extra line that's between the brace and the
text. I should have deleted it in that patch.

-- Steve

