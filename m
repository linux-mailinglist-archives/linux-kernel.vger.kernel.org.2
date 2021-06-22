Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892923B09D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFVQEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:04:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51396 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhFVQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:04:37 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 377801FD36;
        Tue, 22 Jun 2021 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624377741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4pHCDoZGGtLEwP2H0xlQQzCne1EIfo+4LhiMGDyGsY=;
        b=NR5PmwSV5CSPaeeurWdpk5gjjjZceK6hZMibz6xz0z4hEOe0mCj+cw9inqaSjqyRIy+onC
        KTEdTt196aHeTr2DPJEfEeGCN4JgVIOLMIcV48zzRPtOb8Sr+FLBNhfLoRvvkocYflikJk
        EAe/qFHvCGc2foPeBqJqtjdCaIR3ui8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624377741;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4pHCDoZGGtLEwP2H0xlQQzCne1EIfo+4LhiMGDyGsY=;
        b=uQJ+Osifvr2ard1VJjAJw1RgLZXUf9Hdhwn18HsoFQuy/6IOZyWZd604O7Lnf7oda3ZBmM
        InHVZU1Qd3m45ZAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 21B2411A97;
        Tue, 22 Jun 2021 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624377741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4pHCDoZGGtLEwP2H0xlQQzCne1EIfo+4LhiMGDyGsY=;
        b=NR5PmwSV5CSPaeeurWdpk5gjjjZceK6hZMibz6xz0z4hEOe0mCj+cw9inqaSjqyRIy+onC
        KTEdTt196aHeTr2DPJEfEeGCN4JgVIOLMIcV48zzRPtOb8Sr+FLBNhfLoRvvkocYflikJk
        EAe/qFHvCGc2foPeBqJqtjdCaIR3ui8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624377741;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4pHCDoZGGtLEwP2H0xlQQzCne1EIfo+4LhiMGDyGsY=;
        b=uQJ+Osifvr2ard1VJjAJw1RgLZXUf9Hdhwn18HsoFQuy/6IOZyWZd604O7Lnf7oda3ZBmM
        InHVZU1Qd3m45ZAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 1MdbCI0J0mATGgAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 16:02:21 +0000
Date:   Tue, 22 Jun 2021 18:02:20 +0200
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
Subject: Re: [patch V3 50/66] x86/fpu: Rename xfeatures_mask_user() to
 xfeatures_mask_uabi()
Message-ID: <YNIJjOF7Ud58wiGe@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143450.090350690@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143450.090350690@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:13PM +0200, Thomas Gleixner wrote:
> Rename it so it's clear that this is about user ABI features which can
> differ from the feature set which the kernel saves and restores because the
> kernel handles e.g. PKRU differently. But the user ABI (ptrace, signal
> frame) expects it to be there.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |    7 ++++++-
>  arch/x86/include/asm/fpu/xstate.h   |    6 +++++-
>  arch/x86/kernel/fpu/core.c          |    2 +-
>  arch/x86/kernel/fpu/signal.c        |   10 +++++-----
>  arch/x86/kernel/fpu/xstate.c        |   18 +++++++++---------
>  5 files changed, 26 insertions(+), 17 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
