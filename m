Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA43AB370
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhFQMYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:24:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58706 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhFQMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:24:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E98621AC4;
        Thu, 17 Jun 2021 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623932541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqNSyF4gbT7gFuwt4YELo2s1nT/0l6nL2O+rK1T16yc=;
        b=deqf/YO3dPJb9RmFtVJsPyQCcj6zYcHWXi5PqibVrzl+pz0py2HmUjsO25vOzlfazb7rBi
        FXL5voLcJVq8O/ByQvkhGy6I8IALxNvZEGRl3yi9FxlA7oAr0rknBS+Hyu2b2/paj3XmvW
        +PBP2gCtnTv+2TptM9sZuJV2XbT5jF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623932541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqNSyF4gbT7gFuwt4YELo2s1nT/0l6nL2O+rK1T16yc=;
        b=Fxxj6yqVFxgQ4ZNl81EGodlvENkYVz/zCIyHm+vTOjHNYAHDb7dAcXCwClHzDo6HN4b6wM
        /AoTWSnN/yW0QCDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6BF42118DD;
        Thu, 17 Jun 2021 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623932541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqNSyF4gbT7gFuwt4YELo2s1nT/0l6nL2O+rK1T16yc=;
        b=deqf/YO3dPJb9RmFtVJsPyQCcj6zYcHWXi5PqibVrzl+pz0py2HmUjsO25vOzlfazb7rBi
        FXL5voLcJVq8O/ByQvkhGy6I8IALxNvZEGRl3yi9FxlA7oAr0rknBS+Hyu2b2/paj3XmvW
        +PBP2gCtnTv+2TptM9sZuJV2XbT5jF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623932541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqNSyF4gbT7gFuwt4YELo2s1nT/0l6nL2O+rK1T16yc=;
        b=Fxxj6yqVFxgQ4ZNl81EGodlvENkYVz/zCIyHm+vTOjHNYAHDb7dAcXCwClHzDo6HN4b6wM
        /AoTWSnN/yW0QCDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id smhAGX0+y2CjIQAALh3uQQ
        (envelope-from <bp@suse.de>); Thu, 17 Jun 2021 12:22:21 +0000
Date:   Thu, 17 Jun 2021 14:22:11 +0200
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
Subject: Re: [patch V2 20/52] x86/fpu: Cleanup arch_set_user_pkey_access()
Message-ID: <YMs+cwXZGrEf2gI/@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155355.744726133@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155355.744726133@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:28PM +0200, Thomas Gleixner wrote:
> The function is having a sanity check with a WARN_ON_ONCE() but happily

"The function does a sanity check..."

> proceeds when the pkey argument is out of range.
> 
> Clean it up.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/xstate.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -887,11 +887,10 @@ EXPORT_SYMBOL_GPL(get_xsave_addr);
>   * rights for @pkey to @init_val.
>   */
>  int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> -		unsigned long init_val)
> +			      unsigned long init_val)
>  {
> -	u32 old_pkru;
> -	int pkey_shift = (pkey * PKRU_BITS_PER_PKEY);
> -	u32 new_pkru_bits = 0;
> +	u32 old_pkru, new_pkru_bits = 0;
> +	int pkey_shift;
>  
>  	/*
>  	 * This check implies XSAVE support.  OSPKE only gets

There's a boot_cpu_has() check

<--- here

Might wanna convert it to cpu_feature_enabled(), while at it.

> @@ -905,7 +904,8 @@ int arch_set_user_pkey_access(struct tas
>  	 * values originating from in-kernel users.  Complain
>  	 * if a bad value is observed.
>  	 */
> -	WARN_ON_ONCE(pkey >= arch_max_pkey());
> +	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
> +		return -EINVAL;
>  
>  	/* Set the bits we need in PKRU:  */
>  	if (init_val & PKEY_DISABLE_ACCESS)
> @@ -914,6 +914,7 @@ int arch_set_user_pkey_access(struct tas
>  		new_pkru_bits |= PKRU_WD_BIT;
>  
>  	/* Shift the bits in to the correct place in PKRU for pkey: */
> +	pkey_shift = pkey * PKRU_BITS_PER_PKEY;
>  	new_pkru_bits <<= pkey_shift;
>  
>  	/* Get old PKRU and mask off any old bits in place: */

With those addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
