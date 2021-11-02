Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDB5443415
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhKBQ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhKBQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:56:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDA6C06120B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1sJdvJqhAZ8971iSxAtIuMLFnEJHx4QlcRhowz6J5Po=; b=UdvDzwHUdl7TAS3z1mhORKh/yt
        3irrVNIEUFmZ5bDiNfBaX5LloCH9pcJQMb13F3WP2htvyofIRD+GTlIACkkPU8vClmBBZ5N9LxK9d
        s/oAa77XtKdncaRdHRAPa3XlOrndiCrW7tSnA6HWW37m3/SHjTh2VyRnpDSDo3eLdHBUMLOWTVs6C
        jhuBuVgwEXyzPezZiXWsmxfWtfEYicLPe4gj4JaDcfDLax+hLjuA9aCyse4PSa9GweF2DDdHnVZD9
        MrtJmT0TbDo7NW4qa+rFDhbn6Kr2WqaTKNn2l+Htr6snw6iWFBgxwMoSudUG3oNvfMTCRFB7jUk6/
        z36oG+ZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhwGa-00DmKw-1A; Tue, 02 Nov 2021 16:04:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C25B39816BA; Tue,  2 Nov 2021 17:04:02 +0100 (CET)
Date:   Tue, 2 Nov 2021 17:04:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Morotti, Romain (London)" <romain.morotti@man.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kernel/scheduler: The Linux scheduler doesn't scale to more than
 8 cores?
Message-ID: <20211102160402.GX174703@worktop.programming.kicks-ass.net>
References: <6725b3093d47459fa438825fb187970f@man.com>
 <CAKfTPtAKpMj15dHO1MC=dH_XJQe1Os24k93N2jDZ=kgg3O7K7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAKpMj15dHO1MC=dH_XJQe1Os24k93N2jDZ=kgg3O7K7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 04:25:05PM +0100, Vincent Guittot wrote:
> > From the first line, the CPU count is capped to 8.
> >
> > Thus the scheduler scaling won't be more than a factor of 4, no matter how many CPUs there are. (1+log2(8))
> >
> > There's also a linear scaling option, that is similarly capped to 8 times, because 8 CPUs.
> 
> That's a good point and I never realized this limitation in the scaling factor.
> 
> Peter mentioned that there were interactivity problems with large
> scale factors at the time it was added. But the scheduler has changed
> since and it would be interesting to run benchmarks on more recent
> platforms with larger factor

The important note here is that this limit is about timescales, not
anything else. Previously a 64 cpu system would blow up the latency to
6ms * (1 + ln)2(64)) = 42ms, which is atrocious.

