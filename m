Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19F63B0B85
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhFVRiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:38:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFVRiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:38:12 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5B6A72196A;
        Tue, 22 Jun 2021 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624383355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IaJqeQsHSH/MIe/2wOUqtl2luW+OgwGZahxXjgcHQdU=;
        b=sYg2TI++TvKJQq/voBNV7z20JF6O4dXqZuRYe3Ml2vq0lK1cYAEo8j3xKn2z1O4VWgP1WS
        /O4yapbGz27XAwiTxw5K+vTnZWT5tNuQzeEW25SpbBGoB9Oyn2kdGfgBWcE5q4VygApwSG
        DfSBo6YR5Y6+Xwh1uxvtQD0elvuqTmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624383355;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IaJqeQsHSH/MIe/2wOUqtl2luW+OgwGZahxXjgcHQdU=;
        b=gfJkcZlc3GNleJHqtWpvQkufs2yQt0tQDiONPmwG8Ptpjz0suo7sWWp6yz0pCyCUu7E9Rb
        FSWPgwHaRImznjAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 44BEC11A97;
        Tue, 22 Jun 2021 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624383355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IaJqeQsHSH/MIe/2wOUqtl2luW+OgwGZahxXjgcHQdU=;
        b=sYg2TI++TvKJQq/voBNV7z20JF6O4dXqZuRYe3Ml2vq0lK1cYAEo8j3xKn2z1O4VWgP1WS
        /O4yapbGz27XAwiTxw5K+vTnZWT5tNuQzeEW25SpbBGoB9Oyn2kdGfgBWcE5q4VygApwSG
        DfSBo6YR5Y6+Xwh1uxvtQD0elvuqTmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624383355;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IaJqeQsHSH/MIe/2wOUqtl2luW+OgwGZahxXjgcHQdU=;
        b=gfJkcZlc3GNleJHqtWpvQkufs2yQt0tQDiONPmwG8Ptpjz0suo7sWWp6yz0pCyCUu7E9Rb
        FSWPgwHaRImznjAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id oc0DEXsf0mDITAAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 17:35:55 +0000
Date:   Tue, 22 Jun 2021 19:35:50 +0200
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
Subject: Re: [patch V3 59/66] x86/fpu/signal: Move initial checks into
 fpu__sig_restore()
Message-ID: <YNIfdidWt/nRwIPa@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143451.099973627@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143451.099973627@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:22PM +0200, Thomas Gleixner wrote:

> Subject: Re: [patch V3 59/66] x86/fpu/signal: Move initial checks into fpu__sig_restore()

fpu__restore_sig() is the name.

> __fpu_sig_restore() is convoluted and some of the basic checks can trivialy be done
> in the calling function as well as the final error handling of clearing user state.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c |   76 +++++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 35 deletions(-)

...

> @@ -490,15 +464,47 @@ static inline int xstate_sigframe_size(v
>   */
>  int fpu__restore_sig(void __user *buf, int ia32_frame)
>  {
> +	unsigned int size = xstate_sigframe_size();
>  	void __user *buf_fx = buf;
> -	int size = xstate_sigframe_size();
> +	bool ia32_fxstate = false;
> +	int ret;
>  
> +	if (unlikely(!buf)) {
> +		fpu__clear_user_states(&current->thread.fpu);

You could declare

	struct fpu *fpu = &tsk->thread.fpu;

above so that it is easier to read, as this call is done twice.

Also, you can do:

	int ret = 0;

	if (unlikely(!buf))
		goto out;

so that the exit paths converge at the end.

> +		return 0;
> +	}
> +
> +	ia32_frame &= (IS_ENABLED(CONFIG_X86_32) ||
> +		       IS_ENABLED(CONFIG_IA32_EMULATION));
> +
> +	/*
> +	 * Only FXSR enabled systems need the FX state quirk.
> +	 * FRSTOR does not need it and can use the fast path.
> +	 */
>  	if (ia32_frame && use_fxsr()) {
>  		buf_fx = buf + sizeof(struct fregs_state);
>  		size += sizeof(struct fregs_state);
> +		ia32_fxstate = true;
> +	}
> +
> +	if (!access_ok(buf, size)) {
> +		ret = -EACCES;
> +		goto out;
> +	}
> +
> +	if (!IS_ENABLED(CONFIG_X86_64) && !static_cpu_has(X86_FEATURE_FPU)) {

cpu_feature_enabled()

> +		return fpregs_soft_set(current, NULL, 0,
> +				       sizeof(struct user_i387_ia32_struct),
> +				       NULL, buf);

Err, don't you need to catch retval into ret here and goto out, like
before, so that you can call fpu__clear_user_states() on error?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
