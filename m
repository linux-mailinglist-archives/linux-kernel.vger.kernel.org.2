Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0283AF41A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhFUSGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:06:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37616 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhFUSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:02:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C45AD1FD3D;
        Mon, 21 Jun 2021 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624298416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xp+LIcwe0KB76r2LoWsSKsZMG7iMXrfQTRthYdfN3rc=;
        b=BkvleaOJyWFGAqN3TuaG7NMrEqVR8vDI/7UtDyzXFI/jHWec+LBdDroYR5Rf5oZPU2ANUr
        SEVGv7P6PBqpBrKboC08eMiXmznOKzOqq3icZY0dqwPju1XmPwhVOqBnAqclTtns4IFBHq
        qQME8neX40wimy6v4hKWJ5TLsqfrJ0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624298416;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xp+LIcwe0KB76r2LoWsSKsZMG7iMXrfQTRthYdfN3rc=;
        b=HvNraGk7daU7WjnCH4PnU24xy0knwcpUuW14at2wGmL6iMGir4XeBwR0QPNuU4AGGQxIL+
        pbU707RNC4oWLyBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id AED8B118DD;
        Mon, 21 Jun 2021 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624298416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xp+LIcwe0KB76r2LoWsSKsZMG7iMXrfQTRthYdfN3rc=;
        b=BkvleaOJyWFGAqN3TuaG7NMrEqVR8vDI/7UtDyzXFI/jHWec+LBdDroYR5Rf5oZPU2ANUr
        SEVGv7P6PBqpBrKboC08eMiXmznOKzOqq3icZY0dqwPju1XmPwhVOqBnAqclTtns4IFBHq
        qQME8neX40wimy6v4hKWJ5TLsqfrJ0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624298416;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xp+LIcwe0KB76r2LoWsSKsZMG7iMXrfQTRthYdfN3rc=;
        b=HvNraGk7daU7WjnCH4PnU24xy0knwcpUuW14at2wGmL6iMGir4XeBwR0QPNuU4AGGQxIL+
        pbU707RNC4oWLyBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id pM9gKbDT0GBvVgAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 21 Jun 2021 18:00:16 +0000
Date:   Mon, 21 Jun 2021 20:00:06 +0200
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
Subject: Re: [patch V3 27/66] x86/fpu: Rename copy_xregs_to_kernel() and
 copy_kernel_to_xregs()
Message-ID: <YNDTpqYqVpsHRxtw@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143447.472279566@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143447.472279566@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:50PM +0200, Thomas Gleixner wrote:
> The function names for xsave[s]/xrstor[s] operations are horribly named and
> a permanent source of confusion.
> 
> Rename:
> 	copy_xregs_to_kernel() to os_xsave()
> 	copy_kernel_to_xregs() to os_xrstor()
> 
> These are truly low level wrappers around the actual instructions
> XSAVE[OPT]/XRSTOR and XSAVES/XRSTORS with the twist that the selection
> based on the available CPU features happens with an alternative to avoid
> conditionals all over the place and to provide the best performance for hot
> pathes.

"paths".

You need more elisp magic here. :)

> @@ -385,7 +390,7 @@ extern int copy_fpregs_to_fpstate(struct
>  static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
>  {
>  	if (use_xsave()) {
> -		copy_kernel_to_xregs(&fpstate->xsave, mask);
> +		os_xrstor(&fpstate->xsave, mask);

Yeah, this reads funny now:

	if use xsave, then xrstor.

and then later

	if use xsave, then xsave.

where latter makes perfect sense but former makes you stop and think for
a bit.

:-)

Regardless, it is still move in the right direction.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
