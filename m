Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACA83A7699
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 07:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhFOFtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 01:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhFOFtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 01:49:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DBD661410;
        Tue, 15 Jun 2021 05:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623736059;
        bh=f4qCOZWRuH4vKOgiIZVgeX8l6HC+JRWZLecahwNFIPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jAGcVW+OgL6SuL5Uk7TiQp0WiD8SkaSxqUu7+LT2Tu6Qod/OkeErSqBYgqDqkDAQi
         G4zqh7TnOAl8XbCvBD01IiXZFJnx+gj8C4h/63gE53zPZAuFkX+VKiPvET5T1LnxkN
         fRIGLHAbnNbaI60HKilOKNbZ67w9S+BDNThFdMl5KGq1yOeDU9aYQe5evJPQLoGa7w
         jnPCNkmAzl3zdbi2VFoeRZwKTBHfH1fuQL3M4hF1bexn9AMjHkCGeWSxJzcHKjzge8
         yyYW2iLO8p2bNoKOPqM8+gy983hDb2p5mVie5LlwAqyz9qxNVLwvK3pnn+/GXl4Kft
         diDjRtcYuJzyw==
Date:   Tue, 15 Jun 2021 14:47:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 1/2] trace/kprobe: Fix count of missed kretprobes in
 kprobe_profile
Message-Id: <20210615144737.087d11e9f901e68cadcb91c5@kernel.org>
In-Reply-To: <2905f923966229953e6dc162b0a036853a420172.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <2905f923966229953e6dc162b0a036853a420172.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 23:33:28 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> For a kretprobe, the miss count includes the number of times the probe
> on function entry was missed, as well as the number of times we ran out
> of kretprobe_instance structures due to maxactive being too low.
> 
> Fixes: cd7e7bd5e44718 ("tracing: Add kprobes event profiling interface")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Good catch!

> ---
>  kernel/trace/trace_kprobe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index ea6178cb5e334d..0475e2a6d0825e 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1192,7 +1192,8 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
>  	seq_printf(m, "  %-44s %15lu %15lu\n",
>  		   trace_probe_name(&tk->tp),
>  		   trace_kprobe_nhit(tk),
> -		   tk->rp.kp.nmissed);
> +		   trace_kprobe_is_return(tk) ? tk->rp.kp.nmissed + tk->rp.nmissed
> +					      : tk->rp.kp.nmissed);

Can you add a static trace_kprobe_nmissed(tk) for wrapping this ?

Thank you,

>  
>  	return 0;
>  }
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
