Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE4A33DE72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 21:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhCPUNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 16:13:16 -0400
Received: from casper.infradead.org ([90.155.50.34]:34002 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhCPUM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rTDrt6R4KroMdKMf+HF0nCxGja3tnnOqB93Y69bQc8A=; b=SqFM4nBmd8DMru5yIZ1oGwoJYi
        VQSxS5qUoNr2R7caNJKcWQHOKeScP+wzL487DwKsWnqMQcEA6VI6lTAUm6kTtimHeQTrdl7F638ah
        OO0Vrb1pnGFhumMnQftv/52wi2ZWqdVb1OL8mcHYA1XdVMCoWMJAKMop/UJOYGvml04rW4uu1cA/a
        UrvMrOPRGPKo6WPatCVXVL3eL71V8aYlg0qoTb/za+FOWbGz7wkR/ifdqtfRpzCc5TD3DQXQSof7n
        Fpqoc0ZrQYDlXjW/26la1NZgxypdZhelg1DQHjqaQXeP6bCqK0iYdeRn5aZhwo23diShWUMiiYSrL
        MQWt7wWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMG3N-000Z6d-15; Tue, 16 Mar 2021 20:12:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B37F304D58;
        Tue, 16 Mar 2021 21:12:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77D7A2C950467; Tue, 16 Mar 2021 21:12:32 +0100 (CET)
Date:   Tue, 16 Mar 2021 21:12:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] futex: Leave the pi lock stealer in a consistent
 state upon successful fault
Message-ID: <YFERMIGd8hU9gm4F@hirez.programming.kicks-ass.net>
References: <20210315050224.107056-1-dave@stgolabs.net>
 <20210315050224.107056-3-dave@stgolabs.net>
 <YFCUYimuDkUonySp@hirez.programming.kicks-ass.net>
 <20210316180305.sh7nyi4xjskd3e3j@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316180305.sh7nyi4xjskd3e3j@offworld>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 11:03:05AM -0700, Davidlohr Bueso wrote:
> On Tue, 16 Mar 2021, Peter Zijlstra wrote:
> > 
> > IIRC we made the explicit choice to never loop here. That saves having
> > to worry about getting stuck in in-kernel loops.
> > 
> > Userspace triggering the case where the futex goes corrupt is UB, after
> > that we have no obligation for anything to still work. It's on them,
> > they get to deal with the bits remaining.
> 
> I was kind of expecting this answer, honestly. After all, we are warned
> about violations to the 10th:
> 
>  * [10] There is no transient state which leaves owner and user space
>  *      TID out of sync. Except one error case where the kernel is denied
>  *      write access to the user address, see fixup_pi_state_owner().
> 
> (btw, should we actually WARN_ON_ONCE this case such that the user is
> well aware things are screwed up?)

I'm not sure WARN is appropriate, it is something unpriv userspace
can trigger at will.
