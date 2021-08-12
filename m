Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAD33EA7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbhHLPqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:46:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59362 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbhHLPqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:46:02 -0400
Date:   Thu, 12 Aug 2021 17:45:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628783136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QshiZfmt8roqFylPYgpNuNADtG05X3lJ/LU9XWyCDhM=;
        b=GAE2j+r4El1NQXuPxSCxTWzyf2qZDNLQTURIA/5HzwpsVPT1sKn746GKvGVMpyzmSezuWO
        q7c83tvaN1Gs7HG4U57XH2NRAfGrsMi+CsdKbgXaqArnCDj3VZ7JSJbZQeBB8ryEo8LsOf
        j05gbxOyxu78dz3Gs1TwYS4PVZLTikxfIXEfLBxkf+acmZvR2cPbyolULfc87lPzGMBAcA
        dq0ERW3IOdn2rVO6xwOSkdlgMBVQEILS/+G+dNgooRqQxzJ+qVReWs7hvXVuHnPjUFVLTK
        G10kW/1KkGICffo/+juJWIamLvgojeocSelWcY9SA1L/sIdgg7lZkaAAg5xuPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628783136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QshiZfmt8roqFylPYgpNuNADtG05X3lJ/LU9XWyCDhM=;
        b=fKyyX/mUWRHmhOCGerSNU8baizPJjuM+9CRwVH/8a5S0F0FWu11luws8svdnC2a9bxrWbH
        u4rNI37NgrGQNCAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: debugobjects: Make them PREEMPT_RT aware
Message-ID: <20210812154534.zumt27b455dgrhls@linutronix.de>
References: <87sfzehdnl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sfzehdnl.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-12 17:43:26 [+0200], Thomas Gleixner wrote:
> On PREEMPT_RT enabled kernels it is not possible to refill the object pool
> from atomic context (preemption or interrupts disabled) as the allocator
> might acquire 'sleeping' spinlocks.
> 
> Guard the invocation of fill_pool() accordingly.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
