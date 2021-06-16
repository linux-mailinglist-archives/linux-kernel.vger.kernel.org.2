Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365633A9F19
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhFPPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:33:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39412 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbhFPPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:33:49 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2FFD1FD49;
        Wed, 16 Jun 2021 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623857503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e40TH999IVDY520meXAa6hXsslbXe/O+i/b5ytHr+EQ=;
        b=0WrqZSdS6amrdJerWDG87usl2tyA+SgTIYAF1/W6JlOgLBbevaOXtDUl+/vSOGymIrQh8L
        AQXDqa8YX3ThwX/pYj0tE8jjVd217Rakzwyv+Ztpv9r9WE3hOCRt0uiTCDffrMjZCaA/nB
        ud/PFhItZP5Qeznema52uwkhx/kj/Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623857503;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e40TH999IVDY520meXAa6hXsslbXe/O+i/b5ytHr+EQ=;
        b=5FHwl5g/veawnqPr2Qhhr8Gv7hDJ4KRHdGFDhz+Jj0h8wytDqK0PjsIxIt8ak/PzLFIh0+
        on71EscD7Qd1j8Aw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id DDB8C118DD;
        Wed, 16 Jun 2021 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623857502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e40TH999IVDY520meXAa6hXsslbXe/O+i/b5ytHr+EQ=;
        b=gDIBquk7IRoCphrdlo5TIx5F6uBTdaw+eghLLX1hh/g9N9sbsSle3EDN1sI23nhuQmBVia
        YaTmPQgi2ZAcAfyeoi8za5hj4svLDHuk5ReHBr8gOOd5ag9cwYoN+7ETACQu50BwWGL3ob
        FBMuwnRq7MSqVcXBVP80ToWgaCMAGwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623857502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e40TH999IVDY520meXAa6hXsslbXe/O+i/b5ytHr+EQ=;
        b=JoLXLtsIFGaEeLP6Azt4Rl5hhswoTYXAQhtpcZiRtI2KhrjmjQ7zDkew0QD2cOejVDpJ01
        8go2CrHbY9EiKUAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id jjKANV4ZymC5fwAALh3uQQ
        (envelope-from <bp@suse.de>); Wed, 16 Jun 2021 15:31:42 +0000
Date:   Wed, 16 Jun 2021 17:31:38 +0200
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
Subject: Re: [patch V2 12/52] x86/fpu: Fail ptrace() requests that try to set
 invalid MXCSR values
Message-ID: <YMoZWodsnqdgc0Rm@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155354.935915316@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155354.935915316@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:20PM +0200, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> We're not doing anyone any favors by accepting and silently changing an
> invalid MXCSR value supplied via ptrace().  Instead, return -EINVAL on
> invalid input.
> 
> If this breaks something, we can revert it.

Please use passive voice in your commit message: no "we" or "I", etc,

> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch. Picked up from Andy.
> ---
>  arch/x86/kernel/fpu/regset.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> ---
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -65,8 +65,9 @@ int xfpregs_set(struct task_struct *targ
>  	if (ret)
>  		return ret;
>  
> -	/* Mask invalid MXCSR bits (for historical reasons). */
> -	newstate.mxcsr &= mxcsr_feature_mask;
> +	/* Do not allow an invalid MXCSR value. */
> +	if (newstate.mxcsr & ~mxcsr_feature_mask)
> +		ret = -EINVAL;
>  
>  	fpu__prepare_write(fpu);

With that addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
