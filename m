Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436ED3B0ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhFVQ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:57:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57084 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhFVQ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:57:24 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD31D1FD66;
        Tue, 22 Jun 2021 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624380906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIxnDX46rbm+965diWj9vg3CEs1mt4+C3Op+ORezFj0=;
        b=USh94KmCjk+TE+VOGBhLnXsmgRTCOrfpkKC/EKClak2gfHvrhOrhnIihTRRrwGVcaz/YCw
        p73it8pcWcqkjRmfvjYFyR8PzL/VsUGUShpW2ZwnEY1vzvdvkpZmdUtBs2L52wumRE4dcx
        TRatgaLtL2hrGfplg5Srvt3VQgeYTcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624380906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIxnDX46rbm+965diWj9vg3CEs1mt4+C3Op+ORezFj0=;
        b=n9XClOxavtsUGuhitGxQ4ckHzY1y0UDvEj0v3naF/4aYDPxmYDC2pVTGB17Wo1wO3W21bc
        x8S4yay0DxFTGKBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 9A52211A97;
        Tue, 22 Jun 2021 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624380906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIxnDX46rbm+965diWj9vg3CEs1mt4+C3Op+ORezFj0=;
        b=USh94KmCjk+TE+VOGBhLnXsmgRTCOrfpkKC/EKClak2gfHvrhOrhnIihTRRrwGVcaz/YCw
        p73it8pcWcqkjRmfvjYFyR8PzL/VsUGUShpW2ZwnEY1vzvdvkpZmdUtBs2L52wumRE4dcx
        TRatgaLtL2hrGfplg5Srvt3VQgeYTcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624380906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIxnDX46rbm+965diWj9vg3CEs1mt4+C3Op+ORezFj0=;
        b=n9XClOxavtsUGuhitGxQ4ckHzY1y0UDvEj0v3naF/4aYDPxmYDC2pVTGB17Wo1wO3W21bc
        x8S4yay0DxFTGKBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id MvOVJOoV0mDVNwAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 16:55:06 +0000
Date:   Tue, 22 Jun 2021 18:55:01 +0200
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
Subject: Re: [patch V3 52/66] x86/fpu: Add PKRU storage outside of task XSAVE
 buffer
Message-ID: <YNIV5Wk7E1LNhekk@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143450.309386233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143450.309386233@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:15PM +0200, Thomas Gleixner wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> PKRU is currently partly XSAVE-managed and partly not.  It has space in the
> task XSAVE buffer and is context-switched by XSAVE/XRSTOR.  However, it is
> switched more eagerly than FPU because there may be a need for PKRU to be
> up-to-date for things like copy_to/from_user() since PKRU affects
> user-permission memory accesses, not just accesses from userspace itself.
> 
> This leaves PKRU in a very odd position.  XSAVE brings very little value to
> the table for how Linux uses PKRU except for signal related XSTATE
> handling.
> 
> Prepare to move PKRU away from being XSAVE-managed.  Allocate space in the
> thread_struct for it and save/restore it in the context-switch path
> separately from the XSAVE-managed features. task->thread_struct.pkru is
> only valid when the task is scheduled out. For the current task the
> authoritative source is the hardware, i.e. it has to be retrieved via
> rdpkru().
> 
> Leave the XSAVE code in place for now to ensure bisectability.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: Fix the fallout on !PKRU enabled systems in copy_thread() - Intel testing via Dave
> ---
>  arch/x86/include/asm/processor.h |    9 +++++++++
>  arch/x86/kernel/process.c        |    7 +++++++
>  arch/x86/kernel/process_64.c     |   25 +++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
