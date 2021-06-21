Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ABF3AE6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFUKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:03:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56694 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFUKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:03:24 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC1D51FD3D;
        Mon, 21 Jun 2021 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624269668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DK4VOq3/aR+8QJMmcLcj1iWRrIsrH84E5osKmEsvTsk=;
        b=W49a/6l1a3pOBGlRU3CYQ4rfVliQrG7WGXnAHCzxXolaIbMH/QlBibUi1C5Lu9351VO3Vz
        ea9o8XRdF5PzESG46ZUngeYr2BmiKJOlhqtS26z98QU5QkVy/qtgmjm8XddLLCu8Hufpxw
        XeAZGa61n4BBvLyzijRIACCSFGVLg90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624269668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DK4VOq3/aR+8QJMmcLcj1iWRrIsrH84E5osKmEsvTsk=;
        b=10rQrSmZEGDFyFSQZPmNw4feTsDyuoNfMqoHtX+4nlweNZr2F6lUXvWF/UJ8sC9pToNSRG
        RjFQnbE5PA/v8ZBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C6CE0118DD;
        Mon, 21 Jun 2021 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624269668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DK4VOq3/aR+8QJMmcLcj1iWRrIsrH84E5osKmEsvTsk=;
        b=W49a/6l1a3pOBGlRU3CYQ4rfVliQrG7WGXnAHCzxXolaIbMH/QlBibUi1C5Lu9351VO3Vz
        ea9o8XRdF5PzESG46ZUngeYr2BmiKJOlhqtS26z98QU5QkVy/qtgmjm8XddLLCu8Hufpxw
        XeAZGa61n4BBvLyzijRIACCSFGVLg90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624269668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DK4VOq3/aR+8QJMmcLcj1iWRrIsrH84E5osKmEsvTsk=;
        b=10rQrSmZEGDFyFSQZPmNw4feTsDyuoNfMqoHtX+4nlweNZr2F6lUXvWF/UJ8sC9pToNSRG
        RjFQnbE5PA/v8ZBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id r9GjMGRj0GDNWwAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 21 Jun 2021 10:01:08 +0000
Date:   Mon, 21 Jun 2021 12:00:55 +0200
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
Subject: Re: [patch V3 12/66] x86/fpu: Reject invalid MXCSR values in
 copy_kernel_to_xstate()
Message-ID: <YNBjV5MNFV6wsEzr@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143445.769616874@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143445.769616874@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:35PM +0200, Thomas Gleixner wrote:
> Instead of masking out reserved bits, check them and reject the provided
> state as invalid if not zero.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: Validate MXCSR when FP|SSE|YMM are set. The quirk check is only
>     correct for the copy function.
> V2: New patch
> ---
>  arch/x86/kernel/fpu/xstate.c |   19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
