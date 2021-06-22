Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1F43B0965
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhFVPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:43:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51736 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhFVPm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:42:57 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1FBBB2195D;
        Tue, 22 Jun 2021 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624376440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5JiXVBjC6ksabLncNKVZeSDz5WHF+7ATqdjOBvH5l8=;
        b=mre8lWAZ0Sv4PHcomUP1sYiZs/vk02a4Vq+THQWKXFo5jwYc7NJXZSDgaX4UdlZmos3ROm
        fVVODINakpT0/Q0k7QgIrUiN9ztxzz/o9y/jvc2k4TueI6hCWnr36atLUrc5/5pt7bXFnd
        TEtkhf/UHxRMhTd+nC4oU4KjyvkfieQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624376440;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5JiXVBjC6ksabLncNKVZeSDz5WHF+7ATqdjOBvH5l8=;
        b=dZ01pVEwNz7uPK9SaqOyjV/V/22w9H37inZ/UXf+rwIg1wJsvLvf9HUzwpsyTuMStaouh7
        L1EhnjpwufODI8Bw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 0E893118DD;
        Tue, 22 Jun 2021 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624376440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5JiXVBjC6ksabLncNKVZeSDz5WHF+7ATqdjOBvH5l8=;
        b=mre8lWAZ0Sv4PHcomUP1sYiZs/vk02a4Vq+THQWKXFo5jwYc7NJXZSDgaX4UdlZmos3ROm
        fVVODINakpT0/Q0k7QgIrUiN9ztxzz/o9y/jvc2k4TueI6hCWnr36atLUrc5/5pt7bXFnd
        TEtkhf/UHxRMhTd+nC4oU4KjyvkfieQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624376440;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5JiXVBjC6ksabLncNKVZeSDz5WHF+7ATqdjOBvH5l8=;
        b=dZ01pVEwNz7uPK9SaqOyjV/V/22w9H37inZ/UXf+rwIg1wJsvLvf9HUzwpsyTuMStaouh7
        L1EhnjpwufODI8Bw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id jyt7AngE0mDVBwAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 15:40:40 +0000
Date:   Tue, 22 Jun 2021 17:40:39 +0200
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
Subject: Re: [patch V3 48/66] x86/fpu: Rename __fpregs_load_activate() to
 fpregs_restore_userregs()
Message-ID: <YNIEd6SZIGnfbWVJ@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143449.881756905@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143449.881756905@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:11PM +0200, Thomas Gleixner wrote:
> Rename it so that it becomes entirely clear what this function is
> about. It's purpose is to restore the FPU registers to the state which was
> saved in the task's FPU memory state either at context switch or by an in
> kernel FPU user.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |    6 ++----
>  arch/x86/kernel/fpu/core.c          |    2 +-
>  arch/x86/kernel/fpu/signal.c        |    2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
