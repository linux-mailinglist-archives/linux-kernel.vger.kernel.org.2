Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE73B09F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFVQKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:10:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52184 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhFVQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:10:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A58AD1FD45;
        Tue, 22 Jun 2021 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624378092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIo2unu8wS8UOOBy1Q7WVnvvtG43xEKHeuRSBa2yeRA=;
        b=FSCctRcNeMEpmmW3/4dtINn3RxPiECGw3Xwwibro2v4EljUHK/62ME4LmgcIdFxLOhdUQK
        a1Jd1Plj1M9KULWAnez/05Uqjuv/1CMzLiMSHH50E5YslIxDUWLt4R72PSfcVoawtP7DLW
        ZWoLNyY3WZMxhGZNhWUcmo5pcz5zAU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624378092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIo2unu8wS8UOOBy1Q7WVnvvtG43xEKHeuRSBa2yeRA=;
        b=W2ZvLKuTBTvyd4P4UW41RZlExNSc6Jcs9W9sVglM0hfnfk2xGzl/W2SyOmCdevcYAtVCjj
        v4euZ7KbVkGMPkCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 9073D11A97;
        Tue, 22 Jun 2021 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624378092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIo2unu8wS8UOOBy1Q7WVnvvtG43xEKHeuRSBa2yeRA=;
        b=FSCctRcNeMEpmmW3/4dtINn3RxPiECGw3Xwwibro2v4EljUHK/62ME4LmgcIdFxLOhdUQK
        a1Jd1Plj1M9KULWAnez/05Uqjuv/1CMzLiMSHH50E5YslIxDUWLt4R72PSfcVoawtP7DLW
        ZWoLNyY3WZMxhGZNhWUcmo5pcz5zAU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624378092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIo2unu8wS8UOOBy1Q7WVnvvtG43xEKHeuRSBa2yeRA=;
        b=W2ZvLKuTBTvyd4P4UW41RZlExNSc6Jcs9W9sVglM0hfnfk2xGzl/W2SyOmCdevcYAtVCjj
        v4euZ7KbVkGMPkCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ELgdIuwK0mCQHQAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 16:08:12 +0000
Date:   Tue, 22 Jun 2021 18:08:11 +0200
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
Subject: Re: [patch V3 51/66] x86/fpu: Dont restore PKRU in
 fpregs_restore_userspace()
Message-ID: <YNIK632EfZXPQw5s@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143450.190790035@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143450.190790035@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:14PM +0200, Thomas Gleixner wrote:
> switch_to(), flush_thread() write the task's PKRU value eagerly so the PKRU
> value of current is always valid in the hardware.
> 
> That means there is no point in restoring PKRU on exit to user or when
> reactivating the task's FPU registers in the signal frame setup path.
> 
> This allows to remove all the xstate buffer updates with PKRU values once
> the PKRU state is stored in thread struct while a task is scheduled out.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: Restore supervisor state too. (Yu-Cheng)
> ---
>  arch/x86/include/asm/fpu/internal.h |   16 +++++++++++++++-
>  arch/x86/include/asm/fpu/xstate.h   |   19 +++++++++++++++++++
>  arch/x86/kernel/fpu/core.c          |    2 +-
>  3 files changed, 35 insertions(+), 2 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
