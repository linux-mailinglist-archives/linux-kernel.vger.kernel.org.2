Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914213AF65C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhFUTqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 15:46:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48058 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFUTqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 15:46:43 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF5AC2198C;
        Mon, 21 Jun 2021 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624304667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQClZieg0qeNhuMkHg13xw52Xckq8RJN25aLLhxO+8M=;
        b=ChJU6j/vr85ZCAgq1I2DgyQov2mjA/FWzPNLlz8r40SgrFV7JaJ0kW0rir/MQ47Yzai8Z5
        hG5w5d4DnmMc+qX6lChVkn8Z0hxPZrbjNKiqTupUglSFZ4mq6GBqgDzxsDKl6iF1hPJrCr
        Z5AQiCjg23U/qQtfYCR87iNN+Uet/Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624304667;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQClZieg0qeNhuMkHg13xw52Xckq8RJN25aLLhxO+8M=;
        b=wYhZOQLO8OpChDP7WxfY43iogxj7jIjd+cem5Ka+RGKrR8SHPNZTLDoW/Ui0g9F8yVJJUE
        CnHFkBpO/GkDIiAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D8084118DD;
        Mon, 21 Jun 2021 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624304667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQClZieg0qeNhuMkHg13xw52Xckq8RJN25aLLhxO+8M=;
        b=ChJU6j/vr85ZCAgq1I2DgyQov2mjA/FWzPNLlz8r40SgrFV7JaJ0kW0rir/MQ47Yzai8Z5
        hG5w5d4DnmMc+qX6lChVkn8Z0hxPZrbjNKiqTupUglSFZ4mq6GBqgDzxsDKl6iF1hPJrCr
        Z5AQiCjg23U/qQtfYCR87iNN+Uet/Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624304667;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQClZieg0qeNhuMkHg13xw52Xckq8RJN25aLLhxO+8M=;
        b=wYhZOQLO8OpChDP7WxfY43iogxj7jIjd+cem5Ka+RGKrR8SHPNZTLDoW/Ui0g9F8yVJJUE
        CnHFkBpO/GkDIiAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id lw7FMxvs0GBdAQAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 21 Jun 2021 19:44:27 +0000
Date:   Mon, 21 Jun 2021 21:44:22 +0200
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
Subject: Re: [patch V3 28/66] x86/fpu: Rename copy_user_to_xregs() and
 copy_xregs_to_user()
Message-ID: <YNDsFsdywrXyhT+H@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143447.575056756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143447.575056756@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:51PM +0200, Thomas Gleixner wrote:
> The function names for xsave[s]/xrstor[s] operations are horribly named and
> a permanent source of confusion.
> 
> Rename:
> 	copy_xregs_to_user() to xsave_to_user_sigframe()
> 	copy_user_to_xregs() to xrstor_from_user_sigframe()
> 
> so it's entirely clear what this is about. This is also a clear indicator
> of the potentially different storage format because this is user ABI and
> cannot use compacted format.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |    4 ++--
>  arch/x86/kernel/fpu/signal.c        |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
