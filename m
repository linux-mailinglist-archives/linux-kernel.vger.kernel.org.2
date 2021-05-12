Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA037BCA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhELMiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhELMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:38:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D017C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EHo8Um/Yao4wgjlCL2kpN65vP23zytGFwA2JQrNZcRw=; b=mnHo6V0UlJh79ufuLEj3A/j2Fc
        ngaNrBAcwrSIJ1C+H1IqzDVVPTwopLMYtufPumnnf3kREjR5KwLUF1YWE8XZSk6tPsueLfxDdxqCL
        5ZZCnJIKLtzGYmqTn2MwwULWzikQlejNdf9YxBr+ikouYyeJFqAsiGlMupDq8s9+GZoSC/3mWxTfa
        H7r25X92pRL50BraZGBnq0sa/C3qIt6sI9mvApBKLHVuK56geSqqf9KEXO1uXBlwRqZuLJOvkQUo0
        oL4Yk1lp3cvM9IK7GAcuNtxpQcF2ZZsovgT3+c6111w1ABzoobpNIyniEQK6rpH/jLs8xfywQfJAJ
        vnzr9qrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgo74-002l9n-5V; Wed, 12 May 2021 12:37:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C94230026A;
        Wed, 12 May 2021 14:37:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DEEF2040BF87; Wed, 12 May 2021 14:37:12 +0200 (CEST)
Date:   Wed, 12 May 2021 14:37:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Correct calling tracepoints
Message-ID: <YJvL+IvlTtoNv2c7@hirez.programming.kicks-ass.net>
References: <20210512120937.90211-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512120937.90211-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 08:09:37PM +0800, Leo Yan wrote:
> The commit eb1f00237aca ("lockdep,trace: Expose tracepoints") reverses
> tracepoints for lock_contended() and lock_acquired(), thus the ftrace
> log shows the wrong locking sequence that "acquired" event is prior to
> "contended" event:
> 
>   <idle>-0       [001] d.s3 20803.501685: lock_acquire: 0000000008b91ab4 &sg_policy->update_lock
>   <idle>-0       [001] d.s3 20803.501686: lock_acquired: 0000000008b91ab4 &sg_policy->update_lock
>   <idle>-0       [001] d.s3 20803.501689: lock_contended: 0000000008b91ab4 &sg_policy->update_lock
>   <idle>-0       [001] d.s3 20803.501690: lock_release: 0000000008b91ab4 &sg_policy->update_lock
> 
> This patch fixes calling tracepoints for lock_contended() and
> lock_acquired().
> 
> Fixes: eb1f00237aca ("lockdep,trace: Expose tracepoints")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

No idea how that happened, curious. Thanks for fixing though!
