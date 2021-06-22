Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0B73B0B99
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhFVRmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:42:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59242 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhFVRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:42:41 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CE321FD45;
        Tue, 22 Jun 2021 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624383624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYtaeBxbiui3x36+0Wj1Y5L2FGIESTR8v4kqK1PRqSI=;
        b=0DqE/+VfB4K9/5ToAxxOtsLV2F06owChCc8+zbrQFLcwHBA5AxHP2lmiEp9xSl6V/9cCH8
        jDWyCuGTgcbfJ2tUOQMLprqthijtaAPN3shGFJT5yAUdW3d8kkVqfbBmXG7EwPBFBOAj+y
        cRR0oFllHKYm4wOQbtnXxImHW3l8G6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624383624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYtaeBxbiui3x36+0Wj1Y5L2FGIESTR8v4kqK1PRqSI=;
        b=6mZdjZsPy3ADOAItbXj9G0xkb9rdRVbmfRANZPoFZZx4Cx3Ij4o5Pw3F1Fwf07lfh+e5Lg
        p2TIyiJrCaPRaMAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 738C811A97;
        Tue, 22 Jun 2021 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624383624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYtaeBxbiui3x36+0Wj1Y5L2FGIESTR8v4kqK1PRqSI=;
        b=0DqE/+VfB4K9/5ToAxxOtsLV2F06owChCc8+zbrQFLcwHBA5AxHP2lmiEp9xSl6V/9cCH8
        jDWyCuGTgcbfJ2tUOQMLprqthijtaAPN3shGFJT5yAUdW3d8kkVqfbBmXG7EwPBFBOAj+y
        cRR0oFllHKYm4wOQbtnXxImHW3l8G6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624383624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYtaeBxbiui3x36+0Wj1Y5L2FGIESTR8v4kqK1PRqSI=;
        b=6mZdjZsPy3ADOAItbXj9G0xkb9rdRVbmfRANZPoFZZx4Cx3Ij4o5Pw3F1Fwf07lfh+e5Lg
        p2TIyiJrCaPRaMAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id PfjIG4gg0mAZTwAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 17:40:24 +0000
Date:   Tue, 22 Jun 2021 19:40:23 +0200
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
Subject: Re: [patch V3 60/66] x86/fpu/signal: Remove the legacy alignment
 check
Message-ID: <YNIgh8TDBZRdiqbY@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143451.217774510@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143451.217774510@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:23PM +0200, Thomas Gleixner wrote:
> Checking for the XSTATE buffer being 64 byte aligned and if not deciding
> just to restore the FXSR state is daft.
> 
> If user space provides an unaligned math frame and has the extended state
> magic set in the FX software reserved bytes, then it really can keep the
> pieces.
> 
> If the frame is unaligned and the FX software magic is not set, then
> fx_only is already set and the restore will use fxrstor.
> 
> Remove it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -306,9 +306,6 @@ static int __fpu_restore_sig(void __user
>  		}
>  	}
>  
> -	if ((unsigned long)buf_fx % 64)
> -		fx_only = 1;
> -
>  	if (!ia32_fxstate) {
>  		/*
>  		 * Attempt to restore the FPU registers directly from user

Nice, that was really daft.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
