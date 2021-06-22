Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A92C3B01B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhFVKt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:49:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44600 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFVKtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:49:19 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 38C7B1FD36;
        Tue, 22 Jun 2021 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624358822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f06oYsohryrLHCYnhIvUSsicviTNeIQZEK68Q3btK0A=;
        b=Fr1161mN4zj0L+9lwHcNSddmME7n5GKykRKfjwYlfmmJwYb7U5ZZxSq5lyhe+oZW4uLk0H
        3QujQShbBW0J6VoHvEdk6lj4m61fXTaiP0T+D7LnbPzvXhNrHbXTEoVU1bCsksRvPr7O4k
        JLCHD2CXgkn6ExDJDe6JcIVB9jNYqKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624358822;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f06oYsohryrLHCYnhIvUSsicviTNeIQZEK68Q3btK0A=;
        b=eYBFcAzpAtbVU5F59rJccKj45mXONh8DQBz89aGG2cLOTVE5ZqHlloyZ/yehDYvxYNoUN1
        69FdNaRZlaz78/BA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 263E3118DD;
        Tue, 22 Jun 2021 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624358822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f06oYsohryrLHCYnhIvUSsicviTNeIQZEK68Q3btK0A=;
        b=Fr1161mN4zj0L+9lwHcNSddmME7n5GKykRKfjwYlfmmJwYb7U5ZZxSq5lyhe+oZW4uLk0H
        3QujQShbBW0J6VoHvEdk6lj4m61fXTaiP0T+D7LnbPzvXhNrHbXTEoVU1bCsksRvPr7O4k
        JLCHD2CXgkn6ExDJDe6JcIVB9jNYqKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624358822;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f06oYsohryrLHCYnhIvUSsicviTNeIQZEK68Q3btK0A=;
        b=eYBFcAzpAtbVU5F59rJccKj45mXONh8DQBz89aGG2cLOTVE5ZqHlloyZ/yehDYvxYNoUN1
        69FdNaRZlaz78/BA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 8qJKCKa/0WBXVwAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 10:47:02 +0000
Date:   Tue, 22 Jun 2021 12:46:55 +0200
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
Subject: Re: [patch V3 35/66] x86/fpu: Rename copy_kernel_to_fpregs() to
 restore_fpregs_from_kernel()
Message-ID: <YNG/n88VeucXsE6M@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143448.380267423@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143448.380267423@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:58PM +0200, Thomas Gleixner wrote:

> Subject: Re: [patch V3 35/66] x86/fpu: Rename copy_kernel_to_fpregs() to restore_fpregs_from_kernel()

... to restore_fpregs_from_fpstate"


> This is not a copy functionality. It restores the register state from the
> supplied kernel buffer.

"No functional changes."

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |    8 ++++----
>  arch/x86/kvm/x86.c                  |    4 ++--
>  arch/x86/mm/extable.c               |    2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)

with that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
