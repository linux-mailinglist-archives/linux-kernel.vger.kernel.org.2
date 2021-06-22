Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107293B0AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhFVRDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:03:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32934 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFVRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:03:30 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34C812195D;
        Tue, 22 Jun 2021 17:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624381273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFShgu80D9kj8c+VzCWZr6pmlOxAZHPk7cfmOWkzSrU=;
        b=d+ax81qlDflWLNLchAsjFKx/ifcBsXNLxkm32bANfHyVY2kSoWDeGO+OLUNFz91vclFZWV
        vJwF8EoPhwYK63i+8TgF0AUoWRVmuOUtFUDcsULTuQUu8DXeJP0zHYmoE/KQ+OnVtXD3DS
        NcJ6ipZ6otbSyS/xbG1UzbjRYjtFN20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624381273;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFShgu80D9kj8c+VzCWZr6pmlOxAZHPk7cfmOWkzSrU=;
        b=/dQXFBg88Ky6NNmwJkOrBqWJs7xBh1HLkf+pHNp2aU5HuyJcgrXujOaOPMiZ1nFtQe+oyU
        o4TRi3QYGVQynODQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 1F6C911A97;
        Tue, 22 Jun 2021 17:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624381273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFShgu80D9kj8c+VzCWZr6pmlOxAZHPk7cfmOWkzSrU=;
        b=d+ax81qlDflWLNLchAsjFKx/ifcBsXNLxkm32bANfHyVY2kSoWDeGO+OLUNFz91vclFZWV
        vJwF8EoPhwYK63i+8TgF0AUoWRVmuOUtFUDcsULTuQUu8DXeJP0zHYmoE/KQ+OnVtXD3DS
        NcJ6ipZ6otbSyS/xbG1UzbjRYjtFN20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624381273;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFShgu80D9kj8c+VzCWZr6pmlOxAZHPk7cfmOWkzSrU=;
        b=/dQXFBg88Ky6NNmwJkOrBqWJs7xBh1HLkf+pHNp2aU5HuyJcgrXujOaOPMiZ1nFtQe+oyU
        o4TRi3QYGVQynODQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id vlzlB1kX0mDvOgAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 17:01:13 +0000
Date:   Tue, 22 Jun 2021 19:01:12 +0200
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
Subject: Re: [patch V3 53/66] x86/fpu: Hook up PKRU into ptrace()
Message-ID: <YNIXWFkGbJWr3Otv@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143450.414069840@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143450.414069840@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:16PM +0200, Thomas Gleixner wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> One nice thing about having PKRU be XSAVE-managed is that it gets naturally
> exposed into the XSAVE-using ABIs.  Now that XSAVE will not be used to
> manage PKRU, these ABIs need to be manually enabled to deal with PKRU.
> 
> ptrace() uses copy_uabi_xstate_to_kernel() to collect the tracee's
> XSTATE. As PKRU is not in the task's XSTATE buffer, use task->thread.pkru
> for filling in up the ptrace buffer.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/xstate.h |    2 +-
>  arch/x86/kernel/fpu/regset.c      |   10 ++++------
>  arch/x86/kernel/fpu/xstate.c      |   25 ++++++++++++++++++-------
>  3 files changed, 23 insertions(+), 14 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
