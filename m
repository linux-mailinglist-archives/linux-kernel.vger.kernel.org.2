Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F113EB3C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 12:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbhHMKEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 06:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbhHMKEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 06:04:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941B8C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 03:04:12 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a0d0079874d21390dee82.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d00:7987:4d21:390d:ee82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA33F1EC0390;
        Fri, 13 Aug 2021 12:04:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628849046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31zyKUHINqLqvJ/u79cT27oFOJRihlG6WNUrS0PPwwk=;
        b=IYVcJkUb2TlVzgWJzR0D6y4OupxQ+cJBkVHA+ulGIuBHcmnwTPxzj8OwFD0Q67IqbOi7NR
        eyAW/EtwH2o964XsVmthOsEYeafM9+TW3OffoW83VeL/a1wmAYf64KVWw1RWBqqEA9FKQ6
        EakahJuNdbhb93/sSVg4CjvjP8GZsXI=
Date:   Fri, 13 Aug 2021 12:04:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Message-ID: <YRZDu2Rk+KdRhh1U@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com>
 <YRV6M1I/GMXwuJqW@zn.tnic>
 <2BF12EDA-89F0-40F7-B63E-50ADD0262164@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2BF12EDA-89F0-40F7-B63E-50ADD0262164@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 08:04:54AM +0000, Bae, Chang Seok wrote:
> Yes, each state offset in the non-compacted format is fixed in a machine
> regardless of RFBM. So, simply take the size like that.

Comment above it please.

Also, why is this special case needed at all?

> But it might be better to simplify this hunk for readability. I
> suspect its call sites are not that performance-critical.

That's *exactly* what I'm driving at!

> Every task’s state_mask should begin as aligned with the default buffer.
> fpu_clone() sets this for all, except init_task.
> Maybe:
>     “Make sure init_task’s state_mask aligned with its __default_state"

Why "make sure"?

There's nothing to make sure - it is simply so that initially, the FPU
buffer used is the static one, without dynamic states. Just say that
instead.

> How about enlarge_xstate_buffer() or realloc_xstate_buffer()?

realloc is fine along with a proper explanation above it why the realloc
is done/needed.

> The query is intended to check whether the xstate buffer is fully expanded or
> not -- no need to enlarge.
> 
> If the buffer is already the maximum, the code to retrieve XSTATE_BV, this
> call, etc should be skipped there.  
> 
> If the query is moved here, I guess this call site code becomes a bit ugly.

Why does it become ugly?

You simply return early without touching the buffer at all.

> No, it is still pointed by fpu->state and will be freed in the exit path.

Exit path of the task?

All I see is "return -ENOMEM" and no callers of alloc_xstate_buffer()
are calling free_xstate_buffer()...

And looking further into the patchset:

exc_device_not_available does not call free_xstate_buffer() I'm assuming

	force_sig_fault(SIGILL, ILL_ILLOPC,..

later will cause arch_release_task_struct() to happen which will call
free_xstate_buffer(). Yes, no?

I don't see any freeing in xstateregs_set() either, so what's happening
there when it returns -ENOMEM?

I guess there we remain with the old buffer, i.e., the ptrace operation
fails.

Am I close?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
