Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0B03B01BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhFVKu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:50:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44870 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFVKu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:50:56 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E90F71FD36;
        Tue, 22 Jun 2021 10:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624358919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=py31gcHUI3ac/dQQKwE/4yOR0O7IFiQk0rRPzx8umuM=;
        b=LiBMVD+3+J9oWUPNfcCkojqM5hAJ/SEC+Ey/ansajM9EtR/RTz2p2SteJvkIRjXT74XQCt
        yrtWT3DX92P5UkrcQGYQk50iUgv9L/NB+EZ4DBlQDKTwdk24ak5t+JuVF1RXbZjSxY18aP
        p6YLFkmhmGOuZwACyhYSNDWh4FFaiUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624358919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=py31gcHUI3ac/dQQKwE/4yOR0O7IFiQk0rRPzx8umuM=;
        b=jIql+bjcz2RWS31LvzpergHy5CkKF/7rHEtaN++L7nI1bs63Ex/sOo+0GBJJ1E41EW+EGn
        lHSnT/oft0T/cjBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D7CDC118DD;
        Tue, 22 Jun 2021 10:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624358919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=py31gcHUI3ac/dQQKwE/4yOR0O7IFiQk0rRPzx8umuM=;
        b=LiBMVD+3+J9oWUPNfcCkojqM5hAJ/SEC+Ey/ansajM9EtR/RTz2p2SteJvkIRjXT74XQCt
        yrtWT3DX92P5UkrcQGYQk50iUgv9L/NB+EZ4DBlQDKTwdk24ak5t+JuVF1RXbZjSxY18aP
        p6YLFkmhmGOuZwACyhYSNDWh4FFaiUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624358919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=py31gcHUI3ac/dQQKwE/4yOR0O7IFiQk0rRPzx8umuM=;
        b=jIql+bjcz2RWS31LvzpergHy5CkKF/7rHEtaN++L7nI1bs63Ex/sOo+0GBJJ1E41EW+EGn
        lHSnT/oft0T/cjBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id gIajMwfA0WAaWAAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 10:48:39 +0000
Date:   Tue, 22 Jun 2021 12:48:33 +0200
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
Subject: Re: [patch V3 36/66] x86/fpu: Rename initstate copy functions
Message-ID: <YNHAAeL59ox95f/T@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143448.485859910@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143448.485859910@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:59PM +0200, Thomas Gleixner wrote:
> Again this not a copy. It's loading register state.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -303,7 +303,7 @@ void fpu__drop(struct fpu *fpu)
>   * Clear FPU registers by setting them up from the init fpstate.
>   * Caller must do fpregs_[un]lock() around it.
>   */
> -static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
> +static inline void load_fpregs_from_init_fpstate(u64 features_mask)
>  {
>  	if (use_xsave())
>  		os_xrstor(&init_fpstate.xsave, features_mask);
> @@ -338,9 +338,9 @@ static void fpu__clear(struct fpu *fpu,
>  		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
>  		    xfeatures_mask_supervisor())
>  			os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
> -		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
> +		load_fpregs_from_init_fpstate(xfeatures_mask_user());
>  	} else {
> -		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
> +		load_fpregs_from_init_fpstate(xfeatures_mask_all);
>  	}

"load"?

I think you want "restore" here in accordance with the new convention,
like with the previous patch.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
