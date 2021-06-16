Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900243AA674
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhFPWEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbhFPWEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:04:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6275DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 15:02:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623880963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnT/4epHf0bysIg0cEhDRAfssOJxHCObmZ98BFBDTfs=;
        b=ZepVAtgkilR+yKEiIDVPbSC+YjUrgij7PpK6RUaIWhhEBnWtkYLT13Za851+9EZzQkm+rq
        hG/PZNhScLlMy/XDj2x47e2YenqpGz8UTPAe+FUaEuqmkWKx5bUaLdkrafCc0ZYnIgoYrQ
        ShzMxCvL0X0B3gZscmSleI/aqBaRGO0PZ7QLfsN6gdhYm6mDSLWk4+uoLZHXnHUIOYpkv+
        7wiBMh18rU2JeG1p6rzxHs5sQRPk2iUzxFODWhGsDh7XCL7gcHJwbBFbFf0YMvn6CIVBTw
        d28xbZJDKh4q3wlvEvHYlfbrXqhs4DS28nu7gx7R9gWnhQZ99xNmxyBYjWvpeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623880963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnT/4epHf0bysIg0cEhDRAfssOJxHCObmZ98BFBDTfs=;
        b=+3k77V9DRBHSzWsYcx7mvhZb4f0+L2MGHWT9S4Z7qav+ayWZUk5chp42j0luU4sJF6He22
        HZQIDBFw15u7ZqBA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V2 02/52] x86/fpu: Fix copy_xstate_to_kernel() gap handling
In-Reply-To: <20210614155353.825709513@linutronix.de>
References: <20210614154408.673478623@linutronix.de> <20210614155353.825709513@linutronix.de>
Date:   Thu, 17 Jun 2021 00:02:42 +0200
Message-ID: <874kdxh3i5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14 2021 at 17:44, Thomas Gleixner wrote:
> The gap handling in copy_xstate_to_kernel() is wrong in two aspects when
> XSAVES is in use.
>
>   1) Copying of xstate.i387.xmm_space is only copied when the SSE feature
>      bit is set. This is not correct because YMM (AVX) shares the XMM space
>      and that state must also be copied if only the YMM feature bit set
>      like already done for MXCSR.

Thinking more about it. That'd be broken in hardware. When YMM is not in
init state then SSE cannot be in init state.

Of course you can use xsave, then clear the SSE bit and XRSTOR which
blows away the SSE state. Or clear the bit in the sigframe. So copying
it over is silly as XRSTOR will ignore it anyway. If so, user space can
keep the pieces. Let me take that out.

This stuff drives me nuts.

Thanks,

        tglx

