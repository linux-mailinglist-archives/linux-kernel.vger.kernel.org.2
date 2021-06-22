Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B913B0B30
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhFVRMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:12:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58090 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhFVRMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:12:32 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D3A601FD45;
        Tue, 22 Jun 2021 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624381815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+ndS1pMXzpxxOJw4uAlXW0tsIJJQ3SpgvDNP6Zb8gg=;
        b=skdhE1Y9rpB880qDk6FzQEM59eMQGnjDy+JH1uvqSHcRF7XxeyUhHtiAe36RjeXs91s8qn
        IH1Ol/wA9UCVDsVH12+/680TdPKxXpIrONtfbJH0NleznfBzuiajFeHvFWqG+IcC4wYCaa
        86YLOeNHfQpW2aReijp/zeogvqrcmew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624381815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+ndS1pMXzpxxOJw4uAlXW0tsIJJQ3SpgvDNP6Zb8gg=;
        b=f2oT0OWiBOAzc4xCSONSYCn6QEwzss5Tf64Ak8eylqUA2b/i/Uv9oUrmwJ4KkNNYeW+04/
        EeiXeld5SsJhQhCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BFE0911A97;
        Tue, 22 Jun 2021 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624381815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+ndS1pMXzpxxOJw4uAlXW0tsIJJQ3SpgvDNP6Zb8gg=;
        b=skdhE1Y9rpB880qDk6FzQEM59eMQGnjDy+JH1uvqSHcRF7XxeyUhHtiAe36RjeXs91s8qn
        IH1Ol/wA9UCVDsVH12+/680TdPKxXpIrONtfbJH0NleznfBzuiajFeHvFWqG+IcC4wYCaa
        86YLOeNHfQpW2aReijp/zeogvqrcmew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624381815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+ndS1pMXzpxxOJw4uAlXW0tsIJJQ3SpgvDNP6Zb8gg=;
        b=f2oT0OWiBOAzc4xCSONSYCn6QEwzss5Tf64Ak8eylqUA2b/i/Uv9oUrmwJ4KkNNYeW+04/
        EeiXeld5SsJhQhCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id zs/ALXcZ0mCjPwAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 17:10:15 +0000
Date:   Tue, 22 Jun 2021 19:10:15 +0200
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
Subject: Re: [patch V3 56/66] x86/fpu: Dont store PKRU in xstate in
 fpu_reset_fpstate()
Message-ID: <YNIZd4/R/39u8ybb@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143450.752639563@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143450.752639563@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:19PM +0200, Thomas Gleixner wrote:
> PKRU for a task is stored in task->thread.pkru when the task is scheduled
> out. For 'current' the authoritative source of PKRU is the hardware.
> 
> fpu_reset_fpstate() has two callers:
> 
>   1) fpu__clear_user_states() for !FPU systems. For those PKRU is irrelevant
> 
>   2) fpu_flush_thread() which is invoked from flush_thread(). flush_thread()
>      resets the hardware to the kernel restrictive default value.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/core.c |   22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
