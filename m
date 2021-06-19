Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99763AD8A1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 10:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhFSIhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 04:37:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58582 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbhFSIhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 04:37:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7B1951FD2D;
        Sat, 19 Jun 2021 08:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624091703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+MjFqL+kLBlA8ILICgJ1s2xiR+V4tpKyupBnPQjWVI=;
        b=2TPmR165IiCFkKmw8g+5DX17lW1HU9W4RL4keeI328TBsuTDRPJCov8UYldh71mXEpGvYF
        ng87vt+V4KJEgc0c09Vif8J4ygrDLfTEtSDVNdI7R5CPjbTArvmU0+DbLx2DmKz/H1G2/7
        zh2ed8uzS+ohClI5g9uhVLDM+eT1HkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624091703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+MjFqL+kLBlA8ILICgJ1s2xiR+V4tpKyupBnPQjWVI=;
        b=QSB6bRJm0LvxXyhXcqNKvKdCXMP3VT/G+tdmMWBD2HqW46OYLa58kDzaUacdrg0SYzV6MM
        0PdVbR7h+n8067BQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 62DA1118DD;
        Sat, 19 Jun 2021 08:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624091703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+MjFqL+kLBlA8ILICgJ1s2xiR+V4tpKyupBnPQjWVI=;
        b=2TPmR165IiCFkKmw8g+5DX17lW1HU9W4RL4keeI328TBsuTDRPJCov8UYldh71mXEpGvYF
        ng87vt+V4KJEgc0c09Vif8J4ygrDLfTEtSDVNdI7R5CPjbTArvmU0+DbLx2DmKz/H1G2/7
        zh2ed8uzS+ohClI5g9uhVLDM+eT1HkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624091703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+MjFqL+kLBlA8ILICgJ1s2xiR+V4tpKyupBnPQjWVI=;
        b=QSB6bRJm0LvxXyhXcqNKvKdCXMP3VT/G+tdmMWBD2HqW46OYLa58kDzaUacdrg0SYzV6MM
        0PdVbR7h+n8067BQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id OyGBFzeszWBkQAAALh3uQQ
        (envelope-from <bp@suse.de>); Sat, 19 Jun 2021 08:35:03 +0000
Date:   Sat, 19 Jun 2021 10:34:53 +0200
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
Subject: Re: [patch V3 01/66] x86/fpu: x86/fpu: Preserve supervisor states in
 sanitize_restored_user_xstate()
Message-ID: <YM2sLY56q4LIxv6t@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143444.438635017@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143444.438635017@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:24PM +0200, Thomas Gleixner wrote:
> Subject: Re: [patch V3 01/66] x86/fpu: x86/fpu: Preserve supervisor states in

Prefix repeated.

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> sanitize_restored_user_xstate() preserves the supervisor states only
> when the fx_only argument is zero, which allows unpriviledged user space
> to put supervisor states back into init state.

Yikes.

> Preserve them unconditionally.
> 
> Fixes: 5d6b6a6f9b5c ("x86/fpu/xstate: Update sanitize_restored_xstate() for supervisor xstates")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/kernel/fpu/signal.c |   26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -221,28 +221,18 @@ sanitize_restored_user_xstate(union fpre
>  
>  	if (use_xsave()) {
>  		/*
> -		 * Note: we don't need to zero the reserved bits in the
> -		 * xstate_header here because we either didn't copy them at all,
> -		 * or we checked earlier that they aren't set.
> +		 * Clear all features bit which are not set in

			    feature bits

> +		 * user_xfeatures and clear all extended features
> +		 * for fx_only mode.
>  		 */
> +		u64 mask = fx_only ? XFEATURE_MASK_FPSSE : user_xfeatures;
>  
>  		/*
> -		 * 'user_xfeatures' might have bits clear which are
> -		 * set in header->xfeatures. This represents features that
> -		 * were in init state prior to a signal delivery, and need
> -		 * to be reset back to the init state.  Clear any user
> -		 * feature bits which are set in the kernel buffer to get
> -		 * them back to the init state.
> -		 *
> -		 * Supervisor state is unchanged by input from userspace.
> -		 * Ensure supervisor state bits stay set and supervisor
> -		 * state is not modified.
> +		 * Supervisor state has to be preserved. The sigframe
> +		 * restore can only modify user features, i.e. @mask
> +		 * cannot contain them.
>  		 */
> -		if (fx_only)
> -			header->xfeatures = XFEATURE_MASK_FPSSE;
> -		else
> -			header->xfeatures &= user_xfeatures |
> -					     xfeatures_mask_supervisor();
> +		header->xfeatures &= mask | xfeatures_mask_supervisor();

With those addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
