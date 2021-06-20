Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165FA3AE0AF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 23:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFTVcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 17:32:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57830 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhFTVcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 17:32:51 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 222641FD29;
        Sun, 20 Jun 2021 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624224637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jr3EKkDtgn8FizBBDVJKegsYoeH9jissvBbAKGoDq+8=;
        b=gSAmezX+CA9jlMqe+4UmOmWobkOa54tZqltCq/MslwgMLDn69QASbjgqLG3OdHfvC8gxs5
        e9/c3GAeGpilTx3EEWP+75NRZOxlsIgeD540C6M8nJPLZp3bcjPflnURe7/zwK9pdcwmlA
        laaA1YQ3HaBhqcqT1Y4cbGCh7bMA0kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624224637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jr3EKkDtgn8FizBBDVJKegsYoeH9jissvBbAKGoDq+8=;
        b=dLVsKyeB21FpEOtAyaYBvbY1mZLtc/yYTPibx1udlGA7tw86YHWqR1Ta3yd3yH2jye5LFP
        9FUbe27lu9o1gIBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 09DB2118DD;
        Sun, 20 Jun 2021 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624224637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jr3EKkDtgn8FizBBDVJKegsYoeH9jissvBbAKGoDq+8=;
        b=gSAmezX+CA9jlMqe+4UmOmWobkOa54tZqltCq/MslwgMLDn69QASbjgqLG3OdHfvC8gxs5
        e9/c3GAeGpilTx3EEWP+75NRZOxlsIgeD540C6M8nJPLZp3bcjPflnURe7/zwK9pdcwmlA
        laaA1YQ3HaBhqcqT1Y4cbGCh7bMA0kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624224637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jr3EKkDtgn8FizBBDVJKegsYoeH9jissvBbAKGoDq+8=;
        b=dLVsKyeB21FpEOtAyaYBvbY1mZLtc/yYTPibx1udlGA7tw86YHWqR1Ta3yd3yH2jye5LFP
        9FUbe27lu9o1gIBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id GH+jAn2zz2CHTwAALh3uQQ
        (envelope-from <bp@suse.de>); Sun, 20 Jun 2021 21:30:37 +0000
Date:   Sun, 20 Jun 2021 23:30:23 +0200
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
Subject: Re: [patch V3 11/66] x86/fpu: Sanitize xstateregs_set()
Message-ID: <YM+zbxOj5Bxl5R8D@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143445.667573756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143445.667573756@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:34PM +0200, Thomas Gleixner wrote:
> xstateregs_set() operates on a stopped task and tries to copy the provided
> buffer into the task's fpu.state.xsave buffer.
> 
> Any error while copying or invalid state detected after copying results in
> wiping the target task's FPU state completely including supervisor states.
> 
> That's just wrong. The caller supplied invalid data or has a problem with
> unmapped memory, so there is absolutely no justification to corrupt the
> target state.
> 
> Fix this with the following modifications:
> 
>  1) If data has to be copied from userspace, allocate a buffer and copy from
>     user first.
> 
>  2) Use copy_kernel_to_xstate() unconditionally so that header checking
>     works correctly.
> 
>  3) Return on error without corrupting the target state.
> 
> This prevents corrupting states and lets the caller deal with the problem
> it caused in the first place.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/xstate.h |    4 ---
>  arch/x86/kernel/fpu/regset.c      |   44 +++++++++++++++-----------------------
>  arch/x86/kernel/fpu/xstate.c      |   14 ++++++------
>  3 files changed, 26 insertions(+), 36 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

Nice!

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
