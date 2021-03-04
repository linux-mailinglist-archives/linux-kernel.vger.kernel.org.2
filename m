Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3032D884
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhCDRV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhCDRVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:21:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC6DC061574;
        Thu,  4 Mar 2021 09:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GhCGhP0BsbYxxvG5oirIRrU/eVqLhvnrFt9++MBuTbI=; b=NPKi/FCogHT05rZYVfR2iyhhx5
        eHl43l4EOWfXGoMyxptEdO7OW3v61XMn/ugNheYMCs2J+Jtgs8J3l3rTnvbC/DJeabbXaUkY6BB5W
        KS9x3F2aUOJmkyeNF4q3ZFetboPNyZ+DdZSWNZ6TuKhFozr/rUrOmoG1hiL7WxlCwCiXefYnQNGkn
        FY5QpfMZvnAfnOJZXi4M9ekwjkXa+tD5Wvrpi2og+WutpT/l/xpLq50eAruI8gtOZNA1Qo5xwT+Yh
        qrvUaduQyMeOW1PLXmYi8B7R91Zse0ItV5kWCIQ0zcNP+6xzXS3vEei0qkMbRBmmcUEeS5SPedLOQ
        I4R+Hw0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHrdV-007yCV-09; Thu, 04 Mar 2021 17:19:49 +0000
Date:   Thu, 4 Mar 2021 17:19:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
Message-ID: <20210304171940.GL2723601@casper.infradead.org>
References: <20210301174749.1269154-1-swboyd@chromium.org>
 <20210301174749.1269154-6-swboyd@chromium.org>
 <20210301214319.7e54c66f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301214319.7e54c66f@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 09:43:19PM -0500, Steven Rostedt wrote:
> On Mon,  1 Mar 2021 09:47:47 -0800
> Stephen Boyd <swboyd@chromium.org> wrote:
> 
> > The %pS printk format (among some others) is used to print kernel
> > addresses symbolically. When the kernel prints an address inside of a
> > module, the kernel prints the addresses' symbol name along with the
> > module's name that contains the address. Let's make kernel stacktraces
> > easier to identify on KALLSYMS builds by including the build ID of a
> > module when we print the address.
> 
> Please no!
> 
> This kills the output of tracing with offset, and can possibly break
> scripts. I don't want to look at traces like this!
> 
>           <idle>-0       [004] ..s1   353.842577: ipv4_conntrack_in+0x0/0x10 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_hook_slow+0x40/0xb0

Would it make sense to only print the build-id if it differs from the
build-id of the kernel which has loaded it?
