Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929E83AB34A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhFQMLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:11:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56592 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhFQMLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:11:44 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6789C21AAF;
        Thu, 17 Jun 2021 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623931776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zf1PZcsWl5sHjafZT4XLuZyzuMtooZSh0kC7gjynjXM=;
        b=L9jlI6SdIlJXp9nR48+e68MCSscnPO70jY3et2F54pV1R6R+qeLz48oEiA0rJ76YXAIsNN
        IUmwyWoT3FXBNT5R9GjmPx5xqRaWIDuuUgrNIZ6cQfjBS7h6XygibUKoptdz6/oNkHmxsy
        nO9nJ05nqfer2UaxIuZEi8q/t+tD4LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623931776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zf1PZcsWl5sHjafZT4XLuZyzuMtooZSh0kC7gjynjXM=;
        b=xNmxaOlVAnpyaM9UpjL/UhyicW433ZiMaD3w2OhANlVgjKdEZBmDDcrzvpOdBswEp7CS+l
        Gedz6N9AB5DmV2AA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5064C118DD;
        Thu, 17 Jun 2021 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623931776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zf1PZcsWl5sHjafZT4XLuZyzuMtooZSh0kC7gjynjXM=;
        b=L9jlI6SdIlJXp9nR48+e68MCSscnPO70jY3et2F54pV1R6R+qeLz48oEiA0rJ76YXAIsNN
        IUmwyWoT3FXBNT5R9GjmPx5xqRaWIDuuUgrNIZ6cQfjBS7h6XygibUKoptdz6/oNkHmxsy
        nO9nJ05nqfer2UaxIuZEi8q/t+tD4LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623931776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zf1PZcsWl5sHjafZT4XLuZyzuMtooZSh0kC7gjynjXM=;
        b=xNmxaOlVAnpyaM9UpjL/UhyicW433ZiMaD3w2OhANlVgjKdEZBmDDcrzvpOdBswEp7CS+l
        Gedz6N9AB5DmV2AA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id jqPNE4A7y2DmGgAALh3uQQ
        (envelope-from <bp@suse.de>); Thu, 17 Jun 2021 12:09:36 +0000
Date:   Thu, 17 Jun 2021 14:09:31 +0200
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
Subject: Re: [patch V2 19/52] x86/kvm: Avoid looking up PKRU in XSAVE buffer
Message-ID: <YMs7exTqkCwdCKkM@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155355.646122849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155355.646122849@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:27PM +0200, Thomas Gleixner wrote:
> @@ -4632,18 +4633,20 @@ static void load_xsave(struct kvm_vcpu *
>  	 */
>  	valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
>  	while (valid) {
> +		u32 size, offset, ecx, edx;
>  		u64 xfeature_mask = valid & -valid;
>  		int xfeature_nr = fls64(xfeature_mask) - 1;
> -		void *dest = get_xsave_addr(xsave, xfeature_nr);
>  
> -		if (dest) {
> -			u32 size, offset, ecx, edx;
> -			cpuid_count(XSTATE_CPUID, xfeature_nr,
> -				    &size, &offset, &ecx, &edx);
> -			if (xfeature_nr == XFEATURE_PKRU)
> -				memcpy(&vcpu->arch.pkru, src + offset,
> -				       sizeof(vcpu->arch.pkru));
> -			else
> +		cpuid_count(XSTATE_CPUID, xfeature_nr,
> +			    &size, &offset, &ecx, &edx);
> +
> +		if (xfeature_nr == XFEATURE_PKRU) {
> +			memcpy(&vcpu->arch.pkru, src + offset,
> +			       sizeof(vcpu->arch.pkru));
> +		} else {
> +			void *dest = get_xsave_addr(xsave, xfeature_nr);
> +

With that superfluous newline removed:

Reviewed-by: Borislav Petkov <bp@suse.de>

> +			if (dest)
>  				memcpy(dest, src + offset, size);
>  		}

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
