Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16A53A47D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFKRXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:23:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51606 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:23:07 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2704B1FD6D;
        Fri, 11 Jun 2021 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623432069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1wCFO2uyMl6F9g05s0s+7aNn9WOlwoLqA16xaoeAIo=;
        b=mbvnCooLdb+UbG208FlKNFoSHegREybbIlxr95onWRcTZueqI/CD6zGHC9SC5lfxVhQmjf
        UthFMxgw2fLc0KJiBoq7Ci3VxwUbAJ//KF5+jr909Fzva07BpzCDkcSwFiDrVVyqge4pRI
        yQtkx6WFj7lRi056I824/OhJZIZwSPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623432069;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1wCFO2uyMl6F9g05s0s+7aNn9WOlwoLqA16xaoeAIo=;
        b=ile+VbJSJd3jn0L5i0qp56DjOKWjxQdkvNJK+FV4OAdSMqzEgTNIWBLCtBd/SYQJXEOgJ1
        4So+dcKvXKRjtgBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 0D4D9118DD;
        Fri, 11 Jun 2021 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623432069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1wCFO2uyMl6F9g05s0s+7aNn9WOlwoLqA16xaoeAIo=;
        b=mbvnCooLdb+UbG208FlKNFoSHegREybbIlxr95onWRcTZueqI/CD6zGHC9SC5lfxVhQmjf
        UthFMxgw2fLc0KJiBoq7Ci3VxwUbAJ//KF5+jr909Fzva07BpzCDkcSwFiDrVVyqge4pRI
        yQtkx6WFj7lRi056I824/OhJZIZwSPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623432069;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1wCFO2uyMl6F9g05s0s+7aNn9WOlwoLqA16xaoeAIo=;
        b=ile+VbJSJd3jn0L5i0qp56DjOKWjxQdkvNJK+FV4OAdSMqzEgTNIWBLCtBd/SYQJXEOgJ1
        4So+dcKvXKRjtgBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id vJy5AoWbw2DGSAAALh3uQQ
        (envelope-from <bp@suse.de>); Fri, 11 Jun 2021 17:21:09 +0000
Date:   Fri, 11 Jun 2021 19:21:01 +0200
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
Subject: Re: [patch 02/41] x86/fpu: Mark various FPU states __ro_after_init
Message-ID: <YMObffchf+5FFDNw@zn.tnic>
References: <20210611161523.508908024@linutronix.de>
 <20210611163111.130178710@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210611163111.130178710@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 06:15:25PM +0200, Thomas Gleixner wrote:
> Nothing modifies these after booting.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/init.c   |    4 ++--
>  arch/x86/kernel/fpu/xstate.c |   16 ++++++++++------
>  2 files changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
