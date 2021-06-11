Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DFF3A4875
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFKSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:17:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53396 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhFKSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:17:26 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 109E81FD6D;
        Fri, 11 Jun 2021 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623435327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/FOfhrl3cCwqR9duZhfuHKDLkqxOBH1C/W+2xFM5CE=;
        b=xMXE2VGsRiDvWazXdj9/TDk98mC79JJOd08U0yNP8NA4bXtwPGdgPxPKeYKfErWU7nQ1Mm
        gLzBr5W8wjCQpVfhr1H6lp7E6xea7w0aVu+0h3TIfH75fkIGepHPuGMZWab5x4ZKSxtK0h
        pDmmbrYmrKpDFfJ1jAfKG+/DuRA6lHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623435327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/FOfhrl3cCwqR9duZhfuHKDLkqxOBH1C/W+2xFM5CE=;
        b=f5dEChXfAMh8bLgXRJSFmz3QN6xzRvCWvZNWDItIgCs2Eb63eJUiXInrFhO6vu1oj8fCGw
        /KuPYVZfOywPTyBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id EEEEF118DD;
        Fri, 11 Jun 2021 18:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623435327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/FOfhrl3cCwqR9duZhfuHKDLkqxOBH1C/W+2xFM5CE=;
        b=xMXE2VGsRiDvWazXdj9/TDk98mC79JJOd08U0yNP8NA4bXtwPGdgPxPKeYKfErWU7nQ1Mm
        gLzBr5W8wjCQpVfhr1H6lp7E6xea7w0aVu+0h3TIfH75fkIGepHPuGMZWab5x4ZKSxtK0h
        pDmmbrYmrKpDFfJ1jAfKG+/DuRA6lHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623435327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/FOfhrl3cCwqR9duZhfuHKDLkqxOBH1C/W+2xFM5CE=;
        b=f5dEChXfAMh8bLgXRJSFmz3QN6xzRvCWvZNWDItIgCs2Eb63eJUiXInrFhO6vu1oj8fCGw
        /KuPYVZfOywPTyBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id +MHfOT6ow2A6XAAALh3uQQ
        (envelope-from <bp@suse.de>); Fri, 11 Jun 2021 18:15:26 +0000
Date:   Fri, 11 Jun 2021 20:15:18 +0200
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
Subject: Re: [patch 05/41] x86/fpu: Limit xstate copy size in xstateregs_set()
Message-ID: <YMOoNnVB+np53N2L@zn.tnic>
References: <20210611161523.508908024@linutronix.de>
 <20210611163111.515164108@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210611163111.515164108@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 06:15:28PM +0200, Thomas Gleixner wrote:
> If the count argument is larger than the xstate size, this will happily
> copy beyond the end of xstate.
> 
> Fixes: 91c3dba7dbc1 ("x86/fpu/xstate: Fix PTRACE frames for XSAVES")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/regset.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -117,7 +117,7 @@ int xstateregs_set(struct task_struct *t
>  	/*
>  	 * A whole standard-format XSAVE buffer is needed:
>  	 */
> -	if ((pos != 0) || (count < fpu_user_xstate_size))
> +	if (pos != 0 || count != fpu_user_xstate_size)
>  		return -EFAULT;
>  
>  	xsave = &fpu->state.xsave;

Patches 3-5:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
