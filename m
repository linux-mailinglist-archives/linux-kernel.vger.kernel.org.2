Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3625D3A9EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhFPPMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234390AbhFPPMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:12:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CBC161166;
        Wed, 16 Jun 2021 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623856212;
        bh=Ek8PXfa5d4UObasVdBmtYIX6dF9ex+esl93Yz4SV+64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ju9HXKUUL/hMHyMuwTRFi8zcT0K7NBBCmh+OsVn5EzVUIaAbMIujN6rl53d/iAgCQ
         B/mlNuTkn1py8GbItBHlYeyRVvaLGZGah330ntXj6FpgLDLC7w7CgC+9y1leiHNZE2
         HXDPBMh3FmrULZjdPqwNr1B8h5Lgz49q57nVfVDfNLfppTLpjMS0FHsyCMdLT4my0P
         afRmGH6W0GSAhRy1W4gNJpmQZzqG5cTxgw0iKyUjXo6wFWYXZ7M7pj5w4z5BeHEMAn
         evBNf6rycjKo16k/HUY90cDrrhqgn1Ly6n78Gi3qc2CFeY0foWgZwg8vQGqlKamHce
         rAEUw5hTmfqNQ==
Date:   Thu, 17 Jun 2021 00:10:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
Message-Id: <20210617001009.d5ae7b2edfdc34f4f8c19ab5@kernel.org>
In-Reply-To: <20210616112711.ce318fc66b389038203331d1@kernel.org>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
        <1623777582.jsiokbdey1.naveen@linux.ibm.com>
        <20210616094622.c8bd37840898c67dddde1053@kernel.org>
        <20210615210351.602bc03e@rorschach.local.home>
        <20210616112711.ce318fc66b389038203331d1@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 11:27:11 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 15 Jun 2021 21:03:51 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 16 Jun 2021 09:46:22 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > To avoid such trouble, I had set the 4096 limitation for the maxactive
> > > parameter. Of course 4096 may not enough for some use-cases. I'm welcome
> > > to expand it (e.g. 32k, isn't it enough?), but removing the limitation
> > > may cause OOM trouble easily.
> > 
> > What if you just made the max as 10 * number of possible cpus, or 4096,
> > which ever is greater? Why would a user need more?
> 
> It could be. But actually, that is not correct number because the
> number of instances depends on the number of processes and the possiblity
> of recursive. Thus the huge system which runs more than 64k processes,
> may need more than that.
> 
> > I'd still like to get a wrapper around function graph tracing so that
> > kretprobes could use it. I think that would get rid of the requirement
> > of maxactive, because isn't that just used to have a way to know the
> > original return value?
> 
> Hmm, yes, on some arch, it can be done. But on other arch we still need
> current implementation for generic solution.
> What I need is not fully wrapped by the function graph, but just share
> the per-task (software) shadow stack.

BTW, I have 2 ideas to fix this except for wrapper.

1. Use func-graph tracer API directly from dynamic event instead of
  kretprobes. This will be enabled only if the arch supports fgraph
  tracer and enable it. maxactive will be ignored if this is enabled,
  and tracefs user may not need except for the return value 
  (BTW, is that possible to access the stack? In some case, return
  value can be passed via stack)

2. Move the kretprobe instance pool from kretprobe to struct task.
  This pool will allocates one page per task, and shared among all
  kretprobes. This pool will be allocated when the 1st kretprobe
  is registered. maxactive will be kept for someone who wants to
  use per-instance data. But since dynamic event doesn't use it,
  it will be removed from tracefs and perf.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
