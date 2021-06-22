Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BFF3B09B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhFVQBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:01:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51172 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhFVQBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:01:03 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28F7F1FD36;
        Tue, 22 Jun 2021 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624377527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXh7RjOXmV2RWZrNe0RUiNyya32itOg7D/MZ06LVb6c=;
        b=Y40M7zj9JrOdLakKT44qKn6g8h9WNiS/Tk2eCBx4bVdn/dgBajQZkbO9YTJhP54A/l6RAE
        1PdfOY4x2w2OPeMbWr/RdujrjL4FKCZXNiLzdnuKs/a570tejDQJSOTgVMHAOPr5VyKNrL
        ZaKjW2y07xBYNJumzGZ6RlQFi6tnutI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624377527;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXh7RjOXmV2RWZrNe0RUiNyya32itOg7D/MZ06LVb6c=;
        b=F3LRoT3FIgZdecnl+PHVaaUMM1JkwS8N+TePtYqz7jfgFWTLmyJSofpMhFtYUa7McEiO/v
        66ljPIBvlUzJm5Aw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 12C1C11A97;
        Tue, 22 Jun 2021 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624377527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXh7RjOXmV2RWZrNe0RUiNyya32itOg7D/MZ06LVb6c=;
        b=Y40M7zj9JrOdLakKT44qKn6g8h9WNiS/Tk2eCBx4bVdn/dgBajQZkbO9YTJhP54A/l6RAE
        1PdfOY4x2w2OPeMbWr/RdujrjL4FKCZXNiLzdnuKs/a570tejDQJSOTgVMHAOPr5VyKNrL
        ZaKjW2y07xBYNJumzGZ6RlQFi6tnutI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624377527;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXh7RjOXmV2RWZrNe0RUiNyya32itOg7D/MZ06LVb6c=;
        b=F3LRoT3FIgZdecnl+PHVaaUMM1JkwS8N+TePtYqz7jfgFWTLmyJSofpMhFtYUa7McEiO/v
        66ljPIBvlUzJm5Aw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id U/C5BLcI0mCJFwAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 15:58:47 +0000
Date:   Tue, 22 Jun 2021 17:58:41 +0200
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
Subject: Re: [patch V3 49/66] x86/fpu: Move FXSAVE_LEAK quirk info
 __copy_kernel_to_fpregs()
Message-ID: <YNIIsWcv6vM1gnp+@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143449.989728490@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143449.989728490@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:12PM +0200, Thomas Gleixner wrote:
> copy_kernel_to_fpregs() restores all xfeatures but it is also the place
> where the AMD FXSAVE_LEAK bug is handled.
> 
> That prevents fpregs_restore_userregs() to limit the restored features,
> which is required to distangle PKRU and XSTATE handling and also for the

"untangle"

> upcoming supervisor state management.
> 
> Move the FXSAVE_LEAK quirk into __copy_kernel_to_fpregs() and deinline that
> function which has become rather fat.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |   25 +------------------------
>  arch/x86/kernel/fpu/core.c          |   27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 24 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
