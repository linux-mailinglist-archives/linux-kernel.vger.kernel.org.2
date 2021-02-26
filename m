Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AEE326921
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBZVGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBZVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:06:40 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1441C061574;
        Fri, 26 Feb 2021 13:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oAMn00qL1UH8lZgRFRyPH+GWc5Azm2mPOYcIwE8BO0U=; b=DlkbmiwR6dInsoXYmDyn7MlvUg
        D8Fo4Ojdj+ikq44ei9R7Vya6o5uK98vRr+s5D/v62VkwvS1qiFe/wbvAHLUMVaVgaju5yBGmrK6Xa
        jx7j1/Pf8c41fiOP+MywvbZKn6dKbs58RJ8VCQL/eduuKyyKUVFgJk2PpPAeZZtEuljTygoCqQy/9
        ntMROheOEFQAw5qX1S1KgMFxbeCanRnbrVNcPVroF63/s1yPseVF30MPQYo7ZbeM3PPvpWuFIySEN
        nuSY71G+g0jw53oHl3UtNjSuTJQFeEJTj+UnuLEpfSWUfF62JtjdBxUeN+GCCy3sNBSItAZ9Y1k+1
        2pqxPOFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFkJ7-0007Ll-5G; Fri, 26 Feb 2021 21:05:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC536300DB4;
        Fri, 26 Feb 2021 22:05:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A214320616380; Fri, 26 Feb 2021 22:05:51 +0100 (CET)
Date:   Fri, 26 Feb 2021 22:05:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, mhocko@suse.com,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/3] kernel/smp: add more data to CSD lock debugging
Message-ID: <YDlirwTWMmZ3g0ts@hirez.programming.kicks-ass.net>
References: <20210226112521.8641-1-jgross@suse.com>
 <20210226112521.8641-4-jgross@suse.com>
 <YDkkFBerBlW5uUBS@hirez.programming.kicks-ass.net>
 <20210226181205.GZ2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226181205.GZ2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:12:05AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 26, 2021 at 05:38:44PM +0100, Peter Zijlstra wrote:
> > 
> > I hate all of this, but if this will finally catch the actual problem,
> > we can then revert all this, so sure.
> 
> OK, I will bite...  What exactly do you hate about it?

It's ugly and messy. We're basically commiting a debug session. Normally
gunk like this is done in private trees, then we find the problem and
fix that and crap like this never sees the light of day.
