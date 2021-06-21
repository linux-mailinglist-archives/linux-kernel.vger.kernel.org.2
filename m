Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953583AEA07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFUN3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:29:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51464 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:29:13 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B1D721A66;
        Mon, 21 Jun 2021 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624282018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tw+/KDvuUvNoiL44wKibOxR7zrMDcKrfnPx4W5yXglg=;
        b=VvaMZFSj1BoxILy7bVguOw5sRWDAHebmFfGwnFONMAOUeUr9A2PsDr7jBuYvd60cCL8bfl
        8ginDWjfP3sNYZ5+7BCRu5L5zZkg64nXaokFLSHVFWVm4KRa/AXWzprW4uGbgTGFLwMiKZ
        WBwhbs+MlPWoOWuwOamQyxASUcx8Mlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624282018;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tw+/KDvuUvNoiL44wKibOxR7zrMDcKrfnPx4W5yXglg=;
        b=GqmVe+tKzyAeprqLKxqdie0VE4K2ymyY2QK2eFoOvaUpVIW8rxDCPaEZr+4Rmj85Y7QjaN
        MeTyhFAsY4CWZYDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6603A118DD;
        Mon, 21 Jun 2021 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624282018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tw+/KDvuUvNoiL44wKibOxR7zrMDcKrfnPx4W5yXglg=;
        b=VvaMZFSj1BoxILy7bVguOw5sRWDAHebmFfGwnFONMAOUeUr9A2PsDr7jBuYvd60cCL8bfl
        8ginDWjfP3sNYZ5+7BCRu5L5zZkg64nXaokFLSHVFWVm4KRa/AXWzprW4uGbgTGFLwMiKZ
        WBwhbs+MlPWoOWuwOamQyxASUcx8Mlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624282018;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tw+/KDvuUvNoiL44wKibOxR7zrMDcKrfnPx4W5yXglg=;
        b=GqmVe+tKzyAeprqLKxqdie0VE4K2ymyY2QK2eFoOvaUpVIW8rxDCPaEZr+4Rmj85Y7QjaN
        MeTyhFAsY4CWZYDg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id mIIVGaKT0GDfTwAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 21 Jun 2021 13:26:58 +0000
Date:   Mon, 21 Jun 2021 15:26:45 +0200
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
Subject: Re: [patch V3 21/66] x86/fpu/regset: Move fpu__read_begin() into
 regset
Message-ID: <YNCTlXp5vbYfEQiL@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143446.797089970@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143446.797089970@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:44PM +0200, Thomas Gleixner wrote:
> The function can only be used from the regset get() callbacks safely. So
> there is no reason to have it globaly exposed.

"globally"

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |    1 -
>  arch/x86/kernel/fpu/core.c          |   20 --------------------
>  arch/x86/kernel/fpu/regset.c        |   22 +++++++++++++++++++---
>  3 files changed, 19 insertions(+), 24 deletions(-)

...

> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -28,6 +28,22 @@ int regset_xregset_fpregs_active(struct
>  		return 0;
>  }
>  
> +/*
> + * The regset get() functions are invoked from:
> + *
> + *   - coredump to dump the current task's fpstate. If the current task
> + *     owns the FPU then the memory state has to be synchronized and the
> + *     FPU register state preserved. Otherwise fpstate is already in sync.
> + *
> + *   - ptrace to dump fpstate of a stopped task, in which case the register
									^

"registers"

With that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
