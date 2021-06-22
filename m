Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5F03B0046
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhFVJdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:33:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37924 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVJdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:33:45 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F9CB1FD5D;
        Tue, 22 Jun 2021 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624354289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9Bbmz47N10UG8giHvgOwdYprrSOjH5wrgszJlkF4zE=;
        b=blZz11mG7cAAkIkROne1d9pYKpLiOw+VxblhAA8HcgbZ3NhfqZ9iuQmJ7r6cW3c7SlxBu5
        TbYpVVUQDYDxr1mhw4ppC0TZISSsGXu+/BACrN2wuNqjdBQ8uw/CKqLj9zaRh2X+poyE9D
        6vHFDjxXEPJ6QeMF67G7sL5kESxkdlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624354289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9Bbmz47N10UG8giHvgOwdYprrSOjH5wrgszJlkF4zE=;
        b=6eD/VlGbCndHXirXcbGgF56xQw1r3dAJEg57OF2A8icvK7mRurShEVZ2kUB+ceh4AmsJGp
        YqpWa/eoedbuHqBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 60225118DD;
        Tue, 22 Jun 2021 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624354289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9Bbmz47N10UG8giHvgOwdYprrSOjH5wrgszJlkF4zE=;
        b=blZz11mG7cAAkIkROne1d9pYKpLiOw+VxblhAA8HcgbZ3NhfqZ9iuQmJ7r6cW3c7SlxBu5
        TbYpVVUQDYDxr1mhw4ppC0TZISSsGXu+/BACrN2wuNqjdBQ8uw/CKqLj9zaRh2X+poyE9D
        6vHFDjxXEPJ6QeMF67G7sL5kESxkdlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624354289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9Bbmz47N10UG8giHvgOwdYprrSOjH5wrgszJlkF4zE=;
        b=6eD/VlGbCndHXirXcbGgF56xQw1r3dAJEg57OF2A8icvK7mRurShEVZ2kUB+ceh4AmsJGp
        YqpWa/eoedbuHqBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id PSr1FvGt0WDGLQAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 09:31:29 +0000
Date:   Tue, 22 Jun 2021 11:31:17 +0200
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
Subject: Re: [patch V3 30/66] x86/fpu: Rename fregs related copy functions
Message-ID: <YNGt5ZKCjlWTA9r7@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143447.780873283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143447.780873283@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:53PM +0200, Thomas Gleixner wrote:
> The function names for fnsave/fnrstor operations are horribly named and
> a permanent source of confusion.
> 
> Rename:
> 	copy_fregs_to_kernel() to fnsave()

That first one is not existant.

> 	copy_kernel_to_fregs() to fnrstor()

				frstor() - no "n"

> 	copy_fregs_to_user()   to fnsave_to_user_sigframe()
> 	copy_user_to_fregs()   to fnrstor_from_user_sigframe()
> 
> so it's clear what these are doing. All these functions are really low
> level wrappers around the equaly named instructions, so mapping to the
> documentation is just natural.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: Rename (Boris)
> ---
>  arch/x86/include/asm/fpu/internal.h |   10 +++++-----
>  arch/x86/kernel/fpu/core.c          |    2 +-
>  arch/x86/kernel/fpu/signal.c        |    6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)

Regardless, above is just nitpicks.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
