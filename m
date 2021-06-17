Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1115D3AB324
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhFQMCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:02:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41916 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhFQMCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:02:09 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 965851FDCE;
        Thu, 17 Jun 2021 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623931201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHVrctRoTY/gEqharNKyVDHQJHZtEHuXRUMHJKQVWf8=;
        b=n2GJctvUXVf5Bd1JN3AyN4gvP18JeYvBEGNTRZ6i3faXPGjQKznOcozuUMF0KAg4ubYszn
        tSenYFeYujDf6g2R+4bWyzaKcH03zVleLGLjketefgc3wB0bfUrV/os/20VhvVqVMJ3wrZ
        LY/on7w8nuli1jTTPnXlAeH7nWE1K64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623931201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHVrctRoTY/gEqharNKyVDHQJHZtEHuXRUMHJKQVWf8=;
        b=WWLQSxRlGzOKYudDY9QEkeUupMgjiy7GSvuRkwPxHIqayvqc/3gyOK2XILsbkRAh746+Nq
        xZtOQADt2qMCdGCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 83541118DD;
        Thu, 17 Jun 2021 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623931201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHVrctRoTY/gEqharNKyVDHQJHZtEHuXRUMHJKQVWf8=;
        b=n2GJctvUXVf5Bd1JN3AyN4gvP18JeYvBEGNTRZ6i3faXPGjQKznOcozuUMF0KAg4ubYszn
        tSenYFeYujDf6g2R+4bWyzaKcH03zVleLGLjketefgc3wB0bfUrV/os/20VhvVqVMJ3wrZ
        LY/on7w8nuli1jTTPnXlAeH7nWE1K64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623931201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHVrctRoTY/gEqharNKyVDHQJHZtEHuXRUMHJKQVWf8=;
        b=WWLQSxRlGzOKYudDY9QEkeUupMgjiy7GSvuRkwPxHIqayvqc/3gyOK2XILsbkRAh746+Nq
        xZtOQADt2qMCdGCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id Y+L4HkE5y2DTFQAALh3uQQ
        (envelope-from <bp@suse.de>); Thu, 17 Jun 2021 12:00:01 +0000
Date:   Thu, 17 Jun 2021 13:59:56 +0200
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
Subject: Re: [patch V2 18/52] x86/fpu: Get rid of using_compacted_format()
Message-ID: <YMs5PGxFcmt46H47@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155355.548963297@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155355.548963297@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:26PM +0200, Thomas Gleixner wrote:
> @@ -590,9 +576,9 @@ static void do_extra_xstate_size_checks(
>  		check_xstate_against_struct(i);
>  		/*
>  		 * Supervisor state components can be managed only by
> -		 * XSAVES, which is compacted-format only.
> +		 * XSAVES.
>  		 */
> -		if (!using_compacted_format())
> +		if (!static_cpu_has(X86_FEATURE_XSAVES))
>  			XSTATE_WARN_ON(xfeature_is_supervisor(i));
>  
>  		/* Align from the end of the previous feature */
> @@ -602,9 +588,9 @@ static void do_extra_xstate_size_checks(
>  		 * The offset of a given state in the non-compacted
>  		 * format is given to us in a CPUID leaf.  We check
>  		 * them for being ordered (increasing offsets) in
> -		 * setup_xstate_features().
> +		 * setup_xstate_features(). XSAVES uses compacted format.
>  		 */
> -		if (!using_compacted_format())
> +		if (!static_cpu_has(X86_FEATURE_XSAVES))

both: cpu_feature_enabled()

and yes, I have complained about that one in the past so good riddance.

Reviewed-by: Borislav Petkov <bp@suse.de>

Btw, that patch looks like it could be moved to the beginning of the
patchset, right after the urgent fixes as it is an independent cleanup.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
