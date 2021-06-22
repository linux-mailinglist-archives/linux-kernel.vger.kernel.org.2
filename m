Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC133B0731
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhFVOSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:18:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35538 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhFVOSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:18:13 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 514F91FD70;
        Tue, 22 Jun 2021 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624371357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSk6L6EfS4DnLkbkOUtJsHjkN6XrF8OPZUwspwtC5aE=;
        b=EC9RKglWV6+UMwS4y0ewvhdD3hEkOGIT7BZWIXdR1OHQGaxaJFc7rSeIY22iW3izp/dpiP
        tOGCrwBuDwVoU6HU9iW/j6DE0l1fEQe8wPZhx3kDwHI6PG01VhgYndfO1Zgf9DlPotQd2F
        Df62vswARR6ysV79X7OmBQtAkfwQb9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624371357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSk6L6EfS4DnLkbkOUtJsHjkN6XrF8OPZUwspwtC5aE=;
        b=sg2863oBJgYMVgA55nliuIDn5f075U4ekmj0R8zI0edndp5genInmpuV+jyt1dBh6SUslF
        WbIMP9mnqMDg/CDw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 39DA3118DD;
        Tue, 22 Jun 2021 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624371357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSk6L6EfS4DnLkbkOUtJsHjkN6XrF8OPZUwspwtC5aE=;
        b=EC9RKglWV6+UMwS4y0ewvhdD3hEkOGIT7BZWIXdR1OHQGaxaJFc7rSeIY22iW3izp/dpiP
        tOGCrwBuDwVoU6HU9iW/j6DE0l1fEQe8wPZhx3kDwHI6PG01VhgYndfO1Zgf9DlPotQd2F
        Df62vswARR6ysV79X7OmBQtAkfwQb9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624371357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSk6L6EfS4DnLkbkOUtJsHjkN6XrF8OPZUwspwtC5aE=;
        b=sg2863oBJgYMVgA55nliuIDn5f075U4ekmj0R8zI0edndp5genInmpuV+jyt1dBh6SUslF
        WbIMP9mnqMDg/CDw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id gJZjDZ3w0WBUVAAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 14:15:57 +0000
Date:   Tue, 22 Jun 2021 16:15:47 +0200
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
Subject: Re: [patch V3 41/66] x86/cpu: Sanitize X86_FEATURE_OSPKE
Message-ID: <YNHwk774s1/RI2/q@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143449.052887078@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143449.052887078@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:04PM +0200, Thomas Gleixner wrote:
> X86_FEATURE_OSPKE is enabled first on the boot CPU and the feature flag is
> set. Secondary CPUs have to enable CR4.PKE as well and set their per CPU
> feature flag. That's ineffective because all call sites have checks for
> boot_cpu_data.
> 
> Make it smarter and force the feature flag when PKU is enabled on the boot
> cpu which allows then to use cpu_feature_enabled(X86_FEATURE_OSPKE) all
> over the place. That either compiles the code out when PKEY support is
> disabled in Kconfig or uses a static_cpu_has() for the feature check which
> makes a significant difference in hotpathes, e.g. context switch.

"hotpaths"

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/pkeys.h |    8 ++++----
>  arch/x86/include/asm/pkru.h  |    4 ++--
>  arch/x86/kernel/cpu/common.c |   24 +++++++++++-------------
>  arch/x86/kernel/fpu/core.c   |    2 +-
>  arch/x86/kernel/fpu/xstate.c |    2 +-
>  arch/x86/kernel/process_64.c |    2 +-
>  arch/x86/mm/fault.c          |    2 +-
>  7 files changed, 21 insertions(+), 23 deletions(-)

Other than that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
