Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83AC3AE91B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhFUMeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:34:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47598 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhFUMeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:34:44 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2FF72195B;
        Mon, 21 Jun 2021 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624278749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcKjJbvXgp4hUuR9j8YFkCVorkNtDkOV/BhcFUnRY40=;
        b=VZKnjwqR6aWQKoxQ9M4JUTkRc5P0jjaXJtyjLOz7KA3qYGJGPaMIvQlg0fuAaTvguNdadS
        WFoBvqVvKL3brkqFlaC3GZrAgzGamsqz3GgcPpPfzgcW7ljrfSQ1DwS56gaNQUDZg0OAbp
        emKrEa4WKiX5NnaataTF9Mp/jzH3vq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624278749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcKjJbvXgp4hUuR9j8YFkCVorkNtDkOV/BhcFUnRY40=;
        b=Qb3U49i5UL6i973pGstFhHllzy2InAlMIITBTPzELiF0gKFZCsBUtg1AeK4H6PY25iMkFB
        UGE6laTRs3xLXZAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C9922118DD;
        Mon, 21 Jun 2021 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624278749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcKjJbvXgp4hUuR9j8YFkCVorkNtDkOV/BhcFUnRY40=;
        b=VZKnjwqR6aWQKoxQ9M4JUTkRc5P0jjaXJtyjLOz7KA3qYGJGPaMIvQlg0fuAaTvguNdadS
        WFoBvqVvKL3brkqFlaC3GZrAgzGamsqz3GgcPpPfzgcW7ljrfSQ1DwS56gaNQUDZg0OAbp
        emKrEa4WKiX5NnaataTF9Mp/jzH3vq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624278749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcKjJbvXgp4hUuR9j8YFkCVorkNtDkOV/BhcFUnRY40=;
        b=Qb3U49i5UL6i973pGstFhHllzy2InAlMIITBTPzELiF0gKFZCsBUtg1AeK4H6PY25iMkFB
        UGE6laTRs3xLXZAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 7xskMN2G0GCIMgAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 21 Jun 2021 12:32:29 +0000
Date:   Mon, 21 Jun 2021 14:32:18 +0200
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
Subject: Re: [patch V3 17/66] x86/fpu: Make copy_xstate_to_kernel() usable
 for [x]fpregs_get()
Message-ID: <YNCG0kNJMJ/khoOG@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143446.323623547@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143446.323623547@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:40PM +0200, Thomas Gleixner wrote:
> When xsave with init state optimization is used then a component's state
> in the task's xsave buffer can be stale when the corresponding feature bit
> is not set.
> 
> fpregs_get() and xfpregs_get() invoke fpstate_sanitize_xstate() to update
> the task's xsave buffer before retrieving the FX or FP state. That's just
> duplicated code as copy_xstate_to_kernel() already handles this correctly.
> 
> Add a copy mode argument to the function which allows to restrict the state
> copy to the FP and SSE features.
> 
> Also rename the function to copy_xstate_to_uabi_buf() so the name reflects
> what it is doing.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: Rename to copy_xstate_to_uabi_buf() - Boris
> V2: New patch
> ---
>  arch/x86/include/asm/fpu/xstate.h |   12 +++++++++-
>  arch/x86/kernel/fpu/regset.c      |    2 -
>  arch/x86/kernel/fpu/xstate.c      |   42 ++++++++++++++++++++++++++++----------
>  3 files changed, 42 insertions(+), 14 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
