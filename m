Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C3C3AD915
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhFSJnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 05:43:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41350 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFSJnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 05:43:40 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4AB221ADC;
        Sat, 19 Jun 2021 09:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624095688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mn9xRkCcao6dpo7BJ5O2NDcPb06oH4ZHo+K7nLuZBi8=;
        b=qdTu8QFI3F5AmKCN99fWxg0F3JZjVi3qx77I99dpC+fYez2OiJntNz/VPQnLwSR0JVBaPv
        c6AeGDT9dADP7+80UrcPVHNTJbBnMbhBwH3G9um+Uwlo6v1fN6uiu39Aa1Q/cJ5/xHt879
        JHFOxxyEG6qVaWSm1nFEAZQmfcikB7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624095688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mn9xRkCcao6dpo7BJ5O2NDcPb06oH4ZHo+K7nLuZBi8=;
        b=HMsUD7vWa0qCHieGDVnLHkpydW4mqlMf11FJ7JzXBMmV617YAzAR+bVMdkkVb81ebum5qL
        xGPNVs23/hIcnLCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BE44B118DD;
        Sat, 19 Jun 2021 09:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624095688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mn9xRkCcao6dpo7BJ5O2NDcPb06oH4ZHo+K7nLuZBi8=;
        b=qdTu8QFI3F5AmKCN99fWxg0F3JZjVi3qx77I99dpC+fYez2OiJntNz/VPQnLwSR0JVBaPv
        c6AeGDT9dADP7+80UrcPVHNTJbBnMbhBwH3G9um+Uwlo6v1fN6uiu39Aa1Q/cJ5/xHt879
        JHFOxxyEG6qVaWSm1nFEAZQmfcikB7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624095688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mn9xRkCcao6dpo7BJ5O2NDcPb06oH4ZHo+K7nLuZBi8=;
        b=HMsUD7vWa0qCHieGDVnLHkpydW4mqlMf11FJ7JzXBMmV617YAzAR+bVMdkkVb81ebum5qL
        xGPNVs23/hIcnLCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id jm3FLsi7zWCYVAAALh3uQQ
        (envelope-from <bp@suse.de>); Sat, 19 Jun 2021 09:41:28 +0000
Date:   Sat, 19 Jun 2021 11:41:17 +0200
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
Subject: Re: [patch V3 03/66] x86/fpu: Fix copy_xstate_to_kernel() gap
 handling
Message-ID: <YM27vRoWhxZTVNTA@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143444.743973084@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143444.743973084@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:26PM +0200, Thomas Gleixner wrote:
> The gap handling in copy_xstate_to_kernel() is wrong when XSAVES is in use.
> 
> Using init_fpstate for copying the init state of features which are
> not set in the xstate header is only correct for the legacy area, but
> not for the extended features area because when XSAVES is in use then
> init_fpstate is in compacted form which means the xstate offsets which
> are used to copy from init_fpstate are not valid.
> 
> Fortunately this is not a real problem today because all extended
> features in use have an all zeros init state, but it is wrong
> nevertheless and with a potentially dynamically sized init_fpstate
> this would result in access outside of the init_fpstate.
> 
> Fix this by keeping track of the last copied state in the target buffer and
> explicitly zero it when there is a feature or alignment gap.
> 
> Use the compacted offset when accessing the extended feature space in
> init_fpstate.
> 
> As this is not a functional issue on older kernels this is intentionally
> not tagged for stable.
> 
> Fixes: b8be15d58806 ("x86/fpu/xstate: Re-enable XSAVES")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: Remove the AVX/SEE thinko
>     Fix comments (Boris)
> V2: New patch
> ---
>  arch/x86/kernel/fpu/xstate.c |  105 ++++++++++++++++++++++++-------------------
>  1 file changed, 61 insertions(+), 44 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
