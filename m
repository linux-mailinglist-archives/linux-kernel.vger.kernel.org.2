Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9435F455E61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhKROlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhKROlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:41:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E84C061748;
        Thu, 18 Nov 2021 06:38:53 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:38:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KZMtINu1WcS6ZgDUnnQ1TAEde/yv9KiRpZ6mIuB/Vwc=;
        b=PwGOHhstHCGk8SS5ZVZk56mjbs4Pi8nccZckKKpOea6IapfTf28Vi1ezo1zwex08OF5Y9n
        R0dId/TBZkkMHWHH/nG15F07sLAj8vIysR5fyUqR/G9sP+9OVykn5241sH2267CrXxm099
        UVtOloKNVXduqF5O10j9CVy7zAh8xroUBGPFNQplAeGiCr9/dbVIKw7yjcmdtQg55sEDRn
        qyUq3CVFVI5UMDPJrEAa9AX2f69UnkS4nh+BJsyAUIftswGHhsdCrNXtdiIfFgmFx9JvW+
        T2S1233RDqAbIQmYDjLalv0sbUtgFHzjKgcttr0h0ovkNu+u+hQkvV/Qkf+ekg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KZMtINu1WcS6ZgDUnnQ1TAEde/yv9KiRpZ6mIuB/Vwc=;
        b=/kNBxa0bBpdp02eD+JehFXt27OW+exJeK7LRdOYhUX34hvnCAjmHILsScs76LmrogXCgXs
        O9uBXxyOtz2r/tAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        tglx@linutronix.de
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 0/8] kernel/fork: Move thread stack free otu of the
 scheduler path.
Message-ID: <20211118143850.ygpp7xetpz3pt2nj@linutronix.de>
References: <20211118143452.136421-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118143452.136421-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ tglx.

It starts at
   https://lore.kernel.org/all/20211118143452.136421-1-bigeasy@linutronix.de/

On 2021-11-18 15:34:44 [+0100], To linux-kernel@vger.kernel.org wrote:
> 
> This is a follup-up on the patch
>     sched: Delay task stack freeing on RT 
>     https://lkml.kernel.org/r/20210928122411.593486363@linutronix.de
> 
> It addresses the review feedback:
> - Decouple stack accounting from its free invocation. The accounting
>   happens in do_exit(), the final free call happens later.
> 
> - Add put_task_stack_sched() to finish_task_switch(). Here the VMAP
>   stack is cached only. If it fails, or in the !VMAP case then the final
>   free happens in delayed_put_task_struct(). This is also an oportunity
>   to cache the stack.

Sebastian
