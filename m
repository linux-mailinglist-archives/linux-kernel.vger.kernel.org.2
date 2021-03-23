Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF086346466
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhCWQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhCWQF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:05:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6985FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lKpytMVS6/ftOFf2bnc4fc09YEOmBW8jbciH2TkLvS8=; b=PPw+hHlVgAnxt5La/yIIDDs1Lj
        FolUqBA0A2s2VR+8dKC/f20eRqtXaDMF2h3BY4EaIjnlxONkgMd2ftOZyyMfeDFFMHVRFbSmj62hf
        hpLHC0If0WTpRBJsaRWqbSjI3VTPZRXy9VsTFAeHMX1KOznmSSich82au2AmmGpoPO4UFRJ9kiPza
        fv4M4pKuSaUAfCr8jw49Gjr2f1oT8mis0sjwtPzAqG9Ak4w4D3NmUx1aP8NtJNaG1MBZ79flEtbbD
        /f1X7ytcHUs81pU72yfiJlh+afLAzS2olUcQbn3rIBoqchMt/oiUBegy28vxJq7ABkTjZLnnHJW60
        cDCdKoBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOjX0-00FHsw-LO; Tue, 23 Mar 2021 16:05:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3EE493003E1;
        Tue, 23 Mar 2021 17:05:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 239712D98F229; Tue, 23 Mar 2021 17:05:21 +0100 (CET)
Date:   Tue, 23 Mar 2021 17:05:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ftrace: shut up -Wcast-function-type warning for
 ftrace_ops_no_ops
Message-ID: <YFoRwYBeHAN0Vn5q@hirez.programming.kicks-ass.net>
References: <20210322215006.1028517-1-arnd@kernel.org>
 <YFmbHI4hnKg5UH2M@hirez.programming.kicks-ass.net>
 <20210323085742.18477aad@gandalf.local.home>
 <YFoIU0xC3lXBwc9Y@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFoIU0xC3lXBwc9Y@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 04:25:07PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 23, 2021 at 08:57:42AM -0400, Steven Rostedt wrote:
> 
> > Well, from what I understand is that typecasting functions to other types
> > of functions is one of the mistakes that cause security bugs to happen. And
> > there's been a few of them in the kernel. Which is why the compilers have
> > now been flagging them.
> 
> Doing the cast in the first pace is an indication something weird is
> happening anyway. C will already warn you if you assign non-matching
> pointer types.
> 
> So if there's bugs, audit all (function) pointer casts. Don't wreck
> casts.
> 
> This warning will only make people add more (void *) intermediate casts
> and then we have uglier code and an equal amount of hidden bugs. IE. we
> really didn't win anything at all.
> 
> > This particular instance of the typecasting is unique and there's a bit of
> > magic involved. Adding this little work around here is fine. Probably needs
> > a better comment though.
> 
> Nah, it's not unique, static_call() has a whole bunch of them, including
> the exact same you have. Yes, we're doing something C thinks is UB, but
> we do that all day every day.

Here's weakening static_call_update() to get around this new
fail^Wfeature:

https://lkml.kernel.org/r/YFoN7nCl8OfGtpeh@hirez.programming.kicks-ass.net
