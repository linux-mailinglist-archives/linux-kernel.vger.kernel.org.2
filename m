Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB46C3A4DDC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhFLJQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:16:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49638 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFLJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:16:10 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 432541FD7B;
        Sat, 12 Jun 2021 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623489250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2sSlImVRcXaM9VYnbNA49+Up3x5pVh6O5L7b3RGQVU=;
        b=j/ADvuN+DoA2M1FHPVpN4s/fL8ph16TW6g0orccD9s9N2zwbnjkKbCeaKuALucg9CMVVPV
        1CnCHrahDA4q1Tm863BHCp94xD1qT7/PVJySeV49CiOgd0jjX+objvqpbBD5N+eXAFbJmv
        Y3trSlay72zyZ0Lk9rXyiBcFbjJ5wy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623489250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2sSlImVRcXaM9VYnbNA49+Up3x5pVh6O5L7b3RGQVU=;
        b=bckWDiGQYYYy65ueC80D77+yKZoroh9qyvvWACh7sWkcaNCR+3CU8dtvvzql8K7v05FdPi
        OycH9G7BYGWIf0Cg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2A9BB118DD;
        Sat, 12 Jun 2021 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623489250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2sSlImVRcXaM9VYnbNA49+Up3x5pVh6O5L7b3RGQVU=;
        b=j/ADvuN+DoA2M1FHPVpN4s/fL8ph16TW6g0orccD9s9N2zwbnjkKbCeaKuALucg9CMVVPV
        1CnCHrahDA4q1Tm863BHCp94xD1qT7/PVJySeV49CiOgd0jjX+objvqpbBD5N+eXAFbJmv
        Y3trSlay72zyZ0Lk9rXyiBcFbjJ5wy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623489250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2sSlImVRcXaM9VYnbNA49+Up3x5pVh6O5L7b3RGQVU=;
        b=bckWDiGQYYYy65ueC80D77+yKZoroh9qyvvWACh7sWkcaNCR+3CU8dtvvzql8K7v05FdPi
        OycH9G7BYGWIf0Cg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id KK7LCeJ6xGDcBQAALh3uQQ
        (envelope-from <bp@suse.de>); Sat, 12 Jun 2021 09:14:10 +0000
Date:   Sat, 12 Jun 2021 11:13:51 +0200
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
Subject: Re: [patch 07/41] x86/fpu: Simplify PTRACE_GETREGS code
Message-ID: <YMR6z3hlyR0t9Kip@zn.tnic>
References: <20210611161523.508908024@linutronix.de>
 <20210611163111.724946882@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210611163111.724946882@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 06:15:30PM +0200, Thomas Gleixner wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> ptrace() has interfaces that let a ptracer inspect a ptracee's register state.
> This includes XSAVE state.  The ptrace() ABI includes a hardware-format XSAVE
> buffer for both the SETREGS and GETREGS interfaces.
> 
> In the old days, the kernel buffer and the ptrace() ABI buffer were the
> same boring non-compacted format.  But, since the advent of supervisor
> states and the compacted format, the kernel buffer has diverged from the
> format presented in the ABI.
> 
> This leads to two paths in the kernel:
> 1. Effectively a verbatim copy_to_user() which just copies the kernel buffer
>    out to userspace.  This is used when the kernel buffer is kept in the
>    non-compacted form which means that it shares a format with the ptrace
>    ABI.
> 2. A one-state-at-a-time path: copy_xstate_to_kernel().  This is theoretically
>    slower since it does a bunch of piecemeal copies.
> 
> Remove the verbatim copy case.  Speed probably does not matter in this path,
> and the vast majority of new hardware will use the one-state-at-a-time path
> anyway.  This ensures greater testing for the "slow" path.
> 
> This also makes enabling PKRU in this interface easier since a single path
> can be patched instead of two.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V4: Picked up from Dave's PKRU series
> ---
>  arch/x86/kernel/fpu/regset.c |   22 ++--------------------
>  arch/x86/kernel/fpu/xstate.c |    6 +++---
>  2 files changed, 5 insertions(+), 23 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
