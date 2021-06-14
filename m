Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE113A6EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhFNTRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:17:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48132 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbhFNTRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:17:41 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D42E3219A1;
        Mon, 14 Jun 2021 19:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623698137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFKWmKxcY2uwyqEckSpBrr89WgMLR1uS0uOPzy/Z8sk=;
        b=e/MJnQBoMwn1BgbXCZo5MDxbNBD7EyW2oKNkhHxtqqbMnydNynxKa4RKFlsmjXVuRVZ/8p
        mdJBngKgCXlo480Rqi6HkiFuhxogWuAuqG+rCeaWKgAfzA48BZPbh4oSBv+h/jmMa8qVLB
        1/ZPXmKC6luySUSWn9CtNYuMKN7vPVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623698137;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFKWmKxcY2uwyqEckSpBrr89WgMLR1uS0uOPzy/Z8sk=;
        b=wfhbs0zitTcEeN2wvKQNtL4wWPwvexl4kPHAwiKYEt6PiPBkReBDIjbLWHXOoMYY768LQj
        74LioLvd9/suJaDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C06AF118DD;
        Mon, 14 Jun 2021 19:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623698137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFKWmKxcY2uwyqEckSpBrr89WgMLR1uS0uOPzy/Z8sk=;
        b=e/MJnQBoMwn1BgbXCZo5MDxbNBD7EyW2oKNkhHxtqqbMnydNynxKa4RKFlsmjXVuRVZ/8p
        mdJBngKgCXlo480Rqi6HkiFuhxogWuAuqG+rCeaWKgAfzA48BZPbh4oSBv+h/jmMa8qVLB
        1/ZPXmKC6luySUSWn9CtNYuMKN7vPVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623698137;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFKWmKxcY2uwyqEckSpBrr89WgMLR1uS0uOPzy/Z8sk=;
        b=wfhbs0zitTcEeN2wvKQNtL4wWPwvexl4kPHAwiKYEt6PiPBkReBDIjbLWHXOoMYY768LQj
        74LioLvd9/suJaDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id zFb0Ldmqx2DAFQAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 14 Jun 2021 19:15:37 +0000
Date:   Mon, 14 Jun 2021 21:15:27 +0200
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
Subject: Re: [patch V2 01/52] x86/fpu: Make init_fpstate correct with
 optimized XSAVE
Message-ID: <YMeqz6rav7V5UlLC@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155353.658707307@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155353.658707307@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:09PM +0200, Thomas Gleixner wrote:
> @@ -466,10 +489,20 @@ static void __init setup_init_fpu_buf(vo
>  	copy_kernel_to_xregs_booting(&init_fpstate.xsave);
>  
>  	/*
> -	 * Dump the init state again. This is to identify the init state
> -	 * of any feature which is not represented by all zero's.
> +	 * All components are now in init state. Read the state back so
> +	 * that init_fpstate contains all non-zero init state. This is only
> +	 * working with XSAVE,

"This only works with XSAVE, ... "


> but not with XSAVEOPT and XSAVES because
> +	 * those use the init optimization which skips writing data for
> +	 * components in init state.

<--- Add a newline in the comment here so that it is not as dense.

> So XSAVE could be used, but that would
> +	 * require to reshuffle the data when XSAVES is available because
> +	 * XSAVES uses xstate compaction. But doing so is a pointless
> +	 * exercise because most components have an all zeros init state
> +	 * except for the legacy ones (FP and SSE). Those can be saved with
> +	 * FXSAVE into the legacy area. Adding new features requires to
> +	 * ensure that init state is all zeroes or if not to add the
> +	 * necessary handling here.
>  	 */
> -	copy_xregs_to_kernel_booting(&init_fpstate.xsave);
> +	fxsave_to_kernel(&init_fpstate.fxsave);

With those fixed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
