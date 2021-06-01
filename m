Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF25396E63
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhFAH7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhFAH7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:59:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD9BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d0+bGm6BSb+FBtnbz7qLziUlVBuKZKGk4px2hrwqgf0=; b=LIOYzWC7JHIPZH3UMmS2+ZPeV/
        JW31aJxa18rURheilAFI4FsyicCi0VTqyTgUqA+wXrLSimMJX8vVY9Hqn6nGL8Kx9svz+2K/1Ps8n
        SwMUEuY2hGTHWsWom5i/OJ8togfWMVRrk+7oVwbGXDiu4tCg3kDF5DaxzSGExsJ1a3HskIFKO99a+
        Yg9+4V2q61PY0miwKIZwDwHJ5l4/WiSR2d62phgvWASGbXOOKy8QATAeVAJ/ufqAg8KzVptN+f8rK
        qbkUbsYsLh+/6S+iEkVOVxT7Lc9wHW5u0GrEPSAHOUjVhuCzmkMeYwQxxZSXDlKqFWzYo2aBMOhFk
        DbqRy2Ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lnzGZ-002UgE-Ji; Tue, 01 Jun 2021 07:56:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BB5A300223;
        Tue,  1 Jun 2021 09:56:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23D0D20264902; Tue,  1 Jun 2021 09:56:51 +0200 (CEST)
Date:   Tue, 1 Jun 2021 09:56:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hailong Liu <liuhailongg6@163.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: Re: [PATCH] sched/debug:fix stale comments of sched_debug
Message-ID: <YLXoQzcUwSO775Z6@hirez.programming.kicks-ass.net>
References: <20210530025145.13527-1-liuhailongg6@163.com>
 <YLSUw2Kkq946LQam@smile.fi.intel.com>
 <48a36f92-e8cf-d62b-e4d5-bf6911bcbbcf@163.com>
 <YLUJQp4fdEAW4GzY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLUJQp4fdEAW4GzY@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 07:05:22PM +0300, Andy Shevchenko wrote:
> > >> --- a/lib/Kconfig.debug
> > >> +++ b/lib/Kconfig.debug
> > >> @@ -1166,7 +1166,7 @@ config SCHED_DEBUG
> > >>  	depends on DEBUG_KERNEL && PROC_FS
> > > 
> > > Are the dependencies correct?
> > 
> > Based on your suggestion, I checked and it turned out that PROC_FS is not
> > the correct dependency, but DEBUG_FS. 
> 
> I guess you missed something.
> 
> > Shoud I change it to DEBUG_FS?
> 
> Please, double check.

Thing is that proc_sched_show_task() still wants PROC_FS, i've not yet
found a suitable debugfs based location for that.

And DEBUG_FS doesn't need a dependency; it has complete DEBUG_FS=n
wrappers and will build fine. Arguably selecting SCHED_DEBUG without
DEBUG_FS is daft, but it should work.
