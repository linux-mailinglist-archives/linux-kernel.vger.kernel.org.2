Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B30C373CCB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhEEN6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhEEN6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:58:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A340C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uyz8xzhZhhl7+aXceUSGUjTe8+5pIspaVIlfaycBdow=; b=AwiE9sc1NbdYRXvQS6336r2ijI
        IVhdD8T8vODOTv4uL7RUFbFakuZ7AcQO4Vxevl4M6sougzxPHlIys5WenAPlQ4CewoavcO6rlPbfk
        axKQEoI5Y2aQn9VFz1FJ6nQRgE2gQ2IGRi0u3dUOaQVeEmh39jyJGlW4x3lNFWGUBP1ePsLfLAwV0
        6xyS7VywP2HbZ969iyHx3vaupHa2S+CWJFYa8q84uk4iU8zSpEZnD46Lw46SeXMx8FdQOw2Sqp6+y
        7c3fROJO3ABiKn7FfIlOPFA1kCT9r4y0gHGjzW2U8cZcBaPf8VvZWpUtuWXiUJV3f7IMm+Z4d/Kuk
        h+iOkBPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leI1s-001MUz-Mq; Wed, 05 May 2021 13:57:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C3B130022A;
        Wed,  5 May 2021 15:57:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52573203E67C2; Wed,  5 May 2021 15:57:32 +0200 (CEST)
Date:   Wed, 5 May 2021 15:57:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/8] tick/nohz updates v2
Message-ID: <YJKkTPQ1MpBCMZy3@hirez.programming.kicks-ass.net>
References: <20210422120158.33629-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422120158.33629-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:01:50PM +0200, Frederic Weisbecker wrote:
> Frederic Weisbecker (3):
>       tick/nohz: Remove superflous check for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
>       tick/nohz: Update nohz_full Kconfig help
>       tick/nohz: Only wakeup a single target cpu when kicking a task
> 
> Marcelo Tosatti (2):
>       tick/nohz: Change signal tick dependency to wakeup CPUs of member tasks
>       tick/nohz: Kick only _queued_ task whose tick dependency is updated
> 
> Yunfeng Ye (2):
>       tick/nohz: Conditionally restart tick on idle exit
>       tick/nohz: Update idle_exittime on actual idle exit
> 
> Peter Zijlstra (1):
>       tick/nohz: Evaluate the CPU expression after the static key
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
