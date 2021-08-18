Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2E3F0064
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhHRJ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhHRJ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:28:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD5C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:27:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cc300d1eeff563b8fec45.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:d1ee:ff56:3b8f:ec45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C76BE1EC0545;
        Wed, 18 Aug 2021 11:27:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629278864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITISNFiaflXSHrJa/kIubFFqquMC1witXfkRpKNhqyM=;
        b=dAk6m8driOq7XAdWCfMp+tInAQR6kEGRR8NQQqc/+48OcxNVX9VkpRRX+NeZodWSMXRqBk
        FBwsoG/JJ+WAW7xn/J3qrVQqzSRP25u3hpKZdtcsd3zmRpo+YdbFBtZywij/A/D3TZNX03
        AhJqm74DO1SD+jnvMUuyqi0GexvzcDQ=
Date:   Wed, 18 Aug 2021 11:28:24 +0200
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
Message-ID: <YRzSuC25eHEOgj6h@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com>
 <YRV6M1I/GMXwuJqW@zn.tnic>
 <2BF12EDA-89F0-40F7-B63E-50ADD0262164@intel.com>
 <YRZDu2Rk+KdRhh1U@zn.tnic>
 <2B279B5F-ACF2-46F2-9259-684419A57BDF@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2B279B5F-ACF2-46F2-9259-684419A57BDF@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 07:43:53PM +0000, Bae, Chang Seok wrote:
> Without the “compacted” notion in the function name, one might
> call this even with !XSAVES. But chances are very low in practice.

So leave only the first two which are obvious and are more likely to
happen - the first one is going to be the most likely on non-dynamic
setups and the second one is on dynamic systems.

For all the other configurations, just do the loop and that's it.

*IF* an optimization needs to happen there, then it can happen latter,
supplied with perf numbers to justify it.

> Perhaps, the call site in the ptrace path becomes like this, I think:
> 
> +	if (xfeatures_mask_user_dynamic) {
> +		u64 state_mask;
> +
> +		/* Retrieve XSTATE_BV. */
> +		memcpy(&state_mask, (kbuf ?: tmpbuf) + offsetof(struct xregs_state, header),
> +		       sizeof(u64));
> +
> +		/* Expand the xstate buffer based on the XSTATE_BV. */
> +		ret = realloc_xstate_buffer(fpu, state_mask & xfeatures_mask_user_dynamic);
> +		if (ret)
> +			goto out;
> +	}
> 
> Maybe retrieve XSTATE_BV is inevitable here. Then, it is not that ugly.

Lemme see if I can follow: here, a task is being ptraced and the tracer
process does PTRACE_SETREGS to set the xregs and you want to go and read
out the XSTATE_BV vector from the supplied xstate buffer to see how much
to enlarge the buffer.

Which makes me go, whut?

Why doesn't the task already have a large enough buffer?

IOW and IIUC, you should not have to ever resize the xstate buffer of a
task in ptrace.

> In this case, the ptracer just failed to inject some context. But the
> ptracee’s context in the (old) buffer is intact. It will resume and eventually
> exit. I think arch_release_task_struct()->free_xstate_buffer() will take care
> of the old buffer.

You think or you know?

How about verifying it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
