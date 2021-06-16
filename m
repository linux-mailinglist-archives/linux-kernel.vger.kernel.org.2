Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081383A8ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 04:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhFPC3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 22:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231233AbhFPC3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 22:29:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8187961356;
        Wed, 16 Jun 2021 02:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623810435;
        bh=lYj2bg0NTUrYg6FGPQulyn1pIRI7JCNrKP+PSwV01as=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W1b8IvrSSubwOQscHheNT4JGxWCq8kTmvoGM6EmChcQbUIf7jpxWp0IdKpIZACcHp
         WYz4mtNRSaLz9js+6ayGAE3vOFJJdYzbadJpqVPhfZVy6IyT+rgvm3XlspXnalcCVp
         SJCWjrFbAMG6rEpS6E7o7+LF8VCnrYi9Rq7baS1u34/9cksjZcTcyBQXbvOTaQ5hgm
         JFMOSLtW3xF5i6H7im4jq8M7yPmjacTr5tgx7FsiIoqiceNdcsvmo62PJ4nEc/dFUm
         UuS3xsQcBWf2EWrXjUvDOt/QA/SesRIdLMW/deuOHTtJhk1F0cDehsrXEV82nDGvl8
         fFgDwireFwUbg==
Date:   Wed, 16 Jun 2021 11:27:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
Message-Id: <20210616112711.ce318fc66b389038203331d1@kernel.org>
In-Reply-To: <20210615210351.602bc03e@rorschach.local.home>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
        <1623777582.jsiokbdey1.naveen@linux.ibm.com>
        <20210616094622.c8bd37840898c67dddde1053@kernel.org>
        <20210615210351.602bc03e@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 21:03:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 16 Jun 2021 09:46:22 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > To avoid such trouble, I had set the 4096 limitation for the maxactive
> > parameter. Of course 4096 may not enough for some use-cases. I'm welcome
> > to expand it (e.g. 32k, isn't it enough?), but removing the limitation
> > may cause OOM trouble easily.
> 
> What if you just made the max as 10 * number of possible cpus, or 4096,
> which ever is greater? Why would a user need more?

It could be. But actually, that is not correct number because the
number of instances depends on the number of processes and the possiblity
of recursive. Thus the huge system which runs more than 64k processes,
may need more than that.

> I'd still like to get a wrapper around function graph tracing so that
> kretprobes could use it. I think that would get rid of the requirement
> of maxactive, because isn't that just used to have a way to know the
> original return value?

Hmm, yes, on some arch, it can be done. But on other arch we still need
current implementation for generic solution.
What I need is not fully wrapped by the function graph, but just share
the per-task (software) shadow stack.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
