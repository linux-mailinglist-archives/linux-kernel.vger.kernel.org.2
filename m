Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6AB3D8425
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 01:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhG0XjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 19:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232735AbhG0XjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 19:39:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1FA160F6B;
        Tue, 27 Jul 2021 23:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627429156;
        bh=DxpSRtxm2P8cztzLVTsCpms38y/1YnNRSm6MTuy0rc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o8kbwQSd+gt4igaPaxGlY7salvUr6BDve9UVrE/uUygw2+NghvPI5a5NdUzcmBuLq
         /lTmklU1ziy3k8RLnsijmltr+6eWJB3YT0m182HYp4expzC6XWabtYnyohKhppZZ8s
         Wmt3wvfeWvFytvcZ/WdeEoT6AN3H8rDwRzhLezt9WuM0vfn7efqMHIiQZsZRDR3e3l
         A2umItypmcx+3Tohwo6bFwD9C6J2ukqNq5PTp8Bn2b2y4TWwarQRS6cGDXzTbb6u1J
         8XAV7yiwK64xvWwH57K7Ish/KQmUxMjDx7+0wqUeFQogMyrbPBv2J8qVoaznUjy5MM
         VMVkOKxg8BFJA==
Date:   Wed, 28 Jul 2021 08:39:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        guoren@kernel.org, linux-csky@vger.kernel.org, x86@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/5] kprobes: Bugfix and improvements
Message-Id: <20210728083913.bcf0fa991e4a2b819f457543@kernel.org>
In-Reply-To: <20210727133426.2919710-1-punitagrawal@gmail.com>
References: <20210727133426.2919710-1-punitagrawal@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Punit,

Thanks for resending this series.

Ingo, could you pick this patch too?
I'll resend my series on this series. 

Thank you,

On Tue, 27 Jul 2021 22:34:21 +0900
Punit Agrawal <punitagrawal@gmail.com> wrote:

> Hi,
> 
> This is the second posting of patches previously posted at
> [0]. Although the patches were reviewed / acked in the previous cycle
> but for some didn't end up getting picked up for this cycle.
> 
> This posting rebases the patches to 5.14-rc3 and makes some minor
> improvements to the commit log in Patch 1. I've also added the tags as
> appropriate from the previous posting.
> 
> It would be great if the patches can be picked up this time around.
> 
> Thanks,
> Punit
> 
> 
> [0] https://lore.kernel.org/linux-csky/20210609105019.3626677-1-punitagrawal@gmail.com/
> 
> Punit Agrawal (5):
>   kprobes: Do not use local variable when creating debugfs file
>   kprobes: Use helper to parse boolean input from userspace
>   kprobe: Simplify prepare_kprobe() by dropping redundant version
>   csky: ftrace: Drop duplicate implementation of
>     arch_check_ftrace_location()
>   kprobes: Make arch_check_ftrace_location static
> 
>  arch/csky/kernel/probes/ftrace.c |  7 ----
>  include/linux/kprobes.h          |  7 ++--
>  kernel/kprobes.c                 | 58 ++++++++++----------------------
>  3 files changed, 23 insertions(+), 49 deletions(-)
> 
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
