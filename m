Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9D73A430D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFKNce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:32:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39828 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhFKNcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:32:33 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623418235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWbMv2syBe23vSIpKpZSJNGAHjCwekcNtnuniLaCLp0=;
        b=ebb+xNcYEhDfYppcg4jQDEaUoIu7TTeO3+R738VPnqZgd2X3w7lroI4layAyXO2Z//8ZjK
        Tzb083kccUsquE+IQ5rWFKbVUvTlkhTZoItVW6oeCuzRJEjub9ROIKcFrBEyQlBUQCv0sI
        1IHkgn0DXKRoUtgku2+RXga3uW32mxt06vW/pK7t0X1NwhbaL0N2pmR4wYk4UTCmZkOQsP
        YkzdFUosxzoUKXTxPj/Tx0jxMfikV2DbbLjmvzcGnLduFDTcgSKw4zNRuWfMn621XGehmu
        hX2h/WVMVZTtRAy06fnJgZkg3IfL4tEXG5tRFoUVSkC/1rcoygkAKPvGZMFhEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623418235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWbMv2syBe23vSIpKpZSJNGAHjCwekcNtnuniLaCLp0=;
        b=ApQeL3rth4rXrdTFLjJzO/zTsUjnStczxV+ov87kYawrMquo+TpkZLW+ulp/r+FS+4XPpY
        5DEIxBUU3WFlpSAA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/fpu: Rename "dynamic" XSTATEs to "independent"
In-Reply-To: <YMMYUGW9f7CUJ+oz@hirez.programming.kicks-ass.net>
References: <cover.1623388344.git.luto@kernel.org> <1eecb0e4f3e07828ebe5d737ec77dc3b708fad2d.1623388344.git.luto@kernel.org> <YMMYUGW9f7CUJ+oz@hirez.programming.kicks-ass.net>
Date:   Fri, 11 Jun 2021 15:30:34 +0200
Message-ID: <87sg1owmth.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2021 at 10:01, Peter Zijlstra wrote:
> On Thu, Jun 10, 2021 at 10:13:36PM -0700, Andy Lutomirski wrote:
> Yesterday tglx proposed the *save*_to_{user,kernel}() and
> *rstor*_from_{user,kernel}() namespace for pretty much every other such
> function.
>
> And while I agree that independent_supervisor beats dynamic_supervisor
> for a name, they're both stupid long :-(
>
> I don't suppose we can simply use xsaves_to_kernel()
> xstrors_from_kernel() and add some magic to their respective mask
> handling to ensure that a mask belongs to only 1 (of 3) types.
>
> 	int types = 0;
>
> 	if (mask & xfeatures_mask_user())
> 		type++;
> 	if (mask & xfeatures_mask_supervisor())
> 		types++;
> 	if (mask & xfeatures_mask_independent())
> 		types++;
>
> 	if (WARN_ON_ONCE(type != 1))
> 		return;

We basically have only two sets which are exclusive:

Features which end up in task->fpu.state.xstate and those independent
ones. Let me add something like this to the pile I have anyway.

I pick up the rename of the mask bits though, as this dynamic naming is
really bad. I'm not too happy with that independent name either, but
it's at least better.

Thanks,

        tglx


    
