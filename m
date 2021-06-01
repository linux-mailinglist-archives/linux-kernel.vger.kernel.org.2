Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679AD397D2E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhFAXuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 19:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235034AbhFAXug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 19:50:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97CAC613B4;
        Tue,  1 Jun 2021 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622591334;
        bh=L5TBPUeRAk35Q5KL49H1pE9FXn6EXJ/5i7usvcJ4g2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Osm0zNOwf+weSGzuGiJV4iyG6FvfX2RvIsSYStZcYKZjChPL/PNeFlIJvg7dqEOFB
         0FFpiscmEhDn3dav7HZWsNago+DtlYO8XuT+mOa8iNNVvYdq3hKfnmhg+RXQasE166
         QqWD8U6fNi78DwlmEDE0Ay2U50oqsQTiWJ3wdaWZ2fFCJ/dFsoTUFtsjRcxnU/MCuq
         YtmNqEavToCk7NGfDq07wAXP208GDwRgYDwAnMn3BOrh2wmPJEPORwHYBZweqGg1zk
         yg41CNSoi+FjpjsBiVnprGN3PrlYKj8MjCP78OHZOwch0HIFDBY74Ev8iedkmgENGD
         39DGs8pmMPRDA==
Date:   Wed, 2 Jun 2021 08:48:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        mhiramat@kernel.org, ananth@linux.ibm.com,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, rostedt@goodmis.org, x86@kernel.org
Subject: Re: [PATCH] kprobes: Do not increment probe miss count in the fault
 handler
Message-Id: <20210602084850.598a60d848a7bdc7c3b0085a@kernel.org>
In-Reply-To: <YLY0INyDtfjgVrXv@hirez.programming.kicks-ass.net>
References: <20210525073213.561116662@infradead.org>
        <20210601120150.672652-1-naveen.n.rao@linux.vnet.ibm.com>
        <YLY0INyDtfjgVrXv@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 15:20:32 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jun 01, 2021 at 05:31:50PM +0530, Naveen N. Rao wrote:
> > Kprobes has a counter 'nmissed', that is used to count the number of
> > times a probe handler was not called. This generally happens when we hit
> > a kprobe while handling another kprobe.
> > 
> > However, if one of the probe handlers causes a fault, we are currently
> > incrementing 'nmissed'. The comment in fault handler indicates that this
> > can be used to account faults taken by the probe handlers. But, this has
> > never been the intention as is evident from the comment above 'nmissed'
> > in 'struct kprobe':
> > 
> > 	/*count the number of times this probe was temporarily disarmed */
> > 	unsigned long nmissed;
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> > I'm posting this here so that these can go together, if the patch is ok 
> > otherwise.
> 
> I had the other two queued in perf/core and was about to push then to
> tip, Masami are you good with adding this on top?

Yes, those looks good to me too.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
