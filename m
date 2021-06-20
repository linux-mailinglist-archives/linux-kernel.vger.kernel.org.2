Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90073ADDD7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhFTJFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 05:05:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38740 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFTJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 05:05:17 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93E151FD29;
        Sun, 20 Jun 2021 09:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624179784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpEtzCzJeCraFJ1wkgqGq/lke5Znq95uV8gUu3LE09w=;
        b=fDInKSljvaN/2HVX7AWpRjne0as5yphhkVaDdndh9RinqOxkAPfYi6Hsiwr0iZwChksC4h
        /BB/KICe/EFDRmxQ7c3rUckMO0+orb+izEeukUhZCUZix0HjuPoSdvBJbg+B2jTOuaq5h6
        fpkgYI+h0f21mCpGXICwOK4OB0EzP1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624179784;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpEtzCzJeCraFJ1wkgqGq/lke5Znq95uV8gUu3LE09w=;
        b=o0I1yfgB8eCtf7YNh2Yalm/fqF/Cm5GONrEjCn1KP1d2PZ1D51o1EKzwmiqY3B7q77NYra
        fKilg1wFga5K/QBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7B354118DD;
        Sun, 20 Jun 2021 09:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624179784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpEtzCzJeCraFJ1wkgqGq/lke5Znq95uV8gUu3LE09w=;
        b=fDInKSljvaN/2HVX7AWpRjne0as5yphhkVaDdndh9RinqOxkAPfYi6Hsiwr0iZwChksC4h
        /BB/KICe/EFDRmxQ7c3rUckMO0+orb+izEeukUhZCUZix0HjuPoSdvBJbg+B2jTOuaq5h6
        fpkgYI+h0f21mCpGXICwOK4OB0EzP1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624179784;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpEtzCzJeCraFJ1wkgqGq/lke5Znq95uV8gUu3LE09w=;
        b=o0I1yfgB8eCtf7YNh2Yalm/fqF/Cm5GONrEjCn1KP1d2PZ1D51o1EKzwmiqY3B7q77NYra
        fKilg1wFga5K/QBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id D7GoHUgEz2CpcgAALh3uQQ
        (envelope-from <bp@suse.de>); Sun, 20 Jun 2021 09:03:04 +0000
Date:   Sun, 20 Jun 2021 11:02:54 +0200
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
Subject: Re: [patch V3 07/66] x86/fpu: Get rid of
 fpu__get_supported_xfeatures_mask()
Message-ID: <YM8EPoLgGidlCKOc@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143445.206372999@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143445.206372999@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:30PM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1715,9 +1715,8 @@ void print_cpu_info(struct cpuinfo_x86 *
>  }
>  
>  /*
> - * clearcpuid= was already parsed in fpu__init_parse_early_param.
> - * But we need to keep a dummy __setup around otherwise it would
> - * show up as an environment variable for init.
> + * clearcpuid= was already parsed in cpu_parse_early_param().  This dummy
> + * function prevents it to become an environment variable for init.

... prevents it from becoming...

In any case:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
