Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98E3439930
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhJYOvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233364AbhJYOup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:50:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71EE960C40;
        Mon, 25 Oct 2021 14:48:20 +0000 (UTC)
Date:   Mon, 25 Oct 2021 10:48:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        corbet@lwn.net, ananth@in.ibm.com, akpm@linux-foundation.org,
        randy.dunlap@oracle.com, mathieu.desnoyers@polymtl.ca,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] MAINTAINERS: Add git tree and missing files for
 KPROBES
Message-ID: <20211025104819.66404060@gandalf.local.home>
In-Reply-To: <c10e50c8-081b-aca6-eefe-eac463cb5a30@loongson.cn>
References: <1635132660-5038-1-git-send-email-yangtiezhu@loongson.cn>
        <1635132660-5038-5-git-send-email-yangtiezhu@loongson.cn>
        <20211025153821.baa3f5d90fd40943ee28d2e1@kernel.org>
        <c10e50c8-081b-aca6-eefe-eac463cb5a30@loongson.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 16:31:07 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> On 10/25/2021 02:38 PM, Masami Hiramatsu wrote:
> > On Mon, 25 Oct 2021 11:31:00 +0800
> > Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >  
> >> There is no git tree for KPROBES in MAINTAINERS, it is not convinent to
> >> rebase, lib/test_kprobes.c and samples/kprobes belong to kprobe, add them.
> >>
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >> ---
> >>   MAINTAINERS | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 4372473..0e9bc60 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -10506,10 +10506,13 @@ M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> >>   M:	"David S. Miller" <davem@davemloft.net>
> >>   M:	Masami Hiramatsu <mhiramat@kernel.org>
> >>   S:	Maintained
> >> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git  
> > NACK. As I said, this branch was prepared when I discussed with tip maintainer
> > on kretprobe stackfix series but now it has been maintained on Steve's tracing
> > tree.
> >
> > Steve, should we put your tree here?  
> 

I'm fine if kprobes goes through my tree.

> If yes, should I update patch #4 and then send a v2 version of this 
> patch set?
> 
> @@ -10505,11 +10505,16 @@ M:    Naveen N. Rao <naveen.n.rao@linux.ibm.com>
>   M:     Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>   M:     "David S. Miller" <davem@davemloft.net>
>   M:     Masami Hiramatsu <mhiramat@kernel.org>
> +L:     linux-trace-devel@vger.kernel.org

Please do not add the above mailing list. That's more for tracing tools
like trace-cmd, kernelshark and the libtracefs/libtraceevent libraries.
Only API changes (additions) should go to that list. Not internal updates.

>   S:     Maintained
> +Q:     https://patchwork.kernel.org/project/linux-trace-devel/list/

And this too is for the tracing tools, not the kernel. The patches status
on that patchwork do not get updated by changes to the kernel. Only changes
to the libraries and tool git trees will update those patches.

> +T:     git 
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>   F:     Documentation/trace/kprobes.rst
>   F:     include/asm-generic/kprobes.h
>   F:     include/linux/kprobes.h
>   F:     kernel/kprobes.c
> +F:     lib/test_kprobes.c
> +F:     samples/kprobes
> 
> By the way, it seems that we should also update the TRACING git tree [1]?
> If yes, should I send the following change as a new patch #5 in the v2 
> version
> or do the following change in the above patch #4?
> 
> @@ -19065,8 +19070,10 @@ F:     drivers/char/tpm/
>   TRACING
>   M:     Steven Rostedt <rostedt@goodmis.org>
>   M:     Ingo Molnar <mingo@redhat.com>
> +L:     linux-trace-devel@vger.kernel.org

Again, don't add that list.

>   S:     Maintained
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 
> perf/core
> +Q:     https://patchwork.kernel.org/project/linux-trace-devel/list/

Nor the patchwork.

> +T:     git 
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>   F:     Documentation/trace/ftrace.rst
>   F:     arch/*/*/*/ftrace.h
>   F:     arch/*/kernel/ftrace.c
> 

-- Steve
