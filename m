Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084313B0B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhFVRJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:09:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57774 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFVRJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:09:37 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B82C1FD5D;
        Tue, 22 Jun 2021 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624381641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnx75kZ1eKos8iJeRwdFLJSgEiX4CPqJNChQzt0z4TE=;
        b=c4zRbP3XgABu1SOPeFNGsUG0ILU3/KCD91BbXTbKziou4IJ54m2BqQiA6QEA6zITep/dfv
        sktlxs1CtoRL55wRtNyRVakC/iKLTWtjAbOaJIk1xm6HQH4/vk0kCF5wRdQvzRva2PPACf
        n5K5TFTY8sUC4D12H+tt8c6E32fciIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624381641;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnx75kZ1eKos8iJeRwdFLJSgEiX4CPqJNChQzt0z4TE=;
        b=e/CCw/EdIM9bqN5XH7/Pe4R3ykg6hAQuNTQAUx2FDis097Zq7yB2mk3NJkXVDQuuUOxre1
        4MrHhh3xCcGp2xBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 1981711A97;
        Tue, 22 Jun 2021 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624381641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnx75kZ1eKos8iJeRwdFLJSgEiX4CPqJNChQzt0z4TE=;
        b=c4zRbP3XgABu1SOPeFNGsUG0ILU3/KCD91BbXTbKziou4IJ54m2BqQiA6QEA6zITep/dfv
        sktlxs1CtoRL55wRtNyRVakC/iKLTWtjAbOaJIk1xm6HQH4/vk0kCF5wRdQvzRva2PPACf
        n5K5TFTY8sUC4D12H+tt8c6E32fciIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624381641;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnx75kZ1eKos8iJeRwdFLJSgEiX4CPqJNChQzt0z4TE=;
        b=e/CCw/EdIM9bqN5XH7/Pe4R3ykg6hAQuNTQAUx2FDis097Zq7yB2mk3NJkXVDQuuUOxre1
        4MrHhh3xCcGp2xBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id AsNCBckY0mARPgAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 17:07:21 +0000
Date:   Tue, 22 Jun 2021 19:07:20 +0200
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
Subject: Re: [patch V3 54/66] x86/fpu: Mask PKRU from kernel XRSTOR[S]
 operations
Message-ID: <YNIYyCwrmM/vq5+U@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143450.527252651@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143450.527252651@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:17PM +0200, Thomas Gleixner wrote:
> As the PKRU state is managed seperately restoring it from the xstate buffer

separately

> would be counterproductive as it might either restore a stale value or
> reinit the PKRU state to 0.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |    4 ++--
>  arch/x86/include/asm/fpu/xstate.h   |   10 ++++++++++
>  arch/x86/kernel/fpu/xstate.c        |    1 +
>  arch/x86/mm/extable.c               |    2 +-
>  4 files changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
