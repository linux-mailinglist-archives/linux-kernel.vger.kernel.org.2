Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3163B0070
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFVJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:41:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38526 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:41:08 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62F721FD45;
        Tue, 22 Jun 2021 09:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624354732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/UgONYVJ74qk0Pgu6moqK3t8sNlau5INj3EZgc+amk=;
        b=yB+zW5Mvs8mVAGbNQCZfmrNrg3JHNM9pM8RuIBiRmA6UfibmEMz8V1hQLJiFG+DnkFScvr
        TBfO+ytpgYCWHkGaARu+Qk6U80gPUAO0V279ykb/i4xTUhfZQb4VE/YRZ/YLpu3VbhpM7R
        /FNk+YI4NNj4A6YIvIwGJiF/AwdIC+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624354732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/UgONYVJ74qk0Pgu6moqK3t8sNlau5INj3EZgc+amk=;
        b=UXv8WJCnRmU2vCJNRlRloAwPPJRv2eqbnJ3YgRmd4mfnIcanDQBMQ2NQx4mTxx9o+EhQc0
        UMi6mIobL9ujn7Bg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4088D118DD;
        Tue, 22 Jun 2021 09:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624354732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/UgONYVJ74qk0Pgu6moqK3t8sNlau5INj3EZgc+amk=;
        b=yB+zW5Mvs8mVAGbNQCZfmrNrg3JHNM9pM8RuIBiRmA6UfibmEMz8V1hQLJiFG+DnkFScvr
        TBfO+ytpgYCWHkGaARu+Qk6U80gPUAO0V279ykb/i4xTUhfZQb4VE/YRZ/YLpu3VbhpM7R
        /FNk+YI4NNj4A6YIvIwGJiF/AwdIC+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624354732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/UgONYVJ74qk0Pgu6moqK3t8sNlau5INj3EZgc+amk=;
        b=UXv8WJCnRmU2vCJNRlRloAwPPJRv2eqbnJ3YgRmd4mfnIcanDQBMQ2NQx4mTxx9o+EhQc0
        UMi6mIobL9ujn7Bg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id weO0Dqyv0WC1MQAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 09:38:52 +0000
Date:   Tue, 22 Jun 2021 11:38:45 +0200
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
Subject: Re: [patch V3 31/66] x86/fpu: Rename xstate copy functions which are
 related to UABI
Message-ID: <YNGvpaSNbf1+rGew@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143447.897676792@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143447.897676792@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:54PM +0200, Thomas Gleixner wrote:
> Rename them to reflect that these functions deal with user space format
> XSAVE buffers.
> 
>       copy_kernel_to_xstate() -> copy_uabi_from_kernel_to_xstate()
>       copy_user_to_xstate()   -> copy_sigframe_from_user_to_xstate()
> 
> Again a clear statement that these functions deal with user space ABI.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/xstate.h |    4 ++--
>  arch/x86/kernel/fpu/regset.c      |    2 +-
>  arch/x86/kernel/fpu/signal.c      |    2 +-
>  arch/x86/kernel/fpu/xstate.c      |    5 +++--
>  4 files changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
