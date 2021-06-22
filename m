Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B7C3B0120
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFVKSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:18:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41618 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhFVKSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:18:43 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A6C71FD36;
        Tue, 22 Jun 2021 10:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624356987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcJKssQawx82pik+5SEiH9OLdBNbYw3x7ZlIe2Tcr7o=;
        b=L/JP/LB3GfHBJtG1aypthoOJnN2WTkZXEWUsk8o5kfkBomcdJjSdGRPam0XdadXBHhlsso
        PYidKaZoZ7euK4AWdhN6d29cFN6zfC91uCKRWpd9Yd4UqKDLQvf2Dq8JOYoX4iMqbhTEl+
        ZBlEDzsycdRd9izq9mcWbxzJJaQGNOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624356987;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcJKssQawx82pik+5SEiH9OLdBNbYw3x7ZlIe2Tcr7o=;
        b=jJKZX+nkPqWN+mHxT0BJ+JtnFzm1a732Xand24KFfW0FlrZzFBwcmbb0QyvwyyQs1lcRiB
        +Y4kJNBfiTlrv3Dw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 477DD118DD;
        Tue, 22 Jun 2021 10:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624356987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcJKssQawx82pik+5SEiH9OLdBNbYw3x7ZlIe2Tcr7o=;
        b=L/JP/LB3GfHBJtG1aypthoOJnN2WTkZXEWUsk8o5kfkBomcdJjSdGRPam0XdadXBHhlsso
        PYidKaZoZ7euK4AWdhN6d29cFN6zfC91uCKRWpd9Yd4UqKDLQvf2Dq8JOYoX4iMqbhTEl+
        ZBlEDzsycdRd9izq9mcWbxzJJaQGNOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624356987;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcJKssQawx82pik+5SEiH9OLdBNbYw3x7ZlIe2Tcr7o=;
        b=jJKZX+nkPqWN+mHxT0BJ+JtnFzm1a732Xand24KFfW0FlrZzFBwcmbb0QyvwyyQs1lcRiB
        +Y4kJNBfiTlrv3Dw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id TxoOEHu40WCzRQAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 10:16:27 +0000
Date:   Tue, 22 Jun 2021 12:16:20 +0200
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
Subject: Re: [patch V3 33/66] x86/fpu: Rename copy_fpregs_to_fpstate() to
 save_fpregs_to_fpstate()
Message-ID: <YNG4dGnYGMJOTSFO@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143448.139321010@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143448.139321010@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:56PM +0200, Thomas Gleixner wrote:
> A copy is guaranteed to leave the source intact, which is not the case when
> FNSAVE is used as that reinitilizes the registers.
> 
> Save does not make such guarantees and it matches what this is about,
> i.e. to save the state for a later restore.
> 
> Rename it to save_fpregs_to_fpstate(). 
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |    4 ++--
>  arch/x86/kernel/fpu/core.c          |   10 +++++-----
>  arch/x86/kvm/x86.c                  |    2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
