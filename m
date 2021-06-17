Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFEF3AB3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhFQMoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:44:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48830 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhFQMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:44:09 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A4381FDCE;
        Thu, 17 Jun 2021 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623933721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6du5rShliFs1Bihe7PeBJuT9EHklARbBwoRJSKEtKeU=;
        b=lNHBj8bXqXTgwZrQKp4vYm9yRDk3nKf7c5FzUIFdsefnE9O2/xakcY9ph392s2J5G3ZzKj
        rKaJsWxr1cik2c/H0uU9dYm3QiyTOCemz4kLxVCumnTbztE1aA36v5zwehdHC2fPAaeWgj
        JOpqO48BqvhCIjuZFI0vFSfgvA5RZwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623933721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6du5rShliFs1Bihe7PeBJuT9EHklARbBwoRJSKEtKeU=;
        b=BIzN87Jil0w4+rdZZlaiMgmJcqAcFHL9saHXYfKH+ghinjVRkjKOAT5SIKHqzoQf3YTanu
        a33I4oCgJbsJ4vBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 01321118DD;
        Thu, 17 Jun 2021 12:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623933721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6du5rShliFs1Bihe7PeBJuT9EHklARbBwoRJSKEtKeU=;
        b=lNHBj8bXqXTgwZrQKp4vYm9yRDk3nKf7c5FzUIFdsefnE9O2/xakcY9ph392s2J5G3ZzKj
        rKaJsWxr1cik2c/H0uU9dYm3QiyTOCemz4kLxVCumnTbztE1aA36v5zwehdHC2fPAaeWgj
        JOpqO48BqvhCIjuZFI0vFSfgvA5RZwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623933721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6du5rShliFs1Bihe7PeBJuT9EHklARbBwoRJSKEtKeU=;
        b=BIzN87Jil0w4+rdZZlaiMgmJcqAcFHL9saHXYfKH+ghinjVRkjKOAT5SIKHqzoQf3YTanu
        a33I4oCgJbsJ4vBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id tI7+OhhDy2BELAAALh3uQQ
        (envelope-from <bp@suse.de>); Thu, 17 Jun 2021 12:42:00 +0000
Date:   Thu, 17 Jun 2021 14:41:48 +0200
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
Subject: Re: [patch V2 21/52] x86/fpu: Get rid of copy_supervisor_to_kernel()
Message-ID: <YMtDDFgYy8+ubmve@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155355.841581418@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155355.841581418@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:29PM +0200, Thomas Gleixner wrote:
> If the fast path of restoring the FPU state on sigreturn fails or is not
> taken and the current task's FPU is active then the FPU has to be
> deactivated for the slow path to allow a safe update of the tasks FPU
> memory state.
> 
> With supervisor states enabled, this requires to save the supervisor state
> in the memory state first. Supervisor states require XSAVES so saving only
> the supervisor state requires to reshuffle the memory buffer because XSAVES
> uses the compacted format and therefore stores the supervisor states at the
> beginning of the memory state. That's just an overengineered optimization.
> 
> Get rid of it and save the full state for this case.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/fpu/xstate.h |    1 
>  arch/x86/kernel/fpu/signal.c      |   13 +++++---
>  arch/x86/kernel/fpu/xstate.c      |   55 --------------------------------------
>  3 files changed, 8 insertions(+), 61 deletions(-)

Simplification? To the FPU stinking pile of turds?

Hell yeah!

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
