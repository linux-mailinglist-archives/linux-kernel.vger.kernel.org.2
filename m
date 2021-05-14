Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F964381199
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhENUTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbhENUTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:19:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF9206121E;
        Fri, 14 May 2021 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621023489;
        bh=3N0GNmVDgTeE+9IO7jkM8kisClVzCGSHAfDkGTS1HoA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AX8h9jH/cAObRl8toqU5F1PAM7M4Qe4E8gmS+sTrrtd498JXw+ZGyM9ANU4li7Lgd
         E8QRk3Hb3qdxGTSeeFQnrKXm3jNiAygQ7msfylOe9NVCPZNrGYraGiXL59TVyNALTO
         nyUhkZrBkTDejtlmQ/kI2FbZGCUaydMi7c0zXNWHCjdA5rS+qP+v7byXxxRyO2gaMl
         nqxVw8HFTlxzdO9vQlRhhuaJzhmDhkZpLm1yJSKci/YGX311R6mtGtbCS+VfG+wRQA
         DbIpsUXKpcwms17r23LhuyHpHXFW4pq0oFBOAPb+MLVvT14/lPkV9Upoe0vYm45bF3
         FF6eujyhXoWzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B87EF5C02A5; Fri, 14 May 2021 13:18:08 -0700 (PDT)
Date:   Fri, 14 May 2021 13:18:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
Message-ID: <20210514201808.GO975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210514140015.2944744-1-arnd@kernel.org>
 <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
 <20210514193657.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <534d9b03-6fb2-627a-399d-36e7127e19ff@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534d9b03-6fb2-627a-399d-36e7127e19ff@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 01:11:05PM -0700, Nathan Chancellor wrote:
> Hi Paul,
> 
> On 5/14/2021 12:36 PM, Paul E. McKenney wrote:
> > On Fri, May 14, 2021 at 11:29:18AM -0700, Nathan Chancellor wrote:
> > > On 5/14/2021 7:00 AM, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > 
> > > > clang points out that an initcall funciton should return an 'int':
> > > > 
> > > > kernel/kcsan/debugfs.c:274:15: error: returning 'void' from a function with incompatible result type 'int'
> > > > late_initcall(kcsan_debugfs_init);
> > > > ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > > > include/linux/init.h:292:46: note: expanded from macro 'late_initcall'
> > > >    #define late_initcall(fn)               __define_initcall(fn, 7)
> > > > 
> > > > Fixes: e36299efe7d7 ("kcsan, debugfs: Move debugfs file creation out of early init")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > For the record, this requires CONFIG_LTO_CLANG to be visible.
> > > 
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > 
> > Queued with the three Reviewed-by tags, thank you all!
> > 
> > Nathan, I lost the thread on exactly what it is that requires that
> > CONFIG_LTO_CLANG be visible.  A naive reader might conclude that the
> > compiler diagnostic does not appear unless CONFIG_LTO_CLANG=y, but
> > that would be surprising (and yes, I have been surprised many times).
> > If you are suggesting that the commit log be upgraded, could you please
> > supply suggested wording?
> 
> You can see my response to Marco here:
> 
> https://lore.kernel.org/r/ad7fa126-f371-5a24-1d80-27fe8f655b05@kernel.org/
> 
> Maybe some improved wording might look like
> 
> clang with CONFIG_LTO_CLANG points out that an initcall function should
> return an 'int' due to the changes made to the initcall macros in commit
> 3578ad11f3fb ("init: lto: fix PREL32 relocations"):

OK, so the naive reading was correct, thank you!

> ...
> 
> Arnd, do you have any objections?

In the meantime, here is what I have.  Please let me know of any needed
updates.

							Thanx, Paul

------------------------------------------------------------------------

commit fe1f4e1b099797d06bd8c66681eed4024c3cad67
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri May 14 16:00:08 2021 +0200

    kcsan: Fix debugfs initcall return type
    
    clang with CONFIG_LTO_CLANG points out that an initcall function should
    return an 'int' due to the changes made to the initcall macros in commit
    3578ad11f3fb ("init: lto: fix PREL32 relocations"):
    
    kernel/kcsan/debugfs.c:274:15: error: returning 'void' from a function with incompatible result type 'int'
    late_initcall(kcsan_debugfs_init);
    ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
    include/linux/init.h:292:46: note: expanded from macro 'late_initcall'
     #define late_initcall(fn)               __define_initcall(fn, 7)
    
    Fixes: e36299efe7d7 ("kcsan, debugfs: Move debugfs file creation out of early init")
    Cc: stable <stable@vger.kernel.org>
    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Reviewed-by: Marco Elver <elver@google.com>
    Reviewed-by: Nathan Chancellor <nathan@kernel.org>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index c1dd02f3be8b..e65de172ccf7 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -266,9 +266,10 @@ static const struct file_operations debugfs_ops =
 	.release = single_release
 };
 
-static void __init kcsan_debugfs_init(void)
+static int __init kcsan_debugfs_init(void)
 {
 	debugfs_create_file("kcsan", 0644, NULL, NULL, &debugfs_ops);
+	return 0;
 }
 
 late_initcall(kcsan_debugfs_init);
