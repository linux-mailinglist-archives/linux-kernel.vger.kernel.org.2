Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3671F3810F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhENTiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhENTiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:38:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A854610F7;
        Fri, 14 May 2021 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621021017;
        bh=Hh0QonQZjmEOkFxHlLabLQ/ulBr/IzaZmwAVlG28RlU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Nw1yr7gmTaNsIqyvluuIzuWg6ihBMfQ8R3/UpA1cYXHmf9PUzKOLZ2NVCJl2L+A6j
         1ggAtjNhOZnsbRJeIOSTCqL9bspCVgo+6Y6je9N25iyGeFAr6RwXj2/qBQNrj+0NAL
         0jvzrIWJp6ZnvGxAl2FzdwKZe8OiSQbH25nUOIg3Nm57COWkR0H4VRDZ+yChJ6GwmD
         o4qEdc8BxG/ESQuj6ZaQX4a4S0TJJYWMWRjLWQ3jczpeoyL4xZgDuUKFLuWvBfz6iH
         kx5+YKHoJxXxQ+onmBZSbKARukQagkJiBAC3pk1uVqIXcd2bDk7jBZ9nVXjdRkEbeD
         BKWqkmdTCU6vA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0AE945C02A5; Fri, 14 May 2021 12:36:57 -0700 (PDT)
Date:   Fri, 14 May 2021 12:36:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
Message-ID: <20210514193657.GM975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210514140015.2944744-1-arnd@kernel.org>
 <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:29:18AM -0700, Nathan Chancellor wrote:
> On 5/14/2021 7:00 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > clang points out that an initcall funciton should return an 'int':
> > 
> > kernel/kcsan/debugfs.c:274:15: error: returning 'void' from a function with incompatible result type 'int'
> > late_initcall(kcsan_debugfs_init);
> > ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > include/linux/init.h:292:46: note: expanded from macro 'late_initcall'
> >   #define late_initcall(fn)               __define_initcall(fn, 7)
> > 
> > Fixes: e36299efe7d7 ("kcsan, debugfs: Move debugfs file creation out of early init")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> For the record, this requires CONFIG_LTO_CLANG to be visible.
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Queued with the three Reviewed-by tags, thank you all!

Nathan, I lost the thread on exactly what it is that requires that
CONFIG_LTO_CLANG be visible.  A naive reader might conclude that the
compiler diagnostic does not appear unless CONFIG_LTO_CLANG=y, but
that would be surprising (and yes, I have been surprised many times).
If you are suggesting that the commit log be upgraded, could you please
supply suggested wording?

Once this is nailed down (or by Wednesday if I hear no more), I will
rebase it to the bottom of the current kcsan stack, let it soak in -next
for a couple of days, then send to Linus as a fix for a regression.
Hopefully some time next week.

							Thanx, Paul

> > ---
> >   kernel/kcsan/debugfs.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> > index c1dd02f3be8b..e65de172ccf7 100644
> > --- a/kernel/kcsan/debugfs.c
> > +++ b/kernel/kcsan/debugfs.c
> > @@ -266,9 +266,10 @@ static const struct file_operations debugfs_ops =
> >   	.release = single_release
> >   };
> > -static void __init kcsan_debugfs_init(void)
> > +static int __init kcsan_debugfs_init(void)
> >   {
> >   	debugfs_create_file("kcsan", 0644, NULL, NULL, &debugfs_ops);
> > +	return 0;
> >   }
> >   late_initcall(kcsan_debugfs_init);
> > 
> 
