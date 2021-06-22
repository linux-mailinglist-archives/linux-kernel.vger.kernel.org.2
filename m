Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DB53B00F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFVKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:11:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41148 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVKLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:11:43 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CEB171FD45;
        Tue, 22 Jun 2021 10:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624356566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BtqnCgN0sz+nCidq/cwryve12n6z0zXw8iJRS+DSUc=;
        b=O7llyc5L+9jMs37dZx1IOQbA50M93UPsscoRGtH5xZ9rgryvtCfXc7hhUDviBU0mvA9rxK
        mH6aHQkPilwKmptiYmOAWcVoPW7l/2PjPEpL6FZxytrmY34uVtgCYdVfwKYSPA9FWE5l/v
        dKHN4SC4nzzV0tcsD9XMeHptmhsJKeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624356566;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BtqnCgN0sz+nCidq/cwryve12n6z0zXw8iJRS+DSUc=;
        b=jkFfIXuTtquoaCOXj3V0OGdGbne3JqeYbYKgpuFwrjYVgxGEI+zZXAkq6mC5ClhZ1lEIi9
        PYKqZwgrz6Z2IhCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BCB82118DD;
        Tue, 22 Jun 2021 10:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624356566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BtqnCgN0sz+nCidq/cwryve12n6z0zXw8iJRS+DSUc=;
        b=O7llyc5L+9jMs37dZx1IOQbA50M93UPsscoRGtH5xZ9rgryvtCfXc7hhUDviBU0mvA9rxK
        mH6aHQkPilwKmptiYmOAWcVoPW7l/2PjPEpL6FZxytrmY34uVtgCYdVfwKYSPA9FWE5l/v
        dKHN4SC4nzzV0tcsD9XMeHptmhsJKeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624356566;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BtqnCgN0sz+nCidq/cwryve12n6z0zXw8iJRS+DSUc=;
        b=jkFfIXuTtquoaCOXj3V0OGdGbne3JqeYbYKgpuFwrjYVgxGEI+zZXAkq6mC5ClhZ1lEIi9
        PYKqZwgrz6Z2IhCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ogEFLda20WASQgAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 10:09:26 +0000
Date:   Tue, 22 Jun 2021 12:09:15 +0200
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
Subject: Re: [patch V3 32/66] x86/fpu: Deduplicate
 copy_uabi_from_user/kernel_to_xstate()
Message-ID: <YNG2y498poXZExzd@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143448.030191461@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143448.030191461@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:55PM +0200, Thomas Gleixner wrote:
> copy_uabi_from_user_to_xstate() and copy_uabi_from_kernel_to_xstate() are
> almost identical except for the copy function.
> 
> Unify them.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> ---
> V3: Fixed MXCSR thinkos and simplified the handling of MXCSR
> ---
>  arch/x86/kernel/fpu/xstate.c |  137 ++++++++++++++-----------------------------
>  1 file changed, 47 insertions(+), 90 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
