Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3063A9E77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhFPPFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:05:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42500 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhFPPFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:05:03 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C871821A56;
        Wed, 16 Jun 2021 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623855776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIE3/2GOODFL10IY6yr1GOK4qw19CkZ8cooDQXO5v2c=;
        b=S2Bx/cTT9k7teRWcZxcMEC73FjdoNj1HChWaZWcFSsi7+6muVIqe+/3gkvEjpCsDwMta6S
        Ul4NkxI9eWVJ5owyfkpnknlimxQq2PVVP3Lf5KPxQenHOGK6vJpV6dicmwOl/9WRP7HlqG
        39cTBgbel61Q+mMeCjigptXdkM7qBTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623855776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIE3/2GOODFL10IY6yr1GOK4qw19CkZ8cooDQXO5v2c=;
        b=ONwaD7zuUI4R730yxODLLTVizy7ecYYkX8KCqhLRAhF5zDJjyFkSL771XKfs3CIigi9iYr
        EDP/xZ+CaB7G8JAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B58E9118DD;
        Wed, 16 Jun 2021 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623855776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIE3/2GOODFL10IY6yr1GOK4qw19CkZ8cooDQXO5v2c=;
        b=S2Bx/cTT9k7teRWcZxcMEC73FjdoNj1HChWaZWcFSsi7+6muVIqe+/3gkvEjpCsDwMta6S
        Ul4NkxI9eWVJ5owyfkpnknlimxQq2PVVP3Lf5KPxQenHOGK6vJpV6dicmwOl/9WRP7HlqG
        39cTBgbel61Q+mMeCjigptXdkM7qBTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623855776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIE3/2GOODFL10IY6yr1GOK4qw19CkZ8cooDQXO5v2c=;
        b=ONwaD7zuUI4R730yxODLLTVizy7ecYYkX8KCqhLRAhF5zDJjyFkSL771XKfs3CIigi9iYr
        EDP/xZ+CaB7G8JAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 6vtuK6ASymDtbwAALh3uQQ
        (envelope-from <bp@suse.de>); Wed, 16 Jun 2021 15:02:56 +0000
Date:   Wed, 16 Jun 2021 17:02:45 +0200
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
Subject: Re: [patch V2 09/52] x86/fpu: Reject invalid MXCSR values in
 copy_kernel_to_xstate()
Message-ID: <YMoSlfxR8dbjwnCe@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155354.630211386@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155354.630211386@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:17PM +0200, Thomas Gleixner wrote:
> Instead of masking out reserved bits, check them and reject the provided
> state as invalid if not zero.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  arch/x86/kernel/fpu/xstate.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1166,6 +1166,14 @@ int copy_kernel_to_xstate(struct xregs_s
>  	if (validate_user_xstate_header(&hdr))
>  		return -EINVAL;
>  
> +	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {

Since we're cleaning up this FPU stinking pile - that function needs to
have a verb in the name, something like:

	if (xfeatures_mxcsr_quirk_needed(...))

but that's unrelated to here and as a note to whoever gets to get to it
first.

> +		const u32 *mxcsr = kbuf + offsetof(struct fxregs_state, mxcsr);
> +
> +		/* Reserved bits in MXCSR must be zero. */
> +		if (*mxcsr & ~mxcsr_feature_mask)
> +			return -EINVAL;
> +	}

Btw, that function has another

	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {

branch already below the loop.

Should we merge both? Diff ontop of yours:

---
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 5d032c48f39d..30022d3fcd4a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1172,6 +1172,11 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 		/* Reserved bits in MXCSR must be zero. */
 		if (*mxcsr & ~mxcsr_feature_mask)
 			return -EINVAL;
+
+		offset = offsetof(struct fxregs_state, mxcsr);
+		size = MXCSR_AND_FLAGS_SIZE;
+
+		memcpy(&xsave->i387.mxcsr, kbuf + offset, size);
 	}
 
 	for (i = 0; i < XFEATURE_MAX; i++) {
@@ -1187,12 +1192,6 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 		}
 	}
 
-	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
-		offset = offsetof(struct fxregs_state, mxcsr);
-		size = MXCSR_AND_FLAGS_SIZE;
-		memcpy(&xsave->i387.mxcsr, kbuf + offset, size);
-	}
-
 	/*
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
