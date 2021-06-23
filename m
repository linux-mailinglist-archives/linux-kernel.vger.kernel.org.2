Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B73B3B164C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhFWI7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:59:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49118 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhFWI7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:59:18 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 91E841FD67;
        Wed, 23 Jun 2021 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624438620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKs6XUcYopZiUDYRQwQVPKKH9u3OF6a4BuAazEEupuE=;
        b=HSsY+ZZtAXSVcJo0NvYN4JsXMo1KUq3EpxjT0CbWmaGu3Jzq7aoRzvS+ShtPlFS8/NzBkY
        Xc2W3f8Wekmik4Y6n2vEyURaEWeFbWw7AiDVBDwGK2MyF8N3JbEb5YIb6+/+P6eU+DPLQ1
        BN0Ul9nXaZ7s8+5a8Cb2aj5IP7CAHsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624438620;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKs6XUcYopZiUDYRQwQVPKKH9u3OF6a4BuAazEEupuE=;
        b=tOA2cUS1Pc1dAfQX2Wt4hNzTRfBC/GNg97Qd591lOVTF/jofLmiCrdzZu3I6LU91oFPLkM
        q+OF3D1XiQnNP7Cg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7947811A97;
        Wed, 23 Jun 2021 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624438620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKs6XUcYopZiUDYRQwQVPKKH9u3OF6a4BuAazEEupuE=;
        b=HSsY+ZZtAXSVcJo0NvYN4JsXMo1KUq3EpxjT0CbWmaGu3Jzq7aoRzvS+ShtPlFS8/NzBkY
        Xc2W3f8Wekmik4Y6n2vEyURaEWeFbWw7AiDVBDwGK2MyF8N3JbEb5YIb6+/+P6eU+DPLQ1
        BN0Ul9nXaZ7s8+5a8Cb2aj5IP7CAHsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624438620;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKs6XUcYopZiUDYRQwQVPKKH9u3OF6a4BuAazEEupuE=;
        b=tOA2cUS1Pc1dAfQX2Wt4hNzTRfBC/GNg97Qd591lOVTF/jofLmiCrdzZu3I6LU91oFPLkM
        q+OF3D1XiQnNP7Cg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id gfkKHVz30mAnLQAALh3uQQ
        (envelope-from <bp@suse.de>); Wed, 23 Jun 2021 08:57:00 +0000
Date:   Wed, 23 Jun 2021 10:56:53 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V3 66/66] x86/fpu/signal: Let xrstor handle the features
 to init
Message-ID: <YNL3VXx9QiizOo0T@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143451.901164303@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143451.901164303@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:29PM +0200, Thomas Gleixner wrote:
> There is no reason to do an extra XRSTOR from initfp_state for feature bits
> which have been cleared by user space in the FX magic xfeatures storage.
> 
> Just clear them in the task's XSTATE header and do a full restore which
> will put these cleared features into init state.
> 
> There is no real difference in performance because the current code already
> does a full restore when the xfeatures bits are preserved as the signal
> frame setup has stored them, which is the full UABI feature set.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c |   92 +++++++++++++++----------------------------
>  1 file changed, 33 insertions(+), 59 deletions(-)

...

> @@ -390,54 +362,56 @@ static int __fpu_restore_sig(void __user
>  		set_thread_flag(TIF_NEED_FPU_LOAD);
>  	}
>  	__fpu_invalidate_fpregs_state(fpu);
> +	__cpu_invalidate_fpregs_state();
>  	fpregs_unlock();
>  
>  	if (use_xsave() && !fx_only) {
> -		u64 init_bv = xfeatures_mask_uabi() & ~user_xfeatures;
> -
> -		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
> +		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave,
> +							buf_fx);

Why? Just let it stick out.

Regardless,

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
