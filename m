Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3A43ADDC6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 10:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhFTIrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 04:47:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46466 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhFTIrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 04:47:05 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D48021A5A;
        Sun, 20 Jun 2021 08:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624178692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKKoanJ4wshGQOfupMu8RrjtMJrud3LH2EHotYJr5Aw=;
        b=RUNTtrhYxwi2NHaSk8fIGdULsk4i3T9cMDasoaPvr+a2OIzLRxMyX4IU+YBrayBZbpXFpf
        frsltXfIg82tNpVdsTM8Bcd9mCysABirKnQVhEVEzhpfzmpj2z9+aL6NKHmVzKYeGAM/1B
        FC4fy4nUnmC0tV18m3YTgfyTPObxYdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624178692;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKKoanJ4wshGQOfupMu8RrjtMJrud3LH2EHotYJr5Aw=;
        b=Y3HEywzcIS61NpUf/q3jDvU2WkEDfdCyJtw2+GF8B+jhk+HVomCZzqJ3HY0eCsZRCOXWJs
        mV77JYTxDTWS7vDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2872C118DD;
        Sun, 20 Jun 2021 08:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624178692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKKoanJ4wshGQOfupMu8RrjtMJrud3LH2EHotYJr5Aw=;
        b=RUNTtrhYxwi2NHaSk8fIGdULsk4i3T9cMDasoaPvr+a2OIzLRxMyX4IU+YBrayBZbpXFpf
        frsltXfIg82tNpVdsTM8Bcd9mCysABirKnQVhEVEzhpfzmpj2z9+aL6NKHmVzKYeGAM/1B
        FC4fy4nUnmC0tV18m3YTgfyTPObxYdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624178692;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKKoanJ4wshGQOfupMu8RrjtMJrud3LH2EHotYJr5Aw=;
        b=Y3HEywzcIS61NpUf/q3jDvU2WkEDfdCyJtw2+GF8B+jhk+HVomCZzqJ3HY0eCsZRCOXWJs
        mV77JYTxDTWS7vDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id WTFhCQQAz2BsbQAALh3uQQ
        (envelope-from <bp@suse.de>); Sun, 20 Jun 2021 08:44:52 +0000
Date:   Sun, 20 Jun 2021 10:44:40 +0200
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
Subject: Re: [patch V3 06/66] x86/fpu: Make xfeatures_mask_all __ro_after_init
Message-ID: <YM7/+DClnxtqd3Ix@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143445.104177935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143445.104177935@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:29PM +0200, Thomas Gleixner wrote:
> Nothing has to modify this after init.
> 
> But of course there is code which unconditionaly masks xfeatures_mask_all

WARNING: 'unconditionaly' may be misspelled - perhaps 'unconditionally'?
#71: 
But of course there is code which unconditionaly masks xfeatures_mask_all
                                  ^^^^^^^^^^^^^^
> @@ -896,8 +888,18 @@ void __init fpu__init_system_xstate(void
>  	setup_init_fpu_buf();
>  	setup_xstate_comp_offsets();
>  	setup_supervisor_only_offsets();
> -	print_xstate_offset_size();
>  
> +	/*
> +	 * Paranoia check whether something in the setup modified the
> +	 * xfeatures mask.
> +	 */
> +	if (xfeatures != xfeatures_mask_all) {
> +		pr_err("x86/fpu: xfeatures modified during init %016llx %016llx, disabling XSAVE\n",

Let's make that:

		pr_err("x86/fpu: xfeatures modified from 0x%016llx to 0x%016llx during init, disabling XSAVE\n",

so that it is clear which is which.

With those:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
