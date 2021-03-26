Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D83034AB53
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhCZPUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCZPT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:19:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7F2C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qmp+F0418AwvQlnC1o8gzr9PkURFAqbNZKpNnU0rE5w=; b=R6Us5JD/hHCwkwlG2iWZqpPSKj
        T4sPgNZV0BtmPzbZ3YXLquGZtoOC5f08zUguEaqEWWohr04mQvwoPoKC2CHMFI6s2qruo3yNZyM+k
        TkneEycTgTVvYhO9T5V1LU2pWrQGPVXpjKepQybDWmhO5bB+yhb1q0v7SxXDkZUAGjt+iUdPIXpcv
        RQ89Fs888/a9LfUZkgC6RFJzcbsr+QDmSbzAOERMy7l8e4V8pl/RB28IyQxGoZyH5lPS6w8Ny3ZxF
        Wv0oywusG1ik3abtEl3OEPPTtScEwnJDKnhaVjVoOsq0yVlR0ehCzwbVyq7pJbI6kFjDGHzo1WkfJ
        JeSs3tbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPoEz-003sRh-34; Fri, 26 Mar 2021 15:19:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0DF3980FEF; Fri, 26 Mar 2021 16:19:12 +0100 (CET)
Date:   Fri, 26 Mar 2021 16:19:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg KH <greg@kroah.com>, mingo@kernel.org, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <20210326151912.GL4746@worktop.programming.kicks-ass.net>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
 <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
 <YF3F0JbbEpeSGzW6@kroah.com>
 <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
 <70594935-18e6-0791-52f9-0448adf37155@rasmusvillemoes.dk>
 <20210326142230.GJ4746@worktop.programming.kicks-ass.net>
 <c1be3728-40e7-f200-ece0-cd3f11349f65@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1be3728-40e7-f200-ece0-cd3f11349f65@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 03:58:37PM +0100, Rasmus Villemoes wrote:
> >   kmalloc(len + 2, ...);
> 
> No, because nul-terminating the stuff you pass to
> simple_read_from_buffer is pointless cargo-culting. Yeah, read_file_bool
> does it, but that's just bogus.

Urgh, feel yuck to not have it zero terminated, but if you feel strongly
about it I suppose I can make it go away.

> > 	len = strscpy(copy, str, len);
> > 	if (len < 0)
> > 		return len;
> 
> To what end? The only way that could possibly return -EFOO is if the
> nul-terminator in str vanished between the strlen() and here, and in
> that case you have bigger problems.

There are strings in the kernel which we rewrite in most ugly ways,
task_struct::comm comes to mind. Best be paranoid.

> > Copy-pasta from debugfs_*_bool(). This thing seems to export everything
> > and I figured I'd go along with that.
> 
> I thought the convention was not to export anything until the kernel
> itself had a (modular) user.

That's generally how I feel too. But this really isn't my subsystem so I
more or less try to mimmick what I see done there.
