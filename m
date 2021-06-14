Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0723A6003
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhFNK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:29:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57162 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbhFNK3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:29:51 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4474521940;
        Mon, 14 Jun 2021 10:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623666468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPWGUvc9QsksybOOBkMAjuobjDdoIirHHK7LlvuuvW8=;
        b=fJmcpjbifWZ0eDkkBn7GYGIdtCSC8eCbkifsLD7QYSnZ/k2IHLrM6bTvfD0UcWVXhojzSM
        XqMcIMjtV5RrrazklsqQUrK/O8Sib1GIm5MkpE/WGfvo6/bpFExGKkeepVZtuVTMR7UC4y
        /0cgQYmdGStQQV8HfhVaXa8y679Gggk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623666468;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPWGUvc9QsksybOOBkMAjuobjDdoIirHHK7LlvuuvW8=;
        b=GW4FPUqjJ/bZGtC44QgD7f8Q9NWhN+PeJzYjqh2BJkKrxxKK+pPxYd83ng+y30oY0aHQ+g
        aeLmgpmlQN3dRdCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2F979118DD;
        Mon, 14 Jun 2021 10:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623666468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPWGUvc9QsksybOOBkMAjuobjDdoIirHHK7LlvuuvW8=;
        b=fJmcpjbifWZ0eDkkBn7GYGIdtCSC8eCbkifsLD7QYSnZ/k2IHLrM6bTvfD0UcWVXhojzSM
        XqMcIMjtV5RrrazklsqQUrK/O8Sib1GIm5MkpE/WGfvo6/bpFExGKkeepVZtuVTMR7UC4y
        /0cgQYmdGStQQV8HfhVaXa8y679Gggk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623666468;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPWGUvc9QsksybOOBkMAjuobjDdoIirHHK7LlvuuvW8=;
        b=GW4FPUqjJ/bZGtC44QgD7f8Q9NWhN+PeJzYjqh2BJkKrxxKK+pPxYd83ng+y30oY0aHQ+g
        aeLmgpmlQN3dRdCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id l8aACiQvx2ASbgAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 14 Jun 2021 10:27:48 +0000
Date:   Mon, 14 Jun 2021 12:26:20 +0200
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
Subject: Re: [patch 09/41] x86/kvm: Avoid looking up PKRU in XSAVE buffer
Message-ID: <YMcuzOOCGl+nKysP@zn.tnic>
References: <20210611161523.508908024@linutronix.de>
 <20210611163111.931697147@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210611163111.931697147@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 06:15:32PM +0200, Thomas Gleixner wrote:
> -		if (src) {
> -			u32 size, offset, ecx, edx;
> -			cpuid_count(XSTATE_CPUID, xfeature_nr,
> -				    &size, &offset, &ecx, &edx);
> -			if (xfeature_nr == XFEATURE_PKRU)
> -				memcpy(dest + offset, &vcpu->arch.pkru,
> -				       sizeof(vcpu->arch.pkru));
> -			else
> -				memcpy(dest + offset, src, size);
> +		cpuid_count(XSTATE_CPUID, xfeature_nr,
> +			    &size, &offset, &ecx, &edx);
>  
> +		if (xfeature_nr == XFEATURE_PKRU) {
> +			memcpy(dest + offset, &vcpu->arch.pkru,
> +			       sizeof(vcpu->arch.pkru));
> +		} else {
> +			src = get_xsave_addr(xsave, xfeature_nr);
> +			if (src)
> +				memcpy(dest + offset, src, size);
>  		}
>  
>  		valid -= xfeature_mask;

How about pulling up that PKRU case even further (pasting the whole
changed loop instead of an unreadable diff) and keeping the CPUID access
and the xsave address handling separate?

        valid = xstate_bv & ~XFEATURE_MASK_FPSSE;
        while (valid) {
                u32 size, offset, ecx, edx;
                u64 xfeature_mask = valid & -valid;
                int xfeature_nr = fls64(xfeature_mask) - 1;
                void *src;

                if (xfeature_nr == XFEATURE_PKRU) {
                        memcpy(dest + offset, &vcpu->arch.pkru, sizeof(vcpu->arch.pkru));
                        continue;
                }

                cpuid_count(XSTATE_CPUID, xfeature_nr, &size, &offset, &ecx, &edx);

                src = get_xsave_addr(xsave, xfeature_nr);
                if (src)
                        memcpy(dest + offset, src, size);

                valid -= xfeature_mask;
        }

Btw, I'm wondering if that CPUID read in a loop can be replaced with
adding accessors for xstate_{offsets,sizes,..} etc and providing them to
kvm...


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


^ Superfluous newline.

> +			if (dest)
>  				memcpy(dest, src + offset, size);
>  		}
>  
> 

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
