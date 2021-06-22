Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39493B0B27
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhFVRLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:11:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57898 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFVRLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:11:10 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 892421FD36;
        Tue, 22 Jun 2021 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624381733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNLnb8zC8KS5LpPq575etT0i9Nf+c3/GWwiSlBQ0EXM=;
        b=xnXTrCGMAAJgEu/hjIBkBEqzr/4zRe216wTgokg1eUXP78u/5I+gPpfcaxANAzGeNS5Dfm
        aTuYtukmGNIctI5ZFvHqT0TypqCTfKTRtyce3TQPS9LE2smUQypGbC4uwHHofAZ16CIKOs
        IAOIsrpwTHr9dofbih1ZAmrVdPe+QsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624381733;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNLnb8zC8KS5LpPq575etT0i9Nf+c3/GWwiSlBQ0EXM=;
        b=E75eSKXix0clYSXAjowM7QBzwO9cbzbx7Njk+4bjvoYxyRIWRUjNXS6K9BN35iQwgPy0Ek
        8x7zncDYTWORfYBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 777B411A97;
        Tue, 22 Jun 2021 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624381733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNLnb8zC8KS5LpPq575etT0i9Nf+c3/GWwiSlBQ0EXM=;
        b=xnXTrCGMAAJgEu/hjIBkBEqzr/4zRe216wTgokg1eUXP78u/5I+gPpfcaxANAzGeNS5Dfm
        aTuYtukmGNIctI5ZFvHqT0TypqCTfKTRtyce3TQPS9LE2smUQypGbC4uwHHofAZ16CIKOs
        IAOIsrpwTHr9dofbih1ZAmrVdPe+QsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624381733;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNLnb8zC8KS5LpPq575etT0i9Nf+c3/GWwiSlBQ0EXM=;
        b=E75eSKXix0clYSXAjowM7QBzwO9cbzbx7Njk+4bjvoYxyRIWRUjNXS6K9BN35iQwgPy0Ek
        8x7zncDYTWORfYBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id O2oeHCUZ0mDPPgAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 17:08:53 +0000
Date:   Tue, 22 Jun 2021 19:08:52 +0200
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
Subject: Re: [patch V3 55/66] x86/fpu: Remove PKRU handling from
 switch_fpu_finish()
Message-ID: <YNIZJDUkaAOgNbDs@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143450.643422340@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143450.643422340@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:18PM +0200, Thomas Gleixner wrote:
> PKRU is already updated and the xstate is not longer the proper source of
> information.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |   34 ++++------------------------------
>  1 file changed, 4 insertions(+), 30 deletions(-)
> 
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -549,39 +549,13 @@ static inline void switch_fpu_prepare(st
>   */
>  
>  /*
> - * Load PKRU from the FPU context if available. Delay loading of the
> - * complete FPU state until the return to userland.
> + * Delay loading of the complete FPU state until the return to userland.
> + * PKRU is handled seperately.

separately

With that fixed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
