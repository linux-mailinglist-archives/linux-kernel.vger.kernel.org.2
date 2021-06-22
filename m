Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E415D3B02D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFVLfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:35:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47698 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFVLfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:35:13 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E7EC1FD36;
        Tue, 22 Jun 2021 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624361577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vtyw6qpiQK5A+4PpVL4hye3tFIEI3eb2PMDtiyewNJ4=;
        b=R19AM98l+Zx/wSR6qYnUopY102D4H5F+tMjZnI50WkQltzLMYBAjFgZMFDM32VaN+8q7QK
        RR5LOKW+qKN577cBnC56AuwtoJ84bjjvlZBIDBWLnoXNo7b4Esj+FheinNW2MUxkPfUkci
        8I9kUqxTuozTtZCA4oLBXLvE4Hh4AtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624361577;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vtyw6qpiQK5A+4PpVL4hye3tFIEI3eb2PMDtiyewNJ4=;
        b=jWBr9BhGeS3Kv6JsmdNrZdxB89dhh0Klq1VfKmdFWVprEmM4jFUNW4iIYoexhwb0fYDySB
        mNAfBc39pxQRpbBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 17BCD118DD;
        Tue, 22 Jun 2021 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624361577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vtyw6qpiQK5A+4PpVL4hye3tFIEI3eb2PMDtiyewNJ4=;
        b=R19AM98l+Zx/wSR6qYnUopY102D4H5F+tMjZnI50WkQltzLMYBAjFgZMFDM32VaN+8q7QK
        RR5LOKW+qKN577cBnC56AuwtoJ84bjjvlZBIDBWLnoXNo7b4Esj+FheinNW2MUxkPfUkci
        8I9kUqxTuozTtZCA4oLBXLvE4Hh4AtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624361577;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vtyw6qpiQK5A+4PpVL4hye3tFIEI3eb2PMDtiyewNJ4=;
        b=jWBr9BhGeS3Kv6JsmdNrZdxB89dhh0Klq1VfKmdFWVprEmM4jFUNW4iIYoexhwb0fYDySB
        mNAfBc39pxQRpbBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id R5hlBWnK0WBLcgAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 11:32:57 +0000
Date:   Tue, 22 Jun 2021 13:32:43 +0200
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
Subject: Re: [patch V3 38/66] x86/fpu/xstate: Sanitize handling of
 independent features
Message-ID: <YNHKWyB9pRmw7v+K@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143448.745062645@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143448.745062645@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:01PM +0200, Thomas Gleixner wrote:
> The copy functions for the independent features are horribly named and the
> supervisor and independent part is just overengineered.
> 
> The point is that the supplied mask has either to be a subset of the
> independent feature or a subset of the task->fpu.xstate managed features.

features

> Rewrite it so it checks check for invalid overlaps of these areas in the

s/ check//

> caller supplied feature mask. Rename it so it follows the new naming
> convention for these operations. Mop up the function documentation.
> 
> This allows to use that function for other purposes as well.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> ---
> V3: Rename
> ---
>  arch/x86/events/intel/lbr.c       |    6 +-
>  arch/x86/include/asm/fpu/xstate.h |    5 +-
>  arch/x86/kernel/fpu/xstate.c      |   93 +++++++++++++++++++-------------------
>  3 files changed, 53 insertions(+), 51 deletions(-)

...

>  /**
> - * copy_independent_supervisor_to_kernel() - Save independent supervisor states to
> - *                                           an xsave area
> - * @xstate: A pointer to an xsave area
> - * @mask: Represent the independent supervisor features saved into the xsave area
> + * xsaves - Save selected components to a kernel xstate buffer
> + * @xstate:	Pointer to the buffer
> + * @mask:	Feature mask to select the components to save
>   *
> - * Only the independent supervisor states sets in the mask are saved into the xsave
> - * area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of independent
> - * supervisor feature). Besides the independent supervisor states, the legacy
> - * region and XSAVE header are also saved into the xsave area. The supervisor
> - * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
> - * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
> + * The @xstate buffer must be 64 byte aligned and correctly initialized as
> + * XSAVES does not write the full xstate header. Before first use the
> + * buffer should be zeroed otherwise a consecutive XRSTORS from that buffer
> + * can #GP.
>   *
> - * The xsave area must be 64-bytes aligned.
> + * The feature mask must either be a subset of the independent features or
> + * a subset of the task->fpstate related features
						    ^
						    Fullstop.

In the corresponding sentence for xrstors() too.

Btw, looking at how almost identical the two are, they're kinda begging
for a common worker function __x_handle_supervisor() or so which is
called by xsaves() and xrstors(). But maybe later.

With the above nitpicks addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
