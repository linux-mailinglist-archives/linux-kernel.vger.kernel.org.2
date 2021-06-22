Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81E3B0B41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhFVRRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:17:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58358 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFVRRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:17:41 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 598601FD5D;
        Tue, 22 Jun 2021 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624382124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7soX5VsR7GZwKCisYu8YA474265qwWjvCsD4pqfRp8=;
        b=pRHNtJEtZGbzBkIfxMrUUUcxTQK4Mp3+emmRNzIPSHcqVopUK5PFERk4kOYANHQ4izKOtJ
        X9vddKxx3kxfBST6cK33H8Lw6wCntVfXhA0XcDYVRekBVzykYoLH3Z2rNLSoCkHVSd9Q3a
        FRDYpsh6zPYOj2f6VAH9bYc+2Nq4kj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624382124;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7soX5VsR7GZwKCisYu8YA474265qwWjvCsD4pqfRp8=;
        b=aoFL7+FTu59NBIP1Fr6AbLUKXaFChnIzXR7mR4sOANmmWtUhKQFomC6CBhQNvrJkcOsChC
        VFK5zCpeGRSKhhCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4659E11A97;
        Tue, 22 Jun 2021 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624382124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7soX5VsR7GZwKCisYu8YA474265qwWjvCsD4pqfRp8=;
        b=pRHNtJEtZGbzBkIfxMrUUUcxTQK4Mp3+emmRNzIPSHcqVopUK5PFERk4kOYANHQ4izKOtJ
        X9vddKxx3kxfBST6cK33H8Lw6wCntVfXhA0XcDYVRekBVzykYoLH3Z2rNLSoCkHVSd9Q3a
        FRDYpsh6zPYOj2f6VAH9bYc+2Nq4kj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624382124;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7soX5VsR7GZwKCisYu8YA474265qwWjvCsD4pqfRp8=;
        b=aoFL7+FTu59NBIP1Fr6AbLUKXaFChnIzXR7mR4sOANmmWtUhKQFomC6CBhQNvrJkcOsChC
        VFK5zCpeGRSKhhCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id TYMWEKwa0mBYQgAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 17:15:24 +0000
Date:   Tue, 22 Jun 2021 19:15:23 +0200
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
Subject: Re: [patch V3 57/66] x86/pkru: Remove xstate fiddling from
 write_pkru()
Message-ID: <YNIaq1VDpeV33BEo@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143450.852876561@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143450.852876561@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:20PM +0200, Thomas Gleixner wrote:
> The PKRU value of a task is stored in task->thread.pkru when the task is
> scheduled out. PKRU is restored on schedule in from there. So keeping the
> XSAVE buffer up to date is a pointless exercise.
> 
> Remove the xstate fiddling and cleanup all related functions.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/pkru.h          |   17 ++++-------------
>  arch/x86/include/asm/special_insns.h |   14 +-------------
>  arch/x86/kvm/x86.c                   |    4 ++--
>  3 files changed, 7 insertions(+), 28 deletions(-)

Yap, untangling PKRU from XSAVE makes the related code a lot nicer, I
gotta say.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
